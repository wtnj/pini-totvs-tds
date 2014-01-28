#include "rwmake.ch"
/*/
Alterado por Danilo C S Pala em 20120820: Comentar alteracao de e1_comis1 =1 (Cidinha)
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: SACI008   ³Autor: Rosane Lacava Rodrigues³ Data:   24/11/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Ponto de Entrada - Baixa do Contas a Receber - Desconto de ³ ±±
±±³           20 % na publicidade para as transacoes 5 e 13 nas comissoes³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Saci008()
Local cNatBx
SetPrvt("_CALIAS,_NINDEX,_NREG,_NINDSE1,_NREGSE1,_NINDSE3")
SetPrvt("_NREGSE3,MTPTRANS,MPEDIDO,MHIST,MPREFIXO,MNUM")
SetPrvt("MPARCELA,MSERIE,MTIPOOP,MQTDEP,MQTDEEX,MQTDEPG")
SetPrvt("MMESCIRC,MREVISTA,_MEXADIC,_EDINIC,_EDFIN,_EDVENC")
SetPrvt("_EDSUSP,_CCHAVESE5,_CCHAVESE1,_CMSG,")
Private oDlgNat


aArea := GetArea()

dbSelectArea("SE1")
aAreaSE1 := GetArea()

dBselectArea("SE5")
aAreaSE5 := GetArea()

dbSelectArea("SE3")
aAreaSE3 := GetArea()
/*
cNatBx := Space(10)

@ 315, 310 to 405, 650 Dialog oDlgNat Title OemToAnsi("Informe Natureza de Baixa")
@ 010, 010 Say OemToAnsi("Nat Baixa?") Size 50,10
@ 010, 065 Get cNatBx Size 50,10 F3("Z5")
@ 025, 120 BmpButton Type 1 Action Close(oDlgNat)
Activate Dialog oDlgNat Centered
*/
DbSelectArea("SE1")
RECLOCK("SE1",.f.)
SE1->E1_DTALT  := dDataBase
SE1->E1_MOTIVO := SE5->E5_MOTBX
SE1->E1_HISTBX := TRIM(SE5->E5_HISTOR)+' ' +SE1->E1_CONTA
SE1->E1_HIST   := TRIM(SE5->E5_HISTOR)+' ' +SE1->E1_CONTA
//SE1->E1_NATBX  := cNatBx                                   // Grava Natureza na Baixa 
MsUnlock()


IF SUBS(SE1->E1_MOTIVO,1,3)=='CAN'
	DBSELECTAREA("SZI")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SZI")+SE1->E1_NUM+SE1->E1_SERIE)
	IF FOUND()
		RETURN
	ENDIF
	// POSICIONA NO SF2 E SD2  PARA ACHAR O VALOR TOTAL DA NF
	DBSELECTAREA("SF2")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SF2")+SE1->E1_NUM+SE1->E1_SERIE+SE1->E1_CLIENTE)
	DBSELECTAREA("SD2")
	DBSETORDER(3)
	DBSEEK(XFILIAL("SD2")+SE1->E1_NUM+SE1->E1_SERIE+SE1->E1_CLIENTE)
	
	DBSELECTAREA("SZI")
	RECLOCK("SZI",.T.)
	SZI->ZI_FILIAL  := SE1->E1_FILIAL
	SZI->ZI_NFISCAL := SE1->E1_NUM
	SZI->ZI_EMISSAO := SE1->E1_EMISSAO
	SZI->ZI_CODCLI  := SE1->E1_CLIENTE
	SZI->ZI_PEDIDO  := SE1->E1_PEDIDO
	SZI->ZI_DTCANC  := SE1->E1_BAIXA
	SZI->ZI_MOTIVO  := SE1->E1_HISTBX
	SZI->ZI_VALORNF := SF2->F2_VALBRUT
	SZI->ZI_TES     := SD2->D2_TES
	SZI->ZI_NATOPER := ALLTRIM(SD2->D2_CF)
	SZI->ZI_CODVEND := SE1->E1_VEND1
	SZI->ZI_SERIE   := SE1->E1_SERIE
	MSUNLOCK()
ENDIF


IF SE1->E1_PEDIDO # SPACE(06) .AND. SUBS(SE1->E1_PEDIDO,1,6) == 'P'
	MTPTRANS := ' '
	MPEDIDO  := SE1->E1_PEDIDO
	DBSELECTAREA("SC5")
	DBSETORDER(1)
	If DBSEEK(XFILIAL("SC5")+MPEDIDO, .F.)
		MTPTRANS := SC5->C5_TPTRANS
	ENDIF
	DBSELECTAREA("SE1")
	RECLOCK("SE1",.F.)
	SE1->E1_FATPREF := MTPTRANS
	MSUNLOCK()
