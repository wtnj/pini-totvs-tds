#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M41LIOK   � Autor � Douglas Silva      � Data �  09/04/2014 ���
�������������������������������������������������������������������������͹��
���Descricao � Este programa tem como n�o deixar duplicar itens no pedido ���
���          � de venda                                                   ���
�������������������������������������������������������������������������͹��
���Uso       � Especifico Editora Pini                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function M410LIOK()       

Private cAliaAnte, nAreaAnte,nRegiAnte, nTES, _TES, nTIPBON, _TIPBON, cTexto, nNotaOrig, _NotaOrig, nSerieOrig, _SerieOrig, nPosTes
Private nCodPro, _CodPro, nItemOri, _ItemOri
Private nPosProduto, nPosPerDesc, nPosPrUnit, nPosPrcVen, nPosBlDesc, nPosPrUnit2, nTipoBonif
Private nRetorno := .T.  
Private nSaldo := 0

//N�o entra no ponto de entrada caso seja Faturamento Notas Serie 21

cAliaAnte := Alias()                                   
nAreaAnte := IndexOrd()
nRegiAnte := RecNo()
                                                                                 
nPosItem		:= aScan(aHeader,{|COLUNA| AllTrim(Upper(COLUNA[2]))	==	"C6_ITEM" 		})
nPosProduto 	:= aScan(aHeader,{|COLUNA| AllTrim(Upper(COLUNA[2]))	==	"C6_PRODUTO" 	})
nPosPerDesc 	:= aScan(aHeader,{|COLUNA| AllTrim(Upper(COLUNA[2]))	==	"C6_PERDESC" 	})
nPosPrUnit 	:= aScan(aHeader,{|COLUNA| AllTrim(Upper(COLUNA[2]))	==	"C6_PRUNIT" 	})
nPosQuant 		:= aScan(aHeader,{|COLUNA| AllTrim(Upper(COLUNA[2]))	==	"C6_QTDVEN"	})
nPosPrcVen 	:= aScan(aHeader,{|COLUNA| AllTrim(Upper(COLUNA[2]))	==	"C6_PRCVEN" 	})
nPosBlDesc 	:= aScan(aHeader,{|COLUNA| AllTrim(Upper(COLUNA[2]))	==	"C6_BLDESC" 	})
nPosPrUnit2 	:= aScan(aHeader,{|COLUNA| AllTrim(Upper(COLUNA[2]))	==	"C6_PRUNIT2" 	})
nTipoBonif 	:= aScan(aHeader,{|COLUNA| AllTrim(Upper(COLUNA[2]))	==	"C6_TIPOBON" 	})
nTipoLocal 	:= aScan(aHeader,{|COLUNA| AllTrim(Upper(COLUNA[2]))	==	"C6_LOCAL" 	})
nPosTes	 	:= aScan(aHeader,{|COLUNA| AllTrim(Upper(COLUNA[2]))	==	"C6_TES"	 	})

If ACOLS[N,LEN(ACOLS[N])] // Entra se a linha estiver apagada

     nRetorno := .T.
     dbSelectArea(cAliaAnte)
     dbSetOrder(nAreaAnte)
     dbGoTo(nRegiAnte)
     Return(nRetorno)   
     
EndIf

cCodigoP := aCols[n,nPosProduto]
nSaldo := U_CONSSLDO(cCodigoP,aCols[n,nTipoLocal], aCols[n,nPosTes] )             

SB1->(DBSELECTAREA("SB1"))
SB1->(DBSETORDER(1))
SB1->(DBSEEK(xFilial("SB1") + ALLTRIM(aCols[n,nPosProduto]) ))
/*
If ALLTRIM(M->C5_TIPOOP) $ "500|30"
	Return(.T.)
EndIf
*/
If ( ! ALLTRIM(M->C5_LOTEFAT) $ "500|30" .and.   ! SB1->B1_GRUPO $ "0100|0300|4000|3610|0804" )
	//Valida��o para n�o deixar item duplicado.
	
	For  nX := 1 To len(aCols)
		If ! ACOLS[N,LEN(ACOLS[N])] .And. aCols[n,nTipoLocal] == "T5" .or. aCols[n,nTipoLocal] == "T6"
			If nX != n .And. cCodigoP == aCols[nX,nPosProduto] .And. ! ACOLS[nX,LEN(ACOLS[nX])]  
				Alert("ATEN��O: N�o � possivel digitar dois itens com o mesmo c�digo, favor somar com o item: " +  aCols[nX,nPosItem] ,"M410LIOK") 
				nRetorno := .F.         
	        Endif
	    Endif           
	Next nX
           
	//Valida quantidade em Estoque
	If ! ACOLS[N,LEN(ACOLS[N])] .And. aCols[n,nTipoLocal] == "T5" .or. aCols[n,nTipoLocal] == "T6"
		If  nSaldo < aCols[n,nPosQuant] .And. (! ACOLS[n,LEN(ACOLS[n])])  
			Alert("ATEN��O: Produto: " + ALLTRIM(cCodigoP) + " N�o contem saldo suficiente para atender este pedido: " + cValToChar(nSaldo) ,"M410LIOK") 
			nRetorno := .F.         
        Endif
    Endif           
EndIf
dbSelectArea(cAliaAnte)
dbSetOrder(nAreaAnte)
dbGoTo(nRegiAnte)  

Return(nRetorno)                              

User Function CONSSLDO(_cCodigo,_cLocal, _cTes) 

Private nSaldo := 0

cQuery := " SELECT (B2_QATU - B2_RESERVA) AS B2_QATU FROM "+RETSQLNAME("SB2")+" SB2  " 
cQuery += " WHERE SB2.D_E_L_E_T_ != '*' AND SB2.B2_LOCAL = '"+_cLocal+"' AND SB2.B2_COD = '"+_cCodigo+"' "

dbUseArea(.T., "TOPCONN", TCGenQry(, , cQuery), "TRB", .F., .T.)


cQuery := " SELECT F4_ESTOQUE FROM "+RETSQLNAME("SF4")+" SF4 WHERE D_E_L_E_T_ != '*' AND F4_FILIAL = '01' AND F4_CODIGO = '"+_cTes+"' "

dbUseArea(.T., "TOPCONN", TCGenQry(, , cQuery), "TRD", .F., .T.)


	If TRD->F4_ESTOQUE == "S"
		nSaldo := TRB->B2_QATU
	Else
		nSaldo := 999999
	EndIf 

TRB->(DBCLOSEAREA("TRB"))
TRD->(DBCLOSEAREA("TRD"))

Return(nSaldo)