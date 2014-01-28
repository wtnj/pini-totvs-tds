#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//Danilo C S Pala 20060328: dados de enderecamento do DNE
//Danilo C S Pala 20100305: ENDBP
User Function Rfat031()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,LIMITE,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CNATUREZA,ARETURN,RNF,NOMEPROG")
SetPrvt("CPERG,NLASTKEY,LCONTINUA,WNREL,NTAMNF,CSTRING")
SetPrvt("TREGS,M_MULT,P_ANT,P_ATU,P_CNT,M_SAV20")
SetPrvt("M_SAV7,INICIO,XNFISCAL,XPEDIDO,XSERIE,XTIPOOP")
SetPrvt("XCODPROM,XMENSNFN,NOTA_NUM,NOTA_EMIS,NOTA_CLIE,NOTA_LOJA")
SetPrvt("NOTA_MERC,NOTA_TOTA,NOTA_VEND,NOTA_COND,NOTA_DESPREM,SERNF")
SetPrvt("MPREFIX,NREGATU,NOTA_NATU,NOTA_COFI,NOTA_TESA,NOTA_PEDI")
SetPrvt("MD2CF,CLIE_CGC,CLIE_NOME,CLIE_INSC,CLIE_ENDE,CLIE_BAIR")
SetPrvt("CLIE_MUNI,CLIE_ESTA,CLIE_CEP,CLIE_SUF,CLIE_COBR,CLIE_TRAN")
SetPrvt("CLIE_FONE,CLIE_TIPO,XENDC,XBAIRROC,XCIDADEC,XESTADOC")
SetPrvt("XCEPC,XDESCRNF,XDESCDUPL,XPAGA1,XPAGAD,XQTDEP")
SetPrvt("XCODFAT,XMENSNF1,XMENSNF2,XMENSNF3,XMENSNF4,MDUPLA")
SetPrvt("MDUPLB,MDUPLC,MDUPLD,MDUPLE,MDUPLF,MVALA")
SetPrvt("MVALB,MVALC,MVALD,MVALE,MVALF,MPARCA")
SetPrvt("MPARCB,MPARCC,MPARCD,MPARCE,MPARCF,MVENCA")
SetPrvt("MVENCB,MVENCC,MVENCD,MVENCE,MVENCF,ITEM_CODI")
SetPrvt("ITEM_QUAN,ITEM_VUNI,ITEM_TOTA,ITEM_ABAT,ITEM_ITEM,ITEM_UNID")
SetPrvt("ITEM_DESC,VUNI_VTOT,mhora")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: NFSOFT    ³Autor: Solange Nalini         ³ Data:   14/02/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Notas Fiscais de essere               (impressora        ) ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Emite a nota fiscal p/anexar os demais boletos                        ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Lote                                 ³
//³ mv_par02             // Data                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
cDesc1 :=PADC("Este programa ira emitir a Nota Fiscal da P.Sistemas  ",74)
cDesc2 :=""
cDesc3 :=""
cNatureza:=""

aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
//RNF:='CNE'
nomeprog:="NFASLI"
cPerg:="FAT004"
nLastKey:= 0
lContinua := .T.
MHORA := TIME()
wnrel    := "NFLIV2_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tamanho do Formulario de Nota Fiscal (em Linhas)          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nTamNf:=66     // Apenas Informativo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas, busca o padrao da Nfiscal           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.T.)               // Pergunta no SX1

