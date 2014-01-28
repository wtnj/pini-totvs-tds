#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//Danilo C S Pala 20060328: dados de enderecamento do DNE
//Danilo C S Pala 20100305: ENDBP
User Function Rfat030()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Declaracao de variaveis utilizadas no programa atraves da funcao    Ё
//Ё SetPrvt, que criara somente as variaveis definidas pelo usuario,    Ё
//Ё identificando as variaveis publicas do sistema utilizadas no codigo Ё
//Ё Incluido pelo assistente de conversao do AP5 IDE                    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,LIMITE,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CNATUREZA,ARETURN,SERNF,NOMEPROG")
SetPrvt("CPERG,NLASTKEY,LCONTINUA,WNREL,NTAMNF,CSTRING")
SetPrvt("TREGS,M_MULT,P_ANT,P_ATU,P_CNT,M_SAV20")
SetPrvt("M_SAV7,INICIO,XNFISCAL,XPEDIDO,XSERIE,XTIPOOP")
SetPrvt("XCODPROM,XMENSNFN,NOTA_NUM,NOTA_EMIS,NOTA_CLIE,NOTA_LOJA")
SetPrvt("NOTA_MERC,NOTA_TOTA,NOTA_VEND,NOTA_COND,NOTA_DESPREM,MPREFIX")
SetPrvt("NREGATU,NOTA_NATU,NOTA_COFI,NOTA_TESA,NOTA_PEDI,MD2CF")
SetPrvt("CLIE_CGC,CLIE_NOME,CLIE_INSC,CLIE_ENDE,CLIE_BAIR,CLIE_MUNI")
SetPrvt("CLIE_ESTA,CLIE_CEP,CLIE_SUF,CLIE_COBR,CLIE_TRAN,CLIE_FONE")
SetPrvt("CLIE_TIPO,XENDC,XBAIRROC,XCIDADEC,XESTADOC,XCEPC")
SetPrvt("XDESCRNF,XDESCDUPL,XPAGA1,XPAGAD,XQTDEP,XCODFAT")
SetPrvt("XMENSNF1,XMENSNF2,XMENSNF3,XMENSNF4,COL,COL2")
SetPrvt("ITEM_CODI,ITEM_QUAN,ITEM_VUNI,ITEM_TOTA,ITEM_ABAT,MCOMPL")
SetPrvt("ITEM_UNID,ITEM_DESC,mhora")

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддддддддддддбддддддддддддддддддддддддддддддбдддддддддддддддддд© ╠╠
╠╠ЁPrograma: PFAT021   ЁAutor: Solange Nalini         Ё Data:   26/03/98 Ё ╠╠
╠╠цддддддддддддддддддддаддддддддддддддддддддддддддддддадддддддддддддддддд╢ ╠╠
╠╠ЁDescri┤ao: Notas Fiscais de Assinaturas e Livros (impressora OKIDATA) Ё ╠╠
╠╠цдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢ ╠╠
╠╠ЁUso      : M╒dulo de Faturamento                                      Ё ╠╠
╠╠юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды ╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis utilizadas para parametros                         Ё
//Ё mv_par01             // Lote                                 Ё
//Ё mv_par02             // Data                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
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
MHORA := TIME()
wnrel    := "NFEP_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Tamanho do Formulario de Nota Fiscal (em Linhas)          Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

nTamNf:=66     // Apenas Informativo

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


//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё  Prepara regua de impressфo                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
tregs := LastRec()-Recno()+1
m_mult := 1
IF tregs>0
   m_mult := 70/tregs
EndIf
p_ant := 4
p_atu := 4
p_cnt := 0
m_sav20 := dcursor(3)
m_sav7 := savescreen(23,0,24,79)

DBSELECTAREA('SC6')
DBSETORDER(4)
DbSeek(xFilial()+MV_PAR01)

IF .NOT. FOUND()
    RETURN
ENDIF

