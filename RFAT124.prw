#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
//Danilo C S Pala 20100305: ENDBP
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³RFAT124   ³ Autor ³  Danilo C S Pala      ³ Data ³ 20091027 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ RECIBO / COMPROVANTE DE NOTA FISCAL                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico PINI                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Release  ³ 															  ³±±
±±³          ³ 															  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function RFAT124()
Private cDoNumero := space(9) //MP10
Private cAteNumero := space(9) //MP10
Private cSerie := space(3)  
/*Private cDaParcela := SPACE(1)
Private cAteParcela := "Z"*/
Private nVias := 1
//Private aItens := {"Abertas","Baixadas","Todas"}    

@ 000,000 TO 220,300 DIALOG oDlg TITLE "Recibo de Titulo Recebido" 
@ 001,005 TO 110,120
@ 005,010 SAY "Serie:"
@ 005,070 GET cserie  Picture "@!" F3("SF2") Valid ValSF2()
@ 020,010 SAY "Do Numero:"
@ 020,070 GET cDoNumero  Picture "@R 999999999"
@ 035,010 SAY "Ate Numero"
@ 035,070 GET cAteNumero  Picture "@R 999999999"
/*@ 050,010 SAY "Da Parcela:"
@ 050,070 GET cDaParcela  Picture "@!"
@ 065,010 SAY "Ate Parcela:"
@ 065,070 GET cAteParcela  Picture "@!"*/
//@ 035,010 SAY "Tipo da nota:"
//@ 035,070 COMBOBOX cTipo ITEMS aItens SIZE 90,90
@ 085,010 BUTTON "Imprimir" SIZE 40,20 ACTION Processa({||Recibotit()})
@ 085,070 BUTTON "Sair" SIZE 40,20 Action ( Close(oDlg) )
Activate Dialog oDlg centered
Return
        


/*
Loop no SE1
*/
Static Function Recibotit()
setprvt("cNome, cEnd, cBairro, cMun, cCep, cEst, cCGC, cPreco, cPRODUTOS, cTexto1")
setprvt("nBox0_LI, nBox0_LF, nBox0_CI, nBox0_CF, cMenNota, cPedido")
oFont1 	:= TFont():New( "Arial",,14,,.T.,,,,,.F.) //oFont1 	:= TFont():New( "Georgia",,12,,.T.,,,,,.F.)
oFont2 	:= TFont():New( "Tahoma",,16,,.T.,,,,,.F.)
oFont3	:= TFont():New( "Arial"       ,,20,,.F.,,,,,.F.)
oFont4 	:= TFont():New( "courier new",,12,,.T.,,,,,.F.)
oFont5 	:= TFont():New( "Times New Roman",,20,,.T.,,,,,.F.)
oPrn := tAvPrinter():New("Recibo")

Private cQuery :=  space(200)
Private nLinha := 10
Private nSomaLinha := 30
Private nColuna := 30
Private nImplinha := 0
Private nVolta := 1
Private nPosicao := 0
cQuery := "SELECT * FROM "+ RetSqlName("SF2") +" SF2 WHERE F2_FILIAL='"+ XFILIAL("SF2") +"' AND F2_SERIE='"+ cSerie +"' AND F2_DOC>='"+ cDoNumero +"' AND F2_DOC<='"+ cAteNumero +"' AND SF2.D_E_L_E_T_<>'*'"
TCQUERY cQuery NEW ALIAS "NOTA"
TcSetField("NOTA","F2_EMISSAO" ,"D")
DbSelectArea("NOTA")
DBGOTOP()

