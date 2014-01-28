#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFDEF WINDOWS
        #DEFINE SAY PSAY
#ENDIF

User Function Rfat021()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CDESC1")
SetPrvt("CDESC2,CDESC3,CTITULO,CCABEC1,CCABEC2,CPROGRAMA")
SetPrvt("CTAMANHO,LIMITE,NCARACTER,ARETURN,WNREL,CSTRING")
SetPrvt("NLASTKEY,_ACAMPOS,_CNOME,CINDEX,CKEY,_CFILTRO")
SetPrvt("MCLI,MPED,MPRD,M_PAG,L,MSUBT")
SetPrvt("MPRODUTO,mhora")

#IFDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>         #DEFINE SAY PSAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: FATPROD   ³Autor: Rosane Lacava Rodrigues³ Data:   23/06/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de Faturamento por Produto                       ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//cSavTela   := SaveScreen( 0, 0,24,80)
//cSavCursor := SetCursor()
//cSavCor    := SetColor()
//cSavAlias  := Select()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_prod_de           //Do Produto:       ³
//³ mv_prod_ate          //Ate o Produto:    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:='FAT023'
IF .NOT. PERGUNTE(cPerg)
   RETURN
ENDIF

cDesc1   := PADC("Este programa emite a quantidade faturada por produto",70)
cDesc2   := PADC("no periodo solicitado",70)
cDesc3   := " "
cTitulo  := "* RELATORIO DE PRODUTOS FATURADOS * PERIODO: "+DTOC(MV_PAR03)+" A "+DTOC(MV_PAR04)+" *"
cCabec1  := "DUPLICATA  DT.EMISSAO  PEDIDO  QTDADE  CLIENTE"
cCabec2  := " "
cPrograma:= "FATPROD"
cTamanho := "M"
LIMITE   := 132 
nCaracter:= 12

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aReturn:={"Especial", 1,"Administracao", 1, 2, 1," ",1 }
MHORA := TIME()
wnrel    :="FATPROD_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString  :="SD2"
NLASTKEY := 0

wnrel:=SetPrint(cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,,,.F.)

IF NLASTKEY==27 .OR. NLASTKEY==65
   RETURN
ENDIF

SetDefault(aReturn,cString)

IF NLASTKEY==27 .OR. NLASTKEY==65
   RETURN
ENDIF

#IFDEF WINDOWS
       RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        RptStatus({|| Execute(RptDetail)})
       Return
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        Function RptDetail
Static Function RptDetail()
#ENDIF

_aCampos := {{"NUMPED"  ,"C",6, 0} ,;
             {"CODCLI"  ,"C",6, 0} ,;
             {"NOMECLI" ,"C",40,0} ,;
             {"QTDE"    ,"N",6, 0} ,;
             {"NUMNF"   ,"C",9, 0} ,;
             {"PRODUTO" ,"C",15,0} ,;
             {"DESCRIC" ,"C",40,0} ,;
             {"DTEMISS" ,"D",8, 0}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"FATPROD",.F.,.F.)
