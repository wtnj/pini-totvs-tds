#include "rwmake.ch"
#include "ap5mail.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPfin029   บAutor ณDanilo C S Pala     บ Data ณ  20120126   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ บฑฑ
ฑฑบ          ณ                        									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function pfin029()
Local mRet := .f.

Private _cTitulo  := "Converter codigo de barras"
Private ctexto := "Executar"
Private cTexto1 := "Executar"
Private cTexto2 := "Fechar"
Private cCodbar := space(48)
Private cNovo := space(44)
Private lExec := .F.


@ 010,001 TO 210,400 DIALOG oDlg TITLE _cTitulo
@ 020,010 SAY "Codigo de barras:"
@ 020,050 GET cCodbar
@ 040,010 SAY "Novo codigo de barras:"
@ 040,050 GET cNovo
@ 080,020 BUTTON "Executar" SIZE 40,11 ACTION (lExec := .T., Proccodbar(cCodbar))
@ 080,080 BUTTON "Sair" SIZE 40,11 Action (lExec := .F.,Close(oDlg))
Activate Dialog oDlg CENTERED      

return

Static Function Proccodbar(cCodbar)
	cNovo :=  u_valcodbar(cCodbar)
Return


