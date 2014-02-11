#INCLUDE "Protheus.ch"

User Function RVPLR01()

	If ! SRC->(DBSEEK(xFilial("SRC") + SRC->RC_MAT + "108" ))
	
		fGeraVerba("108", 100, 10,, SRA->RA_CC, "V", , 0, , , .T.,,,)
		
	EndIf 

Return