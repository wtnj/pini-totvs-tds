#INCLUDE "RWMAKE.CH"
User Function RATCT5()

Private lEnd, cArqtemp1, mChave

lEnd:= .F.

Processa({|lEnd| ProcCT5(@lEnd)})

Return

Static Function ProcCT5()

cArqTemp1 := "LP"
dbUseArea( .T.,, cArqTemp1,"TMP", if(.F. .OR. .F., !.F., NIL), .F. )

dbSelectArea("TMP")
DbGoTop()

ProcRegua(RecCount())

WHILE !EOF() .and. !lEnd
	IncProc("Lendo Registro " + Str(recno(),6,0))
	mChave :=TMP->CODIGO+TMP->SEQ
	DbSelectArea("CT5")
	DbSetOrder(1)
	DbGoTop()
	If DbSeek(xFilial("CT5")+MCHAVE)
	   RecLock("CT5",.F.)
	   CT5->CT5_DEBITO := TMP->DEBITO
	   CT5->CT5_CREDITO:= TMP->CREDITO
	   MsUnlock()
	Endif
	DbSelectArea("TMP")
	DBSKIP()
END

DbSelectArea("TMP")
DbCloseArea()
                
DbSelectArea("CT5")
RetIndex("CT5")
Return