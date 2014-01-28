#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"

/*/ // Alterado por Danilo C S Pala em 20050405
//20041022 Alterado por Danilo, impressao do endereco de cobranca  
20041022 Alterado por Danilo, 20041117: alteracao ca razao social
//Danilo C S Pala 20060328: dados de enderecamento do DNE
//Danilo C S Pala 20060529: DESPESA COM BOLETO   
//Danilo C S Pala 20060810: mensagem NF-E
//Danilo C S Pala 20090714: nova razao social
//Danilo C S Pala 20090828: NAO IMPRIMIR NF SOMENTE DE SERVICOS
//Danilo C S Pala 20100305: ENDBP
ээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбддддддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁAdaptado  Ё PFAT071  Ё Autor Ё Gilberto A. de Oliveira  Ё Data Ё 05/05/00 Ё╠╠
╠╠цддддддддддеддддддддддадддддддаддддддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao Ё Nota Fiscal de Saida.    Soft/Serv Pini Sistemas              Ё╠╠
╠╠цддддддддддеддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё Especifico para Editora Pini Ltda.                            Ё╠╠
╠╠цддддддддддеддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁAlteracoesЁ 06.06.00 - Impressao dos campos                               Ё╠╠
╠╠Ё          Ё            Andreia Silva.                                     Ё╠╠
╠╠Ё          Ё 18/09/00 - Busca do titulo no FINANCEIRO. Apenas prefixo "FAT"Ё╠╠
╠╠Ё          Ё 18/09/00 - Acerto da impressao dos dados do titulo financeiro.Ё╠╠
╠╠Ё          Ё            Gilberto A. de Oliveira Jr.                        Ё╠╠
╠╠Ё          Ё 06/11/00 - Impressao do Campo Z9_CODFAT.                      Ё╠╠
╠╠Ё          Ё            Gilberto A. de Oliveira Jr.                        Ё╠╠
╠╠Ё          Ё 10/11/00 - Impressao das "Despesas Acessorias", C5_DESPREM.   Ё╠╠
╠╠Ё          Ё            Solicitante : Cicero                               Ё╠╠
╠╠Ё          Ё            Analista    : Gilberto A. de Oliveira Jr.          Ё╠╠
╠╠Ё          Ё 13.11.00 - Adi┤фo de um texto especifico para prod. com TES   Ё╠╠
╠╠Ё          Ё            704. Alteracao no Texto de Inf. Complementares.    Ё╠╠
╠╠Ё          Ё            Solicitante : C║cero                               Ё╠╠
╠╠Ё          Ё            Analista    : Gilberto A. de Oliveira Jr.          Ё╠╠
╠╠юддддддддддаддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
User Function Pfat071()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("NORDEM,Z,M,TAMANHO,LIMITE,TITULO")
SetPrvt("CDESC1,CDESC2,CDESC3,CNATUREZA,ARETURN,NOMEPROG")
SetPrvt("CPERG,NLASTKEY,LCONTINUA,NLIN,WNREL,_NAUX")
SetPrvt("NTAMNF,CSTRING,CPEDANT,_XFILIAL,NLININI,XNUM_NF")
SetPrvt("XSERIE,XEMISSAO,XTOT_FAT,XCLIENTE,XLOJA,XVEND1")
SetPrvt("XFRETE,XSEGURO,XBASE_ICMS,XBASE_IPI,XVALOR_ICMS,XICMS_RET")
SetPrvt("XVALOR_IPI,XVALOR_MERC,XNUM_DUPLIC,XCOND_PAG,XPBRUTO,XPLIQUI")
SetPrvt("XTIPO,XESPECIE,XVOLUME,XTOT_ISS,XTOT_SERV,X_TOTISS")
SetPrvt("MPREFIXO,CPEDATU,CITEMATU,XPED_VEND,XITEM_PED,XNUM_NFDV")
SetPrvt("XPREF_DV,XICMS,XCOD_PRO,XQTD_PRO,XPRE_UNI,XPRE_TAB")
SetPrvt("XIPI,XVAL_IPI,XDESC,XVAL_DESC,XVAL_MERC,XTEXTO")
SetPrvt("XTES,XCF,XICMSOL,XICM_PROD,XVALICM,XSIMIRRF")
SetPrvt("XLIVRO,XDOACAO,_XFILD2,XPESO_PRO,XPESO_UNIT,XDESCRICAO")
SetPrvt("XUNID_PRO,XCOD_TRIB,XMEN_TRIB,XCOD_FIS,XCLAS_FIS,XMEN_POS")
SetPrvt("XISS,XTIPO_PRO,XLUCRO,XCLFISCAL,XSERVICO,XPESO_LIQ")
SetPrvt("I,XTOT_MERC,XSUP_INF,NPELEM,_CLASFIS,NPTESTE")
SetPrvt("XPESO_LIQUID,XPED,XPESO_BRUTO,XP_LIQ_PED,XTIPOOP,XDESPREM")
SetPrvt("XTIPO_CLI,XCOD_MENS,XMENSAGEM,XTPFRETE,XCONDPAG,XCOD_FAT")
SetPrvt("XCOD_VEND,XDESC_NF,XDESCDUPL,XPAGA1,XPAGAD,XQTDEP")
SetPrvt("XCODFAT,XMENSNF4,XDESC_PAG,XPED_CLI,XDESC_PRO,J")
SetPrvt("ITNT,XEND_COB,XCOD_CLI,XNOME_CLI,XEND_CLI,XBAIRRO")
SetPrvt("XCEP_CLI,XCOB_CLI,XCOB_BAI,XCOB_CID,XCOB_EST,XCOB_CEP, XCOB_BP")
SetPrvt("XREC_CLI,XMUN_CLI,XEST_CLI,XCGC_CLI,XINSC_CLI,XTRAN_CLI")
SetPrvt("XTEL_CLI,XFAX_CLI,XSUFRAMA,XCALCSUF,ZFRANCA,XVENDEDOR")
SetPrvt("XBSICMRET,XNOME_TRANSP,XEND_TRANSP,XMUN_TRANSP,XEST_TRANSP,XVIA_TRANSP")
SetPrvt("XCGC_TRANSP,XTEL_TRANSP,XINSC_TRANSP,XNUM_DUP,XPARC_DUP,XVENC_DUP")
SetPrvt("XVALOR_DUP,XDUPLICATAS,NOPC,CCOR,NCONT,NCOL")
SetPrvt("_NLIN01,_NLIN02,_NLIN03,_NLIN04,_NLIN05,_NLIN06")
SetPrvt("_NLIN07,_NLIN08,_NLIN09,_NLIN10,_NLIN11,_NLIN12,_NLIN13,_NLIN14")
SetPrvt("_NAJUSTE,XTXTCF,BB,XY2,_CC5NUM,_NIENDCOB")
SetPrvt("XY1,NTAMDET,XB_ICMS_SOL,XV_ICMS_SOL,_LIMP,NTAMMEN")
SetPrvt("_NTTLOBS,NTAMOBS,_SALIAS,AREGS,BRETEM, B_SERVENG")
SetPrvt("NVALCOFINS, NVALPIS, NVALCSLL, NVALRETTOTAL, NVALIRRF, NVALORTOTAL") //20040212
SetPrvt("MSOMABOL,mhora")  //20060529
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis Ambientais                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis utilizadas para parametros                         Ё
//Ё mv_par01             // Da Nota Fiscal                       Ё
//Ё mv_par02             // Ate a Nota Fiscal                    Ё
//Ё mv_par03             // Da Serie                             Ё      
//| MV_PAR06 			//IMPRIME NF SERVICO (S/N)	 20090828	 |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nOrdem   := 000
Z        := 000
M        := 000
tamanho  := "G"
limite   := 220
titulo   := PADC("Nota Fiscal - PFAT071",74)
cDesc1   := PADC("Este programa ira emitir a Nota Fiscal de Saida",74)
cDesc2   := ""
cDesc3   := PADC("da Empresa Pini Sistemas...",74)
cNatureza:= ""
aReturn  := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
nomeprog := "PFAT071"
cPerg    := "NFSEPI"
nLastKey := 000
lContinua:= .T.
nLin     := 000
MHORA      := TIME()
wnrel    := "PFAT071_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
_naux    := 00

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Tamanho do Formulario de Nota Fiscal (em Linhas)                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nTamNf:=72                         // Apenas Informativo
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica as perguntas selecionadas, (SX1).                               Ё
//Ё Caso nao existam cria o grupo. Nome do Grupo de Perguntas : NFSEPI       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//_ValidPerg() 20090714
Pergunte(cPerg,.T.)

cString:="SF2"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Envia controle para a funcao SETPRINT                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)
If nLastKey == 27
	Return
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica Posicao do Formulario na Impressora                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

VerImp()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Inicio do Processamento da Nota Fiscal                                   Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     RptStatus({|| Execute(RptDetail)})
Return
/*
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁRPTDETAIL ╨Autor  ЁMicrosiga           ╨ Data Ё  03/27/02   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Desc.     Ё IMPRESSAO DA NOTA                                          ╨╠╠
╠╠╨          Ё                                                            ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP5                                                        ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
*/
Static Function RptDetail()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё  Cabecalho da Nota Fiscal Saida                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
DbSelectArea("SF2")
DbSetOrder(1)
DbSeek(xFilial("SF2")+mv_par01+mv_par03,.t.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё  Itens de Venda da Nota Fiscal                                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
DbSelectArea("SD2")
DbSetOrder(3)
DbSeek(xFilial("SD2")+mv_par01+mv_par03)
cPedant:= SD2->D2_PEDIDO

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Inicializa  regua de impressao                                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetRegua(Val(mv_par02)-Val(mv_par01))

DbSelectArea("SF2")

_xFilial:= xFilial("SF2")

While !Eof() .And. ( SF2->F2_DOC <= mv_par02 ) .And. ( SF2->F2_FILIAL==_xFilial )	.And. lContinua

	BRETEM := .F. //20040202
	B_SERVENG := .F. //20040202                                        
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Se a Serie do Arquivo for Diferente do Parametro Informado !!!     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If SF2->F2_SERIE #mv_par03
		DbSkip()
		Loop
	Endif   

	IF mv_par06 ==2 //nao imprimir nota somente de servicos 20090828	
		cquery ="SELECT D2_SERIE, D2_DOC, SUM(CASE WHEN  (D2_TP IN ('CS','MO','PD','RC','SE','SW','TC','TM','WW')) THEN 0 ELSE 1 END) AS IMPRIMIR FROM " + RetSqlName("SD2") +" SD2 WHERE D2_FILIAL='"+ xFilial("SD2")+"' AND D2_SERIE='"+ SF2->F2_SERIE +"' AND D2_DOC='"+ SF2->F2_DOC +"' AND D2_EMISSAO>='"+ DTOS(SF2->F2_EMISSAO) +"' AND D_E_L_E_T_<>'*' GROUP BY D2_SERIE, D2_DOC"
		TCQUERY cQuery NEW ALIAS "TBSD2"
		DbSelectArea("TBSD2")
		DBGOTOP()
		IF TBSD2->IMPRIMIR == 0 //SOMENTE SERVICOS, NAO IMPRIMIR
			DBCLOSEAREA("TBSD2")
			DbSelectArea("SF2")
			DbSkip()
			Loop
		ELSE
			DBCLOSEAREA("TBSD2")
		ENDIF //ATE AQUI 20090828
	ENDIF
	
	IF lAbortPrint
		@ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
		lContinua := .F.
		Exit
	Endif
	
	nLinIni:=nLin                         // Linha Inicial da Impressao
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Inicio de Levantamento dos Dados da Nota Fiscal                    Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё * CABECALHO DA NOTA FISCAL                                         Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	xNUM_NF     :=SF2->F2_DOC             // Numero.
	xSERIE      :=SF2->F2_SERIE           // Serie.
	xEMISSAO    :=SF2->F2_EMISSAO         // Data de Emissao.
	xTOT_FAT    :=SF2->F2_VALFAT          // Valor Total da Fatura.
	NVALIRRF := 0 //20040216 VALOR DO IRRF : 1,50%
		
	If xTOT_FAT == 0
		xTOT_FAT := SF2->F2_VALMERC+SF2->F2_VALIPI+SF2->F2_SEGURO+SF2->F2_FRETE
	EndIf
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё 06.06.00 - Inclusao do campo: F2_VEND1 - Andreia Silva.            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	xCLIENTE    := SF2->F2_CLIENTE         // Codigo do Cliente
	xLOJA       := SF2->F2_LOJA            // Loja do Cliente.
	xVEND1      := SF2->F2_VEND1           // Vendedor 1.
	xFRETE      := SF2->F2_FRETE           // Frete.
	xSEGURO     := SF2->F2_SEGURO          // Seguro.
	xBASE_ICMS  := SF2->F2_BASEICM         // Base do ICMS.
	xBASE_IPI   := SF2->F2_BASEIPI         // Base do IPI.
	xVALOR_ICMS := SF2->F2_VALICM          // Valor do ICMS.
	xICMS_RET   := SF2->F2_ICMSRET         // Valor do ICMS Retido.
	xVALOR_IPI  := SF2->F2_VALIPI          // Valor do IPI.
	xVALOR_MERC := SF2->F2_VALMERC         // Valor da Mercadoria.
	xNUM_DUPLIC := SF2->F2_DUPL            // Numero da Duplicata.
	xCOND_PAG   := SF2->F2_COND            // Condicao de Pagamento.
	xPBRUTO     := SF2->F2_PBRUTO          // Peso Bruto.
	xPLIQUI     := SF2->F2_PLIQUI          // Peso Liquido.
	xTIPO       := SF2->F2_TIPO            // Tipo do Cliente.
	xESPECIE    := SF2->F2_ESPECI1         // Especie 1 no Pedido.
	xVOLUME     := SF2->F2_VOLUME1         // Volume 1 no Pedido.
	XTOT_ISS    := SF2->F2_VALISS          // Valor do ISS.
	XTOT_SERV   := SF2->F2_BASEISS
	x_TOTISS    := SF2->F2_VALISS          // Alt.Andreia Silva - 26/02/99
	MPREFIXO    := SF2->F2_PREFIXO
	NVALCOFINS	:= SF2->F2_VALCOFI 			//VALOR DA RETENCAO DA COFINS 20040212
	NVALPIS     := SF2->F2_VALPIS			//VALOR DA RETENCAO DO PIS    20040212 
	NVALCSLL    := SF2->F2_VALCSLL         //VALOR DA RETENCAO DA CSLL   20040212 
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Itens de Venda da Nota Fiscal de Saida.                            Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	DbSelectArea("SD2")
	DbSetOrder(3)
	DbSeek(xFilial("SD2")+xNUM_NF+xSERIE)
	
	cPedAtu  := SD2->D2_PEDIDO
	cItemAtu := SD2->D2_ITEMPV
	
	xPED_VEND:={}                         // Numero do Pedido de Venda.
	xITEM_PED:={}                         // Numero do Item do Pedido de Venda.
	xNUM_NFDV:={}                         // Numero quando houver devolucao.
	xPREF_DV :={}                         // Serie  quando houver devolucao.
	xICMS    :={}                         // Porcentagem do ICMS.
	xCOD_PRO :={}                         // Codigo  do Produto.
	xQTD_PRO :={}                         // Peso/Quantidade do Produto.
	xPRE_UNI :={}                         // Preco Unitario de Venda.
	xPRE_TAB :={}                         // Preco Unitario de Tabela.
	xIPI     :={}                         // Porcentagem do IPI.
	xVAL_IPI :={}                         // Valor do IPI.
	xDESC    :={}                         // Desconto por Item.
	xVAL_DESC:={}                         // Valor do Desconto.
	xVAL_MERC:={}                         // Valor da Mercadoria.
	xTEXTO   :={}                         // TEXTO DA NATUREZA.
	xTES     :={}                         // TES.
	xCF      :={}                         // Classificacao quanto natureza da Operacao.
	xICMSOL  :={}                         // Base do ICMS Solidario.
	xICM_PROD:={}                         // ICMS do Produto.
	xVALICM  :={}                         // Valor do ICMS.
	xSIMIRRF :={}                         // Caso encontre produtos/servicos com incidencia de IRRF.
	xLIVRO   :=.F.                        // Tipo de Produto Livro
	xDOACAO  :=.F.                        // Para acionar mensagem de doacao ESSERE.
	
	_xFilD2:= xFilial("SD2")
	
	While !Eof() .And. ( SD2->D2_DOC==xNUM_NF    ) ;
		.And. ( SD2->D2_SERIE==xSERIE   ) ;
		.And. ( SD2->D2_FILIAL==_xFilD2 )
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Se a Serie do Arquivo for Diferente do Parametro Informado !!! Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		If SD2->D2_SERIE #mv_par03
			DbSkip()
			Loop
		Endif
		
		SF4->( dbSeek(xfilial("SF4")+SD2->D2_TES) )
		
		AADD(xPED_VEND ,SD2->D2_PEDIDO)
		AADD(xITEM_PED ,SD2->D2_ITEMPV)
		AADD(xNUM_NFDV ,IIF(Empty(SD2->D2_NFORI),"",SD2->D2_NFORI))
		AADD(xPREF_DV  ,SD2->D2_SERIORI)
		AADD(xICMS     ,IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM))
		AADD(xCOD_PRO  ,SD2->D2_COD)
		AADD(xQTD_PRO  ,SD2->D2_QUANT)
		AADD(xPRE_UNI  ,SD2->D2_PRCVEN)
		AADD(xPRE_TAB  ,SD2->D2_PRUNIT)
		AADD(xIPI      ,IIF(Empty(SD2->D2_IPI),0,SD2->D2_IPI))
		AADD(xVAL_IPI  ,SD2->D2_VALIPI)
		AADD(xDESC     ,SD2->D2_DESC)
		AADD(xVAL_MERC ,SD2->D2_TOTAL)
		AADD(xTES      ,SD2->D2_TES)
		IF ASCAN(xTEXTO ,Alltrim(SF4->F4_TEXTO) )==0
			AADD(xTEXTO , Alltrim(SF4->F4_TEXTO) )
		ENDIF
		IF SD2->D2_TES == "704" .OR. SD2->D2_TES == "703"
			XLIVRO:= .T.
		ENDIF
		IF SD2->D2_TES == "705"
			XDOACAO:= .T.
		ENDIF
		// AADD(xCF       ,SD2->D2_CF)
		IF ASCAN(xCF,SD2->D2_CF) == 0
			AADD(xCF       ,SD2->D2_CF)
		ENDIF
		AADD(xVALICM   ,SD2->D2_VALICM)
		AADD(xICM_PROD ,IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM))

		// 20040202
		if SUBSTR(SD2->D2_COD,1,2)  = "04"
			B_SERVENG := .T.
		endif
		//ATEH AKI 20040202		
		Dbskip()
	End
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Cadastro de Produtos (Desc.Generica do Produto)                    Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	DbSelectArea("SB1")
	DbSetOrder(1)
	
	xPESO_PRO  :={}                          // Peso Liquido.
	xPESO_UNIT :={}                          // Peso Unitario do Produto.
	xDESCRICAO :={}                          // Descricao do Produto.
	xUNID_PRO  :={}                          // Unidade do Produto.
	xCOD_TRIB  :={}                          // Codigo de Tributacao.
	xMEN_TRIB  :={}                          // Mensagens de Tributacao.
	xCOD_FIS   :={}                          // Cogigo Fiscal.
	xCLAS_FIS  :={}                          // Classificacao Fiscal.
	xMEN_POS   :={}                          // Mensagem da Posicao IPI.
	xISS       :={}                          // Aliquota de ISS.
	xTIPO_PRO  :={}                          // Tipo do Produto.
	xLUCRO     :={}                          // Margem de Lucro p/ ICMS Solidario.
	xCLFISCAL  :={}                          // Auxiliar p/ Classifica┤фo Fiscal.
	xSERVICO   :={}                          // Indica se Produtos Fisicao (CD/MANUAL) ou Servi┤o.
	xPESO_LIQ  :=00                          // Pe┤o Liquido.
	
	I          :=01
	XTOT_ISS   :=00
	XTOT_MERC  :=00
	XTOT_SERV  :=00
	XSUP_INF   := .F.   // Para controle dos itens de suporte informatico na NF. 13.11.2000
	
	For I:=1 to Len(xCOD_PRO)
		DbSeek(xFilial("SB1")+xCOD_PRO[I])
		AADD(xPESO_PRO ,SB1->B1_PESO * xQTD_PRO[I])
		xPESO_LIQ  := xPESO_LIQ + xPESO_PRO[I]
		AADD(xPESO_UNIT , SB1->B1_PESO)
		AADD(xUNID_PRO  , SB1->B1_UM)
		//AADD(xDESCRICAO , SB1->B1_DESC)
		AADD(xDESCRICAO , SB1->B1_DESC)
		// GILBERTO - 07.11.2000 (PROVISORIO !!)
		IF SUBS(XCOD_PRO[I],3,5)=="95001"
			AADD(xCOD_TRIB  , "20")
			XSUP_INF:= .T.
		ELSEIF SUBS(XCOD_PRO[I],3,5)=="95002"
			AADD(xCOD_TRIB  , "00")
			XSUP_INF:= .T.
		ELSEIF SUBS(XCOD_PRO[I],3,5)=="95003"
			AADD(xCOD_TRIB  , "04")
		ELSE
			IF AllTrim(XTES[I]) == "703" .OR. Alltrim(XTES[I])=="704"
				AADD(xCOD_TRIB  , "04")
			ELSE
				AADD(xCOD_TRIB  , "  ")
			ENDIF
		ENDIF
		// Utilizado para definir mensagem em Informacoes Complementares.
		// Caso encontre algum produtos destes grupos nao emitira mensagem :
		// "NAO INCIDENCIA DE IRRF..."
		IF SB1->B1_GRUPO $ "0500╖1900"
			AADD(XSIMIRRF,SB1->B1_GRUPO)
		ENDIF
	
		DO CASE
			CASE SB1->B1_TIPO=="CD"            // Para CD/MANUAL.
				AADD(xSERVICO,"N")
			CASE SB1->B1_TIPO=="TS"            // Para Servi┤o (Treinamento).
				AADD(xSERVICO,"S")
			CASE SB1->B1_TIPO=="SW"            // Para Servi┤o (Software).
				AADD(xSERVICO,"S")
			CASE SB1->B1_TIPO=="SE"            // Para Servi┤os Especiais Pini Sistemas.
				AADD(xSERVICO,"S")
			CASE SB1->B1_TIPO=="RC"            // Para "Servi┤os" Relatorio de Custo.
				AADD(xSERVICO,"S")
			CASE SB1->B1_TIPO=="PD"            // Para "Servi┤os" Cursos Profissionalizantes de Desenvolvimento.
				AADD(xSERVICO,"S")
			OTHERWISE                          // Para qualquer outro tipo.
				AADD(xSERVICO,"N")
		ENDCASE
		IF xSERVICO[I] <> "S"
			XTOT_MERC:=XTOT_MERC+XVAL_MERC[I]
		ELSE
			XTOT_SERV:=XTOT_SERV+XVAL_MERC[I]
		ENDIF
		If Ascan(xMEN_TRIB, SB1->B1_ORIGPRO)==0
			AADD(xMEN_TRIB ,SB1->B1_ORIGPRO)
		Endif
		npElem := Ascan(xCLAS_FIS,SB1->B1_POSIPI)
		If npElem == 0
			AADD(xCLAS_FIS  ,SB1->B1_POSIPI)
		Endif
		npElem := Ascan(xCLAS_FIS,SB1->B1_POSIPI)
		DO CASE
			CASE npElem == 1
				_CLASFIS := "A"
			CASE npElem == 2
				_CLASFIS := "B"
			CASE npElem == 3
				_CLASFIS := "C"
			CASE npElem == 4
				_CLASFIS := "D"
			CASE npElem == 5
				_CLASFIS := "E"
			CASE npElem == 6
				_CLASFIS := "F"
		ENDCASE
		nPteste := Ascan(xCLFISCAL,_CLASFIS)
		If nPteste == 0
			AADD(xCLFISCAL,_CLASFIS)
		Endif
		AADD(xCOD_FIS ,_CLASFIS)
		
		If SB1->B1_ALIQISS > 0
			AADD(xISS ,SB1->B1_ALIQISS)
			XTOT_ISS:=XTOT_ISS+(SB1->B1_ALIQISS/100)*XVAL_MERC[I]
		Endif
		
		AADD(xTIPO_PRO ,SB1->B1_TIPO)
		AADD(xLUCRO    ,SB1->B1_PICMRET)
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Calculo do Peso Liquido da Nota Fiscal                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		xPESO_LIQUID:=0
		For J:=1 to Len(xPESO_PRO)
			xPESO_LIQUID:=xPESO_LIQUID+xPESO_PRO[I]
		Next J
	Next I
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё PEDIDOS DE VENDA.                                                Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	DbSelectArea("SC5")
	DbSetOrder(1)
	
	xPED        := {}
	xPESO_BRUTO := 0
	xP_LIQ_PED  := 0
	XTIPOOP     := " "
	
	For I:=1 to Len(xPED_VEND)
		DbSeek(xFilial("SC5")+xPED_VEND[I])
		If ASCAN(xPED,xPED_VEND[I])==0
			DbSeek(xFilial("SC5")+xPED_VEND[I])
			XDESPREM    := SC5->C5_DESPREM           // A pedido do Sr. Cicero.
			XTIPOOP     := SC5->C5_TIPOOP
			// xCLIENTE    := SC5->C5_CLIENTE            // Codigo do Cliente
			xTIPO_CLI   := SC5->C5_TIPOCLI            // Tipo de Cliente
			xCOD_MENS   := SC5->C5_MENPAD             // Codigo da Mensagem Padrao
			xMENSAGEM   := SC5->C5_MENNOTA            // Mensagem para a Nota Fiscal
			xTPFRETE    := SC5->C5_TPFRETE            // Tipo de Entrega
			xCONDPAG    := SC5->C5_CONDPAG            // Condicao de Pagamento
			xPESO_BRUTO := SC5->C5_PBRUTO             // Peso Bruto
			xP_LIQ_PED  := xP_LIQ_PED + SC5->C5_PESOL // Peso Liquido
			
			DbSelectArea("SZ9")                        // GILBERTO
			DbSetOrder(1)                              // 06.11.2000
			DbSeek(xFilial("SZ9")+SC5->C5_TIPOOP)
			xCOD_FAT:= SZ9->Z9_CODFAT                  // Resumo da operacao financeira (Nr. de Parcelas, Forma de Pagto)
			
			DbSelectArea("SC5")
			xCOD_VEND:= {SC5->C5_VEND1,;              // Codigo do Vendedor 1
			SC5->C5_VEND2,;              // Codigo do Vendedor 2
			SC5->C5_VEND3,;              // Codigo do Vendedor 3
			SC5->C5_VEND4,;              // Codigo do Vendedor 4
			SC5->C5_VEND5}               // Codigo do Vendedor 5
			xDESC_NF := {SC5->C5_DESC1,;              // Desconto Global 1
			SC5->C5_DESC2,;              // Desconto Global 2
			SC5->C5_DESC3,;              // Desconto Global 3
			SC5->C5_DESC4}               // Desconto Global 4
			AADD(xPED,xPED_VEND[I])
		Endif
		
		If xP_LIQ_PED >0
			xPESO_LIQ := xP_LIQ_PED
		Endif
		
	Next
	
	//// GILBERTO : 07.11.2000
	XDESCDUPL:= ""
	XPAGA1   := ""
	XPAGAD   := ""
	XQTDEP   := 0
	IF XTIPOOP == '99'
		XDESCDUPL := 'CR'                 //CONSULTA CONTAS A RECEBER
	ELSE
		DbSelectArea("SZ9")
		DbSetOrder(2)
		DbSeek(XTIPOOP)
		IF FOUND()
			XDESCDUPL := SZ9->Z9_DESCDUP
			XPAGA1    := SZ9->Z9_PAGA1
			XPAGAD    := SZ9->Z9_PAGAD
			XQTDEP    := SZ9->Z9_QTDEP
			XCODFAT   := SZ9->Z9_CODFAT
		ENDIF
	ENDIF
	
	XMENSNF4:= ""
	DO CASE
		CASE XQTDEP == 1 .AND. XPAGA1 == 'S'
			XMENSNF4 := 'NF QUITADA.'
		CASE XQTDEP > 1 .AND. XPAGA1 == 'S' .AND. XPAGAD == 'S'
			XMENSNF4 := 'NF QUITADA.'
			OTHER
			XMENSNF4 := ' '
	ENDCASE
	
	//зддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё PESQUISA DA CONDICAO DE PAGTO.              Ё
	//юддддддддддддддддддддддддддддддддддддддддддддды
	DbSelectArea("SE4")
	DbSetOrder(1)
	DbSeek(xFilial("SE4")+xCONDPAG)
	xDESC_PAG := SE4->E4_DESCRI
	
	//зддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё ITENS DO PEDIDO DE VENDA.                   Ё
	//юддддддддддддддддддддддддддддддддддддддддддддды
	DbSelectArea("SC6")
	DbSetOrder(1)
	xPED_CLI :={}                          // Numero de Pedido
	xDESC_PRO:={}                          // Descricao aux do produto
	
	J:=Len(xPED_VEND)
	
	ITNT := 1
	
	For I:=1 to J
		DbSeek(xFilial("SC6")+xPED_VEND[I]+xITEM_PED[I])
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Variavel para Buscar a TES do primeiro Item digitado no PV      Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		if xITEM_PED[I]=='01'
			ITNT := I
		Endif
		
		SB1->(DbSeek(xFilial("SB1")+SC6->C6_PRODUTO))
		
		AADD(xPED_CLI ,SC6->C6_PEDCLI)
		AADD(xDESC_PRO,SC6->C6_DESCRI)
		//AADD(xDESC_PRO,SB1->B1_DESC)
		AADD(xVAL_DESC,SC6->C6_VALDESC)
		
		//        IF x_TotIss == 0          // VER DEPOIS SE ESSE CODIGO DEVE
		//           xSERVICO[I] := "N"     // RETORNAR, POIS FUNCIONAVA ASSIM NA
		//        ENDIF                     // SYBASE.
		//        IF xSERVICO[I] == "S"
		//           XTOT_SERV:=0
		//        ENDIF
		//        IF xSERVICO[I] == "N"            // VER DEPOIS SE ESSE CODIGO DEVE
		//           xSERVICO[I] := 'S'            // RETORNAR, POIS FUNCIONAVA ASSIM NA
		//           IF XTOT_MERC > XVAL_MERC[I]   // SYBASE.
		//              XTOT_MERC:=XTOT_MERC - XVAL_MERC[I]
		//           ENDIF
		//        ENDIF
	Next
	
	// Incluido em 27/11/00 By RC
	xEND_COB := {}
	
	If xTIPO=='N' .OR.;
		xTIPO=='C' .OR.;
		xTIPO=='P' .OR.;
		xTIPO=='I' .OR.;
		xTIPO=='S' .OR.;
		xTIPO=='T' .OR.;
		xTIPO=='O'
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё CADASTRO DE CLIENTES                                             Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		DbSelectArea("SA1")
		DbSetOrder(1)
		DbSeek(xFilial("SA1")+xCLIENTE+xLOJA)
		xCOD_CLI :=SA1->A1_COD             // Codigo do Cliente
		xNOME_CLI:=SA1->A1_NOME            // Nome
		xEND_CLI :=ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060328             // Endereco
		xBAIRRO  :=SA1->A1_BAIRRO          // Bairro
		xCEP_CLI :=SA1->A1_CEP             // CEP
		xCOB_CLI :=SA1->A1_ENDCOB          // Endereco de Cobranca
		xCOB_BP  :=SA1->A1_ENDBP			//ENDERECO COBRANCA BP 20100305
		
		//20100305 DAQUI
		IF SM0->M0_CODIGO =="03" .AND. xCOB_BP ="S"
			DbSelectArea("ZY3")
			DbSetOrder(1)
			DbSeek(XFilial()+xCLIENTE+xLOJA)
			XCOB_CLI:= ZY3_END
			XCOB_BAI:= ZY3_BAIRRO
			XCOB_CID:= ZY3_CIDADE
			XCOB_EST:= ZY3_ESTADO
			XCOB_CEP:= ZY3_CEP
			AADD(XEND_COB,XCOB_CLI)
			AADD(XEND_COB,XCOB_BAI)
			AADD(XEND_COB,XCOB_CEP+"  "+ALLTRIM(XCOB_CID)+" / "+XCOB_EST)
	    ELSEIF SUBS(xCOB_CLI,1,1)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
			DbSelectArea("SZ5")
			DbSetOrder(1)
			If dbSeek(xFilial("SZ5")+SA1->A1_COD, .F.)
				XCOB_CLI:= ALLTRIM(SZ5->Z5_TPLOG)+ " " + ALLTRIM(SZ5->Z5_LOGR) + " " + ALLTRIM(SZ5->Z5_NLOGR) + " " + ALLTRIM(SZ5->Z5_COMPL) //20060328
				XCOB_BAI:= SZ5->Z5_BAIRRO
				XCOB_CID:= SZ5->Z5_CIDADE
				XCOB_EST:= SZ5->Z5_ESTADO
				XCOB_CEP:= SZ5->Z5_CEP
				AADD(XEND_COB,XCOB_CLI)
				AADD(XEND_COB,XCOB_BAI)
				AADD(XEND_COB,XCOB_CEP+"  "+ALLTRIM(XCOB_CID)+" / "+XCOB_EST)
			Else
				XCOB_CLI:= Space(Len(ALLTRIM(SZ5->Z5_TPLOG)+ " " + ALLTRIM(SZ5->Z5_LOGR) + " " + ALLTRIM(SZ5->Z5_NLOGR) + " " + ALLTRIM(SZ5->Z5_COMPL) )) //20060328
				XCOB_BAI:= Space(Len(SZ5->Z5_BAIRRO))
				XCOB_CID:= Space(Len(SZ5->Z5_CIDADE))
				XCOB_EST:= Space(Len(SZ5->Z5_ESTADO))
				XCOB_CEP:= Space(Len(SZ5->Z5_CEP))
			EndIf
		EndIF
		
		DbSelectArea("SA1")
		xREC_CLI :=SA1->A1_ENDENT          // Endereco de Entrega
		xMUN_CLI :=SA1->A1_MUN             // Municipio
		xEST_CLI :=SA1->A1_EST             // Estado
		xCGC_CLI :=Iif(EMPTY(SA1->A1_CGC),SA1->A1_CGCVAL,SA1->A1_CGC)  // CGC
		xINSC_CLI:=SA1->A1_INSCR           // Inscricao estadual
		xTRAN_CLI:=SA1->A1_TRANSP          // Transportadora
		xTEL_CLI :=SA1->A1_TEL             // Telefone
		xFAX_CLI :=SA1->A1_FAX             // Fax
		xSUFRAMA :=SA1->A1_SUFRAMA         // Codigo Suframa
		xCALCSUF :=SA1->A1_CALCSUF         // Calcula Suframa

		//20040202
		if B_SERVENG .and. SA1->A1_TPCLI ='J'
			BRETEM := .T.
		endif //ateh aki 20040202
		// Alteracao p/ Calculo de Suframa
		If !empty(xSUFRAMA) .and. xCALCSUF =="S"
			IF XTIPO == 'D' .OR. XTIPO == 'B'
				zFranca := .F.
			Else
				zFranca := .T.
			Endif
		Else
			zfranca:= .F.
		Endif
	Else
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё CADASTRO DE FORNECEDORES                                         Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		zFranca:=.F.
		DbSelectArea("SA2")
		DbSetOrder(1)
		DbSeek(xFilial("SA2")+xCLIENTE+xLOJA)
		xCOD_CLI :=SA2->A2_COD             // Codigo do Fornecedor
		xNOME_CLI:=SA2->A2_NOME            // Nome Fornecedor
		xEND_CLI :=SA2->A2_END             // Endereco
		xBAIRRO  :=SA2->A2_BAIRRO          // Bairro
		xCEP_CLI :=SA2->A2_CEP             // CEP
		xCOB_CLI :=""                      // Endereco de Cobranca
		XCOB_BP  :=""						//20100305
		xREC_CLI :=""                      // Endereco de Entrega
		xMUN_CLI :=SA2->A2_MUN             // Municipio
		xEST_CLI :=SA2->A2_EST             // Estado
		xCGC_CLI :=SA2->A2_CGC             // CGC
		xINSC_CLI:=SA2->A2_INSCR           // Inscricao estadual
		xTRAN_CLI:=SA2->A2_TRANSP          // Transportadora
		xTEL_CLI :=SA2->A2_TEL             // Telefone
		xFAX_CLI :=SA2->A2_FAX             // Fax
		
	Endif
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё CADASTRO DE VENDEDORES                                           Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	DbSelectArea("SA3")
	DbSetOrder(1)
	xVENDEDOR:={}                         // Nome do Vendedor
	I:=1
	J:=Len(xCOD_VEND)
	
	For I:=1 to J
		dbSeek(xFilial("SA3")+xCOD_VEND[I])
		Aadd(xVENDEDOR,SA3->A3_NREDUZ)
	Next
	
	If xICMS_RET >0                          // Apenas se ICMS Retido > 0
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё CADASTRO LIVROS FISCAIS                                          Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		DbSelectArea("SF3")
		DbSetOrder(4)
		DbSeek(xFilial("SF3")+SA1->A1_COD+SA1->A1_LOJA+SF2->F2_DOC+SF2->F2_SERIE)
		If Found()
			xBSICMRET:=F3_VALOBSE
		Else
			xBSICMRET:=0
		Endif
	Else
		xBSICMRET:=0
	Endif
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё CADASTRO DE TRANSPORTADORAS                                      Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	DbSelectArea("SA4")
	DbSetOrder(1)
	DbSeek(xFilial("SA4")+SF2->F2_TRANSP)
	
	xNOME_TRANSP :=SA4->A4_NOME           // Nome Transportadora
	xEND_TRANSP  :=SA4->A4_END            // Endereco
	xMUN_TRANSP  :=SA4->A4_MUN            // Municipio
	xEST_TRANSP  :=SA4->A4_EST            // Estado
	xVIA_TRANSP  :=SA4->A4_VIA            // Via de Transporte
	xCGC_TRANSP  :=SA4->A4_CGC            // CGC
	xTEL_TRANSP  :=SA4->A4_TEL            // Fone
	XINSC_TRANSP :=SA4->A4_INSEST         // INSCR. ESTADUAL TRANSP.
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё CONTAS A RECEBER                                                 Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	DbSelectArea("SE1")
	DbSetOrder(1)
	xNUM_DUP   :={}                       // Parcela
	xPARC_DUP  :={}                       // Parcela
	xVENC_DUP  :={}                       // Vencimento
	xVALOR_DUP :={}                       // Valor
	MSOMABOL := 0 //20060529
	//xDUPLICATAS:=IIF(dbSeek(xFilial("SE1")+xSERIE+xNUM_DUPLIC,.T.),.T.,.F.) // Flag p/Impressao de Duplicatas
	xDUPLICATAS:=IIF(dbSeek(xFilial("SE1")+MPREFIXO+xNUM_DUPLIC,.T.),.T.,.F.) // Flag p/Impressao de Duplicatas
	If xDESCDUPL == "S" .OR. XDESCDUPL == 'CR'
		While !Eof() .And. ( SE1->E1_NUM == xNUM_DUPLIC );
			.And. ( xDUPLICATAS == .T. );
			.And. !EOF()
			
			If !("NF" $ SE1->E1_TIPO)
				DbSkip()
				Loop
			Endif
			AADD(xNUM_DUP  ,SE1->E1_NUM)
			AADD(xPARC_DUP ,SE1->E1_PARCELA)
			AADD(xVENC_DUP ,SE1->E1_VENCTO)
			// AADD(xVALOR_DUP,SE1->E1_VALOR)
			//AADD(xVALOR_DUP,SE1->E1_VALOR)
			//20040218			
			MSOMABOL := MSOMABOL + SE1->E1_DESPBOL //20060529
			IF MV_PAR04 = 1  //RETEM COFINS 
				IF MV_PAR05 = 1  //RETEM IR
					NVALORTOTAL :=  SE1->E1_VALOR -(E1_COFINS + E1_PIS + E1_CSLL +E1_IRRF)
				ELSE
					NVALORTOTAL :=  SE1->E1_VALOR -(E1_COFINS + E1_PIS + E1_CSLL) 
				ENDIF
			ELSE     
				IF MV_PAR05 = 1  //RETEM IR
					NVALORTOTAL :=  SE1->E1_VALOR - E1_IRRF
				ELSE
					NVALORTOTAL :=  SE1->E1_VALOR
				ENDIF
			ENDIF
			//ATEH AKI 20040218
			AADD(xVALOR_DUP,NVALORTOTAL ) // 20040218
			DbSkip()
		End
	EndIf
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё CADASTRO DE CLIENTES                                         Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	DbSelectArea("SF4")
	DbSetOrder(1)                                                               
	DbSeek(xFilial("SF4")+xTES[ITNT])

	//20040218          
	if bretem    
		IF MV_PAR04 = 1  //RETEM COFINS?
			IF MV_PAR05 = 1         //RETEM IR
				NVALIRRF := (XTOT_FAT * 1.50)/100
