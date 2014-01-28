#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT035   ³Autor: Solange Nalini         ³ Data:   18/05/98 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Libera‡ao de Pedidos - ESPECIAL                            ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat025()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,LIBERA")
SetPrvt("MPEDIDO,MITEM,MCODPROD,MEDINIC,MEDFIN,MDESCRI")
SetPrvt("MREGCOT,MCONFIRMA,")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG  := "FAT001"
LIBERA := .T.

WHILE LIBERA
   //DrawAdvWin("**  ALTERACAO DE PRODUTOS -ASS       **" , 8, 0, 16, 75 )
   MPEDIDO   := SPACE(6)
   MITEM     := SPACE(2)
   MCODPROD  := SPACE(15)
   MEDINIC   := 0
   MEDFIN    := 0
   MDESCRI   := ' '
   MREGCOT   := ' '
   MCONFIRMA := SPACE(1)

   @ 10, 5 Say " PEDIDO --> " GET MPEDIDO
   @ 11, 5 SAY " ITEM  ---> " GET MITEM
   @ 12, 5 SAY " PRODUTO -> " GET MCODPROD
   @ 13,05 SAY " ED.INIC -> " GET MEDINIC
   @ 14,05 SAY " ED.FINAL-> " GET MEDFIN
   READ

   IF MPEDIDO==SPACE(6)
      LIBERA:=.F.
      LOOP
   ENDIF
   @ 16,05 SAY 'CONFIRMA S/N ? ' GET MCONFIRMA PICT '@!'
   READ
   DO CASE
   CASE MCONFIRMA#'S'
      LOOP
   ENDCASE

   DBSELECTAREA('SB1')
   DBSETORDER(1)
   DBSEEK(XFILIAL("SB1")+MCODPROD)
   IF FOUND()
      MDESCRI:=SB1->B1_DESC
      MREGCOT:=SB1->B1_REGCOT
   ENDIF

   DBSELECTAREA('SC6')
   DBSETORDER(1)
   DbSeek(xFilial()+MPEDIDO+MITEM)

   IF .NOT. FOUND()
       ALERT("PEDIDO NAO ENCONTRADO")
       RETURN
   ENDIF

   RECLOCK("SC6",.F.)
     SC6->C6_PRODUTO := MCODPROD
     SC6->C6_DESCRI  := SB1->B1_DESC
     SC6->C6_REGCOT  := SB1->B1_REGCOT
     SC6->C6_EDINIC  := MEDINIC
     SC6->C6_EDFIN   := MEDFIN
     SC6->C6_EDVENC  := MEDFIN
   MSUNLOCK()
END

RETURN