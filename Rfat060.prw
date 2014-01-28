#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATR14   ³Autor: Rosane Lacava Rodrigues³ Data:   28/01/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de AVs Cadastradas                               ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat060()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CSAVALIAS,CPERG,CTITULO")
SetPrvt("CCABEC1,CCABEC2,CPROGRAMA,CTAMANHO,LIMITE,NCARACTER")
SetPrvt("NLASTKEY,CDESC1,CDESC2,CDESC3,M_PAG,NLIN")
SetPrvt("_OBS,_MDESC,ARETURN,WNREL,CSTRING,_CFILTRO")
SetPrvt("CINDEX,CKEY,_MCLI,_MAG,_MESP,_MPROG")
SetPrvt("_MREV,_MOBS,mhora")

cSavAlias  := Select()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //Av Inicial        ³
//³ mv_par02             //Av Final          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG:='PFAT60'
IF !PERGUNTE(CPERG)
   RETURN
ENDIF

cTitulo   := SPACE(16)+"***** RELATORIO DO CADASTRO DE A.V *****"
cCabec1   := "A.V Inicial : " + MV_PAR01 + SPACE(10) + "A.V Final : " + MV_PAR02
cCabec2   := " "
cPrograma := "RFAT060"
cTamanho  := "M"
LIMITE    := 132
nCaracter := 22
NLASTKEY  := 0
cDesc1    := PADC("Este programa gera o relat¢rio do cadastro de A.V",70)
cDesc2    := " "
cDesc3    := " "
M_PAG     := 1
nlin      := 80
_obs      := " "
_mdesc    := " "
aRETURN   :={"Especial", 1,"Administracao", 2, 2, 1," ",1 }
MHORA := TIME()
WNREL     := "RFAT060_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING   := "SC5"
WNREL     := SETPRINT(CSTRING,WNREL,CPERG,cTitulo,cDesc1,cDesc2,cDesc3,.T.)
SETDEFAULT(aRETURN,CSTRING)

IF NLASTKEY==27 .OR. NLASTKEY==65
   DBCLOSEAREA()
   RETURN
ENDIF

RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        RptStatus({|| Execute(RptDetail)})

Return

Static Function RptDetail()

dbselectarea("SC5")

_cFiltro := "C5_FILIAL == '"+xFilial("SC5")+"'"
_cFiltro := _cFiltro+".and.C5_DIVVEN =='PUBL'"

