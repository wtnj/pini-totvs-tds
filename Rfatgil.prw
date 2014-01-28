#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
  #DEFINE PSAY SAY
#ENDIF

User Function Rfatgil()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CPERG,_X,_CMSG,CSTRING,CDESC1,CDESC2")
SetPrvt("CDESC3,TAMANHO,ARETURN,NOMEPROG,LIMITE,ALINHA")
SetPrvt("NLASTKEY,NLIN,TITULO,CCABEC1,CCABEC2,CCANCEL")
SetPrvt("M_PAG,WNREL,_APRODS,_ACAMPOS,MV_PAR05,_CNOMEARQ")
SetPrvt("_CARQIDX,_CIND,_CKEY,_CFILTRO,NINDEX,_MTOT")
SetPrvt("_MPROD,_MQTDE,_MTOTP,_MVAL,_MNUM,_MDESCR")
SetPrvt("_MCONT,_MOTIVO,_NREGATU,_NVALOR,_CPRODUTO,_NI")
SetPrvt("_CSUPORTE,_MPERC,_MDESP,_CDESCR,AREGS,I")
SetPrvt("J,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>   #DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATR35   ³Autor: Rosane Rodrigues       ³ Data:   21/04/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: RELATORIO DE VENDAS                                        ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Alteracoes³ Gilberto - 05.11.2000 : Totalizacao por Grupo.            ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³   Parametros Utilizados                   ³
//³   mv_par01 = Prd. Inicial                 ³
//³   mv_par02 = Prd. Final                   ³
//³   mv_par03 = Data Inicial                 ³
//³   mv_par04 = Data Final                   ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cPerg    := "RFAT35"
ValidPerg()
If !Pergunte(cPerg)
   Return
EndIf

/*/
For _X:= 1 to Len(Alltrim(MV_PAR05))

    If AT(Subs(Alltrim(mv_par05),_x,1) , _cCarProi ) #0

       Alert( STR(AT( Subs(Alltrim(mv_par05),_x,1) , _cCarProi )) )

       _cMsg:= "O Caracter "+Subs(Alltrim(mv_par05),_x,1)+"e um caractere proibido para o nome do arquivo !! Verifique ..."
       #IFNDEF WINDOWS
          Alert( _cMsg )
       #ELSE
          MsgStop( _cMsg )
       #ENDIF

       Return

    EndIf

Next
/*/

cString  := "SC6"
cDesc1   := PADC("Este programa emite o relat¢rio das vendas",70)
cDesc2   := PADC("por faixa de grupo de produto no per¡odo solicitado",70)
cDesc3   := PADC("Obs: os pedidos com S‚rie CP0 e LIV nÆo aparecem no relat¢rio",70)
tamanho  := "M"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFATR35"
limite   := 80
aLinha   := { }
nLastKey := 0
nLin     := 80
titulo   := "Vendas por Faixa de Grupo de Produto"
cCabec1  := "Produto Inicial : " + MV_PAR01 + SPACE(04) + "Produto Final : " + MV_PAR02 + SPACE(04) +;
            "Dt. Compra Inicial : " + DTOC(MV_PAR03) + SPACE(04) + "Dt. Compra Final : " + DTOC(MV_PAR04)
cCabec2  := " "
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1               //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel    := "RFATR35_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)       //Nome Default do relatorio em Disco
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

*****************************************************************************

If AllTrim(MV_PAR05) #"."
   _aProds:= {}
   _aCampos := {}
   aAdd(_aCampos, { "PRODUTO" ,"C", 40, 0 })
   aAdd(_aCampos, { "PEDIDO"  ,"C", 06, 0 })
   aAdd(_aCampos, { "CLIENTE" ,"C", 06, 0 })
   aAdd(_aCampos, { "NOME"    ,"C", 40, 0 })
   aAdd(_aCampos, { "QUANT"   ,"N", 06, 0 })
   aAdd(_aCampos, { "PAGAMENT","C", 20, 0 })
   aAdd(_aCampos, { "VALTOTAL","N", 12, 2 })
   aAdd(_aCampos, { "DUPLICAT","C", 15, 0 })
   aAdd(_aCampos, { "VALPARC" ,"N", 12, 2 })
   aAdd(_aCampos, { "DTPAGTO" ,"C", 08, 0 })

   MV_PAR05:= IIF( EMPTY(MV_PAR05) , "VE"+STR(DAY(dDataBase))+STR(MONTH(dDataBase))+SUBS(TIME(),7,2) , MV_PAR05 )
   _cNomeArq:= ALLTRIM(MV_PAR05)+".XLS"   /// "VENDAS.XLS"
   _cArqIdx:= CriaTrab(NIL,.F.)

   // DbCreate("VENDAS.XLS",_aCampos)
   DbCreate(_cNomeArq,_aCampos)
   DbUseArea(.T.,,_cNomeArq,"TRB",.f.,.f.)
   IndRegua("TRB",_cArqIdx, "PEDIDO+CLIENTE",,,"Indexando Arq.Trabalho...")

EndIf

*****************************************************************************

DbSelectArea("SE5")

_cInd := CriaTrab(NIL,.F.)
_cKey := "E5_FILIAL+E5_NUMERO+E5_PARCELA"
IndRegua("SE5",_cInd,_cKey,,,"Selecionando registros .. ")

DbSelectArea("SE1")

_cInd    := CriaTrab(NIL,.F.)
_cKey    := "E1_FILIAL+E1_PEDIDO+E1_NUM+E1_PARCELA"
_cFiltro := "E1_FILIAL == '"+xFilial("SE1")+"'"
_cFiltro := _cFiltro+".and.E1_SERIE<>'LIV'.AND.E1_SERIE<>'CP0'"
IndRegua("SE1",_cInd,_cKey,,_cFiltro,"Selecionando registros .. ")

DbSelectArea("SC6")

_cInd    := CriaTrab(NIL,.F.)
_cKey    := "C6_FILIAL+C6_PRODUTO+C6_NUM+DTOS(C6_DATA)"
_cFiltro := "C6_FILIAL == '"+xFilial("SC6")+"'"
_cFiltro := _cFiltro+".and.DTOS(C6_DATA)>=DTOS(CTOD('"+DTOC(MV_PAR03)+"'))"
_cFiltro := _cFiltro+".and.DTOS(C6_DATA)<=DTOS(CTOD('"+DTOC(MV_PAR04)+"'))"
IndRegua("SC6",_cInd,_cKey,,_cFiltro,"Selecionando registros .. ")
nIndex := RetIndex("SC6")+1
#IFNDEF TOP
   dbSetIndex( _cInd + OrdBagExt())
   dbSetOrder( nIndex )
#ENDIF

DbSelectArea("SC6")
DbSetOrder( nIndex )

SetRegua(Reccount()/7)
dbSeek(xFilial("SC6")+MV_PAR01,.T.)

_mtot  := 0
_mProd := " "
_mQtde := 0
_mtotp := 0

While !Eof() .And. SC6->C6_PRODUTO <= MV_PAR02

    // Gilberto em 01/12/2000. Para desprezar o Suporte Informatico.

    If Left(SC6->C6_PRODUTO,4) $ "1195/1495/1595/1795"
       DbSelectAreA("SC6")
       DbSkip()
       Loop
    EndIf

    IncRegua()

    _mval   := 0
    _mnum   := SC6->C6_NUM
    _mDescr := " "
    _mCont  := 0
    _motivo := " "

    // Gilberto - 01/12/2000. Para somar suporte informatico.

    DbSelectArea("SC6")

    _nRegAtu:= SC6->( Recno() )
    _nValor:= SC6->C6_VALOR
    _cProduto:= LEFT(SC6->C6_PRODUTO,2)+"95"
    For _ni := 1 To 3
        DbSelectArea("SC6")
        _cSuporte:= Padr(_cProduto+StrZero(_ni,3),15) + _mNum
        DbSeek( xFilial("SC6")+_cSuporte )
        If Found()
           _nValor:= _nValor + SC6->C6_VALOR
        EndIf
    Next
    dbGoto(_nRegAtu)

    If _mProd #LEFT(SC6->C6_PRODUTO,2) .And. _mProd # Space(01)
       nlin := nlin + 2
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

    If Found()

       // _mPerc := (SC6->C6_VALOR * 100) / SC5->C5_VLRPED

       _mPerc := (_nValor * 100) / SC5->C5_VLRPED
       _mDesp := SC5->C5_DESPREM

       DbSelectArea("SZ9")
       DbSetOrder(01)
       DbSeek(xFilial("SZ9")+SC5->C5_TIPOOP)
       If Found()
          _mDescr := SUBSTR(SZ9->Z9_DESCR,1,19)
       Endif

       DbSelectArea("SE1")
       // DbSeek(xFilial("SE1")+_mnum,.T.)
       DbSeek(xFilial("SE1")+_mNum)

       If Found()

          Do While _mNum == SE1->E1_PEDIDO .And. !Eof()

             IF "LUCROS E PERDAS" $(SE1->E1_HIST)
                _motivo := "L&P"
             ENDIF

             IF "NF CANCELA" $(SE1->E1_HIST) .OR. 'CAN' $(SE1->E1_MOTIVO)
                _motivo := "NF CANC"
             ENDIF

             DbSelectArea("SE5")
             DbSeek(xFilial("SE5")+SE1->E1_NUM+SE1->E1_PARCELA)
             If Found()
                IF "CAN" $ (SE5->E5_MOTBX)
                    _motivo := "NF CANC"
                Endif
             Endif

             If nLin > 59

                DbSelectArea("SB1")
                DbSeek(xfilial("SB1") + LEFT( SC6->C6_PRODUTO,2) + "00000" )

                If Found()
                   _cDescr:= SB1->B1_DESC
                Else
                   DbSeek(xfilial("SB1") + LEFT( SC6->C6_PRODUTO,2) )
                   _cDescr:= SB1->B1_DESC
                EndIf

                nLin     := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18) //IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho
                nLin     := nLin + 2
                //@ nlin,00 PSAY "Produto :  " + SC6->C6_DESCRI
                @ nlin,00 PSAY "Faixa Prd.:  " + _cDescr
                nLin     := nLin + 2
                @ nlin,00 PSAY "Pedido  Cliente  Nome do Cliente                          Qtde  Forma de Pgto        Valor Total   Duplicata  Valor Parcela  Dt.Pgto."
                nLin     := nLin + 1
                @ nlin,00 PSAY "------  -------  ---------------------------------------- ----  -------------------  ------------  ---------  -------------  --------"
                nLin     := nLin + 1


                // GRAVACAO DO ARQUIVO.

                If Alltrim(MV_PAR05) #"."
                   If Ascan( _aProds , _cDescr ) == 0
                      DbSelectArea("TRB")
                      RecLock("TRB",.T.)
                      TRB->PRODUTO:=_cDescr
                      MsUnLock()
                      AaDd(_aProds,_cDescr)
                   EndIf
                EndIf

             Endif

             nLin     := nLin + 1
             _mval := SE1->E1_VALOR

             If _mCont == 0
                @ nlin,000 PSAY SE1->E1_PEDIDO
                @ nlin,008 PSAY SC6->C6_CLI
                dbSelectArea("SA1")
                dbSetOrder(1)
                dbSeek(xFilial("SA1")+SC6->C6_CLI)
                @ nlin,017 PSAY SA1->A1_NOME
                @ nlin,058 PSAY STR(SC6->C6_QTDVEN,4)
                @ nlin,064 PSAY _mDescr
                @ nlin,086 PSAY SC5->C5_VLRPED * (_mPerc / 100) PICTURE "@E 99,999.99"
                _mQtde := _mQtde + SC6->C6_QTDVEN
                _mCont := 1

                If Alltrim(MV_PAR05) #"."
                   // GRAVACAO DO ARQUIVO.
                   RecLock("TRB",.T.)
                   TRB->PEDIDO   := SE1->E1_PEDIDO
                   TRB->CLIENTE  := SC6->C6_CLI
                   TRB->NOME     := SA1->A1_NOME
                   TRB->QUANT    := SC6->C6_QTDVEN
                   TRB->PAGAMENT := _mDescr
                   TRB->VALTOTAL := SC5->C5_VLRPED * (_mPerc / 100)
                EndIf
             Else
                If Alltrim(MV_PAR05) #"."
                   RecLock("TRB",.T.)
                EndIf
             Endif

             If SE1->E1_PARCELA == "A" .OR. SE1->E1_PARCELA == " "
                _mval := SE1->E1_VALOR - _mDesp
             Endif

             @ nlin,099 PSAY SE1->E1_NUM+" "+SE1->E1_PARCELA
             @ nlin,111 PSAY _mval * (_mPerc / 100) PICTURE "@E 99,999.99"

             // GRAVACAO DO ARQUIVO.
             If Alltrim(MV_PAR05) #"."
                TRB->DUPLICAT := SE1->E1_NUM+" "+SE1->E1_PARCELA
                TRB->VALPARC  :=  _mval * (_mPerc / 100)
             EndIf

             If _motivo #" "
                If _motivo == "L&P"
                   @ nlin,125 PSAY _motivo
                   _mtot  := _mtot + (_mval * (_mPerc / 100))
                else
                   @ nlin,125 PSAY _motivo
                endif
                If Alltrim(MV_PAR05) #"."
                   TRB->DTPAGTO:= _motivo
                EndIf
             Else
                If YEAR(SE1->E1_BAIXA) <> 0
                   @ nlin,125 PSAY SE1->E1_BAIXA
                   _mtotp := _mtotp + (_mval * (_mPerc / 100))
                endif
                _mtot  := _mtot + (_mval * (_mPerc / 100))
                If Alltrim(MV_PAR05) #"."
                   TRB->DTPAGTO:= DTOC(SE1->E1_BAIXA)
                EndIf
             Endif

             If Alltrim(MV_PAR05) #"."
                MsUnLock()
             EndIf

             _motivo := " "

             DbSelectArea("SE1")
             DbSkip()

          Enddo

       Endif

    Endif

    _mProd := LEFT(SC6->C6_PRODUTO,2)

    DbSelectArea("SC6")
    DbSkip()

