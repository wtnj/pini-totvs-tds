#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//Danilo C S Pala 20060327: dados de enderecamento do DNE
User Function Pfat110()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("ARETURN,CPROGRAMA,CSTRING,NLASTKEY,WNREL,L")
SetPrvt("NORDEM,CTAMANHO,NCARACTER,LCONTINUA,CPERG,M_PAG")
SetPrvt("CCABEC1,CCABEC2,MARQ,MDIR,MCAMINHO,_ACAMPOS")
SetPrvt("_CNOME,CTITULO,CDESC1,CDESC2,CDESC3,TITULO")
SetPrvt("MNOMECLI,MNOMEDEST,MEND,MBAIRRO,MMUN,MCEP")
SetPrvt("MEST,MCODCLI,MCODDEST,MFONE,MOCORRENC,MPEDIDO")
SetPrvt("MITEM,MCODRESP,MOBS1,MOBS2,MOBS3,LIN")
SetPrvt("COL,LI,CINDEX,CKEY,MCONTA,mhora")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT110   ³Autor: Raquel Farias          ³ Data: 08/03/00   ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Lˆ Arquivo de retorno e atualiza roteiro                   ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento  Liberado para Usu rio em:           ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                   ³
//³ mv_par01             // Arquivo   C-8                                  ³
//³ mv_par02             // ExtensÆo  C-1  SDF   TXT   DBF                 ³
//³ mv_par03             // Diretorio C-30                                 ³
//³ mv_par04             // Atualizar Roteiro Etiqueta Relat¢rio Ambos C-1 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

ScreenDraw("SMT050", 3, 0, 0, 0)
SetCursor(1)
SetColor("B/BG")

aReturn   :={ "Especial", 1,"Administra‡Æo", 1, 2, 1,"",1 }
cPrograma :="PFAT110"
cString   :="PFAT110"
nLastKey  :=0
MHORA      := TIME()
wnrel     := "PFAT110_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
L         := 0
nOrdem    := 0
cTamanho   :="P"
nCaracter :=10
lContinua :=.T.
cPerg     :="PFAT62"
M_PAG     :=1
cCabec1   :=""
cCabec2   :=""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If .Not. PERGUNTE(cPerg)
    Return
Endif

MARQ :=MV_PAR01
MDIR :=MV_PAR03
MCAMINHO:=ALLTRIM(MDIR)+ALLTRIM(MARQ)

