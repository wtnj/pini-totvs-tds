#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*   alterado em 20030917 por danilo
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PFat160A  �Autor  �Danilo C S Pala     � Data �  20030917   ���
�������������������������������������������������������������������������͹��
���Desc.     � Programa para otimizacao do Pfat106C, com query 			  ���
���          �  (Clientes Cont/Arq)										  ���
�������������������������������������������������������������������������͹��
���Uso       � AP5                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function Pfat160A
SetPrvt("cQuery, _aCampos, aArq, _cnome, aQuery")
SetPrvt("cQuerySZJ, _aCamposSZJ")
SetPrvt("contdel, contproc")
SetPrvt("mEnd, mBairro, mMun, mCEP, mEst, mFone, mFone1")
SetPrvt("mCodDest, mCodCli, mDTPG, mPGTO, mAberto")
SetPrvt("mTpprod, _aCamposF, _cNomeF")
SetPrvt("mPRODUTO, mPEDIDO ,  mTES, mCF, mF4_TEXTO") 
SetPrvt("mDTPG, mDTPG2 , mPago, mParc")
SetPrvt("_cNomeF, _aCamposF, cIndex, cKey, mContAss")

Private _cTitulo  := "WebOP"
Private ctexto := "Limpar"
Private cTexto1 := "Processar"
Private cTexto2 := "Fechar"
setprvt("_aCampos, _cNome, caIndex, caChave, caFiltro, cQuery, contPed, _cMsgINFO, ContSzk")
Private Memp := SM0->M0_CODIGO

@ 010,001 TO 210,400 DIALOG oDlg TITLE _cTitulo
@ 010,010 SAY "**********TESTE**********"
@ 020,010 BUTTON cTexto SIZE 40,11 ACTION   Processa({||Limpar()})
@ 020,060 BUTTON cTexto1 SIZE 40,11 ACTION   Processa({||Processar()})
@ 080,120 BUTTON cTexto2 SIZE 40,15 Action ( Close(oDlg) )
Activate Dialog oDlg CENTERED

return








Static Function Limpar()
contDel := 0
ContProc := 0
dbUseArea(.T.,,"\SIGA\EXPORTA\WEBOP.DBF","WEBOP",.F.,.F.)
DBSELECTAREA("WEBOP")                  
DbGotop()
While !eof("WEBOP")
	if Alltrim(WEBOP->z9_del) = "*" 
		Reclock("WEBOP",.F.)
		DBDelete()          
		MSUNLOCK("WEBOP")		
		contDel++
	elseif WEBOP->f4_del = "*"
		Reclock("WEBOP",.F.)
		DBDelete()          
		MSUNLOCK("WEBOP")		
		contDel++
	elseif WEBOP->c5_del = "*"
		Reclock("WEBOP",.F.)
		DBDelete()          
		MSUNLOCK("WEBOP")		
		contDel++
	elseif WEBOP->c6_del = "*"
		Reclock("WEBOP",.F.)
		DBDelete()          
		MSUNLOCK("WEBOP")		
		contDel++
	elseif WEBOP->a1_del = "*"
		Reclock("WEBOP",.F.)
		DBDelete()          
		MSUNLOCK("WEBOP")		
		contDel++
	elseif WEBOP->f4_del = "*"
		Reclock("WEBOP",.F.)
		DBDelete()          
		MSUNLOCK("WEBOP")		
		contDel++
	end if
	DBSkip()                        
	Contproc++
end         
DBCloseArea("WEBOP")
MsgAlert("WebOP: processados: "+ Alltrim(str(contproc)) +", deletados: "+ Alltrim(str(contdel)))
return                                                                 

                    



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PFAT160A  �Autor  �Danilo C S Pala     � Data �  20030917   ���
�������������������������������������������������������������������������͹��
���Desc.     � Faz as consistencias                                       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function Processar()            
//TESTE
MvPar07 := 3 //TIPO
MvPar08 := 3 //SITUACAO
MvPar09 := 99999 //QTD
MvPar11 := 2 //DUPLI
MvPar19 := 1 //REPRESENT
//TESTE

