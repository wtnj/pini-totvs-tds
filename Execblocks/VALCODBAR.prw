/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVALCCODBARบAutor  ณDANILO C S PALA     บ Data ณ  20120124   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ RETORNA O NUMERO DO CODIGO DE BARRA CONFORME LAYOUT DO     บฑฑ
ฑฑบ          ณSANTANDER PARA SISPAG    									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PINI                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VALCODBAR(cCODBAR)
Local cRetorno  := ""
Local cSEG_A  := ""
Local cSEG_B  := ""
Local cSEG_C  := ""
Local cSEG_D  := ""
Local cSEG_E  := ""
   
IF len(alltrim(cCodBar))== 47
	cSEG_A := SUBSTR(cCODBAR,1,3)
	cSEG_B := SUBSTR(cCODBAR,4,1)
	cSEG_C := SUBSTR(cCODBAR,5,5) + SUBSTR(cCODBAR,11,10) + SUBSTR(cCODBAR,22,10)
	cSEG_D := SUBSTR(cCODBAR,33,1)
	cSEG_E := SUBSTR(cCODBAR,34,14)
	cRetorno := cSEG_A + cSEG_B + cSEG_D + cSEG_E + cSEG_C
ELSE            
	cRetorno := cCODBAR
ENDIF

RETURN(cRetorno)