#INCLUDE 'RWMAKE.CH'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA200FIL  ºAutor  ³Microsiga           º Data ³  05/09/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para localizacao do titulo pelo nosso      º±±
±±º          ³numero bancario na baixa por CNAB                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5 - FINA200 -                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
USER FUNCTION FA200FIL()

LOCAL _cNsNum   := Padr(Alltrim(cNsNum),15) 
LOCAL aAreaSE1  := GetArea()
LOCAL nIndex    := IndexOrd()
LOCAL _cBco     := cBanco
LOCAL _cAgencia := SEE->EE_AGENCIA
LOCAL _cConta   := SEE->EE_CONTA

cNumTit := SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA
cEspecie:= SE1->E1_TIPO

DbSelectArea("SE1")
DbOrderNickName("E1_NUMBCO")  // dbSetOrder(25) 20130226   // indice pelo nosso numero bancario //mp10 era 18 //20100413 DbSetOrder(24)

If	dbSeek(xFilial("SE1") + _cNsNum + _cBco)
	While !eof() .and. Alltrim(_cNsNum)==Alltrim(SE1->E1_NUMBCO) .and. Alltrim(_cBco)==Alltrim(SE1->E1_PORTADO)
		If Alltrim(SE1->E1_CONTA)<>Alltrim(_cConta) .and. Alltrim(SE1->E1_AGEDEP)<>Alltrim(_cAgencia)
			DBSelectArea("SE1")
			DbSkip()
	    Else
	    	Exit
	    EndIf
	End
	If Alltrim(_cBco)<>Alltrim(SE1->E1_PORTADO) .or. Alltrim(SE1->E1_CONTA)<>Alltrim(_cConta) .or. Alltrim(SE1->E1_AGEDEP)<>Alltrim(_cAgencia)
		RestArea(aAreaSE1)
	EndIf
	cNumTit  := SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA
	cEspecie := SE1->E1_TIPO
	DbSelectArea("SE1")
	DbSetOrder(nIndex)
Else
	RestArea(aAreaSE1)
Endif
	
Return