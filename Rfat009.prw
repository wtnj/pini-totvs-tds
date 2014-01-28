#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: ABPORT    ³Autor: Rosane Lacava Rodrigues³ Data:   15/07/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de Pendencias por Portador - Venda Mercantil/P.S ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Financeiro                                       ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat009()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CDESC1")
SetPrvt("CDESC2,CDESC3,CTITULO,CCABEC1,CCABEC2,CPROGRAMA")
SetPrvt("CTAMANHO,LIMITE,NCARACTER,NLASTKEY,ARETURN,_ACAMPOS")
SetPrvt("_CNOME,CINDEX,CKEY,WNREL,CSTRING,_CFILTRO")
SetPrvt("MVALOR,MNUM,MPARCELA,MPREFIXO,MPEDIDO,MVENCTO")
SetPrvt("MTIPO,MVENDA,MCODPORT,MCONTA,M_PAG,L")
SetPrvt("MSUBT,MPORT,DATA,mhora")

cSavAlias  := Select()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //Da data:          ³
//³ mv_par02             //Ate a data:       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG      := 'MTR957'
IF !PERGUNTE(CPERG)
	RETURN
ENDIF

_aCampos := {{"CODPORT" ,"C",3	, 0} ,;
			 {"VENDA"   ,"C",1	, 0} ,;
			 {"VENCTO"  ,"C",8	, 0} ,;
			 {"CONTA"   ,"C",10	, 0} ,;
			 {"NUM"     ,"C",6	, 0} ,;
			 {"PARCELA" ,"C",1	, 0} ,;
			 {"PREFIXO" ,"C",3	, 0} ,;
			 {"PEDIDO"  ,"C",6	, 0} ,;
			 {"VALOR"   ,"N",10	, 2}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"ABPORT",.F.,.F.)
CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="CODPORT+CONTA+VENDA+VENCTO"
INDREGUA("ABPORT",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")
DbSetOrder(1)

CDESC1    := PADC("Este programa emite relatorio por portador, dos titulos",70)
CDESC2    := PADC("em aberto e vencimentos no periodo solicitado",70)
CDESC3    := " "
cTitulo   := "* RELATORIO DE VENCIMENTOS / PORTADOR * PERIODO: "+DTOC(MV_PAR01)+" A "+DTOC(MV_PAR02)+" *"
cCabec1   := "DATA VENCTO                                          VALOR"
cCabec2   := " "
cPrograma := "ABPORT"
cTamanho  := "M"
LIMITE    := 132
nCaracter := 12
NLASTKEY  := 0
aRETURN   := {"Especial", 1,"Administracao", 1, 2, 1," ",1 }
MHORA := TIME()
WNREL     := "ABPORT_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING   := "ABPORT"
WNREL     := SETPRINT(CSTRING,WNREL,CPERG,cTitulo,CDESC1,CDESC2,CDESC3,.F.)
SETDEFAULT(aRETURN,CSTRING)

IF NLASTKEY==27 .OR. NLASTKEY==65
	DBCLOSEAREA()
	RETURN
ENDIF

lEnd := .f.

Processa({|lEnd| RptDetail(@lEnd)},"Aguarde","Selecionando Registros...",.t.)// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        RptStatus({|| Execute(RptDetail)})

Return

Static Function RptDetail()

DBSELECTAREA("SE1")
//_cFiltro := "E1_FILIAL == '"+xFilial("SE1")+"'"
//_cFiltro += "EMPTY(E1_BAIXA) .and. EMPTY(E1_PGPROG)"  // " .and. DTOS(E1_BAIXA)   == DTOS(CTOD(' ')) .and. DTOS(E1_PGPROG) == DTOS(CTOD(' '))"
//_cFiltro += " .and. DTOS(E1_VENCREA) >= DTOS(CTOD('"+DTOC(MV_PAR01)+"'))"
//_cFiltro += " .and. DTOS(E1_VENCREA) <= DTOS(CTOD('"+DTOC(MV_PAR02)+"'))"
//CINDEX := CRIATRAB(NIL,.F.)
//CKEY   := "E1_FILIAL+DTOS(E1_VENCREA)" // "E1_FILIAL+DTOS(E1_BAIXA)"
//INDREGUA("SE1",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")
DbSetOrder(7)
DBSEEK(XFILIAL("SE1")+DTOS(MV_PAR01),.T.) // DBSEEK(XFILIAL("SE1")+DTOS(E1_BAIXA),.T.)   // Soft Seek on (.T.)
ProcRegua(RECCOUNT())
//WHILE !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. DTOS(E1_VENCREA) >= DTOS(CTOD(DTOC(MV_PAR01))) .and. DTOS(E1_VENCREA) <= DTOS(CTOD(DTOC(MV_PAR02)))
WHILE !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. DTOS(E1_VENCREA) <= DTOS(MV_PAR02) .and. !lEnd	
	IncProc("Lendo Titulo "+Alltrim(SE1->E1_PREFIXO+SE1->E1_NUM))
	If "CAN" $(SE1->E1_MOTIVO) .OR. "DEV" $(SE1->E1_MOTIVO) .OR. "CANC" $(SE1->E1_HIST) .or. !Empty(SE1->E1_BAIXA) .or. !Empty(SE1->E1_PGPROG)
		DbSelectArea("SE1")
		dbSkip()
		Loop
	EndIf
	
	MVALOR   := SE1->E1_VALOR
	MNUM     := SE1->E1_NUM
	MPARCELA := SE1->E1_PARCELA
	MPREFIXO := SE1->E1_PREFIXO
	MPEDIDO  := SE1->E1_PEDIDO
	MVENCTO  := DTOS(CTOD(DTOC(SE1->E1_VENCREA)))
	MTIPO    := ' '
	MVENDA   := ' '
	
	IF "P" $(SE1->E1_PEDIDO)
		MCODPORT := SE1->E1_PORTADO
		MCONTA   := SE1->E1_CONTA
		MVENDA   := 'P'
	ELSE
		IF SM0->M0_CODIGO == '02'
			MCODPORT := SE1->E1_PORTADO
			MCONTA   := SE1->E1_CONTA
		ELSE
			MCODPORT := SE1->E1_PORTADO
			MCONTA   := SE1->E1_CONTA
		ENDIF
		MVENDA   := 'V'
	ENDIF
	
	DBSELECTAREA("ABPORT")
	If !DBSEEK(MCODPORT+MCONTA+MVENDA+MVENCTO)
		DbSelectArea("ABPORT")
		RECLOCK("ABPORT",.T.)
		ABPORT->CODPORT := MCODPORT
		ABPORT->NUM     := MNUM
		ABPORT->PARCELA := MPARCELA
		ABPORT->PREFIXO := MPREFIXO
		ABPORT->PEDIDO  := MPEDIDO
		ABPORT->CONTA   := MCONTA
		ABPORT->VALOR   := MVALOR
		ABPORT->VENCTO  := MVENCTO
		ABPORT->VENDA   := MVENDA
		MsUnlock()
	ELSE
		DbSelectArea("ABPORT")
		RECLOCK("ABPORT",.F.)
		ABPORT->VALOR := (MVALOR + ABPORT->VALOR)
		MsUnlock()
	ENDIF
	
	DBSELECTAREA("SE1")
	DBSKIP()
END

Processa({|| R09Proc()})

@ L,48 PSAY '----------'
L++
@ L,33 PSAY 'TOTAL .......'
@ L,46 PSAY MSUBT PICTURE "@E 9,999,999.99"
COPY TO RO.DBF VIA "DBFCDXADS" // 20121106 
SET DEVICE TO SCREEN
DBCLOSEAREA()

IF aRETURN[5] ==1
	SET PRINTER TO
	DBCOMMITALL()
	OURSPOOL(WNREL)
ENDIF

MS_FLUSH()

DBSELECTAREA("SE1")
RETINDEX("SE1")

RETURN

Static Function R09Proc()

M_PAG := 1
L     := 0
MSUBT := 0
MPORT := 'ZZZZZ'

DBSELECTAREA("ABPORT")
DbSetOrder(1)
DBGOTOP()

ProcRegua(RECCOUNT())

WHILE !EOF()
	IncProc("Lendo Portador/Titulo... "+Alltrim(MCODPORT+"/"+MPREFIXO+MNUM+MPARCELA))
	IF MPORT <> 'ZZZZZ'
		IF MPORT <> CODPORT+CONTA+VENDA
			@ L,48   PSAY '----------'
			@ L+1,33 PSAY 'TOTAL .......'
			@ L+1,46 PSAY MSUBT PICTURE "@E 9,999,999.99"
			MSUBT :=0
			L:=60
		ENDIF
	ENDIF
	
	IF L == 0 .OR. L > 59
		IF VENDA == 'P'
			MVENDA := 'PUBLICIDADE'
		ELSE
			MVENDA := 'VENDA MERCANTIL'
		ENDIF
		L := Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
		@ 8,00 PSAY "** PORTADOR: "
		@ 8,13 PSAY CODPORT + ' / ' + CONTA+'/'+ MVENDA
		L := 10
	ENDIF
	
	DATA := SUBSTR(VENCTO,7,2)+"/"+SUBSTR(VENCTO,5,2)+"/"+SUBSTR(VENCTO,1,4)
	@ L,00 PSAY DATA
	@ L,48 PSAY VALOR PICTURE "@E 999,999.99"
	
	MSUBT := MSUBT+VALOR
	MPORT := CODPORT+CONTA+VENDA
	
	IF L > 59
		L := 0
		M_PAG++
	ELSE
		L++
	ENDIF
	DbSelectArea("ABPORT")
	DBSKIP()
END

Return