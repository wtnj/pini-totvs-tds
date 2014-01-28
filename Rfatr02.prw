#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa : RFATR02  ³Autor: Fabio William          ³ Data:  12/01/00  ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Relatorio de Programa‡Æo de An£ncios                       ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfatr02()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CPERG,CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO")
SetPrvt("ARETURN,NOMEPROG,ALINHA,NLASTKEY,NLIN,TITULO")
SetPrvt("CABEC1,CABEC2,CCANCEL,M_PAG,WNREL,CARQ")
SetPrvt("CKEY,CFILTRO,mhora")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³   Parametros Utilizados                   ³
//³   mv_par01 = Revista                      ³
//³   mv_par02 = Edicao                       ³
//³   mv_par03 = Secao Inicial                ³
//³   mv_par04 = Secao Final                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg    := "FATR02"
If !pergunte(cperg)
   Return
Endif

cString  := "SZS"
cDesc1   := PADC("Emite o relat¢rio de programa‡Æo de an£ncios da se‡Æo indeterminadas",70)
cDesc2   := " "
cDesc3   := ""
tamanho  := "M"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFATR02"
aLinha   := { }
nLastKey := 0
nLin     := 80
titulo   := oemtoansi("Programa‡Æo de An£ncios - Indeterminadas")
Cabec1   := "Revista : " + MV_PAR01 + "  Edicao : " + STR(MV_PAR02,4)
cabec2   := "Cliente Nome do Cliente                Num Av Item Descricao do Produto               C.Mat. Titulo               Observacao"
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1      //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel    := "RFATR02_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)            //Nome Default do relatorio em Disco
wnrel    := SetPrint(cString,wnrel,cPerg,space(17)+titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

SetDefault(aReturn,cString)

If nLastKey == 27 .or. nlastkey == 65
   Return
Endif

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Chama Relatorio                                ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lEnd := .f.
Processa({|lEnd| RptDetail(@lEnd) }, "Aguarde", "Selecionando Registros...",.t.)// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>    RptStatus({|| Execute(RptDetail) })

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³RptDetail ³ Autor ³ Ary Medeiros          ³ Data ³ 15.02.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Impressao do corpo do relatorio                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RptDetail()

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Cria o arquivo temporario                      ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cArq     := CriaTrab(NIL,.F.)
cKey     := "ZS_FILIAL+ZS_CODREV+Str(ZS_EDICAO)" //"ZS_FILIAL+ZS_NUMAV+ZS_ITEM"
DBSELECTAREA("SZS")
//cFiltro  := 'ZS_FILIAL=="'+xFilial()+'".And.ZS_CODREV=="'+MV_PAR01+'"'
//cFiltro  := cFiltro + '.and.STR(ZS_EDICAO,4) =="'+str(MV_PAR02,4)+'".And.ZS_CODTIT=="999"'
IndRegua("SZS",cArq,cKey,,,"Selecionando registros .. ") // IndRegua("SZS",cArq,cKey,,cFiltro,"Selecionando registros .. ")
DbSetOrder(1)

ProcRegua(Reccount())
DbGotop()

DbSeek(xFilial("SZS")+MV_PAR01+Str(MV_PAR02,4))

nLin := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18) //IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho

While !eof() .and. SZS->ZS_FILIAL == xFilial("SZS") .and. Alltrim(SZS->ZS_CODREV) == Alltrim(MV_PAR01) .and. Str(SZS->ZS_EDICAO,4) == Str(MV_PAR02,4) .and. !lEnd

   If Val(SZS->ZS_CODMAT) == 0 .or. SZS->ZS_SITUAC == 'CC' .or. STR(SZS->ZS_EDICAO,4) <> Str(MV_PAR02,4) .or. ;
   			SZS->ZS_CODTIT <> "999"
      dbskip()
      loop
   endif

   IncProc("Lendo AV: "+SZS->ZS_NUMAV)
   
   If nLin >= 55
      Roda(0,"",tamanho)
      nLin := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18) //IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho
      nLin += 2
   Endif

   DbSelectArea("SC6")
   dbsetorder(01)
   DbSeek(xFilial()+SZS->ZS_NUMAV+SZS->ZS_ITEM)

   DbSelectArea("SA1")
   DbSeek(xFilial()+SC6->C6_CLI+SC6->C6_LOJA)

   DbSelectArea("SZU")
   DBSETORDER(01)
   DbSeek(xFilial("SZU")+SC6->C6_CLI+SZS->ZS_CODMAT)

   DbSelectArea("SB1")
   DbSeek(xFilial()+SZS->ZS_CODPROD)

   nLin++ // nLin += 2
   @ nLin,000 PSAY SC6->C6_CLI
   @ nLin,008 PSAY SUBST(SA1->A1_NOME,1,30)
   @ nlin,039 PSAY SZS->ZS_NUMAV 
   @ nlin,046 PSAY SZS->ZS_ITEM  
   @ nlin,051 PSAY SUBSTR(SB1->B1_DESC,1,34)
   @ nlin,086 PSAY SZS->ZS_CODMAT
   @ nlin,093 PSAY SZU->ZU_TITULO
   @ nlin,114 PSAY SZU->ZU_OBS

   DbSelectArea("SZS")
   DbSkip()
End

If lEnd
	@ nLin,000 PSAY "*******INTERROMPIDO PELO USUARIO********"
	MsgStop("Interrompido pelo Usuario!","Processamento Interrompido")
EndIf

DbSelectarea("SZS")
RetIndex("SZS")
Ferase(cArq+OrdBagExt())

Roda(0,"",tamanho)

Set Filter To
Set Device to Screen
If aReturn[5] == 1
        Set Printer To
        Commit
        ourspool(wnrel) //Chamada do Spool de Impressao
Endif

MS_FLUSH() //Libera fila de relatorios em spool

Return