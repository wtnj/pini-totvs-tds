#include "rwmake.ch"

User Function EndBP()
SetPrvt("MRET,")

AxCadastro("ZY3","EndCobrBP")
IF ZY3_END==' '
   MRET:='N'
ELSE
   MRET:='S'
ENDIF
Return(MRET)
