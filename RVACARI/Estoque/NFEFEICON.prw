#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NFEFEICON  ºAutor  ³DOUGLAS R SILVA     º Data ³ 24/03/2014 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ ESTE FONTE TEM COMO OBJETIVO ALIMENTAR OS DOCUMENTOS DE    º±±
±±º          ³ ENTRADA COM AS NOTAS EMITIDAS PARA FEICON 2014             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PINI                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NFEFEICON()

Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local nX     := 0
Local nY     := 0
Local cDoc   := ""
Local lOk    := .T.         
Local CPERG := 'NFEFEICON'

Private lMsHelpAuto := .T.
Private lMsErroAuto := .F.

Pergunte(cPerg, .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//| Abertura do ambiente                                         |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*
ConOut(Repl("-",80))
ConOut(PadC(OemToAnsi("Teste de Inclusao de 2 documentos de entrada com 2 itens cada"),80))

//PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "COM" TABLES "SF1","SD1","SA1","SA2","SB1","SB2","SF4"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//| Verificacao do ambiente para teste                           |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea("SB1")
DbSetOrder(1)

If !SB1->(MsSeek(xFilial("SB1")+"PA001"))	
	lOk := .F.	
	ConOut(OemToAnsi("Cadastrar produto: PA001"))
EndIf

DbSelectArea("SF4")
DbSetOrder(1)

If !SF4->(MsSeek(xFilial("SF4")+"001"))	
	lOk := .F.	
	ConOut(OemToAnsi("Cadastrar TES: 001"))
EndIf

DbSelectArea("SE4")
DbSetOrder(1)

If !SE4->(MsSeek(xFilial("SE4")+"001"))	
	lOk := .F.	
	ConOut(OemToAnsi("Cadastrar condicao de pagamento: 001"))
EndIf

If !SB1->(MsSeek(xFilial("SB1")+"PA002"))	
	lOk := .F.	
	ConOut(OemToAnsi("Cadastrar produto: PA002"))
EndIf

DbSelectArea("SA2")
DbSetOrder(1)

If !SA2->(MsSeek(xFilial("SA2")+"F0000101"))	
	lOk := .F.	
	ConOut(OemToAnsi("Cadastrar fornecedor: F0000101"))
EndIf

If lOk	
	ConOut(OemToAnsi("Inicio: ")+Time())	
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//| Verifica o ultimo documento valido para um fornecedor        |	
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
*/

cQuery := "SELECT SF2.F2_DOC, SF2.F2_SERIE, SF2.F2_CLIENTE, SF2.F2_LOJA, SD2.D2_COD, SD2.D2_QUANT, SD2.D2_PRCVEN, SD2.D2_TOTAL, SF2.F2_CHVNFE" 
cQuery += " FROM "+RETSQLNAME("SF2")+" SF2"
cQuery += " JOIN "+RETSQLNAME("SD2")+" SD2 ON SD2.D_E_L_E_T_ != '*'" 
cQuery += "	AND SF2.F2_DOC = SD2.D2_DOC "
cQuery += "   AND SF2.F2_SERIE = SD2.D2_SERIE "
cQuery += "   AND SF2.F2_CLIENTE = SD2.D2_CLIENTE "
cQuery += "   AND SF2.F2_LOJA = SD2.D2_LOJA" 
cQuery += " WHERE SF2.D_E_L_E_T_ != '*'" 
cQuery += " AND SF2.F2_DOC = '"+MV_PAR01+"'"
cQuery += " AND SF2.F2_SERIE = '"+MV_PAR02+"'"

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRB", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
/*		
		aCabec := {}		
			
			aadd(aCabec,{"F1_TIPO"   	,"N"})		
			aadd(aCabec,{"F1_FORMUL" 	,"N"})		
			aadd(aCabec,{"F1_DOC"    	,TRB->F2_DOC})		
			aadd(aCabec,{"F1_SERIE"  	,TRB->F2_SERIE})		
			aadd(aCabec,{"F1_EMISSAO"	,dDataBase})		
			aadd(aCabec,{"F1_FORNECE"	,"000374"})		
			aadd(aCabec,{"F1_LOJA"   	,"1 "})		
			aadd(aCabec,{"F1_ESPECIE"	,"SPED"})		
			aadd(aCabec,{"F1_COND"		,"001"})	
	
	aItens := {}
	Do While TRB->(!EOF())			
					
				aadd(aLinha,{"D1_COD"  	,TRB->D2_COD		,Nil})			
				aadd(aLinha,{"D1_QUANT"	,TRB->D2_QUANT	,Nil})			
				aadd(aLinha,{"D1_VUNIT"	,TRB->D2_PRCVEN	,Nil})			
				aadd(aLinha,{"D1_TOTAL"	,TRB->D2_TOTAL	,Nil})			
				aadd(aLinha,{"D1_TES"	,"136"				,Nil})			
				aadd(aLinha,{"D1_LOCAL"	,"FE"				,Nil})
				aadd(aItens,aLinha)			            
						
		TRB->(DBSKIP())
	Enddo 
*/

SF1->(DBSELECTAREA("SF1"))
SF1->(DBSETORDER(1))

		If ! SF1->(DBSEEK(xFilial("SF1") + TRB->F2_CHVNFE)) 	
	
			// Define os campos do cabecalho
			_aCab := 	{{'F1_TIPO'	,,Nil},;
						{'F1_FORMUL'	,,Nil},;
						{'F1_DOC'		,,Nil},;
						{'F1_SERIE'	,,Nil},;
						{'F1_EMISSAO'	,,Nil},;
						{'F1_FORNECE'	,,Nil},;
						{'F1_LOJA'		,,Nil},;
						{'F1_ESPECIE'	,,Nil},;
						{'F1_CHVNFE'	,,Nil},;
						{'F1_STATUS'	,,Nil},;	
						{'F1_COND'		,,Nil}}	
						               
						_aCab[01,2] 	:= "N"
						_aCab[02,2] 	:= "N"			// Formulario Proprio
						_aCab[03,2] 	:= TRB->F2_DOC 	// Numero da NF
						_aCab[04,2] 	:= TRB->F2_SERIE	// Serie da NF
						_aCab[05,2] 	:= dDataBase  	// Data de NF
						_aCab[06,2] 	:= "000374"		// Fornecedor
						_aCab[07,2] 	:= "01"			// Loja Fornecedor
						_aCab[08,2] 	:= "SPED" 
						_aCab[09,2]	:= TRB->F2_CHVNFE	// Chave do XML 
						_aCab[10,2]	:= "A"			// Chave do XML  
						_aCab[11,2]	:= "001"		// Chave do XML 
						
			
		Do While TRB->(!EOF())			
					
				aadd(aLinha,{"D1_COD"  	,TRB->D2_COD		,Nil})			
				aadd(aLinha,{"D1_QUANT"	,TRB->D2_QUANT	,Nil})			
				aadd(aLinha,{"D1_VUNIT"	,TRB->D2_PRCVEN	,Nil})			
				aadd(aLinha,{"D1_TOTAL"	,TRB->D2_TOTAL	,Nil})			
				aadd(aLinha,{"D1_TES"	,"136"				,Nil})			
				aadd(aLinha,{"D1_LOCAL"	,"FE"				,Nil})
				aadd(aItens,aLinha)			            
						
		TRB->(DBSKIP())
		EndDo
	
	EndIf

	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿		
	//| Teste de Inclusao Pré Nota                                   |		
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
	
	MSExecAuto({|x,y| mata103(x,y)},aCabec,aItens)
	//MATA103(aCabec,aItens , 3 , .T.)
	
	If !lMsErroAuto			
		MsgInfo(OemToAnsi("Incluido com sucesso! ")+TRB->F2_DOC)		
	Else			
		Alert(OemToAnsi("Erro na inclusao!"))		
	EndIf
		
TRB->(DBCLOSEAREA("TRB"))
		
Return