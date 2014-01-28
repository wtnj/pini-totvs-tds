#include "rwmake.ch"      

// Desenvolvido por Danilo C S Pala 20090304
User Function ValidaSE2()
SetPrvt("MRET")
     
DBSELECTAREA("SE2")
DBSETORDER(1) //PARCELA UNICA
IF DBSEEK(XFILIAL("SE2") + "COM" + CNFISCAL + " " + "NF " + CA100FOR + CLOJA) ////E2_FILIAL + E2_PREFIXO + E2_NUM + E2_PARCELA + E2_TIPO + E2_FORNECE + E2_LOJA
	MsgAlert("Este titulo ja existe no contas a pagar! Favor utilizar outro!")     
	MRET:=.F.
ELSE                         
	MRET:=.T.
ENDIF
IF MRET == .T.  //PARCELA A
IF DBSEEK(XFILIAL("SE2") + CSERIE + CNFISCAL + "A" + CESPECIE + CA100FOR + CLOJA) ////E2_FILIAL + E2_PREFIXO + E2_NUM + E2_PARCELA + E2_TIPO + E2_FORNECE + E2_LOJA
	MsgAlert("Este titulo ja existe no contas a pagar! Favor utilizar outro!")     
	MRET:=.F.
ELSE                         
	MRET:=.T.
ENDIF
ENDIF
Return(MRET)