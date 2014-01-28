#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02

User Function Eicpo1()        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("NFOBGERAL,")

nFobGeral:=SW2->W2_FOB_TOT + SW2->W2_INLAND + SW2->W2_PACKING + SW2->W2_FRETEIN - SW2->W2_DESCONT
If Inclui .OR. Altera
   nFobGeral:=M->W2_FOB_TOT + M->W2_INLAND + M->W2_PACKING + M->W2_FRETEIN - M->W2_DESCONT
Endif
// Substituido pelo assistente de conversao do AP5 IDE em 16/03/02 ==> __Return(nFobGeral)
Return(nFobGeral)        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02




