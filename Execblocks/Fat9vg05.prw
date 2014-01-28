#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa:  FAT9VG05 ³Autor: Roger Cangianeli       ³ Data:   31/01/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Validacao da Get Dados na Manutencao do SZV                ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Valida no ExecBlock RFATA09, Campo SERIE                   ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Fat9vg05()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
Local aArea := GetArea()
SetPrvt("_CALIAS,_NINDEX,_NREG,_LRET,_NPOSNF,_NPOSSER")
SetPrvt("_NPOSDT,_CMSG,ACOLS,M->ZV_SERIE,")



_lRet   := .T.
_nPosNF := aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_NFISCAL"})
_nPosSER:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_SERIE"})
_nPosDT := aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_DTNF"})

dbSelectArea("SF2")
dbSetOrder(1)
If !dbSeek(xFilial("SF2")+aCols[n,_nPosNF]+M->ZV_SERIE, .F.)
	_cMsg := "Nota Fiscal/Serie Nao Encontrada ! Verifique."
    aCols[n,_nPosNF] := Space(6)
    aCols[n,_nPosDT] := stod("")
    M->ZV_SERIE := Space(3)
	_lRet := .F.
Else
	aCols[n,_nPosDT] := SF2->F2_EMISSAO
EndIf

If !_lRet
	MsgStop(_cMsg, " Atencao ")
EndIf

RestArea(aArea)

Return(_lRet)