#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/ alterado por Danilo C S Pala em 20040203
//20050708 Danilo C S Pala: alteracoes de op solicitadas por Cicero
Danilo C S Pala 20070829: se o c5_data1 < ddatabase entao c5_data1 = ddatabase 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFAT007   ³Autor: Solange Nalini         ³ Data:   18/05/98 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Libera‡ao de Pedidos - ESPECIAL                            ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat007()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,LIBERA")
SetPrvt("MPEDIDO,MCONFIRMA,MCLIENTE,MLOJA,MEST,MFLAGID")
SetPrvt("MTIPOOP,_CTES,_CCF,MITEM,MFILIAL,MPRODUTO")
SetPrvt("MQTDVEN,MPRCVEN,MCLI,MGRUPO,")

CPERG:="FAT001"

Processa({|| RunProc()})

Return

Static Function RunProc()

MPEDIDO   := SPACE(06)
MCONFIRMA := SPACE(01)

@ 96,042 TO 323,505 DIALOG oDlg6 TITLE " Acerto de Liberação "
@ 08,010 TO 84,222
@ 40,025 say " PEDIDO--> "
@ 40,090 GET MPEDIDO
@ 60,025 say 'CONFIRMA S/N ? '
@ 60,090 GET MCONFIRMA PICTURE '@!'
@ 91,079 BMPBUTTON TYPE 1 ACTION PROCURA()
@ 91,159 BMPBUTTON TYPE 2 ACTION close(odlg6)
ACTIVATE DIALOG oDlg6 CENTERED

Return

Static Function Procura()
CLOSE(OdLG6)

DBSELECTAREA('SC5')
PROCREGUA(RECCOUNT())

LIBERA:=.T.

WHILE LIBERA
	IF MPEDIDO == SPACE(6)
		LIBERA := .F.
		LOOP
	ENDIF
	
	IF MCONFIRMA # 'S'
		LOOP
	ENDIF
	
	DBSELECTAREA('SC5')
	DBSETORDER(1)
	If !DbSeek(xFilial("SC5")+MPEDIDO)
		ALERT("PEDIDO NAO ENCONTRADO","ATENCAO")
		RETURN
	ENDIF
	
	IF SC5->C5_SERIE == 'UNI' .OR. SC5->C5_SERIE == 'SER'
		MsgStop(OemToAnsi("Atencao, este pedido ja tem uma nota fiscal emitida."),"ATENCAO")
		Libera := .f.
		DBSKIP()
		LOOP
	ENDIF
	
	MCLIENTE:=SC5->C5_CLIENTE
	MLOJA   :=SC5->C5_LOJACLI
	DBSELECTAREA("SA1")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SA1")+MCLIENTE+MLOJA)
	MEST    := SA1->A1_EST
	MFLAGID := SA1->A1_FLAGID
	LIB_PED()
END

Return

STATIC FUNCTION LIB_PED()

IncProc(" Acertando Registros "+ALLTRIM(SC5->C5_NUM))
DBSELECTAREA("SC5")

DO CASE
	CASE SC5->C5_TIPOOP == '18 '
		MTIPOOP:= '93 '
	CASE SC5->C5_TIPOOP == '24 '
		MTIPOOP := '20 '
	CASE SC5->C5_TIPOOP == '34 '
		MTIPOOP := '30 '
//20031205 Danilo
	CASE SC5->C5_TIPOOP == '44 '
		MTIPOOP := '45 '
	CASE SC5->C5_TIPOOP == '54 '
		MTIPOOP := '50 '
//ateh aki 20031205     
	CASE SC5->C5_TIPOOP == '63 ' //20040203
		MTIPOOP := '61 ' 
	CASE SC5->C5_TIPOOP == '80 ' //20050708
		MTIPOOP := '93 ' 
	CASE SC5->C5_TIPOOP == '82 '
		MTIPOOP := '02 ' 
	CASE SC5->C5_TIPOOP == '83 '
		MTIPOOP := '03 '
	CASE SC5->C5_TIPOOP == '84 ' 
		MTIPOOP := '04 '
	CASE SC5->C5_TIPOOP == '87 ' 
		MTIPOOP := '05 ' // ateh aki

	OTHERWISE
		MTIPOOP := SC5->C5_TIPOOP
ENDCASE

DbSelectArea("SC5")
RecLock("SC5",.F.)
SC5->C5_NOTA   := SPACE(6)
SC5->C5_TIPOOP := MTIPOOP
if SC5->C5_DATA1 < DDATABASE  //20070829
	REPLACE C5_DATA1 WITH DDATABASE
endif
MSUNLOCK()

DBSELECTAREA("SC6")
DBSETORDER(1)
IF !DBSEEK(XFILIAL("SC6")+MPEDIDO)
	MsgAlert("ITENS NAO ENCONTRADOS","ATENCAO")
	RETURN
ENDIF

// _cTES := "601"
// _cCF  := "5101"