ENDIF

IF SE1->E1_FATPREF == '05 ' .OR. SE1->E1_FATPREF == '13 '
	DBSELECTAREA("SE3")
	RECLOCK("SE3",.F.)
	SE3->E3_BASE := (SE1->E1_BASCOM1 - (SE1->E1_BASCOM1 * 0.20))
	//SE3->E3_PORC := 1 //20120820
	SE3->E3_COMIS:= (SE3->E3_BASE * (SE3->E3_PORC/100)) //SE3->E3_COMIS:= (SE3->E3_BASE * 0.01)//20120820
	MSUNLOCK()
ENDIF

IF VAL(SE1->E1_PORTADO)<900 .AND. VAL(SE1->E1_PORTADO)#0
	MHIST  := 'COBR DIRETA '+LTRIM(SA6->A6_NREDUZ)
	RECLOCK("SE1",.F.)
	SE1->E1_HIST  := MHIST
	MSUNLOCK()
	
	RECLOCK("SE5",.F.)
	SE5->E5_HISTOR := MHIST
	MSUNLOCK()
ENDIF

IF SUBS(SE1->E1_MOTIVO,1,2)=='LP'
	RECLOCK("SE1",.F.)
	SE1->E1_HIST   := 'LUCROS E PERDAS'
	SE1->E1_HISTBX := 'LUCROS E PERDAS'
	MSUNLOCK()
ENDIF

IF SE1->E1_SERIE $ 'CP0/LIV'
	MPREFIXO := SE1->E1_PREFIXO
	MNUM     := SE1->E1_NUM
	MPARCELA := SE1->E1_PARCELA
	MSERIE   := SE1->E1_SERIE
	
	DBSELECTAREA("SE3")
	DBSETORDER(1)
	IF DBSEEK(XFILIAL("SE3")+MPREFIXO+MNUM+MPARCELA)
		WHILE MNUM == SE3->E3_NUM .AND. SE3->E3_PARCELA == MPARCELA .AND. !EOF()
			RECLOCK("SE3",.F.)
			DbDelete()
			MSUNLOCK()
			DbSelectArea("SE3")
			DBSKIP()
		END
	ENDIF
	
	DBSELECTAREA("SE1")
	DBSETORDER(1)
	WHILE SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_NUM == MNUM .AND. !EOF()
		IF SE1->E1_PARCELA == MPARCELA
			DBSKIP()
			LOOP
		ENDIF
		IF SE1->E1_SERIE # MSERIE
			DBSKIP()
			LOOP
		ENDIF
		IF SE1->E1_PARCELA == 'B' .OR. SE1->E1_PARCELA == 'C'
			RECLOCK("SE1",.f.)
			SE1->E1_HIST   := 'FAT P/SERIE UNICA'
			SE1->E1_HISTBX := 'FAT P/SERIE UNICA'
			MSUNLOCK()
		ENDIF
		DBSELECTAREA("SE1")
		DBSKIP()
	END
ELSEIF SE1->E1_SERIE == 'UNI'
	MSERIE := 'ASS'
	DBSELECTAREA("SE3")
	DBSETORDER(5)
	DBSEEK(XFILIAL("SE3")+SE1->E1_PEDIDO+MSERIE+SE1->E1_PARCELA)
	IF FOUND()
		DBSEEK(XFILIAL("SE1")+SE1->E1_PEDIDO+SE1->E1_SERIE+SE1->E1_PARCELA)
		IF FOUND()
			WHILE SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_PEDIDO == SE3->E3_PEDIDO .AND. SE1->E1_SERIE == SE3->E3_SERIE .AND. ;
				SE1->E1_PARCELA == SE3->E3_PARCELA
				RECLOCK("SE3",.F.)
				DBDELETE()
				MSUNLOCK()
				DBSELECTAREA("SE3")
				DBSKIP()
			END
		ENDIF
	ENDIF
ENDIF

