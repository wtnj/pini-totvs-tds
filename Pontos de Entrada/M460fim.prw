#Include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02
/*/
// Alterado por Danilo C S Pala 20050520: CFB
//Alterado por Danilo C S Pala em 20070315: CFE
//Alterado por Danilo C S Pala em 20070328: NFS
//Alterado por Danilo C S Pala em 20080220: SEN
//Alterado por Danilo C S Pala em 20110509: AjusteVencto(cPrefixo, cNumero, cCliente, cLoja)
//Alterado por Danilo C S Pala em 20110823: SNF
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ M460FIM  ³ Autor ³GILBERTO A OLIVEIRA JR ³ Data ³ 30.11.00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Ponto de Entrada no Final da Geracao da NFS.               ³±±
±±³          ³ Visa verificar problemas na gravacao dos dados FINANCEIROS ³±±
±±³          ³ quando faturamento do Lote 700, serie CUP (Cupom Fiscal).  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico (PINI) -                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Revis„o  ³                                          ³ Data ³          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function M460fim()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

SetPrvt("_CAREA_CORRENTE,_NINDICE_CORRENTE,_NREGISTRO_CORRENTE,_NSD2_IDX,_NSD2_REC,_NSF2_IDX")
SetPrvt("_NSF2_REC,_NSF4_IDX,_NSF4_REC,_NSE1_IDX,_NSE1_REC,_LFINANCEIRO")
SetPrvt("_CDOC,_CSER,_CMSG,")       

//MsgAlert("Passou aki no ponto de entrada M460fim")

If SM0->M0_CODIGO == "01" .OR. SM0->M0_CODIGO == "02" .OR. SM0->M0_CODIGO == "03"
	IF Alltrim(SF2->F2_SERIE) == "UNI" .or. Alltrim(SF2->F2_SERIE) =="CUP" .or. Alltrim(SF2->F2_SERIE) =="ASS" .or. Alltrim(SF2->F2_SERIE) =="CFS" .or. Alltrim(SF2->F2_SERIE) =="CFA" .or. Alltrim(SF2->F2_SERIE) =="CFB" .or. Alltrim(SF2->F2_SERIE) =="ANG" .or. Alltrim(SF2->F2_SERIE) =="CFE" .or. Alltrim(SF2->F2_SERIE) =="NFS" .or. Alltrim(SF2->F2_SERIE) =="SEN" .or. Alltrim(SF2->F2_SERIE) =="ECF" .or. Alltrim(SF2->F2_SERIE) =="1"  .or. Alltrim(SF2->F2_SERIE) =="8" .or. Alltrim(SF2->F2_SERIE) =="3" .or. Alltrim(SF2->F2_SERIE) =="SNF" .or. Alltrim(SF2->F2_SERIE) =="EC1" .or. Alltrim(SF2->F2_SERIE) =="4"
		_cArea_Corrente:= Alias()
		_nIndice_Corrente:= IndexOrd()
		_nRegistro_Corrente:= Recno()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³  Outras Areas  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		DbSelectArea("SD2")
		_nSD2_Idx:= IndexOrd()
		_nSD2_Rec:= Recno()
		
		DbSelectArea("SF2")
		_nSF2_Idx:= IndexOrd()
		_nSF2_Rec:= Recno()
		
		DbSelectArea("SF4")
		_nSF4_Idx:= IndexOrd()
		_nSF4_Rec:= Recno()
		
		DbSelectArea("SE1")
		_nSE1_Idx:= IndexOrd()
		_nSE1_Rec:= Recno()
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³PROCESSAMENTO³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		_lFinanceiro:= .F.
		
		_cDoc:= SF2->F2_DOC
		_cSer:= SF2->F2_SERIE
		
		DbSelectArea("SD2")
		DbSetOrder(3)
		DbSeek(xFilial("SD2") + _cDoc + _cSer )
		
		While !Eof() .And. ( _cDoc+_cSer ==  SD2->D2_DOC+SD2->D2_SERIE )
			DbSelectArea("SF4")
			DbSetOrder(1)
			DbSeek( xFilial("SF4") + SD2->D2_TES )
			If SF4->F4_DUPLIC == "S"
				_lFinanceiro:= .T.
				Exit
			EndIf
			DbSelectArea("SD2")
			DbSkip()
		End
		
		If !_lFinanceiro   /// CASO NAO ENTRE AQUI SIGNIFICA QUE NENHUMA TES GERA DUPLICATA.
			
			DbSelectArea("SE1")
			DbSetOrder(1)
			If !DbSeek(xFilial("SE1") + _cSer + _cDoc )
				_cMsg := "Houve algum problema com a geracao dos dados "
				_cMsg += "FINANCEIROS. Favor REFAZER O PROCESSO ou entrar "
				_cMsg += "em contato com o Depto de Informatica. "
				_cMsg += "Repetindo : DADOS FINANCEIROS NAO ATUALIZADOS ! Verifique..."
				//MsgAlert(_cMsg,OemToAnsi("M460FIM")) desabilitado a pedido do Cicero em 20110526
			EndIf
			
			If Alltrim(_cSer) == "ASS"
				While !eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_NUM+SE1->E1_PREFIXO == _cDoc+_cSer
					// Teste se e a primeira parcela se nao for pula para
					// proximo registro
					If !(Alltrim(SE1->E1_PARCELA) $ "A% ")
						dbSelectArea("SE1")
						dbSkip()
						Loop
					Endif
					
					If SUBSTR(SE1->E1_PEDIDO,1,1) <> "R"
						dbSelectArea("SE1")
						dbSkip()
						Loop
					Endif
					// Abaixo achou a primeira parcela e agora vai proceder com
					// a baixa do titulo
					RecLock("SE1",.F.)
					SE1->E1_BAIXA  := dDataBase
					SE1->E1_HIST   := "Valor recebido s/ Titulo"
					SE1->E1_MOTIVO := "NOR"
					SE1->E1_MOVIMEN:= dDataBase
					SE1->E1_SALDO  := 0
					SE1->E1_VALLIQ := SE1->E1_VALOR
					SE1->E1_STATUS := "B"
					SE1->E1_HISTBX := "Valor recebido s/ Titulo"
					SE1->E1_DTALT  := dDataBase
					MsUnlock()
					
					// Gerando Movimentacao Bancaria
					Reclock("SE5",.T.)
					SE5->E5_FILIAL  := xFilial("SE5")
					SE5->E5_BANCO   := "341"
					SE5->E5_AGENCIA := "0585"
					SE5->E5_CONTA   := "39886-0"
					SE5->E5_DATA    := dDataBase
					SE5->E5_MOEDA   := STR(SE1->E1_MOEDA,2)
					SE5->E5_VALOR   := SE1->E1_VALOR
					SE5->E5_NATUREZ := "BX"
					SE5->E5_RECPAG  := "R"
					SE5->E5_TIPO    := "NF"
					SE5->E5_LA      := "N"
					SE5->E5_TIPODOC := "BA"
					SE5->E5_PREFIXO := SE1->E1_PREFIXO
					SE5->E5_NUMERO  := SE1->E1_NUM
					SE5->E5_PARCELA := SE1->E1_PARCELA
					SE5->E5_CLIFOR  := SE1->E1_CLIENTE
					SE5->E5_LOJA    := SE1->E1_LOJA
					SE5->E5_BENEF   := SE1->E1_NOMCLI
					SE5->E5_MOTBX   := "NOR"
					SE5->E5_SEQ     := "01"
					SE5->E5_HISTOR  := "Valor recebido s/ Titulo"
					SE5->E5_DTDIGIT := DdataBase
					SE5->E5_DTDISPO := DdataBase
					SE5->E5_VLMOED2 := SE1->E1_VALOR
					
					AtuSalBco("341","0585","39886-0",dDataBase,SE1->E1_VALOR,"+" )
					MsUnlock()
					dbSelectArea("SE1")
					dbSkip()
				End
			Endif
		EndIf
		              
		//MsgAlert("M460fim:2")
		//20110509: 
		U_AjusteVencto(SF2->F2_SERIE, SF2->F2_DOC, SF2->F2_CLIENTE, SF2->F2_LOJA)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ RETORNA AREAS UTILIZADAS POR ESSE PTO DE ENTRADA  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		DbSelectArea("SD2")
		DbSetOrder(_nSD2_Idx)
		DbGoto(_nSD2_Rec)
		
		DbSelectArea("SF2")
		DbSetOrder(_nSF2_Idx)
		DbGoto(_nSF2_Rec)
		
		DbSelectArea("SF4")
		DbSetOrder(_nSF4_Idx)
		DbGoto(_nSF4_Rec)
		
		DbSelectArea("SE1")
		DbSetOrder(_nSE1_Idx)
		DbGoto(_nSE1_Rec)
		
		DbSelectArea(_cArea_Corrente)
		DbSetOrder(_nIndice_Corrente)
		DbGoTo(_nRegistro_Corrente)
	ENDIF
ENDIF

Return(Nil)