#INCLUDE "protheus.ch"

/*/
//+-----------------------------------------------------------------------------------------------------+
//| Rotina | SCHAX1     | Autor | Douglas Rodrigues da Silva  | Data | 07.03.11							|
//+-----------------------------------------------------------------------------------------------------+
//| Descr. | Gerenciamento e Abertura				    		    									|
//+-----------------------------------------------------------------------------------------------------+
//| Uso 	| Esta rotina tem como função Abrir e gerenciar o chamados de T.I                        	|
//+-----------------------------------------------------------------------------------------------------+
/*/ 

User Function SCHAX01()
                                                                                                                                              
Private cCadastro := "Chamados de TI"
Private aRotina   := {	{"Pesquisar" 	, "AxPesqui"   	, 0, 1},;
							{"Visualizar"	, "U_SCHAX07"   	, 0, 2},;
							{"Atedimento" 	, "U_SCHAX08" 	, 0, 3},;
							{"Abertura"   	, "U_SCHAX09" 	, 0, 4},;
							{"Analista"  	, "U_SCHAX03" 	, 0, 5},;
							{"OS"  			, "U_SCHAX04" 	, 0, 6},;
							{"Imp OS"		, "U_SCHAR02"	, 0, 7},;
							{"Cancelar"  	, "U_SCHAX05"	, 0, 8},;
							{"Legenda"   	, "U_SCHAX06"	, 0, 9}}
	
Private cDelFunc := ".T."	// Validacao para a exclusao. Pode-se utilizar ExecBlock
Private cAlias   := "ZX1"

aCores := {{"ZX1->ZX1_STATUS == '1'", "BR_VERMELHO"}, {"ZX1->ZX1_STATUS == '2'", "BR_VERDE"}, {"ZX1->ZX1_STATUS == '3'", "BR_AMARELO"},{"ZX1->ZX1_STATUS == '5'", "BR_CINZA"},{"ZX1->ZX1_STATUS == '4'", "BR_PRETO"},{"ZX1->ZX1_STATUS == '6'", "BR_AZUL"}}

ZX1->(dbSetOrder(1))

mBrowse(6, 1, 22, 105, cAlias, , , , , 2, aCores)

Return 

/*/
//+-----------------------------------------------------------------------------------------------------+
//| Rotina | SCHAX1     | Autor | Douglas Rodrigues da Silva  | Data | 07.03.11							|
//+-----------------------------------------------------------------------------------------------------+
//| Descr. | Gerenciamento e Abertura				    		    									|
//+-----------------------------------------------------------------------------------------------------+
//| Uso 	| Esta rotina tem como função cancelar o chamado                                        	|
//+-----------------------------------------------------------------------------------------------------+
/*/ 

User Function SCHAX05()

Local lResp

If ZX1->ZX1_STATUS != "1"
	Alert("O chamado não está pendente!")
	Return 
EndIf

lResp := MsgYesNo("Confirma Cancelamento do Chamado?")

If lResp
	RecLock("ZX1", .F.)
		ZX1->ZX1_DTENC  := dDataBase
		ZX1->ZX1_HRENC  := SubStr(Time(), 1, 5)                                                                                                              
		ZX1->ZX1_STATUS := "3"	// Cancelado
	MsUnlock()
EndIf

Return

/*/
//+-----------------------------------------------------------------------------------------------------+
//| Rotina | SCHAX1     | Autor | Douglas Rodrigues da Silva  | Data | 07.03.11							|
//+-----------------------------------------------------------------------------------------------------+
//| Descr. | Gerenciamento e Abertura				    		    									|
//+-----------------------------------------------------------------------------------------------------+
//| Uso 	| Esta rotina tem como função Reservar o chamado para atendimento                       	|
//+-----------------------------------------------------------------------------------------------------+
/*/ 

User Function SCHAX08()

Local lResp
Local cUser 	:= CUSERNAME  

If ZX1->ZX1_STATUS != "1"
	Alert("O chamado não está pendente!")
	Return 
EndIf

lResp := MsgYesNo("Confirma o Atendimento?")

If lResp
	RecLock("ZX1", .F.)
		ZX1->ZX1_ANALIS	:= cUser
		ZX1->ZX1_DTENT  	:= dDataBase        
		ZX1->ZX1_HENT  	:= SubStr(Time(), 1, 5)                                                                                                              
		ZX1->ZX1_STATUS 	:= "6"	// Cancelado
	MsUnlock()
EndIf

Return

/*/
//+-----------------------------------------------------------------------------------------------------+
//| Rotina | SCHAX2     | Autor | Douglas Rodrigues da Silva  | Data | 07.03.11							|
//+-----------------------------------------------------------------------------------------------------+
//| Descr. | Gerenciamento e Abertura				    		    									|
//+-----------------------------------------------------------------------------------------------------+
//| Uso 	| Esta rotina tem como função Abertura de Chamado                                        	|
//+-----------------------------------------------------------------------------------------------------+
/*/ 

User Function SCHAX02()

Private cCadastro := "Chamados de TI"
Private aRotina   := {	{"Pesquisar" 	, "AxPesqui"   	, 0, 1},;
						{"Visualizar"	, "U_SCHAX07"   	, 0, 2},;
						{"Abertura"   	, "U_SCHAX09" 	, 0, 3},;
						{"Legenda"   	, "U_SCHAX06"	, 0, 4}}

Private cDelFunc := ".T."	// Validacao para a exclusao. Pode-se utilizar ExecBlock
Private cAlias   := "ZX1"

aCores := {{"ZX1->ZX1_STATUS == '1'", "BR_VERMELHO"}, {"ZX1->ZX1_STATUS == '2'", "BR_VERDE"}, {"ZX1->ZX1_STATUS == '3'", "BR_AMARELO"},{"ZX1->ZX1_STATUS == '5'", "BR_CINZA"},{"ZX1->ZX1_STATUS == '4'", "BR_PRETO"},{"ZX1->ZX1_STATUS == '6'", "BR_AZUL"}}

ZX1->(dbSetOrder(1))

mBrowse(6, 1, 22, 105, cAlias, , , , , 2, aCores)

Return   

User Function SCHAX09()

Local cXFilial		:= xFilial("ZX1")
Local cNumero        
Local dDataAber		:= Date()
Local cHora			:= SubStr(Time(), 1, 5)  
Local cUsuario      := CUSERNAME 
Local cAnalista    	:= CUSERNAME
Local cArea          
Local cCodProj      := SPACE(6)
Local cDepartamento 
Local cGerente 		:= SPACE(20)
Local cChamado3 	:= SPACE(20)
Local cTel          := SPACE(20)
//Local cOcorrencia   
Local cDescricao	:= SPACE(50)
Local cSolucao		:= SPACE(50)
Local cDP           := SPACE(50)
Local dDataEnt 		:= Date()
Local dDataSai		:= Date()
Local cHoraEnt		:= SubStr(Time(), 1, 5)
Local cHoraSai 		:= SubStr(Time(), 1, 5)
Local cEmail        := SPACE(40)
Local cObs          := SPACE(40)

