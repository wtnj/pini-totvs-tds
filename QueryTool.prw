#include "rwmake.ch"
#include "ap5mail.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*   Danilo C S Pala, 20040929
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณQueryTool บAutor  ณDanilo C S Pala     บ Data ณ  20030812   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Pedido de Software Siga, programa para appendar os clientesบฑฑ
ฑฑบ          ณ  cadastrados pelo PSWeb									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function QueryTool
Private _cTitulo  := "Integracao do PSWeb/PSIntranet com PSSiga:Appendar"
Private ctexto := "Appendar"
Private cTexto1 := "Visualizar"
Private cTexto2 := "Fechar"
Private cQuery := space(800)


@ 010,001 TO 210,800 DIALOG oDlg TITLE _cTitulo
@ 020,010 SAY "Query:"
@ 020,070 GET cQuery
@ 080,110 BUTTON "Consultar" SIZE 40,11 ACTION   Processa({||Visualizar()})
@ 100,120 BUTTON "sair" SIZE 40,15 Action ( Close(oDlg) )
Activate Dialog oDlg CENTERED
return

Static Function Visualizar()
setprvt("aCampos")
DbselectArea("SA1")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif
DbClosearea("SA1")

TCQUERY cQuery NEW ALIAS "QUERY"

@ 200,001 TO 400,600 DIALOG oDlg1 TITLE "query"
@ 6,5 TO 100,250 BROWSE "Query" FIELDS aCampos
@ 070,260 BUTTON "_Ok" SIZE 40,15 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED

DBCloseArea("Query")
RETURN