WHILE !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NUM == MPEDIDO
	MITEM := SC6->C6_ITEM
	_cTES :=		SC6->C6_TES
	_cCF  :=		SC6->C6_CF  
	
	IF SM0->M0_CODIGO=="01"            // Gilberto . 30/11/2000
		
		IF SC6->C6_TES=='602'
			DO CASE
				CASE MEST == 'SP'
					_cTES := '601'
					_cCF  := '5101'
					//	_cCF  := '511 '
				CASE MEST =='EX'
					_cTES := '601'
					_cCF  := '7101'
					//	_cCF  := '711 '
				OTHERWISE
					_cTES := '601'
					_cCF  := '6101'
					//  _cCF  := '611 '
			ENDCASE
		ENDIF
		
		// PRECISA AINDA TRATAR O FLAGID
		IF SC6->C6_TES=='603'
			DO CASE
				CASE MEST == 'SP'
					_cTES := '512'
					_cCF  := '5102'
					//_cCF  := '512 '
				CASE MEST =='EX'
					_cTES := '512'
					_cCF  := '7102'
					//_cCF  := '712 '
				OTHERWISE
					_cTES := '512'
					_cCF  := '6102'
					//	_cCF  := '612 '
			ENDCASE
		ENDIF
	ENDIF
	
	IF SM0->M0_CODIGO == "01"  // Gilberto - 30.11.2000
		IF SC6->C6_TES <> '601'
			DbSelectArea("SC6")
			RecLock("SC6",.F.)
			SC6->C6_TES := _cTES     
			SC6->C6_CF  := _cCF
			MsUnlock()
		ENDIF
	ENDIF
	
	DBSELECTAREA("SA3")
	dbSetOrder(1)
	If dbSeek(xFilial("SA3")+SC5->C5_VEND1)
		DbSelectArea("SC6")
		RecLock("SC6",.f.)
		SC6->C6_LOCAL   := SA3->A3_LOCAL
		MsUnlock()
	Endif
	
	DBSELECTAREA("SC6")
	RecLock("SC6",.f.)
	SC6->C6_QTDEMP := SC6->C6_QTDVEN
	SC6->C6_NOTA   := SPACE(6)
	SC6->C6_SERIE  := SPACE(3)
	SC6->C6_DATFAT := CTOD('  /  /  ')
	SC6->C6_QTDENT := 0
	MsUnLock()
	
	DBSELECTAREA("SC9")
	DBSETORDER(1)
	IF DBSEEK(XFILIAL("SC9")+MPEDIDO+MITEM)
		DbSelectArea("SC9")
		RECLOCK("SC9",.F.)
		SC9->C9_NFISCAL := SPACE(6)
		SC9->C9_SERIENF := SPACE(3)
		SC9->C9_DATALIB := DDATABASE
		SC9->C9_BLEST   := SPACE(2)
		SC9->C9_BLCRED  := SPACE(2)
		MSUNLOCK()
	ELSE
		mfilial   := SC6->C6_FILIAL
		MPRODUTO  := SC6->C6_PRODUTO
		MQTDVEN   := SC6->C6_QTDVEN
		MPRCVEN   := SC6->C6_PRCVEN
		MCLI      := SC6->C6_CLI
		MLOJA     := SC6->C6_LOJA
		
		DBSELECTAREA("SB1")
		DBSETORDER(1)
		IF DBSEEK(XFILIAL()+MPRODUTO)
			MGRUPO := SB1->B1_GRUPO
		ENDIF
		
		DBSELECTAREA("SC9")
		RECLOCK("SC9",.T.)
		SC9->C9_FILIAL  := MFILIAL
		SC9->C9_PEDIDO  := MPEDIDO
		SC9->C9_ITEM    := MITEM
		SC9->C9_CLIENTE := MCLI
		SC9->C9_LOJA    := MLOJA
		SC9->C9_PRODUTO := MPRODUTO
		SC9->C9_QTDLIB  := MQTDVEN
		SC9->C9_DATALIB := dDataBase
		SC9->C9_SEQUEN  := '01'
		SC9->C9_GRUPO   := MGRUPO
		SC9->C9_PRCVEN  := MPRCVEN
		SC9->C9_LOCAL   := SC6->C6_LOCAL
		MSUNLOCK()
	ENDIF
	
	DBSELECTAREA("SC6")
	DBSKIP()
END

Libera := .F.

DBSELECTAREA("SE1")
RETINDEX("SE1")
DBSELECTAREA("SE3")
RETINDEX("SE3")
DBSELECTAREA("SC5")
RETINDEX("SC5")
DBSELECTAREA("SC6")
RETINDEX("SC6")
DBSELECTAREA("SC9")
RETINDEX("SC9")
DBSELECTAREA("SB1")
RETINDEX("SB1")
DBSELECTAREA("SA3")
RETINDEX("SA3")

RETURN