Static oDlgOS
Static oButton1
Static oButton2
Static oComboBox1
Static nComboBox1 := 1
Static oComboBox2
Static nComboBox2 := 1
Static oComboBox3
Static nComboBox3 := 1
Static oComboBox4
Static nComboBox4 := 1
Static oFont1 := TFont():New("Arial",,022,,.T.,,,,,.F.,.T.) 
Static oFontt := TFont():New("Calibri",,022,,.F.,,,,,.F.,.F.)
Static oFont3 := TFont():New("Calibri",,024,,.F.,,,,,.F.,.F.)
Static oFont2 := TFont():New("Calibri",,026,,.T.,,,,,.F.,.F.)
Static oGet1
Static cGet1 := "Define variable value"
Static oGet16
Static cGet16 := "Define variable value"
Static oGet2
Static cGet2 := "Define variable value"
Static oGet3
Static cGet3 := "Define variable value"
Static oGet4
Static cGet4 := "Define variable value"
Static oGet5
Static cGet5 := "Define variable value"
Static oGet6
Static cGet6 := "Define variable value"
Static oGet7
Static cGet7 := "Define variable value"
Static oGet9
Static cGet9 := "Define variable value"
Static oGroup1
Static oGroup2
Static oGroup3
Static oGroup4
Static oGroup6
Static oMultiGet1
Static cMultiGet1 := "Define variable value"
Static oSay1
Static oSay10
Static oSay11
Static oSay12
Static oSay13
Static oSay2
Static oSay21
Static oSay23
Static oSay3
Static oSay4
Static oSay5
Static oSay6
Static oSay7
Static oSay8 

Local lResp   := .F.

Local cCombAR := "           " 
Local aCombAR := {"         ","1=Hardware","2=Software","3=Rede","4=Impressora","5=Tel (Voip)","6=Remanejamento",;
					"7=TOTVS","8=Vistoria","9=Aloha","10=No-Break","11=CFTV","12=TI ADM","13=Outros"} 

//Departamento
Local cCombDP := "           "
Local aCombDP := {"         ","1=Financeiro","2=RH","3=Fiscal","4=Contabil","5=TI","6=Planejamento",;
					"7=Diretoria","8=Chalet","13=Outros"}
					
//Prestacao de servico
Local cCombSE := "           "
Local aCombSE := {"         ","1=VTT","2=Aloha","3=G4","4=Micros","5=Bematech","6=Cielo",;
					"7=Otech","8=Novits","9=Linx","10=TopHelp","11=Outros"}

//Ocorrencia					
Local cCombOC := "              "					
Local aCombOC := {"         ","1=Manunteção","2=Preventiva","3=Service","4=Acompanhamento","13=Outros"}

//Numeração do Chamado....

cSeq	:= Getmv("MV_SCHAXMV")
    
 	nValor1 := Val(cSeq)
 	nValor2 := 1
 	nResult	:= nValor1 + nValor2
 	
 PutMV("MV_SCHAXMV",STRZERO(nResult,5))
 
 cNumero := "S" + STRZERO(nResult,5)


  DEFINE MSDIALOG oDlgOS TITLE "Abertura de Chamado" FROM 000, 000  TO 390, 700 COLORS 0, 16777215 PIXEL

    @ 026, 003 GROUP oGroup1 TO 063, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
    
    //alinhamento                              tamanho
    @ 034, 054 SAY oSay2 PROMPT "Numero" SIZE 023, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 034, 005 SAY oSay3 PROMPT "Filial" SIZE 013, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 007, 112 SAY oSay1 PROMPT "Abertura de Chamado" SIZE 109, 013 OF oDlgOS FONT oFont1 COLORS 0, 16777215 PIXEL
    @ 034, 116 SAY oSay4 PROMPT "Data Abertura" SIZE 037, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 034, 205 SAY oSay5 PROMPT "Hora" SIZE 014, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 034, 255 SAY oSay6 PROMPT "Usuario" SIZE 021, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 075, 004 SAY oSay7 PROMPT "Gerente" SIZE 022, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 048, 005 SAY oSay10 PROMPT "Area" SIZE 015, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 048, 080 SAY oSay11 PROMPT "Codigo do Projeto" SIZE 045, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 049, 183 SAY oSay12 PROMPT "Departamento" SIZE 036, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 049, 270 SAY oSay14 PROMPT "Prest serv" SIZE 025, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 097, 004 SAY oSay13 PROMPT "Descrição" SIZE 025, 007 OF oDlgOS COLORS 0, 16777215 PIXEL // AQUI !!!!!!!!
    @ 075, 157 SAY oSay21 PROMPT "Tel" SIZE 011, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 075, 211 SAY oSay23 PROMPT "Ocorrencia" SIZE 029, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 075, 082 SAY oSay8 PROMPT "Chamado 3º" SIZE 032, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    
    @ 003, 002 GROUP oGroup2 TO 023, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
    @ 068, 002 GROUP oGroup3 TO 088, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
    @ 092, 002 GROUP oGroup4 TO 161, 345 OF oDlgOS COLOR 0, 16777215 PIXEL
    @ 167, 002 GROUP oGroup6 TO 186, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
                  
	@ 047, 020 COMBOBOX oComboBox1 VAR cCombAR VALID !Empty(cCombAR) ITEMS aCombAR SIZE 057, 010 OF oDlgOS COLORS 0, 16777215 PIXEL     
	@ 047, 220 COMBOBOX oComboBox2 VAR cCombDP VALID !Empty(cCombDP) ITEMS aCombDP SIZE 047, 010 OF oDlgOS COLORS 0, 16777215 PIXEL 
	@ 073, 240 COMBOBOX oComboBox3  VAR cCombOC VALID !Empty(cCombOC) ITEMS aCombOC SIZE 054, 010 OF oDlgOS COLORS 0, 16777215 PIXEL  
	@ 048, 297 COMBOBOX oComboBox4  VAR cCombSE VALID !Empty(cCombSE) ITEMS aCombSE SIZE 043, 010 OF oDlgOS COLORS 0, 16777215 PIXEL  
	
	@ 097, 031 GET oMultiGet1 VAR cDescricao VALID !Empty(cDescricao) OF oDlgOS MULTILINE SIZE 309, 058 COLORS 0, 16777215 HSCROLL NO VSCROLL PIXEL
	    
	@ 073, 026 MSGET oGet6 VAR cGerente SIZE 053, 010 OF oDlgOS COLORS 0, 16777215 PIXEl     
	@ 073, 114 MSGET oGet7 VAR cChamado3 SIZE 040, 010 OF oDlgOS COLORS 0, 16777215 PIXEL     
    @ 073, 168 MSGET oGet16 VAR cTel SIZE 040, 010 OF oDlgOS PICTURE "@E (99)9999-9999" COLORS 0, 16777215 PIXEL
    
    @ 032, 019 MSGET oGet2 VAR cXFilial SIZE 034, 010 OF oDlgOS PICTURE "@E 99" COLORS 0, 16777215 PIXEL
    @ 032, 078 MSGET oGet1 VAR cNumero SIZE 034, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 032, 153 MSGET oGet3 VAR dDataAber SIZE 050, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL    
    @ 032, 221 MSGET oGet4 VAR cHora SIZE 032, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL    
    @ 032, 277 MSGET oGet5 VAR cUsuario SIZE 063, 010 OF oDlgOS COLORS 0, 16777215 PIXEL                             
       
	@ 047, 128 MSGET oGet9 VAR cCodProj SIZE 051, 010 OF oDlgOS COLORS 0, 16777215 PIXEL
    
    @ 171, 260 BUTTON oButton2 PROMPT "&Confirma" SIZE 037, 012 OF oDlgOS ACTION {|| lResp := .T., oDlgOS:End()}  PIXEL   
    @ 171, 303 BUTTON oButton1 PROMPT "&Sair" SIZE 037, 012 OF oDlgOS ACTION {|| oDlgOS:End()} PIXEL     
    
  ACTIVATE MSDIALOG oDlgOS CENTERED 

