#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
//Danilo C S Pala 20060322: dados de enderecamento do DNE
//Danilo C S Pala 20100305: ENDBP
//Danilo C S Pala 20100428: serie = UNI
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддддддддддддбддддддддддддддддддддддддддддддбдддддддддддддддддд© ╠╠
╠╠ЁPrograma: PFAT021   ЁAutor: Solange Nalini         Ё Data:   26/03/98 Ё ╠╠
╠╠цддддддддддддддддддддаддддддддддддддддддддддддддддддадддддддддддддддддд╢ ╠╠
╠╠ЁDescri┤ao: Notas fiscais de assinaturas e livros (impressora OKIDATA) Ё ╠╠
╠╠цдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢ ╠╠
╠╠ЁUso      : M╒dulo de Faturamento                                      Ё ╠╠
╠╠юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды ╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
User Function Rfat023()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,LIMITE,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CNATUREZA,ARETURN,SERNF,NOMEPROG")
SetPrvt("CPERG,NLASTKEY,LCONTINUA,WNREL,NTAMNF,CSTRING")
SetPrvt("TREGS,M_MULT,P_ANT,P_ATU,P_CNT,M_SAV20")
SetPrvt("M_SAV7,INICIO,XNFISCAL,XSERIE,XPEDIDO,XTIPOOP")
SetPrvt("XCODPROM,XRESPCOB,XMENSNF,XMENSES1,XMENSES2,XMENSES3")
SetPrvt("XCODDEST,NOTA_NUM,NOTA_EMIS,NOTA_CLIE,NOTA_LOJA,NOTA_MERC")
SetPrvt("NOTA_TOTA,NOTA_DESC,NOTA_VEND,NOTA_COND,NOTA_DESPREM,MPREFIX")
SetPrvt("CLIE_CGC,CLIE_NOME,CLIE_INSC,CLIE_ENDE,CLIE_BAIR,CLIE_MUNI")
SetPrvt("CLIE_ESTA,CLIE_CEP,CLIE_COBR,CLIE_FONE,MDEST,MENDD")
SetPrvt("MBAIRROD,MCIDADED,MESTADOD,MCEPD,XENDC,XBAIRROC")
SetPrvt("XCIDADEC,XESTADOC,XCEPC,XDESCRNF,XDESCDUPL,XPAGA1")
SetPrvt("XPAGAD,XQTDEP,XCODFAT,MQUITADA,L,ITEM_CODI")
SetPrvt("MCODREV,ITEM_ITEM,ITEM_QUAN,ITEM_VUNI,ITEM_TOTA,ITEM_ABAT")
SetPrvt("ITEM_UNID,ITEM_DESC,MEDINIC,MEDFIN,MDTINIC,MDTFIN")
SetPrvt("XMENSNF1,XMENSNF2,XMENSNF3,MPARCELA,MCOLU,MNOMEV,mhora")

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis utilizadas para parametros                         Ё
//Ё mv_par01             // Lote                                 Ё
//Ё mv_par02             // Data                                 Ё
//Ё mv_par03             Serie									 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
li        := 0
LIN       := 0
CbTxt     := ""
CbCont    := ""
nOrdem    := 0
Alfa      := 0
Z         := 0
M         := 0
tamanho   := "G"
limite    := 220
titulo    := PADC("Nota Fiscal - Nfiscal",74)
cDesc1    := PADC("Este programa ira emitir a Nota Fiscal da Editora Pini ",74)
cDesc2    := ""
cDesc3    := ""
cNatureza := ""

aReturn   := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
SERNF     := 'UNI'
nomeprog  := "NFASLI"
cPerg     := "FAT004"
nLastKey  := 0
lContinua := .T.
MHORA := TIME()
wnrel     := "NFEP_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Tamanho do Formulario de Nota Fiscal (em Linhas)          Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nTamNf := 66     // Apenas Informativo

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica as perguntas selecionadas, busca o padrao da Nfiscal           Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte(cPerg,.T.)               // Pergunta no SX1