LIN:=PROW()
LI:=0
INICIO:=.T.
DO WHILE SC6->C6_NOTA>=MV_PAR01 .AND.  SC6->C6_NOTA<=MV_PAR02

              IF SUBS(SC6->C6_NUM,6,1)=='P'
                 DBSKIP()
                 LOOP
             ENDIF
                XNFISCAL:=SC6->C6_NOTA
                XPEDIDO :=SC6->C6_NUM
                XSERIE  :=SC6->C6_SERIE
                DO WHILE SC6->C6_NOTA==XNFISCAL
                   DBSKIP()
                   IF SC6->C6_NOTA#XNFISCAL
                      DBSKIP(-1)
                      EXIT
                   ENDIF
                ENDDO

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё  Inicio do levantamento dos dados da Nota Fiscal             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды


    XPEDIDO:=C6_NUM
    DBSELECTAREA("SC5")
    DBSETORDER(1)
       DBSEEK(XFILIAL()+XPEDIDO)
       IF FOUND()
                XTIPOOP:=C5_TIPOOP
                XCODPROM:=C5_CODPROM
                /*
                *ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                *                      MENSAGENS NOTA FISCAL                        *
                *ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                */
                   xMENSNFN:=SUBSTR(SC5->C5_MENNOTA,1,45)
       ENDIF


    DbSelectArea("SF2")
    DbSetOrder(1)
    DbSeek(xFilial()+xnfiscal+xserie)
                /*
                *дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                *                          CABECALHO DA NOTA                         *
                *дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                */
                NOTA_NUM  := F2_DOC
                NOTA_EMIS := F2_EMISSAO                         && DATA EMISSAO
                NOTA_CLIE := F2_CLIENTE                         && CODIGO DO CLIENTE
                NOTA_LOJA := F2_LOJA                            && CODIGO DA LOJA
                NOTA_MERC := F2_VALMERC                         && VALOR MERCADORIA
                NOTA_TOTA := F2_VALBRUT                         && VALOR BRUTO FATURADO
                NOTA_VEND := F2_VEND1                           && CODIGO VENDEDOR
                NOTA_COND := F2_COND                            && CONDICAO PAGAMENTO
                NOTA_DESPREM:=F2_DESPREM
                SERNF:=F2_SERIE
                MPREFIX:=F2_PREFIXO
                /*
                *ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                *             ITENS DO CABECALHO QUE ESTAO NO ARQ. DE ITENS          *
                *дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                */
                DbSelectArea("SD2")
                DbSetOrder(3)
                DBSEEK(xFilial()+NOTA_NUM+SERNF)
                NREGATU:=RECNO()
                NOTA_NATU:=' '
                NOTA_COFI:=' '

                DO WHILE SD2->D2_DOC==NOTA_NUM
                   IF SD2->D2_SERIE#SERNF
                      DBSKIP()
                      LOOP
                   ENDIF
                   NOTA_TESA := SD2->D2_TES                        && TIPO ENTRADA E SAIDA
                   NOTA_PEDI := SD2->D2_PEDIDO                     && PEDIDO INTERNO
                   DbSelectArea("SF4")
                   DBSEEK(xFilial()+SD2->D2_TES)
                   MD2CF:= SD2->D2_CF
                   IF NOTA_NATU==' '
                      NOTA_NATU :=TRIM(SF4->F4_TEXTO)
                      NOTA_COFI :=TRIM(MD2CF)
                   ELSE
                      IF TRIM(NOTA_NATU)#TRIM(SF4->F4_TEXTO)
                         NOTA_NATU :=NOTA_NATU+'/'+TRIM(SF4->F4_TEXTO)
                      ENDIF
                      IF TRIM(MD2CF)$(NOTA_COFI)
                         NOTA_COFI :=TRIM(NOTA_COFI)
                      ELSE
                         NOTA_COFI :=TRIM(NOTA_COFI)+'/'+TRIM(SD2->D2_CF)
                      ENDIF
                   ENDIF
                   DBSELECTAREA("SD2")
                   DBSKIP()
               ENDDO
               DBGOTO(NREGATU)
                /*
                *дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                *                          DADOS DO CLIENTE                          *
                *дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                */
                DbSelectArea("Sa1")
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
                *дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                *                          ENDERECO DE COBRANCA                     *
                *дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
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
                        XENDC   := ALLTRIM(SZ5->Z5_TPLOG)+ " " + ALLTRIM(SZ5->Z5_LOGR) + " " + ALLTRIM(SZ5->Z5_NLOGR) + " " + ALLTRIM(SZ5->Z5_COMPL) //20060328
                        XBAIRROC:= Z5_BAIRRO
                        XCIDADEC:= Z5_CIDADE
                        XESTADOC:= Z5_ESTADO
                        XCEPC   := Z5_CEP
                ELSE
                        XENDC   :=' '
                        XBAIRROC:=' '
                        XCIDADEC:=' '
                        XESTADOC:=' '
                        XCEPC   :=SPACE(8)
                ENDIF
                /*
                *дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                *                      DEFINE CONDICAO DE PAGAMENTO P/TIPO DE OPER                 *
                *дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
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
                     XMENSNF1:=' '
                     XMENSNF2:=' '
                     XMENSNF3:=' '
                DO CASE
                CASE XQTDEP==1 .AND. XPAGA1=='S'
                     XMENSNF4:='NF QUITADA.'
                CASE XQTDEP>1 .AND. XPAGA1=='S' .AND. XPAGAD=='S'
                     XMENSNF4:='NF QUITADA.'
                OTHER
                     XMENSNF4:=' '
                ENDCASE

                /*
                *дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                *                   IMPRESSAO DA NOTA FISCAL                 *
                *дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                */
                IF INICIO
                   SETPRC(6,0)
                   COL:=75
                   COL2:=114
                   @ 06,01  PSAY '.'
                ELSE
                   SETPRC(0,0)
                   @ 09,01  PSAY '.'
                   COL:=73
                   COL2:=112
                   SETPRC(6,0)
                ENDIF

                @ 06,COL  PSAY 'XX'
                @ 06,COL2 PSAY NOTA_NUM
                @ 07,001  PSAY ' '
                @ 10,025  PSAY 'FONE:0(XX11)3224-8811'
                @ 10,050  PSAY 'FAX:0(XX11)3224-0314'

                IF INICIO
                   INICIO:=.F.
                   INKEY(0)
                ENDIF
                @ 12,003 PSAY NOTA_NATU
                @ 12,039 PSAY NOTA_COFI
                @ 15,003 PSAY CLIE_NOME     + ' ' +NOTA_CLIE                && nome do cliente