If lResp        
   
	RecLock("ZX1", .T.)
			
		ZX1->ZX1_FILIAL  	:= cXFilial	 
		ZX1->ZX1_NUM 		:= cNumero 	
		ZX1->ZX1_DTSOLI 	:= dDataAber
		ZX1->ZX1_HRSOLI 	:= cHora 
		ZX1->ZX1_USUARI 	:= cUsuario 
		ZX1->ZX1_ANALIS 	:= cAnalista
		ZX1->ZX1_TIPO 		:= cCombAR 
		ZX1->ZX1_CODPRO 	:= cCodProj
		ZX1->ZX1_DEP     	:= cCombDP
		ZX1->ZX1_NOMGER  	:= cGerente
		ZX1->ZX1_CHA3    	:= cChamado3 
		ZX1->ZX1_TEL	    := cTel
		ZX1->ZX1_OCORRE  	:= cCombOC
		ZX1->ZX1_PREST   	:= cCombSE 
		ZX1->ZX1_DESCR1	:= cDescricao
		ZX1->ZX1_SOLU    	:= cSolucao
		ZX1->ZX1_DP      	:= cDP 
		ZX1->ZX1_STATUS  	:= "1" 
		/*
		ZX1->ZX1_DTENT	:= dDataEnt
		ZX1->ZX1_DTSAI	:= dDataSai
		ZX1->ZX1_HENT	:= cHoraEnt
		ZX1->ZX1_HSAI	:= cHoraSai
		ZX1->ZX1_EMAIL	:= cEmail
		ZX1->ZX1_OBS		:= cObs		
		ZX1->ZX1_DTENC 	:= dEnc 
		ZX1->ZX1_HRENC 	:= cEnc 	
		*/
	MsUnlock() 
	
 DEFINE MSDIALOG oDlgAbr1 TITLE "Abertura de Chamado..." FROM 000, 000  TO 400, 400 COLORS 0, 16777215 PIXEL

    @ 034, 008 SAY oSayA PROMPT "Atencão" SIZE 040, 014 OF oDlgAbr1 FONT oFont3 COLORS 255, 16777215 PIXEL
    @ 062, 007 SAY oSay2 PROMPT "Abertura do seu chamado foi efetuada com sucesso. " SIZE 184, 027 OF oDlgAbr1 FONT oFontt COLORS 16711680, 16777215 PIXEL
   // @ 149, 005 SAY oSay3 PROMPT "Deseja abrir outro Chamado?" SIZE 118, 014 OF oDlgAbr1 FONT oFontt COLORS 16711680, 16777215 PIXEL
   // @ 181, 107 BUTTON oButton1 PROMPT "&Sim" SIZE 035, 012 OF oDlgAbr1 ACTION {|| lResp := .T., oDlgAbr1:End()} Pixel //{|| U_SCHAX2() }  PIXEL
    @ 181, 152 BUTTON oButton3 PROMPT "&Sair" SIZE 037, 012 OF oDlgAbr1 ACTION {|| oDlgAbr1:End()} PIXEL
    @ 108, 007 SAY oSay4 PROMPT "Numero do Chamado:" SIZE 091, 013 OF oDlgAbr1 FONT oFontt COLORS 16711680, 16777215 PIXEL
    @ 008, 045 SAY oSay1 PROMPT "BGK DO BRASIL SA" SIZE 096, 015 OF oDlgAbr1 FONT oFont2 COLORS 16711680, 16777215 PIXEL
    @ 108, 101 SAY oSay5 PROMPT cNumero SIZE 065, 013 OF oDlgAbr1 FONT oFontt COLORS 255, 16777215 PIXEL
  ACTIVATE MSDIALOG oDlgAbr1 CENTERED

Return

Else
       
	If lResp
		U_SCHAX02()
	Else
		Return()
    Endif
EndIf
	
Return

/*/
//+-----------------------------------------------------------------------------------------------------+
//| Rotina | SCHAX3     | Autor | Douglas Rodrigues da Silva  | Data | 07.03.11							|
//+-----------------------------------------------------------------------------------------------------+
//| Descr. | Gerenciamento e Abertura				    		    									|
//+-----------------------------------------------------------------------------------------------------+
//| Uso 	| Gerenciamento de Chamado											                       	|
//+-----------------------------------------------------------------------------------------------------+
/*/  

User Function SCHAX03()
                       
Local dAbert  		:= Date()
Local dAbert1  	:= Date()
Local dAbert2  	:= Date()
Local dAbert3  	:= Date()
Local cHoraTI 		:= SubStr(Time(), 1, 5) 
Local cHoraTI1 	:= SubStr(Time(), 1, 5)
Local cHoraTI2 	:= SubStr(Time(), 1, 5)
Local cMemo   		:= SPACE(50)
Local cUser 		:= CUSERNAME                                                                                                              
Local lResp   		:= .F.
Local cObserva 
Local cHistorico
Local cChamado  := ZX1->ZX1_DESCR1
//Local cHistor   := ZX1->ZX1_HIST  // mudei aqui
Local cEmail    := SPACE(50) 

Local oDlgEnc, oSay1, oGetData, oSay3, oGetHora, oGrp5, oSBtn7, oBtnCancel 

Local 	cNumCha		:= ZX1->ZX1_NUM 
Local	cObserva 		:= 	SPACE(140)
Local	cHistorico 	:= 	SPACE(140)

Local 		cCombTr		:= ZX1->ZX1_TIPO
Local 		aCombTr		:= {"1=Hardware","2=Software","3=Rede","4=Impressora","5=Tel (Voip)","6=Remanejamento",;
									"7=TOTVS","8=Vistoria","9=Aloha","10=No-Break","11=CFTV","12=TI ADM","13=Outros"}
Local cCombTr1 := "5=Em andamento"
Local aCombTr1 := {"2=Encerrar","3=Cancelar","4=Encaminhar", "5=Em andamento"}

//cEmail := CUSERNAME + "@BGKDOBRASIL.COM.BR"

If ZX1->ZX1_STATUS == "2"
	Alert("O chamado está Encerrado!")
	Return 
Elseif ZX1->ZX1_STATUS == "3"
	Alert("Chamado Cancelado!")
	Return
EndIf						

DEFINE MSDIALOG oDlgEnc TITLE "Area do Analista" FROM 000, 000  TO 380, 600 COLORS 0, 16777215 PIXEL

oGrp5                 := TGroup():Create(oDlgEnc)
oGrp5:cName           := "oGrp5"
oGrp5:nLeft           := 14
oGrp5:nTop            := 20
oGrp5:nWidth          := 565
oGrp5:nHeight         := 300
oGrp5:lShowHint       := .F.
oGrp5:lReadOnly       := .F.
oGrp5:Align           := 0
oGrp5:lVisibleControl := .T.


@ 100,40 GET oMultiGet1 VAR cObserva VALID !Empty(cObserva) OF oDlgEnc MULTILINE SIZE 135,30  HSCROLL NO VSCROLL PIXEL
@ 061, 40 GET oMultiGet1 VAR cChamado VALID !Empty(cObserva) OF oDlgEnc MULTILINE SIZE 135,30 READONLY  HSCROLL NO VSCROLL PIXEL 

@ 061, 40 GET oMultiGet1 VAR cHistor VALID !Empty(cHistorico) OF oDlgEnc MULTILINE SIZE 135,30 READONLY  HSCROLL NO VSCROLL PIXEL // aqui

@ 135, 40 MSGET oGet2 VAR cEmail PICTURE "@!"  VALID !Empty(cEmail) SIZE 200, 010 OF oDlgEnc COLORS 16711680, 16777215 PIXEL 
@ 045,31  COMBOBOX oCombo VAR cCombTr ITEMS aCombTr SIZE 060,30 PIXEL OF oDlgEnc when .T.  
@ 045,125 COMBOBOX oCombo VAR cCombTr1 ITEMS aCombTr1 SIZE 050,30 PIXEL OF oDlgEnc when .T.

oSay1                 := TSay():Create(oDlgEnc)
oSay1:cName           := "oSay1"
oSay1:cCaption        := "Data"
oSay1:nLeft           := 215
oSay1:nTop            := 34
oSay1:nWidth          := 45
oSay1:nHeight         := 17
oSay1:lShowHint       := .F.
oSay1:lReadOnly       := .F.
oSay1:Align           := 0
oSay1:lVisibleControl := .T.
oSay1:lWordWrap       := .F.
oSay1:lTransparent    := .F.   

