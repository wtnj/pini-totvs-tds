#include "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT146   ³Autor: Raquel Ramalho         ³ Data:   13/12/01 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera arquivo DBF dos Recebimentos                          ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function PFINJ01()

Private PROGRAMA  ,MHORA     ,CARQ       ,CSTRING   ,WNREL      ,NLASTKEY
Private L,NORDEM  ,M_PAG     ,NCARACTER  ,TAMANHO   ,CCABEC1
Private CCABEC2   ,LCONTINUA ,CARQPATH   ,_CSTRING  ,MEMPRESA   ,CPERG
Private MCONTA1   ,MCONTA2   ,MCONTA3    ,LEND      ,BBLOCO     ,CMSG
Private CCHAVE    ,CFILTRO   ,CIND       ,MCONTA    ,MPEDIDO    ,MITEM
Private MCODCLI   ,MCODDEST  ,MPRODUTO   ,MCF       ,MDTFAT     ,MVEND
Private MTITULO   ,MGRUPO    ,MDESCR     ,MNOME     ,MDESCROP   ,MDIVVEND
Private MREVISTA  ,MGRAT     ,MPORTADO   ,MTIPO     ,MATIVIDADE ,MTIPOOP
Private MQTDEFAT  ,MQTDE     ,MVLTOT     ,MIT       ,MITAV      ,MPAGO
Private MPGTO     ,MPARC     ,MCANC      ,MABERTO   ,MINADIMPL  ,MVENCIDO
Private MPARCAV   ,MVALFAT   ,MVALTOT    ,MLP       ,MDESCONTO  ,MNOTA
Private MSERIE    ,MPARCELA  ,MBAIXA     ,MVENCTO   ,MCODPROM   ,MIDENTIF
Private MCONDPGTO ,MDESPREM  ,MVALORPED  ,MDTPED    ,MDIVVEN    ,MCLIENTE
Private MEQUIPE   ,MREGIAO   ,MVALOR     ,MPAGOIT   ,MVENCIDIT  ,MCANCIT
Private MLPIT     ,MINADIMIT ,MDESCONTIT ,MABERTOIT ,MUF        ,MMUN
Private _ACAMPOS  ,_CNOME    ,CINDEX     ,CKEY      ,_SALIAS    ,AREGS
Private I         ,J

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                               ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ mv_par01 Vencimento de:                                            ³
//³ mv_par02 Vencimento at‚:                                           ³
//³ mv_par03 Baixado   Em Aberto    Ambos                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Programa  := "PFAT146"
MHORA     := TIME()
cArq      := "JBF"+SUBS(DTOS(dDataBase),7,2)+SM0->M0_CODIGO //SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString   := "JBF"+SUBS(DTOS(dDataBase),7,2)+SM0->M0_CODIGO //SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
lContinua := .T.
cArqPath  := GetMv("MV_PATHTMP")
_cString  := cArqPath+cString+".DBF"
mEmpresa  := SM0->M0_CODIGO
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso nao exista, cria grupo de perguntas.                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:="PFT146"

//Pergunte(cPerg,.f.)

mv_par01 := CTOD("01/01/02")  // acertar os parametros desta data futuramente
mv_par02 := CTOD("31/12/06")
mv_par03 := 3

mConta1 := 0
mConta2 := 0
mConta3 := 0

FArqTrab()

Filtra()

lEnd:= .F.

PRODUTOS()

DbSelectArea(cArq)

dbGoTop()

COPY TO &_cString VIA "DBFCDXADS" // 20121106 

DbSelectArea("TRB")
DbCloseArea()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorna indices originais...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea(cArq)
DbCloseArea()

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ Filtra()                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Filtra arquivo SE1 para ser utilizado no programa.            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function FILTRA()

Local cQuerySE1 := ""

cQuerySE1 += "SELECT * FROM " + RetSqlName("SE1") + " SE1"
cQuerySE1 += " WHERE SE1.E1_FILIAL = '" + xFilial("SE1") + "'"
cQuerySE1 += " AND SE1.E1_VENCTO BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "'"
cQuerySE1 += " AND SE1.D_E_L_E_T_ <> '*' "
cQuerySE1 += " ORDER BY SE1.E1_FILIAL, SE1.E1_VENCTO"

