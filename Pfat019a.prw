#include "rwmake.ch"
/*/ Alterado Por Danilo C S Pala em 20040504, ajuste provisorio para solucionar
os problemas da duplicidade de numeros da serie cup, causada pela manutencao da
impressora bematech: UTILIZACAO DE INDICES MAIS COMPLETOS
//Danilo C S Pala 20060525: DESPESA COM BOLETO
//Danilo C S Pala 20060928: PROCESSAR APENAS 1 VEZ OS SE1      
//Danilo C S Pala 20070302: corrigir natureza para o tipoop 86
//Danilo C S Pala 20081210: natureza bnds
//Danilo C S Pala 20090722: SE1 com imposto de renda
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: PFAT019a  �Autor: Solange Nalini         � Data:   15/06/98 � ��
������������������������������������������������������������������������Ĵ ��
���Em 12/11/98 criei os campos C5_DESPREM,F2_DESPREM para que as despe-  � ��
���sas de remessa possam entrar nas notas sem ser consideradas na base   � ��
���de calculo da comissao.                                               � ��
������������������������������������������������������������������������Ĵ ��
���Descri��o: Esta rotina acerta os vencimentos no SE1,de acordo com o   � ��
���Arquivo de pedidos, calcula os vencimentos para as parcelas 5 e 6     � ��
���Programa os pagtos a vista, pr�-datados e cart�o de cr�dito.          � ��
���Baixa os pedidos no arquivo de controle de pedidos.                   � ��
������������������������������������������������������������������������Ĵ ��
���Campos criados   E1_PGPROG, C5_PARC5,C5_VENC5,C5_PARC6,C5_VENC6       � ��
������������������������������������������������������������������������Ĵ ��
���Uso : M�dulo de Faturamento                                           � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function Pfat019a()

Processa( {||PrF019a() } )

Return(nil)
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: PFAT019a  �Autor: Solange Nalini         � Data:   15/06/98 � ��
������������������������������������������������������������������������Ĵ ��
���Uso : M�dulo de Faturamento                                           � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function Prf019a()

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,PREFIX")
SetPrvt("MDUPL,MPEDIDO,MSERIE,MLOTEFAT,MDATA,XCLIENTE")
SetPrvt("MCLIENTE,MPROD,MTIPOOP,MVAL1,MGRUPO,MITEM")
SetPrvt("MPEDANT,MITEMANT,NREGATUA,MEDIN,MCODCLI,MCODDEST")
SetPrvt("MITEMANT2,MPROGPA1,MPROGPAD,MNATUREZ,MEMISSAO,MPROGPAG")
SetPrvt("MVENCTO,MVENCREA,MVALOR,TREGS,M_MULT,P_ANT")
SetPrvt("P_ATU,P_CNT,M_SAV20,M_SAV7, MDESPBOL, MDESPREM, MQTDPARCELA")
SetPrvt("MCOUNT, MSOMADR, MSOMABOL")

//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01             Da Nota                                 �
//� mv_par02             At� a Nota                              �
//� mv_par03             Serie									 �
//����������������������������������������������������������������
cPERG    := "FAT004"

If !Pergunte(cPerg)
	Return
Endif

Prefix   := MV_PAR03

//�����������������������������������������������������������������������Ŀ
//�Localiza os Itens do SD2 - Pela nota, pega a duplicata,serie e pedido  �
//�������������������������������������������������������������������������
dbSelectarea("SF2")
dbSetOrder(1)
dbSeek(xFilial("SF2")+mv_par01+Prefix,.T.)

ProcRegua(RecCount())

While !Eof() .And. SF2->F2_FILIAL == xFilial("SF2") .and. Val(SF2->F2_DOC)>=val(mv_par01) .and. val(SF2->F2_DOC)<=val(mv_par02)
	
	INCPROC("Aguarde - Lendo Registros....")
	mDUPL    := ""
	mPEDIDO  := ""
	MSERIE   := ""
	MLOTEFAT := ""
	MDATA    := ""
	MSERIE   := ""
	XCLIENTE := ""
	mcliente := ""
	mprod    := ""
	MQTDPARCELA := 0 //20060525 DAQUI
	MDESPREM := 0
	MDESPBOL := 0
	MCOUNT   := 0
	MSOMADR  := 0 //SOMA DAS DESPESAS DE REMESSA 
	MSOMABOL := 0 //20060525         ATE AQUI
	
	dbSelectArea("SD2")
	dbSetOrder(3)
	dbSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA) //20040504
	
	IF SUBS(SD2->D2_PEDIDO,6,1) == 'P' .OR. SD2->D2_SERIE # MV_PAR03
		dbSelectArea("SF2")
		DBSKIP()
		LOOP
	ENDIF
	
	dbSelectArea("SE1")
	dbSetOrder(2)                   //indice 2:   filial+cliente+loja+prefixo+num
	If dbSeek(xFilial("SE1")+SD2->D2_CLIENTE+SD2->D2_LOJA+SD2->D2_SERIE+SD2->D2_DOC) //20040504
		IF DTOC(SE1->E1_BAIXA) # ' '
		    dbSelectArea("SF2")
			DBSKIP()
			LOOP
		ENDIF
	Endif
	
	mDUPL   := SD2->D2_DOC
	mPEDIDO := SD2->D2_PEDIDO
	MSERIE  := SD2->D2_SERIE
	
	//�����������������������������������������������������������������������Ŀ
	//� Procura no Arq de Pedidos e verifica se o clifat e #do cliente       �
	//� Pega os valores das parcelas pela cond 201                            �
	//�������������������������������������������������������������������������
	dbSelectArea("SC5")
	dbSetOrder(1)
	If dbSeek(xFilial()+mPedido)
		MLOTEFAT := SC5->C5_LOTEFAT
		MDATA    := SC5->C5_DATA
		MSERIE   := SC5->C5_SERIE
		XCLIENTE := SC5->C5_CLIENTE
		MDESPREM := SC5->C5_DESPREM //20060525
		IF VAL(C5_CLIFAT) # 0 .OR. SC5->C5_CLIFAT # SPACE(6)
			mCLIENTE := SC5->C5_CLIFAT   
		ELSE
			mcliente := SC5->C5_CLIENTE
		ENDIF
		mTIPOOP  := SC5->C5_TIPOOP
		//  mVAL1:=SC5->C5_PARC1      -- DESPREZAR
	ELSE
		Alert("Pedido nao Encontrado-> "+SF2->F2_DOC)
		dbSelectArea("SF2")
		dbSkip()
		Loop
	endif
	//
	dbselectarea("SC6")
	DBSETORDER(1)
	If dbseek(xfilial()+mpedido)
		mprod := SC6->C6_PRODUTO
	else
		mprod := '  '
	endif
	
	DBSELECTAREA("SB1")
	DBSETORDER(1)
	If DBSEEK(XFILIAL()+MPROD)
		MGRUPO := SB1->B1_GRUPO
	else
		mgrupo := ' '
	endif
	
	DBSELECTAREA("SC6")
	DBSETORDER(1)
	IF !EMPTY(SC6->C6_PEDANT)
		MITEM    :=  SC6-> C6_ITEM
		MPEDANT  :=  SC6-> C6_PEDANT
		MITEMANT :=  SC6-> C6_ITEMANT
		NREGATUA :=  RECNO()       
		       
/*BEGINDOC
//���������������������������������������������������������������������������������������������������������������������Ŀ
//�14/02/03: If inserido por Raquel para viabilizar a renovacao dos pedidos da Au convertidos de Bimestral para Mensal  �
//�����������������������������������������������������������������������������������������������������������������������
ENDDOC*/
		If SUBS(SC6->C6_PRODUTO,1,4)=='0124' .and. DTOS(SC6->C6_DATA)<='20030101'
		   MPROD:='0107'
		Else   
		   MPROD    :=  SUBS(SC6->C6_PRODUTO,1,4)
		Endif
		MEDIN    :=  SC6->C6_EDINIC
		MCODCLI  :=  SC6->C6_CLI
		MCODDEST :=  SC6->C6_CODDEST
		MITEMANT2:=  "  "
		
		DBSETORDER(1)
		DBGOTOP()
		IF DBSEEK(XFILIAL()+MPEDANT+MITEMANT) .AND. SC6->C6_EDFIN <> 0 .AND. SUBS(STR(SC6->C6_EDFIN,4),1,2) <> '99';
			.AND. SUBS(SC6->C6_PRODUTO,1,4) == MPROD .AND. MEDIN >= SC6->C6_EDVENC
			RECLOCK("SC6",.F.)
			Replace SC6->C6_PEDREN  WITH MPEDIDO
			Replace SC6->C6_ITEMREN WITH MITEM
			MSUNLOCK()
		ELSE
			DBSETORDER(1)
			DBGOTOP()
			If DBSEEK(XFILIAL()+MPEDANT)
				WHILE !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NUM == MPEDANT
					IF SC6->C6_EDFIN <> 0 .AND. SUBS(STR(SC6->C6_EDFIN,4),1,2)<>'99';
						.AND. SUBS(SC6->C6_PRODUTO,1,4) == MPROD .AND. MEDIN >= SC6->C6_EDVENC;
						.AND. SC6->C6_CLI == MCODCLI .AND. SC6->C6_CODDEST == MCODDEST
						RECLOCK("SC6",.F.)
						Replace SC6->C6_PEDREN WITH MPEDIDO
						Replace SC6->C6_ITEMREN WITH MITEM
						MSUNLOCK()
						MITEMANT2:=C6_ITEM
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
		IF SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_ITEMANT == "  " .AND. MITEMANT2 <> "  "
			RECLOCK("SC6",.F.)
			Replace SC6->C6_ITEMANT WITH MITEMANT2
			MSUNLOCK()
		ENDIF
	ENDIF
	
	//*****
	
	dbSelectArea("SZ9")
	dbSetOrder(2)
	If dbSeek(mTIPOOP)
		mPROGPA1 := SZ9->Z9_PROGPA1
		mPROGPAD := SZ9->Z9_PROGPAD
		MQTDPARCELA :=  SZ9->Z9_QTDEP
	Endif        
	MCOUNT := 1
	MSOMADR := 0  
	MSOMABOL := 0
	
	dbSelectArea("SE1")
	dbSetOrder(2)                                                                
	dbSeek(xFilial("SE1")+SF2->F2_CLIENTE+SF2->F2_LOJA+SF2->F2_SERIE+SF2->F2_DOC,.T.) //20040504