//                IF LEN(TRIM(CLIE_CGC))<14
//                   @ 15,070 PSAY CLIE_CGC PICT "@R 999.999.999-99"        && c.g.c.
//                ELSE
//                   @ 15,070 PSAY CLIE_CGC PICT "@R 99.999.999/9999-99"    && c.g.c.
//                ENDIF
                @ 15,077 PSAY CLIE_CGC                          && c.g.c.
                @ 15,116 PSAY NOTA_EMIS                         && data de emissao
                @ 17,003 PSAY SUBSTR(CLIE_ENDE1,65)                         && endereco do cliente 20060328
                @ 17,069 PSAY CLIE_BAIR                         && bairro 20060328 ERA 61
                @ 17,092 PSAY SUBS(CLIE_CEP,1,5)+'-'+SUBS(CLIE_CEP,6,3)   && cep do cliente
                @ 19,003 PSAY CLIE_MUNI                         && cep do cliente
                @ 19,042 PSAY CLIE_FONE                         && fone do cliente
                @ 19,068 PSAY CLIE_ESTA                         && estado do cliente
                @ 19,087 PSAY CLIE_INSC                         && inscricao estadual

                @ 22,020 PSAY XENDC
                @ 23,007 PSAY SUBS(XCEPC,1,5)+'-'+SUBS(XCEPC,6,3)
                @ 23,030 PSAY XBAIRROC
                @ 23,083 PSAY XCIDADEC
                @ 23,121 PSAY XESTADOC
                If xDescDupl=="S"
                   DbSelectArea("SE1")
                   DbSetOrder(1)
                   DBSEEK(xFilial()+MPREFIX+NOTA_NUM)
              /*/
                   DO WHILE SE1->E1_PREFIXO == MPREFIX  .AND. SE1->E1_NUM == NOTA_NUM .AND. ! EOF()

                       IF SE1->E1_PARCELA=='A'.OR. SE1->E1_PARCELA==' '
                          @ 25,005 PSAY SE1->E1_NUM+' ' +SE1->E1_PARCELA
                          @ 25,025 PSAY SE1->E1_VALOR PICT '@e 999,999,999.99'
                          @ 25,050 PSAY SE1->E1_VENCTO
                       ENDIF
                       IF SE1->E1_PARCELA=='B'
                          @ 25,071 PSAY SE1->E1_NUM+' ' +SE1->E1_PARCELA
                          @ 25,089 PSAY SE1->E1_VALOR PICT '@e 999,999,999.99'
                          @ 25,112 PSAY SE1->E1_VENCTO
                       ENDIF
                       IF SE1->E1_PARCELA=='C'
                          @ 26,005 PSAY SE1->E1_NUM+' ' +SE1->E1_PARCELA
                          @ 26,025 PSAY SE1->E1_VALOR PICT '@e 999,999,999.99'
                          @ 26,050 PSAY SE1->E1_VENCTO
                       ENDIF
                       IF SE1->E1_PARCELA=='D'
                          @ 26,071 PSAY SE1->E1_NUM+' ' +SE1->E1_PARCELA
                          @ 26,089 PSAY SE1->E1_VALOR PICT '@e 999,999,999.99'
                          @ 26,112 PSAY SE1->E1_VENCTO
                       ENDIF
                       IF SE1->E1_PARCELA=='E'
                          @ 27,005 PSAY SE1->E1_NUM+' ' +SE1->E1_PARCELA
                          @ 27,025 PSAY SE1->E1_VALOR PICT '@e 999,999,999.99'
                          @ 27,050 PSAY SE1->E1_VENCTO
                       ENDIF
                       IF SE1->E1_PARCELA=='F'
                          @ 27,071 PSAY SE1->E1_NUM+' ' +SE1->E1_PARCELA
                          @ 27,089 PSAY SE1->E1_VALOR PICT '@e 999,999,999.99'
                          @ 27,112 PSAY SE1->E1_VENCTO
                       ENDIF
                       dbSkip()
                   enddo
             /*/
                endif



                LIN:=31
                DbSelectArea('SD2')
                DbSetOrder(3)
                DO WHILE NOTA_NUM==SD2->D2_DOC .AND. SD2->D2_SERIE == SERNF .AND. .NOT. EOF()
                        ITEM_CODI := SD2->D2_COD                         && codigo produto
                        ITEM_QUAN := ABS(SD2->D2_QUANT)                  && quantidade
                        ITEM_VUNI := ABS(SD2->D2_PRCVEN)                 && preco unitario
                        ITEM_TOTA := ABS(SD2->D2_TOTAL)                  && preco total
                        ITEM_ABAT := SD2->D2_DESC                        && desconto

                        IF SUBS(ITEM_CODI,1,2)=='01' .AND. SUBS(ITEM_CODI,5,3)#'001'
                           MCOMPL:='ED: '+LTRIM(STR(ITEM_EDINIC,6,0))+' A '+LTRIM(STR(ITEM_EDFIN,6,0))
                        ELSE
                           MCOMPL:=' '
                        ENDIF
                        DbSelectArea("SB1")
                        DbSetOrder(1)
                        DbSeek(xFilial()+ITEM_CODI)
                        ITEM_UNID := SB1->B1_UM                     && unidade do produto
                        ITEM_DESC := SUBS(SB1->B1_DESC,1,24)        && descricao do produto
                       /*
                        *ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                        *                       Detalhes do Item - Produto                    *
                        *ддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
                       */
                        @ LIN+LI,002 PSAY ITEM_CODI                      && imprime cod do produto
                        @ LIN+LI,020 PSAY ITEM_DESC                      && imprime descricao do item
                        @ LIN+LI,058 PSAY 'CFOP:'+ALLTRIM(SD2->D2_CF)                           && SITUACAO TRIBUTARIA
                        @ LIN+LI,075 PSAY '04'                           && SITUACAO TRIBUTARIA
                        @ LIN+LI,080 PSAY 'UN'                           && SITUACAO TRIBUTARIA
                        @ LIN+LI,084 PSAY ITEM_QUAN PICTURE '@E 999999'
                        @ LIN+LI,095 PSAY ITEM_VUNI PICTURE '@E 99,999.99'
                        @ LIN+LI,108 PSAY ITEM_TOTA PICTURE '@E 9,999,999.99'
                        DBSELECTAREA("SD2")
                        DBSKIP()
                        LIN:=LIN+1
                ENDDO
                DBSELECTAREA("SF2")

                IF NOTA_DESPREM <> 0
                   NOTA_TOTA :=NOTA_MERC + NOTA_DESPREM
                   END

                @ 40,102 PSAY NOTA_MERC    PICTURE '@E 9,999,999,999.99'
                @ 42,056 PSAY NOTA_DESPREM PICTURE "@E 9,999.99"
                @ 42,102 PSAY NOTA_TOTA    PICTURE '@E 9,999,999,999.99'


                DbSelectArea("SA3")
                DbSetOrder(1)
                DbSeek(xFilial()+NOTA_VEND)

                LIN:=51
                @ LIN+1,20 PSAY XPEDIDO
