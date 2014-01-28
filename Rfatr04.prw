#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
  #DEFINE PSAY SAY
#ENDIF

User Function Rfatr04()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CPERG,CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO")
SetPrvt("ARETURN,NOMEPROG,LIMITE,ALINHA,NLASTKEY,NLIN")
SetPrvt("TITULO,CCABEC1,CCABEC2,CCANCEL,M_PAG,WNREL")
SetPrvt("CARQ,CKEY,CFILTRO,NINDEX,MREV,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>   #DEFINE PSAY SAY
#ENDIF

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATR04   ³Autor: Fabio William          ³ Data:   07/10/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: RELATORIO DE INSERCOES NAO LIBERADAS                       ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento de Publicidade                       ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³   Parametros Utilizados                   ³
//³   mv_par01 = Revista                      ³
//³   mv_par02 = Edicao                       ³
//³   mv_par03 = Secao Inicial                ³
//³   mv_par04 = Secao Final                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cPerg    := "FATR02"
IF .NOT. PERGUNTE(CPERG)
   RETURN
ENDIF

cString  := "SZS"
cDesc1   := PADC("Este programa emite o relat¢rio das",70)
cDesc2   := PADC("inser‡äes nÆo liberadas - Revista/Edi‡Æo",70)
cDesc3   := " "
tamanho  := "M"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFATR04"
limite   := 80
aLinha   := { }
nLastKey := 0

nLin     := 80
titulo   := "Inser‡äes nÆo liberadas"
cCabec1  := " "
cCabec2  := " " 
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1      //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel    := "RFATR04_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)            //Nome Default do relatorio em Disco
wnrel    := SetPrint(cString,wnrel,cPerg,space(25)+titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

SetDefault(aReturn,cString)

IF NLASTKEY==27 .OR. NLASTKEY==65
   RETURN
ENDIF

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Chama Relatorio                                ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF WINDOWS
   RptStatus({|| RptDetail() })// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>    RptStatus({|| Execute(RptDetail) })
#ELSE
   RptDetail()
#ENDIF
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
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function RptDetail
Static Function RptDetail()

DbSelectArea("SZU")
DbSetOrder(02)

DbSelectArea("SB1")
DbSetOrder(01)

DbSelectArea("SZJ")
DbSetOrder(01)

DbSelectArea("SC6")
DbSetOrder(01)

cArq     := CriaTrab(NIL,.F.)
cKey     := "ZS_NUMAV+ZS_ITEM"
DBSELECTAREA("SZS")
cFiltro  := 'ZS_FILIAL=="'+xFilial()+'".And.ZS_CODREV=="'+MV_PAR01+'"'
cFiltro  := cFiltro + '.and.STR(ZS_EDICAO,4) =="'+str(MV_PAR02,4)+'"'
cFiltro  := cFiltro + '.and.ZS_SITUAC<>"CC"'
IndRegua("SZS",cArq,cKey,,cFiltro,"Selecionando registros .. ")
nIndex:=RetIndex("SZS")
#IFNDEF TOP
        dbSetIndex(cArq+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()
SetRegua(Reccount())

Do While !eof()  .and. MV_PAR01 == SZS->ZS_CODREV .and. SZS->ZS_EDICAO == MV_PAR02

   IncRegua()
   MREV  := '01' + SUBSTR(MV_PAR01,3,2)

   IF VAL(SZS->ZS_CODMAT) <> 0
      DbSkip()
      Loop
   ENDIF
   DbSelectArea("SZU")
   DbSeek(xFilial()+SZS->ZS_CODMAT)

   DbSelectArea("SB1")
   DbSeek(xFilial()+SZS->ZS_CODPROD)

   DbSelectArea("SZJ")
   DbSeek(xFilial()+MREV)

   DbSelectArea("SC6")
   DbSeek(xFilial()+SZS->ZS_NUMAV+SZS->ZS_ITEM)

   DbSelectArea("SA1")
   DbSeek(xFilial()+SC6->C6_CLI+SC6->C6_LOJA)

   if nLin > 60
      cCabec1 := "Publicacao: " + SZS->ZS_CODREV + "  " + SZJ->ZJ_DESCR + " No. Edicao : " + STR(SZS->ZS_EDICAO,4) +;
                 "  Dt. Circ. : " + DTOC(SZS->ZS_DTCIRC)
      cCabec2 := " " 
      nLin := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18) // IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho
      nLin := nLin + 2
/*/
                      012345678901234567890123456789012345678901234567890123456789012345678901234567890
                                1         2         3         4         5         6         7         8
/*/
      @ nlin,0  PSAY "Num Av  Item  Ins/Qtde  Cliente  Nome do Cliente                           Descricao do Produto"
      nLin := nLin + 1
      @ nlin,0  PSAY "------   --   --------  -------  ----------------------------------------  ---------------------------------------"
      nLin := nLin + 1
   Endif
   nLin := nLin + 1
   @ nlin,00 PSAY SZS->ZS_NUMAV
   @ nlin,09 PSAY SZS->ZS_ITEM
   @ nlin,15 PSAY STR(SZS->ZS_NUMINS,2)+'/'+STR(SC6->C6_QTDVEN,2)
   @ nlin,24 PSAY SZS->ZS_CODCLI
   @ nlin,33 PSAY SA1->A1_NOME
   @ nlin,75 PSAY SB1->B1_DESC

   nLin := nLin + 1

   DbSelectArea("SZS")
   DbSkip()
Enddo

Roda(0,"",tamanho)

DbSelectarea("SZS")
RetIndex("SZS")
Ferase(cArq+OrdBagExt())

Set Filter To
Set Device to Screen
If aReturn[5] == 1
        Set Printer To
//        Commit
        ourspool(wnrel) //Chamada do Spool de Impressao
Endif
MS_FLUSH() //Libera fila de relatorios em spool

Return
