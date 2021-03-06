#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/    Alterado por Danilo C S Pala em 20041117             
//ALTERADO POR DANILO C S PALA EM 20041208: NPESOLIQUIDO
// icms: Danilo CS Pala 20051108
//Danilo C S Pala 20060328: dados de enderecamento do DNE
//Danilo C S Pala 20060525: DESPESA COM BOLETO     
//Danilo C S Pala 20070613: ALMOXARIFADOS DO D2_LOCAL
//Danilo C S Pala 20100305: ENDBP
//Danilo C S Pala 20100805: alteracoes para a serie 1
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: PFAT021   �Autor: Solange Nalini         � Data:   26/03/98 � ��
������������������������������������������������������������������������Ĵ ��
���Descri�ao: Notas Fiscais de Assinaturas e Livros (impressora OKIDATA) � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento                                      � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function Pfat021()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,LIMITE,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CNATUREZA,ARETURN,SERNF,NOMEPROG")
SetPrvt("CPERG,NLASTKEY,LCONTINUA,WNREL,NTAMNF,CSTRING")
SetPrvt("TREGS,M_MULT,P_ANT,P_ATU,P_CNT,M_SAV20")
SetPrvt("M_SAV7,INICIO,XNFISCAL,XPEDIDO,XSERIE,XTIPOOP")
SetPrvt("XCODPROM,XMENSNFN,XMENSNFO,XMENSES1,XMENSES2,NOTA_NUM")
SetPrvt("NOTA_EMIS,NOTA_CLIE,NOTA_LOJA,NOTA_MERC,NOTA_TOTA,NOTA_DESC")
SetPrvt("NOTA_VEND,NOTA_COND,NOTA_DESPREM,MPREFIX,NREGATU,NOTA_NATU")
SetPrvt("NOTA_COFI,NOTA_TESA,NOTA_PEDI,MD2CF,MD2SF,CLIE_CGC")
SetPrvt("CLIE_NOME,CLIE_INSC,CLIE_ENDE,CLIE_BAIR,CLIE_MUNI,CLIE_ESTA")
SetPrvt("CLIE_CEP,CLIE_SUF,CLIE_COBR,CLIE_TRAN,CLIE_FONE,CLIE_TIPO")
SetPrvt("XENDC,XBAIRROC,XCIDADEC,XESTADOC,XCEPC,XDESCRNF")
SetPrvt("XDESCDUPL,XPAGA1,XPAGAD,XQTDEP,XCODFAT,XMENSES3")
SetPrvt("XMENSNF1,XMENSNF2,XMENSNF3,XMENSNF4,COL,COL2")
SetPrvt("ITEM_CODI,ITEM_QUAN,ITEM_VUNI,ITEM_TOTA,ITEM_ABAT,ITEM_EDINIC")
SetPrvt("ITEM_EDFIN,MCOMPL,ITEM_UNID,ITEM_DESC, NPESOLIQUIDO")
SetPrvt("xBASE_ICMS, xVALOR_ICMS,xBSICMRET, xICMS_RET") //20051108
SetPrvt("SOMABOL, NOTA_ALMOX, mhora")

//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Lote                                 �
//� mv_par02             // Data                                 �
//����������������������������������������������������������������
li:=0
LIN:=0
CbTxt:=""
CbCont:=""
nOrdem :=0
Alfa := 0
Z:=0
M:=0
tamanho:="G"
limite:=220
titulo :=PADC("Nota Fiscal - Nfiscal",74)
cDesc1 :=PADC("Este programa ira emitir a Nota Fiscal da Editora Pini ",74)
cDesc2 :=""
cDesc3 :=""
cNatureza:=""

aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
SERNF:='CNE'
nomeprog:="NFASLI"
cPerg:="FAT004"
nLastKey:= 0
lContinua := .T.
MHORA      := TIME()
wnrel    := "NFEP_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

//�����������������������������������������������������������Ŀ
//� Tamanho do Formulario de Nota Fiscal (em Linhas)          �
//�������������������������������������������������������������
nTamNf:=66     // Apenas Informativo

//�������������������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas, busca o padrao da Nfiscal           �
//���������������������������������������������������������������������������
Pergunte(cPerg,.T.)               // Pergunta no SX1

cString:="SF2"

