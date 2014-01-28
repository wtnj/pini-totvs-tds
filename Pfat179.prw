#include "rwmake.ch"
#include "ap5mail.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*   Danilo C S Pala, 20040929
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPfat179   บAutor  ณDanilo C S Pala     บ Data ณ  20081023   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Executar o programa especificado                           บฑฑ
ฑฑบ          ณ                        									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Pfat179()
Private _cTitulo  := "Executar a rotina especificada"
Private ctexto := "Executar"
Private cTexto1 := "Executar"
Private cTexto2 := "Fechar"
Private cQuery := space(80)
Private dData1 := nil


@ 010,001 TO 210,400 DIALOG oDlg TITLE _cTitulo
@ 020,010 SAY "Rotina:"
@ 020,040 GET cQuery
@ 080,020 BUTTON "Executar" SIZE 40,11 ACTION   Processa({||Visualizar()})
//@ 080,080 BUTTON "Sair" SIZE 40,11 Action ( Close(oDlg) )
Activate Dialog oDlg CENTERED
return

Static Function Visualizar()
	try
		if alltrim(cQuery) == "X"
			u_AjusteVencto("UNI", "033146   ", "412945", "01")
		elseif alltrim(cQuery) == "Y"
			u_jobpini2("TELA")
		elseif alltrim(cQuery) == "D"
			MsgAlert("Data: "+ dtoc(stod("")))
		else
			ExecBlock(cQuery)
		endif
	catch e as IdxException
		ConOut( ProcName() + " " + Str(ProcLine()) + " " + e:cErrorText )
	end try
	
RETURN
