#include "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT167   ³Autor:DANILO C S PALA         ³ Data:   20060811 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: PFAT146: RECEBIMENTOS POR PRODUTO                          ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function Pfat167()

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
Private MCONDPGTO ,MVALORPED  ,MDTPED    ,MDIVVEN    ,MCLIENTE
Private MEQUIPE   ,MREGIAO   ,MVALOR     ,MPAGOIT   ,MVENCIDIT  ,MCANCIT
Private MLPIT     ,MINADIMIT ,MDESCONTIT ,MABERTOIT ,MUF        ,MMUN
Private _ACAMPOS  ,_CNOME    ,CINDEX     ,CKEY      ,_SALIAS    ,AREGS
Private I         ,J         ,MVENCREAL	 ,MVLPROD
Private MEDICAO, mtelefone, mCGC, mEndereco, mCEP, mBairro, mSituaca
PRIVATE MDESPREM, MDESPBOL

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ mv_par01 Vencimento de:                                                 ³
//³ mv_par02 Vencimento at‚:                                                ³
//³ mv_par03 Baixado   Em Aberto    Ambos                                   ³
//³ mv_par04 PRODUTO 		                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Programa  := "PFAT167"
MHORA     := TIME()
cArq      := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
wnrel     := SUBS(CUSUARIO,7,6)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
nLastKey  := 00
L         := 00
nOrdem    := 00
m_pag     := 01
nCaracter := 10
tamanho   := "M"
cCabec1   := ""
cCabec2   := ""
lContinua := .T.
cArqPath  := GetMv("MV_PATHTMP")
_cString  := cArqPath+cString+".DBF"
mEmpresa  := SM0->M0_CODIGO
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso nao exista, cria grupo de perguntas.                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:="PFT167"

If !Pergunte(cPerg)
	Return
Endif

IF Lastkey()==27
	Return
Endif

mConta1 := 0
mConta2 := 0
mConta3 := 0

FArqTrab()

Filtra()

lEnd:= .F.
bBloco:= {|lEnd| PRODUTOS(@lEnd)}
Processa( bBloco, "Aguarde" ,"Processando...", .T. )

cMsg:= "Arquivo Gerado com Sucesso em: "+_cString

DbSelectArea(cArq)
dbGoTop()
COPY TO &_cString VIA "DBFCDXADS" // 20121106 
MSGINFO(cMsg)

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
                                          
//MsgAlert("Considerado intervalo de datas pela data de emissao.")
cQuerySE1 += "SELECT * FROM " + RetSqlName("SE1") + " SE1"
cQuerySE1 += " WHERE SE1.E1_FILIAL = '" + xFilial("SE1") + "'"
cQuerySE1 += " AND SE1.E1_VENCTO BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "'"
//cQuerySE1 += " AND SE1.E1_EMISSAO BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "'"
cQuerySE1 += " AND SE1.D_E_L_E_T_ <> '*' "
cQuerySE1 += " ORDER BY SE1.E1_FILIAL, SE1.E1_VENCTO"

lEnd := .f.

If Select("TRB") <> 0
	DbselectArea("TRB")
	DbCloseArea()
EndIf	

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuerySE1), "TRB", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")

TcSetField("TRB","E1_VENCTO"  ,"D")
TcSetField("TRB","E1_BAIXA"   ,"D")
TcSetField("TRB","E1_EMISSAO" ,"D")
TcSetField("TRB","E1_DTALT"   ,"D")
TcSetField("TRB","E1_VENCREA"   ,"D") //20040119

Dbgotop()

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ PRODUTOS()                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function PRODUTOS()

mConta := 0

