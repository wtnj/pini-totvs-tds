#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
   #DEFINE PSAY SAY
#ENDIF

//Danilo C S Pala 20060328: dados de enderecamento do DNE
//Danilo C S Pala 20100305: ENDBP
User Function Pfat071a()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CBTXT,CBCONT,NORDEM,ALFA,Z,M")
SetPrvt("TAMANHO,LIMITE,TITULO,CDESC1,CDESC2,CDESC3")
SetPrvt("CNATUREZA,ARETURN,NOMEPROG,CPERG,NLASTKEY,LCONTINUA")
SetPrvt("NLIN,WNREL,_NAUX,NTAMNF,CSTRING,CPEDANT")
SetPrvt("_XFILIAL,NLININI,XNUM_NF,XSERIE,XEMISSAO,XTOT_FAT")
SetPrvt("XCLIENTE,XLOJA,XVEND1,XFRETE,XSEGURO,XBASE_ICMS")
SetPrvt("XBASE_IPI,XVALOR_ICMS,XICMS_RET,XVALOR_IPI,XVALOR_MERC,XNUM_DUPLIC")
SetPrvt("XCOND_PAG,XPBRUTO,XPLIQUI,XTIPO,XESPECIE,XVOLUME")
SetPrvt("XTOT_ISS,XTOT_SERV,X_TOTISS,MPREFIXO,CPEDATU,CITEMATU")
SetPrvt("XPED_VEND,XITEM_PED,XNUM_NFDV,XPREF_DV,XICMS,XCOD_PRO")
SetPrvt("XQTD_PRO,XPRE_UNI,XPRE_TAB,XIPI,XVAL_IPI,XDESC")
SetPrvt("XVAL_DESC,XVAL_MERC,XTEXTO,XTES,XCF,XICMSOL")
SetPrvt("XICM_PROD,XVALICM,XSIMIRRF,XLIVRO,_XFILD2,XPESO_PRO")
SetPrvt("XPESO_UNIT,XDESCRICAO,XUNID_PRO,XCOD_TRIB,XMEN_TRIB,XCOD_FIS")
SetPrvt("XCLAS_FIS,XMEN_POS,XISS,XTIPO_PRO,XLUCRO,XCLFISCAL")
SetPrvt("XSERVICO,XPESO_LIQ,I,XTOT_MERC,XSUP_INF,NPELEM")
SetPrvt("_CLASFIS,NPTESTE,XPESO_LIQUID,XPED,XPESO_BRUTO,XP_LIQ_PED")
SetPrvt("XTIPOOP,XDESPREM,XTIPO_CLI,XCOD_MENS,XMENSAGEM,XTPFRETE")
SetPrvt("XCONDPAG,XCOD_FAT,XCOD_VEND,XDESC_NF,XDESCDUPL,XPAGA1")
SetPrvt("XPAGAD,XQTDEP,XCODFAT,XMENSNF4,XDESC_PAG,XPED_CLI")
SetPrvt("XDESC_PRO,J,ITNT,XEND_COB,XCOD_CLI,XNOME_CLI")
SetPrvt("XEND_CLI,XBAIRRO,XCEP_CLI,XCOB_CLI,XCOB_BAI,XCOB_CID, XCOB_BP")
SetPrvt("XCOB_EST,XCOB_CEP,XREC_CLI,XMUN_CLI,XEST_CLI,XCGC_CLI")
SetPrvt("XINSC_CLI,XTRAN_CLI,XTEL_CLI,XFAX_CLI,XSUFRAMA,XCALCSUF")
SetPrvt("ZFRANCA,XVENDEDOR,XBSICMRET,XNOME_TRANSP,XEND_TRANSP,XMUN_TRANSP")
SetPrvt("XEST_TRANSP,XVIA_TRANSP,XCGC_TRANSP,XTEL_TRANSP,XINSC_TRANSP,XNUM_DUP")
SetPrvt("XPARC_DUP,XVENC_DUP,XVALOR_DUP,XDUPLICATAS,NOPC,CCOR")
SetPrvt("NCONT,NCOL,_NLIN01,_NLIN02,_NLIN03,_NLIN04")
SetPrvt("_NLIN05,_NLIN06,_NLIN07,_NLIN08,_NLIN09,_NLIN10")
SetPrvt("_NLIN11,_NLIN12,_NAJUSTE,XTXTCF,BB,XY2")
SetPrvt("_CC5NUM,_NIENDCOB,XY1,NTAMDET,XB_ICMS_SOL,XV_ICMS_SOL")
SetPrvt("_LIMP,NTAMMEN,_NTTLOBS,NTAMOBS,_SALIAS,AREGS,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>    #DEFINE PSAY SAY
#ENDIF
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컫컴컴컴쩡컴컴컴컴커굇
굇쿌daptado  � PFAT071  � Autor � Gilberto A. de Oliveira  � Data � 05/05/00 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컨컴컴컴좔컴컴컴컴캑굇
굇쿏escricao � Nota Fiscal de Saida.                                         낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿢so       � Especifico para Editora Pini Ltda.                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿌lteracoes� 06.06.00 - Impressao dos campos                               낢�
굇�          �            Andreia Silva.                                     낢�
굇�          � 18/09/00 - Busca do titulo no FINANCEIRO. Apenas prefixo "FAT"낢�
굇�          � 18/09/00 - Acerto da impressao dos dados do titulo financeiro.낢�
굇�          �            Gilberto A. de Oliveira Jr.                        낢�
굇�          � 06/11/00 - Impressao do Campo Z9_CODFAT.                      낢�
굇�          �            Gilberto A. de Oliveira Jr.                        낢�
굇�          � 10/11/00 - Impressao das "Despesas Acessorias", C5_DESPREM.   낢�
굇�          �            Solicitante : Cicero                               낢�
굇�          �            Analista    : Gilberto A. de Oliveira Jr.          낢�
굇�          � 13.11.00 - Adi눯o de um texto especifico para prod. com TES   낢�
굇�          �            704. Alteracao no Texto de Inf. Complementares.    낢�
굇�          �            Solicitante : C죅ero                               낢�
굇�          �            Analista    : Gilberto A. de Oliveira Jr.          낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽
/*/

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Ambientais                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Da Nota Fiscal                       �
//� mv_par02             // Ate a Nota Fiscal                    �
//� mv_par03             // Da Serie                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

CbTxt    := ""
CbCont   := ""
nOrdem   := 000
Alfa     := 000
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

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Tamanho do Formulario de Nota Fiscal (em Linhas)                         �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

nTamNf:=72                         // Apenas Informativo

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica as perguntas selecionadas, (SX1).                               �
//� Caso nao existam cria o grupo. Nome do Grupo de Perguntas : NFSEPI       �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

_ValidPerg()
Pergunte(cPerg,.T.)

cString:="SF2"

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Envia controle para a funcao SETPRINT                                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
   Return
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica Posicao do Formulario na Impressora                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

#IFNDEF WINDOWS
    SetFirstPage(.T.)
#ELSE
    SetWFirstPage(.T.)
#ENDIF

VerImp()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Inicio do Processamento da Nota Fiscal                                   �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

#IFDEF WINDOWS
    RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     RptStatus({|| Execute(RptDetail)})
    Return
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     Function RptDetail
Static Function RptDetail()
#ENDIF

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//�  Cabecalho da Nota Fiscal Saida                                          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

DbSelectArea("SF2")
DbSetOrder(1)
DbSeek(xFilial("SF2")+mv_par01+mv_par03,.t.)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//�  Itens de Venda da Nota Fiscal                                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

DbSelectArea("SD2")
DbSetOrder(3)
DbSeek(xFilial("SD2")+mv_par01+mv_par03)
cPedant:= SD2->D2_PEDIDO

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Inicializa  regua de impressao                                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

SetRegua(Val(mv_par02)-Val(mv_par01))

DbSelectArea("SF2")

_xFilial:= xFilial("SF2")

While !Eof() .And. ( SF2->F2_DOC <= mv_par02 ) ;
             .And. ( SF2->F2_FILIAL==_xFilial );
             .And. lContinua

      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
      //� Se a Serie do Arquivo for Diferente do Parametro Informado !!!     �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

      If SF2->F2_SERIE #mv_par03
         DbSkip()
         Loop
      Endif

      #IFNDEF WINDOWS
            IF LastKey()==286
               @ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
               lContinua := .F.
               Exit
            Endif
      #ELSE
            IF lAbortPrint
               @ 00,01 PSAY "** CANCELADO PELO OPERADOR **"
               lContinua := .F.
               Exit
            Endif
      #ENDIF

      nLinIni:=nLin                         // Linha Inicial da Impressao

      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
      //� Inicio de Levantamento dos Dados da Nota Fiscal                    �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
      //� * CABECALHO DA NOTA FISCAL                                         �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

      xNUM_NF     :=SF2->F2_DOC             // Numero.
      xSERIE      :=SF2->F2_SERIE           // Serie.
      xEMISSAO    :=SF2->F2_EMISSAO         // Data de Emissao.
      xTOT_FAT    :=SF2->F2_VALFAT          // Valor Total da Fatura.

      If xTOT_FAT == 0
        xTOT_FAT := SF2->F2_VALMERC+SF2->F2_VALIPI+SF2->F2_SEGURO+SF2->F2_FRETE
      EndIf

      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
      //� 06.06.00 - Inclusao do campo: F2_VEND1 - Andreia Silva.            �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

      xCLIENTE    :=SF2->F2_CLIENTE         // Codigo do Cliente
      xLOJA       :=SF2->F2_LOJA            // Loja do Cliente.
      xVEND1      :=SF2->F2_VEND1           // Vendedor 1.
      xFRETE      :=SF2->F2_FRETE           // Frete.
      xSEGURO     :=SF2->F2_SEGURO          // Seguro.
      xBASE_ICMS  :=SF2->F2_BASEICM         // Base do ICMS.
      xBASE_IPI   :=SF2->F2_BASEIPI         // Base do IPI.
      xVALOR_ICMS :=SF2->F2_VALICM          // Valor do ICMS.
      xICMS_RET   :=SF2->F2_ICMSRET         // Valor do ICMS Retido.
      xVALOR_IPI  :=SF2->F2_VALIPI          // Valor do IPI.
      xVALOR_MERC :=SF2->F2_VALMERC         // Valor da Mercadoria.
      xNUM_DUPLIC :=SF2->F2_DUPL            // Numero da Duplicata.
      xCOND_PAG   :=SF2->F2_COND            // Condicao de Pagamento.
      xPBRUTO     :=SF2->F2_PBRUTO          // Peso Bruto.
      xPLIQUI     :=SF2->F2_PLIQUI          // Peso Liquido.
      xTIPO       :=SF2->F2_TIPO            // Tipo do Cliente.
      xESPECIE    :=SF2->F2_ESPECI1         // Especie 1 no Pedido.
      xVOLUME     :=SF2->F2_VOLUME1         // Volume 1 no Pedido.
      XTOT_ISS    :=SF2->F2_VALISS          // Valor do ISS.
      XTOT_SERV   :=SF2->F2_BASEISS
      x_TOTISS    :=SF2->F2_VALISS          // Alt.Andreia Silva - 26/02/99
      MPREFIXO    :=SF2->F2_PREFIXO

      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
      //� Itens de Venda da Nota Fiscal de Saida.                            �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

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
      xLIVRO   :=.F.                        // Valor do ICMS.

      _xFilD2:= xFilial("SD2")

      While !Eof() .And. ( SD2->D2_DOC==xNUM_NF    ) ;
                   .And. ( SD2->D2_SERIE==xSERIE   ) ;
                   .And. ( SD2->D2_FILIAL==_xFilD2 )

            //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
            //� Se a Serie do Arquivo for Diferente do Parametro Informado !!! �
            //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

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
            AADD(xQTD_PRO  ,SD2->D2_QUANT)                                  // Guarda as quant. da NF
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
            // AADD(xCF       ,SD2->D2_CF)
            IF ASCAN(xCF,SD2->D2_CF) == 0
               AADD(xCF       ,SD2->D2_CF)
            ENDIF
            AADD(xVALICM   ,SD2->D2_VALICM)
            AADD(xICM_PROD ,IIf(Empty(SD2->D2_PICM),0,SD2->D2_PICM))
            Dbskip()

      End-While

      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
      //� Cadastro de Produtos (Desc.Generica do Produto)                    �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

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
      xCLFISCAL  :={}                          // Auxiliar p/ Classifica눯o Fiscal.
      xSERVICO   :={}                          // Indica se Produtos Fisicao (CD/MANUAL) ou Servi뇇.
      xPESO_LIQ  :=00                          // Pe뇇 Liquido.

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
             IF Alltrim(XTES[I]) == "703" .OR. Alltrim(XTES[I])=="704"
                AADD(xCOD_TRIB  , "04")
             ELSE
                AADD(xCOD_TRIB  , "  ")
             ENDIF
          ENDIF

          // Utilizado para definir mensagem em Informacoes Complementares.
          // Caso encontre algum produtos destes grupos nao emitira mensagem :
          // "NAO INCIDENCIA DE IRRF..."

          IF SB1->B1_GRUPO $ "0500�1900"
             AADD(XSIMIRRF,SB1->B1_GRUPO)
          ENDIF

          DO CASE
             CASE SB1->B1_TIPO=="CD"            // Para CD/MANUAL.
                  AADD(xSERVICO,"N")
             CASE SB1->B1_TIPO=="TS"            // Para Servi뇇 (Treinamento).
                  AADD(xSERVICO,"S")
             CASE SB1->B1_TIPO=="SW"            // Para Servi뇇 (Software).
                  AADD(xSERVICO,"S")
             CASE SB1->B1_TIPO=="SE"            // Para Servi뇇s Especiais Pini Sistemas.
                  AADD(xSERVICO,"S")
             CASE SB1->B1_TIPO=="RC"            // Para "Servi뇇s" Relatorio de Custo.
                  AADD(xSERVICO,"S")
             CASE SB1->B1_TIPO=="PD"            // Para "Servi뇇s" Cursos Profissionalizantes de Desenvolvimento.
                  AADD(xSERVICO,"S")
             OTHERWISE                          // Para qualquer outro tipo.
                  AADD(xSERVICO,"N")
          ENDCASE

          // CASE xVALICM[I]<>0   -> USADO NA SYBASE, VER SE SERA UTILIZADO NA PINI.

          IF xSERVICO[I] <> "S"
             XTOT_MERC:=XTOT_MERC+XVAL_MERC[I]
          ELSE
             XTOT_SERV:=XTOT_SERV+XVAL_MERC[I]
          ENDIF

          If Ascan(xMEN_TRIB, SB1->B1_ORIGPRO)==0
             AADD(xMEN_TRIB ,SB1->B1_ORIGPRO)
          Endif

          npElem := Ascan(xCLAS_FIS,SB1->B1_POSIPI)

          if npElem == 0
             AADD(xCLAS_FIS  ,SB1->B1_POSIPI)
          endif

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

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
         //� Calculo do Peso Liquido da Nota Fiscal                           �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

         xPESO_LIQUID:=0
         For I:=1 to Len(xPESO_PRO)
            xPESO_LIQUID:=xPESO_LIQUID+xPESO_PRO[I]
         Next

      Next

      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
      //� PEDIDOS DE VENDA.                                                �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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

            XDESPREM    := SC5->C5_DESPREM            // A pedido do Sr. Cicero.
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

      /////

      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
      //� PESQUISA DA CONDICAO DE PAGTO.              �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

      DbSelectArea("SE4")
      DbSetOrder(1)
      DbSeek(xFilial("SE4")+xCONDPAG)
      xDESC_PAG := SE4->E4_DESCRI

      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
      //� ITENS DO PEDIDO DE VENDA.                   �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

      DbSelectArea("SC6")
      DbSetOrder(1)
      xPED_CLI :={}                          // Numero de Pedido
      xDESC_PRO:={}                          // Descricao aux do produto

      J:=Len(xPED_VEND)

      ITNT := 1

      For I:=1 to J

          DbSeek(xFilial("SC6")+xPED_VEND[I]+xITEM_PED[I])

          //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
          //� Variavel para Buscar a TES do primeiro Item digitado no PV      �
          //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
         //� CADASTRO DE CLIENTES                                             �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
         DbSelectArea("SA1")
         DbSetOrder(1)
         DbSeek(xFilial("SA1")+xCLIENTE+xLOJA)

         xCOD_CLI :=SA1->A1_COD             // Codigo do Cliente
         xNOME_CLI:=SA1->A1_NOME            // Nome
         xEND_CLI := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060328             // Endereco
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
            IF DbSeek(xFilial("SZ5")+SA1->A1_COD)
               XCOB_CLI:= Iif(Found(),ALLTRIM(SZ5->Z5_TPLOG)+ " " + ALLTRIM(SZ5->Z5_LOGR) + " " + ALLTRIM(SZ5->Z5_NLOGR) + " " + ALLTRIM(SZ5->Z5_COMPL) ,Space(Len(ALLTRIM(SZ5->Z5_TPLOG)+ " " + ALLTRIM(SZ5->Z5_LOGR) + " " + ALLTRIM(SZ5->Z5_NLOGR) + " " + ALLTRIM(SZ5->Z5_COMPL))))
               XCOB_BAI:= Iif(Found(),SZ5->Z5_BAIRRO,Space(Len(SZ5->Z5_BAIRRO)))
               XCOB_CID:= Iif(Found(),SZ5->Z5_CIDADE,Space(Len(SZ5->Z5_CIDADE)))
               XCOB_EST:= Iif(Found(),SZ5->Z5_ESTADO,Space(Len(SZ5->Z5_ESTADO)))
               XCOB_CEP:= Iif(Found(),SZ5->Z5_CEP,Space(Len(SZ5->Z5_CEP)))
               AADD(XEND_COB,XCOB_CLI)
               AADD(XEND_COB,XCOB_BAI)
               AADD(XEND_COB,XCOB_CEP+"  "+ALLTRIM(XCOB_CID)+" / "+XCOB_EST)
            ELSE
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
         xCGC_CLI :=SA1->A1_CGC             // CGC
         xINSC_CLI:=SA1->A1_INSCR           // Inscricao estadual
         xTRAN_CLI:=SA1->A1_TRANSP          // Transportadora
         xTEL_CLI :=SA1->A1_TEL             // Telefone
         xFAX_CLI :=SA1->A1_FAX             // Fax
         xSUFRAMA :=SA1->A1_SUFRAMA         // Codigo Suframa
         xCALCSUF :=SA1->A1_CALCSUF         // Calcula Suframa

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

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
         //� CADASTRO DE FORNECEDORES                                         �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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
         xREC_CLI :=""                      // Endereco de Entrega
         xMUN_CLI :=SA2->A2_MUN             // Municipio
         xEST_CLI :=SA2->A2_EST             // Estado
         xCGC_CLI :=SA2->A2_CGC             // CGC
         xINSC_CLI:=SA2->A2_INSCR           // Inscricao estadual
         xTRAN_CLI:=SA2->A2_TRANSP          // Transportadora
         xTEL_CLI :=SA2->A2_TEL             // Telefone
         xFAX_CLI :=SA2->A2_FAX             // Fax

      Endif
      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
      //� CADASTRO DE VENDEDORES                                           �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
         //� CADASTRO LIVROS FISCAIS                                          �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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

      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
      //� CADASTRO DE TRANSPORTADORAS                                      �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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

      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
      //� CONTAS A RECEBER                                                 �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
      DbSelectArea("SE1")
      DbSetOrder(1)

      xNUM_DUP   :={}                       // Parcela
      xPARC_DUP  :={}                       // Parcela
      xVENC_DUP  :={}                       // Vencimento
      xVALOR_DUP :={}                       // Valor
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

               If SE1->E1_SERIE <> MPREFIXO
                  DbSkip()
                  Loop
               EndIf
               If SE1->E1_PARCELA=="A" .OR. SE1->E1_PARCELA==" "
                  AADD(xNUM_DUP  ,Space(Len(SE1->E1_NUM)) )
                  AADD(xPARC_DUP ,SE1->E1_PARCELA)
                  AADD(xVENC_DUP ,"QUITADA" )        ///SE1->E1_VENCTO)
                  AADD(xVALOR_DUP,SE1->E1_VALOR)
               Else
                  AADD(xNUM_DUP  ,SE1->E1_NUM)
                  AADD(xPARC_DUP ,SE1->E1_PARCELA)
                  AADD(xVENC_DUP ,SE1->E1_VENCTO)
                  AADD(xVALOR_DUP,SE1->E1_VALOR)
               EndIf

               DbSkip()

         EndDo

      EndIf

      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
      //� CADASTRO DE CLIENTES                                         �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
      DbSelectArea("SF4")
      DbSetOrder(1)
      DbSeek(xFilial("SF4")+xTES[ITNT])

      Imprime()

      //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
      //� Termino da Impressao da Nota Fiscal                          �
      //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

      IncRegua()                    // Termometro de Impressao

      nLin:=0
      DbSelectArea("SF2")

//    SF2->F2_IMPRESS := "S"        // Atualiza Flag Impresso=S / Wally 30/03

      DbSkip()                      // passa para a proxima Nota Fiscal

EndDo

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//�                      FIM DA IMPRESSAO                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Fechamento do Programa da Nota Fiscal                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

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

#IFDEF WINDOWS
   SetWFirstPage(.T.)
#ENDIF

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Fim do Programa                                              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//�                   FUNCOES ESPECIFICAS                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑uncao    � VERIMP   � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escricao � Verifica posicionamento de papel na Impressora             낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Nfiscal                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//�袴袴袴袴袴袴袴袴袴袴敲
//� Inicio da Funcao    �
//훤袴袴袴袴袴袴袴袴袴袴�

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function VerImp
Static Function VerImp()

         nLin   := 0           // Contador de Linhas
         nLinIni:= 0

         If aReturn[5]==2

            nOpc := 1

            #IFNDEF WINDOWS
              cCor       := "B/BG"
            #ENDIF

            While .T.

                  SetPrc(0,0)
                  DbCommitAll()

                  @ nLin ,000 PSAY " "
                  @ nLin ,004 PSAY "*"
                  @ nLin ,022 PSAY "."

                  #IFNDEF WINDOWS
                      Set Device to Screen
                      DrawAdvWindow(" Formulario ",10,25,14,56)
                      SetColor(cCor)
                      @ 12,27 Say "Formulario esta posicionado?"
                      nOpc:=Menuh({"Sim","Nao","Cancela Impressao"},14,26,"b/w,w+/n,r/w","SNC","",1)
                      Set Device to Print
                  #ELSE
                      IF MsgYesNo("Fomulario esta posicionado ? ")
                         nOpc := 1
                      ElseIF MsgYesNo("Tenta Novamente ? ")
                         nOpc := 2
                      Else
                         nOpc := 3
                      Endif
                  #ENDIF

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
            End-While

         EndIf

Return

//�袴袴袴袴袴袴袴袴袴袴敲
//� Fim da Funcao       �
//훤袴袴袴袴袴袴袴袴袴袴�


/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑uncao    � CLASFIS  � Autor �   Marcos Simidu       � Data � 16/11/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escricao � Impressao de Array com as Classificacoes Fiscais           낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Nfiscal                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//�袴袴袴袴袴袴袴袴袴袴敲
//� Inicio da Funcao    �
//훤袴袴袴袴袴袴袴袴袴袴�

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function CLASFIS
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
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑uncao    � LI       � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Pula 1 linha                                               낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Generico RDMAKE                                            낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴�
//� Inicio da Funcao    �
//읕컴컴컴컴컴컴컴컴컴컴�
//旼컴컴컴컴컴컴컴컴컴컴�
//� Fim da Funcao       �
//읕컴컴컴컴컴컴컴컴컴컴�

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑uncao    � IMPRIME  � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Imprime a Nota Fiscal de Entrada e de Saida                낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Generico RDMAKE                                            낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function Imprime
Static Function Imprime()

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
         //�              IMPRESSAO DA NOTA FISCAL DE SAIDA.              �
         //쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
         //�                   LINHAS DE IMPRESSAO                        �
         //쳐컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
         //� VARIAVEL  � VALOR � TEXTO                                    �
         //쳐컴컴컴컴컴탠컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
         //� _nLin01   �  00   � Primeira linha da nota fiscal. (nr.nf)   �
         //� _nLin02   �  03   � Segunda Linha da NF (X)                  �
         //� _nLin03   �  09   � 3� Linha - Nat. Op. , CFOP.              �
         //� _nLin04   �  12   � 4� Linha - Razao Social,Cod.Cli,CNPJ/CPF.�
         //� _nLin05   �  14   � 5� Linha - Endereco, Bairro, CEP, Dt.Em. �
         //� _nLin06   �  16   � 6� Linha - Municipio,Tel/Fax,UF,Insc.Est.�
         //� _nLin07   �  62   � Linha do Vl. do ISS e do Total dos Serv. �
         //� _nLin08   �  65   � Base Calc.ICMS, Vl.ICMS, Valor do Produt.�
         //� _nLin09   �  67   � Frete, Seguro, Vl. IPI, Valor da Nota    �
         //� _nLin10   �  70   � TRANSPORTADORA:Nome, Frete, Placa, CPF.. �
         //� _nLin11   �  72   � TRANSPORTADORA:Endereco, Municipio, Insc.�
         //� _nLin12   �  74   � TRANSPORTADORA:Qtd. , Especie, Marca, Nr.�
         //읕컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

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

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� Impressao do Cabecalho da N.F.      �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         _nAjuste:= 2

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� para ajustar o espacamento de linha em 1/8"   �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

         @ _nLin01, 000 PSAY CHR(27)+CHR(48)     // Apenas para impressora OkiData.
         @ _nLin01, 000 PSAY CHR(27)+CHR(103)    // Apenas para impressora OkiData.
         @ _nLin01, 119 PSAY xNUM_NF             // Numero da Nota Fiscal.

         /*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/

         @ _nLin02, 075 PSAY "X"

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� Incluir natureza de operacao... ver onde � melhor buscar....  �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� Impressao dos Dados do Cliente                                            �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

         @ _nLin04, 002  PSAY xNOME_CLI+"  "+xCOD_CLI            // Nome do Cliente
         If !EMPTY(xCGC_CLI)                                     // Se o C.G.C. do Cli/Forn nao for Vazio.
            @ _nLin04, 075  PSAY xCGC_CLI Picture"@R 99.999.999/9999-99"
         Else
            @ _nLin04, 075  PSAY " "                                    // Caso seja vazio, sem picture.
         Endif
         @ _nLin04,106  PSAY xEMISSAO                                  // Data da Emissao do Documento

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� Impressao do Endereco do Cliente.                                         �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

         @ _nLin05,002  PSAY substr(xEND_CLI,1,65)                                 // Endereco
         @ _nLin05,069  PSAY xBAIRRO                                  // Bairro era 54
         @ _nLin05,090  PSAY xCEP_CLI Picture"@R 99999-999"           // CEP
         @ _nLin05,106  PSAY " "                                      // Reservado  p/Data Saida/Entrada

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� Impressao do Restante do endereco do cliente, na linha logo abaixo.       �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

         @ _nLin06,002  PSAY xMUN_CLI                               // Municipio
         @ _nLin06,037  PSAY xTEL_CLI                               // Telefone/FAX
         @ _nLin06,067  PSAY xEST_CLI                               // U.F.
         @ _nLin06,075  PSAY xINSC_CLI                              // Insc. Estadual

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� Impressao da Fatura/Duplicata                                             �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

         nLin := 19                                            // Linha a ser usada na impressao de duplicatas/faturas.
         BB   := 01                                            // Inicializacao da variavel a ser usada no For...Next.
         nCol := 00                                            // Inicializacao da variavel a ser usada como coluna de impressao.

         If xDuplicatas

            DUPLIC()

         Else
            //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
            //� Endereco de cobranca do cliente.                                          �
            //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
            If Len(XEND_COB) #0
               For xy2:= 1 TO Len(XEND_COB)
                   @ nLin,077 PSAY XEND_COB[xy2]
                   nLin:= nLin + 1
               Next
            EndIf
         Endif

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� Dados dos Produtos/Servicos Vendidos (Detalhe da Nota Fiscal)             �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

         IMPDET()

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� Imprime mensagem do corpo da Nota Fiscal                                  �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

         IMPMENP()

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� Imprime Totais de ISS e Servi뇇s.                                         �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

         @ _nLin07, 057  PSAY X_TOTISS    Picture"@E 9,999,999.99"
         @ _nLin07, 102  PSAY XTOT_SERV  Picture"@E 9,999,999.99"

         @ _nLin08, 005  PSAY xBASE_ICMS  Picture"@E@Z 999,999,999.99"  // Base do ICMS.
         @ _nLin08, 030  PSAY xVALOR_ICMS Picture"@E@Z 999,999,999.99"  // Valor do ICMS.
         @ _nLin08, 047  PSAY xBSICMRET   Picture"@E@Z 999,999,999.99"  // Base ICMS Ret.
         @ _nLin08, 070  PSAY xICMS_RET   Picture"@E@Z 999,999,999.99"  // Valor  ICMS Ret.
         @ _nLin08, 101  PSAY xTOT_MERC   Picture"@E@Z 999,999,999.99"  // Valor Tot. Prod.

         @ _nLin09, 002  PSAY xFRETE      Picture"@E@Z 999,999,999.99"  // Valor do Frete.
         @ _nLin09, 030  PSAY xSEGURO     Picture"@E@Z 999,999,999.99"  // Valor Seguro.
         @ _nLin09, 057  PSAY xDESPREM    Picture"@E@Z 999,999.99"      // Outras Despesas Acessorias.
         @ _nLin09, 070  PSAY xVALOR_IPI  Picture"@E@Z 999,999,999.99"  // Valor do IPI.
         @ _nLin09, 101  PSAY xTOT_FAT    Picture"@E@Z 999,999,999.99"  // Valor Total NF.

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� Impressao Dados da Transportadora                                         �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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

         @ _nLin11, 002 PSAY xEND_TRANSP                                // Endereco Transp.
         @ _nLin11, 063 PSAY xMUN_TRANSP                                // Municipio
         @ _nLin11, 092 PSAY xEST_TRANSP                                // U.F.
         @ _nLin11, 098 PSAY xINSC_TRANSP                               // Reservado p/Insc. Estad.

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

         nLin:=078

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� Imprime mensagem do c5_mennota no campo de mensagem                       �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         MENSOBS()

         _cC5NUM := Iif(xPED_VEND[1] #NIL,xPED_VEND[1],"")
         @ 085, 010  PSAY _cC5NUM
         @ 085, 030  PSAY XCOD_VEND[1]    // _cC5NUM
         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� Numero da Nota Fiscal.                                                    �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         @ 91, 090  PSAY xCOD_FAT         // Gilberto 06.11.2000
         @ 91, 113  PSAY xNUM_NF
         @ 96, 000  PSAY " "

         //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         //� Zera o Formulario.                                                        �
         //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
         SetPrc(0,0)

Return .T.
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑uncao    � DUPLIC   � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao do Parcelamento das Duplicacatas                 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Nfiscal                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function DUPLIC
Static Function DUPLIC()

         nCol:= 2
         _nIEndCob:= 0    // Indice para Endereco de Cobranca.

         For BB := 1 to Len(xVALOR_DUP)

             // _nIEndCob:= _nIEndCob + 1

             @ nLin, nCol      PSAY xNUM_DUP[BB] + " " + xPARC_DUP[BB]
             @ nLin, nCol + 12 PSAY xVALOR_DUP[BB] Picture("@E 9,999,999.99")
             @ nLin, nCol + 35 PSAY xNUM_DUP[BB]+" "+xPARC_DUP[BB]
             @ nLin, nCol + 56 PSAY xVENC_DUP [BB]

             // ALTERADO EM 27/11/00 By RC
             If Len(XEND_COB) #0 .AND. BB <= 3
                //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
                //� Endereco de cobranca do cliente.                                          �
                //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//                @ nLin,077   PSAY XEND_COB[_nIEndCob]
                @ nLin,077   PSAY XEND_COB[BB]
             Endif

             nLin := nLin + 1

         Next

//         If Len(XEND_COB) #0 .And. _nIEndCob < Len(XEND_COB)

         If Len(XEND_COB) #0 .And. BB < Len(XEND_COB)
//            _nIEndCob:= _nIEndCob + 1
            BB := BB + 1
//            For xy1:= _nIEndCob TO Len(XEND_COB)
            For xy1:= BB TO Len(XEND_COB)
                @ nLin,077 PSAY XEND_COB[xy1]
                nLin:= nLin + 1
            Next
         EndIF

Return
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑uncao    � IMPDET   � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escricao � Impressao de Linhas de Detalhe da Nota Fiscal              낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Nfiscal                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function IMPDET
Static Function IMPDET()

//       nTamDet     := 18           // Tamanho da Area de Detalhe
         // Incluido em 09/11/00 para imprimir ate 18 servico, por Roger C.
         // conforme solicitacao Sr.Cicero.
         nTamDet := 18
         I           := 01           // Para uso no primerio For...Next.
         J           := 01           // Para uso no segundo For...Next.
         xB_ICMS_SOL := 00           // Base  do ICMS Solidario
         xV_ICMS_SOL := 00           // Valor do ICMS Solidario
         nLin        := 30     // 29 Alterado por Gilberto - A pedido de C죅ero.

         For I:=1 to nTamDet

                 //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
                 //� Impressao dos Itens de produtos fisicos  - controle de estoque " SIM "    �
                 //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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

               //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
               //�  Impressao de produtos de servicos  - controle de estoque " NAO "   �
               //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

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
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑uncao    � IMPMENP  � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao Mensagem Padrao da Nota Fiscal                   낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Nfiscal                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function IMPMENP
Static Function IMPMENP()

         nCol:= 00
         nTamMen:=80
         nlin:=nlin+1
         If !Empty(xCOD_MENS)
            @ nLin, nCol PSAY SUBSTR(FORMULA(xCOD_MENS),1,nTamMen)
            nLin := nLin + 1
            @ nLin, nCol PSAY SUBSTR(FORMULA(xCOD_MENS),81,nTamMen)
         Endif

Return
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑uncao    � MENSOBS  � Autor �   Marcos Simidu       � Data � 20/12/95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao Mensagem no Campo Observacao                     낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Nfiscal                                                    낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function MENSOBS
Static Function MENSOBS()

         ***
         * Inclui o numero pedido no fim do conteudo em OBS - WM - 11/06
         ***

         _cC5NUM   := Iif(xPED_VEND[1] #NIL,xPED_VEND[1],"")

         _nTtlobs  := len(alltrim(xMENSAGEM))      // Retirado por Gilberto em 30/05/00 a pedido do usuario Cicero.
         xMensagem := subs( xMensagem, 1,_nTTlobs) // + "  Nr.Pedido:" + _cC5NUM

         nTamObs:= 040
         nCol   := 030          // coluna original e 30 dia 09.02.1999

         @ nLin, 002   PSAY UPPER(SUBSTR(xMENSAGEM,01,nTamObs))
         nlin:=nlin+1
         @ nLin, 002   PSAY UPPER(SUBSTR(xMENSAGEM,41,nTamObs))
         nlin:=nlin+1
         @ nLin, 002   PSAY UPPER(SUBSTR(xMENSAGEM,81,nTamObs))
         nlin:=nlin+1

         If xLivro   // Conforme Solicitacao de C죅ero. Gilberto - 13.11.2000
            nLin:= nLin - 1
            @ nLin, 002   PSAY "IMUN.ICMS S/LIVRO ART.7 INC XIV RICMS APROV.P/DECR.33118/91"
            nLin:= nLin + 1
         Endif
         // Alteracao no Texto, conforme Solicitacao de C죅ero. Gilberto - 13.11.2000
         // Mensagem valida apenas quando na nota fiscal houver algum produto de suporte informatico.
         If XSUP_INF
            @ nLin, 002   PSAY "SUP.INF B.CALC ICMS DECR.33674/92 ART.51A DO RICMS"
         Endif
         nlin:=nlin+1
         // Mensagem valida apenas quando na nota fiscal houver apenas produtos que nao terao incidencia de IRRF.
         If Len(xSimIrrf) == 0
            // @ nLin, 002   PSAY "NAO INCIDENCIA DE IRRF CONF.IN 23 DE 21/08/86"
         EndIf

         nlin:=nlin+1

         IF !EMPTY(XMENSNF4)
            @ nLin, 002   PSAY XMENSNF4
         ENDIF

Return
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿣ALIDPERG � Autor �  Luiz Carlos Vieira   � Data � 16/07/97 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Verifica as perguntas inclu죒do-as caso n꼘 existam        낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Espec죉ico para clientes Microsiga                         낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function _ValidPerg
Static Function _ValidPerg()

         _sAlias := Alias()
         DbSelectArea("SX1")
         DbSetOrder(1)
         cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
         aRegs:={}

         // Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

         AADD(aRegs,{cPerg,"01","Da Nota Fiscal     ?","mv_ch1","C",6,0,0,"G","","mv_par01","","000002","","","","","","","","","","","","",""})
         AADD(aRegs,{cPerg,"02","Ate a Nota Fiscal  ?","mv_ch2","C",6,0,0,"G","","mv_par02","","000002","","","","","","","","","","","","",""})
         AADD(aRegs,{cPerg,"03","Da Serie           ?","mv_ch3","C",3,0,0,"G","","mv_par03","","UNI","","","","","","","","","","","","",""   })

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




