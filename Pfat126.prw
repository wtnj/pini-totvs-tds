#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
/*/ Alterador por Danilo C S Pala em 20041014 930
//Alterador por Danilo C S Pala em 20110923: incluir prefixo e numero da nota
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT126   ³Autor: Raquel Ramalho         ³ Data:   05/02/01 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera arquivo DBF das vendas                                ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function Pfat126()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

SetPrvt("CDESC1,CDESC2,CDESC3,CTITULO,_CTITULO,ARETURN")
SetPrvt("PROGRAMA,MHORA,CARQ,CSTRING,WNREL,NLASTKEY")
SetPrvt("L,NORDEM,M_PAG,NCARACTER,TAMANHO,CCABEC1")
SetPrvt("CCABEC2,LCONTINUA,CARQPATH,_CSTRING,CPERG,MTIPO")
SetPrvt("MSAIDA,CABEC1,CABEC2,CABEC3,MCONTA1,MCONTA2")
SetPrvt("MCONTA3,LEND,BBLOCO,CINDEX,CKEY,CMSG")
SetPrvt("CCHAVE,CFILTRO,CIND,MCONTA,MQTNFAT,MVLNFAT")
SetPrvt("MPEDIDO,MITEM,MCODCLI,MCODDEST,MPRODUTO,MCF")
SetPrvt("MDTFAT,MDTPED,MFILIAL,MVEND,MTITULO,MGRUPO")
SetPrvt("MDESCR,MDESCR2,MNOMEVEND,MQTDE,MGRAT,MNOME")
SetPrvt("MDESCROP,MDIVVEND,MREVISTA,MCODTIT,MATIVIDADE,MDTPG")
SetPrvt("MPAGO,MPGTO,MPARC,MCANC,MLP,MVENC")
SetPrvt("MABERTO,MINADIMPL,MVLPAGO,MVLABERTO,MVLINADIM,MVLCANC")
SetPrvt("MVLVENC,MVLPENDEN,MVLFATURA,MIT,MVLLP,MPARC1")
SetPrvt("MPARC2,MPARC3,MPARC4,MPARC5,MPARC6,MPARC7")
SetPrvt("MPARC8,MPARC9,MPARC10,MPARC11,MPARC12,MVENCIDO")
SetPrvt("MVALOR,MDESCONTO,MVENC1,MVENC2,MVENC3,MVENC4")
SetPrvt("MVENC5,MVENC6,MVENC7,MVENC8,MVENC9,MVENC10")
SetPrvt("MVENC11,MVENC12,MCODPROM,MIDENTIF,MTIPOOP,MVLPEDIDO")
SetPrvt("MDESPREM,MCONDPGTO,MTPTRANS,MEQUIPE,MREGIAO,MAVTOTAL")
SetPrvt("MPERCPEN,MAVCANC,MDTCIRC,MEDICAO,MCHAVE1,MCHAVE2")
SetPrvt("MSERIE,MDOC,MUF,MMUN,_ACAMPOS,_CNOME")
SetPrvt("LI,MVALORT,MQTDET,MPGTOT,MEMABERTOT,MINADIMPLT")
SetPrvt("MCANCT,MVENCIDOT,MEMABERTO,_SALIAS,AREGS,I")
SetPrvt("J,")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ mv_par01 Do Produdo.........:                                           ³
//³ mv_par02 At‚ o Produto......:                                           ³
//³ mv_par03 Faturados de.......:                                           ³
//³ mv_par04 Faturados at‚......:                                           ³
//³ mv_par05 Do vendedor........:                                           ³
//³ mv_par06 At‚ vendedor.......:                                           ³
//³ mv_par07 Tipo do Pedido.....: Pagos, Cortesia                           ³
//³ mv_par08 Da regiao..........:                                           ³
//³ mv_par09 At‚ regiao.........:                                           ³
//³ mv_par10 Tipo de saida......: Arquivo  Relat¢rio                        ³
//³ mv_par11 Da Promo‡Æo........:                                           ³
//³ mv_par12 At‚ Promo‡Æo.......:                                           ³
//³ mv_par13 Divisao de Vendas..: Mercantil    Publicidade   Software  Ambos³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cDesc1    :=PADC("Este programa ira gerar o resumo de vendas por grupo de produto" ,74)
cDesc2    :=PADC("a partir do arquivo de pedidos",74)
cDesc3    :=""
cTitulo   :=PADC("RELATàRIO",74)
_cTitulo  :=" **** RESUMO DOS PEDIDOS DE VENDAS **** "
aReturn   := { "Especial", 1,"Administra‡Æo", 1, 2, 1,"",1 }
Programa  :="PFAT126"
MHORA     :=TIME()
cArq      :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString   :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
wnrel     :=SUBS(CUSUARIO,7,6)
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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso nao exista, cria grupo de perguntas.                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:="PFT126"

//_ValidPerg()
If !Pergunte(cPerg)
	Return
Endif

IF Lastkey()==27
	Return
Endif

Do Case
	Case MV_PAR07==1
		mTipo:='Pagos'
	Case MV_PAR07==2
		mTipo:='Gratu¡tos'
EndCase

mSaida    :=MV_PAR10

Cabec1:="Do Produto :"+SUBS(MV_PAR01,1,7)+"   Do Vend :"+MV_PAR05+"   Pedidos de :"+DTOC(MV_PAR03)+"   Da RegiÆo :"+MV_PAR08
//
//      1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//               10        20        30        40        50        60        70        80        90        100       110       120
Cabec2:="At‚ Produto:"+SUBS(MV_PAR02,1,7)+"   At‚ Vend:"+MV_PAR06+"   Pedidos at‚:"+DTOC(MV_PAR04)+"   At‚ RegiÆo:"+MV_PAR09+"   Tipo:"+mTipo
//
//       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                10        20        30        40        50        60        70        80        90        100       110       120
Cabec3:="Produto                                   Qtde       Valor         Pago(%)  Em Aberto(%) Vencido(%)  Cancelados(%) Inadimplencia(%) "
//       XXXXXXXXXXXXXXX                           999999999  999999999999  999999   999999       99999
//       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                10        20        30        40        50        60        70        80        90        100       110       120

mConta1   :=0
mConta2   :=0
mConta3   :=0

FArqTrab()

Filtra()

lEnd:= .F.
bBloco:= {|lEnd| PRODUTOS()}
//MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
Processa(bBloco, "Produtos" ,"Processando...", .T. )
Do While .T.
	If !Pergunte(cPerg)
		Exit
	Endif
	
	If LastKey()== 27
		Exit
	Endif
	
	Filtra()
	
	lEnd  := .F.
	bBloco:= {|lEnd|PRODUTOS()}// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>       bBloco:= { |lEnd| Execute(PRODUTOS)  }
	//MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
	Processa( bBloco, "Produtos" ,"Processando...", .T. )
End

DbSelectArea("cArq")
dbGoTop()
cIndex := CriaTrab(Nil,.F.)
cKey   := "TITULO"
Indregua("cArq",cIndex,ckey,,,"Selecionando Registros do Arq")

If mSaida==1
	cMsg:= "Arquivo Gerado com Sucesso em: "+_cString
	DbSelectArea("cArq")
	dbGoTop()
	COPY TO &_cString VIA "DBFCDXADS" // 20121106 
	MSGINFO(cMsg,"Arquivo Copiado")
EndIf

If mSaida==2
	wnrel:=SetPrint(cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
	SetDefault(aReturn,cString)
	If nLastKey == 27
		DbSelectArea("cArq")
		DbCloseArea()
		Return
	Endif
	Processa({||Relatorio()})// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        RptStatus( {||Execute(Relatorio)} )
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorna indices originais...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("cArq")
DbCloseArea()
DbSelectArea("SA1")
Retindex("SA1")
DbSelectArea("SC6")
Retindex("SC6")
DbSelectArea("SC5")
Retindex("SC5")
DbSelectArea("SA3")
Retindex("SA3")
DbSelectArea("SE1")
Retindex("SD2")
DbSelectArea("SD2")
Retindex("SE1")
DbSelectArea("SB1")
Retindex("SB1")
DbSelectArea("SX5")
Retindex("SX5")
DbSelectArea("SF4")
Retindex("SF4")
DbSelectArea("SZ9")
Retindex("SZ9")
DbSelectArea("SE4")
Retindex("SE4")
DbSelectArea("ZZ8")
Retindex("ZZ8")

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ Filtra()                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Filtra arquivo SC5 para ser utilizado no programa.            ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function FILTRA()
DbSelectArea("SC5")
DbGoTop()
cChave  := IndexKey()
cFiltro := 'DTOS(C5_DATA)>="'+DTOS(MV_PAR03)+'" .AND. DTOS(C5_DATA)<="'+DTOS(MV_PAR04)+'"'
cFiltro := Alltrim(cFiltro)+'.AND.C5_VEND1>="'+MV_PAR05+'".AND.C5_VEND1<="'+MV_PAR06+'"'
cFiltro := Alltrim(cFiltro)+'.AND.C5_CODPROM>="'+MV_PAR11+'".AND.C5_CODPROM<="'+MV_PAR12+'"'
Do Case
	Case MV_PAR13 == 1
		cFiltro := Alltrim(cFiltro)+'.AND.C5_DIVVEN=="MERC"'
	Case MV_PAR13 == 2
		cFiltro := Alltrim(cFiltro)+'.AND.C5_DIVVEN=="PUBL"'
	Case MV_PAR13 == 3
		cFiltro := Alltrim(cFiltro)+'.AND.C5_DIVVEN=="SOFT"'
EndCase
cInd   := CriaTrab(NIL,.f.)
MsAguarde({|| IndRegua("SC5",cInd,cChave,,cFiltro,"Filtrando Pedidos...")},"Aguarde", "Gerando Indice Temporario (SC5)...")
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
mConta :=0
mQtNFat:=0
mVlNFat:=0
DbSelectArea("SC5")
DbGoTop()
cPedAnt := "ZZZZZZ"
While !EOF()
	mPedido := ""
	mItem   := ""
	mCodCli := ""
	mCodDest:= ""
	mProduto:= ""
	mCF     := ""
	mDTFat  := stod("")
	mDTPed  := stod("")
	mFilial := ""
	mVend   := ""
	mTitulo := ""
	mGrupo  := ""
	mDescr  := ""
	mDescr2 := ""
	mNomeVend:=""
	mQtde   := 0
	mGrat   :=""
	mNome   :=""
	mDescrop:=""
	mDivVend:=""
	mRevista:=""
	mCodTit :=""
	mAtividade:=""
	mDTPG   := stod("")
	mPago   := 0
	mPgto   := 0
	mParc   := 0
	mcanc   := 0
	mLP     := 0
	mVenc   := 0
	mAberto := 0
	mInadimpl:=0
	mVlPago  :=0
	mVlAberto:=0
	mVlInadim:=0
	mVlcanc  :=0
	mVlVenc  :=0
	mVlPenden:=0
	mVlFatura:=0
	mIt      :=0
	mVlLP   := 0
	mParc1  := 0
	mParc2  := 0
	mParc3  := 0
	mParc4  := 0
	mParc5  := 0
	mParc6  := 0
	mParc7  := 0
	mParc8  := 0
	mParc9  := 0
	mParc10 := 0
	mParc11 := 0
	mParc12 := 0
	mVencido:= 0
	mValor  := 0
	mQtde   := 0
	mVenc   :=0
	mDesconto:=0
	mVenc1  := stod("")
	mVenc2  := stod("")
	mVenc3  := stod("")
	mVenc4  := stod("")
	mVenc5  := stod("")
	mVenc6  := stod("")
	mVenc7  := stod("")
	mVenc8  := stod("")
	mVenc9  := stod("")
	mVenc10 := stod("")
	mVenc11 := stod("")
	mVenc12 := stod("")
	mPedido :=SC5->C5_NUM
	mVend   :=SC5->C5_VEND1
	mCodProm:=SC5->C5_CODPROM
	mIdentif:=SC5->C5_IDENTIF
	mTipoop :=SC5->C5_TIPOOP
	mDtPed   :=SC5->C5_DATA
	mVlPedido:=SC5->C5_VLRPED+SC5->C5_DESPREM
	mDespRem :=SC5->C5_DESPREM
	mCondPgto:=SC5->C5_CONDPAG
	mTpTrans :=SC5->C5_TPTRANS
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Elimina pedidos de Publicidade                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
	
	DbSelectArea("SA3")
	dbSetOrder(1)
	DbGoTop()
	If DbSeek(xFilial("SA3")+mVend, .T.)
		mEquipe   := SA3->A3_EQUIPE
		mRegiao   := SA3->A3_REGIAO
		mDivVend  := SA3->A3_DIVVEND
		mNomeVend := SA3->A3_NOME
	EndIf
	
	If mRegiao < MV_PAR08 .OR. mRegiao > MV_PAR09
		DbSelectArea("SC5")
		DbSkip()
		Loop
	Endif
	
	DbSelectArea("SZ9")       
	dbSetOrder(1)
	DbGoTop()
	If DbSeek(xFilial("SZ9")+mTipoop,.T.)
		mDescrop := SZ9->Z9_DESCR
	Endif
	
	IF SC5->C5_DIVVEN == 'PUBL'
		DbSelectArea("SE4")
		dbSetOrder(1)
		DbGoTop()
		If DbSeek(xFilial("SE4")+mCondpgto,.T.)
			mDescrop := SE4->E4_DESCRI
		Endif
	Endif
	
	DbSelectArea("SZS")
	DbGoTop()
	If DbSeek(xFilial("SZS")+mPedido+mItem, .T.)
		mVlPenden := 0
		mAvTotal  := 0
		mPercPen  := 1
		If SZS->ZS_FATPROG == 'S'
			DbSelectArea("SZV")
			DbGoTop()
			DbSetOrder(1)
			DbSeek(xFilial("SZV")+mPedido, .T.)
			While !Eof() .and. SZV->ZV_FILIAL == xFilial("SZV") .and. mPedido==SZV->ZV_NUMAV
				If SZV->ZV_SITUAC=='AA'
					mAvtotal:=SZV->ZV_VALOR+mAvtotal
				Endif
				
				If SZV->ZV_SITUAC=='AA' .and. Empty(SZV->ZV_NFISCAL)
					mVlPenden += SZV->ZV_VALOR
				Endif
				DbSkip()
			End
			mPercPen := mVlpenden/mAvtotal
		Endif
	Endif
		
	DbSelectArea("SC6")
	DbGoTop()
	If DbSeek(xFilial("SC6")+mPedido, .T.)
		ProcRegua(LastRec())
		While SC6->C6_NUM==mPedido
			mAvCanc  :=0
			mDtcirc  :=stod("")
			mEdicao  :=0
			
			IncProc("Lendo Registros : "+StrZero(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
			
			If (SC6->C6_PRODUTO < MV_PAR01) .or. (SC6->C6_PRODUTO > MV_PAR02) .OR. MCF=='596'
				DbSelectArea("SC6")
				DbSkip()
				Loop
			EndIf
			
			If SM0->M0_CODIGO=='01'
				If (SC6->C6_TES) $ "700/701/703"
					DbSelectArea("SC6")
					DbSkip()
					Loop
				Endif
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Elimina duplicidade de pedido+item na grava‡Æo do arquivo    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			DbSelectArea("cArq")
			DbGoTop()
			If DbSeek(SC6->C6_NUM+SC6->C6_Item)
				DbSelectArea("SC6")
				DbSkip()
				Loop
			EndIf
			
			DbSelectArea("SF4")
			DbSetOrder(1)
			DbGoTop()
			DbSeek(xFilial("SF4")+SC6->C6_TES)
			If 'N' $(SF4->F4_DUPLIC) .OR. SC6->C6_PRCVEN==1 .OR. SC6->C6_PRCVEN==0
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se ‚ cortesia para parƒmetro=pago                   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If MV_PAR07==1
					DbSelectArea("SC6")
					DbSkip()
					Loop
				EndIf
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se ‚ pago para parƒmetro=cortesia                   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If MV_PAR07==2
					DbSelectArea("SC6")
					DbSkip()
					Loop
				EndIf
			EndIf
			
			mProduto:= SC6->C6_PRODUTO
			mDTFat  := SC6->C6_DATFAT
			mCodCli := SC6->C6_CLI
			mItem   := SC6->C6_ITEM
			mValor  := SC6->C6_VALOR
			mCF     := AllTrim(SC6->C6_CF)
			mCodDest:= SC6->C6_CODDEST
			mFilial := SC6->C6_FILIAL
			mQtde   := SC6->C6_QTDVEN
			mDtfat  := SC6->C6_DATFAT
			mEdicao  :=SC6->C6_EDINIC
			mDtcirc  :=SC6->C6_DTINIC
			
			If Empty(SC6->C6_DATFAT) .AND. mGrat<>'S'
				mQtNFat:=mQtNFat+SC6->C6_QTDVEN
				mVlNFat:=mVlNFat+SC6->C6_VALOR
				mVlPenden:=mValor
			EndIf
			
			DbSelectArea("SZS")
			DbSetOrder(1)
			DbGotop()
			DbSeek(xFilial("SZS")+mPedido+mItem, .T.)
			If Found()
				mEdicao :=SZS->ZS_EDICAO
				mDtcirc :=SZS->ZS_DTCIRC
				mAvcanc:=0
				mCodTit:=SZS->ZS_CODTIT
				mVlPenden:=0
				While mPedido==SZS->ZS_NUMAV .and. mItem==SZS->ZS_ITEM
					If SZS->ZS_SITUAC=='CC'
						mAvCanc:=SZS->ZS_VALOR+mAvCanc
					Endif
					If SZS->ZS_SITUAC=='AA' .and. Empty(SZS->ZS_NFISCAL) .AND. SZS->ZS_FATPROG<>'S'
						mVlPenden:=SZS->ZS_VALOR+mVlPenden-mAvCanc
					Endif
					DbSkip()
				End
				DbSkip(-1)
				If SZS->ZS_FATPROG=='S'
					mVlPenden:=(mVaLor-mAvCanc)*mPercPen
				Endif
			Endif

			GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Execute(GRAVA)
            IncProc("Lendo Registros : "+StrZero(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
			DbSelectArea("SC6")
			DbSkip()
		End
		
		//mChave1:=mPedido+'UNI'
		mChave2:=mPedido
		DbSelectArea("SD2")
		DbSetOrder(8)
		DbGoTop()
		/*If DbSeek(xFilial("SD2")+mChave1)
			mSerie :=SD2->D2_SERIE
			mDoc   :=SD2->D2_DOC
			mDtfat :=SD2->D2_EMISSAO
		Else
			DbGoTop()*/
			If DbSeek(xFilial("SD2")+mChave2)
				mSerie :=SD2->D2_SERIE
				mDoc   :=SD2->D2_DOC
				mDtfat :=SD2->D2_EMISSAO
			Endif
		//Endif
		
		DbSelectArea("SE1")
		DbOrderNickName("E1_PEDIDO") //dbSetOrder(27) 20130225  ///dbSetOrder(15) AP5 //20090114 era(21) //20090723 mp10 era(22) //dbSetOrder(26) 20100412
		DbGoTop()
		DbSeek(xFilial("SE1")+mPedido)
		
		While ( SE1->E1_PEDIDO==mPedido)
			IF SE1->E1_SERIE<>mSerie
				DbSkip()
				loop
			Endif
			mParc := mParc+1
			mDTPG:= SE1->E1_BAIXA
			mit:=mit+1
			Do Case
				Case mit==1
					mParc1:=SE1->E1_VALOR
					mvenc1:=SE1->E1_VENCTO
				Case mit==2
					mParc2:=SE1->E1_VALOR
					mvenc2:=SE1->E1_VENCTO
				Case mit==3
					mParc3:=SE1->E1_VALOR
					mvenc3:=SE1->E1_VENCTO
				Case mit==4
					mParc4:=SE1->E1_VALOR
					mvenc4:=SE1->E1_VENCTO
				Case mit==5
					mParc5:=SE1->E1_VALOR
					mvenc5:=SE1->E1_VENCTO
				Case mit==6
					mParc6:=SE1->E1_VALOR
					mvenc6:=SE1->E1_VENCTO
				Case mit==7
					mParc7:=SE1->E1_VALOR
					mvenc7:=SE1->E1_VENCTO
				Case mit==8
					mParc8:=SE1->E1_VALOR
					mvenc8:=SE1->E1_VENCTO
				Case mit==9
					mParc9:=SE1->E1_VALOR
					mvenc9:=SE1->E1_VENCTO
				Case mit==10
					mParc10:=SE1->E1_VALOR
					mvenc10:=SE1->E1_VENCTO
				Case mit==11
					mParc11:=SE1->E1_VALOR
					mvenc11:=SE1->E1_VENCTO
				Case mit==12
					mParc12:=SE1->E1_VALOR
					mvenc12:=SE1->E1_VENCTO
			EndCase
			
			If !Empty(MDTPG) .And. E1_SALDO==0;
				.AND. !'LP'$(SE1->E1_MOTIVO);
				.AND. !'CAN'$(SE1->E1_MOTIVO);
				.AND. !'DEV'$(SE1->E1_MOTIVO);
				.AND. !'920'$(SE1->E1_PORTADO) .AND. !'930'$(SE1->E1_PORTADO) .AND. !'904'$(SE1->E1_PORTADO) //20041014
				
				mPago:=mPago+1
				mVlPago:=mVlpago+SE1->E1_VALOR
				mDesconto:=SE1->E1_DESCONT+mDesconto
			Else
				Do Case
					Case SE1->E1_VENCTO+30 < DATE().AND. !'CAN'$(SE1->E1_MOTIVO);
						.AND.!'LP'$(SE1->E1_MOTIVO).And.!'920'$(SE1->E1_PORTADO)  //20041014
						mInadimpl:=mInadimpl+1
						mVlInadim:=mVlInadim+SE1->E1_VALOR
					Case SE1->E1_VENCTO < DATE().AND.!'CAN'$(SE1->E1_MOTIVO);
						.AND.!'LP'$(SE1->E1_MOTIVO).and.!'920'$(SE1->E1_PORTADO) .and.!'930'$(SE1->E1_PORTADO)  //20041014
						mVlVenc:=mVlVenc+SE1->E1_VALOR
						mVenc  :=mVenc+1
					Case 'LP'$(SE1->E1_MOTIVO)  .or. (SE1->E1_PORTADO)$'904'
						mLP  :=mLp+1
						mVlLP:=mVlLP+SE1->E1_VALOR
					Case 'CAN'$(SE1->E1_MOTIVO);
						.OR. '920'$(SE1->E1_PORTADO) .OR. '930'$(SE1->E1_PORTADO)   //20041014
						mCanc:=mCanc+1
						mVlCanc:=mVlCanc+SE1->E1_VALOR
					OtherWise
						mAberto:=mAberto+1
						mVlAberto:=mVlAberto+SE1->E1_VALOR
				EndCase
			Endif
			
			mVlFatura:=mVlFatura+SE1->E1_VALOR
			DbSelectArea("SE1")
			DbSkip()
		End
		
		mPgto     := mPago/mParc
		mInadimpl := mInadimpl/mParc
		mAberto   := mAberto/mParc
		mCanc     := mCanc/mParc
		mLp       := mLp/mParc
		mVenc     := mVenc/mParc
		If mPedido == cPedAnt
			mVlPedido := 0
		Endif			
		cPedAnt := mPedido
		ATDUPL()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>                    Execute(ATDUPL)
	Else
		DbSelectArea("SC5")
		DbSkip()
		Loop
	EndIf
	
	DbSelectArea("SC5")
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
mNome      := ""
mUF        := ""
mMun       := ""
mGrupo     := ""
mDescr     := ""
mRevista   := ""
mTitulo    := ""
mDescr2    := ""
mAtividade := ""

