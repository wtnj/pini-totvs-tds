#INCLUDE "RWMAKE.CH"
User Function LPF0101D()
Local mcta := ''   
DbSelectArea("ZZR")
DbSetOrder(2)
DbSeek(xFilial("ZZR")+SRZ->RZ_PD+SRZ->RZ_CC)
If Found()
	MCTA := ZZR->ZZR_CONTAD
Else
	MCTA := "CC INVALIDO"
ENDIF
RETURN(MCTA)