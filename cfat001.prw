#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02
// Danilo C S Pala: alterado a pedido do cicero, completar pesquisa por indice
User Function cfat001()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,MVPAR")
SetPrvt("MNOTA,MDATA, MSERIE, MCLIENTE")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: CFAT001   ³Autor: Solange Nalini         ³ Data:   20/01/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: CONSULTA DE NF PELO PEDIDO                                 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento/                                     ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//cSavTela   := SaveScreen( 0, 0,23,80)
//cSavCursor := SetCursor()
//cSavCor    := SetColor()
//cSavAlias  := Select()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ScreenDraw("SMT050", 3, 0, 0, 0)
//SetCursor(1)
//SetColor("B/BG")
//
//DO WHILE .T.

   CPERG:="PFAT50"

   If .Not. PERGUNTE(cPerg)
       Return
   Endif

   MVPAR:=MV_PAR01
   DBSELECTAREA("SC5")
   DBSETORDER(1)
   IF DBSEEK(XFILIAL()+MVPAR)
      MNOTA   := SC5->C5_NOTA        
      MSERIE  := SC5->C5_SERIE
      MCLIENTE:= SC5->C5_CLIENTE
      DBSELECTAREA("SF2")
      DBSETORDER(1)

      IF DBSEEK(XFILIAL()+MNOTA+MSERIE+MCLIENTE)
         MDATA := SF2->F2_EMISSAO
      ENDIF
      notali := sc5->c5_nota
      datli  := DTOC(SF2->F2_EMISSAO)
  
      ALERT("Nº da Nota Fiscal -->  " + sc5->c5_nota +' '+ SC5->C5_SERIE +'  de   '+ datli)
   Else
     ALERT("O pedido não se encontra faturado, Verifique !!")
   endif

RETURN