DbSelectArea("SB1")
DbGoTop()
DbSeek(xFilial("SB1")+mProduto)
If Found()
	mGrupo  := AllTrim((SB1->B1_GRUPO))
	mDescr  := SB1->B1_DESC
	mDescr2 := SB1->B1_DESC
Endif

DbSelectArea("SB1")
DbGoTop()
If DbSeek(xFilial("SB1")+subs(mProduto,1,4)+'000')
	mRevista:=SB1->B1_DESC
Endif

If subs(mProduto,1,2)=='03'
	mDescr:=mRevista
Endif

/*
DbSelectArea("SX5")
DbGoTop()
DbSeek(xFilial("SX5")+'03'+mGrupo+'  ')
If Found()
	mTitulo := SX5->X5_DESCRI
Endif
*/
DbSelectArea("SBM")
// DbGoTop()
If DbSeek(xFilial("SBM")+mGrupo)
	mTitulo := SBM->BM_DESC
Endif

DbSelectArea("SX5")
DbGoTop()
DbSeek(xFilial("SX5")+'Z0'+mTpTrans+'  ')
If Found()
	mTipoop  := mTpTrans
	mTpTrans := SX5->X5_DESCRI
Endif

DbSelectArea("SA1")
DbGoTop()
DbSeek(xFilial("SA1")+mCodcli)
If Found()
	mNome      := SA1->A1_NOME
	mUF        := SA1->A1_EST
	mMun       := SA1->A1_MUN
	mAtividade := SA1->A1_ATIVIDA
