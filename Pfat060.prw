#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//Danilo C S Pala 20060327: dados de enderecamento do DNE, etiqueta com 9 linhas, sendo a ultima ponto(.)
User Function Pfat060()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("ARETURN,CPROGRAMA,CSTRING,NLASTKEY,WNREL,L")
SetPrvt("NORDEM,TAMANHO,NCARACTER,LCONTINUA,CDESC1,CDESC2")
SetPrvt("CDESC3,CTITULO,CCABEC1,CCABEC2,CARQ,M_PAG")
SetPrvt("MCONTA4,CPERG,TITULO,MV_PAR01,MARQUIVO,_ACAMPOS")
SetPrvt("_CNOME,MCEPINI,MCHAVE,CINDEX,CKEY,MCONTA3")
SetPrvt("MCHAVE1,MCHAVE2,MIND2,MIND3,CCHAVE,CFILTRO1")
SetPrvt("CFILTRO2,CFILTRO3,CFILTRO4,CFILTRO,CIND,MCONTA")
SetPrvt("MCONTA1,MCONTA2,MORIGEM,MCODCLI,MNOMECLI,MEND")
SetPrvt("MBAIRRO,MMUN,MEST,MCEP,MFONE,MDEST")
SetPrvt("MCGC,MCONTATO,MCODDEST,MNOMEDEST,MTIPO,MUTILIZA")
SetPrvt("MDTUTILI,MFONE1,LIN,COL,LI,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT060   ³Autor: Raquel Farias          ³ Data:   19/07/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Arquivo de clientes/prospects                              ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Origem Inicial     C-3               ³
//³ mv_par02             // Origem Final       C-3               ³
//³ mv_par03             // Cep Inicial        C-8               ³
//³ mv_par04             // Cep Final          C-8               ³
//³ mv_par05             // Clientes Prospects C-1               ³
//³ mv_par06             // Da Atividade       C-7               ³
//³ mv_par07             // At‚ Atividade      C-7               ³
//³ mv_par08             // Do Produto         C-15              ³
//³ mv_par09             // At‚ Produto        C-15              ³
//³ mv_par10             // Contagem Arquivo Etiqueta Relat¢rio  ³
//³ mv_par11             // Sim NÆo                              ³
//³ mv_par12             // qtde de registros selecionados       ³
//³ mv_par13             // Televendas Mala Direta               ³
//³ mv_par14             // Data da sele‡ao                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

ScreenDraw("SMT050", 3, 0, 0, 0)
SetCursor(1)
SetColor("B/BG")

aReturn   :={ "Especial", 1,"Administra‡Æo", 1, 2, 1,"",1 }
cPrograma :="PFAT060"
cString   :="PFAT060"
nLastKey  :=0
wnrel     :="PFAT060"
L         :=0
nOrdem    :=0
tamanho   :="P"
nCaracter :=10
lContinua :=.T.
cDesc1    :=""
cDesc2    :=""
cDesc3    :=""
cTitulo   :=""
cCabec1   :=""
cCabec2   :=""
carq      :=""
M_PAG     :=1
MCONTA4   :=0

cPerg :="PFAT26"

If .Not. PERGUNTE(cPerg)
    Return
Endif

If LastKey()== 27
   Return
Endif

IF MV_PAR10==3
   cDesc1    :=PADC("Este programa ira gerar o arquivo de clientes em etiquetas" ,74)
   cDesc2    :=PADC("Elimina duplicidade por nome+destinat rio+cep",74)
   cDesc3    :=""
   cTitulo   :=PADC("ETIQUETAS",74)
ENDIF

IF MV_PAR10==4
   cDesc1    :=PADC("Este programa ira gerar o arquivo de cliente em relat¢rio" ,74)
   cDesc2    :=PADC("Elimina duplicidade por nome+destinatario+cep",74)
   cDesc3    :=""
   cTitulo   :=PADC("RELATàRIO",74)
   IF MV_PAR05==1
      Titulo    :="**** CLIENTES ****"
   ENDIF
   IF MV_PAR05==2
      Titulo    :="**** PROSPECTS ****"
   ENDIF
ENDIF

IF VAL(MV_PAR01)==0
   MV_PAR01:=SPACE(3)
ENDIF

IF MV_PAR05==1
   MARQUIVO:='SA1'
ENDIF

IF MV_PAR05==2
   cArq:='CADPINI2.DBF'
   dbUseArea( .T.,, cArq,"CADPINI2", if(.F. .OR. .F., !.F., NIL), .F. )
   MARQUIVO:='CADPINI2'
ENDIF

DrawAdvWin(" AGUARDE  - GERANDO ARQUIVO DE CLIENTES -  " , 8, 0, 15, 75 )
_aCampos := {  {"CODCLI"  ,"C", 6,0},;
               {"CODDEST" ,"C", 6,0},;
               {"NOME"    ,"C",45,0},;
               {"DEST"    ,"C",45,0},;
               {"V_END"     ,"C",120,0},;
               {"BAIRRO"  ,"C",30,0},;
               {"MUN"     ,"C",30,0},;
               {"EST"     ,"C", 2,0},;
               {"TIPO"    ,"C", 1,0},;
               {"FONE"    ,"C",20,0},;
               {"ORIGEM"  ,"C", 3,0},;
               {"CGC"     ,"C", 3,0},;
               {"CEP"     ,"C", 8,0}}
_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PFAT060",.F.,.F.)

MCEPINI:=MV_PAR03
MCHAVE :=VAL(MV_PAR03)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio do relatorio                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF MV_PAR05==1
   INDEXA()
ENDIF

SELECAO()
LIMPA()

DO WHILE .T.
   ScreenDraw("SMT050", 3, 0, 0, 0)
   SetCursor(1)
   SetColor("B/BG")

   cPerg:="PFAT26"

   If .Not. PERGUNTE(cPerg)
       exit
   Endif

   If LastKey()== 27
      exit
   Endif

   DrawAdvWin(" AGUARDE  - " , 8, 0, 15, 75 )
   SELECAO()
   LIMPA()
ENDDO
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Copia selecao para arquivo dbf                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DrawAdvWin(" AGUARDE  - COPIANDO ARQUIVO   " , 8, 0, 10, 75 )
DBSELECTAREA("PFAT060")
DBGOTOP()
COPY TO I:\SIGA\ARQTEMP\PFAT060.DBF


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Elimina duplicidade por codigo de cliente+destinatario       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

IF MV_PAR11==1
   DBSELECTAREA("PFAT060")
   cIndex:=CriaTrab(Nil,.F.)
   cKey  :="NOME+DEST+TIPO+CEP"
   Indregua("PFAT060",cIndex,ckey,,,"Selecionando Registros do Arq")

   DBSELECTAREA("PFAT060")
   DBGOTOP()
   MCONTA3:=0
   DrawAdvWin(" AGUARDE  - TIRANDO DUPLICIDADE POR NOME E CEP   " , 8, 0, 15, 75 )
   DO WHILE .NOT. EOF()
      MCONTA3:=MCONTA3+1
      @ 10,05 SAY 'LENDO REGISTRO : '+STR(MCONTA3,7)
      MCHAVE1:=NOME+DEST+CEP
      IF EOF()
        EXIT
      ELSE
           DBSKIP()
      ENDIF
      MCHAVE2:=NOME+DEST+CEP
      DO WHILE MCHAVE2==MCHAVE1
         Reclock("PFAT060",.F.)
         DBDELETE()
         PFAT060->(MSunlock())
         IF EOF()
             EXIT
         ELSE
           DBSKIP()
           MCHAVE2:=NOME+DEST+CEP
         ENDIF
      ENDDO
   ENDDO
   COPY TO I:\SIGA\ARQTEMP\PFAT060.DBF
ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Contagem dos registros selecionados                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF MV_PAR10==1
   DBSELECTAREA("PFAT060")
   COUNT FOR TIPO=='C' TO MCONTA1
   COUNT FOR TIPO=='P' TO MCONTA
   LIMPA()
   MOSTRA()
ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define formato de saida do relatorio                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF MV_PAR10==3
   wnrel:=SetPrint(cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
   SetDefault(aReturn,cString)
   If nLastKey == 27
      Return
   Endif
   ETIQUETA()
ENDIF

IF MV_PAR10==4
   wnrel:=SetPrint(cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
   SetDefault(aReturn,cString)
   If nLastKey == 27
      Return
   Endif
   RELATORIO()
ENDIF

DBCLOSEAREA()

DBSELECTAREA("SA1")
Retindex("SA1")

DBSELECTAREA('SZO')
Retindex("SZO")

DBSELECTAREA('SZN')
Retindex("SZN")

Retindex("SD2")
Retindex("SD2")


// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION INDEXA
Static FUNCTION INDEXA()
   DBSELECTAREA("SC6")
   cIndex:=CriaTrab(Nil,.F.)
   cKey:="C6_FILIAL+C6_CLI"
   Indregua("SC6",cIndex,ckey,,,"Selecionando Registros do Arq")
   Retindex("SC6")
   MIND2:=Retindex("SC6")
   DBSETINDEX(CINDEX)
   DBSETORDER(MIND2+1)
   DBGOTOP()

   DBSELECTAREA("SZN")
   cIndex:=CriaTrab(Nil,.F.)
   cKey:="ZN_FILIAL+ZN_CODCLI"
   Indregua("SZN",cIndex,ckey,,,"Selecionando Registros do Arq")
   Retindex("SZN")
   MIND3:=Retindex("SZN")
   DBSETINDEX(CINDEX)
   DBSETORDER(MIND3+1)
   DBGOTOP()
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION SELECAO
Static FUNCTION SELECAO()
  DBSELECTAREA(MARQUIVO)
  DBGOTOP()
  cArq    := MARQUIVO
  cChave  := 'A1_CEP+A1_ORIGEM+A1_ATIVIDA'
  cFiltro1:= 'A1_ORIGEM >= "'+MV_PAR01+'" .AND. A1_ORIGEM <= "'+MV_PAR02+'"'
  cFiltro2:= ' .AND. DTOS(A1_DTUTILI) <= "'+DTOS(MV_PAR14)+'"'
  cFiltro3:= ' .AND. A1_CEP >= "'+MV_PAR03+'" .AND. A1_CEP <= "'+MV_PAR04+'"'
  cFiltro4:= ' .AND. A1_ATIVIDA >= "'+MV_PAR06+'" .AND. A1_ATIVIDA <= "'+MV_PAR07+'"'
  cFiltro := cFiltro1+cFiltro2+cFiltro3+cFiltro4
  cInd    := CriaTrab(nil,.f.)
  IndRegua( cArq, cInd, cChave, , cFiltro, "Filtrando .." )
  DBGOTOP()
  MCONTA :=0
  MCONTA1:=0
  MCONTA2:=0
  DBSELECTAREA(MARQUIVO)
  DBGOTOP()
  DO WHILE .NOT. EOF() .AND. MCONTA2<>MV_PAR12
     MCONTA2  :=MCONTA2+1
     MORIGEM  :=A1_ORIGEM
     MCODCLI  :=A1_COD
     MNOMECLI :=A1_NOME
     MEND     := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060327
     MBAIRRO  :=A1_BAIRRO
     MMUN     :=A1_MUN
     MEST     :=A1_EST
     MCEP     :=A1_CEP
     MFONE    :=A1_TEL
     MDEST    :=SPACE(40)
     MCGC     :=A1_CGC
     MCONTATO :=A1_CONTATO
     MCODDEST :=""
     MNOMEDEST:=""
     MTIPO    :=""
     MUTILIZA :=""
     MDTUTILI :=DATE()


     IF MV_PAR13==1 .AND. EMPTY(MFONE)
        DBSKIP()
        LOOP
     ENDIF

     IF MV_PAR13==2
        IF EMPTY(MEND) .OR. EMPTY(MCEP)
           DBSKIP()
           LOOP
        ENDIF
     ENDIF

     IF VAL(MCODCLI)==0
        DBSKIP()
        LOOP
     ENDIF

     MCONTA4 :=MCONTA4+1

     @ 10, 5 Say "   A G U A R D E  - LIDOS"+" "+MARQUIVO+" "+"->"+STR(MCONTA2,7)
     @ 11, 5 Say "   A G U A R D E  - LENDO CEP -> "+MCEP
     @ 12, 5 Say "   A G U A R D E  - GRAVANDO  -> "+STR(MCONTA4,7)

     DO CASE
        CASE MV_PAR13==1
        MUTILIZA:='TELEVENDAS'
        CASE MV_PAR13==2
        MUTILIZA:='MALA DIRETA'
     ENDCASE

     Reclock("MARQUIVO",.F.)
     REPLACE A1_UTILIZA  WITH MUTILIZA
     REPLACE A1_DTUTILI  WITH  MDTUTILI
     MARQUIVO->(MSunlock())

     DBSELECTAREA('SC6')
     DBGOTOP()
     DBSEEK(xFILIAL()+MCODCLI)
     IF FOUND()
        MTIPO:='C' //CLIENTE
     ELSE
        MTIPO:='P' //PROSPECT
     ENDIF

     IF SC6->C6_PRODUTO<'"+MV_PAR08+"' .AND. SC6->C6_PRODUTO>'"+MV_PAR09+"'
        DBSELECTAREA(MARQUIVO)
        DBSKIP()
        LOOP
     ENDIF

     IF MV_PAR05==1 .AND. MTIPO<>'C'
        DBSELECTAREA(MARQUIVO)
        DBSKIP()
        LOOP
     ENDIF

     IF MV_PAR05==2 .AND. MTIPO<>'P'
        DBSELECTAREA(MARQUIVO)
        DBSKIP()
        LOOP
     ENDIF

     DBSELECTAREA("SZN")
     DBGOTOP()
     DBSEEK(XFILIAL()+MCODCLI)
     IF FOUND()
        DO WHILE SZN->ZN_CODCLI==MCODCLI
           MNOMEDEST:=SZN->ZN_NOME
           MCODDEST :=SZN->ZN_CODDEST
           DBSELECTAREA("SZO")
           DBGOTOP()
           DBSEEK(XFILIAL()+MCODCLI+MCODDEST)
           IF FOUND()
              MCEP    :=SZO->ZO_CEP
              MEND    := ALLTRIM(SZ5->Z5_TPLOG)+ " " + ALLTRIM(SZ5->Z5_LOGR) + " " + ALLTRIM(SZ5->Z5_NLOGR) + " " + ALLTRIM(SZ5->Z5_COMPL) //20060327
              MBAIRRO :=SZO->ZO_BAIRRO
              MMUN    :=SZO->ZO_CIDADE
              MEST    :=SZO->ZO_ESTADO
              MCEP    :=SZO->ZO_CEP
              MFONE1  :=SZO->ZO_FONE
              IF MFONE1<>'  '
                 MFONE:=MFONE1
              ENDIF
           ENDIF
           IF MCEP>='"+MV_PAR03+"' .AND. MCEP<='"+MV_PAR04+"'
              GRAVA_TEMP()
           ENDIF
           DBSELECTAREA("SZN")
           DBSKIP()
           IF SZN->ZN_CODCLI<>MCODCLI
              EXIT
            ENDIF
        ENDDO
     ELSE
        GRAVA_TEMP()
     ENDIF
     DBSELECTAREA(MARQUIVO)
     DBSKIP()
  ENDDO
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION LIMPA
Static FUNCTION LIMPA()
  @ 10,05 clear TO 10,70
  @ 11,05 clear TO 11,70
  @ 12,05 clear TO 12,70
  @ 13,05 clear TO 13,70
  @ 14,05 clear TO 14,70
Return

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION MOSTRA
Static FUNCTION MOSTRA()
   @ 10,05 SAY  'ORIGEM --------------->' +STR(VAL(MV_PAR01),3)+ ' A ' + MV_PAR02
   @ 11,05 SAY  'CEP    --------------->' +MCEPINI+ ' A ' + MV_PAR04
   @ 12,05 SAY  'QUANTIDADE DO MAILING->' + STR(MCONTA,6,0)
   @ 13,05 SAY  'QUANTIDADE CLIENTES--->' + STR(MCONTA1,6,0)
   @ 14,05 SAY  'TOTAL----------------->' + STR((MCONTA1+MCONTA),6,0)
   INKEY(0)
RETURN


// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION GRAVA_TEMP
Static FUNCTION GRAVA_TEMP()
DBSELECTAREA("PFAT060")
                IF MTIPO=='P'
                   MCONTA:=MCONTA+1
                ENDIF
                IF MTIPO=='C'
                  MCONTA1:=MCONTA1+1
                ENDIF
                Reclock("PFAT060",.t.)
                REPLACE CODCLI   WITH  MCODCLI
                REPLACE CODDEST  WITH  MCODDEST
                REPLACE NOME     WITH  MNOMECLI
                IF MNOMEDEST=='    '
                   REPLACE DEST WITH  MCONTATO
                ELSE
                   REPLACE DEST WITH  MNOMEDEST
                ENDIF
                REPLACE V_END      WITH  MEND
                REPLACE BAIRRO   WITH  MBAIRRO
                REPLACE MUN      WITH  MMUN
                REPLACE CEP      WITH  MCEP
                REPLACE EST      WITH  MEST
                REPLACE FONE     WITH  MFONE
                REPLACE ORIGEM   WITH  MORIGEM
                REPLACE TIPO     WITH  MTIPO
                REPLACE CGC      WITH  MCGC
                PFAT060->(MSUnlock())
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION ETIQUETA
Static FUNCTION ETIQUETA()
   SETPRC(0,0)
   LIN:=0
   COL:=1
   LI :=0
   DBSELECTAREA('PFAT060')
   cIndex:=CriaTrab(Nil,.F.)
   cKey:="CEP+NOME+DEST"
   Indregua("PFAT060",cIndex,ckey,,,"Selecionando Registros do Arq")
   COUNT TO MCONTA
   DBGOTOP()
   DO WHILE .NOT. EOF()
      @ LIN+LI,001 SAY NOME
      DBSKIP()
      @ LIN+LI,043 SAY NOME
      DBSKIP()
      @ LIN+LI,087 SAY NOME
      DBSKIP(-2)
      LI:=LI+1

      @ LIN+LI,001 SAY DEST
      DBSKIP()
      @ LIN+LI,043 SAY DEST
      DBSKIP()
      @ LIN+LI,087 SAY DEST
      DBSKIP(-2)
      LI:=LI+1

//20060327 daqui
      @ LIN+LI,001 SAY substr(V_END,1,40)
      DBSKIP()
      @ LIN+LI,043 SAY substr(V_END,1,40)
      DBSKIP()
      @ LIN+LI,087 SAY substr(V_END,1,40)
      DBSKIP(-2)
      LI:=LI+1

      @ LIN+LI,001 SAY substr(V_END,41,40)
      DBSKIP()
      @ LIN+LI,043 SAY substr(V_END,41,40)
      DBSKIP()
      @ LIN+LI,087 SAY substr(V_END,41,40)
      DBSKIP(-2)
      LI:=LI+1

      @ LIN+LI,001 SAY substr(V_END,81,40)
      DBSKIP()
      @ LIN+LI,043 SAY substr(V_END,81,40)
      DBSKIP()
      @ LIN+LI,087 SAY substr(V_END,81,40)
      DBSKIP(-2)
      LI:=LI+1
//20060327 ate aqui

      @ LIN+LI,001 SAY BAIRRO+'          '+'('+NUMPED+')'
      DBSKIP()
      @ LIN+LI,043 SAY BAIRRO+'          '+'('+NUMPED+')'
      DBSKIP()
      @ LIN+LI,087 SAY BAIRRO+'          '+'('+NUMPED+')'
      DBSKIP(-2)
      LI:=LI+1

      @ LIN+LI,001 SAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
      DBSKIP()
      @ LIN+LI,043 SAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
      DBSKIP()
      @ LIN+LI,087 SAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
      LI:=LI+1
      DBSKIP()
          
  	  @ LIN+LI,001 PSAY "." //20060327
	  LI:=LI+1          //20060327
	
      LI:=2                          
      setprc(0,0)
      lin:=prow()
      IncRegua()
   ENDDO
   @ LIN+LI  ,001 SAY '****************************************'
   @ LIN+LI+1,001 SAY 'TOTAL...................:'+STR(MCONTA,7)
   @ LIN+LI+2,001 SAY '****************************************'

   SET DEVI TO SCREEN
   IF aRETURN[5] == 1
     Set Printer to
     dbcommitAll()
     ourspool(WNREL)
   ENDIF
   MS_FLUSH()
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION RELATORIO
Static FUNCTION RELATORIO()
  DBSELECTAREA('PFAT060')
  cIndex:=CriaTrab(Nil,.F.)
  cKey:="CEP+NOME+DEST"
  Indregua("PFAT060",cIndex,ckey,,,"Selecionando Registros do Arq")
  SETREGUA(RECCOUNT())
  DBGOTOP()
  DO WHILE .NOT. EOF()
     IncRegua()
     IMPR3()
     IMPR2()
     DBSELECTAREA('PFAT060')
     @ L,01   SAY 'COD CLI...: '+CODCLI
     @ L,27   SAY 'COD DEST..: '+CODDEST
     @ L,50   SAY 'FONE....:'   +TRIM(FONE)
     @ L+1,01 SAY 'NOME......: '+NOME
     @ L+1,50 SAY 'CPF/CGC.:'   +TRIM(CGC)
     @ L+2,01 SAY 'DEST......: '+DEST
     @ L+3,01 SAY 'ENDERECO..: '+V_END
     @ L+4,01 SAY 'BAIRRO..:'   +BAIRRO
     @ L+4,50 SAY 'CIDADE/EST: '+TRIM(MUN)+' '+EST
     @ L+5,01 SAY 'CEP.......: '+SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)
     @ L+6,01 SAY REPLICATE('_',79)
     L:=L+7
     IF EOF()
        EXIT
     ELSE
        DBSKIP()
     ENDIF
  ENDDO
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

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION IMPR3
Static FUNCTION IMPR3()
   IF L<>0
      IF L==65 .OR. L+7>65
         L:=0
      ELSE
         L:=L+1
      ENDIF
   ENDIF
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION IMPR2
Static FUNCTION IMPR2()
  IF L==0
     L:=L+1
     CABEC(Titulo,cCabec1,cCabec2,cPrograma,tamanho,nCaracter)
     L:=4
     @ L,00 SAY REPLICATE('*',79)
     L:=L+2
  ENDIF
RETURN