//				XTOT_FAT := XTOT_FAT - (NVALCOFINS + NVALPIS + NVALCSLL + NVALIRRF)  //comentado em 20040329 solicitado por Jose Ricardo Valenga
			ELSE
//				XTOT_FAT := XTOT_FAT - (NVALCOFINS + NVALPIS + NVALCSLL)  //comentado em 20040329 solicitado por Jose Ricardo Valenga
			ENDIF
		ELSE
			IF MV_PAR05 = 1         //RETEM IR
				NVALIRRF := (XTOT_FAT * 1.50)/100
//				XTOT_FAT := XTOT_FAT - (NVALIRRF)  //comentado em 20040329 solicitado por Jose Ricardo Valenga
			ELSE
				XTOT_FAT := XTOT_FAT
			ENDIF
		ENDIF
	endif
	// ateh aki 20040218
	
	Imprime()
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Termino da Impressao da Nota Fiscal                          Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	IncRegua()                    // Termometro de Impressao
	nLin:=0
	DbSelectArea("SF2")
	//    SF2->F2_IMPRESS := "S"        // Atualiza Flag Impresso=S / Wally 30/03
	DbSkip()                      // passa para a proxima Nota Fiscal
End

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё                      FIM DA IMPRESSAO                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Fechamento do Programa da Nota Fiscal                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
DbSelectArea("SF2")
Retindex("SF2")
DbSelectArea("SF1")
Retindex("SF1")
DbSelectArea("SD2")
Retindex("SD2")
DbSelectArea("SD1")
Retindex("SD1")
Set Device To Screen

