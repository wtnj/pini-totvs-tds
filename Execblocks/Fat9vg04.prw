#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
/*/ Alterado por Danilo C S Pala, em 20040812
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa:  FAT9VG04 ³Autor: Roger Cangianeli       ³ Data:   31/01/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Validacao da Get Dados na Manutencao do SZV                ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Valida no ExecBlock RFATA09, Campo NFISCAL                 ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Fat9vg04()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
Local aArea := GetArea()
SetPrvt("_CALIAS,_NINDEX,_NREG,_LRET,_NPOSNF,_NPOSSER")
SetPrvt("_NPOSDT,_CMSG,ACOLS,M->ZV_NFISCAL,_notafiscal")



_lRet    := .T.
_nPosNF  := aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_NFISCAL"})
_nPosSER := aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_SERIE"})
_nPosDT  := aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_DTNF"})

dbSelectArea("SF2")
dbSetOrder(1)
If !dbSeek(xFilial("SF2")+M->ZV_NFISCAL, .F.)
	_cMsg := "Nota Fiscal Nao Encontrada ! Verifique."
	aCols[n,_nPosDT]  := stod("")
	aCols[n,_nPosSER] := Space(3)
    aCols[n,_nPosNF]  := Space(9)                    
    _lRet := MsgBox("Deseja desassociar a Nota Fiscal da Av?","Pergunta","YESNO") //20040812
    M->ZV_NFISCAL     := Space(9)
Else
	aCols[n,_nPosDT]  := SF2->F2_EMISSAO
	aCols[n,_nPosSER] := SF2->F2_SERIE
EndIf

If !_lRet
	MsgStop(_cMsg, " Atencao ")
EndIf

RestArea(aArea)

Return(_lRet)