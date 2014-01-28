#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: CONSTN    ³Autor: Rosane Lacava          ³ Data:   28/05/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de Clientes - Construcoes Novas Comissionadas    ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat014()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CDESC1")
SetPrvt("CDESC2,CDESC3,CTITULO,CCABEC1,CCABEC2,CPROGRAMA")
SetPrvt("CTAMANHO,LIMITE,NCARACTER,NLASTKEY,ARETURN,_ACAMPOS")
SetPrvt("_CNOME,CINDEX1,CKEY,CINDEX2,WNREL,CSTRING")
SetPrvt("MD,XD,_CFILTRO,CINDEX,CONT,MPEDIDO")
SetPrvt("MVEND,CONTINUA,MCLI,MPROD,MITEM,M_PAG")
SetPrvt("L,MSUBT,MTOTAL,MEQUIPE,mhora")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //Da data:          ³
//³ mv_par02             //Ate a data:       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG := 'FAT022'

IF !PERGUNTE(CPERG)
   RETURN
ENDIF

CDESC1   := PADC("Este programa emite relatorio de clientes de construcoes novas, cuja",70)
CDESC2   := PADC("parcela 'A' foi comissionada para o vendedor no periodo solicitado",70)
CDESC3   := " "
cTitulo  := "* CLIENTES CONSTRUCOES NOVAS * PERIODO COMISSAO: "+DTOC(MV_PAR01)+" A "+DTOC(MV_PAR02)+" *"
cCabec1  := "NOME DO CLIENTE                          ENDERECO                                 TELEFONE        CEP        VALOR     TITULO"
cCabec2  := " "
cPrograma:= "CONSTN"
cTamanho := "M"
LIMITE   := 132
nCaracter:= 12
NLASTKEY := 0

aRETURN:={"Especial", 1,"Administracao", 1, 2, 1," ",1 }

_aCampos := {{"NUMPED"  ,"C",6, 0} ,;
             {"ITEM"    ,"C",2, 0} ,;
             {"CODCLI"  ,"C",6, 0} ,;
             {"NOMECLI" ,"C",40,0} ,;
             {"ENDERECO","C",40,0} ,;
             {"CEP"     ,"C",8, 0} ,;
             {"TELEFONE","C",15,0} ,;
             {"TITULO"  ,"C",10,0} ,;
             {"CODREG"  ,"C",3, 0} ,;
             {"CODVEND" ,"C",6, 0} ,;
             {"VALOR"   ,"N",10,2} ,;
             {"PRODUTO" ,"C",15,0} ,;
             {"EQUIPE"  ,"C",30,0}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"CONSTN",.F.,.F.)
