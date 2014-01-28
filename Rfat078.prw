#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
    #DEFINE PSAY SAY
#ENDIF

User Function Rfat078()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CDESC1")
SetPrvt("CDESC2,CDESC3,CTITULO,CCABEC1,CCABEC2,CPROGRAMA")
SetPrvt("CTAMANHO,LIMITE,NCARACTER,NLASTKEY,M_PAG,NLIN")
SetPrvt("MSUBT,MCODCLI,MTOT,_LVEND,ARETURN,WNREL")
SetPrvt("CSTRING,_ACAMPOS,_CNOME,CINDEX,CKEY,LCLIENTE")
SetPrvt("_NVLRUNIT,_NVLRBRT,_NVLRLIQ,_CARQPATH,_CARQ,")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     #DEFINE PSAY SAY
#ENDIF
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: RSZS02    쿌utor: Mauricio Mendes        � Data:   31/08/01 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri눯o: Relacao de Avs Programadas para o Departamento de Publicida� 굇
굇�           de solicitado pela usuaria Sra. Cida                       � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo Faturamento                                         � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
/*cSavTela   := SaveScreen( 0, 0,24,80)
cSavCursor := SetCursor()
cSavCor    := SetColor()
cSavAlias  := Select()  
*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Vari쟶eis utilizadas para parametros     �
//� mv_par01             //Data de     ?     �
//� mv_par02             //Data ate    ?     �
//� mv_par03             //Arquivo     ?     �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
CPERG:='RSZS02'
IF .NOT. PERGUNTE(CPERG)
   RETURN
ENDIF

CDESC1   := PADC("Este programa gera Planilha de AV's",70)
CDESC2   := PADC("arquivo SZS(Av's Programadas)",70)
CDESC3   := " "
cTitulo  := "Relatorio por data de  : "+DTOC(MV_PAR01)+" A "+DTOC(MV_PAR02)
cCabec1  := "*COD.CLI NOME                 ENDERECO                                  BAIRRO                MUN.                  UF   CEP       *"
cCabec2  := "*REVISTA        DESCRICAO PRODUTO                          INICIO    TERMINO   AV/ITEM                        VALOR                *"
//           1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                    10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220
cPrograma:= "RSZS02"
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
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Recupera o desenho padrao de atualizacoes�
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
ScreenDraw("SMT050", 3, 0, 0, 0)
SetCursor(1)
SetColor("B/BG")

aRETURN:={"Especial", 1,"Administracao", 1, 2, 1," ",1 }

WNREL    := MV_PAR03
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

_aCampos := {}
aAdd(_aCampos,{"CLIENTE"   ,"C",06,0})
aAdd(_aCampos,{"LOJA_CLI"  ,"C",02,0})
aAdd(_aCampos,{"DESC_CLI"  ,"C",45,0})
aAdd(_aCampos,{"PRODUTO"   ,"C",15,0})
aAdd(_aCampos,{"DESCRICAO" ,"C",30,0})
aAdd(_aCampos,{"AV"        ,"C",06,0})
aAdd(_aCampos,{"ITEMAV"    ,"C",02,0})
aAdd(_aCampos,{"VLR_UNIT"  ,"N",18,2})
aAdd(_aCampos,{"VLR_BRT"   ,"N",18,2})
aAdd(_aCampos,{"VLR_LIQ"   ,"N",18,2})
aAdd(_aCampos,{"CIRCULACAO","D",08,0})
aAdd(_aCampos,{"TIPO_TRANS","C",02,0})
aAdd(_aCampos,{"SECAO"     ,"C",04,0})
aAdd(_aCampos,{"VENDEDOR"  ,"C",06,0})
aAdd(_aCampos,{"ATIVO"     ,"C",02,0})

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"TRB",.F.,.F.)


DBSELECTAREA("SZS")

CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="ZS_FILIAL+DTOS(ZS_DTCIRC)"
INDREGUA("SZS",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ SZS")
dbgotop()


lCliente := .t.

dbSelectArea("SZS")
dbGotop()
dbSeek(xFilial("SZS")+DTOS(MV_PAR01),.T.)


SetRegua(3000)

While  !Eof()  .AND. DTOS(SZS->ZS_DTCIRC) <= DTOS(MV_PAR02)
   IncRegua()

   If SZS->ZS_CODPROD < '0301000        '
      dbSelectArea("SZS")
      dbSkip()
      Loop
   Endif

   If SZS->ZS_SITUAC<>'AA'
      dbSelectArea("SZS")
      dbSkip()
      Loop
   Endif

   If  SZS->ZS_CODPROD > '0305999'
       If !(SZS->ZS_CODPROD >= '0320000        ' .and.  SZS->ZS_CODPROD <= '0320999        ')
          dbSelectArea("SZS")
          dbSkip()
          Loop
       Endif
   Endif

   dbSelectArea("SC5")
   dbSetOrder(1)
   dbSeek(xFilial("SC5")+SZS->ZS_NUMAV)

   dbSelectArea("SA1")
   dbSetOrder(1)
   dbSeek(xFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI)

   dbSelectArea("SC6")
   dbSetOrder(1)
   dbSeek(xFilial("SC6")+SZS->ZS_NUMAV+SZS->ZS_ITEM)

   dbSelectArea("SB1")
   dbSetOrder(1)
   dbSeek(xFilial("SB1")+SC6->C6_PRODUTO)

   _nVlrUnit    :=  SC6->C6_PRCVEN
   _nVlrBrt     :=  SC6->C6_PRCVEN
   _nVlrLiq     :=  Iif(SC5->C5_TPTRANS $ '05 / 04 / 13 / 12 ',SC6->C6_PRCVEN*0.80,SC6->C6_PRCVEN)

   dbSelectArea("TRB")
   RecLock("TRB",.T.)
     TRB->CLIENTE       :=  SC5->C5_CLIENTE
     TRB->LOJA_CLI      :=  SC5->C5_LOJACLI
     TRB->VENDEDOR      :=  SC5->C5_VEND1
     TRB->TIPO_TRANS    :=  SC5->C5_TPTRANS
     TRB->DESC_CLI      :=  SA1->A1_NOME
     TRB->PRODUTO       :=  SB1->B1_COD
     TRB->DESCRICAO     :=  SB1->B1_DESC
     TRB->AV            :=  SZS->ZS_NUMAV
     TRB->ITEMAV        :=  SZS->ZS_ITEM
     TRB->CIRCULACAO    :=  SZS->ZS_DTCIRC
     TRB->ATIVO         :=  SZS->ZS_SITUAC
     TRB->VLR_UNIT      :=  _nVlrUnit
     TRB->VLR_BRT       :=  _nVlrBrt
     TRB->VLR_LIQ       :=  _nVlrLiq
     TRB->SECAO         :=  SC6->C6_CODTIT
   TRB->(MsUnlock())

   dbSelectArea("SZS")
   dbSkip()
ENDDO


_cArqPath  :=GetMv("MV_PATHTMP")
_cArq      :=_cArqPath+Alltrim(MV_PAR03)+".XLS"


dbSelectArea("TRB")
Copy to &(_cArq) VIA "DBFCDXADS" // 20121106 
dbCloseArea()
Alert("Copiar o Arquivo "+_cArq)

@ 000,010 PSAY "Copiar o Arquivo "+_cArq

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