Endif

DbSelectArea("ZZ8")
DbGoTop()
DbSeek(xFilial("ZZ8")+mAtividade)
If Found()
	mAtividade := ZZ8->ZZ8_DESCR
Endif

mConta1 := mConta1+1



DbSelectArea("cArq")
RecLock("cArq",.T.)
REPLACE Pedido   With  mPedido
REPLACE Item     With  mItem
REPLACE CodCli   With  mCodCli
REPLACE CodDest  With  mCodDest
REPLACE Produto  With  mProduto
REPLACE Tipoop   With  mTipoop
REPLACE Descrop  With  mDescrop
REPLACE NomeVend With  mNomeVend
REPLACE CF       With  mCF
REPLACE VlItem   With  mValor
REPLACE DtPed    With  mDtPed  
REPLACE DtFat    With  mDtFat
REPLACE Titulo   With  mTitulo
REPLACE Revista  With  mRevista
REPLACE Descr    With  mDescr
REPLACE Descr2   With  mDescr2
REPLACE Vend     With  mVend
REPLACE Regiao   With  mRegiao
REPLACE Equipe   With  mEquipe
REPLACE Qtde     With  mQtde
REPLACE CodProm  With  mCodProm
REPLACE Identif  With  mIdentif
REPLACE Nome     With  mNome
REPLACE UF       With  mUF
REPLACE Mun      With  mMun
REPLACE DivVend  With  mDivVend
REPLACE Ativida  With  mAtividade
REPLACE AvCanc   With  mAvCanc
REPLACE VlPenden With  mVlPenden
REPLACE Tptrans  With  mTpTrans
REPLACE CodTit   With  mCodTit
REPLACE Edicao   With  mEdicao
REPLACE DtCirc   With  mDtcirc
MSUNLOCK()
Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ ATDUPL()                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Realiza gravacao dos registros ideais (conforme parametros)   ³
//³           ³ para impressao de Relatorio.                                  ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function ATDUPL()
DbSelectArea("cArq")
DbGoTop()
If dbSeek(mPedido+mItem)
	RecLock("cArq",.F.)
	REPLACE DtFat    With  mDtFat
	REPLACE VlPedido With  mVlPedido
	REPLACE DespRem  With  mDespRem
	REPLACE VlFatura With  mVlFatura
	REPLACE VlPago   With  mVlPago
	REPLACE VlAvencer With mVlAberto
	REPLACE VlVencido With mVlVenc
	REPLACE VlInadim With  mVlInadim
	REPLACE Vlcanc   With  mVlcanc
	REPLACE VlLp     With  mVlLp
	REPLACE Pgto     With  mPgto
	REPLACE AVencer  With  mAberto
	REPLACE Inadimpl with  mInadimpl
	REPLACE Canc     With  mCanc
	REPLACE LP       With  mLp
	REPLACE Vencido  With  mVenc
	REPLACE Parcela  With  mParc
	REPLACE Desconto With  mDesconto
	REPLACE VlPenden With  mVlPenden
	REPLACE Parc1    With  mParc1
	REPLACE Parc2    With  mParc2
	REPLACE Parc3    With  mParc3
	REPLACE Parc4    With  mParc4
	REPLACE Parc5    With  mParc5
	REPLACE Parc6    With  mParc6
	REPLACE Parc7    With  mParc7
	REPLACE Parc8    With  mParc8
	REPLACE Parc9    With  mParc9
	REPLACE Parc10   With  mParc10
	REPLACE Parc11   With  mParc11
	REPLACE Parc12   With  mParc12
	REPLACE Venc1    With  mVenc1
	REPLACE Venc2    With  mVenc2
	REPLACE Venc3    With  mVenc3
	REPLACE Venc4    With  mVenc4
	REPLACE Venc5    With  mVenc5
	REPLACE Venc6    With  mVenc6
	REPLACE Venc7    With  mVenc7
	REPLACE Venc8    With  mVenc8
	REPLACE Venc9    With  mVenc9
	REPLACE Venc10   With  mVenc10
	REPLACE Venc11   With  mVenc11
	REPLACE Venc12   With  mVenc12
	REPLACE Serie    With  mSerie //20110923
	REPLACE Doc   	 With  mDoc //20110923
	MsUnlock()
