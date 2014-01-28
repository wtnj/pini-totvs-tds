#INCLUDE "RWMAKE.CH"

User Function EXED3EDI()

Local NPOSPRODUTO, CPRODUTO, _LFLAG

nPosPRODUTO  :=  aScan(aHeader,{|x| UPPER(AllTrim(x[2]))=="D3_PRODUTO" })
cProduto     :=  aCols[N,nPosPRODUTO]

_lFlag := .t.

If UPPER(ALLTRIM(FUNNAME())) == "MATA241"
//	cProduto     := M->D3_PRODUTO
	dbSelectArea("SZJ")               
	dbSetOrder(1)
	IF !DBSEEK(XFILIAL("SZJ")+Padr(Alltrim(CPRODUTO),4)+STR(M->D3_EDICAO,4,0))
    	MsgAlert("Edicao nao Cadastrada")
		_LFLAG := .F.
    ENDIF
EndIf

RETURN(_LFLAG)