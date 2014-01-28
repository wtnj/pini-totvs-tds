#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Rfis004   ³ Autor ³ Danilo C S Pala       ³ Data ³20091104  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera arquivo da Nota Fiscal Paulista                        ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³					                                          ³±±
±±³          ³     				                                          ³±±
±±³          ³       			                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function Rfis004()
Private cSerie := space(3)
Private dDaData := dDatabase
Private dAteData := dDatabase
Private cNomeArquivo := space(40)
//Private aItens := {"Abertas","Baixadas","Todas"}    
                    


@ 000,000 TO 320,400 DIALOG oDlg TITLE "Arquivo para Nota Fiscal Paulista(Saídas)" 
@ 001,005 TO 310,380
@ 005,010 SAY "Serie:"
@ 005,070 GET cserie  Picture "@!" 
@ 020,010 SAY "Da Data:"
@ 020,070 GET dDaData
@ 035,010 SAY "Ate Data"
@ 035,070 GET dAteData
@ 050,010 SAY "Arquivo de saída:"
@ 050,070 GET cNomeArquivo  Picture "@!"
@ 060,070 SAY "Exemplo C:\NFP20091104.txt"
@ 115,010 BUTTON "Gerar Arquivo" SIZE 40,20 ACTION Processa({||GerarArquivo()})
@ 115,070 BUTTON "Sair" SIZE 40,20 Action ( Close(oDlg) )
Activate Dialog oDlg centered
Return


Static Function GerarArquivo()
Private nCont20 := 0
Private nCont30 := 0
Private nCont40 := 0
Private nCont50 := 0
Private nCont60 := 0
Private cQuery  := ""
Private cString := ""
Private nItemNF := 0
Private cNatOp  := ""
    
//10 - Cabecalho
cString += '10|1,00|'+ SM0->M0_CGC +'|'+ Alltrim(ConvertDate(dDaData)) +'|'+ Alltrim(ConvertDate(dAteData)) + CHR(13)