endif

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
Static Function FARQTRAB()
_aCampos := {}
AADD(_aCampos,{"PEDIDO","C",6,0})
AADD(_aCampos,{"ITEM","C",2,0})
AADD(_aCampos,{"CF","C",5,0})
AADD(_aCampos,{"CODCLI","C",6,0})
AADD(_aCampos,{"CODDEST","C",6,0})
AADD(_aCampos,{"PRODUTO" ,"C",15,0})
AADD(_aCampos,{"TITULO","C",40,0})
AADD(_aCampos,{"REVISTA","C",40,0})
AADD(_aCampos,{"DESCR","C",40,0})
AADD(_aCampos,{"DESCR2","C",40,0})
AADD(_aCampos,{"DTPED ","D",8,0})
AADD(_aCampos,{"DTFAT ","D",8,0})
AADD(_aCampos,{"QTDE","N",10,0})
AADD(_aCampos,{"VLITEM","N",12,2})
AADD(_aCampos,{"DESPREM","N",12,2})
AADD(_aCampos,{"VLPEDIDO","N",12,2})
AADD(_aCampos,{"VLFATURA","N",12,2})
AADD(_aCampos,{"VLPENDEN","N",12,2})
AADD(_aCampos,{"VLPAGO","N",12,2})
AADD(_aCampos,{"DESCONTO","N",12,2})
AADD(_aCampos,{"VLAVENCER","N",12,2})
AADD(_aCampos,{"VLVENCIDO","N",12,2})
AADD(_aCampos,{"VLINADIM","N",12,2})
AADD(_aCampos,{"VLCANC","N",12,2})
AADD(_aCampos,{"AVCANC","N",12,2})
AADD(_aCampos,{"VLLP","N",12,2})
AADD(_aCampos,{"PGTO","N",5,2})
AADD(_aCampos,{"AVENCER","N",5,2})
AADD(_aCampos,{"VENCIDO","N",5,2})
AADD(_aCampos,{"LP","N",5,2})
AADD(_aCampos,{"INADIMPL","N",5,2})
AADD(_aCampos,{"CANC","N",5,2})
AADD(_aCampos,{"PARCELA","N",5,0})
AADD(_aCampos,{"VEND","C",6,0})
AADD(_aCampos,{"REGIAO","C",3,0})
AADD(_aCampos,{"EQUIPE","C",15,0})
AADD(_aCampos,{"NOMEVEND","C",40,0})
AADD(_aCampos,{"DIVVEND","C",40,0})
AADD(_aCampos,{"CODPROM","C",15,0})
AADD(_aCampos,{"IDENTIF","C",8,0})
AADD(_aCampos,{"NOME","C",40,0})
AADD(_aCampos,{"MUN ","C",30,0})
AADD(_aCampos,{"UF","C",2,0})
AADD(_aCampos,{"ATIVIDA","C",40,0})
AADD(_aCampos,{"TIPOOP","C",2,0})
AADD(_aCampos,{"DESCROP","C",50,0})
AADD(_aCampos,{"TPTRANS","C",60,0})
AADD(_aCampos,{"CODTIT","C",3,0})
AADD(_aCampos,{"EDICAO","N",4,0})
AADD(_aCampos,{"DTCIRC","D",08,0})
AADD(_aCampos,{"PARC1","N",12,2})
AADD(_aCampos,{"PARC2","N",12,2})
AADD(_aCampos,{"PARC3","N",12,2})
AADD(_aCampos,{"PARC4","N",12,2})
AADD(_aCampos,{"PARC5","N",12,2})
AADD(_aCampos,{"PARC6","N",12,2})
AADD(_aCampos,{"PARC7","N",12,2})
AADD(_aCampos,{"PARC8","N",12,2})
AADD(_aCampos,{"PARC9","N",12,2})
AADD(_aCampos,{"PARC10","N",12,2})
AADD(_aCampos,{"PARC11","N",12,2})
AADD(_aCampos,{"PARC12","N",12,2})
AADD(_aCampos,{"VENC1","D",08,0})
AADD(_aCampos,{"VENC2","D",08,0})
AADD(_aCampos,{"VENC3","D",08,0})
AADD(_aCampos,{"VENC4","D",08,0})
AADD(_aCampos,{"VENC5","D",08,0})
AADD(_aCampos,{"VENC6","D",08,0})
AADD(_aCampos,{"VENC7","D",08,0})
AADD(_aCampos,{"VENC8","D",08,0})
AADD(_aCampos,{"VENC9","D",08,0})
AADD(_aCampos,{"VENC10","D",08,0})
AADD(_aCampos,{"VENC11","D",08,0})
AADD(_aCampos,{"VENC12","D",08,0})
AADD(_aCampos,{"SERIE","C",3,0}) //20110923
AADD(_aCampos,{"DOC","C",9,0}) //20110923


