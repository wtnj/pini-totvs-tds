#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
  #DEFINE PSAY SAY
#ENDIF

User Function Rfatr31()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CPERG,CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO")
SetPrvt("ARETURN,NOMEPROG,LIMITE,ALINHA,NLASTKEY,NLIN")
SetPrvt("TITULO,CCABEC1,CCABEC2,CCANCEL,M_PAG,WNREL")
SetPrvt("_ACAMPOS,_CNEWARQ,_CKEY,_CIND,_CFILTRO,_MTOT")
SetPrvt("_MPROD,_MQTDE,_MTOTP,_MVAL,_MNUM,_MDESCR")
SetPrvt("_MDESCP,_MCONT,_MVALOR,_MQTDEP,_MPRODUT,_MOTIVO")
SetPrvt("_MPERC,_MDESP,_MDESCRP,")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>   #DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATR31   ³Autor: Rosane Rodrigues       ³ Data:   14/04/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: RELATORIO DE VENDAS POR GRUPO DE PRODUTO                   ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento de Publicidade                       ³ ±±
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
cDesc1   := PADC("Este programa emite o relat¢rio das vendas ",70)
cDesc2   := PADC("por grupo de produto no per¡odo solicitado.",70)
cDesc3   := PADC("Obs: os pedidos com S‚rie CP0 e LIV nÆo aparecem no relat¢rio",70)
tamanho  := "M"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFATR31"
limite   := 80
aLinha   := { }
nLastKey := 0
nLin     := 80
titulo   := "Vendas por Grupo de Produto"
cCabec1  := "Produto Inicial : " + MV_PAR01 + SPACE(04) + "Produto Final : " + MV_PAR02 + SPACE(04) +;
            "Dt. Compra Inicial : " + DTOC(MV_PAR03) + SPACE(04) + "Dt. Compra Final : " + DTOC(MV_PAR04)
