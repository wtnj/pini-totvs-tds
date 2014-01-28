#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
/*/     20031010
//Danilo C S Pala 20060327: dados de enderecamento do DNE
//Danilo C S Pala 20060602: Carta de NFE
//Danilo C S Pala 20100305: ENDBP
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³    CARTA ³ Autor ³  Danilo C S Pala      ³ Data ³ 20031007 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao de carta de correcao                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico para clientes Microsiga                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Release  ³ 															  ³±±
±±³          ³ 															  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfis001()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

SetPrvt("CBTXT,CDESC1,CDESC2,CDESC3,CSTRING,IMPRIME")
SetPrvt("CPICT,AORD,CTEXTO,J,TAMANHO,LIMITE")
SetPrvt("NOMEPROG,MV_TABPR,NTIPO,NLASTKEY,AIND,TITULO")
SetPrvt("NLIN,LI,CPERG,NPAG,LCONTINUA,I")
SetPrvt("ACOL1,ACOL2,ACOL3,AMESES,NDIA,NANO")
SetPrvt("CMES,CBCONT,CONTFL,M_PAG,ARETURN,WNREL")
SetPrvt("ADRIVER,AMARCA1,AMARCA2,AMARCA3,ACOD,NPERG")
SetPrvt("CAUX,XCOD,CAUX1,CAUX2,CAUX3,XDESC")
SetPrvt("CCOD,CNOME,CEND,CBAIRRO,CMUN,CCEP")
SetPrvt("CEST,NQTDVIAS,NVIA")            
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis do oPrn ==>Danilo                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetPrvt("nText1_LI ,nText2_LI ,nText3_LI ,nText4_LI ,nText5_LI , nText6_LI")
SetPrvt("nText7_LI, nText8_LI, nText9_LI, nText1_CI, nText2_CI, nText0_LI")
SetPrvt("nBox0_LI ,nBox0_LF ,nBox0_CI ,nBox0_CF")
SetPrvt("nBox1_LI ,nBox1_LF ,nBox1_CI ,nBox1_CF ,nBox1_LF2, nBox1_CF2, nBox1_CM")
SetPrvt("nBox2_CI ,nBox2_CF ,nBox2_CF2, nBox2_CM")
SetPrvt("nBox3_CI , nBox3_CF, nBox3_CF2 ,nBox3_CM")
SetPrvt("nBox4_LI, nBox4_LF ,nBox4_CI ,nBox4_CF ,nBox4_LF2 ,nBox4_CF2")
SetPrvt("nText10_LI ,nText11_CI, nText40_LI, nText40_CI ,nText41_LI ,nText42_CI")
SetPrvt("nText12_LI, nBox5_LI ,nBox5_LF ,nBox5_CI ,nBox5_CF ,nBox5_LF2 ,nBox5_LF3")
SetPrvt("nAuxLinha, nText3CEP_LI, nLinha, nCont")
SetPrvt("nTextA_LI , nTextA_CI ,nTextA_CM ,nTextAA_LI ,nTextB_CI, nTextB_CM")
SetPrvt(" nTextC_CI, nTextC_CM, nTextA_CF, nTextB_CF, nTextC_CF")


//dialog                
Private cDaNota := space(6)
Private cAteNota := space(6)
Private cSerie := space(3)  
Private cTipo := space(7)
Private nVias := 1
Private cFornec := space(6)
Private cLoja := space(2)
Private aItens := {"Saida","Entrada"}    

Private cCodigo1 := space(2)
Private cMsg1_1 := space(40)
Private cMsg2_1 := space(40)
Private cMsg3_1 := space(40)
Private cCodigo2 := space(2)
Private cMsg1_2 := space(40)
Private cMsg2_2 := space(40)
Private cMsg3_2 := space(40)
Private cCodigo3 := space(2)
Private cMsg1_3 := space(40)
Private cMsg2_3 := space(40)
Private cMsg3_3 := space(40)
Private cCodigo4 := space(2)
Private cMsg1_4 := space(40)
Private cMsg2_4 := space(40)
Private cMsg3_4 := space(40)
Private cCodigo5 := space(2)
Private cMsg1_5 := space(40)
Private cMsg2_5 := space(40)
Private cMsg3_5 := space(40)
Private cCodigo6 := space(2)
Private cMsg1_6 := space(40)
Private cMsg2_6 := space(40)
Private cMsg3_6 := space(40)
Private cCodigo7 := space(2)
Private cMsg1_7 := space(40)
Private cMsg2_7 := space(40)
Private cMsg3_7 := space(40)
Private cCodigo8 := space(2)
Private cMsg1_8 := space(40)
Private cMsg2_8 := space(40)
Private cMsg3_8 := space(40)
Private cCodigo9 := space(2)
Private cMsg1_9 := space(40)
Private cMsg2_9 := space(40)
Private cMsg3_9 := space(40)
Private cCodigo10 := space(2)
Private cMsg1_10 := space(40)
Private cMsg2_10 := space(40)
Private cMsg3_10 := space(40)

//Pergunte("CARTA",.T.)
CbTxt        := ""
cDesc1       := "Este programa tem como objetivo imprimir a carta de corre‡„o"
cDesc2       := "da "+AllTrim(SM0->M0_NOMECOM)
cDesc3       := ""
cString      := "SF2"
imprime      := .T.
cPict        := ""
aOrd         := {}
cTexto       := ""
j            := 0
tamanho      := "P"
limite       := 80
nomeprog     := "CARTA"
mv_tabpr     := ""
nTipo        := 15
nLastKey     := 0
aInd         := {}
titulo       := "Emiss„o de carta de corre‡„o"
nlin         := 0
li           := 0
cPerg        := "CARTA"
nPag         := 1
lContinua    := .T.
i            := 1
aCol1        := {"Razao Social","Endereco/Faturamento","Municipio","Estado","No. Insc. CNPJ/CPF",;
"No. Insc. Est.","Natureza de Operacao","Codigo Fiscal Operacao","Via de Transporte",;
"Data de Emissao","Data de Saida","Unidade (produto)"}
aCol2        := {"Quant. (produto)","Descr. dos Prod./Servicos","Preco Unitario","Valor do Produto",;
"Class. Fiscal","Aliquota do IPI","Valor do IPI","Base de Calc. IPI","Valor Total Nota",;
"Aliquota do ICMS","Valor do ICMS","Base de Calc. ICMS"}
aCol3        := {"Nome Transportador","End. Transportador","Termo Isencao IPI","Termo Isencao ICMS",;
"Peso-Bruto/Liquid.","Vol-Marcas/Nun/Quant.","Rasuras","Codigo do(s) Produto(s)","Condicoes de Pagamentos",;
"Endereco de Cobranca","Data de Vencto da Parcela A","Outras Especif."}
aMeses       := {"Janeiro","Fevereiro","Marco","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"}
nDia         := Day(dDataBase)
nAno         := Year(dDataBase)
cMes         := aMeses[Month(dDataBase)]
cbtxt        := Space(10)
cbcont       := 00
CONTFL       := 01
m_pag        := 1
imprime      := .T.
/*
aReturn      := { "Zebrado", 1,"Administra‡„o", 1, 2, 1, "",1}
wnrel        := "CARTA"
//wnrel        := SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.)

If nLastKey == 27
Return
Endif

//SetDefault(aReturn,cString)

If nLastKey == 27
Return
Endif

Pergunte(cPerg,.f.)

//aDriver      := ReadDriver()

lEnd         := .f.
*/  
/*
IF mv_par04 == 1
	Processa({|lEnd| CartaSai(@lEnd)})// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> 	   RptStatus({|| Execute(CartaSai)})
Else
	Processa({|lEnd| CartaEnt(@lEnd)})// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> 	   RptStatus({|| Execute(CartaEnt)})
Endif
  */                                        


