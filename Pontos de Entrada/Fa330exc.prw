#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function Fa330exc()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("_CALIAS,_NINDEX,_NORDEM,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿛TO ENTRADA 쿑A330EXC  � Autor � Gilberto A. Oliveira  � Data � 04/08/00 낢�
굇쳐컴컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escricao   쿛onto de Entrada para estornar o conteudo gravado no        낢�
굇�            쿎5_STATFIN pelo ponto de entrada FA330SE1.                  낢�
굇�            쿌contece no estorno da Compensacao CR.                      낢�
굇쳐컴컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so         쿐specifico para Editora Pini. Modulo Financeiro.            낢�
굇쳐컴컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴눙�
굇쿝evisao     �                                          � Data �          낢�
굇읕컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

_cAlias:= Alias()
_nIndex:= IndexOrd()
_nOrdem:= Recno()

DbSelectArea("SC5")
DbSetOrder(1)
DbSeek(xfilial("SC5")+SE1->E1_PEDIDO)

If (Alltrim(SC5->C5_TIPOOP) $ "80|82|83|84") .And. Found()

   If SC5->C5_STATFIN == "DC "
      RecLock("SC5",.F.)
      SC5->C5_STATFIN:= "RA "
      MsUnLock()
   EndIf

EndIf

DbSelectArea(_cAlias)
DbSetOrder(_nIndex)
DbGoto(_nOrdem)

Return


