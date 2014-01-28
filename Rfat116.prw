#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
//Danilo C S Pala 20100305: ENDBP
//Danilo C S Pala 20060321: dados de enderecamento do DNE
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: Rfat116   ³Autor: Solange Nalini         ³ Data:   26/03/98 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Notas fiscais de assinaturas e livros (impressora OKIDATA) ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat116()

SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,cTAMANHO,cLIMITE,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CNATUREZA,ARETURN,SERNF,NOMEPROG")
SetPrvt("CPERG,NLASTKEY,LCONTINUA,WNREL,NTAMNF,CSTRING")
SetPrvt("TREGS,M_MULT,P_ANT,P_ATU,P_CNT,M_SAV20")
SetPrvt("M_SAV7,INICIO,XNFISCAL,XSERIE,XPEDIDO,XTIPOOP")
SetPrvt("XCODPROM,XRESPCOB,XMENSNF,XCODDEST,NOTA_NUM,NOTA_EMIS")
SetPrvt("NOTA_CLIE,NOTA_LOJA,NOTA_MERC,NOTA_TOTA,NOTA_VEND,NOTA_COND")
SetPrvt("NOTA_DESPREM,MPREFIX,CLIE_CGC,CLIE_NOME,CLIE_INSC,CLIE_ENDE")
SetPrvt("CLIE_BAIR,CLIE_MUNI,CLIE_ESTA,CLIE_CEP,CLIE_COBR,CLIE_FONE")
SetPrvt("MDEST,MENDD,MBAIRROD,MCIDADED,MESTADOD,MCEPD")
SetPrvt("XENDC,XBAIRROC,XCIDADEC,XESTADOC,XCEPC,XDESCRNF")
SetPrvt("XDESCDUPL,XPAGA1,XPAGAD,XQTDEP,XCODFAT,MQUITADA")
SetPrvt("L,ITEM_CODI,MCODREV,ITEM_ITEM,ITEM_QUAN,ITEM_VUNI")
SetPrvt("ITEM_TOTA,ITEM_ABAT,ITEM_UNID,ITEM_DESC,MEDINIC,MEDFIN")
SetPrvt("MDTINIC,MDTFIN,XMENSNF1,XMENSNF2,XMENSNF3,MPARCELA")
SetPrvt("MCOLU,MNOMEV,")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Lote                                 ³
//³ mv_par02             // Data                                 ³
//³ mv_par03             Serie									 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li        := 0
LIN       := 0
CbTxt     := ""
CbCont    := ""
nOrdem    := 0
Alfa      := 0
Z         := 0
M         := 0
ctamanho   := "P"
climite    := 80
titulo    := PADC("Nota Fiscal - Nfiscal",74)
cDesc1    := PADC("Este programa ira emitir a Nota Fiscal da Editora Pini ",74)
cDesc2    := ""
cDesc3    := ""
cNatureza := ""
aReturn   := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
SERNF     := 'COR'
nomeprog  := "NFASLI"
cPerg     := "FAT004"
nLastKey  := 0
lContinua := .T.
MHORA := TIME()
wnrel     := "NFEP_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tamanho do Formulario de Nota Fiscal (em Linhas)          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTamNf    := 66     // Apenas Informativo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas, busca o padrao da Nfiscal           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.T.)               // Pergunta no SX1

cString   := "SF2"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel     := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)

If nLastKey == 27
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica Posicao do Formulario na Impressora                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

lEnd := .f.

Processa({|lEnd| R020Proc(@lEnd)},"Aguarde","Gerando Relatorio",.t.)

Return

Static Function R020Proc()

DBSELECTAREA('SF2')
DbSetOrder(1)
If !DbSeek(xFilial("SF2")+mv_par01+SERNF)
	RETURN
ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Prepara regua de impressÆo                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
tregs := LastRec()-Recno()+1

ProcRegua(tregs)

LIN    := 0
LI     := 0
INICIO :=.T.

