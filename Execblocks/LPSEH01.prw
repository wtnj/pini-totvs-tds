#INCLUDE "RWMAKE.CH"
User Function LPSEH01() //BANCO
// ANDRE/JOSE RICARDO, Danilo C S Pala 20100208 
Local mcta  := space(20) // ''
Local aArea := GetArea()
IF SEH->EH_APLEMP ="APL"
   dbselectarea("SA6") 
   DBGOTOP()
   dbsetorder(1)
   dbseek(xfilial("SA6")+SEH->EH_BANCO+SEH->EH_AGENCIA+SEH->EH_CONTA)        
   If Found()
      MCTA:=SA6->A6_CONTA 
   Endif            
ENDIF
RestArea(aArea)
RETURN(MCTA)