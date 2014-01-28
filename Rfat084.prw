#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/                 
//Alterado por Danilo C S Pala em 20050520: CFB
//Alterado por Danilo C S Pala em 20061031: ANG
//Alterado por Danilo C S Pala em 20070315: CFE  
//Alterado por Danilo C S Pala em 20070328: NFS
//Alterado por Danilo C S Pala em 20080220: SEN
//Alterado por Danilo C S Pala em 20081031: STD
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: VDLIV     ³Autor: Rosane Lacava Rodrigues³ Data:   14/09/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Arquivo de Produtos / Vendedor - Vendas e Cortesias        ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat084()

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CPROGRAMA")
SetPrvt("NLASTKEY,_ACAMPOS,_CNOME,CINDEX,CKEY,MD")
SetPrvt("XD,MIND,_CFILTRO,CONT,MPEDIDO,MVEND")
SetPrvt("MNOTA,CONTINUA,MTES,MPROD,MTIT,")

//cSavAlias  := Select()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //Da data:          ³
//³ mv_par02             //Ate a data:       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG:='FAT022'
IF !Pergunte(CPERG)
	Return
EndIf

cPrograma := "VDLIV"
NLASTKEY  := 0

cMsg := "Este programa gera os arquivos DBF de vendas e cortesias de livros," + CHR(10) + CHR(13)
cMsg += "videos e cdrom, cuja parcela 'A' foi comissionada no periodo solicitado" + CHR(10) + CHR(13)

MsgInfo(OemToAnsi(cMsg),"VENDAS/CORTESIAS-COMISSOES")

_aCampos := {{"PRODUTO"  ,"C",15,0} ,;
{"TITULO"   ,"C",23,0} ,;
{"QTDE"     ,"N",6 ,0} ,;
{"VALOR"    ,"N",10,2} ,;
{"SERIE"    ,"C",3 ,0} ,;
{"NOTA"     ,"C",6 ,0} ,;
{"IT_NOTA"  ,"C",2 ,0} ,;
{"PEDIDO"   ,"C",6 ,0} ,;
{"IT_PED"   ,"C",2 ,0}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"VDLIV",.F.,.F.)

