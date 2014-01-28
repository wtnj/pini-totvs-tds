#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
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
User Function Rfat070()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CDESC1")
SetPrvt("CDESC2,CDESC3,CTITULO,CCABEC1,CCABEC2,CPROGRAMA")
SetPrvt("CTAMANHO,LIMITE,NCARACTER,NLASTKEY,M_PAG,NLIN")
SetPrvt("MSUBT,MPORT,MTOT,_LVEND,ARETURN,WNREL")
SetPrvt("CSTRING,_CFILTRO,CINDEX,CKEY,mhora")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //Periodo Inicial   ³
//³ mv_par02             //Periodo Final     ³
//³ mv_par03             //Do Portador       ³
//³ mv_par04             //At‚ o Portador    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG := 'PFIN07'
IF !PERGUNTE(CPERG)
   RETURN
ENDIF

CDESC1    := PADC("Este programa emite o relatorio por portador, dos titulos",70)
CDESC2    := PADC("em aberto e vencimentos no periodo solicitado - Publicidade",70) 
CDESC3    := " "
cTitulo   := Padc("Duplicatas/Portador - Publicidade" ,74)
cCabec1   := "* Vencimento : "+DTOC(MV_PAR01)+" A "+DTOC(MV_PAR02)+ SPACE(6) +;
             " Portador : " +MV_PAR03+ " A " +MV_PAR04+" *"
cCabec2   := " "
cPrograma := "RFATR25"
cTamanho  := "P"
LIMITE    := 80 
nCaracter := 16
NLASTKEY  := 0
M_PAG     := 1
NLIN      := 80
MSUBT     := 0
MPORT     := 'ZZZZZ'
MTOT      := 0
_lVend    := .F.

aRETURN   := {"Especial", 1,"Administracao", 1, 2, 1," ",1 }
MHORA := TIME()
WNREL     :="RFATR25_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING   :="SE1"
WNREL     :=SETPRINT(CSTRING,WNREL,CPERG,cTitulo,CDESC1,CDESC2,CDESC3,.F.)
SETDEFAULT(aRETURN,CSTRING)

IF NLASTKEY==27 .OR. NLASTKEY==65
   RETURN
ENDIF

Processa({|| RptDetail()})

Return

Static Function RptDetail()

DBSELECTAREA("SE1")
//_cFiltro := "E1_FILIAL == '"+xFilial("SE1")+"'"
//_cFiltro := _cFiltro+".and.DTOS(E1_BAIXA)==DTOS(CTOD(' '))"
//_cFiltro := _cFiltro+".and.DTOS(E1_VENCREA)>=DTOS(CTOD('"+DTOC(MV_PAR01)+"'))"
//_cFiltro := _cFiltro+".and.DTOS(E1_VENCREA)<=DTOS(CTOD('"+DTOC(MV_PAR02)+"'))"
CINDEX   := CRIATRAB(NIL,.F.)
CKEY     := "E1_FILIAL+E1_PORTADO+DTOS(E1_VENCREA)+DTOS(E1_BAIXA)+E1_PREFIXO+E1_NUM+E1_PARCELA"
MsAguarde({|| INDREGUA("SE1",CINDEX,CKEY,,,"")},"Aguarde","Criando Indice Temporario...")

DbSeek(xFilial("SE1")+MV_PAR03+DTOS(MV_PAR01)+Space(8),.t.)

nlin := Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho,nCaracter)
nlin += 2
@ nlin,00 PSAY "** PORTADOR: "
@ nlin,13 PSAY SE1->E1_PORTADO
nlin += 2
@ nlin,00 PSAY "Duplicata   Dt.Vencto    Vl. Duplicata   Cliente                Numero do Banco"          
nlin++
@ nlin,00 PSAY "=========   =========    =============   ====================   ==============="          
nlin++

PROCREGUA(RECCOUNT())

WHILE !EOF() .and. SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_PORTADO >= MV_PAR03 .and. SE1->E1_PORTADO <= MV_PAR04
  
   If SE1->E1_PORTADO < MV_PAR03 .OR. SE1->E1_PORTADO > MV_PAR04 .or. ;
   		!Empty(SE1->E1_BAIXA) .or. DTOS(SE1->E1_VENCREA) < DTOS(MV_PAR01) .or. ;
   		DTOS(SE1->E1_VENCREA) > DTOS(MV_PAR02)
       INCPROC("Desprezando Portador/Titulo : "+SE1->E1_PORTADO+"/"+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)   
       dbSkip()
       Loop
   Endif

   If 'CAN' $(SE1->E1_MOTIVO) .OR. 'DEV' $(SE1->E1_MOTIVO) .OR.;
      'CANC' $(SE1->E1_HIST) .OR. !'P' $(SE1->E1_PEDIDO)
       INCPROC("Desprezando Portador/Titulo : "+SE1->E1_PORTADO+"/"+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)   
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

   IF NLIN >= 55
      Roda(0,"",cTamanho)
      nlin := Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho,nCaracter)
      nlin += 2
      @ nlin,00 PSAY "** PORTADOR: "
      @ nlin,13 PSAY SE1->E1_PORTADO
      nlin += 2
      @ nlin,00 PSAY "Duplicata   Dt.Vencto    Vl. Duplicata   Cliente                Numero do Banco"          
      nlin++
      @ nlin,00 PSAY "=========   =========    =============   ====================   ==============="          
      nlin++
   ENDIF

   nlin++
   @ nlin,00 PSAY SE1->E1_NUM+' '+SE1->E1_PARCELA
   @ nlin,12 PSAY SE1->E1_VENCREA
   @ nlin,26 PSAY SE1->E1_VALOR PICTURE "@E 999,999.99"
   @ nlin,41 PSAY SE1->E1_NOMCLI
   @ nlin,65 PSAY SE1->E1_NUMBCO
   
   INCPROC("Considerando Portador/Titulo: "+SE1->E1_PORTADO+"/"+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)   
   
   MSUBT += SE1->E1_VALOR
   MTOT  += SE1->E1_VALOR
   MPORT := SE1->E1_PORTADO

   DbSelectArea("SE1")
   DBSKIP()
END

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

Roda(0,"",ctamanho)


SET DEVICE TO SCREEN

IF aRETURN[5] ==1
   SET PRINTER TO
   DBCOMMITALL()
   OURSPOOL(WNREL)
ENDIF

MS_FLUSH()

DBSELECTAREA("SE1")
RETINDEX("SE1")

RETURN