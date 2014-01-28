#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SZ5CEP	ºAutor  ³Danilo C S Pala     º Data ³  20060627   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ º±±
±±º          ³ º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function SZ5CEP(CEP, COLUNA)
Local RETORNO  := space(60)

DBSELECTAREA("SZ0")
DBSETORDER(1)                               
IF DBSEEK(XFILIAL("SZ0")+CEP)
	IF COLUNA = "Z5_END"  
		RETORNO = ALLTRIM(SZ0->Z0_TIPO) + " " + ALLTRIM(SZ0->Z0_END)
	ELSEIF COLUNA = "Z5_LOGR"
		RETORNO = ALLTRIM(SZ0->Z0_END)
	ELSEIF COLUNA = "Z5_TPLOG"	
		RETORNO = ALLTRIM(SZ0->Z0_TIPO)
	ELSEIF COLUNA = "Z5_CIDADE"	   
		RETORNO = ALLTRIM(SZ0->Z0_MUN)
	ELSEIF COLUNA = "Z5_BAIRRO"	   
		RETORNO = ALLTRIM(SZ0->Z0_BAIRRO)
	ELSEIF COLUNA = "Z5_ESTADO"	       
		RETORNO = ALLTRIM(SZ0->Z0_UF)
	ELSE 
		RETORNO = ""
	ENDIF
ELSE                         
	RETORNO = ""
ENDIF

return (RETORNO)