/* Desabilitado por Raquel em 27/11/02
//** tratamento dos titulos pagos - assinatura - para ajustar edicao de suspensao
//** 18/12/01 - solange

IF SUBS(SE1->E1_MOTIVO,1,3) == 'NOR'
	DBSELECTAREA("SC5")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SC5")+SE1->E1_PEDIDO)
	
	MTIPOOP := SC5->C5_TIPOOP
	
	DBSELECTAREA("SZ9")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SZ9")+MTIPOOP)
	IF FOUND()
		MQTDEP := SZ9->Z9_QTDEP
	ELSE
		MQTDEP := 0
	ENDIF
	
	DBSELECTAREA("SC6")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SC6")+SE1->E1_PEDIDO)
	WHILE SC6->C6_NUM == SE1->E1_PEDIDO
		IF SUBS(SC6->C6_PRODUTO,1,2)#'01'.AND. SUBS(SC6->C6_PRODUTO,1,2)#'10'.AND. SUBS(SC6->C6_PRODUTO,1,4)#'1105'
			DbSelectArea("SC6")
			DBSKIP()
			LOOP
		ENDIF
		
		DBSELECTAREA("SF4")
		DBSETORDER(1)
		DBSEEK(XFILIAL("SF4")+SC6->C6_TES)
		IF SF4->F4_DUPLIC=='N'
			DbSelectArea("SC6")
			DBSKIP()
			LOOP
		ENDIF

		DBSELECTAREA("SB1")
		DBSEEK(XFILIAL("SB1")+SC6->C6_PRODUTO)
		MQTDEEX  := SB1->B1_QTDEEX
		MQTDEPG  := (MQTDEEX/MQTDEP)-1
		MMESCIRC := Substr(DTOS(ddatabase),1,6)    //STR(MONTH(ddatabase),2,0)+'/'+STR(YEAR(ddatabase),4,0)
		MREVISTA := SUBS(SC6->C6_PRODUTO,1,4)
		_MEXADIC := 0
		
		DBSELECTAREA("SZJ")
		DBSETORDER(6)
		DBSEEK(XFILIAL("SZJ")+MREVISTA+MMESCIRC)
		IF SC6->C6_EDINIC == SC6->C6_EDSUSP
			IF SC6->C6_EDINIC <= SZJ->ZJ_EDICAO
				_EDINIC  := SZJ->ZJ_EDICAO
				_EDFIN   := _EDINIC+MQTDEEX - 1
				_EDVENC  := _EDINIC+MQTDEEX - 1
				_EDSUSP  := _EDINIC+MQTDEPG - 1
			ELSE
				_EDINIC  := SC6->C6_EDINIC
				_EDFIN   := SC6->C6_EDFIN
				_EDVENC  := SC6->C6_EDVENC
				_EDSUSP  := SC6->C6_EDSUSP+MQTDEPG - 1
			ENDIF
		ELSE
			IF SZJ->ZJ_EDICAO <= SC6->C6_EDSUSP
				_EDINIC  := SC6->C6_EDINIC
				_EDFIN   := SC6->C6_EDFIN
				_EDVENC  := SC6->C6_EDVENC
				_EDSUSP  := SC6->C6_EDSUSP+MQTDEPG - 1
			ELSE
				_EDINIC  := SC6->C6_EDINIC
				_EDFIN   := SC6->C6_EDFIN
				_MEXADIC := SZJ->ZJ_EDICAO - SC6->C6_EDSUSP - 1
				_EDVENC  := SC6->C6_EDVENC+_MEXADIC
				_EDSUSP  := SC6->C6_EDSUSP+_MEXADIC+MQTDEPG - 1
			ENDIF
		ENDIF
		DBSELECTAREA("SC6")
		RECLOCK("SC6",.f.)
		SC6->C6_EDINIC := _EDINIC
		SC6->C6_EDFIN  := _EDFIN
		SC6->C6_EXADIC := _MEXADIC
		SC6->C6_EDVENC := _EDVENC
		SC6->C6_EDSUSP := _EDSUSP
		MSUNLOCK()
		DBSELECTAREA("SC6")
		DBSKIP()
	END
ENDIF
*/

RestArea(aAreaSE1)

RestArea(aAreaSE5)

RestArea(aAreaSE3)

RestArea(aArea)

//****
//**** GILBERTO - 09.01.2001 :  Para tentar "PEGAR" o que causa diferenca nas
//****                          entre SE1 e SE5 nas baixas a receber...
//****

_cChaveSE5:= SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_CLIFOR
_cChaveSE1:= SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_CLIENTE

If _cChaveSE5 <> _cChaveSE1
	_cMsg:= "Atencao : BAIXA DA BAIXA NAO CORRESPONDE AO TITULO NO FINANCEIRO !!"
	_cMsg:= _cMsg + " Favor entrar em contato com o Departamento de Informatica.."
	MsgAlert( OemToAnsi(_cMsg) )
EndIf

RETURN