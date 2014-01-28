#include "rwmake.ch"

User Function Pfat004()

/*/ ALTERADO POR DANILO C S PALA EM 20050811
//Danilo C S Pala 20070620: validar o saldo em estoque, caso negativo nao liberar
Danilo C S Pala 20070722: somente na Editora Pini     
Danilo C S Pala 20070703: estornar itens liberados
Danilo C S Pala 20070829: se o c5_data1 < ddatabase entao c5_data1 = ddatabase  
Danilo C S Pala 20080416: NAO VALIDAR ESTOQUE DOS TES 509 E 510  
Danilo C S Pala 20080820: nao validar tes que nao controla estoque
Danilo C S Pala 20130228: daqui Liberar produtos da PSE (Cicero)
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT004   ³Autor: Solange Nalini         ³ Data:   30/04/98 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Libera‡ao de Pedidos de Venda por lote                     ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³ CONVERTIDO P/  WINDOWS por Gilberto A. de Oliveira em  02/08/2000    ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,MEMPRESA")
SetPrvt("TREGS,M_MULT,P_ANT,P_ATU,P_CNT,M_SAV20")
SetPrvt("M_SAV7,MPEDIDO,MLOTEFAT,MDATA,MFILIAL,MITEM")
SetPrvt("MPRODUTO,MQTDVEN,MPRCVEN,MCLI,MLOJA,MNUM")
SetPrvt("MGRUPO,SLDALMOX, BLIBPED, MSALDO, APEDIDOS, NLOOP, CESTOQUE")

cPerg:="FAT001"
mEmpresa:=SM0->M0_CODIGO
APEDIDOS  := {}
NLOOP	  := 1   
CESTOQUE := "N" //20080820


/*
MV_PAR01 = DE LOTE
MV_PAR02 = ATE LOTE
MV_PAR03 = DATA DO LOTE DE
MV_PAR04 = DATA DO LOTE ATE
MV_PAR05 = NUMERO DA 1 NOTA FISCAL
*/

If !Pergunte(cPerg)
   Return
Endif

Processa( {|| RunProc() } )// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>    Processa( {|| Execute(RunProc) } )


Static Function RunProc()
//20070620 daqui
IF SM0->M0_CODIGO=="01"
	cArq      := '\SIGA\AUDITLIB.DTC'//20121106 era dbf
	dbUseArea(.T.,,cArq,"AUDITLIB") //,.F.,.F.)
	cIndex    := CriaTrab(Nil,.F.)
	cKey      := "DTOS(DTLIB)+PEDIDO+ITEM"
	cFiltro   := ""
	Indregua("AUDITLIB",cIndex,ckey,,cFiltro,"Selecionando Registros do Arq")
ENDIF
//20070620 ate aqui

DbSelectArea("SC6")
DbSetOrder(16) //20050811 ERA 7
DbSeek(xFilial("SC6")+MV_PAR01+DTOS(MV_PAR03))

If !Found()
   Return
EndIf

ProcRegua( LastRec() )

