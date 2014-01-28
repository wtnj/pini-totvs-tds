#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"

/*/  Criado por Danilo C S Pala em 20090625: ANDRE
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ 20090625 ³ VALOR TOTAL DO BORDERO BAIXADO VIA BAIXA AUTOMATICA     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function VALBXAT()
Local nVLBX:=0
Local aArea := GetArea()
Local cquery := space(500)
Local aArea := GetArea()
Public cPesquisa := space(1)

DbSelectArea("SE2")
IF !EMPTY(SE2->E2_NUM) .AND. !EOF()
    /*
	cquery := "SELECT E2_PREFIXO, E2_NUM, E2_PARCELA FROM "+ RetSqlName("SE2") +" SE2 WHERE E2_FILIAL='"+ XFILIAL("SE2") +"' and E2_NUMBOR='"+ SE2->E2_NUMBOR +"' and E2_OK<>'  ' AND D_E_L_E_T_<>'*' ORDER BY E2_FILIAL, E2_VENCREA, E2_NOMFOR, E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO"
	//cquery := "SELECT E2_PREFIXO, E2_NUM, E2_PARCELA FROM "+ RetSqlName("SE2") +" SE2 WHERE E2_FILIAL='"+ XFILIAL("SE2") +"' and E2_NUMBOR='"+ SE2->E2_NUMBOR +"' and E2_OK<>'  ' AND D_E_L_E_T_<>'*' ORDER BY E2_FILIAL DESC, E2_VENCREA DESC, E2_NOMFOR DESC, E2_PREFIXO DESC, E2_NUM DESC, E2_PARCELA DESC, E2_TIPO DESC"
	//cquery := "SELECT COUNT(E2_NUMBOR) QTD FROM "+ RetSqlName("SE2") +" SE2 WHERE E2_FILIAL='"+ XFILIAL("SE2") +"' and E2_NUMBOR='"+ SE2->E2_NUMBOR +"' and E2_OK<>'  ' AND D_E_L_E_T_<>'*' GROUP BY E2_NUMBOR"
	TCQUERY cQuery NEW ALIAS "VLBXAT"
	DbSelectArea("VLBXAT")
	DBGOTOP()
	IF SE2->E2_PREFIXO==VLBXAT->E2_PREFIXO .AND. SE2->E2_NUM==VLBXAT->E2_NUM .AND. SE2->E2_PARCELA == VLBXAT->E2_PARCELA //PRIMEIRO TITULO A SER BAIXADO DESTE BORDERO DOS SELECIONADOS(E2_OK)
	*/
	cPesquisa := PesqBXAT(SE2->E2_NUMBOR)
		//IF cNUMBOR <> SE2->E2_NUMBOR
		IF cPesquisa == "N"
			cquery := "SELECT E2_NUMBOR, SUM(E2_VALOR) AS VALOR from "+ RetSqlName("SE2") +" SE2 WHERE E2_FILIAL='"+ XFILIAL("SE2") +"' and E2_NUMBOR='"+ SE2->E2_NUMBOR +"' and E2_OK<>'  ' AND D_E_L_E_T_<>'*' GROUP BY E2_NUMBOR"
			TCQUERY cQuery NEW ALIAS "TBVALOR"
			DbSelectArea("TBVALOR")
			DBGOTOP()
			nVLBX := TBVALOR->VALOR + SE2->E2_VALOR
			DBCLOSEAREA("TBVALOR")
			//cNUMBOR := SE2->E2_NUMBOR
		ELSE
			//cBORDBX := "S"
			nVLBX:=0
		ENDIF
	/*ELSE
		nVLBX:=0
	ENDIF
	DbSelectArea("VLBXAT")
	DBCLOSEAREA("VLBXAT")*/

	cquery := "SELECT COUNT(E2_NUMBOR) QTD FROM "+ RetSqlName("SE2") +" SE2 WHERE E2_FILIAL='"+ XFILIAL("SE2") +"' and E2_NUMBOR='"+ SE2->E2_NUMBOR +"' and E2_OK<>'  ' AND D_E_L_E_T_<>'*' GROUP BY E2_NUMBOR"
	TCQUERY cQuery NEW ALIAS "QTDBOR"
	DbSelectArea("QTDBOR")
	DBGOTOP()
	IF QTDBOR->QTD = 0 //limpar o bordero da sessao no borbxat
		//cNUMBOR := SPACE(6)
		PesqBXAT(SPACE(6))
	ENDIF
	DbSelectArea("QTDBOR")
	DBCLOSEAREA("QTDBOR")   
//ELSE
	//cNUMBOR := SPACE(6)
	//PesqBXAT(SPACE(6))
ENDIF

RestArea(aArea)
Return(nVLBX)
             



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º Pesquisa bordero para este login                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PesqBXAT(cBORDERO) //LER O ARQUIVO BORBXAT
	Local achou := "N"
	Local novo := "S"
	cArq      := '\SIGA\BORBXAT.DTC'//20121106 era dbf
	dbUseArea(.T.,,cArq,"BORBXAT")
	cIndex    := CriaTrab(Nil,.F.)
	cKey      := "LOGIN+BORDERO"
	cFiltro   := ""
	Indregua("BORBXAT",cIndex,ckey,,cFiltro,"Selecionando Registros do Arq")
	
	//PESQUISA LOGIN SM0->M0_CODIGO + ALLTRIM(CUSERNAME)
	WHILE !EOF() .AND. ALLTRIM(BORBXAT->LOGIN) <= ALLTRIM(SM0->M0_CODIGO + ALLTRIM(CUSERNAME))
		IF ALLTRIM(BORBXAT->LOGIN) == ALLTRIM(SM0->M0_CODIGO + ALLTRIM(CUSERNAME)) //achou o login
			novo := "N"
			if BORBXAT->BORDERO == cBORDERO //achou o mesmo bordero
				achou := "S"
			else //nao achou este bordero
				achou := "N"
				RECLOCK("BORBXAT",.F.) //update .F.
					BORBXAT->BORDERO  := cBORDERO
				MSUNLOCK()
			endif          
			EXIT //SAIR DO WHILE
		ELSE
			achou := "N"
			novo := "S"
		ENDIF           
		DBSkip()
	END	
	IF  novo=="S"
		RECLOCK("BORBXAT",.T.) //insert .T.
			BORBXAT->LOGIN 	  := substr(ALLTRIM(SM0->M0_CODIGO + ALLTRIM(CUSERNAME)),1,20)
			BORBXAT->BORDERO  := cBORDERO
		MSUNLOCK()
	end if 
	DbSelectArea("BORBXAT")
	DBCLOSEAREA("BORBXAT")
return(achou)