If aReturn[5] == 1
	Set Printer TO
	dbcommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFuncao    Ё VERIMP   Ё Autor Ё   Marcos Simidu       Ё Data Ё 20/12/95 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao Ё Verifica posicionamento de papel na Impressora             Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё Nfiscal                                                    Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function VerImp()

nLin   := 0           // Contador de Linhas
nLinIni:= 0

If aReturn[5]==2
	nOpc := 1
	While .T.
		SetPrc(0,0)
		DbCommitAll()
		
		@ nLin ,000 PSAY " "
		@ nLin ,004 PSAY "*"
		@ nLin ,022 PSAY "."
		
		IF MsgYesNo("Fomulario esta posicionado ? ")
			nOpc := 1
		ElseIF MsgYesNo("Tenta Novamente ? ")
			nOpc := 2
		Else
			nOpc := 3
		Endif
		
		Do Case
			Case nOpc==1
				lContinua:=.T.
				Exit
			Case nOpc==2
				Loop
			Case nOpc==3
				lContinua:=.F.
				Return
		EndCase
	End
EndIf

Return
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFuncao    Ё CLASFIS  Ё Autor Ё   Marcos Simidu       Ё Data Ё 16/11/95 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao Ё Impressao de Array com as Classificacoes Fiscais           Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё Nfiscal                                                    Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function CLASFIS()

