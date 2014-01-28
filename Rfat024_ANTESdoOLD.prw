#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFAT024   ³Autor: Solange Nalini         ³ Data:   10/02/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: IVC - RESUMO DA DISTRIBUICAO GEOGRAFICA                    ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat024()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("_CALIAS,_NINDEX,_NREG,CPERG,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CSTRING,ARETURN,LCONTINUA,WNREL")
SetPrvt("NLASTKEY,CPROGRAMA,NCARACTER,TAMANHO,MDESCR1,MDESCR2")
SetPrvt("MAMPL,MDESCR,_CNOME,_ACAMPOS,CINDEX,CCHAVE")
SetPrvt("MV_PAR01,_CFILTRO,CKEY,_CARQ,RESTO,MREVISTA")
SetPrvt("MCLIENTE,MCODDEST,MPEDIDO,MITEM,MPAGOSN,MEST")
SetPrvt("MCIDADE,MCEP,MOBS,MORDEM,MLOCGEO,MLOCAL")
SetPrvt("CABEC2,MPGA,CTITULO,CABEC1,L,NTAMANHO")
SetPrvt("TOTGER,TCAPITAL,TINTERIOR,TOUTROS,TTOTAL,M_PAG")

Local aArea := GetArea()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Cod.da Revista                       ³
//³ mv_par02             // Edicao                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:="SAN015"

lEnd := .f.

If Pergunte(cPerg)
	Processa({|lEnd| R024Proc(@lEnd)}, "IVC", "Aguarde, Processando IVC...")// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>         RptStatus({||Execute(_RunProc)}, "Processando IVC ........")
EndIf

RestArea(aArea)

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: R024Proc  ³Autor: Solange Nalini         ³ Data:   10/02/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: IVC - RESUMO DA DISTRIBUICAO GEOGRAFICA                    ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : RFAT024                                                    ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R024Proc()

Private TITULO      := '** RELATORIO DA DISTRIBUICAO GEOGRAFICA ** '
Private cDesc1      := PADC("Este programa ira gerar o Relatorio Mensal da Distribuicao ",74)
Private cDesc2      := PADC("Geografica para o IVC",74)
Private cDesc3      := ""
Private cString     := 'SC6'
Private aReturn     := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
Private lContinua   := .T.
Private wnrel       := "DIVC"
Private nLastKey    := 0
Private CPROGRAMA   := "RFAT024"
Private lAbortPrint := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

NCARACTER:=12
tamanho:="P"

DBSELECTAREA("SZJ")
DBSETORDER(1)
DBSEEK(XFILIAL("SZJ")+MV_PAR01+STR(MV_PAR02,4))

If !found()
	MsgAlert("REVISTA NAO CADASTRADA")
	return
Endif

MDESCR1 := TRIM(SZJ->ZJ_DESCR)+ALLTRIM(STR(MV_PAR02,4,0))
MDESCR2 := 'C'+MDESCR1
MAMPL   := SZJ->ZJ_REVAMPL
MDESCR  := SZJ->ZJ_DESCR

_CNOME   :="IVC"
_aCampos := {   {"ESTADO"   ,"C",2 ,  0} ,;
{"CAPITAL"  ,"N",5 ,  0} ,;
{"INTERIOR" ,"N",5 ,  0} ,;
{"OUTROS"   ,"N",5 ,  0} ,;
{"TOTAL"    ,"N",5 ,  0} ,;
{"ORDEM"    ,"N",2 ,  0} ,;
{"OBS "     ,"C",20,  0} ,;
{"PAGOSN"   ,"C",1 ,  0}}

If Select("IVC") <> 0
	DbSelectArea("IVC")
	DbCloseArea()
EndIf

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,,_cNome,"IVC",.F.,.F.)

DBSELECTAREA("IVC")
cIndex := CriaTrab(Nil,.F.)
cChave := "STR(ORDEM,2,0)+ESTADO+PAGOSN"
MsAguarde({|| Indregua("IVC",cIndex,cCHAVE,,,"AGUARDE....CRIANDO INDICE ")},"Aguarde","Gerando Indice Temporario (IVC)...")

mv_par01 :=  mv_par01 + space(11)

