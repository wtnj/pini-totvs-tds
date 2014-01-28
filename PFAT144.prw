#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
#include "tbiconn.ch"
/*/ 
Danilo C S Pala em 20130423: Programa remodelado para melhorar desempenho e incluir itens da Feicon2013
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT144   ³Autor: Raquel Ramalho/Danilo Pala³ Data:   26/11/01 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera arquivo DBF do Faturamento para auditoria             ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function Pfat144()

SetPrvt("CDESC1,CDESC2,CDESC3,CTITULO,_CTITULO,ARETURN,CONTADOR")
SetPrvt("PROGRAMA,MHORA,CARQ,CARQ1,CSTRING,CSTRING1,WNREL,NLASTKEY")
SetPrvt("L,NORDEM,M_PAG,NCARACTER,TAMANHO,CCABEC1,mCNPJ,mIRRF")
SetPrvt("CCABEC2,LCONTINUA,CARQPATH,_CSTRING,_CSTRING1,MEMPRESA,CPERG")
SetPrvt("MTIPO,CABEC1,CABEC2,CABEC3,MCONTA1,MCONTA2,MEND")
SetPrvt("MCONTA3,BBLOCO,MVLTOT,MPAGO,MPGTO,mCep,mBairro,mPais")
SetPrvt("MIT,MABERTO,MINADIMPL,MVENCIDO,MPARC,MCANC,_CSTRING2")
SetPrvt("MPARC1,MPARC2,MPARC3,MPARC4,MPARC5,MPARC6,MALIQISS")
SetPrvt("MPARC7,MPARC8,MPARC9,MPARC10,MPARC11,MPARC12")
SetPrvt("MAVABERTO,MAVFATURAD,MQTDEFAT,MAVTOTAL,MPARCFAT,MDESCONTO")
SetPrvt("MCODISS,MVALORICMS,MBASEICMS,MVENC1,MVENC2,MVENC3")
SetPrvt("MVENC4,MVENC5,MVENC6,MVENC7,MVENC8,MVENC9,T_PROD")
SetPrvt("MVENC10,MVENC11,MVENC12,MNOTA,MSERIE,MPEDIDO,MPEDIDO1")
SetPrvt("MVLPEDIDO,MDESPREM,MCHAVE,MPARCELA,MAVFATURADA,CMSG")
SetPrvt("CCHAVE,CFILTRO,CIND,MCONTA,MQTNFAT,MVLNFAT")
SetPrvt("MITEM,MCODCLI,MCODDEST,MPRODUTO,MREVISTA,MTIPOOP, MALMOX")
SetPrvt("MTPTRANS,MDESCROP,MCF,MTITULO,MDESCR,MREGIAO")
SetPrvt("MVEND,MEQUIPE,MCODPROM,MIDENTIF,MNOME,MUF")
SetPrvt("MMUN,MDIVVEND,MGRAT,MGRUPO,MDTRANS,MDUPLICADO")
SetPrvt("MCONDPGTO,MFATPROG,MNOMEVEND,MITAV,MPARCAV,MCOMIS")
SetPrvt("MVALOR,MEDICAO,MQTDE,MVLITEM,MNUMINS,MDTFAT")
SetPrvt("MRECO,MCLIENTE,MCONT,MPERITEM,MTOTALAV,MTOTALFAT")
SetPrvt("_AVCANC,_DUPL,_ITEM,_EDICAO,_PARCELA,_FATPROG")
SetPrvt("_PEDIDO,_PRODUTO,MVLBRUTO,_VLITEM,_DTCIRC,MVLLIQ")
SetPrvt("_ACAMPOS,_CNOME,CINDEX,CKEY,LI,MVALORT,MFONE,MINSCR")
SetPrvt("MQTDET,MPGTOT,MEMABERTOT,MINADIMPLT,MCANCT,MVENCIDOT")
SetPrvt("MEMABERTO,_SALIAS,AREGS,I,J,MCONTABIL,	mContaop,aOrd")
SetPrvt("_aCamposG, _cNomeG, _aCamposGI, _cNomeGI")
SetPrvt("cIndexG, cKeyG, mPRCVEN")
SetPrvt("contDoc, ContIgual, MNOMEARQ")
SetPrvt("mTipoLogr, mLogr, mNumLogr, mCompLogr")

//VARS PARA GOLD    
//dados do doc
SetPrvt("mTipoReg, mcodDeposit, mCodEmp, mCGCEmp")
SetPrvt("mNomeEmp, mEndEmp, mBairroEmp, mMunEmp")
SetPrvt("mUFEmp, mCepEmp, mInscrEmp, mTipoDoc")
SetPrvt("mNumDoc, mCodMatriz, mCodEstab, mNatOperac")
SetPrvt("mConhecimento, mDataEmissao, mValTotDoc")
SetPrvt("mValTotProd, mValIcms, mValIcmsSub, mValIpi")
SetPrvt("mValFrete, mBaseIcms, mBaseIcmsSub, mBaseIpi")
SetPrvt("mValorSeguro, mValorDesc, mValAcresc, mCodTrans, mValTolDoc")
//itens do doc
SetPrvt("mTipoReg, mCodEmp, mTipoDoc, mSerie, mNumDoc")
SetPrvt("mCodMatriz, mCodProd, mQtd, mTipoUc, mFatorTipoUC")
SetPrvt("mAliqICms, mAliqIpi, mValUnitario, mAliqIcmsSub")
SetPrvt("mTipoLogist, mDadoLogist, mnulo, mfdado")
//dados do produto
SetPrvt("mTipoReg ,mcodDeposit, mCodProd, mTipoProd, mModeloProd")
SetPrvt("mCodGrupo, mClasFiscal, mLargura, mComprimento, mAltura")
SetPrvt("mPesoLiqProd, mPesoBrutoProd, mAliqIcms, mAliqRedIcms")
SetPrvt("mAliqSegCusto, mAliqIpi, mAliqIcmsSub, mPrazoValid")
SetPrvt("mUnidadeCond, mFatorUC, _ARQE, mNumExt")


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ mv_par01 Do Produdo.........:                                           ³
//³ mv_par02 At‚ o Produto......:                                           ³
//³ mv_par03 Faturados de.......:                                           ³
//³ mv_par04 Faturados at‚......:                                           ³
//³ mv_par05 Do vendedor........:                                           ³
//³ mv_par06 At‚ vendedor.......:                                           ³
//³ mv_par07 Tipo do Pedido.....: Pagos, Cortesia, Todos, Outras Saidas     ³
//³ mv_par08 Da regiao..........:                                           ³
//³ mv_par09 At‚ regiao.........:                                           ³
//³ mv_par10 Tipo de saida......: Arquivo DBF, Arquivo Matrix, Arq. Transfolha,  Relat¢rio e Gold³
//³ mv_par11 Da Promo‡Æo........:                                           ³
//³ mv_par12 At‚ Promo‡Æo.......:                                           ³
//³ mv_par13 Divisao de Vendas..: Mercantil    Publicidade   Software  Todos³
//³ mv_par14 Tipo Faturamento...: Normal Edi‡Æo                             ³
//³ mv_par15 Circulacao de......:                                           ³
//³ mv_par16 Circulacao at‚.....:                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cDesc1     := PADC("Este programa ira gerar o resumo de vendas por grupo de produto" ,74)
cDesc2     := PADC("a partir do arquivo de pedidos",74)
cDesc3     := ""
aReturn    := { "Especial", 1,"Administra‡Æo", 1, 2, 1,"",1 }
MHORA      := TIME()
cArq       := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString    := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cArq1      := SUBS(CUSUARIO,7,3)+"R"+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
wnrel      := "Relatorio_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
nLastKey   := 00
L          := 00
nOrdem     := 00
m_pag      := 01
nCaracter  := 10
tamanho    := "P"
cCabec1    := ""
cCabec2    := ""
lContinua  := .T.
cArqPath   :=GetMv("MV_PATHTMP")
_cString   :=cArqPath+cString+".DBF"
_cString1 := cArqPath+"MATRIX"
_cString2 := cArqPath+"CADASTRO.DBF"
mEmpresa   := SM0->M0_CODIGO
mcodDeposit := "PINI"
ContIGual := 0
ContDoc := 0

cPerg:="PFT144"
_ValidPerg()
If !Pergunte(cPerg)
	Return
Endif

IF Lastkey() == 27
	Return
Endif

Processa({||PRODUTOS()} )

Return





//****************************************************************************
// Function   PRODUTOS()
//****************************************************************************
Static Function PRODUTOS()
Local cQuery := ""


If mv_par14 ==2
	MsgAlert("Foi desabilito o filtro por edição. Utilize a Query. Detalhes com a Cidinha")
	return
EndIf

mConta1   :=0
mConta2   :=0
mConta3   :=0

FArqTrab()

mConta :=0
mQtNFat:=0
mVlNFat:=0

cQuery := "SELECT D2_SERIE, D2_DOC, D2_EMISSAO, D2_CLIENTE, D2_LOJA, D2_PEDIDO, D2_ITEMPV, D2_COD, D2_LOCAL, D2_TES, D2_CF, D2_QUANT, D2_TOTAL, D2_COMIS1, D2_COMIS2, D2_COMIS3, D2_COMIS5"
cQuery += " , D2_CODISS, D2_VALICM, D2_BASEICM, D2_VALISS, D2_ALIQISS, D2_PRCVEN, F2_DESPREM, F2_ESPECIE, F2_PDV, F2_ECF, F2_VALFAT, F2_VALMERC, F2_VEND1, F2_VALFAT, A3_EQUIPE, A3_REGIAO, A3_DIVVEND, A3_NOME"
cQuery += " FROM "+ RetSqlName("SD2") +" SD2, "+ RetSqlName("SF2") + " SF2"
cQuery += " LEFT OUTER JOIN "+ RetSqlName("SA3") +" SA3 ON (A3_FILIAL='"+ xFilial("SA3") +"' AND F2_VEND1=A3_COD AND SA3.D_E_L_E_T_<>'*' )"
cQuery += " WHERE D2_FILIAL = '"+ xFilial("SD2") +"'"
cQuery += " AND F2_FILIAL='"+ xFilial("SF2") +"' AND D2_SERIE=F2_SERIE AND D2_DOC=F2_DOC AND D2_EMISSAO=F2_EMISSAO AND D2_CLIENTE=F2_CLIENTE AND D2_LOJA=F2_LOJA"
cQuery += " AND D2_EMISSAO >= '" + DTOS(MV_PAR03) + "' AND D2_EMISSAO <='" + DTOS(MV_PAR04) + "'"
cQuery += " AND D2_COD >= '" + MV_PAR01 + "' AND D2_COD <='" + MV_PAR02 + "'"
cQuery += " AND F2_VEND1 >= '"+ MV_PAR05 +"' AND F2_VEND1 <= '"+ MV_PAR06 +"'"
cQuery += " AND A3_REGIAO>='"+ MV_PAR08 +"' AND A3_REGIAO<='"+ MV_PAR09 +"'"
cQuery += " AND SD2.D_E_L_E_T_<>'*' AND SF2.D_E_L_E_T_<>'*'"
cQuery += " ORDER BY D2_SERIE, D2_DOC, D2_ITEM"

If Select("TRBF") <> 0
	DbselectArea("TRBF")
	DbCloseArea()
EndIf	

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRBF", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
TcSetField("TRBF","D2_EMISSAO"   ,"D")
Dbgotop()
ProcRegua(Reccount())

Do While !EOF()
	mPedido    := ""
	mItem      := ""
	mCodCli    := ""
	mCodDest   := ""
	mProduto   := ""
	MALMOX	    := ""
	mRevista   := ""
	mTipoop    := ""
	mTpTrans   := ""
	mDescrop   := ""
	mCF        := ""
	mTitulo    := ""
	mDescr     := ""
	mVend      := ""
	mCodProm   := ""
	mIdentif   := ""
	mNome      := ""
	mUF        := ""
	mMun       := ""
	mNota      := ""
	mSerie     := ""
	mGrat      := ""
	mGrupo     := ""
	mDescr     := ""
	mNome      := ""
	mDtrans    := ""
	mTpTrans   := "00"
	mDuplicado := ""
	mCondPgto  := ""
	mFatprog   := ""
	mItAv      := 0
	mParcAV    := 0
	mParc      := 0
	mComis     := 0
	mValor     := 0
	mAvAberto  := 0
	mAvFaturad := 0
	mQtdeFat   := 0
	mEdicao    := 0
	mQtde      := 0
	mVlITem    := 0
	mNumIns    := 0
	mcodiss    := 0
	mValoricms := 0
	mBaseicms  := 0
	mDesprem   := 0
	mDtFat     :=stod("")
	mAliqiss   := 0	      
	mIRRF    := 0
	mCNPJ      := ""
   	mNumExt := ""
   	mVltot   :=0
	mPago    :=0
	mPgto    :=0
	mIt      :=0
	mAberto  :=0
	mInadimpl:=0
	mVencido :=0
	mParc    :=0
	mCanc    :=0
	mParc1   :=0
	mParc2   :=0
	mParc3   :=0
	mParc4    :=0
	mParc5    :=0
	mParc6    :=0
	mParc7    :=0
	mParc8    :=0
	mParc9    :=0
	mParc10   :=0
	mParc11   :=0
	mParc12   :=0
	mAvAberto :=0
	mAvFaturad:=0
	mQtdeFat  :=0
	mAvTotal  :=0
	mParcfat  :=0
	mDesconto :=0
	mCodiss   :=0
	mValoricms:=0
	mBaseicms :=0        
	mAvTotFat:=0
	mVenc1   :=stod("")
	mVenc2   :=stod("")
	mVenc3   :=stod("")
	mVenc4   :=stod("")
	mVenc5   :=stod("")
	mVenc6   :=stod("")
	mVenc7   :=stod("")
	mVenc8   :=stod("")
	mVenc9   :=stod("")
	mVenc10  :=stod("")
	mVenc11  :=stod("")
	mVenc12  :=stod("")
	mDivven  := ""
	mPedido    := TRBF->D2_PEDIDO
	mDTFat     := TRBF->D2_EMISSAO
	mSerie     := TRBF->D2_SERIE
	mProduto   := TRBF->D2_COD
	MALMOX	    := TRBF->D2_LOCAL
	mCliente   := TRBF->D2_CLIENTE
	mItem      := TRBF->D2_ITEMPV
	mCF        := AllTrim(TRBF->D2_CF)
	mQtde      := TRBF->D2_QUANT
	mValor     := TRBF->D2_TOTAL
	mNota      := TRBF->D2_DOC
	mComis     := TRBF->D2_COMIS1+TRBF->D2_COMIS2+TRBF->D2_COMIS3+TRBF->D2_COMIS5
	mCodiss    := TRBF->D2_CODISS
	mValoricms := TRBF->D2_VALICM
	mBaseicms  := TRBF->D2_BASEICM
	mValorISS  := TRBF->D2_VALISS
	mAliqiss   := TRBF->D2_ALIQISS 
	mPRCVEN    := TRBF->D2_PRCVEN
	mDesprem   := TRBF->F2_DESPREM	
	mValMerc   := TRBF->F2_VALMERC
	mEquipe    := TRBF->A3_EQUIPE
	mRegiao    := TRBF->A3_REGIAO
	mDivVend   := TRBF->A3_DIVVEND
	mNomevend  := TRBF->A3_NOME
	
	IncProc("Nota: "+ mSerie+mNota +"; Pedido: "+mPedido)

	DbSelectArea("SF4")
	DbSetOrder(1)
	DbGoTop()
	DbSeek(xFilial("SF4")+TRBF->D2_TES)
	If 'S' $(SF4->F4_DUPLIC)
		mGrat := 'P' //pago
	ElseIf 'N' $(SF4->F4_DUPLIC)
		if trim(SF4->F4_TPMOV)=='1'
			mGrat := 'O' //Outras Saidas
		else
			mGrat := 'C' //Cortesia
		endif
	EndIf

	   //pago                                   todos                 cortesia                               outras saidas    
	If (MV_PAR07 == 1 .And. mGrat == 'P') .OR. (MV_PAR07 ==  3) .OR. (MV_PAR07 == 2 .AND. mGrat =='C') .OR. (MV_PAR07 == 4 .AND. mGrat <> 'O')
		
		//SIGALOJA OU PEDIDOS
		IF ALLTRIM(TRBF->F2_ESPECIE)='CF' .AND. !EMPTY(TRBF->F2_PDV) .AND. TRBF->F2_ECF=='S' //(SIGALOJA)
				//SELECT NO SL1:	L1_NUM, L1_SERIE, L1_DOC, L1_XPEDIDO, L1_EMISSAO, L1_VLRTOT
				cQuery := "SELECT L1_NUM, L1_SERIE, L1_DOC, L1_XPEDIDO, L1_EMISSAO, L1_VLRTOT"
				cQuery += " FROM "+ RetSqlName("SL1") +" SL1"
				cQuery += " WHERE L1_FILIAL='"+ xFilial("SL1") +"' AND L1_SERIE='"+ mSerie +"' AND L1_DOC='"+ mNota +"' AND L1_EMISSAO='"+ dtos(mDTFat) +"' AND SL1.D_E_L_E_T_<>'*'"
				
				DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRBLJ", .T., .F. )
				TcSetField("TRBLJ","L1_EMISSAO"   ,"D")
				Dbgotop()
				If !eof()
					mCodProm  := ""
					mIdentif  := "SIGALOJA"
					mTipoop   := ""
					mVend     := TRBF->F2_VEND1
					mCondPgto := ""
					mTpTrans  := ""
					mVlPedido := TRBLJ->L1_VLRTOT
					mDivven   := "MERC"
					mNumExt   := TRBLJ->L1_XPEDIDO
					mPedido   := TRBLJ->L1_NUM
					mDescrop  := ""
					mContaop  := ""
				Endif
				DBSelectArea("TRBLJ")
				DBCloseArea()
		ELSE //PEDIDOS (SC5)
		
			DbSelectArea("SC5")
			DbSetOrder(1)
			If DbSeek(xFilial("SC5")+mPedido, .T.) //ped1
				mCodProm  := SC5->C5_CODPROM
				mIdentif  := SC5->C5_IDENTIF
				mTipoop   := SC5->C5_TIPOOP
				mVend     := SC5->C5_VEND1
				//mCodcli   := SC5->C5_CLIENTE
				mCondPgto := SC5->C5_CONDPAG
				mTpTrans  := SC5->C5_TPTRANS
				mVlPedido := SC5->C5_VLRPED
				mDivven   := SC5->C5_DIVVEN
				if SM0->M0_CODIGO =="01"
					mNumExt := SC5->C5_NUMEXT
				endif
		
				//divven
				If (MV_PAR13 == 1 .and. SC5->C5_DIVVEN == "MERC") .or. (MV_PAR13 == 2 .and. SC5->C5_DIVVEN == "PUBL") .or. (MV_PAR13 == 3 .and. SC5->C5_DIVVEN == "SOFT") .or. (MV_PAR13 == 4)
			
					If SC5->C5_CODPROM > MV_PAR12 .OR. SC5->C5_CODPROM < MV_PAR11
						DbSelectArea("TRBF")
						DbSkip()
						Loop
					EndIf
			
				Else //divven
			 		DbSelectArea("TRBF")
					DbSkip()
					Loop	
				EndIf //divven
			
				DbSelectArea("SZ9")
				If DbSeek(xFilial("SZ9")+mTipoop,.T.)
					mDescrop := SZ9->Z9_DESCR
					mContaop := SZ9->Z9_CONTA1
				Else
					mDescrop := ""
					mContaop := ""
				Endif
	
				If SC5->C5_DIVVEN == 'PUBL'
					DbSelectArea("SE4")
					If DbSeek(xFilial("SE4")+mCondpgto,.T.)
						mDescrop := SE4->E4_DESCRI
					Endif
				Endif
				
				DbSelectArea("SZS")
				DbSetOrder(4)
				DbSeek(xFilial("SZS")+mPedido+mItem+mNota+mSerie, .T.)
				mFatprog := SZS->ZS_FATPROG
				If Found()
					mParcAv := SZS->ZS_NUMINS
					mEdicao := 0
				Else
					DbSelectArea("SZV")
					DbSetOrder(2)
					If DbSeek(xFilial("SZV")+mNota,.T.) .and. SZV->ZV_NUMAV == mPedido
						mParcAv := SZV->ZV_NPARC
						mEdicao := 0
					Endif
				Endif		
			EndIf//ped1
		
		ENDIF //sigaloja/pedido
		
		//verificar SE1
		DbSelectArea("SE1")
		DbSetOrder(1)
		DbGoTop()
		If DbSeek(xFilial("SE1")+mSerie+mNota)
			While !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. Alltrim(SE1->E1_NUM) == Alltrim(mNota)
				If Alltrim(SE1->E1_PREFIXO) == Alltrim(mSerie) .and. (ALLTRIM(SE1->E1_TIPO) =="NF" .or. alltrim(SE1->E1_ORIGEM)=='LOJA701')
					If SE1->E1_PARCELA=='A' .OR. SE1->E1_PARCELA==' ' 
						mIRRF := SE1->E1_IRRF
					EndIf
					
					
					mParc++
					mParcfat := (SE1->E1_VALOR)*(mValor/mValMerc)
					mVltot   += mParcfat 
					mDesconto:= SE1->E1_DESCONT*(mValor/mValMerc)
					mit++
			
					If mit == 1
						mParc1   := mParcfat
						mvenc1   := SE1->E1_VENCTO
					ElseIf mit == 2
						mParc2   := mParcfat
						mvenc2   := SE1->E1_VENCTO
					ElseIf mit == 3
						mParc3   := mParcfat
						mvenc3   := SE1->E1_VENCTO
					ElseIf mit == 4
						mParc4   := mParcfat
						mvenc4   := SE1->E1_VENCTO
					ElseIf mit == 5
						mParc5   := mParcfat
						mvenc5   := SE1->E1_VENCTO
					ElseIf mit == 6
						mParc6   := mParcfat
						mvenc6   := SE1->E1_VENCTO
					ElseIf mit == 7
						mParc7   := mParcfat
						mvenc7   := SE1->E1_VENCTO
					ElseIf mit == 8
						mParc8   := mParcfat
						mvenc8   := SE1->E1_VENCTO
					ElseIf mit == 9
						mParc9   := mParcfat
						mvenc9   := SE1->E1_VENCTO
					ElseIf mit == 10
						mParc10  := mParcfat
						mvenc10  := SE1->E1_VENCTO
					ElseIf mit == 11
						mParc11  := mParcfat
						mvenc11  := SE1->E1_VENCTO
					ElseIf mit == 12
						mParc12  := mParcfat
						mvenc12  := SE1->E1_VENCTO
					EndIf
			
					If !Empty(SE1->E1_BAIXA) .And. SE1->E1_SALDO==0;
						.AND. !'LP'$(SE1->E1_MOTIVO) .AND. !'CAN'$(SE1->E1_MOTIVO);
						.AND. !'DEV'$(SE1->E1_MOTIVO) .AND. !'920'$(SE1->E1_PORTADO) .AND. !'930'$(SE1->E1_PORTADO) .AND. !'904'$(SE1->E1_PORTADO) //20041014
					
						//mPago++
						mPago += mParcfat
					Else
						If SE1->E1_VENCTO+30 < DDATABASE .AND.!'CAN'$(SE1->E1_MOTIVO) .AND. !'920'$(SE1->E1_PORTADO) .AND. !'930'$(SE1->E1_PORTADO) .AND. !'904'$(SE1->E1_PORTADO) //20041014 //20080312
							//mInadimpl++
							mInadimpl+= mParcfat
						ElseIf SE1->E1_VENCTO < DDATABASE .AND. !'CAN'$(SE1->E1_MOTIVO) .AND. !'920'$(SE1->E1_PORTADO) .AND. !'930'$(SE1->E1_PORTADO) .AND. !'904'$(SE1->E1_PORTADO) //20041014 //20080312
							//mVencido++
							mVencido+= mParcfat
						ElseIf 'CAN'$(SE1->E1_MOTIVO) .OR. '920'$(SE1->E1_PORTADO) .OR. '930'$(SE1->E1_PORTADO) .OR. '904'$(SE1->E1_PORTADO) //20041014 /20080312
							//mCanc++
							mCanc+= mParcfat
						Else
							//mAberto++
							mAberto+= mParcfat
						EndIf
					Endif
				Endif
			
				DbSelectArea("SE1")
				DbSkip()
			End
		Endif   
	
		If MDIVVEN =='PUBL'
		//trocar por select sum 
	     	DbSelectArea("SE1")
			dbSetOrder(1)
    		DbGoTop()
	    	If DbSeek(xFilial("SE1")+mSerie+mNota) 
    	       While !Eof() .AND.  SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_NUM==mNota .and. SE1->E1_SERIE==mSerie 
       	       if ALLTRIM(SE1->E1_TIPO) =="NF"
	       	       If !'LP'$(SE1->E1_MOTIVO) .AND. !'CAN'$(SE1->E1_MOTIVO);
		       	 	  .AND. !'DEV'$(SE1->E1_MOTIVO) .AND. !'920'$(SE1->E1_PORTADO)  .AND. !'930'$(SE1->E1_PORTADO) .AND. !'904'$(SE1->E1_PORTADO)
        	    		  mAvTotFat+=SE1->E1_VALOR                           
	            	  	Endif   		
    	       	endif
       	       DbSkip()
           	End    
	    	Endif
	    	
			DbSelectArea("SZS")
			DbSetOrder(1)
			If DbSeek(xFilial("SZS")+mPedido+mItem, .T.)
			//trocar por select sum 
				If SZS->ZS_FATPROG == 'S'
					DbSelectArea("SZV")
					DbSetOrder(1)
					DbSeek(xFilial("SZV")+mPedido, .T.)
					While !Eof() .and. SZV->ZV_FILIAL == xFilial("SZV") .and. mPedido == SZV->ZV_NUMAV 
						If SZV->ZV_SITUAC=='AA'
							mQTdeFat++
							mAvTotal += SZV->ZV_VALOR
							If Empty(SZV->ZV_NFISCAL)
								mAvAberto += SZV->ZV_VALOR
							Else
								mAvFaturada += SZV->ZV_VALOR
							Endif
						EndIf
						DbSkip()
					End
				Else
					DbSelectArea("SZS")
					DbSetOrder(1)
					//trocar por select sum 
					While !Eof() .and.  SZS->ZS_FILIAL == xFilial("SZS") .AND. mPedido == SZS->ZS_NUMAV 
						If SZS->ZS_SITUAC == 'AA'
							mQTdeFat++
							mAvTotal += SZS->ZS_VALOR
							If Empty(SZS->ZS_NFISCAL)
								mAvAberto += SZS->ZS_VALOR
							Else
								mAvFaturada += SZS->ZS_VALOR
							Endif
						EndIf
						DbSkip()
					End
				Endif
			Else
				mQtdeFat := 1
			Endif    	 
		Endif //divven publi
	
		GRAVA()
	EndIf //pago cortesia outras saidas todos
		
	DbSelectArea("TRBF")
	DbSkip()
	Loop
End

DbSelectArea(cArq)
dbGoTop()
If MV_PAR10 == 1
	cMsg := "Arquivo Gerado com Sucesso em: "+_cString
	DbSelectArea(cArq)
	dbGoTop()
	COPY TO &_cString VIA "DBFCDXADS"
	MSGINFO(cMsg)
ElseIf MV_PAR10 == 2
	DbSelectArea(cArq)
	dbGoTop()
	
	GRAVAMTR()
	cMsg := "Arquivo Gerado com Sucesso em: "+_cString1
	DbSelectArea(cArq1)
	dbGoTop()
	COPY TO &_cString1 DELI
	COPY TO &_cString2 VIA "DBFCDXADS"
	DbSelectArea(cArq1)
	DBCloseArea()
	MSGINFO(cMsg)
ElseIf MV_PAR10 == 3
	wnrel := SetPrint(cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
	SetDefault(aReturn,cString)
	Processa( {|| Transfolha()} )     
	MSGINFO("Transfolha:Fim de Processamento")
ElseIf MV_PAR10 == 4
	wnrel := SetPrint(cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
	SetDefault(aReturn,cString)
	Processa( {|| Relatorio()} )
ElseIf MV_PAR10 == 5
	Processa( {|| Gold()} )        
	DbSelectArea("GOLD")                 
	DBGOTOP()
	_ARQE := "\SIGA\arqass\GOLDDOC.TXT"
	COPY TO &_arqe SDF          	
	DBCloseArea("GOLD")        
	
	DbSelectArea("GOLDI")
	DBGOTOP()
	_ARQEI := "\SIGA\arqass\GOLDITEM.TXT"
	COPY TO &_arqeI SDF          	
	DBCloseArea("GOLDI")
	MsgInfo(_ARQE+CHR(10)+_ARQEI+CHR(10)+"Item:"+trim(Str(contIgual+ ContDoc))+CHR(10)+"Doc:"+trim(Str(ContDoc)))
Endif

DbSelectArea(cArq)
DbCloseArea()
DbSelectArea("TRBF")
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
DbSelectArea("SZJ")
Retindex("SZJ")
DbSelectArea("SZS")
Retindex("SZS")
DbSelectArea("SZV")
Retindex("SZV")
DbSelectArea("SD2")
Retindex("SD2")

Return


//****************************************************************************
// Function  GRAVA()
//****************************************************************************
Static Function GRAVA()
mNome   := ""
mUF     := ""
mMun    := ""
mGrupo  := ""
mDescr  := ""
mRevista:= ""
mTitulo := ""
mDtrans := ""
mContrib:= ""

DbSelectArea("SB1")
If DbSeek(xFilial("SB1")+mProduto)
	mGrupo := AllTrim((SB1->B1_GRUPO))
	mDescr := SB1->B1_DESC
	t_prod := SB1->B1_TIPO
	mContabil  := SB1->B1_CONTA 
Endif 

DbSelectArea("SBM")
If DbSeek(xFilial("SBM")+mGrupo)
	mTitulo := SBM->BM_DESC
Endif

DbSelectArea("SX5")
DbGoTop()
If DbSeek(xFilial("SX5")+'Z0'+mTpTrans+'  ')
	mTipoop := mTpTrans
	mDtrans := SX5->X5_DESCRI
Endif

DbSelectArea("SA1")
dbsetorder(1)
If DbSeek(xFilial("SA1")+mCliente)
	mNome    := SA1->A1_NOME
	mUF      := SA1->A1_EST
	mMun     := SA1->A1_MUN
	mFone    := SA1->A1_TEL
	mInscr   := SA1->A1_INSCR 
	mCNPJ    := SA1->A1_CGC
	If  Empty(SA1->A1_INSCR) .OR. 'ISEN'$(SA1->A1_INSCR)
		mContrib := ""
	else
		mContrib := "S"
	Endif
Else
	mNome    := ""
	mUF      := ""
	mMun     := ""
	mFone    := ""
	mInscr   := "" 
	mCNPJ    := ""
	mContrib := ""
Endif

mConta1++

//MsProcTxt("Lendo Registros : "+Str(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))

DbSelectArea(cArq)
RecLock(cArq,.T.)
Replace Contrib   With  mContrib
Replace Pedido    With  mPedido
Replace Item      With  mItem
Replace CodCli    With  mCliente
Replace CodDest   With  mCodDest
Replace Produto   With  mProduto
REPLACE ALMOX 	WITH  MALMOX
Replace Revista   With  mRevista
Replace Edicao    With  mEdicao
Replace Tipoop    With  mTipoop
Replace TpTrans   With  mDtrans
Replace FatProg   With  mFatProg
Replace Descrop   With  mDescrop
Replace CF        With  mCF
Replace ValorFat  With  mValor
Replace Parcela   With  mParcAv
Replace DtFat     With  mDtFat
Replace Titulo    With  mTitulo
Replace Descr     With  mDescr
Replace Tipo      With  t_Prod
Replace Vend      With  mVend
Replace Regiao    With  mRegiao
Replace Equipe    With  mEquipe
Replace QtdeVen   With  mQtde
Replace CodProm   With  mCodProm
Replace Identif   With  mIdentif
Replace Nome      With  mNome
Replace Fone      With  mFone
Replace Inscr     With  mInscr
Replace UF        With  mUF
Replace Mun       With  mMun
Replace Serie     With  mSerie
Replace DivVend   With  mDivVend
Replace Dupl      With  mNota
Replace Comissao  With  mComis
Replace Nomevend  With  mNomevend
Replace CodIss    With  mCodISS
Replace ValorISS  With  mValorISS
Replace ValorICMS With  mValorICMS
Replace BaseIcms  With  mBaseIcms
Replace Contabil  With  mContabil
Replace Contabil2 With 	mContaop
Replace Desprem   With  mDesprem
Replace Aliqiss   With  mAliqiss
Replace CGC       With  mCNPJ
Replace IRRF      With  mIRRF
REPLACE PRCVEN	WITH  mPRCVEN
Replace NUMEXT	WITH mNumExt
Replace AvAvencer With  mAvAberto
Replace AvFatura  With  mAvFaturada
Replace AvTotal   With  mAvTotal    
If TIPOOP=='04' .OR. TIPOOP=='12'
   Replace DifAvFat  With  mAvTotFat-(mAvFaturada*0.80)
Else
   Replace DifAvFat  With  mAvTotFat-mAvFaturada
EndIf
Replace QtdeFat   With  mQtdeFat
Replace Vldupl    With  mVltot
Replace Pago      With  mPago
Replace Inadimp   With  mInadimpl
Replace Avencer   With  mAberto
Replace Vencido   With  mVencido
Replace Cancelado With  mCanc
Replace Desconto  With  mDesconto
Replace Parc1     With  mParc1
Replace Parc2     With  mParc2
Replace Parc3     With  mParc3
Replace Parc4     With  mParc4
Replace Parc5     With  mParc5
Replace Parc6     With  mParc6
Replace Parc7     With  mParc7
Replace Parc8     With  mParc8
Replace Parc9     With  mParc9
Replace Parc10    With  mParc10
Replace Parc11    With  mParc11
Replace Parc12    With  mParc12
Replace Venc1     With  mVenc1
Replace Venc2     With  mVenc2
Replace Venc3     With  mVenc3
Replace Venc4     With  mVenc4
Replace Venc5     With  mVenc5
Replace Venc6     With  mVenc6
Replace Venc7     With  mVenc7
Replace Venc8     With  mVenc8
Replace Venc9     With  mVenc9
Replace Venc10    With  mVenc10
Replace Venc11    With  mVenc11
Replace Venc12    With  mVenc12           

MsUnlock()
Return




//**************************************************************************** 
// Function  FARQTRAB()
//****************************************************************************
Static Function FARQTRAB()

_aCampos := {}
AADD(_aCampos,{"PEDIDO","C",6,0})
AADD(_aCampos,{"ITEM","C",2,0})
AADD(_aCampos,{"DUPL","C",9,0})
AADD(_aCampos,{"PARCELA","N",5,0})
AADD(_aCampos,{"QTDEVEN","N",10,0})
AADD(_aCampos,{"QTDEFAT","N",5,0})
AADD(_aCampos,{"SERIE","C",3,0})
AADD(_aCampos,{"FATPROG","C",1,0})
AADD(_aCampos,{"DTFAT ","D",8,0})
AADD(_aCampos,{"EDICAO","N",4,0})
AADD(_aCampos,{"CIRCULACAO","D",8,0})
AADD(_aCampos,{"ANO","N",4,0})
AADD(_aCampos,{"MES","N",2,0})
AADD(_aCampos,{"VLFATITEM","N",12,2})
AADD(_aCampos,{"VLBRUTO","N",12,2})
AADD(_aCampos,{"VLLIQ","N",12,2})
AADD(_aCampos,{"VALORFAT","N",12,2})
AADD(_aCampos,{"AVAVENCER","N",12,2})
AADD(_aCampos,{"AVFATURA","N",12,2})
AADD(_aCampos,{"AVTOTAL","N",12,2})
AADD(_aCampos,{"DIFAVFAT","N",12,2})
AADD(_aCampos,{"AVCANC","N",12,2})
AADD(_aCampos,{"DESPREM","N",12,2})
AADD(_aCampos,{"VLDUPL","N",12,2})
AADD(_aCampos,{"PAGO","N",12,2})
AADD(_aCampos,{"DESCONTO","N",12,2})
AADD(_aCampos,{"INADIMP","N",12,2})
AADD(_aCampos,{"AVENCER","N",12,2})
AADD(_aCampos,{"VENCIDO","N",12,2})
AADD(_aCampos,{"CANCELADO","N",12,2})
AADD(_aCampos,{"CF","C",5,0})
AADD(_aCampos,{"CODCLI","C",6,0})
AADD(_aCampos,{"CODDEST","C",6,0})
AADD(_aCampos,{"CONTRIB","C",1,0})
AADD(_aCampos,{"PRODUTO" ,"C",15,0})
AADD(_aCampos,{"TITULO","C",40,0})
AADD(_aCampos,{"REVISTA","C",40,0})
AADD(_aCampos,{"DESCR","C",40,0})
AADD(_aCampos,{"TIPO","C",2,0})
AADD(_aCampos,{"VEND","C",6,0})
AADD(_aCampos,{"REGIAO","C",3,0})
AADD(_aCampos,{"EQUIPE","C",15,0})
AADD(_aCampos,{"DIVVEND","C",40,0})
AADD(_aCampos,{"NOMEVEND","C",40,0})
AADD(_aCampos,{"COMISSAO","N",12,2})
AADD(_aCampos,{"CODPROM","C",15,0})
AADD(_aCampos,{"IDENTIF","C",8,0})
AADD(_aCampos,{"NOME","C",40,0})
AADD(_aCampos,{"FONE","C",20,0})
AADD(_aCampos,{"INSCR","C",18,0})
AADD(_aCampos,{"MUN ","C",30,0})
AADD(_aCampos,{"UF","C",2,0})
AADD(_aCampos,{"TIPOOP","C",2,0})
AADD(_aCampos,{"TPTRANS","C",60,0})
AADD(_aCampos,{"DESCROP","C",50,0})
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
AADD(_aCampos,{"CODISS","C",08,0})
AADD(_aCampos,{"VALORISS","N",14,2})
AADD(_aCampos,{"VALORICMS","N",14,2})
AADD(_aCampos,{"BASEICMS","N",16,2})
AADD(_aCampos,{"CONTABIL","C",20,0})
AADD(_aCampos,{"CONTABIL2","C",20,0})
AADD(_aCampos,{"ALIQISS","N",06,2})
AADD(_aCampos,{"IRRF","N",12,2})
AADD(_aCampos,{"CGC","C",14,0})      
AADD(_aCampos,{"PRCVEN","N",12,2})
AADD(_aCampos,{"ALMOX","C",2,0})
AADD(_aCampos,{"NUMEXT","C",10,0})

_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "Pedido+Dupl+Item+STR(edicao,4)"

dbUseArea(.T.,, _cNome,cArq,.F.,.F.)

dbSelectArea(cArq)
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")


// Arquivo Matrix
If MV_PAR10 == 2
	_aCampos := {}
	AADD(_aCampos,{"CODAWB","C",9,0})
	AADD(_aCampos,{"AWBREF","C",20,0})
	AADD(_aCampos,{"CODCEP","C",8,0})
	AADD(_aCampos,{"CODPROD","C",6,0})
	AADD(_aCampos,{"VALORAWB","N",10,2})
	AADD(_aCampos,{"PESOAWB","N",10,2})
	AADD(_aCampos,{"LARGAWB","N",10,2})
	AADD(_aCampos,{"ALTUAWB","N",10,2})
	AADD(_aCampos,{"PROFAWB","N",10,2})
	AADD(_aCampos,{"QTDE","N",5,0})
	AADD(_aCampos,{"ENDLOG","C",40,0})
	AADD(_aCampos,{"ENDBAI","C",20,0})
	AADD(_aCampos,{"DESTINA","C",40,0})
	AADD(_aCampos,{"TELEFONE","C",10,0})
	AADD(_aCampos,{"ENDTPO","C",5,0})
	AADD(_aCampos,{"ENDNUM","C",10,0})
	AADD(_aCampos,{"ENDCOM","C",20,0})
	AADD(_aCampos,{"CIDADE","C",20,0})
	AADD(_aCampos,{"ESTADO","C",2,0})
	AADD(_aCampos,{"VLRFRETE","N",10,2})
	AADD(_aCampos,{"QTDFITAS2","N",5,0})
	AADD(_aCampos,{"RETIRADA","C",20,0})
	AADD(_aCampos,{"VLRAGENTE","N",10,2})
	AADD(_aCampos,{"DDD","C",4,0})
	AADD(_aCampos,{"PAIS","C",20,0})
	AADD(_aCampos,{"CPF","C",14,0})
	AADD(_aCampos,{"DDD1","C",4,0})
	AADD(_aCampos,{"TELEFONE1","C",8,0})
	AADD(_aCampos,{"NF","C",10,0})
	
	_cNome1 := CriaTrab(_aCampos,.t.)
	cIndex := CriaTrab(Nil,.F.)
	cKey   := "NF"
	dbUseArea(.T.,, _cNome1,cArq1,.F.,.F.)
	dbSelectArea(cArq1)
	Indregua(cArq1,cIndex,ckey,,,"Selecionando Registros do Arq")
EndIF


//Arquivo Gold
If MV_PAR10 == 5
	_aCamposG := {}
	AADD(_aCamposG,{"TipoReg","C",2,0})
	AADD(_aCamposG,{"codDeposit","C",15,0})
	AADD(_aCamposG,{"CodEmp","C",15,0})
	AADD(_aCamposG,{"CGCEmp","C",15,0})
	AADD(_aCamposG,{"NomeEmp","C",40,0})
	AADD(_aCamposG,{"EndEmp","C",40,0})
	AADD(_aCamposG,{"bairroEmp","C",25,0})
	AADD(_aCamposG,{"MunEmp","C",25,0})
	AADD(_aCamposG,{"UFEmp","C",2,0})
	AADD(_aCamposG,{"CepEmp","C",9,0})
	AADD(_aCamposG,{"InscrEmp","C",15,0})
	AADD(_aCamposG,{"TipoDoc","C",5,0})
	AADD(_aCamposG,{"SerieDoc","C",5,0})
	AADD(_aCamposG,{"NumDoc","C",10,0})
	AADD(_aCamposG,{"CodMatriz","C",15,0})
	AADD(_aCamposG,{"CodEstab","C",10,0})
	AADD(_aCamposG,{"NatOperac","C",6,0})
	AADD(_aCamposG,{"Conhec","C",10,0})
	AADD(_aCamposG,{"DtEmis","C",8,0})
	AADD(_aCamposG,{"ValTotDoc","C",20,0})
	AADD(_aCamposG,{"ValTotProd","C",20,0})
	AADD(_aCamposG,{"ValIcms","C",20,0})
	AADD(_aCamposG,{"ValIcmsSub","C",20,0})
	AADD(_aCamposG,{"ValIpi","C",20,0})
	AADD(_aCamposG,{"ValFrete","C",20,0})
	AADD(_aCamposG,{"BIcms","C",20,0})
	AADD(_aCamposG,{"BIcmsSub","C",20,0})
	AADD(_aCamposG,{"BIpi","C",20,0})
	AADD(_aCamposG,{"ValSeg","C",20,0})
	AADD(_aCamposG,{"ValDesc","C",20,0})
	AADD(_aCamposG,{"ValAcresc","C",20,0})
	AADD(_aCamposG,{"CodTrans","C",15,0})
	AADD(_aCamposG,{"Info1","C",25,0})
	AADD(_aCamposG,{"Info2","C",25,0})
	AADD(_aCamposG,{"Info3","C",25,0})
	AADD(_aCamposG,{"CodEmpEnt","C",15,0})
	AADD(_aCamposG,{"CodEmpFat","C",15,0})
	AADD(_aCamposG,{"CodEmpDest","C",15,0})
	AADD(_aCamposG,{"CodEmpEmit","C",15,0})
	AADD(_aCamposG,{"TipoLogr","C",15,0})
	AADD(_aCamposG,{"Logr","C",60,0})
	AADD(_aCamposG,{"NumLogr","C",10,0})
	AADD(_aCamposG,{"CompLogr","C",40,0})
	AADD(_aCamposG,{"Pedido","C",6,0})
	AADD(_aCamposG,{"NUMEXT","C",10,0})
	_cNomeG := CriaTrab(_aCamposG,.t.)
	cIndexG:= CriaTrab(Nil,.F.)
	cKeyG   := "NumDoc"
	dbUseArea(.T.,, _cNomeG,"GOLD",.F.,.F.)
	dbSelectArea("GOLD")
	Indregua("GOLD",cIndexG,ckeyG,,,"Criando indice")


	//gold item
	_aCamposGI := {}
	AADD(_aCamposGI,{"TipoReg","C",2,0})
	AADD(_aCamposGI,{"CodEmp","C",15,0})
	AADD(_aCamposGI,{"TipoDoc","C",5,0})
	AADD(_aCamposGI,{"Serie","C",5,0})
	AADD(_aCamposGI,{"NumDoc","C",10,0})
	AADD(_aCamposGI,{"CodMatriz","C",15,0})
	AADD(_aCamposGI,{"CodProd","C",25,0})
	AADD(_aCamposGI,{"Qtd","C",20,0})
	AADD(_aCamposGI,{"TipoUc","C",5,0})
	AADD(_aCamposGI,{"FatTpUC","C",20,0})
	AADD(_aCamposGI,{"AlICms","C",20,0})
	AADD(_aCamposGI,{"AlIpi","C",20,0})
	AADD(_aCamposGI,{"ValUnit","C",20,0})
	AADD(_aCamposGI,{"AlIcmsSub","C",20,0})
	AADD(_aCamposGI,{"TpLog","C",10,0})
	AADD(_aCamposGI,{"DadoLog","C",15,0})
	AADD(_aCamposGI,{"ClassePro","C",5,0})
	AADD(_aCamposGI,{"SeqItem","N",3,0})
	AADD(_aCamposGI,{"Info1","C",25,0})
	AADD(_aCamposGI,{"Info2","C",25,0})
	AADD(_aCamposGI,{"Info3","C",25,0})
	_cNomeGI := CriaTrab(_aCamposGI,.t.)
	dbUseArea(.T.,, _cNomeGI,"GOLDI",.F.,.F.)
EndIf

Return














//****************************************************************************
// Function  RELATORIO()
//****************************************************************************
Static Function RELATORIO()
cTitulo    := PADC("RELATÓRIO",74)
_cTitulo   := " **** RESUMO DO FATURAMENTO **** " 
Programa   := "PFAT144"
If MV_PAR07 == 1
		mTipo := 'Pagos'
ElseIf MV_PAR07 == 2
		mTipo := 'Gratuitos' 
ElseIf MV_PAR07 == 3
		mTipo := 'Todos'   
ElseIf MV_PAR07 == 4
		mTipo := 'Outras Saidas'   
Endif

Cabec1:="Do Produto :"+SUBS(MV_PAR01,1,7)+"   Do Vend :"+MV_PAR05+"   Pedidos de :"+DTOC(MV_PAR03)+"   Da Regiao :"+MV_PAR08
//      1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//               10        20        30        40        50        60        70        80        90        100       110       120
Cabec2:="At‚ Produto:"+SUBS(MV_PAR02,1,7)+"   At‚ Vend:"+MV_PAR06+"   Pedidos at‚:"+DTOC(MV_PAR04)+"   At‚ Regiao:"+MV_PAR09+"   Tipo:"+mTipo
//       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                10        20        30        40        50        60        70        80        90        100       110       120
Cabec3:="Produto                                   Qtde       Valor         Pago(%)  Em Aberto(%) Vencido(%)  Cancelados(%) Inadimplencia(%) "
//       XXXXXXXXXXXXXXX                           999999999  999999999999  999999   999999       99999
//       1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                10        20        30        40        50        60        70        80        90        100       110       120

Li := 0
Cabec(_cTitulo,Cabec1,Cabec2,Programa,Tamanho,nCaracter)

@ Li,000 PSAY CABEC3
@ Li+1  ,000 PSAY Replicate('*',132)
Li += 2

dbSelectArea(cArq)
cIndex := CriaTrab(Nil,.F.)
cKey   := "TITULO"
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")
dbGoTop()

mValort   :=0
mQtdet    :=0
mPgtot    :=0
mEmabertot:=0
mInadimplt:=0
mCanct    :=0
mVencidot :=0

While !Eof()
	If Li >= 60
		Li := 0
		Cabec(_cTitulo,Cabec1,Cabec2,Programa,Tamanho,nCaracter)
	Endif
	mTitulo  := TITULO
	mQtde    := 0
	mValor   := 0
	mPgto    := 0
	mEmaberto:= 0
	mInadimpl:= 0
	mCanc    := 0
	mVencido := 0
	
	While !Eof() .and. TITULO == mTitulo
		mQtde    := mQtde+QTDEVEN
		mValor   := mValor+VlDupl
		mPgto    := mPgto+PAGO
		mEmaberto:= mEmaberto+AVENCER
		mInadimpl:= mInadimpl+INADIMP
		mCanc    := mCanc+CANCELADO
		mVencido := mVencido+VENCIDO
		dbSkip()
	End
	
	@ Li,001 PSAY substr(mTitulo,1,30)
	@ Li,033 PSAY substr(Transform(mQtde,"@E 99,999,999"),1,10)
	@ Li,044 PSAY Transform(mValor,"@E 9,999,999,999.99")
	@ Li,068 PSAY Transform((mPgto/mValor)*100,"@E 999.99")
	@ Li,077 PSAY Transform((mEmaberto/mValor)*100,"@E 999.99")
	@ Li,090 PSAY Transform((mVencido/mvalor)*100,"@E 999.99")
	@ Li,102 PSAY Transform((mCanc/mvalor)*100,"@E 999.99")
	@ Li,116 PSAY Transform((mInadimpl/mvalor)*100,"@E 999.99")
	
	Li++
	mValort   += mValor
	mQtdet    += mQtde
	mPgtot    += mPgto
	mEmabertot+= mEmaberto
	mInadimplt+= mInadimpl
	mCanct    += mCanc
	mVencidot += mVencido
	
	If Eof()
		@ Li+2,001 PSAY 'SUBTOTAL..............:'
		@ Li+2,033 PSAY Transform(mQtdet,"@E 99,999,999")
		@ Li+2,044 PSAY Transform(mValort,"@E 9,999,999,999.99")
		@ Li+2,068 PSAY Transform((mPgtot/mValort)*100,"@E 999.99")
		@ Li+2,077 PSAY Transform((mEmabertot/mValort)*100,"@E 999.99")
		@ Li+2,090 PSAY Transform((mVencidot/mValort)*100,"@E 999.99")
		@ Li+2,102 PSAY Transform((mCanct/mValort)*100,"@E 999.99")
		@ Li+2,116 PSAY Transform((mInadimplt/mValort)*100,"@E 999.99")
		@ Li+4,001 PSAY 'ITENS NAO FATURADOS...:'
		@ Li+4,033 PSAY Transform(mQtNFat,"@E 99,999,999")
		@ Li+4,044 PSAY Transform(mVlNFat,"@E 9,999,999,999.99")
		@ Li+4,068 PSAY Transform(00000,"@E 999.99")
		@ Li+4,077 PSAY Transform(00000,"@E 999.99")
		@ Li+4,090 PSAY Transform(00000,"@E 999.99")
		@ Li+6,001 PSAY 'TOTAL.................:'
		@ Li+6,033 PSAY Transform(mQtdet+mQtNFat,"@E 99,999,999")
		@ Li+6,044 PSAY Transform(mValort+mVlNFat,"@E 9,999,999,999.99")
		@ Li+6,068 PSAY Transform((mPgtot/mValort)*100,"@E 999.99")
		@ Li+6,077 PSAY Transform((mEmabertot/mValort)*100,"@E 999.99")
		@ Li+6,090 PSAY Transform((mVencidot/mValort)*100,"@E 999.99")
		@ Li+6,102 PSAY Transform((mCanct/mValort)*100,"@E 999.99")
		@ Li+6,116 PSAY Transform((mInadimplt/mValort)*100,"@E 999.99")
	EndIf
End
// Termino do Relatorio
SET DEVICE TO SCREEN
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF
MS_FLUSH()
Return
                          





//****************************************************************************
// Function Transfolha()
//****************************************************************************
Static Function TRANSFOLHA()     
// Primeira leitura - contagem dos registros e gravacao do cabecalho
Contador := 1     

dbselectarea(cArq)
cIndex := CriaTrab(Nil,.F.)
cKey   := "Dupl+Item"
Indregua(cArq,cIndex,ckey,,,"Indexando por DUPL")

dbgotop()
While !Eof()        
   If serie == "UNI" .or. serie=="1  " .or. serie=="8  "
   else
      dbskip()
      Loop
   Endif

   If PEDIDO == mPedido1
      dbskip()
      Loop
   Endif
   mPedido  := PEDIDO
   contador := contador + 1
   mPedido1 := mPedido

	dbselectarea(cArq)
	dbskip()
End

Li := 0
@ Li,001 PSAY "EXPRESSA"
@ Li,009 PSAY "000100"
@ Li,015 PSAY "2"
@ Li,016 PSAY "LIVROS"
@ Li,051 PSAY Transform(contador,"@E 999999")
@ Li,057 PSAY SPACE(8)
@ Li,065 PSAY SPACE(6)
@ Li,071 PSAY "<<V003>>"                

// Segunda leitura - gravacao dos registros

dbselectarea(cArq)
dbgotop()
While !Eof()        

   If serie == "UNI" .or. serie == "1  " .or. serie == "8  "
   else
      dbskip()
      Loop
   Endif

   If PEDIDO == mPedido1
      dbskip()
      Loop
   Endif

    mPedido  := PEDIDO
	mNota    := DUPL 
	mProduto := PRODUTO
	mDescr   := DESCR
	mMun     := Mun
	mUf      := UF
	mValor   := Valorfat   
	mQtde    := Qtdeven
	mNome    := Nome
	mFone    := Fone
	mCodcli  := Codcli
	dbselectarea("SA1")
	dbsetorder(1)	
	If DbSeek(xFilial("SA1")+mCodcli)
		mCep     := SA1->A1_CEP
		mEnd     := SA1->A1_END
		mBairro  := SA1->A1_BAIRRO
		mPais    := SA1->A1_PAIS
	else
		mCep     := ""
		mBairro  := ""
		mPais    := ""
	Endif

Li := Li+1
//@ Li,000 PSAY mPedido + mItem 
@ Li,000 PSAY mNota
@ Li,010 PSAY mNome
@ Li,060 PSAY SPACE(50)
@ Li,110 PSAY SPACE(3)
@ Li,113 PSAY mEnd
@ Li,163 PSAY SPACE(6)
@ Li,169 PSAY SPACE(30)
@ Li,199 PSAY mBairro
@ Li,229 PSAY SUBSTR(mCep,1,5) + "-" + SUBSTR(mCep,6,3)
@ Li,238 PSAY mMun
@ Li,268 PSAY mUf
@ Li,270 PSAY SPACE(30)
@ Li,300 PSAY SPACE(30)
@ Li,330 PSAY SPACE(3)
@ Li,333 PSAY SPACE(8)
@ Li,341 PSAY SPACE(6)
@ Li,347 PSAY SPACE(20)
@ Li,367 PSAY SUBSTR(mDescr,1,30)
@ Li,397 PSAY SUBSTR(mProduto,1,10)
@ Li,407 PSAY SPACE(20)

mPedido1 := mPedido

	dbselectarea(cArq)
	dbskip()
End

SET DEVICE TO SCREEN
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF
MS_FLUSH()
Return






//****************************************************************************
// Funcion GravaMtr()
//****************************************************************************
Static Function GRAVAMTR()
dbselectarea(cArq)
dbgotop()
While !Eof()    
   If serie == "UNI" .or. serie == "1  " .or. serie == "8  "
   else
      dbskip()
      Loop
   Endif

   If substr(produto,1,2) <> "02"
      dbskip()
      Loop
   Endif

	mNota    := DUPL
	mMun     := Mun
	mUf      := UF
	mValor   := Valorfat   
	mQtde    := Qtdeven
	mNome    := Nome
	mFone    := Fone
	mCodcli  := Codcli
	dbselectarea("SA1")
	dbsetorder(1)	
	If DbSeek(xFilial("SA1")+mCodcli)
		mCep     := SA1->A1_CEP
		mEnd     := SA1->A1_END
		mBairro  := SA1->A1_BAIRRO
		mPais    := SA1->A1_PAIS
	else
		mCep     := ""
		mBairro  := ""
		mPais    := ""
	Endif
	
	dbselectarea(cArq1)
	If DbSeek(mNota)
		dbselectarea(cArq)
		dbskip()
		loop
	Endif
	
	DbSelectArea(cArq1)
	RecLock(cArq1,.T.)
	
	Codawb    := ""
	Awbref    := ""
	Codcep    := mCep
	Codprod   := ""
	Valorawb  := mValor
	Pesoawb   := 0
	Largawb   := 0
	Altuawb   := 0
	Profawb   := 0
	Qtde      := mQtde
	Endlog    := mEnd
	Endbai    := mBairro
	Destina   := mNome
	Telefone  := mFone
	Endtpo    := ""
	Endnum    := ""
	Endcom    := ""
	Cidade    := mMun
	Estado    := mUF
	Vlrfrete  := 0
	Qtdfitas2 := 0
	Retirada  := ""
	Vlragente := 0
	DDD       := ""
	Pais      := mPais
	CPF       := ""
	DDD1      := ""
	Telefone1 := ""
	Nf        := mNota
	
	MsUnlock()
	dbselectarea(cArq)
	dbskip()
End
Return





//****************************************************************************
//Function Gold()
//****************************************************************************
Static Function Gold()
contDoc := 0
ContIgual := 0       
Private GPedido := space(6)

dbselectarea(cArq)
cIndex := CriaTrab(Nil,.F.)
cKey   := "Dupl+Item"
Indregua(cArq,cIndex,ckey,,,"Indexando por DUPL")

dbgotop()
procregua(reccount())
while !eof()
	//dados do documento
	incproc("Nota: "+DUPL)
    dbselectarea(cArq)                  
	mNulo := 0
	mCodEmp := CGC
	mNomeEmp := NOME
	mEndEmp := mEnd
	mBairroEmp := mBairro
	mMunEmp := MUN
	mUFEmp:= UF
	mCepEmp:= mCEP
	mInscrEmp:= mInscr
	mTipoDoc := "NFF  " //???
	mNumDoc := DUPL //"10,214"
	mCodMatriz := mcodDeposit
	mDTFat := DTFAT       
	mSerie := SERIE
	mCodcli  := Codcli 
	mCODPROD := PRODUTO
	MQTD := QTDeVEN
	mNatOperac := CF
	mVALUNIT := PRCVEN              
	GPedido := Pedido
	mNumExt := NUMEXT
	
	//Somente as notas da serie UNI
	IF mSerie == "UNI" .or. serie == "1  " .or. serie == "8  "
	else
		dbselectarea(cArq)
		dbskip()
		Loop
	EndIF

	//CABECALHO DA NF SAIDA
	DbSelectArea("SF2")
	DbSetOrder(1)
	IF DbSeek(xFilial("SF2")+mNumDoc+mSerie)
		mValTotDoc := SF2->F2_VALFAT
		mValTotProd := SF2->F2_VALMERC
	ELSE 
		mValTotDoc := 0
		mValTotProd := 0
	ENDIF
	
	dbselectarea("SA1")
	DbSetOrder(1)
	If DbSeek(xFilial("SA1")+mCodcli)
		mCepEmp     := SA1->A1_CEP
		mEndEmp     := ""
		mBairroEmp  := SA1->A1_BAIRRO
		mINSCREmp 	:= SA1->A1_INSCR   
		mTipoLogr   := SA1->A1_TPLOG
		mLogr       := SA1->A1_LOGR
		mNumLogr    := SA1->A1_NLOGR
		mCompLogr   := SA1->A1_COMPL
		
		//codemp qdo cgc em branco
		if ALLTRIM(SA1->A1_CGC)=""
			mCodEmp := SA1->A1_COD
		endif
	else
		mCepEmp     := ""
		mBairroEmp  := ""
		mTipoLogr   := ""
		mLogr       := ""
		mNumLogr    := ""
		mCompLogr   := ""
	Endif
    
    
	DBSelectArea("GOLD")           
	DbGoTop()
	DbSeek(mNumDoc)
	If Found()
		contIgual++    
	Else
		ContDoc++
		RECLOCK("GOLD",.T.)  //INSERIR .T.
			GOLD->TipoReg := "03"  
			GOLD->CodDeposit := mcodDeposit
			GOLD->CodEmp := mCodEmp
			GOLD->CGCEmp := mCodEmp
			GOLD->NomeEmp := mNOMEEmp
			GOLD->EndEmp := ""
			GOLD->BairroEmp := mBairroEmp
			GOLD->MunEmp := mMUNEMP
			GOLD->UFEmp:= mUFEMP
			GOLD->CepEmp:= mCEPEmp
			GOLD->InscrEmp:= mInscrEmp
			GOLD->TipoDoc := mTipoDoc
			GOLD->SERIEDOC := mSerie		
			GOLD->NumDoc := mNumDoc //"10,214"
			GOLD->CodMatriz := mcodDeposit
			GOLD->CodEstab := StrZero(1,10)
			GOLD->NatOperac := mNatOperac
			GOLD->Conhec := space(10)
			GOLD->DtEmis := DataGold(mDTFat)
			GOLD->ValTotDoc := Fnumero(mValTotDoc)
			GOLD->ValTotProd := Fnumero(mValTotProd)
			GOLD->ValIcms := StrZero(mnulo,20)
			GOLD->ValIcmsSub := Strzero(mnulo,20)
			GOLD->ValIpi := Strzero(mnulo,20)
			GOLD->ValFrete := Strzero(mnulo,20)
			GOLD->BIcms := Strzero(mnulo,20)
			GOLD->BIcmsSub := Strzero(mnulo,20)
			GOLD->BIpi := Strzero(mnulo,20)
			GOLD->ValSeg := Strzero(mnulo,20)
			GOLD->ValDesc := Strzero(mnulo,20)
			GOLD->ValAcresc := Strzero(mnulo,20)
			GOLD->TipoLogr   := mTipoLogr
			GOLD->Logr       := mLogr
			GOLD->NumLogr    := mNumLogr
			GOLD->CompLogr   := mCompLogr
			GOLD->Pedido     := GPedido
			GOLD->NUMEXT     := mNumExt
		MSUNLOCK("GOLD")	
	Endif
	
	//itens do documento
	DBSelectArea("GOLDI")           
	RECLOCK("GOLDI",.T.)  //INSERIR .T.
		GOLDI->TipoReg := "04"  
		GOLDI->CodEmp := mCodEmp
		GOLDI->TipoDoc := mTipoDoc
		GOLDI->Serie := mSerie //"5,23"
		GOLDI->NumDoc := mNUmDOC
		GOLDI->CodMatriz := mcodDeposit
		GOLDI->CodProd := mCODPROD
		GOLDI->Qtd := Fnumero(mQTD)
		GOLDI->TipoUc := "UN"
		GOLDI->FatTpUC := Fnumero(1)//space(20)
 		GOLDI->AlICms := Strzero(mnulo,20)//space(20)
		GOLDI->AlIpi := Strzero(mnulo,20)//space(20)
		GOLDI->ValUnit := Fnumero(MVALUNIT)
		GOLDI->AlIcmsSub := Strzero(mnulo,20)//space(20)
		GOLDI->TpLog := Strzero(mnulo,10,0)//space(10)
	MSUNLOCK("GOLDI")	
	dbselectarea(cArq)
	dbskip()
End

SET DEVICE TO SCREEN
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool("Gold_doc")
ENDIF
MS_FLUSH()
Return


//****************************************************************************
//converterData
//****************************************************************************
static Function DataGold(data_old)             //12345678
setprvt("data_new") 
Data_old := DtoS(data_old)				//       20030131
data_new := substr(data_old,7,2)+""+substr(data_old,5,2)+""+substr(data_old,1,4)
return data_new
	
	
//****************************************************************************
//converter numero em character 20,4
//****************************************************************************
static Function FNumero(num)             //12345678
setprvt("numero_new") 
	numero_new := StrZero(num,20,4)
	numero_new := "0"+substr(numero_new,1,15)+substr(numero_new,17,4)
return numero_new

//****************************************************************************
// Function ValidPerg()
//****************************************************************************
Static Function _ValidPerg()

_sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

aAdd(aRegs,{cPerg,"01","Do Produdo      ","Do Produdo      ","Do Produdo      ","mv_par01","C",015,0,2,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","","",""})
aAdd(aRegs,{cPerg,"02","Ate Produdo     ","Ate Produdo     ","Ate Produdo     ","mv_par02","C",015,0,2,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","","",""})
aAdd(aRegs,{cPerg,"03","Faturados de    ","Faturados de    ","Faturados de    ","mv_par03","D",08,0,2,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Faturados ate   ","Faturados ate   ","Faturados ate   ","mv_par04","D",08,0,2,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Do Vendedor     ","Do Vendedor     ","Do Vendedor     ","mv_par05","C",06,0,2,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","SA3","","","",""})
aAdd(aRegs,{cPerg,"06","Ate Vendedor    ","Ate Vendedor    ","Ate Vendedor    ","mv_par06","C",06,0,2,"G","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","","SA3","","","",""})
aAdd(aRegs,{cPerg,"07","Tipo do pedido  ","Tipo do pedido  ","Tipo do pedido  ","mv_par07","C",01,0,2,"C","","MV_PAR07","Pagos","Pagos","Pagos","","","Cortesias","Cortesias","Cortesias","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","Da Regiao       ","Da Regiao       ","Da Regiao       ","mv_par08","C",03,0,2,"G","","MV_PAR08","","","","","","","","","","","","","","","","","","","","","","","","","ZZ9","","","",""})
aAdd(aRegs,{cPerg,"09","Ate Regiao      ","Ate Regiao      ","Ate Regiao      ","mv_par09","C",03,0,2,"G","","MV_PAR09","","","","","","","","","","","","","","","","","","","","","","","","","ZZ9","","","",""})
aAdd(aRegs,{cPerg,"10","Tipo de saida   ","Tipo de saida   ","Tipo de saida   ","mv_par10","C",01,0,2,"C","","MV_PAR10","Pagos","Pagos","Pagos","","","Cortesias","Cortesias","Cortesias","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"11","Da Promocao     ","Da Promocao     ","Da Promocao     ","mv_par11","C",03,0,2,"G","","MV_PAR11","","","","","","","","","","","","","","","","","","","","","","","","","SZA","","","",""})
aAdd(aRegs,{cPerg,"12","Ate Promocao    ","Ate Promocao    ","Ate Promocao    ","mv_par12","C",03,0,2,"G","","MV_PAR12","","","","","","","","","","","","","","","","","","","","","","","","","SZA","","","",""})
aAdd(aRegs,{cPerg,"13","Divisao de Vendas","Divisao de Vendas","Divisao de Vendas","mv_par13","C",01,0,2,"C","","MV_PAR13","Mercantil","Mercantil","Mercantil","","","Publicidade","Publicidade","Publicidade","","","Software","Software","Software","","","Todos","Todos","Todos","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"14","Tipo Faturamento","Tipo Faturamento","Tipo Faturamento","mv_par14","C",01,0,2,"C","","MV_PAR14","Normal","Normal","Normal","","","Edicao","Edicao","Edicao","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"15","Circulacao de   ","Circulacao de   ","Circulacao de   ","mv_par15","D",08,0,2,"G","","MV_PAR15","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"16","Circulacao ate  ","Circulacao ate  ","Circulacao ate  ","mv_par16","D",08,0,2,"G","","MV_PAR16","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

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