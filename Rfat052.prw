#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
  #DEFINE PSAY SAY
#ENDIF

User Function Rfat052()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CPERG,CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO")
SetPrvt("ARETURN,NOMEPROG,LIMITE,ALINHA,NLASTKEY,NLIN")
SetPrvt("TITULO,CCABEC1,CCABEC2,CCANCEL,M_PAG,WNREL")
SetPrvt("_ACAMPOS,_CNOME,CKEY,CINDEX,MPEDIDO,MNOMEC")
SetPrvt("MNOMEA,MAG,MVALOR,TVALOR,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>   #DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATR06   ³Autor: Rosane Rodrigues       ³ Data:   14/01/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: RELATORIO DE DUPLICATAS POR AGENCIA                        ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento de Publicidade                       ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³   Parametros Utilizados                   ³
//³   mv_par01 = Cod.Agencia Inicial          ³
//³   mv_par02 = Cod.Agencia Final            ³
//³   mv_par03 = Do Vencto                    ³
//³   mv_par04 = At‚ o Vencto                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cPerg    := "PFAT56"
IF .NOT. PERGUNTE(CPERG)
   RETURN
ENDIF
cString  := "SE1"
cDesc1   := PADC("Este programa emite o relat¢rio das duplicatas por agencia",70)
cDesc2   := PADC("com vencimento no periodo solicitado",70)
cDesc3   := " "
tamanho  := "M"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFATR06"
limite   := 80
aLinha   := { }
nLastKey := 0
nLin     := 80
titulo   := "Duplicatas por Agencia"
cCabec1  := "Per¡odo de Vencimento : " + DTOC(MV_PAR03) + ' A ' + DTOC(MV_PAR04)
cCabec2  := " " 
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1      //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel    := "RFATR06_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)            //Nome Default do relatorio em Disco
wnrel    := SetPrint(cString,wnrel,cPerg,space(25)+titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

SetDefault(aReturn,cString)

IF NLASTKEY==27 .OR. NLASTKEY==65
   RETURN
ENDIF

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Chama Relatorio                                ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF WINDOWS
   RptStatus({|| RptDetail() })// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>    RptStatus({|| Execute(RptDetail) })
#ELSE
   RptDetail()
#ENDIF
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³RptDetail ³ Autor ³ Ary Medeiros          ³ Data ³ 15.02.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Impressao do corpo do relatorio                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function RptDetail
Static Function RptDetail()

_aCampos := {{"CODAG"  ,"C",6 ,0} ,;
             {"NOMEAG" ,"C",40,0} ,;
             {"CODCLI" ,"C",6 ,0} ,;
             {"NOMECLI","C",40,0} ,;
             {"DUPLIC" ,"C",6 ,0} ,;
             {"PARC"   ,"C",1 ,0} ,;
             {"DTVENC" ,"D",8 ,0} ,;
             {"VALOR"  ,"N",10,2}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"DUPLA",.F.,.F.)
CKEY:="CODAG+DUPLIC+PARC+NOMECLI"
INDREGUA("DUPLA",_cNome,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")

DbSelectArea("SA1")
DbSetOrder(01)


DBSELECTAREA("SE1")
CINDEX   := CriaTrab(NIL,.F.)
cKey     := "E1_FILIAL+DTOS(E1_VENCTO)+E1_PEDIDO"
IndRegua("SE1",CINDEX,cKey,,,"Selecionando registros .. ")
SetRegua(Reccount())

dbSeek( xFilial("SE1")+DTOS(MV_PAR03), .T. )
While !eof() .and. SE1->E1_VENCTO <= MV_PAR04
 
   IncRegua()

   If !"P" $ SE1->E1_PEDIDO
        dbSkip()
        Loop
   EndIf

   MPEDIDO := SE1->E1_PEDIDO
   MNOMEC  := ' '
   MNOMEA  := ' '

   If 'CAN' $(SE1->E1_MOTIVO) .OR. 'DEV' $(SE1->E1_MOTIVO) .OR.;
      'CANC' $(SE1->E1_HIST)
      DBSKIP()
      LOOP
   ENDIF

   DbSelectArea("SC5")
   DBSETORDER(01)
   If dbSeek(xFilial("SC5")+MPEDIDO, .F.)
        
      If SC5->C5_CODAG < MV_PAR01 .or. SC5->C5_CODAG > MV_PAR02
         dbSelectArea("SE1")
         dbSkip()
         Loop
      EndIf

      DbSelectArea("SA1")
      DbSeek(xFilial("SA1")+SC5->C5_CLIENTE)
      MNOMEC := SA1->A1_NOME
      DbSelectArea("SA1")
      DbSeek(xFilial("SA1")+SC5->C5_CODAG)
      MNOMEA := SA1->A1_NOME
      DBSELECTAREA("DUPLA")
      RECLOCK("DUPLA",.T.)
      DUPLA->CODAG   := SC5->C5_CODAG
      DUPLA->NOMEAG  := MNOMEA
      DUPLA->CODCLI  := SC5->C5_CLIENTE
      DUPLA->NOMECLI := MNOMEC      
      DUPLA->DUPLIC  := SE1->E1_NUM
      DUPLA->PARC    := SE1->E1_PARCELA
      DUPLA->DTVENC  := SE1->E1_VENCTO
      DUPLA->VALOR   := SE1->E1_VALOR
      DUPLA->(MSUNLOCK())
   ENDIF
   DbSelectArea("SE1")
   DbSkip()
   IncRegua()
Enddo

MAG    := 'ZZZZZZ'
MVALOR := 0
TVALOR := 0

DBSELECTAREA("DUPLA")
DBSETORDER(01)
DBGOTOP()
DO WHILE .NOT. EOF()
   IF MAG <> 'ZZZZZZ' .AND. MAG <> DUPLA->CODAG
      nLin    := nLin + 2
      @ nlin,00 PSAY "Total ..................................................................: " 
      @ nlin,76 PSAY mvalor PICTURE "@E 99,999,999.99"
      MVALOR  := 0
      nLin    := 80
   ENDIF
   if nLin > 60 
      nLin     := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18) //IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho
      nLin     := nLin + 2
      @ nlin,00 PSAY "C¢digo Agˆncia: " + DUPLA->CODAG + ' ' + DUPLA->NOMEAG
      nLin     := nLin + 2
      @ nlin,00 PSAY "Cliente   Nome do Cliente                            N.Fiscal   Dt.Vencto   Valor"
      nLin     := nLin + 1
      @ nlin,00 PSAY "-------   ----------------------------------------   ------ -   ---------   ------------"
      nLin     := nLin + 1
   Endif
   nLin := nLin + 1
   @ nlin,00 PSAY DUPLA->CODCLI
   @ nlin,10 PSAY DUPLA->NOMECLI
   @ nlin,53 PSAY DUPLA->DUPLIC
   @ nlin,60 PSAY DUPLA->PARC  
   @ nlin,65 PSAY DUPLA->DTVENC
   @ nlin,76 PSAY DUPLA->VALOR PICTURE "@E 99,999,999.99"
   nLin   := nLin + 1
   MAG    := DUPLA->CODAG
   MVALOR := MVALOR + DUPLA->VALOR
   TVALOR := TVALOR + DUPLA->VALOR
   DBSKIP()
ENDDO

IF RECCOUNT() == 0
   Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18)
   @ 15, 00 PSAY "NAO HA DADOS A APRESENTAR !!! "
ENDIF

IF TVALOR > 0
   nLin    := nLin + 2
   @ nlin,00 PSAY   "Total ..................................................................: " 
   @ nlin,76 PSAY mvalor PICTURE "@E 99,999,999.99"
   nLin := nLin + 3
   @ nlin+1,00 PSAY "Total Geral ............................................................: "
   @ nlin+1,76 PSAY TVALOR PICTURE "@E 99,999,999.99"
ENDIF

DBSELECTAREA("DUPLA")
DBCLOSEAREA()
fErase(_cNome+".DBF")
fErase(_cNome+OrdBagExt())


DbSelectarea("SE1")
RetIndex("SE1")
// Apaga Indice SE1
fErase(cIndex+OrdBagExt())

DbSelectarea("SA1")
RetIndex("SA1")
DbSelectarea("SC5")
RetIndex("SC5")

Set Filter To
Set Device to Screen
If aReturn[5] == 1
        Set Printer To
        Commit
        ourspool(wnrel) //Chamada do Spool de Impressao
Endif
MS_FLUSH() //Libera fila de relatorios em spool
Return