//	dbSeek(xFilial("SE1")+SF2->F2_SERIE+SF2->F2_DOC,.T.)
	
	While !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_NUM == MDUPL .AND. SE1->E1_PREFIXO == MV_PAR03 //20090722
		IF trim(SE1->E1_TIPO) <> 'NF' //20090722
			dbSelectArea("SE1")
			DBSKIP()
			LOOP
		ENDIF

		IF DTOC(SE1->E1_BAIXA) # ' '
			MCOUNT := MCOUNT +1 //20060525
			dbSelectArea("SE1")
			DBSKIP()
			LOOP
		ENDIF
		IF SE1->E1_PARCELA == 'A' .OR. SE1->E1_PARCELA == ' '  //20060525 REINICIAR OS CONTADORES
			MCOUNT  := 1
			MSOMADR := 0
			MSOMABOL := 0
		ENDIF
		
		mNATUREZ := SE1->E1_NATUREZ
		mEMISSAO := SE1->E1_EMISSAO
		mPROGPAG := CTOD('  /  /  ')
		mVENCTO  := SE1->E1_VENCTO
		mVENCREA := SE1->E1_VENCREA
  //20060525
			IF TRIM(SE1->E1_SERIE) # 'D1' .AND. MCOUNT = MQTDPARCELA //ultima parcela pegar a dif de valores para nao dar diferenca nos centavos
				MDESPREM := round((SC5->C5_DESPREM - MSOMADR),2)
				mVALOR := SE1->E1_VALOR + (MDESPREM)
				MSOMADR := MSOMADR + MDESPREM
			ELSEif TRIM(SE1->E1_SERIE) # 'D1' .and. SC5->C5_DESPREM > 0
				MDESPREM := round((SC5->C5_DESPREM / MQTDPARCELA) ,2)
				mVALOR := SE1->E1_VALOR + MDESPREM
				MSOMADR := MSOMADR + MDESPREM
			ELSE //20060606
				MDESPREM := 0 //20060606
				mVALOR := SE1->E1_VALOR //20060606
			endif
