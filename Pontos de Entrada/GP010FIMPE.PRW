#INCLUDE "RWMAKE.CH"
/*   
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GP010FIMPE  ºAutor  ³Danilo Pala       º Data ³  20130823   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada na inclusao/alteracao de funcionario       º±±
±±º          ³ Chamado pelo GPEA010                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GP010FIMPE()
	Local aArea    := GetArea()
	Local aDados := {}
	Local cCodFor := ""
	
	if SM0->M0_CODIGO=='01'
		DBSelectArea("SA2")
		DBSetOrder(3)
		DbGoTop()
		If DbSeek(xFilial("SA2")+SRA->RA_CIC) //alterar
			if !Empty(SRA->RA_BCDEPSA) //prosseguir somente se o cadastro estiver preenchido
				If (SA2->A2_BANCO <> SUBSTR(SRA->RA_BCDEPSA,1,3)) .or. (SA2->A2_AGENCIA <> SUBSTR(SRA->RA_BCDEPSA,4,5)) .or. (SA2->A2_NUMCON <> strzero(val(SRA->RA_CTDEPSA),10)) //perguntar somente se os dados forem diferentes
					If MsgYesNo("Deseja atualizar os dados para deposito do fornecedor: "+ SA2->A2_COD + " "+ alltrim(SA2->A2_NOME) +"?") 
						RecLock("SA2",.F.) //update
							SA2->A2_BANCO := SUBSTR(SRA->RA_BCDEPSA,1,3) //BBBAAAAA   Onde B=Banco e A=Agencia
							SA2->A2_AGENCIA := SUBSTR(SRA->RA_BCDEPSA,4,5) //BBBAAAAA   Onde B=Banco e A=Agencia
							SA2->A2_NUMCON := strzero(val(SRA->RA_CTDEPSA),10)  //Conta corrente
						MsUnlock()
					EndIf //pergunta
				EndIf //dados diferentes
			EndIf //banco vazio
		Else //inserir
		
			If !Empty(SRA->RA_BCDEPSA) //somente prosseguir se o cadastro estiver preenchido
				If MsgYesNo("Deseja inserir um fornecedor para deposito referente ao funcionario: "+ SRA->RA_MAT + " "+ alltrim(SRA->RA_NOME) +"?")
					//MsgAlert("Inclusao do fornecedor em desenvolvimento")
					cCodFor := u_ForPiniParametro()
					aadd(aDados,{ "A2_COD",cCodFor, Nil})
					aadd(aDados,{ "A2_LOJA","01", Nil})
					aadd(aDados,{ "A2_NOME",SRA->RA_NOME, Nil})
					aadd(aDados,{ "A2_NREDUZ", SUBSTR(SRA->RA_NOME,1,20), Nil})
					aadd(aDados,{ "A2_TIPO","F", Nil})
					aadd(aDados,{ "A2_CGC", SRA->RA_CIC, Nil})
					aadd(aDados,{ "A2_CEP", SRA->RA_CEP, Nil})
					aadd(aDados,{ "A2_END", SRA->RA_ENDEREC, Nil})
					aadd(aDados,{ "A2_BAIRRO",SRA->RA_BAIRRO, Nil})
					aadd(aDados,{ "A2_EST", SRA->RA_ESTADO, Nil})
					aadd(aDados,{ "A2_ESTADO", SRA->RA_ESTADO, Nil})
					aadd(aDados,{ "A2_MUN", SRA->RA_MUNICIP, Nil})
					aadd(aDados,{ "A2_COD_MUN",posicione("SZ0",1,xfilial("SZ0")+SRA->RA_CEP,"Z0_COD_MUN"), Nil})
					aadd(aDados,{ "A2_TEL", LimparTel(SRA->RA_TELEFON), Nil})
					aadd(aDados,{ "A2_XXML", "N", Nil })
					aadd(aDados,{ "A2_CONTA","21010102999", Nil})
					aadd(aDados,{ "A2_NATUREZ", "86", Nil})
					aadd(aDados,{ "A2_EMAIL", SRA->RA_EMAIL, Nil})
					aadd(aDados,{ "A2_BANCO", SUBSTR(SRA->RA_BCDEPSA,1,3), Nil })
					aadd(aDados,{ "A2_AGENCIA",SUBSTR(SRA->RA_BCDEPSA,4,5), Nil })
					aadd(aDados,{ "A2_NUMCON", strzero(val(SRA->RA_CTDEPSA),10), Nil })
					aadd(aDados,{"AUTDELETA" ,"N",Nil})
				
					lMsErroAuto := .F.
					Begin Transaction
						MSExecAuto({|x,y| MATA020(x,y)},aDados,3)
						IF lMsErroAuto
							DisarmTransaction()
							MostraErro()
						Else
							// sucesso
						Endif
					End Transaction
					/*RecLock("SA2",.T.) //insert
						SA2->A2_COD    	:= cCodFor
						SA2->A2_LOJA   	:= "01"
						SA2->A2_NOME   	:= SRA->RA_NOME
						SA2->A2_NREDUZ 	:= SUBSTR(SRA->RA_NOME,1,20)
						SA2->A2_TIPO   	:= "F"
						SA2->A2_CGC    	:=  SRA->RA_CIC
						SA2->A2_CEP    	:=  SRA->RA_CEP
						SA2->A2_END    	:=  SRA->RA_ENDEREC
						SA2->A2_BAIRRO 	:= SRA->RA_BAIRRO
						SA2->A2_EST    	:=  SRA->RA_ESTADO
						//SA2->A2_ESTADO 	:=  SRA->RA_ESTADO
						SA2->A2_MUN    	:= SRA->RA_MUNICIP
						SA2->A2_COD_MUN 	:= posicione("SZ0",1,xfilial("SZ0")+SRA->RA_CEP,"Z0_COD_MUN")
						SA2->A2_TEL     	:=  LimparTel(SRA->RA_TELEFON)
						SA2->A2_XXML 		:=  "N"
						SA2->A2_CONTA 		:= "21010102999"
						SA2->A2_NATUREZ 	:=  "86"
						SA2->A2_EMAIL 		:=  SRA->RA_EMAIL
						SA2->A2_BANCO 		:= SUBSTR(SRA->RA_BCDEPSA,1,3) //BBBAAAAA   Onde B=Banco e A=Agencia
						SA2->A2_AGENCIA 	:= SUBSTR(SRA->RA_BCDEPSA,4,5) //BBBAAAAA   Onde B=Banco e A=Agencia
						SA2->A2_NUMCON 	:= strzero(val(SRA->RA_CTDEPSA),10)  //Conta corrente
					MsUnlock()*/
				EndIf
			EndIf
		Endif
	Endif
	
	RestArea(aArea)
Return


Static Function LimparTel(cTel) //20110606
cTel := upper(cTel)
cTel := Alltrim(StrTran(cTel," ",""))
cTel := Alltrim(StrTran(cTel,"-",""))
cTel := Alltrim(StrTran(cTel,"/",""))
cTel := Alltrim(StrTran(cTel,".",""))
cTel := Alltrim(StrTran(cTel,";",""))
cTel := Alltrim(StrTran(cTel,",",""))
cTel := Alltrim(StrTran(cTel,"REC",""))
cTel := Alltrim(StrTran(cTel,"R",""))
cTel := Alltrim(StrTran(cTel,"(",""))
cTel := Alltrim(StrTran(cTel,")","")) 
cTel := substr(Alltrim(cTel),1,10)
Return cTel