lEnd := .f.

If Select("TRB") <> 0
	DbselectArea("TRB")
	DbCloseArea()
EndIf	

DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuerySE1), "TRB", .T., .F. )

TcSetField("TRB","E1_VENCTO"  ,"D")
TcSetField("TRB","E1_BAIXA"   ,"D")
TcSetField("TRB","E1_EMISSAO" ,"D")
TcSetField("TRB","E1_DTALT"   ,"D")

Dbgotop()

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ PRODUTOS()                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function PRODUTOS()

mConta := 0

DbSelectArea("TRB")

DbGoTop()
While !EOF() .and. TRB->E1_FILIAL == xFilial("SE1") .AND. DTOS(TRB->E1_VENCTO) <= DTOS(MV_PAR02) .and. !lEnd
	mPedido    := ""
	mItem      := ""
	mCodCli    := ""
	mCodDest   := ""
	mProduto   := ""
	mCF        := ""
	mDTFat     := stod("")
	mVend      := ""
	mTitulo    := ""
	mGrupo     := "0000000"
	mDescr     := ""
	mNome      := ""
	mDescrop   := ""
	mDivVend   := ""
	mRevista   := ""
	mGrat      := ""
	mPortado   := ""
	mTipo      := ""
	mAtividade := ""
	mTipoop    := ""
	mQtdeFat   := 0
	mQtde      := 0
	mVltot     := 0
	mIt        := 0
	mItAv      := 0
	mPago      := 0
	mPgto      := 0
	mParc      := 0
	mcanc      := 0
	mAberto    := 0
	mInadimpl  := 0
	mVencido   := 0
	mParcAV    := 0
	mValfat    := 0
	mValtot    := 0
	mLp        := 0
	mDesconto  := 0
	mPedido    := TRB->E1_PEDIDO
	mNota      := TRB->E1_NUM
	mSerie     := TRB->E1_SERIE
	mDTFat     := TRB->E1_EMISSAO
	mParcela   := TRB->E1_PARCELA
	mBaixa     := TRB->E1_BAIXA
	mVencto    := TRB->E1_VENCTO
	mPortado   := TRB->E1_PORTADO
	mNatureza  := TRB->E1_NATUREZ
	mDtAlt     := TRB->E1_DTALT
	mValor     := TRB->E1_VALOR
	mNomeVend  := ""
	
	If MV_PAR03 == 1 .and. DTOS(TRB->E1_BAIXA) == "        "
		DbSelectArea("TRB")
		DbSkip()
		Loop
	Endif
	
	If MV_PAR03 == 2 .and. DTOS(TRB->E1_BAIXA) <> "        "
		DbSelectArea("TRB")
		DbSkip()
		Loop
	Endif
	
	DbSelectArea(cArq)
	If DbSeek(TRB->E1_PEDIDO + TRB->E1_NUM + TRB->E1_PARCELA)
		DbSelectArea("TRB")
		DbSkip()
		Loop
	Endif
	
	DbSelectArea("SC5")
	DbSetOrder(1)
	If DbSeek(xFilial("SC5")+mPedido)
		mCodProm  := SC5->C5_CODPROM
		mIdentif  := SC5->C5_IDENTIF
		mTipoop   := SC5->C5_TIPOOP
		mVend     := SC5->C5_VEND1
		mCodcli   := SC5->C5_CLIENTE
		mCondPgto := SC5->C5_CONDPAG
		mDesprem  := SC5->C5_DESPREM
		mValorPed := SC5->C5_VLRPED
		mDtPed    := SC5->C5_DATA
		mDivVend  := SC5->C5_DIVVEN
	Endif
	
	If mDivVend <> 'PUBL'
		DbSelectArea(cArq)
		If DbSeek(TRB->E1_PEDIDO)
			While !Eof() .and. Pedido == mPedido
				If SERIE <> 'UNI' .and. mSerie == 'UNI'
					While !Eof() .and. PEDIDO+PARCELA == mPedido+mParcela
						RecLock(cArq,.f.)
						Dbdelete()
						MsUnlock()
						DbSelectArea(cArq)
						DbSkip()
					End
				Endif
				DbSelectArea(cArq)
				DbSkip()
			End
		Endif
	Endif
	
	DbSelectArea("SF2")
	DbSetOrder(1)
	If DbSeek(xFilial("SF2")+mNota+mSerie)
		If Found()
			mValfat  := SF2->F2_VALFAT
			mCliente := SF2->F2_CLIENTE
		Endif
		
		DbSelectArea("SA3")
		DbSetOrder(1)
		If DbSeek(xFilial("SA3")+mVend)
			mEquipe  := SA3->A3_EQUIPE
			mRegiao  := SA3->A3_REGIAO
			mDivVend := SA3->A3_DIVVEND
			mNomeVend:= SA3->A3_NREDUZ
		EndIf
		
		DbSelectArea("SZ9")
		DbSetOrder(1)
		If DbSeek(xFilial("SZ9")+mTipoop) //,.T.)
			mDescrop := SZ9->Z9_DESCR
		Endif
		
		IF SC5->C5_DIVVEN == 'PUBL'
			DbSelectArea("SE4")
			DbSetOrder(1)
			If DbSeek(xFilial("SE4")+mCondpgto)
				mDescrop := SE4->E4_DESCRI
			Endif
		Endif
		
		DbSelectArea("TRB")
		If DTOS(TRB->E1_BAIXA) <> "        " .And. TRB->E1_SALDO==0 .AND. !'LP'$(TRB->E1_MOTIVO);
			.AND. !'CAN'$(TRB->E1_MOTIVO) .AND. !'DEV'$(TRB->E1_MOTIVO) .AND. !'920'$(TRB->E1_PORTADO)
			mPago     := TRB->E1_VALOR
			mDesconto := TRB->E1_DESCONT
		Else
			Do Case
				Case DTOS(TRB->E1_VENCTO) < DTOS(DDATABASE-30) .AND. !'CAN'$(TRB->E1_MOTIVO) .AND. !'920'$(TRB->E1_PORTADO)
					mInadimpl := TRB->E1_VALOR
				Case DTOS(TRB->E1_VENCTO) < DTOS(DDATABASE) .AND. !'CAN'$(TRB->E1_MOTIVO) .AND. !'920'$(TRB->E1_PORTADO)
					mVencido  := TRB->E1_VALOR
				Case 'LP'$(TRB->E1_MOTIVO)
					mLp       := TRB->E1_VALOR
				Case 'CAN'$(TRB->E1_MOTIVO) .OR. '920'$(TRB->E1_PORTADO)
					mCanc     := TRB->E1_VALOR
				OtherWise
					mAberto   := TRB->E1_VALOR
			EndCase
		Endif
		
		DbSelectArea("SD2")
		DbSetOrder(8)
		If DbSeek(xFilial("SD2")+mPedido)
			While !Eof() .and. xFilial("SD2") == SD2->D2_FILIAL .and. SD2->D2_PEDIDO == mPedido
				DbSelectArea(cArq)
				If DbSeek(TRB->E1_PEDIDO+TRB->E1_NUM+TRB->E1_PARCELA)
					mValor  := 0
					If mParcela == 'A' .OR. mParcela == ' '
						mValtot  := SD2->D2_TOTAL
						mValFat  := SF2->F2_VALFAT
					Else
						mValtot  := SD2->D2_TOTAL
						mValFat  := SF2->F2_VALFAT-SC5->C5_DESPREM
					Endif
				Else
					mValor  := TRB->E1_VALOR
					If mParcela == 'A' .OR. mParcela == ' '
						mValtot  := SD2->D2_TOTAL+SC5->C5_DESPREM
						mValFat  := SF2->F2_VALFAT
					Else
						mValtot  := SD2->D2_TOTAL
						mValFat  := SF2->F2_VALFAT-SC5->C5_DESPREM
					Endif
				Endif
				IF Alltrim(SD2->D2_SERIE) == Alltrim(mSerie) .AND. Alltrim(SD2->D2_DOC) == Alltrim(mNota)
					mProduto   := SD2->D2_COD
					mPagoIt    := (mValtot)*(mPago/mValFat)
					mVencidit  := (mValtot)*(mVencido/mValFat)
					mCancIt    := (mValtot)*(mCanc/mValFat)
					mLpIt      := (mValtot)*(mLp/mValFat)
					mInadimIt  := (mValtot)*(mInadimpl/mValFat)
					mDescontIt := (mValtot)*(mDesconto/mValFat)
					mAbertoIt  := (mValtot)*(mAberto/mValFat)
					GRAVA()
					DbSelectArea("TRB")
				Endif
				DbSelectArea("SD2")
				Dbskip()
			End
		Endif
	EndIf
	DbSelectArea("TRB")
	DbSkip()
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