cIndex:=CRIATRAB(NIL,.F.)
cKey:="PRODUTO+NUMNF"
INDREGUA("FATPROD",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")

Set Index To
DbSetIndex(CINDEX)
DbSetOrder(01)

DBSELECTAREA("SD2")
_cFiltro := "D2_FILIAL == '"+xFilial("SD2")+"'"
_cFiltro := _cFiltro+".and.D2_COD>=MV_PAR01.and.D2_COD<=MV_PAR02"
_cFiltro := _cFiltro+".and.DTOS(D2_EMISSAO)>=DTOS(CTOD('"+DTOC(MV_PAR03)+"'))"
_cFiltro := _cFiltro+".and.DTOS(D2_EMISSAO)<=DTOS(CTOD('"+DTOC(MV_PAR04)+"'))"

CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="D2_FILIAL+D2_COD+DTOS(D2_EMISSAO)"
INDREGUA("SD2",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")

DBSEEK(XFILIAL()+MV_PAR01,.T.)   // Soft Seek on (.T.)

SETREGUA(RECCOUNT())
DO WHILE .NOT. EOF() 
   INCREGUA()
   MCLI:=SD2->D2_CLIENTE
   MPED:=SD2->D2_PEDIDO
   MPRD:=SD2->D2_COD

   IF AllTrim(SD2->D2_CF) == '552' .OR. AllTrim(SD2->D2_CF) == '652' .OR.;
    AllTrim(SD2->D2_CF) == '752'
      DBSKIP()
      LOOP
   ENDIF

   IF SD2->D2_SERIE == 'LIV' .OR. SD2->D2_SERIE == 'CP0'
      DBSKIP()
      LOOP
   ENDIF
      
   IF AllTrim(SD2->D2_CF) <> '599' .AND. AllTrim(SD2->D2_CF) <> '699' .AND.;
      AllTrim(SD2->D2_CF) <> '799'
      DBSELECTAREA("SE1")
      /*dbSetOrder(22)  ///dbSetOrder(15) AP5 //20090114 era(21) //20090723 mp10 alterado indice
      DBSEEK(XFILIAL()+MPED)*/
      dbSetOrder(1)//20090723 mp10 
      DBSEEK(XFILIAL("SE1")+SD2->D2_SERIE+SD2->D2_DOC)//20090723 mp10 
      IF .NOT. FOUND()
         DBSELECTAREA("SD2")
         DBSKIP()
         LOOP
      ENDIF
      IF FOUND()
         IF SE1->E1_MOTIVO == 'DEV                 '
            DBSKIP()
            LOOP
         ENDIF
      ENDIF

      DBSELECTAREA("SA1")
      DBSEEK(XFILIAL()+MCLI)
      IF .NOT. FOUND()
          DBSELECTAREA("SD2")
          DBSKIP()
          LOOP
      ENDIF

      DBSELECTAREA("SB1")
      DBSEEK(XFILIAL()+MPRD)
      IF .NOT. FOUND()
          DBSELECTAREA("SD2")
          DBSKIP()
          LOOP
      ENDIF

      DBSELECTAREA("FATPROD")
      RECLOCK("FATPROD",.T.)
      FATPROD->PRODUTO  := SD2->D2_COD
      FATPROD->CODCLI   := SD2->D2_CLIENTE
      FATPROD->NUMPED   := SD2->D2_PEDIDO
      FATPROD->NUMNF    := SD2->D2_DOC   
      FATPROD->NOMECLI  := SA1->A1_NOME
      FATPROD->QTDE     := SD2->D2_QUANT
      FATPROD->DTEMISS  := SD2->D2_EMISSAO
      FATPROD->DESCRIC  := SB1->B1_DESC
      FATPROD->(MsUnlock())
   ENDIF

   DBSELECTAREA("SD2")
   DBSKIP()
   INCREGUA()
ENDDO

DBSELECTAREA("FATPROD")
M_PAG   :=1
L       :=0
MSUBT   :=0
MPRODUTO:=' '

DBGOTOP()
SETREGUA(RECCOUNT())
DO WHILE .NOT. EOF()
   INCREGUA()
   IF MPRODUTO <> ' '
      IF MPRODUTO <> PRODUTO
         @ L,31   PSAY '------'
         @ L+1,15 PSAY 'TOTAL .......'
         @ L+1,31 PSAY MSUBT PICTURE "@E 999999" 
         MSUBT:=0
         L:=60
      ENDIF
   ENDIF

   IF L==0 .OR. L>59
      Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
      @ 8,00 PSAY "** PRODUTO: "
      @ 8,12 PSAY PRODUTO
      @ 8,27 PSAY DESCRIC
      L:=10
   ENDIF

   @ L,00 PSAY NUMNF  
   @ L,12 PSAY DTEMISS 
   @ L,23 PSAY NUMPED  
   @ L,31 PSAY QTDE
   @ L,39 PSAY NOMECLI                      

   MSUBT:=MSUBT+QTDE 
   MPRODUTO:=PRODUTO
   IF L>59
      L:=0
      M_PAG:=M_PAG+1
   ELSE
      L:=L+1
   ENDIF
   DBSKIP()
   INCREGUA()
ENDDO

@ L,31 PSAY '------'
L:=L+1
@ L,15 PSAY 'TOTAL .......'
@ L,31 PSAY MSUBT PICTURE "@E 999999"

SET DEVI TO SCREEN
DBCLOSEAREA()

IF aRETURN[5] ==1
   SET PRINTER TO
   DBCOMMITALL()
   OURSPOOL(WNREL)
ENDIF
MS_FLUSH()

DBSELECTAREA("SD2")
RETINDEX("SD2")
DBSELECTAREA("SE1")
RETINDEX("SE1")
DBSELECTAREA("SA1")
RETINDEX("SA1")
DBSELECTAREA("SB1")
RETINDEX("SB1")
RETURN
