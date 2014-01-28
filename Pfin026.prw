#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/
Alterado por Danilo Pala 20100303
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PFAT249  ³ Autor ³ Danilo C S Pala       ³ Data ³ 20091215 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Integracao com requisicoes                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Pini                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfin026() 
PRIVATE lExec    := .F.
PRIVATE cIndexName := ''
PRIVATE cIndexKey  := ''
PRIVATE cFilter    := ''
Private cQuery := ""
Private cSerie :="REQ"
Private cDoNumero  :="000011111"               
Private cOpcao := "I"
Private aVetor := {}
Private cMsg := ""
//Private cAteNumero :="370961   "   

	@ 000,000 TO 320,400 DIALOG oDlg TITLE "Integração Siga - Requisições" 
	@ 001,005 TO 310,380
	@ 005,010 SAY "Este programa processa as requisições que estão na Área de Interface"
	@ 015,010 SAY " e insere ou deleta no Protheus os respectivos títulos a pagar"
	/*@ 005,010 SAY "Serie:"
	@ 005,070 GET cserie  Picture "@!" F3("SF2")
	@ 020,010 SAY "Numero:"
	@ 020,070 GET cDoNumero  Picture "@R 999999999"
	@ 035,010 SAY "Opcao: (I/D)"
	@ 035,070 GET cOpcao  Picture "@!"  Valid Pertence("I/D")
	//@ 050,010 SAY "Vendedor:"
	//@ 050,070 GET cVendedor  Picture "@!" F3("SA3")*/
	@ 115,010 BUTTON "OK" SIZE 40,20 ACTION (lExec := .T., Close(oDlg))
	@ 115,070 BUTTON "Cancelar" SIZE 40,20 ACTION (lExec := .F.,Close(oDlg))
	Activate Dialog oDlg centered
	if lExec 
		//processar                                       
		ProcRegua(3)
		IncProc("Carregando requisições da Área de Interface")
		AreaInterface() //Carregar requisicoes da area de interface
		IncProc("Inserindo, atualizando ou deletando Títulos a Pagar")
		ProcIntReq() //Inserir os titulos a pagar       
		IncProc("Fim de processamento")
		cMsg += "Fim de processamento"
		Alert(cMsg)
	endif
	

Return         
           
           
           


Static Function ProcIntReq()
Private cQuery :=""
Private cUpdate :=""
Private cNatFornec := ""
Private TFornec :=""
Private TLoja :=""

	cQuery := "SELECT ZY2_CODEMP, ZY2_FORNEC, ZY2_LOJA, ZY2_SERIE, ZY2_NUMERO, ZY2_EMISSA, ZY2_VALOR, ZY2_OPERAC, ZY2_STATUS, ZY2_DTINSE, ZY2_DTPROC, ZY2_DTVENC, ZY2_AREA, R_E_C_N_O_ RECNUMERO FROM "+ RetSqlName("ZY2") +" ZY2 WHERE ZY2_FILIAL='"+ XFILIAL("ZY2") +"' AND ZY2_STATUS='1' AND D_E_L_E_T_<>'*' ORDER BY ZY2_DTINSE, R_E_C_N_O_"
	TCQUERY cQuery NEW ALIAS "INTREQ"
	TcSetField("INTREQ","ZY2_EMISSA"   ,"D")
	TcSetField("INTREQ","ZY2_DTPROC"   ,"D")
	TcSetField("INTREQ","ZY2_DTINSE"   ,"D")
	TcSetField("INTREQ","ZY2_DTVENC"   ,"D")
	DbSelectArea("INTREQ")
	DBGOTOP()
	WHILE !EOF()                                           
		IF SM0->M0_CODIGO == INTREQ->ZY2_CODEMP //SOMENTE PARA A EMPRESA LOGADA
			cNatFornec := GetNatFornec(INTREQ->ZY2_FORNECE, INTREQ->ZY2_LOJA)
			if INTREQ->ZY2_OPERAC =="I" //Insert
				TFornec := GetTitFornec(INTREQ->ZY2_SERIE, INTREQ->ZY2_NUMERO)
				if empty(TFornec) //vazio
					TituloaPagar(INTREQ->ZY2_SERIE, INTREQ->ZY2_NUMERO, INTREQ->ZY2_EMISSA, INTREQ->ZY2_VALOR, INTREQ->ZY2_FORNECE, INTREQ->ZY2_LOJA, INTREQ->ZY2_OPERAC, INTREQ->ZY2_DTVENC, INTREQ->ZY2_AREA, cNatFornec)
				endif
			else  //Delete ou Update, pegar Fornecedor do titulo a pagar
				TFornec := GetTitFornec(INTREQ->ZY2_SERIE, INTREQ->ZY2_NUMERO)
				if !empty(TFornec) //nao vazio
					TituloaPagar(INTREQ->ZY2_SERIE, INTREQ->ZY2_NUMERO, INTREQ->ZY2_EMISSA, INTREQ->ZY2_VALOR, Substr(TFornec,1,6), Substr(TFornec,7,2), INTREQ->ZY2_OPERAC, INTREQ->ZY2_DTVENC, INTREQ->ZY2_AREA, cNatFornec)
				else
					TituloaPagar(INTREQ->ZY2_SERIE, INTREQ->ZY2_NUMERO, INTREQ->ZY2_EMISSA, INTREQ->ZY2_VALOR, INTREQ->ZY2_FORNECE, INTREQ->ZY2_LOJA, INTREQ->ZY2_OPERAC, INTREQ->ZY2_DTVENC, INTREQ->ZY2_AREA, cNatFornec)
				endif
			endif
			cUpdate := "UPDATE "+ RetSqlName("ZY2") +" SET ZY2_STATUS='2', ZY2_DTPROC=to_char(SYSDATE,'YYYYMMDD') WHERE R_E_C_N_O_="+ ALLTRIM(Transform(INTREQ->RECNUMERO,"@E 99999999999")) +" AND D_E_L_E_T_<>'*'"
		    If TcSqlExec(cUpdate) = 1
				//DELETADO
			Else
		    	//NAO DELETADO
		    EndIf   
		 ENDIF
		DbSelectArea("INTREQ")
		DBSkip()
	END
	DbSelectArea("INTREQ")
	DbCloseArea()
