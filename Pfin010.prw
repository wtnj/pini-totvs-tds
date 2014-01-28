#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
//teste para migracao ap7 20050810
#IFNDEF WINDOWS
        #DEFINE PSAY SAY
#ENDIF

User Function Pfin010()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSTRING,WNREL,TAMANHO,TITULO,CDESC1,CDESC2")
SetPrvt("CDESC3,ARETURN,NOMEPROG,NLASTKEY,AORD,CBTXT")
SetPrvt("CPERG,LIMITE,_NVLRTOT,_NSDOTOT,CABEC1,CABEC2")
SetPrvt("CBCONT,LI,M_PAG,ADRIVER,NTIPO,CINDEX")
SetPrvt("CEXPRES,CARQTMP,NINDEX,CABEC3,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 26/02/02 ==>         #DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PFIN010  ³ Autor ³ Andreia Silva         ³ Data ³ 12/04/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Relatorio de Lancamentos Contabeis que constam campos espe-³±±
±±³          ³ cificos da Editora Pini Ltda.                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Editora Pini Ltda.                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ´±±
±±³Alteracoes                                        ³ Data    ³ Autor    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Acerto dos nomes de campos no filtro do CT2,     ³ 08/05/00³ Gilberto ³±±
±±³ CT2_FILIAL p/ CT2->CT2_FILIAL                     ³         ³          ³±±
±±³                                                  ³         ³          ³±±
±±³                                                  ³         ³          ³±±
±±³                                                  ³         ³          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
cString  := "CT2"
MHORA      := TIME()
wnRel    := "PFIN010_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
Tamanho  := "G"
Titulo   := "Lancamentos Contabeis - Especifico para Editora Pini Ltda."
cDesc1   := "Este programa imprimira somente lancamentos contabeis, de acordo com"
cDesc2   := "os parametros solicitados pelo usuario."
cDesc3   := "Especifico para Editora Pini Ltda."
aReturn := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
NomeProg :="PFIN010"
nLastKey := 0
aOrd     := {}
Cbtxt      := SPACE(10)
cPerg    := "PFIN10"
Limite   := 220           // P - 80 / M - 132 / G - 220
_nVlrTot := 0
_nSdoTot := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01    // Data Lanc.     De           (D-08)            ³
//³ mv_par02    //                Ate                            ³
//³ mv_par03    // Numero Lote    De           (C-10)            ³
//³ mv_par04    //                Ate                            ³
//³ mv_par05    // Origem         De           (C-15)            ³
//³ mv_par06    //                Ate                            ³
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

If      nLastKey == 27
        Return
Endif

#IFDEF WINDOWS
   RptStatus({|| R010PRC() })// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>    RptStatus({|| Execute(R010PRC) })
#ELSE
   R010PRC()
#ENDIF

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ R010PRC  ³ Autor ³ Andreia Silva         ³ Data ³ 12/04/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Processa Relatorio                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para Editora Pini Ltda.                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ´±±
±±³Revisao   ³                                          ³ Data ³          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION R010PRC
Static FUNCTION R010PRC()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Cabec1  := ""
Cabec2  := ""
cbCont  :=  0
li       := 80
m_pag    := 1
aDriver  := ReadDriver()
nTipo    := IIF(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtra arquivo do Contas a Receber.                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("CT2")
cIndex  := "CT2_FILIAL+CT2_NUM"
cExpres := 'CT2->CT2_FILIAL == "'+ xFilial()
cExpres := cExpres + '" .And. DTOS(CT2->CT2_DATA) >= "'+ DTOS(mv_par01)
cExpres := cExpres + '" .And. DTOS(CT2->CT2_DATA) <= "'+ DTOS(mv_par02)
cExpres := cExpres + '" .And. CT2->CT2_NUM        >= "'+ mv_par03
cExpres := cExpres + '" .And. CT2->CT2_NUM        <= "'+ mv_par04
cExpres := cExpres + '" .And. CT2->CT2_ORIGEM     >= "'+ mv_par05
cExpres := cExpres + '" .And. CT2->CT2_ORIGEM     <= "'+ mv_par06 +'"'

cArqTmp := CriaTrab(NIL,.F.)
cIndex  := "CT2_FILIAL+CT2_NUM"
IndRegua("CT2",cArqTmp,cIndex,,cExpres,"Selecionando Registros ...")
// nIndex := RetIndex("CT2")+1 //20050810

#IFNDEF TOP  //20050810
    DbSetIndex(cArqTmp+OrdBagExt())
#ENDIF

dbSelectArea("CT2")
//dbSetOrder(nIndex) */ //20050810
dbGoTop()

SetRegua( RecCount() )

Cabec1:="Dt.Lanc. Num.Lote   Linha D/C Conta Debito         CC Deb.   Conta Credito        CC Cred.  Ctrl Valor Lancamento    Proc   Prod.   Dt.Fech. Historico do Lancamento                  Origem         "
//       XX/XX/XX XXXXXXXXXX XX    X   XXXXXXXXXXXXXXXXXXXX XXXXXXXXX XXXXXXXXXXXXXXXXXXXX XXXXXXXXX X    99.999.999.999,99   XXX    XXXXXXX XX/XX/XX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXX
//       123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345
//                10        20        30        40        50        60        70        80        90        100       110       120       130
Cabec2:=""
Cabec3:=""

Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)

While !Eof()

   IncRegua()
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Verifica se o usuario interrompeu o relatorio                ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

        #IFDEF WINDOWS
                If lAbortPrint
        #ELSE
        Inkey()
                If      LastKey() == 286
        #ENDIF
        @Prow()+1,001 PSAY "CANCELADO PELO OPERADOR"
        Exit
        Endif

   If Li >= 60
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   Endif

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Impede a impressao de lancamentos contabeis sem origem.      ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   If CT2->CT2_ORIGEM == ""
      dbSelectArea("CT2")
      dbSkip()
      Loop
   Endif

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Direciona linha, coluna para impressao                       ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   @ Li,001 PSAY CT2->CT2_DATA
   @ Li,010 PSAY CT2->CT2_NUM
   @ Li,021 PSAY CT2->CT2_LINHA
   @ Li,027 PSAY CT2->CT2_DC
   @ Li,031 PSAY CT2->CT2_DEBITO
   @ Li,052 PSAY CT2->CT2_CCD
   @ Li,062 PSAY CT2->CT2_CREDITO
   @ Li,083 PSAY CT2->CT2_CCC
   @ Li,093 PSAY CT2->CT2_CTRL
   @ Li,098 PSAY Transform(CT2->CT2_VALOR,"@E 99,999,999,999.99")
   @ Li,118 PSAY CT2->CT2_PROCESSO
   @ Li,125 PSAY CT2->CT2_PRODUTO
   @ Li,133 PSAY CT2->CT2_FECHCUS
   @ Li,142 PSAY CT2->CT2_HIST
   @ Li,183 PSAY CT2->CT2_ORIGEM

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Totaliza o valor dos lancamentos                             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   _nVlrTot := _nVlrTot + CT2->CT2_VALOR

   Li := Li + 4

   dbSkip()

EndDo                   // Finaliza While principal

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Imprime total referente ao valor dos lancamentos             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   Li := Li + 1
   @ Li,001 PSAY "Total dos Lancamentos Impressos"
   @ Li,098 PSAY Transform(_nVlrTot,"@E 99,999,999,999.99")

Roda(cbcont,cbtxt,Tamanho)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indice de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("CT2")
//Set Filter To  //20050810
//Set Index To   //20050810
//RetIndex("CT2") //20050810
dbclosearea()
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

