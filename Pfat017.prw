#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Pfat017()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("TITULO,CDESC1,CTITULO,CCABEC1,CCABEC2,NCARACTER")
SetPrvt("ARETURN,CPROGRAMA,CPERG,NLASTKEY,M_PAG,LCONTINUA")
SetPrvt("WNREL,L,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,CDESC2,CDESC3,CSTRING")
SetPrvt("TREGS,M_MULT,P_ANT,P_ATU,P_CNT,M_SAV20")
SetPrvt("M_SAV7,XNOTA,XPEDIDO,MOBS,mhora")
/*
*ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
*º Programa    : RELCOM                                                      º
*º Descricao   : Relatorio de comissoes a pagar                              º
*º Programador : Solange Nalini                                              º
*º Data        : 24/06/98                                                    º
*ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
 */
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Ambientais                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Da Regiao                            ³
//³ mv_par02             // At‚ Regiao                           ³
//³ mv_par02             // Data de Pagamento                    ³
//³ mv_par02             // Mensal/Semestral                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo :=PADC("OBSERVACOES EM PEDIDOS",74)
cDesc1 :=PADC("Este programa emite relatorio de Obs em Pedidos ",74)

cTitulo:= ' **** OBSERVACOES EM PEDIDOS  **** '
//                 10        20        30        40        50        60        70         80        90        100      110       120     130         140      150       160
//        123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 12456789'
cCabec1:='PEDIDO    N.FISCAL     OBSERVACAO'
cCabec2:=' '
NCARACTER:=12

aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
cprograma:="PFAT017"

cPerg:="FAT004"
nLastKey:= 0
M_PAG:=1
lContinua := .T.
MHORA      := TIME()
wnrel    := "PFAT017_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

L:= 0
CbTxt:=""
CbCont:=""
nOrdem :=0
Alfa := 0
Z:=0
M:=0
tamanho:="P"


cDesc2 :=""
cDesc3 :=""


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas.                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.T.)               // Pergunta no SX1

cString:="SC6"


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


DBSELECTAREA("SC6")
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
SET SOFTSEEK ON

DBSELECTAREA('SC6')
DBSETORDER(4)
DbSeek(xFilial()+MV_PAR01)

IF .NOT. FOUND()
    RETURN
ENDIF

DO WHILE SC6->C6_NOTA>=MV_PAR01 .AND.  SC6->C6_NOTA<=MV_PAR02
XNOTA:=C6_NOTA
XPEDIDO:=C6_NUM
   DBSELECTAREA("SZK")
   DBSEEK(XFILIAL()+XPEDIDO)
   IF FOUND()
      MOBS:=ZK_OBS
   ELSE
      MOBS:=SPACE(40)
   ENDIF
   IF MOBS#SPACE(40)
      IMPOBS()
   ENDIF
DBSELECTAREA("SC6")
DBSKIP()
      p_cnt := p_cnt + 1
      p_atu := 3+INT(p_cnt*m_mult)
      If p_atu != p_ant
          p_ant := p_atu
          Restscreen(23,0,24,79,m_sav7)
          Restscreen(23,p_atu,24,p_atu+3,m_sav20)
      Endif
ENDDO

SET DEVICE TO SCREEN
IF aRETURN[5] == 1
  Set Printer to
  dbcommitAll()
  ourspool(WNREL)
ENDIF
MS_FLUSH()


// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION IMPOBS
Static FUNCTION IMPOBS()
IF L==0
   CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho,NCARACTER)
   L:=8
ENDIF
@ L,01 PSAY XPEDIDO
@ L,11 PSAY XNOTA
@ L,24 PSAY MOBS

   IF L>60
      L:=0
      M_PAG:=M_PAG+1
   ELSE
      L:=L+2
   ENDIF
RETURN