CINDEX := CRIATRAB(NIL,.F.)
CKEY   := "C5_FILIAL+C5_NUM"
INDREGUA("SC5",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")

DBSEEK(XFILIAL("SC5")+MV_PAR01,.T.)
SETREGUA(RECCOUNT()/7)
WHILE !EOF() .AND. SC5->C5_DIVVEN == 'PUBL' .AND. SC5->C5_NUM <= MV_PAR02
   INCREGUA()

   _mdesc := "CLIENTE"
   _mcli  := " "
   _mag   := " "
   _mesp  := "N"

   If VAL(SC5->C5_TPTRANS) == 4
      _mdesc := 'AGENCIA'
   Endif

   DbSelectArea("SE4")
   DbSetOrder(1)
   DbSeek(XFILIAL("SE4")+SC5->C5_CONDPAG)

   DbSelectArea("SA3")
   DbSetOrder(1)
   DbSeek(XFILIAL("SA3")+SC5->C5_VEND1)

   DbSelectArea("SA1")
   DbSetOrder(1)
   DbSeek(XFILIAL("SA1")+SC5->C5_CLIENTE)
   _mcli := SA1->A1_NOME

   DbSelectArea("SA1")
   DbSetOrder(1)
   DbSeek(XFILIAL("SA1")+SC5->C5_CODAG)
   _mag := SA1->A1_NOME

   DBSELECTAREA("SC6")
   DBSETORDER(1)
   DBSEEK(XFILIAL("SC6")+SC5->C5_NUM)
   WHILE SC6->C6_NUM == SC5->C5_NUM
      Imp_CAB()
      _mprog := "NORMAL"
      _mrev  := " "

      If SC6->C6_TPPROG == 'E'
         _mprog := "ESPECIAL"
      Endif

      If SC6->C6_TIPOREV == '0'
         _mrev := "MENSAL"
      Endif
      If SC6->C6_TIPOREV == '1'
         _mrev := "PAR"
      Endif
      If SC6->C6_TIPOREV == '2'
         _mrev := "IMPAR"
      Endif
      If SC6->C6_TIPOREV == '3'
         _mrev := "SEMANAL"
      Endif
      If SC6->C6_TIPOREV == '4'
         _mrev := "BIMESTRAL"
      Endif

      DbSelectArea("SB1")
      DbSetorder(1)
      DbSeek(XFILIAL("SB1")+SC6->C6_PRODUTO)
      DbSelectArea("SZW")
      DBSETORDER(1)
      DbSeek(xFilial("SZW")+SC6->C6_CODTIT)
      @ nlin,00 PSAY "NUMERO ITEM .: "+SC6->C6_ITEM  +SPACE(10)+"PRODUTO ........: "+SC6->C6_PRODUTO+"  VEICULO : "+SB1->B1_TITULO+" FORMATO/CORES : "+SB1->B1_DESC
      nlin := nlin + 1
      @ nlin,00 PSAY "QTD INSER€åES: "+STR(SC6->C6_QTDVEN,2)+SPACE(10)+"TIPO PROGRAMACAO: "+_mprog+SPACE(9)+"REVISTA : "+_mrev+SPACE(5)+" 1a. EDICAO ...: "+STR(SC6->C6_EDINIC,4)
      nlin := nlin + 1
      @ nlin,00 PSAY "LIQ INSER€åES: "+STR(SC6->C6_VALOR,10,2)+"  CODIGO DA SECAO : "+SC6->C6_CODTIT+"   "+SUBSTR(SZW->ZW_DESCR,1,20)
      nlin := nlin + 3
/*/
                  01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
                            1         2         3         4         5         6         7         8         9        10        11        12        13
/*/
      @ nlin,05 PSAY "  NUM.INS          EDI€ÇO          DT.CIRC.          VALOR INSER€ÇO          OBSERVA€åES"
      nlin := nlin + 1
      @ nlin,05 PSAY "  =======          ======          ========          ==============          ==========="
      nlin := nlin + 2

      DbSelectArea("SZS")
      DbSetOrder(1)
      DbSeek(XFILIAL("SZS")+SC6->C6_NUM+SC6->C6_ITEM)
      WHILE SZS->ZS_NUMAV+SZS->ZS_ITEM == SC6->C6_NUM+SC6->C6_ITEM
         _mobs := "FATURADO"
         _mesp := SZS->ZS_FATPROG
         If SZS->ZS_EDICAO == 0
            _mobs := "PENDENTE"
         Endif
         If VAL(SZS->ZS_CODMAT) == 0
            _mobs := "NAO LIBERADO"
         Endif
         If VAL(SZS->ZS_NFISCAL) == 0
            _mobs := "LIBERADO"
         Endif
         @ nlin,07 PSAY STR(SZS->ZS_NUMINS,2)+"/"+STR(SC6->C6_QTDVEN,2)
         @ nlin,25 PSAY SZS->ZS_EDICAO
         @ nlin,40 PSAY SZS->ZS_DTCIRC
         @ nlin,58 PSAY SZS->ZS_VALOR PICTURE "@E 99,999,999.99"
         @ nlin,82 PSAY _mobs
         nlin := nlin + 1
         DbSkip()
      End
      nlin := nlin + 2
      DBSELECTAREA("SC6")
      DBSKIP()
      INCREGUA()
   END
   IF _mesp ==  'S'
      IMP_CAB()
/*/
                  01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
                            1         2         3         4         5         6         7         8         9        10        11        12        13
/*/
      @ nlin,05 PSAY "  PARCELA          VALOR PARCELA"
      nlin := nlin + 1
      @ nlin,05 PSAY "  =======          ============="
      nlin := nlin + 3
      DBSELECTAREA("SZV")
      DBSETORDER(1)
      DbSeek(XFILIAL("SZV")+SC5->C5_NUM+" 1")
      WHILE SZV->ZV_NUMAV == SC5->C5_NUM
         @ nlin,08 PSAY SZV->ZV_NPARC
         @ nlin,10 PSAY "/"
         @ nlin,11 PSAY SZV->ZV_TOTPARC
         @ nlin,25 PSAY SZV->ZV_VALOR PICTURE "@E 9,999,999.99"
         nlin := nlin + 1
         DBSKIP()
      END
   ENDIF
   DBSELECTAREA("SC5")
   DBSKIP()
ENDDO

SET DEVICE TO SCREEN
IF aRETURN[5] ==1
   SET PRINTER TO
   DBCOMMITALL()
   OURSPOOL(WNREL)
ENDIF
MS_FLUSH()

DBSELECTAREA("SC6")
RETINDEX("SC6")

DBSELECTAREA("SC5")
RETINDEX("SC5")

DBSELECTAREA("SA3")
RETINDEX("SA3")

DBSELECTAREA("SA1")
RETINDEX("SA1")

DBSELECTAREA("SB1")
RETINDEX("SB1")

DBSELECTAREA("SE4")
RETINDEX("SE4")

DBSELECTAREA("SZW")
RETINDEX("SZW")

RETURN

Static FUNCTION Imp_cab()

nlin := Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho,18) //IIF(aReturn[4] == 1,15,22))
nlin := nlin + 2
@ nlin,00 PSAY "NUMERO DA AV : "+SC5->C5_NUM
nlin := nlin + 3
@ nlin,00 PSAY "CLIENTE .....: "+SC5->C5_CLIENTE+"  NOME DO CLIENTE : "+_mcli+"  FATURAR PARA : "+_mdesc
nlin := nlin + 1
@ nlin,00 PSAY "AGENCIA .....: "+SC5->C5_CODAG  + "  NOME DA AGENCIA : "+_mag+"  TRANSA€ÇO ...: "+SC5->C5_TPTRANS
nlin := nlin + 1
@ nlin,00 PSAY "VENDEDOR ....: "+SC5->C5_VEND1  + "  NOME DO VENDEDOR: "+SA3->A3_NOME+"  COND PAGTO ..: "+SC5->C5_CONDPAG+"   "+SE4->E4_DESCRI
nlin := nlin + 3

RETURN