mDescr     := ""
mGrupo     := ""
mRevista   := ""
mTitulo    := ""
mNome      := ""
mUF        := ""
mMun       := ""
mTipo      := ""
mAtividade := ""
mDescPort  := ""
mTel       := ""
mEnder     := "'

DbSelectArea("SA6")
DbSetOrder(1)
If DbSeek(xFilial("SA6")+mPortado)
	mDescPort := SA6->A6_NOME
EndIf

DbSelectArea("SB1")
DbSetOrder(1)
If DbSeek(xFilial("SB1")+mProduto)
	mGrupo   := AllTrim((SB1->B1_GRUPO))
	mDescr   := SB1->B1_DESC
Endif

DbSelectArea("SB1")
DbSetOrder(1)
If DbSeek(xFilial("SB1")+subs(mProduto,1,4)+'000')
	mRevista := SB1->B1_DESC
Endif

/*
DbSelectArea("SX5")
If DbSeek(xFilial("SX5")+'03'+mGrupo+'  ')
	mTitulo := SX5->X5_DESCRI
Endif
*/

DbSelectArea("SBM")
If DbSeek(xFilial("SBM")+mGrupo)
 	mTitulo := SBM->BM_DESC
Endif

If subs(mProduto,1,2)=='03'
	mDescr := mRevista
