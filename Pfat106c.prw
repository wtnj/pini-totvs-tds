#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
/*/
//Danilo C S Pala 20060327: dados de enderecamento do DNE
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT106   ³Autor: Raquel Farias          ³ Data:   27/07/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera arquivo de clientes por produto                       ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Altera‡Æo           ³Alterado por: Raquel Farias   ³ Data:   10/04/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Acrescentei consistencia de e1_hist == 'LP'                ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Liberado para Usu rio em: 11/04/00                                    ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± Observacao : Os progamas PFAT106E, PFAT106R e PFAT106C eram originalmen-±±
±± te um s¢ que funcionava apenas para DOS. Por ocasiÆo da conversao para  ±±
±± funcionamento em Windows decidiu-se que para melhor compreensÆo do pro- ±±
±± grama e afim de se seguir o padrÆo Microsiga era melhor separar o pro-  ±±
±± grama de acordo com suas funcoes principais : Relatorio, Etiquetas e    ±±
±± Geracao de Arquivo.Foram criados,portando,os RDMAKES acima citados.     ±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³PFAT106C.PRX        ³ Gilberto A. de Oliveira Jr.  ³ Data:   16/04/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Alteracoes:         ³                                                 ³ ±±
±±³Gilberto - 16.04.00 ³Conversao p/ Windows, separacao do antigo PFAT106³ ±±
±±³                    ³e substituicao de indices temporarios.           ³ ±±
±±³Gilberto - 18.05.00 ³MV_PAR17, prioridade de processamento.           ³ ±±
±±³                    ³Clientes ou Produtos. Quando clientes cria indice³ ±±
±±³                    ³temporario por A1_CEP para o SA1 e processa pelo ³ ±±
±±³                    ³                                                 ³ ±±
±±³                    ³                                                 ³ ±±
±±³Raquel - 21.08.00   ³Acrescentei grava‡Æo de 12 campos de controle no ³ ±±
±±³                    ³ZZ7.                                             ³ ±±
±±³                    ³Acrescentei valida‡Æo para assinaturas:          ³ ±±
±±³                    ³Se o mv_par16<>1 e Mv_par16<>2 o programa traba- ³ ±±
±±³                    ³lha comparando a data de faturamento, se nÆo tra-³ ±±
±±³                    ³balha comparando a data de circula‡Æo.           ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat106c()

SetPrvt("MCONTA1,MCONTA2,MCONTA3,MHORA,CARQ,CSTRING")
SetPrvt("MSAIDA,CARQPATH,_CSTRING,CPERG,LEND,BBLOCO")
SetPrvt("CMSG,MVALIDA,CCHAVE,CIND,MIND2,MCONTA")
SetPrvt("MPEDIDO,MITEM,MCODCLI,MCODDEST,MPROD,MCF")
SetPrvt("MCEP,MVALOR,MQTDE,MNOMECLI,MRESPCOB,MDEST")
SetPrvt("MEND,MMUN,MEST,MFONE,MCGC,MDTPG")
SetPrvt("MDTFAT,MDTPG2,MFILIAL,MBAIRRO,MPAGO,MPGTO")
SetPrvt("MPARC,MABERTO,MVEND,MEDVENC,MEDINIC,MEDSUSP,MEDFIN,MGRAVA,MTIPOOP")
SetPrvt("MTPPROD,MDESCROP,MPRICOM,MULTCOM,MGRAT,MDTVENC")
SetPrvt("MCODREV,MTITULO,_LSEEK,MEMAIL,MFAX,MATIV")
SetPrvt("MTPCLI,MFONE1,_ACAMPOS,_CNOME,CINDEX,CKEY")
SetPrvt("MIND1,_SALIAS,AREGS,I,J,MINSCR,MINSCRM")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                    ³
//³                                                                         ³
//³ mv_par01 Do Produdo.........:                                           ³
//³ mv_par02 At‚ o Produto......:                                           ³
//³ mv_par03 Faturados/Venc de..:                                           ³
//³ mv_par04 Faturados/Venc at‚.:                                           ³
//³ mv_par05 Do CEP.............:                                           ³
//³ mv_par06 At‚ CEP............:                                           ³
//³ mv_par07 Tipo...............: Pagas, Cortesia, Ambas.                   ³
//³ mv_par08 Situacao...........: Baixados, Em Aberto, Ambas.               ³
//³ mv_par09 Qtde da Selecao....:                                           ³
//³ mv_par10 Gerar..............: Contagem, Arquivo.                        ³
//³ mv_par11 Elimina duplicidade: Sim, Nao.                                 ³
//³ mv_par12 Cod. Promo‡Æo......:                                           ³
//³ mv_par13 Cod. Mailing.......:                                           ³
//³ mv_par14 Da Atividade.......:                                           ³
//³ mv_par15 At‚ Atividade......:                                           ³
//³ mv_par16 Tipo Cliente.......: Ass. Ativos, Ass. Cancelados, Outros.     ³
//³ mv_par17 Utilizacao.........: Mala Direta, TeleMarketing.               ³
//³ mv_par18 Processa por.......: Clientes,Produtos.                        ³
//³ mv_par19 Inclui representante: Sim  Nao                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

mConta1   := 0
mConta2   := 0
mConta3   := 0
MHORA     := TIME()
cArq      := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
mSaida    := "1"
cArqPath  := GetMv("MV_PATHTMP")
_cString  := cArqPath+cString+".DBF"
cPerg     := "PF106C"

If !Pergunte(cPerg)
	Return
Endif

If MV_PAR10 <> 1
	DbSelectArea("ZZ7")
	If DbSeek(xfilial("ZZ7")+MV_PAR12+MV_PAR13+MSAIDA)
		MsgStop("C¢digo j  utilizado, informe c¢digo v lido ou solicite manutencao no cad. Mailing")
		Return
	Endif
	
	F_VERSZA()
	
	IF mValida == 'N'
		RETURN
	ENDIF
Endif

FArqTrab()

lEnd:= .F.

If mv_par18 == 2
	bBloco:= {|lEnd| Produtos(@lEnd)}
Else
	bBloco:= {|lEnd| Clientes(@lEnd)}
EndIf

MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )

MOSTRA()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza arquivo de controle  - saida de mailing             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
F_ATUZZ7()

While .T.
	If !Pergunte(cPerg)
		Exit
	Endif
	
	If LastKey() == 27
		Exit
	Endif
	
	lEnd:= .F.
	If mv_par18 == 1
		bBloco:= {|lEnd| Clientes(@lEnd)}
	Else
		bBloco:= {|lEnd| Produtos(@lEnd)}
	EndIf
	
	MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
	
	MOSTRA()
	
	IF MV_PAR10 <> 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Valida gera‡Æo do mailing  - Verifica promo‡Æo               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		F_VERSZA()
		IF mValida == 'N'
			DbSelectArea(cArq)
			DbCloseArea()
			RETURN
		ENDIF
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza arquivo de controle  - saida de mailing             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		F_ATUZZ7()
		
	ENDIF
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava arquivo para Access...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par10 == 2
	cMsg := "Arquivo Gerado com Sucesso em: "+_cString
	lEnd:= .F.
	bBloco:= {|lEnd| FGERARQ(@lEnd)}
	MsAguarde(bBloco,"Aguarde" ,"Copiando Arquivo...", .T. )
	MSGINFO(cMsg)
Endif

DbGoTop()

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
DbSelectArea("SZ9")
Retindex("SZ9")

Return

Static Function FGERARQ()

DBSELECTAREA(cArq)
DBGOTOP()
COPY TO &_cString
Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ F_VERSZA                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Valida gera‡Æo do arquivo  de dados                           ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function F_VERSZA()

DBSELECTAREA("SZA")
DBGOTOP()
IF !DBSEEK(XFILIAL("SZA")+MV_PAR12)
	MsgStop("Promocao nao cadastrada")
	MsgStop("Entrar em contato com depto de Cadastro")
	mValida    := "N"
ELSE
	DBSELECTAREA('SX5')
	DBGOTOP()
	IF !DBSEEK(XFILIAL("SX5")+'91'+MV_PAR13)
		MsgStop("Mailing nÆo cadastrado")
		MsgStop("Entrar em contato com depto de Marketing")
		mValida := "N"
	ELSE
		mValida := "S"
	ENDIF
ENDIF

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ F_AtuZZ7                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Atualiza arquivo de controle de utilizacao.                   ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function F_AtuZZ7()

DbSelectArea("ZZ7")

RecLock("ZZ7",.T.)
ZZ7->ZZ7_CODPRO := MV_PAR12
ZZ7->ZZ7_CODMAI := MV_PAR13
ZZ7->ZZ7_USUAR  := Subs(cUsuario,7,15)
ZZ7->ZZ7_DATA   := Date()
ZZ7->ZZ7_QTDE   := mConta1
ZZ7->ZZ7_SAIDA  := mSaida
ZZ7->ZZ7_PROD1  := MV_PAR01
ZZ7->ZZ7_PROD2  := MV_PAR02
ZZ7->ZZ7_CEP1   := MV_PAR05
ZZ7->ZZ7_CEP2   := MV_PAR06
ZZ7->ZZ7_ATIV1  := MV_PAR14
ZZ7->ZZ7_ATIV2  := MV_PAR15
ZZ7->ZZ7_TPCLI  := Str(MV_PAR16,1)
ZZ7->ZZ7_UTILIZ := Str(MV_PAR17,1)
ZZ7->ZZ7_DUPLIC := Str(MV_PAR11,1)
ZZ7->ZZ7_SITUAC := Str(MV_PAR08,1)
ZZ7->ZZ7_TPVEND := Str(MV_PAR07,1)
MsUnLock()

Return
//
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

mConta :=0
DbSelectArea("SC6")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ordem 2 + DbSeek, substituindo o filtro indregua anteriormente    ³
//³usado. Gilberto - 03.05.2000                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSetOrder(2)
//DbGoTop()
DbSeek(xFilial("SC6")+MV_PAR01, .T.)

If (SC6->C6_PRODUTO > MV_PAR02)
	MsgStop("Nao Existem Dados para serem apurados !")
Endif

While !EOF() .And. (mConta1 < MV_PAR09) .And. (SC6->C6_PRODUTO <= MV_PAR02)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Filtro:Deixa passar apenas o que estiver de acordo com os    ³
	//³ parametros.                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MsProcTxt("Lendo Registros : "+Str(Recno(),7)+" Gravando...... "+StrZero(mConta1,7))
	IF MV_PAR16 <> 1 .AND. MV_PAR16 <> 2
		IF (SC6->C6_DATFAT < MV_PAR03) .OR. (SC6->C6_DATFAT > MV_PAR04)
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
	dbSelectArea("SZN")
	If dbSeek(xFilial("SZN")+SC6->C6_CLI+SC6->C6_CODDEST)
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
	mQtde    := 0
	mNomeCli := ""
	mRespcob := ""
	mDest    := ""
	mEnd     := ""
	mMun     := ""
	mEst     := ""
	mFone    := ""
	mCGC     := ""
	mDTPG    := ctod("  /  /  ")
	mDTFat   := ctod("  /  /  ")
	mDTPG2   := ctod("  /  /  ")
	mFilial  := ""
	mBairro  := ""
	mPago    := 0
	mPgto    := 0
	mParc    := 0
	mAberto  := 0
	mVend    := ""
	mEDVENC  := ""  
	mEdinic  := ""
	mEdsusp  := ""
	mEdfin   := ""
	mGrava   := ""
	mTipoop  := ""
	mTpprod  := ""
	mDescrop := ""
	mPricom  := ctod("  /  /  ")
	mUltcom  := ctod("  /  /  ")
	mGrat    := " "
	mDtVenc  := ctod("  /  /  ")
	
	mProd    := SC6->C6_PRODUTO
	mCodRev  := SUBS(SC6->C6_PRODUTO,1,4)
	mDTFat   := SC6->C6_DATFAT
	mCodCli  := SC6->C6_CLI
	mPedido  := SC6->C6_NUM
	mItem    := SC6->C6_ITEM
	mQtde    := SC6->C6_QTDVEN
	mValor   := SC6->C6_VALOR
	mCF      := ALLTRIM(SC6->C6_CF)
	mCodDest := SC6->C6_CODDEST
	mFilial  := SC6->C6_FILIAL
	mEdvenc  := SC6->C6_EDVENC
	mEdinic  := SC6->C6_EDINIC
	mEdsusp  := SC6->C6_EDSUSP
	mEdfin   := SC6->C6_EDFIN 
	
	DbSelectArea ("SC5")
	DbSetOrder(1)
	If DbSeek(xFilial("SC5")+mPedido)
		mVend    := SC5->C5_VEND1
		mRespcob := SC5->C5_RESPCOB
		mTipoop  := SC5->C5_TIPOOP
	Endif
	
	DbSelectArea("SZ9")
	DbSeek(xFilial("SZ9")+mTipoop,.T.)
	If Found()
		mDescrop:=SZ9->Z9_DESCR
	Endif
	If MV_PAR16 == 2  .AND.!EMPTY(SC6->C6_PEDREN)
		DbSelectArea("SC6")
		DbSkip()
		Loop
	Endif
	
	DbSelectArea("SC6")
	Do Case
		Case subs(SC6->C6_PRODUTO,1,2) == '02'
			mTpprod:='LIVROS'
		Case subs(SC6->C6_PRODUTO,1,2) == '07'
			mTpprod:='CD'
		Case subs(SC6->C6_PRODUTO,1,2) == '01'.And. subs(SC6->C6_PRODUTO,5,3) == '002'
			mTpprod:='NOVA ANUAL'
		Case subs(SC6->C6_PRODUTO,1,2) == '01'.And. subs(SC6->C6_PRODUTO,5,3) == '003'
			mTpprod:='NOVA BIENAL'
		Case subs(SC6->C6_PRODUTO,1,2) == '01'.And. subs(SC6->C6_PRODUTO,5,3) == '004'
			mTpprod:='RENOVADA ANUAL'
		Case subs(SC6->C6_PRODUTO,1,2) == '01'.And. subs(SC6->C6_PRODUTO,5,3) == '005'
			mTpprod:='RENOVADA BIENAL'
		OtherWise
			mTpprod:='OUTROS'
	EndCase
	
	If MV_PAR16 == 1 .or. MV_PAR16 == 2
		DbSelectArea ("SZJ")
		DbGoTop()
		
		IF SUBSTR(MV_PAR01,1,4) >= '1000' .AND. SUBSTR(MV_PAR02,1,4) <= '1105'
			mCodRev := '9999'
		ENDIF
		
		DbSeek(xFilial("SZJ")+mCodRev+Str(MEDSUSP,4))
		If MV_PAR16 == 2
			If SZJ->ZJ_DTCIRC < MV_PAR03 .OR. SZJ->ZJ_DTCIRC > MV_PAR04
				DbSelectArea("SC6")
				DbSkip()
				Loop
			Endif
		Endif
		If MV_PAR16 == 1
			If SZJ->ZJ_DTCIRC < DATE()
				DbSelectArea("SC6")
				DbSkip()
				Loop
			Endif
		Endif
		If Subs(SC6->C6_PRODUTO,5,3) == '001'
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
	Endif
	IF MV_PAR19 == 2
		DbSelectArea("SZL")
		DbGoTop()
		DbSeek(xFilial("SZL")+MCODCLI)
		
		If Found()
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
	ENDIF
	If mv_par11 == 1
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
			mGrat:='S'
		Endif
	EndIf
	If MV_PAR07 == 1 .And. mGrat == 'S'
		DbSelectArea("SC6")
		DbSkip()
		Loop
	Endif
	
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
			
			mParc := mParc+1
			mDTPG2:= SE1->E1_BAIXA
			
			If DTOC(MDTPG2) <> "  /  /  " .And. SE1->E1_SALDO == 0;
				.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,2) <> 'LP';
				.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,4) <> 'CANC'
				mPago:=mPago+1
			Else
				If SE1->E1_VENCTO+30 < DATE()
					mAberto:=mAberto+1
				Endif
			Endif
			DbSkip()
		End
		
		mPGTO:=mPAGO/mPARC
	Else
		mAberto:=99999
	Endif
	
	DbSelectArea("SC6")
	If SUBS(SC6->C6_CF,2,2) == "99"
		mAberto:=0
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
//³           ³ para gera‡Æo do arquivo.                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function GRAVA
Static Function GRAVA()

DbSelectArea("SB1")
DbSeek(xFilial("SB1")+mProd)
If Found()
	mTitulo:=SB1->B1_DESC
Else
	mTitulo:="  "
Endif

_lSeek:= .T.

if mv_par18 == 2   // Observacao : S¢ executa o bloco abaixo caso o
	// processamento seja pelo produto, pois se for por
	// cliente o SA1 j  est  posicionado.
	
	DbSelectArea("SA1")
	DbGoTop()
	_lSeek := DbSeek(xFilial("SA1")+mCodCli)
endif

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
	mInscr   := SA1->A1_INSCR
	mInscrm  := SA1->A1_INSCRM
	mFone    := SA1->A1_TEL
	mEmail   := SA1->A1_EMAIL
	mFax     := SA1->A1_FAX
	mAtiv    := SA1->A1_ATIVIDA
	mTpCli   := SA1->A1_TPCLI
	mPricom  := SA1->A1_PRICOM
	mUltcom  := SA1->A1_ULTCOM
Else
	mNomeCli := SPACE(40)
Endif

If mNomeCli <> "  "
	
	If mCodDest#" "
		
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
	mCodCli   <> "  " .And. mAtiv >= mv_par14 .And. mAtiv <= mv_par15 .And. !Empty(mNomeCli)
	mGrava:= "S"
Endif
/*
If MV_PAR16 == 2 .and. mTpCli == 'R'
	mGrava := "N"
Endif
*/
If MV_PAR17 == 2 .And. Empty(mFone)
	mGrava := "N"
