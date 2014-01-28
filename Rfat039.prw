#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: Rcanc     ³Autor: Solange Nalini         ³ Data:   15/10/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Relatorio de nf canceladas                                 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento/Financeiro e Contabibilidade         ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat039()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("TITULO,CDESC1,CTITULO,CCABEC2,NCARACTER,ARETURN")
SetPrvt("CPROGRAMA,CPERG,NLASTKEY,M_PAG,LCONTINUA,WNREL")
SetPrvt("L,CBTXT,CBCONT,NORDEM,ALFA,Z")
SetPrvt("M,TAMANHO,CDESC2,CDESC3,CCABEC1,CSTRING")
SetPrvt("XCONT,_VALTOT,_NFISCAL,_SERIE,_CLIENTE,_PEDIDO")
SetPrvt("_EMISSAO,_DTCANC,_VALOR,_MOTIVO,_TES,_NOMECLI")
SetPrvt("_PRODUTO,_DPRODUTO,mhora")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Data de cancelamento do SZI Inicial  ³
//³ mv_par02             // Data de cancelamento do SZI Final    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Titulo :=PADC("COMISSOES ",74)
cDesc1 :=PADC("Este programa emite relatorio de Comissäes a pagar ",74)
cTitulo:= ' **** RELATORIO DE NOTAS FISCAIS CANCELADAS DE MESES ANTERIORES *** '

// Regua para impressao dos sub-titulos
//                 10        20        30        40        50        60        70         80        90        100      110       120     130         140      150       160
//        123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 12456789'
cCabec2 := ' '
nCaracter:=12

aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }

cPrograma := "RCANC"
cPerg     := "NCAN"
nLastKey  := 0
M_PAG     := 1
lContinua := .T.
MHORA := TIME()
WNREL     := "RCANC_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
L         := 0
CbTxt     := ""
CbCont    := ""
nOrdem    := 0
Alfa      := 0
Z         := 0
M         := 0
tamanho   := "M"
cDesc2    := ""
cDesc3    := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas.                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.T.)               // Pergunta no SX1

cCabec1 := 'PERIODO DE CANCELAMENTO:  '+ DTOC(MV_PAR01) + ' A ' + DTOC(MV_PAR02)
cString := "SZI"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel   := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)

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

RptStatus({|| R039Proc()})

Return

Static Function R039Proc()

dbSelectArea("SZI")
dbsetOrder(4)
DBSEEK(XFILIAL("SZI")+DTOS(MV_PAR01),.T.)   // Soft Seek on (.T.)

SETREGUA(RECCOUNT())
   xcont   := 0
   L       := 0
   _VALTOT := 0

While DTOS(SZI->ZI_DTCANC) >= DTOS(MV_PAR01) .AND. DTOS(SZI->ZI_DTCANC) <= DTOS(MV_PAR02)
   xcont:=xcont+1
   INCREGUA()
   IF SZI->ZI_SERIE#'UNI'.AND. SZI->ZI_SERIE#'SER'
      DBSKIP()
      LOOP
   ENDIF

   IF MONTH(SZI->ZI_EMISSAO) >= MONTH(MV_PAR01) .AND. YEAR(SZI->ZI_EMISSAO) >= YEAR(MV_PAR01)
      DBSKIP()
      LOOP
   ENDIF

   _nfiscal := SZI->ZI_NFISCAL
   _SERIE   := SZI->ZI_SERIE
   _cliente := SZI->ZI_CODCLI
   _pedido  := SZI->ZI_PEDIDO
   _emissao := SZI->ZI_EMISSAO
   _dtcanc  := SZI->ZI_DTCANC
   _valor   := SZI->ZI_VALORNF
   _MOTIVO  := SZI->ZI_MOTIVO
   _tes     := SZI->ZI_TES

   dbSelectArea("SA1")
   dbSetOrder(1)
   dbSeek(xFILIAL("SA1")+_cliente)
   If Found()
      _nomecli:=SA1->A1_NOME
   Endif

   DBSELECTAREA("SF4")
   DBSETORDER(1)
   DBSEEK(XFILIAL("SF4")+_TES)
   IF FOUND()
      IF SF4->F4_DUPLIC#'S'
         DBSELECTAREA("SZI")
         DBSKIP()
         LOOP
      ENDIF
   ENDIF

   _PRODUTO:=' '
   dbSelectarea("SE1")
   dbsetorder(1)
   dbseek(xfilial("SE1")+_SERIE+_NFISCAL)
   if found()
      _produto:=subs(SE1->E1_GRPROD,1,2)
   Endif
   Do Case
      Case _produto $ '11/12/13/14/15/16/17/18/19/20'
           _dproduto:='APLICATIVOS'
      Case _produto=='05'
           _dproduto:='CURSOS'
      Case _produto=='04'
           _dproduto:='SERV ESPECIAIS'
      Case _produto=='01'
           _dproduto:='ASSINATURAS'
      Case _produto=='02'
           _dproduto:='LIVROS'
      Case _produto=='07'
           _dproduto:='VIDEOS'
      Case _produto=='03' .OR. _PRODUTO=='08' .OR. _PRODUTO=='21' .OR. 'P' $(_PEDIDO)
           _dproduto:='PUBLICIDADE'
      Case _produto=='10'
           _dproduto:='REL CUSTOS'
      Endcase

   IF L == 0
      CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho,ncaracter)
      L:=8
      @ L,001   PSAY  'PARA:          '
      @ L+1,001 PSAY  'DE  : CONTABILIDADE'
//                            10       20         30       40        50         60        70        80        90       100        10       20        30        40        50       10
//                   123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
      @ L+4,001 PSAY '+-------------------------------------------------------------------------------------------------------------------------------------+'
      @ L+5,001 PSAY '| EMISSAO |N.FISCAL| VALOR/R$ |             CLIENTE                    |  PRODUTO  |               MOTIVO                             |'
      @ L+6,001 PSAY '+-------------------------------------------------------------------------------------------------------------------------------------|'
      L:=L+7
   ENDIF

   @ L,001 PSAY  '|'
   @ L,002 PSAY  _EMISSAO
   @ L,011 PSAY  '|'
   @ L,012 PSAY  _NFISCAL
   @ L,020 PSAY  '|'
   @ L,021 PSAY  STR(_VALOR,10,2)
   @ L,031 PSAY  '|'
   @ L,032 PSAY  _NOMECLI
   @ L,072 PSAY  '|'
   @ L,073 PSAY  _DPRODUTO
   @ L,084 PSAY  '|'
   @ L,085 PSAY  _MOTIVO
   @ L,135 PSAY  '|'

   _VALTOT  := _VALTOT+_VALOR
   IF L==60
      SETPRC(0,0)
      L:=0
   ELSE
      L:=L+1
   ENDIF
   DBSELECTAREA("SZI")
   DBSKIP()
ENDDO

@ L,001 PSAY   '+-------------------------------------------------------------------------------------------------------------------------------------+'
@ L+1,001 PSAY '|  VALOR TOTAL ...'
@ L+1,020 PSAY '|'
@ L+1,021 PSAY STR(_VALTOT,10,2)
@ L+1,31 PSAY '|'
@ L+2,01 PSAY  '+-----------------------------+'

dbselectarea("SE1")
Retindex("SE1")

dbselectarea("SZI")
Retindex("SZI")

SET DEVICE TO SCREEN
IF aRETURN[5] == 1
  Set Printer to
  dbcommitAll()
  ourspool(WNREL)
ENDIF

MS_FLUSH()

Return