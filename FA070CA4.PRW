#INCLUDE "RWMAKE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA070CA4  ºAutor  ³Marcos Farineli     º Data ³  07/31/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FA070CA4()

Private cCombo := "Simples Cancelamento"
Private aCombo := {"Simples Cancelamento","1a devolucao","2a devolucao"}                                                              

@ 268,297 To 370,701 Dialog oDlg1 Title OemToAnsi("Informe o motivo do Cancelamento")
@ 012,010 Say OemToAnsi("Motivo do Cancelamento") Size 70,10
@ 012,090 ComboBox cCombo Items aCombo Size 80,21
@ 030,135 BmpButton Type 1 Action Fa070Ca4Proc(oDlg1)
Activate Dialog oDlg1 Centered

Return(.t.)

Static Function Fa070Ca4Proc(oDlg1)

Close(oDlg1)

If cCombo == "1a devolucao"
	DbSelectArea("SE1")
	RecLock("SE1",.f.)
	SE1->E1_DTAL11 := dDatabase
	SE1->E1_DTAL12 := stod("")
	SE1->E1_ALINEA := "1"
	MsUnlock()
ElseIf cCombo == "2a devolucao"
	DbSelectArea("SE1")
	RecLock("SE1",.f.)
	SE1->E1_DTAL12 := dDatabase
	SE1->E1_ALINEA := "2"
	MsUnlock()	
Else
	DbSelectArea("SE1")
	RecLock("SE1",.f.)
	SE1->E1_ALINEA := " "
	MsUnlock()		
EndIf

Return