cString := "SF2"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Envia controle para a funcao SETPRINT                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)

If nLastKey == 27
	Return
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica Posicao do Formulario na Impressora                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

lEnd := .f.

Processa({|lEnd| R023Proc(@lEnd)},"Aguarde","Imprimindo",.t.)

Return

Static Function R023Proc()    
SERNF := MV_PAR03 //20100428

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё  Prepara regua de impressфo                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
tregs := IIF(Val(MV_PAR02)<>Val(MV_PAR01),Abs(Val(MV_PAR02)-Val(MV_PAR01)),1)   //LastRec()-Recno()+1

DBSELECTAREA('SF2')
DbSetOrder(1)
If !DbSeek(xFilial()+mv_par01+SERNF)
	RETURN
ENDIF

LIN    := 0
LI     := 0
INICIO := .T.

ProcRegua(tRegs)

WHILE !Eof() .and. SF2->F2_FILIAL == xFilial("SF2") .and. SF2->F2_DOC >= MV_PAR01 .AND.  SF2->F2_DOC <= MV_PAR02 .and. !lEnd
	IF SF2->F2_SERIE # SERNF //20100428
		DBSKIP()
		LOOP
	ENDIF
	
	IncProc("Nota: "+SF2->F2_SERIE+SF2->F2_DOC)
	
	NOTA_DESC:= 0
	XNFISCAL := SF2->F2_DOC
	XSERIE   := SF2->F2_SERIE
	NOTA_DESC:= SF2->F2_DESCONT
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё  Inicio do levantamento dos dados da Nota Fiscal             Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	DBSELECTAREA("SD2")
	DBSETORDER(3)
	DBSEEK(XFILIAL()+XNFISCAL+SERNF)
	XPEDIDO := SD2->D2_PEDIDO
	
	DBSELECTAREA("SC5")
	DBSETORDER(1)
	IF DBSEEK(XFILIAL()+XPEDIDO)
		XTIPOOP  := SC5->C5_TIPOOP
		XCODPROM := SC5->C5_CODPROM
		XRESPCOB := SC5->C5_RESPCOB
		xMENSNF  := SUBSTR(SC5->C5_MENNOTA,1,45)
		
		// GILBERTO - 01.12.2000 - ESSERE CORTESIA.
		IF !EMPTY(SC5->C5_MENPAD)
			XMENSES1 := SUBSTR(FORMULA(SC5->C5_MENPAD),1,45)
			XMENSES2 := SUBSTR(FORMULA(SC5->C5_MENPAD),46,60)
		ELSE
			XMENSES1 := " "
			XMENSES2 := " "
		ENDIF
		// RAQUEL 14/08/01 - CONVERSAO DA REVISTA
		IF NOTA_DESC > 0
			XMENSES3 := 'DESCONTO..R$ '+STR(NOTA_DESC,5,2)
		ELSE
			XMENSES3 := " "
		ENDIF
	ENDIF
	
	DBSELECTAREA("SC6")
	DBSETORDER(1)
	DBSEEK(XFILIAL()+XPEDIDO)
	XCODDEST := SC6->C6_CODDEST
	
	DbSelectArea("SF2")
	DbSetOrder(1)
	DbSeek(xFilial()+xnfiscal+xserie)
	
	//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	//*                          CABECALHO DA NOTA                         *
	//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	NOTA_NUM     := SF2->F2_DOC
	NOTA_EMIS    := SF2->F2_EMISSAO                         // DATA EMISSAO
	NOTA_CLIE    := SF2->F2_CLIENTE                         // CODIGO DO CLIENTE
	NOTA_LOJA    := SF2->F2_LOJA                            // CODIGO DA LOJA
	NOTA_MERC    := SF2->F2_VALMERC                         // VALOR MERCADORIA
	NOTA_TOTA    := SF2->F2_VALBRUT                         // VALOR BRUTO FATURADO
	NOTA_DESC    := SF2->F2_DESCONT                         // DESCONTO EM VALOR
	NOTA_VEND    := SF2->F2_VEND1                           // CODIGO VENDEDOR
	NOTA_COND    := SF2->F2_COND                            // CONDICAO PAGAMENTO
	NOTA_DESPREM := SF2->F2_DESPREM
	MPREFIX      := SF2->F2_PREFIXO
	
	// *дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	// *                          DADOS DO CLIENTE                          *
	// *дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	DbSelectArea("Sa1")
	DBSEEK(xFilial()+NOTA_CLIE+NOTA_LOJA)
	IF SA1->A1_CGC == SPACE(14)
		CLIE_CGC := SA1->A1_CGCVAL
	ELSE
		CLIE_CGC := SA1->A1_CGC
	ENDIF
	CLIE_NOME := SA1->A1_NOME
	CLIE_INSC := SA1->A1_INSCR
	CLIE_ENDE := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060322
	CLIE_BAIR := SA1->A1_BAIRRO
	CLIE_MUNI := SA1->A1_MUN
	CLIE_ESTA := SA1->A1_EST
	CLIE_CEP  := SA1->A1_CEP
	CLIE_COBR := SA1->A1_ENDCOB
	CLIE_FONE := SA1->A1_TEL
	//*  DADOS DO DESTINATARIO, SE FOR O MESMO CLIENTE
	MDEST     := SA1->A1_NOME
	MENDD     := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060322
	MBAIRROD  := SA1->A1_BAIRRO
	MCIDADED  := SA1->A1_MUN
	MESTADOD  := SA1->A1_EST
	MCEPD     := SA1->A1_CEP
	
	//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	//*                         ENDERECO DE COBRANCA                     *
	//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*

	//20100305 DAQUI
	IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
		DbSelectArea("ZY3")
		DbSetOrder(1)
		DbSeek(XFilial()+NOTA_CLIE+NOTA_LOJA)
		XENDC :=ZY3_END
		XBAIRROC :=ZY3_BAIRRO
		XCIDADEC :=ZY3_CIDADE
		XESTADOC :=ZY3_ESTADO
		XCEPC  :=ZY3_CEP
  ELSEIF SUBS(SA1->A1_ENDCOB,1,1)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
		DbSelectArea("SZ5")
		DbSetOrder(1)
		DbSeek(XFilial()+NOTA_CLIE+NOTA_LOJA)
		XENDC    := ALLTRIM(Z5_TPLOG)+ " " + ALLTRIM(Z5_LOGR) + " " + ALLTRIM(Z5_NLOGR) + " " + ALLTRIM(Z5_COMPL) //20060322
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
	
	//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	//*        DEFINE CONDICAO DE PAGAMENTO P/TIPO DE OPER                 *
	//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	IF XTIPOOP == '99'
		XDESCRNF  := 'CONF.ABAIXO'
		XDESCDUPL := 'CR'                 //CONSULTA CONTAS A RECEBER
	ELSE
		DbSelectArea("SZ9")
		DbSetOrder(2)
		If DbSeek(XTIPOOP)
			XDESCRNF  := SZ9->Z9_DESCRNF
			XDESCDUPL := SZ9->Z9_DESCDUP
			XPAGA1    := SZ9->Z9_PAGA1
			XPAGAD    := SZ9->Z9_PAGAD
			XQTDEP    := SZ9->Z9_QTDEP
			XCODFAT   := SZ9->Z9_CODFAT
		ENDIF
	ENDIF
	IF XQTDEP == 1 .AND. XPAGA1 == 'S'
		MQUITADA := 'PARCELA QUITADA.'
	ELSEIF XQTDEP > 1 .AND. XPAGA1 == 'S' .AND. XPAGAD == 'N'
		MQUITADA := 'PARCELA QUITADA.'
	ELSE
		MQUITADA := ' '
	ENDIF
	
	//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	//*                   IMPRESSAO DA CONFIRMACAO DO PEDIDO       *
	//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	L := 6
	@ L,59 PSAY XPEDIDO+'/'+nota_NUM
	@ L+3,011 PSAY CLIE_NOME     + '  cod.cli.: ' +NOTA_CLIE            // nome do cliente
	@ L+4,011 PSAY CLIE_ENDE                         // endereco do cliente
	@ L+5,011 PSAY CLIE_BAIR                         // bairro
	@ L+6,011 PSAY SUBS(CLIE_CEP,1,5)+'-'+SUBS(CLIE_CEP,6,3)   // cep do cliente
	@ L+6,023 PSAY CLIE_MUNI                         // cep do cliente
	@ L+6,065 PSAY CLIE_ESTA                       // fone do cliente
	@ L+7,011 PSAY 'CNPJ/CPF :'+CLIE_CGC                          // c.g.c.
	@ L+8,011 PSAY 'INSCR.EST.'+CLIE_INSC                         // inscricao estadual
	
	IF XENDC==' '
		@ L+11,11 PSAY 'O MESMO  '
	ELSE
		@ L+10,011 PSAY XRESPCOB
		@ L+11,011 PSAY XENDC
		@ L+12,011 PSAY XBAIRROC
		@ L+13,011 PSAY SUBS(XCEPC,1,5)+'-'+SUBS(XCEPC,6,3)
		@ L+13,022 PSAY XCIDADEC
		@ L+13,050 PSAY XESTADOC
	ENDIF
	//****************************
	IF SC5->C5_CLIFAT # ' '
		DBSELECTAREA("SA1")
		IF DBSEEK(XFILIAL()+SC5->C5_CLIENTE)
			MDEST    := SA1->A1_NOME
			MENDD    := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060322
			MBAIRROD := SA1->A1_BAIRRO
			MCIDADED := SA1->A1_MUN
			MESTADOD := SA1->A1_EST
			MCEPD    := SA1->A1_CEP
		ENDIF
	ELSE
		IF VAL(XCODDEST)#0
			DBSELECTAREA("SZN")
			dbsetorder(1)
			IF DBSEEK(XFILIAL()+SC5->C5_CLIENTE+XCODDEST)
				MDEST := ZN_NOME
			ENDIF
			
			DBSELECTAREA("SZO")
			dbsetorder(1)
			DBSEEK(XFILIAL()+SC5->C5_CLIENTE+XCODDEST)
			IF FOUND()
				MENDD    := ALLTRIM(SZO->ZO_TPLOG) + " " + ALLTRIM(SZO->ZO_LOGR) + " " + ALLTRIM(SZO->ZO_NLOGR) + " " + ALLTRIM(SZO->ZO_COMPL) //20060322
				MBAIRROD := SZO->ZO_BAIRRO
				MCIDADED := SZO->ZO_CIDADE
				MESTADOD := SZO->ZO_ESTADO
				MCEPD    := SZO->ZO_CEP
			ELSE
				DBSELECTAREA("SA1")
				DBSETORDER(1)
				DBSEEK(XFILIAL()+NOTA_CLIE)
				//  MDEST   :=  A1_NOME
				MENDD    := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060322
				MBAIRROD := SA1->A1_BAIRRO
				MCEPD    := SA1->A1_CEP
				MCIDADED := SA1->A1_MUN
				MESTADOD := SA1->A1_EST
			ENDIF
		ENDIF
		
	ENDIF
	@ L+15,011 PSAY MDEST
	@ L+16,011 PSAY MENDD
	@ L+17,011 PSAY MBAIRROD
	@ L+18,011 PSAY SUBS(MCEPD,1,5)+'-'+SUBS(MCEPD,6,3)+' '+MCIDADED+' '+MESTADOD
	LIN := L+22 //LIN := LIN+22
	LI  := 0
	DbSelectArea('SD2')
	DbSetOrder(3)
	DBSEEK(xFilial()+NOTA_NUM+SERNF)
	WHILE !Eof() .AND. SD2->D2_FILIAL == xFilial("SD2") .and. NOTA_NUM == SD2->D2_DOC
		IF SD2->D2_SERIE # SERNF
			DBSKIP()
			LOOP
		ENDIF
		IF SD2->D2_DOC # NOTA_NUM
			EXIT
			LOOP
		ENDIF
		
		ITEM_CODI := SD2->D2_COD                         // codigo produto
		MCODREV   := SUBS(SD2->D2_COD,1,4)
		ITEM_item := SD2->D2_ITEMPV                      // codigo produto
		ITEM_QUAN := ABS(SD2->D2_QUANT)                 // quantidade
		ITEM_VUNI := ABS(SD2->D2_PRCVEN)                // preco unitario
		ITEM_TOTA := ABS(SD2->D2_TOTAL)                  // preco total
		ITEM_ABAT := SD2->D2_DESC                        // desconto
		
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial()+ITEM_CODI)
		ITEM_UNID := SB1->B1_UM                     // unidade do produto
		ITEM_DESC := SUBS(SB1->B1_DESC,1,24)        // descricao do produto
		
		//*ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
		//*                       Detalhes do Item - Produto                    *
		//*ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
		DBSELECTAREA("SC6")
		DBSETORDER(1)
		DBSEEK(XFILIAL()+XPEDIDO+ITEM_ITEM)
		IF ALLTRIM(SC6->C6_TES) $ "650/651"
			ITEM_DESC := ITEM_DESC+' - CORTESIA'
		ENDIF
		@ LIN+LI,011 PSAY ITEM_CODI                      // imprime cod do produto
		@ LIN+LI,020 PSAY ITEM_DESC
		@ LIN+LI,055 PSAY ITEM_TOTA PICTURE '@E 9,999,999.99'
		
		IF FOUND()
			MEDINIC := STR(SC6->C6_EDINIC,4,0)
			MEDFIN  := STR(SC6->C6_EDFIN,4,0)
		ELSE
			MEDINIC := ' '
			MEDFIN  := ' '
		ENDIF
		IF VAL(MEDINIC) # 0
			DBSELECTAREA("SZJ")
			DBSEEK(XFILIAL()+MCODREV+MEDINIC)
			IF FOUND()
				MDTINIC := DTOC(ZJ_DTCIRC)
			ELSE
				MDTINIC := ' '
			ENDIF
			IF DBSEEK(XFILIAL()+MCODREV+MEDFIN)
				MDTFIN := DTOC(ZJ_DTCIRC)
			ELSE
				MDTFIN := ' '
			ENDIF
			
			LI++
			
			// CICERO VAI TESTAR O IF ABAIXO
			IF SUBS(ITEM_CODI,1,2) == '01'
				@ LIN+LI,020 PSAY 'EDI─OES:'+MEDINIC +'-'+MDTINIC+ ' A '+ MEDFIN+'-'+MDTFIN
			ENDIF
		ENDIF
		DbselectArea("SD2")
		IF Alltrim(SD2->D2_TES) $ "650/651" .AND. XCODPROM == 'ENS' .OR. XCODPROM == 'A01'
			IF  VAL(SD2->D2_ITEM)>1
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
	END
	
	DBSELECTAREA("SF2")
	
	IF NOTA_DESPREM <> 0
		NOTA_TOTA :=NOTA_MERC + NOTA_DESPREM
	END
	
	@ 42,58 PSAY  STR(NOTA_DESPREM,12,2)
	@ 43,58 PSAY  STR(NOTA_TOTA,12,2)
	
	If xDescDupl == "S"
		DbSelectArea("SE1")
		DbSetOrder(1)
		DBSEEK(xFilial()+MPREFIX+NOTA_NUM)
		WHILE !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_PREFIXO == MPREFIX  .AND. SE1->E1_NUM == NOTA_NUM
			IF SE1->E1_SERIE # SERNF //20100428
				DBSKIP()
				LOOP
			ENDIF
			IF SE1->E1_PARCELA == 'A' .OR. SE1->E1_PARCELA == ' '
				IF SE1->E1_PARCELA == ' '
					MPARCELA := 'UNICA'
					MCOLU    := 12
				ELSE
					MPARCELA := SE1->E1_PARCELA
					MCOLU    := 014
				ENDIF
				@ 47,MCOLU PSAY  MPARCELA
				@ 47,019 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99'
				@ 47,045 PSAY DTOC(SE1->E1_VENCTO)+ '  ' + MQUITADA
			ENDIF
			IF SE1->E1_PARCELA=='B'
				@ 48,MCOLU PSAY  SE1->E1_PARCELA
				@ 48,019 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99'
				@ 48,045 PSAY SE1->E1_VENCTO
			ENDIF
			IF SE1->E1_PARCELA=='C'
				@ 49,MCOLU PSAY SE1->E1_PARCELA
				@ 49,019 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99'
				@ 49,045 PSAY SE1->E1_VENCTO
			ENDIF
			IF SE1->E1_PARCELA=='D'
				@ 50,MCOLU PSAY SE1->E1_PARCELA
				@ 50,019 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99'
				@ 50,045 PSAY SE1->E1_VENCTO
			ENDIF
			IF SE1->E1_PARCELA=='E'
				@ 51,MCOLU PSAY SE1->E1_PARCELA
				@ 51,019 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99'
				@ 51,045 PSAY SE1->E1_VENCTO
			ENDIF
			IF SE1->E1_PARCELA=='F'
				@ 52,MCOLU PSAY SE1->E1_PARCELA
				@ 52,019 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99'
				@ 52,045 PSAY SE1->E1_VENCTO
			ENDIF
			dbSkip()
		end
	ELSE
		IF XPAGA1 == "S"
			IF XPAGAD == "S" .OR. XQTDEP == 1 .OR. SUBS(SC5->C5_TIPOOP,1,1) == 'C'
				@ 48,019 PSAY ' PEDIDO QUITADO  '
			ENDIF
		ENDIF
	endif
	
	// TESTAR
	IF SUBS(ITEM_CODI,1,2)=='02'
		@ 50,11 PSAY ' O LIVRO SERA ENVIADO APOS A QUITA─AO DO BOLETO ANEXO'
	ENDIF
	
	// RAQUEL 14/08/01 - CONVERSAO DA REVISTA
	IF NOTA_DESC<>0
		XMENSES3 := 'DESCONTO..R$ '+STR(NOTA_DESC,5,2)
	ELSE
		XMENSES3 := " "
	ENDIF
	
	DBSELECTAREA("SA3")
	DBSEEK(XFILIAL()+NOTA_VEND)
	MNOMEV:=A3_NOME
	@ 52,33 PSAY NOTA_VEND+'/'+MNOMEV
	@ 53,70 PSAY XCODFAT
	@ 55,20 PSAY XMENSNF
	
	@ 56,20 PSAY XMENSES1    // GILBERTO - 01.12.2000 - ESSERE BRINDE.
	
	@ 57,20 PSAY DTOC(DDATABASE)
	@ 57,30 PSAY XMENSES3
	
	DbSelectArea("SF2")
	DBSETORDER(1)
	DBSKIP()
	SET DEVICE TO SCREEN
	
	SETPRC(0,0)
	
	SET DEVICE TO PRINTER
	//       SetPrc(0,0)
	
	EJECT
	LIN := 6
	LI  := 0
END

SET DEVICE TO SCREEN

DBSELECTAREA("SC6")
RETINDEX("SC6")
DBSELECTAREA("SD2")
RETINDEX("SD2")

IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()

Return