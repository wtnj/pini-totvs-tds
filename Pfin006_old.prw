#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PFIN006  ³ Autor ³ Andreia Silva         ³ Data ³ 25/02/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Emissao de baixas no SE1                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Editora Pini Ltda.                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ´±±
±±³Alteracoes³                                          ³ Data ³          ³±±
±±³          ³                                          ³      ³          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfin006()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

SetPrvt("CSTRING,WNREL,TAMANHO,TITULO,CDESC1,CDESC2")
SetPrvt("CDESC3,ARETURN,NOMEPROG,NLASTKEY,AORD,CBTXT")
SetPrvt("CPERG,LIMITE,CABEC1,CABEC2,CBCONT,LI")
SetPrvt("M_PAG,ADRIVER,NTIPO,CINDEX,CEXPRES,CARQTMP")
SetPrvt("NINDEX,CABEC3,_NQTITEM,")

cString  := "SE1"
wnRel    := "PFIN006"
Tamanho  := "M"
Titulo   := "Baixas de Titulos - Contas a Receber"
cDesc1   := "Este programa imprimira somente um titulo por pedido de venda, de"
cDesc2   := "acordo com os parametros solicitados pelo usuario."
cDesc3   := "Especifico Editora Pini Ltda."
aReturn  := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
NomeProg := "PFIN006"
nLastKey := 0
aOrd     := {}
Cbtxt    := SPACE(10)
cPerg    := "PFIN06"
Limite   := 132           // P - 80 / M - 132 / G - 220
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01    // Data Movimento De                             ³
//³ mv_par02    //                Ate                            ³
//³ mv_par03    // Serie          De                             ³
//³ mv_par04    //                Ate                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)

wnRel:=SetPrint(cString,wnRel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho)

If nLastKey == 27
    Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
    Return
Endif

lEnd := .f.

RptStatus({|lEnd| R010PRC(@lEnd)},"Aguarde","Imprimindo",.t.)

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ R010PRC  ³ Autor ³ Andreia Silva         ³ Data ³ 25/02/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Processa Relatorio                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico para Editora Pini Ltda.                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Revisao  ³                                          ³ Data ³          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static FUNCTION R010PRC()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Cabec1  := ""
Cabec2  := ""
cbCont  :=  0
li      := 80
m_pag   := 1
//aDriver := ReadDriver()
nTipo   := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtra arquivo do Contas a Receber.                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("SE1")
dbSetOrder(1)
cIndex  := "E1_FILIAL + E1_SERIE + E1_PEDIDO"

cExpres := 'E1_FILIAL == "'+ xFilial("SE1")
If mv_par05 == 1
	cExpres := cExpres + '" .And. DTOS(E1_DTALT)  >= "'+ DTOS(mv_par01)
	cExpres := cExpres + '" .And. DTOS(E1_DTALT)  <= "'+ DTOS(mv_par02)
Else
	cExpres := cExpres + '" .And. DTOS(E1_BAIXA)  >= "'+ DTOS(mv_par01)
	cExpres := cExpres + '" .And. DTOS(E1_BAIXA)  <= "'+ DTOS(mv_par02)
EndIf
cExpres := cExpres + '" .And. E1_SERIE        >= "'+ mv_par03
cExpres := cExpres + '" .And. E1_SERIE        <= "'+ mv_par04 +'"'

cArqTmp := CriaTrab(NIL,.F.)
MsAguarde({|| IndRegua("SE1", cArqTmp, cIndex,,cExpres,"Selecionando Registros ...")},"Aguarde","Criando Indice Temporario (SE1)...")
//nIndex := RetIndex("SE1")+1

dbSelectArea("SE1")
//dbSetOrder(nIndex)
dbGoTop()

SetRegua( RecCount() )

If mv_par05 == 1
	Cabec1:="Nro.PV  Codigo Lj  Nome Cliente          Vlr.Original       Dt.Mov.    NFiscal  Serie  Qt.Itens"
Else
	Cabec1:="Nro.PV  Codigo Lj  Nome Cliente          Vlr.Original       Dt.Baixa   NFiscal  Serie  Qt.Itens"
EndIf	
//
//       XXXXXX  XXXXXX XX  XXXXXXXXXXXXXXXXXXXX  99.999.999.999,99  XXXXXXXX   XXXXXX    XXX     XX
//       12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
//                10        20        30        40        50        60        70        80        90        100
//
Cabec2:=""
Cabec3:=""

Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)

While !Eof() .and. !lEnd

   IncRegua()
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica se o usuario interrompeu o relatorio                ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   If Li >= 60
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   Endif

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Impede a repeticao de titulos a receber com o mesmo numero   ³
   //³ de pedido de venda, conf. solicitacao da Ed. Pini Ltda.      ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If SE1->E1_PARCELA <> "A" .AND. SE1->E1_PARCELA <> " "
      dbSelectArea("SE1")
      dbSkip()
      Loop
   Endif

   If SE1->E1_SALDO > 0
      dbSelectArea("SE1")
      dbSkip()
      Loop
   Endif
   ** Verifica se o motivo da baixa e normal.

   If SE1->E1_MOTIVO#'NOR' .AND. SE1->E1_MOTIVO#' '
      dbSelectArea("SE1")
      dbSkip()
      Loop
   Endif

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Direciona linha, coluna para impressao                       ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   @ Li,01 PSAY SE1->E1_PEDIDO
   @ Li,08 PSAY SE1->E1_CLIENTE
   @ Li,15 PSAY SE1->E1_LOJA
   @ Li,19 PSAY SE1->E1_NOMCLI
   @ Li,41 PSAY Transform(SE1->E1_VALOR,"@E 99,999,999,999.99")
   If mv_par05 == 1
   		@ Li,60 PSAY SE1->E1_DTALT
   Else 
 		@ Li,60 PSAY SE1->E1_BAIXA
   EndIf
   @ Li,71 PSAY SE1->E1_NUM
   @ Li,81 PSAY SE1->E1_SERIE

   dbSelectArea("SC6")
   dbSetOrder(1)
   dbSeek(xfilial("SC6") + SE1->E1_PEDIDO)

   _nQtItem := 0

   While !Eof() .and. C6_NUM == SE1->E1_PEDIDO .and. C6_FILIAL == xfilial("SC6")
      _nQtItem := _nQtItem + 1
      dbSelectArea("SC6")
      dbSkip()
   End

   dbSelectArea("SE1")
   @ Li,91 PSAY _nQtItem
   Li++
   dbSkip()
End

Roda(cbcont,cbtxt,Tamanho)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indice de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("SE1")
RetIndex("SE1")

Ferase( cArqTmp + OrdBagExt() )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apresenta relatorio na tela                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Set Device To Screen

If aReturn[5] == 1
     Set Printer TO
     dbcommitAll()
     ourspool(wnRel)
Endif

Ms_Flush()

Return