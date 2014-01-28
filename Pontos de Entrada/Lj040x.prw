#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function Lj040x()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CALIAS,_NINDEX,_NREG,_LERRO,_CMSG,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: LJ040X    ³Autor: Roger Cangianeli       ³ Data:   18/12/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao:Apos a confirmacao da alteracao.                            ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      :Especifico PINI.                                            ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()

dbSelectArea("SF2")
dbSetOrder(1)
If dbSeek(xFilial("SF2")+SE1->E1_NUM+SE1->E1_SERIE+SE1->E1_CLIENTE+SE1->E1_LOJA, .F.)
    _lErro := .F.
    _cMsg  := ""
    If SE1->E1_VEND1 #SF2->F2_VEND1
        _lErro := .T.
        _cMsg  := " Vendedor 1 - "
    EndIf
    If SE1->E1_VEND2 #SF2->F2_VEND2
        _lErro := .T.
        _cMsg  := _cMsg +" Vendedor 2 - "
    EndIf
    If SE1->E1_VEND3 #SF2->F2_VEND3
        _lErro := .T.
        _cMsg  := _cMsg +" Vendedor 3 - "
    EndIf
    If SE1->E1_VEND4 #SF2->F2_VEND4
        _lErro := .T.
        _cMsg  := _cMsg +" Vendedor 4 - "
    EndIf
    If SE1->E1_VEND5 #SF2->F2_VEND5
        _lErro := .T.
        _cMsg  := _cMsg +" Vendedor 5 - "
    EndIf

    If _lErro
        RecLock("SF2", .F.)
        SF2->F2_VEND1   := SE1->E1_VEND1
        SF2->F2_VEND2   := SE1->E1_VEND2
        SF2->F2_VEND3   := SE1->E1_VEND3
        SF2->F2_VEND4   := SE1->E1_VEND4
        SF2->F2_VEND5   := SE1->E1_VEND5
        msUnlock()
        _cMsg := _cMsg + " foram alterados no cabecalho da N.F.Saida. "
        #IFDEF WINDOWS
            MsgAlert(_cMsg, "Atencao","ALERT")
        #ELSE
            Alert(_cMsg)
        #ENDIF
    EndIf

EndIf


dbSelectArea("SC5")
dbSetOrder(1)
If dbSeek(xFilial("SC5")+SE1->E1_PEDIDO, .F.)
    _lErro := .F.
    _cMsg  := ""
    If SE1->E1_VEND1 #SC5->C5_VEND1
        _lErro := .T.
        _cMsg  := " Vendedor 1 - "
    EndIf
    If SE1->E1_VEND2 #SC5->C5_VEND2
        _lErro := .T.
        _cMsg  := _cMsg +" Vendedor 2 - "
    EndIf
    If SE1->E1_VEND3 #SC5->C5_VEND3
        _lErro := .T.
        _cMsg  := _cMsg +" Vendedor 3 - "
    EndIf
    If SE1->E1_VEND4 #SC5->C5_VEND4
        _lErro := .T.
        _cMsg  := _cMsg +" Vendedor 4 - "
    EndIf
    If SE1->E1_VEND5 #SC5->C5_VEND5
        _lErro := .T.
        _cMsg  := _cMsg +" Vendedor 5 - "
    EndIf

    If _lErro
        RecLock("SC5", .F.)
        SC5->C5_VEND1   := SE1->E1_VEND1
        SC5->C5_VEND2   := SE1->E1_VEND2
        SC5->C5_VEND3   := SE1->E1_VEND3
        SC5->C5_VEND4   := SE1->E1_VEND4
        SC5->C5_VEND5   := SE1->E1_VEND5
        msUnlock()
        _cMsg := _cMsg + " foram alterados no Pedido de Venda. "
        #IFDEF WINDOWS
            MsgAlert(_cMsg, "Atencao","ALERT")
        #ELSE
            Alert(_cMsg)
        #ENDIF
    EndIf
    
EndIf

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)
Return
