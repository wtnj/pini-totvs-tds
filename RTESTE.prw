//Danilo c s Pala, 20040803
#include "rwmake.ch" 
User Function RTESTE()

PRIVATE DESCGIN := space(40)
//DESCGIN :=  fDesc("X26","26"+SRA->RA_GRINRAI,"X5_DESCRI")
//DESCGIN :=  iif(DBSEEK(xFilial("SX5")+"2655"),"sim","nao")    
DESCGIN :=  Tabela("26",SRA->RA_GRINRAI)
MSGALERT(DESCGIN)

RETURN