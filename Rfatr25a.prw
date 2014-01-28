#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
    #DEFINE PSAY SAY
#ENDIF
//Alterado por Danilo C S Pala em 20041014

User Function Rfatr25a()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

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
SetPrvt("CSTRING,_CFILTRO,CINDEX,CKEY,_ACAMPOS,_CNOME,mhora")
                   

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
//³ mv_par03             //Do Vendedor       ³
//³ mv_par04             //At‚ o Vendedor    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG:='PFIN25'
IF .NOT. PERGUNTE(CPERG)
   RETURN
ENDIF

CDESC1   := PADC("Este programa emite o relatorio por Vendedor, dos titulos",70)
CDESC2   := PADC("em aberto e vencimentos no periodo solicitado - Publicidade",70) 
CDESC3   := " "
cTitulo  := "Duplicatas/Portador - Publicidade" 
cCabec1  := "* Vencimento : "+DTOC(MV_PAR01)+" A "+DTOC(MV_PAR02)+ SPACE(6) +;
            " Vendedor : " +MV_PAR03+ " A " +MV_PAR04+" *"
cCabec2  := " "
cPrograma:= "RFATR25A"
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
CKEY:="E1_FILIAL+E1_NUM+E1_PARCELA+E1_TIPO"
INDREGUA("SE1",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")


// MM
_aCampos := {}
AADD(_aCampos,{"VEND"   ,"C",06,0})
AADD(_aCampos,{"NUM"    ,"C",06,0})
AADD(_aCampos,{"VENCREA","D",08,0})
AADD(_aCampos,{"VALOR"  ,"N",15,2})
AADD(_aCampos,{"NOMCLI" ,"C",20,0})
AADD(_aCampos,{"NUMBCO" ,"C",15,0})
AADD(_aCampos,{"PARCELA","C",01,0})

_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "VEND+NUM+PARCELA"

dbUseArea(.T.,, _cNome,"TRB",.F.,.F.)
dbSelectArea("TRB")
Indregua("TRB",cIndex,ckey,,,"Selecionando Registros do Arq")

dbSelectArea("SE1")
dbGotop()
while !eof()
   If 'CAN' $(SE1->E1_MOTIVO) .OR. 'DEV' $(SE1->E1_MOTIVO) .OR.;
      'CANC' $(SE1->E1_HIST) .OR. !'P' $(E1_PEDIDO)
       dbSkip()
       Loop
   EndIf

   If Alltrim(SE1->E1_PORTADO) == "920" .or. Alltrim(SE1->E1_PORTADO) == "930" .or. Alltrim(SE1->E1_PORTADO) == "904"
       dbSelectArea("SE1")
       dbSkip()
       Loop
   Endif

   If SE1->E1_VEND1 >= MV_PAR03 .AND. SE1->E1_VEND1 <= MV_PAR04 .AND. !EMPTY(SE1->E1_VEND1)
      RecLock("TRB",.T.)
        TRB->VEND     :=  SE1->E1_VEND1
        TRB->NUM      :=  SE1->E1_NUM
        TRB->VENCREA  :=  SE1->E1_VENCREA
        TRB->VALOR    :=  SE1->E1_VALOR
        TRB->NOMCLI   :=  SE1->E1_NOMCLI
        TRB->NUMBCO   :=  SE1->E1_NUMBCO
        TRB->PARCELA  :=  SE1->E1_PARCELA
      MsUnlock()
   Endif
   If SE1->E1_VEND2 >= MV_PAR03 .AND. SE1->E1_VEND2 <= MV_PAR04 .AND. !EMPTY(SE1->E1_VEND2)
      RecLock("TRB",.T.)
        TRB->VEND     :=  SE1->E1_VEND2
        TRB->NUM      :=  SE1->E1_NUM
        TRB->VENCREA  :=  SE1->E1_VENCREA
        TRB->VALOR    :=  SE1->E1_VALOR
        TRB->NOMCLI   :=  SE1->E1_NOMCLI
        TRB->NUMBCO   :=  SE1->E1_NUMBCO
        TRB->PARCELA  :=  SE1->E1_PARCELA
      MsUnlock()
   Endif
   If SE1->E1_VEND3 >= MV_PAR03 .AND. SE1->E1_VEND3 <= MV_PAR04 .AND. !EMPTY(SE1->E1_VEND3)
      RecLock("TRB",.T.)
        TRB->VEND     :=  SE1->E1_VEND3
        TRB->NUM      :=  SE1->E1_NUM
        TRB->VENCREA  :=  SE1->E1_VENCREA
        TRB->VALOR    :=  SE1->E1_VALOR
        TRB->NOMCLI   :=  SE1->E1_NOMCLI
        TRB->NUMBCO   :=  SE1->E1_NUMBCO
        TRB->PARCELA  :=  SE1->E1_PARCELA
      MsUnlock()
   Endif
   If SE1->E1_VEND4 >= MV_PAR03 .AND. SE1->E1_VEND4 <= MV_PAR04 .AND. !EMPTY(SE1->E1_VEND4)
      RecLock("TRB",.T.)
        TRB->VEND     :=  SE1->E1_VEND4
        TRB->NUM      :=  SE1->E1_NUM
        TRB->VENCREA  :=  SE1->E1_VENCREA
        TRB->VALOR    :=  SE1->E1_VALOR
        TRB->NOMCLI   :=  SE1->E1_NOMCLI
        TRB->NUMBCO   :=  SE1->E1_NUMBCO
        TRB->PARCELA  :=  SE1->E1_PARCELA
      MsUnlock()
   Endif
   If SE1->E1_VEND5 >= MV_PAR03 .AND. SE1->E1_VEND5 <= MV_PAR04 .AND. !EMPTY(SE1->E1_VEND5)
      RecLock("TRB",.T.)
        TRB->VEND     :=  SE1->E1_VEND5
        TRB->NUM      :=  SE1->E1_NUM
        TRB->VENCREA  :=  SE1->E1_VENCREA
        TRB->VALOR    :=  SE1->E1_VALOR
        TRB->NOMCLI   :=  SE1->E1_NOMCLI
        TRB->NUMBCO   :=  SE1->E1_NUMBCO
        TRB->PARCELA  :=  SE1->E1_PARCELA
      MsUnlock()
   Endif
   DbSelectArea("SE1")
   DbSKip()
EndDo


dbSelectArea("TRB")
DBGOTOP()
SETREGUA(RECCOUNT())
                   
WHILE  !Eof()
   INCREGUA()
   IF MPORT <> 'ZZZZZ' .AND. MPORT <> TRB->VEND
      nlin := nlin + 2
      @ nlin,00 PSAY "Total do Portador ...: "
      @ nlin,24 PSAY MSUBT PICTURE "@E 9,999,999.99"
      MSUBT := 0 
      NLIN  := 80
   ENDIF

   IF NLIN > 59
      nlin := Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho,nCaracter)
      nlin := nlin + 2
      @ nlin,00 PSAY "** VENDEDOR: "
      @ nlin,13 PSAY TRB->VEND
