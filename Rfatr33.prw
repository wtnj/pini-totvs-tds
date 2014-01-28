#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Rfatr33()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("M_PAG,TAMANHO,LIMITE,TITULO,CDESC1,CDESC2")
SetPrvt("CDESC3,ARETURN,NOMEPROG,CPERG,NLASTKEY,WNREL")
SetPrvt("CSTRING,CCABEC1,CCABEC2,_ACAMPOS,_CNOME,_CIND")
SetPrvt("_CKEY,_CFILTRO,_MTIPO,NLIN,_MTP,_TOTALASS,mhora")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATR33   ³Autor: Rosane Rodrigues       ³ Data:   17/05/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Relat¢rio de Assinantes por Produto                        ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Especifico PINI                                            ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³   Parametros Utilizados                   ³
//³   mv_par01 = Produto  Inicial             ³
//³   mv_par02 = Produto  Final               ³
//³   mv_par03 = Data Inicial                 ³
//³   mv_par04 = Data Final                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
M_PAG    := 1
tamanho  := "P"
limite   := 80
titulo   := PADC("ASSINANTES POR PRODUTO",30)
cDesc1   := PADC("Este programa ira emitir o relat¢rio dos assinantes por produto",70)
cDesc2   := " "
cDesc3   := " "

aReturn  := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
nomeprog := "rfatr33"

cPerg    := "FAT018"
If !Pergunte(CPERG)
   Return
EndIf
nLastKey := 0
MHORA := TIME()
wnrel    := "RFATR33_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

CSTRING  := "SC6"
cCabec1  := "Produto : " + SUBSTR(MV_PAR01,1,8) + " A " + SUBSTR(MV_PAR02,1,8) + SPACE(04) +;
            "Per¡odo da Compra : " + DTOC(MV_PAR03) + " A " + DTOC(MV_PAR04)
cCabec2  := " "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,wnrel,cPerg,SPACE(18)+Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
   Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica Posicao do Formulario na Impressora                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Prepara regua de impressÆo                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_aCampos := {{"CODCLI" ,"C",6, 0},;
             {"NOME"   ,"C",40,0},;
             {"END"    ,"C",40,0},;
             {"BAIRRO" ,"C",20,0},;
             {"CEP"    ,"C",8, 0},;
             {"MUN"    ,"C",20,0},;
             {"EST"    ,"C",2, 0},;
             {"TEL"    ,"C",20,0},;
             {"FAX"    ,"C",15,0},;
             {"EMAIL"  ,"C",20,0},;
             {"PEDIDO" ,"C",6, 0},;
             {"DTCOMP" ,"D",8, 0},;
             {"PRODUTO","C",30,0},;
             {"QTDE"   ,"N",3, 0},;
             {"VALOR"  ,"N",10,2},;
             {"CODREPR","C",6 ,0},;
             {"NOMEREP","C",40,0},;
             {"TIPO"   ,"C",1, 0}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"RELASS",.F.,.F.)

dbSelectArea("SC6")
_cInd   := CriaTrab(NIL,.F.)
_cKey   := "C6_FILIAL+C6_PRODUTO+C6_NUM+DTOS(C6_DATA)"
_cFiltro := "C6_FILIAL == '"+xFilial("SC6")+"'"
_cFiltro := _cFiltro+".and.DTOS(C6_DATA)>=DTOS(CTOD('"+DTOC(MV_PAR03)+"'))"
_cFiltro := _cFiltro+".and.DTOS(C6_DATA)<=DTOS(CTOD('"+DTOC(MV_PAR04)+"'))"
IndRegua("SC6",_cInd,_cKey,,_cFiltro,"Selecionando registros .. ")

SetRegua(Reccount()/7)
dbSeek(xFilial("SC6")+MV_PAR01,.T.)

