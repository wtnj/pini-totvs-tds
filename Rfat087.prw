#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
#IFDEF WINDOWS
        #DEFINE SAY PSAY
#ENDIF

User Function Rfat087()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CDESC1")
SetPrvt("CDESC2,CDESC3,CTITULO,CCABEC1,CCABEC2,CPROGRAMA")
SetPrvt("CTAMANHO,LIMITE,NCARACTER,NLASTKEY,ARETURN,_ACAMPOS")
SetPrvt("_CNOME,CINDEX1,CKEY,CINDEX2,WNREL,CSTRING")
SetPrvt("_CFILTRO,CINDEX,MPEDIDO,MVEND,MNOTA,MVALOR")
SetPrvt("MVENCTO,MCLI,MPARCELA,MREG,MNOME,M_PAG")
SetPrvt("L,MSUBT,mhora")

#IFDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 26/02/02 ==>         #DEFINE SAY PSAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: VDPEND    ³Autor: Rosane Lacava Rodrigues³ Data:   28/05/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de Pendencias por Pedido / Vendedor              ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Financeiro                                       ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
cSavTela   := SaveScreen( 0, 0,24,80)
cSavCursor := SetCursor()
cSavCor    := SetColor()
cSavAlias  := Select()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //Da data:          ³
//³ mv_par02             //Ate a data:       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG:='PFIN01'
IF .NOT. PERGUNTE(CPERG)
   RETURN
ENDIF

CDESC1   :=PADC("Este programa emite relatorio por vendedor ou por regiao",70)
CDESC2   :=PADC("dos pedidos em aberto na cobranca",70)
CDESC3   :=" "
cTitulo :="       *****  RELATORIO DOS PEDIDOS EM ABERTO NA COBRANCA  *****  "
cCabec1  :="NOME DO CLIENTE                          PEDIDO   NOTA FISCAL  PARCELA VALOR     DATA DE VENCTO"
cCabec2  :=" "
cPrograma:="VDPEND"
cTamanho  :="M"
LIMITE   :=132
nCaracter:=12
NLASTKEY :=0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ScreenDraw("SMT050", 3, 0, 0, 0)
SetCursor(1)
SetColor("B/BG")

aRETURN:={"Especial", 1,"Administracao", 1, 2, 1," ",1 }

_aCampos := {{"NUMPED"  ,"C",6, 0} ,;
             {"NOMECLI" ,"C",40,0} ,;
             {"NUMNF"   ,"C",6, 0} ,;
             {"VENCTO"  ,"D",8, 0} ,;
             {"VALOR"   ,"N",10,2} ,;
             {"CODVEND" ,"C",6 ,0} ,;
             {"CODREG"  ,"C",3 ,0} ,;
             {"NOME"    ,"C",40,0} ,;
             {"PARCELA" ,"C",1 ,0}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"VDPEND",.F.,.F.)
