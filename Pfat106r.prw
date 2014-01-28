#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
/*/
//Danilo C S Pala 20060327: dados de enderecamento do DNE
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT106   ³Autor: Raquel Farias          ³ Data:   27/07/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera relatorio para mala direta.                           ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Altera‡Æo           ³Alterado por: Raquel Farias   ³ Data:   10/04/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Acrescentei consistencia de e1_hist=='LP'                  ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Liberado para Usu rio em: 11/04/00                                    ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± Observacao : Os progamas PFAT106E, PFAT106R e PFAT106C eram originalmen-±±
±± te um s¢ que funcionava apenas para DOS. Por ocasiao da conversao para  ±±
±± funcionamento em Windows decidiu-se que para melhor compreensao do pro- ±±
±± grama e afim de se seguir o padrao Microsiga era melhor separar o pro-  ±±
±± grama de acordo com suas funcoes principais : Relatorio, Etiquetas e    ±±
±± Geracao de Arquivo.Foram criados,portando,os RDMAKES acima citados.     ±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³PFAT106R.PRX        ³ Gilberto A. de Oliveira Jr.  ³ Data:   16/04/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Alteracoes:         ³                                                 ³ ±±
±±³Gilberto - 16.04.00 ³Conversao p/ Windows, separacao do antigo PFAT106³ ±±
±±³                    ³e substituicao de indices temporarios.           ³ ±±
±±³Gilberto - 22.05.00 ³MV_PAR17, prioridade de processamento.           ³ ±±
±±³                    ³Clientes ou Produtos. Quando clientes cria indice³ ±±
±±³                    ³temporario por A1_CEP para o SA1 e processa pelo ³ ±±
±±³                    ³SA1.                                             ³ ±±
±±³Raquel - 21.08.00   ³Acrescentei grava‡Æo de 12 campos de controle no ³ ±±
±±³                    ³ZZ7.                                             ³ ±±
±±³                    ³Acrescentei valida‡Æo para assinaturas:          ³ ±±
±±³                    ³Se o mv_par16<>1 e Mv_par16<>2 o programa traba- ³ ±±
±±³                    ³lha comparando a data de faturamento, se nÆo tra-³ ±±
±±³                    ³balha comparando a data de circula‡Æo.           ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat106r()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

SetPrvt("CDESC1,CDESC2,CDESC3,TITULO,CTITULO,ARETURN")
SetPrvt("CPROGRAMA,MHORA,CARQ,CSTRING,WNREL,NLASTKEY")
SetPrvt("L,NORDEM,M_PAG,NCARACTER,TAMANHO,CCABEC1")
SetPrvt("CCABEC2,LCONTINUA,MSAIDA,MVALIDA,CPERG,MCONTA1")
SetPrvt("MCONTA2,MCONTA3,LEND,BBLOCO,CINDEX,CKEY")
SetPrvt("CCHAVE,CFILTRO,CIND,MIND1,MCONTA,MPEDIDO")
SetPrvt("MITEM,MCODCLI,MCODDEST,MPROD,MCF,MCEP")
SetPrvt("MVALOR,MNOMECLI,MDEST,MEND,MMUN,MEST")
SetPrvt("MFONE,MCGC,MDTPG,MDTFAT,MDTPG2,MFILIAL")
SetPrvt("MBAIRRO,MPAGO,MPGTO,MPARC,MABERTO,MVEND")
SetPrvt("MEDVENC,MEDSUSP,MGRAVA,MDTVENC,MSITUAC,MGRAT")
SetPrvt("MCODREV,MRESPCOB,MTITULO,_LSEEK,MEMAIL,MFAX")
SetPrvt("MATIV,MTPCLI,MFONE1,MCHAVE,MCHAVE2,MEDINIC")
SetPrvt("MDTVEND,_ACAMPOS,_CNOME,MIND2,_SALIAS,AREGS")
SetPrvt("I,J,")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ mv_par01 Do Produdo.........:                                           ³
//³ mv_par02 At‚ o Produto......:                                           ³
//³ mv_par03 Faturado/Venc......:                                           ³
//³ mv_par04 Faturados/Venc at‚.:                                           ³
//³ mv_par05 Do CEP.............:                                           ³
//³ mv_par06 At‚ CEP............:                                           ³
//³ mv_par07 Tipo...............: Pagas, Cortesia, Ambas.                   ³
//³ mv_par08 Situacao...........: Baixados, Em Aberto, Ambas.               ³
//³ mv_par09 Qtde da Selecao....:                                           ³
//³ mv_par10 Elimina duplicidade: Sim, Nao.                                 ³
//³ mv_par11 Cod. Promo‡Æo......:                                           ³
//³ mv_par12 Cod. Mailing.......:                                           ³
//³ mv_par13 Da Atividade.......:                                           ³
//³ mv_par14 At‚ Atividade......:                                           ³
//³ mv_par15 Tipo Cliente.......: Ass. Ativos, Ass. Cancelados, Outros.     ³
//³ mv_par16 Utilizacao.........: Mala Direta, TeleMarketing.               ³
//³ mv_par17 Processa por.......: Clientes, Produtos.                       ³
//³ mv_par18 Inclui representante: Sim  NÆo                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cDesc1    := PADC("Este programa ira gerar o arquivo de cliente em relat¢rio" ,74)
cDesc2    := PADC("Elimina duplicidade por codigo de cliente e destinatario",74)
cDesc3    := ""
Titulo    := PADC("RELATàRIO",74)
cTitulo   := " **** CLIENTES **** "
aReturn   := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
cPrograma := "PFA106R"
MHORA     := TIME()
cArq      := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
wnrel     := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
nLastKey  := 00
L         := 00
nOrdem    := 00
m_pag     := 01
nCaracter := 10
tamanho   := "P"
cCabec1   := ""
cCabec2   := ""
lContinua := .T.
mSaida    := "2"
mValida   := ""
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso nao exista, cria grupo de perguntas.                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:="PF106R"

//_ValidPerg()

If !Pergunte(cPerg)
	Return
Endif

IF Lastkey()==27
	Return
Endif

DbSelectArea("ZZ7")
If DbSeek(xfilial("ZZ7")+MV_PAR11+MV_PAR12+MSAIDA)
	MsgStop("Codigo ja utilizado, informe codigo valido ou solicite manuten‡ao no cad. Mailing")
	Return
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Consiste parametro do CEP para o caso do processamento solicitado for por  ³
//³ clientes (SA1). Nao pode conter <branco> a <ZZZ> ou equivalente.           ³
//³ Deve ter um intervalo valido de CEP's.                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par17 == 1
	If mv_par05 == Space(Len(MV_PAR05))
		MsgStop("Verifique o Parametro CEP DE, pois o mesmo nao pode ser Branco !")
		Return
	EndIf
	
	If mv_par06 == Repl("9",Len(mv_par05)) .Or. Upper(mv_par06) == Repl("Z",Len(mv_par05))
		MsgStop("Verifique o Parametro CEP ATE, pois o mesmo nao pode ser sequencia de 9 ou Z")
		Return
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Valida geracao do mailing  - Verifica promocao               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
F_VERSZA()

IF mValida=='N'
	RETURN
ENDIF

mConta1   :=0
mConta2   :=0
mConta3   :=0

FArqTrab()

// Filtra() - Substituido por Dbsetorder(2) e DbSeek(xFilial()+mv_par01,.T.)
lEnd:= .F.
If mv_par17 == 2
	bBloco := {|lEnd| PRODUTOS(@lEnd)}
else
	bBloco := {|lEnd| CLIENTES(@lEnd)}
endif

MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )

MOSTRA()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza arquivo de controle  - saida de mailing             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
F_ATUZZ7()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     Execute(F_ATUZZ7)

While .T.
	If !Pergunte(cPerg)
		Exit
	Endif
	If LastKey()== 27
		Exit
	Endif
	// Filtra() - Substituido por Dbsetorder(2) e DbSeek(xFilial()+mv_par01,.T.)
	lEnd  := .F.
	If mv_par17==2
		bBloco := {|lEnd| PRODUTOS(@lEnd)}
	Else
		bBloco := {|lEnd| CLIENTES(@lEnd)}
	Endif
	MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
	MOSTRA()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida geracao do mailing  - Verifica promocao               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	F_VERSZA()
	IF mValida=='N'
		DbSelectArea(cArq)
		DbCloseArea()
		RETURN
	ENDIF
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza arquivo de controle  - saida de mailing             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	F_ATUZZ7()
End

DbGoTop()

wnrel := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)
SetDefault(aReturn,cString)

If nLastKey == 27
	DbSelectArea(cArq)
	DbCloseArea()
	Return
Endif

DbSelectArea(cArq)
cIndex := CriaTrab(Nil,.F.)
cKey   := "CEP+NOME+NDEST+CODCLI+CODDEST"
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")
dbGoTop()

RptStatus({|| Relatorio()})// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     RptStatus( {||Execute(Relatorio)} )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorna indices originais...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea(cArq)
DbCloseArea()

DbSelectArea("SC6")
Retindex("SC6")

DbSelectArea("SC5")
Retindex("SC5")

DbSelectArea("SA1")
Retindex("SA1")

DbSelectArea("SZO")
Retindex("SZO")

DbSelectArea("SZN")
Retindex("SZN")

DbSelectArea("SE1")
Retindex("SE1")

DbSelectArea("SB1")
Retindex("SB1")

DbSelectArea("SZL")
Retindex("SZL")

DbSelectArea("SZA")
Retindex("SZA")

DbSelectArea("ZZ7")
Retindex("ZZ7")

DbSelectArea("SZJ")
Retindex("SZJ")

DbSelectArea("SX5")
Retindex("SX5")

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ F_VERSZA                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Valida geracao do arquivo  de dados                           ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function F_VERSZA()
DBSELECTAREA("SZA")
DBGOTOP()
DBSEEK(XFILIAL("SZA")+MV_PAR11)
IF !FOUND()
	MsgStop("Promocao nao cadastrada")
	MsgStop("Entrar em contato com depto de Cadastro")
	mValida:="N"
ELSE
	DBSELECTAREA("SX5")
	DBGOTOP()
	DBSEEK(XFILIAL()+'91'+MV_PAR12)
	IF !FOUND()
		MsgStop("Mailing nao cadastrado")
		MsgStop("Entrar em contato com depto de Marketing")
		mValida:="N"
	ELSE
		mValida:="S"
	ENDIF
ENDIF
Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ FATUZZ7                                                       ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Atualiza arquivo de controle de utilizacao.                   ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function F_AtuZZ7()

DbSelectArea("ZZ7")
RecLock("ZZ7",.T.)
REPLACE ZZ7_CODPRO With MV_PAR11
REPLACE ZZ7_CODMAI With MV_PAR12
REPLACE ZZ7_USUAR  With Subs(cUsuario,7,15)
REPLACE ZZ7_DATA   With Date()
REPLACE ZZ7_QTDE   With mConta1
REPLACE ZZ7_SAIDA  With MSAIDA
REPLACE ZZ7_PROD1  With MV_PAR01
REPLACE ZZ7_PROD2  With MV_PAR02
REPLACE ZZ7_CEP1   With MV_PAR05
REPLACE ZZ7_CEP2   With MV_PAR06
REPLACE ZZ7_ATIV1  With MV_PAR13
REPLACE ZZ7_ATIV2  With MV_PAR14
REPLACE ZZ7_TPCLI  With Str(MV_PAR15,1)
REPLACE ZZ7_UTILIZ With Str(MV_PAR16,1)
REPLACE ZZ7_DUPLIC With Str(MV_PAR10,1)
REPLACE ZZ7_SITUAC With Str(MV_PAR08,1)
REPLACE ZZ7_TPVEND With Str(MV_PAR07,1)
MsUnLock()

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ Filtra()                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Filtra arquivo SC6 para ser utilizado no programa.            ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³ FUNCAO NAO UTILIZADA A PARTIR DE 03.05.2000                   ³
//³           ³ Em seu lugar passou a ser utilizado o seguinte : DbSetOrder(2)³
//³           ³ e DbSeek(xfilial()+mv_par01) e If..Skip..Loop..Endif          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function FILTRA()

DbSelectArea("SC6")
DbGoTop()

IF FILTRO
	cChave  := IndexKey()
	cFiltro := 'DTOS(C6_DATFAT) >= "'+DTOS(MV_PAR03)+'" .AND. DTOS(C6_DATFAT) <= "'+DTOS(MV_PAR04)+'"'
	cFiltro := Alltrim(cFiltro)+' .AND. C6_PRODUTO >= "'+MV_PAR01+'" .AND. C6_PRODUTO <= "'+MV_PAR02+'"'
	cFiltro := Alltrim(cFiltro)+'.AND.C6_CLI<>"040000"'
	cInd    := CriaTrab(NIL,.f.)
	MsAguarde({|| IndRegua("SC6",cInd,cChave,,cFiltro,"Filtrando Itens de Pedidos...")},"Aguarde","Gerando Indice Temporario(SC6)..")
ENDIF

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ PRODUTOS()                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Realiza leitura dos registros do SC6 ja filtrado e aplica     ³
//³           ³ restante dos filtros de parametros. Prepara os dados para     ³
//³           ³ serem gravados. Faz chamada a funcao GRAVA.                   ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function PRODUTOS()

mConta := 0
DbSelectArea("SC6")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ordem 2 + DbSeek, substituindo o filtro indregua anteriormente    ³
//³usado. Gilberto - 03.05.2000                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSetOrder(2)
DbGoTop()
DbSeek(xFilial("SC6")+MV_PAR01,.T.)

If ( SC6->C6_PRODUTO > MV_PAR02 )
	MsgStop("Nao Existem Dados para serem apurados !")
Endif

While !EOF() .And. (mConta1 < MV_PAR09) .And. (SC6->C6_PRODUTO <= MV_PAR02)
	MsProcTxt("Lendo Registros : "+StrZero(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtro:Deixa passar apenas o que estiver de acordo com os    ³
	//³ parametros.                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IF MV_PAR15 <> 1 .AND. MV_PAR15 <> 2
		IF DTOS(SC6->C6_DATFAT) < DTOS(MV_PAR03) .OR. DTOS(SC6->C6_DATFAT) > DTOS(MV_PAR04)
			DbSkip()
			Loop
		ENDIF
	ENDIF
	
	IF (SC6->C6_PRODUTO < MV_PAR01)
		DbSkip()
		Loop
	ENDIF
	
	IF ALLTRIM(SC6->C6_CLI) == "040000"
		DbSkip()
		Loop
	ENDIF
	
	//** GILBERTO - 25.09.2000
	dbSelectArea("SZN")
	If dbSeek(xFilial("SZN")+SC6->C6_CLI+SC6->C6_CODDEST )
		If !Empty(SZN->ZN_SITUAC)
			dbSelectArea("SC6")
			dbSkip()
			Loop
		EndIf
	EndIf
	
	dbSelectArea("SC6")
	mPedido  := ""
	mItem    := ""
	mCodCli  := ""
	mCodDest := ""
	mProd    := ""
	mCF      := ""
	mCEP     := ""
	mValor   := 0
	mNomeCli := ""
	mDest    := ""
	mEnd     := ""
	mMun     := ""
	mEst     := ""
	mFone    := ""
	mCGC     := ""
	mDTPG    := stod("")
	mDTFat   := stod("")
	mDTPG2   := stod("")
	mFilial  := ""
	mBairro  := ""
	mPago    := 0
	mPgto    := 0
	mParc    := 0
	mAberto  := 0
	mVend    := ""
	mEdvenc  := ""
	mEdsusp  := ""
	mGrava   := ""
	mDtVenc  := stod("")
	mSituac  := " "
	mGrat    := " "
	mProd    := SC6->C6_PRODUTO
	mCodRev  := Padr(SUBS(SC6->C6_PRODUTO,1,4),4)
	mDTFat   := SC6->C6_DATFAT
	mCodCli  := SC6->C6_CLI
	mPedido  := SC6->C6_NUM
	mItem    := SC6->C6_ITEM
	mValor   := SC6->C6_VALOR
	mCF      := AllTrim(SC6->C6_CF)
	mCodDest := SC6->C6_CODDEST
	mFilial  := SC6->C6_FILIAL
	mEdvenc  := SC6->C6_EDVENC
	mEdsusp  := SC6->C6_EDSUSP
	mSituac  := SC6->C6_SITUAC
	
	DbSelectArea ("SC5")
	DbGoTop()
	DbSeek(xFilial("SC5")+mPedido)
	
	If Found()
		mVend    := C5_VEND1
		mRespcob := C5_RESPCOB
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se a assinatura esta ativa                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MV_PAR15 == 2  .AND. !EMPTY(SC6->C6_PEDREN)
		DbSelectArea("SC6")
		DbSkip()
		Loop
	Endif
	
	If MV_PAR15 == 1 .or. MV_PAR15 == 2
		
		IF SUBSTR(MV_PAR01,1,4) >= '1000' .AND. SUBSTR(MV_PAR02,1,4) <= '1105'
			mCodRev := '9999'
		ENDIF
		
		DbSelectArea ("SZJ")
		DbSetOrder(1)
		DbGoTop()
		DbSeek(xFilial("SZJ")+mCodRev+Str(MEDSUSP,4))
		If MV_PAR15 == 2
			If DTOS(SZJ->ZJ_DTCIRC) < DTOS(MV_PAR03) .OR. DTOS(SZJ->ZJ_DTCIRC) > DTOS(MV_PAR04)
				DbSelectArea("SC6")
				DbSkip()
				Loop
			Else
				mDtvenc := SZJ->ZJ_DTCIRC
			Endif
		Endif
		If MV_PAR15 == 1
			If DTOS(SZJ->ZJ_DTCIRC) < DTOS(DDATABASE)
				DbSelectArea("SC6")
				DbSkip()
				Loop
			Else
				mDtvenc := SZJ->ZJ_DTCIRC
			Endif
		Endif
		If Subs(SC6->C6_PRODUTO,5,3) == '001'
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o registro faz parte do cad de representante        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MV_PAR18 == 2
		DbSelectArea("SZL")
		DbGoTop()
		DbSeek(xFilial("SZL")+MCODCLI)
		
		If Found()
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Elimina duplicidade por codigo de cliente e destinat rio     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MV_PAR10 == 1
		DbSelectArea(cArq)
		DbGoTop()
		DbSeek(mCodCli+mCodDest)
		If Found()
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
	Endif
	
	DbSelectArea("SF4")
	DbSetOrder(1)
	DbGoTop()
	DbSeek(xFilial("SF4")+SC6->C6_TES)
	If SF4->F4_DUPLIC == 'N'
		IF 'CORTESIA' $(SF4->F4_TEXTO).OR.'DOACAO' $(SF4->F4_TEXTO)
			mGrat := 'S'
		Endif
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se ‚ cortesia para parƒmetro=pago                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MV_PAR07 == 1 .And. mGrat == 'S'
		DbSelectArea("SC6")
		DbSkip()
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se ‚ pago para parƒmetro=cortesia                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MV_PAR07 == 2 .AND. mGrat <> 'S'
		DbSelectArea("SC6")
		DbSkip()
		Loop
	Endif
	
	DbSelectArea("SE1")
	DbGoTop()
	DbSeek(xFilial("SE1")+mPedido)
	If Found()
		MDTPG := SE1->E1_BAIXA
		While ( SE1->E1_PEDIDO == MPEDIDO )
			mParc  := mParc+1
			mDTPG2 := SE1->E1_BAIXA
			If !Empty(MDTPG2) .And. E1_SALDO == 0 .AND. SUBS(ALLTRIM(SE1->E1_MOTIVO),1,2) <> 'LP';
				.AND. SUBS(ALLTRIM(SE1->E1_MOTIVO),1,4) <> 'CANC'
				mPago := mPago+1
			Else
				If DTOS(SE1->E1_VENCTO+30) < DTOS(DDATABASE)
					mAberto := mAberto+1
				Endif
			Endif
			DbSkip()
		End
		mPGTO := mPAGO/mPARC
	Else
		mAberto := 99999
	Endif
	
	DbSelectArea("SC6")
	If SUBS(SC6->C6_CF,2,2) == "99"
		mAberto := 0
	Endif
	
	If MV_PAR08 == 1
		If mAberto <> 0
			DbSkip()
			Loop
		Endif
	Endif
	
	If MV_PAR08 == 2
		If mAberto == 0
			DbSkip()
			Loop
		Endif
	Endif
	
	GRAVA()
	
	DbSelectArea("SC6")
	If EOF()
		Exit
	Else
		DbSkip()
	Endif
End

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ GRAVA()                                                       ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Realiza gravacao dos registros ideais (conforme parametros)   ³
//³           ³ para impressao de Relatorio.                                  ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function GRAVA()

DbSelectArea("SB1")
DBSETORDER(1)
DbSeek(xFilial("SB1")+mProd)
If Found()
	mTitulo:=SB1->B1_DESC
Else
	mTitulo:="  "
Endif


/*
// -----------> 29/05/03 - INICIO
IF mv_par15 == 3 .and. SB1->B1_GRUPO <> '1001'
	EXIT
ENDIF
// -----------> 29/05/03 - FIM
*/

