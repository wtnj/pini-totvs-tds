#INCLUDE "RWMAKE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjBord()  ºAutor  ³Marcos Farineli     º Data ³  17/06/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ajusta borderos errados                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AjBord()

If MsgYesNo("Confirma Processamento?","Bordero 000623")
	Processa({|| AjProc()})
EndIf

Return

Static Function AjProc()

DbSelectArea("SA6")
DbSetOrder(1)
If DbSeek(xFilial("SA6")+"677")
	cBanco   := SA6->A6_COD
	cAgencia := SA6->A6_AGENCIA	
	cConta   := SA6->A6_NUMCON
Else
	Return
EndIf		

If !MsgYesNo("Banco: "+cBanco+" Ag: "+cAgencia+" Conta: "+cConta)
	Return
EndIf	

DbSelectArea("SE1")
DbSetOrder(5)
If DbSeek(xFilial("SE1")+"000623")
	ProcRegua(200)
	While !Eof() .and. Alltrim(SE1->E1_NUMBOR) == "000623"
		DbSelectArea("SE1")
		RecLock("SE1",.f.)
		SE1->E1_PORTADO := cBanco
		SE1->E1_AGEDEP  := cAgencia
		SE1->E1_CONTA   := cConta
		MsUnlock()
		DbSkip()
		IncProc()		
	End
EndIf	
	
DbSelectArea("SEA")
DbSetOrder(1)
If DbSeek(xFilial("SEA")+"000623")
	ProcRegua(200)
	While !Eof() .and. Alltrim(SEA->EA_NUMBOR) == "000623"
		DbSelectArea("SEA")
		RecLock("SEA",.f.)
		SEA->EA_PORTADO := cBanco
		SEA->EA_AGEDEP  := cAgencia
		SEA->EA_NUMCON  := cConta
		DbSkip()
		MsUnlock()		
		IncProc()
	End	
EndIf

MsgInfo("Processamento Concluido")

Return