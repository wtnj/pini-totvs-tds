#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PRODVD    ³Autor: Rosane Lacava Rodrigues³ Data:   21/07/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de Produtos / Vendedor                           ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat037()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CDESC1")
SetPrvt("CDESC2,CDESC3,CTITULO,CCABEC1,CCABEC2,CPROGRAMA")
SetPrvt("CTAMANHO,LIMITE,NCARACTER,NLASTKEY,MEMPRESA,MMES")
SetPrvt("MANO,CARQ,CARQPATH,_CSTRING,ARETURN,_ACAMPOS")
SetPrvt("_CNOME,_CKEY,CINDEX,WNREL,CSTRING,MD")
SetPrvt("XD,_CINDEX,MIND,_CFILTRO,CONT,MPEDIDO")
SetPrvt("MVEND,MNOTA,CONTINUA,MTES,MPROD,MTIT")
SetPrvt("MEQUIPE,MNOME,MDIVVEND,MNUN,MMUN,CMSG")
SetPrvt("M_PAG,L,MQTDE,MQTDET,MSUBT,MTOTAL")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //Da data:          ³
//³ mv_par02             //Ate a data:       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG := 'FAT022'
IF !PERGUNTE(CPERG)
	RETURN
ENDIF

CDESC1    := PADC("Este programa emite relatorio de produtos por vendedor, cuja",70)
CDESC2    := PADC("parcela 'A' foi comissionada no periodo solicitado",70)
CDESC3    := ""
cTitulo   := "*** PRODUTOS POR VENDEDOR * PERIODO COMISSAO: "+DTOC(MV_PAR01)+" A "+DTOC(MV_PAR02)+" ***"
cCabec1   := "TITULO                                 QUANTIDADE                                 VALOR"
cCabec2   := ""
cPrograma := "PRODVD"
cTamanho  := "M"
LIMITE    := 132
nCaracter := 12
NLASTKEY  := 0
MEMPRESA  := SM0->M0_CODIGO
MMES      := ALLTRIM(STR(MONTH(MV_PAR02),2))
MANO      := STR(YEAR(MV_PAR02),4)

IF MEMPRESA == '01'
	cArq   := 'PCOM'+MMES+SUBS(MANO,3,2)
ENDIF
IF MEMPRESA == '02'
	cArq   := 'SCOM'+MMES+SUBS(MANO,3,2)
ENDIF

cArqPath  :=GetMv("MV_PATHTMP")
_cString  :=cArqPath+cArq+".DBF"

aRETURN  := {"Especial", 1,"Administracao", 1, 2, 1," ",1 }

_aCampos := {{"TITULO"   ,"C",23,0} ,;
{"QTDE"     ,"N",06,0} ,;
{"VALOR"    ,"N",10,2} ,;
{"CODVEND"  ,"C",06,0} ,;
{"NOME"     ,"C",40,0} ,;
{"EQUIPE"   ,"C",15,0} ,;
{"DIVVEND"  ,"C",40,0} ,;
{"MUNICIPIO","C",15,0} }

If Select("PRODVD") <> 0
	DbSelectArea("PRODVD")
	DbCloseArea()
EndIf	

