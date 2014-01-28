#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Rfat083()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

Private MDUPL,MNAT,MPREFIXO,MPARC
Private oDlg1, oLbl1, oLbl2, oLbl3, oLbl4
Private oGet1, oGet2, oGet3
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
mPrefixo := Space(3)
mDupl    := Space(9) //MP10
mParc    := Space(1)
mNat     := Space(10)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Interface                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 284,326 To  542,697 Dialog oDlg1 Title OemToAnsi("Alteracao de Natureza")
@ 020,020 Say OemToAnsi("Prefixo")  Size 25,10 Object oLbl1
@ 035,020 Say OemToAnsi("Numero")   Size 25,10 Object oLbl2
@ 050,020 Say OemToAnsi("Parcela")  Size 25,10 Object oLbl3
@ 065,020 Say OemToAnsi("Natureza") Size 25,10 Object oLbl4
@ 020,075 Get mPrefixo Picture "@!" Size 20,10 Object oGet1
@ 035,075 Get mDupl                 Size 30,10 Object oGet2
@ 050,075 Get mParc    Picture "@!" Size 10,10 Object oGet3
@ 065,075 Get mNat                  Size 40,10 F3("SED") Valid(existcpo("SED") .and. naovazio()) Object oGet4 
@ 105,075 BmpButton Type 1 Action R083Proc(oDlg1) 
@ 105,130 BmpButton Type 2 Action Close(oDlg1)
Activate Dialog oDlg1 CENTERED

Return

Static Function R083Proc(oDlg1)

DBSELECTAREA("SE1")

If dbSeek(xfilial("SE1")+MPREFIXO+mDUPL+MPARC)
 	RECLOCK("SE1",.f.)
 	SE1->E1_NATUREZ := MNAT
 	MSUNLOCK()
 	MsgAlert("Titulo: "+mPrefixo+mDupl+mParc+ " Nova Natureza: "+mNat, "Natureza Alterada")
Else
	MsgAlert("Titulo nao Encontrado","Atencao")
EndIf

mPrefixo := Space(3)
mDupl    := Space(9) //MP10
mParc    := Space(1)

oDlg1:refresh()

RETURN