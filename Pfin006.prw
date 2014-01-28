#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
/*/ alterado em 20031112
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ PFIN006  ³ Autor ³ Andreia Silva         ³ Data ³ 25/02/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Emissao de baixas no SE1  								  ³±±
±±³          ³ comparando-se a serie LIV com UNI em 20031111              ³±±
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
SetPrvt("NINDEX,CABEC3,_NQTITEM, mpedido")
SetPrvt("_cNome,_aCampos, cIndex, cChave")
SetPrvt("mCLIENTE, mLOJA, mNOMCLI, mVALOR")
SetPrvt("mDATAD, mNUM, mSERIE, mQTD, nTotal, nUNI,mhora")

cString  := "SE1"
MHORA      := TIME()
wnRel    := "PFIN006_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
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
nTotal := 0
nUNI := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01    // Data Movimento De                             ³
//³ mv_par02    //                Ate                            ³
//³ mv_par03    // Serie          De                             ³
//³ mv_par04    //                Ate                            ³     
//³ mv_par05    //Considera   1:Ultimo Movto / 2:Baixa			 ³     
//³ mv_par06    //Tipo de relatorio  1: Liv X UNI / 2: Por Serie | //20031111
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.T.)

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

IF MV_PAR06 == 1
	cExpres := cExpres + '" .And. (E1_SERIE == "LIV")'
Else
	cExpres := cExpres + '" .And. E1_SERIE        >= "'+ mv_par03
	cExpres := cExpres + '" .And. E1_SERIE        <= "'+ mv_par04 +'"'	
Endif

cArqTmp := CriaTrab(NIL,.F.)
MsAguarde({|| IndRegua("SE1", cArqTmp, cIndex,,cExpres,"Selecionando Registros ...")},"Aguarde","Criando Indice Temporario (SE1)...")
//nIndex := RetIndex("SE1")+1

FARQTRAB()

dbSelectArea("SE1")
dbGoTop()


While !Eof() .and. !lEnd
   
   If mv_par06 = 1 .and. SE1->E1_SERIE <>"LIV" //20031111
   		dbSelectArea("SE1")
	    dbSkip()
    	Loop
	EndIf
   	
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
   	mpedido := SE1->E1_PEDIDO
	mCLIENTE := SE1->E1_CLIENTE
	mLOJA := SE1->E1_LOJA
	mNOMCLI := SE1->E1_NOMCLI
   	mVALOR := SE1->E1_VALOR
   	If mv_par05 == 1
   		mDATAD := SE1->E1_DTALT
   	Else 
   		mDATAD := SE1->E1_BAIXA
   	EndIf
	mNUM := SE1->E1_NUM
	mSERIE := SE1->E1_SERIE
   
	//CALCULANDO A QTD
   dbSelectArea("SC6")
   dbSetOrder(1)
   dbSeek(xfilial("SC6") + SE1->E1_PEDIDO)
   _nQtItem := 0
   While !Eof() .and. C6_NUM == SE1->E1_PEDIDO .and. C6_FILIAL == xfilial("SC6")
      _nQtItem := _nQtItem + 1
      dbSelectArea("SC6")
      dbSkip()
   End
	mQTD := _nQtItem
    
    GravarBASE()
	dbSelectArea("SE1")  
	dbSkip()
End

IF mv_par06=1
	GravarLiv()
	ImprimirLiv()
Else
	ImprimirSerie()
EndIf

Roda(cbcont,cbtxt,Tamanho)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indice de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

dbSelectArea("SE1")
RetIndex("SE1")

Ferase( cArqTmp + OrdBagExt() )
DBSelectArea("PFIN006")
DBCloseArea()

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
          





Static Function FARqTrab()
_aCampos := {  {"PEDIDO"  ,"C",6 ,0} ,;                  
{"CLIENTE"  ,"C",6 ,0} ,;
{"LOJA"  ,"C",2 ,0} ,;
{"NOMCLI"  ,"C",20 ,0} ,;
{"VALOR"  ,"N",17 ,2} ,;
{"DATAD"  ,"D",8 ,0} ,;
{"NUM"  ,"C",6 ,0} ,;
{"SERIE"  ,"C",3 ,0},;
{"QTD"  ,"N",3 ,0}, ;
{"UNI_DATAD"  ,"D",8 ,0} ,;
{"UNI_NUM"  ,"C",6 ,0} ,;
{"UNI_SERIE"  ,"C",3 ,0}}
_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PFIN006",.F.,.F.)     
DBSELECTAREA("PFIN006")
cIndex := CriaTrab(Nil,.F.)
cChave := "PEDIDO"
MsAguarde({|| Indregua("PFIN006",cIndex,cCHAVE,,,"AGUARDE....CRIANDO INDICE ")},"Aguarde","Gerando Indice Temporario(PFIN006)...")
Return                        




Static Function GravarBASE()
DBSelectArea("PFIN006")
Reclock("PFIN006",.t.)
replace PEDIDO  WITH mPEDIDO 
replace CLIENTE  WITH mCLIENTE
replace LOJA  WITH mLOJA
replace NOMCLI  WITH mNOMCLI
replace VALOR  WITH mVALOR
replace DATAD  WITH mDATAD
replace NUM  WITH mNUM
replace SERIE  WITH mSERIE
replace QTD  WITH mQTD
MsUnlock()
Return 


               



Static Function GravarLiv()
nTotal := 0
nUNI := 0
DBSELECTAREA("SE1")
RetIndex("SE1")                    
DBCloseArea("SE1")
DBSELECTAREA("SE1")
DbOrderNickName("E1_PEDIDO") //dbSetOrder(27) 20130225  ///dbSetOrder(15) AP5 //20090114 era(21) //20090723 mp10 era(22) //dbSetOrder(26) 20100412
//cIndex := CriaTrab(Nil,.F.)
//cChave := "E1_FILIAL+E1_PEDIDO+E1_SERIE"
//MsAguarde({|| Indregua("SE1",cIndex,cCHAVE,,,"AGUARDE....CRIANDO INDICE ")},"Aguarde","Gerando Indice Temporario(SE1)...")


DBSelectArea("PFIN006")      
DBGotop()
While !Eof() .and. !lEnd
	DBSelectArea("SE1")      
   	bAchou := .T. 
	IF DBSEEK(XFILIAL()+PFIN006->PEDIDO)
		//PROCEDIMENTOS PARA FILTRAR SOMENTE UNI
		while SE1->E1_PEDIDO = PFIN006->PEDIDO .and. bAchou
			If SE1->E1_SERIE = "UNI"
		  		Reclock("PFIN006",.F.)       
		  		If mv_par05 == 1
					replace UNI_DATAD  WITH SE1->E1_DTALT
				Else 
			   		replace UNI_DATAD  WITH SE1->E1_BAIXA
			   	EndIf
				replace UNI_NUM  WITH SE1->E1_NUM
				replace UNI_SERIE  WITH SE1->E1_SERIE
				MsUnlock()
				bAchou := .F.
				nUNI++
			EndIF
			dbSelectArea("SE1")
		    dbSkip()
		    Loop
		end
	ENDIF   
	nTotal++
    DBSelectArea("Pfin006")
    DBSkip()
End
Return 







Static Function ImprimirSerie()
DBSelectArea("PFIN006")
DBGotop()
SetRegua( RecCount() )

if mv_par05 = 1
	Cabec1:="Nro.PV  Codigo Lj  Nome Cliente          Vlr.Original       Dt.Mov.    NFiscal  Serie  Qt.Itens"
Else
	Cabec1:="Nro.PV  Codigo Lj  Nome Cliente          Vlr.Original       Dt.Baixa   NFiscal  Serie  Qt.Itens"
Endif
//           XXXXXX  XXXXXX XX  XXXXXXXXXXXXXXXXXXXX  99.999.999.999,99  XXXXXXXX   XXXXXX    XXX     XX
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                    10        20        30        40        50        60        70        80        90        100       110
Cabec2:=""
Cabec3:=""
Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)

While !Eof() .and. !lEnd
   IncRegua()
   If Li >= 60
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   Endif
	@ Li,01 PSAY PFIN006->PEDIDO
	@ Li,08 PSAY PFIN006->CLIENTE
	@ Li,15 PSAY PFIN006->LOJA
	@ Li,19 PSAY PFIN006->NOMCLI
	@ Li,41 PSAY Transform(PFIN006->VALOR,"@E 99,999,999,999.99")
	@ Li,60 PSAY PFIN006->DATAD
	@ Li,71 PSAY PFIN006->NUM
	@ Li,81 PSAY PFIN006->SERIE
	@ Li,91 PSAY PFIN006->QTD
	Li++
    DBSelectArea("Pfin006")
    DBSkip()
end
Return






Static Function ImprimirLiv()
DBSelectArea("PFIN006")
DBGotop()             
SetRegua( RecCount() )

if mv_par05 = 1                       //DIFERENCA
	Cabec1:="Nro.PV  Codigo Lj  Nome Cliente          Vlr.Original       Mov.-LIV    NF-LIV   Serie  Qt.Itens  NF-UNI   Serie  Mov.-LIV"
Else
	Cabec1:="Nro.PV  Codigo Lj  Nome Cliente          Vlr.Original       Baixa-LIV   NF-LIV   Serie  Qt.Itens  NF-UNI   Serie  Baixa-LIV"
Endif      
//           XXXXXX  XXXXXX XX  XXXXXXXXXXXXXXXXXXXX  99.999.999.999,99  XXXXXXXX   XXXXXX    XXX     XX
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                    10        20        30        40        50        60        70        80        90        100       110
Cabec2:=""
Cabec3:=""
Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)

While !Eof() .and. !lEnd
   IncRegua()
   If Li >= 60
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   Endif
	@ Li,01 PSAY PFIN006->PEDIDO
	@ Li,08 PSAY PFIN006->CLIENTE
	@ Li,15 PSAY PFIN006->LOJA
	@ Li,19 PSAY PFIN006->NOMCLI
	@ Li,41 PSAY Transform(PFIN006->VALOR,"@E 99,999,999,999.99")
	@ Li,60 PSAY PFIN006->DATAD
	@ Li,71 PSAY PFIN006->NUM
	@ Li,81 PSAY PFIN006->SERIE
	@ Li,91 PSAY PFIN006->QTD
	@ Li,98 PSAY PFIN006->UNI_NUM   //DIFERENCA
	@ Li,108 PSAY PFIN006->UNI_SERIE
	@ Li,115 PSAY PFIN006->UNI_DATAD
	Li++
    DBSelectArea("Pfin006")
    DBSkip()
end       
@ Li+2,001 PSAY Repl("_",125)
@ Li+2,001 PSAY "Total de Nota Fiscais com Serie LIV: "+ Alltrim(Str(nTotal)) +", encontradas "+ Alltrim(Str(nUNI)) +" Notas Fiscais com Serie UNI"
Return