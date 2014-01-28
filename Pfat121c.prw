#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/03/02
/*/
//Danilo C S Pala 20060327: dados de enderecamento do DNE
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT121c  ³Autor: Raquel Ramalho         ³ Data:   09/09/01 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Acompanhamento da inadimplencia                            ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function Pfat121c()        // incluido pelo assistente de conversao do AP5 IDE em 25/03/02

SetPrvt("CDESC1,CDESC2,CDESC3,TITULO,CTITULO,ARETURN")
SetPrvt("CPROGRAMA,MHORA,CARQ,CSTRING,WNREL,CARQTEMP")
SetPrvt("NLASTKEY,L,NORDEM,M_PAG,NCARACTER,TAMANHO")
SetPrvt("CCABEC1,CCABEC2,LCONTINUA,MSAIDA,MVALIDA,CARQPATH")
SetPrvt("_CSTRING,CPERG,MCONTA,MCONTA1,MCONTA2,LEND")
SetPrvt("BBLOCO,CINDEX,CKEY,CMSG,CCHAVE,CFILTRO1")
SetPrvt("CFILTRO2,CFILTRO,CIND,MDATA,MPEDIDO,MITEM")
SetPrvt("MCODCLI,MCODDEST,MPROD,MCF,MCEP,MVALOR")
SetPrvt("MNOMECLI,MDEST,MEND,MMUN,MEST,MFONE")
SetPrvt("MCGC,MDTPG,MDTFAT,MDTPG2,MFILIAL,MBAIRRO")
SetPrvt("MPAGO,MPGTO,MPARC,MPARC1,MPARC2,MPARC3")
SetPrvt("MPARC4,MPARC5,MPARC6,MPARC7,MVENC1,MVENC2")
SetPrvt("MVENC3,MVENC4,MVENC5,MVENC6,MVENC7,MABERTO")
SetPrvt("MINADIMPL,MVEND,MEDVENC,MGRAVA,MDTVENC,MSITUAC")
SetPrvt("MREGIAO,MGRAT,MPARCELA,MIT,MVLTOT,MDESCROP")
SetPrvt("MTIPOOP,MDIVVEND,MNOMEVEND,MATUALIZA,MCODREV,MEDSUSP")
SetPrvt("MEDINIC,MRECO,MNUM,MTITULO,MPARC8,MVENC8")
SetPrvt("MPARC9,MVENC9,MPARC10,MVENC10,MPARC11,MVENC11")
SetPrvt("MPARC12,MVENC12,MEMAIL,MFAX,MATIV,MFONE1")
SetPrvt("MCHAVE,MCHAVE2,MDTVEND,MEMABERTO,_ACAMPOS,_CNOME")
SetPrvt("_SALIAS,AREGS,I,J,")

//ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ MV_PAR01 ³ Regiao De            ?                         ³
//³ MV_PAR02 ³ Regiao Ate           ?                         ³
//³ MV_PAR03 ³ Vendedor De          ?                         ³
//³ MV_PAR04 ³ Vendedor Ate         ?                         ³
//³ MV_PAR05 ³ Vencidos  De         ?                         ³
//³ MV_PAR06 ³ Vencidos  At‚        ?                         ³
//³ MV_PAR07 ³ Produto De           ?                         ³
//³ MV_PAR08 ³ Produto At‚          ?                         ³
//³ MV_PAR09 ³ Cep De               ?                         ³
//³ MV_PAR10 ³ Cep At‚              ?                         ³
//³ MV_PAR11 ³ Gera                 ? Arquivo Relat¢rio       ³
//³ MV_PAR12 ³ Dias de atraso       ?                         ³
//³ MV_PAR13 ³ Inclui parcela A     ? Sim NÆo somente parc A  ³
//ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cDesc1     := PADC("Este programa ira gerar o arquivo de clientes inadimplentes" ,74)
cDesc2     := PADC("em relat¢rio" ,74)
cDesc3     := ""
Titulo     := PADC("RELATORIO DE INADIMPLENTES",74)
cTitulo    := " **** CLIENTES INADIMPLENTES **** "
aReturn    :=  { "Especial", 1,"Administra‡ao", 1, 2, 1,"",1 }
cPrograma  := "PFA121"
mHora      := TIME()
cArq       := SUBS(cUsuario,7,3)+SUBS(mHora,1,2)+SUBS(mHora,7,2)
cString    := SUBS(cUsuario,7,3)+SUBS(mHora,1,2)+SUBS(mHora,7,2)
wnrel      := SUBS(cUsuario,7,3)+SUBS(mHora,1,2)+SUBS(mHora,7,2)
cArqTemp   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
nLastKey   := 00
L          := 00
nOrdem     := 00
m_pag      := 01
nCaracter  := 10
tamanho    := "P"
cCabec1    := ""
cCabec2    := ""
lContinua  := .T.
mSaida     := "2"
mValida    := ""
cArqPath   := GetMv("MV_PATHTMP")
_cString   := cArqPath+cString+".DBF"

cPerg:="PF121C"
//_ValidPerg()

If !Pergunte(cPerg)
	Return
Endif

IF Lastkey()==27
	Return
Endif

mConta    :=0
mConta1   :=0
mConta2   :=0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Valida gera‡Æo do mailing  - Verifica promo‡Æo               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
F_VERSZA()

IF mValida=='N'
	RETURN
Else
	F_AtuZZ7()// Substituido pelo assistente de conversao do AP5 IDE em 25/03/02 ==>        Execute(F_AtuZZ7)
ENDIF

FArqTrab()

lEnd:= .F.

bBloco:= { |lEnd| FILTRA()  }
MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )

bBloco:= { |lEnd| PRODUTOS()  }
Processa( bBloco, "Aguarde" ,"Processando...", .T. )

DbSelectArea(cArq)
cIndex := CriaTrab(Nil,.F.)
cKey   := "Z1_CEP+Z1_NOME+Z1_NDEST+Z1_CODCLI+Z1_CODDEST"
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")
dbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava arquivo dbf                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If MV_PAR11==1
	cMsg:= "Arquivo Gerado com Sucesso em: "+_cString
		DbSelectArea(cArq)
		dbGoTop()
		COPY TO &_cString VIA "DBFCDXADS" // 20121106 
		MSGINFO(cMsg)
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Relatorio                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If MV_PAR11==2
	wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)
	SetDefault(aReturn,cString)
	
	If nLastKey == 27
		DbSelectArea(cArq)
		DbCloseArea()
		Return
	Endif

	Processa({||Relatorio()})
EndIf

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

DbSelectArea("SA3")
Retindex("SA3")

DbSelectArea("SZA")
Retindex("SZA")

DbSelectArea("SX5")
Retindex("SX5")

DbSelectArea("ZZ7")
Retindex("ZZ7")

DbSelectArea("SZ9")
Retindex("SZ9")

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ Filtra()                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Filtra arquivo SC6 para ser utilizado no programa.            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function FILTRA()

DbSelectArea("SE1")
DbGoTop()

cChave  :=IndexKey(15)
cFiltro1:='DTOS(E1_VENCTO)>="'+DTOS(MV_PAR05)+'".and.DTOS(E1_VENCTO)<="'+DTOS(MV_PAR06)+'"'
cFiltro2:='.AND. EMPTY(DTOS(E1_BAIXA))'
cFiltro :=cFiltro1+cFiltro2
cInd    :=CriaTrab(NIL,.f.)

IndRegua("SE1",cInd,cChave,,cFiltro,"Filtrando Itens de Pedidos...")

DbGoTop()

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

DbSelectArea("SE1")
DbGoTop()
ProcRegua(RecCount())
While !EOF()
	IncProc("Lendo Registros : "+Str(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))

	mData     :=DATE()-MV_PAR12

	IF SE1->E1_VENCTO>mData
		DbSkip()
		Loop
	Endif
	
	DbSelectArea("SC6")
	DbGoTop()
	If !DbSeek(xFilial("SC6")+SE1->E1_PEDIDO)
		DbSelectArea("SE1")
		DbSkip()
		Loop
	Endif
	
	IF ALLTRIM(SC6->C6_CLI) == "040000"
		DbSelectArea("SE1")
		DbSkip()
		Loop
	ENDIF
	
	DbSelectArea(cArq)
	If DbSeek(SE1->E1_PEDIDO)
		DbSelectArea("SE1")
		DbSkip()
		Loop
	Endif
	
	mPedido   := ""
	mItem     := ""
	mCodCli   := ""
	mCodDest  := ""
	mProd     := ""
	mCF       := ""
	mCEP      := ""
	mValor    := 0
	mNomeCli  := ""
	mDest     := ""
	mEnd      := ""
	mMun      := ""
	mEst      := ""
	mFone     := ""
	mCGC      := ""
	mDTPG     := stod("")
	mDTFat    := stod("")
	mDTPG2    := stod("")
	mFilial   := ""
	mBairro   := ""
	mPago     := 0
	mPgto     := 0
	mParc     := 0
	mParc1    := 0
	mParc2    := 0
	mParc3    := 0
	mParc4    := 0
	mParc5    := 0
	mParc6    := 0
	mParc7    := 0
	mVenc1    := stod("")
	mVenc2    := stod("")
	mVenc3    := stod("")
	mVenc4    := stod("")
	mVenc5    := stod("")
	mVenc6    := stod("")
	mVenc7    := stod("")
	mAberto   := 0
	mInadimpl := 0
	mVend     := ""
	mEdvenc   := ""
	mGrava    := ""
	mDtVenc   := stod("")
	mSituac   := ""
	mRegiao   := ""
	mGrat     := ""
	mparcela  := ""
	mit       := 0
	mVltot    := 0
	mDescrop  := ""
	mTipoop   := ""
	mProd     := SC6->C6_PRODUTO
	mRegiao   := ""
	mDivvend  := ""
	mNomevend := ""
	mAtualiza := ""
	
	mCodRev   := SUBS(SC6->C6_PRODUTO,1,4)
	mDTFat    := SC6->C6_DATFAT
	mCodCli   := SC6->C6_CLI
	mPedido   := SC6->C6_NUM
	mItem     := SC6->C6_ITEM
	mValor    := SC6->C6_VALOR
	mCF       := ALLTRIM(SC6->C6_CF)
	mCodDest  := SC6->C6_CODDEST
	mFilial   := SC6->C6_FILIAL
	mEdvenc   := SC6->C6_EDVENC
	mEdsusp   := SC6->C6_EDSUSP
	mEdinic   := SC6->C6_EDINIC
	mSituac   := SC6->C6_SITUAC	
	
	If 'P' $(SC6->C6_NUM)
		DbSelectArea("SE1")
		DbSkip()
		Loop
	EndIf
	
	DbSelectArea ("SC5")
	//DbGoTop()
	If DbSeek(xFilial("SC5")+SE1->E1_PEDIDO)
		mVend   := SC5->C5_VEND1
		mTipoop := SC5->C5_TIPOOP
	Endif
	
	DbSelectArea("SZ9")
	If DbSeek(xFilial("SZ9")+mTipoop)
		mDescrop := SZ9->Z9_DESCR
	Endif
	
	DbSelectArea("SA3")
	If DbSeek(xFilial("SA3")+mVend)
		mRegiao   := SA3->A3_REGIAO
		mDivvend  := SA3->A3_DIVVEND
		mNomevend := SA3->A3_NOME
	Endif
	
	If mRegiao < MV_PAR01 .OR. mRegiao > MV_PAR02
		DbSelectArea("SE1")
		DbSkip()
		Loop
	Endif
	
	If mVend < MV_PAR03 .OR. mVend > MV_PAR04
		DbSelectArea("SE1")
		DbSkip()
		Loop
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se ‚ cortesia                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	DbSelectArea("SF4")
	DbSetOrder(1)
	//DbGoTop()
	DbSeek(xFilial("SF4")+SC6->C6_TES)
	If SF4->F4_DUPLIC=='N' .OR. 'CORTESIA' $(F4_TEXTO) .OR. 'DOA€ÇO' $(F4_TEXTO) .OR. 'DOACAO' $(F4_TEXTO)
		mGrat:='S'
	EndIf
	
	If '99' $(mCF)
		mGrat:='S'
	Endif
	
	If mGrat=='S'
		DbSelectArea("SE1")
		DbSkip()
		Loop
	Endif
	
	MRECO := RECNO()
	DbSelectArea("SE1")
	WHILE !Eof () .and. SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_PEDIDO == MPEDIDO
		mParc++
		mit++
		mDTPG   := SE1->E1_BAIXA
		mNum    := SE1->E1_NUM
		mtitulo := SE1->E1_PARCELA
		
		If MV_PAR13==2
			If SE1->E1_PARCELA=='A' .OR. SE1->E1_PARCELA==' ' .or. SE1->E1_SERIE=='LIV'
				mAtualiza:='N'
			Endif
		Endif
		
		If MV_PAR13==3 .AND. SE1->E1_PARCELA<>'A' .AND. SE1->E1_PARCELA<>' '
			DbSelectArea("SE1")
			DbSkip()
			Loop
		Endif
		
		If SUBS(ALLTRIM(SE1->E1_MOTIVO),1,3)=='CAN' .OR. SUBS(ALLTRIM(SE1->E1_MOTIVO),1,3)=='DEV'
			Dbskip()
			Loop
		Endif
		
		mVltot += SE1->E1_VALOR
		
		If DTOS(MDTPG)<>"        " .And. E1_SALDO == 0;
			.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,2)<>'LP';
			.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,4)<>'CANC'
			mPago := mPago+1
		Else
			If SE1->E1_VENCTO<=DATE()-MV_PAR12
				mAberto++
				Do Case
					Case mit==1
						mParc1:=SE1->E1_VALOR
						mvenc1:=SE1->E1_VENCTO
						mparcela:=SE1->E1_PARCELA
					Case mit==2
						mParc2:=SE1->E1_VALOR
						mvenc2:=SE1->E1_VENCTO
						mparcela:=mparcela+SE1->E1_PARCELA
					Case mit==3
						mParc3:=SE1->E1_VALOR
						mvenc3:=SE1->E1_VENCTO
						mparcela:=mparcela+SE1->E1_PARCELA
					Case mit==4
						mParc4:=SE1->E1_VALOR
						mvenc4:=SE1->E1_VENCTO
						mparcela:=mparcela+SE1->E1_PARCELA
					Case mit==5
						mParc5:=SE1->E1_VALOR
						mvenc5:=SE1->E1_VENCTO
						mparcela:=mparcela+SE1->E1_PARCELA
					Case mit==6
						mParc6:=SE1->E1_VALOR
						mvenc6:=SE1->E1_VENCTO
						mparcela:=mparcela+SE1->E1_PARCELA
					Case mit==7
						mParc7:=SE1->E1_VALOR
						mvenc7:=SE1->E1_VENCTO
						mparcela:=mparcela+SE1->E1_PARCELA
					Case mit==8
						mParc8:=SE1->E1_VALOR
						mvenc8:=SE1->E1_VENCTO
						mParcela:=mparcela+SE1->E1_PARCELA
					Case mit==9
						mParc9:=SE1->E1_VALOR
						mvenc9:=SE1->E1_VENCTO
						mParcela:=mparcela+SE1->E1_PARCELA
					Case mit==10
						mParc10:=SE1->E1_VALOR
						mvenc10:=SE1->E1_VENCTO
						mParcela:=mparcela+SE1->E1_PARCELA
					Case mit==11
						mParc11:=SE1->E1_VALOR
						mvenc11:=SE1->E1_VENCTO
						mParcela:=mparcela+SE1->E1_PARCELA
					Case mit==12
						mParc12:=SE1->E1_VALOR
						mvenc12:=SE1->E1_VENCTO
						mParcela:=mparcela+SE1->E1_PARCELA
				EndCase
			Endif
			If SE1->E1_VENCTO+30 <= dDatabase
				mInadimpl++
			Endif
		Endif
		DbSelectArea("SE1")
		DbSkip()
	End
	
	If mInadimpl == 0 .AND. mAberto == 0
		DbSelectArea("SE1")
		Loop
	Endif
	
	If mAtualiza=='N'
		DbSelectArea("SE1")
		Loop
	Endif
	
	GRAVA()
	
	DbSelectArea("SE1")
	If Eof()
		Exit
	EndIf
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
If DbSeek(xFilial("SB1")+mProd)
	mTitulo:=SB1->B1_TITULO
Else
	mTitulo:="  "
Endif

DbSelectArea("SA1")
DbSetOrder(1)
//DbGoTop()
If DbSeek(xFilial("SA1")+mCodCli)
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
Else
	mNomeCli := SPACE(40)
Endif

If mNomeCli<>"  "
	If mCodDest#" "
		DbSelectArea("SZN")
		If DbSeek(xFilial("SZN")+mCodCli+mCodDest)
			mDest:= SZN->ZN_NOME
		Endif
		DbSelectArea("SZO")
		If DbSeek(xFilial("SZO")+mCodCli+mCodDest)
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

mConta1++

DbSelectArea(cArq)
RecLock(cArq,.T.)
Replace Z1_Pedido   With  mPedido
Replace Z1_Item     With  mItem
Replace Z1_CodCli   With  mCodCli
Replace Z1_CodDest  With  mCodDest
Replace Z1_Codprod  With  mProd
Replace Z1_CF       With  mCF
Replace Z1_CEP      With  mCEP
Replace Z1_Valor    With  mValor
Replace Z1_Nome     With  mNomeCli
Replace Z1_NDest    With  mDest
Replace Z1_End      With  mEnd
Replace Z1_Bairro   With  mBairro
Replace Z1_MUN      With  mMun
Replace Z1_UF       With  mEst
Replace Z1_Fone     With  mFone
Replace Z1_Fax      With  mFax
Replace Z1_EMAIL    With  mEMAIL
Replace Z1_CGC      With  mCGC
Replace Z1_DTPGTO   With  mDTPG
Replace Z1_DTFAT    With  mDTFAT
Replace Z1_PGTO     With  mPGTO
Replace Z1_Emaberto With  mAberto
Replace Z1_Inadimpl With  mInadimpl
Replace Z1_Descr    With  mTitulo
Replace Z1_Vend     With  mVend
Replace Z1_Parc1    With  mParc1
Replace Z1_Parc2    With  mParc2
Replace Z1_Parc3    With  mParc3
Replace Z1_Parc4    With  mParc4
Replace Z1_Parc5    With  mParc5
Replace Z1_Parc6    With  mParc6
Replace Z1_Parc7    With  mParc7
Replace Z1_Venc1    With  mVenc1
Replace Z1_Venc2    With  mVenc2
Replace Z1_Venc3    With  mVenc3
Replace Z1_Venc4    With  mVenc4
Replace Z1_Venc5    With  mVenc5
Replace Z1_Venc6    With  mVenc6
Replace Z1_Venc7    With  mVenc7
Replace Z1_StatusI  With  '501'
Replace Z1_Parcela  With  mParcela
Replace Edvenc      With  mEdvenc
Replace Edinic      With  mEdinic
Replace Edsusp      With  mEdsusp
Replace Situac      with  Msituac
Replace Tipoop      With  mTipoop
Replace Descrop     With  mDescrop
Replace Z1_Vldupl   with  mVltot
Replace Parcela     With  mParc
Replace Z1_obs3     With  tipoop+'-'+descrop
Replace Regiao      With  mRegiao
Replace Divvend     With  mDivvend
Replace Nomevend    With  mNomevend

MsUnlock()

Return

Static FUNCTION IMPR2()
IF L==0
	L++
	CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho,nCaracter)
	L :=4
//0	@ L,00 PSAY REPLICATE('*',79)
	L += 2
ENDIF
RETURN

Static FUNCTION IMPR3()
IF L<>0
	IF L==64 .OR. L+10>=64
		L := 0
	ELSE
		L++
	ENDIF
ENDIF
RETURN


Static FUNCTION IMPR4()
IF L<>0
	IF L==64
		L:=0
	ELSE
		L++
	ENDIF
ENDIF
RETURN

Static FUNCTION CABEC2()
@ L,01 PSAY 'EM ABERTO / TITULO'
@ L,27 PSAY 'PEDIDO'
@ L,34 PSAY 'ITEM'
@ L,39 PSAY 'SUSP'
@ L,44 PSAY 'ED.INI'
@ L,51 PSAY 'ED.VENC'
@ L,59 PSAY 'VENC/FAT'
@ L,68 PSAY 'VALOR'
@ L,75 PSAY 'VEND'
RETURN

Static FUNCTION EXTRATO()

@ L,01 PSAY LTRIM(STR(MINADIMPL,1))+'/'+LTRIM(STR(MPARCELA,1))+' '+SUBS(TRIM(mTitulo),1,25)
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

MCONTA:=0

DBSELECTAREA(cArq)
PROCREGUA(RECCOUNT())
DBGOTOP()
WHILE !EOF()
	MCONTA:=MCONTA+1
	IncProc()
	IMPR3()
	IMPR2()
	DBSELECTAREA(cArq)
	
/*	MCHAVE  :=CODCLI+CODDEST
	MCHAVE2 :=CODCLI+CODDEST
	@ L,01   PSAY 'COD CLI...: '+Z1_CODCLI
	@ L,27   PSAY 'COD DEST..: '+Z1_CODDEST
	@ L,54   PSAY 'FONE....:'   +TRIM(FONE)
	@ L+1,01 PSAY 'NOME......: '+NOME
	@ L+1,54 PSAY 'CPF/CGC.:'   +TRIM(CGC)
	@ L+2,01 PSAY 'DEST......: '+NDEST
	@ L+3,01 PSAY 'ENDERECO..: '+ MEND
	@ L+3,54 PSAY 'BAIRRO..:'   +BAIRRO
	@ L+4,01 PSAY 'CIDADE/EST: '+TRIM(MUN)+' '+UF
	@ L+4,57 PSAY 'EMAIL...:'   +MEMAIL
	@ L+5,01 PSAY 'CEP.......: '+SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)
*/


	MCHAVE  :=Z1_CODCLI+Z1_CODDEST
	MCHAVE2 :=Z1_CODCLI+Z1_CODDEST
	@ L,01   PSAY 'COD CLI...: '+Z1_CODCLI
	@ L,27   PSAY 'COD DEST..: '+Z1_CODDEST
	@ L,54   PSAY 'FONE....:'   +TRIM(Z1_FONE)
	@ L+1,01 PSAY 'NOME......: '+Z1_NOME
	@ L+1,54 PSAY 'CPF/CGC.:'   +TRIM(Z1_CGC)
	@ L+2,01 PSAY 'DEST......: '+Z1_NDEST
	@ L+3,01 PSAY 'ENDERECO..: '+ MEND
	@ L+4,01 PSAY 'BAIRRO..:'   +Z1_BAIRRO
	@ L+4,31 PSAY 'CIDADE/EST: '+TRIM(Z1_MUN)+' '+Z1_UF
	@ L+4,57 PSAY 'EMAIL...:'   +MEMAIL
	@ L+5,01 PSAY 'CEP.......: '+SUBS(Z1_CEP,1,5)+'-'+SUBS(Z1_CEP,6,3)

	L:=L+6
	CABEC2()
	DO WHILE MCHAVE2==MCHAVE
		DBSELECTAREA(cArq)
		IMPR4()
		IMPR2()
		IF L==0
			CABEC2()
			L:=L+1
		ENDIF
		