Endif

If MV_PAR20 == 1 .and. mTpCli <> 'F'
	mGrava := "N"
Endif

If MV_PAR20 == 2 .and. mTpCli <> 'J'
	mGrava := "N"
Endif

If mGrava == "S"
	mConta1:= mConta1+1
	DbSelectArea(cArq)
	RecLock(cArq,.T.)
	replace NumPed   With  mPedido
	replace codass   With  mPedido+substr(mProd,3,2)+mItem
	replace zz6_Cod  With  mCodCli
	replace zz6_Produto  With substr(mProd,3,2)  
	replace zz6_End      With  mEnd
	replace zz6_Bairro   With  mBairro
	replace zz6_Mun      With  mMun
	replace zz6_CEP      With  mCEP
	replace zz6_Estado   With  mEst
	replace zz6_tel     With  mFone
	replace zz6_Fax      With  mFax
	replace zz6_EMAIL    With  mEMAIL
	replace zz6_CGC      With  mCGC  
	replace zz6_inscr    With  mInscr
	replace zz6_inscrm   With  minscrm  
	replace zz6_Valor    With  mValor
	replace zz6_Nome     With  mNomeCli
	replace zz6_contat With  mDest  
	replace zz6_CodVend  With  mVend
	replace zz6_Edinic   With  mEdinic 
	replace zz6_EdVenc   With  mEdVenc
	replace zz6_Edsusp   With  mEdsusp
	replace zz6_Edfin    With  mEdfin
	replace zz6_TpCli    With  mTpCli
	replace zz6_Seqass With  mItem    
	replace CodDest  With  mCodDest
	replace CodProd  With  mProd
	replace CF       With  mCF
	replace Qtde     With  mQtde
	replace Respcob  With  mRespcob
	replace DTPGTO   With  mDTPG
	replace DTFAT    With  mDTFAT
	replace PGTO     With  mPGTO
	replace EmAberto With  mAberto
	replace Descr    With  mTitulo
	replace Tipoop   With  mTipoop
	replace Tpprod   With  mTpprod
	replace Descrop  With  mDescrop
	replace Pricom   With  mPricom
	replace Ultcom   With  mUltcom
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
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function Limpa
Static Function Limpa()
@ 10,05 clear TO 10,70
@ 11,05 clear TO 10,70
@ 12,05 clear TO 10,70
@ 13,05 clear TO 10,70
@ 14,05 clear TO 10,70
Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ MOSTRA()                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Mostra o resultado final da apuracao dos registros que serao  ³
//³           ³ gravados no arquivo.                                          ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function Mostra
Static Function Mostra()
@ 200,001 TO 400,450 DIALOG oDlg TITLE " Confirme ... "
@ 003,010 TO 090,220
@ 15,018 Say "Produto................: "+Trim(MV_PAR01)+ " A " + Trim(MV_PAR02)
@ 30,018 Say "CEP....................: "+MV_PAR05      + " A " + MV_PAR06
@ 45,018 SAY "Quantidade Selecionada.: "+STRZERO(MV_PAR09,7,0)
@ 60,018 SAY "Quantidade Mailing.....: "+STRZERO(MCONTA1 ,7,0)
@ 75,188 BMPBUTTON TYPE 01 ACTION Close(oDlg)
Activate Dialog oDlg Centered

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ FArqTrab()                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Cria arquivo de trabalho para guardar registros que serao     ³
//³           ³ gravados em forma de Arquivo.                                 ³
//³           ³ Faz chamada a funcao GRAVA.                                   ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function FARQTRAB
Static Function FARQTRAB()