Return          





Static Function TituloaPagar(cSerie, cNumero, dData, nValor, cFornece, cLoja, cOperacao, dVencto, cArea, cNatureza)
		lMsErroAuto := .F.
		if cOperacao="I"
			aVetor :={	{"E2_PREFIXO"	,cSerie,Nil},;
					{"E2_NUM"		,cNumero,Nil},;
					{"E2_PARCELA"	,'1',Nil},;
					{"E2_TIPO"		,'VL',Nil},;			 //PRE = titulo provisorio
					{"E2_NATUREZ"	,'REQUISICAO',Nil},;
					{"E2_FORNECE"	,cFornece,Nil},; 
					{"E2_LOJA"		,cLoja,Nil},;      
					{"E2_EMISSAO"	,dData,NIL},;
					{"E2_VENCTO"	,dVencto,NIL},;					 
					{"E2_VENCREA"	,dVencto,NIL},;					 					
					{"E2_VALOR"		,nValor,Nil},;
					{"E2_HIST"		,cArea + "/"+ cNatureza,Nil}}

			MSExecAuto({|x,y,z| Fina050(x,y,z)},aVetor,,3) //Inclusao
			cMsg += "Inserido: " + cNumero + CHR(10)+ CHR(13)
		elseif cOperacao="D"
			aVetor :={	{"E2_PREFIXO"	,cSerie,Nil},;
				{"E2_NUM"		,cNumero,Nil},;
				{"E2_PARCELA"	,'1',Nil},;
				{"E2_TIPO"		,'VL ',Nil},;			
				{"E2_NATUREZ"	,'REQUISICAO',Nil},;
				{"E2_FORNECE"	,cFornece,Nil},; 
				{"E2_LOJA"		,cLoja,Nil},;
				{"E2_EMISSAO"	,dData,NIL}}

			MSExecAuto({|x,y,z| Fina050(x,y,z)},aVetor,,5) //Exclusao
			cMsg += "Deletado: " + cNumero + CHR(10)+ CHR(13)
		elseif cOperacao="U"
			aVetor :={	{"E2_PREFIXO"	,cSerie,Nil},;
				{"E2_NUM"		,cNumero,Nil},;
				{"E2_PARCELA"	,'1',Nil},;
				{"E2_TIPO"		,'VL ',Nil},;			
				{"E2_NATUREZ"	,'REQUISICAO',Nil},;
				{"E2_FORNECE"	,cFornece,Nil},; 
				{"E2_LOJA"		,cLoja,Nil},;
				{"E2_EMISSAO"	,dData,NIL},;
				{"E2_VALOR"		,nValor,Nil}}

			MSExecAuto({|x,y,z| Fina050(x,y,z)},aVetor,,4) //Atualizar
			cMsg += "Atualizado: " + cNumero + CHR(10)+ CHR(13)
		endif
				/*
		aVetor :={	{"E2_PREFIXO"	,'999',Nil},;
				{"E2_NUM"		,'999999',Nil},;
				{"E2_PARCELA"	,'1',Nil},;
				{"E2_TIPO"		,'NDF',Nil},;			
				{"E2_NATUREZ"	,'001',Nil},;
				{"E2_VENCTO"	,dDataBase,NIL},;					 
				{"E2_VENCREA"	,dDataBase+5,NIL},;					 					
				{"E2_VALOR"		,2200,Nil}}

		MSExecAuto({|x,y,z| Fina050(x,y,z)},aVetor,,4) //Alteracao
		*/
		
		If lMsErroAuto
			mostraerro()
		Else
			//Alert(cMsg)
		Endif