oSay1                 := TSay():Create(oDlgEnc)
oSay1:cName           := "oSay1"
oSay1:cCaption        := "Data E.."
oSay1:nLeft           := 365
oSay1:nTop            := 34
oSay1:nWidth          := 75
oSay1:nHeight         := 17
oSay1:lShowHint       := .F.
oSay1:lReadOnly       := .F.
oSay1:Align           := 0
oSay1:lVisibleControl := .T.
oSay1:lWordWrap       := .F.
oSay1:lTransparent    := .F.    

oSay1                 := TSay():Create(oDlgEnc)
oSay1:cName           := "oSay1"
oSay1:cCaption        := "Data S.."
oSay1:nLeft           := 365
oSay1:nTop            := 62
oSay1:nWidth          := 75
oSay1:nHeight         := 17
oSay1:lShowHint       := .F.
oSay1:lReadOnly       := .F.
oSay1:Align           := 0
oSay1:lVisibleControl := .T.
oSay1:lWordWrap       := .F.
oSay1:lTransparent    := .F.

oSay1                 := TSay():Create(oDlgEnc)
oSay1:cName           := "oSay1"
oSay1:cCaption        := "Hora S.."
oSay1:nLeft           := 365   
oSay1:nTop            := 118
oSay1:nWidth          := 75
oSay1:nHeight         := 17
oSay1:lShowHint       := .F.
oSay1:lReadOnly       := .F.
oSay1:Align           := 0
oSay1:lVisibleControl := .T.
oSay1:lWordWrap       := .F.
oSay1:lTransparent    := .F.

oSay1                 := TSay():Create(oDlgEnc)
oSay1:cName           := "oSay1"
oSay1:cCaption        := "Hora E.."
oSay1:nLeft           := 365
oSay1:nTop            := 90
oSay1:nWidth          := 75
oSay1:nHeight         := 17
oSay1:lShowHint       := .F.
oSay1:lReadOnly       := .F.
oSay1:Align           := 0
oSay1:lVisibleControl := .T.
oSay1:lWordWrap       := .F.
oSay1:lTransparent    := .F.  

oGetData                 := TGet():Create(oDlgEnc)
oGetData:cName           := "oGetData1"
oGetData:nLeft           := 250
oGetData:nTop            := 34
oGetData:nWidth          := 100
oGetData:nHeight         := 21
oGetData:lShowHint       := .F.
oGetData:lReadOnly       := .F.
oGetData:Align           := 0
oGetData:cVariable       := "dAbert1"
oGetData:bSetGet         := {|u| If(PCount() > 0, dAbert1 := u, dAbert1)}
oGetData:lVisibleControl := .T.
oGetData:lPassword       := .F.
oGetData:Picture         := "@D"
oGetData:lHasButton      := .T. 

oGetData                 := TGet():Create(oDlgEnc)
oGetData:cName           := "oGetData2"
oGetData:nLeft           := 415
oGetData:nTop            := 34
oGetData:nWidth          := 100
oGetData:nHeight         := 21
oGetData:lShowHint       := .F.
oGetData:lReadOnly       := .F.
oGetData:Align           := 0
oGetData:cVariable       := "dAbert2"
oGetData:bSetGet         := {|u| If(PCount() > 0, dAbert2 := u, dAbert2)}
oGetData:lVisibleControl := .T.
oGetData:lPassword       := .F.
oGetData:Picture         := "@D"
oGetData:lHasButton      := .T. 

oGetData                 := TGet():Create(oDlgEnc)
oGetData:cName           := "oGetData3"
oGetData:nLeft           := 415
oGetData:nTop            := 62
oGetData:nWidth          := 100
oGetData:nHeight         := 21
oGetData:lShowHint       := .F.
oGetData:lReadOnly       := .F.
oGetData:Align           := 0
oGetData:cVariable       := "dAbert3"
oGetData:bSetGet         := {|u| If(PCount() > 0, dAbert3 := u, dAbert3)}
oGetData:lVisibleControl := .T.
oGetData:lPassword       := .F.
oGetData:Picture         := "@D"
oGetData:lHasButton      := .T. 

oGetHora                 := TGet():Create(oDlgEnc)
oGetHora:cName           := "oGetHora1"
oGetHora:nLeft           := 415
oGetHora:nTop            := 90
oGetHora:nWidth          := 80
oGetHora:nHeight         := 21
oGetHora:lShowHint       := .F.
oGetHora:lReadOnly       := .F.
oGetHora:Align           := 0
oGetHora:cVariable       := "cHoraTI1"
oGetHora:bSetGet         := {|u| If(PCount() > 0, cHoraTI1 := u, cHoraTI1)}
oGetHora:lVisibleControl := .T.
oGetHora:lPassword       := .F.
oGetHora:Picture         := "99:99"
oGetHora:lHasButton      := .F.

oGetHora                 := TGet():Create(oDlgEnc)
oGetHora:cName           := "oGetHora1"
oGetHora:nLeft           := 415
oGetHora:nTop            := 118
oGetHora:nWidth          := 80
oGetHora:nHeight         := 21
oGetHora:lShowHint       := .F.
oGetHora:lReadOnly       := .F.
oGetHora:Align           := 0
oGetHora:cVariable       := "cHoraTI2"
oGetHora:bSetGet         := {|u| If(PCount() > 0, cHoraTI2 := u, cHoraTI2)}
oGetHora:lVisibleControl := .T.
oGetHora:lPassword       := .F.
oGetHora:Picture         := "99:99"
oGetHora:lHasButton      := .F.

oSay3                 := TSay():Create(oDlgEnc)
oSay3:cName           := "oSay6"
oSay3:cCaption        := "Num"
oSay3:nLeft           := 26
oSay3:nTop            := 35
oSay3:nWidth          := 37
oSay3:nHeight         := 17
oSay3:lShowHint       := .F.
oSay3:lReadOnly       := .F.
oSay3:Align           := 0
oSay3:lVisibleControl := .T.
oSay3:lWordWrap       := .F.
oSay3:lTransparent    := .F.  

oGetHora                 := TGet():Create(oDlgEnc)
oGetHora:cName           := "oGetCham"
oGetHora:nLeft           := 62
oGetHora:nTop            := 34
oGetHora:nWidth          := 80
oGetHora:nHeight         := 20
oGetHora:lShowHint       := .F.
oGetHora:lReadOnly       := .T.
oGetHora:Align           := 0
oGetHora:cVariable       := "cNumCha"
oGetHora:bSetGet         := {|u| If(PCount() > 0, cNumCha := u, cNumCha)}
oGetHora:lVisibleControl := .T.
oGetHora:lPassword       := .F.
oGetHora:Picture         := "@!"
oGetHora:lHasButton      := .F.  

oSay3                 := TSay():Create(oDlgEnc)
oSay3:cName           := "oSay4"
oSay3:cCaption        := "Analista"
oSay3:nLeft           := 200
oSay3:nTop            := 62
oSay3:nWidth          := 40
oSay3:nHeight         := 20
oSay3:lShowHint       := .F.
oSay3:lReadOnly       := .T.
oSay3:Align           := 0
oSay3:lVisibleControl := .T.
oSay3:lWordWrap       := .F.
oSay3:lTransparent    := .F.   

oSay3                 := TSay():Create(oDlgEnc)
oSay3:cName           := "oSay4"
oSay3:cCaption        := "Descric"
oSay3:nLeft           := 200
oSay3:nTop            := 92
oSay3:nWidth          := 40
oSay3:nHeight         := 20
oSay3:lShowHint       := .F.
oSay3:lReadOnly       := .F.
oSay3:Align           := 0
oSay3:lVisibleControl := .T.
oSay3:lWordWrap       := .F.
oSay3:lTransparent    := .F.    