//farqtrab
_aCamposF:={}
AADD(_aCamposF,{"NUMPED","C",6,0})
AADD(_aCamposF,{"ZZ6_SEQASS","C",2,0})
AADD(_aCamposF,{"ZZ6_COD","C",6,0})
AADD(_aCamposF,{"ZZ6_NOME","C",40,0})
AADD(_aCamposF,{"ZZ6_CONTAT","C",40,0})
AADD(_aCamposF,{"ZZ6_END","C",40,0})
AADD(_aCamposF,{"ZZ6_BAIRRO","C",20,0})
AADD(_aCamposF,{"ZZ6_MUN","C",20,0})
AADD(_aCamposF,{"ZZ6_ESTADO","C",2,0})
AADD(_aCamposF,{"ZZ6_CEP","C",8,0})
AADD(_aCamposF,{"ZZ6_CGC","C",14,0})  
AADD(_aCamposF,{"ZZ6_INSCR","C",14,0})   
AADD(_aCamposF,{"ZZ6_INSCRM","C",14,0})
AADD(_aCamposF,{"ZZ6_TEL","C",20,0})
AADD(_aCamposF,{"ZZ6_FAX","C",20,0})
AADD(_aCamposF,{"ZZ6_EMAIL","C",20,0})
AADD(_aCamposF,{"ZZ6_EDINIC","N",4,0})
AADD(_aCamposF,{"ZZ6_EDVENC","N",4,0})
AADD(_aCamposF,{"ZZ6_EDSUSP","N",4,0})
AADD(_aCamposF,{"ZZ6_EDFIN","N",4,0})
AADD(_aCamposF,{"ZZ6_PRODUT","C",2,0}) 
AADD(_aCamposF,{"ZZ6_CODVEN","C",6,0}) 
AADD(_aCamposF,{"ZZ6_TPCLI","C",1,0})
AADD(_aCamposF,{"CODASS","C",12,0}) 
AADD(_aCamposF,{"RESPCOB","C",40,0})
AADD(_aCamposF,{"CF","C",5,0})
AADD(_aCamposF,{"CODPROD","C",15,0})
AADD(_aCamposF,{"DESCR","C",40,0})
AADD(_aCamposF,{"DTPGTO","D",8,0})
AADD(_aCamposF,{"DTFAT","D",8,0})
AADD(_aCamposF,{"QTDE","N",12,2})
AADD(_aCamposF,{"ZZ6_VALOR","N",12,2})
AADD(_aCamposF,{"PGTO","N",5,2})
AADD(_aCamposF,{"EMABERTO","N",5,0})
AADD(_aCamposF,{"CODDEST","C",6,0})
AADD(_aCamposF,{"TIPOOP","C",2,0})
AADD(_aCamposF,{"DESCROP","C",50,0})
AADD(_aCamposF,{"PRICOM","D",8,0})
AADD(_aCamposF,{"ULTCOM","D",8,0})
AADD(_aCamposF,{"TPPROD","C",30,0}) 

_cNomeF := CriaTrab(_aCamposF,.t.)
cIndex := CriaTrab(Nil,.F.)
//cKey   := "ZZ6_Cod+CodDEst"
dbUseArea(.T.,, _cNomeF,"ASSOP",.F.,.F.)
dbSelectArea("ASSOP")
//Indregua("ASSOP",cIndex,ckey,,,"Selecionando Registros do Arq")

Conta1 := 0    
ContCons := 0                                   
mContAss := 0
dbUseArea(.T.,,"\SIGA\EXPORTA\WEBOP.DBF","WEBOP",.F.,.F.)
DBSELECTAREA("WEBOP")                  
DbGotop()
While !eof("WEBOP") .and. (Conta1 < MvPar09)
	mTpprod   := ""
	mPRODUTO  := WEBOP->C6_PRODUTO
	mPEDIDO   := WEBOP->C6_NUM
	mCODCLI   := WEBOP->C6_CLI
	mCODDEST  :=WEBOP->C6_CODDEST
	mTES 	  := WEBOP->C6_TES
	mCF 	  := WEBOP->C6_CF
	mF4_TEXTO := WEBOP->F4_TEXTO  
	mDTPG     := ctod("  /  /  ")
	mDTPG2   := ctod("  /  /  ")
	mPgto	  := 0
	mAberto	  := 0    
	mPago    := 0
	mParc    := 0    
	
	Do Case
	  Case subs(mPRODUTO,1,2) == '02'
		mTpprod:='LIVROS'
	  Case subs(mPRODUTO,1,2) == '07'
		mTpprod:='CD'
	  Case subs(mPRODUTO,1,2) == '01'.And. subs(mPRODUTO,5,3) == '002'
		mTpprod:='NOVA ANUAL'
	  Case subs(mPRODUTO,1,2) == '01'.And. subs(mPRODUTO,5,3) == '003'
		mTpprod:='NOVA BIENAL'
	  Case subs(mPRODUTO,1,2) == '01'.And. subs(mPRODUTO,5,3) == '004'
		mTpprod:='RENOVADA ANUAL'
	  Case subs(mPRODUTO,1,2) == '01'.And. subs(mPRODUTO,5,3) == '005'
		mTpprod:='RENOVADA BIENAL'
	  OtherWise
		mTpprod:='OUTROS'
	EndCase

	//��������������������������������������������������������������Ŀ
	//� Verifica o registro faz parte do cad de representante        �
	//����������������������������������������������������������������
	IF MVPAR19 = 2
		DbSelectArea("SZL")
		DbGoTop()
		DbSeek(xFilial("SZL")+MCODCLI)
		If Found()
			Reclock("WEBOP",.F.)
			DBDelete()          
			MSUNLOCK("WEBOP")		
			contCons++    
			DBSelectarea("WEBOP")	
			DBSkip()                        
			Loop
		Endif   
		DBCloseArea("SZL")
	ENDIF
	
	//��������������������������������������������������������������Ŀ
	//� Elimina duplicidade por codigo de cliente e destinat�rio     �
	//����������������������������������������������������������������
