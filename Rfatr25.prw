#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
    #DEFINE PSAY SAY
#ENDIF

User Function Rfatr25()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CDESC1")
SetPrvt("CDESC2,CDESC3,CTITULO,CCABEC1,CCABEC2,CPROGRAMA")
SetPrvt("CTAMANHO,LIMITE,NCARACTER,NLASTKEY,M_PAG,NLIN")
SetPrvt("MSUBT,MPORT,MTOT,_LVEND,ARETURN,WNREL")
SetPrvt("CSTRING,_CFILTRO,CINDEX,CKEY,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     #DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATR25   ³Autor: Rosane Lacava Rodrigues³ Data:   18/02/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de Duplicatas a Receber - Publicidade            ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Financeiro                                       ³ ±±
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
//³ mv_par01             //Periodo Inicial   ³
//³ mv_par02             //Periodo Final     ³
//³ mv_par03             //Do Portador       ³
//³ mv_par04             //At‚ o Portador    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG:='PFIN07'
IF .NOT. PERGUNTE(CPERG)
   RETURN
ENDIF

CDESC1   := PADC("Este programa emite o relatorio por portador, dos titulos",70)
CDESC2   := PADC("em aberto e vencimentos no periodo solicitado - Publicidade",70) 
CDESC3   := " "
cTitulo  := "Duplicatas/Portador - Publicidade" 
cCabec1  := "* Vencimento : "+DTOC(MV_PAR01)+" A "+DTOC(MV_PAR02)+ SPACE(6) +;
            " Portador : " +MV_PAR03+ " A " +MV_PAR04+" *"
cCabec2  := " "
cPrograma:= "RFATR25"
cTamanho := "P"
LIMITE   := 80 
nCaracter:= 16
NLASTKEY := 0
M_PAG    := 1
NLIN     := 80
MSUBT    := 0
MPORT    := 'ZZZZZ'
MTOT     := 0
_lVend   := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ScreenDraw("SMT050", 3, 0, 0, 0)
SetCursor(1)
SetColor("B/BG")

aRETURN:={"Especial", 1,"Administracao", 1, 2, 1," ",1 }
MHORA := TIME()
WNREL    :="RFATR25_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING  :="SE1"
WNREL    :=SETPRINT(CSTRING,WNREL,CPERG,SPACE(18)+cTitulo,CDESC1,CDESC2,CDESC3,.T.)
SETDEFAULT(aRETURN,CSTRING)

IF NLASTKEY==27 .OR. NLASTKEY==65
   RETURN
ENDIF

#IFDEF WINDOWS
       RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        RptStatus({|| Execute(RptDetail)})
       Return
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        Function RptDetail
Static Function RptDetail()
#ENDIF

DBSELECTAREA("SE1")
_cFiltro := "E1_FILIAL == '"+xFilial("SE1")+"'"
_cFiltro := _cFiltro+".and.DTOS(E1_BAIXA)==DTOS(CTOD(' '))"
_cFiltro := _cFiltro+".and.DTOS(E1_VENCREA)>=DTOS(CTOD('"+DTOC(MV_PAR01)+"'))"
_cFiltro := _cFiltro+".and.DTOS(E1_VENCREA)<=DTOS(CTOD('"+DTOC(MV_PAR02)+"'))"

CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="E1_FILIAL+E1_PORTADO+E1_NUM+E1_PARCELA"
INDREGUA("SE1",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")

DBGOTOP()
SETREGUA(RECCOUNT()/5)
DO WHILE .NOT. EOF()  
   INCREGUA()

   If E1_PORTADO < MV_PAR03 .OR. E1_PORTADO > MV_PAR04
       dbSkip()
       Loop
   Endif

   If 'CAN' $(SE1->E1_MOTIVO) .OR. 'DEV' $(SE1->E1_MOTIVO) .OR.;
      'CANC' $(SE1->E1_HIST) .OR. !'P' $(E1_PEDIDO)
       dbSkip()
       Loop
   EndIf

   IF MPORT <> 'ZZZZZ' .AND. MPORT <> SE1->E1_PORTADO
      nlin := nlin + 2
      @ nlin,00 PSAY "Total do Portador ...: "
      @ nlin,24 PSAY MSUBT PICTURE "@E 9,999,999.99"
      MSUBT := 0 
      NLIN  := 80
   ENDIF

   IF NLIN > 59
      nlin := Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho,nCaracter)
      nlin := nlin + 2
      @ nlin,00 PSAY "** PORTADOR: "
      @ nlin,13 PSAY SE1->E1_PORTADO

      nlin := nlin + 2
      @ nlin,00 PSAY "Duplicata   Dt.Vencto    Vl. Duplicata   Cliente                Numero do Banco"          
      nlin := nlin + 1
      @ nlin,00 PSAY "=========   =========    =============   ====================   ==============="          
      nlin := nlin + 1
   ENDIF

   nlin := nlin + 1
   @ nlin,00 PSAY SE1->E1_NUM+' '+SE1->E1_PARCELA
   @ nlin,12 PSAY SE1->E1_VENCREA
   @ nlin,26 PSAY SE1->E1_VALOR PICTURE "@E 999,999.99"
   @ nlin,41 PSAY SE1->E1_NOMCLI
   @ nlin,65 PSAY SE1->E1_NUMBCO

   MSUBT:=MSUBT+SE1->E1_VALOR
   MTOT :=MTOT+SE1->E1_VALOR
   MPORT:=SE1->E1_PORTADO

   DBSKIP()
   INCREGUA()
ENDDO

IF MTOT <> 0 
   nlin := nlin + 2
   @ nlin,00 PSAY "Total do Portador ...: "
   @ nlin,24 PSAY MSUBT PICTURE "@E 9,999,999.99"
   nlin := nlin + 2
   @ nlin,00 PSAY "Total Geral .........: "
   @ nlin,23 PSAY MTOT PICTURE "@E 99,999,999.99"
ELSE
   nlin := nlin + 2
   @ nlin,00 PSAY "NAO HA DADOS A APRESENTAR !"
ENDIF

SET DEVI TO SCREEN

IF aRETURN[5] ==1
   SET PRINTER TO
   DBCOMMITALL()
   OURSPOOL(WNREL)
ENDIF
MS_FLUSH()

DBSELECTAREA("SE1")
RETINDEX("SE1")
RETURN