@ 000,000 TO 660,720 DIALOG oDlg TITLE "Carta de Correcao"       
@ 001,005 TO 050,330
@ 005,010 SAY "Da nota:"
@ 005,070 GET cDaNota  Picture "@R 999999" 
@ 015,010 SAY "Ate a nota:"
@ 015,070 GET cAteNota  Picture "@R 999999"
@ 025,010 SAY "Da serie:"
@ 025,070 GET cserie  Picture "@!"
@ 035,010 SAY "Tipo da nota:"
@ 035,070 COMBOBOX cTipo ITEMS aItens SIZE 90,90

@ 015,200 SAY "Numero de vias:"
@ 015,250 GET nVias  Picture "@R 9"
@ 025,200 SAY "Fornecedor NF Ent."
@ 025,250 GET cFornec  Picture "@R 99" 
@ 035,200 SAY "Loja NF Ent."
@ 035,250 GET cLoja  Picture "@R 99"
                    
@ 055,005 TO 305,330
// item 1
@ 060,010 SAY "1 Codigo"
@ 060,070 GET cCodigo1  Picture "@R 99" F3 "Z1"
@ 070,010 SAY "Mensagem irregular"
@ 070,070 GET cMsg1_1  Picture "@!" 
@ 080,070 GET cMsg2_1  Picture "@!"
@ 090,070 GET cMsg3_1  Picture "@!"
// item 2
@ 110,010 SAY "2 Codigo"
@ 110,070 GET cCodigo2  Picture "@R 99" F3 "Z1"
@ 120,010 SAY "Mensagem irregular"
@ 120,070 GET cMsg1_2  Picture "@!" 
@ 130,070 GET cMsg2_2  Picture "@!"
@ 140,070 GET cMsg3_3  Picture "@!"
// item 3
@ 160,010 SAY "3 Codigo"
@ 160,070 GET cCodigo3  Picture "@R 99" F3 "Z1"
@ 170,010 SAY "Mensagem irregular"
@ 170,070 GET cMsg1_3  Picture "@!" 
@ 180,070 GET cMsg2_3  Picture "@!"
@ 190,070 GET cMsg3_3  Picture "@!"
// item 4
@ 210,010 SAY "4 Codigo"
@ 210,070 GET cCodigo4  Picture "@R 99" F3 "Z1"
@ 220,010 SAY "Mensagem irregular"
@ 220,070 GET cMsg1_4  Picture "@!" 
@ 230,070 GET cMsg2_4  Picture "@!"
@ 240,070 GET cMsg3_4  Picture "@!"
// item 5
@ 260,010 SAY "5 Codigo"
@ 260,070 GET cCodigo5  Picture "@R 99" F3 "Z1"
@ 270,010 SAY "Mensagem irregular"
@ 270,070 GET cMsg1_5  Picture "@!" 
@ 280,070 GET cMsg2_5  Picture "@!"
@ 290,070 GET cMsg3_5  Picture "@!"
// item 6
@ 060,200 SAY "6 Codigo"
@ 060,250 GET cCodigo6  Picture "@R 99" F3 "Z1"
@ 070,200 SAY "Mensagem irregular"
@ 070,250 GET cMsg1_6  Picture "@!" 
@ 080,250 GET cMsg2_6  Picture "@!"
@ 090,250 GET cMsg3_6  Picture "@!"
// item 7           
@ 110,200 SAY "7 Codigo"
@ 110,250 GET cCodigo7  Picture "@R 99" F3 "Z1"
@ 120,200 SAY "Mensagem irregular"
@ 120,250 GET cMsg1_7  Picture "@!" 
@ 130,250 GET cMsg2_7  Picture "@!"
@ 140,250 GET cMsg3_7  Picture "@!"
// item 8
@ 160,200 SAY "8 Codigo"
@ 160,250 GET cCodigo8  Picture "@R 99" F3 "Z1"
@ 170,200 SAY "Mensagem irregular"
@ 170,250 GET cMsg1_8  Picture "@!" 
@ 180,250 GET cMsg2_8  Picture "@!"
@ 190,250 GET cMsg3_8  Picture "@!"
// item 9
@ 210,200 SAY "9 Codigo"
@ 210,250 GET cCodigo9  Picture "@R 99" F3 "Z1"
@ 220,200 SAY "Mensagem irregular"
@ 220,250 GET cMsg1_9  Picture "@!" 
@ 230,250 GET cMsg2_9  Picture "@!"
@ 240,250 GET cMsg3_9  Picture "@!"
// item 10
@ 260,200 SAY "10 Codigo"
@ 260,250 GET cCodigo10  Picture "@R 99" F3 "Z1"
@ 270,200 SAY "Mensagem irregular"
@ 270,250 GET cMsg1_10  Picture "@!" 
@ 280,250 GET cMsg2_10  Picture "@!"
@ 290,250 GET cMsg3_10  Picture "@!"

