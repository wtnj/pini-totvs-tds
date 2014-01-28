#INCLUDE "RWMAKE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RFATR50   ºAutor  ³Marcos Farineli     º Data ³  26/07/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Lista baixas conforme regras da Editora                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function RFATR50()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private CbTxt       := ""
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 220
Private tamanho     := "G"
Private nomeprog    := "RFATR50"
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private MHORA := TIME()
Private wnrel       := "RFATR50_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
Private nCaracter   := 12
Private cQuery      := ""
Private cPerg       := "RFT050"
Private cArq,cInd
Private cString     := ""
Private aStru
Private aOrd        := {}
Private cDesc1      := "Este programa tem como objetivo imprimir relatorio "
Private cDesc2      := "de acordo com os parametros informados pelo usuario."
Private cDesc3      := "Baixas "
Private cPict       := ""
Private ctitulo      := "Baixas "
Private nLin        := 80
Private cCabec1      := "Listagem de Baixas"
Private cCabec2      := "Data Alt  Data Bxa  Data Ven  Pref Numero Parc  Valor Orig       Multa       Juros    Desconto     Liquido  Natureza   Nat Bxa    Portador  Hist Baixa"
Private imprime     := .T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³mv_par01 - Data de?                               ³
//³mv_par02 - Data ate?                              ³
//³mv_par03 - Tipo de saida ? relatorio/arquivo/ambos³
//³mv_par04 - Diretorio de saida                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !Pergunte(cPerg,.t.)
	Return
EndIf

wnrel := SetPrint(cString,NomeProg,cPerg,@ctitulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.f.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| RunReport()})

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP5 IDE            º Data ³  26/07/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RunReport()

cQuery += "SELECT E1_BAIXA, DECODE(E1_DTALT,'        ',E1_BAIXA,E1_DTALT) E1_DTALT,"
cQuery += " E1_VENCTO, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_HISTBX,"
cQuery += " E1_VALOR, E1_VALJUR, E1_MULTA, E1_DESCONT, E1_VALLIQ,"
cQuery += " E1_PORTADO, E1_NATUREZ, E1_NATBX"
cQuery += " FROM " + RetSqlName("SE1")
cQuery += " WHERE E1_FILIAL = '" + xFilial("SE1") + "'"
cQuery += " AND(((E1_BAIXA BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"') AND E1_DTALT ='        ')"
cQuery += " OR (E1_BAIXA <> '        ' AND (E1_DTALT BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"')))"
cQuery += " AND E1_NATUREZ BETWEEN '"+ MV_PAR05 +"' AND '"+ MV_PAR06+"'"
cQuery += " AND E1_NATBX BETWEEN '"+ MV_PAR07 +"' AND '"+ MV_PAR08+"'"
cQuery += " AND E1_PORTADO BETWEEN '"+ MV_PAR09 +"' AND '"+ MV_PAR10+"'"
cQuery += " AND D_E_L_E_T_ <> '*'"
cQuery += " ORDER BY E1_DTALT, E1_PREFIXO, E1_NUM, E1_PARCELA"

If Select("TE1") <> 0
	DbSelectArea("TE1")
	DbCloseArea()
EndIf	

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TE1", .T., .F. )},"Aguarde - NAO DESCONECTE!","Buscando dados. Isto pode demorar um pouco...")

TcSetField("TE1","E1_VENCTO" ,"D")
TcSetField("TE1","E1_BAIXA"  ,"D")
TcSetField("TE1","E1_DTALT"  ,"D")

dbSelectArea("TE1")
ProcRegua(RecCount())
dbGoTop()

If mv_par03 == 2 .or. mv_par03 == 3
	Copy To &("\siga\arqtemp\rfatr50.dbf")   VIA "DBFCDXADS" // 20121106 // Copia o arquivo para diretorio temporario
	WinExec("copy \\vilya\ap5\siga\arqtemp\rfatr50.dbf "+ mv_par04)
    Ferase("\siga\arqtemp\rfatr50.dbf")
	If mv_par03 == 2  // Somente arquivo
		Return
	EndIf