@ nLin,006 PSAY "Classificacao Fiscal"
nLin := nLin + 1
For nCont := 1 to Len(xCLFISCAL) .And. nCont <= 12
	nCol := If(Mod(nCont,2) != 0, 06, 33)
	@ nLin, nCol   PSAY ALLTRIM(xCLFISCAL[nCont]) + "-"
	@ nLin, nCol+ 05 PSAY Transform(xCLAS_FIS[nCont],"@r 99.99.99.99.99")
	nLin := nLin + If(Mod(nCont,2) != 0, 0, 1)
Next

Return
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFuncao    Ё IMPRIME  Ё Autor Ё   Marcos Simidu       Ё Data Ё 20/12/95 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Imprime a Nota Fiscal de Entrada e de Saida                Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё Generico RDMAKE                                            Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function Imprime()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё              IMPRESSAO DA NOTA FISCAL DE SAIDA.              Ё
//цдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
//Ё                   LINHAS DE IMPRESSAO                        Ё
//цдддддддддддбдддддддбдддддддддддддддддддддддддддддддддддддддддд╢
//Ё VARIAVEL  Ё VALOR Ё TEXTO                                    Ё
//цдддддддддддедддддддедддддддддддддддддддддддддддддддддддддддддд╢
//Ё _nLin01   Ё  00   Ё Primeira linha da nota fiscal. (nr.nf)   Ё
//Ё _nLin02   Ё  03   Ё Segunda Linha da NF (X)                  Ё
//Ё _nLin03   Ё  09   Ё 3╖ Linha - Nat. Op. , CFOP.              Ё
//Ё _nLin04   Ё  12   Ё 4╖ Linha - Razao Social,Cod.Cli,CNPJ/CPF.Ё
//Ё _nLin05   Ё  14   Ё 5╖ Linha - Endereco, Bairro, CEP, Dt.Em. Ё
//Ё _nLin06   Ё  16   Ё 6╖ Linha - Municipio,Tel/Fax,UF,Insc.Est.Ё
//Ё _nLin07   Ё  62   Ё Linha do Vl. do ISS e do Total dos Serv. Ё
//Ё _nLin08   Ё  65   Ё Base Calc.ICMS, Vl.ICMS, Valor do Produt.Ё
//Ё _nLin09   Ё  67   Ё Frete, Seguro, Vl. IPI, Valor da Nota    Ё
//Ё _nLin10   Ё  70   Ё TRANSPORTADORA:Nome, Frete, Placa, CPF.. Ё
//Ё _nLin11   Ё  72   Ё TRANSPORTADORA:Endereco, Municipio, Insc.Ё
//Ё _nLin12   Ё  74   Ё TRANSPORTADORA:Qtd. , Especie, Marca, Nr.Ё
//Ё _nLin13   Ё  59   Ё NOVA RAZAO SOCIAL                        Ё
//Ё _nLin14   Ё  60   Ё NOVO ENDERECO                            Ё
//юдддддддддддадддддддадддддддддддддддддддддддддддддддддддддддддды