WHILE !Eof() .and. SF2->F2_FILIAL == xFilial("SF2") .and. SF2->F2_DOC >= MV_PAR01 .AND. SF2->F2_DOC <= MV_PAR02 .and. !lEnd
	IF SF2->F2_SERIE#"COR"
		DBSKIP()
		LOOP
	ENDIF
	
	IncProc("Nota: "+SF2->F2_SERIE+SF2->F2_DOC)
	
	XNFISCAL := SF2->F2_DOC
	XSERIE   := SF2->F2_SERIE
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  Inicio do levantamento dos dados da Nota Fiscal             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DBSELECTAREA("SD2")
	DBSETORDER(3)
	DBSEEK(XFILIAL("SD2")+XNFISCAL+SERNF)
	XPEDIDO := SD2->D2_PEDIDO
	
	DBSELECTAREA("SC5")
	DBSETORDER(1)
	IF DBSEEK(XFILIAL("SC5")+XPEDIDO)
		XTIPOOP  := SC5->C5_TIPOOP
		XCODPROM := SC5->C5_CODPROM
		XRESPCOB := SC5->C5_RESPCOB
		xMENSNF  := SUBSTR(SC5->C5_MENNOTA,1,45)
	ENDIF
	
	DBSELECTAREA("SC6")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SC6")+XPEDIDO)
	XCODDEST := SC6->C6_CODDEST
	
	DbSelectArea("SF2")
	DbSetOrder(1)
	DbSeek(xFilial("SF2")+xnfiscal+xserie)
	*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
	*                          CABECALHO DA NOTA                         *
	*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
	NOTA_NUM     := SF2->F2_DOC
	NOTA_EMIS    := SF2->F2_EMISSAO                         && DATA EMISSAO
	NOTA_CLIE    := SF2->F2_CLIENTE                         && CODIGO DO CLIENTE
	NOTA_LOJA    := SF2->F2_LOJA                            && CODIGO DA LOJA
	NOTA_MERC    := SF2->F2_VALMERC                         && VALOR MERCADORIA
	NOTA_TOTA    := SF2->F2_VALBRUT                         && VALOR BRUTO FATURADO
	NOTA_VEND    := SF2->F2_VEND1                           && CODIGO VENDEDOR
	NOTA_COND    := SF2->F2_COND                            && CONDICAO PAGAMENTO
	NOTA_DESPREM := SF2->F2_DESPREM
	MPREFIX      := SF2->F2_PREFIXO
	
	*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
	*                          DADOS DO CLIENTE                          *
	*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
	DbSelectArea("SA1")
	DBSEEK(xFilial("SA1")+NOTA_CLIE+NOTA_LOJA)
	IF SA1->A1_CGC == SPACE(14)
		CLIE_CGC  := SA1->A1_CGCVAL
	ELSE
		CLIE_CGC  := SA1->A1_CGC
	ENDIF
	CLIE_NOME := SA1->A1_NOME
	CLIE_INSC := SA1->A1_INSCR
	CLIE_ENDE := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060321
	CLIE_BAIR := SA1->A1_BAIRRO
	CLIE_MUNI := SA1->A1_MUN
	CLIE_ESTA := SA1->A1_EST
	CLIE_CEP  := SA1->A1_CEP
	CLIE_COBR := SA1->A1_ENDCOB
	CLIE_FONE := SA1->A1_TEL
	**  DADOS DO DESTINATARIO, SE FOR O MESMO CLIENTE
	MDEST     := SA1->A1_NOME
	MENDD     := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060321
	MBAIRROD  := SA1->A1_BAIRRO
	MCIDADED  := SA1->A1_MUN
	MESTADOD  := SA1->A1_EST
	MCEPD     := SA1->A1_CEP
	
	*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
	*                          ENDERECO DE COBRANCA                     *
	*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
	
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
		XENDC    := ALLTRIM(Z5_TPLOG)+ " " + ALLTRIM(Z5_LOGR) + " " + ALLTRIM(Z5_NLOGR) + " " + ALLTRIM(Z5_COMPL) //20060321
		XBAIRROC := SZ5->Z5_BAIRRO
		XCIDADEC := SZ5->Z5_CIDADE
		XESTADOC := SZ5->Z5_ESTADO
		XCEPC    := SZ5->Z5_CEP
	ELSE
		XENDC    := ' '
		XBAIRROC := ' '
		XCIDADEC := ' '
		XESTADOC := ' '
		XCEPC    := SPACE(8)
	ENDIF
	*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
	*                      DEFINE CONDICAO DE PAGAMENTO P/TIPO DE OPER                 *
	*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
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
	DO CASE
		CASE XQTDEP == 1 .AND. XPAGA1 == 'S'
			MQUITADA := 'PARCELA QUITADA.'
		CASE XQTDEP > 1 .AND. XPAGA1 == 'S' .AND. XPAGAD == 'N'
			MQUITADA := 'PARCELA QUITADA.'
			OTHERWISE
			MQUITADA := ' '
	ENDCASE
	
	*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
	*                //   IMPRESSAO DA CONFIRMACAO DO PEDIDO     *
	*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
    
