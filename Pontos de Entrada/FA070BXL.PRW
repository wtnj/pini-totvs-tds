#INCLUDE "RWMAKE.CH"
/*   
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA070BXL  ºAutor  ³Marcos Farineli     º Data ³  29/06/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada na baixa por lote                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FA070BXL()
// Ponto de entrada incluido para garantir que todos os titulos incluidos
// em uma baixa por lote tenham o numero gravado.

Local aArea    := GetArea()
Local aAreaSE1 
Local aareaSE5
Local cLoteF    := ""

DbSelectArea("SE1")
aAreaSE1 := GetArea()
DbGoTop()   // SE1 esta filtrado neste momento pelo IndRegua
While !Eof()
	If Dtos(SE1->E1_BAIXA) <> "        "
		If !EMPTY(SE1->E1_LOTE)
			cLoteF := SE1->E1_LOTE
		    Exit
		EndIf		
	EndIf
	DbSelectArea("SE1")
	DbSkip()
End

DbSelectArea("SE1")
DbGoTop()
While !Eof()
	If Dtos(SE1->E1_BAIXA) <> "        " .and. !Empty(cLoteF)
		RecLock("SE1",.f.)
		SE1->E1_LOTE := cLoteF
		MsUnlock()
	EndIf
	DBSelectArea("SE5")
	aAreaSE5 := GetArea()
	DbSetOrder(2)
	If DbSeek(xFilial("SE5")+ "VL"+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO+DTOS(SE1->E1_BAIXA))
	RecLock("SE5",.f.)
	SE5->E5_LOTE := cLoteF
	MsUnlock()
	EndIf
	If SE1->E1_JUROS > 0 // Multa
		If DbSeek(xFilial("SE5")+ "MT"+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO+DTOS(SE1->E1_BAIXA))
		RecLock("SE5",.f.)
		SE5->E5_LOTE := cLoteF
		MsUnlock()
		EndIf	
	EndIf
	RestArea(aAreaSE5)
	DbSelectArea("SE1")
	DbSkip()
End

RestArea(aAreaSE1)
RestArea(aArea)

Return