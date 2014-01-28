#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
  #DEFINE PSAY SAY
#ENDIF

User Function Rfatr26()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CPERG,CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO")
SetPrvt("ARETURN,NOMEPROG,LIMITE,ALINHA,NLASTKEY,NLIN")
SetPrvt("TITULO,CCABEC1,CCABEC2,CCANCEL,M_PAG,WNREL")
SetPrvt("_CIND,_CKEY,_CFILTRO,_MTOT,_MPROD,_MQTDE")
SetPrvt("_MTOTP,_MVAL,_MNUM,_MDESCR,_MCONT,_MPERC")
SetPrvt("_MDESP,_MNOTA,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>   #DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATR26   ³Autor: Rosane Rodrigues       ³ Data:   21/02/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: RELATORIO DE VENDAS/CANCELAMENTOS                          ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³   Parametros Utilizados                   ³
//³   mv_par01 = Produto  Inicial             ³
//³   mv_par02 = Produto  Final               ³
//³   mv_par03 = Data Inicial                 ³
//³   mv_par04 = Data Final                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cPerg    := "FAT018"
If !Pergunte(CPERG)
   Return
EndIf
cString  := "SC6"
cDesc1   := PADC("Este programa emite o relat¢rio das vendas/cancelamentos",70)
cDesc2   := PADC("por produto no per¡odo solicitado.",70)
cDesc3   := " "
tamanho  := "M"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFATR26"
limite   := 80
aLinha   := { }
nLastKey := 0
nLin     := 80
titulo   := "Vendas/Cancelamentos por Produto"
cCabec1  := "Produto Inicial : " + MV_PAR01 + SPACE(04) + "Produto Final : " + MV_PAR02 + SPACE(04) +;
            "Dt. Compra Inicial : " + DTOC(MV_PAR03) + SPACE(04) + "Dt. Compra Final : " + DTOC(MV_PAR04)
cCabec2  := " " 
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1               //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel    := "RFATR26_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)       //Nome Default do relatorio em Disco
wnrel    := SetPrint(cString,wnrel,cPerg,space(20)+titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

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

dbSelectArea("SE1")
_cInd   := CriaTrab(NIL,.F.)
_cKey   := "E1_FILIAL+E1_PEDIDO+E1_NUM+E1_PARCELA"
_cFiltro := "E1_FILIAL == '"+xFilial("SE1")+"'"
_cFiltro := _cFiltro+".and.E1_SERIE<>'LIV'.AND.E1_SERIE<>'CP0'"
IndRegua("SE1",_cInd,_cKey,,_cFiltro,"Selecionando registros .. ")

dbSelectArea("SC6")
_cInd   := CriaTrab(NIL,.F.)
_cKey   := "C6_FILIAL+C6_PRODUTO+C6_NUM+DTOS(C6_DATA)"
_cFiltro := "C6_FILIAL == '"+xFilial("SC6")+"'"
_cFiltro := _cFiltro+".and.DTOS(C6_DATA)>=DTOS(CTOD('"+DTOC(MV_PAR03)+"'))"
_cFiltro := _cFiltro+".and.DTOS(C6_DATA)<=DTOS(CTOD('"+DTOC(MV_PAR04)+"'))"
IndRegua("SC6",_cInd,_cKey,,_cFiltro,"Selecionando registros .. ")

SetRegua(Reccount()/7)
dbSeek(xFilial("SC6")+MV_PAR01,.T.)

_mtot  := 0
_mProd := " "
_mQtde := 0
_mtotp := 0

While !eof() .and. sc6->c6_produto <= mv_par02
    IncRegua()

    _mval   := 0
    _mnum   := SC6->C6_NUM
    _mDescr := " "
    _mCont  := 0

    If _mProd <> SC6->C6_PRODUTO .and. _mProd <> " "
       nLin     := nLin + 2
       @ nlin,000 PSAY "Total do Produto .....................................: "
       @ nlin,056 PSAY STR(_mQtde,6)
       @ nlin,108 PSAY _mtot  PICTURE "@E 9,999,999.99"
       nLin := nLin + 2
       @ nlin,000 PSAY "Total de Pagamentos ..................................: "
       @ nlin,108 PSAY _mtotp PICTURE "@E 9,999,999.99"
       _mtot  := 0
       _mQtde := 0
       _mtotp := 0
       nLin   := 80
    Endif

    DbSelectArea("SC5")
    DbSetOrder(01)
    DbSeek(xFilial("SC5")+_mnum)
    if Found()
       _mPerc := (SC6->C6_VALOR * 100) / SC5->C5_VLRPED
       _mDesp := SC5->C5_DESPREM

       DbSelectArea("SZ9")
       DbSetOrder(01)
       DbSeek(xFilial("SZ9")+SC5->C5_TIPOOP)
       If Found()
          _mDescr := SUBSTR(SZ9->Z9_DESCR,1,19)
       Endif

       DbSelectArea("SE1")
       DbSeek(xFilial("SE1")+_mnum,.T.)
       if found() 
          Do While _mnum == SE1->E1_PEDIDO
             if nLin > 59
                nLin     := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18) //IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho
                nLin     := nLin + 2
                @ nlin,00 PSAY "Produto :  " + SC6->C6_DESCRI
                nLin     := nLin + 2
                             //           1         2         3         4         5         6         7         8         9        10        11        12        13
                             // 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
                @ nlin,00 PSAY "Pedido  Cliente  Nome do Cliente                          Qtde  Forma de Pgto        Valor Total   Duplicata  Valor Parcela  Dt.Pgto."
                nLin     := nLin + 1
                @ nlin,00 PSAY "------  -------  ---------------------------------------- ----  -------------------  ------------  ---------  -------------  --------"
                nLin     := nLin + 1                                                                  
             Endif
             nLin := nLin + 1

             _mval := SE1->E1_VALOR

             If SE1->E1_PARCELA == 'A' .OR. SE1->E1_PARCELA == ' '
                If _mCont == 0
                   @ nlin,000 PSAY SE1->E1_PEDIDO
                   @ nlin,008 PSAY SE1->E1_CLIENTE
                   dbSelectArea("SA1")
                   dbSetOrder(1)
                   dbSeek(xFilial("SA1")+SE1->E1_CLIENTE)
                   @ nlin,017 PSAY SA1->A1_NOME
                   @ nlin,058 PSAY STR(SC6->C6_QTDVEN,4)
                   @ nlin,064 PSAY _mDescr
                   @ nlin,086 PSAY SC5->C5_VLRPED * (_mPerc / 100) PICTURE "@E 99,999.99"
                   _mQtde := _mQtde + SC6->C6_QTDVEN
                   _mCont := 1
                Endif
                _mval  := SE1->E1_VALOR - _mDesp
             Endif
             @ nlin,099 PSAY SE1->E1_NUM+' '+SE1->E1_PARCELA
             @ nlin,111 PSAY _mval * (_mPerc / 100) PICTURE "@E 99,999.99"
             If YEAR(SE1->E1_BAIXA) <> 0    
                @ nlin,125 PSAY SE1->E1_BAIXA
                _mtotp := _mtotp + (_mval * (_mPerc / 100))
             Endif
             _mnota := SE1->E1_NUM
             _mtot  := _mtot + (_mval * (_mPerc / 100))
             DbSelectArea("SE1")
             DbSkip()
          Enddo
          nLin   := nLin + 1
          @ nlin,000 PSAY REPLICATE ("-",133)
          nLin   := nLin + 1
       Endif
    Endif
    _mProd := SC6->C6_PRODUTO
    DbSelectArea("SC6")
    DbSkip()
End

nLin := nLin + 2
@ nlin,000 PSAY "Total do Produto .....................................: "
@ nlin,056 PSAY STR(_mQtde,6)
@ nlin,108 PSAY _mtot  PICTURE "@E 9,999,999.99"
nLin := nLin + 2
@ nlin,000 PSAY "Total de Pagamentos ..................................: "
@ nlin,108 PSAY _mtotp PICTURE "@E 9,999,999.99"

dbSelectarea("SC6")
RetIndex("SC6")
// Apaga Indice SC6
fErase(_cInd+OrdBagExt())
dbSelectarea("SE1")
RetIndex("SE1")
dbSelectarea("SC5")
RetIndex("SC5")

Set Device to Screen
If aReturn[5] == 1
    Set Printer To
    ourspool(wnrel) //Chamada do Spool de Impressao
Endif
MS_FLUSH() //Libera fila de relatorios em spool
Return