Endif

DbSelectArea("SA1")
DbSetOrder(1)
If DbSeek(xFilial("SA1")+mCodcli)
	mNome      := SA1->A1_NOME
	mUF        := SA1->A1_EST
	mMun       := SA1->A1_MUN
	mTipo      := SA1->A1_TIPO
	mAtividade := SA1->A1_ATIVIDA
    mEnder     := SA1->A1_END
    mTel       := SA1->A1_TEL
Endif

DbSelectArea("ZZ8")
DbSetOrder(1)
If DbSeek(xFilial("ZZ8")+mAtividade)
	mAtividade := ZZ8->ZZ8_DESCR
Endif

mDescNat := ""

DbSelectArea("SED")
DbSetOrder(1)
If DbSeek(xFilial("SED")+TRB->E1_NATUREZ)
	mDescNat := SED->ED_DESCRIC
EndIf

mConta1 := mConta1++

DbSelectArea(cArq)
RecLock(cArq,.T.)
Replace Pedido    With  mPedido
Replace Tipoop    With  mTipoop
Replace Descrop   With  mDescrop
Replace Serie     With  mSerie
Replace DtFat     With  mDtFat
Replace Baixa     With  mBaixa
Replace Natureza  With  mNatureza
Replace DescNat   With  mDescNat
Replace DtAlt     With  mDtAlt
Replace Vencto    With  mVencto
Replace Dupl      With  mNota
Replace Parcela   With  mParcela
Replace VlDupl    With  mValor
Replace Pago      With  mPagoIt
Replace Desconto  With  mDescontIt
Replace AVencer   With  mAbertoIt
Replace Vencido   with  mVencidIt+mInadimIt
Replace Inadimpl  with  mInadimIt
Replace Cancelado With  mCancIt
Replace Lp        With  mLpiT
Replace Portado   With  mPortado
Replace NomPort   With  mDescPort
Replace CodProm   With  mCodProm
Replace CodCli    With  mCodCli
Replace CodDest   With  mCodDest
Replace Nome      With  mNome
Replace UF        With  mUF
Replace Mun       With  mMun
Replace Ativida   With  mAtividade
Replace Vend      With  mVend
Replace Regiao    With  mRegiao
Replace Equipe    With  mEquipe
Replace DivVend   With  mDivVend
Replace Produto   With  mProduto
Replace Descr     With  mDescr
Replace Titulo    With  mTitulo
Replace Tipo      With  mTipo
Replace NomeVend  With  mNomeVend
Replace CliEnder  With  mEnder
Replace Telefone  With  mTel
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
Static Function FARQTRAB()

