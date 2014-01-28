#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: FAT11VG1  ³Autor: Roger Cangianeli       ³ Data:  07/02/00  ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Validacao da LINHA da Get Dados na Manutencao do SZS       ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Valida no ExecBlock RFATA11                                ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Fat11vg1()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

SetPrvt("_CALIAS,_NINDEX,_NREG,_LRET,_NPOSORI,_NPOSIT")
SetPrvt("_NPOSINS,_NPOSREV,_NPOSCIR,_NPOSPRD,_NPOSMAT,_NPOSTIT")
SetPrvt("_NPOSVAL,_NPOSCPG,_CMSG,")

_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()
_lRet   := .T.
_nPosOri:= n
_nPosIt := aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_ITEM"})
_nPosIns:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_NUMINS"})
_nPosRev:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_CODREV"})
_nPosCir:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_DTCIRC"})
_nPosPrd:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_CODPROD"})
_nPosMat:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_CODMAT"})
_nPosTit:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_CODTIT"})
_nPosVal:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_VALOR"})
_nPosCpg:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_CONDPAG"})

// Se Linha estiver valida
If !aCols[n,Len(aHeader)+1]

    // Numero do Item
    If Empty(aCols[_nPosOri,_nPosPar])
        _cMsg := "O Numero do Item deve ser Preenchido."
        _lRet := .F.
    EndIf
    // Numero da Insercao
    If Empty(aCols[_nPosOri,_nPosIns])
        _cMsg := "O Numero da Insercao deve ser Preenchido."
        _lRet := .F.
    EndIf
    // Codigo da Revista
    If Empty(aCols[_nPosOri,_nPosRev])
        _cMsg := "O Codigo da Revista deve ser Preenchido."
        _lRet := .F.
    EndIf
    // Data da Circulacao
    If Empty(aCols[_nPosOri,_nPosCir])
        _cMsg := "A Data de Circulacao da Revista deve ser Preenchido."
        _lRet := .F.
    EndIf
    // Codigo do Produto
    If Empty(aCols[_nPosOri,_nPosPrd])
        _cMsg := "O Codigo do Produto deve ser Preenchido."
        _lRet := .F.
    EndIf
    // Codigo do Material
    If Empty(aCols[_nPosOri,_nPosMat])
        _cMsg := "O Codigo do Material deve ser Preenchido."
        _lRet := .F.
    EndIf
    // Codigo do Titulo
    If Empty(aCols[_nPosOri,_nPosTit])
        _cMsg := "O Codigo do Titulo deve ser Preenchido."
        _lRet := .F.
    EndIf
    // Valor da Parcela
    If aCols[_nPosOri,_nPosVal] <= 0 .and. _lRet
        _cMsg := "O Valor da Insercao deve ser maior que Zero."
        _lRet := .F.
    EndIf
    // Condicao de Pagamento
    If Empty(aCols[_nPosOri,_nPosCpg]) .and. _lRet
        _cMsg := "Deve ser incluida uma Condicao de Pagamento nesta Insercao."
        _lRet := .F.
    EndIf

EndIf

If !_lRet
	MsgStop(_cMsg, " Atencao ")
EndIf

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)

// Substituido pelo assistente de conversao do AP5 IDE em 19/03/02 ==> __Return(_lRet)
Return(_lRet)        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
