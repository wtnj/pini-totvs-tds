#INCLUDE "RWMAKE.CH"
#INCLUDE "GPER250.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER250  ³ Autor ³ R.H. - Marcos Stiefano³ Data ³ 30.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio Cesta Basica                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GPER250(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Aldo       ³24/03/97³xxxxxx³ Inclusao de cancelamento de impressao.   ³±±
±±³ Aldo       ³28/05/97³11114A³ Pegar Horas do cad.Func. na CompMes().   ³±±
±±³ Aldo       ³29/07/97³10468A³ Criado pergunta Salario Base/Composto.   ³±±
±±³ Aldo       ³18/09/97³XXXXXX³ Trocado "funcionario" por "beneficiario" ³±±
±±³ Aldo       ³31/10/97³12207a³ Lanc.Verba Base C.Basica parte Empresa.  ³±±
±±³ Aldo       ³05/01/98³13929a³ Cancel.Rel. qdo nao achar Adic.Temp.Serv.³±±
±±³ Cristina   ³19/05/98³XXXXXX³ Conversao para outros idiomas.           ³±±
±±³ Kleber     ³02/07/98³15943A³ Acrescentado ordem por Nome e C.C.+Nome  ³±±
±±³ Kleber     ³13/07/98³16043A³ Impor quebra de pagina por Filial.       ³±±
±±³ Mauro      ³25/08/98³------³ Subs.fValoriza por fSalInc-Incorp.Salar. ³±±
±±³ Aldo       ³30/03/99³------³ Passagem de nTamanho para SetPrint().    ³±±
±±³Marinaldo   ³27/07/00³XXXXXX³ Retirada Dos e Validacao Filial/Acessos  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
USER Function CTBASI()
LOCAL cDesc1  := STR0001			//"Rela‡„o da Cesta Basica                                   "
LOCAL cDesc2  := STR0002			//"Ser  impresso de acordo com os parametros solicitados pelo"
LOCAL cDesc3  := STR0003			//"usu rio."
LOCAL cString := "SRA" 							// alias do arquivo principal (Base)
LOCAL aOrd    := {STR0004,STR0005,STR0017,STR0018}	//"Centro de Custo"###"Matr¡cula"###"Nome"###"Centro de Custo + Nome"//

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn  := {STR0006,1,STR0007,2,2,1,"",1 }		//"Zebrado"###"Administra‡„o"
Private NomeProg := "GPER250"
Private aLinha   := {}
Private nLastKey := 0
Private cPerg    := "GPR250"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aPosicao1 := {} // Array das posicoes
Private aTotCc1   := {}
Private aTotFil1  := {}
Private aTotEmp1  := {}
Private aInfo     := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas na funcao IMPR                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Titulo
Private AT_PRG   := "GPER250"
Private wCabec0  := 1
Private wCabec1  := STR0008		//"FIL C.CUSTO   MATRICULA   NOME                                CUSTO BENEFICIARIO     CUSTO EMPRESA        CUSTO TOTAL"
Private Contfl   := 1
Private Li       := 0
Private nTamanho := "M"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("GPR250",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01        //  Filial De                                ³
//³ mv_par02        //  Filial Ate                               ³
//³ mv_par03        //  Centro de Custo De                       ³
//³ mv_par04        //  Centro de Custo Ate                      ³
//³ mv_par05        //  Matricula De                             ³
//³ mv_par06        //  Matricula Ate                            ³
//³ mv_par07        //  Situacoes                                ³
//³ mv_par08        //  Categorias                               ³
//³ mv_par09        //  Imprime C.C em Outra Pagina              ³
//³ mv_par10        //  Atualiza SRC                             ³
//³ mv_par11        //  Data do Pagamento                        ³
//³ mv_par12        //  Sobre qual Salario                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTit   :=STR0009	// " RELA€ŽO DA CESTA BASICA "
Titulo :=STR0009	// " RELA€ŽO DA CESTA BASICA "
wCabec1+=" "
wCabec1+=" "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="GPER250"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,cTit,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carregando variaveis mv_par?? para Variaveis do Sistema.     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem     := aReturn[8]
cFilDe     := mv_par01
cFilAte    := mv_par02
cCcDe      := mv_par03
cCcAte     := mv_par04
cMatDe     := mv_par05
cMatAte    := mv_par06
cSituacao  := mv_par07
cCategoria := mv_par08
lSalta     := If( mv_par09 == 1 , .T. , .F. )
lAtualiza  := If( mv_par10 == 1 , .T. , .F. )
dDpgto     := mv_par11
nQualSal   := mv_par12

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

RptStatus({|lEnd| GR250Imp(@lEnd,wnRel,cString)},cTit)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER250  ³ Autor ³ R.H. - Marcos Stiefano³ Data ³ 30.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio Cesta Basica                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GPER250(lEnd,WnRel,cString)                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ lEnd        - A‡Æo do Codelock                             ³±±
±±³          ³ wnRel       - T¡tulo do relat¢rio                          ³±±
±±³Parametros³ cString     - Mensagem			                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GR250Imp(lEnd,WnRel,cString)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
LOCAL CbTxt //Ambiente
LOCAL CbCont

Local aBasica   := {}
Local nCustFunc := 0
Local nSalario  := 0
Local nSalMes   := 0
Local nSalDia   := 0
Local nSalHora  := 0

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis de Acesso do Usuario                               ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Local cAcessaSRA	:= &( " { || " + ChkRH( "GPER250" , "SRA" , "2" ) + " } " )

Private aCodFol   := {}
Private aRoteiro  := {}

dbSelectArea( "SRA" )
If nOrdem == 1
	dbSetOrder(2)
ElseIf nOrdem == 2
	dbSetOrder(1)
ElseIf nOrdem == 3
   dbSetOrder(3)
ElseIf nOrdem == 4
   dbSetOrder(8)	
Endif
dbGoTop()

If nOrdem == 1 
	dbSeek( cFilDe + cCcDe + cMatDe , .T. )
	cInicio := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim    := cFilAte + cCcAte + cMatAte
ElseIf nOrdem == 2 
	dbSeek( cFilDe + cMatDe , .T. )
	cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
	cFim    := cFilAte + cMatAte
ElseIf nOrdem == 3
   dbSeek( cFilDe , .T. )
	cInicio := "SRA->RA_FILIAL"
	cFim    := cFilAte
ElseIf nOrdem == 4
  	dbSeek( cFilDe + cCcDe , .T. )
	cInicio := "SRA->RA_FILIAL + SRA->RA_CC"
	cFim    := cFilAte + cCcAte		
Endif

cFilialAnt := "  "
cCcAnt     := Space(9)

dbSelectArea( "SRA" )
SetRegua(SRA->(RecCount()))

While	!EOF() .And. &cInicio <= cFim
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Movimenta Regua Processamento                                ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IncRegua()

		If lEnd
			@Prow()+1,0 PSAY cCancel
			Exit
		Endif	 
		
		If SRA->RA_FILIAL # cFilialAnt
			If !Fp_CodFol(@aCodFol,SRA->RA_FILIAL)           .Or. ;
				!CarBasica(@aBasica,SRA->RA_FILIAL)           .Or. ;
				!fInfo(@aInfo,SRA->RA_FILIAL)
				Exit
			Endif
			dbSelectArea( "SRA" )
			cFilialAnt := SRA->RA_FILIAL
		Endif
      
      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Consiste Parametrizacao do Intervalo de Impressao            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If (Sra->Ra_Mat < cMatDe) .Or. (Sra->Ra_Mat > cMatAte) .Or. ;
			(Sra->Ra_CC < cCcDe) .Or. (Sra->Ra_CC > cCCAte)
			fTestaTotal()			
			Loop
		EndIf

		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³Consiste Filiais e Acessos                                             ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		IF !( SRA->RA_FILIAL $ fValidFil() .and. Eval( cAcessaSRA ) )
	   		fTestaTotal()
	   		Loop
		EndIF

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se Existe Incorporacao de Salario                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aPd := {} // Limpa a Matriz do SRC
		If nQualSal # 2 		//-- Salario Composto
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Calcula Salario Mes,Dia,Hora Funcionario                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			fSalario(@nSalario,@nSalHora,@nSalDia,@nSalMes,"A")
		Else
			fSalInc(@nSalario,@nSalMes,@nSalHora,@nSalDia,.T.)
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o Funcionario Tem Cesta Basica                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SRA->RA_CESTAB # "S"
			fTestaTotal()
			Loop
		Endif
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica Situacao e Categoria do Funcionario                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If !( SRA->RA_SITFOLH $ cSituacao ) .OR. !( SRA->RA_CATFUNC $ cCategoria )
			fTestaTotal()
			Loop
		Endif
	
		nCustFunc := 0			
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula a Cesta Basica                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If nSalMes >= aBasica[1,2] .And. nSalMes <= aBasica[1,3]
			nCustFunc := ( aBasica[1,1] * aBasica[1,4] ) / 100
		ElseIf nSalMes >= aBasica[1,5] .And. nSalMes <= aBasica[1,6]
			nCustFunc := ( aBasica[1,1] * aBasica[1,7] ) / 100
		ElseIf nSalMes >= aBasica[1,8] .And. nSalMes <= aBasica[1,9]
			nCustFunc := ( aBasica[1,1] * aBasica[1,10] ) / 100
		ElseIf nSalMes >= aBasica[1,11] .And. nSalMes <= aBasica[1,12]
			nCustFunc := ( aBasica[1,1] * aBasica[1,13] ) / 100
		ElseIf nSalMes >= aBasica[1,14] .And. nSalMes <= aBasica[1,15]
			nCustFunc := ( aBasica[1,1] * aBasica[1,16] ) / 100
        ElseIf nSalMes >= aBasica[1,17] .And. nSalMes <= aBasica[1,18]
			nCustFunc := ( aBasica[1,1] * aBasica[1,19] ) / 100
        ElseIf nSalMes >= aBasica[1,20] .And. nSalMes <= aBasica[1,21]
			nCustFunc := ( aBasica[1,1] * aBasica[1,22] ) / 100
        ElseIf nSalMes >= aBasica[1,23] .And. nSalMes <= aBasica[1,24]
			nCustFunc := ( aBasica[1,1] * aBasica[1,25] ) / 100
        ElseIf nSalMes >= aBasica[1,26] .And. nSalMes <= aBasica[1,27]
			nCustFunc := ( aBasica[1,1] * aBasica[1,28] ) / 100
		Endif
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Calcula o Bloco para o Funcionario                           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aPosicao1:={} // Limpa Arrays
		Aadd(aPosicao1,{0,0,0,0})
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza o Bloco para os Totalizadores                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nPos0 := nCustFunc
		nPos1 := ( aBasica[1,1] - nCustFunc )
		nPos2 := aBasica[1,1]
		nPos3 := 1
		Atualiza(@aPosicao1,1,nPos0,nPos1,nPos2,nPos3)
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza a Movimentacao do Funcionario SRC                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lAtualiza
			Begin Transaction
				If nCustFunc > 0
					GravaSrc(SRA->RA_FILIAL,SRA->RA_MAT,aCodFol[156,1],dDpgto,SRA->RA_CC,cSemana,"V","G",0,nCustFunc,0)
				Endif
				If ( aBasica[1,1] - nCustFunc ) > 0
					GravaSrc(SRA->RA_FILIAL,SRA->RA_MAT,aCodFol[157,1],dDpgto,SRA->RA_CC,cSemana,"V","G",0,aBasica[1,1],0)
					GravaSrc(SRA->RA_FILIAL,SRA->RA_MAT,aCodFol[211,1],dDpgto,SRA->RA_CC,cSemana,"V","G",0,(aBasica[1,1]-nCustFunc),0)
				Endif
			End Transaction
		Endif

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualizando Totalizadores                                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fAtuCont(@aToTCc1)  // Centro de Custo
		fAtuCont(@aTotFil1) // Filial
		fAtuCont(@aTotEmp1) // Empresa
	
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Impressao do Funcionario                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		fImpFun()
	
		fTestaTotal()  // Quebras e Skips
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( "SRA" )
Set Filter to 
dbSetOrder(1)

Set Device To Screen

If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif

MS_FLUSH()

*--------------------------------------*
Static Function CarBasica(aBasica,cFil)
*--------------------------------------*
Local cAlias := Alias()
Local nValCesta := 0
Local nIniF1 := nFimF1 := nPerc1:= 0
Local nIniF2 := nFimF2 := nPerc2:= 0
Local nIniF3 := nFimF3 := nPerc3:= 0
Local nIniF4 := nFimF4 := nPerc4:= 0
Local nIniF5 := nFimF5 := nPerc5:= 0
Local nIniF6 := nFimF6 := nPerc6:= 0
Local nIniF7 := nFimF7 := nPerc7:= 0
Local nIniF8 := nFimF8 := nPerc8:= 0
Local nIniF9 := nFimF9 := nPerc9:= 0
aBasica := {}

dbSelectArea( "SRX" )
If FPHIST82( SRA->RA_FILIAL , "35" , cFil + "1" )
	nValCesta := Val(Substr(SRX->RX_TXT,01,11))
	nIniF1    := Val(Substr(SRX->RX_TXT,12,11))
	nFimF1    := Val(Substr(SRX->RX_TXT,23,11))
	nPerc1    := Val(Substr(SRX->RX_TXT,34,07))
	FPHIST82( SRA->RA_FILIAL , "35" , cFil + "2" )
	nIniF2    := Val(Substr(SRX->RX_TXT,01,11))
	nFimF2    := Val(Substr(SRX->RX_TXT,12,11))
	nPerc2    := Val(Substr(SRX->RX_TXT,23,07))
	nIniF3    := Val(Substr(SRX->RX_TXT,30,11))
	nFimF3    := Val(Substr(SRX->RX_TXT,41,11))
	nPerc3    := Val(Substr(SRX->RX_TXT,52,07))
	FPHIST82( SRA->RA_FILIAL , "35" , cFil + "3" )
	nIniF4    := Val(Substr(SRX->RX_TXT,01,11))
	nFimF4    := Val(Substr(SRX->RX_TXT,12,11))
	nPerc4    := Val(Substr(SRX->RX_TXT,23,07))
	nIniF5    := Val(Substr(SRX->RX_TXT,30,11))
	nFimF5    := Val(Substr(SRX->RX_TXT,41,11))
	nPerc5    := Val(Substr(SRX->RX_TXT,52,07))
	FPHIST82( SRA->RA_FILIAL , "35" , cFil + "4" )
	nIniF6    := Val(Substr(SRX->RX_TXT,01,11))
	nFimF6    := Val(Substr(SRX->RX_TXT,12,11))
	nPerc6    := Val(Substr(SRX->RX_TXT,23,07))
	nIniF7    := Val(Substr(SRX->RX_TXT,30,11))
	nFimF7    := Val(Substr(SRX->RX_TXT,41,11))
	nPerc7    := Val(Substr(SRX->RX_TXT,52,07))
	FPHIST82( SRA->RA_FILIAL , "35" , cFil + "5" )
	nIniF8    := Val(Substr(SRX->RX_TXT,01,11))
	nFimF8    := Val(Substr(SRX->RX_TXT,12,11))
	nPerc8    := Val(Substr(SRX->RX_TXT,23,07))
	nIniF9    := Val(Substr(SRX->RX_TXT,30,11))
	nFimF9    := Val(Substr(SRX->RX_TXT,41,11))
	nPerc9    := Val(Substr(SRX->RX_TXT,52,07))
ElseIf FPHIST82( SRA->RA_FILIAL , "35" , "  1" )
	nValCesta := Val(Substr(SRX->RX_TXT,01,11))
	nIniF1    := Val(Substr(SRX->RX_TXT,12,11))
	nFimF1    := Val(Substr(SRX->RX_TXT,23,11))
	nPerc1    := Val(Substr(SRX->RX_TXT,34,07))
	dbSkip( 1 )
	FPHIST82( SRA->RA_FILIAL , "35" , "  2" )
	nIniF2    := Val(Substr(SRX->RX_TXT,01,11))
	nFimF2    := Val(Substr(SRX->RX_TXT,12,11))
	nPerc2    := Val(Substr(SRX->RX_TXT,23,07))
	nIniF3    := Val(Substr(SRX->RX_TXT,30,11))
	nFimF3    := Val(Substr(SRX->RX_TXT,41,11))
	nPerc3    := Val(Substr(SRX->RX_TXT,52,07))
	FPHIST82( SRA->RA_FILIAL , "35" , "  3" )
	nIniF4    := Val(Substr(SRX->RX_TXT,01,11))
	nFimF4    := Val(Substr(SRX->RX_TXT,12,11))
	nPerc4    := Val(Substr(SRX->RX_TXT,23,07))
	nIniF5    := Val(Substr(SRX->RX_TXT,30,11))
	nFimF5    := Val(Substr(SRX->RX_TXT,41,11))
	nPerc5    := Val(Substr(SRX->RX_TXT,52,07))
		FPHIST82( SRA->RA_FILIAL , "35" , "  4" )
	nIniF6    := Val(Substr(SRX->RX_TXT,01,11))
	nFimF6    := Val(Substr(SRX->RX_TXT,12,11))
	nPerc6    := Val(Substr(SRX->RX_TXT,23,07))
	nIniF7    := Val(Substr(SRX->RX_TXT,30,11))
	nFimF7    := Val(Substr(SRX->RX_TXT,41,11))
	nPerc7    := Val(Substr(SRX->RX_TXT,52,07))
	FPHIST82( SRA->RA_FILIAL , "35" , "  5" )
	nIniF8    := Val(Substr(SRX->RX_TXT,01,11))
	nFimF8    := Val(Substr(SRX->RX_TXT,12,11))
	nPerc8    := Val(Substr(SRX->RX_TXT,23,07))
	nIniF9    := Val(Substr(SRX->RX_TXT,30,11))
	nFimF9    := Val(Substr(SRX->RX_TXT,41,11))
	nPerc9    := Val(Substr(SRX->RX_TXT,52,07))
Else
	Set Device To Screen
	HELP(" ",1,"GR250CESTA")
	dbSelectArea( cAlias )
	Return ( .F. )
Endif

Aadd(aBasica,{nValCesta,nIniF1,nFimF1,nPerc1,nIniF2,nFimF2,nPerc2,nIniF3,nFimF3,nPerc3,nIniF4,nFimF4,nPerc4,nIniF5,nFimF5,nPerc5,nIniF6,nFimF6,nPerc6,nIniF7,nFimF7,nPerc7,nIniF8,nFimF8,nPerc8,nIniF9,nFimF9,nPerc9})

dbSelectArea( cAlias )
Return ( .T. )

*--------------------------------------------------------------*
Static Function Atualiza(aMatriz,nElem,nPos0,nPos1,nPos2,nPos3)
*--------------------------------------------------------------*
aMatriz[nElem,1] := nPos0
aMatriz[nElem,2] := nPos1
aMatriz[nElem,3] := nPos2
aMatriz[nElem,4] := nPos3

Return Nil

*--------------------------*
Static Function fTestaTotal
*--------------------------*
dbSelectArea( "SRA" )
cFilialAnt := SRA->RA_FILIAL              // Iguala Variaveis
cCcAnt     := SRA->RA_CC
dbSkip()

If Eof() .Or. &cInicio > cFim
	fImpCc()
	fImpFil()
	fImpEmp()
Elseif cFilialAnt # SRA->RA_FILIAL
	fImpCc()
	fImpFil()
Elseif cCcAnt # SRA->RA_CC
	fImpCc()
Endif

Return Nil

*------------------------*
Static Function fImpFun()
*------------------------*
Local lRetu1 := .T.

cDet := " "+SRA->RA_FILIAL+" "+SRA->RA_CC+"    "+SRA->RA_MAT+"   "+Left(SRA->RA_NOME,30)+SPACE(09)
cDet += TRANSFORM(aPosicao1[1,1],"@E 999,999,999.99")+SPACE(5)+TRANSFORM(aPosicao1[1,3] - aPosicao1[1,1],"@E 999,999,999.99")+SPACE(5)
cDet += TRANSFORM(aPosicao1[1,3],"@E 999,999,999.99")
Impr(cDet,"C")

Return Nil

*-----------------------*
Static Function fImpCc()
*-----------------------*
Local lRetu1 := .T.

If Len(aTotCc1) == 0 .Or. nOrdem # 1
	Return Nil
Endif

Impr("","C")
cDet := STR0010+cFilialAnt+STR0011+cCcAnt+" - "+DescCc(cCcAnt,cFilialAnt)		//"FILIAL: "###" CCTO: "
cDet += Space(13)+STR0012			//"CUSTO BENEFICIARIO     CUSTO EMPRESA        CUSTO TOTAL  CESTA BASICA"
Impr(cDet,"C")

lRetu1 := fImpComp(aTotCc1,1) // Imprime

aTotCc1 :={}      // Zera

cDet := Repl("=",132)
Impr(cDet,"C")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salta de Pagina na Quebra de Centro de Custo (lSalta = .T.)  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lSalta
	Impr("","P")
Endif

Return Nil

*------------------------*
Static Function fImpFil()
*------------------------*
Local lRetu1 := .T.
Local cDescFil

If Len(aTotFil1) == 0
	Return Nil
Endif

cDescFil := aInfo[1] + Space(25)
cDet     := STR0013+cFilialAnt+" - "+cDescFil		//"FILIAL: "
cDet     += Space(09)+STR0014		//"CUSTO BENEFICIARIO     CUSTO EMPRESA        CUSTO TOTAL  CESTA BASICA"
Impr(cDet,"C")
Impr("","C")

lRetu1 := fImpComp(aTotFil1,1) // Imprime

aTotFil1 :={}      // Zera

cDet := Repl("#",132)
Impr(cDet,"C")
Impr("","P")

Return Nil

*------------------------*
Static Function fImpEmp()
*------------------------*
Local lRetu1 := .T.

If Len(aTotEmp1) == 0
	Return Nil
Endif

cDet := STR0015+aInfo[3]		//"Empresa: "
cDet += Space(13)+STR0016		//"CUSTO BENEFICIARIO     CUSTO EMPRESA        CUSTO TOTAL  CESTA BASICA"
Impr(cDet,"C")
Impr("","C")

lRetu1 := fImpComp(aTotEmp1,1) // Imprime

aTotEmp1 :={}      // Zera

Impr("","F")

Return Nil

*-------------------------------------------------------------------*
Static Function fImpComp(aPosicao,nLugar) // Complemento da Impressao
*-------------------------------------------------------------------*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ aPosicao = Array Contendo o que vai ser impresso            ³
//³ nLugar   = Posicao Fisica dos Grupos de Impressao           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local nResImp := 0
Local nPos    := 0
Local cCab1 , cCab2

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Resultado de Impressao para testar se tudo nao esta zerado  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nPos := 1
AeVal(aPosicao,{ |X| nResImp += ( X[1] + X[2] + X[3] ) })  // Testa se a Soma == 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime se Possui Valores                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nResImp > 0
	cDet := Space(65) + TRANSFORM(aPosicao[nPos,1],"@E 999,999,999.99")
	cDet += Space(05) + TRANSFORM(aPosicao[nPos,2],"@E 999,999,999.99")
	cDet += Space(05) + TRANSFORM(aPosicao[nPos,3],"@E 999,999,999.99")
	cDet += Space(05) + TRANSFORM(aPosicao[nPos,4],"@E 9999999")
	Impr(cDet,"C")
	Return ( .T. )
Else
	Return ( .F. )
Endif

*---------------------------------------------------------*
Static Function fAtuCont(aArray1)  // Atualiza Acumuladores
*---------------------------------------------------------*
Local x := 0
Local z := 1

If Len(aArray1) > 0
	For x:= 1 To 4
		aArray1[z,x] += aPosicao1[z,x]
	Next
Else
	aArray1 := Aclone(aPosicao1)
Endif

Return Nil