@ 310,230 BUTTON "Imprimir" SIZE 40,20 ACTION Processa({||ProcNF()})
@ 310,280 BUTTON "Sair" SIZE 40,20 Action ( Close(oDlg) )
Activate Dialog oDlg centered
Return
                                                                   

Static Function ProcNF()
if cTipo = "Saida"
	CartaSAI()
else
	CartaENT()
endif
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CARTASAI ³ Autor ³  Luiz Carlos Vieira   ³ Data ³ 07/07/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao de carta de correcao                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico para clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CartaSAI()
oFont1 	:= TFont():New( "Times New Roman",,8,,.T.,,,,,.F.)
oFont2 	:= TFont():New( "Tahoma",,16,,.T.,,,,,.F.)
oFont3	:= TFont():New( "Arial"       ,,20,,.F.,,,,,.F.)
oFont4 	:= TFont():New( "courier new",,12,,.T.,,,,,.F.)

oPrn := tAvPrinter():New("Carta de Correcao")

dbSelectArea("SF2")
dbSetOrder(1)
dbSeek(xFilial("SF2")+cDaNota,.T.)

ProcRegua(Val(cAteNota)-Val(cDaNota))

While !Eof() .And. xFilial("SF2")==SF2->F2_FILIAL .And. SF2->F2_DOC <= cAteNota
	
	IF SF2->F2_SERIE #cSerie
		dbSkip()
		Loop
	Endif
	
	IncProc("Nota: "+SF2->F2_SERIE+SF2->F2_DOC)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Prepara a impressao de acordo com as perguntas...            ³
	//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
	//³ Monta o array com as marcas nos codigos selecionados atraves ³
	//³ das perguntas. Um array para cada coluna. Cada coluna com 12 ³
	//³ codigos no maximo.                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aMarca1   := aFill(Array(12),".")
	aMarca2   := aFill(Array(12),".")
	aMarca3   := aFill(Array(12),".")
	
	aCod  := {}
	nCont := 1
	While nCont <= 10
		cAux  := "cCodigo"+Alltrim(Str(nCont))
		xCod  := &cAux
		xCod  := Val(xCod)
		cAux1 := "cMsg1_"+Alltrim(Str(nCont))
		cAux2 := "cMsg2_"+Alltrim(Str(nCont))
		cAux3 := "cMsg3_"+Alltrim(Str(nCont))
		xDesc := &cAux1 + &cAux2 + &cAux3
		If xCod >= 01 .And. xCod <= 12
			aMarca1[xCod]   := "X"
		Elseif xCod >= 13 .And. xCod <= 24
			aMarca2[xCod-12] := "X"
		Elseif xCod >= 25 .And. xCod <= 36
			aMarca3[xCod-24] := "X"
		Endif
		xCod := If(xCod==0,"99",STRZERO(xCod,2))
		aAdd(aCod,{xCod,xDesc})
		nCont++
	End
	
	If SF2->F2_TIPO $"DB"
		dbSelectArea("SA2")                   // Cadastro de Fornecedores
		dbSetOrder(1)
		dbSeek(xFilial()+SF2->F2_CLIENTE+SF2->F2_LOJA)
		cCod    := SA2->A2_COD + "/" + SA2->A2_LOJA
		cNome   := SA2->A2_NOME
		cEnd    := SA2->A2_END
		cBairro := SA2->A2_BAIRRO
		cMun    := SA2->A2_MUN
		cCep    := SA2->A2_CEP
		cEst    := SA2->A2_EST
		
	Else
		dbSelectArea("SA1")                // Cadastro de Clientes
		dbSetOrder(1)
		dbSeek(xFilial()+SF2->F2_CLIENTE+SF2->F2_LOJA)
		cCod    := SA1->A1_COD + "/" + SA1->A1_LOJA
		cNome   := SA1->A1_NOME
		cEnd    := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060327
		cBairro := SA1->A1_BAIRRO
		cMun    := SA1->A1_MUN
		cCep    := SA1->A1_CEP
		cEst    := SA1->A1_EST
		
		//20100305 DAQUI
		IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
			DbSelectArea("ZY3")
			DbSetOrder(1)
			if DbSeek(xFilial("ZY3")+SA1->A1_COD+SA1->A1_LOJA, .F. )
				cEnd    :=ZY3_END
				cBairro :=ZY3_BAIRRO
				cMun    :=ZY3_CIDADE
				cEst    :=ZY3_ESTADO
				cCep    :=ZY3_CEP
			endif
		ELSEIF SUBS(SA1->A1_ENDCOB,1,1)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
			dbSelectArea("SZ5")
			dbSetOrder(1)
			If dbSeek( xFilial("SZ5")+SA1->A1_COD+SA1->A1_LOJA, .F. )
				cEnd    := ALLTRIM(SZ5->Z5_TPLOG)+ " " + ALLTRIM(SZ5->Z5_LOGR) + " " + ALLTRIM(SZ5->Z5_NLOGR) + " " + ALLTRIM(SZ5->Z5_COMPL) //20060327
				cBairro := SZ5->Z5_BAIRRO
				cMun    := SZ5->Z5_CIDADE
				cCep    := SZ5->Z5_CEP
				cEst    := SZ5->Z5_ESTADO
			EndIf
		EndIf
		
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	if nVias > 0 .and. nVias <= 3
		nQtdVias := nVias
	else
		nQtdVias := 3
	endif
	For nVias := 1 To nQtdVias
		oPrn:StartPage()
		nLinha := 30
		nText1_LI := 20
		nText0_LI := nText1_LI + (nLinha *2)
		nText2_LI := nText0_LI + nLinha
		nText3_LI := nText2_LI + nLinha
		nText3CEP_LI := nText3_LI + nLinha
		nText4_LI := nText3_LI + (nLinha*2)
		nText5_LI := nText4_LI + (nLinha *2)
		nText6_LI := nText5_LI + nLinha
		nText7_LI := nText6_LI + nLinha
		nText8_LI := nText7_LI + (nLinha *5)
		nText9_LI := nText8_LI + nLinha
		
		nText1_CI := 20
		nText2_CI := 400
		
		oPrn:Say(nText1_LI, 20, (Alltrim(SM0->M0_CIDCOB)+", "+StrZero(nDia,2)+" de "+cMes+" de "+StrZero(nAno,4)),oFont1,100)
		oPrn:Say(nText1_LI, 1700, ("Carimbo Padronizado do CNPJ"),oFont1,100)
		oPrn:Say(nText0_LI, 20, ("A"),oFont1,100)
		
		//box0
		nBox0_LI := 50
		nBox0_LF := 450
		nBox0_CI := 1700
		nBox0_CF := 2300
		oPrn:Box (nBox0_LI,nBox0_CI,nBox0_LF,nBox0_CF)
		
		oPrn:Say(nText2_LI, nText1_CI, (cNOME + " - " +  cCod),oFont1,100) 
		oPrn:Say(nText3_LI, nText1_CI, (AllTrim(cEND)),oFont1,100) 
		oPrn:Say(nText3CEP_LI, nText1_CI, (If(!Empty(cBAIRRO),"  -  "+cBAIRRO,"")+" - CEP: "+cCEP +" - "+AllTrim(cMUN)+" - "+cEST),oFont1,100) 
		oPrn:Say(nText4_LI, nText1_CI, "Prezado(s) Senhor(es)",oFont1,100)
		oPrn:Say(nText5_LI, nText2_CI, "Ref.: CONFERENCIA DE DOCUMENTO FISCAL E COMUNICACAO DE INCORRECOES.",oFont1,100)
		oPrn:Say(nText6_LI, nText2_CI, "[ ] S/ Nota Fiscal No.        de" ,oFont1,100)
		oPrn:Say(nText7_LI, nText2_CI, ("[X] N/ Nota Fiscal No."+SF2->F2_DOC+" de "+DTOC(SF2->F2_EMISSAO)),oFont1,100)
		oPrn:Say(nText8_LI, nText1_CI+30,("Em face do que determina a legislacao fiscal vigente, vimos pela presente comunicar-lhe que a Nota Fiscal em referencia contem a(s) irregularidade(s) que abaixo apontamos, ") ,oFont1,100)
		oPrn:Say(nText9_LI, nText1_CI, ("cuja correcao solicitamos seja providenciada imediatamente."),oFont1,100)
		
		//box1
		nBox1_LI := 570
		nBox1_LF := 620
		nBox1_CI := 40
		nBox1_CF := 170
		nBox1_LF2 := 1000
		nBox1_CF2 := 700
		nBox1_CM := (nBox1_CI + nBox1_CF)/2
		oPrn:Box(nBox1_LI,nBox1_CI,nBox1_LF,nBox1_CF)//box1_1
		oPrn:Box(nBox1_LI,nBox1_CF,nBox1_LF,nBox1_CF2) //box1_2
		oPrn:Box(nBox1_LF,nBox1_CI,nBox1_LF2,nBox1_CM)//box1_3
		oPrn:Box(nBox1_LF,nBox1_CM,nBox1_LF2,nBox1_CF)//box1_4
		oPrn:Box(nBox1_LF,nBox1_CF,nBox1_LF2,nBox1_CF2)//box1_5
		
		//BOX2
		nBox2_CI := 790
		nBox2_CF := 920
		nBox2_CF2 := 1450
		nBox2_CM := (nBox2_CI + nBox2_CF)/2
		oPrn:Box(nBox1_LI, nBox2_CI, nBox1_LF, nBox2_CF)//box2_1
		oPrn:Box(nBox1_LI, nBox2_CF, nBox1_LF, nBox2_CF2)//box2_1
		oPrn:Box(nBox1_LF, nBox2_CI, nBox1_LF2, nBox2_CM)//box2_3             690+650=1340
		oPrn:Box(nBox1_LF, nBox2_CM, nBox1_LF2, nBox2_CF)//box2_4
		oPrn:Box(nBox1_LF, nBox2_CF, nBox1_LF2, nBox2_CF2)//box2_5
		
		//BOX3
		nBox3_CI := 1540
		nBox3_CF := 1670
		nBox3_CF2 := 2200
		nBox3_CM := (nBox3_CI + nBox3_CF)/2
		oPrn:Box(nBox1_LI, nBox3_CI, nBox1_LF, nBox3_CF)//box3_1
		oPrn:Box(nBox1_LI, nBox3_CF, nBox1_LF, nBox3_CF2)//box3_2
		oPrn:Box(nBox1_LF, nBox3_CI, nBox1_LF2, nBox3_CM)//box3_3
		oPrn:Box(nBox1_LF, nBox3_CM, nBox1_LF2, nBox3_CF)//box3_4
		oPrn:Box(nBox1_LF, nBox3_CF, nBox1_LF2, nBox3_CF2)//box3_5
		
		nTextA_LI := nBox1_LI +10
		nTextA_CI := nBox1_CI + 10
		nTextA_CM := nBox1_CM + 10
		nTextA_CF := nBox1_CF+10
		nTextAA_LI := nBox1_LI + 30
		nTextB_CI := nBox2_CI + 10
		nTextB_CM := nBox2_CM + 10
		nTextB_CF := nBox2_CF+10
		nTextC_CI := nBox3_CI + 10
		nTextC_CM := nBox3_CM + 10
		nTextC_CF := nBox3_CF + 10
		
		oPrn:Say(nTextA_LI, nTextA_CI,"Codigo" ,oFont1,100)
		oPrn:Say(nTextA_LI, nTextB_CI,"Codigo" ,oFont1,100)
		oPrn:Say(nTextA_LI, nTextC_CI,"Codigo" ,oFont1,100)
		oPrn:Say(nTextA_LI, nTextA_CF,"Especificacao" ,oFont1,100)
		oPrn:Say(nTextA_LI, nTextB_CF,"Especificacao" ,oFont1,100)
		oPrn:Say(nTextA_LI, nTextC_CF,"Especificacao" ,oFont1,100)

		nAuxLinha := nTextAA_LI+ nlinha
		For nLin := 1 To 12
			//box1
			oPrn:Say(nAuxLinha, nTextA_CI, (aMarca1[nLin]) ,oFont1,100)
			oPrn:Say(nAuxLinha, nTextA_CM, (StrZero(nLin,2)) ,oFont1,100)
			oPrn:Say(nAuxLinha, nTextA_CF, (aCol1[nLin]) ,oFont1,100)
			//box2
			oPrn:Say(nAuxLinha, nTextB_CI, (aMarca2[nLin]) ,oFont1,100)
			oPrn:Say(nAuxLinha, nTextB_CM, (StrZero(nLin+12,2)) ,oFont1,100)
			oPrn:Say(nAuxLinha, nTextB_CF, (aCol2[nLin]) ,oFont1,100)
			//box3
			oPrn:Say(nAuxLinha, nTextC_CI, (aMarca3[nLin]) ,oFont1,100)
			oPrn:Say(nAuxLinha, nTextC_CM, (StrZero(nLin+24,2)) ,oFont1,100)
			oPrn:Say(nAuxLinha, nTextC_CF, (aCol3[nLin]) ,oFont1,100)

			nAuxLinha += 30
		Next nLin
		
		//box4
		nBox4_LI := 1050
		nBox4_LF := 1150
		nBox4_CI := 40
		nBox4_CF := 260
		nBox4_LF2 := 1480
		nBox4_CF2 := 2300
		oPrn:Box(nBox4_LI, nBox4_CI, nBox4_LF, nBox4_CF)//box4_1
		oPrn:Box(nBox4_LI, nBox4_CF, nBox4_LF, nBox4_CF2)//box4_2
		oPrn:Box(nBox4_LF, nBox4_CI, nBox4_LF2, nBox4_CF)//box4_3
		oPrn:Box(nBox4_LF, nBox4_CF, nBox4_LF2, nBox4_CF2)//box4_4
		
		nText40_LI := nBox4_LI +10
		nText40_CI := nBox4_CI +10
		nText41_LI := nText40_LI +30
		nText42_CI := nBox4_CF +10
		oPrn:Say(nText40_LI, nText40_CI,"Codigos com" ,oFont1,100)
		oPrn:Say(nText41_LI, nText40_CI,"Irregularidades" ,oFont1,100)
		oPrn:Say(nText40_LI, nText42_CI,"Retificacoes a serem consideradas" ,oFont1,100)
		
		nAuxLinha := nText41_LI+70
		For nLin := 1 To 10       
			oPrn:Say(nAuxLinha, nText40_CI,  (If(aCod[nLin,1]!="99",aCod[nLin,1],"  ")) ,oFont1,100)
			oPrn:Say(nAuxLinha, nText42_CI, (aCod[nLin,2]) ,oFont1,100) 
			nAuxLinha += 30
		Next nLin
		
		
		nText10_LI := 1500
		nText11_CI := 1200
		oPrn:Say(nText10_LI, nText1_CI+30,"Para evitar-se sancao fiscal, solicitamos acusarem o recebimento desta, na copia que acompanha, devendo a via de V. S(as) ficar arquivada juntamente com a Nota Fiscal em questao." ,oFont1,100)
		oPrn:Say(nText10_LI+(nLinha*3), nText11_CI,"Sem outro motivo para o momento, subscrevemo-nos atenciosamente" ,oFont1,100)
		oPrn:Say(nText10_LI+(nLinha*6), nText11_CI,"_____________________________________________" ,oFont1,100)
		oPrn:Say(nText10_LI+(nLinha*7), nText11_CI, AllTrim(SM0->M0_NOMECOM) ,oFont1,100)
		If nVias == 1
			oPrn:Say(nText10_LI+(nLinha*10), nText11_CI,"1a. Via Cliente" ,oFont1,100)
		Elseif nVias == 2
			oPrn:Say(nText10_LI+(nLinha*10), nText11_CI,"2a. Via Cliente" ,oFont1,100)
		Elseif nVias == 3
			oPrn:Say(nText10_LI+(nLinha*10), nText11_CI,"3a. Via Fiscal" ,oFont1,100)
		Endif
		
		
		//box5
		nBox5_LI := 1600
		nBox5_LF := 1700
		nBox5_CI := 40
		nBox5_CF := 900
		nBox5_LF2 := 1850
		nBox5_LF3 := 1900
		oPrn:Box(nBox5_LI, nBox5_CI, nBox5_LF, nBox5_CF)//box5_1
		oPrn:Box(nBox5_LF, nBox5_CI, nBox5_LF2, nBox5_CF)//box5_2
		oPrn:Box(nBox5_LF2, nBox5_CI, nBox5_LF3, nBox5_CF)//box5_3
		
		oPrn:Say(nBox5_LI - nLinha, nBox5_CI +30 ,"Acusamos recebimento da "+STR(nVias,1)+".a via" ,oFont1,100)
		oPrn:Say(nBox5_LF + 10, nBox5_CI +30 ,"(local e data)" ,oFont1,100)
		oPrn:Say(nBox5_LF2 + 10, nBox5_CI +30 ,"(carimbo e assinatura)" ,oFont1,100)
		
		
		nText12_LI := 1950
		//oPrn:Box(1900, 20, 1902, 2300)//box6_1
		oPrn:Line(nText12_LI, 20, nText12_LI, 2300)
		oPrn:Say(nText12_LI+(nLinha), nText1_CI ,"EDITORA  PINI LTDA. Rua Anhaia 964 e Rua dos Italianos 967 - Bom Retiro - Sao Paulo - SP CEP: 01130-900" ,oFont1,100)
		oPrn:Say(nText12_LI+(nLinha*2), nText1_CI ,"PINI SISTEMAS LTDA. Rua Anhaia 964 Casa 1 - Bom Retiro - Sao Paulo - SP CEP: 01130-900" ,oFont1,100)
		oPrn:Say(nText12_LI+(nLinha*3), nText1_CI ,"BP S/A. Rua Anhaia 964 1o Andar - Bom Retiro - Sao Paulo - SP CEP: 01130-900" ,oFont1,100)
		
		oPrn:EndPage()
		
	Next nVias
	dbSelectArea("SF2")
	dbSkip()
