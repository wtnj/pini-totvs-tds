#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 30/03/02

User Function ATSZ9()
SetPrvt("CINDEX,CKEY,MCONTA1")
lEnd  := .F.
bBloco:= {|lEnd| ATproc(@lEnd)}
Processa( bBloco, "Aguarde" ,"Processando...", .T. )  

Return

Static Function ATproc()   

DbSelectArea("SZ9")
DBGOTOP()
DO WHILE .NOT. EOF()
   MCONTA1:='   '
   IF SUBSTR(Z9_NATBX,1,2)=='CV'
      MCONTA1:='11020001001'
   ENDIF
   IF SUBSTR(Z9_NATBX,1,2)=='CA'
      MCONTA1:='11020001002'
   ENDIF
   IF SUBSTR(Z9_NATBX,1,2)=='CM'
      MCONTA1:='11020001003'
   ENDIF
   IF MCONTA1=='    ' .AND. SUBSTR(Z9_NATUREX,1,1)=='C'
      MCONTA1:='11020001004'
   ENDIF
   IF SUBSTR(Z9_NATBX,1,2)=='BX'
      MCONTA1:='11020101002'
   ENDIF
   IF SUBSTR(Z9_NATBX,1,2)=='CH'
      MCONTA1:='11020101003'
   ENDIF
   IF SUBSTR(Z9_NATBX,1,2)=='DP'
      MCONTA1:='11020101004'
   ENDIF
   IF SUBSTR(Z9_NATBX,1,2)=='BB'
      MCONTA1:='11020101008'
   ENDIF
   IF SUBSTR(Z9_NATBX,1,2)=='DB'
      MCONTA1:='11020101011'
   ENDIF

   IF SUBSTR(Z9_NATBX,1,2)=='DH'
      MCONTA1:='11020101002'
   ENDIF
   Reclock("SZ9",.F.)
   REPLA Z9_CONTA1 WITH MCONTA1
   MSUNLOCK()
   DBSKIP()
ENDDO
DbSelectArea("SZ9")
Retindex("SZ9")
Return
