#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFDEF WINDOWS
        #DEFINE SAY PSAY
#ENDIF

User Function Rfat044()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CTITULO")
SetPrvt("CCABEC1,CCABEC2,CPROGRAMA,CTAMANHO,LIMITE,NCARACTER")
SetPrvt("NLASTKEY,CDESC1,CDESC2,CDESC3,M_PAG,ARETURN")
SetPrvt("_ACAMPOS,_CNOME,CINDEX,CKEY,WNREL,CSTRING")
SetPrvt("_CFILTRO,MIND,MAV,MVEND,MCLI,MQTDE")
SetPrvt("MITEM,MPROD,MDESC,L,MFINAL,MNOME")
SetPrvt("MNOMC,mhora")

#IFDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>         #DEFINE SAY PSAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RENPUBE   ³Autor: Rosane Lacava Rodrigues³ Data:   27/12/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de Renovacoes de Publicidade por Edicao          ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
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
//³ mv_par01             //Codigo Revista    ³
//³ mv_par02             //Edicao Inicial    ³
//³ mv_par03             //Edicao Final      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG:='PFAT52'
IF .NOT. PERGUNTE(CPERG)
   RETURN
ENDIF

cTitulo  := SPACE(12)+"***** RELATORIO DE RENOVACOES - POR EDICAO *****"
cCabec1  := " "
cCabec2  := " "
cPrograma:= "RENPUBE"
cTamanho := "M"
LIMITE   := 132
nCaracter:= 22
NLASTKEY := 0
cDesc1   := PADC("Este programa gera o relatorio de renovacoes por edicao",70)
cDesc2   := " "
cDesc3   := " "
M_PAG    := 1
aRETURN:={"Especial", 1,"Administracao", 2, 2, 1," ",1 }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ScreenDraw("SMT050", 3, 0, 0, 0)
SetCursor(1)
SetColor("B/BG")

_aCampos := {{"CODVEND"  ,"C",6 ,0} ,;
             {"CODCLI"   ,"C",6, 0} ,;
             {"NUMAV"    ,"C",6, 0} ,;
             {"ITEM"     ,"C",2, 0} ,;
             {"FINAL"    ,"N",4 ,0} ,;
             {"PRODUTO"  ,"C",7 ,0} ,;
             {"DESCR"    ,"C",30,0} ,;
             {"DTCIRC"   ,"D",8, 0}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"RENOV",.F.,.F.)
CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="STR(FINAL,4)+CODVEND+CODCLI+NUMAV+ITEM"
INDREGUA("RENOV",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")
MHORA := TIME()
WNREL    :="RENPUBE_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING  :="RENOV"
WNREL:=SETPRINT(CSTRING,WNREL,CPERG,cTitulo,cDesc1,cDesc2,cDesc3,.T.)
SETDEFAULT(aRETURN,CSTRING)

IF NLASTKEY==27 .OR. NLASTKEY==65
   DBCLOSEAREA()
   RETURN
ENDIF

#IFDEF WINDOWS
       RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        RptStatus({|| Execute(RptDetail)})
       Return
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        Function RptDetail
Static Function RptDetail()
#ENDIF

dbselectarea("SZS")
_cFiltro := "ZS_FILIAL == '"+xFilial("SZS")+"'"
_cFiltro := _cFiltro+".and. ZS_SITUAC <> 'CC' .AND. ZS_CODTIT <> SPACE(03)"
CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="ZS_FILIAL+ZS_NUMAV+ZS_ITEM+STR(ZS_NUMINS,3)"
INDREGUA("SZS",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")
RETINDEX("SZS")
MIND:=RETINDEX("SZS")
DBSETINDEX(CINDEX)
MIND:=MIND+1

dbselectarea("SC5")
_cFiltro := "C5_FILIAL == '"+xFilial("SC5")+"'"
_cFiltro := _cFiltro+".and.C5_DIVVEN =='PUBL'"
CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="C5_FILIAL+C5_NUM"
INDREGUA("SC5",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")

DBGOTOP()
SETREGUA(RECCOUNT())
DO WHILE .NOT. EOF() .AND. SC5->C5_DIVVEN == 'PUBL'
   INCREGUA()

   MAV  := SC5->C5_NUM
   MVEND:= SC5->C5_VEND1
   MCLI := SC5->C5_CLIENTE

   DBSELECTAREA("SC6")
   DBSETORDER(01)
   DBSEEK(XFILIAL()+MAV)
   IF FOUND()
      DO WHILE SC6->C6_NUM == MAV
         MQTDE := SC6->C6_QTDVEN
         MITEM := SC6->C6_ITEM
         MPROD := SC6->C6_PRODUTO
         MDESC := ' '
         DBSELECTAREA("SB1")
         DBSETORDER(01)
         DBSEEK(XFILIAL()+MPROD)
         IF FOUND()
            MDESC := SB1->B1_DESC
         ENDIF
         DBSELECTAREA("SZS")
         DBSETORDER (MIND)
         DBSEEK(XFILIAL()+MAV+MITEM+STR(MQTDE,3))
         IF FOUND().AND.SZS->ZS_EDICAO>=MV_PAR02.AND.SZS->ZS_EDICAO<=MV_PAR03.AND.SZS->ZS_CODREV==MV_PAR01
            DBSELECTAREA("RENOV")
            RECLOCK("RENOV",.T.)
            RENOV->CODVEND := MVEND
            RENOV->CODCLI  := MCLI
            RENOV->NUMAV   := MAV
            RENOV->ITEM    := MITEM
            RENOV->FINAL   := SZS->ZS_EDICAO
            RENOV->DTCIRC  := SZS->ZS_DTCIRC
            RENOV->PRODUTO := SZS->ZS_VEIC
            RENOV->DESCR   := MDESC
            RENOV->(MSUNLOCK())
         ENDIF
         DBSELECTAREA("SC6")
         DBSKIP()
         INCREGUA()
      ENDDO
   ENDIF
   DBSELECTAREA("SC5")
   DBSKIP()
ENDDO

L := 0
DBSELECTAREA("RENOV")
DBSETORDER(01)
DBGOTOP()
DO WHILE .NOT. EOF()
   Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho,if(aReturn[4]==1,15,22))
   L:= 4
   @ L,00 PSAY REPLICATE ("*",132)
   L:= 6
   MFINAL := FINAL

   @ L,00 PSAY "REVISTA : " + MV_PAR01 + " " + PRODUTO
   @ L,25 PSAY "EDICAO DE VENCIMENTO : " + STR(FINAL,4)
   @ L,59 PSAY "DATA DE CIRCULACAO : "
   @ L,80 PSAY DTCIRC
   L := L+3
   @ L,00  PSAY "CODVEND"
   @ L,08  PSAY "NOME DO VENDEDOR"
   @ L,42  PSAY "CODCLI"
   @ L,49  PSAY "NOME DO CLIENTE"
   @ L,90  PSAY "NUMAV / IT"
   @ L,101 PSAY "FORMATO/CORES"
   L := L+1
   @ L,00  PSAY "======="
   @ L,08  PSAY "================================="
   @ L,42  PSAY "======"
   @ L,49  PSAY "========================================"
   @ L,90  PSAY "=========="
   @ L,101 PSAY "=============================="

   DBSELECTAREA("RENOV")
   DO WHILE FINAL == MFINAL
      DBSELECTAREA("SA3")
      DBSETORDER(01)
      DBSEEK(XFILIAL()+RENOV->CODVEND)
      IF FOUND()
         MNOME := SUBSTR(SA3->A3_NOME,1,35)
      ENDIF
      DBSELECTAREA("SA1")
      DBSETORDER(01)
      DBSEEK(XFILIAL()+RENOV->CODCLI)
      IF FOUND()
         MNOMC:= SA1->A1_NOME 
      ENDIF
      L := L+2
      DBSELECTAREA("RENOV")
      @ L,00  PSAY CODVEND
      @ L,08  PSAY MNOME 
      @ L,42  PSAY CODCLI
      @ L,49  PSAY MNOMC
      @ L,90  PSAY NUMAV+"/"+ITEM
      @ L,101 PSAY DESCR
      MNOME := ' '
      MNOMC := ' '
      DBSKIP()
   ENDDO
ENDDO

DBSELECTAREA("RENOV")
SET DEVICE TO SCREEN

IF aRETURN[5] ==1
   SET PRINTER TO
   DBCOMMITALL()
   OURSPOOL(WNREL)
ENDIF
MS_FLUSH()
DBCLOSEAREA()

DBSELECTAREA("SC6")
RETINDEX("SC6")
DBSELECTAREA("SC5")
RETINDEX("SC5")
DBSELECTAREA("SA3")
RETINDEX("SA3")
DBSELECTAREA("SA1")
RETINDEX("SA1")
DBSELECTAREA("SZS")
RETINDEX("SZS")
DBSELECTAREA("SB1")
RETINDEX("SB1")
RETURN
