#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02
/*/ //20041124 Danilo C S Pala, nao alterar para baixas cientes: Andre e Andrea
// erro na migracao do 7.10: substr do produto
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ A050GRV  ³ Autor ³ Desconhecido          ³ Data ³ ??/??/??    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ponto de Entrada na gravacao do lancamento contabil utilizado ³±±
±±³          ³ em todos os modulos que utilizam contabilizacao               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ 29/08/01 - Inclusao de Tratamento para o Programa MATA330 ( Recalculo    ³±±
±±³            Custo Medio ). Mauricio Mendes                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Ca050grv()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02
Local aArea := GetArea()
SetPrvt("_CPAR,MORIGEM,MCCUSTO,MPROCESS,MPRODUTO,MSEQ")



_cpar:=Str(PARAMIXB[1])

IF EMPTY(CT2->CT2_ORIGEM)
   MORIGEM:=SUBS(CUSUARIO,7,15)
ELSE
   MORIGEM:=CT2_ORIGEM
ENDIF

/*If AllTrim(FUNNAME())=="FINA040" .OR. AllTrim(FUNNAME())=="FINA070"
   MCCUSTO:='001' //20041124
   MPROCESS:=CT2->CT2_PROCESS
   MPRODUTO:=SUBS(SE1->E1_GRPROD,1,2)+'00000'
   DO CASE
      CASE SE1->E1_GRPROD=='01' .OR. SE1->E1_GRPROD=='02' .OR. SE1->E1_GRPROD='0700'
           MPROCESS:='060'
      CASE SE1->E1_GRPROD=='03' .OR. SE1->E1_GRPROD=='08'
           MPROCESS:='040'
      CASE SUBS(SE1->E1_GRPROD,1,2)=='04'
           MPROCESS:='070'
      CASE SUBS(SE1->E1_GRPROD,1,2)=='05'
           MPROCESS:='080'
      CASE SUBS(SE1->E1_GRPROD,1,2)=='10'
           MPROCESS:='060'
      CASE SUBS(SE1->E1_GRPROD,1,2) $'11/12/13/14/15/16/17/18/19/20'
           MPRODUTO:='1100000'
           MPROCESS:='090'
      CASE SUBS(SE1->E1_GRPROD,1,2)=='03' .OR. 'P' $(SE1->E1_PEDIDO)
           MPROCESS:='040'
      CASE SUBS(SE1->E1_GRPROD,1,2) $'01/02/07'
           MPROCESS:='060'
   ENDCASE
   RECLOCK("CT2",.F.)
     IF SE1->E1_REAB=='S'
        CT2->CT2_CCC:=MCCUSTO
     ELSE
        CT2->CT2_CCD:=MCCUSTO
     ENDIF
     CT2->CT2_PROCESS:=MPROCESS
     CT2->CT2_PRODUTO:=MPRODUTO
   MSUNLOCK()
ENDIF  20041124*/

If AllTrim(FUNNAME())=="MATA460" .OR. AllTrim(FUNNAME())=="MATA520"
  // MPRODUTO:=RIGHT(CT2->CT2_HIST,7)

   DBSELECTAREA("SB1")
   DBSETORDER(1)
   DBSEEK(XFILIAL()+SD2->D2_COD)
   IF FOUND()
      DBSELECTAREA("CT2")
      RECLOCK("CT2",.F.)
         CT2->CT2_PROCESS := SB1->B1_PROCESSO
         CT2->CT2_CCC     := SB1->B1_CCUSTO
         CT2->CT2_PRODUTO := substr(SB1->B1_COD,1,7)
//       CT2->CT2_HIST    :=LEFT(CT2->CT2_HIST)
      MSUNLOCK()
   ENDIF
ENDIF

// Rotina abaixo Incluida por Mauricio em 29/08/01
If AllTrim(FUNNAME())=="MATA330"
   MSEQ     :=SUBSTR(CT2->CT2_ORIGEM,21,6)
   // Indice 4 do SD3 Filial + Numseq
   DBSELECTAREA("SD3")
   DBSETORDER(4)
   DBSEEK(XFILIAL("SD3")+MSEQ)
   IF FOUND()
      DBSELECTAREA("CT2")
      RECLOCK("CT2",.F.)
         CT2->CT2_PROCESS := SD3->D3_PROCESS
         CT2->CT2_CCC     := SD3->D3_CC
         CT2->CT2_PRODUTO := substr(SD3->D3_PRODUTO,1,7)
      MSUNLOCK()
   ENDIF
ENDIF

// FOR€AR A GRAVACAO DA ORIGEM NO I2 - PARA QUALQUER LANCAMENTO
//RECLOCK("CT2",.F.)
//CT2->CT2_ORIGEM  := MORIGEM
//MSUNLOCK()

// GILBERTO - 19/12/2000 PARA FORCAR GRAVACAO DO CT2_FECHCUS COM BRANCOS.
IF AllTrim(FUNNAME())=="CONA050"
   IF INCLUI
      DBSELECTAREA("CT2")
      RECLOCK("CT2",.F.)
      CT2->CT2_FECHCUS := stod("")
      MSUNLOCK()
   ENDIF
ENDIF

RestArea(aArea)

Return(.t.)