/*		mEdsusp:=" "
		mEdvenc:=" "
		mEdinic:=" "
		mDtvend:=" "
		mSituac:=SITUAC
		mPedido:=PEDIDO
		mItem  :=ITEM
		mEdvenc:=EDVENC
		mEdinic:=EDINIC
		mEdsusp:=EDSUSP
		mCodrev:=Subs(CODPROD,1,4)
		mValor :=VALOR
		mTitulo:=TRIM(SUBS(CODPROD,1,10))+' '+TRIM(SUBS(DESCR,1,10))
		mVend  :=VEND
		mDtfat :=DTFAT
		mEmaberto:=EMABERTO
		mParcela :=PARCELA
		mInadimpl:=INADIMPL
		mEmail   :=EMAIL
  */

		mEdsusp:=" "
		mEdvenc:=" "
		mEdinic:=" "
		mDtvend:=" "
		mSituac:=SITUAC
		mPedido:=Z1_PEDIDO
		mItem  :=Z1_ITEM
		mEdvenc:=EDVENC
		mEdinic:=EDINIC
		mEdsusp:=EDSUSP
		mCodrev:=Subs(Z1_CODPROD,1,4)
		mValor :=VALOR
		mTitulo:=TRIM(SUBS(Z1_CODPROD,1,10))+' '+TRIM(SUBS(Z1_DESCR,1,10))
		mVend  :=Z1_VEND
		mDtfat :=Z1_DTFAT
		mEmaberto:=Z1_EMABERTO
		mParcela :=PARCELA
		mInadimpl:=Z1_INADIMPL
		mEmail   :=Z1_EMAIL

		
		DbSelectArea ("SZJ")
		DbGoTop()
		If DbSeek(xFilial("SZJ")+mCodRev+Str(MEDVENC,4))
			mDtvenc:=SZJ->ZJ_DTCIRC
		else
			mDtvenc:=mDtfat
		Endif
		EXTRATO()
		DBSELECTAREA(cArq)
		IF EOF()
			EXIT
		ELSE
			DBSELECTAREA(cArq)
			DBSKIP()
			MCHAVE2 :=Z1_CODCLI+Z1_CODDEST
			IF MCHAVE2<>MCHAVE
				IF L<>0
					L:=L+1
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
// Substituido pelo assistente de conversao do AP5 IDE em 25/03/02 ==> Function FARQTRAB
Static Function FARQTRAB()

