#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT019   ³Autor: Solange Nalini         ³ Data:   15/06/98 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Em 12/11/98 criei os campos C5_DESPREM,F2_DESPREM para que as despe-  ³ ±±
±±³sas de remessa possam entrar nas notas sem ser consideradas na base   ³ ±±
±±³de calculo da comissao.                                               ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Esta rotina acerta os vencimentos no SE1,de acordo com o   ³ ±±
±±³Arquivo de pedidos, calcula os vencimentos para as parcelas 5 e 6     ³ ±±
±±³Programa os pagtos a vista, pr‚-datados e cartÆo de cr‚dito.          ³ ±±
±±³Baixa os pedidos no arquivo de controle de pedidos.                   ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Campos criados   E1_PGPROG, C5_PARC5,C5_VENC5,C5_PARC6,C5_VENC6       ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso : M¢dulo de Faturamento                                           ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat019()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,PREFIX")
SetPrvt("MDUPL,MPEDIDO,MSERIE,MLOTEFAT,MDATA,XCLIENTE")
SetPrvt("MCLIENTE,MTIPOOP,MVAL1,MPROD,MGRUPO,MITEM")
SetPrvt("MPEDANT,MITEMANT,NREGATUA,MEDIN,MCODCLI,MCODDEST")
SetPrvt("MITEMANT2,MPROGPA1,MPROGPAD,MNATUREZ,MEMISSAO,MPROGPAG")
SetPrvt("MVENCTO,MVENCREA,MVALOR,TREGS,M_MULT,P_ANT")
SetPrvt("P_ATU,P_CNT,M_SAV20,M_SAV7,")
Private lEnd
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             Da Nota                                 ³
//³ mv_par02             At‚ a Nota                              ³
//³ mv_par03             Serie									 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPERG    := "FAT004"

If !Pergunte(cPerg)
	Return
Endif

Prefix   := MV_PAR03

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Desenha tela padrao do Siga                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//DrawAdvWin(" ** AJUSTE DE VENCIMENTOS **     " , 8, 0, 12, 75 )

lEnd := .f.

Processa({|lEnd| P019Proc(@lEnd)},"Ajustando Vencimentos", "Processando",.t.)

Return

Static Function P019Proc()

