#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function Mta010ok()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CRET,_AREA,")

_cRet := .T.
If nModulo == 17	// SIGAEIC
	_Area:=ALIAS()
	dbSelectArea("SW1")
	dbSetOrder(3)
	If dbSeek(xFilial()+SB1->B1_COD)
	   MsgInfo("Produto possui Solicitacao de Importacao em andamento")
	  _cRet:=.F.
	else
		_cRet:=.T.
	endif  
	dbSetOrder(1)
	dbSelectArea(_Area)
Endif
// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> __Return(_cRet)
Return(_cRet)        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

