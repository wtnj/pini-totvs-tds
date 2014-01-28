#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 14/03/02

User Function Pfat149()        // incluido pelo assistente de conversao do AP5 IDE em 14/03/02

SetPrvt("PROGRAMA,MHORA,CARQ,CSTRING,WNREL,NLASTKEY")
SetPrvt("L,NORDEM,M_PAG,NCARACTER,TAMANHO,CCABEC1")
SetPrvt("CCABEC2,LCONTINUA,CARQPATH,_CSTRING,_CSTRING2,CPERG")
SetPrvt("MCONTA1,MCONTA2,MCONTA3,LEND,BBLOCO,CMSG")
SetPrvt("CCHAVE,CFILTRO1,CFILTRO2,CFILTRO3,CFILTRO,CIND")
SetPrvt("MCONTA,MVEND,MEMISSAO,MDTPGTO,MPEDIDO,MPARCELA")
SetPrvt("MNOMEVEND,MDIVVEND,MVALOR,MPLANILHA,_ACAMPOS,_CNOME")
SetPrvt("CINDEX,MVEND5,CKEY,_SALIAS,AREGS,I,J")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT149   ³Autor: Raquel Ramalho         ³ Data:   28/01/02 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera Posicao de Comissoes                                  ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ mv_par01 Vencimento De......:                                           ³
//³ mv_par02 Vencimento At‚.....:                                           ³
//³ mv_par03 Pagas   Em Aberto    Ambos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Programa  :="PFAT149"
MHORA     :=TIME()
cArq      :=SUBS(CUSUARIO,1,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString   :=SUBS(CUSUARIO,1,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
wnrel     :=SUBS(CUSUARIO,1,6)
nLastKey  := 00
L         := 00
nOrdem    := 00
m_pag     := 01
nCaracter := 10
tamanho   := "M"
cCabec1   := ""
cCabec2   := ""
lContinua := .T.
cArqPath  :=GetMv("MV_PATHTMP")
_cString  :=cArqPath+cString+".DBF"
_cString2 :=cString+".DBF"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso nao exista, cria grupo de perguntas.                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cPerg:="PFT152"

// _ValidPerg()

// Definindo bases
DbSelectArea("SE3")
DbSetOrder(2)
DbGoTop()

If !Pergunte(cPerg)
	Return
Endif

IF Lastkey()==27
	Return
Endif

mConta1   :=0
mConta2   :=0
mConta3   :=0

FArqTrab()

Filtra()

#IFNDEF WINDOWS
	DrawAdvWin(" AGUARDE - GERANDO POSICAO DAS COMISSOES EM DBF" , 8, 0, 15, 75 )
	PRODUTOS()
#ELSE
	lEnd:= .F.
	bBloco:= { |lEnd| PRODUTOS()  }// Substituido pelo assistente de conversao do AP5 IDE em 14/03/02 ==>        bBloco:= { |lEnd| Execute(PRODUTOS)  }
	MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
#ENDIF

Do While .T.
	#IFNDEF WINDOWS
		ScreenDraw("SMT050", 3, 0, 0, 0)
		SetCursor(1)
		SetColor("B/BG")
		
		If !Pergunte(cPerg)
			Exit
		Endif
		
		If LastKey()== 27
			Exit
		Endif
		
		DrawAdvWin(" AGUARDE  - GERANDO RESUMO DO FATURAMENTO -  " , 8, 0, 15, 75 )
		Filtra()
		PRODUTOS()
	#ELSE
		
		If !Pergunte(cPerg)
			Exit
		Endif
		
		If LastKey()== 27
			Exit
		Endif
		
		Filtra()
		
		lEnd  := .F.
		bBloco:= { |lEnd| PRODUTOS()  }// Substituido pelo assistente de conversao do AP5 IDE em 14/03/02 ==>       bBloco:= { |lEnd| Execute(PRODUTOS)  }
		MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
	#ENDIF
End-While

cMsg:= "Arquivo Gerado com Sucesso em: "+_cString
#IFNDEF WINDOWS
	DrawAdvWin(" AGUARDE  - COPIANDO ARQUIVO   " , 8, 0, 15, 75 )
	DbSelectArea(cArq)
	dbGoTop()
	COPY TO &_cString
	ALERT(cMsg)
#ELSE
	//MsProcTxt("Aguarde" ,"Copinado Arquivo...", .T. )
	ALERT("Copiando Arquivo, OK!!")
	DbSelectArea(cArq)
	dbGoTop()
	COPY TO &_cString
	MSGINFO(cMsg)
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorna indices originais...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea(cArq)
DbCloseArea()
DbSelectArea("SE3")
Retindex("SE3")
DbSelectArea("SA3")
Retindex("SA3")

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ Filtra()                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Filtra arquivo SE3 para ser utilizado no programa.            ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Substituido pelo assistente de conversao do AP5 IDE em 14/03/02 ==> Function FILTRA
Static Function FILTRA()

DbSelectArea("SE3")
DbGoTop()
cChave := IndexKey()
If MV_PAR03==1
	cFiltro1:= 'DTOS(E3_DATA)>="'+DTOS(MV_PAR01)+'"'
	cFiltro2:= '.AND. DTOS(E3_DATA)<="'+DTOS(MV_PAR02)+'"'
	cFiltro3:= '.AND. !Empty(DTOS(E3_DATA)) .and. SE3->E3_COMIS<>0'
	cFiltro:= cFiltro1+cFiltro2+cFiltro3
Endif

If MV_PAR03==2
	cFiltro:='Empty(DTOS(E3_DATA)) .and. SE3->E3_COMIS<>0'
Endif

cInd   := CriaTrab(NIL,.f.)
IndRegua("SE3",cInd,cChave,,cFiltro,"Filtrando Pedidos...")
Dbgotop()
Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ PRODUTOS()                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Realiza leitura dos registros do SE2 ja filtrado e aplica     ³
//³           ³ restante dos filtros de parametros. Prepara os dados para     ³
//³           ³ serem gravados. Faz chamada a funcao GRAVA.                   ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Substituido pelo assistente de conversao do AP5 IDE em 14/03/02 ==> Function PRODUTOS
Static Function PRODUTOS()
mConta :=0
DbSelectArea("SE3")
DbGoTop()
Do While !EOF()
	
	mPedido  :=SE3->E3_PEDIDO
	DbSelectArea("SC5")
	DBSetOrder(1)
	
	IF DbSeek(xFilial("SC5")+mPedido)
		MVEND5 := SC5->C5_DIVVEN
		
		if mv_par04 == 1
			if	SC5->C5_DIVVEN <> 'MERC'
				DbSelectArea("SE3")
				dbskip()
				loop
			endif
		endif
		
		if mv_par04 == 2
			if	SC5->C5_DIVVEN <> 'PUBL'
				DbSelectArea("SE3")
				dbskip()
				loop
			endif
		endif
		
		if mv_par04 == 3
			if	SC5->C5_DIVVEN <> 'SOFT'
				DbSelectArea("SE3")
				dbskip()
				loop
			endif
		endif
	ELSE
		DbSelectArea("SE3")
		dbskip()
		loop
	endif
	
	mVend    :=SE3->E3_VEND
	mEmissao :=SE3->E3_EMISSAO
	mDtPgto  :=SE3->E3_DATA
	//            mPedido  :=SE3->E3_PEDIDO
	mParcela :=SE3->E3_PARCELA
	mNomeVend:=""
	mDivVend :=""
	
	If !Empty(SE3->E3_SITUAC)
		mValor   := -SE3->E3_COMIS
	Else
		mValor   := SE3->E3_COMIS
	Endif
	
	DbSelectArea("SA3")
	DbGoTop()
	DbSeek(xFilial()+mVend)
	If Found()
		mNomeVend:=SA3->A3_NOME
		mPlanilha:=SA3->A3_EMISSN
		mDivVend:=SA3->A3_DIVVEND
		//		MTIPOVEN := SA3->A3_TIPOVEN
		
		/*
		If SA3->A3_TIPOVEN=='CT'
		mPlanilha:='N'
		Endif
		If SA3->A3_TIPOVEN=='CP'
		mPlanilha:='N'
		Endif
		*/
		
		if mvend5 == 'PUBL' .AND. (SA3->A3_TIPOVEN <> 'CT' .AND. SA3->A3_TIPOVEN <> 'CP')
			mPlanilha:='N'
		endif
		
	Endif
	If mPlanilha<>'N'
		#IFNDEF WINDOWS
			Grava()
		#ELSE
			GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 14/03/02 ==>  Execute(GRAVA)
		#ENDIF
	Endif
	#IFNDEF WINDOWS
		@ 10,05 SAY "LENDO REGISTROS......." +StrZero(RECNO(),7)
		@ 11,05 SAY "GRAVANDO.............." +STR(MCONTA1,7)
	#ELSE
		MsProcTxt("Lendo Registros : "+Str(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
	#ENDIF
	
	DbSelectArea("SE3")
	DbSkip()
End-While
Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ GRAVA()                                                       ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Realiza gravacao dos registros ideais (conforme parametros)   ³
//³           ³ para impressao de Relatorio.                                  ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Substituido pelo assistente de conversao do AP5 IDE em 14/03/02 ==> Function GRAVA
Static Function GRAVA()
mConta1:= mConta1+1

#IFNDEF WINDOWS
	@ 10,05 SAY "LENDO REGISTROS......." +StrZero(RECNO(),7)
	@ 11,05 SAY "GRAVANDO.............." +STR(MCONTA1,7)
#ELSE
	MsProcTxt("Lendo Registros : "+Str(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
#ENDIF

DbSelectArea(cArq)
RecLock(cArq,.T.)
Replace Vend     With mVend
Replace Emissao  With mEmissao
Replace Comissao With mValor
Replace NomeVend With mNomeVend
Replace DivVend  with mDivVend
Replace DtPgto   With mDtPgto
Replace Pedido   With mPedido
Replace Parcela  With mParcela
MsUnlock()
Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ FARQTRAB()                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Cria arquivo de trabalho para guardar registros que serao     ³
//³           ³ impressos em forma de etiquetas.                              ³
//³           ³ serem gravados. Faz chamada a funcao GRAVA.                   ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Substituido pelo assistente de conversao do AP5 IDE em 14/03/02 ==> Function FARQTRAB
Static Function FARQTRAB()

_aCampos := {}
AADD(_aCampos,{"VEND","C",6,0})
AADD(_aCampos,{"EMISSAO","D",8,0})
AADD(_aCampos,{"DTPGTO","D",8,2})
AADD(_aCampos,{"NOMEVEND","C",40,0})
AADD(_aCampos,{"DIVVEND","C",40,0})
AADD(_aCampos,{"COMISSAO","N",12,2})
AADD(_aCampos,{"PEDIDO","C",6,2})
AADD(_aCampos,{"PARCELA","C",1,2})

_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "DTOS(EMISSAO)+VEND"
dbUseArea(.T.,, _cNome,cArq,.F.,.F.)
dbSelectArea(cArq)
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³VALIDPERG ³ Autor ³  Luiz Carlos Vieira   ³ Data ³ 16/07/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica as perguntas inclu¡ndo-as caso n„o existam        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Espec¡fico para clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 14/03/02 ==> Function _ValidPerg
/*Static Function _ValidPerg()

_sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg := PADR(cPerg,6)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

AADD(aRegs,{cPerg,"01","Emissao De......:","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Emissao At‚.....:","mv_ch2","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Situacao...........:","mv_ch3","C",01,0,4,"C","","mv_par03","Pagas","","","Em Aberto","","","Todos",""})
AADD(aRegs,{cPerg,"04","Divisao de vendas..:","mv_ch4","C",01,0,4,"C","","mv_par04","Mercado","","","Publicidade","","","Software",""})

For i:=1 to Len(aRegs)
If !dbSeek(cPerg+aRegs[i,2])
RecLock("SX1",.T.)
For j:=1 to FCount()
If j <= Len(aRegs[i])
FieldPut(j,aRegs[i,j])
Endif
Next
MsUnlock()
Endif
Next

DbSelectArea(_sAlias)
Return
*/
