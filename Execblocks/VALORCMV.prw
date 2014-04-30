/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VALORCMV  ºAutor  ³DANILO C S PALA     º Data ³  20110505   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ RETORNA O VALOR DO ITEM DA NOTA FISCAL A SER CONTABILIZADO º±±
±±º          ³ DO CMV                   								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PINI                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VALORCMV(cTpNota) //cTpNota:E=Entrada ou S=Saida
Local nValor  := 0
Local aArea := GetArea()
Local cTES := ""
Local nTotal := 0
Local cProduto := ""
Local cAlmox := ""

if (SD2->D2_SERIE=='UNI' .OR. TRIM(SD2->D2_SERIE)=='D1' .OR. SD2->D2_SERIE=='CUP' .OR. SD2->D2_SERIE=='CFS' .OR.SD2->D2_SERIE=='CFA' .OR. SD2->D2_SERIE=='PUB' .OR. SD2->D2_SERIE=='CFB' .OR. SD2->D2_SERIE=='CFC' .OR. SD2->D2_SERIE=='CFD' .OR. SD2->D2_SERIE=='ANG' .OR. SD2->D2_SERIE=='CFE' .OR. SD2->D2_SERIE=='NFS' .OR. SD2->D2_SERIE=='SEN' .OR. SD2->D2_SERIE=='STD' .OR. SD2->D2_SERIE=='ECF' .OR. SD2->D2_SERIE=='1  ' .OR. SD2->D2_SERIE=='8  ' .OR. SD2->D2_SERIE=='EC1' .OR. SD2->D2_SERIE=='4  ') .OR. (SD1->D1_SERIE=='   ' .OR. SD1->D1_SERIE=='2  ') 
	if cTpNota =="S" //Saida
		cTES := SD2->D2_TES
		nTotal := SD2->D2_CUSTO1
		cProduto := SD2->D2_COD
		cAlmox := SD2->D2_LOCAL
	else //Entrada
		IF SD1->D1_TIPO =="D"  
			cTES := SD1->D1_TES
			nTotal := SD1->D1_CUSTO
			cProduto := SD1->D1_COD
			cAlmox := SD1->D1_LOCAL
		ELSE
			nTotal := 0
		ENDIF
	endif

	if nTotal >0
		//VERIFICAR O TES
		DbSelectArea("SF4")
		DbSetOrder(1)
		DbSeek(xFilial("SF4")+cTES)
		IF EMPTY(SF4->F4_CTBESP) .or. SF4->F4_CTBESP =="DC" 
			DbSelectArea("SB1")
			DbSetOrder(1)
			IF DbSeek(xFilial("SB1")+cProduto) 
				If SB1->B1_TIPO =="LI" .or. SB1->B1_TIPO =="LC" .or. SB1->B1_TIPO =="TC" .or. SB1->B1_TIPO =="CD" .or. SB1->B1_TIPO =="DC" .or. SB1->B1_TIPO =="DV" .or. SB1->B1_TIPO =="IE" .or. SB1->B1_TIPO =="RE"
					if ALLTRIM(SB1->B1_COD) <> "0000400" .and. cAlmox<>"CD" //ARCHICAD
						nValor := nTotal
					endif
			    endIf
			ENDIF //DBSEEK SB1
		ElseIf SF4->F4_CODIGO == "662"
			nValor := 0
		ELSE
			nValor := 0
		ENDIF //TES
	else
		nValor := 0
	endif
endif

RestArea(aArea)
RETURN(nValor)