_aCampos := {  {"IDENT","N",1,0},;
               {"GENERICO","C",20,0},;
               {"LIXO","C",2,0},;
               {"PEDIDO","C",6,0},;
               {"ITEM","C",2,0},;
               {"CODPROD","N",5, 0},;
               {"REVISTA","C",3,0},;
               {"EDICAO","C",8,0},;
               {"CODRESP","N",3,0},;
               {"DTRESP","C",8,0},;
               {"OBS","C",255,0},;
               {"CODCLI","C",6,0},;
               {"CODDEST","C",6,0},;
               {"NOME","C",40,0},;
               {"DEST","C",40,0},;
               {"V_END","C",120,0},;
               {"BAIRRO","C",20,0},;
               {"MUN","C",20,0},;
               {"CEP","C",8, 0},;
               {"EST","C",2, 2},;
               {"FONE","C",15,0},;
               {"OCORRENC","C",10,0}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PFAT110",.F.,.F.)

IF MV_PAR02==1
   DBSELECTAREA("PFAT110")
   APPEND FROM &MCAMINHO SDF
   MSUNLOCK()
   DBGOTOP()
ENDIF

IF MV_PAR02==2
   DBSELECTAREA("PFAT110")
   APPEND FROM &MCAMINHO DELI
   MSUNLOCK()
   DBGOTOP()
ENDIF

IF MV_PAR02==3
   DBSELECTAREA("PFAT110")
   APPEND FROM &MCAMINHO
   MSUNLOCK()
   DBGOTOP()
ENDIF

IF MV_PAR04==1
   DrawAdvWin("**  ATUALIZANDO ARQUIVO  **" , 8, 0, 12, 75 )
   DBSELECTAREA("PFAT110")
   DBGOTOP()
   ATUALIZA()
ENDIF

IF MV_PAR04==2
   cTitulo   :=PADC("ETIQUETAS",74)
   cDesc1    :=PADC("Este programa ira gerar o arquivo de etiquetas" ,74)
   cDesc2    :=""
   cDesc3    :=""
   wnrel:=SetPrint(cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
   SetDefault(aReturn,cString)
   If nLastKey == 27
      DBCLOSEAREA()
      Return
   Endif

   DBSELECTAREA("PFAT110")
   DBGOTOP()
   ATUALIZA()
   ETIQUETA()
ENDIF

IF MV_PAR04==3
   cTitulo   :=PADC("RELATORIO",74)
   cDesc1    :=PADC("Este programa ira gerar o relatorio de retorno Transfolha" ,74)
   cDesc2    :=""
   cDesc3    :=""
   Titulo    :="*** Relatorio de Retorno Transfolha ***  Arq :" +MV_PAR01
   wnrel:=SetPrint(cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
   SetDefault(aReturn,cString)
   If nLastKey == 27
      DBCLOSEAREA()
      Return
   Endif

   DBSELECTAREA("PFAT110")
   DBGOTOP()
   ATUALIZA()
   RELATORIO()
ENDIF

DBSELECTAREA("PFAT110")
DBGOTOP()
MARQ:='I:\SIGA\TRANSFO\RETORNO\PFAT110.DBF'
COPY TO &MARQ VIA "DBFCDXADS" // 20121106 

DBSELECTAREA("PFAT110")
DBCLOSEAREA()

DbSelectArea("SC6")
Retindex("SC6")

DbSelectArea("SC5")
Retindex("SC5")

DbSelectArea("SZN")
Retindex("SZN")

DbSelectArea("SZO")
Retindex("SZO")

DbSelectArea("SA1")
Retindex("SA1")


// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION ATUALIZA
Static FUNCTION ATUALIZA()
   DBSELECTAREA('PFAT110')
   DBGOTOP()
   DO WHILE .NOT. EOF()
      MNOMECLI := ""
      MNOMEDEST:= ""
      MEND     := ""
      MBAIRRO  := ""
      MMUN     := ""
      MCEP     := ""
      MEST     := ""
      MCODCLI  := ""
      MCODDEST := ""
      MFONE    := ""
      MOCORRENC:=STR(CODRESP,3)
      MPEDIDO  :=PEDIDO
      MITEM    :=ITEM
      MCODRESP :=CODRESP
      MOBS1    :=SUBS(OBS,1,100)
      MOBS2    :=SUBS(OBS,101,200)
      MOBS3    :=SUBS(OBS,201,255)

      IF VAL(MPEDIDO)==0
         DBDELETE()
         DBSKIP()
         LOOP
      ENDIF

      IF MCODRESP==1
         MOCORRENC:=STR(MCODRESP,3)+'-'+'N. ENTREG'
      ENDIF

      IF MCODRESP==2
         MOCORRENC:=STR(MCODRESP,3)+'-'+'AREA RISCO'
      ENDIF

      IF MCODRESP==3
         MOCORRENC:=STR(MCODRESP,3)+'-'+'MUDOU-SE'
      ENDIF

      IF MCODRESP==4
         MOCORRENC:=STR(MCODRESP,3)+'-'+'DESCONHEC'
      ENDIF

      IF MCODRESP==5
         MOCORRENC:=STR(MCODRESP,3)+'-'+'RECUSADO'
      ENDIF

      IF MCODRESP==6
         MOCORRENC:=STR(MCODRESP,3)+'-'+'FALECIDO'
      ENDIF

      IF MCODRESP==9
         MOCORRENC:=STR(MCODRESP,3)+'-'+'FORA PERIM'
      ENDIF

      IF MCODRESP==22
         MOCORRENC:=STR(MCODRESP,3)+'-'+'N. LOCALIZ'
      ENDIF

      IF MCODRESP==26
        MOCORRENC:=STR(MCODRESP,3)+'-'+'END ERRADO'
      ENDIF

      DBSELECTAREA("SC6")
      DBGOTOP()
      DBSEEK(xfilial()+MPEDIDO+MITEM)
      IF FOUND()
         MCODDEST:=SC6->C6_CODDEST
         MCODCLI :=SC6->C6_CLI
         IF MV_PAR04==1
           /*/
           Reclock("SC6",.F.)
           REPLACE C6_OBSDISTR WITH MOCORRENC
           MSunlock()
           DBSKIP()
           /*/
         ENDIF
      ENDIF

      DBSELECTAREA("SA1")
      DBGOTOP()
      DBSEEK(XFILIAL()+MCODCLI)
      IF FOUND()
         MNOMECLI:=SA1->A1_NOME
         MEND    :=ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060327
         MBAIRRO :=SA1->A1_BAIRRO
         MMUN    :=SA1->A1_MUN
         MEST    :=SA1->A1_EST
         MCEP    :=SA1->A1_CEP
         MFONE   :=SA1->A1_TEL
      ELSE
         MNOMECLI:='  '
      ENDIF

      IF MCODDEST#' '
         DBSELECTAREA("SZN")
         DBGOTOP()
         DBSEEK(XFILIAL()+MCODCLI+MCODDEST)
         IF FOUND()
            MNOMEDEST:=SZN->ZN_NOME
         ENDIF
         DBSELECTAREA("SZO")
         DBGOTOP()
         DBSEEK(XFILIAL()+MCODCLI+MCODDEST)
         IF FOUND()
            MEND    :=ALLTRIM(SZO->ZO_TPLOG) + " " + ALLTRIM(SZO->ZO_LOGR) + " " + ALLTRIM(SZO->ZO_NLOGR) + " " + ALLTRIM(SZO->ZO_COMPL) //20060327
            MBAIRRO :=SZO->ZO_BAIRRO
            MMUN    :=SZO->ZO_CIDADE
            MEST    :=SZO->ZO_ESTADO
            MCEP    :=SZO->ZO_CEP
            IF .NOT. EMPTY(SZO->ZO_FONE)
               MFONE:=SZO->ZO_FONE
            ENDIF
         ENDIF
      ENDIF
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  GRAVA ARQUIVO TEMPORARIO                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      Reclock("PFAT110",.F.)
      REPLACE CODCLI  WITH  MCODCLI
      REPLACE CODDEST WITH  MCODDEST
      REPLACE NOME    WITH  MNOMECLI
      REPLACE DEST    WITH  MNOMEDEST
      REPLACE V_END     WITH  MEND
      REPLACE BAIRRO  WITH  MBAIRRO
      REPLACE MUN     WITH  MMUN
      REPLACE CEP     WITH  MCEP
      REPLACE EST     WITH  MEST
      REPLACE OCORRENC WITH  MOCORRENC
      REPLACE FONE     WITH  MFONE
      REPLACE OBS      WITH  MOBS1+MOBS2+MOBS3
      PFAT110->(MSunlock())
      DBSELECTAREA('PFAT110')
      DBSKIP()
   ENDDO
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION ETIQUETA
Static FUNCTION ETIQUETA()
   SETPRC(0,0)
   LIN:=0
   COL:=1
   LI :=0

   DBSELECTAREA('PFAT110')
   cIndex:=CriaTrab(Nil,.F.)
   cKey  :="NOME+DEST"
   Indregua("PFAT110",cIndex,ckey,,,"Selecionando Registros do Arq")
   DBGOTOP()

   SETREGUA(RECCOUNT())
   DBGOTOP()

   MCONTA:=0
   DO WHILE .NOT. EOF()
      IncRegua()
      MCONTA:=MCONTA+2
      @ LIN+LI,001 SAY NOME
      DBSKIP()
      @ LIN+LI,043 SAY NOME
      DBSKIP(-1)
      LI:=LI+1

      @ LIN+LI,001 SAY DEST
      DBSKIP()
      @ LIN+LI,043 SAY DEST
      DBSKIP(-1)
      LI:=LI+1

      @ LIN+LI,001 SAY V_END
      DBSKIP()
      @ LIN+LI,043 SAY V_END
      DBSKIP(-1)
      LI:=LI+1

      @ LIN+LI,001 SAY BAIRRO+'  '+'('+PEDIDO+')'
      DBSKIP()
      @ LIN+LI,043 SAY BAIRRO+'  '+'('+PEDIDO+')'
      DBSKIP(-1)
      LI:=LI+1

      @ LIN+LI,001 SAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
      DBSKIP()
      @ LIN+LI,043 SAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST

      DBSKIP()

      LI:=2
      setprc(0,0)
      lin:=prow()
   ENDDO
   @ LIN+LI  ,001 SAY '****************************************'
   @ LIN+LI+1,001 SAY 'ARQUIVO RETORNO.........:'+MV_PAR01
   @ LIN+LI+2,001 SAY 'TOTAL...................:'+STR(MCONTA,7)
   @ LIN+LI+3,001 SAY '****************************************'

   SET DEVI TO SCREEN
   IF aRETURN[5] == 1
     Set Printer to
     dbcommitAll()
     ourspool(WNREL)
   ENDIF
   MS_FLUSH()
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION RELATORIO
Static FUNCTION RELATORIO()

  DBSELECTAREA('PFAT110')
  cIndex:=CriaTrab(Nil,.F.)
  cKey  :="NOME+DEST"
  Indregua("PFAT110",cIndex,ckey,,,"Selecionando Registros do Arq")
  DBGOTOP()

  SETREGUA(RECCOUNT())
  DBGOTOP()

  MCONTA:=0
  DO WHILE .NOT. EOF()
     MCONTA:=MCONTA+1
     IncRegua()
     IMPR3()
     IMPR2()
     DBSELECTAREA('PFAT110')
     @ L,01   PSAY 'COD CLI....: '+CODCLI
     @ L,27   PSAY 'COD DEST...: '+CODDEST
     @ L,50   PSAY 'FONE.......: '+TRIM(FONE)
     @ L+1,01 PSAY 'NOME.......: '+NOME
     @ L+1,50 PSAY 'BAIRRO.....: '+BAIRRO
     @ L+2,01 PSAY 'DEST.......: '+DEST
     @ L+2,50 PSAY 'REVISTA....: '+REVISTA
     @ L+3,01 PSAY 'ENDERECO...: '+V_END
     @ L+3,50 PSAY 'EDICAO.....: '+EDICAO
     @ L+4,61 PSAY 'CIDADE/EST.: '+TRIM(MUN)+' '+EST
     @ L+4,50 PSAY 'RETORNO POR: '+MOCORRENC
     @ L+5,01 PSAY 'CEP........: '+SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)
     @ L+5,50 PSAY 'PEDIDO.....: '+PEDIDO+'-'+ITEM
     @ L+6,01 PSAY 'OBSERVACAO.: '+SUBS(OBS,1,67)
     @ L+7,01 PSAY SUBS(OBS,68,148)
     @ L+8,01 PSAY SUBS(OBS,149,229)
     @ L+9,01 PSAY SUBS(OBS,230,255)
     @ L+10,01 PSAY REPLICATE('_',79)
     L:=L+11
     DBSKIP()
  ENDDO
  @ L+1,00 PSAY '****************************************'
  @ L+2,00 PSAY 'ARQUIVO RETORNO.........:'+MV_PAR01
  @ L+3,00 PSAY 'TOTAL...................:'+STR(MCONTA,7)
  @ L+4,00 PSAY '****************************************'
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Termino do Relatorio                                         ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   SET DEVI TO SCREEN
   IF aRETURN[5] == 1
     Set Printer to
     dbcommitAll()
     ourspool(WNREL)
   ENDIF
   MS_FLUSH()
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION IMPR3
Static FUNCTION IMPR3()
   IF L<>0
      IF L==65 .OR. L+7>65
         L:=0
      ELSE
         L:=L+1
      ENDIF
   ENDIF
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION IMPR2
Static FUNCTION IMPR2()
  IF L==0
     L:=L+1
     CABEC(Titulo,cCabec1,Ccabec2,cPrograma,cTamanho,nCaracter)
     L:=4
     @ L,00 PSAY REPLICATE('*',79)
     L:=L+2
  ENDIF
RETURN