_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "Pedido+Item"
dbUseArea(.T.,, _cNome,"cArq",.F.,.F.)
dbSelectArea("cArq")
Indregua("cArq",cIndex,ckey,,,"Selecionando Registros do Arq")
Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ RELATORIO()                                                   ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Gera resultado das vendas em listagem                         ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function RELATORIO()
Li:=0
Cabec(_cTitulo,Cabec1,Cabec2,Programa,Tamanho,nCaracter)
@Li-1,000 PSAY CABEC3
@Li,000 PSAY Replicate('*',132)
Li:=Li+2
dbSelectArea("cArq")
dbGoTop()
mValort:=0
mQtdet :=0
mPgtot :=0
mEmabertot:=0
mInadimplt:=0
mCanct:=0
mVencidot:=0
While !Eof()
	If Li >= 60
		Li:=0
		Cabec(_cTitulo,Cabec1,Cabec2,Programa,Tamanho,nCaracter)
	Endif
	mTitulo:=TITULO
	mQtde:=0
	mValor:=0
	mPgto :=0
	mEmaberto:=0
	mInadimpl:=0
	mCanc    :=0
	mVencido :=0
	While TITULO==mTitulo
		mQtde    :=mQtde+QTDE
		mValor   :=mValor+VlPedido
		mPgto    :=mPgto+(VlPedido*PGTO)
		mEmaberto:=mEmaberto+(VlPedido*AVENCER)
		mInadimpl:=mInadimpl+(VlPedido*INADIMPL)
		mCanc    :=mCanc+(VlPedido*CANC)
		mVencido :=mVencido+(VlPedido*VENCIDO)
		dbSkip()
	End
	@ Li,001 PSAY mTitulo
	@ Li,033 PSAY Transform(mQtde,"@E 9,999,999,999")
	@ Li,044 PSAY Transform(mValor,"@E 9,999,999,999.99")
	@ Li,068 PSAY Transform((mPgto/mValor)*100,"@E 999.99")
	@ Li,077 PSAY Transform((mEmaberto/mValor)*100,"@E 999.99")
	@ Li,090 PSAY Transform((mVencido/mvalor)*100,"@E 999.99")
	@ Li,102 PSAY Transform((mCanc/mvalor)*100,"@E 999.99")
	@ Li,116 PSAY Transform((mInadimpl/mvalor)*100,"@E 999.99")
	Li := Li + 1
	mValort:=mValort+mValor
	mQtdet :=mQtdet+mqtde
	mPgtot  :=mPgtot+mPgto
	mEmabertot:=mEmabertot+mEmaberto
	mInadimplt:=mInadimplt+mInadimpl
	mCanct:=mCanct+mCanc
	mVencidot:=mVencidot+mVencido
	If Eof()
		@ Li+2,001 PSAY 'SUBTOTAL..............:'
		@ Li+2,033 PSAY Transform(mQtdet,"@E 9,999,999,999")
		@ Li+2,044 PSAY Transform(mValort,"@E 9,999,999,999.99")
		@ Li+2,068 PSAY Transform((mPgtot/mValort)*100,"@E 999.99")
		@ Li+2,077 PSAY Transform((mEmabertot/mValort)*100,"@E 999.99")
		@ Li+2,090 PSAY Transform((mVencidot/mValort)*100,"@E 999.99")
		@ Li+2,106 PSAY Transform((mCanct/mValort)*100,"@E 999.99")
		@ Li+2,116 PSAY Transform((mInadimplt/mValort)*100,"@E 999.99")
		@ Li+4,001 PSAY 'ITENS NÇO FATURADOS...:'
		@ Li+4,033 PSAY Transform(mQtNFat,"@E 9,999,999,999")
		@ Li+4,044 PSAY Transform(mVlNFat,"@E 9,999,999,999.99")
		@ Li+4,068 PSAY Transform(00000,"@E 999.99")
		@ Li+4,077 PSAY Transform(00000,"@E 999.99")
		@ Li+4,090 PSAY Transform(00000,"@E 999.99")
		@ Li+6,001 PSAY 'TOTAL.................:'
		@ Li+6,033 PSAY Transform(mQtdet+mQtNFat,"@E 9,999,999,999")
		@ Li+6,044 PSAY Transform(mValort+mVlNFat,"@E 9,999,999,999.99")
		@ Li+6,068 PSAY Transform((mPgtot/mValort)*100,"@E 999.99")
		@ Li+6,077 PSAY Transform((mEmabertot/mValort)*100,"@E 999.99")
		@ Li+6,090 PSAY Transform((mVencidot/mValort)*100,"@E 999.99")
		@ Li+6,102 PSAY Transform((mCanct/mValort)*100,"@E 999.99")
		@ Li+6,116 PSAY Transform((mInadimplt/mValort)*100,"@E 999.99")
	EndIf
