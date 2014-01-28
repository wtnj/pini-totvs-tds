#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function Mta410br()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CALIAS,_NORDEM,_NRECNO,_CPARAM,_CRETORNO,_NORDEM_ANTIGA_DO_SB1")

_cAlias:= Alias()
_nOrdem:= IndexOrd()
_nRecno:= Recno()


_cParam:= ParamIXB
_cRetorno:= ""

DbSelectArea("SB1")
_nOrdem_Antiga_do_SB1:= IndexOrd()
DbSetOrder(3)
DbSeek(xFilial("SB1")+_cParam)

If Found()
   Msgstop("Encontrei !")
   _cRetorno:= SB1->B1_COD
Endif

DbSetOrder( _nOrdem_Antiga_do_SB1)

DbSelectArea(_cAlias)
DbSetOrder(_nOrdem)
DbGoto(_nRecno)

// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> __Return( _cRetorno )
Return( _cRetorno )        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

