#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
    #DEFINE PSAY SAY
#ENDIF

User Function Rfatr03()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CPERG,CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO")
SetPrvt("ARETURN,NOMEPROG,ALINHA,NLASTKEY,NLIN,TITULO")
SetPrvt("CABEC1,CABEC2,CCANCEL,M_PAG,WNREL,_CARQ")
SetPrvt("_CKEY,_CFILTRO,_CCODMATANT,_LNOVOMAT,_CODVEIC,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     #DEFINE PSAY SAY
#ENDIF

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATR03   ³Autor: Fabio William          ³ Data:   20/01/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: ANUNCIOS - CADERNOS DE COTACOES                            ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso          : M¢dulo de Faturamento de Publicidade                   ³ ±±
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

cPerg := "FATR02"
If !Pergunte("FATR02")
   Return
Endif

cString  :="SZS"
cDesc1   := PADC("Este programa gera o relat¢rio de An£ncios - Caderno de Cota‡äes",70)
cDesc2   := " " 
cDesc3   := " "
tamanho  :="P"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog :="RFATR03"
aLinha   := { }
nLastKey := 0
nLin     :=  80
titulo   := "ANUNCIOS - CADERNO DE COTA€OES"
cabec1   := "Da Se‡ao: " + MV_PAR03 + " A " + MV_PAR04
Cabec2   := " "
//                         XXXXXX  XX  XXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
//                         12345678901234567890123456789012345678901234567890123456789012345678901234567890
//                                              1                 2             3                 4             5                 6             7                 8
cCancel := "***** CANCELADO PELO OPERADOR *****"
m_pag   := 1      //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel:="RFATR03_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,space(18)+titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

If nLastKey == 27
        Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
        Return
Endif


DbSelectArea("SZS")
_cArq     := CriaTrab(NIL,.F.)
_cKey     := "ZS_FILIAL+ZS_NUMAV+ZS_ITEM+STRZERO(ZS_NUMINS,3)"
_cFiltro  := 'ZS_FILIAL=="'+xFilial()+'".And.ZS_CODREV=="'+MV_PAR01+'"'
//_cFiltro  := _cFiltro + '.and.STR(ZS_EDICAO,4) =="'+str(MV_PAR02,4)+'"'
IndRegua("SZS",_cArq,_cKey,,_cFiltro,"Selecionando registros .. ")
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
DbSetOrder(01)

DbSelectArea("SB1")
DbSetOrder(01)

DbSelectArea("SZJ")
DbSetOrder(01)

DbSelectArea("SC6")
DbSetOrder(01)

DbSelectArea("SZW")
DbSetOrder(01)

DbSelectArea("SZS")
dbGotop()
SetRegua(Reccount())
While !eof()  .and. MV_PAR01 == SZS->ZS_CODREV
    IncRegua()

    If SZS->ZS_CODTIT < MV_PAR03 .or. SZS->ZS_CODTIT > MV_PAR04 .or.;
        MV_PAR02 #SZS->ZS_EDICAO .or. SZS->ZS_SITUAC == 'CC'
        DbSkip()
        Loop
    Endif

    If nLin > 57
        nLin := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18) //Impressao do cabecalho
        nLin := nLin + 1
    Endif

    _cCODMATANT := space(6)

    If SZS->ZS_NUMINS #1
        _lNovoMat   := .f.
        DbSkip(-1)
        _cCODMATANT := SZS->ZS_CODMAT
        DbSkip()
        if !_cCODMATANT == SZS->ZS_CODMAT
            _lNovoMat := .t.
        Endif
   Endif

   If SZS->ZS_NUMINS == 1 .or. _lNovoMat
      if SZS->ZS_NUMINS == 1
         _cCODMATANT := "  "
      endif

      _CODVEIC := '01'+SUBSTR(SZS->ZS_CODREV,3,2)

      DbSelectArea("SZU")
      DbSeek(xFilial("SZU")+SZS->ZS_CODMAT)

      DbSelectArea("SB1")
      DbSeek(xFilial("SB1")+SZS->ZS_CODPROD)

      DbSelectArea("SZJ")
      DbSeek(xFilial("SZJ")+_CODVEIC)

      DbSelectArea("SZW")
      DbSeek(xFilial("SZW")+SZS->ZS_CODTIT)

      DbSelectArea("SC6")
      DbSeek(xFilial("SC6")+SZS->ZS_NUMAV+SZS->ZS_ITEM)

      DbSelectArea("SA1")
      DbSeek(xFilial("SA1")+SC6->C6_CLI+SC6->C6_LOJA)

      @ nlin,000 PSAY "Publicacao: "+SZS->ZS_CODREV
      @ nlin,022 PSAY SZJ->ZJ_DESCR
      @ nlin,045 PSAY "No. Edicao "+STR(SZS->ZS_EDICAO,4)
      @ nlin,063 PSAY "Dt. Circ."+DTOC(SZS->ZS_DTCIRC)
      nLin := nLin + 1
      @ nlin,000 PSAY "Secao     : "+SZS->ZS_CODTIT
      @ nlin,022 PSAY SZW->ZW_DESCR
      nLin := nLin + 1
      @ nlin,000 PSAY "Anunciante: "+SC6->C6_CLI
      @ nlin,022 PSAY SA1->A1_NOME
      nLin := nLin + 1
      @ nlin,000 PSAY "Descricao : "+SC6->C6_DESCRI
      nLin := nLin + 1
      @ nlin,000 PSAY "Material  : "+SZS->ZS_CODMAT+"/"+SZU->ZU_TITULO
      @ nlin,063 PSAY "Mat. Ant. "+_cCODMATANT
      nLin := nLin + 1
      @ nlin,000 PSAY "Av/Item   : "+SZS->ZS_NUMAV+"/"+SZS->ZS_ITEM
      @ nlin,063 PSAY "Insercao  "+ StrZero(SZS->ZS_NUMINS,3)+"/"+StrZero(SC6->C6_QTDVEN,3)
      nLin := nLin + 2
      @ nlin,000 PSAY Replicate("-",80)
      nLin := nLin + 2
   Endif
   DbSelectArea("SZS")
   DbSkip()
   IncRegua()
Enddo

Roda(0,"",tamanho)

dbSelectArea("SZS")
RetIndex("SZS")
fErase(_cArq+OrdBagExt())

//Set Filter To
Set Device to Screen
If aReturn[5] == 1
    Set Printer To
//    Commit
    ourspool(wnrel) //Chamada do Spool de Impressao
Endif
MS_FLUSH() //Libera fila de relatorios em spool

Return
