User Function MyMata103b()

Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local nX     := 0
Local nY     := 0
Local cDoc   := ""
Local lOk    := .T.         

Private lMsHelpAuto := .T.
PRIVATE lMsErroAuto := .F.

//��������������������������������������������������������������Ŀ
//| Abertura do ambiente                                         |
//����������������������������������������������������������������

//ConOut(Repl("-",80))
//ConOut(PadC(OemToAnsi("Teste de Inclusao de 2 documentos de entrada com 2 itens cada"),80))
//PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "COM" TABLES "SF1","SD1","SA1","SA2","SB1","SB2","SF4"

//��������������������������������������������������������������Ŀ
//| Verificacao do ambiente para teste                           |
//����������������������������������������������������������������

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
	ConOut(OemToAnsi("Inicio: ")+ Time())	
	
	//��������������������������������������������������������������Ŀ	
	//| Verifica o ultimo documento valido para um fornecedor        |	
	//����������������������������������������������������������������	
	
	DbSelectArea("SF1")	
	DbSetOrder(2)	
	MsSeek(xFilial("SF1")+"F0000101z",.T.)	
	dbSkip(-1)	
	cDoc := SF1->F1_DOC	
	
	For nY := 1 To 2		
		aCabec := {}		
		aItens := {}		
		
		If Empty(cDoc)			
			cDoc := StrZero(1,Len(SD1->D1_DOC))		
		Else			
			cDoc := Soma1(cDoc)		
		EndIf		
		
		aadd(aCabec,{"F1_TIPO"   	,"N"})		
		aadd(aCabec,{"F1_FORMUL" 	,"N"})		
		aadd(aCabec,{"F1_DOC"    	,"TESTE1"})		
		aadd(aCabec,{"F1_SERIE"  	,"1"})		
		aadd(aCabec,{"F1_EMISSAO"	,dDataBase})		
		aadd(aCabec,{"F1_FORNECE"	,"000374"})		
		aadd(aCabec,{"F1_LOJA"   	,"01"})		
		aadd(aCabec,{"F1_ESPECIE"	,"SPED"})		
		aadd(aCabec,{"F1_COND"		,"001"})		
		aadd(aCabec,{"F1_DESPESA"   ,10})				
		aadd(aCabec,{"E2_NATUREZ"	,"85"})		
		
		For nX := 1 To 2			
			aLinha := {}			
			aadd(aLinha,{"D1_COD"  	,"02011040"	,Nil})			
			aadd(aLinha,{"D1_QUANT"	,1			,Nil})			
			aadd(aLinha,{"D1_VUNIT"	,100		,Nil})			
			aadd(aLinha,{"D1_TOTAL"	,100		,Nil})			
			aadd(aLinha,{"D1_TES"	,"001"		,Nil})			
			aadd(aItens,aLinha)		
		Next nX		
		
		//��������������������������������������������������������������Ŀ		
		//| Teste de Inclusao                                            |		
		//����������������������������������������������������������������                
		
		//MSExecAuto({|x,y| mata103(x,y)},aCabec,aItens)		
		MSExecAuto( {|x,y,z,w|MATA103( x, y, z, w ) }, aCab, aItens, 3, .T. )
		
		If !lMsErroAuto			
			ConOut(OemToAnsi("Incluido com sucesso! ")+cDoc)		
		Else			
			ConOut(OemToAnsi("Erro na inclusao!"))		
		EndIf	
		
		Next nY	
		ConOut(OemToAnsi("Fim  : ")+Time())
	EndIf
//	RESET ENVIRONMENT

Return(.T.)