#INCLUDE "RWMAKE.CH"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: LUCPER    �Autor: SOLANGE NALINI         � Data:  28/04/01  � ��
������������������������������������������������������������������������Ĵ ��
���Descri�ao: Preparacao dos titulos para Lucros e Perdas                � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo Financeiro - Espec�fico PINI                        � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
/*/
//����������������������������������Ŀ
//� MV_PAR01 � Data do Cancelamento: �
//������������������������������������
User Function PFIN015()

Private nCont, nValNF, cSerie, nValTot

cPerg:="FIN001"

If !Pergunte(cPerg)
	Return
Endif

IF Lastkey()==27
	Return
Endif

lEnd := .f.

Processa({|lEnd|PF015Proc(@lEnd)},"Lucros e Perdas","Processando",.t.)

Return

Static Function PF015Proc()

nCont   := 0
nValTot := 0
lAssin  := .f.

DbSelectArea("SE1")
DbSetOrder(6)
DbGoTop()

ProcRegua(RecCount())

While SE1->E1_FILIAL == xFilial("SE1") .and. DTOS(SE1->E1_EMISSAO) <= DTOS(mv_par01) .and. !EOF()
	IncProc("Data: "+TRANSFORM(SE1->E1_EMISSAO,"@E 99/99/99"))
	// Checa condicoes de filtragem
	If SE1->E1_SALDO == 0 .or. Alltrim(SE1->E1_TIPO) <> "NF" .or. !Alltrim(SE1->E1_SERIE)$"ASS/UNI" .or. !Empty(SE1->E1_BAIXA) .or. DTOS(SE1->E1_VENCTO) > DTOS(mv_par01)
		DbSelectArea("SE1")
		DbSkip()
		Loop
	EndIf
	// Reseta checagem de assinatura
	lAssin := .f.
	If SE1->E1_SERIE <> "ASS"
		DbSelectArea("SC6")
		DBSetOrder(1)
		If DbSeek(xFilial("SC6")+SE1->E1_PEDIDO)
			While SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NUM == SE1->E1_PEDIDO
				If Substr(SC6->C6_PRODUTO,1,2) == "01" .and. Substr(SC6->C6_PRODUTO,5,3) <> "001"
					lAssin := .t.
				EndIf
				DbSelectArea("SC6")
				DBSkip()
			End
		EndIf
	Else
		lAssin := .t.
	EndIf	
	DbSelectArea("SF2")
	DbSetOrder(1)
	DbSeek(xfilial("SF2")+SE1->E1_NUM+SE1->E1_SERIE)
	
	nValNF   := SF2->F2_VALBRUT-SF2->F2_DESPREM
	
	DbSelectArea("SE1")
	
	If nValNF <= 5000 .and. lAssin
		nCont++
		IncProc("Atualizando: "+StrZero(nCont,6)+" "+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)
		GravaBaixa(Alltrim(SE1->E1_SERIE))
	Endif
	DBSelectArea("SE1")
	Dbskip()
End

RETURN

Static Function GravaBaixa(cSerie)

Local cNat, cPort, cAgeDep, cConta, cSituac, cNumero, cParcela
Local cClifor, cLoja, cTipo

cNat     := ""
cPort    := ""
cAgeDep  := ""
cConta   := ""
cSituac  := ""

If Alltrim(cSerie)<>"ASS" .and. Alltrim(cSerie)<>"UNI"
	Return
EndIf	

If Alltrim(cSerie) == "ASS"
	cNat    := "CAN"
	cPort   := "CAN"
	cAgeDep := "00000"
	cConta  := "0000000000"
	cSituac := "0"
Else
	cNat    := "LP"
	cPort   := "BLP"
	cAgeDep := "99999"
	cConta  := "9999999999"
	cSituac := "0"	
EndIf

nValTot := SE1->E1_SALDO
cSerie  := SE1->E1_SERIE
cNumero := SE1->E1_NUM
cParcela:= SE1->E1_PARCELA
cClifor := SE1->E1_CLIENTE
cLoja   := SE1->E1_LOJA
cTipo   := SE1->E1_TIPO

DbSelectarea("SE1")
Reclock("SE1",.F.)
SE1->E1_BAIXA   := dDataBase
SE1->E1_DTALT   := dDataBase
SE1->E1_MOTIVO  := IIF(cSerie == "ASS", "CAN", "LP")
SE1->E1_NATUREZ := cNat
SE1->E1_PORTADO := cPort
SE1->E1_AGEDEP  := cAgeDep
SE1->E1_CONTA   := cConta
SE1->E1_SITUACA := cSituac
SE1->E1_SALDO   := 0
SE1->E1_LOTE    := IIF(cSerie == "ASS","CAN","LP")
MsUnlock()

DbSelectArea("SE5")
RecLock("SE5",.t.)
SE5->E5_FILIAL   := xFilial("SE5")
SE5->E5_DATA     := dDataBase
SE5->E5_VALOR    := nValTot
SE5->E5_TIPO     := cTipo
SE5->E5_PREFIXO  := cSerie
SE5->E5_NUMERO   := cNumero
SE5->E5_PARCELA  := cParcela
SE5->E5_CLIFOR   := cClifor
SE5->E5_LOJA     := cLoja
SE5->E5_NATUREZ  := cNat
SE5->E5_BANCO    := cPort
SE5->E5_AGENCIA  := cAgeDep
SE5->E5_CONTA    := cConta
SE5->E5_RECPAG   := "R"
SE5->E5_HISTOR   := IIF(cSerie == "ASS","BAIXA POR CANCELAMENTO","LUCROS E PERDAS")
SE5->E5_TIPODOC  := "VL"
SE5->E5_LOTE     := IIF(cSerie == "ASS","CANC","LP")
SE5->E5_DTDIGIT  := dDataBase
SE5->E5_MOTBX    := IIF(cSerie == "ASS","CAN","LP")
SE5->E5_SEQ      := "01"
SE5->E5_DTDISPO  := dDataBase
MsUnlock()
Return