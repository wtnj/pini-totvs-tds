#INCLUDE "RWMAKE.CH"
User Function LPSEH03() //HISTORICO APLICACAO
// ANDRE/JOSE RICARDO, Danilo C S Pala 20100208 
Local MHIST  := space(40) // ''
Local mBco := space(20)
Local aArea := GetArea()
IF SEH->EH_APLEMP ="APL"
   dbselectarea("SA6") 
   DBGOTOP()
   dbsetorder(1)
   dbseek(xfilial("SA6")+SEH->EH_BANCO+SEH->EH_AGENCIA+SEH->EH_CONTA)           //banco, pois deve sair a conta de origem
   If Found()
      MBCO:="APLIC "+ ALLTRIM(SE9->E9_DESTIP)+ "/"+ ALLTRIM(SA6->A6_NREDUZ) +"/"+ ALLTRIM(SA6->A6_NUMCON)
   Endif         
ENDIF   
   RestArea(aArea)
RETURN(MBCO)