#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFIN013   ³Autor: Roger CangianeLi       ³ Data:   06/07/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Etiquetas para cartas de cobranca da PubLicidade           ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfin013()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

SetPrvt("_CALIAS,_NINDEX,_NREG,CPERG,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CSTRING,ARETURN,LCONTINUA,WNREL")
SetPrvt("NLASTKEY,_AIMPR,_NCONT,LIN,_CBANCO,_CNOME")
SetPrvt("_CEND,_CCEP,_NCOL,_NLINHA,AREGS,I")
SetPrvt("J,aArea")

Private aArea := GetArea()

If SM0->M0_CODIGO #'01'
    Return
EndIf

cPerg   := "FAT114"
 
If Pergunte(cPerg)
	RptStatus({||_RunProc()}, "Imprimindo Cartas ...")// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>         RptStatus({||Execute(_RunProc)}, "Imprimindo Cartas ...")
EndIf

RestArea(aArea)

Return

Static Function _RunProc()

titulo  := PADC("ETIQUETAS PARA CARTAS DE COBRANCA ",74)
cDesc1  := PADC("Este programa emite Etiquetas para cartas de cobranca",74)
cDesc2  :=' '
cDesc3  :=' '
cString :='SE1'
aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
lContinua   := .T.
wnrel       := "FIN013"
nLastKey    := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
   Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

_aImpr  := Array(3,4)
_nCont  := 0
Lin     := 0

dbSelectArea("SE1")
dbSetOrder(7)
SetRegua(RecCount())
dbSeek(xFilial("SE1")+DtoS(MV_PAR01), .T.)
While !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and.;
    SE1->E1_VENCREA <= MV_PAR02

    IncRegua()

    _cBanco     := SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA
    If ( !"P" $ SE1->E1_PEDIDO .and. SE1->E1_DIVVEN #"PUBL" ) .or.;
        Empty(_cBanco) .or. SE1->E1_SALDO <= 0
        dbSkip()
        Loop
    EndIf


    dbSelectArea("SA1")
    If dbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA,.F.)

        _nCont  := _nCont + 1
        _cNome  := AllTrim(SA1->A1_NOME)
        _cEnd   := AllTrim(SA1->A1_END)
        _cCep   := Subs(SA1->A1_CEP,1,5) + '-' + Subs(SA1->A1_CEP,6,3)
        _cCep   := _cCep + ' - ' + AllTrim(SA1->A1_MUN) + ' -  ' + SA1->A1_EST

        _aImpr[_nCont, 1] := _cNome
        _aImpr[_nCont, 2] := _cEnd
        _aImpr[_nCont, 3] := _cCep
        _aImpr[_nCont, 4] := ""

        dbSelectArea("SC5")
        dbSeek(xFilial("SC5")+SE1->E1_PEDIDO, .F.)
        If !Empty(SC5->C5_CODAG)
            dbSelectArea("SA1")
            If dbSeek(xFilial("SA1")+SC5->C5_CODAG,.F.)
                _cEnd   := AllTrim(SA1->A1_END)
                _cCep   := Subs(SA1->A1_CEP,1,5) + '-' + Subs(SA1->A1_CEP,6,3)
                _cCep   := _cCep + ' - ' + AllTrim(SA1->A1_MUN) + ' -  ' + SA1->A1_EST
                _aImpr[ _nCont, 1] := _cNome
                _aImpr[ _nCont, 2] := "A/C " + AllTrim(SA1->A1_NOME)
                _aImpr[ _nCont, 3] := _cEnd
                _aImpr[ _nCont, 4] := _cCep
            EndIf

        EndIf

        If _nCont == 3
            _Imprime()
            _nCont := 0
            _aImpr  := Array(3,4)
        EndIf

    EndIf

    dbSelectArea("SE1")
    IncRegua()
    dbSkip()

EndDo

// Imprime restante das etiquetas
If _nCont > 0
    _Imprime()
EndIf

Set Devi To Scre
If aRETURN[5] == 1
    Set Printer to
    dbcommitAll()
    ourspool(WNREL)
EndIf

Ms_Flush()

Return

Static Function _Imprime()

If nLastKey == 27
   Return
Endif

_nCol   := 1

For _nLinha := 1 to 4
    Lin     := Lin + 1
    For _nReg := 1 to 3
        If ValType(_aImpr[ _nReg, _nLinha ]) == "U"
            @ Lin, _nCol PSAY ""
        Else
            @ Lin, _nCol PSAY _aImpr[ _nReg, _nLinha ]
        EndIf
        If _nCol == 1
            _nCol := 43
        Else
            _nCol := 87
        EndIf
    Next
    _nCol   := 1
Next
Lin     := Lin + 2

Return

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Funcao    ³VALIDPERG³ Autor ³ Jose Renato July ³ Data ³ 25.01.99 ³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±³Descricao ³ Verifica perguntas, incluindo-as caso nao existam.   ³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±³Uso       ³ SX1                                                  ³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±³Release   ³ 3.0i - Roger Cangianeli - 12/05/99.                  ³±
±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function VALIDPERG
Static Function VALIDPERG()

cPerg    := PADR(cPerg,6)
aRegs    := {}
dbSelectArea("SX1")
dbSetOrder(1)
AADD(aRegs,{cPerg,"01","Data Vencimento De  ?","mv_ch1","D",08,0,2,"G","","mv_par01","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Data Vencimento Ate ?","mv_ch2","D",08,0,2,"G","","mv_par02","","","","","","","","","","","","","","",""})
For i := 1 to Len(aRegs)
  If !dbSeek(cPerg+aRegs[i,2])
     RecLock("SX1",.T.)
     For j := 1 to FCount()
        If j <= Len(aRegs[i])
           FieldPut(j,aRegs[i,j])
        Endif
     Next
     SX1->(MsUnlock())
  Endif
Next
Return