_lSeek:= .t.

If mv_par17==2
	// Observacao : S¢ executa o bloco abaixo caso o
	// processamento seja pelo produto, pois se for por
	// cliente o SA1 j  est  posicionado.
	DbSelectArea("SA1")
	DbGoTop()
	_lSeek:= DbSeek(xFilial("SA1")+mCodCli)
EndIf

If _lSeek
	mNomeCli := SA1->A1_NOME
	mEnd     := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060327
	mBairro  := SA1->A1_BAIRRO
	mMun     := SA1->A1_MUN
	mEst     := SA1->A1_EST
	mCEP     := SA1->A1_CEP
	mFone    := SA1->A1_TEL
	mDest    := SPACE(40)
	mCGC     := SA1->A1_CGC
	mFone    := SA1->A1_TEL
	mEmail   := SA1->A1_EMAIL
	mFax     := SA1->A1_FAX
	mAtiv    := SA1->A1_ATIVIDA
	mTpCli   := SA1->A1_TPCLI
Else
	mNomeCli := SPACE(40)
Endif

If mNomeCli <> "  "
	If mCodDest # " "
		DbSelectArea("SZN")
		DbSeek(xFilial("SZN")+mCodCli+mCodDest)
		If Found()
			mDest:= SZN->ZN_NOME
		Endif
		DbSelectArea("SZO")
		DbSeek(xFilial("SZO")+mCodCli+mCodDest)
		If Found()
			mEnd    := ALLTRIM(SZO->ZO_TPLOG) + " " + ALLTRIM(SZO->ZO_LOGR) + " " + ALLTRIM(SZO->ZO_NLOGR) + " " + ALLTRIM(SZO->ZO_COMPL) //20060327
			mBairro := SZO->ZO_BAIRRO
			mMun    := SZO->ZO_CIDADE
			mEst    := SZO->ZO_ESTADO
			mCEP    := SZO->ZO_CEP
			mFone1  := SZO->ZO_FONE
			If mFone1 <> "  "
				mFone:= mFone1
			Endif
		Endif
	Endif