_aCampos:={}
AADD(_aCampos,{"NUMPED","C",6,0})
AADD(_aCampos,{"ZZ6_SEQASS","C",2,0})
AADD(_aCampos,{"ZZ6_COD","C",6,0})
AADD(_aCampos,{"ZZ6_NOME","C",40,0})
AADD(_aCampos,{"ZZ6_CONTAT","C",40,0})
AADD(_aCampos,{"ZZ6_END","C",120,0})
AADD(_aCampos,{"ZZ6_BAIRRO","C",20,0})
AADD(_aCampos,{"ZZ6_MUN","C",20,0})
AADD(_aCampos,{"ZZ6_ESTADO","C",2,0})
AADD(_aCampos,{"ZZ6_CEP","C",8,0})
AADD(_aCampos,{"ZZ6_CGC","C",14,0})  
AADD(_aCampos,{"ZZ6_INSCR","C",14,0})   
AADD(_aCampos,{"ZZ6_INSCRM","C",14,0})
AADD(_aCampos,{"ZZ6_TEL","C",20,0})
AADD(_aCampos,{"ZZ6_FAX","C",20,0})
AADD(_aCampos,{"ZZ6_EMAIL","C",20,0})
AADD(_aCampos,{"ZZ6_EDINIC","N",4,0})
AADD(_aCampos,{"ZZ6_EDVENC","N",4,0})
AADD(_aCampos,{"ZZ6_EDSUSP","N",4,0})
AADD(_aCampos,{"ZZ6_EDFIN","N",4,0})
AADD(_aCampos,{"ZZ6_PRODUT","C",2,0}) 
AADD(_aCampos,{"ZZ6_CODVEN","C",6,0}) 
AADD(_aCampos,{"ZZ6_TPCLI","C",1,0})
AADD(_aCampos,{"CODASS","C",12,0}) 
AADD(_aCampos,{"RESPCOB","C",40,0})
AADD(_aCampos,{"CF","C",5,0})
AADD(_aCampos,{"CODPROD","C",15,0})
AADD(_aCampos,{"DESCR","C",40,0})
AADD(_aCampos,{"DTPGTO","D",8,0})
AADD(_aCampos,{"DTFAT","D",8,0})
AADD(_aCampos,{"QTDE","N",12,2})
AADD(_aCampos,{"ZZ6_VALOR","N",12,2})
AADD(_aCampos,{"PGTO","N",5,2})
AADD(_aCampos,{"EMABERTO","N",5,0})
AADD(_aCampos,{"CODDEST","C",6,0})
AADD(_aCampos,{"TIPOOP","C",2,0})
AADD(_aCampos,{"DESCROP","C",50,0})
AADD(_aCampos,{"PRICOM","D",8,0})
AADD(_aCampos,{"ULTCOM","D",8,0})
AADD(_aCampos,{"TPPROD","C",30,0}) 