oGetHora                 := TGet():Create(oDlgEnc)
oGetHora:cName           := "oGetUser"
oGetHora:nLeft           :=  250
oGetHora:nTop            := 62
oGetHora:nWidth          := 100
oGetHora:nHeight         := 20
oGetHora:lShowHint       := .F.
oGetHora:lReadOnly       := .T.
oGetHora:Align           := 0
oGetHora:cVariable       := "cUser"
oGetHora:bSetGet         := {|u| If(PCount() > 0, cUser := u, cUser)}
oGetHora:lVisibleControl := .T.
oGetHora:lPassword       := .F.
oGetHora:Picture         := "@!"
oGetHora:lHasButton      := .F.   

oSay3                 := TSay():Create(oDlgEnc)
oSay3:cName           := "oSay3"
oSay3:cCaption        := "Hora"
oSay3:nLeft           := 26
oSay3:nTop            := 65
oSay3:nWidth          := 37
oSay3:nHeight         := 17
oSay3:lShowHint       := .F.
oSay3:lReadOnly       := .F.
oSay3:Align           := 0
oSay3:lVisibleControl := .T.
oSay3:lWordWrap       := .F.
oSay3:lTransparent    := .F.

oGetHora                 := TGet():Create(oDlgEnc)
oGetHora:cName           := "oGetHora"
oGetHora:nLeft           := 62
oGetHora:nTop            := 62
oGetHora:nWidth          := 80
oGetHora:nHeight         := 21
oGetHora:lShowHint       := .F.
oGetHora:lReadOnly       := .F.
oGetHora:Align           := 0
oGetHora:cVariable       := "cHoraTI"
oGetHora:bSetGet         := {|u| If(PCount() > 0, cHoraTI := u, cHoraTI)}
oGetHora:lVisibleControl := .T.
oGetHora:lPassword       := .F.
oGetHora:Picture         := "99:99"
oGetHora:lHasButton      := .F.
  

oSay3                 := TSay():Create(oDlgEnc)
oSay3:cName           := "oSay4"
oSay3:cCaption        := "Area"
oSay3:nLeft           := 26
oSay3:nTop            := 95
oSay3:nWidth          := 60
oSay3:nHeight         := 17
oSay3:lShowHint       := .F.
oSay3:lReadOnly       := .F.
oSay3:Align           := 0
oSay3:lVisibleControl := .T.
oSay3:lWordWrap       := .F.
oSay3:lTransparent    := .F. 

oSay3                 := TSay():Create(oDlgEnc)
oSay3:cName           := "oSay4"
oSay3:cCaption        := "Chamado"
oSay3:nLeft           := 26
oSay3:nTop            := 120
oSay3:nWidth          := 60
oSay3:nHeight         := 17
oSay3:lShowHint       := .F.
oSay3:lReadOnly       := .F.
oSay3:Align           := 0
oSay3:lVisibleControl := .T.
oSay3:lWordWrap       := .F.
oSay3:lTransparent    := .F.  

oSay3                 := TSay():Create(oDlgEnc)
oSay3:cName           := "oSay4"
oSay3:cCaption        := "Descric"
oSay3:nLeft           := 26
oSay3:nTop            := 200
oSay3:nWidth          := 60
oSay3:nHeight         := 17
oSay3:lShowHint       := .F.
oSay3:lReadOnly       := .F.
oSay3:Align           := 0
oSay3:lVisibleControl := .T.
oSay3:lWordWrap       := .F.
oSay3:lTransparent    := .F. 
                              
oSay3                 := TSay():Create(oDlgEnc)
oSay3:cName           := "oSay4"
oSay3:cCaption        := "E-Mail"
oSay3:nLeft           := 26
oSay3:nTop            := 275
oSay3:nWidth          := 60
oSay3:nHeight         := 17
oSay3:lShowHint       := .F.
oSay3:lReadOnly       := .F.
oSay3:Align           := 0
oSay3:lVisibleControl := .T.
oSay3:lWordWrap       := .F.
oSay3:lTransparent    := .F.                               
                                                                               
oSBtn7                 := SButton():Create(oDlgEnc)
oSBtn7:cName           := "oSBtn7"
oSBtn7:cCaption        := "OK"
oSBtn7:nLeft           := 450
oSBtn7:nTop            := 335
oSBtn7:nWidth          := 55
oSBtn7:nHeight         := 22
oSBtn7:lShowHint       := .F.
oSBtn7:lReadOnly       := .F.
oSBtn7:Align           := 0
oSBtn7:lVisibleControl := .T.
oSBtn7:nType           := 1
oSBtn7:bLClicked       := {|| lResp := MsgYesNo("Deseja encerrar o chamado ? "), oDlgEnc:End()}

oBtnCancel                 := SButton():Create(oDlgEnc)
oBtnCancel:cName           := "oBtnCancel"
oBtnCancel:cCaption        := "Cancelar"
oBtnCancel:nLeft           := 526
oBtnCancel:nTop            := 335
oBtnCancel:nWidth          := 55
oBtnCancel:nHeight         := 22
oBtnCancel:lShowHint       := .F.
oBtnCancel:lReadOnly       := .F.
oBtnCancel:Align           := 0
oBtnCancel:lVisibleControl := .T.
oBtnCancel:nType           := 2
oBtnCancel:bLClicked       := {|| oDlgEnc:End()}

  ACTIVATE MSDIALOG oDlgEnc CENTERED
//oDlgEnc:Activate

//Fecha Chamado

If lResp
	RecLock("ZX1", .F.)
	
		ZX1->ZX1_ANALIS 	:= cUser  
		ZX1->ZX1_DTENC 	:= dAbert1
		ZX1->ZX1_HRENC 	:= cHoraTI
		ZX1->ZX1_STATUS  	:= cCombTr1 
		ZX1->ZX1_SOLU		:= cObserva
		ZX1->ZX1_TIPO		:= cCombTr
		ZX1->ZX1_DTENT   	:= dAbert1
		ZX1->ZX1_DTSAI	:= dAbert2 
		ZX1->ZX1_HENT		:= cHoraTI1
		ZX1->ZX1_HSAI		:= cHoraTI2 
		ZX1->ZX1_EMAIL   	:= cEmail
		//ZX1->ZX1_HIST    := cHistorico
		
	MsUnlock()
Else

	Return()

EndIf 
  


Return 

User Function SCHAX06()

BrwLegenda(cCadastro, "Legenda", {	{"BR_VERDE"   	, "Chamado Encerrado" 	},;
									{"BR_VERMELHO"	, "Chamado Pendente"	},;
									{"BR_AZUL"		, "Chamado em Atendimento"	},;
									{"BR_PRETO"		, "Chamado Transferido"	},;
									{"BR_CINZA"		, "OS"	},;
									{"BR_AMARELO" 	, "Chamado Cancelado"	}})

Return


Static Function SCHAXMVZ()

Local cSeg

 cSeq:= GetNewPar("MV_SCHAXMV","00000")
	cSeq := Soma1(cSeq)
 PutMV("MV_SCHAXMV",cSeq)

Return(cSeq)    

/*/
//+-----------------------------------------------------------------------------------------------------+
//| Rotina | SCHAX4     | Autor | Douglas Rodrigues da Silva  | Data | 07.03.11							|
//+-----------------------------------------------------------------------------------------------------+
//| Descr. | Gerenciamento e Abertura				    		    									|
//+-----------------------------------------------------------------------------------------------------+
//| Uso 	| Abertura de chamado OS											                      	|
//+-----------------------------------------------------------------------------------------------------+
/*/ 