EndIf	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa variaveis de controle³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nValDia  := 0
nMulDia  := 0
nJurDia  := 0
nLiqDia  := 0
nValTot  := 0
nMulTot  := 0
nJurTot  := 0
nLiqTot  := 0
nDesDia  := 0
nDesTot  := 0
aNatDia  := {}
aVlNtDia := {}
aNatTot  := {}
aVlNtTot := {}
aVNBxDia := {}
aNtBxDIa := {}
aVNBxTot := {}
aNtBxTot := {}
aPortDia := {}
aVlPtDia := {}
aPortTot := {}
aVlPtTot := {}
dDataRef := TE1->E1_DTALT

nlin := CABEC(cTitulo,cCabec1,cCabec2,nomeProg,tamanho,nCaracter)
nlin++
@ nlin, 000 PSay "Data: " + Transform(TE1->E1_DTALT ,"@E 99/99/99")

While !EOF()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif

	IncProc("Data: " + Transform(TE1->E1_DTALT,"@E 99/99/99"))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ChecaPag()

	If DTOS(TE1->E1_DTALT) <> DTOS(dDataRef)
		ResDia()
		nLin += 2
		@ nlin, 000 PSay "Data: " + Transform(TE1->E1_DTALT ,"@E 99/99/99")
	EndIf

	// ..........1.........2.........3.........4.........5.........6.........7.........8.........9........10........11........12........13........14........15........16........17........18
	// 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	// Data Alt  Data Bxa  Data Ven  Pref Numero Parc  Valor Orig       Multa       Juros    Desconto     Liquido  Natureza   Nat Bxa    Portador  Hist Baixa
	// dd/mm/yy  dd/mm/yy  dd/mm/yy  xxx  999999 x     999.999,99  999.999,99  999.999,99  999.999,99  999.999,99  xxxxxxxxxx xxxxxxxxxx xxx       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	
	@ nlin, 000 PSay Transform(TE1->E1_DTALT ,"@E 99/99/99")
	@ nlin, 010 PSay Transform(TE1->E1_BAIXA ,"@E 99/99/99")
	@ nlin, 020 PSay Transform(TE1->E1_VENCTO,"@E 99/99/99")
	@ nlin, 030 PSay TE1->E1_PREFIXO
	@ nlin, 035 PSay TE1->E1_NUM
	@ nlin, 042 PSay TE1->E1_PARCELA
	@ nlin, 048 PSay TE1->E1_VALOR Picture "@E 999,999.99"
	@ nlin, 060 PSay TE1->E1_MULTA Picture "@E 999,999.99"
	@ nlin, 072 PSay TE1->E1_VALJUR Picture "@E 999,999.99"
	@ nLin, 084 Psay TE1->E1_DESCONT Picture "@E 999,999.99"
	@ nlin, 096 PSay TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT Picture "@E 999,999.99"
	@ nlin, 108 Psay TE1->E1_NATUREZ
	@ nLin, 119 Psay TE1->E1_NATBX
	@ nlin, 130 Psay TE1->E1_PORTADO
	@ nlin, 140 PSay Substr(TE1->E1_HISTBX,1,30)

	nLin++ // Avanca a linha de impressao
	nValDia  += TE1->E1_VALOR
	nMulDia  += TE1->E1_MULTA
	nJurDia  += TE1->E1_VALJUR
	nDesDia  += TE1->E1_DESCONT
	nLiqDia  := nValDia + nMulDia + nJurDia - nDesDia //IIF(TE1->E1_VALLIQ == 0,TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT ,TE1->E1_VALLIQ)
	nDesTot  += TE1->E1_DESCONT
	nValTot  += TE1->E1_VALOR
	nMulTot  += TE1->E1_MULTA
	nJurTot  += TE1->E1_VALJUR
	nLiqTot  := nValtot + nMulTot + nJurTot - nDesTot //IIF(TE1->E1_VALLIQ == 0,TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT ,TE1->E1_VALLIQ)
	dDataRef := TE1->E1_DTALT

	If Ascan(aNatDia,TE1->E1_NATUREZ) <> 0
		aVlNtDia[Ascan(aNatDia,TE1->E1_NATUREZ)] += TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT 
	Else
		AADD(aNatDia,  TE1->E1_NATUREZ)
		AADD(aVlNtDia, TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT )
	EndIf
	
	If Ascan(aNatTot,TE1->E1_NATUREZ) <> 0
		aVlNtTot[Ascan(aNatTot,TE1->E1_NATUREZ)] += TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT
	Else
		AADD(aNatTot,  TE1->E1_NATUREZ) 
		AADD(aVlNtTot, TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT)
	EndIf	

	If Ascan(aNtBxTot,TE1->E1_NATBX) <> 0
		aVNBxTot[Ascan(aNtBxTot,TE1->E1_NATBX)] += TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT
	Else
		AADD(aNtBxTot,  TE1->E1_NATBX) 
		AADD(aVNBxTot,  TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT)
	EndIf	

	If Ascan(aNtBxDia,TE1->E1_NATBX) <> 0
		aVNBxDia[Ascan(aNtBxDia,TE1->E1_NATBX)] += TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT
	Else
		AADD(aNtBxDia,  TE1->E1_NATBX) 
		AADD(aVNBxDia,  TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT)
	EndIf		
    
	If Ascan(aPortDia,TE1->E1_PORTADO) <> 0
		aVlPtDia[Ascan(aPortDia,TE1->E1_PORTADO)] += TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT
	Else
		AADD(aPortDia,  TE1->E1_PORTADO) 
		AADD(aVlPtDia,  TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT)
	EndIf		

	If Ascan(aPortTot,TE1->E1_PORTADO) <> 0
		aVlPtTot[Ascan(aPortTot,TE1->E1_PORTADO)] += TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT
	Else
		AADD(aPortTot,  TE1->E1_PORTADO) 
		AADD(aVlPtTot,  TE1->E1_VALOR+TE1->E1_VALJUR+TE1->E1_MULTA-TE1->E1_DESCONT)
	EndIf		

	DbSelectArea("TE1")
	dbSkip() // Avanca o ponteiro do registro no arquivo