//    SetPrc(0,0)
    @ 00,00 psay avalimp(80)
	
//	l:=6
	l := 7
	@ l,59 PSAY XPEDIDO+'/'+nota_NUM
	@ l+3,011 PSAY CLIE_NOME     + '  Cod.cli.: ' +NOTA_CLIE            && nome do cliente
	@ l+4,011 PSAY CLIE_ENDE                         && endereco do cliente
	@ l+5,011 PSAY CLIE_BAIR                         && bairro
	@ l+6,011 PSAY SUBS(CLIE_CEP,1,5)+'-'+SUBS(CLIE_CEP,6,3)   && cep do cliente
	@ l+6,023 PSAY CLIE_MUNI                         && cep do cliente
	@ l+6,065 PSAY CLIE_ESTA                       && fone do cliente
	@ l+7,011 PSAY 'CNPJ/CPF :'+CLIE_CGC                          && c.g.c.
	@ L+8,011 PSAY 'INSCR.EST.'+CLIE_INSC                         && inscricao estadual
	
	IF XENDC==' '
		@ L+11,11 PSAY 'O MESMO  '
	ELSE
		@ L+12,011 PSAY XRESPCOB
		@ L+13,011 PSAY XENDC
		@ L+14,011 PSAY XBAIRROC
		@ L+15,011 PSAY SUBS(XCEPC,1,5)+'-'+SUBS(XCEPC,6,3)
		@ L+15,022 PSAY XCIDADEC
		@ L+15,050 PSAY XESTADOC
		
	ENDIF
	//****************************
	IF SC5->C5_CLIFAT#' '
		DBSELECTAREA("SA1")
		DBSEEK(XFILIAL()+SC5->C5_CLIENTE)
		IF FOUND()
			MDEST    := SA1->A1_NOME
			MENDD    := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060321
			MBAIRROD := SA1->A1_BAIRRO
			MCIDADED := SA1->A1_MUN
			MESTADOD := SA1->A1_EST
			MCEPD    := SA1->A1_CEP
		ENDIF
	ELSE
		IF VAL(XCODDEST)#0
			DBSELECTAREA("SZN")
			dbsetorder(1)
			DBSEEK(XFILIAL()+SC5->C5_CLIENTE+XCODDEST)
			IF FOUND()
				MDEST := ZN_NOME
			ENDIF
			
			DBSELECTAREA("SZO")
			dbsetorder(1)
			DBSEEK(XFILIAL()+SC5->C5_CLIENTE+XCODDEST)
			IF FOUND()
				MENDD    := ALLTRIM(ZO_TPLOG)+ " " + ALLTRIM(ZO_LOGR) + " " + ALLTRIM(ZO_NLOGR) + " " + ALLTRIM(ZO_COMPL) //20060321
				MBAIRROD := SZO->ZO_BAIRRO
				MCIDADED := SZO->ZO_CIDADE
				MESTADOD := SZO->ZO_ESTADO
				MCEPD    := SZO->ZO_CEP
			ELSE
				DBSELECTAREA("SA1")
				DBSETORDER(1)
				DBSEEK(XFILIAL()+NOTA_CLIE)
				//  MDEST   :=  A1_NOME
				MENDD    :=  ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060321
				MBAIRROD :=  A1_BAIRRO
				MCEPD    :=  A1_CEP
				MCIDADED :=  A1_MUN
				MESTADOD :=  A1_EST
			ENDIF
		ENDIF
	ENDIF