_aCampos := {}
AADD(_aCampos,{"Z1_PEDIDO",	"C", 6,0})
AADD(_aCampos,{"Z1_ITEM",   	"C", 2,0})
AADD(_aCampos,{"Z1_CF",		"C", 5,0})
AADD(_aCampos,{"Z1_CODCLI",	"C", 6,0})
AADD(_aCampos,{"Z1_CODDEST",   "C", 6,0})
AADD(_aCampos,{"Z1_NOME",	    "C",40,0})
AADD(_aCampos,{"Z1_NDEST",  	"C",40,0})
AADD(_aCampos,{"Z1_END",	    "C",120,0})
AADD(_aCampos,{"Z1_BAIRRO",	"C",20,0})
AADD(_aCampos,{"Z1_MUN",   	"C",20,0})
AADD(_aCampos,{"Z1_UF",		"C", 2,0})
AADD(_aCampos,{"Z1_CEP",	    "C", 8,0})
AADD(_aCampos,{"Z1_CGC",    	"C",14,0})
AADD(_aCampos,{"Z1_FONE",  	"C",20,0})
AADD(_aCampos,{"Z1_FAX",   	"C",20,0})
AADD(_aCampos,{"Z1_EMAIL", 	"C",20,0})
AADD(_aCampos,{"Z1_CODPROD",   "C",15,0})
AADD(_aCampos,{"Z1_DESCR", 	"C",40,0})
AADD(_aCampos,{"Z1_DTPGTO",	"D", 8,0})
AADD(_aCampos,{"Z1_DTFAT ",	"D", 8,0})
AADD(_aCampos,{"Z1_VALOR", 	"N",12,2})
AADD(_aCampos,{"Z1_PARC1", 	"N",12,2})
AADD(_aCampos,{"Z1_PARC2", 	"N",12,2})
AADD(_aCampos,{"Z1_PARC3", 	"N",12,2})
AADD(_aCampos,{"Z1_PARC4", 	"N",12,2})
AADD(_aCampos,{"Z1_PARC5", 	"N",12,2})
AADD(_aCampos,{"Z1_PARC6", 	"N",12,2})
AADD(_aCampos,{"Z1_PARC7", 	"N",12,2})
AADD(_aCampos,{"Z1_VENC1", 	"D", 8,2})
AADD(_aCampos,{"Z1_VENC2",	    "D", 8,2})
AADD(_aCampos,{"Z1_VENC3", 	"D", 8,2})
AADD(_aCampos,{"Z1_VENC4", 	"D", 8,2})
AADD(_aCampos,{"Z1_VENC5", 	"D", 8,2})
AADD(_aCampos,{"Z1_VENC6", 	"D", 8,2})
AADD(_aCampos,{"Z1_VENC7", 	"D", 8,2})
AADD(_aCampos,{"Z1_PGTO",  	"N", 5,2})
AADD(_aCampos,{"Z1_EMABERT",   "N", 5,0})
AADD(_aCampos,{"Z1_INADIMP",   "N", 5,0})
AADD(_aCampos,{"Z1_VEND",  	"C", 6,0})
AADD(_aCampos,{"Z1_STATUSI",   "C", 3,0})
AADD(_aCampos,{"Z1_PARCELA",   "C",12,0})
AADD(_aCampos,{"Z1_VLDUPL",	"N",12,2})
AADD(_aCampos,{"Z1_OBS3",  	"C",60,2})
AADD(_aCampos,{"EDVENC",   	"N", 4,0})
AADD(_aCampos,{"EDINIC",   	"N", 4,0})
AADD(_aCampos,{"EDSUSP",   	"N", 4,0})
AADD(_aCampos,{"SITUAC",   	"C", 2,0})
AADD(_aCampos,{"TIPOOP",   	"C", 2,0})
AADD(_aCampos,{"DESCROP",  	"C",50,0})
AADD(_aCampos,{"PARCELA",  	"N",5,0})
AADD(_aCampos,{"DIVVEND",  	"C",40,0})
AADD(_aCampos,{"NOMEVEND",  	"C",40,0})
AADD(_aCampos,{"REGIAO",   	"C",3,0})

