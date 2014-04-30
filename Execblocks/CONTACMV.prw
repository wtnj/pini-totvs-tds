//Alterado por Danilo Pala em 20121016: INFORMACOES ESTRATEGICAS
//Alterado por Danilo Pala em 20130828: TCPO INFRA
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CONTACMV  ºAutor  ³DANILO C S PALA     º Data ³  20110505   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ RETORNA A CONTA CONTABIL DO PRODUTO DO CMV 				  º±±
±±º          ³                          								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PINI                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CONTACMV(cTpNota, cTipo) //cTpNota:E=Entrada ou S=Saida ,cTipo:C=Credito ou D=Debito
Local cConta := ""
Local aArea := GetArea()
Local cTES := ""
Local cProduto := ""


if cTpNota =="S" //Saida
	cTES := SD2->D2_TES
	cProduto := SD2->D2_COD
else //Entrada
	cTES := SD1->D1_TES
	cProduto := SD1->D1_COD
endif

//VERIFICAR O TES
DbSelectArea("SF4")
DbSetOrder(1)
DbSeek(xFilial("SF4")+cTES)
IF EMPTY(SF4->F4_CTBESP) //NAO CONTABILIZA PODER3
	DbSelectArea("SB1")
	DbSetOrder(1)
	IF DbSeek(xFilial("SB1")+cProduto)
		If SB1->B1_TIPO =="LI" .AND. !("TCPO" $ B1_DESC) //LIVRO PINI
			if cTipo == "D"
				cConta := "32010102001"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107001"
			else
				cConta := "11030102001"
			endif
		Elseif SB1->B1_TIPO =="LC" //LIVROS CONSIGNADO
			if cTipo == "D"
				cConta := "32010201001"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107002"
			else
				cConta := "11030102002"
			endif
		Elseif (SB1->B1_TIPO =="TC" .OR. SB1->B1_TIPO =="LI") .AND. "TCPO" $ B1_DESC //LIVRO TCPO
			if cTipo == "D"
				cConta := "32010106001"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107007"
			else
				cConta := "11030106001"
			endif                      
		Elseif SB1->B1_TIPO =="CD" .AND. "TCPO" $ B1_DESC//CD TCPO
			if cTipo == "D"
				cConta := "32010106001"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107008"
			else
				cConta := "11030106001"
			endif
		Elseif SB1->B1_TIPO =="CD" .AND. !("TCPO" $ B1_DESC) .AND. !("MODELAT" $ B1_DESC) .AND. !("INFRA" $ B1_DESC)//CD PINI
			if cTipo == "D"
				cConta := "32010104001"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107005"
			else   
				cConta := "11030104001"
			endif
		Elseif SB1->B1_TIPO =="DC" //DVD CONSIGNADO
			if cTipo == "D"
				cConta := "32010201002"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107006"
			else
				cConta := "11030104002"
			endif
		Elseif SB1->B1_TIPO =="DV" //DVD PINI
			if cTipo == "D"
				cConta := "32010106001"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107005"
			else
				cConta := "11030106001"
			endif
		Elseif SB1->B1_TIPO =="CD" .AND. "MODELAT" $ B1_DESC//MODELATTO
			if cTipo == "D"
				cConta := "32010106002"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107009"
			else   
				cConta := "11030106002"
			endif
		Elseif SB1->B1_TIPO =="IE" //INFORMACOES ESTRATEGICAS 20121016
			if cTipo == "D"
				cConta := "32010105001"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107001"
			else
				cConta := "11030105001"         
			endif
		Elseif SB1->B1_TIPO =="PE" //PESQUISA EXPRESSA
			if cTipo == "D"
				cConta := "32010105002"
			else
				cConta := "11030105002"         
			endif
		Elseif SB1->B1_TIPO =="CD" .AND. "TCPO" $ B1_DESC .AND. "INFRA" $ B1_DESC//TCPO INFRA
			if cTipo == "D"
				cConta := "32010106003"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107011"
			else   
				cConta := "11030106003"
			endif
		ElseIf SB1->B1_TIPO == "RE" .AND. SUBSTR(SB1->B1_COD,1,3) == "015" .And. SD2->D2_LOCAL == "T5" //REVISTAS COM INICIO 015
			if cTipo == "D"
				cConta := "32010201003"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107010"
			Else   
				cConta := "11030109001"
			EndIf
		ElseIf SB1->B1_TIPO == "RE" .AND. SUBSTR(SB1->B1_COD,1,5) == "01240" .And. SD2->D2_LOCAL == "T5" //REVISTAS COM INICIO 01240
			if cTipo == "D"
				cConta := "32010101001"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107010"
			Else   
				cConta := "11030101001"
			EndIf
		ElseIf SB1->B1_TIPO == "RE" .AND. SUBSTR(SB1->B1_COD,1,5) == "01160" .And. SD2->D2_LOCAL == "T5" //REVISTAS COM INICIO 01160
			if cTipo == "D"
				cConta := "32010101002"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107010"
			Else   
				cConta := "11030101002"
			EndIf
		ElseIf SB1->B1_TIPO == "RE" .AND. SUBSTR(SB1->B1_COD,1,5) == "01280" .And. SD2->D2_LOCAL == "T5"  //REVISTAS COM INICIO 01280
			if cTipo == "D"
				cConta := "32010101003"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107010"
			Else   
				cConta := "11030101003"
			EndIf
		ElseIf SB1->B1_TIPO == "RE" .AND. SUBSTR(SB1->B1_COD,1,5) == "01320" .And. SD2->D2_LOCAL == "T5"  //REVISTAS COM INICIO 01320
			if cTipo == "D"
				cConta := "32010101010"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107010"
			Else   
				cConta := "11030101004"
			EndIf
		ElseIf SB1->B1_TIPO == "RE" .AND. SUBSTR(SB1->B1_COD,1,5) == "01250" .And. SD2->D2_LOCAL == "T5"  //REVISTAS COM INICIO 01320
			if cTipo == "D"
				cConta := "32010101008"
			ElseIf SD2->D2_SERIE == "FE2" .Or. SD2->D2_SERIE == "FE3"
				cConta := "11030107010"
			Else   
				cConta := "11030101005"
			EndIf
		Else
			cConta := ""
		EndIf
	ELSE
		cConta := ""
	ENDIF //DBSEEK SB1
ELSEIF SF4->F4_CTBESP =="DC" //DEVOLUCAO DE CONSIGNACAO
	If SB1->B1_TIPO =="LC" //LIVROS CONSIGNADO
			if cTipo == "D"
				cConta := "21030201005"
			else
				cConta := "11030102002"
			endif
	Elseif SB1->B1_TIPO =="CD" .AND. !("TCPO" $ B1_DESC) .AND. !("MODELAT" $ B1_DESC) .AND. !("INFRA" $ B1_DESC)//CD PINI
			if cTipo == "D"
				cConta := "21030201005"
			else   
				cConta := "11030104002"
			endif
	Elseif SB1->B1_TIPO =="DC" //DVD CONSIGNADO
			if cTipo == "D"
				cConta := "21030201005"
			else
				cConta := "11030104002"
			endif
	Else
		cConta := ""
	EndIf
ELSE
	cConta := ""
ENDIF //TES

RestArea(aArea)
RETURN(cConta)