End

ResDia()

Roda(0,"",tamanho)
nLin := Cabec(cTitulo,cCabec1,cCabec2,NomeProg,Tamanho,nTipo)
nLin++

ChecaPag()
@ nlin, 000 Psay "Total Baixados ou Alterados ........................................:"
@ nlin, 092 Psay nValTot Picture "@E 999,999,999.99"
nlin++
ChecaPag()
@ nlin, 000 Psay "Total em Multas ....................................................:"
@ nlin, 092 Psay nMulTot Picture "@E 999,999,999.99"
nlin++
ChecaPag()
@ nlin, 000 Psay "Total em Juros .....................................................:"
@ nlin, 092 Psay nJurTot Picture "@E 999,999,999.99"
nlin++
@ nlin, 000 Psay "Total Descontos ....................................................:"
@ nlin, 092 Psay nDesTot Picture "@E 999,999,999.99"
nlin++
ChecaPag()
@ nlin, 000 Psay "Total Liquido ......................................................:"
@ nlin, 092 Psay nLiqTot Picture "@E 999,999,999.99"
nlin++
nlin++
ChecaPag()
@ nlin, 000 Psay "Resumo por Naturezas:"
nlin++
@ nlin, 000 Psay Replicate("-",106)
nlin++
ChecaPag()
@ nlin, 000 PSay "Original"
@ nlin, 101 PSay "Valor"
nlin++
@ nlin, 000 Psay Replicate("-",106)
nlin++
ChecaPag()

For nC := 1 to Len(aNatTot)
	@ nlin, 000 PSay aNatTot[nC] Picture "@!"
	@ nlin, 011 Psay ".........................................................:"
	@ nlin, 092 Psay aVlNtTot[nC] Picture "@E 999,999,999.99"
	nlin++
	ChecaPag()
Next nC
nlin += 2

@ nlin, 000 PSay "Por Baixa"
@ nlin, 101 PSay "Valor"
nlin++
@ nlin, 000 Psay Replicate("-",106)
nlin++
ChecaPag()

For nC := 1 to Len(aNtBxTot)
	@ nlin, 000 PSay aNtBxTot[nC] Picture "@!"
	@ nlin, 011 Psay ".........................................................:"
	@ nlin, 092 Psay aVNBxTot[nC] Picture "@E 999,999,999.99"
	nlin++
	ChecaPag()