While SC6->C6_LOTEFAT>=MV_PAR01 .AND.;
         SC6->C6_LOTEFAT<=MV_PAR02 .AND.;
         (DTOS(SC6->C6_DATA)>=DTOS(MV_PAR03)  .AND.;
          DTOS(SC6->C6_DATA)<=DTOS(MV_PAR04)) .AND. !EOF()
	IncProc()

   tregs := LastRec()-Recno()+1
   MSALDO    := 0   //20070619    
	SLDALMOX  := .T. //20070619    
	BLIBPED   := .T. //20070619    


   MPEDIDO:=SC6->C6_NUM
   /*/
   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ ABRE O ARQUIVO DE PEDIDOS E VERIFICA SE O PEDIDO JA FOI LIBERADO.           ³
   ³ SE JA FOI, PROCURA O PROXIMO.                                               ³
   ³ SENAO  PEGA O N.DO LOTE E A DATA E BAIXA  O PEDIDO NO ARQUIVO DE CONTROLE   ³
   ³ DE PEDIDOS, COLOCANDO A DATA, O LOTE E O FLAG "B",BAIXADO POR VENDA         ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   /*/
      DBSELECTAREA("SC5")
      DBSETORDER(1)
      DBSEEK(XFILIAL()+MPEDIDO)
      IF SC5->C5_LIBEROK=='S'
         DBSELECTAREA("SC6")
         DBSKIP()
         LOOP
      ENDIF

      MLOTEFAT := SC5->C5_LOTEFAT
      MDATA    := SC5->C5_DATA

      DBSELECTAREA("SZD")
      DBSETORDER(1)
      DBSEEK(XFILIAL()+MPEDIDO)
      IF FOUND()
         RECLOCK("SZD",.F.)
         REPLACE ZD_LOTEFAT WITH MLOTEFAT
         REPLACE ZD_DATA WITH MDATA
         REPLACE ZD_SITUAC WITH 'B'
         REPLACE ZD_DTSITUA WITH DATE()
         SZD->(MSUNLOCK())
      ENDIF

      DBSELECTAREA("SC6")

      While SC6->C6_NUM==MPEDIDO .AND. !EOF()
         mFilial   :=SC6->C6_FILIAL
         MITEM     :=SC6->C6_ITEM
         MPRODUTO  :=SC6->C6_PRODUTO
         MQTDVEN   :=SC6->C6_QTDVEN
         MPRCVEN   :=SC6->C6_PRCVEN
         MCLI      :=SC6->C6_CLI
         MLOJA     :=SC6->C6_LOJA
         MNUM      :=SC6->C6_NUM
         
		//20080820       daqui
		DbSelectArea("SF4")
		DbSetOrder(1)
		DbGoTop()
		DbSeek(xFilial("SF4")+SC6->C6_TES)
		If SF4->F4_ESTOQUE=='S'
			CESTOQUE := 'S'
		ELSE
			CESTOQUE := 'N'
		EndIf  //20080820 ate aqui

  		//20070620 DAQUI
		IF SM0->M0_CODIGO=="01" .AND. CESTOQUE =='S' //SC6->C6_TES <> "509" .AND. SC6->C6_TES <> "510"  //20080416 //20080820
			MSALDO := U_SldAlmox(SC6->C6_PRODUTO, SC6->C6_LOCAL)
			IF ((MSALDO - SC6->C6_QTDVEN) <0) 
			   SLDALMOX  := .F.
			   BLIBPED   := .F.
			   GRAVARAUDIT()
			   DBSELECTAREA("SC6")
			   DBSKIP()
			   LOOP
			ELSE
			   SLDALMOX  := .T.
			ENDIF              
		ENDIF
			//20070620 ATE AQUI

		 //If (SC6->C6_TES == "700" .or. SC6->C6_TES == "703" ) .and. mEmpresa<>'02' //20130228 daqui Liberar produtos da PSE
		 //	DBSELECTAREA("SC6")
        //   	dbSkip()
        //    Loop
        // Endif //20130228 ate aqui

         DBSELECTAREA("SB1")
         DBSETORDER(1)
         DBSEEK(XFILIAL()+MPRODUTO)

         IF FOUND()
            MGRUPO:=SB1->B1_GRUPO
         ENDIF


         DBSELECTAREA("SC6")
         RecLock("SC6",.F.)
         REPLACE C6_QTDEMP WITH C6_QTDVEN
         SC6->(MSUnlock())

         DbSelectArea("SC9")
         RecLock("SC9",.T.)
         REPLACE C9_FILIAL  WITH MFILIAL
         REPLACE C9_PEDIDO  WITH MPEDIDO
         REPLACE C9_ITEM    WITH MITEM
         REPLACE C9_CLIENTE WITH MCLI
         REPLACE C9_LOJA    WITH MLOJA
         REPLACE C9_PRODUTO WITH MPRODUTO
         REPLACE C9_QTDLIB  WITH MQTDVEN
         REPLACE C9_DATALIB WITH DDATABASE
         REPLACE C9_SEQUEN  WITH "01"
         REPLACE C9_GRUPO   WITH MGRUPO
         REPLACE C9_PRCVEN  WITH MPRCVEN
         REPLACE C9_LOCAL   WITH SC6->C6_LOCAL
         REPLACE C9_DATENT   WITH DDATABASE
         
         SC9->(MsUnLock())

         If Alltrim(SC5->C5_LOTEFAT) == "700"
            RecLock("SC9",.F.)
            SC9->C9_LOTEFAT:= SC5->C5_LOTEFAT
            MsUnLock()
         Endif

         DbSelectArea("SC6")
         DbSetOrder(16) //20050811 era 7
         Dbskip()
   End
                  
	IF SM0->M0_CODIGO=="01"
		IF BLIBPED  //20070620
   			DbSelectArea("SC5")
      		RecLock("SC5",.F.)
      			REPLACE C5_LIBEROK WITH 'S'
      			if SC5->C5_DATA1 < DDATABASE  //20070829
					REPLACE C5_DATA1 WITH DDATABASE
				endif
      		SC5->(MsUnlock())
		ENDIF  //20070620
	ELSE
		DbSelectArea("SC5")
    	RecLock("SC5",.F.)
    		REPLACE C5_LIBEROK WITH 'S'
    		if SC5->C5_DATA1 < DDATABASE  //20070829
				REPLACE C5_DATA1 WITH DDATABASE
			endif
    	SC5->(MsUnlock())
	ENDIF
   DbSelectArea("SC6")
   DbSetOrder(16) //20050811 ERA 7
