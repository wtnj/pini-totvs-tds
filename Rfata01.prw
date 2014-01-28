#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Rfata01()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CPROGLIB,LGRADE,AHEADGRADE,ACOLSGRADE,AHEADAUX,ACOLSAUX")
SetPrvt("AALTGR,CMASCARA,NTAMREF,NTAMLIN,NTAMCOL,CPRODREF")
SetPrvt("LLIBER,LARREDONDA,LALTEROU,LMONTA,LQTDVEN,NAUX")
SetPrvt("AAC,NPOSATU,NPOSANT,NTOTREGS,NPOSCNT,NOPCA")
SetPrvt("LMTA410T,ALOCAL,LTRANSF,LSUGERE,_CFILTRO,_CARQUIVO")
SetPrvt("_CKEY,_NREG,NIND,_NOPC,")


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATA01   ³Autor: Fabio William          ³ Data:   11/08/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Faz a Liberacao de Pedidos avaliando credito e estoque     ³ ±±
±±³utiliza o No. Lote e Data do Lote.                                    ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define variaveis que serao utilizadas internamente ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


cProgLib  := "MATA440"
lGrade    := GetMv("MV_GRADE")
aHeadGrade:={}
aColsGrade:={}
aHeadAux  :={}
aColsAux  :={}
aAltGr    :={}
cMascara  :=GetMv("MV_MASCGRD")
nTamRef   :=Val(Substr(cMascara,1,2))
nTamLin   :=Val(Substr(cMascara,4,2))
nTamCol   :=Val(Substr(cMascara,7,2))
cProdRef  :=""
lLiber    := .F.
lArredonda := IIf(GetMV("MV_ARREFAT") == "S",.T.,.F.)
lAlterou  :=.F.
lMonta    :=.T.
lQtdVen   :=.T.
nAux      :=0
aAC       := { "Abandona","Confirma" }
nPosAtu   :=0
nPosAnt   :=0
nTotRegs  :=0
nPosCnt   :=0
nOpca     :=0
lMta410T  := .T.
aLocal    :={}


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionada                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("MTA440",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Transfere locais para a liberacao                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lTransf   :=IIF(mv_par01==1,.T.,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera Parcial pedidos de vendas                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lLiber    :=IIF(mv_par02==1,.T.,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Sugere quantidade liberada                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lSugere   :=IIF(mv_par03==1,.T.,.F.)



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ mv_par01 Ordem Processmento ?  Ped.+Item /Dt.Entrega+Ped.+Item³
//³ mv_par02 Pedido de          ?                                 ³
//³ mv_par03 Pedido ate         ?                                 ³
//³ mv_par04 Cliente de         ?                                 ³
//³ mv_par05 Cliente ate        ?                                 ³
//³ mv_par06 Dta Entrega de     ?                                 ³
//³ mv_par07 Dta Entrega ate    ?                                 ³
//³ mv_par08 Lote de                                              ³
//³ mv_par09 Lote Ate                                             ³
//³ mv_par10 Data Lote de                                         ³
//³ mv_par11 Data Lote Ate                                        ³
//³ mv_par12 Pedido da Publicidade                                ³
//³ mv_par13 Data Liberacao                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

ScreenDraw("SMT251",10, 2, -1, 1)
SetColor("w/n")
@ 10,21 Say PADC("Libera‡„o Autom tica",34)
SetColor("b/bg")
@ 12,09 Say "      Este programa tem como objetivo gerar automaticamente"
@ 13,09 Say "as libera‡”es de pedidos, tomando-se como base o cr‚dito do"
@ 14,09 Say "cliente e a existˆncia dos produtos em estoque e a data de "
@ 15,09 Say "entrega do item do pedido."
nOpcA:=menuh(aAC,17,09,"b/bg,w+/n,r/bg","AC","Quanto a Libera‡„o? ",1)
If nOpcA == 1 .Or. LastKey() == 27
   Return
Endif
Pergunte("MTALIB",.T.)
		
If MV_PAR01 == 2
   dbSelectArea("SC6")
   dbSetOrder(3)
   DbSeek(xFilial("SC6"))
Else
   dbSelectArea("SC6")
   dbSetOrder(1)
   DbSeek(xFilial("SC6"))
Endif
_cFiltro  := ''
_cFiltro  := _cFiltro+'C6_FILIAL>="'+xFilial("SC6")+'"'
_cFiltro  := _cFiltro+'.AND.C6_NUM>="'+MV_PAR02+'".AND.C6_NUM<="'+MV_PAR03+'"'
_cFiltro  := _cFiltro+'.AND.C6_CLI>="'+MV_PAR04+'".AND.C6_CLI<= "'+MV_PAR05+'"'
//_cFiltro  := _cFiltro+'.AND.DTOS(C6_ENTREG)>="'+DTOS(MV_PAR06)+'".AND.DTOS(C6_ENTREG)<="'+DTOS(MV_PAR07)+'"'
_cfiltro  := _cFiltro+".and.C6_LOTEFAT >='"+mv_par08+"'.AND.C6_LOTEFAT<='"+mv_par09+"'"
_cfiltro  := _cFiltro+".and.Dtos(C6_DATA)>='"+Dtos(mv_par10)+"'.AND.Dtos(C6_DATA)<='"+Dtos(mv_par11)+"'"
_cArquivo := CriaTrab(nil,.f.)
_cKey     := IndexKey()
IndRegua("SC6",_cArquivo,_cKey,,_cFiltro,"Selecionando Registros")
_nReg     := Recno()
nInd      := RetIndex("SC6")
dbSetIndex(_cArquivo+OrdBagExt())
dbSetOrder(nInd+1)
// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Forcado a gravada da data de entrega p/ Liberacao dos pedidos  ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


DbGoTo(_nReg)
Do While !eof()
   IF EMPTY(SC6->C6_ENTREG)
      RecLock("SC6",.F.)
      SC6->C6_ENTREG := SC6->C6_DATA  // Grava a Data do Lote
      msunlock()
   ENDIF
   dbskip()
Enddo

DbGoTo(_nReg)
_nOpc := 1
a440Proces("SC6",_nReg,_nopc)

RetIndex("SC6")
Ferase(_cArquivo+OrdBagExt())
dbSetOrder(01)
DbGoTop()
