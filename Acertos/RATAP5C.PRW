#INCLUDE "RWMAKE.CH"
User Function AcPW()

Private lEnd, cArqtemp1, mChave

lEnd:= .F.

Processa({|lEnd| ProcSE1(@lEnd)})

Return

Static Function ProcSE1()

cArqTemp1 := "SE1PWBX.DBF"
dbUseArea( .T.,, cArqTemp1,"TMP", if(.F. .OR. .F., !.F., NIL), .F. )

dbSelectArea("TMP")
DbGoTop()

ProcRegua(RecCount())

WHILE !EOF() .and. !lEnd
	IncProc("Lendo Registro " + Str(recno(),6,0))
	mChave := TMP->E1_PREFIXO+TMP->E1_NUM+TMP->E1_PARCELA+TMP->E1_TIPO
	DbSelectArea("SE1")
	DbSetOrder(1)
	DbGoTop()
	If DbSeek(xFilial("SE1")+MCHAVE)
		//DbSelectArea("TMP")
		If DTOS(TMP->E1_BAIXA) <> "        "
			If DTOS(TMP->E1_BAIXA) <> DTOS(SE1->E1_BAIXA)
				If MsgYesNo(TMP->E1_PREFIXO+TMP->E1_NUM+TMP->E1_PARCELA+"/"+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)
					RecLock("SE1",.F.)
					SE1->E1_BAIXA := TMP->E1_BAIXA
					SE1->E1_DTALT := TMP->E1_DTALT
					SE1->E1_SALDO := TMP->E1_SALDO
					MsUnlock()
				EndIf
		    EndIf
		EndIf
	Endif
	DbSelectArea("TMP")
	DBSKIP()
END

DbSelectArea("TMP")
DbCloseArea()

Return