//DbSelectArea("SC6")
//_cFiltro := "C6_FILIAL == '" + xFilial("SC6") + "'"
//_cFiltro += " .and. C6_REGCOT == '" + MV_PAR01 + "'"
//_cFiltro += " .and. C6_EDINIC <= " + Alltrim(Str(MV_PAR02,4,0)) + " .AND. C6_EDVENC >= " + Alltrim(Str(MV_PAR02,4,0)) + " "
//CINDEX   := CRIATRAB(NIL,.F.)
//CKEY     := "C6_FILIAL+C6_REGCOT"
//MsAguarde({|| IndRegua("SC6",CINDEX,ckey,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (SC6)...")
//DBGOTOP()

if mv_par05 <> 2
	_CARQ:="\SIGAADV\ETIQUETAS\ESPECIAIS\"+trim(MDESCR2)+".DBF"
	
	If Select("CANC") <> 0
		DbSelectArea("CANC")
		DbCloseArea()
	EndIf
	
	dbUseArea(.T.,,_Carq,"CANC",.F.,.F.)
	
	DBSELECTAREA("CANC")
	
	cIndex := CRIATRAB(NIL,.F.)
	cKey   := "NUMPED+ITEM"
	MsAguarde({|| IndRegua("CANC",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (CANC)...")
endif

//ProcRegua(RecCount())

DbSelectArea("SC6")
DbGoTop()
DbSetOrder(6)
DbSeek(xFilial("SC6")+MV_PAR01,.T.)

While !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_REGCOT == MV_PAR01
	IncProc("Pedido " + SC6->C6_NUM)
	//RESTO    := MOD(MV_PAR02,2)
	//IF RESTO == 0
	//      mREVISTA := 'PAR'
	//ELSE
	//      mREVISTA := 'IMPAR'
	//ENDIF
	//If mREVISTA == 'IMPAR' .and. SC6->C6_TIPOREV == '1' .or.(MREVISTA == 'PAR' .and. SC6->C6_TIPOREV == '2')
	//      DbSkip()
	//      Loop
	//Endif
	
	// TESTE 12/06....       If SC6->C6_EDINIC > Alltrim(Str(MV_PAR02,4,0)) .or. SC6->C6_EDVENC < Alltrim(Str(MV_PAR02,4,0)) .or. SC6->C6_REGCOT <> MV_PAR01
	If SC6->C6_EDINIC > MV_PAR02 .or. SC6->C6_EDSUSP < MV_PAR02 .or. Alltrim(SC6->C6_REGCOT) <> Alltrim(MV_PAR01)
		DbSelectArea("SC6")
		DbSkip()
		Loop
	EndIf
	
	IF SUBS(SC6->C6_PRODUTO,5,3) == '001'
		DBSELECTAREA("SC6")
		DBSKIP()
		LOOP
	ENDIF
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Tratamento das ampliadas pelo parametro no SZJ - ZJ_REVAMPL             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF MAMPL == 'N' .OR. MAMPL == ' '
		IF SUBS(SC6->C6_PRODUTO,5,3) == '008' .OR. SUBS(SC6->C6_PRODUTO,5,3) == '009' ;
			.OR. SUBS(SC6->C6_PRODUTO,5,3) == '010' .OR. SUBS(SC6->C6_PRODUTO,5,3) == '011'
			DBSELECTAREA("SC6")
			DBSKIP()
			LOOP
		ENDIF
	ENDIF
	
	//RESTO := MOD(MV_PAR02,2)
	//IF RESTO == 0
	//      MREVISTA := 'PAR'
	//ELSE
	//      MREVISTA := 'IMPAR'
	//ENDIF
	
	//IF MREVISTA == 'IMPAR' .AND. SC6->C6_TIPOREV == '1' .OR. (MREVISTA == 'PAR' .AND. SC6->C6_TIPOREV == '2')
	//      DBSKIP()
	//      LOOP
	//ENDIF
	
	MCLIENTE := SC6->C6_CLI
	MCODDEST := SC6->C6_CODDEST
	MPEDIDO  := SC6->C6_NUM
	MITEM    := SC6->C6_ITEM
	
	IF MV_PAR05 <> 2
		Dbselectarea("CANC")
		If DbSeek(mpedido+mitem)
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
	ENDIF
	
	//  VERIFICA SE E GRATUITA OU PAGA
	//DBSELECTAREA("SF4")
	//DBSETORDER(1)
	//IF DBSEEK(XFILIAL("SF4")+SC6->C6_TES)
	//      IF SF4->F4_DUPLIC=='N'
	//              MPAGOSN:='G'
	//      ELSE
	//              MPAGOSN:='P'
	//      ENDIF
	//ENDIF
	
	DbSelectArea("SC6")
	IF SC6->C6_TES $ "650/651/654/701"
		MPAGOSN := 'G'
	ELSE
		MPAGOSN := 'P'
	ENDIF
	
	DBSELECTAREA("SA1")
	DbsetOrder(1)
	DBSEEK(XFILIAL("SA1")+MCLIENTE)
	
	MEST      := SA1->A1_EST
	MCIDADE   := SA1->A1_MUN
	MCEP      := SA1->A1_CEP
	IF MCODDEST # ' '
		DBSELECTAREA("SZO")
		IF DBSEEK(XFILIAL("SZO")+MCLIENTE+MCODDEST)
			MEST    := SZO->ZO_ESTADO
			MCIDADE := SZO->ZO_CIDADE
			MCEP    := SZO->ZO_CEP
		ENDIF
	ENDIF
	//A ROTINA ABAIXO PROCURA NO ARQ DE CEP LOCAL GEOGR (C-CAPITAL,I-INTERIOR) E
	//*A ORDEM DE IMPRESSAO NO RELATORIO PARA O IVC.   HABILITAR APOS A CRIA€AO DE
	//*CAMPOS.
	//
	//** TIRAR QUANDO HABILITAR O SZ0
	//*/
	
	MOBS   := ' '
	mordem := 0
	MLOCAL:=' '
	
	/*
	DBSELECTAREA("SZ0")
	DBSETORDER(1)
	IF DBSEEK(XFILIAL("SZ0")+MCEP)
	MLOCAL := SZ0->Z0_LOCGEO
	MORDEM := Alltrim(STR(SZ0->Z0_ORDEM))
	MOBS   := ' '
	ELSE
	MLOCAL := ' '
	MORDEM := ' '
	MOBS   := 'S/CEP-PED.:'+SC6->C6_NUM+'/'+SC6->C6_ITEM
	ENDIF
	*/
	
	// QUANDO HABILITAR A ROTINA ACIMA, DESPREZAR A ABAIXO
	
	If ALLTRIM(MCIDADE) == 'PORTO VELHO' .AND. MEST == 'RO'
		MLOCAL:='C'
		MORDEM:=5
	ElseIf  ALLTRIM(MCIDADE) # 'PORTO VELHO' .AND. MEST == 'RO'
		MLOCAL:='I'
		MORDEM:=5
	ElseIf ALLTRIM(MCIDADE) == 'BOA VISTA' .AND. MEST == 'RR'
		MLOCAL:='C'
		MORDEM:= 6
	ElseIf ALLTRIM(MCIDADE) # 'BOA VISTA' .AND. MEST == 'RR'
		MLOCAL:='I'
		MORDEM:= 6
	ElseIf ALLTRIM(MCIDADE) == 'BELEM' .AND. MEST == 'PA'
		MLOCAL:='C'
		MORDEM:= 4
	ElseIf ALLTRIM(MCIDADE)#'BELEM' .AND. MEST=='PA'
		MLOCAL:='I'
		MORDEM:= 4
	ElseIf ALLTRIM(MCIDADE)=='ARACAJU' .AND. MEST=='SE'
		MLOCAL:='C'
		MORDEM:= 16
	ElseIf ALLTRIM(MCIDADE)#'ARACAJU' .AND. MEST=='SE'
		MLOCAL:='I'
		MORDEM:= 16
	ElseIf ALLTRIM(MCIDADE)=='MACAPA' .AND. MEST=='AP'
		MLOCAL:='C'
		MORDEM:=2
	ElseIf ALLTRIM(MCIDADE)#'MACAPA' .AND. MEST=='AP'
		MLOCAL:='I'
		MORDEM:= 2
	ELseIf ALLTRIM(MCIDADE)=='SAO PAULO' .AND. MEST=='SP'
		MLOCAL:='C'
		MORDEM:= 20
	ElseIf ALLTRIM(MCIDADE)#'SAO PAULO' .AND. MEST=='SP'
		MLOCAL:='I'
		MORDEM:= 20
	ElseIf ALLTRIM(MCIDADE)=='VITORIA' .AND. MEST=='ES'
		MLOCAL:='C'
		MORDEM:= 17
	ElseIf ALLTRIM(MCIDADE)#'VITORIA' .AND. MEST=='ES'
		MLOCAL:='I'
		MORDEM:= 17
	ElseIf ALLTRIM(MCIDADE) $('TERESINA/TEREZINA/TEREZINHA') .AND. MEST=='PI'
		MLOCAL:='C'
		MORDEM:=14
	ElseIf ALLTRIM(MCIDADE) # 'TERESINA' .and.  ALLTRIM(MCIDADE)#'TEREZINA' .and. ALLTRIM(MCIDADE) #'TEREZINHA' .AND. MEST=='PI'
		MLOCAL:='I'
		MORDEM:= 14
	ElseIf ALLTRIM(MCIDADE) $ ('SAO LUIS/SAO LUIZ') .AND. MEST=='MA'
		MLOCAL:='C'
		MORDEM:= 11
	ElseIf ALLTRIM(MCIDADE) #'SAO LUIS' .and. ALLTRIM(MCIDADE)#'SAO LUIZ' .AND. MEST=='MA'
		MLOCAL:='I'
		MORDEM:= 11
	ElseIf ALLTRIM(MCIDADE)=='RIO BRANCO' .AND. MEST=='AC'
		MORDEM:=1
		MLOCAL:='C'
	ElseIf ALLTRIM(MCIDADE)#'RIO BRANCO' .AND. MEST=='AC'
		MLOCAL:='I'
		MORDEM:=1
	ElseIf ALLTRIM(MCIDADE)=='NATAL' .AND. MEST=='RN'
		MLOCAL:='C'
		MORDEM:= 15
	ElseIf ALLTRIM(MCIDADE)#'NATAL' .AND. MEST=='RN'
		MLOCAL:='I'
		MORDEM:= 15
	ElseIf ALLTRIM(MCIDADE)=='FORTALEZA' .AND. MEST=='CE'
		MLOCAL:='C'
		MORDEM:= 9
	ElseIf ALLTRIM(MCIDADE)#'FORTALEZA' .AND. MEST=='CE'
		MLOCAL:='I'
		MORDEM:= 9
	ElseIf ALLTRIM(MCIDADE)=='MACEIO' .AND. MEST=='AL'
		MLOCAL:='C'
		MORDEM:= 7
	ElseIf ALLTRIM(MCIDADE)#'MACEIO' .AND. MEST=='AL'
		MLOCAL:='I'
		MORDEM:= 7
	ElseIf ALLTRIM(MCIDADE)=='MANAUS' .AND. MEST=='AM'
		MLOCAL:='C'
		MORDEM:= 3
	ElseIf ALLTRIM(MCIDADE)#'MANAUS' .AND. MEST=='AM'
		MLOCAL:='I'
		MORDEM:= 3
	ElseIf ALLTRIM(MCIDADE)=='RECIFE' .AND. MEST=='PE'
		MLOCAL:='C'
		MORDEM:= 13
	ElseIf ALLTRIM(MCIDADE)#'RECIFE' .AND. MEST=='PE'
		MLOCAL:='I'
		MORDEM:= 13
	ElseIf ALLTRIM(MCIDADE)=='SALVADOR' .AND. MEST=='BA'
		MLOCAL:='C'
		MORDEM:= 8
	ElseIf ALLTRIM(MCIDADE)#'SALVADOR' .AND. MEST=='BA'
		MLOCAL:='I'
		MORDEM:= 8
	ElseIf ALLTRIM(MCIDADE)=='JOAO PESSOA' .AND. MEST=='PB'
		MLOCAL:='C'
		MORDEM:= 12
	ElseIf ALLTRIM(MCIDADE)#'JOAO PESSOA' .AND. MEST=='PB'
		MLOCAL:='I'
		MORDEM:= 12
	ElseIf MEST=='EX'
		MLOCAL:='O'
		MORDEM:= 29
	ElseIf ALLTRIM(MCIDADE)=='BELO HORIZONTE' .AND. MEST=='MG'
		MLOCAL:='C'
		MORDEM:= 18
	ElseIf ALLTRIM(MCIDADE)#'BELO HORIZONTE' .AND. MEST=='MG'
		MLOCAL:='I'
		MORDEM:=  18
	ElseIf ALLTRIM(MCIDADE)=='RIO DE JANEIRO' .AND. MEST=='RJ'
		MLOCAL:='C'
		MORDEM:= 19
	ElseIf ALLTRIM(MCIDADE)#'RIO DE JANEIRO' .AND. MEST=='RJ'
		MLOCAL:='I'
		MORDEM:= 19
	ElseIf ALLTRIM(MCIDADE)=='PALMAS' .AND. MEST=='TO'
		MLOCAL:='C'
		MORDEM:=28
	ElseIf ALLTRIM(MCIDADE)#'PALMAS' .AND. MEST=='TO'
		MLOCAL:='I'
		MORDEM:= 28
	ElseIf ALLTRIM(MCIDADE)=='GOIANIA' .AND. MEST=='GO'
		MLOCAL:='C'
		MORDEM:= 25
	ElseIf ALLTRIM(MCIDADE)#'GOIANIA' .AND. MEST=='GO'
		MLOCAL:='I'
		MORDEM:= 25
	ElseIf ALLTRIM(MCIDADE)=='CAMPO GRANDE' .AND. MEST=='MS'
		MLOCAL:='C'
		MORDEM:= 27
	ElseIf ALLTRIM(MCIDADE)#'CAMPO GRANDE' .AND. MEST=='MS'
		MLOCAL:='I'
		MORDEM:=  27
	ElseIf ALLTRIM(MCIDADE)=='CUIABA' .AND. MEST=='MT'
		MLOCAL:='C'
		MORDEM:= 26
	ElseIf ALLTRIM(MCIDADE)#'CUIABA' .AND. MEST=='MT'
		MLOCAL:='I'
		MORDEM:= 26
	ElseIf ALLTRIM(MCIDADE)=='BRASILIA' .AND. MEST=='DF'
		MLOCAL:='C'
		MORDEM:= 24
	ElseIf ALLTRIM(MCIDADE)#'BRASILIA' .AND. MEST=='DF'
		MLOCAL:='I'
		MORDEM:= 24
	ElseIf ALLTRIM(MCIDADE)=='PORTO ALEGRE' .AND. MEST=='RS'
		MLOCAL:='C'
		MORDEM:= 23
	ElseIf ALLTRIM(MCIDADE)#'PORTO ALEGRE' .AND. MEST=='RS'
		MLOCAL:='I'
		MORDEM:= 23
	ElseIf ALLTRIM(MCIDADE)=='FLORIANOPOLIS' .AND. MEST=='SC'
		MLOCAL:='C'
		MORDEM:= 22
	ElseIf ALLTRIM(MCIDADE)#'FLORIANOPOLIS' .AND. MEST=='SC'
		MLOCAL:='I'
		MORDEM:= 22
	ElseIf ALLTRIM(MCIDADE)=='CURITIBA' .AND. MEST=='PR'
		MLOCAL:='C'
		MORDEM:=21
	ElseIf ALLTRIM(MCIDADE)#'CURITIBA' .AND. MEST=='PR'
		MLOCAL:='I'
		MORDEM:= 21
	EndIf
	If Empty(MLOCAL)  .OR. Empty(MORDEM)
		MOBS:=SC6->C6_NUM
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  GRAVA ARQUIVO TEMPORARIO                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	GRAVA_TEMP()
	DBSELECTAREA("SC6")
	DBSKIP()
END

CABEC2 := 'PAGOS'
MPGA   := 'P'
IMPRIME()
CABEC2 := 'GRATUITOS'
MPGA   := 'G'
IMPRIME()

DBSELECTAREA("IVC")
COPY TO &("IVCTEMP.DBF")
DBCLOSEAREA()

DbSelectArea("SC6")
Retindex("SC6")

DbSelectArea("SA1")
Retindex("SA1")

IF MV_PAR05 <> 2
	DbSelectArea("CANC")
	DbCloseArea()
ENDIF

Set Device To Screen

If aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
EndIf

Ms_Flush()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GRAVA_TEMPºAutor  ³Microsiga           º Data ³  03/26/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION GRAVA_TEMP()  

IF SA1->A1_ATIVIDA >= MV_PAR06 .AND. SA1->A1_ATIVIDA <= MV_PAR07
	
	DBSELECTAREA("IVC")
	DBSEEK(STR(MORDEM,2,0)+MEST+MPAGOSN)
	IF !FOUND()
		Reclock("IVC",.t.)
		replace ORDEM  WITH MORDEM
		do case
			case mlocal=='C'
				replace CAPITAL WITH 1
			CASE MLOCAL=='I'
				replace INTERIOR WITH 1
			CASE MLOCAL=='O'
				replace OUTROS WITH 1
		ENDCASE
		replace OBS    WITH MOBS
		replace TOTAL  WITH 1
		replace ESTADO WITH MEST
		replace PAGOSN WITH MPAGOSN
		MsUnlock()
	ELSE
		Reclock("IVC",.F.)
		do case
			case mlocal == 'C'
				replace CAPITAL  WITH CAPITAL+1
			CASE MLOCAL == 'I'
				replace INTERIOR WITH INTERIOR+1
			CASE MLOCAL == 'O'
				replace OUTROS   WITH OUTROS+1
		ENDCASE
		replace TOTAL  WITH TOTAL+1
		If ! Empty(MOBS)
			replace OBS    WITH ALLTRIM(OBS)+'/'+MOBS
		Endif
		MsUnlock()
	ENDIF
ENDIF

RETURN
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IMPRIME   ºAutor  ³Microsiga           º Data ³  03/26/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION IMPRIME()

CTITULO  := '** DISTRIBUICAO GEOGRAFICA - IVC **'
CABEC1   := 'REVISTA: '+TRIM(MDESCR)+ ' - EDICAO: '+ TRIM(STR(MV_PAR02,4,0))+' - ASSINANTES '+CABEC2
CABEC2   := ' '
l        := 0
NTAMANHO := 'P'

If nLastKey == 27
	Return
Endif

DBSELECTAREA("IVC")
DBGOTOP()
//TOTGER  := 0
TCAPITAL  := 0
TINTERIOR := 0
TOUTROS   := 0
TTOTAL    := 0
M_PAG     := 1

WHILE !EOF()
	IF MPGA # PAGOSN
		DBSKIP()
		LOOP
	ENDIF
	IF L <> 0
		IF L == 64     //.OR. L+10>=64
			L := 0
		ELSE
			L++
		ENDIF
	ENDIF
	
	IF L == 0
		L++
		CABEC(cTitulo,Cabec1,Cabec2,cPrograma,Ntamanho,nCaracter)
		L := 8
		@ L,30 PSAY 'CAPITAL'
		@ L,43 PSAY 'INTERIOR'
		@ L,53 PSAY 'OUTROS'
		@ L,63 PSAY 'TOTAL'
		@ L,73 PSAY 'OBS'
		L:=L+2
	ENDIF
	
	@ L,02 PSAY 'ASSINANTES DO ESTADO ->'+ESTADO
	@ L,29 PSAY CAPITAL
	@ L,42 PSAY INTERIOR
	@ L,51 PSAY OUTROS
	@ L,62 PSAY TOTAL
	@ L,73 PSAY OBS
	TCAPITAL  := TCAPITAL+CAPITAL
	TINTERIOR := TINTERIOR+INTERIOR
	TOUTROS   := TOUTROS+OUTROS
	TTOTAL    := TTOTAL+TOTAL
	DBSKIP()
END
@ L+1,29 PSAY STR(TCAPITAL,5,0)
@ L+1,42 PSAY STR(TINTERIOR,5,0)
@ L+1,51 PSAY STR(TOUTROS,5,0)
@ L+1,62 PSAY STR(TTOTAL,5,0)
@ L+1,73 PSAY '  '

RETURN