cCabec2  := " "
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1               //Variavel que acumula numero da pagina
wnrel    := "RFATR31"       //Nome Default do relatorio em Disco
wnrel    := SetPrint(cString,wnrel,cPerg,space(19)+titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

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


// Inclusao para dados do SigaEis
_aCampos := {}
aAdd( _aCampos, {"PRODUTO", "C", 20, 0 })
aAdd( _aCampos, {"QUANT",   "N", 10, 0 })
aAdd( _aCampos, {"VALOR",   "N", 17, 2 })
aAdd( _aCampos, {"PAGTO",   "D", 08, 0 })

_cNewArq:= CriaTrab(_aCampos, .T.)
dbUseArea( .T., , _cNewArq, "TRB", .F., .F. )
_cKey   := "PRODUTO+DTOS(PAGTO)"
IndRegua( "TRB", _cNewArq, _cKey ,,, "Selecionando registros .. ")


dbSelectArea("SE5")
_cInd    := CriaTrab(NIL,.F.)
_cKey    := "E5_FILIAL+E5_NUMERO+E5_PARCELA"
IndRegua("SE5",_cInd,_cKey,,,"Selecionando registros .. ")

dbSelectArea("SE1")
_cInd   := CriaTrab(NIL,.F.)
_cKey   := "E1_FILIAL+E1_PEDIDO+E1_NUM+E1_PARCELA"
_cFiltro := "E1_FILIAL == '"+xFilial("SE1")+"'"
_cFiltro := _cFiltro+".and.E1_SERIE<>'LIV'.AND.E1_SERIE<>'CP0'"
IndRegua("SE1",_cInd,_cKey,,_cFiltro,"Selecionando registros .. ")

dbSelectArea("SC6")
_cInd   := CriaTrab(NIL,.F.)
IF SUBS(MV_PAR01,1,2)=='15'
   _cKey   := "C6_FILIAL+SUBSTR(C6_PRODUTO,1,8)+C6_NUM+DTOS(C6_DATA)"
ELSE
   _cKey   := "C6_FILIAL+SUBSTR(C6_PRODUTO,1,2)+C6_NUM+DTOS(C6_DATA)"
ENDIF
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

While !eof() .and. substr(sc6->c6_produto,1,2) <= substr(mv_par02,1,2)

    // IF SC6->C6_PRODUTO#MV_PAR
    IncRegua()

    _mval   := 0
    _mnum   := SC6->C6_NUM
    _mDescr := " "
    _mDescp := " "
    _mCont  := 0
    _mvalor := 0
    _mqtdep := 0
    _mprod  := SUBSTR(SC6->C6_PRODUTO,1,2)
    _mprodut:= SUBSTR(SC6->C6_PRODUTO,1,2)+'00000'
    _motivo := " "

    Do while SC6->C6_NUM == _mnum .and. _mprod == SUBSTR(SC6->C6_PRODUTO,1,2)
       _mvalor := _mvalor + SC6->C6_VALOR
       _mqtdep := _mqtdep + SC6->C6_QTDVEN
       dbskip()
    Enddo

    DbSelectArea("SC5")
    DbSetOrder(01)
    DbSeek(xFilial("SC5")+_mnum)
    if Found()
       _mPerc := (_mvalor * 100) / SC5->C5_VLRPED
       _mDesp := SC5->C5_DESPREM

       DbSelectArea("SZ9")
       DbSetOrder(01)
       DbSeek(xFilial("SZ9")+SC5->C5_TIPOOP)
       If Found()
          _mDescr := SUBSTR(SZ9->Z9_DESCR,1,19)
       Endif

       DbSelectArea("SB1")
       DbSeek(xFilial("SB1")+_mprodut)
       if found()
          _mdescrp := SB1->B1_DESC
       endif

       DbSelectArea("SE1")
       DbSeek(xFilial("SE1")+_mnum,.T.)
       if found()
          Do While _mnum == SE1->E1_PEDIDO
             IF 'LUCROS E PERDAS' $(SE1->E1_HIST)
                _motivo := "L&P"
             ENDIF
             IF 'NF CANCELA' $(SE1->E1_HIST) .OR. 'CAN' $(SE1->E1_MOTIVO)
                _motivo := "NF CANC"
             ENDIF
             DbSelectArea("SE5")
             DbSeek(xFilial("SE5")+SE1->E1_NUM+SE1->E1_PARCELA)
             If Found()
                IF 'CAN' $(E5_MOTBX)
                    _motivo := "NF CANC"
                Endif
             Endif

             if nLin > 59
                nLin     := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18) //IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho
                nLin     := nLin + 2
                @ nlin,00 PSAY "Produto :  " + _mprod + " " + _mdescrp
                nLin     := nLin + 2
                             //           1         2         3         4         5         6         7         8         9        10        11        12        13
                             // 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

                @ nlin,00 PSAY "Pedido  Cliente  Nome do Cliente                          Qtde  Forma de Pgto        Valor Total   Duplicata  Valor Parcela  Dt.Pgto."
                nLin     := nLin + 1
                @ nlin,00 PSAY "------  -------  ---------------------------------------- ----  -------------------  ------------  ---------  -------------  --------"
                nLin     := nLin + 1
             Endif
             nLin := nLin + 1

             _mval := SE1->E1_VALOR

             If _mCont == 0
                @ nlin,000 PSAY SE1->E1_PEDIDO
                @ nlin,008 PSAY SC6->C6_CLI
                dbSelectArea("SA1")
                dbSetOrder(1)
                dbSeek(xFilial("SA1")+SC6->C6_CLI)
                @ nlin,017 PSAY SA1->A1_NOME
                @ nlin,058 PSAY STR(_mqtdep,4)
                @ nlin,064 PSAY _mDescr
                @ nlin,086 PSAY SC5->C5_VLRPED * (_mPerc / 100) PICTURE "@E 99,999.99"
                _mQtde := _mQtde + _mqtdep
                _mCont := 1


             Endif
             If SE1->E1_PARCELA == 'A' .OR. SE1->E1_PARCELA == ' '
                _mval  := SE1->E1_VALOR - _mDesp

                // Incluido para uso do SigaEis
                dbSelectArea("TRB")
                If dbSeek( _mDescrP+Dtos(SE1->E1_BAIXA), .F.)
                    RecLock("TRB", .F.)
                    TRB->VALOR   := TRB->VALOR + ( SE1->E1_VALOR - SE1->E1_SALDO )
                    TRB->QUANT   := TRB->QUANT + _mQtdeP
                    msUnlock()
                Else
                    RecLock("TRB", .T.)
                    TRB->PRODUTO := _mDescrP
                    TRB->QUANT   := _mQtdeP
                    TRB->VALOR   := ( SE1->E1_VALOR - SE1->E1_SALDO )
                    TRB->PAGTO   := SE1->E1_BAIXA
                    msUnlock()
                EndIf


             Else

                // Incluido para uso do SigaEis
                dbSelectArea("TRB")
                If dbSeek( _mDescrP+Dtos(SE1->E1_BAIXA), .F.)
                    RecLock("TRB", .F.)
                    TRB->VALOR   := TRB->VALOR + ( SE1->E1_VALOR - SE1->E1_SALDO )
                    msUnlock()
                Else
                    RecLock("TRB", .T.)
                    TRB->PRODUTO := _mDescrP
                    // TRB->QUANT   := _mQtdeP
                    TRB->VALOR   := ( SE1->E1_VALOR - SE1->E1_SALDO )
                    TRB->PAGTO   := SE1->E1_BAIXA
                    msUnlock()
                EndIf

             Endif

             @ nlin,099 PSAY SE1->E1_NUM+' '+SE1->E1_PARCELA
             @ nlin,111 PSAY _mval * (_mPerc / 100) PICTURE "@E 99,999.99"
             If _motivo #" "
                if _motivo == "L&P"
                   @ nlin,125 PSAY _motivo
                   _mtot  := _mtot + (_mval * (_mPerc / 100))
                else
                   @ nlin,125 PSAY _motivo
                endif
             else
                If YEAR(SE1->E1_BAIXA) <> 0
                   @ nlin,125 PSAY SE1->E1_BAIXA
                   _mtotp := _mtotp + (_mval * (_mPerc / 100))
                Endif
                _mtot  := _mtot + (_mval * (_mPerc / 100))
             Endif
             _motivo := " "

             DbSelectArea("SE1")
             DbSkip()
          Enddo
       Endif
    Endif
    If _mProd <> substr(SC6->C6_PRODUTO,1,2) .and. _mProd <> " "
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
    DbSelectArea("SC6")
