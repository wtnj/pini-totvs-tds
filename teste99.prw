#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT040   ³Autor: Valdir Diocleciano     ³ Data:   25/09/02 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Atualizacao de comissoes a pagar - Cartao de Credito       ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat108()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CTITULO,")
SetPrvt("XCABEC2,NCARACTER,ARETURN,SERNF,CPROGRAMA,CPERG")
SetPrvt("NLASTKEY,M_PAG,LCONTINUA,WNREL,L,CBTXT")
SetPrvt("CBCONT,NORDEM,ALFA,Z,M,TAMANHO,mRegiao")
SetPrvt("CDESC2,CDESC3,TREGS,M_MULT,P_ANT")
SetPrvt("P_ATU,P_CNT,M_SAV20,M_SAV7,MVEND,MEMISSN")
SetPrvt("MNOMEVEND,MREGIAO,MEQUIPE,MVALTOT,MVALCOM,MVALBASE")
SetPrvt("MPREFIXO,MNUM,MPARCELA,MCODCLI,MLOJA,MVBASE")
SetPrvt("MPEDIDO,MVLRBASE,MPORC,MCOMIS,MTIPO,MSTATUS,MSTATUS1")
SetPrvt("MEMISSAO,MVENCTO,MBAIXA,MNOMECLI,MCALCCOM,MCALCFGTS")
SetPrvt("MCALCDSR,MTOTALCOM,mValor,mVend1,mVlcomi,mDtbx,mPedido1,mPedido2")
SetPrvt("mDtmov,mPccomi,mTipoop,mEstorno,mParcela1,mSerie,mData1")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Data de                              ³
//³ mv_par02             // Data At‚                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cPerg     := "FAT025"

If !Pergunte(cPerg)
	Return
Endif

Processa({|| P039Proc()})

Static Function P039Proc()
mVlcomi  := 0
dbselectarea("SA3")
dbsetorder(1)
dbSelectArea("SE1")
dbSetOrder(16)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Prepara regua de impressÆo                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSeek(xFILIAL("SE1")+'        '+DTOS(MV_PAR01+30),.t.)
ProcRegua(RecCount())

While (DTOS(SE1->E1_VENCREA-30) >= DTOS(MV_PAR01) .AND. DTOS(SE1->E1_VENCREA-30) <= DTOS(MV_PAR02))
	IncProc("Titulo: "+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)
	
	dbSelectArea("SE3")
	dbSetOrder(2)
	If dbSeek(xFILIAL("SE3")+SE1->E1_VEND1+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA,.t.)
		DBSELECTAREA("SE1")
		DBSKIP()
		LOOP
	ENDIF       

