#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function Md2tudok()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

#IFDEF WINDOWS
	MsgStop("Existem "+Str(Len(aCols))+" linhas na GetDados")
#ELSE
	Alert("Existem "+Str(Len(aCols))+" linhas na GetDados")
#ENDIF
// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> __RETURN(.T.)
Return(.T.)        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02
