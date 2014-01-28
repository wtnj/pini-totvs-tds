#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Rfat096()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CLIE_DEST,CDESC1,CDESC2,CDESC3,CDESC4,MDESCR")
SetPrvt("CPERG,ARQUIVO,_ACAMPOS,_CNOME,MDATA,MDC")
SetPrvt("MNUM,MLINHA,MDEBITO,MCREDITO,MVALOR,MHIST")
SetPrvt("MCCD,MCCC,MPROCESS,MCODINV,MPRODUTO,")
/*
*ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
*º Programa    : CUSTO1.PRX                                                  º
*º Descricao   : GERACAO ARQUIVO CONTABIL PARA CUSTOS                        º
*º Programador : Solange Nalini                                              º
*º Data        : 26/02/99                                                    º
*ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Periodo Inicial                      ³
//³ mv_par02             // Periodo Final                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

ScreenDraw("SMT050", 3, 0, 0, 0)
SetCursor(1)
SetColor("B/BG")

CLIE_DEST:=SPACE(40)
cDesc1 :=PADC("Este programa ira gerar o arquivo contabil para custos" ,74)
cDesc2 :=PADC("Se a opcao for (F)echamento serao selecionados todos",74)
cDesc3 :=PADC("os lancamentos do periodo,se (C)omplemento, somente os lancamentos",74)
cDesc4 :=PADC("apos o fechamento, controlados pelo campo CT2_CTRL",74)


mDESCR :="  "

cPerg:="CON001"


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If .Not. PERGUNTE(cPerg)
    Return
Endif


DrawAdvWin("**  GERACAO ARQUIVO CONTABIL PARA CUSTOS ***" , 8, 0, 18, 75 )
ARQUIVO:='CUSTOS'
_aCampos := {  {"CT2_DATA"    ,"D",8, 0} ,;
               {"CT2_DC"      ,"C",1, 0} ,;
               {"CT2_NUM"     ,"C",10, 0} ,;
               {"CT2_LINHA"   ,"C",2, 0} ,;
               {"CT2_DEBITO"  ,"C",15,0} ,;
               {"CT2_CREDITO" ,"C",15,0} ,;
               {"CT2_VALOR"   ,"N",17,2} ,;
               {"CT2_HIST"    ,"C",40,0} ,;
               {"CT2_CCD"     ,"C",9, 0} ,;
               {"CT2_CCC"     ,"C",9, 0} ,;
               {"CT2_PROCESS" ,"C",3, 0} ,;
               {"CT2_CODINV"  ,"C",6, 2} ,;
               {"CT2_PRODUTO" ,"C",7 ,0},;
               {"CT2_DTVENC" ,"D",8 ,0}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"CUSTOS",.F.,.F.)
DBSELECTAREA('CT2')
DBSETORDER(3)
SET SOFTSEEK ON
DbSeek(xFilial()+dtos(mv_par01))
DO WHILE CT2->CT2_DATA>=MV_PAR01 .AND. CT2->CT2_DATA<=MV_PAR02
   @ 10, 5 Say "   A G U A R D E  - LENDO REGISTRO SC6-> "+STR(RECNO())

   IF CT2_CTRL#' '
      DBSKIP()
      LOOP
   ENDIF

   //   IF CT2_CTRL=='C' .AND. MV_PAR03=='C'
   //     IF CT2_FECHCUS#DATE()
   //         DBSKIP()
   //         LOOP
   //      Endif
   //   ENDIF

   MDATA   :=CT2_DATA
   MDC     :=CT2_DC
   MNUM    :=CT2_NUM
   MLINHA  :=CT2_LINHA
   MDEBITO :=CT2_DEBITO
   MCREDITO:=CT2_CREDITO
   MVALOR  :=CT2_VALOR
   MHIST   :=CT2_HIST
   MCCD    :=CT2_CCD
   MCCC    :=CT2_CCC
   MPROCESS:=CT2_PROCESS
   MCODINV :=CT2_CODINV
   MPRODUTO:=CT2_PRODUTO

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³  GRAVA ARQUIVO TEMPORARIO                                    ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   GRAVA_CONT()

   DBSELECTAREA("CT2")

     Reclock("CT2",.F.)
        REPLACE CT2_CTRL WITH mv_par03
        REPLACE CT2_fechcus with date()
     CT2->(MSunlock())
     DBSKIP()

   ENDDO
   DBSELECTAREA("CUSTOS")
   COPY TO CUSTOS1.DBF VIA "DBFCDXADS" // 20121106 

DBCLOSEAREA()

DbSelectArea("CT2")
Retindex("CT2")

RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION GRAVA_CONT
Static FUNCTION GRAVA_CONT()
DBSELECTAREA("CUSTOS")
                Reclock("CUSTOS",.t.)
                REPLACE CT2_DATA     WITH  MDATA
                REPLACE CT2_DC       WITH  MDC
                REPLACE CT2_NUM      WITH  MNUM
                REPLACE CT2_LINHA    WITH  MLINHA
                REPLACE CT2_DEBITO   WITH  MDEBITO
                REPLACE CT2_CREDITO  WITH  MCREDITO
                REPLACE CT2_VALOR    WITH  MVALOR
                REPLACE CT2_HIST     WITH  MHIST
                REPLACE CT2_CCD      WITH  MCCD
                REPLACE CT2_CCC      WITH  MCCC
                REPLACE CT2_PROCESS  WITH  MPROCESS
                REPLACE CT2_CODINV   WITH  MCODINV
                REPLACE CT2_PRODUTO  WITH  MPRODUTO
                REPLACE CT2_DTVENC   WITH  DATE()
                CUSTOS->(msUnlock())
RETURN


