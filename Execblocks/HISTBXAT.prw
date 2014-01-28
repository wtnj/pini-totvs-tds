#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"

/*/  Criado por Danilo C S Pala em 20090624: ANDRE
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ 16/03/02 ³ HISTORICO DA BAIXA AUTOMATICA                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function HISTBXAT()
Local mHIST:=SPACE(40)
Local aArea := GetArea()
Local cquery := space(500)

Local aArea := GetArea()
DbSelectArea("SE2")
IF TRIM(SE2->E2_HIST) <>""
	MHIST := SUBSTR(TRIM(SA2->A2_NREDUZ)+'/NF '+TRIM(SE2->E2_NUM)+TRIM(SE2->E2_PARCELA)+'/'+TRIM(SE2->E2_HIST),1,40)
ELSE                       
	cquery := "SELECT D1_DESCRI FROM "+ RetSqlName("SF1") +" SF1, "+ RetSqlName("SD1") +" SD1 WHERE F1_FILIAL='"+ XFILIAL("SF1") +"' AND D1_FILIAL='"+ XFILIAL("SD1") +"' AND F1_DOC=D1_DOC AND F1_SERIE=D1_SERIE AND F1_FORNECE=D1_FORNECE AND F1_LOJA=F1_LOJA AND F1_DOC='"+ SE2->E2_NUM +"' AND F1_PREFIXO='"+ SE2->E2_PREFIXO +"' AND F1_FORNECE='"+ SE2->E2_FORNECE +"' AND F1_LOJA='"+ SE2->E2_LOJA +"' AND F1_EMISSAO='"+ DTOS(SE2->E2_EMISSAO) +"' AND SF1.D_E_L_E_T_<>'*' AND SD1.D_E_L_E_T_<>'*'"
	TCQUERY cQuery NEW ALIAS "HISTBXAT"
	DbSelectArea("HISTBXAT")
	DBGOTOP()
	MHIST := SUBSTR(TRIM(SA2->A2_NREDUZ)+'/NF '+TRIM(SE2->E2_NUM)+TRIM(SE2->E2_PARCELA)+'/'+TRIM(HISTBXAT->D1_DESCRI),1,40)
	DBCLOSEAREA("HISTBXAT")
ENDIF

RestArea(aArea)

Return(MHIST)