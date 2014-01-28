#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: FAT9VG01  ³Autor: Roger Cangianeli       ³ Data:  26/01/00  ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Validacao da LINHA da Get Dados na Manutencao do SZV       ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Valida no ExecBlock RFATA09                                ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Fat9vg01()

SetPrvt("_CALIAS,_NINDEX,_NREG,_LRET,_NPOSORI,_NPOSPAR")
SetPrvt("_NPOSVAL,_NPOSCPG,_NPOSTRA,_CMSG,_NVEZES,")

_cAlias  := Alias()
_nIndex  := IndexOrd()
_nReg    := Recno()
_lRet    := .T.
_nPosOri := n
_nPosPar := aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_NPARC"})
_nPosVal := aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_VALOR"})
_nPosCpg := aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_CONDPAG"})

// Verifica se linha esta valida
If !aCols[n,Len(aHeader)+1]
    // Numero da Parcela
    If aCols[_nPosOri,_nPosPar] <= 0
        _cMsg := "O Numero da Parcela deve ser maior que Zero."
        _lRet := .F.
    EndIf

    // Valor da Parcela
    If aCols[_nPosOri,_nPosVal] <= 0 .and. _lRet
        _cMsg := "O Valor da Parcela deve ser maior que Zero."
        _lRet := .F.
    EndIf

    // Condicao de Pagamento
    If Empty(aCols[_nPosOri,_nPosCpg]) .and. _lRet
        _cMsg := "Deve ser incluida uma Condicao de Pagamento nesta Parcela."
        _lRet := .F.
    EndIf

    // Verifica existencia de mais de uma parcela com mesmo numero
    If _lRet
        For _nVezes := 1 to Len(aCols)
            If aCols[_nVezes,1] == aCols[_nPosOri,_nPosPar] .and. _nVezes #_nPosOri
                _cMsg := "Ja existe uma parcela com mesma numeracao ! Verifique."
                _lRet := .F.
                Exit
            EndIf
        Next
    EndIf
EndIf

If !_lRet
	MsgAlert(_cMsg, " Atencao ")
EndIf

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)

Return(_lRet)