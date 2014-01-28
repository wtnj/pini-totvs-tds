#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/ Alterado por Danilo C S Pala em 20041117 novo layout
Alterado por Danilo C S Pala em 20041213: 	// NPESOLIQUIDO       
// icms: Danilo CS Pala 20051109
//Danilo C S Pala 20060328: dados de enderecamento do DNE    
//Danilo C S Pala 20060525: DESPESA COM BOLETO
//Danilo C S Pala 20061016: Mensagem para Gold
//Danilo C S Pala 20070613: ALMOXARIFADOS DO D2_LOCAL
//Danilo C S Pala 20100305: ENDBP
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддддддддддддбддддддддддддддддддддддддддддддбдддддддддддддддддд© ╠╠
╠╠ЁPrograma: PFAT055   ЁAutor: Solange / Claudio      Ё Data:   25/05/99 Ё ╠╠
╠╠цддддддддддддддддддддаддддддддддддддддддддддддддддддадддддддддддддддддд╢ ╠╠
╠╠ЁDescri┤ao: Solicita┤фo de Notas Fiscais          (impressora OKIDATA) Ё ╠╠
╠╠цдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢ ╠╠
╠╠ЁUso      : M╒dulo de Faturamento                                      Ё ╠╠
╠╠юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды ╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
User Function Pfat055()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,XMENSNF1,XMENSNF2,XMENSNF3,XMENSNF4")
SetPrvt("TAMANHO,LIMITE,TITULO,CDESC1,CDESC2,CDESC3")
SetPrvt("CNATUREZA,ARETURN,SERNF,NOMEPROG,CPERG,NLASTKEY")
SetPrvt("LCONTINUA,WNREL,XENDC,XBAIRROC,XCIDADEC,XESTADOC")
SetPrvt("XCEPC,NTAMNF,CSTRING,TREGS,M_MULT,P_ANT")
SetPrvt("P_ATU,P_CNT,M_SAV20,M_SAV7,INICIO,XNFISCAL")
SetPrvt("XPEDIDO,XSERIE,NREGANT,XTIPOOP,XCODPROM,NOTA_NUM")
SetPrvt("NOTA_EMIS,NOTA_CLIE,NOTA_LOJA,NOTA_MERC,NOTA_TOTA,NOTA_VEND")
SetPrvt("NOTA_COND,NOTA_DESPREM,NOTA_SERIE,XTIPO,MPREFIX,NREGATU")
SetPrvt("NOTA_NATU,NOTA_COFI,NOTA_TESA,NOTA_PEDI,MD2CF,CLIE_CGC")
SetPrvt("CLIE_NOME,CLIE_INSC,CLIE_ENDE,CLIE_BAIR,CLIE_MUNI,CLIE_ESTA")
SetPrvt("CLIE_CEP,CLIE_SUF,CLIE_COBR,CLIE_TRAN,CLIE_FONE,CLIE_TIPO")
SetPrvt("XDESCRNF,XDESCDUPL,XPAGA1,XPAGAD,XQTDEP,XCODFAT")
SetPrvt("COL,COL2,MDESC,MPEDIDO,MITEM,ITEM_CODI")
SetPrvt("ITEM_QUAN,XTOTAL,ITEM_VUNI,ITEM_TOTA,ITEM_DESC,ITEM_UNID")
SetPrvt("ITEM_DESCR,MEDICAO,MQUANT,NOTA_BRUTO,NOTA_DESC,NPESOLIQUIDO")
SetPrvt("xBASE_ICMS, xVALOR_ICMS,xBSICMRET, xICMS_RET") //20051109
SetPrvt("MSOMABOL, NOTA_ALMOX,mhora")
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis utilizadas para parametros                         Ё
//Ё mv_par01             // Lote                                 Ё
//Ё mv_par02             // Data                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
li     := 0
LIN    := 0
CbTxt  := ""
CbCont := ""
nOrdem := 0
Alfa   := 0
Z      :=0
M      :=0

//   inicializa as variaveis de mensagem
XMENSNF1 := ' '
XMENSNF2 := ' '
XMENSNF3 := ' '
XMENSNF4 := ' '

tamanho  := "G"
limite   := 220
titulo   := PADC("Nota Fiscal - Nfiscal",74)
cDesc1   := PADC("Este programa ira emitir a Nota Fiscal da Editora Pini ",74)
cDesc2   := ""
cDesc3   := ""
cNatureza:= ""