//              @ LIN+1,52 PSAY NOTA_VEND
                @ LIN+1,46 PSAY NOTA_VEND
                @ LIN+1,52 PSAY '/ '+ SA3->A3_LOCAL
                IF XMENSNF4#'NF QUITADA'
                   @ LIN+3,20 PSAY 'A NF SERA CONSIDERADA QUITADA APOS PAGTO DOS BOLETOS'
                   @ LIN+4,20 PSAY 'ENVIADOS ANEXOS A CONFIRMACAO DO PEDIDO ACIMA.'
                ENDIF

                @ LIN+5,20 PSAY XMENSNF3
                @ LIN+6,20 PSAY XMENSNFN
                @ LIN+7,20 PSAY XMENSNF4
                @ 63,95 PSAY XCODFAT
                @ 63,115 PSAY NOTA_NUM
//              DbSelectArea("SF2")                  //ESTA PARTE DEVE SER
//                 RecLock("SF2",.F.)              // RESTAURADA APOS TESTE
//                 replace F2_NFEM WITH 'S'
//              dbUnlock()

                DbSelectArea("SC6")
                DBSETORDER(4)
                DBSKIP()
                set device to screen

                SETPRC(0,0)


      p_cnt := p_cnt + 1
      p_atu := 3+INT(p_cnt*m_mult)
      If p_atu != p_ant
         p_ant := p_atu
          Restscreen(23,0,24,79,m_sav7)
          Restscreen(23,p_atu,24,p_atu+3,m_sav20)
       Endif
       set devi to print
       SetPrc(0,0)

       LIN:=6
       LI:=0
   ENDDO
   SET DEVI TO SCREEN
   DBSELECTAREA("SC6")
   DBSETORDER(1)


IF aRETURN[5] == 1
  Set Printer to
  dbcommitAll()
  ourspool(WNREL)
ENDIF
MS_FLUSH()

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> __Return()
Return()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02