User Function SCHAX04 
  
Local cXFilial		:= xFilial("ZX1")
Local cNumero        
Local dDataAber		:= Date()
Local cHora			:= SubStr(Time(), 1, 5)  
Local cUsuario      := CUSERNAME 
Local cAnalista    	:= CUSERNAME
Local cArea          
Local cCodProj      := SPACE(6)
Local cDepartamento 
Local cGerente 		:= SPACE(20)
Local cChamado3 	:= SPACE(20)
Local cTel          := SPACE(20)
//Local cOcorrencia   
Local cDescricao	:= SPACE(50)
Local cSolucao		:= SPACE(50)
Local cDP           := SPACE(50)
Local dDataEnt 		:= Date()
Local dDataSai		:= Date()
Local cHoraEnt		:= SubStr(Time(), 1, 5)
Local cHoraSai 		:= SubStr(Time(), 1, 5)
Local cEmail        := SPACE(40)
Local cObs          := SPACE(40)

Local dEnc	:= Date()				
Local cEnc 	:= SubStr(Time(), 1, 5) 

Local lResp		:= .F.

Static oDlgOS
Static oButton1
Static oComboBox1
Static nComboBox1 := 1
Static oComboBox2
Static nComboBox2 := 1
Static oComboBox3
Static nComboBox3 := 1

Static oFont1 := TFont():New("Arial",,022,,.T.,,,,,.F.,.T.)

Static oGet1
Static oGet10
Static oGet11
Static oGet12
Static oGet13
Static oGet14
Static oGet15
Static oGet16
Static oGet2
Static oGet3
Static oGet4
Static oGet5
Static oGet6
Static oGet7
Static oGet8
Static oGet9
Static oGroup1
Static oGroup2
Static oGroup3
Static oGroup4
Static oGroup5
Static oGroup6
Static oMultiGet1
Static oMultiGet2
Static oMultiGet3
Static oSay1
Static oSay10
Static oSay11
Static oSay12
Static oSay13
Static oSay14
Static oSay15
Static oSay16
Static oSay17
Static oSay18
Static oSay19
Static oSay2
Static oSay20
Static oSay21
Static oSay22
Static oSay23
Static oSay24
Static oSay3
Static oSay4
Static oSay5
Static oSay6
Static oSay7
Static oSay8
Static oSay9  

Local cCombAR := "           " 
Local aCombAR := {"          ","1=Hardware","2=Software","3=Rede","4=Impressora","5=Tel (Voip)","6=Remanejamento",;
					"7=TOTVS","8=Vistoria","9=Aloha","10=No-Break","11=CFTV","12=TI ADM","13=Outros"} 

//Departamento
Local cCombDP := "           "
Local aCombDP := {"          ","1=Financeiro","2=RH","3=Fiscal","4=Contabil","5=TI","6=Planejamento",;
					"7=Diretoria","8=Chalet","14=Lojas","15=Outros"} 
					
//Prestacao de servico
Local cCombSE := "           "
Local aCombSE := {"         ","1=VTT","2=Aloha","3=G4","4=Micros","5=Bematech","6=Cielo",;
					"7=Otech","8=Novits","9=Linx","10=TopHelp","11=Outros"}

//Ocorrencia					
Local cCombOC := "              "					
Local aCombOC := {"             ","1=Manunteção","2=Preventiva","3=Service","4=Acompanhamento","13=Outros"}

//Numeração do Chamado....

cSeq	:= Getmv("MV_SCHAXMV")
    
 	nValor1 := Val(cSeq)
 	nValor2 := 1
 	nResult	:= nValor1 + nValor2
 	
 PutMV("MV_SCHAXMV",STRZERO(nResult,5))
 
 cNumero := "S" + STRZERO(nResult,5)


//Combos

//Area

  DEFINE MSDIALOG oDlgOS TITLE "Abertura de OS" FROM 000, 000  TO 445, 700 COLORS 0, 16777215 PIXEL
     
    @ 026, 003 GROUP oGroup1 TO 063, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
    @ 003, 002 GROUP oGroup2 TO 023, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
    @ 068, 002 GROUP oGroup3 TO 088, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
    @ 092, 002 GROUP oGroup4 TO 161, 345 OF oDlgOS COLOR 0, 16777215 PIXEL 
    @ 165, 002 GROUP oGroup5 TO 196, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
    @ 200, 002 GROUP oGroup6 TO 220, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
        
    @ 007, 135 SAY oSay1 PROMPT "Abertura de O.S." SIZE 070, 013 OF oDlgOS FONT oFont1 COLORS 0, 16777215 PIXEL
    
    @ 034, 054 SAY oSay2  PROMPT "Numero" SIZE 023, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 034, 005 SAY oSay3  PROMPT "Filial" SIZE 013, 007 OF oDlgOS COLORS 0, 16777215  PIXEL
	@ 034, 116 SAY oSay4  PROMPT "Data Abertura" SIZE 037, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
	@ 034, 205 SAY oSay5  PROMPT "Hora" SIZE 014, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
	@ 034, 255 SAY oSay6  PROMPT "Usuario" SIZE 021, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
	@ 075, 004 SAY oSay7  PROMPT "Gerente" SIZE 022, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
	@ 075, 082 SAY oSay8  PROMPT "Chamado 3º" SIZE 032, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
	@ 050, 005 SAY oSay9  PROMPT "Analista" SIZE 021, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
	@ 050, 083 SAY oSay10 PROMPT "Area" SIZE 015, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
	@ 050, 156 SAY oSay11 PROMPT "Codigo do Projeto" SIZE 045, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
	@ 050, 255 SAY oSay12 PROMPT "Departamento" SIZE 036, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
	@ 097, 004 SAY oSay13 PROMPT "Descrição" SIZE 025, 007 OF oDlgOS COLORS 0, 16777215 PIXEL // AQUI
	@ 097, 121 SAY oSay14 PROMPT "Solução" SIZE 025, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 097, 235 SAY oSay15 PROMPT "D.P" SIZE 013, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 172, 006 SAY oSay16 PROMPT "Data Entrada" SIZE 035, 007 OF oDlgOS COLORS 0, 16777215 PIXEL   	
	@ 172, 077 SAY oSay17 PROMPT "Data Saida" SIZE 030, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 185, 006 SAY oSay18 PROMPT "Hora Entrada" SIZE 033, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 184, 077 SAY oSay19 PROMPT "Hora Saida" SIZE 028, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 172, 144 SAY oSay20 PROMPT "E-Mail" SIZE 018, 007 OF oDlgOS COLORS 0, 16777215 PIXEL       
    @ 075, 157 SAY oSay21 PROMPT "Tel" SIZE 011, 007 OF oDlgOS COLORS 0, 16777215 PIXEL    
    @ 184, 145 SAY oSay22 PROMPT "Obs" SIZE 016, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 075, 211 SAY oSay23 PROMPT "Ocorrencia" SIZE 029, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 049, 270 SAY oSay24 PROMPT "Prest serv" SIZE 025, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    
    @ 032, 019 MSGET oGet2 VAR cXFilial SIZE 034, 010 OF oDlgOS PICTURE "@E 99" COLORS 0, 16777215 F3 "SM0" PIXEL
    @ 032, 078 MSGET oGet1 VAR cNumero SIZE 034, 010 OF oDlgOS COLORS 0, 16777215 PIXEL
 	@ 032, 153 MSGET oGet3 VAR dDataAber SIZE 050, 010 OF oDlgOS COLORS 0, 16777215 PIXEL  
    @ 032, 221 MSGET oGet4 VAR cHora SIZE 032, 010 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 032, 277 MSGET oGet5 VAR cUsuario SIZE 063, 010 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 048, 098 COMBOBOX  oComboBox1 VAR cCombAR ITEMS aCombAR SIZE 057, 010 OF oDlgOS COLORS 0, 16777215 PIXEL 
    @ 048, 292 COMBOBOX oComboBox2 VAR cCombDP ITEMS aCombDP  SIZE 047, 010 OF oDlgOS COLORS 0, 16777215 PIXEL    
    @ 073, 026 MSGET oGet6 VAR cGerente SIZE 053, 010 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 073, 114 MSGET oGet7 VAR cChamado3 SIZE 040, 010 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 073, 168 MSGET oGet16 VAR cTel SIZE 040, 010 OF oDlgOS PICTURE "@E (99)9999-9999" COLORS 0, 16777215 PIXEL
    @ 073, 240 COMBOBOX oComboBox3 VAR cCombOC ITEMS aCombOC  SIZE 054, 010 OF oDlgOS  COLORS 0, 16777215 PIXEL 
    @ 049, 255 COMBOBOX oComboBox4  VAR cCombSE ITEMS aCombSE SIZE 054, 010 OF oDlgOS COLORS 0, 16777215 PIXEL 
    
    @ 097, 031 GET oMultiGet1 VAR cDescricao OF oDlgOS VALID !Empty(cDescricao) MULTILINE SIZE 088, 058 COLORS 0, 16777215 HSCROLL NO VSCROLL PIXEL 
    @ 097, 145 GET oMultiGet2 VAR cSolucao OF oDlgOS VALID !Empty(cSolucao) MULTILINE SIZE 088, 058 COLORS 0, 16777215 HSCROLL NO VSCROLL PIXEL
    @ 097, 250 GET oMultiGet3 VAR cDP OF oDlgOS VALID !Empty(cDP) MULTILINE SIZE 088, 058 COLORS 0, 16777215 HSCROLL NO VSCROLL PIXEL
    @ 170, 040 MSGET oGet11 VAR dDataEnt SIZE 034, 010 OF oDlgOS COLORS 0, 16777215 PIXEL    
    @ 170, 107 MSGET oGet12 VAR dDataSai SIZE 034, 010 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 183, 040 MSGET oGet13 VAR cHoraEnt SIZE 035, 010 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 183, 107 MSGET oGet14 VAR cHoraSai SIZE 035, 010 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 170, 162 MSGET oGet15 VAR cEmail SIZE 141, 010 OF oDlgOS COLORS 0, 16777215 PIXEL    
    @ 183, 162 MSGET oGet10 VAR cObs SIZE 141, 010 OF oDlgOS COLORS 0, 16777215 PIXEL       
    @ 048, 026 MSGET oGet8 VAR cAnalista SIZE 053, 010 OF oDlgOS COLORS 0, 16777215 PIXEL      
    @ 048, 202 MSGET oGet9 VAR cCodProj SIZE 051, 010 OF oDlgOS COLORS 0, 16777215 PIXEL
    
    @ 205, 260 BUTTON oButton1 PROMPT "&Confirmar" SIZE 037, 012 OF ACTION {|| lResp := .T., oDlgOS:End()} PIXEL
    @ 205, 304 BUTTON oButton1 PROMPT "&Sair" SIZE 037, 012 OF oDlgOS ACTION {|| oDlgOS:End()} PIXEL
    
  ACTIVATE MSDIALOG oDlgOS CENTERED

