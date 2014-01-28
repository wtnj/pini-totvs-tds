#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Rfat010()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("LI,LIN,TITULO,CDESC1,CDESC2,CDESC3")
SetPrvt("ARETURN,SERNF,NOMEPROG,CPERG,NLASTKEY,LCONTINUA")
SetPrvt("WNREL,CSTRING,TREGS,M_MULT,P_ANT,P_ATU")
SetPrvt("P_CNT,M_SAV20,M_SAV7,CINDEX,CKEY,MPEDIDO")
SetPrvt("DUPL_NUM,DUPL_EMIS,DUPL_PARC,DUPL_CLIE,DUPL_VALOR,DUPL_VENC")
SetPrvt("DUPL_LOJA,MJUROS,CLIE_CGC,CLIE_NOME,CLIE_ENDE,CLIE_MUNI")
SetPrvt("CLIE_ESTA,CLIE_CEP,MLOCALPAG,")

*ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
*º Programa    : BANCOB                                                      º
*º Descricao   : Duplicatas de livros e assinaturas                          º
*º Programador : Solange Nalini                                              º
*º Data        : 10/01/98                                                    º
*ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Lote                                 ³
//³ mv_par02             // Data                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li:=0
LIN:=0
titulo :=PADC("BOLETOS DE COBRAN€A - Nfiscal",74)
cDesc1 :=PADC("Este programa ira emitir Boletos de Cobran‡a do BANESPA",74)
cDesc2 :=PADC("para duplicatas em atraso, ref venda de livros",74)
cDesc3 :=""

aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
SERNF:='UNI'
nomeprog:="BANCOB"
cPerg:="COB001"
nLastKey:= 0
lContinua := .T.
Lin:=0
wnrel    := "BANCOB"


Pergunte(cPerg,.T.)               // Pergunta no SX1

cString:="SE1"

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

DBSELECTAREA('SE1')
   cIndex:=CriaTrab(Nil,.F.)
   cKEY:="DTOS(E1_BAIXA)+DTOS(E1_VENCREA)+E1_NUM+E1_PARCELA"
   Indregua("SE1",cIndex,cKey,,,"AGUARDE.. ")

DO WHILE DTOS(E1_BAIXA)==space(8)
   IF E1_VENCREA>MV_PAR01 .or. E1_CODPORT=='920' .OR. E1_CODPORT=='905' .OR. E1_CODPORT=='425'
//     IF E1_CODPORT#"CAR"
        DBSKIP()
      LOOP
   ENDIF
   MPEDIDO:=E1_PEDIDO
   DBSELECTAREA("SC6")
   DBSEEK(XFILIAL()+MPEDIDO)
   IF FOUND()
      IF SUBS(SC6->C6_PRODUTO,1,2)=='01'
         DBSELECTAREA("SE1")
         DBSKIP()
         LOOP
      ENDIF
   ENDIF

   IMPBOL()
   DBSELECTAREA("SE1")
       RECLOCK("SE1")
         SE1->E1_CODPORT:='425'
      SE1->(MSUNLOCK())
   DBSKIP()
ENDDO


DbSelectArea("SA1")
Retindex("SA1")
DbSelectArea("SE1")
Retindex("SE1")

SET DEVI TO SCREEN
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

                SET DEVI TO PRINT
                SET PRINT ON
                ??CHR(27)
                dbselectarea("SE1")

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

               * IF !EMPTY(SA1->A1_ENDCOB) .OR. SA1->A1_ENDCOB=='S'
               IF SA1->A1_ENDCOB=='S'
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
                IF VAL(CLIE_CEP)<6000
                   MLOCALPAG:='CENTRAL - SP '
                ELSE
                   MLOCALPAG:=TRIM(CLIE_MUNI)+' - '+CLIE_ESTA
                ENDIF

                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
                *                   IMPRESSAO DO BOLETO                      *
                *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*

                @ LIN  ,002 PSAY   MLOCALPAG
                @ LIN  ,055 PSAY   DUPL_VENC
                @ LIN+03,002 PSAY DATE()
                @ LIN+03,014 PSAY DUPL_NUM+" " +DUPL_PARC
                @ LIN+04,035 PSAY DUPL_VALOR PICTURE "@E 999,999.99"
                @ LIN+04,053 PSAY DUPL_VALOR PICTURE "@E 999,999.99"
                @ LIN+06,002 PSAY '04-06'
                @ LIN+07,002 PSAY MV_PAR04
                @ LIN+08,002 PSAY 'Taxa Juros/Dia: ' +str(mv_par03,5,2)

                @ LIN+13,004 PSAY CLIE_NOME + DUPL_CLIE             && nome do cliente
                @ LIN+14,004 PSAY CLIE_ENDE                        && endereco do cliente
                @ LIN+15,004 PSAY CLIE_CEP+' ' +trim(CLIE_MUNI) +' - '+CLIE_ESTA +' CGC/CPF:'+CLIE_CGC                     && cep do cliente
                @ LIN+16,00 PSAY ' '
                SET DEVICE TO SCREEN
                DbSelectArea("SE1")
       //         RecLock("SE1",.F.)
       //            replace E1_CODPORT WITH MV_PAR02
       //         dbUnlock()

                p_cnt := p_cnt + 1
                p_atu := 3+INT(p_cnt*m_mult)
                If p_atu != p_ant
                   p_ant := p_atu
                   Restscreen(23,0,24,79,m_sav7)
                   Restscreen(23,p_atu,24,p_atu+3,m_sav20)
                Endif
                set deviCE to printER
                SetPrc(0,0)
                liN := 8
RETURN .T.



