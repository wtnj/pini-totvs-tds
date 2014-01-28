#INCLUDE "RWMAKE.CH"
User Function RAass()
  Private lEnd, cArqtemp1, mChave,mStatus,mEdicao
  lEnd:= .F.
  Processa({|lEnd| ProcAss(@lEnd)})
Return


Static Function ProcAss()

cArqTemp1 := "OPTMKT.DBF"
dbUseArea( .T.,, cArqTemp1,"TMP", if(.F. .OR. .F., !.F., NIL), .F. )

dbSelectArea("TMP")
DbGoTop()

ProcRegua(RecCount())

DO WHILE !EOF() .and. !lEnd
	IncProc("Lendo Registro " + Str(recno(),6,0))
	mChave :=TMP->NOVO_PED+'01'
	DbSelectArea("SC6")
	DbSetOrder(1)
	DbGoTop()
	If DbSeek(xFilial("SC6")+MCHAVE) 
	   If TMP->ZZ6_STATUS='AT'
	      mStatus:='AA'
	      mEdicao:=SC6->C6_EDFIN
	   Endif         
	   
	   If TMP->ZZ6_STATUS='S '
	      mStatus:='SU'
	      mEdicao:=SC6->C6_EDINIC	      
	   Endif         
	   
	   RecLock("SC6",.F.)
	   SC6->C6_SITUAC:=mStatus
	   sc6->C6_EDSUSP:=mEdicao
	   MsUnlock()
	Endif  
	dbSelectArea("TMP")
	DBSKIP()      
ENDDO

DbSelectArea("TMP")
DbCloseArea()     

DbSelectArea("SA1")
RetIndex("SA1")  
Return