aReturn  := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
SERNF    := 'UNI'
nomeprog := "NFASLI"
cPerg    := "FAT004"
nLastKey := 0
lContinua:= .T.
MHORA      := TIME()
wnrel    := "NFEP_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

//   inicializa as variaveis de Cobran┤a
XENDC    := ' '
XBAIRROC := ' '
XCIDADEC := ' '
XESTADOC := ' '
XCEPC    := SPACE(8)

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Tamanho do Formulario de Nota Fiscal (em Linhas)          Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nTamNf   := 66     // Apenas Informativo

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica as perguntas selecionadas, busca o padrao da Nfiscal           Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte(cPerg,.T.)               // Pergunta no SX1

cString:="SF2"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Envia controle para a funcao SETPRINT                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

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

// Chamada do processamento
Processa({|| P055Proc()})

Return
/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁP055PROC  ╨Autor  ЁMicrosiga           ╨ Data Ё  03/27/02   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     ЁProcessamento da Impressao                                  ╨╠╠
╠╠╨          Ё                                                            ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё PFat055                                                    ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function P055Proc()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё  Prepara regua de impressфo                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
tregs := IIF(Val(MV_PAR01) <> Val(MV_PAR02), Abs(Val(MV_PAR02)-Val(MV_PAR01)), 1)

DBSELECTAREA('SC6')
DBSETORDER(4)
If !DbSeek(xFilial()+MV_PAR01)
	RETURN
ENDIF

LIN:=PROW()
LI:=0
INICIO:=.T.

ProcRegua(tregs)