Return            



Static Function AreaInterface()
Private cQueryArea :=""
Private cDeleteArea :=""
Private LFornec := ""
Private LLoja := ""
/*
INSERT INTO INTEGRACAOREQUISICOES (CODEMP, FORNEC, LOJA, SERIE, NUMERO, EMISSA, VALOR, OPERAC, STATUS, DTINSE, DTVENC, AREA, RECNUMERO)
VALUES ('01', '099999', '01', 'REQ', '000011119', SYSDATE, 10.99, 'I', '1', SYSDATE, SYSDATE+4, '001', SEQ_INTEGRACAOREQUISICOES.NEXTVAL)
*/
	cQueryArea := "SELECT CODEMP, FORNEC, LOJA, SERIE, NUMERO, TO_CHAR(EMISSA,'YYYYMMDD') EMISSA, VALOR, OPERAC, STATUS, TO_CHAR(DTINSE,'YYYYMMDDHH24mmss') DTINSE, TO_CHAR(DTVENC,'YYYYMMDD') DTVENC, AREA, RECNUMERO FROM INTEGRACAOREQUISICOES ORDER BY RECNUMERO"
	TCQUERY cQueryArea NEW ALIAS "AREAINT"
	DbSelectArea("AREAINT")
	DBGOTOP()
	WHILE !EOF()                                                
		RECLOCK("ZY2",.T.) //inserir .T.
			if ValidaFornec(AREAINT->FORNEC, AREAINT->LOJA)
				LFornec := AREAINT->FORNEC
				LLoja 	:= AREAINT->LOJA
			else
				LFornec := "099999"
				LLoja 	:= "01"
			endif
				
			ZY2->ZY2_CODEMP	:= AREAINT->CODEMP 
			ZY2->ZY2_FORNEC	:= LFornec
			ZY2->ZY2_LOJA	:= LLoja
			ZY2->ZY2_SERIE	:= AREAINT->SERIE
			ZY2->ZY2_NUMERO	:= AREAINT->NUMERO
			ZY2->ZY2_EMISSA	:= stod(subs(AREAINT->EMISSA,1,8))
			ZY2->ZY2_VALOR	:= AREAINT->VALOR
			ZY2->ZY2_OPERAC	:= AREAINT->OPERAC
			ZY2->ZY2_STATUS	:= AREAINT->STATUS
			ZY2->ZY2_DTINSE := stod(subs(AREAINT->DTINSE,1,8))
			ZY2->ZY2_DTVENC := stod(subs(AREAINT->DTVENC,1,8))
			ZY2->ZY2_AREA	:= AREAINT->AREA
		MSUNLOCK()                                    

		cDeleteArea := "DELETE FROM INTEGRACAOREQUISICOES WHERE CODEMP='"+ AREAINT->CODEMP +"' AND FORNEC='"+ AREAINT->FORNEC +"' AND LOJA='"+  AREAINT->LOJA +"' AND SERIE='"+ AREAINT->SERIE +"' AND NUMERO='"+ AREAINT->NUMERO +"' AND TO_CHAR(EMISSA,'YYYYMMDD')='"+ AREAINT->EMISSA +"' AND VALOR="+ Alltrim(StrTran(Transform(AREAINT->VALOR,"@E 999999999.99"),",",".")) +" AND OPERAC='"+ AREAINT->OPERAC +"' AND TO_CHAR(DTINSE,'YYYYMMDDHH24mmss') ='"+ AREAINT->DTINSE +"' AND RECNUMERO="+ ALLTRIM(Transform(AREAINT->RECNUMERO,"@E 99999999999")) 
		//cDeleteArea := "DELETE FROM INTEGRACAOREQUISICOES WHERE CODEMP='"+ AREAINT->CODEMP +"' AND FORNEC='"+ AREAINT->FORNEC +"' AND LOJA='"+  AREAINT->LOJA +"' AND SERIE='"+ AREAINT->SERIE +"' AND NUMERO='"+ AREAINT->NUMERO +"' AND TO_CHAR(EMISSA,'YYYYMMDD')='"+ AREAINT->EMISSA +"' AND VALOR="+ Alltrim(StrTran(Transform(AREAINT->VALOR,"@E 999999999.99"),",",".")) +" AND OPERAC='"+ AREAINT->OPERAC +"' AND TO_CHAR(DTINSE,'YYYYMMDDHH24mmss') ='"+ AREAINT->DTINSE +"'"
		
	    If TcSqlExec(cDeleteArea) = 1
			//DELETADO
		Else
		    //NAO DELETADO
	    EndIf
	    
		DbSelectArea("AREAINT")
		DBSkip()
	END
	DbSelectArea("AREAINT")
	DbCloseArea()
