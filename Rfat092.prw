#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT004   ³Autor: Solange Nalini         ³ Data:   30/04/98 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Libera‡ao de Pedidos de Venda por lote                     ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat092()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CPERG,_CMSG")
SetPrvt("_SALDOPARC,MV_PAR06,")

CPERG:="PFAT51"
While .T.
    If !Pergunte(cPerg)
		Return
	Endif
	
    dbSelectArea('SC5')
    dbSetOrder(1)
    If !dbSeek(xFilial("SC5")+MV_PAR02, .F.)
        Return
    EndIf
	
    If SC5->C5_CLIENTE #MV_PAR01
        _cMsg := "ESTA AV NAO E DESTE CLIENTE"
        MsgAlert( _cMsg, "ATENCAO")
        Return
    EndIf
	
    If SC5->C5_AVESP#'S'
        _cMsg:= "ESTA AV NAO ESTA CADASTRADA COMO ESPECIAL"
        MsgAlert( _cMsg, "ATENCAO")
        Return
    EndIf
	
    _SALDOPARC := MV_PAR04
	
    dbSelectArea("SZV")
    dbSetOrder(1)
    If dbSeek( xFilial("SZV")+MV_PAR02+STR(MV_PAR04,2,0), .F. )
        _cMsg := "PARCELA JA CADASTRADA"
        MsgAlert( _cMsg, "ATENCAO")
        Return
    EndIf
	
    While _SALDOPARC <= MV_PAR03
        dbSelectArea("SZV")
        RecLock("SZV",.T.)
		SZV->ZV_FILIAL :='01'
		SZV->ZV_CODCLI :=MV_PAR01
		SZV->ZV_NUMAV  :=MV_PAR02
		SZV->ZV_TOTPARC:=MV_PAR03
		SZV->ZV_NPARC  :=_SALDOPARC
		SZV->ZV_VALOR  :=MV_PAR05
		SZV->ZV_ANOMES :=MV_PAR06
		SZV->ZV_CONDPAG:=MV_PAR07
        SZV->ZV_SITUAC := "AA"      // GRAVACAO SOLICITADA POR CIDINHA.- R.C.
        SZV->(msUnlock())
		MV_PAR06:=MV_PAR06+30
        While MONTH(MV_PAR06)==MONTH(SZV->ZV_ANOMES)
			MV_PAR06:=MV_PAR06+1
        End
		_SALDOPARC:=_SALDOPARC+1
    End
End

Return