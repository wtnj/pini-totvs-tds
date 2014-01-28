#INCLUDE "RWMAKE.CH"
/* Alterado por Danilo C S Pala, 20050210
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AjDifSC6()ºAutor  ³Marcos Farineli     º Data ³  12/06/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ajusta valores de diferimento no SC6                       º±±
±±º          ³ Chamada do Processamento                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AjDifSC6()

Private lEnd := .f.

If MsgYesNo("Deseja prosseguir? Nao continue sem o consentimento do Administrador","Ajuste do Diferimento")
	Processa({|| AJProc()})
EndIf

Return	
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³AjProc()  ºAutor  ³Marcos Farineli     º Data ³  12/06/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Processamento                                              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AjProc()
Private cPerg    := "ATR241"                        

//aStru  := {}
If !Pergunte(cPerg,.t.) //Danilo 20050210
	Return
EndIf

aCampo := {}
Aadd(aCampo,{"REVISTA", "C",04,0})
Aadd(aCampo,{"EDICAO" , "N",04,0})

cArqTRB := CriaTrab(aCampo, .T.)
dbUseArea( .T.,, cArqTRB, "REV", Nil, .F. )
Index On REVISTA+STRZERO(edicao,4) To &carqtrb

DbSelectArea("SC6")
//aStru := DbStruct()

//cArqDif := "dif.dbf"
//dbUseArea( .T.,, cArqDif, "DIF", Nil, .F. )


DBSELECTAREA("SZJ")
DBSETORDER(2)
DBSEEK(XFILIAL("SZJ")+DTOS(MV_PAR01),.T.) //DBSEEK(XFILIAL("SZJ")+"20020601",.T.) //20050210
PROCREGUA(RECCOUNT())

WHILE !EOF() .AND. DTOS(SZJ->ZJ_DTCIRC) <= DTOS(MV_PAR02) // "20020631" 20050210
	dbselectarea("rev")
	If !dbseek(szj->zj_codrev+strzero(szj->zj_edicao,4)) .and. Substr(SZJ->ZJ_CODREV,1,2) == "01"
		Reclock("REV",.T.)
		REV->REVISTA := SZJ->ZJ_CODREV
		REV->EDICAO  := SZJ->ZJ_EDICAO
		MSUNLOCK("REV")
	ENDIF
	DBSELECTAREA("SZJ")
	DBSKIP()
END


DbSelectArea("REV")
ProcRegua(RecCount())
DbGoTop()
While !Eof()
	//IncProc("Lendo Pedido: "+DIF->C6_NUM)

	/*
	DbSelectArea("SC6")
	DbSetOrder(1)
	If DbSeek(xFilial("SC6")+DIF->C6_NUM)
		If DTOS(SC6->C6_DATA) > "20020331"
			DbSelectArea("DIF")
			RecLock("DIF",.f.)
			DbDelete()
			MsUnlock()
		Else 
			DbSelectArea("DIF")
			RecLock("DIF",.f.)
			DIF->C6_DATA := SC6->C6_DATA
			MsUnlock()
		EndIf
	EndIf
	*/
	
	DbSelectArea("SC6")
	DbGoTop()
	DbSetOrder(2) // Filial+Produto+Pedido+Item
	DbSeek(xFilial("SC6") + REV->REVISTA,.t.)
	While !Eof() .and. Substr(SC6->C6_PRODUTO,1,4) == REV->REVISTA
	
		//If SC6->C6_TES == '700'
		//	DbSelectArea("SC6")
		//	DbSkip()
		//	Loop
		//EndIf		
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Se o produto nao for assinatura³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ      
/*		if sc6->c6_num = "00004A"
			msgAlert("achou")
		endif */
//		If Substr(SC6->C6_PRODUTO,1,2) <> "01" .OR. SC6->C6_VLDIFIT == 0
		If Substr(SC6->C6_PRODUTO,1,2) <> "01" .OR. SC6->C6_TES $ "700" .or. SC6->C6_TES $ "701" .OR. (subs(SC6->C6_PRODUTO,5,3) == "001") .or. SC6->C6_EDINIC = 9999 //20050210  	
			DbSelectArea("SC6")
			DbSkip()
			Loop
		EndIf
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Busca dados do produto.                ³
		//³Caso nao encontre, passa para o proximo³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("SB1")
		If !DbSeek(xFilial("SB1")+SC6->C6_PRODUTO)	
			DbSelectArea("SC6")
			DbSkip()
			Loop
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Evita divisao por zero (qtde exemplares)³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SB1->B1_QTDEEX == 0
			DbSelectArea("SC6")
			DbSkip()
			Loop
		EndIf
		nQtd := SB1->B1_QTDEEX
		
		DbSelectArea("SF4")
		DbSetOrder(1)
		If !DbSeek(xFilial("SF4")+SC6->C6_TES)
			DbSelectArea("SC6")
			DbSkip()
			Loop
		EndIf
		
		If SF4->F4_DUPLIC <> "S"
			DbSelectArea("SC6")
			DbSkip()
			Loop
		EndIf

		DbSelectArea("SC6")
		RecLock("SC6",.f.)
		//DIF->C6_NUM     := SC6->C6_NUM
		//DIF->C6_PRODUTO := SC6->C6_PRODUTO
		//DIF->C6_ITEM    := SC6->C6_ITEM
		//DIF->C6_VALOR   := SC6->C6_VALOR
		//DIF->C6_EDINIC  := SC6->C6_EDINIC
		//DIF->C6_EDFIN   := SC6->C6_EDFIN
		//DIF->C6_EDSUSP  := SC6->C6_EDSUSP
		//DIF->C6_VLDIFIT := SC6->C6_VLDIFIT
		//DIF->C6_TES     := SC6->C6_TES
		SC6->C6_VLDIFIT := Round(SC6->C6_VALOR/nQtd,2)
		If SC6->C6_EDINIC <= REV->EDICAO .and. SC6->C6_EDSUSP >= REV->EDICAO
			SC6->C6_VLADIFR := ((SC6->C6_EDSUSP-SC6->C6_EDINIC)*SC6->C6_VLDIFIT)-ROUND(SC6->C6_VLDIFIT*(REV->EDICAO-SC6->C6_EDINIC),2)
			SC6->C6_VLDIFRD := ROUND(SC6->C6_VLDIFIT * (REV->EDICAO - SC6->C6_EDINIC),2) 
    		If SC6->C6_EDVENC < REV->EDICAO .or. SC6->C6_EDFIN < REV->EDICAO
				SC6->C6_VLDIFRD := ((SC6->C6_EDSUSP-SC6->C6_EDINIC)*SC6->C6_VLDIFIT)
				SC6->C6_VLADIFR := 0
		    EndIf 
		ElseIf SC6->C6_EDINIC > REV->EDICAO
			SC6->C6_VLADIFR := ((SC6->C6_EDSUSP-SC6->C6_EDINIC)*SC6->C6_VLDIFIT)
			SC6->C6_VLDIFRD := 0
		ElseIf SC6->C6_EDSUSP < REV->EDICAO //rever com o Ricardo!!!! 20050210
			SC6->C6_VLDIFRD := ((SC6->C6_EDSUSP-SC6->C6_EDINIC)*SC6->C6_VLDIFIT)
			SC6->C6_VLADIFR := 0
		EndIf
		MsUnlock()
    
		DbSelectArea("SC6")
		DbSkip()
	End		
	DbSelectArea("REV")
	DbSkip()
End

DbSelectArea("REV")
//Copy To &("\siga\arqtemp\dif.dbf")
DbCloseArea()

Return