/*
	@ L+15,011 PSAY MDEST
	@ L+16,011 PSAY MENDD+ ' ' +MBAIRROD
	@ L+17,011 PSAY SUBS(MCEPD,1,5)+'-'+SUBS(MCEPD,6,3)+' '+MCIDADED+' '+MESTADOD
*/

	@ L+16,011 PSAY MDEST
	@ L+17,011 PSAY MENDD
	@ L+18,011 PSAY MBAIRROD
	@ L+19,011 PSAY SUBS(MCEPD,1,5)+'-'+SUBS(MCEPD,6,3)+' '+MCIDADED+' '+MESTADOD

	LIN := L+22 //LIN+22
//	LI  := 0                 
	LI  := 2
	DbSelectArea('SD2')
	DbSetOrder(3)
	DBSEEK(xFilial()+NOTA_NUM+SERNF)
	WHILE NOTA_NUM==SD2->D2_DOC .AND.  .NOT. EOF()
		IF SD2->D2_SERIE #SERNF
			DBSKIP()
			LOOP
		ENDIF
		IF SD2->D2_doc #NOTA_NUM
			EXIT
			LOOP
		ENDIF
		
		ITEM_CODI := SD2->D2_COD                         && codigo produto
		MCODREV   := SUBS(D2_COD,1,4)
		ITEM_item := SD2->D2_ITEMPV                       && codigo produto
		ITEM_QUAN := ABS(SD2->D2_QUANT)                  && quantidade
		ITEM_VUNI := ABS(SD2->D2_PRCVEN)                 && preco unitario
		ITEM_TOTA := ABS(SD2->D2_TOTAL)                  && preco total
		ITEM_ABAT := SD2->D2_DESC                        && desconto
		
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial()+ITEM_CODI)
		ITEM_UNID := SB1->B1_UM                     && unidade do produto
		ITEM_DESC := SUBS(SB1->B1_DESC,1,24)        && descricao do produto
		
		*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
		*                       Detalhes do Item - Produto                    *
		*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
		@ LIN+LI,011 PSAY ALLTRIM(ITEM_CODI)                      && imprime cod do produto