End

//Imprime em tela p/ preview
oPrn:Preview()
oPrn:End()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CARTAENT ³ Autor ³  Luiz Carlos Vieira   ³ Data ³ 07/07/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Emissao de carta de correcao                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico para clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function CartaENT()
oFont1 	:= TFont():New( "Times New Roman",,8,,.T.,,,,,.F.)
oFont2 	:= TFont():New( "Tahoma",,16,,.T.,,,,,.F.)
oFont3	:= TFont():New( "Arial"       ,,20,,.F.,,,,,.F.)
oFont4 	:= TFont():New( "courier new",,12,,.T.,,,,,.F.)

oPrn := tAvPrinter():New("Carta de Correcao")

dbSelectArea("SF1")
dbSetOrder(1)
dbSeek(xFilial("SF1")+cDaNota,.T.)

ProcRegua(Val(cAteNota)-Val(cDaNota))

While !Eof() .And. xFilial("SF1")==SF1->F1_FILIAL .And. SF1->F1_DOC <= cAteNota
	
	IF SF1->F1_SERIE #cSerie
		dbSkip()
		Loop
	Endif
	
	IncProc("Nota: "+SF1->F1_SERIE+SF1->F1_DOC)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Prepara a impressao de acordo com as perguntas...            ³
	//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
	//³ Monta o array com as marcas nos codigos selecionados atraves ³
	//³ das perguntas. Um array para cada coluna. Cada coluna com 12 ³
	//³ codigos no maximo.                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aMarca1   := aFill(Array(12),".")
	aMarca2   := aFill(Array(12),".")
	aMarca3   := aFill(Array(12),".")
	
	aCod  := {}
	nCont := 1
	While nCont <= 10
		cAux  := "cCodigo"+Alltrim(Str(nCont))
		xCod  := &cAux
		xCod  := Val(xCod)
		cAux1 := "cMsg1_"+Alltrim(Str(nCont))
		cAux2 := "cMsg2_"+Alltrim(Str(nCont))
		cAux3 := "cMsg3_"+Alltrim(Str(nCont))
		xDesc := &cAux1 + &cAux2 + &cAux3
		If xCod >= 01 .And. xCod <= 12
			aMarca1[xCod]   := "X"
		Elseif xCod >= 13 .And. xCod <= 24
			aMarca2[xCod-12] := "X"
		Elseif xCod >= 25 .And. xCod <= 36
			aMarca3[xCod-24] := "X"
		Endif
		xCod := If(xCod==0,"99",STRZERO(xCod,2))
		aAdd(aCod,{xCod,xDesc})
		nCont++
	End
	
		dbSelectArea("SA2")                   // Cadastro de Fornecedores
		dbSetOrder(1)
		dbSeek(xFilial()+SF1->F1_FORNECE+SF1->F1_LOJA)
		cCod    := SA2->A2_COD + "/" + SA2->A2_LOJA
		cNome   := SA2->A2_NOME
		cEnd    := SA2->A2_END
		cBairro := SA2->A2_BAIRRO
		cMun    := SA2->A2_MUN
		cCep    := SA2->A2_CEP
		cEst    := SA2->A2_EST
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	if nVias > 0 .and. nVias <= 3
		nQtdVias := nVias
	else
		nQtdVias := 3
	endif
	For nVias := 1 To nQtdVias
		oPrn:StartPage()
		nLinha := 30
		nText1_LI := 20
		nText0_LI := nText1_LI + (nLinha *2)
		nText2_LI := nText0_LI + nLinha
		nText3_LI := nText2_LI + nLinha
		nText3CEP_LI := nText3_LI + nLinha
		nText4_LI := nText3_LI + (nLinha*2)
		nText5_LI := nText4_LI + (nLinha *2)
		nText6_LI := nText5_LI + nLinha
		nText7_LI := nText6_LI + nLinha
		nText8_LI := nText7_LI + (nLinha *5)
		nText9_LI := nText8_LI + nLinha
		
		nText1_CI := 20
		nText2_CI := 400
		
		oPrn:Say(nText1_LI, 20, (Alltrim(SM0->M0_CIDCOB)+", "+StrZero(nDia,2)+" de "+cMes+" de "+StrZero(nAno,4)),oFont1,100)
		oPrn:Say(nText1_LI, 1700, ("Carimbo Padronizado do CNPJ"),oFont1,100)
		oPrn:Say(nText0_LI, 20, ("A"),oFont1,100)
		
		//box0
		nBox0_LI := 50
		nBox0_LF := 450
		nBox0_CI := 1700
		nBox0_CF := 2300
		oPrn:Box (nBox0_LI,nBox0_CI,nBox0_LF,nBox0_CF)
		
		oPrn:Say(nText2_LI, nText1_CI, (cNOME + " - " +  cCod),oFont1,100) 
		oPrn:Say(nText3_LI, nText1_CI, (AllTrim(cEND)),oFont1,100) 
		oPrn:Say(nText3CEP_LI, nText1_CI, (If(!Empty(cBAIRRO),"  -  "+cBAIRRO,"")+" - CEP: "+cCEP +" - "+AllTrim(cMUN)+" - "+cEST),oFont1,100) 
		oPrn:Say(nText4_LI, nText1_CI, "Prezado(s) Senhor(es)",oFont1,100)
		oPrn:Say(nText5_LI, nText2_CI, "Ref.: CONFERENCIA DE DOCUMENTO FISCAL E COMUNICACAO DE INCORRECOES.",oFont1,100)
		oPrn:Say(nText6_LI, nText2_CI, "[ ] S/ Nota Fiscal No.        de" ,oFont1,100)
		oPrn:Say(nText7_LI, nText2_CI, ("[X] N/ Nota Fiscal No."+SF1->F1_DOC+" de "+DTOC(SF1->F1_EMISSAO)),oFont1,100)
		oPrn:Say(nText8_LI, nText1_CI+30,("Em face do que determina a legislacao fiscal vigente, vimos pela presente comunicar-lhe que a Nota Fiscal em referencia contem a(s) irregularidade(s) que abaixo apontamos, ") ,oFont1,100)
		oPrn:Say(nText9_LI, nText1_CI, ("cuja correcao solicitamos seja providenciada imediatamente."),oFont1,100)
		
		//box1
		nBox1_LI := 570
		nBox1_LF := 620
		nBox1_CI := 40
		nBox1_CF := 170
		nBox1_LF2 := 1000
		nBox1_CF2 := 700
		nBox1_CM := (nBox1_CI + nBox1_CF)/2
		oPrn:Box(nBox1_LI,nBox1_CI,nBox1_LF,nBox1_CF)//box1_1
		oPrn:Box(nBox1_LI,nBox1_CF,nBox1_LF,nBox1_CF2) //box1_2
		oPrn:Box(nBox1_LF,nBox1_CI,nBox1_LF2,nBox1_CM)//box1_3
		oPrn:Box(nBox1_LF,nBox1_CM,nBox1_LF2,nBox1_CF)//box1_4
		oPrn:Box(nBox1_LF,nBox1_CF,nBox1_LF2,nBox1_CF2)//box1_5
		
		//BOX2
		nBox2_CI := 790
		nBox2_CF := 920
		nBox2_CF2 := 1450
		nBox2_CM := (nBox2_CI + nBox2_CF)/2
		oPrn:Box(nBox1_LI, nBox2_CI, nBox1_LF, nBox2_CF)//box2_1
		oPrn:Box(nBox1_LI, nBox2_CF, nBox1_LF, nBox2_CF2)//box2_1
		oPrn:Box(nBox1_LF, nBox2_CI, nBox1_LF2, nBox2_CM)//box2_3             690+650=1340
		oPrn:Box(nBox1_LF, nBox2_CM, nBox1_LF2, nBox2_CF)//box2_4
		oPrn:Box(nBox1_LF, nBox2_CF, nBox1_LF2, nBox2_CF2)//box2_5
		
		//BOX3
		nBox3_CI := 1540
		nBox3_CF := 1670
		nBox3_CF2 := 2200
		nBox3_CM := (nBox3_CI + nBox3_CF)/2
		oPrn:Box(nBox1_LI, nBox3_CI, nBox1_LF, nBox3_CF)//box3_1
		oPrn:Box(nBox1_LI, nBox3_CF, nBox1_LF, nBox3_CF2)//box3_2
		oPrn:Box(nBox1_LF, nBox3_CI, nBox1_LF2, nBox3_CM)//box3_3
		oPrn:Box(nBox1_LF, nBox3_CM, nBox1_LF2, nBox3_CF)//box3_4
		oPrn:Box(nBox1_LF, nBox3_CF, nBox1_LF2, nBox3_CF2)//box3_5
		
		nTextA_LI := nBox1_LI +10
		nTextA_CI := nBox1_CI + 10
		nTextA_CM := nBox1_CM + 10
		nTextA_CF := nBox1_CF+10
		nTextAA_LI := nBox1_LI + 30
		nTextB_CI := nBox2_CI + 10
		nTextB_CM := nBox2_CM + 10
		nTextB_CF := nBox2_CF+10
		nTextC_CI := nBox3_CI + 10
		nTextC_CM := nBox3_CM + 10
		nTextC_CF := nBox3_CF + 10
		
		oPrn:Say(nTextA_LI, nTextA_CI,"Codigo" ,oFont1,100)
		oPrn:Say(nTextA_LI, nTextB_CI,"Codigo" ,oFont1,100)
		oPrn:Say(nTextA_LI, nTextC_CI,"Codigo" ,oFont1,100)
		oPrn:Say(nTextA_LI, nTextA_CF,"Especificacao" ,oFont1,100)
		oPrn:Say(nTextA_LI, nTextB_CF,"Especificacao" ,oFont1,100)
		oPrn:Say(nTextA_LI, nTextC_CF,"Especificacao" ,oFont1,100)

		nAuxLinha := nTextAA_LI+ nlinha
		For nLin := 1 To 12
			//box1
			oPrn:Say(nAuxLinha, nTextA_CI, (aMarca1[nLin]) ,oFont1,100)
			oPrn:Say(nAuxLinha, nTextA_CM, (StrZero(nLin,2)) ,oFont1,100)
			oPrn:Say(nAuxLinha, nTextA_CF, (aCol1[nLin]) ,oFont1,100)
			//box2
			oPrn:Say(nAuxLinha, nTextB_CI, (aMarca2[nLin]) ,oFont1,100)
			oPrn:Say(nAuxLinha, nTextB_CM, (StrZero(nLin+12,2)) ,oFont1,100)
			oPrn:Say(nAuxLinha, nTextB_CF, (aCol2[nLin]) ,oFont1,100)
			//box3
			oPrn:Say(nAuxLinha, nTextC_CI, (aMarca3[nLin]) ,oFont1,100)
			oPrn:Say(nAuxLinha, nTextC_CM, (StrZero(nLin+24,2)) ,oFont1,100)
			oPrn:Say(nAuxLinha, nTextC_CF, (aCol3[nLin]) ,oFont1,100)

			nAuxLinha += 30
		Next nLin
		
		//box4
		nBox4_LI := 1050
		nBox4_LF := 1150
		nBox4_CI := 40
		nBox4_CF := 260
		nBox4_LF2 := 1480
		nBox4_CF2 := 2300
		oPrn:Box(nBox4_LI, nBox4_CI, nBox4_LF, nBox4_CF)//box4_1
		oPrn:Box(nBox4_LI, nBox4_CF, nBox4_LF, nBox4_CF2)//box4_2
		oPrn:Box(nBox4_LF, nBox4_CI, nBox4_LF2, nBox4_CF)//box4_3
		oPrn:Box(nBox4_LF, nBox4_CF, nBox4_LF2, nBox4_CF2)//box4_4
		
		nText40_LI := nBox4_LI +10
		nText40_CI := nBox4_CI +10
		nText41_LI := nText40_LI +30
		nText42_CI := nBox4_CF +10
		oPrn:Say(nText40_LI, nText40_CI,"Codigos com" ,oFont1,100)
		oPrn:Say(nText41_LI, nText40_CI,"Irregularidades" ,oFont1,100)
		oPrn:Say(nText40_LI, nText42_CI,"Retificacoes a serem consideradas" ,oFont1,100)
		
		nAuxLinha := nText41_LI+70
		For nLin := 1 To 10       
			oPrn:Say(nAuxLinha, nText40_CI,  (If(aCod[nLin,1]!="99",aCod[nLin,1],"  ")) ,oFont1,100)
			oPrn:Say(nAuxLinha, nText42_CI, (aCod[nLin,2]) ,oFont1,100) 
			nAuxLinha += 30
		Next nLin
		
		
		nText10_LI := 1500
		nText11_CI := 1200
		oPrn:Say(nText10_LI, nText1_CI+30,"Para evitar-se sancao fiscal, solicitamos acusarem o recebimento desta, na copia que acompanha, devendo a via de V. S(as) ficar arquivada juntamente com a Nota Fiscal em questao." ,oFont1,100)
		oPrn:Say(nText10_LI+(nLinha*3), nText11_CI,"Sem outro motivo para o momento, subscrevemo-nos atenciosamente" ,oFont1,100)
		oPrn:Say(nText10_LI+(nLinha*6), nText11_CI,"_____________________________________________" ,oFont1,100)
		oPrn:Say(nText10_LI+(nLinha*7), nText11_CI, AllTrim(SM0->M0_NOMECOM) ,oFont1,100)
		If nVias == 1
			oPrn:Say(nText10_LI+(nLinha*10), nText11_CI,"1a. Via Fornecedor" ,oFont1,100)
		Elseif nVias == 2
			oPrn:Say(nText10_LI+(nLinha*10), nText11_CI,"2a. Via Fornecedor" ,oFont1,100)
		Elseif nVias == 3
			oPrn:Say(nText10_LI+(nLinha*10), nText11_CI,"3a. Via Fiscal" ,oFont1,100)
		Endif
		
		
		//box5
		nBox5_LI := 1600
		nBox5_LF := 1700
		nBox5_CI := 40
		nBox5_CF := 900
		nBox5_LF2 := 1850
		nBox5_LF3 := 1900
		oPrn:Box(nBox5_LI, nBox5_CI, nBox5_LF, nBox5_CF)//box5_1
		oPrn:Box(nBox5_LF, nBox5_CI, nBox5_LF2, nBox5_CF)//box5_2
		oPrn:Box(nBox5_LF2, nBox5_CI, nBox5_LF3, nBox5_CF)//box5_3
		
		oPrn:Say(nBox5_LI - nLinha, nBox5_CI +30 ,"Acusamos recebimento da "+STR(nVias,1)+".a via" ,oFont1,100)
		oPrn:Say(nBox5_LF + 10, nBox5_CI +30 ,"(local e data)" ,oFont1,100)
		oPrn:Say(nBox5_LF2 + 10, nBox5_CI +30 ,"(carimbo e assinatura)" ,oFont1,100)
		
		
		nText12_LI := 1950
		//oPrn:Box(1900, 20, 1902, 2300)//box6_1
		oPrn:Line(nText12_LI, 20, nText12_LI, 2300)
		oPrn:Say(nText12_LI+(nLinha), nText1_CI ,"EDITORA  PINI LTDA. Rua Anhaia 964 e Rua dos Italianos 967 - Bom Retiro - Sao Paulo - SP CEP: 01130-900" ,oFont1,100)
		oPrn:Say(nText12_LI+(nLinha*2), nText1_CI ,"PINI SISTEMAS LTDA. Rua Anhaia 964 Casa 1 - Bom Retiro - Sao Paulo - SP CEP: 01130-900" ,oFont1,100)
		oPrn:Say(nText12_LI+(nLinha*3), nText1_CI ,"BP S/A. Rua Anhaia 964 1o Andar - Bom Retiro - Sao Paulo - SP CEP: 01130-900" ,oFont1,100)
		
		oPrn:EndPage()
		
	Next nVias
	dbSelectArea("SF1")
	dbSkip()
End

//Imprime em tela p/ preview
oPrn:Preview()
oPrn:End()

Return