WHILE !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NOTA >= MV_PAR01 .AND.  SC6->C6_NOTA <= MV_PAR02
	XNFISCAL :=SC6->C6_NOTA
	XPEDIDO  :=SC6->C6_NUM
	XSERIE   :=SC6->C6_SERIE
	
	WHILE !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NOTA == XNFISCAL
		DBSKIP()
		IF SC6->C6_NOTA # XNFISCAL
			DBSKIP(-1)
			EXIT
		ENDIF
	ENDDO
	
	IncProc("Processando Nota " + Alltrim(SC6->C6_NOTA))
	
	NREGANT:=RECNO()
	XPEDIDO:=C6_NUM
	
	DBSELECTAREA("SC5")
	DBSETORDER(1)
	If DBSEEK(XFILIAL()+XPEDIDO)
		XTIPOOP  := SC5->C5_TIPOOP
		XCODPROM := SC5->C5_CODPROM
	ENDIF
	
	xMENSNF2 := SUBSTR(SC5->C5_MENNOTA,1,43)
	xMENSNF3 := SUBSTR(SC5->C5_MENNOTA,44,60)
	
	DbSelectArea("SF2")
	DbSetOrder(1)
	DbSeek(xFilial()+xnfiscal+xserie)
	
	//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	//*                          CABECALHO DA NOTA                         *
	//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	NOTA_NUM     :=  SF2->F2_DOC
	NOTA_EMIS    :=  SF2->F2_EMISSAO                         && DATA EMISSAO
	NOTA_CLIE    :=  SF2->F2_CLIENTE                         && CODIGO DO CLIENTE
	NOTA_LOJA    :=  SF2->F2_LOJA                            && CODIGO DA LOJA
	NOTA_MERC    :=  SF2->F2_VALMERC                         && VALOR MERCADORIA
	NOTA_TOTA    :=  SF2->F2_VALBRUT                         && VALOR BRUTO FATURADO
	NOTA_VEND    :=  SF2->F2_VEND1                           && CODIGO VENDEDOR
	NOTA_COND    :=  SF2->F2_COND                            && CONDICAO PAGAMENTO
	NOTA_DESPREM :=  SF2->F2_DESPREM                         && DESPESA REMESSA
	NOTA_SERIE   :=  SF2->F2_SERIE
	XTIPO        :=  SF2->F2_TIPO
	MPREFIX      :=  SF2->F2_PREFIXO
	//Danilo 20051109
	xBASE_ICMS   := SF2->F2_BASEICM         // Base do ICMS.
	xVALOR_ICMS  := SF2->F2_VALICM          // Valor do ICMS.
	xVALOR_IPI   := SF2->F2_VALIPI          // Valor do IPI.
	xICMS_RET    := SF2->F2_ICMSRET         // Valor do ICMS Retido.
	xBSICMRET    := 0
	
	//*ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	//*             ITENS DO CABECALHO QUE ESTAO NO ARQ. DE ITENS         *
	//*ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*  

	DbSelectArea("SD2")
	DbSetOrder(3)
	DBSEEK(xFilial()+NOTA_NUM+NOTA_SERIE)
	
	NREGATU   := RECNO()
	NOTA_NATU := ' '
	NOTA_COFI := ' '         
	NOTA_ALMOX:=' '//20070613
	
	WHILE !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .and. SD2->D2_DOC == NOTA_NUM
		IF SD2->D2_SERIE # SERNF
			DBSKIP()
			LOOP
		ENDIF
		
		NOTA_TESA := SD2->D2_TES                        && TIPO ENTRADA E SAIDA
		NOTA_PEDI := SD2->D2_PEDIDO                     && PEDIDO INTERNO
				
		DbSelectArea("SF4")
		DBSEEK(xFilial()+SD2->D2_TES)
		MD2CF := AllTrim(SD2->D2_CF)
		IF NOTA_NATU == ' '
			NOTA_NATU := TRIM(SF4->F4_TEXTO)
			NOTA_COFI := TRIM(MD2CF)
			NOTA_ALMOX:=TRIM(SD2->D2_LOCAL) //20070613
		ELSE
			IF TRIM(NOTA_NATU) # TRIM(SF4->F4_TEXTO)
				NOTA_NATU := NOTA_NATU+'/'+TRIM(SF4->F4_TEXTO)
			ENDIF
			IF TRIM(MD2CF)$(NOTA_COFI)
				NOTA_COFI := TRIM(NOTA_COFI)
			ELSE
				NOTA_COFI := TRIM(NOTA_COFI)+'/'+TRIM(SD2->D2_CF)
			ENDIF                                                
			IF TRIM(SD2->D2_LOCAL)$(NOTA_ALMOX) //20070613
				NOTA_ALMOX :=TRIM(NOTA_ALMOX) //20070613
			ELSE //20070613
				NOTA_ALMOX :=TRIM(NOTA_ALMOX)+'/'+TRIM(SD2->D2_LOCAL) //20070613
			ENDIF //20070613
		ENDIF
		DBSelectArea("SD2")
		DBSKIP()
	END
	DBGOTO(NREGATU)
	
	//              IF XCODPROM=='ENS'
	//                 IF NOTA_COFI=='511'
	//                    NOTA_COFI:='511/599'
	//                 ENDIF
	//                 IF NOTA_COFI=='611'
	//                    NOTA_COFI:='611/699'
	//                 ENDIF
	//              ENDIF
	/*
	*ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	*                     TEXTO DA CLASSIFICACAO FISCAL NO TES          *
	*ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	*/
	//              DbSelectArea("SF4")
	//              DBSEEK(xFilial()+SD2->D2_TES)
	//              NOTA_NATU := SF4->F4_TEXTO
	//              IF XCODPROM=='ENS'
	//                 NOTA_NATU:='VENDA/CORTESIA'
	//              ENDIF
	/*
	*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	*                          DADOS DO CLIENTE                          *
	*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	*/
	IF xTIPO=='N' .OR. xTIPO=='C' .OR. xTIPO=='P' .OR. xTIPO=='I' .OR. xTIPO=='S' .OR. xTIPO=='T' .OR. xTIPO=='O'
		
		DbSelectArea("SA1")
		DBSEEK(xFilial()+NOTA_CLIE+NOTA_LOJA)
		IF SA1->A1_CGC == SPACE(14)
			CLIE_CGC := SA1->A1_CGCVAL
		ELSE
			CLIE_CGC := SA1->A1_CGC
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
		
		//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
		//*                          ENDERECO DE COBRANCA                     *
		//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
		//     inicializa as variaveis de Cobran┤a
		XENDC    := ' '
		XBAIRROC := ' '
		XCIDADEC := ' '
		XESTADOC := ' '
		XCEPC    := SPACE(8)
		
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
			XBAIRROC := SZ5->Z5_BAIRRO
			XCIDADEC := SZ5->Z5_CIDADE
			XESTADOC := SZ5->Z5_ESTADO
			XCEPC    := SZ5->Z5_CEP
		ENDIF
	ELSE
		DbSelectArea("SA2")
		DbSetOrder(1)
		DbSeek(xFilial()+NOTA_CLIE+NOTA_LOJA)
		
		CLIE_CGC  := SA2->A2_CGC
		CLIE_NOME := SA2->A2_NOME
		CLIE_INSC := SA2->A2_INSCR
		CLIE_ENDE := SA2->A2_END
		CLIE_BAIR := SA2->A2_BAIRRO
		CLIE_MUNI := SA2->A2_MUN
		CLIE_ESTA := SA2->A2_EST
		CLIE_CEP  := SA2->A2_CEP
		CLIE_TRAN := SA2->A2_TRANSP
		CLIE_FONE := SA2->A2_TEL
		CLIE_TIPO := SA2->A2_TIPO
	ENDIF      
	
     //danilo 20051109
	If xICMS_RET > 0                          // Apenas se ICMS Retido > 0
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё CADASTRO LIVROS FISCAIS                                          Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		DbSelectArea("SF3")
		DbSetOrder(4)
		DbSeek(xFilial("SF3")+SA1->A1_COD+SA1->A1_LOJA+SF2->F2_DOC+SF2->F2_SERIE)
		If Found()
			xBSICMRET := F3_VALOBSE
		EndIf
	Endif

	//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	//*                      DEFINE CONDICAO DE PAGAMENTO P/TIPO DE OPER                 *
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
	
	If XQTDEP == 1 .AND. XPAGA1 == 'S'
		XMENSNF4 := 'NF QUITADA.'
	ElseIf XQTDEP > 1 .AND. XPAGA1 == 'S' .AND. XPAGAD == 'S'
		XMENSNF4 := 'NF QUITADA.'
	Else
		XMENSNF4 := ' '
	EndIf
	
	//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	//*                   IMPRESSAO DA NOTA FISCAL                 *
	//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
	IF INICIO
		SETPRC(4,0) // LINHA -2
		COL  := 75
		COL2 := 114
		@ 04,01  PSAY '.'
	ELSE
		SETPRC(0,0)
		@ 07,01  PSAY '.'  // LINHA -2
		COL  := 73
		COL2 := 112
		SETPRC(4,0)
	ENDIF
	
	@ 04,COL  PSAY 'XX' // linha -2 20041117
	@ 04,COL2 PSAY NOTA_NUM // linha -2 20041117
	@ 05,001  PSAY ' ' // linha -2 20041117
	// RETIRADO A PEDIDO DO USUARIO CICERO EM 18/10/2000 - GILBERTO
	//@ 10,025  PSAY 'FONE:0(XX11)3224-8811'                   && Telefone Novo
	//@ 10,050  PSAY 'FAX:0(XX11)3224-0314'                    && Fax (Fixo)
	
	IF INICIO
		INICIO := .F.
		INKEY(0)
	ENDIF
	@ 10,003 PSAY NOTA_NATU // linha -2 20041117
	@ 10,039 PSAY NOTA_COFI // linha -2 20041117
	@ 13,003 PSAY CLIE_NOME     + ' ' +NOTA_CLIE             && nome do cliente // linha -2 20041117
	//              IF LEN(TRIM(CLIE_CGC))<14
	//                 @ 15,070 PSAY CLIE_CGC PICTURE "@R 999.999.999-99"       && c.g.c.
	//              ELSE
	//                 @ 15,070 PSAY CLIE_CGC PICTURE "@R 99.999.999/9999-99"   && c.g.c.
	//              ENDIF
	@ 13,077 PSAY CLIE_CGC                                   && c.g.c. // linha -2 20041117
	@ 13,116 PSAY NOTA_EMIS                                  && data de emissao // linha -2 20041117
	@ 15,003 PSAY substr(CLIE_ENDE,1,65)                                  && endereco do cliente // linha -2 20041117 20060328
	@ 15,069 PSAY CLIE_BAIR                                  && bairro // linha -2 20041117 20060328 era 61
	@ 15,092 PSAY SUBS(CLIE_CEP,1,5)+'-'+SUBS(CLIE_CEP,6,3)  && cep do cliente // linha -2 20041117
	@ 17,003 PSAY CLIE_MUNI                                  && cep do cliente // linha -2 20041117
	@ 17,042 PSAY CLIE_FONE                                  && fone do cliente // linha -2 20041117
	@ 17,068 PSAY CLIE_ESTA                                  && estado do cliente // linha -2 20041117
	@ 17,087 PSAY CLIE_INSC                                  && inscricao estadual // linha -2 20041117
	
	@ 20,020 PSAY XENDC // linha -2 20041117
	@ 21,007 PSAY SUBS(XCEPC,1,5)+'-'+SUBS(XCEPC,6,3) // linha -2 20041117
	@ 21,030 PSAY XBAIRROC // linha -2 20041117
	@ 21,058 PSAY XCIDADEC // linha -2 20041117
	@ 21,082 PSAY XESTADOC // linha -2 20041117
	MSOMABOL:= 0 //20060525
	If xDescDupl == "S"
		DbSelectArea("SE1")
		DbSetOrder(1) 
		DBSEEK(xFilial()+MPREFIX+NOTA_NUM)
		WHILE !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_PREFIXO == MPREFIX  .AND. SE1->E1_NUM == NOTA_NUM .AND. ! EOF()
			MSOMABOL := MSOMABOL + SE1->E1_DESPBOL //20060525
			IF SE1->E1_PARCELA == 'A'.OR. SE1->E1_PARCELA == ' '
				@ 23,005 PSAY SE1->E1_NUM+' ' +SE1->E1_PARCELA // linha -2 20041117
				@ 23,025 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99' // linha -2 20041117
				@ 23,050 PSAY SE1->E1_VENCTO // linha -2 20041117
			ENDIF
			IF SE1->E1_PARCELA == 'B'
				@ 23,071 PSAY SE1->E1_NUM+' ' +SE1->E1_PARCELA // linha -2 20041117
				@ 23,089 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99' // linha -2 20041117
				@ 23,112 PSAY SE1->E1_VENCTO // linha -2 20041117
			ENDIF
			IF SE1->E1_PARCELA == 'C'
				@ 24,005 PSAY SE1->E1_NUM+' ' +SE1->E1_PARCELA // linha -2 20041117
				@ 24,025 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99' // linha -2 20041117
				@ 24,050 PSAY SE1->E1_VENCTO // linha -2 20041117
			ENDIF
			IF SE1->E1_PARCELA == 'D'
				@ 24,071 PSAY SE1->E1_NUM+' ' +SE1->E1_PARCELA // linha -2 20041117
				@ 24,089 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99' // linha -2 20041117
				@ 24,112 PSAY SE1->E1_VENCTO // linha -2 20041117
			ENDIF
			IF SE1->E1_PARCELA == 'E'
				@ 25,005 PSAY SE1->E1_NUM+' ' +SE1->E1_PARCELA // linha -2 20041117
				@ 25,025 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99' // linha -2 20041117
				@ 25,050 PSAY SE1->E1_VENCTO // linha -2 20041117
			ENDIF
			IF SE1->E1_PARCELA == 'F'
				@ 25,071 PSAY SE1->E1_NUM+' ' +SE1->E1_PARCELA // linha -2 20041117
				@ 25,089 PSAY SE1->E1_VALOR PICTURE '@e 999,999,999.99' // linha -2 20041117
				@ 25,112 PSAY SE1->E1_VENCTO // linha -2 20041117
			ENDIF
			dbSkip()
		end
	endif
	
	LIN := 29  // linha -2 20041117
	NPESOLIQUIDO := 0 //20041213	
	DbSelectArea('SD2')
	DbSetOrder(3)
	DBSEEK(xFilial()+NOTA_NUM+NOTA_SERIE)
	MDESC := 0                //Variavel para verificar se tem desc. em algum item
	WHILE NOTA_NUM==SD2->D2_DOC .AND. SD2->D2_SERIE == NOTA_SERIE .AND. .NOT. EOF()
		MPEDIDO   := SD2->D2_PEDIDO
		MITEM     := SD2->D2_ITEMPV
		ITEM_CODI := ALLTRIM(SD2->D2_COD)                             && codigo produto
		ITEM_QUAN := ABS(SD2->D2_QUANT)                      && quantidade