End

DbSelectArea("SZ6")
Reclock("SZ6",.F.)
REPLACE Z6_LOTELIB WITH 'S'
SZ6->(MsUnLock())
    
IF SM0->M0_CODIGO=="01"               
	ESTORNARLIB() //20070703
	DBSELECTAREA("AUDITLIB")  //20070620
	Copy To & '\SIGA\AUDITLIB.DBF'  VIA "DBFCDXADS" // 20121106
	DBCLOSEAREA("AUDITLIB")  //20070620
ENDIF
Return
       


STATIC FUNCTION GRAVARAUDIT() //20070620 DAQUI
   DbSelectArea("SA3")
   DbSetOrder(1)
   DbSeek(XFILIAL("SA3")+SC5->C5_VEND1)
	RECLOCK("AUDITLIB",.T.) //inserir .T.
		AUDITLIB->DTLIB 	  := ddatabase
		AUDITLIB->PEDIDO	  := SC6->C6_NUM
		AUDITLIB->ITEM 	  := SC6->C6_ITEM
		AUDITLIB->PRODUTO  := SC6->C6_PRODUTO
		AUDITLIB->ALMOX    := SC6->C6_LOCAL
		AUDITLIB->QTD 	  := SC6->C6_QTDVEN
		AUDITLIB->CODVEND  := SC5->C5_VEND1
		AUDITLIB->NOMEVEND := SA3->A3_NOME
	MSUNLOCK()
	aAdd( APEDIDOS, {SC6->C6_NUM } ) //20070703
RETURN //20070620 ATE AQUI


//20070703
STATIC FUNCTION ESTORNARLIB()
For NLOOP :=1 to LEN(APEDIDOS)
	MPEDIDO := APEDIDOS[NLOOP][1]
  	DBSELECTAREA('SC6')
	DBSETORDER(1)
	IF DbSeek(xFilial("SC6")+MPEDIDO)
		WHILE !EOF() .AND. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NUM == MPEDIDO
			RecLock("SC6",.F.)
				REPLACE C6_QTDEMP WITH 0
			MSUnlock()         
			         
			DBSELECTAREA("SC9") //PEDIDOS LIBERADOS: APAGAR
			DbSetOrder(1)
			If DbSeek(xFilial("SC9")+SC6->C6_NUM+SC6->C6_ITEM)
				RECLOCK("SC9",.F.)
					DELETE
				MSUnlock()
			Endif

			DBSELECTAREA("SC6")
			DBSKIP()
		END
	ENDIF          
Next
RETURN