_nLin01:= 000
_nLin02:= 003
_nLin03:= 009
_nLin04:= 012
_nLin05:= 014
_nLin06:= 016
_nLin07:= 062
_nLin08:= 065
_nLin09:= 067
_nLin10:= 070
_nLin11:= 072
_nLin12:= 074
_nLin13:= 059
_nLin14:= 060

//зддддддддддддддддддддддддддддддддддддд©
//Ё Impressao do Cabecalho da N.F.      Ё
//юддддддддддддддддддддддддддддддддддддды
_nAjuste:= 2

//зддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё para ajustar o espacamento de linha em 1/8"   Ё
//юддддддддддддддддддддддддддддддддддддддддддддддды
@ _nLin01, 000 PSAY CHR(27)+CHR(48)     // Apenas para impressora OkiData.
@ _nLin01, 000 PSAY CHR(27)+CHR(103)    // Apenas para impressora OkiData.
@ _nLin01, 119 PSAY xNUM_NF             // Numero da Nota Fiscal.
@ _nLin01+1, 035 PSAY "NOVA RAZAO SOCIAL: PSE LTDA"  //20090714
/*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*/
@ _nLin02, 075 PSAY "X"
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Incluir natureza de operacao... ver onde ┌ melhor buscar....  Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
//xTXTCF:= SF4->F4_TEXTO
IF LEN(XTEXTO) >= 2
	xTXTCF:= XTEXTO[1]+"/"+XTEXTO[2]