End

if _mqtde #0 .or. _mtot # 0 .or. _mtotp # 0
   nLin := nLin + 2
   @ nlin,000 PSAY "Total do Produto .....................................: "
   @ nlin,056 PSAY STR(_mQtde,6)
   @ nlin,108 PSAY _mtot  PICTURE "@E 9,999,999.99"
   nLin := nLin + 2
   @ nlin,000 PSAY "Total de Pagamentos ..................................: "
   @ nlin,108 PSAY _mtotp PICTURE "@E 9,999,999.99"
   Eject
endif


dbSelectArea("TRB")
Copy to I:\SIGA\SIGAADV\EXPORTA\RFATR31
dbCloseArea()
fErase(_cNewArq+".DBF")
fErase(_cNewArq+OrdBagExt())

dbSelectarea("SC6")
RetIndex("SC6")
// Apaga Indice SC6
fErase(_cInd+OrdBagExt())
dbSelectarea("SE1")
RetIndex("SE1")
dbSelectarea("SC5")
RetIndex("SC5")
dbSelectarea("SE5")
RetIndex("SE5")

Set Device to Screen
If aReturn[5] == 1
    Set Printer To
    ourspool(wnrel) //Chamada do Spool de Impressao
Endif
MS_FLUSH() //Libera fila de relatorios em spool
Return