_aCampos := {}

AADD(_aCampos,{"PEDIDO"    ,"C",6  ,0})
AADD(_aCampos,{"TIPOOP"    ,"C",2  ,0})
AADD(_aCampos,{"DESCROP"   ,"C",50 ,0})
AADD(_aCampos,{"SERIE"     ,"C",3  ,0})
AADD(_aCampos,{"DTFAT "    ,"D",8  ,0})
AADD(_aCampos,{"BAIXA"     ,"D",8  ,0})
AADD(_aCampos,{"DTALT"     ,"D",8  ,0})
AADD(_aCampos,{"VENCTO "   ,"D",8  ,0})
AADD(_aCampos,{"NATUREZA"  ,"C",10 ,0})
AADD(_aCampos,{"DESCNAT"   ,"C",30 ,0})
AADD(_aCampos,{"DUPL"      ,"C",6  ,0})
AADD(_aCampos,{"PARCELA"   ,"C",1  ,0})
AADD(_aCampos,{"VLDUPL"    ,"N",12 ,2})
AADD(_aCampos,{"PAGO"      ,"N",12 ,2})
AADD(_aCampos,{"DESCONTO"  ,"N",12 ,2})
AADD(_aCampos,{"AVENCER"   ,"N",12 ,2})
AADD(_aCampos,{"VENCIDO"   ,"N",12 ,2})
AADD(_aCampos,{"CANCELADO" ,"N",12 ,2})
AADD(_aCampos,{"LP"        ,"N",12 ,2})
AADD(_aCampos,{"PORTADO"   ,"C",3  ,0})
AADD(_aCampos,{"NOMPORT"   ,"C",40 ,0})
AADD(_aCampos,{"CODPROM"   ,"C",15 ,0})
AADD(_aCampos,{"CODCLI"    ,"C",6  ,0})
AADD(_aCampos,{"CODDEST"   ,"C",6  ,0})
AADD(_aCampos,{"TIPO"      ,"C",1  ,0})
AADD(_aCampos,{"NOME"      ,"C",40 ,0})
AADD(_aCampos,{"TELEFONE"  ,"C",20 ,2})
AADD(_aCampos,{"CLIENDER"  ,"C",40 ,2})
AADD(_aCampos,{"MUN "      ,"C",30 ,0})
AADD(_aCampos,{"UF"        ,"C",2  ,0})
AADD(_aCampos,{"ATIVIDA"   ,"C",40 ,0})
AADD(_aCampos,{"VEND"      ,"C",6  ,0})
AADD(_aCampos,{"NOMEVEND"  ,"C",15 ,0})
AADD(_aCampos,{"REGIAO"    ,"C",3  ,0})
AADD(_aCampos,{"EQUIPE"    ,"C",15 ,0})
AADD(_aCampos,{"DIVVEND"   ,"C",40 ,0})
AADD(_aCampos,{"PRODUTO"   ,"C",40 ,0})
AADD(_aCampos,{"DESCR"     ,"C",40 ,0})
AADD(_aCampos,{"TITULO"    ,"C",40 ,0})
AADD(_aCampos,{"INADIMPL"  ,"N",12 ,2})
AADD(_aCampos,{"FLUXO"     ,"N",12 ,2})

_cNome := CriaTrab(_aCampos,.t.)

cIndex := CriaTrab(Nil,.F.)
cKey   := "Pedido+Dupl+Parcela"
dbUseArea(.T.,, _cNome,cArq,.F.,.F.)
dbSelectArea(cArq)

Indregua(cArq,cIndex,ckey)

Return