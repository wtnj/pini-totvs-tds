/*/                                                                    
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ 16/03/02 ³ Execblock utilizado na contab NFE CONTA DEBITO DEVOLUCAO³±±
±±³          | DANILO C S PALA E JOSE RICARDO VALENGA                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CONTADDEV()

Local mCONTA  := SPACE(11)
Local aArea := GetArea()

IF SB1->B1_TIPO ="LI" 
	MCONTA := "11030102001"
ELSEIF SB1->B1_TIPO ="LC" 
	MCONTA := "11030102002" 
ELSEIF SB1->B1_TIPO ="CD" .AND. !("TCPO" $ B1_DESC) .AND. !("MODELAT" $ B1_DESC)//CD PINI
	MCONTA := "11030104001"
ELSEIF SB1->B1_TIPO ="DC" 
	MCONTA := "11030104002"
ELSEIF SB1->B1_TIPO ="TC" 
	MCONTA := "11030106001"	
ELSEIF SB1->B1_TIPO =="CD" .AND. "TCPO" $ B1_DESC .AND. !("MODELAT" $ B1_DESC)//TCPO
	MCONTA := "11030106001"	
ELSEIF SB1->B1_TIPO =="CD" .AND. "MODELAT" $ B1_DESC//MODELATTO
	MCONTA := "11030106002"	
ELSE
	MCONTA := SPACE(11)
ENDIF

RestArea(aArea)

Return(mCONTA)
