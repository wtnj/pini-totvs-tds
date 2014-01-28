#include "rwmake.ch" 
User Function Fa070mdb()
// Ponto de entrada para modificação dos dados da baixa
Private lRet

lRet:=.T.

IF SE1->E1_SITUACA#'0' .AND. SE1->E1_PORTADO#'920' .and. cMotBx=='CAN'
   ALERT("TRANSFERIR TITULO PARA CARTEIRA")
   lRet:=.F.
ENDIF

Return(lRet)