Next nC

nlin += 2
@ nlin, 000 PSay "Por Portador"
@ nlin, 101 PSay "Valor"
nlin++
@ nlin, 000 Psay Replicate("-",106)
nlin++
ChecaPag()

For nC := 1 to Len(aPortTot)
	@ nlin, 000 PSay aPortTot[nC] Picture "@!"
	@ nlin, 011 Psay ".........................................................:"
	@ nlin, 092 Psay aVlPtTot[nC] Picture "@E 999,999,999.99"
	nlin++
	ChecaPag()
Next nC

Roda(0,"",tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

Static Function ChecaPag()

If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	Roda(0,"",tamanho)
	nLin := Cabec(cTitulo,cCabec1,cCabec2,NomeProg,Tamanho,nTipo)
	nLin++
Endif

Return

Static Function ResDia()

nlin ++

ChecaPag()

@ nlin, 000 Psay "Total Baixados ou Alterados nesta data..............................:"
@ nlin, 092 Psay nValDia Picture "@E 999,999,999.99"
nlin++
ChecaPag()
@ nlin, 000 Psay "Total em Multas nesta data..........................................:"
@ nlin, 092 Psay nMulDia Picture "@E 999,999,999.99"
nlin++
ChecaPag()
@ nlin, 000 Psay "Total em Juros nesta data...........................................:"
@ nlin, 092 Psay nJurDia Picture "@E 999,999,999.99"
nlin++
ChecaPag()
@ nlin, 000 Psay "Total Descontos nesta data..........................................:"
@ nlin, 092 Psay nDesDia Picture "@E 999,999,999.99"
nlin++
ChecaPag()
@ nlin, 000 Psay "Total Liquido nesta data............................................:"
@ nlin, 092 Psay nLiqDia Picture "@E 999,999,999.99"
nlin++
nlin++
ChecaPag()
@ nlin, 000 Psay "Resumo por Naturezas:"
nlin++
@ nlin, 000 Psay Replicate("-",106)
nlin++
ChecaPag()
@ nlin, 000 PSay "Original"
@ nlin, 101 PSay "Valor"
nlin++
@ nlin, 000 Psay Replicate("-",106)
nlin++
ChecaPag()

For nC := 1 to Len(aNatDia)
	@ nlin, 000 PSay aNatDia[nC] Picture "@!"
	@ nlin, 011 Psay ".........................................................:"
	@ nlin, 092 Psay aVlNtDia[nC] Picture "@E 999,999,999.99"
	nlin++
	ChecaPag()
Next nC
nlin += 2
@ nlin, 000 PSay "Por Baixa"
@ nlin, 101 PSay "Valor"
nlin++
@ nlin, 000 Psay Replicate("-",106)
nlin++
ChecaPag()

For nC := 1 to Len(aNtBxDia)
	@ nlin, 000 PSay aNtBxDia[nC] Picture "@!"
	@ nlin, 011 Psay ".........................................................:"
	@ nlin, 092 Psay aVNBxDia[nC] Picture "@E 999,999,999.99"
	nlin++
	ChecaPag()
Next nC

@ nlin, 000 Psay Replicate("-",106)
ChecaPag()

nlin += 2
@ nlin, 000 PSay "Por Portador"
@ nlin, 101 PSay "Valor"
nlin++
@ nlin, 000 Psay Replicate("-",106)
nlin++
ChecaPag()

For nC := 1 to Len(aPortDia)
	@ nlin, 000 PSay aPortDia[nC] Picture "@!"
	@ nlin, 011 Psay ".........................................................:"
	@ nlin, 092 Psay aVlPtDia[nC] Picture "@E 999,999,999.99"
	nlin++
	ChecaPag()
Next nC
@ nlin, 000 Psay Replicate("-",106)
ChecaPag()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Zera variaveis³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nValDia  := 0
nMulDia  := 0
nJurDia  := 0
nLiqDia  := 0
nDesDia  := 0
aNatDia  := {}
aVlNtDia := {}
aVNBxDia := {}
aNtBxDIa := {}
aPortDia := {}
aVlPtDia := {}

Return