Return                                           




Static Function GetNatFornec(cFornec, cLoja)
	Private cQueryArea :=""
	Private cNatureza :=""

	cQueryArea := "select A2_COD, A2_LOJA, A2_NOME, A2_NATUREZ from SA2010 WHERE A2_FILIAL='"+xfilial("SA2")+"' AND A2_COD='"+ cFornec +"' AND A2_LOJA='"+ cLoja +"' AND D_E_L_E_T_<>'*'"
	TCQUERY cQueryArea NEW ALIAS "FORNEC"
	DbSelectArea("FORNEC")
	DBGOTOP()
	IF !EOF()                                                
		cNatureza	:= FORNEC->A2_NATUREZ
	ELSE 
		cNatureza	:= ""
	ENDIF
    DbSelectArea("FORNEC")
	DbCloseArea()
Return cNatureza



Static Function ValidaFornec(cFornec, cLoja)
	Private cQueryArea :=""
	Private bRetorno := .F.

	cQueryArea := "select A2_COD, A2_LOJA, A2_NOME, A2_NATUREZ from SA2010 WHERE A2_FILIAL='"+xfilial("SA2")+"' AND A2_COD='"+ cFornec +"' AND A2_LOJA='"+ cLoja +"' AND D_E_L_E_T_<>'*'"
	TCQUERY cQueryArea NEW ALIAS "VALFORNEC"
	DbSelectArea("VALFORNEC")
	DBGOTOP()
	IF !EOF()                                                
		bRetorno := .T.
	ELSE 
		bRetorno := .F.
	ENDIF
    DbSelectArea("VALFORNEC")
	DbCloseArea()
Return bRetorno


Static Function GetTitFornec(cSerie, cNumero)
	Private cQueryArea :=""
	Private cRetorno :=""

	cQueryArea := "select E2_FORNECE, E2_LOJA, E2_PREFIXO, E2_NUM from "+ RetSqlName("SE2") +" WHERE E2_FILIAL='"+ XFILIAL("SE2") +"' AND E2_PREFIXO='"+ cSerie +"' AND E2_NUM='"+ cNumero +"' AND D_E_L_E_T_<>'*'"
	TCQUERY cQueryArea NEW ALIAS "TITFORNEC"
	DbSelectArea("TITFORNEC")
	DBGOTOP()
	IF !EOF()                                                
		cRetorno	:= TITFORNEC->E2_FORNECE + TITFORNEC->E2_LOJA
	ELSE 
		cRetorno	:= SPACE(8)
	ENDIF
    DbSelectArea("TITFORNEC")
	DbCloseArea()
Return cRetorno