Local nRegs := Abs(val(mv_par02)-val(mv_par01)+1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Localiza as notas no SE1 - Pela nota, pega a duplicata,serie e pedido  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectarea("SE1")
//set softseek on
dbSetOrder(1)
dbSeek(xFilial("SE1")+Prefix+mv_par01,.t.)
ProcRegua(nRegs)
While SE1->E1_NUM >= mv_par01 .and. SE1->E1_NUM <= mv_par02 .and. !lEnd
	
	IncProc("Nota: "+SE1->E1_PREFIXO+SE1->E1_NUM)
	
	IF SUBS(SE1->E1_PEDIDO,6,1) == 'P' .OR. SE1->E1_SERIE # MV_PAR03
		DBSKIP()
		LOOP
	ENDIF
	
	IF !Empty(SE1->E1_BAIXA)  //DTOC(SE1->E1_BAIXA) # ' '
		DBSKIP()
		LOOP
	ENDIF
	
	mDUPL   := SE1->E1_NUM
	mPEDIDO := SE1->E1_PEDIDO
	MSERIE  := SE1->E1_SERIE
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura no Arq de Pedidos e verifica se o clifat e #do cliente       ³
	//³ Pega os valores das parcelas pela cond 201                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SC5")
	dbSetOrder(1)
	If dbSeek(xFilial("SC5")+mPedido)
		MLOTEFAT := SC5->C5_LOTEFAT
		MDATA    := SC5->C5_DATA
		MSERIE   := SC5->C5_SERIE
		XCLIENTE := SC5->C5_CLIENTE
		IF VAL(C5_CLIFAT)#0 .OR. C5_CLIFAT#SPACE(6)
			mCLIENTE := SC5->C5_CLIFAT
		ELSE
			mcliente := SC5->C5_CLIENTE
		ENDIF
		mTIPOOP  := SC5->C5_TIPOOP
		mVAL1:=SC5->C5_PARC1
	Endif
	
	DBSELECTAREA("SC6")
	DBSETORDER(1)
	If dbseek(xfilial("SC6")+mpedido)
		mprod := SC6->C6_PRODUTO
	Else
		mprod := '  '
	Endif
	DBSELECTAREA("SB1")
	DBSETORDER(1)
	If DBSEEK(XFILIAL("SB1")+MPROD)
		mgrupo := SB1->B1_GRUPO
	else
		mgrupo := ' '
	endif
	
	DBSELECTAREA("SC6")
	DBSETORDER(1)
	IF !EMPTY(SC6->C6_PEDANT)
		MITEM     :=  SC6-> C6_ITEM
		MPEDANT   :=  SC6-> C6_PEDANT
		MITEMANT  :=  SC6-> C6_ITEMANT
		NREGATUA  :=  RECNO()
		MPROD     :=  SUBS(SC6->C6_PRODUTO,1,4)
		MEDIN     :=  SC6->C6_EDINIC
		MCODCLI   :=  SC6->C6_CLI
		MCODDEST  :=  SC6->C6_CODDEST
		MITEMANT2 :=  "  "
		/*/
		DESABILITADO POR RAQUEL EM 29/08/2000. ANTES DA ATUALIZACAO DE VERSAO
		A ROTINA ESTAVA ATUALIZANDO O PEDIDO ORIGEM AO INVES DO PEDIDO ANTERIOR.
		RODEI PROGRAMA PARA ACERTAR OS PEDIDOS QUE FORAM ATUALIZADOS INDEVIDAMENTE.
		APOS ATUALIZACAO O INDICE EQUIVALENTE E O 12.
		
		DBSETORDER(11)
		DBSEEK(XFILIAL()+MPEDANT+MITEMANT)
		IF FOUND()
			RECLOCK("SC6",.F.)
			REPLA C6_PEDREN WITH MPEDIDO
			REPLA C6_ITEMREN WITH MITEM
			DBUNLOCK()
		ENDIF
		/*/
		
		DBSETORDER(1)
		//DBGOTOP()
		DBSEEK(XFILIAL("SC6")+MPEDANT+MITEMANT)
		IF FOUND() .AND. SC6->C6_EDFIN <> 0 .AND. SUBS(STR(SC6->C6_EDFIN,4),1,2)<>'99';
			.AND. SUBS(SC6->C6_PRODUTO,1,4) == MPROD .AND. MEDIN >= SC6->C6_EDVENC
			RECLOCK("SC6",.F.)
			SC6->C6_PEDREN  := MPEDIDO
			SC6->C6_ITEMREN := MITEM
			MSUNLOCK()
		ELSE
			DBSETORDER(1)
			//DBGOTOP()
			DBSEEK(XFILIAL("SC6")+MPEDANT)
			IF FOUND()
				WHILE !Eof() .and. SC6->C6_NUM == MPEDANT
					IF SC6->C6_EDFIN <> 0 .AND. SUBS(STR(SC6->C6_EDFIN,4),1,2)<>'99';
						.AND. SUBS(SC6->C6_PRODUTO,1,4) == MPROD .AND. MEDIN >= SC6->C6_EDVENC ;
						.AND. SC6->C6_CLI == MCODCLI .AND. SC6->C6_CODDEST == MCODDEST
						RECLOCK("SC6",.F.)
						SC6->C6_PEDREN  := MPEDIDO
						SC6->C6_ITEMREN := MITEM
						MSUNLOCK()
						MITEMANT2 := C6_ITEM
						EXIT
					ELSE
						DBSKIP()
						LOOP
					ENDIF
				END
			ENDIF
		ENDIF
		
		DBSETORDER(1)
		DBGOTO(NREGATUA)
		
		IF C6_ITEMANT == "  " .AND. MITEMANT2 <> "  "
			RECLOCK("SC6",.F.)
			SC6->C6_ITEMANT := MITEMANT2
			MSUNLOCK()
		ENDIF
	ENDIF
	*****
	dbSelectArea("SZ9")
	dbSetOrder(2)
	dbSeek(mTIPOOP)
	If Found()
		mPROGPA1 := Z9_PROGPA1
		mPROGPAD := Z9_PROGPAD
	Endif
	
	dbSelectArea("SE1")
	While SE1->E1_NUM == MDUPL .AND. SE1->E1_PREFIXO == MV_PAR03
		IF trim(SE1->E1_TIPO) <> 'NF' //20090723
			dbSelectArea("SE1")
			DBSKIP()
			LOOP
		ENDIF
		mNATUREZ := SE1->E1_NATUREZ
		mEMISSAO := SE1->E1_EMISSAO
		mPROGPAG := CTOD('  /  /  ')
		mVENCTO  := SE1->E1_VENCTO
		mVENCREA := SE1->E1_VENCREA
		IF SE1->E1_PARCELA=='A' .OR. SE1->E1_PARCELA==' '
			mVALOR:=SC5->C5_PARC1+SC5->C5_DESPREM
		ELSE
			mVALOR   := SE1->E1_VALOR
		ENDIF
		If SE1->E1_VENCTO < SE1->E1_EMISSAO
			mVENCTO := SE1->E1_EMISSAO
		Endif
		
		If SE1->E1_PARCELA =='A' .OR. SE1->E1_PARCELA==' '
			If MPROGPA1 == 'S'
				mPROGPAG := SE1->E1_VENCREA
				mNATUREZ := 'BX'
			EndIf
		EndIf
		
		If SE1->E1_PARCELA#'A' .AND. SE1->E1_PARCELA#' '
			If mPROGPAD == 'S'
				mNATUREZ :='BX'
				mPROGPAG := SE1->E1_VENCREA
			EndIf
		EndIf
		
		//  TIRAR QUANDO A COMISSAO FOR PELA EMISSAO E O CARTAO DE CREDITO FOR
		//  COMISSIONADO PELO PROGRAMA DE ATUALIZACAO DE COMISSAO
		
		IF MTIPOOP=='16 '
			mVENCTO := SE1->E1_EMISSAO
			mVENCREA:= SE1->E1_EMISSAO
			mPROGPAG:= SE1->E1_EMISSAO
			mnaturez:= 'CC'
		ENDIF
		IF SUBS(MTIPOOP,1,1)=='8'
			mnaturez:= 'DB'
		ENDIF
		
		IF MTIPOOP=='C2 '.OR. MTIPOOP=='C3 '.OR. MTIPOOP=='C4 '.OR. MTIPOOP=='C5 '
			mnaturez:= 'CC'
		ENDIF
		
		IF SE1->E1_VENCREA<MVENCTO
			MVENCREA:=MVENCTO
		ENDIF
		
		IF DTOC(SE1->E1_PGPROG)#' ' .AND. SE1->E1_PGPROG<MVENCREA
			MPROGPAG:=MVENCREA
		ENDIF
		** CONDICAO ESPECIAL PARA CURSOS
		IF SC5->C5_CONDPAG=='702'
			IF SE1->E1_PARCELA=='A'
				MVALOR:=300.00
			ELSE
				MVALOR:=200.00
			ENDIF
		ENDIF
		
		RecLock("SE1",.F.)
		Replace E1_VENCTO   with mVENCTO
		Replace E1_VENCREA  with mVENCREA
		Replace E1_PGPROG   with mPROGPAG
		Replace E1_VALOR    with mVALOR
		REPLACE E1_CLIENTE  WITH MCLIENTE
		REPLACE E1_CLIPED   WITH XCLIENTE
		REPLACE E1_VLCRUZ   WITH MVALOR
		REPLACE E1_SALDO    WITH MVALOR
		REPLACE E1_NATUREZ  WITH mNATUREZ
		REPLACE E1_TIPOOP   WITH MTIPOOP
		REPLACE E1_GRPROD   WITH MGRUPO
		SE1->(msUnlock())
		
		IF SE1->E1_PARCELA=='A' .OR. SE1->E1_PARCELA==' '
			dbSELECTAREA("SF2")
			dbSetORDER(1)
			//   dbSEEK(XFILIAL()+MDUPL+MSERIE)
			dbSEEK(XFILIAL("SF2")+MDUPL+SE1->E1_PREFIXO)
			IF FOUND()
				RecLock("SF2",.F.)
				SF2->F2_CLIENTE := MCLIENTE
				SF2->F2_DESPREM := SC5->C5_DESPREM
				SF2->F2_VALBRUT := SF2->F2_VALMERC+SC5->C5_DESPREM
				SF2->F2_PROTOC  := '3'
				SF2->F2_VALFAT  := SF2->F2_VALMERC+SC5->C5_DESPREM
				MsUnlock()
			ENDIF
		ENDIF
		
		dbSELECTAREA("SD2")
		dbSetORDER(3)
		dbSEEK(XFILIAL("SD2")+MDUPL+MSERIE)
		IF FOUND()
			WHILE Alltrim(SD2->D2_DOC) == Alltrim(MDUPL) .AND. Alltrim(SD2->D2_SERIE) == Alltrim(MSERIE)
				RecLock("SD2",.F.)
				SD2->D2_CLIENTE := mCLIENTE
				msUnlock()
				DBSKIP()
			END
			
		ENDIF
		
		dbSELECTAREA("SF3")
		dbSetORDER(5)
		dbSEEK(XFILIAL("SF3")+MSERIE+MDUPL)
		IF FOUND()
			WHILE Alltrim(SF3->F3_NFISCAL) == Alltrim(MDUPL) .AND. Alltrim(SF3->F3_SERIE) == Alltrim(MSERIE)
				RecLock("SF3",.F.)
				SF3->F3_CLIEFOR := mCLIENTE
				msUnlock()
				DBSKIP()
			END
			
		ENDIF
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Baixa(deleta) os pedidos no arquivo de controle de pedidos   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SZD")
		DBSETORDER(1)
		dbSEEK(XFILIAL("SZD")+MPEDIDO)
		IF FOUND()
			RecLock("SZD",.F.)
			SZD->ZD_LOTEFAT := MLOTEFAT
			SZD->ZD_DATA    := MDATA
			SZD->ZD_SITUAC  := 'X'
			DBDELETE()
			MSUNLOCK()
		ENDIF
		
		dbSELECTAREA("SE1")
		
		dbSkip()
	End
End

Return