If lResp
   
	RecLock("ZX1", .T.)
			
		ZX1->ZX1_FILIAL  := cXFilial	 
		ZX1->ZX1_NUM 	:= cNumero 	
		ZX1->ZX1_DTSOLIC := dDataAber
		ZX1->ZX1_HRSOLIC := cHora 
		ZX1->ZX1_USUARIO := cUsuario 
	   	ZX1->ZX1_ANALIST := cAnalista
		ZX1->ZX1_TIPO 	:= cCombAR 
		ZX1->ZX1_CODPROJ := cCodProj
		ZX1->ZX1_DEP     := cCombDP
		ZX1->ZX1_NOMGER  := cGerente
		ZX1->ZX1_CHA3    := cChamado3 
		ZX1->ZX1_TEL	    := cTel
		ZX1->ZX1_OCORRE  := cCombOC
		ZX1->ZX1_PREST   := cCombSE   
		ZX1->ZX1_DESCRI1	:= cDescricao
		ZX1->ZX1_SOLU    := cSolucao
		ZX1->ZX1_DP      := cDP  
		ZX1->ZX1_DTENT	:= dDataEnt
		ZX1->ZX1_DTSAI	:= dDataSai
		ZX1->ZX1_HENT	:= cHoraEnt
		ZX1->ZX1_HSAI	:= cHoraSai
		ZX1->ZX1_EMAIL	:= cEmail
		ZX1->ZX1_OBS		:= cObs		
		ZX1->ZX1_DTENC 	:= dEnc 
		ZX1->ZX1_HRENC 	:= cEnc 	
		ZX1->ZX1_STATUS  := "5"
		
	MsUnlock() 
	
Endif


Return

/*/
//+-----------------------------------------------------------------------------------------------------+
//| Rotina | SCHAX7     | Autor | Douglas Rodrigues da Silva  | Data | 07.03.11							|
//+-----------------------------------------------------------------------------------------------------+
//| Descr. | Gerenciamento e Abertura				    		    									|
//+-----------------------------------------------------------------------------------------------------+
//| Uso 	| Esta rotina tem como função Visualização							                      	|
//+-----------------------------------------------------------------------------------------------------+
/*/          

User Function SCHAX07() 

Local cXFilial		:= ZX1->ZX1_FILIAL 
Local cNumero       := ZX1->ZX1_NUM 
Local dDataAber		:= ZX1->ZX1_DTSOLIC
Local cHora			:= ZX1->ZX1_HRSOLIC 
Local cUsuario      := ZX1->ZX1_USUARIO 
Local cAnalista    	:= ZX1->ZX1_ANALIST
Local cArea         := ZX1->ZX1_TIPO 
Local cCodProj      := ZX1->ZX1_CODPROJ
Local cDepartamento := ZX1->ZX1_DEP
Local cGerente 		:= ZX1->ZX1_NOMGER
Local cChamado3 	:= ZX1->ZX1_CHA3
Local cTel          := ZX1->ZX1_TEL
Local cOcorrencia   := ZX1->ZX1_OCORRE
Local cPrest        := ZX1->ZX1_PREST 
Local cDescricao	:= ZX1->ZX1_DESCRI1	
Local cSolucao		:= ZX1->ZX1_SOLU
Local cDP           := ZX1->ZX1_DP
Local dDataEnt 		:= ZX1->ZX1_DTENT
Local dDataSai		:= ZX1->ZX1_DTSAI
Local cHoraEnt		:= ZX1->ZX1_HENT
Local cHoraSai 		:= ZX1->ZX1_HSAI
Local cEmail        := ZX1->ZX1_EMAIL
Local cObs          := ZX1->ZX1_OBS

Local lResp		:= .F.

Static oDlgOS
Static oButton1
Static oComboBox1
Static nComboBox1 := 1
Static oComboBox2
Static nComboBox2 := 1
Static oComboBox3
Static nComboBox3 := 1

Static oFont1 := TFont():New("Arial",,022,,.T.,,,,,.F.,.T.)

Static oGet1
Static oGet10
Static oGet11
Static oGet12
Static oGet13
Static oGet14
Static oGet15
Static oGet16
Static oGet2
Static oGet3
Static oGet4
Static oGet5
Static oGet6
Static oGet7
Static oGet8
Static oGet9
Static oGroup1
Static oGroup2
Static oGroup3
Static oGroup4
Static oGroup5
Static oGroup6
Static oMultiGet1
Static oMultiGet2
Static oMultiGet3
Static oSay1
Static oSay10
Static oSay11
Static oSay12
Static oSay13
Static oSay14
Static oSay15
Static oSay16
Static oSay17
Static oSay18
Static oSay19
Static oSay2
Static oSay20
Static oSay21
Static oSay22
Static oSay23
Static oSay24
Static oSay3
Static oSay4
Static oSay5
Static oSay6
Static oSay7
Static oSay8
Static oSay9  

