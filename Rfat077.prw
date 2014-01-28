#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
    #DEFINE PSAY SAY
#ENDIF
//Danilo C S Pala 20060323: dados de enderecamento do DNE
User Function Rfat077()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CDESC1")
SetPrvt("CDESC2,CDESC3,CTITULO,CCABEC1,CCABEC2,CPROGRAMA")
SetPrvt("CTAMANHO,LIMITE,NCARACTER,NLASTKEY,M_PAG,NLIN")
SetPrvt("MSUBT,MCODCLI,MTOT,_LVEND,ARETURN,WNREL")
SetPrvt("CSTRING,_CFILTRO,CINDEX,CKEY,LCLIENTE,LVENDEDOR")
SetPrvt("CCHAVE,NEDIINI,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     #DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RSZS01    ³Autor: Mauricio Mendes        ³ Data:   05/07/01 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de Vendedores para o Departamento de Trafego     ³ ±±
±±³Descri‡Æo: Solicitado pela usuaria Sra. Cida                          ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo Faturamento                                         ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //Vendedor de ?     ³
//³ mv_par02             //Vendedor Ate?     ³
//³ mv_par03             //Av de       ?     ³
//³ mv_par04             //Av Ate      ?     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG:='RSZS01'
IF .NOT. PERGUNTE(CPERG)
   RETURN
ENDIF

CDESC1   := PADC("Este programa gera Relatorio de Vendedores com base no",70)
CDESC2   := PADC("arquivo SZS(Av's Programadas)",70)
CDESC3   := " "
cTitulo  := "Relatorio de Clientes por Vendedor : "+MV_PAR01+" A "+MV_PAR02+" Av's : "+MV_PAR03+" A "+MV_PAR04
cCabec1  := "*COD.CLI NOME                 ENDERECO                                                                                             *"
cCabec2  := "*REVISTA        DESCRICAO PRODUTO                          INICIO    TERMINO   AV/ITEM                        VALOR                *"
//           1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                    10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
cPrograma:= "RSZS01"
cTamanho := "M"
LIMITE   := 132
nCaracter:= 10
NLASTKEY := 0
M_PAG    := 1
NLIN     := 80
MSUBT    := 0
MCODCLI  := '%asSAS'
MTOT     := 0
_lVend   := .F.
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aRETURN:={"Especial", 1,"Administracao", 1, 2, 1," ",1 }
MHORA := TIME()
WNREL    :="RSZS01_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING  :="SZS"
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


DBSELECTAREA("SZS")

_cFiltro := "ZS_FILIAL == '"+xFilial("SZS")+"'"
_cFiltro := _cFiltro+".and.ZS_VEND >= '"+MV_PAR01+"'"
_cFiltro := _cFiltro+".and.ZS_VEND <= '"+MV_PAR02+"'"
_cFiltro := _cFiltro+".and.ZS_NUMAV>= '"+MV_PAR03+"'"
_cFiltro := _cFiltro+".and.ZS_NUMAV<= '"+MV_PAR04+"'"


CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="ZS_FILIAL+ZS_CODCLI+ZS_NUMAV+ZS_ITEM+STRZERO(ZS_EDICAO,4)"
INDREGUA("SZS",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ SZS")
            
lCliente := .t.

dbSelectArea("SZS")
dbGotop()

SetRegua(RecCount())
                   
While  !Eof()
   IncRegua()

   lCliente := .t.
   lVendedor:= .t.

   dbSelectArea("SA1")
   dbSetOrder(1)
   dbSeek(xFilial("SA1")+SZS->ZS_CODCLI)

   If !Found()
      lCliente := .f.
   Endif

   dbSelectArea("SB1")
   dbSetOrder(1)
   dbSeek(xFilial("SB1")+SZS->ZS_CODPROD)

   If !Found()
      Alert("Produto nao Cadastrado -> "+SZS->ZS_CODPROD)
      Exit
   Endif

   dbSelectArea("SA3")
   dbSetOrder(1)
   dbSeek(xFilial("SA3")+SZS->ZS_VEND)

   If !Found()
      lVendedor := .f.
   Endif

   IF NLIN > 65
      nlin := Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho,nCaracter)
   ENDIF


   IF MCODCLI <> SZS->ZS_CODCLI
      nLin := nLin + 2
      @ nLin,000 PSAY SZS->ZS_CODCLI
      If !lCliente
          @ nLin,008 PSAY "Cliente nao Cadastrado no Arquivo de AV"
      Else
          @ nLin,008 PSAY SA1->A1_NREDUZ
          @ nLin,030 PSAY substr(ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL),1,100) //20060323
          nLin:=nLin+1
          @ nLin,008 PSAY "BAIRRO: "+ SA1->A1_BAIRRO
          @ nLin,037 PSAY "MUN: "+ SA1->A1_MUN
          @ nLin,063 PSAY "UF: "+ SA1->A1_EST
          @ nLin,070 PSAY "CEP: "+ SA1->A1_CEP
          nLin:=nLin+1
          @ nLin,008 PSAY "CGC: "+SA1->A1_CGC PICTURE "@R 999.999.999/9999-99"
          @ nLin,037 PSAY "FONE: "+SA1->A1_TEL
          @ nLin,063 PSAY "FAX: "+SA1->A1_FAX
          @ nLin,089 PSAY "EMAIL: "+SubStr(SA1->A1_EMAIL,1,30)
      Endif
      MCODCLI   :=  SZS->ZS_CODCLI
      cChave    :=  xFilial("SZS")+SZS->ZS_CODCLI+SZS->ZS_NUMAV+SZS->ZS_ITEM
      nEdiIni   :=  SZS->ZS_EDICAO
      nlin      :=  nlin + 1
   ENDIF


   dbSelectArea("SZS")
   while !eof() .and. cChave == xFilial("SZS")+SZS->ZS_CODCLI+SZS->ZS_NUMAV+SZS->ZS_ITEM
       dbSelectArea("SZS")
       dbSkip()
   enddo

   dbSkip(-1)


   nlin := nlin + 1
   @ nlin,000 PSAY SB1->B1_TITULO                             // Descricao da Reista
   @ nlin,017 PSAY SB1->B1_DESC                               // Descricao do Produto
   @ nlin,060 PSAY StrZero(nEdiIni,4)                         // Edicao Final
   @ nlin,070 PSAY StrZero(SZS->ZS_EDICAO,4)                  // Edicao Inicial
   @ nlin,085 PSAY SZS->ZS_NUMAV+"/"+SZS->ZS_ITEM             // Numero Av/Item
   @ nlin,107 PSAY SZS->ZS_VALOR PICTURE "@E 999,999,999.99"  // Ultimo Valor Pago

   dbSelectArea("SZS")
   DBSKIP()
   cChave    :=  xFilial("SZS")+SZS->ZS_CODCLI+SZS->ZS_NUMAV+SZS->ZS_ITEM
   nEdiIni   :=  SZS->ZS_EDICAO

ENDDO


SET DEVI TO SCREEN

IF aRETURN[5] ==1
   SET PRINTER TO
   DBCOMMITALL()
   OURSPOOL(WNREL)
ENDIF
MS_FLUSH()

DBSELECTAREA("SZS")
RETINDEX("SZS")

RETURN