ELSE
	xTXTCF:= XTEXTO[1]
ENDIF

@ _nLin03, 002  PSAY xTXTCF                                   // Descricao da Natureza Operacao.

IF LEN(XCF) >= 2
	@ _nLin03, 039  PSAY xCF[1]+"/"+xCF[2]            // Picture"@R 999"                   // Codigo da Natureza de Operacao
ELSE
	@ _nLin03, 039  PSAY xCF[1]
ENDIF

//
// Ver se ira ser incluso Inscr. Estadual do Subst. Tributario.
//
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Impressao dos Dados do Cliente                                            Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
@ _nLin04, 002  PSAY xNOME_CLI+"  "+xCOD_CLI            // Nome do Cliente
If !EMPTY(xCGC_CLI)                                     // Se o C.G.C. do Cli/Forn nao for Vazio.
	@ _nLin04, 075  PSAY xCGC_CLI Picture"@R 99.999.999/9999-99"
Else
	@ _nLin04, 075  PSAY " "                                    // Caso seja vazio, sem picture.
Endif
@ _nLin04,106  PSAY xEMISSAO                                  // Data da Emissao do Documento

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Impressao do Endereco do Cliente.                                         Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
@ _nLin05,002  PSAY substr(xEND_CLI,1,65)                                 // Endereco 20060328
@ _nLin05,069  PSAY xBAIRRO                                  // Bairro 20060328 era 54
@ _nLin05,092  PSAY xCEP_CLI Picture"@R 99999-999"           // CEP 20060328 era 90
@ _nLin05,106  PSAY " "                                      // Reservado  p/Data Saida/Entrada

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Impressao do Restante do endereco do cliente, na linha logo abaixo.       Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
@ _nLin06,002  PSAY xMUN_CLI                               // Municipio
@ _nLin06,037  PSAY xTEL_CLI                               // Telefone/FAX
@ _nLin06,067  PSAY xEST_CLI                               // U.F.
@ _nLin06,075  PSAY xINSC_CLI                              // Insc. Estadual

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Impressao da Fatura/Duplicata                                             Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nLin := 19                                            // Linha a ser usada na impressao de duplicatas/faturas.
BB   := 01                                            // Inicializacao da variavel a ser usada no For...Next.
nCol := 00                                            // Inicializacao da variavel a ser usada como coluna de impressao.