Endif

If mCEP >= MV_PAR05 .And. MCEP <= MV_PAR06 .And. ;
	mCodCli <> "  " .And. mAtiv >= MV_PAR13 .And. mAtiv <= MV_PAR14
	mGrava := "S"
Endif

If MV_PAR15 == 2 .and. mTpCli == 'R'
	mGrava := "N"
Endif

If MV_PAR16 == 2 .And. Empty(mFone)
	mGrava := "N"
Endif

If MV_PAR19 == 1 .and. mTpCli <> 'F'
	mGrava := "N"
Endif

If MV_PAR19 == 2 .and. mTpCli <> 'J'
	mGrava := "N"
Endif

If mGrava == "S"
	
	mConta1++
	MsProcTxt("Lendo Registros : "+StrZero(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
	
	DbSelectArea(cArq)
	RecLock(cArq,.T.)
	REPLACE Ped      With  mPedido
	REPLACE Item     With  mItem
	REPLACE CodCli   With  mCodCli
	REPLACE CodDest  With  mCodDest
	REPLACE Prod     With  mProd
	REPLACE CF       With  mCF
	REPLACE CEP      With  mCEP
	REPLACE Valor    With  mValor
	REPLACE Nome     With  mNomeCli
	REPLACE NDest    With  mDest
	REPLACE V_END    With  mEnd
	REPLACE Bairro   With  mBairro
	REPLACE MUN      With  mMun
	REPLACE UF       With  mEst
	REPLACE Fone     With  mFone
	REPLACE Fax      With  mFax
	REPLACE EMAIL    With  mEMAIL
	REPLACE CGC      With  mCGC
	REPLACE DTPGTO   With  mDTPG
	REPLACE DTFAT    With  mDTFAT
	REPLACE PGTO     With  mPGTO
	REPLACE EMABERTO With  mAberto
	REPLACE PARCELA  With  mParc
	REPLACE Descr    With  mTitulo
	REPLACE Vend     With  mVend
	REPLACE EDVENC   With  mEDVENC
	REPLACE Edsusp   With  mEdsusp
	REPLACE Situac   with  mSituac
	REPLACE Respcob  with  mRespcob
	MsUnlock()
Endif

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ LIMPA()                                                       ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Limpa tela para proximo Display.                              ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³ Utilizado apenas para Windows.                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function LIMPA
Static Function LIMPA()

//@ 10,05 clear TO 10,70
//@ 11,05 clear TO 10,70
//@ 12,05 clear TO 10,70
//@ 13,05 clear TO 10,70
//@ 14,05 clear TO 10,70

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ MOSTRA()                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Mostra o resultado final da apuracao dos registros que serao  ³
//³           ³ impressos no relatorio.                                       ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function MOSTRA()

@ 200,001 TO 400,450 DIALOG oDlg TITLE " Confirme ... "
@ 003,010 TO 090,220
@ 15,018 Say "Produto................: "+Trim(MV_PAR01)+ " A " + Trim(MV_PAR02)
@ 30,018 Say "CEP....................: "+MV_PAR05      + " A " + MV_PAR06
@ 45,018 SAY "Quantidade Selecionada.: "+STRZERO(MV_PAR09,7,0)
@ 60,018 SAY "Quantidade Mailing.....: "+STRZERO(MCONTA1 ,7,0)
@ 75,188 BMPBUTTON TYPE 01 ACTION Close(oDlg)
Activate Dialog oDlg Centered

Return

Static FUNCTION IMPR3()

IF L<>0
	IF L==64 .OR. L+10>=64
		L:=0
	ELSE
		L:=L+1
	ENDIF
ENDIF

RETURN

Static FUNCTION IMPR4()

IF L<>0
	IF L == 64
		L := 0
	ELSE
		L++
	ENDIF
ENDIF

RETURN

Static FUNCTION IMPR2()

IF L==0
	L++
	CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho,nCaracter)
	L += 4
	@ L,00 PSAY REPLICATE('*',79)
	L += 2
ENDIF

RETURN

Static FUNCTION CABEC2()

@ L,01 PSAY 'TITULO'
@ L,27 PSAY 'PEDIDO'
@ L,34 PSAY 'ITEM'
@ L,39 PSAY 'SUSP'
@ L,44 PSAY 'ED.INI'
@ L,51 PSAY 'ED.VEN'
@ L,59 PSAY 'VENC/FAT'
@ L,68 PSAY 'VALOR'
@ L,75 PSAY 'VEND'

RETURN

Static FUNCTION EXTRATO()

@ L,01 PSAY '('+mSituac+')'+SUBS(TRIM(mTitulo),1,25)
@ L,27 PSAY TRIM(mPedido)
@ L,34 PSAY TRIM(mItem)
@ L,39 PSAY STR(mEdsusp,4)
@ L,44 PSAY STR(mEdinic,4)
@ L,51 PSAY STR(mEdvenc,4)
@ L,59 PSAY mDtvenc
@ L,68 PSAY LTRIM(STR(mValor,7,2))
@ L,75 PSAY TRIM(mVend)

RETURN

Static FUNCTION RELATORIO()

MCONTA := 0
DBSELECTAREA(cArq)
SETREGUA(RECCOUNT())
DBGOTOP()
WHILE !EOF()
	MCONTA++
	IncRegua()
	IMPR3()
	IMPR2()
	DBSELECTAREA(cArq)
	MCHAVE  := CODCLI+CODDEST
	MCHAVE2 := CODCLI+CODDEST
	@ L,01   PSAY 'COD CLI...: '+CODCLI
	@ L,27   PSAY 'COD DEST..: '+CODDEST
	@ L,54   PSAY 'FONE....:'   +TRIM(FONE)
	@ L+1,01 PSAY 'NOME......: '+NOME
	@ L+1,54 PSAY 'CPF/CGC.:'   +TRIM(CGC)
	@ L+2,01 PSAY 'DEST......: '+NDEST +'/'+RESPCOB
	@ L+3,01 PSAY 'ENDERECO..: '+V_END
	@ L+4,01 PSAY 'BAIRRO..:'   +BAIRRO
	@ L+4,54 PSAY 'CIDADE/EST: '+TRIM(MUN)+' '+UF
	@ L+5,01 PSAY 'CEP.......: '+SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)
	@ L+5,54 PSAY 'EM ABERTO.: '+LTRIM(STR(EMABERTO))+'/'+LTRIM(STR(PARCELA))
	L += 6
	CABEC2()
	WHILE MCHAVE2 == MCHAVE
		DBSELECTAREA(cArq)
		IMPR4()
		IMPR2()
		IF L == 0
			CABEC2()
			L++
		ENDIF
		mEdsusp := " "
		mEdvenc := " "
		mEdinic := " "
		mDtvend := " "
		mSituac := SITUAC
		mPedido := PED
		mItem   := ITEM
		mEdvenc := EDVENC
		mEdsusp := EDSUSP
		mCodrev := Subs(PROD,1,4)
		mValor  := VALOR
		mTitulo := TRIM(SUBS(PROD,1,10))+' '+TRIM(SUBS(DESCR,1,10))
		mVend   := VEND
		mDtfat  := DTFAT
		DbSelectArea ("SZJ")
		DbGoTop()
		
		IF SUBSTR(MV_PAR01,1,4) >= '1000' .AND. SUBSTR(MV_PAR02,1,4) <= '1105'
			mCodRev := '9999'
		ENDIF
		
		DbSeek(xFilial("SZJ")+mCodRev+Str(MEDVENC,4))
		If Found()
			mDtvenc := SZJ->ZJ_DTCIRC
		else
			mDtvenc := mDtfat
		Endif
		DbSelectArea ("SC6")
		DbsetOrder(1)
		DbGoTop()
		DbSeek(xFilial("SC6")+mPedido+mItem)
		If Found()
			mEdsusp:=SC6->C6_EDSUSP
			mEdinic:=SC6->C6_EDINIC
		Endif
		EXTRATO()
		IF EOF()
			EXIT
		ELSE
			DBSELECTAREA(cArq)
			DBSKIP()
			MCHAVE2 := CODCLI+CODDEST
			IF MCHAVE2 <> MCHAVE
				IF L <> 0
					L++
					@ L,00 SAY REPLICATE('_',79)
				ENDIF
				IMPR2()
				EXIT
			ENDIF
			LOOP
		ENDIF
	END
	IF EOF()
		IMPR3()
		@ L+3,00 PSAY 'TOTAL DE REGISTROS.....'+STR(MCONTA1,7,0)
		@ L+4,00 PSAY 'TOTAL DE CLIENTES......'+STR(MCONTA,7,0)
		EXIT
	ENDIF