CINDEX1:= CRIATRAB(NIL,.F.)
CKEY   := "CODCLI+PRODUTO+CODVEND+NUMPED+ITEM"
INDREGUA("CONSTN",CINDEX1,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")

//CINDEX2:= CRIATRAB(NIL,.F.)
//CKEY   := "EQUIPE+CEP"
//INDREGUA("CONSTN",CINDEX2,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")

//Set Index To
//DbSetIndex(CINDEX1)
//DbSetIndex(CINDEX2)
//DbSetOrder(1)
MHORA := TIME()
WNREL   := "CONSTN_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING := "CONSTN"
WNREL   := SETPRINT(CSTRING,WNREL,CPERG,cTitulo,CDESC1,CDESC2,CDESC3,.F.)
SETDEFAULT(aRETURN,CSTRING)

IF NLASTKEY == 27 .OR. NLASTKEY == 65
   DBCLOSEAREA()
   RETURN
ENDIF

RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        RptStatus({|| Execute(RptDetail)})

Return

Static Function RptDetail()

MD := MV_PAR01
XD := DTOS(MD)

DBSELECTAREA("SE3")
_cFiltro := "E3_FILIAL == '"+xFilial("SE3")+"'"
_cFiltro := _cFiltro+".and.(E3_PARCELA =='A'.OR.E3_PARCELA==' ')"
_cFiltro := _cFiltro+".and.E3_CODCLI <>'040000'.AND.DTOS(E3_DATA)>=DTOS(CTOD('"+DTOC(MV_PAR01)+"'))"
_cFiltro := _cFiltro+".and.E3_REGIAO <>'12 '.AND.E3_VEND<>'000199'.and.E3_VEND<>'000109'"

CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="E3_FILIAL+DTOS(E3_DATA)"
INDREGUA("SE3",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")

DBSEEK(XFILIAL("SE3")+XD,.T.)   // Soft Seek on (.T.)

SETREGUA(RECCOUNT())

WHILE !EOF() .AND. DTOS(SE3->E3_DATA) <= DTOS(MV_PAR02)
   INCREGUA()

   IF VAL(SE3->E3_VEND)==23 .OR. VAL(SE3->E3_VEND)==116 .OR. VAL(SE3->E3_VEND)==13;
      .OR. VAL(SE3->E3_VEND)==1047 .OR. VAL(SE3->E3_VEND)==10 .OR. VAL(SE3->E3_VEND)==124
      DBSKIP()
      LOOP
   ENDIF

   IF VAL(SE3->E3_VEND)==145 .OR. VAL(SE3->E3_VEND)==184 .OR. VAL(SE3->E3_VEND)==205 .OR. VAL(SE3->E3_VEND)==448
      DBSKIP()
      LOOP
   ENDIF

   IF SE3->E3_SITUAC <> ' ' .OR. SE3->E3_COMIS < 0
      CONT := -1
   ELSE
      CONT := 1
   ENDIF

   MPEDIDO := SE3->E3_PEDIDO
   MVEND   := SE3->E3_VEND

   DBSELECTAREA("SC6")
   DBSEEK(XFILIAL("SC6")+MPEDIDO)
   IF !FOUND()
       DBSELECTAREA("SE3")
       DBSKIP()
       LOOP
   ENDIF
   IF FOUND()
      CONTINUA:=.T.
      WHILE MPEDIDO == SC6->C6_NUM .AND. CONTINUA
         INCREGUA()

         IF SC6->C6_TES=='650' .OR. SC6->C6_TES=='651' .OR. SC6->C6_PRODUTO<>'01'.or. SC6->C6_TES=='700'
            DBSKIP()
            LOOP
         ENDIF

         IF SUBSTR(SC6->C6_PRODUTO,5,3)<>'002' .AND. SUBSTR(C6_PRODUTO,5,3)<>'003';
            .AND. SUBSTR(SC6->C6_PRODUTO,5,3)<>'008' .AND. SUBSTR(C6_PRODUTO,5,3)<>'010'
            DBSKIP()
            LOOP
         ENDIF

         IF VAL(SUBSTR(SC6->C6_PRODUTO,3,2)) > 5 .AND. SUBS(C6_PRODUTO,1,4)<>'0115'
            DBSKIP()
            LOOP
         ENDIF

         MCLI  := SC6->C6_CLI
         MPROD := SC6->C6_PRODUTO
         MITEM := SC6->C6_ITEM

         DBSELECTAREA("SA1")
         DBSEEK(XFILIAL()+MCLI)
         IF .NOT. FOUND()
            CONTINUA := .F.
            LOOP
         ENDIF

         DBSELECTAREA("SB1")
         DBSEEK(XFILIAL()+MPROD)
         IF !FOUND()
            CONTINUA := .F.
            LOOP
         ENDIF

         DBSELECTAREA("SA3")
         DBSEEK(XFILIAL()+MVEND)
         IF !FOUND()
            CONTINUA := .F.
            LOOP
         ENDIF

         DBSELECTAREA("CONSTN")
         DBSEEK(MCLI+MPROD+MVEND+MPEDIDO+MITEM)
         IF !FOUND()
             RECLOCK("CONSTN",.T.)
             CONSTN->PRODUTO  := MPROD
             CONSTN->CODCLI   := MCLI
             CONSTN->NUMPED   := MPEDIDO
             CONSTN->ITEM     := MITEM
             CONSTN->CODVEND  := MVEND
             CONSTN->CODREG   := SE3->E3_REGIAO
             CONSTN->NOMECLI  := SA1->A1_NOME
             CONSTN->ENDERECO := SA1->A1_END
             CONSTN->TELEFONE := SA1->A1_TEL
             CONSTN->CEP      := SA1->A1_CEP
             CONSTN->VALOR    := (SC6->C6_VALOR * CONT)
             CONSTN->TITULO   := SB1->B1_TITULO
             CONSTN->EQUIPE   := SA3->A3_EQUIPE
             CONSTN->(MsUnlock())
         ELSE
            RECLOCK("CONSTN",.F.)
            REPLA VALOR WITH (VALOR + (SC6->C6_VALOR * CONT))
            MsUnlock()
         ENDIF
         DBSELECTAREA("SC6")
         DBSKIP()
      END
      DBSELECTAREA("SE3")
      DBSKIP()
      INCREGUA()
   ENDIF
END

DBSELECTAREA("CONSTN")
RetIndex()
CINDEX2:= CRIATRAB(NIL,.F.)
CKEY   := "EQUIPE+CEP"
INDREGUA("CONSTN",CINDEX2,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")

DbGOTOP()
SETREGUA(RECCOUNT())
WHILE !EOF()
   INCREGUA()
   IF VALOR == 0
      RECLOCK("CONSTN",.F.)
      DELETE
      CONSTN->(MsUnlock())
   ENDIF
   DBSKIP()
ENDDO

M_PAG   :=1
L       :=0
MSUBT   :=0
MTOTAL  :=0
MEQUIPE :=' '

DbGOTOP()

SETREGUA(RECCOUNT())

WHILE !EOF()
   INCREGUA()
   IF MEQUIPE <> ' '
      IF MEQUIPE <> EQUIPE
         @ L,108   PSAY '---------'
         @ L+1,90  PSAY 'SUBTOTAL ....'
         @ L+1,105 PSAY MSUBT PICTURE "@E 9,999,999.99"
         MSUBT:=0
         L:=L+4
         @ L,00 PSAY "** EQUIPE: "
         @ L,11 PSAY EQUIPE
         L:=L+2
      ENDIF
   ENDIF

   IF L == 0 .OR. L > 59
      Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
      @ 8,00 PSAY "** EQUIPE: "
      @ 8,11 PSAY EQUIPE
      L:=10
   ENDIF

   @ L,00  PSAY NOMECLI
   @ L,41  PSAY ENDERECO
   @ L,82  PSAY TELEFONE
   @ L,98  PSAY CEP
   @ L,107 PSAY VALOR PICTURE "@E 999,999.99"
   @ L,119 PSAY TITULO

   MTOTAL  := MTOTAL+VALOR
   MSUBT   := MSUBT+VALOR
   MEQUIPE := EQUIPE
   IF L > 59
      L := 0
      M_PAG++
   ELSE
      L++
   ENDIF
   DBSKIP()
END

@ L,108 PSAY '---------'
L:=L+1
@ L,90  PSAY 'SUBTOTAL ....'
@ L,105 PSAY MSUBT PICTURE "@E 9,999,999.99"
L:=L+2
@ L,107 PSAY '----------'
L:=L+1
@ L ,93 PSAY 'TOTAL ....'
@ L,105 PSAY MTOTAL PICTURE "@E 9,999,999.99"

SET DEVICE TO SCREEN
DBCLOSEAREA()

IF aRETURN[5] ==1
   SET PRINTER TO
   DBCOMMITALL()
   OURSPOOL(WNREL)
ENDIF

MS_FLUSH()

DBSELECTAREA("SE3")
RETINDEX("SE3")
DBSELECTAREA("SA1")
RETINDEX("SA1")
DBSELECTAREA("SC6")
RETINDEX("SC6")
DBSELECTAREA("SB1")
RETINDEX("SB1")
DBSELECTAREA("SA3")
RETINDEX("SA3")

RETURN