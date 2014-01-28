#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa:  FAT11VG4 ³Autor: Roger Cangianeli       ³ Data:   07/02/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Validacao da Get Dados na Manutencao do SZS                ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Valida no ExecBlock RFATA11, Campo NFISCAL                 ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Fat11vg4()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

SetPrvt("_CALIAS,_NINDEX,_NREG,_LRET,_NPOSNF,_NPOSSER")
SetPrvt("_NPOSDT,_CMSG,ACOLS,")

_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()
_lRet   := .T.
_nPosNF := aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_NFISCAL"})
_nPosSER:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_SERIE"})
_nPosDT := aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_DTNF"})

dbSelectArea("SF2")
dbSetOrder(1)
If !dbSeek(xFilial("SF2")+M->ZS_NFISCAL, .F.) .and. !Empty(M->ZS_NFISCAL)
	_cMsg := "Nota Fiscal Nao Encontrada ! Verifique."
	aCols[n,_nPosDT]  := stod("")
	aCols[n,_nPosSER] := Space(3)
	_lRet := .F.
	
ElseIf Empty(M->ZS_NFISCAL)
    aCols[n,_nPosDT]  := stod("")
    aCols[n,_nPosSER] := Space(3)

Else
	aCols[n,_nPosDT]  := SF2->F2_EMISSAO
	aCols[n,_nPosSER] := SF2->F2_SERIE
	
EndIf

If !_lRet
	MsgStop(_cMsg, " Atencao ")
EndIf

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)

Return(_lRet)