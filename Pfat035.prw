#INCLUDE "PROTHEUS.CH"
#include "rwmake.ch"
/*/
Danilo C S Pala 20070619: validar o saldo em estoque, caso negativo nao liberar
Danilo C S Pala 20070622: somente na Editora Pini
Danilo C S Pala 20070703: estornar itens liberados
Danilo C S Pala 20070828: se o c5_data1 < ddatabase entao c5_data1 = ddatabase   
Danilo C S Pala 20080416: NAO VALIDAR ESTOQUE DOS TES 509 E 510   
Danilo C S Pala 20080820: nao validar tes que nao controla estoque
Danilo C S Pala 20100323: corrigir erro quando nao encontra o pedido
Danilo C S Pala 20120215: passar numero do pedido para liberacao automatica dos pedidos da FEICON
Danilo C S Pala 20130711: reservar quantidade liberada no SB2
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT035   ³Autor: Solange Nalini         ³ Data:   18/05/98 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Libera‡ao de Pedidos - ESPECIAL                            ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat035(cPedido, cCupom)        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,LIBERA")
SetPrvt("MPEDIDO,MCONFIRMA,TREGS,M_MULT,P_ANT,P_ATU")
SetPrvt("P_CNT,M_SAV20,M_SAV7,MLOTEFAT,MDATA,MFILIAL")
SetPrvt("MITEM,MPRODUTO,MQTDVEN,MPRCVEN,MCLI,MLOJA")
SetPrvt("MNUM,MGRUPO,SLDALMOX, BLIBPED, MSALDO, APEDIDOS, NLOOP, CESTOQUE, CFechaDlg, MCUPOM")
Private cClientName := GetComputerName()
Private aInfoComp := GetSrvInfo() 
cServerName := aInfoComp[1]
Private cServerName := ""
Private cpath := ""

Default cPedido := ""
Default cCupom := ""

CPERG:="FAT001"

MPEDIDO   := SPACE(06)
MCONFIRMA := SPACE(01)    
MSALDO    := 0   //20070619    
SLDALMOX  := .T. //20070619    
BLIBPED   := .T. //20070619                     
APEDIDOS  := {}
NLOOP	  := 1
MPAGA1	  := SPACE(1) //20070828  
CESTOQUE := "N" //20080820
CFechaDlg := "N"
	
if cPedido == ""
	CFechaDlg := "S"
	MCUPOM := ""
	@ 96,042 TO 323,505 DIALOG oDlgL TITLE " Acerto de Liberação "
	@ 08,010 TO 84,222
	@ 40,025 say " PEDIDO--> "
	@ 40,090 GET MPEDIDO PICTURE '@!'
	@ 91,079 BMPBUTTON TYPE 1 ACTION LIB_PED()
	@ 91,159 BMPBUTTON TYPE 2 ACTION close(odlgL) 
	ACTIVATE DIALOG oDlgL CENTERED
Else      
	MPEDIDO := cPedido
	MCUPOM := cCupom //RI = RESERVA INCLUSAO, RA= RESERVA ALTERACAO e RJ = RESERVA JOBPINI01
	LIB_PED()
Endif

Return

/*************************************************/
Static FUNCTION LIB_PED()      
IF MPEDIDO == SPACE(6)
	CLOSE(OdLGL)