// 		@ LIN+LI,020 PSAY ITEM_DESC  // 06/06        
        @ LIN+LI,020 PSAY ALLTRIM(ITEM_DESC)
		@ LIN+LI,55 PSAY ITEM_TOTA PICTURE '@E 9,999,999.99'
		DBSELECTAREA("SC6")
		DBSETORDER(1)
		DBSEEK(XFILIAL()+XPEDIDO+ITEM_ITEM)
		IF FOUND()
			MEDINIC:=STR(C6_EDINIC,4,0)
			MEDFIN:=STR(C6_EDFIN,4,0)
		ELSE
			MEDINIC:=' '
			MEDFIN:=' '
		ENDIF
		IF VAL(MEDINIC)#0
			DBSELECTAREA("SZJ")
			DBSEEK(XFILIAL()+MCODREV+MEDINIC)
			IF FOUND()
				MDTINIC:=DTOC(ZJ_DTCIRC)
			ELSE
				MDTINIC:=' '
			ENDIF
			DBSEEK(XFILIAL()+MCODREV+MEDFIN)
			IF FOUND()
				MDTFIN:=DTOC(ZJ_DTCIRC)
			ELSE
				MDTFIN:=' '
			ENDIF
			
			LI:=LI+1
			
			* CICERO VAI TESTAR O IF ABAIXO
			IF SUBS(ITEM_CODI,1,2)=='01'
				@ LIN+LI,020 PSAY 'EDI€OES:'+MEDINIC +'-'+MDTINIC+ ' A '+ MEDFIN+'-'+MDTFIN
			ENDIF
		ENDIF
		DbselectArea("SD2")
		IF SD2->D2_TES=='650' .OR. SD2->D2_TES=='651' .AND. XCODPROM=='ENS' .OR. XCODPROM=='A01'
			DO CASE
				CASE  VAL(SD2->D2_ITEM)>1
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
			ENDCASE
		ENDIF
		
		DBSKIP()
		LIN:=LIN+1
	ENDDO
	DBSELECTAREA("SF2")
	
	IF NOTA_DESPREM <> 0
		NOTA_TOTA :=NOTA_MERC + NOTA_DESPREM
	END
	
	@ 45,59 PSAY  STR(NOTA_DESPREM,12,2)
	@ 46,59 PSAY  STR(NOTA_TOTA,12,2)
	
	If xDescDupl=="S"
		DbSelectArea("SE1")
		DbSetOrder(1)
		DBSEEK(xFilial()+MPREFIX+NOTA_NUM)
		WHILE SE1->E1_PREFIXO == MPREFIX  .AND. SE1->E1_NUM == NOTA_NUM .AND. ! EOF()
			IF SE1->E1_SERIE#'COR'
				DBSKIP()
				LOOP
			ENDIF
			IF SE1->E1_PARCELA=='A'.OR. SE1->E1_PARCELA==' '
				IF SE1->E1_PARCELA==' '
					MPARCELA:='UNICA'
					MCOLU:=12
				ELSE
					MPARCELA:=SE1->E1_PARCELA
					MCOLU:=014
				ENDIF
				@ 50,MCOLU PSAY  MPARCELA
				@ 50,019 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99'
				@ 50,45 PSAY DTOC(SE1->E1_VENCTO)+ '  ' + MQUITADA
			ENDIF
			IF SE1->E1_PARCELA=='B'
				@ 51,MCOLU PSAY  SE1->E1_PARCELA
				@ 51,019 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99'
				@ 51,45 PSAY SE1->E1_VENCTO
			ENDIF
			IF SE1->E1_PARCELA=='C'
				@ 52,MCOLU PSAY SE1->E1_PARCELA
				@ 52,019 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99'
				@ 52,045 PSAY SE1->E1_VENCTO
			ENDIF
			IF SE1->E1_PARCELA=='D'
				@ 53,MCOLU PSAY SE1->E1_PARCELA
				@ 53,019 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99'
				@ 53,045 PSAY SE1->E1_VENCTO
			ENDIF
			IF SE1->E1_PARCELA=='E'
				@ 54,MCOLU PSAY SE1->E1_PARCELA
				@ 54,019 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99'
				@ 54,045 PSAY SE1->E1_VENCTO
			ENDIF
			IF SE1->E1_PARCELA=='F'
				@ 55,MCOLU PSAY SE1->E1_PARCELA
				@ 55,019 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99'
				@ 55,045 PSAY SE1->E1_VENCTO
			ENDIF
			dbSkip()
		end
	ELSE
		IF XPAGA1=="S"
			IF XPAGAD=="S" .OR. XQTDEP=1
				@ 48,019 PSAY ' PEDIDO QUITADO  '
			ENDIF
		ENDIF
	endif
	
	* TESTAR
	IF SUBS(ITEM_CODI,1,2)=='02' .OR. SUBS(ITEM_CODI,1,2)=='07'
		@ 54,11 PSAY 'O(S) LIVRO(S) SERA(AO) ENVIADO(S) APOS A QUITACAO DO BOLETO ANEXO.'
		@ 55,11 PSAY 'DEMAIS PARCELAS, SE EXISTIREM, SERAO ENVIADAS COM A NF E LIVRO(S).'
	ENDIF
	
	DBSELECTAREA("SA3")
	DBSEEK(XFILIAL("SA3")+NOTA_VEND)
	MNOMEV := A3_NOME
	@ 56,34 PSAY  NOTA_VEND+'/'+MNOMEV
	@ 58,70 PSAY  XCODFAT
	@ 59,20 PSAY XMENSNF
	@ 61,20 PSAY DATE()
	
	DbSelectArea("SF2")
	DBSETORDER(1)
	DBSKIP()
	//set device to screen
	
	//SETPRC(0,0)
	
	//set device to printer

	LIN := 6       
	LI  := 0
END

set device to printer

SETPRC(0,0)

SET DEVICE TO SCREEN

DBSELECTAREA("SC6")
DBSETORDER(1)
DBSELECTAREA("SD2")
DBSETORDER(1)

IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()

Return