//Combos

//Area
Local cCombAR := ZX1->ZX1_TIPO 
Local aCombAR := {"1=Hardware","2=Software","3=Rede","4=Impressora","5=Tel (Voip)","6=Remanejamento",;
					"7=TOTVS","8=Vistoria","9=Aloha","10=No-Break","11=CFTV","12=TI ADM","13=Outros"} 

//Departamento
Local cCombDP := "5=TI"
Local aCombDP := {"1=Financeiro","2=RH","3=Fiscal","4=Contabil","5=TI","6=Planejamento",;
					"7=Diretoria","8=Chalet","13=Outros"}
					
//Prestacao de servico
Local cCombSE := "           "
Local aCombSE := {"         ","1=VTT","2=Aloha","3=G4","4=Micros","5=Bematech","6=Cielo",;
					"7=Otech","8=Novits","9=Linx","10=TopHelp","11=Outros"}

//Ocorrencia					
Local cCombOC := "2=Manunteção"					
Local aCombOC := {"1=Preventiva","2=Manunteção","3=Service","4=Acompanhamento","13=Outros"}


  DEFINE MSDIALOG oDlgOS TITLE "Visualização" FROM 000, 000  TO 445, 700 COLORS 0, 16777215 PIXEL

    @ 026, 003 GROUP oGroup1 TO 063, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
    @ 034, 054 SAY oSay2 PROMPT "Numero" SIZE 023, 007 OF oDlgOS COLORS 0, 16777215  PIXEL
    @ 032, 078 MSGET oGet1 VAR cNumero SIZE 034, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 034, 005 SAY oSay3 PROMPT "Filial" SIZE 013, 007 OF oDlgOS COLORS 0, 16777215  PIXEL
    @ 032, 019 MSGET oGet2 VAR cXFilial SIZE 034, 010 OF oDlgOS PICTURE "@E 99" COLORS 0, 16777215 READONLY PIXEL
    @ 003, 002 GROUP oGroup2 TO 023, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
    @ 007, 135 SAY oSay1 PROMPT "Visualização" SIZE 063, 013 OF oDlgOS FONT oFont1 COLORS 0, 16777215 PIXEL
    @ 034, 116 SAY oSay4 PROMPT "Data Abertura" SIZE 037, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 032, 153 MSGET oGet3 VAR dDataAber SIZE 050, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 034, 205 SAY oSay5 PROMPT "Hora" SIZE 014, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 032, 221 MSGET oGet4 VAR cHora SIZE 032, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 034, 255 SAY oSay6 PROMPT "Usuario" SIZE 021, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 032, 277 MSGET oGet5 VAR cUsuario SIZE 063, 010 OF oDlgOS COLORS 0, 16777215  READONLY PIXEL
    @ 068, 002 GROUP oGroup3 TO 088, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
    @ 075, 004 SAY oSay7 PROMPT "Gerente" SIZE 022, 007 OF oDlgOS COLORS 0, 16777215  PIXEL
    @ 073, 026 MSGET oGet6 VAR cGerente SIZE 053, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 075, 082 SAY oSay8 PROMPT "Chamado 3º" SIZE 032, 007 OF oDlgOS COLORS 0, 16777215  PIXEL
    @ 073, 114 MSGET oGet7 VAR cChamado3 SIZE 040, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 050, 005 SAY oSay9 PROMPT "Analista" SIZE 021, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 048, 026 MSGET oGet8 VAR cAnalista SIZE 053, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 050, 083 SAY oSay10 PROMPT "Area" SIZE 015, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 048, 098 COMBOBOX  oComboBox1 VAR cCombAR ITEMS aCombAR SIZE 057, 010 OF oDlgOS COLORS 0, 16777215  PIXEL
    @ 050, 156 SAY oSay11 PROMPT "Codigo do Projeto" SIZE 045, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 048, 202 MSGET oGet9 VAR cCodProj SIZE 051, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 050, 255 SAY oSay12 PROMPT "Departamento" SIZE 036, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 092, 002 GROUP oGroup4 TO 161, 345 OF oDlgOS COLOR 0, 16777215  PIXEL
    
    @ 097, 004 SAY oSay13 PROMPT "Descrição" SIZE 025, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 097, 031 GET oMultiGet1 VAR cDescricao OF oDlgOS MULTILINE SIZE 088, 058 COLORS 0, 16777215 READONLY HSCROLL PIXEL
    
    @ 097, 121 SAY oSay14 PROMPT "Solução" SIZE 025, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 097, 145 GET oMultiGet2 VAR cSolucao OF oDlgOS MULTILINE SIZE 088, 058 COLORS 0, 16777215 READONLY HSCROLL PIXEL
    
    @ 097, 250 GET oMultiGet3 VAR cDP OF oDlgOS MULTILINE SIZE 088, 058 COLORS 0, 16777215 READONLY HSCROLL PIXEL
    @ 097, 235 SAY oSay15 PROMPT "D.P" SIZE 013, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 165, 002 GROUP oGroup5 TO 196, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
    @ 172, 006 SAY oSay16 PROMPT "Data Entrada" SIZE 035, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 170, 040 MSGET oGet11 VAR dDataEnt SIZE 034, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 172, 077 SAY oSay17 PROMPT "Data Saida" SIZE 030, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 170, 107 MSGET oGet12 VAR dDataSai SIZE 034, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 185, 006 SAY oSay18 PROMPT "Hora Entrada" SIZE 033, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 183, 040 MSGET oGet13 VAR cHoraEnt SIZE 035, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 184, 077 SAY oSay19 PROMPT "Hora Saida" SIZE 028, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 183, 107 MSGET oGet14 VAR cHoraSai SIZE 035, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 172, 144 SAY oSay20 PROMPT "E-Mail" SIZE 018, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 170, 162 MSGET oGet15 VAR cEmail SIZE 141, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 075, 157 SAY oSay21 PROMPT "Tel" SIZE 011, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 073, 168 MSGET oGet16 VAR cTel SIZE 040, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 200, 002 GROUP oGroup6 TO 220, 346 OF oDlgOS COLOR 0, 16777215 PIXEL
    @ 048, 292 COMBOBOX oComboBox2 VAR cCombDP ITEMS aCombDP  SIZE 047, 010 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 184, 145 SAY oSay22 PROMPT "Obs" SIZE 016, 007 OF oDlgOS COLORS 0, 16777215  PIXEL
    @ 183, 162 MSGET oGet10 VAR cObs SIZE 141, 010 OF oDlgOS COLORS 0, 16777215 READONLY PIXEL
    @ 075, 211 SAY oSay23 PROMPT "Ocorrencia" SIZE 029, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 049, 270 SAY oSay24 PROMPT "Prest serv" SIZE 025, 007 OF oDlgOS COLORS 0, 16777215 PIXEL
    @ 073, 240 COMBOBOX oComboBox3 VAR cCombOC ITEMS aCombOC  SIZE 054, 010 OF oDlgOS COLORS 0, 16777215  PIXEL  
    @ 049, 255 COMBOBOX oComboBox4  VAR cCombSE ITEMS aCombSE SIZE 054, 010 OF oDlgOS COLORS 0, 16777215 PIXEL 
    @ 205, 304 BUTTON oButton1 PROMPT "&Sair" SIZE 037, 012 OF oDlgOS ACTION {|| oDlgOS:End()} PIXEL
  ACTIVATE MSDIALOG oDlgOS CENTERED

Return