_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "ZZ6_Cod+CodDEst"

dbUseArea(.T.,, _cNome,cArq,.F.,.F.)
dbSelectArea(cArq)
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ INDEXA SE1                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea("SE1")
dbSetOrder(21)  ///dbSetOrder(15) AP5

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ INDEXA SZL                                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea("SZL")
cIndex:=CriaTrab(Nil,.F.)
cKey:="ZL_FILIAL+ZL_CODCLI"
Indregua("SZL",cIndex,ckey,,,"Selecionando Registros do Arq")
Retindex("SZL")
mInd1:=Retindex("SZL")
#IFNDEF TOP
	dbSetIndex( cIndex + OrdBagExt())
#ENDIF
dbSetOrder(MIND1+1)
dbGoTop()

Return

/*
Mudancas para poder filtrar atraves de clientes (sa1).

Criar pergunta no sx1 para saber qual  a prioridade de leitura
Selecionada para o relatorio, clientes ou produtos.
Indices do sc6 com chave do codigo do cliente.

Ordem 05 -> C6_FILIAL+C6_CLI+C6_LOJA+C6_PRODUTO.
Ordem 10 -> C6_FILIAL+C6_CLI+C6_NUM

Plano mestre :
--------------
Selecionar SA1, gerar indice por CEP (Temporario),
Manter o While principal com a selecao do SA1.
Pesquisar o SC6 com os clientes que tenham o CEP dentro da selecao
informada pelo usuario.
Verificar o restante dos filtros, como ja vinha sendo feito.
*/
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

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function CLIENTES
Static Function CLIENTES()

