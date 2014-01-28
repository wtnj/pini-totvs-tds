/*/                                                                    
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ 16/03/02 ³ Execblock utilizado na contab NFE CONTA CREDITO DEVOLUCAO³±±   
±±³          | DANILO C S PALA E JOSE RICARDO VALENGA                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CONTACDEV()

Local mCONTA  := SPACE(11)
Local aArea := GetArea()

IF SB1->B1_TIPO ="LI" 
	MCONTA := "11030107001"
ELSEIF SB1->B1_TIPO ="LC" 
	MCONTA := "11030107002"
ELSEIF SB1->B1_TIPO ="CD" .AND. !("TCPO" $ B1_DESC) .AND. !("MODELAT" $ B1_DESC)//CD PINI
	MCONTA := "11030107005"
ELSEIF SB1->B1_TIPO ="DC" 
	MCONTA := "11030107006"
ELSEIF SB1->B1_TIPO ="TC" 
	MCONTA := "11030107007"	
ELSEIF SB1->B1_TIPO =="CD" .AND. "TCPO" $ B1_DESC .AND. !("MODELAT" $ B1_DESC)//TCPO
	MCONTA := "11030107008"	
ELSEIF SB1->B1_TIPO =="CD" .AND. "MODELAT" $ B1_DESC//MODELATTO
	MCONTA := "11030107009"	
ELSE
	MCONTA := SPACE(11)
ENDIF

RestArea(aArea)

Return(mCONTA)