//      @ nlin,20 PSAY "VENDEDOR DE : "+MV_PAR03
//      @ nlin,41 PSAY "ATE VENDEDOR: "+MV_PAR04

      nlin := nlin + 2
      @ nlin,00 PSAY "Duplicata   Dt.Vencto    Vl. Duplicata   Cliente                Numero do Banco"          
      nlin := nlin + 1
      @ nlin,00 PSAY "=========   =========    =============   ====================   ==============="          
      nlin := nlin + 1
   ENDIF

   nlin := nlin + 1
   @ nlin,00 PSAY TRB->NUM+' '+TRB->PARCELA
   @ nlin,12 PSAY TRB->VENCREA
   @ nlin,26 PSAY TRB->VALOR PICTURE "@E 999,999.99"
   @ nlin,41 PSAY TRB->NOMCLI
   @ nlin,65 PSAY TRB->NUMBCO

   MSUBT:=MSUBT+TRB->VALOR
   MTOT :=MTOT+TRB->VALOR
   MPORT:=TRB->VEND

   dbSelectArea("TRB")
   DBSKIP()
   INCREGUA()
ENDDO

IF MTOT <> 0 
   nlin := nlin + 2
   @ nlin,00 PSAY "Total do Vendedor ...: "
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
dbSelectArea("TRB")
dbCloseArea()
ferase(_cNome+".dbf")
ferase(cIndex+OrdBagExt())

RETURN