ELSE
	DBSELECTAREA('SC6')
	ProcRegua(RecCount())
	DBSETORDER(1)
	IF !DbSeek(xFilial("SC6")+MPEDIDO)
		MsgBox("Pedido não localizado!")
		RETURN
	ENDIF
	
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

	
	WHILE !EOF() .AND. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NUM == MPEDIDO
		IncProc(" Acertando Registros "+Alltrim(SC6->C6_NUM))
		tregs := LastRec()-Recno()+1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ ABRE O ARQUIVO DE PEDIDOS E VERIFICA SE O PEDIDO JA FOI LIBERADO.           ³
		//³ SE JA FOI, PROCURA O PROXIMO.                                               ³
		//³ SENAO  PEGA O N.DO LOTE E A DATA E BAIXA  O PEDIDO NO ARQUIVO DE CONTROLE   ³
		//³ DE PEDIDOS, COLOCANDO A DATA, O LOTE E O FLAG "B",BAIXAO POR VENDA          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DBSELECTAREA("SC5")
		DBSETORDER(1)
		DBSEEK(XFILIAL()+MPEDIDO)
		IF SC5->C5_LIBEROK == 'S'
			DBSELECTAREA("SC6")
			DBSKIP()
			LOOP
		ENDIF
		MLOTEFAT := SC5->C5_LOTEFAT
		MDATA    := SC5->C5_DATA
		
		DBSELECTAREA("SZD")
		DBSETORDER(2)
		If DBSEEK(XFILIAL("SZD")+MPEDIDO)
			RECLOCK("SZD",.F.)
			REPLACE ZD_LOTEFAT WITH MLOTEFAT
			REPLACE ZD_DATA WITH MDATA
			REPLACE ZD_SITUAC WITH 'B'
			REPLACE ZD_DTSITUA WITH DATE()
			MSUNLOCK()
		ENDIF         
				
		DBSELECTAREA("SC6")
		WHILE !eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NUM == MPEDIDO
			mfilial   :=SC6->C6_FILIAL
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

			//20070619 DAQUI                  
			IF SM0->M0_CODIGO=="01" .AND. CESTOQUE =='S' // SC6->C6_TES <> "509" .AND. SC6->C6_TES <> "510"  //20080416   //20080820
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
			//20070619 ATE AQUI

			If SC6->C6_TES == "700" .OR. SC6->C6_TES == "703"
				DBSELECTAREA("SC6")
				dbSkip()
				Loop
			Endif
			
			DBSELECTAREA("SB1")
			DBSETORDER(1)
			If DBSEEK(XFILIAL()+MPRODUTO)
				MGRUPO := SB1->B1_GRUPO
			ENDIF
			
			RecLock("SC6",.F.)
			REPLACE C6_QTDEMP WITH C6_QTDVEN
			MSUnlock()
			
			DBSELECTAREA("SC9")
			DbSetOrder(1)
			If !DbSeek(xFilial("SC9")+SC6->C6_NUM+SC6->C6_ITEM)
				RECLOCK("SC9",.T.)
				REPLACE C9_FILIAL  WITH MFILIAL
				REPLACE C9_PEDIDO  WITH MPEDIDO
				REPLACE C9_ITEM    WITH MITEM
				REPLACE C9_CLIENTE WITH MCLI
				REPLACE C9_LOJA    WITH MLOJA
				REPLACE C9_PRODUTO WITH MPRODUTO
				REPLACE C9_QTDLIB  WITH MQTDVEN
				REPLACE C9_DATALIB WITH DDATABASE
				REPLACE C9_SEQUEN  WITH '01'
				REPLACE C9_GRUPO   WITH MGRUPO
				REPLACE C9_PRCVEN  WITH MPRCVEN
				REPLACE C9_LOCAL   WITH SC6->C6_LOCAL
				REPLACE C9_DATENT   WITH DDATABASE
				MSUNLOCK()
			Else
				If Empty(SC9->C9_NFISCAL)
					RecLock("SC9",.f.)
					REPLACE C9_QTDLIB  WITH MQTDVEN
					REPLACE C9_DATALIB WITH DDATABASE
					REPLACE C9_PRCVEN  WITH MPRCVEN
					REPLACE C9_LOCAL   WITH SC6->C6_LOCAL
					REPLACE C9_BLEST   WITH ""
					REPLACE C9_BLCRED  WITH ""
					REPLACE C9_DATENT   WITH DDATABASE
					MsUnlock()
				EndIf
			EndIf
			
			DBSELECTAREA("SB2") //daqui 20130711
			DBSETORDER(1)
			If DBSEEK(XFILIAL("SB2")+MPRODUTO+SC6->C6_LOCAL)
				RecLock("SB2",.f.)
					If mcupom ="RI" .OR. mcupom ="RJ" //inclui ou RESERVA JOBPINI01
						REPLACE B2_RESERVA WITH SB2->B2_RESERVA + MQTDVEN
					Elseif mcupom ="RA" //altera POR PADRÃO O SISTEMA JÁ ESTORNOU A RESERVA NA QUANTIDADE RESERVADA ANTERIORMENTE
					  REPLACE B2_RESERVA WITH SB2->B2_RESERVA + MQTDVEN
					EndIf
				MsUnlock()
			Else
				If mcupom <> "RJ"
					MsgAlert("Erro ao gravar a reserva em estoque. Pedido:"+ MPEDIDO + " Produto:" + MPRODUTO)
				EndIf
			EndIf //ate aqui 20130711
			
			DBSELECTAREA("SC6")
			dbskip()
		END
		           
		IF SM0->M0_CODIGO=="01"
			IF BLIBPED  //20070619
				DbSelectArea("SC5")
				RecLock("SC5",.F.)
				REPLACE C5_LIBEROK WITH 'S'
				if SC5->C5_DATA1 < DDATABASE  //20070828
					REPLACE C5_DATA1 WITH DDATABASE
				endif
				msUnlock()
			ENDIF
		ELSE
			DbSelectArea("SC5")
			RecLock("SC5",.F.)
			REPLACE C5_LIBEROK WITH 'S'
			if SC5->C5_DATA1 < DDATABASE  //20070828
				REPLACE C5_DATA1 WITH DDATABASE
			endif
			msUnlock()
		ENDIF  //20070619
		
		DBSELECTAREA("SC6")
		DBSKIP()
	END
	
	If CFechaDlg == "S"
		CLOSE(oDlgL)
	Else
		IF MCUPOM == "S"
			if cServerName == cClientName
				cpath := "C:\ECFBematechPini\"
			else  
				cpath := "C:\ECFBematechPini\"
				If File(cpath + "ECFBematechPini.exe")
					cpath := "C:\ECFBematechPini\"
				Else
					cpath := "ECFBematechPini.exe (*.exe) | *.RET"
					cpath := cGetFile ( cpath,"Dialogo de Selecao de Arquivos", 0, "C:\", .F., GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY)
				EndIf
			endif
		
			WaitRun(cpath + "ECFBematechPini "+ SM0->M0_CODIGO +" "+ Alltrim(MPEDIDO))
			
		ENDIF
	EndIf
ENDIF
        
                               
IF SM0->M0_CODIGO=="01"
	ESTORNARLIB() //20070703
	DBSELECTAREA("AUDITLIB")  //20070620
	DBCLOSEAREA("AUDITLIB")  //20070620
ENDIF
RETURN


STATIC FUNCTION GRAVARAUDIT() //20070619 DAQUI
   DbSelectArea("SA3")
   DbSetOrder(1)
   DbSeek(XFILIAL("SA3")+SC5->C5_VEND1)
	RECLOCK("AUDITLIB",.T.) //inserir .T.
		AUDITLIB->DTLIB    := ddatabase
		AUDITLIB->PEDIDO   := SC6->C6_NUM
		AUDITLIB->ITEM 	   := SC6->C6_ITEM
		AUDITLIB->PRODUTO  := SC6->C6_PRODUTO
		AUDITLIB->ALMOX    := SC6->C6_LOCAL
		AUDITLIB->QTD 	   := SC6->C6_QTDVEN
		AUDITLIB->CODVEND  := SC5->C5_VEND1
		AUDITLIB->NOMEVEND := SA3->A3_NOME
	MSUNLOCK()
	aAdd( APEDIDOS, {SC6->C6_NUM } ) //20070703
RETURN //20070619 ATE AQUI
                                                                                    

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