END
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do Relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SET DEVICE TO SCREEN

IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()

RETURN
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ FARQTRAB()                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Cria arquivo de trabalho para guardar registros que serao     ³
//³           ³ impressos em forma de etiquetas.                              ³
//³           ³ serem gravados. Faz chamada a funcao GRAVA.                   ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function FARQTRAB
Static Function FARQTRAB()

_aCampos := {}
AADD(_aCampos,{"PED"	,"C"	,6	,0})
AADD(_aCampos,{"ITEM"	,"C"	,2	,0})
AADD(_aCampos,{"CF"		,"C"	,5	,0})
AADD(_aCampos,{"CODCLI"	,"C"	,6	,0})
AADD(_aCampos,{"CODDEST","C"	,6	,0})
AADD(_aCampos,{"NOME"	,"C"	,40	,0})
AADD(_aCampos,{"NDEST"	,"C"	,40	,0})
AADD(_aCampos,{"V_END"	,"C"	,120	,0})
AADD(_aCampos,{"BAIRRO"	,"C"	,20	,0})
AADD(_aCampos,{"MUN"	,"C"	,20	,0})
AADD(_aCampos,{"UF"		,"C"	,2	,0})
AADD(_aCampos,{"CEP"	,"C"	,8	,0})
AADD(_aCampos,{"CGC"	,"C"	,14	,0})
AADD(_aCampos,{"FONE"	,"C"	,20	,0})
AADD(_aCampos,{"FAX"	,"C"	,20	,0})
AADD(_aCampos,{"EMAIL"	,"C"	,20	,0})
AADD(_aCampos,{"PROD" 	,"C"	,15	,0})
AADD(_aCampos,{"DESCR"	,"C"	,40	,0})
AADD(_aCampos,{"DTPGTO"	,"D"	,8	,0})
AADD(_aCampos,{"DTFAT "	,"D"	,8	,0})
AADD(_aCampos,{"VALOR"	,"N"	,12	,2})
AADD(_aCampos,{"PGTO"	,"N"	,5	,2})
AADD(_aCampos,{"EMABERTO","N"	,5	,0})
AADD(_aCampos,{"PARCELA","N"	,5	,0})
AADD(_aCampos,{"VEND"	,"C"	,6	,0})
AADD(_aCampos,{"EDVENC"	,"N"	,4	,0})
AADD(_aCampos,{"EDSUSP"	,"N"	,4	,0})
AADD(_aCampos,{"SITUAC"	,"C"	,2	,0})
AADD(_aCampos,{"RESPCOB","C"	,40	,0})

