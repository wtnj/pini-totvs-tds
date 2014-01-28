#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
#DEFINE REC_NAO_CONCILIADO 1
#DEFINE REC_CONCILIADO     2
#DEFINE PAG_NAO_CONCILIADO 3
#DEFINE PAG_CONCILIADO     4
/*
Danilo C S Pala 20070227: incluir baixa automatica no mapa    20070301 desfazer
Danilo C S Pala 20130524: executar por procedure
Danilo C S Pala 20130724: impressao novo formato
Danilo C S Pala 20130809: Imprime Total e fds? (Iolanda)
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRFIN002   บAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera mapa de fluxo de vendas                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Rfin002()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

SetPrvt("CDESC1,CDESC2,CDESC3,CSTRING,TITULO,ARETURN")
SetPrvt("NOMEPROG,ALINHA,NLASTKEY,CPERG,MSALAPL,WNREL")
SetPrvt("TAMANHO,LIMITE,NSALDOATU,NENTRADAS,NSAIDAS,NSALDOINI")
SetPrvt("CFIL,NORDSE5,ARECON,_ASTRU,_CARQUIVO,LALLFIL")
SetPrvt("CBTXT,CBCONT,LI,M_PAG,CBANCO,CNOMEBANCO")
SetPrvt("CAGENCIA,CCONTA,NLIMCRED,CABEC1,CABEC2,NTIPO")
SetPrvt("CCHAVE,CCOND,CINDEX,NINDEX,CCONDWHILE,LEND")
SetPrvt("_LSUBTRAI,CDOC,_MVALOR,L,TOTENT,TOTSAI")
SetPrvt("TOTOUT,MSUBT,MTIPON,MTIT,mhora")
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cDesc1   := OemToAnsi("Este programa ir  emitir o relatขrio di rio do fluxo")
cDesc2   := " "
cDesc3   := " "
cString  := "SE5"

titulo   := OemToAnsi("Relatorio de Fluxo Di rio")
aReturn  := { OemToAnsi("Especial"), 1,OemToAnsi("Administraฦo"), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
nomeprog := "RFIN002"
aLinha   := { }
nLastKey := 0
cPerg    := "FINR02"
Msalapl  := 0

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica as perguntas selecionadas                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
pergunte(cPerg,.T.)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                        ณ
//ณ mv_par01            // a partir de                          ณ
//ณ mv_par02            // ate                                  ณ
//ณ mv_par03            // Qual Moeda                           ณ
//ณ mv_par04            // Imprime total                        ณ
//ณ mv_par05            // Imprime final de semana              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Envia controle para a funo SETPRINT                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If MsgYesNo("Deseja executar por procedure(novo em fase teste)?")//20130524
	if AnoMes(mv_par01) == AnoMes(mv_par02)
		RF002Proc()
	Else
		MsgAlert("Este relat๓rio s๓ pode ser executado dentro do m๊s")
	Endif
Else

	MHORA      := TIME()
	wnrel := "RFIN002_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)            //Nome Default do relatorio em Disco
	WnRel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,"","",.F.)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Envia controle para a funcao REPORTINI substituir as variaveis.ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return
	Endif

	lEnd := .f.

	Processa({|lEnd| Fa470(@lEnd)},titulo, "Selecionando registros...",.t.)// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>    RptStatus({|| Execute(Fa470)},titulo)
Endif //20130524

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณ FA470IMP ณ Autor ณ Fabio/Solange         ณ Data ณ 10/06/99 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Relatขrio Diario do Fluxo                                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FA470()
tamanho   := "p"
limite    := 132
nSaldoAtu := 0
nEntradas := 0
nSaidas   := 0
nSaldoIni := 0
cFil      := ""
nOrdSE5   := SE5->(IndexOrd())
aRecon    := {}

AAdd( aRecon, {0,0,0,0} )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Prepara Area de Trabalho                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SE5")
_aStru    := DbStruct()
_cArquivo := CriaTrab(_aStru,.t.)

dbUseArea( .T.,, _cArquivo, "trb", if(.T. .OR. .F., !.F., NIL), .F. )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Limpa Naturezas                                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DBSELECTAREA("SED")
DBSETORDER(1)
DBGOTOP()
While !EOF()
	Reclock("SED",.F.)
	SED->ED_DTFLUXO := stod("")
	SED->ED_VLRMAP  := 0
	MSUnlock()
	DbSelectArea("SED")
	DBSkip()
End

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis privadas exclusivas deste programa                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
lAllFil :=.F.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cbtxt    := SPACE(10)
cbcont   := 0
//li       := 80
m_pag    := 1

nSaldoAtu:= 0
nSaldoIni:= 0

dbSelectArea("SA6")
DbGoTop()
While !eof()
	If SA6->A6_FLUXCAI <> "S"
		DbSkip()
		Loop
	Endif
	
	cBanco      := SA6->A6_COD
	cNomeBanco  := SA6->A6_NREDUZ
	cAgencia    := SA6->A6_AGENCIA
	cConta      := SA6->A6_NUMCON
	nLimCred    := SA6->A6_LIMCRED
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Saldo de Partida                                             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("SE8")
	dbSeek( xFilial("SE8")+cBanco+cAgencia+cConta+Dtos(mv_par01),.T.)
	dbSkip(-1)
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Definio dos cabealhos                                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	IF SE8->E8_BANCO # cBanco .or. SE8->E8_AGENCIA # cAgencia .or. SE8->E8_CONTA # cConta .or. BOF() .or. EOF()
	Else
		nSaldoAtu:=nSaldoAtu+xMoeda(E8_SALATUA,1,mv_par03,SE8->E8_DTSALAT,3)
		nSaldoIni:=nSaldoIni+xMoeda(E8_SALATUA,1,mv_par03,SE8->E8_DTSALAT,3)
	EndIf
	
	DbSelectarea("SA6")
	DbSkip()
End

titulo   := OemToAnsi("Relatorio de Fluxo Di rio")
Cabec1 := ""
Cabec2 := ""
nTipo  := IIF(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Filtra o arquivo por tipo e vencimento                                               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cChave  := "E5_FILIAL+DTOS(E5_DTDISPO)+E5_NATUREZ+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_RECPAG+E5_SEQ"
cCond   := 'E5_VALOR <> 0 .and. E5_SITUACA <> "C"'

dbSelectArea("SE5")

cIndex  := CriaTrab(nil,.f.)
dbSelectArea("SE5")

IndRegua("SE5",cIndex,cChave,,cCond,OemToAnsi("Selecionando Registros"))  //"Selecionando Registros..."
//nIndex   := RetIndex("SE5")
cFil       := Iif(lAllFil,"",xFilial("SE5"))

dbSeek(cFil+DtoS(mv_par01),.T.)
ProcRegua(RecCount())

If lAllFil
	cCondWhile := "!Eof() .And. SE5->E5_DTDISPO <= mv_par02"
Else
	cCondWhile := "!Eof() .And. SE5->E5_FILIAL == xFilial('SE5') .And. SE5->E5_DTDISPO <= mv_par02"
EndIf

lEnd := .f.
While &(cCondWhile)
	IF lEnd
		@PROW()+1,0 PSAY OemToAnsi("Cancelado Pelo Operador")  //"Cancelado pelo operador"
		EXIT
	End
	
	IncProc()
	
	IF E5_TIPODOC $ "DC/JR/MT/CM/D2/J2/M2/C2/V2/CP/TL"  //Valores de Baixas
		dbSkip()
		Loop
	End
	
	DbSelectArea("SA6")
	DbSeek(xFilial("SA6")+SE5->E5_BANCO+SE5->E5_AGENCIA+SE5->E5_CONTA)
	if SA6->A6_FLUXCAI <> "S"
		DbSelectArea("SE5")
		DbSkip()
		Loop
	Endif
	
	DbSelectarea("SE5")
	
	IF SE5->E5_MOEDA $ "C1/C2/C3/C4/C5" .and. Empty(SE5->E5_NUMCHEQ)
		dbSkip()
		Loop
	End
	
	IF SE5->E5_VENCTO > mv_par02 .or. SE5->E5_VENCTO > dDataBase .or. SE5->E5_VENCTO > SE5->E5_DATA
		dbSkip()
		Loop
	End
	
	If SubStr(SE5->E5_NUMCHEQ,1,1)=="*"
		dbSkip()
		Loop
	End
	
	If !Empty( SE5->E5_MOTBX )
		If !MovBcoBx( SE5->E5_MOTBX )
			dbSkip()
			Loop
		EndIf
	EndIf
	
   	IF E5_TIPODOC == "BA"      //Baixa Automatica //Erika nao deve sair no mapa! //descomentado:20070301
		dbSkip()
		Loop
	End 
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Nao deve somar o ES quando for baixa por lote       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	_lSUBTRAI := .F.
	IF E5_TIPODOC == "ES"
		cChave :=  DTOS(E5_DTDISPO)+E5_NATUREZ+E5_PREFIXO+E5_NUMERO+E5_PARCELA     //Baixa Automatica
		dbSkip()
		if cChave == DTOS(E5_DTDISPO)+E5_NATUREZ+E5_PREFIXO+E5_NUMERO+E5_PARCELA .and. ;
			E5_TIPODOC == "BA"
			_lSUBTRAI := .T.
		endif
		dbskip(-1)
	End
	
	//   Zera o controle de cancelamento de baixa por lote
	cChave := ""
	dbSelectArea("SE5")
	cDoc := SE5->E5_NUMCHEQ
	
	IF Empty( cDoc )
		cDoc := SE5->E5_DOCUMEN
	End
	
	IF Len(Alltrim(E5_DOCUMEN)) + Len(Alltrim(E5_NUMCHEQ)) <= 14
		cDoc := Alltrim(E5_DOCUMEN) + " " + Alltrim(E5_NUMCHEQ )
	End
	
	If Substr( cDoc ,1, 1 ) == "*"
		dbSkip( )
		Loop
	End
	
	_MVALOR:=SE5->E5_VALOR
	IF SE5->E5_TIPODOC=='ES' .OR. _lSubtrai
		_mvalor := _MVALOR*-1
	ENDIF
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Grava na natureza o valor correspondente                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DbSelectArea("SED")
	If DbSeek(xFilial("SED")+SE5->E5_NATUREZ)
		RECLOCK("SED",.F.)
		SED->ED_VLRMAP  :=  SED->ED_VLRMAP+ _MVALOR
		SED->ED_DTFLUXO :=  MV_PAR01
		msUnlock()
	ENDIF
	DbSelectarea("SE5")
	App()
	IF SE5->E5_RECPAG=="R" .and. !_lSubtrai
		nSaldoAtu := nSaldoAtu + xMoeda(SE5->E5_VALOR,1,mv_par03,SE5->E5_DTDISPO,3)
	Else
		nSaldoAtu := nSaldoAtu - xMoeda(E5_VALOR,1,mv_par03,SE5->E5_DTDISPO,3)
	Endif
	if _lSubtrai
		nSaldoAtu := nSaldoAtu + xMoeda(E5_VALOR,1,mv_par03,SE5->E5_DTDISPO,3) * 2
	Endif
	
	dbSelectArea("SE5")
	dbSkip()
End

IMP_MAPA()

Roda(0,"",tamanho)

DbSelectArea("SE5")
RetIndex("SE5")

Set Filter To
RetIndex("SE5")

DbSelectArea("TRB")
DbCloseArea()

If aReturn[5] == 1
	Set Printer To
	ourspool(wnrel)
End

MS_FLUSH()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณApp       บAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function app()

DbSelectArea("TRB")
RecLock("TRB",.T.)
TRB->E5_FILIAL  := SE5->E5_FILIAL
TRB->E5_DATA    := SE5->E5_DATA
TRB->E5_TIPO    := SE5->E5_TIPO
TRB->E5_MOEDA   := SE5->E5_MOEDA
TRB->E5_VALOR   := _MVALOR
TRB->E5_NATUREZ := SE5->E5_NATUREZ
TRB->E5_BANCO   := SE5->E5_BANCO
TRB->E5_AGENCIA := SE5->E5_AGENCIA
TRB->E5_CONTA   := SE5->E5_CONTA
TRB->E5_NUMCHEQ := SE5->E5_NUMCHEQ
TRB->E5_DOCUMEN := SE5->E5_DOCUMEN
TRB->E5_VENCTO  := SE5->E5_VENCTO
TRB->E5_RECPAG  := SE5->E5_RECPAG
TRB->E5_BENEF   := SE5->E5_BENEF
TRB->E5_HISTOR  := SE5->E5_HISTOR
TRB->E5_TIPODOC := SE5->E5_TIPODOC
TRB->E5_VLMOED2 := SE5->E5_VLMOED2
TRB->E5_LA      := SE5->E5_LA
TRB->E5_SITUACA := SE5->E5_SITUACA
TRB->E5_LOTE    := SE5->E5_LOTE
TRB->E5_PREFIXO := SE5->E5_PREFIXO
TRB->E5_NUMERO  := SE5->E5_NUMERO
TRB->E5_PARCELA := SE5->E5_PARCELA
TRB->E5_CLIFOR  := SE5->E5_CLIFOR
TRB->E5_LOJA    := SE5->E5_LOJA
TRB->E5_DTDIGIT := SE5->E5_DTDIGIT
TRB->E5_TIPOLAN := SE5->E5_TIPOLAN
TRB->E5_DEBITO  := SE5->E5_DEBITO
TRB->E5_CREDITO := SE5->E5_CREDITO
TRB->E5_MOTBX   := SE5->E5_MOTBX
TRB->E5_RATEIO  := SE5->E5_RATEIO
TRB->E5_RECONC  := SE5->E5_RECONC
TRB->E5_SEQ     := SE5->E5_SEQ
TRB->E5_DTDISPO := SE5->E5_DTDISPO
TRB->E5_CCD     := SE5->E5_CCD
TRB->E5_CCC     := SE5->E5_CCC
TRB->E5_OK      := SE5->E5_OK
TRB->E5_ARQRAT  := SE5->E5_ARQRAT
TRB->E5_IDENTEE := SE5->E5_IDENTEE
TRB->E5_FLSERV  := SE5->E5_FLSERV
msunlock()
return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImp_mapa()บAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION IMP_MAPA()

L := 0

DbSelectArea("SED")
DbSetOrder(4)  //  data fluxo + tipo + ordem /mp10 era 2
DbSeek(xFilial("SED")+DTOS(MV_PAR01))

TOTENT := 0
TOTSAI := 0
TOTOUT := 0
MSUBT  := PADC('** MOVIMENTO DE : ' +DTOC(MV_PAR01)+' **',74)

LI := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
LI++
@ LI,00 PSAY MSUBT
LI += 2

While !eof() .and. SED->ED_DTFLUXO <=  MV_PAR02
	If li >= 55
		Roda(0,"",tamanho)
		LI := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		LI++
		@ LI,00 PSAY MSUBT
		LI += 2
	EndIf
	
	MTIPON := SED->ED_TIPON
	
	WHILE !eof() .and. MTIPON == ED_TIPON   //20031023 eof
		IF !SED->ED_MAPSN == 'S'    
			dbselectArea("SED")//20031023
			DBSKIP()
			LOOP
		ENDIF
		
		@ Li,00 PSAY '['+SUBS(ED_CODIGO,1,4) +']   '+TRIM(ED_DESCRIC)+REPLICATE('-',(40-(LEN(TRIM(ED_DESCRIC)))))
		@ Li,57 PSAY 'R$'
		@ Li, 60 PSAY SED->ED_VLRMAP   PICTURE "@E 9,999,999,999.99"
		
		DO CASE
			CASE MTIPON == '1'
				TOTENT := TOTENT+SED->ED_VLRMAP
				MTIT   := '[A ]  ENTRADAS OPERACIONAIS'
			CASE MTIPON == '2'
				TOTSAI := TOTSAI+SED->ED_VLRMAP
				MTIT   := '[B ]  SAIDAS   OPERACIONAIS'
			CASE MTIPON == '3'
				TOTENT := TOTOUT+SED->ED_VLRMAP
		ENDCASE
		
		IF Li >= 55
			Roda(0,"",tamanho)
			LI := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
			LI++
		ELSE
			Li++
		ENDIF
		
		DbSelectArea("SED")
		DbSkip()
	End
	
	@ Li,00 PSAY REPLICATE('-',80)
	
	DO CASE
		CASE MTIPON == '1'
			@ Li+1,00 PSAY MTIT
			@ Li+1,60 PSAY TOTENT  PICTURE "@E 9,999,999,999.99"
		CASE MTIPON == '2'
			@ Li+1,00 PSAY MTIT
			@ Li+1,60 PSAY TOTSAI PICTURE "@E 9,999,999,999.99"
	ENDCASE
	@ Li+2,00 PSAY REPLICATE('-',80)
	Li += 3
END

// CALCULO DO SALDO DA APLICACAO
DBSELECTAREA("SEH")
DbSelectArea(xFilial("SEH"))

WHILE !EOF() .AND. SEH->EH_FILIAL == xFilial("SEH")
	Msalapl := Msalapl+SEH->EH_SALDO
	DBSKIP()
END

@ Li,00 PSAY '[O ]  Saldo Inicial'
@ li,57 PSAY 'R$'
@ li,60 PSAY nSaldoIni   PICTURE "@E 9,999,999,999.99"
@ Li+1,00 PSAY REPLICATE('-',80)
li += 2
@ Li,00 PSAY 'Saldo Aplicado '
@ li,57 PSAY 'R$'
@ li,60 PSAY msalapl  PICTURE "@E 9,999,999,999.99"
@ Li+1,00 PSAY REPLICATE('-',80)
li += 2
@ li,00 PSAY '[O ] Saldo Final'
@ li,57 PSAY 'R$'
@ li,60 PSAY nSaldoAtu PICTURE "@E 9,999,999,999.99"
li += 2
@ li,00 PSAY replicate('-',80)

//Roda(0,"",tamanho)
return




Static Function RF002Proc() //20130524
MHORA      := TIME()
_StringArq := "\SIGA\ARQTEMP\"+ SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2) +".DBF"
//Verifica se a Stored Procedure Teste existe no Servidor
If TCSPExist("SP_MAPAFLUXO")
	aRet := TCSPExec("SP_MAPAFLUXO", SM0->M0_CODIGO, DTOS(MV_PAR01), DTOS(MV_PAR02))
	cQuery := "SELECT * FROM TEMP_MAPA WHERE ED_VLRMAP <>0 ORDER BY ED_TIPON, ED_ORDEM"
	DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "RFIN006", .T., .F. )
	TcSetField("RFIN006","ED_MAPAFLU" ,"C",10,0)
	TcSetField("RFIN006","ED_DESCRI" ,"C",30,0)
	TcSetField("RFIN006","ED_TIPON" ,"C",1,0)
	TcSetField("RFIN006","ED_VLRMAP" ,"N",18,2)
	TcSetField("RFIN006","ED_DTFLUXO" ,"C",8,0)
	TcSetField("RFIN006","D01" ,"N",18,2)
	TcSetField("RFIN006","D02" ,"N",18,2)
	TcSetField("RFIN006","D03" ,"N",18,2)
	TcSetField("RFIN006","D04" ,"N",18,2)
	TcSetField("RFIN006","D05" ,"N",18,2)
	TcSetField("RFIN006","D06" ,"N",18,2)
	TcSetField("RFIN006","D07" ,"N",18,2)
	TcSetField("RFIN006","D08" ,"N",18,2)
	TcSetField("RFIN006","D09" ,"N",18,2)
	TcSetField("RFIN006","D10" ,"N",18,2)
	TcSetField("RFIN006","D11" ,"N",18,2)
	TcSetField("RFIN006","D12" ,"N",18,2)
	TcSetField("RFIN006","D13" ,"N",18,2)
	TcSetField("RFIN006","D14" ,"N",18,2)
	TcSetField("RFIN006","D15" ,"N",18,2)
	TcSetField("RFIN006","D16" ,"N",18,2)
	TcSetField("RFIN006","D17" ,"N",18,2)
	TcSetField("RFIN006","D18" ,"N",18,2)
	TcSetField("RFIN006","D19" ,"N",18,2)
	TcSetField("RFIN006","D20" ,"N",18,2)
	TcSetField("RFIN006","D21" ,"N",18,2)
	TcSetField("RFIN006","D22" ,"N",18,2)
	TcSetField("RFIN006","D23" ,"N",18,2)
	TcSetField("RFIN006","D24" ,"N",18,2)
	TcSetField("RFIN006","D25" ,"N",18,2)
	TcSetField("RFIN006","D26" ,"N",18,2)
	TcSetField("RFIN006","D27" ,"N",18,2)
	TcSetField("RFIN006","D28" ,"N",18,2)
	TcSetField("RFIN006","D29" ,"N",18,2)
	TcSetField("RFIN006","D30" ,"N",18,2)
	TcSetField("RFIN006","D31" ,"N",18,2)
	DbSelectArea("RFIN006")
	dbGotop()
	COPY TO &_StringArq VIA "DBFCDXADS"
	MsgInfo(_StringArq)
	RF002Imp() //20130724
	DbSelectArea("RFIN006")
	DbCloseArea()
Else
	MsgInfo("Procedure SP_MAPAFLUXO nใo encontrada!")
EndIf
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRF002Imp()บAutor  ณDanilo C S Pala     บ Data ณ  20130724   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION RF002Imp()
	Local dContDia := mv_par01
	Local nValDia := 0
	tamanho   := "p"
	limite    := 132
	Cabec1 := ""
	Cabec2 := ""
	TOTENT := 0
	TOTSAI := 0
	TOTOUT := 0
	nTipo  := IIF(aReturn[4]==1,15,18)
	MHORA      := TIME()
	wnrel := "RFIN002"
	WnRel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,"","",.F.)

	If nLastKey == 27
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Return
	Endif
	
	
	If mv_par04 = 1 //imprimeTotal 20130809
		lEnd := .f.
		L := 0
	
		MSUBT  := PADC('** MOVIMENTO DE ' +DTOC(MV_PAR01)+' ATE ' +DTOC(MV_PAR02)+'**',74)
		LI := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		LI++
		@ LI,00 PSAY MSUBT
		LI += 2

		DbSelectArea("RFIN006")
		dbGotop()
		While !eof()
			If li >= 55
				Roda(0,"",tamanho)
				LI := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				LI++
				@ LI,00 PSAY MSUBT
				LI += 2
			EndIf
	
			MTIPON := RFIN006->ED_TIPON
	
			WHILE !eof() .and. MTIPON == RFIN006->ED_TIPON
		
				@ Li,00 PSAY '['+SUBS(RFIN006->ED_MAPAFLU,1,4) +']   '+TRIM(RFIN006->ED_DESCRIC)+REPLICATE('-',(40-(LEN(TRIM(RFIN006->ED_DESCRIC)))))
				@ Li,57 PSAY 'R$'
				@ Li, 60 PSAY RFIN006->ED_VLRMAP   PICTURE "@E 9,999,999,999.99"
		
				DO CASE
					CASE MTIPON == '1'
						TOTENT := TOTENT+RFIN006->ED_VLRMAP
						MTIT   := '[A ]  ENTRADAS OPERACIONAIS'
					CASE MTIPON == '2'
						TOTSAI := TOTSAI+RFIN006->ED_VLRMAP
						MTIT   := '[B ]  SAIDAS   OPERACIONAIS'
					CASE MTIPON == '3'
						TOTENT := TOTOUT+RFIN006->ED_VLRMAP
				ENDCASE
		
				IF Li >= 55
					Roda(0,"",tamanho)
					LI := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
					LI++
				ELSE
					Li++
				ENDIF
		
				DbSelectArea("RFIN006")
				DbSkip()
			End
			@ Li,00 PSAY REPLICATE('-',80)
	
			DO CASE
			CASE MTIPON == '1'
				@ Li+1,00 PSAY MTIT
				@ Li+1,60 PSAY TOTENT  PICTURE "@E 9,999,999,999.99"
			CASE MTIPON == '2'
				@ Li+1,00 PSAY MTIT
				@ Li+1,60 PSAY TOTSAI PICTURE "@E 9,999,999,999.99"
			ENDCASE
			@ Li+2,00 PSAY REPLICATE('-',80)
			Li += 3
		END
	EndIf//imprimeTotal 20130809
	
	
	//*******************************************************************************
	//Movimento dia a dia
	if mv_par02 >= mv_par01 //if01
		if mv_par04 ==1 //20130809
			Rf002Cabec()
			@ Li,00 PSAY REPLICATE('-',80)  
			LI += 2
			MSUBT  := PADC('** MOVIMENTO DIA A DIA **',74)
			LI++
			@ LI,00 PSAY MSUBT
			LI += 2
		Endif
		dContDia :=  mv_par01
		while dContDia <= mv_par02 //while01
			TOTENT := 0
			TOTSAI := 0
			TOTOUT := 0
			
			if (Dow(dContDia) <> 1 .and. Dow(dContDia) <> 7) .or. mv_par05 <> 2  //Imprimefds 20130809
				LI := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
				LI++
				MSUBT  := PADC('** MOVIMENTO DE ' +DTOC(dContDia)+' **',74)
				LI++
				@ LI,00 PSAY MSUBT
				LI += 2
	
				DbSelectArea("RFIN006")
				dbGotop()
				WHILE !eof() //while02
					Rf002Cabec()
			
					MTIPON := RFIN006->ED_TIPON
					WHILE !eof() .and. MTIPON == RFIN006->ED_TIPON //while03
			
						If Day2Str(dContDia) == "01"
							nValDia := RFIN006->D01
						ElseIf Day2Str(dContDia) == "02"
							nValDia := RFIN006->D02
						ElseIf Day2Str(dContDia) == "03"
							nValDia := RFIN006->D03
						ElseIf Day2Str(dContDia) == "04"
							nValDia := RFIN006->D04
						ElseIf Day2Str(dContDia) == "05"
							nValDia := RFIN006->D05
						ElseIf Day2Str(dContDia) == "06"
							nValDia := RFIN006->D06
						ElseIf Day2Str(dContDia) == "07"
							nValDia := RFIN006->D07
						ElseIf Day2Str(dContDia) == "08"
							nValDia := RFIN006->D08
						ElseIf Day2Str(dContDia) == "09"
							nValDia := RFIN006->D09
						ElseIf Day2Str(dContDia) == "10"
							nValDia := RFIN006->D10
						ElseIf Day2Str(dContDia) == "11"
							nValDia := RFIN006->D11
						ElseIf Day2Str(dContDia) == "12"
							nValDia := RFIN006->D12
						ElseIf Day2Str(dContDia) == "13"
							nValDia := RFIN006->D13
						ElseIf Day2Str(dContDia) == "14"
							nValDia := RFIN006->D14
						ElseIf Day2Str(dContDia) == "15"
							nValDia := RFIN006->D15
						ElseIf Day2Str(dContDia) == "16"
							nValDia := RFIN006->D16
						ElseIf Day2Str(dContDia) == "17"
							nValDia := RFIN006->D17
						ElseIf Day2Str(dContDia) == "18"
							nValDia := RFIN006->D18
						ElseIf Day2Str(dContDia) == "19"
							nValDia := RFIN006->D19
						ElseIf Day2Str(dContDia) == "20"
							nValDia := RFIN006->D20
						ElseIf Day2Str(dContDia) == "21"
							nValDia := RFIN006->D21
						ElseIf Day2Str(dContDia) == "22"
							nValDia := RFIN006->D22
						ElseIf Day2Str(dContDia) == "23"
							nValDia := RFIN006->D23
						ElseIf Day2Str(dContDia) == "24"
							nValDia := RFIN006->D24
						ElseIf Day2Str(dContDia) == "25"
							nValDia := RFIN006->D25
						ElseIf Day2Str(dContDia) == "26"
							nValDia := RFIN006->D26
						ElseIf Day2Str(dContDia) == "27"
							nValDia := RFIN006->D27
						ElseIf Day2Str(dContDia) == "28"
							nValDia := RFIN006->D28
						ElseIf Day2Str(dContDia) == "29"
							nValDia := RFIN006->D29
						ElseIf Day2Str(dContDia) == "30"
							nValDia := RFIN006->D30
						ElseIf Day2Str(dContDia) == "31"
							nValDia := RFIN006->D31
						Endif
					
						If nValDia <> 0 //if02
							@ Li,00 PSAY '['+SUBS(RFIN006->ED_MAPAFLU,1,4) +']   '+TRIM(RFIN006->ED_DESCRIC)+REPLICATE('-',(40-(LEN(TRIM(RFIN006->ED_DESCRIC)))))
							@ Li,57 PSAY 'R$'
							@ Li, 60 PSAY nValDia   PICTURE "@E 9,999,999,999.99"
							DO CASE
								CASE MTIPON == '1'
									TOTENT := TOTENT+nValDia
									MTIT   := '[A ]  ENTRADAS OPERACIONAIS'
								CASE MTIPON == '2'
									TOTSAI := TOTSAI+nValDia
									MTIT   := '[B ]  SAIDAS   OPERACIONAIS'
								CASE MTIPON == '3'
									TOTENT := TOTOUT+nValDia
							ENDCASE
							IF Li >= 55
								Roda(0,"",tamanho)
								LI := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
								LI++
							ELSE
								Li++
							ENDIF
						Endif //if02
					
		
						DbSelectArea("RFIN006")
						DbSkip()
					End //while03
				
					@ Li,00 PSAY REPLICATE('-',80)
					DO CASE
					CASE MTIPON == '1'
						@ Li+1,00 PSAY MTIT
						@ Li+1,60 PSAY TOTENT  PICTURE "@E 9,999,999,999.99"
					CASE MTIPON == '2'
						@ Li+1,00 PSAY MTIT
						@ Li+1,60 PSAY TOTSAI PICTURE "@E 9,999,999,999.99"
					ENDCASE
					@ Li+2,00 PSAY REPLICATE('-',80)
					Li += 3
				END //while02
			
			Endif //Imprimefds 20130809
			
			dContDia := dContDia +1  
		End //while01
	
	Endif //if01
	
	If aReturn[5] == 1
		Set Printer To
		ourspool(wnrel)
	End

	MS_FLUSH()
return


Static Function Rf002Cabec()
	If li >= 55
		Roda(0,"",tamanho)
		LI := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		LI++
		@ LI,00 PSAY MSUBT
		LI += 2
	EndIf
Return