#INCLUDE "RWMAKE.CH"
User Function LPSZ903()

Local mcta  := ''
Local aArea := GetArea()

dbselectarea("sc5") 
DBGOTOP()
dbsetorder(1)
dbseek(xfilial("SC5")+SE1->E1_PEDIDO)     

dbselectarea("SZ9") 
DBGOTOP()
DBSETORDER(1)
DBSEEK(XFILIAL("SZ9")+SC5->C5_TIPOOP)
If Found()
   MCTA:=SZ9->Z9_CONTA1
Endif

IF !EMPTY(SE1->E1_DTAL11)
   DBSELECTAREA("SE1")
   RECLOCK("SE1",.F.)
   SE1->E1_ALINEA := ""
   MSUNLOCK()
ENDIF

RestArea(aArea)

RETURN(MCTA)