cQuery := "SELECT * FROM "+ RetSqlName("SF2") +" SF2, "+ RetSqlName("SA1") +" SA1 WHERE F2_FILIAL='"+ XFILIAL("SF2") +"' AND A1_FILIAL='"+ XFILIAL("SA1") +"' AND F2_CLIENTE=A1_COD AND F2_LOJA=A1_LOJA AND F2_SERIE='"+ cSerie +"' AND F2_EMISSAO>='"+ dtos(dDaData) +"' AND F2_EMISSAO<='"+ dtos(dAteData) +"' AND SF2.D_E_L_E_T_<>'*' AND SA1.D_E_L_E_T_<>'*' ORDER BY F2_SERIE, F2_DOC"
TCQUERY cQuery NEW ALIAS "NOTA"
TcSetField("NOTA","F2_EMISSAO"   ,"D")
DbSelectArea("NOTA")
DBGOTOP()
WHILE !EOF() 
	nCont20 := nCont20 + 1
	nItemNF := 1
	cQuery := "SELECT * FROM "+ RetSqlName("SD2") +" SD2, "+ RetSqlName("SB1") +" SB1 WHERE D2_FILIAL='"+ XFILIAL("SD2") +"' AND B1_FILIAL='"+ XFILIAL("SB1") +"' AND D2_COD=B1_COD AND D2_SERIE='"+ NOTA->F2_SERIE +"' AND D2_DOC='"+ NOTA->F2_DOC +"' AND D2_EMISSAO='"+ DTOS(NOTA->F2_EMISSAO) +"' AND SD2.D_E_L_E_T_<>'*' AND SB1.D_E_L_E_T_<>'*'"
	TCQUERY cQuery NEW ALIAS "NOTASD2"
	TcSetField("NOTASD2","D2_EMISSAO"   ,"D")
	DbSelectArea("NOTASD2")
	DBGOTOP()
	WHILE !EOF()
		if nItemNF == 1 
			//20 - NF (nota fiscal com 3 itens de mercadorias e com informações adicionais de interesse do Fisco)
			cNatOp := Alltrim(posicione("SX5",1,xfilial("SX5")+"13"+NOTASD2->D2_CF,"X5_DESCRI"))
			if cNatOp=="COMPL.ICMS"
				cNatOp := "COMPLEMENTO DE ICMS"
			endif
			cString += '20|I||'+ cNatOp +'|'+ iif(NOTA->F2_SERIE=="UNI","03","03") +'|'+ Alltrim(NOTA->F2_DOC) +'|'+ ConvertDate(NOTA->F2_EMISSAO) +NOTA->F2_HORA +':00|'+  ConvertDate(NOTA->F2_EMISSAO) +NOTA->F2_HORA +':00|1|'+ Alltrim(NOTASD2->D2_CF) +'|'+ Alltrim(NOTA->A1_INSCR) +'|'+ Alltrim(NOTA->A1_INSCRM) +'|'+ Alltrim(NOTA->A1_CGC) +'|'+ ALLTRIM(NOTA->A1_NOME) +'|'+ ALLTRIM(NOTA->A1_TPLOG) + " " + ALLTRIM(NOTA->A1_LOGR) +'|'+ iif(empty(NOTA->A1_NLOGR),".",ALLTRIM(NOTA->A1_NLOGR)) +'|'+ ALLTRIM(NOTA->A1_COMPL) +'|'+ iif(empty(NOTA->A1_BAIRRO),".",ALLTRIM(NOTA->A1_BAIRRO)) +'|'+ ALLTRIM(NOTA->A1_MUN) +'|'+ NOTA->A1_EST +'|'+ NOTA->A1_CEP +'|'+ IIF(Empty(NOTA->A1_PAIS),"BRASIL",Posicione("SYA",1,xFilial("SYA")+NOTA->A1_PAIS,"YA_DESCR" )) +'|'+ LimparTel(Alltrim(NOTA->A1_TEL)) +'||'+ CHR(13)
		endif
		nItemNF := nItemNF + 1 
		nCont30 := nCont30 + 1
		//30 - Item NF
		cString += '30|'+ Alltrim(NOTASD2->D2_COD) +'|'+ Alltrim(NOTASD2->B1_DESC)+'|'+ Alltrim(NOTASD2->B1_POSIPI) +'|'+ iif(empty(NOTASD2->D2_UM),"UN",Alltrim(NOTASD2->D2_UM)) +'|'+ Alltrim(Transform(NOTASD2->D2_QUANT,"@E 999999999.9999")) +'|'+ Alltrim(Transform(NOTASD2->D2_PRCVEN,"@E 999999999.9999")) +'|'+ Alltrim(Transform(NOTASD2->D2_TOTAL,"@E 999999999.99")) +'|'+ Alltrim(NOTASD2->D2_CLASFIS) +'|'+ Alltrim(Transform(NOTASD2->D2_PICM,"@E 999.99")) +'|'+ Alltrim(Transform(NOTASD2->D2_IPI,"@E 999.99")) +'|'+ Alltrim(Transform(NOTASD2->D2_VALIPI,"@E 999999999.99"))+ CHR(13)
		DbSelectArea("NOTASD2")
		DBSkip()
	END
	DbSelectArea("NOTASD2")
	DbCloseArea()

	//40 - Valor
	nCont40 := nCont40 + 1
	cString += '40|'+ Alltrim(Transform(NOTA->F2_BASEICM,"@E 999999999.99")) +'|'+ Alltrim(Transform(NOTA->F2_VALICM,"@E 999999999.99")) +'|'+ Alltrim(Transform(NOTA->F2_BASEICM,"@E 999999999.99")) +'|'+ Alltrim(Transform(NOTA->F2_ICMSRET,"@E 999999999.99")) +'|'+ Alltrim(Transform(NOTA->F2_VALMERC,"@E 999999999.99")) +'|'+  Alltrim(Transform(NOTA->F2_FRETE,"@E 999999999.99")) +'|'+ Alltrim(Transform(NOTA->F2_SEGURO,"@E 999999999.99")) +'|'+ Alltrim(Transform(iif(NOTA->F2_DESCONT>=0,0,0),"@E 999999999.99")) +'|'+ Alltrim(Transform(NOTA->F2_VALIPI,"@E 999999999.99")) +'|'+ Alltrim(Transform(NOTA->F2_DESPREM,"@E 999999999.99")) +'|'+ Alltrim(Transform(NOTA->F2_VALFAT,"@E 999999999.99")) + CHR(13) //+'|'+ ???? VALOR TOTAL DE SERVICOS +'|'+ ???? ALIQUITA ISS +'|'+ Alltrim(Transform(F2_VALISS,"@E 999999999.99")) + CHR(13) ///+'|'+  Alltrim(Transform(NOTA->F2_BRICMS,"@E 999999999.99"))
	
	//50 - Transporte
	nCont50 := nCont50 + 1
	cString += '50|1||||||||||||||'+ CHR(13)
	//60 - Dados da Fatura
	nCont60 := nCont60 + 1
	cString += '60|'+ ALLTRIM(NOTA->F2_DUPL) +'||'+ CHR(13)

	DbSelectArea("NOTA")
	DBSkip()
END
DbSelectArea("NOTA")
DbCloseArea()

//90 - Rodape totalizador
cString += '90|'+ StrZero(nCont20,5) +'|'+ StrZero(nCont30,5) +'|'+ StrZero(nCont40,5) +'|'+ StrZero(nCont50,5) +'|'+ StrZero(nCont60,5) + CHR(13)

MemoWrit(cNomeArquivo,cString)
MsgInfo("Gerado arquivo "+ Alltrim(cNomeArquivo))
Return

Static Function ConvertDate(dData)
Local cDataRetorno := ""
cDataRetorno := StrZero(Day(dData),2)+ "/" + StrZero(Month(dData),2)+ "/" + StrZero(Year(dData),4) +" "
Return cDataRetorno

Static Function LimparTel(cTel)
cTel := upper(cTel)
cTel := Alltrim(StrTran(cTel," ",""))
cTel := Alltrim(StrTran(cTel,"-",""))
cTel := Alltrim(StrTran(cTel,"/",";"))
cTel := Alltrim(StrTran(cTel,".",""))
cTel := Alltrim(StrTran(cTel,"REC",""))
cTel := Alltrim(StrTran(cTel,"R",""))
if ';' $ cTel
	cTel :=""
endif
Return cTel