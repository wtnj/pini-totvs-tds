#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPINILOGP3 บAutor  ณDANILO C S PALA     บ Data ณ  20110518   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PINI                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
USER FUNCTION PINILOGP3(cCliente, cLoja, cSerie, cDoc, cItem, cProd, cTipo, cObs, cCliLog, cLojaLog, cSerLog, cDocLog, cPedLog, cTransf, nQtdLog)
DBSELECTAREA("ZY5")
Reclock("ZY5",.T.)
	REPLACE ZY5_FILIAL	WITH XFILIAL("ZY5")
	REPLACE ZY5_CLIENT	WITH cCliente
	REPLACE ZY5_LOJA	WITH cLoja
	REPLACE ZY5_SERIE	WITH cSerie
	REPLACE ZY5_DOC 	WITH cDoc
	REPLACE ZY5_ITEM	WITH cItem
	REPLACE ZY5_PROD	WITH cProd
	REPLACE ZY5_TIPO	WITH cTipo
	REPLACE ZY5_OBS 	WITH cObs
	REPLACE ZY5_CLILOG	WITH cCliLog
	REPLACE ZY5_LOJALO	WITH cLojaLog
	REPLACE ZY5_SERLOG	WITH cSerLog
	REPLACE ZY5_DOCLOG	WITH cDocLog
	REPLACE ZY5_PEDLOG	WITH cPedLog
	REPLACE ZY5_TRANSF	WITH cTransf
	REPLACE ZY5_QTDLOG	WITH nQtdLog
	REPLACE ZY5_USUARI	WITH substr(cUsuario,7,15)
	REPLACE ZY5_DATALO	WITH dtos(date()) + " " + time()
MSUnlock()
RETURN