// 27/11 inicio	
/*	                            
	IF SE1->E1_PARCELA # "A" .AND. SE1->E1_PARCELA # " "
		DBSELECTAREA("SE1")
		DBSKIP()
		LOOP
	ENDIF
*/	             
// 27/11 fim

	IncProc("Titulo: "+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)
	
	mEstorno:=" "
	dbSelectArea("SZ9")
	DBSETORDER(1)
	dbSeek(xFILIAL()+SE1->E1_TIPOOP)
	
	IF FOUND() .AND. Z9_DEBITA == "S"
		
		dbSelectArea("ZZN")
		DBSETORDER(1)
		
		If SE1->E1_VEND1 # SPACE(6)
			
			dbSelectArea("SA3")
			IF dbSeek(xFILIAL("SA3")+SE1->E1_VEND1)
				mRegiao := SA3->A3_REGIAO
			ELSE
				mRegiao := ""
			ENDIF
			
			dbSelectArea("ZZN")
			IF dbSeek(xFILIAL("ZZN")+SE1->E1_VEND1+SE1->E1_PEDIDO+SE1->E1_PARCELA+SE1->E1_SERIE,.T.)
				IF ZZN->ZZN_ESTORN # "S"
					IF SE1->E1_VALOR # ZZN->ZZN_VALOR .OR. SE1->E1_EMISSAO # ZZN->ZZN_EMISSA;
						.OR. SE1->E1_VENCTO # ZZN->ZZN_VENCTO .OR. SE1->E1_PREFIXO # ZZN_PREFIX
						//mVlcomi  := ZZN_VLCOMI * (-1)
						//mValor   := ZZN->ZZN_VALOR * (-1)
						Estorna()
						
						dbSelectArea("SC6")
						IF dbSeek(xFILIAL("SC6")+SE1->E1_PEDIDO)
							// mVlcomi  := SC6->C6_VALOR * (SC6->C6_COMIS1 / 100)
							mVlcomi  := SE1->E1_VALOR * (SC6->C6_COMIS1 / 100)
						ENDIF
						
						mPccomi  := SC6->C6_COMIS1
						mValor   := SE1->E1_VALOR
						mVend1   := SE1->E1_VEND1
						mPedido1 := SE1->E1_PEDIDO
						mDtbx    := SE1->E1_BAIXA
						Grava()
					ENDIF
				ENDIF
			Else
				dbSelectArea("SC6")
				IF dbSeek(xFILIAL("SC6")+SE1->E1_PEDIDO)
					mVlcomi  := SE1->E1_VALOR * (SC6->C6_COMIS1 / 100)
				ENDIF
				mPccomi  := SC6->C6_COMIS1
				mValor   := SE1->E1_VALOR
				mVend1   := SE1->E1_VEND1
				mPedido1 := SE1->E1_PEDIDO
				mDtbx    := SE1->E1_BAIXA
				Grava()
			Endif
			
		If SE1->E1_VEND2 # SPACE(6)
			
			dbSelectArea("SA3")
			IF dbSeek(xFILIAL("SA3")+SE1->E1_VEND2)
				mRegiao := SA3->A3_REGIAO
			ELSE
				mRegiao := ""
			ENDIF
			
			dbSelectArea("ZZN")
			IF dbSeek(xFILIAL("ZZN")+SE1->E1_VEND2+SE1->E1_PEDIDO,.T.)
				IF ZZN->ZZN_ESTORN # "S"
					IF SE1->E1_VALOR # ZZN->ZZN_VALOR .OR. SE1->E1_EMISSAO # ZZN->ZZN_EMISSA;
						.OR. SE1->E1_VENCTO # ZZN->ZZN_VENCTO .OR. SE1->E1_PREFIXO # ZZN_PREFIX
						//mVlcomi  := ZZN_VLCOMI * (-1)
						//mValor   := ZZN->ZZN_VALOR * (-1)
						Estorna()
						dbSelectArea("SC6")
						mVlcomi  := SE1->E1_VALOR * (SC6->C6_COMIS2 / 100)
						mPccomi  := SC6->C6_COMIS2
						mValor   := SE1->E1_VALOR
						mVend1   := SE1->E1_VEND2
						mPedido1 := SE1->E1_PEDIDO
						mDtbx    := SE1->E1_BAIXA
						Grava()
					ENDIF
				ENDIF
			Else
				dbSelectArea("SC6")
				mVlcomi  := SE1->E1_VALOR * (SC6->C6_COMIS2 / 100)
				mPccomi  := SC6->C6_COMIS2
				mValor   := SE1->E1_VALOR
				mVend1   := SE1->E1_VEND2
				mPedido1 := SE1->E1_PEDIDO
				mDtbx    := SE1->E1_BAIXA
				Grava()
			Endif
		Endif
		
		If SE1->E1_VEND3 # SPACE(6)
			
			dbSelectArea("SA3")
			IF dbSeek(xFILIAL("SA3")+SE1->E1_VEND3)
				mRegiao := SA3->A3_REGIAO
			ELSE
				mRegiao := ""
			ENDIF
			
			dbSelectArea("ZZN")
			IF dbSeek(xFILIAL("ZZN")+SE1->E1_VEND3+SE1->E1_PEDIDO,.T.)
				IF ZZN->ZZN_ESTORN # "S"
					IF SE1->E1_VALOR # ZZN->ZZN_VALOR .OR. SE1->E1_EMISSAO # ZZN->ZZN_EMISSA;
						.OR. SE1->E1_VENCTO # ZZN->ZZN_VENCTO .OR. SE1->E1_PREFIXO # ZZN_PREFIX
						//mVlcomi  := ZZN_VLCOMI * (-1)
						//mValor   := ZZN->ZZN_VALOR * (-1)
						Estorna()
						dbSelectArea("SC6")
						mVlcomi  := SE1->E1_VALOR * (SC6->C6_COMIS3 / 100)
						mPccomi  := SC6->C6_COMIS3
						mValor   := SE1->E1_VALOR
						mVend1   := SE1->E1_VEND3
						mPedido1 := SE1->E1_PEDIDO
						mDtbx    := SE1->E1_BAIXA
						Grava()
					ENDIF
				ENDIF
			Else
				dbSelectArea("SC6")
				mVlcomi  := SE1->E1_VALOR * (SC6->C6_COMIS3 / 100)
				mPccomi  := SC6->C6_COMIS3
				mValor   := SE1->E1_VALOR
				mVend1   := SE1->E1_VEND3
				mPedido1 := SE1->E1_PEDIDO
				mDtbx    := SE1->E1_BAIXA
				Grava()
			Endif
		Endif
		
		If SE1->E1_VEND4 # SPACE(6)
			
			dbSelectArea("SA3")
			IF dbSeek(xFILIAL("SA3")+SE1->E1_VEND4)
				mRegiao := SA3->A3_REGIAO
			ELSE
				mRegiao := ""
			ENDIF
			
			dbSelectArea("ZZN")
			IF dbSeek(xFILIAL("ZZN")+SE1->E1_VEND4+SE1->E1_PEDIDO,.T.)
				IF ZZN->ZZN_ESTORN # "S"
					IF SE1->E1_VALOR # ZZN->ZZN_VALOR .OR. SE1->E1_EMISSAO # ZZN->ZZN_EMISSA;
						.OR. SE1->E1_VENCTO # ZZN->ZZN_VENCTO .OR. SE1->E1_PREFIXO # ZZN_PREFIX
						//mVlcomi  := ZZN_VLCOMI * (-1)
						//mValor   := ZZN->ZZN_VALOR * (-1)
						Estorna()
						dbSelectArea("SC6")
						mVlcomi  := SE1->E1_VALOR * (SC6->C6_COMIS4 / 100)
						mPccomi  := SC6->C6_COMIS4
						mValor   := SE1->E1_VALOR
						mVend1   := SE1->E1_VEND4
						mPedido1 := SE1->E1_PEDIDO
						mDtbx    := SE1->E1_BAIXA
						Grava()
					ENDIF
				ENDIF
			Else
				dbSelectArea("SC6")
				mVlcomi  := SE1->E1_VALOR * (SC6->C6_COMIS4 / 100)
				mPccomi  := SC6->C6_COMIS4
				mValor   := SE1->E1_VALOR
				mVend1   := SE1->E1_VEND4
				mPedido1 := SE1->E1_PEDIDO
				mDtbx    := SE1->E1_BAIXA
				Grava()
			Endif
		Endif
		
		If SE1->E1_VEND5 # SPACE(6)
			
			dbSelectArea("SA3")
			IF dbSeek(xFILIAL("SA3")+SE1->E1_VEND5)
				mRegiao := SA3->A3_REGIAO
			ELSE
				mRegiao := ""
			ENDIF
			
			dbSelectArea("ZZN")
			IF dbSeek(xFILIAL("ZZN")+SE1->E1_VEND5+SE1->E1_PEDIDO,.T.)
				IF ZZN->ZZN_ESTORN # "S"
					IF SE1->E1_VALOR # ZZN->ZZN_VALOR .OR. SE1->E1_EMISSAO # ZZN->ZZN_EMISSA;
						.OR. SE1->E1_VENCTO # ZZN->ZZN_VENCTO .OR. SE1->E1_PREFIXO # ZZN_PREFIX
						//mVlcomi := ZZN_VLCOMI * (-1)
						//mValor  := ZZN->ZZN_VALOR * (-1)
						Estorna()
						dbSelectArea("SC6")
						mVlcomi  := SE1->E1_VALOR * (SC6->C6_COMIS5 / 100)
						mPccomi  := SC6->C6_COMIS5
						mValor   := SE1->E1_VALOR
						mVend1   := SE1->E1_VEND5
						mPedido1 := SE1->E1_PEDIDO
						mDtbx    := SE1->E1_BAIXA
						Grava()
					Endif
				Endif
			Else
				dbSelectArea("SC6")
				mVlcomi  := SE1->E1_VALOR * (SC6->C6_COMIS5 / 100)
				mPccomi  := SC6->C6_COMIS5
				mValor   := SE1->E1_VALOR
				mVend1   := SE1->E1_VEND5
				mPedido1 := SE1->E1_PEDIDO
				mDtbx    := SE1->E1_BAIXA
				Grava()
			Endif
		Endif
	Endif
	Endif
	
	dbSelectArea("SE1")
	dbskip()
