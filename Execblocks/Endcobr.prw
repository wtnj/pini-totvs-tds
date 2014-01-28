#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02

User Function Endcobr()        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("MRET,")

AxCadastro("SZ5","EndCobr")
IF Z5_END==' '
   MRET:='N'
ELSE
   MRET:='S'
ENDIF
// Substituido pelo assistente de conversao do AP5 IDE em 16/03/02 ==> __return(MRET)
Return(MRET)        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02