CINDEX1:=CRIATRAB(NIL,.F.)
CKEY:="CODVEND+NUMNF+PARCELA"
INDREGUA("VDPEND",CINDEX1,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")
CINDEX2:=CRIATRAB(NIL,.F.)
CKEY:="CODREG+CODVEND+NUMNF+PARCELA"
INDREGUA("VDPEND",CINDEX2,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")

Set Index To
DbSetIndex(CINDEX1)
DbSetIndex(CINDEX2)
DbSetOrder(01)
MHORA := TIME()
WNREL    :="VDPEND_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING  :="VDPEND"
WNREL:=SETPRINT(CSTRING,WNREL,CPERG,cTitulo,CDESC1,CDESC2,CDESC3,.T.)
SETDEFAULT(aRETURN,CSTRING)

IF NLASTKEY==27 .OR. NLASTKEY==65
   DBCLOSEAREA()
   RETURN
ENDIF

#IFDEF WINDOWS
       RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        RptStatus({|| Execute(RptDetail)})
       Return
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        Function RptDetail
Static Function RptDetail()
#ENDIF

DBSELECTAREA("SE1")
_cFiltro := "E1_FILIAL == '"+xFilial("SE1")+"'"
_cFiltro := _cFiltro+".and.DTOS(E1_BAIXA)==DTOS(CTOD(' '))"
_cFiltro := _cFiltro+".and.DTOS(E1_PGPROG)==DTOS(CTOD(' '))"

CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="E1_FILIAL+DTOS(E1_BAIXA)+E1_VEND1"
INDREGUA("SE1",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")

DBSEEK(XFILIAL()+DTOS(E1_BAIXA)+E1_VEND1,.T.)   // Soft Seek on (.T.)

SETREGUA(RECCOUNT())
DO WHILE .NOT. EOF()
   INCREGUA()
   IF SE1->E1_EMISSAO<CTOD('01/11/2000').OR.(SE1->E1_EMISSAO>CTOD('31/10/2000').AND. SE1->E1_GRPROD#'SOFT')
      DBSKIP()
      LOOP
   ENDIF
   MPEDIDO := SE1->E1_PEDIDO
   MVEND   := SE1->E1_VEND1
   MNOTA   := SE1->E1_NUM
   MVALOR  := SE1->E1_VALOR
   MVENCTO := SE1->E1_VENCREA
   MCLI    := SE1->E1_CLIENTE
   MPARCELA:= SE1->E1_PARCELA

   IF VAL(MV_PAR03) == 0 .AND. VAL(MV_PAR04) == 0
      IF VAL(MVEND) < VAL(MV_PAR01) .OR. VAL(MVEND) > VAL(MV_PAR02)
         DBSKIP()
         LOOP
      ENDIF
   ENDIF

   DBSELECTAREA("SA3")
   DBSEEK(XFILIAL()+MVEND)
   IF .NOT. FOUND()
       DBSELECTAREA('SE1')
       DBSKIP()
       LOOP
   ENDIF
   MREG := SA3->A3_REGIAO
   MNOME:= SA3->A3_NOME

   IF VAL(MV_PAR04) > 0
      IF VAL(MREG) < VAL(MV_PAR03) .OR. VAL(MREG) > VAL(MV_PAR04)
         DBSELECTAREA('SE1')
         DBSKIP()
         LOOP
      ENDIF
   ENDIF

   DBSELECTAREA("SA1")
   DBSEEK(XFILIAL()+MCLI)
   IF .NOT. FOUND()
       DBSELECTAREA('SE1')
       DBSKIP()
       LOOP
   ENDIF

   DBSELECTAREA("VDPEND")
   DBSEEK(MVEND+MNOTA+MPARCELA)
   IF .NOT. FOUND()
       RECLOCK("VDPEND",.T.)
       VDPEND->NUMPED  := MPEDIDO
       VDPEND->NOMECLI := SA1->A1_NOME
       VDPEND->NUMNF   := MNOTA
       VDPEND->VALOR   := MVALOR
       VDPEND->CODVEND := MVEND
       VDPEND->VENCTO  := MVENCTO
       VDPEND->PARCELA := MPARCELA
       VDPEND->CODREG  := MREG
       VDPEND->NOME    := MNOME
       VDPEND->(MsUnlock())
   ENDIF
   DBSELECTAREA("SE1")
   DBSKIP()
   INCREGUA()
ENDDO

M_PAG :=1
L     :=0
MSUBT :=0
MVEND := ' '
MREG  := ' '

DBSELECTAREA("VDPEND")
IF VAL(MV_PAR03) == 0 .AND. VAL(MV_PAR04) == 0
   DBSETORDER(01)
ELSE
   DBSETORDER(02)
ENDIF

GO TOP
SETREGUA(RECCOUNT())
DO WHILE .NOT. EOF()
   INCREGUA()
   IF MVEND <> ' '
      IF MVEND <> CODVEND
         @ L,69   PSAY '----------'
         @ L+1,50 PSAY 'TOTAL .......'
         @ L+1,67 PSAY MSUBT PICTURE "@E 9,999,999.99"
         MSUBT:=0
         L:=60
      ENDIF
   ENDIF

   IF L==0 .OR. L>59
      Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
      @ 8,00 PSAY "** VENDEDOR: "
      @ 8,13 PSAY CODVEND
      @ 8,20 PSAY NOME
      @ 9,00 PSAY "** REGIAO  : "
      @ 9,13 PSAY CODREG
      L:=11
   ENDIF

   @ L,00 PSAY NOMECLI
   @ L,41 PSAY NUMPED
   @ L,53 PSAY NUMNF
   @ L,66 PSAY PARCELA
   @ L,69 PSAY VALOR PICTURE "@E 999,999.99"
   @ L,84 PSAY VENCTO

   MSUBT:=MSUBT+VALOR
   MVEND:=CODVEND

   IF L>59
      L:=0
      M_PAG:=M_PAG+1
   ELSE
      L:=L+1
   ENDIF
   DBSKIP()
ENDDO

@ L,69 PSAY '----------'
L:=L+1
@ L,50 PSAY 'TOTAL .......'
@ L,67 PSAY MSUBT PICTURE "@E 9,999,999.99"

SET DEVI TO SCREEN
DBCLOSEAREA()

IF aRETURN[5] ==1
   SET PRINTER TO
   DBCOMMITALL()
   OURSPOOL(WNREL)
ENDIF
MS_FLUSH()

DBSELECTAREA("SE1")
RETINDEX("SE1")
DBSELECTAREA("SA1")
RETINDEX("SA1")
DBSELECTAREA("SA3")
RETINDEX("SA3")
RETURN

