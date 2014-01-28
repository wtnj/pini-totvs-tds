#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
/*/ alterado por Danilo C S Pala em 20040630
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa:  FAT11VG3 ³Autor: Roger Cangianeli       ³ Data:   07/02/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Validacao da Get Dados na Manutencao do SZS                ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Valida no ExecBlock RFATA11, Campo NUMINS                  ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Fat11vg3()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

SetPrvt("_CALIAS,_NINDEX,_NREG,_NPOS,_LRET,_NPOSINS")
SetPrvt("_NPOSITE,_CSTR,_NVEZES,_CMSG,")

_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()
_nPos   := n
_lRet   := .T.
_nPosIns:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_NUMINS"})
_nPosIte:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_ITEM"})

_cStr   := aCols[ _nPos, _nPosIte ] + Str(M->ZS_NUMINS) //20040625

For _nVezes := 1 to Len(aCols)
	If (aCols[_nVezes,_nPosIte] + Str(aCols[_nVezes,_nPosIns]) == _cStr) .and. (_nVezes #_nPos) //20040625
        _cMsg   := "Item / Insercao ja digitados na linha "+ Str(_nVezes)+ " !"
        _lRet   := .F.
        MsgStop(_cMsg, " Atencao ")
        Exit
    EndIf
Next

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)

Return(_lRet)