DbSelectArea("TRB")
ProcRegua(LastRec())
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
	MCodCli    := ""
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
	mVencto    := TRB->E1_VENCTO
	mPortado   := TRB->E1_PORTADO
	mNatureza  := TRB->E1_NATUREZ                                                
	mVencReal  := TRB->E1_VENCREA  //20040119                        
	MSITUACA   := TRB->E1_SITUACA  //20060329
	mCGC	   := space(14)         
	MDESPREM   := 0  //20060526
	MDESPBOL   := 0  //20060526
	
	If DTOS(TRB->E1_DTALT)='       '
	   mDtAlt:=DTOS(TRB->E1_BAIXA)  
	Else
	   mDtAlt:= DTOS(TRB->E1_DTALT)
	Endif      
	
	If mDtAlt<DTOS(DDATABASE)
       mBaixa     := TRB->E1_BAIXA
	Else
	  mBaixa      :=stod("")
	Endif  
	
	mValor     := TRB->E1_VALOR
	mNomeVend  := "" 

	
	IncProc("Lendo Registros : "+StrZero(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
	
	If MV_PAR03 == 1 .and. DTOS(TRB->E1_BAIXA) == "        "
		DbSelectArea("TRB")
		DbSkip()
		Loop
	Endif
	
	If MV_PAR03 == 2 .and. DTOS(mBaixa) <> "       "
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
	DbSelectArea("TRB")   
  /*	if alltrim(TRB->E1_PORTADO) = "904"
		MsgAlert("Achou") // teste 20041027
	endif*/
	If DTOS(TRB->E1_BAIXA) <> "        " .And. TRB->E1_SALDO==0 .AND. !'LP'$(TRB->E1_MOTIVO);
		.AND. !'CAN'$(TRB->E1_MOTIVO) .AND. !'DEV'$(TRB->E1_MOTIVO) .AND. (!'920'$(TRB->E1_PORTADO) .and. !'930'$(TRB->E1_PORTADO) .and. !'904'$(TRB->E1_PORTADO)) ; 
		.AND. mDtalt<=DTOS(DDATABASE) //20041014
		mPago     := TRB->E1_VALOR - TRB->E1_DESPREM - TRB->E1_DESPBOL
		mDesconto := TRB->E1_DESCONT
	Else
		Do Case                                   
			Case DTOS(TRB->E1_VENCTO) < DTOS(DDATABASE-30) .AND. !Alltrim(TRB->E1_MOTIVO)$"CAN" .AND. !Alltrim(TRB->E1_PORTADO)$"920/CAN/930" //20041014
				mInadimpl := TRB->E1_VALOR - TRB->E1_DESPREM - TRB->E1_DESPBOL
			Case DTOS(TRB->E1_VENCTO) < DTOS(DDATABASE) .AND. !Alltrim(TRB->E1_MOTIVO)$"CAN/LP" .AND. !Alltrim(TRB->E1_PORTADO)$"920/CAN/995/930" //20041014
				mVencido  := TRB->E1_VALOR - TRB->E1_DESPREM - TRB->E1_DESPBOL
			Case Alltrim(TRB->E1_MOTIVO)$"CAN" .OR. alltrim(TRB->E1_PORTADO)$"920/CAN/930"
				mCanc     := TRB->E1_VALOR - TRB->E1_DESPREM - TRB->E1_DESPBOL
			Case Alltrim(TRB->E1_MOTIVO)=="LP" .or. Alltrim(TRB->E1_PORTADO)$"BLP/995" .or. Alltrim(TRB->E1_PORTADO) == "904" //20041027 ALTERADO E1_CODPORT PARA E1_PORTADO
				mLp       := TRB->E1_VALOR - TRB->E1_DESPREM - TRB->E1_DESPBOL
			OtherWise
				mAberto   := TRB->E1_VALOR - TRB->E1_DESPREM - TRB->E1_DESPBOL
		EndCase
	Endif 
	
	If Empty (mCodcli)
	   mCodcli:=SE1->E1_CLIENTE	
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

			If DbSeek(xFilial("SE4")+mCondpgto)
				mDescrop := SE4->E4_DESCRI
			Endif
		Endif     
	    	
		DbSelectArea("SD2")
		DbSetOrder(8)
		If DbSeek(xFilial("SD2")+mPedido)
			While !Eof() .and. xFilial("SD2") == SD2->D2_FILIAL .and. SD2->D2_PEDIDO == mPedido
				DbSelectArea(cArq)
				if TRIM(SD2->D2_COD) == TRIM(MV_PAR04)
					IF DTOS(SC5->C5_EMISSAO) < '20060609'  //20060526
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
					ELSE //20060526
						mValor  := TRB->E1_VALOR - TRB->E1_DESPREM - TRB->E1_DESPBOL
						mValtot  := SD2->D2_TOTAL
						mValFat  := SF2->F2_VALMERC
					ENDIF //20060526
				    	
					IF Alltrim(SD2->D2_SERIE) == Alltrim(mSerie) .AND. Alltrim(SD2->D2_DOC) == Alltrim(mNota)
						mProduto   := SD2->D2_COD
						mPagoIt    := (mValtot)*(mPago/mValFat)
						mVencidit  := (mValtot)*(mVencido/mValFat)
						mCancIt    := (mValtot)*(mCanc/mValFat)
						mLpIt      := (mValtot)*(mLp/mValFat)
						mInadimIt  := (mValtot)*(mInadimpl/mValFat)
						mDescontIt := (mValtot)*(mDesconto/mValFat)
						mAbertoIt  := (mValtot)*(mAberto/mValFat)  
//					  	MVLPROD	   := SD2->D2_PRCVEN //20040119 //20040805
					  	MVLPROD	   := (mpago / mValFat)  //20040805
						MDESPREM   := (TRB->E1_DESPREM) * (mValtot / MVALFAT)  //20060526
						MDESPBOL   := (TRB->E1_DESPBOL) * (mValtot / MVALFAT)  //20060526
						
						DbSelectArea("SZS") //20040120
						DbSetOrder(4)
						if DbSeek(xFilial("SZS")+SD2->D2_PEDIDO+SD2->D2_ITEMPV+mNota+mSerie, .T.)
							MEDICAO := SZS->ZS_EDICAO
						Else
							MEDICAO := 9999
						EndIf //20040120 ateh aki
						                
						GRAVA()
						IncProc("Lendo Registros : "+StrZero(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
						DbSelectArea("TRB")
					Endif
				endif // produto
				
				DbSelectArea("SD2")
				Dbskip()
			End
	
		Endif
	Else  
	  mPagoIt    := mPago
	  mVencidit  := mVencido
	  mCancIt    := mCanc
	  mLpIt      := mLp
	  mInadimIt  := mInadimpl
	  mDescontIt := mDesconto
	  mAbertoIt  := mAberto
	  GRAVA()	
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
mTelefone  := "" //20040329       
mEndereco  := "" //20050215
mBairro	   := "" //20050215
mCEP	   := "" //20050215

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

// Tratamento para Lucros e Perdas de Assinaturas - devem ser cancelados
If Alltrim(mTitulo)$"ASSINATURAS" .and. DTOS(TRB->E1_BAIXA) <> "        "
	If Alltrim(TRB->E1_MOTIVO) == "LP" .or. Alltrim(TRB->E1_PORTADO) $ "995/BLP" .and. mCancIt == 0
			mCancIt   := IIF(mVencidIt > 0, mVencidIt, IIF(mLpIt > 0,mLpIt,mInadimIt))
			mVencidIt := 0
			mLpIt     := 0
			mInadimIt := 0
	EndIf
EndIf

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
	mTelefone  := SA1->A1_TEL //20040329
	mCGC	   := SA1->A1_CGC  
	mEndereco  := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060327
	mBairro	   := SA1->A1_BAIRRO
	mCEP	   := SA1->A1_CEP
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

mConta1++

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
Replace DtAlt     With  STOD(mDtAlt)
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
Replace Telefone  With  mTelefone //20040329
Replace Vend      With  mVend
Replace Regiao    With  mRegiao
Replace Equipe    With  mEquipe
Replace DivVend   With  mDivVend
Replace Produto   With  mProduto
Replace Descr     With  mDescr
Replace Titulo    With  mTitulo
Replace Tipo      With  mTipo
Replace NomeVend  With  mNomeVend                  
Replace VENCREAL  With  MVENCREAL //20040119
Replace VLPROD    With  MVLPROD //20040119
Replace EDICAO    With  MEDICAO //20040119
//Replace EDFIN   With  MEDFIN //20040119
//Replace EDVENC  With  MEDVENC //20040119
//Replace EDSUSP  With  MedSUSP //20040119
Replace CGC	      With  mCGC
Replace COBEND	  With  mEndereco //20050215
Replace BAIRRO	  With  mBairro //20050215
Replace CEP	      With  mCep //20050215
Replace SITUACA	  With  MSITUACA  //20060329        
Replace DESPREM	  With  MDESPREM  //20060526
Replace DESPBOL	  With  MDESPBOL  //20060526


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
AADD(_aCampos,{"VENCREAL"   ,"D",8  ,0}) //20040119
AADD(_aCampos,{"NATUREZA"  ,"C",10 ,0})
AADD(_aCampos,{"DESCNAT"   ,"C",30 ,0})
AADD(_aCampos,{"DUPL"      ,"C",6  ,0})
AADD(_aCampos,{"PARCELA"   ,"C",1  ,0})
AADD(_aCampos,{"VLDUPL"    ,"N",12 ,2})
AADD(_aCampos,{"VLPROD"    ,"N",12 ,2}) //20040119
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
AADD(_aCampos,{"MUN"      ,"C",30 ,0})
AADD(_aCampos,{"UF"        ,"C",2  ,0})
// dados para mala direta da cobranca 20050215
AADD(_aCampos,{"COBEND"    ,"C",120 ,0})
AADD(_aCampos,{"BAIRRO"    ,"C",20 ,0})
AADD(_aCampos,{"CEP"    ,"C",9 ,0}) //ateh aki 20050215
AADD(_aCampos,{"ATIVIDA"   ,"C",40 ,0})    
AADD(_aCampos,{"TELEFONE"  ,"C",22 ,0})    //20040329
AADD(_aCampos,{"VEND"      ,"C",6  ,0})
AADD(_aCampos,{"NOMEVEND"  ,"C",15 ,0})
AADD(_aCampos,{"REGIAO"    ,"C",3  ,0})
AADD(_aCampos,{"EQUIPE"    ,"C",15 ,0})
AADD(_aCampos,{"DIVVEND"   ,"C",40 ,0})
AADD(_aCampos,{"PRODUTO"   ,"C",40 ,0})
AADD(_aCampos,{"DESCR"     ,"C",40 ,0})
AADD(_aCampos,{"TITULO"    ,"C",40 ,0})
AADD(_aCampos,{"EDICAO"  ,"N",4 ,0})//20040119
//AADD(_aCampos,{"EDFIN"  ,"N",4 ,0})//20040119
//AADD(_aCampos,{"EDVENC"  ,"N",4 ,0})//20040119
//AADD(_aCampos,{"EDSUSP"  ,"N",4 ,0})//20040119
AADD(_aCampos,{"INADIMPL"  ,"N",12 ,2})
AADD(_aCampos,{"FLUXO"     ,"N",12 ,2})
AADD(_aCampos,{"CGC"       ,"C",14 ,0})          
AADD(_aCampos,{"SITUACA"   ,"C",1 ,0})          //20060329
AADD(_aCampos,{"DESPREM"   ,"N",12 ,2})  //20060526
AADD(_aCampos,{"DESPBOL"   ,"N",12 ,2})  //20060526
_cNome := CriaTrab(_aCampos,.t.)

cIndex := CriaTrab(Nil,.F.)
cKey   := "Pedido+Dupl+Parcela"
dbUseArea(.T.,, _cNome,cArq,.F.,.F.)
dbSelectArea(cArq)

MsAguarde({|| Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")},"Aguarde","Gerando Indice Temporario (TRB)...")

Return