While !eof() .and. sc6->c6_produto <= mv_par02
    IncRegua()
    _mTipo  := "V"

    DbSelectArea("SC5")
    DbSetOrder(01)
    DbSeek(xFilial("SC5")+SC6->C6_NUM)
    if Found()
       If SC6->C6_SERIE == 'LIV' .OR. SC6->C6_SERIE == 'CP0'
          _mTipo := "E"
       Endif

       DbSelectArea("SF4")
       DbSetOrder(01)
       DbSeek(XFILIAL("SF4")+SC6->C6_TES)
       If "CORTESIA" $(F4_TEXTO) .OR. "DOACAO" $(F4_TEXTO)
          _mTipo := "D"
       Endif

       dbSelectArea("SA1")
       dbSetOrder(1)
       dbSeek(xFilial("SA1")+SC6->C6_CLI)

       dbSelectArea("SA3")
       dbSetOrder(1)
       dbSeek(xFilial("SA3")+SC5->C5_VEND1)

       dbSelectArea("RELASS")
       Reclock("RELASS",.t.)
       RELASS->CODCLI  :=  SC6->C6_CLI
       RELASS->NOME    :=  SA1->A1_NOME
       RELASS->END     :=  SA1->A1_END
       RELASS->BAIRRO  :=  SA1->A1_BAIRRO
       RELASS->CEP     :=  SA1->A1_CEP
       RELASS->MUN     :=  SA1->A1_MUN
       RELASS->EST     :=  SA1->A1_EST
       RELASS->TEL     :=  SA1->A1_TEL
       RELASS->FAX     :=  SA1->A1_FAX
       RELASS->EMAIL   :=  SA1->A1_EMAIL
       RELASS->PEDIDO  :=  SC6->C6_NUM
       RELASS->DTCOMP  :=  SC6->C6_DATA
       RELASS->PRODUTO :=  SC6->C6_DESCRI
       RELASS->QTDE    :=  SC6->C6_QTDVEN
       RELASS->VALOR   :=  SC6->C6_VALOR
       RELASS->CODREPR :=  SC5->C5_VEND1
       RELASS->NOMEREP :=  SA3->A3_NOME
       RELASS->TIPO    :=  _mTipo
       msUnlock()
    Endif
    DbSelectArea("SC6")
    DbSkip()
End

nLin   := 80
_mtp   := " "
_mtipo := " "

DbSelectArea("RELASS")
_cInd   := CriaTrab(NIL,.F.)
_cKey   := "PRODUTO+TIPO+CEP"
IndRegua("RELASS",_cInd,_cKey,,,"Selecionando registros .. ")

_TotalAss:=0

While !eof()

    _mtipo := RELASS->TIPO
    _TotalAss:=_TotalAss+1

    if nLin > 58 .or. _mtipo <> _mtp
       nLin     := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18) //IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho
       nLin     := nLin + 2
       If _mtipo == 'D'
          @ nLin,30 SAY "Doa‡Æo / Cortesia"
          nLin     := nLin + 1
          @ nLin,30 SAY "================="
       Else
          If _mtipo == 'E'
             If SM0->M0_CODIGO == '02'
                @ nLin,34 SAY "S‚rie CP0"
                nLin     := nLin + 1
                @ nLin,34 SAY "========="
             Else
                @ nLin,34 SAY "S‚rie LIV"
                nLin     := nLin + 1
                @ nLin,34 SAY "========="
             Endif
          Else
             @ nLin,35 SAY "Vendas"
             nLin     := nLin + 1
             @ nLin,35 SAY "======"
          Endif
       Endif
       nLin     := nLin + 3
    Endif

    @ nLin,000 SAY "Codcli ..: " + RELASS->CODCLI + SPACE(05) + RELASS->NOME
    nLin     := nLin + 1
    @ nlin,000 SAY "Endere‡o : " + RELASS->END
    nLin     := nLin + 1
    @ nLin,000 SAY "Bairro ..: " + RELASS->BAIRRO
    nLin     := nLin + 1
    @ nlin,000 SAY "Cep .....: " + SUBSTR(RELASS->CEP,1,5) + "-" + SUBSTR(RELASS->CEP,6,3);
    + SPACE(05) + "Cidade : " + RELASS->MUN + SPACE(05) + "Estado : " + RELASS->EST
    nLin     := nLin + 1
    @ nLin,000 SAY "Telefone : " + RELASS->TEL + SPACE(05) + "Fax : " + RELASS->FAX
    nLin     := nLin + 1
    @ nLin,000 SAY "Email ...: " + RELASS->EMAIL
    nLin     := nLin + 1
    @ nlin,000 SAY "Pedido ..: " + RELASS->PEDIDO + SPACE(05) + "Dt. Compra : " + DTOC(RELASS->DTCOMP)
    nLin     := nLin + 1
    @ nLin,000 SAY "Qtde ....: " + STR(RELASS->QTDE,3) + SPACE(05) + "Valor : " + STR(RELASS->VALOR,10,2)
    nLin     := nLin + 1
    @ nlin,000 SAY "Vendedor : " + RELASS->CODREPR + SPACE(05) + RELASS->NOMEREP
    nLin     := nLin + 1
    @ nLin,000 SAY "Produto  : " + RELASS->PRODUTO
    nLin     := nLin + 4
    _mtp := RELASS->TIPO
    DbSkip()
End
    @ nlin+2,000 say 'Total de Assinantes....' +str(_TotalAss,5,0)

DbCloseArea()

dbSelectarea("SC6")
RetIndex("SC6")
// Apaga Indice SC6
fErase(_cInd+OrdBagExt())
dbSelectarea("SC5")
RetIndex("SC5")

Set Device to Screen
If aReturn[5] == 1
    Set Printer To
    ourspool(wnrel) //Chamada do Spool de Impressao
Endif
MS_FLUSH() //Libera fila de relatorios em spool
Return

