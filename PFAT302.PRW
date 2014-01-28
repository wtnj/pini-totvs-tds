#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT302   ³Autor: Raquel Ramalho         ³ Data:   05/02/01 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera arquivo DBF das vendas                                ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
// Alterado para uso de geracao de banco de dados unico por Marcos Farineli
User Function Pfat302()

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
Programa  :="PFAT126"
MHORA     :=TIME()
cArq      :=SUBS(CUSUARIO,1,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString   :=SUBS(CUSUARIO,1,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
nLastKey  := 00
nOrdem    := 00
lContinua := .T.
cArqPath  :=GetMv("MV_PATHTMP")
_cString  :=cArqPath+cString+".DBF"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso nao exista, cria grupo de perguntas.                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:="PFT126"

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

mSaida  := 1

mConta1 := 0
mConta2 := 0
mConta3 := 0

FArqTrab()

Filtra()

lEnd    := .F.
bBloco:= {|lEnd| PRODUTOS()}
Processa(bBloco, "Produtos" ,"Processando...", .T. )

While .T.
	If !Pergunte(cPerg)
		Exit
	Endif
	
	If LastKey()== 27
		Exit
	Endif
	
	Filtra()
	
	lEnd   := .F.
	bBloco := {|lEnd|PRODUTOS()}
	Processa( bBloco, "Produtos" ,"Processando...", .T. )
End

DbSelectArea("cArq")
dbGoTop()
cIndex := CriaTrab(Nil,.F.)
cKey   := "TITULO"
Indregua("cArq",cIndex,ckey,,,"Selecionando Registros do Arq")

cMsg := "Arquivo Gerado com Sucesso em: "+_cString
DbSelectArea("cArq")
dbGoTop()
COPY TO &_cString
MSGINFO(cMsg,"Arquivo Copiado")
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

Return(_cString)

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ Filtra()                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Filtra arquivo SC5 para ser utilizado no programa.            ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function FILTRA()

cQuerySC5 := "SELECT * FROM " + RetSqlName("SC5") + " WHERE C5_FILIAL = '" + xFilial("SC5") + "' "
cQuerySC5 += " AND C5_DATA BETWEEN '" + DTOS(MV_PAR03) + "' AND '" + DTOS(MV_PAR04) + "' "
cQuerySC5 += " AND C5_VEND1 BETWEEN '" + DTOS(MV_PAR05) + "' AND '" + DTOS(MV_PAR06) + "' "
cQuerySC5 += " AND C5_CODPROM BETWEEN '" + DTOS(MV_PAR11) + "' AND '" + DTOS(MV_PAR12) + "' "

Do Case
	Case MV_PAR13 == 1
		cQuerySC5 += " AND C5_DIVVEN = 'MERC'"
	Case MV_PAR13 == 2
		cQuerySC5 += " AND C5_DIVVEN = 'PUBL'"
	Case MV_PAR13 == 3
		cQuerySC5 += " AND C5_DIVVEN = 'SOFT'"
EndCase

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuerySC5), "TRB", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")

TcSetField("TRB","C5_DATA"  ,"D")
TcSetField("TRB","C5_EMISSAO" ,"D")

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ PRODUTOS()                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Realiza leitura dos registros do SC6 ja filtrado e aplica     ³
//³           ³ restante dos filtros de parametros. Prepara os dados para     ³
//³           ³ serem gravados. Faz chamada a funcao GRAVA.                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function PRODUTOS()

mConta   := 0
mQtNFat  := 0
mVlNFat  := 0
cVarParc := "mParc"
cVarVenc := "mVenc"

DbSelectArea("TRB")
DbGoTop()
cPedAnt := "ZZZZZZ"
While !EOF()
	mPedido   := ""
	mItem     := ""
	mCodCli   := ""
	mCodDest  := ""
	mProduto  := ""
	mCF       := ""
	mDTFat    := ctod("  /  /  ")
	mDTPed    := ctod("  /  /  ")
	mFilial   := ""
	mVend     := ""
	mTitulo   := ""
	mGrupo    := ""
	mDescr    := ""
	mDescr2   := ""
	mNomeVend := ""
	mQtde     := 0
	mGrat     := ""
	mNome     := ""
	mDescrop  := ""
	mDivVend  := ""
	mRevista  := ""
	mCodTit   := ""
	mAtividade:= ""
	mDTPG     := ctod("  /  /  ")
	mPago     := 0
	mPgto     := 0
	mParc     := 0
	mcanc     := 0
	mLP       := 0
	mVenc     := 0
	mAberto   := 0
	mInadimpl := 0
	mVlPago   := 0 
	mVlAberto := 0
	mVlInadim := 0
	mVlcanc   := 0
	mVlVenc   := 0
	mVlPenden := 0
	mVlFatura := 0
	mIt       := 0
	mVlLP     := 0
	mParc1    := 0
	mParc2    := 0
	mParc3    := 0
	mParc4    := 0
	mParc5    := 0
	mParc6    := 0
	mParc7    := 0
	mParc8    := 0
	mParc9    := 0
	mParc10   := 0
	mParc11   := 0
	mParc12   := 0
	mVencido  := 0
	mValor    := 0
	mQtde     := 0
	mVenc     := 0
	mDesconto := 0
	mVenc1    := ctod("  /  /  ")
	mVenc2    := ctod("  /  /  ")
	mVenc3    := ctod("  /  /  ")
	mVenc4    := ctod("  /  /  ")
	mVenc5    := ctod("  /  /  ")
	mVenc6    := ctod("  /  /  ")
	mVenc7    := ctod("  /  /  ")
	mVenc8    := ctod("  /  /  ")
	mVenc9    := ctod("  /  /  ")
	mVenc10   := ctod("  /  /  ")
	mVenc11   := ctod("  /  /  ")
	mVenc12   := ctod("  /  /  ")
	mPedido   := TRB->C5_NUM
	mVend     := TRB->C5_VEND1
	mCodProm  := TRB->C5_CODPROM
	mIdentif  := TRB->C5_IDENTIF
	mTipoop   := TRB->C5_TIPOOP
	mDtPed    := TRB->C5_DATA
	mVlPedido := TRB->C5_VLRPED+SC5->C5_DESPREM
	mDespRem  := TRB->C5_DESPREM
	mCondPgto := TRB->C5_CONDPAG
	mTpTrans  := TRB->C5_TPTRANS
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Elimina pedidos de Publicidade                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ   
	
	DbSelectArea("SA3")
    DbSetOrder(1)
	If DbSeek(xFilial("SA3")+mVend)
		mEquipe   := SA3->A3_EQUIPE
		mRegiao   := SA3->A3_REGIAO
		mDivVend  := SA3->A3_DIVVEND
		mNomeVend := SA3->A3_NOME
	EndIf
	
	If Alltrim(mRegiao) < Alltrim(MV_PAR08) .OR. Alltrim(mRegiao) > Alltrim(MV_PAR09)
		DbSelectArea("TRB")
		DbSkip()
		Loop
	Endif
	
	DbSelectArea("SZ9")
	DbSetOrder(1)
	If DbSeek(xFilial("SZ9")+mTipoop)
		mDescrop := SZ9->Z9_DESCR
	Endif
	
	IF TRB->C5_DIVVEN == 'PUBL'
		DbSelectArea("SE4")
    	DbSetOrder(1)
		If DbSeek(xFilial("SE4")+mCondpgto)
			mDescrop := SE4->E4_DESCRI
		Endif
	Endif
	
	DbSelectArea("SZS")
	DbSetOrder(1)
	If DbSeek(xFilial("SZS")+mPedido+mItem)
		mVlPenden := 0
		mAvTotal  := 0
		mPercPen  := 1
		If SZS->ZS_FATPROG == 'S'
			DbSelectArea("SZV")
			DbSetOrder(1)
			DbSeek(xFilial("SZV")+mPedido, .T.)
			While !Eof() .and. SZV->ZV_FILIAL == xFilial("SZV") .and. mPedido == SZV->ZV_NUMAV
				If SZV->ZV_SITUAC=='AA'
					mAvtotal:=SZV->ZV_VALOR+mAvtotal
				Endif
				
				If SZV->ZV_SITUAC=='AA' .and. Empty(SZV->ZV_NFISCAL)
					mVlPenden += SZV->ZV_VALOR
				Endif
				DbSelectArea("SZV")
				DbSkip()
			End
			mPercPen := mVlpenden/mAvtotal
		Endif
	Endif
		
	DbSelectArea("SC6")
	DbSetOrder(1)
	If DbSeek(xFilial("SC6")+mPedido)
		ProcRegua(LastRec())
		While SC6->C6_NUM == mPedido
			mAvCanc  := 0
			mDtcirc  := ctod("  /  /  ")
			mEdicao  := 0
			
			IncProc("Lendo Registros : "+StrZero(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
			
			If (Alltrim(SC6->C6_PRODUTO) < Alltrim(MV_PAR01)) .or. (Alltrim(SC6->C6_PRODUTO) > Alltrim(MV_PAR02)) .OR. Alltrim(mCF)=='596'
				DbSelectArea("SC6")
				DbSkip()
				Loop
			EndIf
			
			If SM0->M0_CODIGO=='01'
				If Alltrim(SC6->C6_TES) $ "700/701/703"
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
			If DbSeek(SC6->C6_NUM+SC6->C6_ITEM)
				DbSelectArea("SC6")
				DbSkip()
				Loop
			EndIf
			
			DbSelectArea("SF4")
			DbSetOrder(1)
			DbSeek(xFilial("SF4")+SC6->C6_TES)
			If 'N' $ Alltrim(SF4->F4_DUPLIC) .OR. SC6->C6_PRCVEN == 1 .OR. SC6->C6_PRCVEN == 0
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se ‚ cortesia para parƒmetro=pago                   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If MV_PAR07 == 1
					DbSelectArea("SC6")
					DbSkip()
					Loop
				EndIf
			Else
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Verifica se ‚ pago para parƒmetro=cortesia                   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If MV_PAR07 == 2
					DbSelectArea("SC6")
					DbSkip()
					Loop
				EndIf
			EndIf
			
			mProduto := SC6->C6_PRODUTO
			mDTFat   := SC6->C6_DATFAT
			mCodCli  := SC6->C6_CLI
			mItem    := SC6->C6_ITEM
			mValor   := SC6->C6_VALOR
			mCF      := AllTrim(SC6->C6_CF)
			mCodDest := SC6->C6_CODDEST
			mFilial  := SC6->C6_FILIAL
			mQtde    := SC6->C6_QTDVEN
			mDtfat   := SC6->C6_DATFAT
			mEdicao  := SC6->C6_EDINIC
			mDtcirc  := SC6->C6_DTINIC
			
			If DTOS(SC6->C6_DATFAT) == "        " .AND. mGrat <> 'S'
				mQtNFat   += SC6->C6_QTDVEN
				mVlNFat   += SC6->C6_VALOR
				mVlPenden := mValor
			EndIf
			
			DbSelectArea("SZS")
			DbSetOrder(1)
			If DbSeek(xFilial("SZS")+mPedido+mItem)
				mEdicao   := SZS->ZS_EDICAO
				mDtcirc   := SZS->ZS_DTCIRC
				mAvcanc   := 0
				mCodTit   := SZS->ZS_CODTIT
				mVlPenden := 0
				While SZS->ZS_FILIAL == xFilial("SZS") .and. mPedido == SZS->ZS_NUMAV .and. mItem == SZS->ZS_ITEM
					If SZS->ZS_SITUAC == 'CC'
						mAvCanc += SZS->ZS_VALOR
					Endif
					If SZS->ZS_SITUAC == 'AA' .and. Empty(SZS->ZS_NFISCAL) .AND. SZS->ZS_FATPROG <> 'S'
						mVlPenden := SZS->ZS_VALOR+mVlPenden-mAvCanc
					Endif
					DbSelectArea("SZS")
					DbSkip()
				End
				DbSkip(-1)
				If SZS->ZS_FATPROG == 'S'
					mVlPenden := (mVaLor-mAvCanc)*mPercPen
				Endif
			Endif

			GRAVA()
            IncProc("Lendo Registros : "+StrZero(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
			DbSelectArea("SC6")
			DbSkip()
		End
		
		mChave1 := mPedido+'UNI'
		mChave2 := mPedido
		DbSelectArea("SD2")
		DbSetOrder(8)
		DbGoTop()
		If DbSeek(xFilial("SD2")+mChave1)
			mSerie := SD2->D2_SERIE
			mDoc   := SD2->D2_DOC
			mDtfat := SD2->D2_EMISSAO
		Else
			DbGoTop()
			If DbSeek(xFilial("SD2")+mChave2)
				mSerie := SD2->D2_SERIE
				mDoc   := SD2->D2_DOC
				mDtfat := SD2->D2_EMISSAO
			Endif
		Endif
		
		DbSelectArea("SE1")
		DbSetOrder(15)
		DbGoTop()
		DbSeek(xFilial("SE1")+mPedido)
		
		While ( SE1->E1_PEDIDO == mPedido)
			IF SE1->E1_SERIE <> mSerie
				DbSkip()
				loop
			Endif
			mDTPG := SE1->E1_BAIXA
			mParc++
			mit++
			
			If mit >= 1 .and. mit <= 12
				&(cVarParc+Alltrim(Str(mit))) := SE1->E1_VALOR
				&(cVarVenc+Alltrim(Str(mit))) := SE1->E1_VENCTO
			EndIf
			
			If DTOS(MDTPG) <> "        " .And. E1_SALDO == 0 .AND. !'LP'$(SE1->E1_MOTIVO) .AND. !'CAN'$(SE1->E1_MOTIVO);
			   .AND. !'DEV'$(SE1->E1_MOTIVO) .AND. !'920'$(SE1->E1_PORTADO)
				mPago++
				mVlPago   := mVlpago+SE1->E1_VALOR
				mDesconto := SE1->E1_DESCONT+mDesconto
			Else
				Do Case
					Case SE1->E1_VENCTO+30 < DATE().AND. !'CAN'$(SE1->E1_MOTIVO) .AND. !'LP'$(SE1->E1_MOTIVO) .And. !'920'$(SE1->E1_PORTADO)
						mInadimpl++
						mVlInadim := mVlInadim+SE1->E1_VALOR
					Case SE1->E1_VENCTO < DATE().AND.!'CAN'$(SE1->E1_MOTIVO) .AND. !'LP'$(SE1->E1_MOTIVO) .and. !'920'$(SE1->E1_PORTADO)
						mVlVenc  := mVlVenc+SE1->E1_VALOR
						mVenc++
					Case 'LP'$(SE1->E1_MOTIVO)
						mLP++
						mVlLP   := mVlLP+SE1->E1_VALOR
					Case 'CAN'$(SE1->E1_MOTIVO)	.OR. '920'$(SE1->E1_PORTADO)
						mCanc++
						mVlCanc := mVlCanc+SE1->E1_VALOR
					OtherWise
						mAberto++
						mVlAberto := mVlAberto+SE1->E1_VALOR
				EndCase
			Endif
			
			mVlFatura := mVlFatura+SE1->E1_VALOR

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
		ATDUPL()
	Else
		DbSelectArea("TRB")
		DbSkip()
		Loop
	EndIf
	
	DbSelectArea("TRB")
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
If DbSeek(xFilial("SB1")+mProduto)
	mGrupo  := AllTrim((SB1->B1_GRUPO))
	mDescr  := SB1->B1_DESC
	mDescr2 := SB1->B1_DESC
Endif

DbSelectArea("SB1")
DbSetOrder(1)
If DbSeek(xFilial("SB1")+subs(mProduto,1,4)+'000')
	mRevista:=SB1->B1_DESC
Endif

If subs(mProduto,1,2)=='03'
	mDescr := mRevista
Endif

DbSelectArea("SBM")
DbSetOrder(1)
If DbSeek(xFilial("SBM")+mGrupo)
	mTitulo := SBM->BM_DESC
Endif

DbSelectArea("SX5")
DbGoTop()
If DbSeek(xFilial("SX5")+'Z0'+mTpTrans+'  ')
	mTipoop  := mTpTrans
	mTpTrans := SX5->X5_DESCRI
Endif

DbSelectArea("SA1")
DbSetOrder(1)
If DbSeek(xFilial("SA1")+mCodcli)
	mNome      := SA1->A1_NOME
	mUF        := SA1->A1_EST
	mMun       := SA1->A1_MUN
	mAtividade := SA1->A1_ATIVIDA
Endif

DbSelectArea("ZZ8")
DbSetOrder(1)
If DbSeek(xFilial("ZZ8")+mAtividade)
	mAtividade := ZZ8->ZZ8_DESCR
Endif

mConta1++

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
	MsUnlock()
endif

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ FARQTRAB()                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Cria arquivo de trabalho para guardar registros que serao     ³
//³           ³ impressos em forma de etiquetas.                              ³
//³           ³ serem gravados. Faz chamada a funcao GRAVA.                   ³
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

_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "Pedido+Item"
dbUseArea(.T.,, _cNome,"cArq",.F.,.F.)
dbSelectArea("cArq")
Indregua("cArq",cIndex,ckey,,,"Selecionando Registros do Arq")
Return