//��������������������������������������������������������������Ŀ
//� Envia controle para a funcao SETPRINT                        �
//����������������������������������������������������������������
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
	Return
Endif

//��������������������������������������������������������������Ŀ
//� Verifica Posicao do Formulario na Impressora                 �
//����������������������������������������������������������������
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

Processa({|| P021Proc()})

Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �P021Proc  �Autor  �Microsiga           � Data �  03/26/02   ���
�������������������������������������������������������������������������͹��
���Desc.     �Processamento                                               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP5                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function P021Proc()

//��������������������������������������������������������������Ŀ
//�  Prepara regua de impress�o                                  �
//����������������������������������������������������������������
DBSELECTAREA("SC6")
DBSETORDER(4)
DbSeek(xFilial("SC6")+MV_PAR01+MV_PAR03)

IF !FOUND()
	RETURN
ENDIF

LIN:=PROW()
LI:=0
INICIO:=.T.

ProcRegua(Abs(Val(MV_PAR02)-Val(MV_PAR01)))

WHILE !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NOTA >= MV_PAR01 .AND.  SC6->C6_NOTA <= MV_PAR02
	
	IF SC6->C6_SERIE <> MV_PAR03 
		DBSKIP()
		LOOP
	ENDIF
	
	IF SUBS(SC6->C6_NUM,6,1)=='P'
		DBSKIP()
		LOOP
	ENDIF
	
	IncProc()
	
	XNFISCAL:=SC6->C6_NOTA
	XPEDIDO :=SC6->C6_NUM
	XSERIE  :=SC6->C6_SERIE
	DO WHILE SC6->C6_NOTA==XNFISCAL .AND. SC6->C6_SERIE==XSERIE   //20100805 INCLUIR A SERIE
		DBSKIP()
		IF SC6->C6_NOTA <> XNFISCAL .OR. SC6->C6_SERIE <> XSERIE //20100805 INCLUIR A SERIE
			DBSKIP(-1)
			EXIT
		ENDIF
	ENDDO
	
	//��������������������������������������������������������������Ŀ
	//�  Inicio do levantamento dos dados da Nota Fiscal             �
	//����������������������������������������������������������������
	XPEDIDO:=SC6->C6_NUM
	DBSELECTAREA("SC5")
	DBSETORDER(1)
	IF DBSEEK(XFILIAL()+XPEDIDO)
		XTIPOOP:=C5_TIPOOP
		XCODPROM:=C5_CODPROM
		
		//*�������������������������������������������������������������������*
		//*                      MENSAGENS NOTA FISCAL                        *
		//*�������������������������������������������������������������������*
		XMENSNFN:=SUBSTR(SC5->C5_MENNOTA,1,45)
		XMENSNFO:=SUBSTR(SC5->C5_MENNOTA,46,60)
		
		// GILBERTO - 01.12.2000 - ESSERE CORTESIA.
		IF !EMPTY(SC5->C5_MENPAD)
			XMENSES1:=SUBSTR(FORMULA(SC5->C5_MENPAD),1,45)
			XMENSES2:=SUBSTR(FORMULA(SC5->C5_MENPAD),46,60)
		ELSE
			XMENSES1:= " "
			XMENSES2:= " "
		ENDIF
	ENDIF
	
	DbSelectArea("SF2")
	DbSetOrder(1)
	DbSeek(xFilial()+xnfiscal+xserie)
	/*
	*��������������������������������������������������������������������*
	*                          CABECALHO DA NOTA                         *
	*��������������������������������������������������������������������*
	*/
	NOTA_NUM     := SF2->F2_DOC
	NOTA_EMIS    := SF2->F2_EMISSAO                         && DATA EMISSAO
	NOTA_CLIE    := SF2->F2_CLIENTE                         && CODIGO DO CLIENTE
	NOTA_LOJA    := SF2->F2_LOJA                            && CODIGO DA LOJA
	NOTA_MERC    := SF2->F2_VALMERC                         && VALOR MERCADORIA
	NOTA_TOTA    := SF2->F2_VALBRUT                         && VALOR BRUTO FATURADO
	NOTA_DESC    := SF2->F2_DESCONT                         && DESCONTO EM VALOR
	NOTA_VEND    := SF2->F2_VEND1                           && CODIGO VENDEDOR
	NOTA_COND    := SF2->F2_COND                            && CONDICAO PAGAMENTO
	NOTA_DESPREM := SF2->F2_DESPREM
	SERNF        := SF2->F2_SERIE
	MPREFIX      := SF2->F2_PREFIXO                         
	//Danilo 20051108
	xBASE_ICMS   := SF2->F2_BASEICM         // Base do ICMS.
	xVALOR_ICMS  := SF2->F2_VALICM          // Valor do ICMS.
	xVALOR_IPI   := SF2->F2_VALIPI          // Valor do IPI.
	xICMS_RET    := SF2->F2_ICMSRET         // Valor do ICMS Retido.
	xBSICMRET    := 0

	/*
	*�������������������������������������������������������������������*
	*             ITENS DO CABECALHO QUE ESTAO NO ARQ. DE ITENS          *
	*��������������������������������������������������������������������*
	*/
	DbSelectArea("SD2")
	DbSetOrder(3)
	DBSEEK(xFilial()+NOTA_NUM+SERNF)
	NREGATU:=RECNO()
	NOTA_NATU:=' '
	NOTA_COFI:=' '
	NOTA_ALMOX:=' '//20070613
	
	WHILE !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .and. SD2->D2_DOC == NOTA_NUM .and. SD2->D2_SERIE == SERNF //20100805 INCLUIR A SERIE
		/*IF SD2->D2_SERIE # SERNF
			DBSKIP()
			LOOP
		ENDIF*/ //comentado em 20100805
		NOTA_TESA := SD2->D2_TES                        && TIPO ENTRADA E SAIDA
		NOTA_PEDI := SD2->D2_PEDIDO                     && PEDIDO INTERNO
		DbSelectArea("SF4")
		DBSEEK(xFilial()+SD2->D2_TES)
		MD2CF := SD2->D2_CF
		MD2SF := SF4->F4_TEXTO
		IF NOTA_NATU==' '
			NOTA_NATU :=TRIM(SF4->F4_TEXTO)
			NOTA_COFI :=TRIM(MD2CF)    
			NOTA_ALMOX:=TRIM(SD2->D2_LOCAL) //20070613
		ELSE
			IF TRIM(MD2SF)$(NOTA_NATU)
				NOTA_NATU :=TRIM(NOTA_NATU)
			ELSE
				NOTA_NATU :=TRIM(NOTA_NATU)+'/'+TRIM(SF4->F4_TEXTO)
			ENDIF
			IF TRIM(MD2CF)$(NOTA_COFI)
				NOTA_COFI :=TRIM(NOTA_COFI)
			ELSE
				NOTA_COFI :=TRIM(NOTA_COFI)+'/'+TRIM(SD2->D2_CF)
			ENDIF
			IF TRIM(SD2->D2_LOCAL)$(NOTA_ALMOX) //20070613
				NOTA_ALMOX :=TRIM(NOTA_ALMOX) //20070613
			ELSE //20070613
				NOTA_ALMOX :=TRIM(NOTA_ALMOX)+'/'+TRIM(SD2->D2_LOCAL) //20070613
			ENDIF //20070613
		ENDIF
		DBSELECTAREA("SD2")
		DBSKIP()
	END
	DBGOTO(NREGATU)
	/*
	*��������������������������������������������������������������������*
	*                          DADOS DO CLIENTE                          *
	*��������������������������������������������������������������������*
	*/
	DbSelectArea("SA1")
	DBSEEK(xFilial()+NOTA_CLIE+NOTA_LOJA)
	IF SA1->A1_CGC==SPACE(14)
		CLIE_CGC:=SA1->A1_CGCVAL
	ELSE
		CLIE_CGC  := SA1->A1_CGC
	ENDIF
	CLIE_NOME := SA1->A1_NOME
	CLIE_INSC := SA1->A1_INSCR
	CLIE_ENDE := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060328
	CLIE_BAIR := SA1->A1_BAIRRO
	CLIE_MUNI := SA1->A1_MUN
	CLIE_ESTA := SA1->A1_EST
	CLIE_CEP  := SA1->A1_CEP
	CLIE_SUF  := SA1->A1_SUFRAMA
	CLIE_COBR := SA1->A1_ENDCOB
	CLIE_TRAN := SA1->A1_TRANSP
	CLIE_FONE := SA1->A1_TEL
	CLIE_TIPO := SA1->A1_TIPO
	/*
	*������������������������������������������������������������������*
	*                          ENDERECO DE COBRANCA                     *
	*������������������������������������������������������������������*
	*/
	
	//20100305 DAQUI
	IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
		DbSelectArea("ZY3")
		DbSetOrder(1)
		DbSeek(XFilial()+NOTA_CLIE+NOTA_LOJA)
		XENDC    :=ZY3_END
		XBAIRROC :=ZY3_BAIRRO
		XCIDADEC :=ZY3_CIDADE
		XESTADOC :=ZY3_ESTADO
		XCEPC    :=ZY3_CEP
    ELSEIF SUBS(SA1->A1_ENDCOB,1,1)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
		DbSelectArea("SZ5")
		DbSetOrder(1)
		DbSeek(XFilial()+NOTA_CLIE+NOTA_LOJA)
		XENDC    := ALLTRIM(SZ5->Z5_TPLOG)+ " " + ALLTRIM(SZ5->Z5_LOGR) + " " + ALLTRIM(SZ5->Z5_NLOGR) + " " + ALLTRIM(SZ5->Z5_COMPL) //20060328
		XBAIRROC := Z5_BAIRRO
		XCIDADEC := Z5_CIDADE
		XESTADOC := Z5_ESTADO
		XCEPC    := Z5_CEP
	ELSE
		XENDC   :=' '
		XBAIRROC:=' '
		XCIDADEC:=' '
		XESTADOC:=' '
		XCEPC   :=SPACE(8)
	ENDIF
         //danilo 20051108
			If xICMS_RET > 0                          // Apenas se ICMS Retido > 0
				
				//������������������������������������������������������������������Ŀ
				//� CADASTRO LIVROS FISCAIS                                          �
				//��������������������������������������������������������������������
				DbSelectArea("SF3")
				DbSetOrder(4)
				DbSeek(xFilial("SF3")+SA1->A1_COD+SA1->A1_LOJA+SF2->F2_DOC+SF2->F2_SERIE)
				If Found()
					xBSICMRET := F3_VALOBSE
				EndIf
			Endif

	/*
	*��������������������������������������������������������������������*
	*                      DEFINE CONDICAO DE PAGAMENTO P/TIPO DE OPER                 *
	*��������������������������������������������������������������������*
	*/
	IF XTIPOOP=='99'
		XDESCRNF  := 'CONF.ABAIXO'
		XDESCDUPL := 'CR'                 //CONSULTA CONTAS A RECEBER
	ELSE
		DbSelectArea("SZ9")
		DbSetOrder(2)
		DbSeek(XTIPOOP)
		IF FOUND()
			XDESCRNF  := SZ9->Z9_DESCRNF
			XDESCDUPL := SZ9->Z9_DESCDUP
			XPAGA1    := SZ9->Z9_PAGA1
			XPAGAD    := SZ9->Z9_PAGAD
			XQTDEP    := SZ9->Z9_QTDEP
			XCODFAT   := SZ9->Z9_CODFAT
		ENDIF
	ENDIF
	// inicializa as variaveis de mensagem
	
	IF NOTA_DESC <> 0
		XMENSES3:='DESCONTO..R$ '+STR(NOTA_DESC,5,2)
	ELSE
		XMENSES3:= " "
	ENDIF
	XMENSNF1 := ' '
	XMENSNF2 := ' '
	XMENSNF3 := ' '
	
	If XQTDEP==1 .AND. XPAGA1=='S'
		XMENSNF4:='NF QUITADA.'
	ElseIf XQTDEP > 1 .AND. XPAGA1=='S' .AND. XPAGAD=='S'
		XMENSNF4:='NF QUITADA.'
	Else
		XMENSNF4:=' '
	EndIf
	
	//*������������������������������������������������������������*
	//*                   IMPRESSAO DA NOTA FISCAL                 *
	//*������������������������������������������������������������*
	IF INICIO
		SETPRC(4,0)  //linha -2 20041117
		COL:=75
		COL2:=114
		@ 04,01  psay '.' //linha -2 20041117
	ELSE
		SETPRC(0,0)
		@ 07,01  psay '.' //linha -2 20041117
		COL:=73
		COL2:=112
		SETPRC(4,0) //linha -2 20041117
	ENDIF
	
	@ 04,COL  psay 'XX' //linha -2 20041117
	@ 04,COL2 psay NOTA_NUM //linha -2 20041117
	@ 05,001  psay ' ' //linha -2 20041117
	// RETIRADO A PEDIDO DO USUARIO CICERO EM 18/10/2000 - GILBERTO.
	//@ 10,025  psay 'FONE:0(XX11)3224-8811'
	//@ 10,050  psay 'FAX:0(XX11)3224-0314'
	
	IF INICIO
		INICIO:=.F.
		INKEY(0)
	ENDIF
	@ 10,003 psay NOTA_NATU //linha -2 20041117
	@ 10,039 psay NOTA_COFI //linha -2 20041117
	@ 13,003 psay CLIE_NOME     + ' ' +NOTA_CLIE                && nome do cliente //linha -2 20041117
	//                IF LEN(TRIM(CLIE_CGC))<14
	//                   @ 15,070 psay CLIE_CGC picture "@R 999.999.999-99"        && c.g.c.
	//                ELSE
	//                   @ 15,070 psay CLIE_CGC picture "@R 99.999.999/9999-99"    && c.g.c.
	//                ENDIF
	@ 13,077 psay CLIE_CGC                          && c.g.c.  //linha -2 20041117
	@ 13,116 psay NOTA_EMIS                         && data de emissao //linha -2 20041117
	@ 15,003 psay SUBSTR(CLIE_ENDE,1,65)                         && endereco do cliente //linha -2 20041117 20060328
	@ 15,068 psay CLIE_BAIR                         && bairro //linha -2 20041117 20060328 ERA 61
	@ 15,092 psay SUBS(CLIE_CEP,1,5)+'-'+SUBS(CLIE_CEP,6,3)   && cep do cliente //linha -2 20041117
	@ 17,003 psay CLIE_MUNI                         && cep do cliente //linha -2 20041117
	@ 17,042 psay CLIE_FONE                         && fone do cliente //linha -2 20041117
	@ 17,068 psay CLIE_ESTA                         && estado do cliente //linha -2 20041117
	@ 17,087 psay CLIE_INSC                         && inscricao estadual //linha -2 20041117
	
	@ 20,020 psay XENDC //linha -2 20041117
	@ 21,007 psay SUBS(XCEPC,1,5)+'-'+SUBS(XCEPC,6,3) //linha -2 20041117
	@ 21,030 psay XBAIRROC //linha -2 20041117
	@ 21,083 psay XCIDADEC //linha -2 20041117
	@ 22,121 psay XESTADOC //linha -2 20041117
	SOMABOL := 0 //20060525
	If xDescDupl=="S"
		DbSelectArea("SE1")
		DbSetOrder(1)
		DBSEEK(xFilial()+MPREFIX+NOTA_NUM)
		WHILE !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_PREFIXO == MPREFIX  .AND. SE1->E1_NUM == NOTA_NUM .AND. ! EOF()
			SOMABOL := SOMABOL + SE1->E1_DESPBOL //20060525
			IF SE1->E1_PARCELA=='A'.OR. SE1->E1_PARCELA==' '
				@ 23,005 psay SE1->E1_NUM+' ' +SE1->E1_PARCELA //linha -2 20041117
				@ 23,025 psay SE1->E1_VALOR picture '@e 999,999,999.99' //linha -2 20041117
				@ 23,050 psay SE1->E1_VENCTO //linha -2 20041117
			ENDIF
			IF SE1->E1_PARCELA=='B'
				@ 23,071 psay SE1->E1_NUM+' ' +SE1->E1_PARCELA //linha -2 20041117
				@ 23,089 psay SE1->E1_VALOR picture '@e 999,999,999.99' //linha -2 20041117
				@ 23,112 psay SE1->E1_VENCTO //linha -2 20041117
			ENDIF
			IF SE1->E1_PARCELA=='C' 
				@ 24,005 psay SE1->E1_NUM+' ' +SE1->E1_PARCELA //linha -2 20041117
				@ 24,025 psay SE1->E1_VALOR picture '@e 999,999,999.99' //linha -2 20041117
				@ 24,050 psay SE1->E1_VENCTO //linha -2 20041117
			ENDIF
			IF SE1->E1_PARCELA=='D'
				@ 24,071 psay SE1->E1_NUM+' ' +SE1->E1_PARCELA  //linha -2 20041117
				@ 24,089 psay SE1->E1_VALOR picture '@e 999,999,999.99' //linha -2 20041117
				@ 24,112 psay SE1->E1_VENCTO //linha -2 20041117
			ENDIF
			IF SE1->E1_PARCELA=='E'  //linha -2 20041117
				@ 25,005 psay SE1->E1_NUM+' ' +SE1->E1_PARCELA
				@ 25,025 psay SE1->E1_VALOR picture '@e 999,999,999.99'
				@ 25,050 psay SE1->E1_VENCTO
			ENDIF
			IF SE1->E1_PARCELA=='F'  //linha -2 20041117
				@ 25,071 psay SE1->E1_NUM+' ' +SE1->E1_PARCELA
				@ 25,089 psay SE1->E1_VALOR picture '@e 999,999,999.99'
				@ 25,112 psay SE1->E1_VENCTO
			ENDIF
			dbSkip()
		end
	endif
	LIN:=29 //LINHA -2 20041117
	NPESOLIQUIDO := 0
	DbSelectArea('SD2')
	DbSetOrder(3)
	WHILE !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .and. NOTA_NUM == SD2->D2_DOC .AND. SD2->D2_SERIE == SERNF .AND. .NOT. EOF()
		ITEM_CODI := alltrim(SD2->D2_COD)                         && codigo produto
		ITEM_QUAN := ABS(SD2->D2_QUANT)                  && quantidade
		ITEM_VUNI := ABS(SD2->D2_PRCVEN)                 && preco unitario
		ITEM_TOTA := ABS(SD2->D2_TOTAL)                  && preco total
		ITEM_ABAT := SD2->D2_DESC                        && desconto
			/*/               ITEM_EDINIC:=SD2->D2_EDINIC
		ITEM_EDFIN:=SD2->D2_EDFIN
		
		IF SUBS(ITEM_CODI,1,2)=='01' .AND. SUBS(ITEM_CODI,5,3)#'001'
			MCOMPL:='ED: '+LTRIM(STR(ITEM_EDINIC,6,0))+' A '+LTRIM(STR(ITEM_EDFIN,6,0))
		ELSE
			MCOMPL:=' '
		ENDIF
		/*/
		
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial()+ITEM_CODI)
		ITEM_UNID := SB1->B1_UM                     && unidade do produto
		ITEM_DESC := SUBS(SB1->B1_DESC,1,40)        && descricao do produto
		NPESOLIQUIDO := NPESOLIQUIDO + (B1_PESO * ITEM_QUAN) 	// peso do produto	

		IF TRIM(ITEM_CODI) == "0699001" .or. TRIM(ITEM_CODI) == "0699002" .or. TRIM(ITEM_CODI) == "0699003" && descricao generica 20051109
			ITEM_DESC := SUBS(SC6->C6_DESCRI,1,32)   && descricao do produto
		ENDIF
		//*���������������������������������������������������������������������*
		//*                       Detalhes do Item - Produto                    *
		//*���������������������������������������������������������������������*
		@ LIN+LI,002 psay ITEM_CODI                      && imprime cod do produto
		@ LIN+LI,014 psay ITEM_DESC                      && imprime descricao do item //20041117
		//                        IF MCOMPL#' '
		//                        @ LIN+LI,034 psay MCOMPL
		//                        ENDIF
		@ LIN+LI,058 psay 'CFOP:'+SD2->D2_CF                           && SITUACAO TRIBUTARIA
		@ LIN+LI,075 psay '040'                           && SITUACAO TRIBUTARIA
		@ LIN+LI,080 psay 'UN'                           && SITUACAO TRIBUTARIA
		@ LIN+LI,084 psay ITEM_QUAN picture '@E 999999'
		@ LIN+LI,095 psay ITEM_VUNI picture '@E 99,999.99'
		@ LIN+LI,108 psay ITEM_TOTA picture '@E 9,999,999.99'  
		@ LIN+LI,123 PSAY IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM) Picture "@E 99" //danilo 20051108
		
		DbselectArea("SD2")
		IF SD2->D2_TES=='650' .OR. SD2->D2_TES=='651' .AND. XCODPROM=='ENS' .OR. XCODPROM=='A01'
			If VAL(SD2->D2_ITEM) > 1
				IF XMENSNF1==' '
					xMENSNF1:='COD.PROD.: '+trim(ITEM_CODI) + ' EM CORTESIA'
					xMENSNF2:=' '
					xMENSNF3:=' '
				ELSE
					IF XMENSNF2==' '
						xMENSNF2:='COD.PROD.: '+trim(ITEM_CODI) + ' EM CORTESIA'
						xMENSNF3:=' '
					ELSE
						xMENSNF3:='COD.PROD.: '+trim(ITEM_CODI) + ' EM CORTESIA'
					ENDIF
				ENDIF
			ENDIF
		ENDIF
		
		DBSKIP()
		LIN++
	ENDDO
	DBSELECTAREA("SF2")
	
	IF NOTA_DESPREM <> 0
		NOTA_TOTA := NOTA_MERC + NOTA_DESPREM
	ENDIF
	IF SOMABOL > 0 //20060525
		NOTA_TOTA := NOTA_MERC + NOTA_DESPREM + SOMABOL    //20060606
	ENDIF
                                                                              
	@ 44,002  PSAY "PAGTO SOMENTE C/ BOLETO BANCARIO: NAO ACEITAMOS PAGTO VIA DOC, TRANSF. OU DEP. SIMPLES. POIS NOSSO SISTEMA NAO IDENTIFICA"                                 // 20060522
	//danilo 20051108
	@ 47,003  PSAY xBASE_ICMS  Picture "@E@Z 999,999,999.99"  // Base do ICMS.
	@ 47,028  PSAY xVALOR_ICMS Picture "@E@Z 999,999,999.99"  // Valor do ICMS.
	@ 47,055  PSAY xBSICMRET   Picture "@E@Z 999,999,999.99"  // Base ICMS Ret.
	@ 47,080  PSAY xICMS_RET   Picture "@E@Z 999,999,999.99"  // Valor  ICMS Ret.
	@ 47,102 psay NOTA_MERC           picture '@E 9,999,999,999.99' //LINHA +7 20041117

	@ 49,003 psay NOTA_DESPREM        picture "@E 9,999.99" //LINHA +7 20041117
	@ 49,056 psay SOMABOL	          picture "@E 9,999.99" //LINHA +7 20041117 //20060525
	@ 49,102 psay NOTA_TOTA           picture '@E 9,999,999,999.99'  //LINHA +7 20041117
	
	DbSelectArea("SA3")
	DbSetOrder(1)
	DbSeek(xFilial()+NOTA_VEND)
	// peso liquido 20041208
	LIN:=55 //LINHA +7 20041117
	if NPESOLIQUIDO > 0 
		@ LIN +1 ,112 psay NPESOLIQUIDO PICTURE "@E 9,999.99"
	end if //ateh aki
	
	LIN := LIN +3

	@ LIN+1,20 psay XPEDIDO
	//              @ LIN+1,52 psay NOTA_VEND
	@ LIN+1,46 psay NOTA_VEND
	@ LIN+1,52 psay '/ ' + NOTA_ALMOX // 20070613 SA3->A3_LOCAL
	
	@ LIN+2,20 psay ALLTRIM(XMENSNF1)+' '+XMENSES3
	@ LIN+3,20 psay XMENSNF2
	@ LIN+4,20 psay XMENSNF3
	
	@ LIN+5,20 psay XMENSNFN
	@ LIN+6,20 psay XMENSNFO
	
	@ LIN+7,20 psay XMENSNF4
	
	// GILBERTO - 01.12.2000 - CESSAO DIREITO ESSERE (CORTESIA)
	@ LIN+8,20  psay XMENSES1
	@ LIN+9,20  psay ALLTRIM(XMENSES2)
	
	@ 69,95 psay XCODFAT //LINHA +6 20041117
	@ 69,115 psay NOTA_NUM  //LINHA +6 20041117
	//              DbSelectArea("SF2")                  //ESTA PARTE DEVE SER
	//                 RecLock("SF2",.F.)              // RESTAURADA APOS TESTE
	//                 replace F2_NFEM WITH 'S'
	//              dbUnlock()
	
	DbSelectArea("SC6")
	DBSETORDER(4)
	DBSKIP()
	
	set device to screen
	
	SETPRc(0,0)
	
	//Endif
	set device to printer
	SetPrc(0,0)
	
	LIN:=6
	LI:=0
END

SET Device TO SCREEN

DBSELECTAREA("SC6")
RetIndex("SC6")

IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()

Return