#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
  #DEFINE PSAY SAY
#ENDIF

User Function Rfatr09()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CPERG,CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO")
SetPrvt("ARETURN,NOMEPROG,ALINHA,NLASTKEY,NLIN,TITULO")
SetPrvt("CABEC1,CABEC2,CCANCEL,M_PAG,WNREL,_TBRUTO")
SetPrvt("_TLIQ,_CARQ,_CKEY,_CFILTRO,NINDEX,_CODVEIC")
SetPrvt("_MLIQ,_MQTDE,DTCIRCI,_CTPTRANS,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>   #DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa : RFATR09  ³Autor: Mauricio Mendes        ³ Data:  18/09/01  ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Relatorio de Programa‡Æo de An£ncios por Revista / Edi‡Æo  ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³   Parametros Utilizados                   ³
//³   mv_par01 = Revista                      ³
//³   mv_par02 = Edicao Inicial               ³
//³   mv_par03 = Edicao Final                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cPerg    := "PFAT52"
If .not. pergunte(cperg)
   Return
Endif

cString  := "SZS"
cDesc1   := PADC("Emite o relat¢rio de programa‡Æo de an£ncios por Revista / Edi‡Æo",70)
cDesc2   := " "
cDesc3   := " "
tamanho  := "M"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFATR09"
aLinha   := { }
nLastKey := 0
nLin     := 80
titulo   := oemtoansi("Programa‡Æo de An£ncios - Revista / Edi‡Æo")
Cabec1   := " "
cabec2   := "Se‡ Num AV/It  Ins/Qtd  Cod    Nome do Cliente            Descri‡Æo do Produto    Vl.Ins.Br. Vl.Ins.Liq TpTrans    Vend.   Ativo"
//cabec2   := "Se‡ Descri‡Æo            Num AV/It  Ins/Qtd  Nome do Cliente            Descri‡Æo do Produto    Vl.Ins.Br. Vl.Ins.Liq Vend    N.Fisc"
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1      //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel    := "RFATR09_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)            //Nome Default do relatorio em Disco
wnrel    := SetPrint(cString,wnrel,cPerg,space(15)+titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)
_Tbruto  := 0
_Tliq    := 0

SetDefault(aReturn,cString)



If nLastKey == 27 .or. nlastkey == 65
   Return
Endif

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Cria o arquivo temporario                      ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_cArq    := CriaTrab(NIL,.F.)
_cKey    := "ZS_CODTIT+STR(ZS_EDICAO,4)+ZS_NUMAV+ZS_ITEM"
DBSELECTAREA("SZS")
_cFiltro := 'ZS_FILIAL=="'+xFilial()+'".And.ZS_CODREV=="'+MV_PAR01+'"'
_cFiltro := _cFiltro + '.and.STR(ZS_EDICAO,4) >="'+str(MV_PAR02,4)+'".And.STR(ZS_EDICAO,4) <="'+str(MV_PAR03,4)+'"'
_cFiltro := _cFiltro + '.and.ZS_SITUAC <> "CC"'

IndRegua("SZS",_cArq,_cKey,,_cFiltro,"Selecionando registros .. ")
nIndex:=RetIndex("SZS")
#IFNDEF TOP
        dbSetIndex(_cArq+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()

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

SetRegua(Reccount()/3)
Do While !eof()

   if val(szs->zs_codmat) == 0
      dbskip()
      loop
   endif

   _CODVEIC := '01'+SUBSTR(SZS->ZS_CODREV,3,2)
   _mliq    := SZS->ZS_VALOR
   _mqtde   := 0

   DbSelectArea("SC5")
   DbSetOrder(01)
   DbSeek(xFilial("SC5")+SZS->ZS_NUMAV)

   DbSelectArea("SC6")
   DbSetOrder(01)
   DbSeek(xFilial("SC6")+SZS->ZS_NUMAV+SZS->ZS_ITEM)
   _mqtde := SC6->C6_QTDVEN

   DbSelectArea("SZJ")
   DbSetOrder(01)
   DbSeek(xFilial("SZJ")+_CODVEIC+STR(MV_PAR02,4))
   dtcirci  := SZJ->ZJ_DTCIRC

   DbSelectArea("SZJ")
   DbSetOrder(01)
   DbSeek(xFilial("SZJ")+_CODVEIC+STR(MV_PAR03,4))

   nLin := nLin + 2
   if nLin > 57
      Cabec1 := "Revista: "+MV_PAR01+" "+SZJ->ZJ_DESCR+"    Edicao Inicial: "+STR(MV_PAR02,4)+"  Dt.Circ.: "+DTOC(DTCIRCI)+"    Edicao Final: "+STR(MV_PAR03,4)+"  Dt.Circ.: "+DTOC(SZJ->ZJ_DTCIRC)
      nLin   := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18) //IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho
      nLin   := nLin + 2
   endif

   DbSelectArea("SA1")
   DbSeek(xFilial()+SC6->C6_CLI+SC6->C6_LOJA)

   DbSelectArea("SZW")
   DBSETORDER(01)
   DbSeek(xFilial("SZW")+SZS->ZS_CODTIT)

   DbSelectArea("SB1")
   DbSeek(xFilial("SB1")+SZS->ZS_CODPROD)

   if VAL(Sc5->c5_tptrans) == 4 .or. VAL(sc5->c5_tptrans) == 5
      _mliq := (SZS->ZS_VALOR - (SZS->ZS_VALOR * 0.20))
   Endif

/*/
   @ nLin,000 PSAY SZS->ZS_CODTIT
   @ nLin,004 PSAY SUBSTR(SZW->ZW_DESCR,1,20)
   @ nlin,025 PSAY SZS->ZS_NUMAV+'/'+SZS->ZS_ITEM
   @ nlin,037 PSAY str(SZS->ZS_NUMINS,2)+'/'+str(_mqtde,2)
   @ nLin,045 PSAY SUBST(SA1->A1_NOME,1,30)
   @ nlin,077 PSAY SUBST(SB1->B1_DESC,1,25)
   @ nlin,103 PSAY SZS->ZS_VALOR PICTURE "@E 999,999.99"
   @ nlin,114 PSAY _mliq PICTURE "@E 999,999.99"
   @ nlin,126 PSAY SZS->ZS_VEND                   
/*/

// alterado em 20/06/00 By RC
/*/
   @ nLin,000 PSAY SZS->ZS_CODTIT
   @ nLin,004 PSAY SUBSTR(SZW->ZW_DESCR,1,20)
   @ nlin,025 PSAY SZS->ZS_NUMAV+'/'+SZS->ZS_ITEM
   @ nlin,037 PSAY str(SZS->ZS_NUMINS,2)+'/'+str(_mqtde,2)
   @ nLin,045 PSAY SUBST(SA1->A1_NOME,1,25)
   @ nlin,072 PSAY SUBST(SB1->B1_DESC,1,23)
   @ nlin,096 PSAY SZS->ZS_VALOR PICTURE "@E 999,999.99"
   @ nlin,107 PSAY _mliq PICTURE "@E 999,999.99"
/*/
//
   @ nLin,000 PSAY SZS->ZS_CODTIT
   @ nlin,005 PSAY SZS->ZS_NUMAV+'/'+SZS->ZS_ITEM
   @ nlin,017 PSAY str(SZS->ZS_NUMINS,2)+'/'+str(_mqtde,2)
   @ nlin,024 PSAY SA1->A1_COD
   @ nLin,031 PSAY SUBST(SA1->A1_NOME,1,25)
   @ nlin,058 PSAY SUBST(SB1->B1_DESC,1,23)
   @ nlin,082 PSAY SZS->ZS_VALOR PICTURE "@E 999,999.99"
   @ nlin,093 PSAY _mliq PICTURE "@E 999,999.99"

//   @ nlin,119 PSAY SZS->ZS_VEND
// Alterado em 06/07/00 By RC
   If Empty(SZS->ZS_NFISCAL)
        If SZS->ZS_TPTRANS == "02"
            _cTpTrans := "PERMUT"
        ElseIf SZS->ZS_TPTRANS == "03"
            _cTpTrans := "BONIFI"
        ElseIf SZS->ZS_TPTRANS $ "11/12/13"
            _cTpTrans := "PARCEL"
        ElseIf SZS->ZS_TPTRANS == "04"
            _cTpTrans := "FAT.AG"
        ElseIf SZS->ZS_TPTRANS == "08"
            _cTpTrans := "COOPER"
        Else
            _cTpTrans := SZS->ZS_TPTRANS
        EndIf
   Else
        _cTpTrans := SZS->ZS_TPTRANS
   EndIf
   // Alterado Mauricio 19/09/01
//   @ nlin,119 PSAY _cTpTrans
   @ nlin,105 PSAY SC5->C5_TPTRANS

   //Impressao Adicionada por Mauricio 19/09/01
   @ nlin,115 PSAY SZS->ZS_VEND
   @ nlin,124 PSAY SZS->ZS_SITUAC

   _Tbruto := _Tbruto + SZS->ZS_VALOR
   _Tliq   := _Tliq + _mliq
   
   DbSelectArea("SZS")
   DbSkip() 
Enddo

If _Tbruto == 0
   Cabec1 := "Revista: "+MV_PAR01+" "+SZJ->ZJ_DESCR+"    Edicao Inicial: "+STR(MV_PAR02,4)+"  Dt.Circ.: "+DTOC(DTCIRCI)+"    Edicao Final: "+STR(MV_PAR03,4)+"  Dt.Circ.: "+DTOC(SZJ->ZJ_DTCIRC)
   nLin   := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18) //IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho
else
   nLin := nLin + 3
   @ nlin,000 PSAY "TOTAL GERAL .................................................:"
   @ nlin,080 PSAY _Tbruto PICTURE "@E 9,999,999.99"
   @ nlin,094 PSAY _Tliq   PICTURE "@E 9,999,999.99"
Endif

DbSelectarea("SZS")
RetIndex("SZS")
Ferase(_cArq+OrdBagExt())

//Roda(0,"",tamanho)
Set Filter To
Set Device to Screen
If aReturn[5] == 1
        Set Printer To
        Commit
        ourspool(wnrel) //Chamada do Spool de Impressao
Endif
MS_FLUSH() //Libera fila de relatorios em spool
Return