//		NPESOLIQUIDO := NPESOLIQUIDO + D2_PESO 	// peso do produto 20041213
		
		IF SD2->D2_DESC <> 0
			XTOTAL    := (100 - SD2->D2_DESC)
			ITEM_VUNI := ((SD2->D2_PRCVEN / XTOTAL) * 100)
			ITEM_TOTA := (ITEM_QUAN * ITEM_VUNI)
		ELSE
			ITEM_VUNI := ABS(SD2->D2_PRCVEN)                  && preco unitario
			ITEM_TOTA := ABS(SD2->D2_TOTAL)                   && preco total
		ENDIF
		ITEM_DESC := SD2->D2_DESC                            && desconto
		
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial()+ITEM_CODI)
		ITEM_UNID  := aLLTRIM(SB1->B1_UM)                              && unidade do produto
		ITEM_DESCR := SUBS(SB1->B1_DESC,1,40)                 && descricao do produto
		NPESOLIQUIDO := NPESOLIQUIDO + (B1_PESO * ITEM_QUAN) 	// peso do produto	
				
		DbSelectArea("SC6")
		DbSetOrder(1)
		DbSeek(XFilial()+MPEDIDO+MITEM)
		MEDICAO := SC6->C6_EDFIN
		
		IF MEDICAO == 9999
			MEDICAO := ' '                                      && edicao final
		ELSE
			MEDICAO := STR(MEDICAO,4,0)
		ENDIF
		
		IF TRIM(ITEM_CODI) == "0699001" .or. TRIM(ITEM_CODI) == "0699002" .or. TRIM(ITEM_CODI) == "0699003" && descricao generica
			ITEM_DESCR := SUBS(SC6->C6_DESCRI,1,32)             && descricao do produto
		ENDIF
		
		//*ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
		//*                       Detalhes do Item - Produto                    *
		//*ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
		@ LIN+LI,002 PSAY ITEM_CODI                           && imprime cod do produto
		@ LIN+LI,014 PSAY ITEM_DESCR                          && imprime descricao do item //20041117
		@ LIN+LI,058 PSAY 'CFOP:'+AllTrim(SD2->D2_CF)         && imprime operacao
		@ LIN+LI,069 PSAY MEDICAO                             && imprime edicao final
		@ LIN+LI,075 PSAY '040'                                && SITUACAO TRIBUTARIA
		@ LIN+LI,080 PSAY 'UN'                                && SITUACAO TRIBUTARIA
		// CONVERTE A QUANTIDADE EM STR PARA NAO ARRENDONDAR NA IMPRESSAO
		MQUANT := STR(ITEM_QUAN,11,4)
		MQUANT := SUBS(MQUANT,1,9)
		@ LIN+LI,082 PSAY MQUANT                              && imprime quantidade
		@ LIN+LI,095 PSAY ITEM_VUNI PICTURE '@E 99,999.9999'     && imprime valor unitario
		@ LIN+LI,108 PSAY ITEM_TOTA PICTURE '@E 9,999,999.99'    && imprime valor total
		@ LIN+LI,123 PSAY IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM) Picture "@E 99" //danilo 20051109
		
		DBSELECTAREA("SD2")
		IF SD2->D2_TES == '650' .OR. SD2->D2_TES == '651' .AND. XCODPROM == 'ENS'
			IF VAL(SD2->D2_ITEM) > 1
				IF XMENSNF1 == ' '
					xMENSNF1 := 'COD.PROD.: '+trim(ITEM_CODI) + ' EM CORTESIA'
					xMENSNF2 := ' '
					xMENSNF3 := ' '
				ELSE
					IF XMENSNF2 == ' '
						xMENSNF2 := 'COD.PROD.: '+trim(ITEM_CODI) + ' EM CORTESIA'
						xMENSNF3 := ' '
					ELSE
						xMENSNF3 := 'COD.PROD.: '+trim(ITEM_CODI) + ' EM CORTESIA'
					ENDIF
				ENDIF
			ENDIF
		ENDIF
		MDESC := SD2->D2_DESC
		
		DBSKIP()
		
		LIN++
	END
	
	IF MDESC # 0
		XTOTAL     := (100 - MDESC)
		NOTA_BRUTO := ((NOTA_MERC / XTOTAL) * 100)
		NOTA_DESC  := NOTA_BRUTO-NOTA_MERC
		XMENSNF1   := "DESCONTO DE " + STR(MDESC,5,0) + " %" + " R$ " + TRANSFORM(NOTA_DESC, "@E 999,999.99")
	ELSE
		NOTA_BRUTO := NOTA_MERC
	ENDIF
	
	IF NOTA_DESPREM <> 0
		NOTA_MERC := NOTA_MERC + NOTA_DESPREM
	END
	      
 	IF MSOMABOL > 0 //20060525
		NOTA_MERC  := NOTA_MERC + NOTA_DESPREM + MSOMABOL //20060606
	ENDIF

	IF NOTA_CLIE == "335257"
		@ 43,002  PSAY "NAO INCIDENCIA DO ICMS,ARTIGO 7,INCISO I DO DEC N 45490/00. SUSP DO IPI CONFORME ARTIGO 42,INCISO III DO DEC N 4544/02"                    // 20061016//20061110
	ENDIF
	@ 44,002  PSAY "PAGTO SOMENTE C/ BOLETO BANCARIO: NAO ACEITAMOS PAGTO VIA DOC, TRANSF. OU DEP. SIMPLES. POIS NOSSO SISTEMA NAO IDENTIFICA"                                 // 20060522
	//danilo 20051109
	@ 47,003  PSAY xBASE_ICMS  Picture "@E@Z 999,999,999.99"  // Base do ICMS.
	@ 47,028  PSAY xVALOR_ICMS Picture "@E@Z 999,999,999.99"  // Valor do ICMS.
	@ 47,055  PSAY xBSICMRET   Picture "@E@Z 999,999,999.99"  // Base ICMS Ret.
	@ 47,080  PSAY xICMS_RET   Picture "@E@Z 999,999,999.99"  // Valor  ICMS Ret.
	@ 47,102 PSAY NOTA_BRUTO   PICTURE "@E 9,999,999,999.99" //LINHA +7 20041117

	@ 49,003 PSAY NOTA_DESPREM PICTURE "@E 9,999.99" //LINHA +7 20041117
	@ 49,056 PSAY MSOMABOL Picture "@E 9,999.99" //20060525
	@ 49,102 PSAY NOTA_MERC    PICTURE "@E 9,999,999,999.99" //LINHA +7 20041117


	DbSelectArea("SA3")
	DbSetOrder(1)
	DbSeek(XFilial()+NOTA_VEND)
	// peso liquido 20041213
	LIN:=55 //LINHA +7 20041117
	if NPESOLIQUIDO > 0 
		@ LIN +1 ,112 psay NPESOLIQUIDO PICTURE "@E 9,999.99"
	end if //ateh aki
	
	LIN := LIN +3
	
	@ LIN+1,20 PSAY XPEDIDO
	//              @ LIN+1,52 PSAY NOTA_VEND
	@ LIN+1,46 PSAY NOTA_VEND
	@ LIN+1,52 PSAY '/ ' + NOTA_ALMOX // 20070613 SA3->A3_LOCAL
	@ LIN+3,20 PSAY XMENSNF1
	@ LIN+4,20 PSAY XMENSNF2
	@ LIN+5,20 PSAY XMENSNF3
	//              @ LIN+6,20 PSAY XMENSNFN
	@ LIN+7,20 PSAY XMENSNF4
	@ 69,95  PSAY XCODFAT //LINHA +6 20041117
	@ 69,115 PSAY NOTA_NUM //LINHA +6 20041117
	
	DbSelectArea("SC6")
	DBSETORDER(4)
	DBGOTO(NREGANT)
	DBSKIP()
	
	SET DEVICE TO SCREEN
	
	SETPRC(0,0)
	
	SET DEVICE TO PRINTER
	
	SetPrc(0,0)
	
	LIN := 6
	LI  := 0
	
	//     inicializa as variaveis de mensagem
	XMENSNF1 := ' '
	XMENSNF2 := ' '
	XMENSNF3 := ' '
	XMENSNF4 := ' '
	
	//     inicializa as variaveis de Cobran┤a
	//     XENDC   :=' '
	//     XBAIRROC:=' '
	//     XCIDADEC:=' '
	//     XESTADOC:=' '
	//     XCEPC   :=SPACE(8)
END

SET DEVICE TO SCREEN

DBSELECTAREA("SC6")
RetIndex("SC6")

IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()

Return