_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "CodCli+CodDEst"

dbUseArea(.T.,, _cNome,cArq,.F.,.F.)
dbSelectArea(cArq)
MsAguarde({|| Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")},"Aguarde","Gerando Indice Temporario..")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ INDEXA SE1                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SE1")
DbOrderNickName("E1_PEDIDO") //dbSetOrder(27) 20130225  ///dbSetOrder(15) AP5 //20090114 era(21) //20090723 mp10 era(22) //dbSetOrder(26) 20100412
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ INDEXA SZL                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SZL")
cIndex := CriaTrab(Nil,.F.)
cKey   := "ZL_FILIAL+ZL_CODCLI"
MsAguarde({|| Indregua("SZL",cIndex,ckey,,,"Selecionando Registros do Arq")},"Aguarde","Gerando Indice Temporario (SZL)...")
//Retindex("SZL")
//mInd2:=Retindex("SZL")
//DbSetOrder(mInd2+1)
DbGoTop()

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ CLIENTES()   ³ Data ³ 28.05.2000 ³ Por³ Gilberto A. Oliveira  ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Realiza leitura dos registros do SA1, filtra por escopo, con- ³
//³           ³ forme os parametro mv_17 e aplica os outros filtros.          ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³ Funcao clone da PRODUTOS, cuja a prioridade e o SA1.             ³
//³           ³ Para diminuir o tempo que se leva para conseguir etiquetas de ³
//³           ³ poucos CEP's.                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function CLIENTES()

mConta := 0

DbSelectArea("SA1")
DbSetOrder(6)
DbSeek(xFilial("SA1")+MV_PAR05, .T.)

If SA1->A1_CEP > MV_PAR06
	MsgStop("O intervalo de CEP's nao foi encontrado no Cad.de Clientes!")
EndIf

Do While !EOF() .And. ( mConta1 < MV_PAR09 ) .And. ( SA1->A1_CEP <= MV_PAR06 )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtro:Deixa passar apenas o que estiver de acordo com os    ³
	//³ parametros.                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("SC6")
	DbSetOrder(5)
	DbSeek(xFilial("SC6")+SA1->A1_COD+SA1->A1_LOJA)
	
	If !Found()
		DbSelectArea("SA1")
		DbSkip()
		Loop
	EndIf
	
	While !Eof() .and. (SC6->C6_CLI+SC6->C6_LOJA) == (SA1->A1_COD+SA1->A1_LOJA) .And. !Eof()	.And. SC6->C6_FILIAL == xFilial()
		
		MsProcTxt("Lendo Registros : "+Str(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
		
		If MV_PAR15 <> 1 .AND. MV_PAR15 <> 2
			If DTOS(SC6->C6_DATFAT) < DTOS(MV_PAR03) .Or. DTOS(SC6->C6_DATFAT) > DTOS(MV_PAR04)
				DbSkip()
				Loop
			EndIf
		Endif
/*		
		IF (SC6->C6_PRODUTO < MV_PAR01) .Or. DTOS(SC6->C6_PRODUTO) > DTOS(MV_PAR02)
			DbSkip()
			Loop
		ENDIF
*/		
		IF (SC6->C6_PRODUTO < MV_PAR01) .Or. (SC6->C6_PRODUTO > MV_PAR02)
			DbSkip()
			Loop
		ENDIF

		IF ALLTRIM(SC6->C6_CLI) == "040000"
			DbSkip()
			Loop
		ENDIF
		
		//** GILBERTO - 25.09.2000
		
		dbSelectArea("SZN")
		If dbSeek( xFilial("SZN")+SC6->C6_CLI+SC6->C6_CODDEST )
			If !Empty(SZN->ZN_SITUAC)
				dbSelectArea("SC6")
				dbSkip()
				Loop
			EndIf
		EndIf
		dbSelectArea("SC6")
		
		mPedido  := ""
		mItem    := ""
		mCodCli  := ""
		mCodDest := ""
		mProd    := ""
		mCF      := ""
		mCEP     := ""
		mValor   := 0
		mNomeCli := ""
		mDest    := ""
		mEnd     := ""
		mMun     := ""
		mEst     := ""
		mFone    := ""
		mCGC     := ""
		mDTPG    := stod("")
		mDTFat   := stod("")
		mDTPG2   := stod("")
		mFilial  := ""
		mBairro  := ""
		mPago    := 0
		mPgto    := 0
		mParc    := 0
		mAberto  := 0
		mVend    := ""
		mEDVENC  := ""
		mGrava   := ""
		mDtVenc  := stod("")
		mSituac  := " "
		mGrat    := " "
		mProd    := SC6->C6_PRODUTO
		mCodRev  := SUBS(SC6->C6_PRODUTO,1,4)
		mDTFat   := SC6->C6_DATFAT
		mCodCli  := SC6->C6_CLI
		mPedido  := SC6->C6_NUM
		mItem    := SC6->C6_ITEM
		mValor   := SC6->C6_VALOR
		mCF      := Alltrim(SC6->C6_CF)
		mCodDest := SC6->C6_CODDEST
		mFilial  := SC6->C6_FILIAL
		mEDVENC  := SC6->C6_EDVENC
		mEdsusp  := SC6->C6_EDSUSP
		mSituac  := SC6->C6_SITUAC
		
		DbSelectArea ("SC5")
		DbGoTop()
		DbSeek(xFilial("SC5")+mPedido)
		
		If Found()
			mVend    := C5_VEND1
			mRespcob := C5_RESPCOB
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se a assinatura esta ativa                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If MV_PAR15 == 2  .AND. !EMPTY(SC6->C6_PEDREN)
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
		
		If MV_PAR15 == 1 .or. MV_PAR15 == 2
			DbSelectArea ("SZJ")
			DbGoTop()
			
			IF SUBSTR(MV_PAR01,1,4) >= '1000' .AND. SUBSTR(MV_PAR02,1,4) <= '1105'
				mCodRev := '9999'
			ENDIF
			
			DbSeek(xFilial("SZJ")+mCodRev+Str(MEDSUSP,4))
			If MV_PAR15==2
				If SZJ->ZJ_DTCIRC < MV_PAR03 .OR. SZJ->ZJ_DTCIRC > MV_PAR04
					DbSelectArea("SC6")
					DbSkip()
					Loop
				Else
					mDtvenc := SZJ->ZJ_DTCIRC
				Endif
			Endif
			
			If MV_PAR15 == 1
				If SZJ->ZJ_DTCIRC < DATE()
					DbSelectArea("SC6")
					DbSkip()
					Loop
				Else
					mDtvenc := SZJ->ZJ_DTCIRC
				Endif
			Endif
			
			If Subs(SC6->C6_PRODUTO,5,3) == '001'
				DbSelectArea("SC6")
				DbSkip()
				Loop
			Endif
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica o registro faz parte do cad de representante        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If MV_PAR18 == 2
			DbSelectArea("SZL")
			DbGoTop()
			DbSeek(xFilial("SZL")+MCODCLI)
			
			If Found()
				DbSelectArea("SC6")
				DbSkip()
				Loop
			Endif
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Elimina duplicidade por codigo de cliente e destinat rio     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If MV_PAR10 == 1
			DbSelectArea(cArq)
			DbGoTop()
			DbSeek(mCodCli+mCodDest)
			If Found()
				DbSelectArea("SC6")
				DbSkip()
				Loop
			Endif
		Endif
		
		DbSelectArea("SF4")
		DbSetOrder(1)
		DbGoTop()
		DbSeek(xFilial("SF4")+SC6->C6_TES)
		If SF4->F4_DUPLIC=='N'
			IF 'CORTESIA' $(SF4->F4_TEXTO).OR.'DOACAO' $(SF4->F4_TEXTO)
				mGrat:='S'
			Endif
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se ‚ cortesia para parƒmetro=pago                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If MV_PAR07==1 .And. mGrat=='S'
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se ‚ pago para parƒmetro=cortesia                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If MV_PAR07==2 .AND. mGrat<>'S'
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
		
		DbSelectArea("SE1")
		DbGoTop()
		DbSeek(xFilial("SE1")+mPedido)
		
		If Found()
			MDTPG := SE1->E1_BAIXA
			While ( SE1->E1_PEDIDO == MPEDIDO ) .And. !Eof()
				mParc := mParc+1
				mDTPG2:= SE1->E1_BAIXA
				If !Empty(MDTPG2) .And. SE1->E1_SALDO == 0;
					.AND. SUBS(ALLTRIM(SE1->E1_MOTIVO),1,2) <> 'LP';
					.AND. SUBS(ALLTRIM(SE1->E1_MOTIVO),1,4) <> 'CANC'
					mPago:=mPago+1
				Else
					If SE1->E1_VENCTO+30 < DATE()
						mAberto:=mAberto+1
					Endif
				Endif
				DbSkip()
			End
			mPGTO   := mPAGO/mPARC
		Else
			mAberto := 99999
		Endif
		
		DbSelectArea("SC6")
		If SUBS(SC6->C6_CF,2,2) == "99"
			mAberto := 0
		Endif
		
		If MV_PAR08 == 1
			If mAberto <> 0
				DbSkip()
				Loop
			Endif
		Endif
		If MV_PAR08 == 2
			If mAberto == 0
				DbSkip()
				Loop
			Endif
		Endif
		
		GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>  Execute(GRAVA)
		
		DbSelectArea("SC6")
		If EOF()
			Exit
		Else
			DbSkip()
		Endif
	End
	DbSelectArea("SA1")
	DbSkip()
End

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
Static Function _ValidPerg()

_sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs:={}

//          Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3
AADD(aRegs,{cPerg,"01","Do Produdo.........:","mv_ch1","C",15,0,0,"G","","mv_par01","","0108001","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"02","At‚ o Produto......:","mv_ch2","C",15,0,0,"G","","mv_par02","","0108003","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"03","Faturados/Venc de.:","mv_ch3","D",08,0,0,"G","","mv_par03","","'01/06/99'","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Faturados/Venc at‚.:","mv_ch4","D",08,0,0,"G","","mv_par04","","'17/04/00'","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Do CEP.............:","mv_ch5","C",08,0,0,"G","","mv_par05","","12000000","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"06","At‚ CEP............:","mv_ch6","C",08,0,0,"G","","mv_par06","","12999999","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"07","Tipo...............:","mv_ch7","C",01,0,3,"C","","mv_par07","Pagos","","","Cortesias","","","Ambas","","","","","","","",""})
AADD(aRegs,{cPerg,"08","Situa‡Æo...........:","mv_ch8","C",01,0,3,"C","","mv_par08","Baixados","","","Em aberto","","","Ambas","","","","","","","",""})
AADD(aRegs,{cPerg,"09","Qtde da Selecao....:","mv_ch9","N",07,0,3,"G","","mv_par09","","9999999","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"10","Elimina duplicidade:","mv_chA","C",01,0,1,"C","","mv_par10","Sim","ZZZZZZZ","","Nao","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"11","Cod. Promo‡Æo......:","mv_chB","C",03,0,1,"G","","mv_par11","","N","","","","","","","","","","","","","SZA"})
AADD(aRegs,{cPerg,"12","Cod. Mailing.......:","mv_chC","C",03,0,1,"G","","mv_par12","","107","","","","","","","","","","","","","91"})
AADD(aRegs,{cPerg,"13","Da Atividade.......:","mv_chD","C",07,0,0,"G","","mv_par13","","","","","","","","","","","","","","","ZZ8"})
AADD(aRegs,{cPerg,"14","At‚ Atividade......:","mv_chE","C",07,0,0,"G","","mv_par14","","ZZZZZZZ","","","","","","","","","","","","","ZZ8"})
AADD(aRegs,{cPerg,"15","Tipo Cliente.......:","mv_chF","C",01,0,3,"C","","mv_par15","Ass. Ativos","","","Ass. Cancelados","","","Outros","","","","","","","",""})
AADD(aRegs,{cPerg,"16","Utilizacao.........:","mv_chG","C",01,0,1,"C","","mv_par16","Mala Direta","","","Telemarketing","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"17","Processa por.......:","mv_chH","C",01,0,1,"C","","mv_par17","Clientes","","","Produtos","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"18","Inclui Representante","mv_chI","C",01,0,1,"C","","mv_par18","Sim","","","NÆo","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"19","Natureza do Cliente:","mv_chj","C",01,0,1,"C","","mv_par19","Fisica","","","Juridica","","","Ambas","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		SX1->(MsUnlock())
	Endif
Next

DbSelectArea(_sAlias)

Return
