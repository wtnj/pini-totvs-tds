#INCLUDE "RWMAKE.CH"
User Function AcPW()

Private lEnd, cArqtemp1, mChave

lEnd:= .F.

Processa({|lEnd| ProcSE1(@lEnd)})

Return

Static Function ProcSE1()

cArqTemp1 := "SAIDA.DBF"
dbUseArea( .T.,, cArqTemp1,"TMP", if(.F. .OR. .F., !.F., NIL), .F. )

dbSelectArea("TMP")
DbGoTop()

ProcRegua(RecCount())

WHILE !EOF() .and. !lEnd
	IncProc("Lendo Registro " + Str(recno(),6,0))
	mChave := TMP->SERIE+NOTA
	DbSelectArea("SF3")
	DbSetOrder(5)
	DbGoTop()
	If DbSeek(xFilial("SF3")+MCHAVE,.T.)
	   RecLock("SF3",.F.)
	   DbDelete()				
       MsUnlock()
	Endif
	DbSelectArea("TMP")
	DBSKIP()
END

DbSelectArea("TMP")
DbCloseArea()

Return