/*			IF SE1->E1_PARCELA == 'A' .OR. SE1->E1_PARCELA == ' ' .AND. TRIM(SE1->E1_SERIE) # 'D1'
				mVALOR := SC5->C5_PARC1 + MDESPREM
			ELSE
				mVALOR   := SE1->E1_VALOR
			ENDIF
		ENDIF  //20060525 ATE AQUI */
		
		If SE1->E1_VENCTO < SE1->E1_EMISSAO
			mVENCTO := SE1->E1_EMISSAO
		Endif
		
		If SE1->E1_PARCELA =='A' .OR. SE1->E1_PARCELA==' '
			If MPROGPA1 == 'S'
				mPROGPAG := SE1->E1_VENCREA
				mNATUREZ := SZ9->Z9_NATBX
			EndIf
		EndIf
		
		If SE1->E1_PARCELA # 'A' .AND. SE1->E1_PARCELA # ' '
			If mPROGPAD == 'S'
				mNATUREZ := SZ9->Z9_NATBX
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
		IF SUBS(MTIPOOP,1,1)=='8' .and. MTIPOOP <>'86 '  //20070302
			mnaturez:= 'DB'
		ENDIF
		
		IF MTIPOOP=='C2 '.OR. MTIPOOP == 'C3 '.OR. MTIPOOP == 'C4 '.OR. MTIPOOP == 'C5 '
			mnaturez:= 'CC'
		ENDIF
		
		IF MTIPOOP=='BND' //20081210
			mnaturez:= 'BND'
		ENDIF
		
		IF SE1->E1_VENCREA < MVENCTO
			MVENCREA := MVENCTO
		ENDIF
		
		IF DTOC(SE1->E1_PGPROG) # ' ' .AND. SE1->E1_PGPROG < MVENCREA
			MPROGPAG:=MVENCREA
		ENDIF
		
		// CONDICAO ESPECIAL PARA CURSOS
		IF SC5->C5_CONDPAG == '702'
			IF SE1->E1_PARCELA == 'A'
				MVALOR:=300.00
			ELSE
				MVALOR:=200.00
			ENDIF
		ENDIF

		// 20060525: COBRAR TAXA ADMINSTRATIVA POR BOLETO
		MDESPBOL := 0
		IF ((SZ9->Z9_BOLETO1 ='S' .AND. MCOUNT =1) .OR. (SZ9->Z9_BOLETOD ='S' .AND. MCOUNT >1)) .AND. SC5->C5_DESPBOL >0
			MDESPBOL := SC5->C5_DESPBOL
			MVALOR := MVALOR + MDESPBOL
			MSOMABOL := MSOMABOL + MDESPBOL
		ENDIF
		//20060525 ATE AQUI
		                      
		//20060928 PROCESSAR APENAS 1 VEZ!!!
		IF (SE1->E1_DESPBOL =0 .and. SE1->E1_DESPREM =0)
			RecLock("SE1",.F.)
			Replace SE1->E1_VENCTO   with mVENCTO
			Replace SE1->E1_VENCREA  with mVENCREA
			Replace SE1->E1_PGPROG   with mPROGPAG
			Replace SE1->E1_VALOR    with mVALOR
			Replace SE1->E1_CLIENTE  WITH MCLIENTE
			Replace SE1->E1_CLIPED   WITH XCLIENTE
			Replace SE1->E1_VLCRUZ   WITH MVALOR
			Replace SE1->E1_SALDO    WITH MVALOR
			Replace SE1->E1_NATUREZ  WITH mNATUREZ
			Replace SE1->E1_TIPOOP   WITH MTIPOOP
			Replace SE1->E1_GRPROD   WITH MGRUPO
			Replace SE1->E1_DESPBOL   WITH MDESPBOL  //20060525	
			Replace SE1->E1_DESPREM   WITH MDESPREM  //20060525	
			MsUnlock()
		ENDIF // APENAS 1 VEZ 20060928

		MCOUNT := MCOUNT +1 //20060525
		
		dbSELECTAREA("SD2")
		dbSetORDER(3)
		If dbSEEK(XFILIAL()+MDUPL+MSERIE+mcliente)
		
			WHILE !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .and. SD2->D2_DOC == MDUPL .AND. SD2->D2_SERIE = MSERIE
				RecLock("SD2",.F.)
				Replace SD2->D2_CLIENTE  with mCLIENTE
				MsUnlock()
				DBSKIP()
			END
		ENDIF
				
		dbSELECTAREA("SF3")
		dbSetORDER(5) //indice 1: dtos(entrada)+serie+nfiscal
		If dbSEEK(XFILIAL()+DTOS(SF2->F2_EMISSAO)+MSERIE+MDUPL)
			WHILE !Eof() .and. SF3->F3_FILIAL == xFilial("SF3") .and. SF3->F3_NFISCAL==MDUPL .AND. SF3->F3_SERIE == MSERIE
				RecLock("SF3",.F.)
				Replace SF3->F3_CLIEFOR  with mCLIENTE
				MsUnlock()
				DBSKIP()
			END
		ENDIF
		
		//��������������������������������������������������������������Ŀ
		//� Baixa(deleta) os pedidos no arquivo de controle de pedidos   �
		//����������������������������������������������������������������
		dbSelectArea("SZD")
		DBSETORDER(1)
		If dbSEEK(XFILIAL()+MPEDIDO)
			RecLock("SZD",.F.)
			Replace SZD->ZD_LOTEFAT WITH MLOTEFAT
			Replace SZD->ZD_DATA WITH MDATA
			Replace SZD->ZD_SITUAC WITH 'X'
			DBDELETE()
			MSUNLOCK()
		ENDIF
		
		dbSELECTAREA("SE1")
		dbSkip()
		
		tregs := LastRec()-Recno()+1
		m_mult := 1
		If tregs>0
			m_mult := 70/tregs
		EndIf
		p_ant := 4
		p_atu := 4
		p_cnt := 0
		//m_sav20 := dcursor(3)
		//m_sav7 := savescreen(23,0,24,79)
		
	End
		
	DbSelectArea("SF2")
	RecLock("SF2",.F.)
	Replace SF2->F2_CLIENTE WITH MCLIENTE          
	Replace SF2->F2_DESPREM WITH SC5->C5_DESPREM
	Replace SF2->F2_PROTOC  WITH '3'
	Replace SF2->F2_VALBRUT WITH F2_VALMERC + SC5->C5_DESPREM + MSOMABOL  //20060525	
	Replace SF2->F2_VALFAT  WITH F2_VALMERC + SC5->C5_DESPREM + MSOMABOL  //20060525	
	SF2->(MsUnlock())
	
	dbSelectArea("SF2")
	dbSkip()
End

Return