If xDuplicatas
	DUPLIC()
Else
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Endereco de cobranca do cliente.                                          Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If Len(XEND_COB) #0
		For xy2:= 1 TO Len(XEND_COB)
			@ nLin,077 PSAY XEND_COB[xy2]
			nLin:= nLin + 1
		Next
	EndIf
Endif

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Dados dos Produtos/Servicos Vendidos (Detalhe da Nota Fiscal)             Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
IMPDET()

//@ _nLin13,015  PSAY "NOVA RAZAO SOCIAL PSE LTDA"          // 20050405
@ (_nLin13),002  PSAY "O REGISTRO DAS OPERACOES RELATIVAS A PRESTACAO DE SERVICOS, CONSTANTE DESTE DOCUMENTO, DEVERA SER CONVERTIDO POR NF-e" // 20060810
@ _nLin14,002  PSAY "PAGTO SOMENTE C/ BOLETO BANCARIO: NAO ACEITAMOS PAGTO VIA DOC, TRANSF. OU DEP. SIMPLES. POIS NOSSO SISTEMA NAO IDENTIFICA"                                 // 20060522

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime mensagem do corpo da Nota Fiscal                                  Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
IMPMENP()

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime Totais de ISS e Servi┤os.                                         Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
@ _nLin07, 057  PSAY X_TOTISS    Picture"@E 9,999,999.99"
@ _nLin07, 102  PSAY XTOT_SERV  Picture"@E 9,999,999.99"
@ _nLin08, 005  PSAY xBASE_ICMS  Picture"@E@Z 999,999,999.99"  // Base do ICMS.
@ _nLin08, 030  PSAY xVALOR_ICMS Picture"@E@Z 999,999,999.99"  // Valor do ICMS.
@ _nLin08, 047  PSAY xBSICMRET   Picture"@E@Z 999,999,999.99"  // Base ICMS Ret.
@ _nLin08, 070  PSAY xICMS_RET   Picture"@E@Z 999,999,999.99"  // Valor  ICMS Ret.
@ _nLin08, 101  PSAY xTOT_MERC   Picture"@E@Z 999,999,999.99"  // Valor Tot. Prod.
/*ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*/
@ _nLin09, 002  PSAY xDESPREM    Picture"@E@Z 999,999,999.99"  // Valor do Frete.  //20060529
@ _nLin09, 030  PSAY xSEGURO     Picture"@E@Z 999,999,999.99"  // Valor Seguro.
@ _nLin09, 057  PSAY MSOMABOL    Picture"@E@Z 999,999.99"  // Outras Despesas Acessorias. //20060529
@ _nLin09, 070  PSAY xVALOR_IPI  Picture"@E@Z 999,999,999.99"  // Valor do IPI.
@ _nLin09, 101  PSAY xTOT_FAT    Picture"@E@Z 999,999,999.99"  // Valor Total NF.

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Impressao Dados da Transportadora                                         Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
@ _nLin10,002  PSAY xNOME_TRANSP                   // Nome da Transport.
IF !EMPTY( xTPFRETE )
	If xTPFRETE=='C'                                   // Frete por conta do
		@ _nLin10, 076  PSAY "1"                        // Emitente (1)
	Else                                               //     ou
		@ _nLin10, 076 PSAY "2"                         // Destinatario (2)
	Endif
ENDIF
@ _nLin10, 080 PSAY " "                            // Res. p/Placa do Veiculo
@ _nLin10, 092 PSAY " "                            // Res. p/xEST_TRANSP                          // U.F.
If !EMPTY(xCGC_TRANSP)                             // Se C.G.C. Transportador nao for Vazio
	@ _nLin10, 098 PSAY TRANSFORM(xCGC_TRANSP,"@R 99.999.999/9999-99")
Else
	@ _nLin10, 098 PSAY " "                         // Caso seja vazio
Endif

/* дддддддддддддддддддддддддддддддддддддддддддддддддддддддд */
@ _nLin11, 002 PSAY xEND_TRANSP                                // Endereco Transp.
@ _nLin11, 063 PSAY xMUN_TRANSP                                // Municipio
@ _nLin11, 092 PSAY xEST_TRANSP                                // U.F.
@ _nLin11, 098 PSAY xINSC_TRANSP                               // Reservado p/Insc. Estad.
/* дддддддддддддддддддддддддддддддддддддддддддддддддддддддд */
@ _nLin12, 002 PSAY xVOLUME  Picture"@E@Z 999,999.99"          // Quant. Volumes
@ _nLin12, 023 PSAY xESPECIE Picture"@!"                       // Especie
@ _nLin12, 047 PSAY " "                                        // Res para Marca
@ _nLin12, 071 PSAY " "                                        // Res para Numero
@ _nLin12, 090 PSAY xPESO_BRUTO     Picture"@E@Z 999,999.99"   // Res para Peso Bruto
@ _nLin12, 107 PSAY xPESO_LIQUID    Picture"@E@Z 999,999.99"   // Res para Peso Liquido
If Len(xNUM_NFDV) > 0  .and. !Empty(xNUM_NFDV[1])
Endif

If !Empty(xSuframa)
EndIf

// nLin:=078
nLin:=077

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Imprime mensagem do c5_mennota no campo de mensagem                       Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
MENSOBS()