CINDEX := CRIATRAB(NIL,.F.)
CKEY   := "PEDIDO+IT_PED"
MsAguarde({|| INDREGUA("VDLIV",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (VDLIV)...")

_aCampos := {{"PRODUTO"  ,"C",15,0} ,;
{"TITULO"   ,"C",23,0} ,;
{"QTDE"     ,"N",6, 0} ,;
{"VALOR"    ,"N",10,2} ,;
{"SERIE"    ,"C",3 ,0} ,;
{"NOTA"     ,"C",6 ,0} ,;
{"IT_NOTA"  ,"C",2 ,0} ,;
{"PEDIDO"   ,"C",6 ,0} ,;
{"IT_PED"   ,"C",2 ,0}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"CORTES",.F.,.F.)

CINDEX := CRIATRAB(NIL,.F.)
CKEY   := "PEDIDO+IT_PED"
MsAguarde({|| INDREGUA("CORTES",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (CORTES)...")

IF NLASTKEY == 27 .OR. NLASTKEY == 65
	DBCLOSEAREA()
	RETURN
ENDIF

lEnd := .f.

Processa({|lEnd| RptDetail(@lEnd),"Aguarde","Selecionando Registros",.t. })// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        RptStatus({|| Execute(RptDetail)})

MsgStop("Arquivos CORTESLV.DBF e VENDASLV.DBF gerados em \SIGA\ARQTEMP\.","Fim de Processamento")

Return

Static Function RptDetail()

MD := MV_PAR01
XD := DTOS(MD)

DBSELECTAREA("SD2")
CINDEX := CRIATRAB(NIL,.F.)
CKEY   := "D2_FILIAL+D2_DOC+D2_PEDIDO"
MsAguarde({|| INDREGUA("SD2",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (SD2)...")

DBSELECTAREA("SE3")
_cFiltro := "E3_FILIAL == '"+xFilial("SE3")+"'"
_cFiltro := _cFiltro+" .and. (E3_PARCELA =='A' .OR. E3_PARCELA == ' ')"
_cFiltro := _cFiltro+" .and. DTOS(E3_DATA) >= '"+DTOS(MV_PAR01)+"'"
_cFiltro := _cFiltro+" .and. E3_VEND <> '000010' .AND. E3_VEND <> '000109' .AND. E3_VEND <> '000448'"
_cFiltro := _cFiltro+" .and. E3_VEND <> '000010' .AND. E3_VEND <> '000124' .AND. E3_VEND <> '000205'"
_cFiltro := _cFiltro+" .and. E3_VEND <> '000191' .AND. E3_VEND <> '000015' .AND. E3_VEND <> '000715'"
_cFiltro := _cFiltro+" .and. E3_VEND <> '000145' .AND. E3_VEND <> '000184' .AND. E3_VEND <> '001008'"
_cFiltro := _cFiltro+" .and. E3_VEND <> '001047'"
CINDEX := CRIATRAB(NIL,.F.)
CKEY   := "E3_FILIAL+DTOS(E3_DATA)"
MsAguarde({|| INDREGUA("SE3",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (SE3)...")

/*
DbSetOrder(5)
DBSEEK(XFILIAL("SE3")+'377150',.T.)   // Soft Seek on (.T.)
*/

PROCREGUA(RECCOUNT())

WHILE !EOF() .and. SE3->E3_FILIAL == xFilial("SE3")
	INCPROC("Lendo pedido: "+SE3->E3_PEDIDO)
	IF DTOS(SE3->E3_DATA) < DTOS(MV_PAR01) .OR. DTOS(SE3->E3_DATA) > DTOS(MV_PAR02)
		dbskip()
		loop
	ENDIF
	
	/*
	IF SE3->E3_PEDIDO=='270621'
	MSGALERT("ACHOU")
	ENDIF
	*/
	
	If (SE3->E3_PARCELA <> "A" .and. SE3->E3_PARCELA <> " ") .or. ;
		DTOS(SE3->E3_DATA) < DTOS(MV_PAR01) .or. ;
		DTOS(SE3->E3_DATA) > DTOS(MV_PAR02)
		DbSelectArea("SE3")
		DBSkip()
		Loop
	EndIf
	
	IF SE3->E3_SITUAC <> ' ' .OR. SE3->E3_COMIS < 0
		CONT := -1
	ELSE
		CONT := 1
	ENDIF
	
	MPEDIDO := SE3->E3_PEDIDO
	MVEND   := SE3->E3_VEND
	MNOTA   := SE3->E3_NUM
	
	DBSELECTAREA("SA3")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SA3")+MVEND)
	IF !FOUND() .OR. SA3->A3_TIPOVEN == 'SP'
		DBSELECTAREA("SE3")
		DBSKIP()
		LOOP
	ENDIF
	
	DBSELECTAREA("SD2")
	DbSetOrder(3)
	IF !DBSEEK(xFilial("SD2")+MNOTA) // +  MPEDIDO
		DBSELECTAREA("SE3")
		DBSKIP()
		LOOP
	ENDIF

	CONTINUA:=.T.
	
	WHILE !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .AND. MNOTA == SD2->D2_DOC  //.and.  .AND. CONTINUA SD2->D2_PEDIDO == MPEDIDO
		INCPROC()
		If ! (SD2->D2_SERIE)$ "UNI/CUP/CFS/CFA/CFB/ANG/CFE/NFS/SEN/STD/8  " .or. SD2->D2_PEDIDO <> MPEDIDO  //20050520 CFB //20061031 ANG //20070315 CFE //20070328 NFS //20080220 SEN //20081031 STD
			DbSelectArea("SD2")
			DbSkip()
			Loop
		EndIf
		
		MTES  := SD2->D2_TES
		MPROD := SD2->D2_COD
		
		IF SUBSTR(MPROD,1,2) <> "02" .AND. SUBSTR(MPROD,1,2) <> "07"
			DbSelectArea("SD2")
			DBSKIP()
			LOOP
		ENDIF
		
		MTIT  := ' '
		
		DBSELECTAREA("SB1")
		DBSETORDER(1)
		IF DBSEEK(XFILIAL("SB1")+MPROD)
			MTIT := SB1->B1_TITULO
		ENDIF
		
		DBSELECTAREA("SF4")
		DBSETORDER(1)
		DBSEEK(XFILIAL("SF4")+MTES)
		IF SF4->F4_DUPLIC <> "S"
			DbSelectArea("SD2")
			DbSkip()
			Loop
		EndIf
		
		IF "VENDA" $(SF4->F4_TEXTO) .OR. "PREST SERV" $(SF4->F4_TEXTO)
			DBSELECTAREA("VDLIV")
			DbSetOrder(1)
			//			If !DBSEEK(SD2->D2_PEDIDO+SD2->D2_ITEMPV)
						DBSEEK(SD2->D2_PEDIDO+SD2->D2_ITEMPV)
			// DBSEEK(SB1->B1_TITULO)
			IF !FOUND()
				RECLOCK("VDLIV",.T.)
				VDLIV->VALOR    := (SD2->D2_TOTAL * CONT)
				VDLIV->QTDE     := (SD2->D2_QUANT * CONT)
				VDLIV->TITULO   := SB1->B1_TITULO
				VDLIV->PRODUTO  := SD2->D2_COD
				VDLIV->SERIE    := SD2->D2_SERIE
				VDLIV->NOTA     := SD2->D2_DOC
				VDLIV->IT_NOTA  := SD2->D2_ITEM
				VDLIV->PEDIDO   := SD2->D2_PEDIDO
				VDLIV->IT_PED   := SD2->D2_ITEMPV
				MsUnlock()
			ELSE
				RECLOCK("VDLIV",.F.)
				VDLIV->VALOR := (VDLIV->VALOR + (SD2->D2_TOTAL * CONT))
				VDLIV->QTDE  := (VDLIV->QTDE  + (SD2->D2_QUANT * CONT))
				MsUnlock()
			EndIf
		ELSE
			IF "CORTESIA" $ (F4_TEXTO)
				DBSELECTAREA("CORTES")
				DbSetOrder(1)
				//				If !DBSEEK(SD2->D2_PEDIDO+SD2->D2_ITEMPV)
				 DBSEEK(SD2->D2_PEDIDO+SD2->D2_ITEMPV)
				// DBSEEK(SB1->B1_TITULO)
				IF !FOUND()
					RECLOCK("CORTES",.T.)
					CORTES->VALOR    := (SD2->D2_TOTAL * CONT)
					CORTES->QTDE     := (SD2->D2_QUANT * CONT)
					CORTES->TITULO   := SB1->B1_TITULO
					CORTES->PRODUTO  := SD2->D2_COD
					CORTES->SERIE    := SD2->D2_SERIE
					CORTES->NOTA     := SD2->D2_DOC
					CORTES->IT_NOTA  := SD2->D2_ITEM
					CORTES->PEDIDO   := SD2->D2_PEDIDO
					CORTES->IT_PED   := SD2->D2_ITEMPV
					MsUnlock()
				ELSE
					RECLOCK("CORTES",.F.)  //RECLOCK("VDLIV",.F.)
					CORTES->VALOR := (CORTES->VALOR + (SD2->D2_TOTAL * CONT))
					CORTES->QTDE  := (CORTES->QTDE  + (SD2->D2_QUANT * CONT))
					MsUnlock()
				EndIf
			ENDIF
		ENDIF
		
		DBSELECTAREA("SD2")
		DBSKIP()
		INCPROC()
	END
	
	DBSELECTAREA("SE3")
	DBSKIP()
	
	INCPROC()
END

DBSELECTAREA("VDLIV")
DBGOTOP()
WHILE !EOF()
	INCPROC()
	IF VALOR == 0 .AND. QTDE == 0
		DBSELECTAREA("VDLIV")
		RECLOCK("VDLIV",.F.)
		DBDELETE()
		MSUNLOCK()
	ENDIF
	DBSKIP()
END

COPY TO &("\SIGA\ARQTEMP\VENDASLV.DBF") VIA "DBFCDXADS" // 20121106 
DBCLOSEAREA()

DBSELECTAREA("CORTES")
DBGOTOP()
WHILE !EOF()
	INCPROC()
	IF VALOR == 0 .AND. QTDE == 0
		RECLOCK("CORTES",.F.)
		DBDELETE()
		MSUNLOCK()
	ENDIF
	DBSKIP()
END

COPY TO &("\SIGA\ARQTEMP\CORTESLV.DBF") VIA "DBFCDXADS" // 20121106 
DBCLOSEAREA()

MS_FLUSH()

DBSELECTAREA("SE3")
RETINDEX("SE3")

DBSELECTAREA("SD2")
RETINDEX("SD2")

DBSELECTAREA("SF4")
RETINDEX("SF4")

DBSELECTAREA("SB1")
RETINDEX("SB1")

RETURN
