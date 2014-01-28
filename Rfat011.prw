#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
//Danilo C S Pala 20100305: ENDBP
User Function Rfat011()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("LI,LIN,TITULO,CDESC1,CDESC2,CDESC3")
SetPrvt("ARETURN,SERNF,NOMEPROG,CPERG,NLASTKEY,LCONTINUA")
SetPrvt("WNREL,NTAMBOL,CSTRING,TREGS,M_MULT,P_ANT")
SetPrvt("P_ATU,P_CNT,M_SAV20,M_SAV7,XCLIENTE,XDUPL")
SetPrvt("XPARC,XVENCTO,XVALOR,DUPL_NUM,DUPL_EMIS,DUPL_PARC")
SetPrvt("DUPL_CLIE,DUPL_VALOR,DUPL_VENC,DUPL_LOJA,MJUROS,CLIE_CGC")
SetPrvt("CLIE_NOME,CLIE_ENDE,CLIE_MUNI,CLIE_ESTA,CLIE_CEP,MLOCALPAG")
SetPrvt("MESPECIE,MACEITE,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: PFAT029   쿌utor: Solange Nalini         � Data:   10/01/98 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri놹o: Boletos do Unibanco                                        � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento                                      � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Lote                                 �
//� mv_par02             // Data                                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
li:=0
LIN:=0
titulo :=PADC("BOLETOS DE COBRAN�A - Nfiscal",74)
cDesc1 :=PADC("Este programa ira emitir Boletos de Cobran놹 do UNIBANCO ",74)
cDesc2 :=""
cDesc3 :=""

aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
SERNF:='UNI'
nomeprog:="UNIB "
cPerg:="FAT005"

nLastKey:= 0
lContinua := .T.
Lin:=0
wnrel    := "ITAU"

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Tamanho do Formulario de Nota Fiscal (em Linhas)          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

nTamBOL:=32     // Apenas Informativo

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Verifica as perguntas selecionadas, busca o padrao da Nfiscal           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Pergunte(cPerg,.T.)               // Pergunta no SX1

cString:="SF2"

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Envia controle para a funcao SETPRINT                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
   Return
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica Posicao do Formulario na Impressora                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif


//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//�  Prepara regua de impress�o                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

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

DBSELECTAREA('SE1')
DBSETORDER(1)
DbSeek(xFilial()+'UNI'+MV_PAR01)

IF .NOT. FOUND()
    RETURN
ENDIF
**


//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//�  Inicio do levantamento dos dados da Duplicata               �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

DO WHILE SE1->E1_NUM>=MV_PAR01 .AND.  SE1->E1_NUM<=MV_PAR02
    IF SE1->E1_CODPORT#'423'
       DBSKIP()
       LOOP
    ENDIF
    IF MONTH(SE1->E1_BAIXA)#0
       DBSKIP()
       LOOP
    ENDIF
                XCLIENTE :=SE1->E1_CLIENTE
                XDUPL    :=SE1->E1_NUM
                XPARC    :=SE1->E1_PARCELA
                XVENCTO  :=SE1->E1_VENCTO
                XVALOR   :=SE1->E1_VALOR

                    IMPBOL()
                    DBSKIP()

ENDDO

DbSelectArea("SC5")
Retindex("SC5")
DbSelectArea("SA1")
Retindex("SA1")
DbSelectArea("SZ5")
Retindex("SZ5")
DbSelectArea("SE1")
Retindex("SE1")
DbSelectArea("SC6")
Retindex("SC6")



SET DEVI TO SCREEN
IF aRETURN[5] == 1
  Set Printer to
  dbcommitAll()
  ourspool(WNREL)
ENDIF
MS_FLUSH()


// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION IMPBOL
Static FUNCTION IMPBOL()
                *컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*
                *   LEVANTAMENTO DE DADOS DA DUPLICATA PARA EMISSAO DO BOLETO        *
                *컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*
                SETPRC(0,0)
                LIN:=PROW()
                SET DEVI TO PRINT

                DUPL_NUM  := E1_NUM
                DUPL_EMIS := E1_EMISSAO                         && DATA EMISSAO
                DUPL_PARC := E1_PARCELA
                DUPL_CLIE := E1_CLIENTE                         && CODIGO DO CLIENTE
                DUPL_VALOR := E1_VALOR
                DUPL_VENC := E1_VENCTO
                DUPL_LOJA := E1_LOJA
                IF DUPL_PARC==' '
                   DUPL_PARC:='A'
                ENDIF

                *컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*
                *                          CALCULO DOS JUROS DIARIOS              *
                *컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*
                 MJUROS:=DUPL_VALOR*MV_PAR03/100
                 MJUROS:=STR(MJUROS,10,2)

                *컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*
                *                          DADOS DO CLIENTE                          *
                *컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*

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

                *컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*
                *                ENDERECO DO BOLETO - NORMAL OU DE COBRANCA       *
                *컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*

               * IF !EMPTY(SA1->A1_ENDCOB) .OR. SA1->A1_ENDCOB=='S'
				//20100305 DAQUI
				IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
					DbSelectArea("ZY3")
					DbSetOrder(1)
					DbSeek(XFilial()+DUPL_CLIE+DUPL_LOJA)
					CLIE_ENDE :=ZY3_END
					CLIE_BAIR :=ZY3_BAIRRO
					CLIE_MUNI :=ZY3_CIDADE
					CLIE_ESTA :=ZY3_ESTADO
					CLIE_CEP  :=ZY3_CEP 
               ELSEIF TRIM(SA1->A1_ENDCOB)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
                        DbSelectArea("SZ5")
                        DbSetOrder(1)
                        DbSeek(XFilial()+DUPL_CLIE+DUPL_LOJA)
                        CLIE_ENDE :=Z5_END
                        CLIE_MUNI :=Z5_CIDADE
                        CLIE_ESTA :=Z5_ESTADO
                        CLIE_CEP  :=Z5_CEP
                ELSE
                        CLIE_ENDE := SA1->A1_END
                        CLIE_MUNI := SA1->A1_MUN
                        CLIE_ESTA := SA1->A1_EST
                        CLIE_CEP  := SA1->A1_CEP
                ENDIF
//                  IF VAL(CLIE_CEP)<6000
//                     MLOCALPAG:='CENTRAL - SP '
//                  ELSE
//                     MLOCALPAG:=TRIM(CLIE_MUNI)+' - '+CLIE_ESTA
//                  ENDIF

                MLOCALPAG:='PAGAVEL EM QUALQUER BANCO ATE O VENCTO'
                MESPECIE :='DM'
                MACEITE  :='N'
                *컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*
                *                   IMPRESSAO DO BOLETO                      *
                *컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*
                @ LIN,00 say CHR(27)+"0"
                @ LIN  ,002  SAY  MLOCALPAG
                @ LIN  ,055  SAY  DUPL_VENC
//              @ LIN+04,001 SAY  DATE()
                @ LIN+04,001 SAY  DUPL_EMIS
                @ LIN+04,017 SAY  DUPL_NUM+' ' +DUPL_PARC
                @ LIN+04,032 SAY  MESPECIE
                @ LIN+04,038 SAY  MACEITE
//              @ LIN+06,035 SAY  DUPL_VALOR PICT '@E 999,999.99'
                @ LIN+06,055 SAY  DUPL_VALOR PICT '@E 999,999.99'

             // confirmar no programa a opcao de portador //

//              @ LIN+09,002 SAY '04-06'

//              @ LIN+10,002 SAY MV_PAR04
                @ LIN+10,002 SAY 'Taxa de: ' +mjuros +' Reais/Dia'
                @ LIN+12,002 SAY 'PROTESTAR APOS 3 DIAS UTEIS DO VENCTO'
                @ LIN+13,002 SAY 'NAO DISPENSAR JUROS DE MORA'

                @ LIN+18,004 SAY CLIE_NOME + DUPL_CLIE               && nome do cliente
                @ LIN+19,004 SAY CLIE_ENDE                           && endereco do cliente
                @ LIN+20,004 SAY CLIE_CEP+' ' +trim(CLIE_MUNI) +' - '+CLIE_ESTA +' CGC/CPF:'+CLIE_CGC
                @ LIN+21,00 SAY '.'
                SET DEVI TO SCREEN
                DbSelectArea("SE1")
             //   RecLock("SE1",.F.)
             //      REPLACE E1_CODPORT WITH '515'
             //      replace E1_BOLEM WITH 'S'
             //   dbUnlock()

                p_cnt := p_cnt + 1
                p_atu := 3+INT(p_cnt*m_mult)
                If p_atu != p_ant
                   p_ant := p_atu
                   Restscreen(23,0,24,79,m_sav7)
                   Restscreen(23,p_atu,24,p_atu+3,m_sav20)
                Endif
                set devi to print
                SetPrc(0,0)
                liN := 11
                @ LIN,00 say CHR(27)+"2"
RETURN .T.



