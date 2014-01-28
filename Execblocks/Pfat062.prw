#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02

User Function Pfat062()        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CDESC1,CDESC2,CDESC3,MDESCR,CPERG,LCONTINUA")
SetPrvt("MDTSIS,MHORA,MNOMEARQ,_ACAMPOS,_CNOME,CCHAVE")
SetPrvt("CFILTRO,CFILTRO1,CFILTRO2,CFILTRO3,CFILTRO4,CFILTRO5")
SetPrvt("CFILTRO6,CIND,MPEDIDO,MITEM,MCODCLI,MCODDEST")
SetPrvt("MPRODUTO,MEDICAO,MQTDE,MNOMECLI,MNOMEDEST,MEND")
SetPrvt("MBAIRRO,MMUN,MCEP,MEST,MFONE,MROTEIRO")
SetPrvt("MSTATUSI,MDTOCORR,NOMEDEST,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT062   ³Autor: Raquel Farias          ³ Data:   23/08/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Geracao do arquivo texto para distribuidor                 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // De                 D-8               ³
//³ mv_par02             // At‚                D-8               ³
//³ mv_par03             // Do  Produto        C-15              ³
//³ mv_par04             // At‚ Produto        C-15              ³
//³ mv_par05             // Da  Edi‡Æo         N-4               ³
//³ mv_par06             // At‚ Edi‡Æo         N-4               ³
//³ mv_par07             // Tipo de Sa¡da      G-1               ³
//³ mv_par08             // Status de          C-3               ³
//³ mv_par09             // Status at‚         C-3               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


ScreenDraw("SMT050", 3, 0, 0, 0)
SetCursor(1)
SetColor("B/BG")

cDesc1 :=PADC("Este programa ira gerar o arquivo de ocorrencias" ,74)
cDesc2 :="  "
cDesc3 :=""

mDESCR :="  "

cPerg:="PFAT28"

lContinua := .T.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If .Not. PERGUNTE(cPerg)
    Return
Endif

MDTSIS:=DTOC(MV_PAR02)
MHORA :=TIME()
MNOMEARQ:='I:\SIGA\TRANSFO\OCORREN\'+'OC'+SUBS(MDTSIS,1,2)+SUBS(MDTSIS,4,2)+SUBS(MHORA,1,2)+'.TXT'

DrawAdvWin("**  GERACAO ARQUIVO - OCORRENCIAS  **" , 8, 0, 12, 75 )

_aCampos := {}
AADD(_aCampos,{"NUMPED","C",6,0})
AADD(_aCampos,{"ITEM","C",2,0})
AADD(_aCampos,{"CODCLI","C",6,0})
AADD(_aCampos,{"CODDEST","C",6,0})
AADD(_aCampos,{"PRODUTO","C",12,0})
AADD(_aCampos,{"EDICAO","N",4,0})
AADD(_aCampos,{"QTDE","N",5,0})
AADD(_aCampos,{"NOME","C",40,0})
AADD(_aCampos,{"DEST","C",40,0})
AADD(_aCampos,{"END","C",40,0})
AADD(_aCampos,{"BAIRRO","C",20,0})
AADD(_aCampos,{"CEP","C",8,0})
AADD(_aCampos,{"MUN","C",20,0})
AADD(_aCampos,{"EST","C",2,2})
AADD(_aCampos,{"ROTEIRO","C",10,0})
AADD(_aCampos,{"FONE","C",20,0})
AADD(_aCampos,{"STATUSI","C",3,0})
AADD(_aCampos,{"OCORR","C",60,0})
AADD(_aCampos,{"DTOCORR","D",8,0})

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PFAT062",.F.,.F.)

DBSELECTAREA('SZ1')
cChave := IndexKey()
cFiltro:='DTOS(Z1_DTOCORR)>="'+DTOS(MV_PAR01)+'"'
cFiltro1:='.AND.DTOS(Z1_DTOCORR)<="'+DTOS(MV_PAR02)+'"'
cFiltro2:='.AND.Z1_CODPROD>="'+MV_PAR03+'" .AND. Z1_CODPROD<="'+MV_PAR04+'"'
cFiltro3:='.AND.Z1_EDICAO>=MV_PAR05 .AND. Z1_EDICAO<=MV_PAR06'
cFiltro4:='.AND.Z1_ATEND<>"S"'
cFiltro5:='.AND.Z1_STATUSI>=MV_PAR08 .AND. Z1_STATUSI<=MV_PAR09'
cFiltro6:=cFiltro+cFiltro1+cFiltro2+cFiltro3+cFiltro4+cFiltro5
cInd:= CriaTrab(nil,.f.)
IndRegua("SZ1",cInd,cChave,,cFiltro6,"Filtrando ..")

DBGOTOP()
DO WHILE .NOT. EOF()
   @ 10, 5 Say "   A G U A R D E  - LENDO REGISTRO -> "+STR(RECNO())
   MPEDIDO  :=""
   MITEM    :=""
   MCODCLI  :=""
   MCODDEST :=""
   MPRODUTO :=""
   MEDICAO  :=""
   MQTDE    :=""
   MNOMECLI :=""
   MNOMEDEST:=""
   MEND     :=""
   MBAIRRO  :=""
   MMUN     :=""
   MCEP     :=""
   MEST     :=""
   MFONE    :=""
   MROTEIRO :=""
   MSTATUSI :=""
   MDTOCORR :=""
   DBSELECTAREA('SZ1')
   MPEDIDO :=SZ1->Z1_PEDIDO
   MITEM   :=SZ1->Z1_ITEM
   MCODCLI :=SZ1->Z1_CODCLI
   MPRODUTO:=SZ1->Z1_CODPROD
   MEDICAO :=SZ1->Z1_EDICAO
   MQTDE   :=SZ1->Z1_QTDE
   MSTATUSI:=SZ1->Z1_STATUSI
   MDTOCORR:=SZ1->Z1_DTOCORR
   DBSELECTAREA('SC6')
   DBSETORDER(10)
   DBSEEK(xfilial()+MCODCLI+MPEDIDO)
   IF FOUND()
      DO WHILE .T.
         IF SUBS(SC6->C6_PRODUTO,1,4)==SUBS(SZ1->Z1_CODPROD,1,4)  .AND. SC6->C6_NUM==MPEDIDO
            MCODDEST:=SC6->C6_CODDEST
            IF EMPTY(MITEM)
               MITEM   :=SC6->C6_ITEM
            ENDIF
            MROTEIRO:=ALLTRIM(SC6->C6_ROTEIRO)
            IF MROTEIRO<>'ECT'
               DBSELECTAREA('SZ1')
               RECLOCK('SZ1',.F.)
               REPLA Z1_ATEND WITH 'S'
               REPLA Z1_PROVID WITH 'ENVIADO PARA DISTRIBUIDOR EM ' +DTOC(DATE())
               REPLA Z1_ROTEIRO WITH 'TRF'
               DBUNLOCK()
               RELACIONA()
               GRAVA_TEMP()
               EXIT
            ENDIF
            DBSELECTAREA('SC6')
            DBSKIP()
         ELSE
            DBSKIP()
            IF SC6->C6_CLI==SZ1->Z1_CODCLI
               LOOP
            ELSE
              EXIT
            ENDIF
         ENDIF
      ENDDO
   ENDIF
   DBSELECTAREA('SZ1')
   DBSKIP()
ENDDO

DBSELECTAREA("PFAT062")
DBGOTOP()
COPY TO &MNOMEARQ SDF

DbSelectArea("PFAT062")
DBCLOSEAREA()

DbSelectArea("SC6")
Retindex("SC6")

DbSelectArea("SA1")
Retindex("SA1")

DbSelectArea("SZO")
Retindex("SZO")

DbSelectArea("SZN")
Retindex("SZN")

DbSelectArea("SZ1")
Retindex("SZ1")


// Substituido pelo assistente de conversao do AP5 IDE em 16/03/02 ==> FUNCTION RELACIONA
Static FUNCTION RELACIONA()

   DBSELECTAREA("SA1")
   DBSEEK(XFILIAL()+MCODCLI)
   IF FOUND()
      MNOMECLI:=SA1->A1_NOME
   ELSE
      MNOMECLI:='  '
   ENDIF
    MEND    :=SA1->A1_END
    MBAIRRO :=SA1->A1_BAIRRO
    MMUN    :=SA1->A1_MUN
    MEST    :=SA1->A1_EST
    MCEP    :=SA1->A1_CEP
    MFONE   :=SA1->A1_TEL
    NOMEDEST:=SPACE(40)
    IF MCODDEST#' '
       DBSELECTAREA("SZN")
       DBSEEK(XFILIAL()+MCODCLI+MCODDEST)
       IF FOUND()
          MNOMEDEST:=SZN->ZN_NOME
       ENDIF
       DBSELECTAREA("SZO")
       DBSEEK(XFILIAL()+MCODCLI+MCODDEST)
       IF FOUND()
          MEND    :=SZO->ZO_END
          MBAIRRO :=SZO->ZO_BAIRRO
          MMUN    :=SZO->ZO_CIDADE
          MEST    :=SZO->ZO_ESTADO
          MCEP    :=SZO->ZO_CEP
          MFONE   :=SZO->ZO_FONE
       ENDIF
   ELSE
      MNOMEDEST:='  '
   ENDIF
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 16/03/02 ==> FUNCTION GRAVA_TEMP
Static FUNCTION GRAVA_TEMP()
DBSELECTAREA("PFAT062")
                Reclock("PFAT062",.t.)
                REPLA NUMPED   WITH  MPEDIDO
                REPLA ITEM     WITH  MITEM
                REPLA CODCLI   WITH  MCODCLI
                REPLA CODDEST  WITH  MCODDEST
                REPLA PRODUTO  WITH  MPRODUTO
                REPLA EDICAO   WITH  MEDICAO
                REPLA QTDE     WITH  MQTDE
                REPLA NOME     WITH  MNOMECLI
                REPLA DEST     WITH  MNOMEDEST
                REPLA END      WITH  MEND
                REPLA BAIRRO   WITH  MBAIRRO
                REPLA MUN      WITH  MMUN
                REPLA CEP      WITH  MCEP
                REPLA EST      WITH  MEST
                REPLA FONE     WITH  MFONE
                REPLA ROTEIRO  WITH  MROTEIRO
                REPLA STATUSI  WITH  MSTATUSI
                REPLA DTOCORR  WITH  MDTOCORR
                REPLA OCORR    WITH  SZ1->Z1_OCORR
                dbUnlock()
RETURN

