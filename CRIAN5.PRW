USER FUNCTION CRIAN5()
DBSELECTAREA("SN3")
DBSETORDER(0)
DBGOTOP()
DO WHILE !EOF()
	IF year(SN3->N3_AQUISIC)==2002
	   	DBSELECTAREA("SN3")
	   	DBSKIP()
	   	LOOP
	ENDIF
	IF !EMPTY(SN3->N3_DTBAIXA) .and. year(sn3->n3_dtbaixa)<2002
	
	   	DBSELECTAREA("SN3")
	   	DBSKIP()
	   	LOOP
	ENDIF
	DBSELECTAREA("SN5")
	DBSETORDER(1)
	DBSEEK(XFILIAL()+SN3->N3_CCONTAB)
	IF !FOUND()
		RECLOCK("SN5",.T.)
		SN5->N5_FILIAL := "01"
		SN5->N5_CONTA  := SN3->N3_CCONTAB
		SN5->N5_DATA   := CTOD("01/01/02")
		sn5->n5_tipo   := "0"
		SN5->N5_TAXA   := .8287
		MSUNLOCK("SN5")
	ENDIF
	RECLOCK("SN5",.F.)
	sn5->n5_valor1 := SN5->N5_VALOR1+sn3->n3_vorig1+sn3->n3_VRCACM1
	sn5->n5_valor2 := SN5->N5_VALOR2+sn3->n3_vorig2
	sn5->n5_valor3 := SN5->N5_VALOR3+sn3->n3_vorig3
	sn5->n5_valor4 := SN5->N5_VALOR4+sn3->n3_vorig4
	sn5->n5_valor5 := SN5->N5_VALOR5+sn3->n3_vorig5
	MSUNLOCK()
	DBSELECTAREA("SN5")
	DBSETORDER(1)
	DBSEEK(XFILIAL()+SN3->N3_CCDEPR)
	IF !FOUND()
		RECLOCK("SN5",.T.)
		SN5->N5_FILIAL := "01"
		SN5->N5_CONTA  := SN3->N3_CCDEPR
		SN5->N5_DATA   := CTOD("01/01/02")
		sn5->n5_tipo   := "0"
		SN5->N5_TAXA   := .8287
		MSUNLOCK("SN5")
	ENDIF
	RECLOCK("SN5",.F.)
	sn5->n5_valor1 := SN5->N5_VALOR1+sn3->n3_vRDACM1
	sn5->n5_valor2 := SN5->N5_VALOR2+sn3->n3_vRDACM2
	sn5->n5_valor3 := SN5->N5_VALOR3+sn3->n3_vRDACM3
	sn5->n5_valor4 := SN5->N5_VALOR4+sn3->n3_vRDACM4
	sn5->n5_valor5 := SN5->N5_VALOR5+sn3->n3_vRDACM5
	MSUNLOCK()
	DBSELECTAREA("SN3")
	DBSKIP()
ENDDO