mConta := 0
DbSelectArea("SA1")
DbsetOrder(6)
DbSeek(xFilial("SA1")+MV_PAR05, .T.)

If ( SA1->A1_CEP > MV_PAR06 )
	MsgStop("O intervalo de CEP's nao foi encontrado no Cad.de Clientes!")
EndIf

While !EOF() .And. ( mConta1 < MV_PAR09 );
	.And. ( SA1->A1_CEP <= MV_PAR06 )

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
	
	While (SC6->C6_CLI+SC6->C6_LOJA) == (SA1->A1_COD+SA1->A1_LOJA);
		.And. !Eof();
		.And. SC6->C6_FILIAL == xFilial()
		
		MsProcTxt("Lendo Registros : "+Str(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
		
		If MV_PAR16 <> 1 .AND. MV_PAR16 <> 2
			If (SC6->C6_DATFAT < MV_PAR03) .Or. ;
				(SC6->C6_DATFAT > MV_PAR04)
				DbSkip()
				Loop
			EndIf
		Endif
		
		IF (SC6->C6_PRODUTO < MV_PAR01) .Or. ;
			(SC6->C6_PRODUTO > MV_PAR02)
			DbSkip()
			Loop
		ENDIF
		
		IF ALLTRIM(SC6->C6_CLI) == "040000"
			DbSkip()
			Loop
		ENDIF
		
		dbSelectArea("SZN")
		If dbSeek( xFilial("SZN")+SC6->C6_CLI+SC6->C6_CODDEST )
			If !Empty(SZN->ZN_SITUAC)
				dbSelectArea("SC6")
				dbSkip()
				Loop
			EndIf
		EndIf
		dbSelectArea("SC6")
		
		mPedido := ""
		mItem   := ""
		mCodCli := ""
		mCodDest:= ""
		mProd   := ""
		mCF     := ""
		mCEP    := ""
		mValor  := 0
		mQtde   := 0
		mNomeCli:= ""
		mDest   := ""
		mRespcob:= ""
		mEnd    := ""
		mMun    := ""
		mEst    := ""
		mFone   := ""
		mCGC    := ""
		mDTPG   := ctod("  /  /  ")
		mDTFat  := ctod("  /  /  ")
		mDTPG2  := ctod("  /  /  ")
		mFilial := ""
		mBairro := ""
		mPago   := 0
		mPgto   := 0
		mParc   := 0
		mAberto := 0
		mVend   := ""
		mEdvenc  :="" 
    	mEdinic  :=""
	    mEdsusp  :=""
    	mEdfin   :="" 
		mGrava   := ""
		mDtVenc  :=ctod("  /  /  ")
		mGrat    :=" "
		mTipoop  := ""
		mTpprod  := ""
		mDescrop := ""
		mPricom  := ctod("  /  /  ")
		mUltcom  := ctod("  /  /  ")
		mProd    := SC6->C6_PRODUTO
		mCodRev  := SUBS(SC6->C6_PRODUTO,1,4)
		mDTFat   := SC6->C6_DATFAT
		mCodCli  := SC6->C6_CLI
		mPedido  := SC6->C6_NUM
		mItem    := SC6->C6_ITEM
		mQtde    := SC6->C6_QTDVEN
		mValor   := SC6->C6_VALOR
		mCF      := ALLTRIM(SC6->C6_CF)
		mCodDest := SC6->C6_CODDEST
		mFilial  := SC6->C6_FILIAL
		mEdvenc  := SC6->C6_EDVENC
    	mEdinic  := SC6->C6_EDINIC
    	mEdsusp  := SC6->C6_EDSUSP
    	mEdfin   := SC6->C6_EDFIN 
		
		DbSelectArea ("SC5")
		DbGoTop()
		DbSeek(xFilial("SC5")+mPedido)
		
		If Found()
			mVend   := C5_VEND1
			mRespcob:=C5_RESPCOB
			mTipoop :=SC5->C5_TIPOOP
		Endif
		
		DbSelectArea("SZ9")
		DbSeek(xFilial("SZ9")+mTipoop,.T.)
		If Found()
			mDescrop:=SZ9->Z9_DESCR
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica Vencimento da Assinatura                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		If MV_PAR16 == 2  .AND. !EMPTY(SC6->C6_PEDREN)
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
		
		DbSelectArea("SC6")
		Do Case
			Case subs(SC6->C6_PRODUTO,1,2) == '02'
				mTpprod:='LIVROS'
			Case subs(SC6->C6_PRODUTO,1,2) == '07'
				mTpprod:='CD'
			Case subs(SC6->C6_PRODUTO,1,2) == '01'.And. subs(SC6->C6_PRODUTO,5,3) == '002'
				mTpprod:='NOVA ANUAL'
			Case subs(SC6->C6_PRODUTO,1,2) == '01'.And. subs(SC6->C6_PRODUTO,5,3) == '003'
				mTpprod:='NOVA BIENAL'
			Case subs(SC6->C6_PRODUTO,1,2) == '01'.And. subs(SC6->C6_PRODUTO,5,3) == '004'
				mTpprod:='RENOVADA ANUAL'
			Case subs(SC6->C6_PRODUTO,1,2) == '01'.And. subs(SC6->C6_PRODUTO,5,3) == '005'
				mTpprod:='RENOVADA BIENAL'
			OtherWise
				mTpprod:='OUTROS'
		EndCase
		
		If MV_PAR16 == 1 .or. MV_PAR16 == 2
			DbSelectArea ("SZJ")
			DbGoTop()
			
			IF SUBSTR(MV_PAR01,1,4) >= '1000' .AND. SUBSTR(MV_PAR02,1,4) <= '1105'
				mCodRev := '9999'
			ENDIF
			
			DbSeek(xFilial("SZJ")+mCodRev+Str(MEDSUSP,4))
			If MV_PAR16 == 2
				If SZJ->ZJ_DTCIRC < MV_PAR03 .OR. SZJ->ZJ_DTCIRC > MV_PAR04
					DbSelectArea("SC6")
					DbSkip()
					Loop
				Endif
			Endif
			If MV_PAR16 == 1
				If SZJ->ZJ_DTCIRC < DATE()
					DbSelectArea("SC6")
					DbSkip()
					Loop
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
		
		IF MV_PAR19 == 2
			DbSelectArea("SZL")
			DbGoTop()
			DbSeek(xFilial("SZL")+MCODCLI)
			
			If Found()
				DbSelectArea("SC6")
				DbSkip()
				Loop
			Endif
		ENDIF
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Elimina duplicidade por codigo de cliente e destinat rio     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		If MV_PAR11 == 1
			
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
				mGrat:='S'
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
			mDTPG := SE1->E1_BAIXA
			
			While ( SE1->E1_PEDIDO == MPEDIDO ) .And. !Eof()
				
				mParc := mParc+1
				mDTPG2:= SE1->E1_BAIXA
				
				If DTOC(MDTPG2) <> "  /  /  " .And. SE1->E1_SALDO == 0;
					.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,2) <> 'LP';
					.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,4) <> 'CANC'
					mPago:=mPago+1
				Else
					If SE1->E1_VENCTO+30 < DATE()
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

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _ValidPerg
Static Function _ValidPerg()

_sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg := PADR(cPerg,6)
aRegs := {}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

AADD(aRegs,{cPerg,"01","Do Produdo.........:","mv_ch1","C",15,0,0,"G","","mv_par01","","0108001","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"02","At‚ o Produto......:","mv_ch2","C",15,0,0,"G","","mv_par02","","0108003","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"03","Faturados/Venc de..:","mv_ch3","D",08,0,0,"G","","mv_par03","","'01/06/99'","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Faturados/Venc at‚.:","mv_ch4","D",08,0,0,"G","","mv_par04","","'17/04/00'","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Do CEP.............:","mv_ch5","C",08,0,0,"G","","mv_par05","","12000000","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"06","At‚ CEP............:","mv_ch6","C",08,0,0,"G","","mv_par06","","12999999","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"07","Tipo Venda.........:","mv_ch7","C",01,0,3,"C","","mv_par07","Pagos","","","Cortesias","","","Ambas","","","","","","","",""})
AADD(aRegs,{cPerg,"08","Situacao do titulo.:","mv_ch8","C",01,0,3,"C","","mv_par08","Baixados","","","Em aberto","","","Ambas","","","","","","","",""})
AADD(aRegs,{cPerg,"09","Qtde da Selecao....:","mv_ch9","N",07,0,3,"G","","mv_par09","","9999999","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"10","Gerar...............","mv_chA","C",01,0,1,"C","","mv_par10","Contagem","","","Arquivo","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"11","Elimina duplicidade:","mv_chB","C",01,0,1,"C","","mv_par11","Sim","ZZZZZZZ","","Nao","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"12","Cod. Promocao......:","mv_chC","C",03,0,1,"G","","mv_par12","","N","","","","","","","","","","","","","SZA"})
AADD(aRegs,{cPerg,"13","Cod. Mailing.......:","mv_chD","C",03,0,1,"G","","mv_par13","","107","","","","","","","","","","","","","91"})
AADD(aRegs,{cPerg,"14","Da Atividade.......:","mv_chE","C",07,0,0,"G","","mv_par14","","","","","","","","","","","","","","","ZZ8"})
AADD(aRegs,{cPerg,"15","At‚ Atividade......:","mv_chF","C",07,0,0,"G","","mv_par15","","ZZZZZZZ","","","","","","","","","","","","","ZZ8"})
AADD(aRegs,{cPerg,"16","Tipo Cliente.......:","mv_chG","C",01,0,3,"C","","mv_par16","Ass. Ativos","","","Ass. Cancelados","","","Outros","","","","","","","",""})
AADD(aRegs,{cPerg,"17","Utilizacao.........:","mv_chH","C",01,0,1,"C","","mv_par17","Mala Direta","","","Telemarketing","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"18","Processa por.......:","mv_chI","C",01,0,1,"C","","mv_par18","Clientes","","","Produtos","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"19","Inclui Representante","mv_chj","C",01,0,1,"C","","mv_par19","Sim","","","NÆo","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"20","Condicao Fiscal....:","mv_chk","C",01,0,1,"C","","mv_par20","Fisica","","","Juridica","","","Ambas","","","","","","","",""})

For i :=1  to Len(aRegs)
	If !dbSeek
		(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j := 1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		SX1->(MsUnlock())
	Endif
Next

DbSelectArea(_sAlias)

Return