END

Static FUNCTION Grava()
RecLock("ZZN",.T.)
ZZN_FILIAL := XFILIAL("ZZN")
ZZN_VEND   := mVend1
ZZN_VLCOMI := mVlcomi
ZZN_DTBX   := mDtbx
ZZN_PEDIDO := mPedido1
ZZN_DTMOV  := SE1->E1_DTALT
ZZN_VALOR  := mValor
ZZN_PCCOMI := mPccomi
ZZN_TIPOOP := SE1->E1_TIPOOP
ZZN_ESTORN := " "
ZZN_PARCEL := SE1->E1_PARCELA
ZZN_SERIE  := SE1->E1_SERIE
ZZN_SITUAC := " "
ZZN_EMISSA := SE1->E1_EMISSAO
ZZN_VENCTO := SE1->E1_VENCTO
ZZN_LOJA   := SE1->E1_LOJA
ZZN_TIPO   := SE1->E1_TIPO
ZZN_PREFIX := SE1->E1_PREFIXO
ZZN_NUM    := SE1->E1_NUM
ZZN_CODCLI := SE1->E1_CLIENTE
ZZN_REGIAO := mRegiao  
ZZN_DATA   := dDatabase  
MsUnlock()
Return

Static FUNCTION Estorna()
IF ZZN_ESTORN # "S"
	RecLock("ZZN",.F.)
	//	ZZN_VLCOMI := mVlcomi
	//	ZZN_VALOR  := mValor
	ZZN_ESTORN := "S"
	MsUnlock()
ENDIF
Return