_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "Z1_PEDIDO+Z1_ITEM"

dbUseArea(.T.,, _cNome,cArq,.F.,.F.)
dbSelectArea(cArq)
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")

Return

Static Function F_VERSZA()

DBSELECTAREA("SZA")
DBGOTOP()
DBSEEK(XFILIAL("SZA")+MV_PAR14)
IF !FOUND()
	MsgStop("Promo‡Æo nÆo cadastrada")
	MsgStop("Entrar em contato com depto de Cadastro")
	mValida:="N"
ELSE
	DBSELECTAREA('SX5')
	//DBGOTOP()
	DBSEEK(XFILIAL("SX5")+'91'+'931')
	IF !FOUND()
		MsgStop("Mailing nÆo cadastrado")
		MsgStop("Entrar em contato com depto de Marketing")
		mValida:="N"
	ELSE
		mValida:="S"
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
Replace ZZ7_CODPRO With MV_PAR14
Replace ZZ7_CODMAI With '931'
Replace ZZ7_USUAR  With Subs(cUsuario,7,15)
Replace ZZ7_DATA   With Date()
Replace ZZ7_QTDE   With mConta1
Replace ZZ7_SAIDA  With STR(MV_PAR11,1)
Replace ZZ7_PROD1  With MV_PAR07
Replace ZZ7_PROD2  With MV_PAR08
Replace ZZ7_CEP1   With MV_PAR09
Replace ZZ7_CEP2   With MV_PAR10
MsUnLock()

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ _ValidPerg                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Valida grupo de perguntas                                     ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Substituido pelo assistente de conversao do AP5 IDE em 25/03/02 ==> Function _ValidPerg
Static Function _ValidPerg()

_sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

AADD(aRegs,{cPerg,"01","Regiao de .........:","mv_ch1","C",03,0,0,"G","","mv_par01","","0108001","","","","","","","","","","","","","ZZ9"})
AADD(aRegs,{cPerg,"02","Regiao at‚.........:","mv_ch2","C",03,0,0,"G","","mv_par02","","0108003","","","","","","","","","","","","","ZZ9"})
AADD(aRegs,{cPerg,"03","Vendedor de........:","mv_ch3","C",06,0,0,"G","","mv_par03","","0108001","","","","","","","","","","","","","SA3"})
AADD(aRegs,{cPerg,"04","Vendedor at‚.......:","mv_ch4","C",06,0,0,"G","","mv_par04","","0108003","","","","","","","","","","","","","SA3"})
AADD(aRegs,{cPerg,"05","Vencidos de........:","mv_ch5","D",08,0,0,"G","","mv_par05","","'01/06/99'","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"06","Vencidos at‚.......:","mv_ch6","D",08,0,0,"G","","mv_par06","","'17/04/00'","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"07","Produto de.........:","mv_ch7","C",15,0,0,"G","","mv_par07","","0108001","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"08","Produto at‚........:","mv_ch8","C",15,0,0,"G","","mv_par08","","0108003","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"09","Cep de.............:","mv_ch9","C", 8,0,0,"G","","mv_par09","","00000000","","","","","","","","","","","","","ZZ0"})
AADD(aRegs,{cPerg,"10","Cep At‚............:","mv_chA","C", 8,0,0,"G","","mv_par10","","99999999","","","","","","","","","","","","","ZZ0"})
AADD(aRegs,{cPerg,"11","Gerar..............:","mv_chB","C",01,0,1,"C","","mv_par11","Arquivo","","","Relatorio","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"12","Dias de Atraso.....:","mv_chC","N",02,0,0,"G","","mv_par12","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"13","Inclui Parcela A...:","mv_chD","C",01,0,0,"C","","mv_par13","Sim","","","NÆo","","","Somente Parcela A","","","","","","","",""})
AADD(aRegs,{cPerg,"14","Cod. A‡Æo/Promo‡Æo.:","mv_chE","C",03,0,0,"G","","mv_par14","","","","","","","","","","","","","","",""})

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