cString:="SF2"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

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


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Prepara regua de impressÆo                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

             IF SC6->C6_SERIE#'UNI'
                 DBSKIP()
                 LOOP
             ENDIF

             IF SUBS(SC6->C6_NUM,6,1)=='P'
                 DBSKIP()
                 LOOP
             ENDIF

                XNFISCAL:=SC6->C6_NOTA
                XPEDIDO :=SC6->C6_NUM
                XSERIE  :=SC6->C6_SERIE
                DO WHILE SC6->C6_NOTA==XNFISCAL
                   DBSKIP()
                   IF SC6->C6_NOTA#XNFISCAL .OR. SC6->C6_SERIE#XSERIE
                      DBSKIP(-1)
                      EXIT
                   ENDIF
                ENDDO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Inicio do levantamento dos dados da Nota Fiscal             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


    XPEDIDO:=C6_NUM
    DBSELECTAREA("SC5")
    DBSETORDER(1)
       DBSEEK(XFILIAL()+XPEDIDO)
       IF FOUND()
                XTIPOOP:=C5_TIPOOP
                XCODPROM:=C5_CODPROM
                /*
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                *                      MENSAGENS NOTA FISCAL                        *
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                */ 
                   xMENSNFN:=SUBSTR(SC5->C5_MENNOTA,1,45)
       ENDIF


    DbSelectArea("SF2")
    DbSetOrder(1)
    DbSeek(xFilial()+xnfiscal+xserie)
                /*
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                *                          CABECALHO DA NOTA                         *
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
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
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                *             ITENS DO CABECALHO QUE ESTAO NO ARQ. DE ITENS          *
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
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
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                *                          DADOS DO CLIENTE                          *
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
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
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                *                          ENDERECO DE COBRANCA                     *
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
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
                ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                *                      DEFINE CONDICAO DE PAGAMENTO P/TIPO DE OPER                 *
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
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
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                *                   IMPRESSAO DA NOTA FISCAL                 *
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                 */

   SET DEVICE TO PRINTER
   IF INICIO
      INICIO := .F.
      @ LI,00 PSAY CHR(27)+"0"
   ELSE
      LI := 7
   ENDIF
   @ LI,01 PSAY '.'
   SETPRC(0,0)
   LI := 0
   @ LI,71 PSAY NOTA_NUM
   LI := LI + 1
   @ LI,50 PSAY 'XX'
   LI := LI + 6
   @ LI,01 PSAY 'PRESTACAO DE SERVICOS'
   LI := LI + 3
   @ LI,01 PSAY  SUBST(CLIE_NOME,1,38) + ' ' + NOTA_CLIE
   @ LI,51 PSAY  CLIE_CGC
   @ LI,71 PSAY  NOTA_EMIS
   LI := LI + 2
   @ LI,01 PSAY  SUBST(CLIE_ENDE,1,35)
   @ LI,37 PSAY  CLIE_BAIR
   @ LI,58 PSAY  CLIE_CEP
   LI := LI + 2
   @ LI,01 PSAY  CLIE_MUNI
   @ LI,25 PSAY  CLIE_FONE
   @ LI,44 PSAY  CLIE_ESTA
   @ LI,50 PSAY  CLIE_INSC
   MDUPLA := ' '
   MDUPLB := ' '
   MDUPLC := ' '
   MDUPLD := ' '
   MDUPLE := ' '
   MDUPLF := ' '
   MVALA  := 0
   MVALB  := 0
   MVALC  := 0
   MVALD  := 0
   MVALE  := 0
   MVALF  := 0
   MPARCA := ' '
   MPARCB := ' '
   MPARCC := ' '
   MPARCD := ' '
   MPARCE := ' '
   MPARCF := ' '
   MVENCA := ' '
   MVENCB := ' '
   MVENCC := ' '
   MVENCD := ' '
   MVENCE := ' '
   MVENCF := ' '
   If xDescDupl == "S" .OR. XDESCDUPL == 'CR'
      DbSelectArea("SE1")
      DbSetOrder(1)
      DBSEEK(xFilial()+MPREFIX+NOTA_NUM)
      DO WHILE SE1->E1_PREFIXO == MPREFIX .AND. SE1->E1_NUM == NOTA_NUM .AND. ! EOF()
         IF SE1->E1_SERIE#SERNF
            DBSKIP()
            LOOP
         ENDIF

         IF SE1->E1_PARCELA=='A' .OR. SE1->E1_PARCELA==' '
            MDUPLA := '      '
            MPARCA := SE1->E1_PARCELA
            MVALA  := SE1->E1_VALOR
            MVENCA := 'PARC QUITADA '
         ENDIF
         IF SE1->E1_PARCELA=='B'
            MDUPLB := SE1->E1_NUM
            MVALB  := SE1->E1_VALOR
            MPARCB := 'B'
            MVENCB := SE1->E1_VENCTO
         ENDIF
         IF SE1->E1_PARCELA=='C'
            MDUPLC := SE1->E1_NUM
            MVALC  := SE1->E1_VALOR
            MPARCC := 'C'
            MVENCC := SE1->E1_VENCTO
         ENDIF
         IF SE1->E1_PARCELA=='D'
            MDUPLD := SE1->E1_NUM
            MVALD  := SE1->E1_VALOR
            MPARCD := 'D'
            MVENCD := SE1->E1_VENCTO
         ENDIF
         IF SE1->E1_PARCELA=='E'
            MDUPLE := SE1->E1_NUM
            MVALE  := SE1->E1_VALOR
            MPARCE := 'E'
            MVENCE := SE1->E1_VENCTO
         ENDIF
         IF SE1->E1_PARCELA=='F'
            MDUPLF := SE1->E1_NUM
            MVALF  := SE1->E1_VALOR
            MPARCF := 'F'
            MVENCF := SE1->E1_VENCTO
         ENDIF
         dbSkip()
      enddo
   ENDIF
   LI := LI+4
      @ LI,01 PSAY MDUPLA
      @ LI,11 PSAY MVALA  PICTURE '@e 999,999.99'
      @ LI,26 PSAY MDUPLA+' '+MPARCA
      @ LI,38 PSAY MVENCA
   @ LI,52 PSAY XENDC
   LI := LI + 1
   IF MDUPLB <> ' '
      @ LI,01 PSAY MDUPLB
      @ LI,11 PSAY MVALB  PICTURE '@e 999,999.99'
      @ LI,26 PSAY MDUPLB+' '+MPARCB
      @ LI,38 PSAY MVENCB
   ENDIF
   @ LI,52 PSAY XBAIRROC
   LI := LI + 1
   IF MDUPLC <> ' '
      @ LI,01 PSAY MDUPLC
      @ LI,11 PSAY MVALC  PICTURE '@e 999,999.99'
      @ LI,26 PSAY MDUPLC+' '+MPARCC
      @ LI,38 PSAY MVENCC
   ENDIF
   @ LI,52 PSAY XCIDADEC + ' ' + XESTADOC
   LI := LI + 1
   IF MDUPLD <> ' '
      @ LI,01 PSAY MDUPLD
      @ LI,11 PSAY MVALD  PICTURE '@e 999,999.99'
      @ LI,26 PSAY MDUPLD+' '+MPARCD
      @ LI,38 PSAY MVENCD
   ENDIF
   @ LI,52 PSAY XCEPC
   LI := LI + 1
   IF MDUPLE <> ' '
      @ LI,01 PSAY MDUPLE
      @ LI,11 PSAY MVALE  PICTURE '@e 999,999.99'
      @ LI,26 PSAY MDUPLE+' '+MPARCE
      @ LI,38 PSAY MVENCE
   ENDIF
   LI := LI + 1
   IF MDUPLF <> ' '
      @ LI,01 PSAY MDUPLF
      @ LI,11 PSAY MVALF  PICTURE '@e 999,999.99'
      @ LI,26 PSAY MDUPLF+' '+MPARCF
      @ LI,38 PSAY MVENCF
   ENDIF
   LI:= LI + 15
   DbSelectArea('SD2')
   DbSetOrder(3)
   DBSEEK(xFilial()+NOTA_NUM+SERNF)
   DO WHILE NOTA_NUM==SD2->D2_DOC .AND. SD2->D2_SERIE == SERNF .AND. .NOT. EOF()
      ITEM_CODI := SUBST(SD2->D2_COD,1,8)              && codigo produto
      ITEM_QUAN := ABS(SD2->D2_QUANT)                  && quantidade
      ITEM_VUNI := ABS(SD2->D2_PRCVEN)                 && preco unitario
      ITEM_TOTA := ABS(SD2->D2_TOTAL)                  && preco total
      ITEM_ABAT := SD2->D2_DESC                        && desconto
      ITEM_ITEM := SD2->D2_ITEMPV

      /*
      *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
      * Se o codigo for generico pega a descricao do SC6 senao do SB1      *
      *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
      */
      IF TRIM(SD2->D2_COD)#'1197000'
         DbSelectArea("SB1")
         DbSetOrder(1)
         DbSeek(xFilial()+ITEM_CODI)
         ITEM_UNID := SB1->B1_UM                     && unidade do produto
         ITEM_DESC := SB1->B1_DESC                   && descricao do produto
      ELSE
         DBSELECTAREA("SC6")
         DBSETORDER(1)
         DBSEEK(XFILIAL()+SD2->D2_PEDIDO+SD2->D2_ITEMPV)
         ITEM_DESC := SC6->C6_DESCRI                 && unidade do produto
         ITEM_UNID := SC6->C6_UM                     && descricao do produto
      ENDIF
      /*
      *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
      *                       Detalhes do Item - Produto                    *
      *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
       */
      @ LI,01 PSAY ITEM_CODI                      && imprime cod do produto
      @ LI,10 PSAY SUBSTR(ITEM_DESC,1,35)         && imprime descricao do item
      @ LI,48 PSAY STR(ITEM_QUAN,5)
      @ LI,56 PSAY ITEM_VUNI PICTURE '@E 999,999.99'
      @ LI,69 PSAY ITEM_TOTA PICTURE '@E 999,999.99'
      DbselectArea("SD2")
      DBSKIP()
      LI := LI+1
   ENDDO

   LI := 60
   VUNI_VTOT :=(NOTA_TOTA - NOTA_DESPREM)
   @ LI,69 PSAY VUNI_VTOT    PICTURE "@E 999,999.99"
   LI := LI + 5
   @ LI,35 PSAY NOTA_DESPREM PICTURE "@E 99,999.99"
   @ LI,69 PSAY NOTA_TOTA    PICTURE "@E 999,999.99"
   LI := LI + 10
   @ LI,01   PSAY XMENSNF1
   @ LI+1,01 PSAY XMENSNF2
   @ LI+2,01 PSAY XMENSNF3
   LI := LI + 3
   @ LI,01 PSAY XMENSNF4
   LI:=LI+5
   @ LI,05   PSAY XPEDIDO
   @ LI,22 PSAY NOTA_VEND
   LI := LI + 6
   @ LI,60 PSAY XCODFAT
   @ LI,72 PSAY NOTA_NUM

   DbSelectArea("SC6")
   DBSKIP()

   set device to screen
   p_cnt := p_cnt + 1
   p_atu := 3+INT(p_cnt*m_mult)
   If p_atu != p_ant
      p_ant := p_atu
      Restscreen(23,0,24,79,m_sav7)
      Restscreen(23,p_atu,24,p_atu+3,m_sav20)
   Endif

   set deviCE to printER
   SetPrc(0,0)
ENDDO
SET DEVICE TO SCREEN

IF aRETURN[5] == 1
  Set Printer to
  dbcommitAll()
  ourspool(WNREL)
ENDIF
MS_FLUSH()

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> __Return()
Return()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

*....................................