/*	If MVPAR11 = 1
		DbSelectArea("WEBOP")
		DbSeek(mCodCli+mCodDest)
		If Found()
			Reclock("WEBOP",.F.)
			DBDelete()          
			MSUNLOCK("WEBOP")		
			contCons++
		Endif
	Endif         
*/	
	//��������������������������������������������������������������Ŀ
	//� Verifica se � pago 1/cortesia 2/ambas 3	                     �
	//����������������������������������������������������������������
	If MVPAR07 = 1 .OR. MVPAR07 = 2
		IF 'CORTESIA' $(mF4_TEXTO).OR.'DOACAO' $(mF4_TEXTO) .and. (MVPAR07 == 1)
			Reclock("WEBOP",.F.)
			DBDelete()          
			MSUNLOCK("WEBOP")		
			contCons++
			DBSelectarea("WEBOP")	
			DBSkip()                        
			Loop
		else //pagas e mvpar07=2
			Reclock("WEBOP",.F.)
			DBDelete()          
			MSUNLOCK("WEBOP")		
			contCons++
			DBSelectarea("WEBOP")	
			DBSkip()                        
			Loop
		Endif
	Endif
	
	
	//��������������������������������������������������������������Ŀ
	//�calculando as baixas						                     �
	//����������������������������������������������������������������
 	 DbSelectArea("SE1")
	 DbGoTop()
	 DbSeek(xFilial("SE1")+mPedido)
	 If Found()
		mDTPG := SE1->E1_BAIXA
		While ( SE1->E1_PEDIDO == MPEDIDO ) .And. !Eof()
			mParc := mParc+1
			mDTPG2:= SE1->E1_BAIXA
			If DTOC(MDTPG2) <> "  /  /  " .And. SE1->E1_SALDO == 0;
				.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,2) <> 'LP';
				.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,4) <> 'CANC'
				mPago:=mPago+1
			Else
				If SE1->E1_VENCTO+30 < DATE()
					mAberto := mAberto+1
				Endif
			Endif
			DbSkip()
		End
		mPGTO := mPAGO/mPARC
	 Else
		mAberto := 99999
	 Endif              
	 DBCloseArea("SE1")
		
	 If SUBS(mCF,2,2) == "99"
		mAberto := 0
	 Endif
		            
	 // BAIXADOS 1/ ABERTOS 2/ ambos 3
	 If MVPAR08 = 1    
		If mAberto <> 0
			Reclock("WEBOP",.F.)
			DBDelete()          
			MSUNLOCK("WEBOP")		
			contCons++
			DBSelectarea("WEBOP")	
			DBSkip()                        
			Loop
		Endif
	 Elseif MVPAR08 = 2            
		If mAberto = 0
			Reclock("WEBOP",.F.)
			DBDelete()          
			MSUNLOCK("WEBOP")		
			contCons++
			DBSelectarea("WEBOP")	
			DBSkip()                        
			Loop
		Endif       
	 Endif
    //ATEH AKI SE1
    
	GRAVA()		        
	DBSelectarea("WEBOP")	
	DBSkip()                        
	Conta1++
end                 

DBCloseArea("WEBOP")                                                               
DbSelectArea("ASSOP")
copy to &("\SIGA\EXPORTA\ASSOP.DBF")
DBClosearea("ASSOP")                                                               

MsgAlert("WebOP: "+ Alltrim(Str(Conta1))+" e deletados: "+ Alltrim(Str(ContCons))+Chr(13)+"Gerado: \SIGA\EXPORTA\ASSOP.DBF")



return         

               


