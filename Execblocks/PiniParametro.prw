#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณJOBPINI01 บAutor  ณDanilo C S Pala     บ Data ณ  20100827   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                 

User Function PiniParametro(cParametro)
Private cQuery 		:= ""
Private cRetorno	:= ""
cQuery := "SELECT NOME, VALOR FROM PiniParametro where NOME='"+ cParametro +"'"
DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PINIPAR", .T., .F. )
DbSelectArea("PINIPAR")
dbGotop()
If !EOF()
	cRetorno :=	PINIPAR->VALOR
Else
	cRetorno :=	nil
EndIf   
DBCloseArea()
Return Alltrim(cRetorno)





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUpdPiniParametroบAutor  ณDanilo C S Pala Data ณ  06/22/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function UpdPiniParametro(cParametro, cValor)
Private cQuery 		:= ""
Private lRetorno	:= .F.
cQuery := "UPDATE PiniParametro SET VALOR='"+ALLTRIM(cValor)+"' where NOME='"+ cParametro +"'"
nUpd :=	TCSQLExec(cQuery)
If nUpd <=0 
	lRetorno := .T.
Else
	lRetorno := .F.
EndIf
Return lRetorno
                          


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCliPiniParametroบAutor  ณDanilo C S Pala Data ณ  06/22/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CliPiniParametro()
Private cQuery 		:= ""
Private cCodCliente	:= ""
Private lCodCli	:= .F.

WHILE lCodCli == .F.
	cQuery := "SELECT NOME, VALOR FROM PiniParametro where NOME='CODCLIENTEPINI'"
	DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PINIPAR", .T., .F. )
	DbSelectArea("PINIPAR")
	dbGotop()
	If !EOF()
		cCodCliente :=	PINIPAR->VALOR
	Else
		cCodCliente :=	nil
	EndIf   
	DBCloseArea()

	if cCodCliente <> nil
		cQuery := "SELECT count(a1_cod) as qtd FROM "+ RETSQLNAME("SA1") +" where A1_FILIAL='"+ XFILIAL("SA1") + "' AND A1_COD='"+ STRZERO(VAL(ALLTRIM(cCodCliente)),6) +"' AND A1_LOJA='01' AND D_E_L_E_T_<>'*'"
		DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PINIPAR", .T., .F. )
		DbSelectArea("PINIPAR")
		dbGotop()
		If !EOF()
			if PINIPAR->QTD >=1
				lCodCli	:= .F. //encontrou, pegar o proximo
			else
				lCodCli	:= .T.	
			endif
		Else
			lCodCli	:= .T.
		EndIf    
		DBCloseArea()
	else
		cCodCliente := "500000" //inicializador padrao
		lCodCli	:= .F.
	endif

	cQuery := "UPDATE PiniParametro SET VALOR='"+ STRZERO( (VAL(ALLTRIM(cCodCliente))+1) ,6) +"' where NOME='CODCLIENTEPINI'"
	nUpd :=	TCSQLExec(cQuery)
end
Return Alltrim(cCodCliente)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณForPiniParametroบAutor  ณDanilo C S Pala Data ณ  20130823   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ForPiniParametro()
Private cQuery 		:= ""
Private cCodFor	:= ""
Private lCodFor	:= .F.

WHILE lCodFor == .F.
	cQuery := "SELECT NOME, VALOR FROM PiniParametro where NOME='CODFORNECEDORPINI'"
	DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PINIPAR", .T., .F. )
	DbSelectArea("PINIPAR")
	dbGotop()
	If !EOF()
		cCodFor :=	PINIPAR->VALOR
	Else
		cCodFor :=	nil
	EndIf   
	DBCloseArea()

	if cCodFor <> nil
		cQuery := "SELECT count(A2_COD) as QTD FROM "+ RETSQLNAME("SA2") +" WHERE A2_FILIAL='"+ XFILIAL("SA2") + "' AND A2_COD='"+ STRZERO(VAL(ALLTRIM(cCodFor)),6) +"' AND A2_LOJA='01' AND D_E_L_E_T_<>'*'"
		DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PINIPAR", .T., .F. )
		DbSelectArea("PINIPAR")
		dbGotop()
		If !EOF()
			if PINIPAR->QTD >=1
				lCodFor	:= .F. //encontrou, pegar o proximo
			else
				lCodFor	:= .T.	
			endif
		Else
			lCodFor	:= .T.
		EndIf    
		DBCloseArea()
	else
		cCodFor := "004633" //inicializador padrao
		lCodFor	:= .F.
	endif

	cQuery := "UPDATE PiniParametro SET VALOR='"+ STRZERO( (VAL(ALLTRIM(cCodFor))+1) ,6) +"' where NOME='CODFORNECEDORPINI'"
	nUpd :=	TCSQLExec(cQuery)
end
Return Alltrim(cCodFor)