End
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
aRegs:={}
// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3
AADD(aRegs,{cPerg,"01","Do Produdo.........:","mv_ch1","C",15,0,0,"G","","mv_par01","","0108001","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"02","At‚ o Produto......:","mv_ch2","C",15,0,0,"G","","mv_par02","","0108003","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"03","Faturados de.......:","mv_ch3","D",08,0,0,"G","","mv_par03","","'01/06/99'","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Faturados.at‚......:","mv_ch4","D",08,0,0,"G","","mv_par04","","'17/04/00'","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Do vendedor........:","mv_ch5","C",06,0,0,"G","","mv_par05","","000000","","","","","","","","","","","","","SA3"})
AADD(aRegs,{cPerg,"06","At‚ vendedor.......:","mv_ch6","C",06,0,0,"G","","mv_par06","","999999","","","","","","","","","","","","","SA3"})
AADD(aRegs,{cPerg,"07","Tipo do Pedido.....:","mv_ch7","C",01,0,3,"C","","mv_par07","Pagos","","","Cortesias","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"08","Da Regiao..........:","mv_ch8","C",03,0,0,"G","","mv_par08","","000","","","","","","","","","","","","","ZZ9"})
AADD(aRegs,{cPerg,"09","At‚ Regiao.........:","mv_ch9","C",03,0,0,"G","","mv_par09","","999","","","","","","","","","","","","","ZZ9"})
AADD(aRegs,{cPerg,"10","Tipo de saida......:","mv_chA","C",01,0,0,"C","","mv_par10","Arquivo","","","Relatorio","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"11","Da Promo‡Æo........:","mv_chB","C",03,0,0,"G","","mv_par11","","   ","","","","","","","","","","","","","SZA"})
AADD(aRegs,{cPerg,"12","At‚ Promo‡Æo.......:","mv_chC","C",03,0,0,"G","","mv_par12","","ZZZ","","","","","","","","","","","","","SZA"})
AADD(aRegs,{cPerg,"13","Divisao de Vendas..:","mv_chD","C",01,0,4,"C","","mv_par13","Mercantil","","","Publicidade","","","Software","","","Todos","",""})
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