_cNome := CriaTrab(_aCampos,.T.)
dbUseArea(.T.,, _cNome,"PRODVD",.F.,.F.)
_cKey := "EQUIPE+CODVEND+TITULO"
MsAguarde({|| INDREGUA("PRODVD", _cNome, _cKey,,,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario...")

_aCampos := {{"TITULO"   ,"C",23,0} ,;
{"QTDE"     ,"N",6, 0} ,;
{"VALOR"    ,"N",10,2} ,;
{"MUNICIPIO","C",15,0} ,;
{"EQUIPE"   ,"C",15,0} ,;
{"DIVVEND"  ,"C",40,0} }

If Select("PRODEQ") <> 0
	DbSelectArea("PRODEQ")
	DbCloseArea()
EndIf	

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PRODEQ",.F.,.F.)
_cKey := "EQUIPE+TITULO"
MsAguarde({|| INDREGUA("PRODEQ",_cNome, _cKey,,,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario...")

_aCampos := {{"PEDIDO"   ,"C",6,0 } ,;
{"VEND"     ,"C",6,0 } ,;
{"VALOR"    ,"N",10,2} ,;
{"NOME"     ,"C",40,0} ,;
{"QTDE"     ,"N",10,4} ,;
{"ITEM"     ,"C",2,0 } ,;
{"TITULO"   ,"C",20,0}}

If Select("ARQX") <> 0
	DbSelectArea("ARQX")
	DbCloseArea()
EndIf	

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"ARQX",.F.,.F.)
MHORA := TIME()
WNREL   := "PRODVD_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING := "PRODVD"
WNREL   := SETPRINT(CSTRING,WNREL,CPERG,cTitulo,CDESC1,CDESC2,CDESC3,.F.)
SETDEFAULT(aRETURN,CSTRING)

IF NLASTKEY==27 .OR. NLASTKEY==65
	DBCLOSEAREA()
	RETURN
ENDIF

lEnd := .f.

Processa({|lEnd| RptDetail(@lEnd)})

Return

Static Function RptDetail()

MD :=MV_PAR01
XD :=DTOS(MD)

// Retirado para uso no indice do SD2
//DBSELECTAREA("SD2")
//_cIndex := CRIATRAB(NIL,.F.)
//_cKey   := "D2_FILIAL+D2_DOC+D2_PEDIDO"
//MsAguarde({|| INDREGUA("SD2", _cIndex, _cKey,,,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (SD2)...")

DBSELECTAREA("SE3")
DbSetOrder(4)
//_cFiltro := "E3_FILIAL == '"+xFilial("SE3")+"'"
//_cFiltro := _cFiltro+" .and. (E3_PARCELA == 'A' .OR. E3_PARCELA == ' ')"
//_cFiltro := _cFiltro+" .and. DTOS(E3_DATA) >= '"+DTOS(MV_PAR01)+"'"

//_cIndex := CRIATRAB(NIL,.F.)
//_cKey   := "E3_FILIAL+DTOS(E3_DATA)"
//MsAguarde({|| INDREGUA("SE3", _cIndex, _cKey,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (SE3)...")

DBSEEK(XFILIAL("SE3")+XD,.T.)   // Soft Seek on (.T.)

ProcRegua(RECCOUNT())
WHILE !EOF() .AND. SE3->E3_DATA <= MV_PAR02 .and. !lEnd
	IncProc("Nota: "+SE3->E3_SERIE + SE3->E3_NUM)
	
	If !SE3->E3_PARCELA$"A/ "
		DbSelectArea("SE3")
		DbSkip()
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
	If !DBSEEK(XFILIAL("SA3")+MVEND,.F.) .or. SA3->A3_TIPOVEN == 'SP'
		DBSELECTAREA("SE3")
		DBSKIP()
		LOOP
	ENDIF
	
	DBSELECTAREA("SD2")
	DbSetOrder(8)
	If !DBSEEK(xFilial("SD2")+MPEDIDO) //!DBSEEK(xFilial("SD2")+MNOTA+MPEDIDO,.F.)
		DBSELECTAREA("SE3")
		DBSKIP()
		LOOP
	ENDIF
	
	CONTINUA := .T.
	WHILE !Eof() .and. xFilial("SD2") == SD2->D2_FILIAL .and. Alltrim(MPEDIDO) == Alltrim(SD2->D2_PEDIDO) .and. continua //.AND. MNOTA == SD2->D2_DOC .AND. CONTINUA
		MPEDIDO := SD2->D2_PEDIDO
		
		If Alltrim(MNOTA) <> Alltrim(SD2->D2_DOC)
			DbSelectArea("SD2")
			DbSkip()
			Loop
		EndIf
		
		//   DBSELECTAREA("SC5")
		//   DBSETORDER(1)
		//   DBSEEK(XFILIAL()+MPEDIDO)
		//   IF FOUND()
		//      IF SC5->C5_DIVVEN#'MERC'
		//         DBSELECTAREA("SD2")
		//         DBSKIP()
		//         LOOP
		//       ENDIF
		//   ENDIF
		//   DBSELECTAREA("SD2")
		
		IncProc("Nota: "+SE3->E3_SERIE + SE3->E3_NUM)
		MTES  := SD2->D2_TES
		MPROD := SD2->D2_COD
		
		IF VAL(SUBSTR(MPROD,1,2)) > 10 .AND. VAL(SUBSTR(MPROD,1,2)) < 21
			IF VAL(SUBSTR(MPROD,1,2)) <> 17
				DBSKIP()
				LOOP
			ENDIF
		ENDIF
		
		IF VAL(SUBSTR(MPROD,1,2)) == 3 .OR. VAL(SUBSTR(MPROD,1,2)) == 8 .OR.;
			SUBSTR(MPROD,1,7) == '9999999' .OR. VAL(SUBSTR(MPROD,1,2)) == 5
			DBSKIP()
			LOOP
		ENDIF
		
		DBSELECTAREA("SF4")
		DBSETORDER(1)
		DBSEEK(XFILIAL("SF4")+MTES)
		IF !"VENDA" $(F4_TEXTO) .AND. !"PREST SERV" $(F4_TEXTO)
			DBSELECTAREA("SD2")
			DBSKIP()
			LOOP
		ENDIF
		
		MTIT  := ' '
		
		DBSELECTAREA("SB1")
		DBSETORDER(1)
		If DBSEEK(XFILIAL("SB1")+MPROD,.F.)
			MTIT := SB1->B1_TITULO
		ENDIF
		
		IF SUBSTR(MPROD,1,2) == '02'
			IF SUBSTR(MTIT,1,4) == 'TCPO'
				MTIT := SB1->B1_TITULO
			ELSE
				IF SUBSTR(MPROD,3,5) == '08271'
					MTIT := 'ESSERE'
				ELSE
					MTIT := 'LIVROS                 '
				ENDIF
			ENDIF
		ENDIF
		IF SUBSTR(MPROD,1,2) == '07'
			IF SUBSTR(MPROD,3,5) == '01018'
				MTIT := 'ESSEREROM'
			ELSE
				IF SUBSTR(MPROD,3,5) == '01017'
					MTIT := 'TCPOROM'
				ELSE
					MTIT := 'VIDEOS/CDROM           '
				ENDIF
			ENDIF
		ENDIF
		IF SUBSTR(MPROD,1,2) == '01'
			IF SUBSTR(MPROD,5,3) == '001'
				IF VAL(SUBSTR(MPROD,3,2)) < 6
					MTIT := 'CONSTRUCAO REG AVULSA    '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 7
					MTIT := 'AU AVULSA                '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 8
					MTIT := 'TECHNE AVULSA            '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) ==14
					MTIT := 'SP CONSTRUCA AVULSA     '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) ==15
					MTIT := 'CONSTRUCAO MERCADO AVULSA'
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 1
					MTIT := 'CONSTRUCAO SP AVULSA     '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 10
					MTIT := 'CERAMICA AVULSA          '
				ENDIF
			ENDIF
			IF SUBSTR(MPROD,5,3) == '002' .OR. SUBSTR(MPROD,5,3) == '003' .OR. SUBSTR(MPROD,5,3) == '006'
				IF VAL(SUBSTR(MPROD,3,2)) < 6
					MTIT := 'CONSTRUCAO REG NOVA    '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 7
					MTIT := 'AU NOVA                '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 8
					MTIT := 'TECHNE NOVA            '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 1
					MTIT := 'CONSTRUCAO SP NOVA     '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 10
					MTIT := 'CERAMICA NOVA          '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 14
					MTIT := 'SP CONSTRUCAO NOVA     '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 15
					MTIT := 'CONSTRUCAO MERCADO NOVA'
				ENDIF
			ENDIF
			IF SUBSTR(MPROD,5,3) == '004' .OR. SUBSTR(MPROD,5,3) == '005' .OR. SUBSTR(MPROD,5,3) == '007'
				IF VAL(SUBSTR(MPROD,3,2)) < 6
					MTIT := 'CONSTRUCAO REG RENOVADA'
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 7
					MTIT := 'AU RENOVADA            '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 8
					MTIT := 'TECHNE RENOVADA        '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 1
					MTIT := 'CONSTRUCAO SP RENOVADA '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 10
					MTIT := 'CERAMICA RENOVADA      '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 14
					MTIT := 'SP CONST RENOVADA      '
				ENDIF
				IF VAL(SUBSTR(MPROD,3,2)) == 15
					MTIT := 'CONST MERCADO RENOVADA'
				ENDIF
			ENDIF
		ENDIF
		IF SUBSTR(MPROD,1,4) == '0198' .OR. SUBSTR(MPROD,1,4) == '0607'
			MTIT := 'SEPARATAS              '
		ENDIF
		IF SUBSTR(MPROD,1,2) == '10'
			MTIT := 'RELATORIOS             '
		ENDIF
		IF SUBSTR(MPROD,1,2) == '17'
			MTIT := 'ESSERE ASSINATURA      '
		ENDIF
		
		MEQUIPE := ' '
		MNOME   := ' '
		MDIVVEND:= ' '
		MNUN    := ' '
		DBSELECTAREA("SA3")
		DbSetOrder(1)
		If DBSEEK(XFILIAL("SA3")+MVEND,.F.)
			MEQUIPE := A3_EQUIPE
			MNOME   := A3_NOME
			MMUN    := A3_MUN
			MDIVVEND:= A3_DIVVEND
		ENDIF
		
		//IF MVEND =='000122' .AND. SUBS(SD2->D2_COD,1,2)=='17'
		// INKEY(0)
		//ENDIF
		//IF MVEND =='000694' .AND. SUBS(SD2->D2_COD,1,2)=='17'
		//  INKEY(0)
		//ENDIF
		DBSELECTAREA("PRODVD")
		If !DBSEEK(MEQUIPE+MVEND+MTIT,.F.)
			RECLOCK("PRODVD",.T.)
			PRODVD->CODVEND  := MVEND
			PRODVD->VALOR    := (SD2->D2_TOTAL * CONT)
			IF SUBS(SD2->D2_COD,1,4)#'1795'
				PRODVD->QTDE  := (PRODVD->QTDE  + (SD2->D2_QUANT * CONT))
			ENDIF
			PRODVD->TITULO   := MTIT
			PRODVD->EQUIPE   := MEQUIPE
			PRODVD->DIVVEND  := MDIVVEND
			PRODVD->NOME     := MNOME
			PRODVD->MUNICIPIO:= MMUN
			MsUnlock()
		ELSE
			RECLOCK("PRODVD",.F.)
			PRODVD->VALOR := (PRODVD->VALOR + (SD2->D2_TOTAL * CONT))
			IF SUBS(SD2->D2_COD,1,4)#'1795'
				PRODVD->QTDE  := (PRODVD->QTDE  + (SD2->D2_QUANT * CONT))
			ENDIF
			MsUnlock()
		ENDIF
		
		DBSELECTAREA("PRODEQ")
		If !DBSEEK(MEQUIPE+MTIT,.F.)
			RECLOCK("PRODEQ",.T.)
			PRODEQ->VALOR    := (SD2->D2_TOTAL * CONT)
			IF SUBS(SD2->D2_COD,1,4)#'1795'
				PRODEQ->QTDE  := (PRODEQ->QTDE  + (SD2->D2_QUANT * CONT))
			ENDIF
			PRODEQ->TITULO   := MTIT
			PRODEQ->EQUIPE   := MEQUIPE
			PRODEQ->DIVVEND  := MDIVVEND
			PRODEQ->MUNICIPIO:= MMUN
			MsUnlock()
		ELSE
			RECLOCK("PRODEQ",.F.)
			PRODEQ->VALOR := (PRODEQ->VALOR + (SD2->D2_TOTAL * CONT))
			IF SUBS(SD2->D2_COD,1,4)#'1795'
				PRODEQ->QTDE  := (PRODEQ->QTDE  + (SD2->D2_QUANT * CONT))
			ENDIF
			MsUnlock()
		ENDIF
		
		DBSELECTAREA("ARQX")
		RECLOCK("ARQX",.T.)
		ARQX->PEDIDO := SD2->D2_PEDIDO
		ARQX->VEND   := SE3->E3_VEND
		ARQX->VALOR  := SD2->D2_TOTAL
		ARQX->TITULO := MTIT
		ARQX->QTDE   := SD2->D2_QUANT
		ARQX->ITEM   := SD2->D2_ITEMPV
		ARQX->NOME   := MNOME
		MSUNLOCK()
		DBSELECTAREA("SD2")
		IncProc("Nota: "+SE3->E3_SERIE + SE3->E3_NUM)
		DBSKIP()
	END
	DBSELECTAREA("SE3")
	IncProc("Nota: "+SE3->E3_SERIE + SE3->E3_NUM)
	DBSKIP()
END

DBSELECTAREA("PRODEQ")
DBGOTOP()
WHILE !EOF()
	IncProc("Registro: " + StrZero(recno(),7))
	IF VALOR == 0 .AND. QTDE == 0
		RECLOCK("PRODEQ",.F.)
		DELE
		PRODEQ->(MSUNLOCK())
	ENDIF
	DBSKIP()
END

DBCLOSEAREA()

DBSELECTAREA("PRODVD")
DBGOTOP()
WHILE !EOF()
	IncProc("Registro: " + StrZero(recno(),7))
	IF VALOR == 0 .AND. QTDE == 0
		RECLOCK("PRODVD",.F.)
		DELE
		PRODVD->(MSUNLOCK())
	ENDIF
	DBSKIP()
END

Pack
If RecCount() > 0
	cMsg:= "Arquivo Gerado com Sucesso em: "+_cString
	COPY TO &_cString VIA "DBFCDXADS" // 20121106 
	MSGINFO(cMsg)
EndIf

DBSELECTAREA("ARQX")

COPY TO &("\SIGA\EXPORTA\ARQ_X.DBF") VIA "DBFCDXADS" // 20121106 

M_PAG   := 1
L       := 0
MQTDE   := 0
MQTDET  := 0
MSUBT   := 0
MTOTAL  := 0
MEQUIPE := ' '
MVEND   := ' '

DBSELECTAREA("PRODVD")
DBGOTOP()
ProcREGUA(RECCOUNT())
WHILE !EOF()
	IncProc("Registro: " + StrZero(recno(),7))
	IF MVEND <> ' '
		IF MVEND <> CODVEND
			@ L,42   PSAY '------'
			@ L,78   PSAY '---------'
			@ L+1,24 PSAY 'SUBTOTAL ....'
			@ L+1,37 PSAY MQTDE
			@ L+1,75 PSAY MSUBT PICTURE "@E 9,999,999.99"
			MSUBT:=0
			MQTDE:=0
			L:=L+3
			IF MEQUIPE <> EQUIPE
				@ L+1,24 PSAY 'TOTAL .......'
				@ L+1,37 PSAY MQTDET
				@ L+1,75 PSAY MTOTAL PICTURE "@E 9,999,999.99"
				MTOTAL:=0
				MQTDET:=0
				Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
				@ 08,00 PSAY "** EQUIPE: "
				@ 08,11 PSAY EQUIPE
				L:=9
			ENDIF
			@ L,00 PSAY "** VENDEDOR: "
			@ L,13 PSAY NOME
			L:=L+2
		ENDIF
	ENDIF
	
	IF L == 0 .OR. L > 59
		Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
		@ 08,00 PSAY "** EQUIPE: "
		@ 08,11 PSAY EQUIPE
		@ 10,00 PSAY "** VENDEDOR: "
		@ 10,13 PSAY NOME
		L:=12
	ENDIF
	
	@ L,00 PSAY TITULO
	@ L,41 PSAY QTDE
	@ L,77 PSAY VALOR PICTURE "@E 999,999.99"
	
	MTOTAL  := MTOTAL+VALOR
	MSUBT   := MSUBT +VALOR
	MQTDE   := MQTDE +QTDE
	MQTDET  := MQTDET+QTDE
	MEQUIPE := EQUIPE
	MVEND   := CODVEND
	IF L>59
		L := 0
		M_PAG++
	ELSE
		L:=L+1
	ENDIF
	DBSKIP()
END

@ L,42 PSAY '------'
@ L,78 PSAY '---------'
L:=L+1
@ L,24 PSAY 'SUBTOTAL ....'
@ L,37 PSAY MQTDE
@ L,75 PSAY MSUBT PICTURE "@E 9,999,999.99"
L:=L+3
@ L,24 PSAY 'TOTAL .......'
@ L,37 PSAY MQTDET
@ L,75 PSAY MTOTAL PICTURE "@E 9,999,999.99"

SET DEVICE TO SCREEN

DBCLOSEAREA()

IF aRETURN[5] ==1
	SET PRINTER TO
	DBCOMMITALL()
	OURSPOOL(WNREL)
ENDIF

MS_FLUSH()

DBSELECTAREA("SE3")
RETINDEX("SE3")

DBSELECTAREA("SD2")
RETINDEX("SD2")

DBSELECTAREA("SF4")
RETINDEX("SF4")

DBSELECTAREA("SB1")
RETINDEX("SB1")

DBSELECTAREA("SA3")
RETINDEX("SA3")

RETURN