#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFDEF WINDOWS
        #DEFINE SAY PSAY
#ENDIF

User Function Rfat076()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,MCDEMP")
SetPrvt("MDESCS,MQTDDR,MQTDDS,MDESCR,NLASTKEY,_ACAMPOS")
SetPrvt("_CNOME,CINDEX,CKEY,MD,XD,MDESP")
SetPrvt("MDOC,_CFILTRO,CINDEX1,MTES,MNOTA,MSERIE")
SetPrvt("MPROD,MQTDE,MVAL,MVEND,MREG,MEQP")
SetPrvt("MTIT,MCOD,")

#IFDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>         #DEFINE SAY PSAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: ROFAT     ³Autor: Rosane Lacava Rodrigues³ Data:   28/05/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de Faturamento por produto                       ³ ±±
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
//³ mv_par01             //Da data:          ³
//³ mv_par02             //Ate a data:       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG:='FAT022'
IF .NOT. PERGUNTE(CPERG)
   RETURN
ENDIF

MCDEMP  := 0
MDESCS  := 0
MQTDDR  := 0
MQTDDS  := 0
MDESCR  := 0
NLASTKEY:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ScreenDraw("SMT050", 3, 0, 0, 0)
SetCursor(1)
SetColor("B/BG")

DrawAdvWin("***** FATURAMENTO POR PRODUTO *****", 8, 0, 14, 75)
@ 10,10 say "Este programa gera o arquivo DBF com o valor total do"
@ 11,14 say "faturamento por produto no periodo solicitado"

_aCampos := {{"CODIGO"  ,"C",1, 0} ,;
             {"QTDE"    ,"N",11,0} ,;
             {"TITULO"  ,"C",23,0} ,;
             {"VALOR"   ,"N",10,2} ,;
             {"DOC"     ,"C",6,0} ,;
             {"SERIE"   ,"C",3,0} ,;
             {"PEDIDO"  ,"C",6,0} ,;
             {"EQUIPE"  ,"C",28,0}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"FAT",.F.,.F.)
CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="TITULO+EQUIPE"
INDREGUA("FAT",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")

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

MD   :=MV_PAR01
XD   :=DTOS(MD)
MDESP:=0
MDOC := '      '

DBSELECTAREA("SD2")
DBSETORDER(05)
_cFiltro := "D2_FILIAL == '"+xFilial("SD2")+"'"
_cFiltro := _cFiltro+".AND.DTOS(D2_EMISSAO)>=DTOS(CTOD('"+DTOC(MV_PAR01)+"'))"

CINDEX1:=CRIATRAB(NIL,.F.)
INDREGUA("SD2",CINDEX1,INDEXKEY(),,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")

DBSEEK(XFILIAL()+XD,.T.)   // Soft Seek on (.T.)
SETREGUA(RECCOUNT())

DO WHILE .NOT. EOF() .AND. SD2->D2_EMISSAO <= MV_PAR02
   INCREGUA()
   MTES := D2_TES

   IF SD2->D2_TES == '670' .OR. SD2->D2_SERIE == 'LIV' .OR. SD2->D2_SERIE == 'CP0'
      DBSKIP()
      LOOP
   ENDIF

   DBSELECTAREA("SF4")
   DBSETORDER(01)
   DBSEEK(XFILIAL()+MTES)
   IF .NOT. "VENDA" $(F4_TEXTO) .AND. .NOT. "PREST SERV" $(F4_TEXTO)
      DBSELECTAREA("SD2")
      DBSKIP()
      LOOP
   ENDIF

   MNOTA := SD2->D2_DOC
   MSERIE:= SD2->D2_SERIE
   MPROD := SD2->D2_COD
   MQTDE := SD2->D2_QUANT
   MVAL  := SD2->D2_TOTAL

   IF MNOTA <> MDOC
      DBSELECTAREA("SF2")
      DBSEEK(XFILIAL()+MNOTA)
      IF .NOT. FOUND()
          DBSELECTAREA("SD2")
          DBSKIP()
          LOOP
      ENDIF
      MVEND := SF2->F2_VEND1
      MDESP := SF2->F2_DESPREM
   ENDIF

   DBSELECTAREA("SA3")
   DBSEEK(XFILIAL()+MVEND)
   IF .NOT. FOUND()
       DBSELECTAREA("SD2")
       DBSKIP()
       LOOP
   ENDIF

   MREG := A3_REGIAO
   IF VAL(A3_REGIAO) < 20
      MEQP  := 'SAO PAULO                   '
      MDESCS:=MDESCS+MDESP
   ELSE
      MEQP  := 'REPRESENTACOES INDEPENDENTES'
      MDESCR:=MDESCR+MDESP
   ENDIF

   IF MDESP <> 0
      IF VAL(A3_REGIAO) < 20
         MQTDDS:=MQTDDS+1
      ELSE
         MQTDDR:=MQTDDR+1
      ENDIF
   ENDIF

   DBSELECTAREA("SB1")
   DBSEEK(XFILIAL()+MPROD)
   IF .NOT. FOUND()
       MTIT := SPACE(23)
   ELSE
       MTIT := SUBSTR(B1_TITULO,1,10)+SPACE(13)
   ENDIF

   IF SUBSTR(MPROD,1,2) == '01'
      MCOD   := '1'
      MCDEMP := 1
   ENDIF
   IF SUBSTR(MPROD,1,2) == '02' .OR. SUBSTR(MPROD,1,2) == '07'
      MCOD   := '2'
      MCDEMP := 1
   ENDIF
   IF SUBSTR(MPROD,1,4) == '0198' .OR. SUBSTR(MPROD,1,4) == '0607'
      MCOD   := '6'
      MTIT   := 'SEPARATAS              '
      MCDEMP := 1
   ENDIF
   IF SUBSTR(MPROD,1,4) == '0601'
      MCOD   := '6'
      MTIT   := 'APARAS                 '
      MCDEMP := 1
   ENDIF

   IF SUBSTR(MPROD,1,4) == '0699'
      MCOD   := '6'
      MTIT   := 'DIVERSOS               '
      MCDEMP := 1
   ENDIF

   IF SUBSTR(MPROD,1,2) == '04'
      MTIT   := 'SERVICOS DE ENGENHARIA '
      MCOD   := '2'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,4) == '0403'
      MTIT   := 'INDI EXPRESS           '
      MCOD   := '2'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,2) == '05'
      MTIT   := 'CURSOS                 '
      MCOD   := '2'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,2) == '10'
      MTIT   := 'RELATORIOS             '
      MCOD   := '2'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,2) == '11' .OR. SUBSTR(MPROD,1,2) == '20'
      MTIT   := 'SOFTWARE VOLARE        '
      MCOD   := '1'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,4) == '1105'
      MTIT   := 'ATUALIZACAO DE INSUMOS '
      MCOD   := '1'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,2) == '12'
      MTIT   := 'VOLARE PROPOSTA TECNICA'
      MCOD   := '1'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,2) == '13'
      MTIT   := 'VOLARE PEQUENAS OBRAS'
      MCOD   := '1'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,2) == '14'
      MTIT   := 'SOFTWARE STRATO        '
      MCOD   := '1'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,4) == '1501'
      MTIT   := 'SOFTWARE ARCON         '
      MCOD   := '1'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,4) == '1502'
      MTIT   := 'SOFTWARE PROCAD        '
      MCOD   := '1'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,2) == '17'
      MTIT   := 'ESSERE                 '
      MCOD   := '2'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,4) == '1901'
      MTIT   := 'TREINAMENTO VOLARE     '
      MCOD   := '1'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,4) == '1902'
      MTIT   := 'TREINAMENTO ARCON      '
      MCOD   := '1'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,4) == '1903'
      MTIT   := 'TREINAMENTO PROCAD     '
      MCOD   := '1'
      MCDEMP := 2
   ENDIF
   IF SUBSTR(MPROD,1,4) == '1904'
      MTIT   := 'TREINAMENTO STRATO     '
      MCOD   := '1'
      MCDEMP := 2
   ENDIF

   DBSELECTAREA("FAT")
   DBSEEK(MTIT+MEQP)
   IF .NOT. FOUND()
      RECLOCK("FAT",.T.)
      FAT->CODIGO := MCOD
      FAT->QTDE   := MQTDE
      FAT->VALOR  := MVAL
      FAT->TITULO := MTIT
      FAT->EQUIPE := MEQP
      FAT->(MsUnlock())
   ELSE
      RECLOCK("FAT",.F.)
      FAT->VALOR  := (FAT->VALOR + MVAL )
      FAT->QTDE   := (FAT->QTDE  + MQTDE)
      FAT->(MsUnlock())
   ENDIF
   MDOC := MNOTA
   MDESP:= 0
   DBSELECTAREA("SD2")
   DBSKIP()
   INCREGUA()
ENDDO

DBSELECTAREA("FAT")
IF MDESCS <> 0
   RECLOCK("FAT",.T.)
   FAT->CODIGO := '9'
   FAT->QTDE   := MQTDDS
   FAT->VALOR  := MDESCS
   FAT->TITULO := 'DESPESAS DE REMESSA'
   FAT->EQUIPE := 'SAO PAULO'
   FAT->(MsUnlock())
ENDIF
IF MDESCR <> 0
   RECLOCK("FAT",.T.)
   FAT->CODIGO := '9'
   FAT->QTDE   := MQTDDR
   FAT->VALOR  := MDESCR
   FAT->TITULO := 'DESPESAS DE REMESSA'
   FAT->EQUIPE := 'REPRESENTACOES INDEPENDENTES'
   FAT->(MsUnlock())
ENDIF
IF MCDEMP == 1
   COPY TO I:\SIGA\ARQTEMP\FATED.DBF
ELSE
   COPY TO I:\SIGA\ARQTEMP\FATPS.DBF
ENDIF
DBCLOSEAREA()
MS_FLUSH()

DBSELECTAREA("SF2")
RETINDEX("SF2")
DBSELECTAREA("SA3")
RETINDEX("SA3")
DBSELECTAREA("SD2")
RETINDEX("SD2")
DBSELECTAREA("SB1")
RETINDEX("SB1")
RETURN