WHILE !EOF() 
	nLinha := 10
	nSomaLinha := 40
	nColuna := 30
    cPreco := "R$ "+ Alltrim(Transform(NOTA->F2_VALBRUTO,"@E 999,999.99"))
	//cPRODUTOS := getProdutos(RECIBO->E1_PREFIXO, RECIBO->E1_NUM, RECIBO->E1_EMISSAO)

	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial("SA1")+NOTA->F2_CLIENTE+NOTA->F2_LOJA)
	cNome   := SA1->A1_NOME
	cEnd    := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060327
	cBairro := SA1->A1_BAIRRO
	cMun    := SA1->A1_MUN
	cCep    := SA1->A1_CEP
	cEst    := SA1->A1_EST
	cCGC 	:= alltrim(SA1->A1_CGC)
	if len(cCGC) <14
		cCGC := "C.P.F. " + Transform(cCGC,"@R 999.999.999-99")
	else 
		cCGC := "C.N.P.J. " + Transform(cCGC,"@R 999.999.999/9999-99")
	endif
		
	//20100305 DAQUI
	IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
		DbSelectArea("ZY3")
		DbSetOrder(1)
		if DbSeek(xFilial("ZY3")+SA1->A1_COD+SA1->A1_LOJA, .F.)
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
	
	oPrn:StartPage() //inicia pagina de impressao
	
	//oPrn:Say(nLinha, nColuna, ("COMPROVANTE DE NOTA FISCAL"),oFont5,100)
	//nLinha := nLinha + (nSomaLinha *4)
	
	//nLinha := nLinha + (nSomaLinha *3)
	oPrn:Say(nLinha, nColuna, ("Á") ,oFont1,100)
	nLinha := nLinha + (nSomaLinha *2)
	oPrn:Say(nLinha, nColuna, (Alltrim(cNome)) ,oFont1,100)
	nLinha := nLinha + nSomaLinha
	oPrn:Say(nLinha, nColuna, (alltrim(cEnd) + " " + alltrim(cBairro)) ,oFont1,100)
	nLinha := nLinha + nSomaLinha
	oPrn:Say(nLinha, nColuna, (alltrim(cMun) +" / "+ alltrim(cEst)) ,oFont1,100)
	nLinha := nLinha + nSomaLinha
	oPrn:Say(nLinha, nColuna, (alltrim(cCEP)) ,oFont1,100)
	
	nLinha := nLinha + (nSomaLinha*3)
	oPrn:Say(nLinha, nColuna, ("Prezado cliente:") ,oFont1,100)
	nLinha := nLinha + (nSomaLinha*2)
	
	cTexto1 := "A sua nota fiscal já foi emitida, porém devido a um problema interno e temporário para a impressão desse documento fiscal a mesma não segue em anexo ao(s) produto(s), mas, visando atender ao nosso cliente dentro de um menor prazo possível, estamos enviando-lhes os produtos conforme a compra realizada por V.S.a desacompanhada da referida nota fiscal e nos comprometendo a encaminhá-la pelo correio assim que este fato esteja resolvido. "
    nImplinha := len(cTexto1)
    

	//nVolta :=0 
	while nImplinha > 0	
		nVolta :=0 
		nPosicao := 0
		while nVolta <= 80
			if substr(cTexto1, 80 -nVolta,1)==" "
				exit
			endif
			nVolta++
		end     
		nPosicao := 80 -nvolta
		//oPrn:Say(nLinha, nColuna, substr(cTexto1,(nvolta*80)+1,80),oFont1,100)
		oPrn:Say(nLinha, nColuna, substr(cTexto1,1,nPosicao),oFont1,100)
		cTexto1 := substr(cTexto1,nPosicao, len(cTexto1))
		nLinha := nLinha + nSomaLinha
		nImplinha := nImplinha -nPosicao 
		//nVolta++
	end
	
	nLinha := nLinha + (nSomaLinha*2)
	oPrn:Say(nLinha, nColuna, ("Dados dos produtos e nota fiscal:") ,oFont1,100)

	nLinha := nLinha + (nSomaLinha*3)
	oPrn:Say(nLinha, nColuna, ("Nota fiscal: " + alltrim(NOTA->F2_SERIE) +" " + alltrim(NOTA->F2_DOC) + " - "+ DTOC(NOTA->F2_EMISSAO) + "   R$ "+ Alltrim(Transform(NOTA->F2_VALBRUT,"@E 999,999.99"))) ,oFont1,100)	
	nLinha := nLinha + (nSomaLinha)
	
	//Produtos
	cQuery := "SELECT B1_COD, B1_DESC, D2_QUANT, D2_PRCVEN, D2_TOTAL, D2_PEDIDO FROM "+ RetSqlName("SD2") +" SD2, "+ RetSqlName("SB1") +" SB1 WHERE D2_FILIAL='"+ XFILIAL("SD2") +"' AND B1_FILIAL='"+ XFILIAL("SB1") +"' AND D2_COD=B1_COD AND D2_SERIE='"+ NOTA->F2_SERIE +"' AND D2_DOC='"+ NOTA->F2_DOC +"' AND D2_EMISSAO='"+ DTOS(NOTA->F2_EMISSAO) +"' AND SD2.D_E_L_E_T_<>'*' AND SB1.D_E_L_E_T_<>'*'"
	TCQUERY cQuery NEW ALIAS "NOTASD2"
	DbSelectArea("NOTASD2")
	DBGOTOP()
	WHILE !EOF() 
		nLinha := nLinha + (nSomaLinha)                                                                                                                                     
		oPrn:Say(nLinha, nColuna, (alltrim(NOTASD2->B1_COD) +" " + alltrim(NOTASD2->B1_DESC) + " "+ Alltrim(Transform(NOTASD2->D2_QUANT,"@E 999,999")) + " "+ Alltrim(Transform(NOTASD2->D2_PRCVEN,"@E 999,999.99")) +" "+ Alltrim(Transform(NOTASD2->D2_TOTAL,"@E 999,999.99")) ) ,oFont1,100)	
		cPedido := NOTASD2->D2_PEDIDO
		DbSelectArea("NOTASD2")
		DBSkip()
	END
	cMenNota := posicione("SC5",1,xfilial("SC5")+cPedido,"C5_MENNOTA")
	nLinha := nLinha + (nSomaLinha *2)
	oPrn:Say(nLinha, nColuna, (alltrim(cMenNota)) ,oFont1,100)
	DbSelectArea("NOTASD2")
	DbCloseArea()	
	
	//Duplicatas
	
	
	

	nLinha := nLinha + (nSomaLinha *3)
	oPrn:Say(nLinha, nColuna, ("Desde já agradecemos e contamos com a sua compreensão e estamos a disposição") ,oFont1,100)
	nLinha := nLinha + (nSomaLinha)
	oPrn:Say(nLinha, nColuna, ("para adicionais esclarecimentos") ,oFont1,100)
	nLinha := nLinha + (nSomaLinha *4)
	oPrn:Say(nLinha, nColuna, ("Atenciosamente") ,oFont1,100)
	nLinha := nLinha + (nSomaLinha *2)
	oPrn:Say(nLinha, nColuna, ("EDITORA PINI LTDA") ,oFont1,100)
	nLinha := nLinha + (nSomaLinha)
	oPrn:Say(nLinha, nColuna, ("Depto de Logística") ,oFont1,100)
	nLinha := nLinha + (nSomaLinha)
	oPrn:Say(nLinha, nColuna, ("Tel. 11 - 2173-2449/2450") ,oFont1,100)
	nLinha := nLinha + (nSomaLinha)
	oPrn:Say(nLinha, nColuna, ("cicero@pini.com.br") ,oFont1,100)


	
	nBox0_LI := 90
	nBox0_LF := 1200
	nBox0_CI := 20
	nBox0_CF := 2000
	//oPrn:Box (nBox0_LI,nBox0_CI,nBox0_LF,nBox0_CF)       
	
	oPrn:EndPage()
    
	DbSelectArea("NOTA")
	DBSkip()
END
DbSelectArea("NOTA")
DbCloseArea()

oPrn:Preview()
oPrn:End()

Return








Static Function ValSF2()
	cSerie := SF2->F2_SERIE
	cDoNumero := SF2->F2_DOC
	cAteNumero := SF2->F2_DOC
RETURN (.T.)