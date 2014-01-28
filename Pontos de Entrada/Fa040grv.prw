#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function Fa040grv()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("_NORDEMC5,_NREGISC5,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿛rograma  쿑A040GRV  � Autor � Gilberto A Oliveira Jr� Data � 19/07/00 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escricao 쿛ONTO DE ENTRADA PARA ATUALIZACAO DO STATUS (C5_STATFIN) NO 낢�
굇�          쿞C5 - PEDIDO DE VENDA. Somente quando o titulo for "RA".    낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       쿐specifico para Editora Pini. Modulo Financeiro.            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴눙�
굇쿝evisao   �                                          � Data �          낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/


If SE1->E1_TIPO<>"RA"
   Return
EndIf

If Empty(SE1->E1_PEDIDO)
   #IFNDEF WINDOWS
      Alert('Por ser um titulo tipo "RA",e necessario que se digite o numero do Pedido de Venda. Verifique...')
   #ELSE
      MsgStop('Por ser um titulo tipo "RA", e necessario que se digite o numero do Pedido de Venda. Verifique...')
   #ENDIF
EndIf


DbSelectArea("SC5")
_nOrdemC5:= IndexOrd()
_nRegisC5:= Recno()
DbSetOrder(3)
If !( DbSeek(xFilial("SC5")+SE1->E1_CLIENTE+SE1->E1_PEDIDO) )
   #IFNDEF WINDOWS
      Alert("Cod. Cliente + Nr.Pedido nao encontrado !!" )
   #ELSE
      MsgStop("Cod. Cliente + Nr.Pedido nao encontrado !!" )
   #ENDIF
Else
   RecLock("SC5",.F.)
   SC5->C5_STATFIN:= "RA"
   MsUnLock()
EndIf

Return




