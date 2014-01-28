#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
//Danilo C S Pala 20060324: dados de enderecamento do DNE
//Danilo C S Pala 20100305: ENDBP
User Function Pfat028()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("LI,LIN,TITULO,CDESC1,CDESC2,CDESC3")
SetPrvt("ARETURN,SERNF,NOMEPROG,CPERG,NLASTKEY,LCONTINUA")
SetPrvt("WNREL,NTAMBOL,CSTRING,TREGS,M_MULT,P_ANT")
SetPrvt("P_ATU,P_CNT,M_SAV20,M_SAV7,XNFISCAL,XPEDIDO")
SetPrvt("XSERIE,XPRODUTO,MPREFIXO,XTIPOOP,VLRTOTA,XBOLETO1")
SetPrvt("XBOLETOD,MV_PAR04,DUPL_NUM,DUPL_EMIS,DUPL_PARC,DUPL_CLIE")
SetPrvt("DUPL_VALOR,DUPL_VENC,DUPL_LOJA,MJUROS,CLIE_CGC,CLIE_NOME")
SetPrvt("CLIE_ENDE,CLIE_MUNI,CLIE_ESTA,CLIE_CEP,MLOCALPAG,MESPECIE")
SetPrvt("MACEITE,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT028   ³Autor: Solange Nalini         ³ Data:   10/01/98 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Boletos do Banco Itau                                      ³ ±±
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
titulo :=PADC("BOLETOS DE COBRAN€A - Nfiscal",74)
cDesc1 :=PADC("Este programa ira emitir Boletos de Cobran‡a do ITAU ",74)
cDesc2 :=""
cDesc3 :=""

aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
SERNF:='UNI'
nomeprog:="ITAU "
cPerg:="FAT005"

nLastKey:= 0
lContinua := .T.
Lin:=0
wnrel    := "ITAU"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tamanho do Formulario de Nota Fiscal (em Linhas)          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nTamBOL:=32     // Apenas Informativo

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
**

DBSELECTAREA('SC6')
DBSETORDER(4)
DbSeek(xFilial()+MV_PAR01)

IF .NOT. FOUND()
    RETURN
ENDIF
**


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Inicio do levantamento dos dados da Duplicata               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DO WHILE SC6->C6_NOTA>=MV_PAR01 .AND.  SC6->C6_NOTA<=MV_PAR02


                XNFISCAL:=SC6->C6_NOTA
                XPEDIDO:=SC6->C6_NUM
                XSERIE:=SC6->C6_SERIE
                XPRODUTO:=SC6->C6_PRODUTO
//                IF SC6->C6_DATFAT<CTOD('29/09/2000')
//                   MPREFIXO:='FAT'
//                ELSE
                   MPREFIXO:=SC6->C6_SERIE
//                ENDIF
                DBSELECTAREA("SB1")
                DBSEEK(XFILIAL()+XPRODUTO)
                IF FOUND()
                IF SUBS(SB1->B1_COD,1,2)=='10' .AND. SUBS(SB1->B1_DESC,39,2)#'AV'
                   DBSELECTAREA("SC6")
                   DBSKIP()
                   LOOP
                ENDIF
                ENDIF
                DBSELECTAREA("SC6")
                DO WHILE SC6->C6_NOTA==XNFISCAL
                   DBSKIP()
                   IF SC6->C6_NOTA#XNFISCAL
                      DBSKIP(-1)
                      EXIT
                   ENDIF
                ENDDO


    DBSELECTAREA("SC5")
    DBSETORDER(1)
       DBSEEK(XFILIAL()+XPEDIDO)
       IF FOUND()
          XTIPOOP:=SC5->C5_TIPOOP
          XPEDIDO:=C5_NUM
          VLRTOTA:=C5_VLRPED
       ENDIF
          dbSelectArea("SZ9")
                    DbSetOrder(2)
                    DbSeek(XTIPOOP)
           IF FOUND()
              XBOLETO1:=SZ9->Z9_BOLETO1
              XBOLETOD:=SZ9->Z9_BOLETOD
           ENDIF
           IF XBOLETO1=='N' .AND. XBOLETOD=='N'
              DbSelectArea("SC6")
              Dbskip()
              loop
           ENDIF

           dbSelectArea("SE1")
           DbSetOrder(1)
           Dbseek(xFilial()+mprefixo+xNFISCAL)

           DO WHILE XNFISCAL == SE1->E1_NUM
              IF SE1->E1_SERIE#XSERIE
                 DBSKIP()
                 LOOP
              ENDIF
              MV_PAR04:=TRIM(MV_PAR04)
              IF MV_PAR04#'.'
                 IF SE1->E1_PARCELA#MV_PAR04
                    DBSKIP()
                    LOOP
                 ENDIF
              ENDIF
              IF SE1->E1_PARCELA=='A' .OR. SE1->E1_PARCELA==' '
                 IF XBOLETO1=='S'
                    IMPBOL()
                 ELSE
                    DBSELECTAREA("SE1")
                    DBSKIP()
                    LOOP
                 ENDIF
              ENDIF
// Verifica se ‚ nf ou confirmacao de pedido e emite s¢ a 1a. para livros
// alteracao feita em 13/01/00

              IF SE1->E1_PARCELA#'A' .AND. XBOLETOD=='S'
                 IMPBOL()
              ENDIF
              DBSKIP()
          ENDDO
          DbSelectArea("SC6")
          Dbskip()
          loop
    ENDDO

DbSelectArea("SC5")
Retindex("SC5")
DbSelectArea("SA1")
Retindex("SA1")
DbSelectArea("SZ5")
Retindex("SZ5")
DbSelectArea("SE1")
Retindex("SE1")
DbSelectArea("SZ9")
Retindex("SZ9")
DbSelectArea("SC6")
Retindex("SC6")



SET DEVICE TO SCREEN
IF aRETURN[5] == 1
  Set Printer to
  dbcommitAll()
  ourspool(WNREL)
ENDIF
MS_FLUSH()


// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION IMPBOL
Static FUNCTION IMPBOL()
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                *   LEVANTAMENTO DE DADOS DA DUPLICATA PARA EMISSAO DO BOLETO        *
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                SETPRC(0,0)
                LIN:=PROW()
                SET DEVICE TO PRINTER

                DUPL_NUM   := E1_NUM
                DUPL_EMIS  := E1_EMISSAO                         && DATA EMISSAO
                DUPL_PARC  := E1_PARCELA
                DUPL_CLIE  := E1_CLIENTE                         && CODIGO DO CLIENTE
                DUPL_VALOR := E1_VALOR
                DUPL_VENC  := E1_VENCTO
                DUPL_LOJA  := E1_LOJA
                IF DUPL_PARC==' '
                   DUPL_PARC:='A'
                ENDIF

                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                *                          CALCULO DOS JUROS DIARIOS              *
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                 MJUROS:=DUPL_VALOR*MV_PAR03/100
                 MJUROS:=STR(MJUROS,10,2)

                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                *                          DADOS DO CLIENTE                          *
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*

                DbSelectArea("Sa1")
                DBSEEK(xFilial()+DUPL_CLIE+DUPL_LOJA)
                IF FOUND()
                IF SA1->A1_CGC==SPACE(14)
                   CLIE_CGC  := SA1->A1_CGCVAL
                ELSE
                   CLIE_CGC  := SA1->A1_CGC
                ENDIF
                ENDIF
                CLIE_NOME := SA1->A1_NOME

                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                *                ENDERECO DO BOLETO - NORMAL OU DE COBRANCA       *
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*


			//20100305 DAQUI
			IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
				DbSelectArea("ZY3")
				DbSetOrder(1)
				DbSeek(XFilial()+DUPL_CLIE+DUPL_LOJA)
				CLIE_ENDE :=ZY3_END
				CLIE_MUNI :=ZY3_CIDADE
				CLIE_ESTA :=ZY3_ESTADO
				CLIE_CEP  :=ZY3_CEP
		    ELSEIF SUBS(SA1->A1_ENDCOB,1,1)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
                        DbSelectArea("SZ5")
                        DbSetOrder(1)
                        DbSeek(XFilial()+DUPL_CLIE+DUPL_LOJA)
                        CLIE_ENDE := ALLTRIM(Z5_TPLOG)+ " " + ALLTRIM(Z5_LOGR) + " " + ALLTRIM(Z5_NLOGR) + " " + ALLTRIM(Z5_COMPL) //20060324
                        CLIE_MUNI :=Z5_CIDADE
                        CLIE_ESTA :=Z5_ESTADO
                        CLIE_CEP  :=Z5_CEP
                ELSE
                        CLIE_ENDE := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060324
                        CLIE_MUNI := SA1->A1_MUN
                        CLIE_ESTA := SA1->A1_EST
                        CLIE_CEP  := SA1->A1_CEP
                ENDIF

//              IF VAL(CLIE_CEP)<6000
//                 MLOCALPAG:='CENTRAL - SP '
//              ELSE
//                 MLOCALPAG:=TRIM(CLIE_MUNI)+' - '+CLIE_ESTA
//              ENDIF

                MLOCALPAG:='PAGAVEL EM QUALQUER BANCO ATE O VENCTO'
                MESPECIE :='DM'
                MACEITE  :='N'
              /*
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                *                   IMPRESSAO DO BOLETO                      *
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
              */
                @ LIN,00 psay CHR(27)+"0"
                @ LIN  ,002  psay   MLOCALPAG
                @ LIN  ,055  psay   DUPL_VENC
//              @ LIN+04,001 psay   DATE()
                @ LIN+04,001 psay   DUPL_EMIS
                @ LIN+04,017 psay   DUPL_NUM+' ' +DUPL_PARC
                @ LIN+04,032 psay   MESPECIE
                @ LIN+04,038 psay   MACEITE
//              @ LIN+06,035 psay   DUPL_VALOR picture '@E 999,999.99'
                @ LIN+06,055 psay   DUPL_VALOR picture '@E 999,999.99'

             // confirmar no programa a opcao de portador //

//              @ LIN+09,002 psay '04-06'

//              @ LIN+10,002 psay MV_PAR04
//              @ LIN+10,002 psay 'Taxa de: ' +mjuros +' Reais/Dia'
                @ LIN+10,002 psay 'COBRAR R$ ' +mjuros +' POR DIA DE ATRASO.'
                @ LIN+12,002 psay 'NAO RECEBER APOS 10 DIAS DE VENCIDO'
                @ LIN+13,002 psay 'NAO DISPENSAR JUROS DE MORA'

                IF !EMPTY(MV_PAR05)
                   @ LIN+14,002 psay 'CONCEDER DESONTO DE R$ ' +STR(MV_PAR05,9,2)
                ENDIF

                @ LIN+18,004 psay CLIE_NOME + DUPL_CLIE              && nome do cliente
                @ LIN+19,004 psay CLIE_ENDE                          && endereco do cliente
                @ LIN+20,004 psay CLIE_CEP+' ' +trim(CLIE_MUNI) +' - '+CLIE_ESTA +' CGC/CPF:'+CLIE_CGC
                @ LIN+21,00  psay '.'
                SET DEVICE TO SCREEN
                DbSelectArea("SE1")
                RecLock("SE1",.F.)
                   REPLACE E1_CODPORT WITH '615'
                   replace E1_BOLEM WITH 'S'
                SE1->(MSUnlock())

                p_cnt := p_cnt + 1
                p_atu := 3+INT(p_cnt*m_mult)
                If p_atu != p_ant
                   p_ant := p_atu
                   Restscreen(23,0,24,79,m_sav7)
                   Restscreen(23,p_atu,24,p_atu+3,m_sav20)
                Endif
                set deviCE to printER
                SetPrc(0,0)
                liN := 11
                @ LIN,00 psay CHR(27)+"2"
RETURN .T.



