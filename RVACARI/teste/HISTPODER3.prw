/*
//Danilo C S Pala 20110504: alterado a pedido de Jose Martins
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³HISTPODER3ºAutor  ³DANILO C S PALA     º Data ³  20101117   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ RETORNA O HISTORICO DO ITEM DA NOTA FISCAL A SER CONTABILIZADO º±±
±±º          ³ DO PODER DE TERCEIROS    								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PINI                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function HISTPODER3(cTpNota) //cTpNota:E=Entrada ou S=Saida
Local cValor := ""
Local aArea := GetArea()
Local cTES := ""
Local cNome := ""
Local cNota := ""
Local nTotal := 0
Local cCompl := ""


if cTpNota =="S" //Saida
	cCompl := "/"
	cTES := SD2->D2_TES
	cNota := "/NF."+SD2->D2_DOC+"/"+SD2->D2_SERIE
	DbSelectArea("SA1")
	DbSetOrder(1)
	IF DbSeek(xFilial("SA1")+SD2->D2_CLIENTE+SD2->D2_LOJA)
		cNome := ALLTRIM(SUBSTR(SA1->A1_NREDUZ,1,15))
	ELSE 
		cNome := ""
	ENDIF        
else //Entrada
	cCompl := "/DEV."
	cTES := SD1->D1_TES
	cNota := "/NF."+SD1->D1_DOC+"/"+SD1->D1_SERIE
	if SD1->D1_TIPO =='B' //20110504
		DbSelectArea("SA1") //daqui 20110504
		DbSetOrder(1)
		IF DbSeek(xFilial("SA1")+SD1->D1_FORNECE+SD1->D1_LOJA)
			cNome := ALLTRIM(SUBSTR(SA1->A1_NREDUZ,1,15))
		ELSE 
			cNome := ""
		ENDIF        //ate aqui 20110504
	else	
		DbSelectArea("SA2")
		DbSetOrder(1)
		IF DbSeek(xFilial("SA2")+SD1->D1_FORNECE+SD1->D1_LOJA)
			cNome := ALLTRIM(SUBSTR(SA2->A2_NREDUZ,1,15))
		ELSE 
			cNome := ""
		ENDIF
	endif
endif


//VERIFICAR O TES
DbSelectArea("SF4")
DbSetOrder(1)
DbSeek(xFilial("SF4")+cTES)
IF !EMPTY(SF4->F4_CTBESP) .and. SF4->F4_DUPLIC <>"S" .and. SF4->F4_CTBESP<>"DC"
	if SUBSTR(SF4->F4_CTBESP,1,1) =="C"
		cValor := "CONSIGNADO"
	elseif SUBSTR(SF4->F4_CTBESP,1,1) =="E"
		cValor := "EMP"
	elseif SUBSTR(SF4->F4_CTBESP,1,1) =="X"
		cValor := "EXP"
	else                    
		cValor := ""
	endif
ELSE
	cValor := ""
ENDIF //TES

cValor := cNome+cNota+cCompl+cValor

RestArea(aArea)
RETURN(cValor)