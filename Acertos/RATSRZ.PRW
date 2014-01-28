#INCLUDE "RWMAKE.CH"
User Function RATSRZ()

Private lEnd, cArqtemp1, mChave,mconta,mNum,mLinha

lEnd:= .F.

Processa({|lEnd| ProcSRZ(@lEnd)})

Return

Static Function ProcSRZ()

cArqTemp1 := "AN"
dbUseArea( .T.,, cArqTemp1,"TMP", if(.F. .OR. .F., !.F., NIL), .F. )
dbSelectArea("TMP")
WHILE !EOF() .and. !lEnd
	IncProc("Lendo Registro " + Str(recno(),6,0))
   	RecLock("TMP",.F.)
	DbDelete() 
	MsUnlock()  
	DbSkip()
Enddo
If SM0->M0_CODIGO='01'
   APPEND FROM ANEP
ENDIF   
If SM0->M0_CODIGO='02'
   APPEND FROM ANPS
ENDIF
If SM0->M0_CODIGO='03'
   APPEND FROM ANBP
ENDIF 
DbGoTop()

ProcRegua(RecCount())
                         
mconta:=0
WHILE !EOF() .and. !lEnd
	IncProc("Lendo Registro " + Str(recno(),6,0)+"Atualizados.."+Str(mconta,7,0))
	mChave :=TMP->VELHO
	DbSelectArea("SRZ")
	DbSetOrder(1)
	DbGoTop()
	If DbSeek(xFilial("SRZ")+MCHAVE) 
	   If RZ_CC==TMP->VELHO
          RecLock("SRZ",.F.)
	      SRZ->RZ_CC := TMP->NOVO
	      MsUnlock()
	       
	      RecLock("TMP",.F.)
     	  TMP->ATUALIZOU:='S' 
       	  MsUnlock()          
       	  MCONTA++
	   Endif
	Endif
	DbSelectArea("TMP")
	DBSKIP()
END 
MSGALERT("ATUALIZOU....."+STR(MCONTA,7,0))

DbSelectArea("TMP")
If SM0->M0_CODIGO='01'
   COPY TO ATANEP
ENDIF   
If SM0->M0_CODIGO='02'
  COPY TO ATANPS
ENDIF
If SM0->M0_CODIGO='03'
   COPY TO ATANBP
ENDIF 
DbCloseArea()
                
DbSelectArea("SRZ")
RetIndex("SRZ")
Return