//���������������������������������������������������������������������������Ŀ
//� Function  � GRAVA()                                                       �
//���������������������������������������������������������������������������Ĵ
//� Descricao � Realiza gravacao dos registros ideais (conforme parametros)   �
//�           � para gera��o do arquivo.                                      �
//���������������������������������������������������������������������������Ĵ
//� Observ.   �                                                               �
//�����������������������������������������������������������������������������
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function GRAVA
Static Function GRAVA()   
//PASSANDO OS VALORES DO SA1
mEnd    := WEBOP->A1_END
mBairro := WEBOP->A1_BAIRRO
mMun    := WEBOP->A1_MUN
mEst    := WEBOP->A1_EST
mCEP    := WEBOP->A1_CEP
mFone  := WEBOP->A1_Tel
mDest 	:= ""
mFone1 := ""

If mCodDest#" "                   
	DbSelectArea("SZN")
	DbSeek(xFilial("SZN")+mCodCli+mCodDest)
	If Found()
		mDest:= SZN->ZN_NOME
	Endif

	DbSelectArea("SZO")
	DbSeek(xFilial("SZO")+mCodCli+mCodDest)
	If Found()
		mEnd    := SZO->ZO_END
		mBairro := SZO->ZO_BAIRRO
		mMun    := SZO->ZO_CIDADE
		mEst    := SZO->ZO_ESTADO
		mCEP    := SZO->ZO_CEP
		mFone1  := SZO->ZO_FONE
		If mFone1 <> "  "
			mFone:= mFone1
		Endif
	Endif
Endif

//gravacao final!!!
mContAss++
DbSelectArea("ASSOP")
RecLock("ASSOP",.T.)
replace NumPed   With  WEBOP->C6_NUM
replace codass   With  WEBOP->C6_NUM+substr(WEBOP->C6_PRODUTO,3,2)+WEBOP->C6_ITEM
replace zz6_Cod  With  WEBOP->C6_CLI
replace zz6_Produto  With substr(WEBOP->C6_PRODUTO,3,2)  
replace zz6_End      With  mEnd
replace zz6_Bairro   With  mBairro
replace zz6_Mun      With  mMun
replace zz6_CEP      With  mCEP
replace zz6_Estado   With  mEst
replace zz6_tel      With  mFone
replace zz6_Fax      With  WEBOP->A1_FAX
replace zz6_EMAIL    With  WEBOP->A1_EMAIL
replace zz6_CGC      With  WEBOP->A1_CGC  
replace zz6_inscr    With  WEBOP->A1_Inscr
replace zz6_inscrm   With  WEBOP->A1_inscrm  
replace zz6_Valor    With  WEBOP->c6_Valor
replace zz6_Nome     With  WEBOP->A1_NOME
replace zz6_contat With  mDest //var  
replace zz6_CodVend  With  WEBOP->C5_VEND1
replace zz6_Edinic   With  WEBOP->C6_EDINIC
replace zz6_EdVenc   With  WEBOP->C6_EdVenc
replace zz6_Edsusp   With  WEBOP->C6_Edsusp
replace zz6_Edfin    With  WEBOP->C6_Edfin
replace zz6_TpCli    With  WEBOP->A1_TpCli
replace zz6_Seqass With  WEBOP->C6_ITEM
replace CodDest  With  WEBOP->C6_CodDest
replace CodProd  With  WEBOP->C6_ProdUTO
replace CF       With  WEBOP->C6_CF
replace Qtde     With  WEBOP->C6_QtdVEN
replace Respcob  With  WEBOP->C5_Respcob
replace DTPGTO   With  mDTPG //VAR
replace DTFAT    With  (WEBOP->C6_DATFAT)
replace PGTO     With  mPGTO //VAR
replace EmAberto With  mAberto //VAR
replace Descr    With  WEBOP->C6_DESCRI
replace Tipoop   With  WEBOP->C5_Tipoop
replace Tpprod   With  mTpprod //VAR
replace Descrop  With  WEBOP->Z9_DESCR
replace Pricom   With  (WEBOP->A1_Pricom)
replace Ultcom   With  (WEBOP->A1_Ultcom)
MsUnlock()
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PFAT160   �Autor  �Danilo C S Pala     � Data �  09/15/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Fun�ao para criar o arquivo de trabalho                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Advanced Protheus                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function FARQTRAB()
Return



//���������������
//�converterData�
//���������������
static Function ConverterData(data_old)             //12345678
setprvt("data_new")                      //20030814
data_new := substr(data_old,7,2)+"/"+substr(data_old,5,2)+"/"+substr(data_old,3,2)
return data_new