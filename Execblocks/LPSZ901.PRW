#INCLUDE "RWMAKE.CH"
User Function LPSZ901()

Local mcta  := ''
Local aArea := GetArea()

dbselectarea("sc5") 
DBGOTOP()
dbsetorder(1)
dbseek(xfilial("SC5")+sd2->d2_pedido)     

dbselectarea("SZ9") 
DBGOTOP()
DBSETORDER(1)
DBSEEK(XFILIAL("SZ9")+SC5->C5_TIPOOP)
If Found()
   MCTA:=SZ9->Z9_CONTA1
   MTIPO:=SZ9->Z9_TIPOOP
Endif

RestArea(aArea)

RETURN(MCTA)