End-While

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
dbSelectarea("SE5")
RetIndex("SE5")

IF ALLTRIM(MV_PAR05) #"."
   dbSelectArea("TRB")
   dbCloseArea()
   COPY FILE "\SIGA\SIGAADV\"+_cNomeArq TO "\SIGA\SIGAADV\EXPORTA\"+_cNomeArq
ENDIF

Set Device to Screen
If aReturn[5] == 1
    Set Printer To
    ourspool(wnrel) //Chamada do Spool de Impressao
Endif

MS_FLUSH() //Libera fila de relatorios em spool

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Funcao    ³VALIDPERG³ Autor ³ Jose Renato July ³ Data ³ 25.01.99 ³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±³Descricao ³ Verifica perguntas, incluindo-as caso nao existam.   ³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±³Uso       ³ SX1                                                  ³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±³Incluido  ³ por : Gilberto A Oliveira Jr - 17/07/00              ³±
±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function ValidPerg
Static Function ValidPerg()

   cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
   aRegs:= {}
   dbSelectArea("SX1")
   dbSetOrder(1)
   aAdd(aRegs,{cPerg,"01","Faixa de Grupo de   ?","mv_ch1","C",02,0,2,"G","","mv_par01","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"02","Faixa de Grupo ate  ?","mv_ch2","C",02,0,2,"G","","mv_par02","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"03","Data de             ?","mv_ch3","D",08,0,2,"G","","mv_par03","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"04","Data At‚            ?","mv_ch4","D",08,0,2,"G","","mv_par04","","","","","","","","","","","","","","",""})
   aAdd(aRegs,{cPerg,"05","Nome do Arquivo     ?","mv_ch5","C",08,0,2,"G","","mv_par05","","","","","","","","","","","","","","",""})
   For i := 1 to Len(aRegs)
      If !dbSeek(cPerg+aRegs[i,2])
         RecLock("SX1",.T.)
         For j := 1 to FCount()
            If j <= Len(aRegs[i])
               FieldPut(j,aRegs[i,j])
            Endif
         Next
         MsUnlock()
      Endif
   Next

Return