_cC5NUM := Iif(xPED_VEND[1] #NIL,xPED_VEND[1],"")
@ 085, 010  PSAY _cC5NUM
@ 085, 030  PSAY XCOD_VEND[1]    // _cC5NUM
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Numero da Nota Fiscal.                                                    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
@ 91, 090  PSAY xCOD_FAT         // Gilberto 06.11.2000
@ 91, 113  PSAY xNUM_NF
@ 96, 000  PSAY " "

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Zera o Formulario.                                                        Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetPrc(0,0)

Return .T.
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFuncao    Ё DUPLIC   Ё Autor Ё   Marcos Simidu       Ё Data Ё 20/12/95 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Impressao do Parcelamento das Duplicacatas                 Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё Nfiscal                                                    Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function DUPLIC()

nCol      := 2
_nIEndCob := 0    // Indice para Endereco de Cobranca.

For BB := 1 to Len(xVALOR_DUP)
	// _nIEndCob:= _nIEndCob + 1
	@ nLin, nCol      PSAY xNUM_DUP[BB] + " " + xPARC_DUP[BB]
	@ nLin, nCol + 12 PSAY xVALOR_DUP[BB] Picture("@E 9,999,999.99")
	@ nLin, nCol + 35 PSAY xNUM_DUP[BB]+" "+xPARC_DUP[BB]
	@ nLin, nCol + 56 PSAY xVENC_DUP [BB]
	
	// ALTERADO EM 27/11/00 By RC
	If Len(XEND_COB) #0 .AND. BB <= 3
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Endereco de cobranca do cliente.                                          Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		//  @ nLin,077   PSAY XEND_COB[_nIEndCob]
		@ nLin,077   PSAY XEND_COB[BB]
	Endif
	nLin := nLin + 1
Next

//         If Len(XEND_COB) #0 .And. _nIEndCob < Len(XEND_COB)
If Len(XEND_COB) #0 .And. BB < Len(XEND_COB)
	//            _nIEndCob:= _nIEndCob + 1
//	BB := BB + 1 //20041022
	//            For xy1:= _nIEndCob TO Len(XEND_COB)
	For xy1:= BB TO Len(XEND_COB)
		@ nLin,077 PSAY XEND_COB[xy1]
		nLin:= nLin + 1
	Next
	BB := BB + 1 //20041022
EndIF

Return

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFuncao    Ё IMPDET   Ё Autor Ё   Marcos Simidu       Ё Data Ё 20/12/95 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescricao Ё Impressao de Linhas de Detalhe da Nota Fiscal              Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё Nfiscal                                                    Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function IMPDET()

//         nTamDet     := 18           // Tamanho da Area de Detalhe
// Incluido em 09/11/00 para imprimir ate 18 servico, por Roger C.
// conforme solicitacao Sr.Cicero.
nTamDet     := 18
I           := 01           // Para uso no primerio For...Next.
J           := 01           // Para uso no segundo For...Next.
xB_ICMS_SOL := 00           // Base  do ICMS Solidario
xV_ICMS_SOL := 00           // Valor do ICMS Solidario
nLin        := 30     // 29 Alterado por Gilberto - A pedido de C║cero.

For I:=1 to nTamDet
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Impressao dos Itens de produtos fisicos  - controle de estoque " SIM "    Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If I <= Len(xCOD_PRO)
		If (xSERVICO[I] #"S")
			@ nLin, 002  PSAY ALLTRIM(xCOD_PRO [I])                              // codigo do produto.
			@ nLin, 016  PSAY SUBS(xDESC_PRO[I],1,40) //"CD/MANUAL"     // descricao do produto.
			//                     @ nLin, 065  PSAY xCOD_FIS [I]                              // codigo fiscal ?
			@ nLin, 065  PSAY xCOD_TRIB[I]                              // situacao tributaria ?
			@ nLin, 071  PSAY xUNID_PRO[I]                              // unidade do produto.
			@ nLin, 075  PSAY xQTD_PRO [I]   Picture"@E 999,999"        // quantidade do produto.
			@ nLin, 084  PSAY xPRE_UNI [I]   Picture"@E 99,999,999.99"  // preco unitario do prod.
			@ nLin, 102  PSAY xVAL_MERC[I]   Picture"@E 99,999,999.99"  // valor do produto.
			@ nLin, 120  PSAY xICM_PROD[I]   Picture"99"                // percentual do ICMS.
			//                     @ nLin, 124  PSAY xIPI     [I]   Picture"99"                // percentual do IPI.
			//                     @ nLin, 131  PSAY xVAL_IPI [I]   Picture"@E 9,999,999.99"   // valor do IPI.
			nLin:= nLin+1
			J:=J+1
		Endif
	EndIf
Next

nLin:= 40

For I:= 1 to nTamDet
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё  Impressao de produtos de servicos  - controle de estoque " NAO "   Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If I <= Len(xCOD_PRO)
		_lImp := .F.
		If (xSERVICO[I]=="S")
			@ nLin,002 PSAY AllTrim(xCOD_PRO [I])                     // Codigo do Produto.
			@ nLin,016 PSAY SUBS(xDESC_PRO[I],1,40)                   // Descricao do Produto no SC6.
			@ nLin,071 PSAY xUNID_PRO[I]                              // Unidade do Produto.
			@ nLin,075 PSAY xQTD_PRO [I]   Picture"@E 999,999"        // Quantidade do Produto.
			@ nLin,084 PSAY xPRE_UNI [I]   Picture"@E 99,999,999.99"  // Preco Unitario.
			@ nLin,102 PSAY xVAL_MERC[I]   Picture"@E 99,999,999.99"  // Preco Total.
			///                    @ nLin,120 PSAY xISS_PROD[I]   Picture"99"                // Percentual do ISS (Preparar Sistema).
			_lImp := .T.
		Endif
		IF nLin==57
			_lImp := .T.
		ENDIF
		IF _lImp
			J := J + 1
			nLin :=nLin+1
		Endif
	Endif
Next
Return
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFuncao    Ё IMPMENP  Ё Autor Ё   Marcos Simidu       Ё Data Ё 20/12/95 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Impressao Mensagem Padrao da Nota Fiscal                   Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё Nfiscal                                                    Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function IMPMENP()

nCol    := 00
nTamMen := 80
nlin    := nlin+1
If !Empty(xCOD_MENS)
	@ nLin, nCol PSAY SUBSTR(FORMULA(xCOD_MENS),1,nTamMen)
	nLin := nLin + 1
	@ nLin, nCol PSAY SUBSTR(FORMULA(xCOD_MENS),81,nTamMen)
Endif
Return
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFuncao    Ё MENSOBS  Ё Autor Ё   Marcos Simidu       Ё Data Ё 20/12/95 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Impressao Mensagem no Campo Observacao                     Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё Nfiscal                                                    Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function MENSOBS()


// Inclui o numero pedido no fim do conteudo em OBS - WM - 11/06
_cC5NUM   := Iif(xPED_VEND[1] #NIL,xPED_VEND[1],"")
_nTtlobs  := Len(alltrim(xMENSAGEM))           //   Retirado por Gilberto em 30/05/00 a pedido do usuario Cicero.
xMensagem := SubS( xMensagem, 1,_nTTlobs)      //   + "  Nr.Pedido:" + _cC5NUM
//*---------------------------------------------------------------------*
nTamObs:= 040
nCol   := 030          // coluna original e 30 dia 09.02.1999
@ nLin, 002   PSAY UPPER(SUBSTR(xMENSAGEM,01,nTamObs))
nlin:=nlin+1
@ nLin, 002   PSAY UPPER(SUBSTR(xMENSAGEM,41,nTamObs))
nlin:=nlin+1
@ nLin, 002   PSAY UPPER(SUBSTR(xMENSAGEM,81,nTamObs))
nlin:=nlin+1

// Conforme Solicitacao de C║cero. Gilberto - 13.11.2000
If xLivro
	@ nLin, 002   PSAY "IMUN.ICMS S/LIVRO ART.7 INC XIV RICMS APROV.P/DECR.33118/91"
	nLin:= nLin + 1
Endif

If xDoacao
	@ nLin, 002 PSAY "CESSAO DIREITO LIVRE DE DEBITO P/FINS DE TRIB. DO ISS"
	nLin:= nLin + 1
	@ nLin, 002 PSAY "DISTRIBUICAO P/ DESTINATARIO EM FORMA DE BRINDE."
	nLin:= nLin + 1
Endif

// Alteracao no Texto, conforme Solicitacao de C║cero. Gilberto - 13.11.2000
If xSup_Inf
	@ nLin, 002   PSAY "SUP.INF B.CALC ICMS DECR.33674/92 ART.51A DO RICMS"
EndIf

// nlin:=nlin+1
//If Len(xSimIrrf) == 0
// @ nLin, 002   PSAY "NAO INCIDENCIA DE IRRF CONF.IN 23 DE 21/08/86"
//EndIf
//20040218
IF BRETEM                                  
	IF MV_PAR04 = 1  //RETEM COFINS 
		nlin:=nlin+1  
		NVALRETTOTAL :=  (NVALCOFINS + NVALPIS + NVALCSLL)
		@ nLin, 002   PSAY "RETENCAO DE COFINS 3%, PIS 0,65% E CSLL 1% = 4,65% :R$"
		@ nLin, 055   PSAY NVALRETTOTAL Picture("@E 99,999.99")
	ENDIF
	
	IF MV_PAR05 = 1  //RETEM IR
		nlin:=nlin+1                                                              
		@ nLin, 002   PSAY "RETENCAO DE IRRF 1,50% :R$"        
		@ nLin, 030   PSAY NVALIRRF Picture("@E 99,999.99")
	ENDIF
ENDIF	
//ATEH AKI 20040218

nlin:=nlin+1
If !Empty(xMensNF4)
	@ nLin, 002   PSAY XMENSNF4
EndIf
Return
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    ЁVALIDPERG Ё Autor Ё  Luiz Carlos Vieira   Ё Data Ё 16/07/97 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Verifica as perguntas inclu║ndo-as caso n└o existam        Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё Espec║fico para clientes Microsiga                         Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function _ValidPerg()
_sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

aAdd(aRegs,{cPerg,"01","Nota de?       ","Nota de?       ","Nota de?       ","mv_ch1","C",06,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Nota atИ?      ","Nota atИ?      ","Nota atИ?      ","mv_ch2","C",06,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Serie?         ","Serie?         ","Serie?         ","mv_ch3","C",03,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})


For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		SX1->(MsUnlock())
	Endif
Next
DbSelectArea(_sAlias)
Return
