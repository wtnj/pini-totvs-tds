#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function Md2vlcli()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

#IFDEF WINDOWS
	MSGSTOP("Voce digitou o Cliente :"+cCliente)
#ELSE
	Alert("Voce digitou o Cliente :"+cCliente)
#ENDIF
// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> __RETURN(.T.)
Return(.T.)        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02
