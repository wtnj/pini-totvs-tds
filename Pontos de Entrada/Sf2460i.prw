#include "rwmake.ch"
/*
Alterado por Danilo C S Pala em 20110701: considerar apenas titulos do contas a receber das parcelas e nao tributos e1_tipo='NF'
Alterado por Danilo C S Pala em 20120820: Comentar alteracao de e1_comis1 =1 (Cidinha)
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ SF2460I  ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ Out/98   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava impressora fiscal utilizada  (DOS/WINDOWS)           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Atualiza Contas a Receber, Pedidos, N.F. Itens e Cabecalho,³±±
±±³          ³ Livros Fiscais e Faturamento Especial de A.V.              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Sf2460i()
Local cSerie := SF2->F2_SERIE
SetPrvt("_APOSARQ,_NVEZ,CNUMPDV,_NVALORFATURADO,_NPARCELA,_NTOTDESC")
SetPrvt("_LERRO,_CMSG,_LFECHA,_NTOTALNOTA,")
Private aArea, aAreaSC5, aAreaSC6, aAreaSD2, aAreaSF2, aAreaSE1, nBaseIcms, nValIcms
// **********************************************************************
// *****************        Gilberto    *********************************
// *  TOMAR O MAXIMO DE CUIDADO POSSIVEL QUANDO ALTERAR ESTE PROGRAMA;  *
// *  SOLICITAR A SRA.CIDINHA QUE TESTE O FATURAMENTO APOS SUAS MODIFI- *
// *  CACOES, POIS DEPOIS FICAMOS OUVINDO UM MONTE DOS USUARIOS.        *
// *  OBRIGADO !!!       ROGER.                                         *
// **********************************************************************
// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Salva o Alias Corrente              ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Numero do PDV que efetuou a venda
// Obs.: as linhas abaixo sao linhas padrao do ponto de entrada quando da
// utilizacao de impressora fiscal.
aArea := GetArea()

If Alltrim(cSerie) == Alltrim(GETMV("MV_SERCUP"))
	If SF2->(FieldPos(F2_PDV)) > 0
		cNumPdv:= CallMp20Fi("|35|14|")
		Reclock("SF2",.F.)
		SF2->F2_PDV := cNumPdv
		msUnlock()
	EndIf
EndIf
// fim do bloco para impressora fiscal.

nBaseIcms := 0
nValIcms  := 0

dbSelectArea("SD2")
aAreaSD2 := GetArea()
dbSetOrder(3)
dbSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE)
While !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .and. SF2->F2_DOC+SF2->F2_SERIE == SD2->D2_DOC+SD2->D2_SERIE
    If SD2->D2_ALIQISS == 0 // Soma somente ICMS
    	nBaseIcms += SD2->D2_BASEICM
		nValIcms += SD2->D2_VALICM
	EndIf
	dbselectarea("SD2")
	dbSkip()
End
RestArea(aAreaSD2)

DbSelectArea("SF2")
RecLock("SF2",.f.)
SF2->F2_BASEICM := nBaseIcms
SF2->F2_VALICM  := nValIcms
MsUnlock()

dbSelectArea("SC5")
aAreaSC5 := GetArea()
DbSetOrder(1)
If dbSeek(xFilial("SC5")+SD2->D2_PEDIDO)
	RecLock("SC5",.F.)
	SC5->C5_NOTA    := SF2->F2_DOC
	SC5->C5_SERIE   := SF2->F2_SERIE
	MsUnlock()
Endif

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Atualiza o Contas a Receber com a Divisao de Vendas ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectarea("SE1")
aAreaSE1 := GetArea()
dbSetOrder(1)
dbSeek(xFilial("SE1")+SF2->F2_PREFIXO+SF2->F2_DOC)
While !eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. Alltrim(SF2->F2_DOC) == Alltrim(SE1->E1_NUM)
	IF SF2->F2_CLIENTE + SF2->F2_LOJA == SE1->E1_CLIENTE + SE1->E1_LOJA
		RecLock("SE1",.F.)
		SE1->E1_DIVVEN := SC5->C5_DIVVEN
		msunlock()
	Endif
	DbSelectArea("SE1")
	DbSkip()
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Somente p/ a empresa Editora ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !SM0->M0_CODIGO $ "01/03"
	RestArea(aAreaSE1)
	RestArea(aAreaSC5)
	RestArea(aAreaSD2)
	RestArea(aArea)
	Return
Endif

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Variaveis utilizadas        ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_nValorFaturado := 0 // Soma os valores da av especial
_nParcela       := 0 // Numero de Itens da Nota Fiscal
_nTotDesc       := 0

IF SC5->C5_AVESP == "S" // Somente AV Especial
	dbSelectArea("SZV")
	dbSetOrder(1)
	// Inclusao em 09/11/00 por Roger Cangianeli, para evitar a geracao
	// de notas fiscais com valor zerado, conforme solicitacao da Sra.Cidinha.
	_lErro := .F.
	If !dbSeek(xFilial("SZV")+SD2->D2_PEDIDO, .F.)
		_cMsg := "Nao foram encontrados registros referentes ao faturamento "
		_cMsg := _cMsg + "especial (SZ5), e o pedido de venda esta cadastrado "
		_cMsg := _cMsg + "como especial. A nota fiscal sera gerada com valor "
		_cMsg := _cMsg + "zerado, devendo ser excluida, corrigida e refaturada. "
		_cMsg := _cMsg + "Qualquer problema, solicite auxilio da Informatica."
		MsgStop(_cMsg, "Dados Inconsistentes")
		_lErro := .T.
	EndIf
	
	While !eof() .and. SD2->D2_FILIAL == xFilial("SD2") .AND. Alltrim(SD2->D2_PEDIDO) == Alltrim(SZV->ZV_NUMAV)
		If Alltrim(SZV->ZV_NFISCAL) == Alltrim(SF2->F2_DOC)
			_nValorFaturado := _nValorFaturado + SZV->ZV_VALOR
		Endif
		DbSelectArea("SZV")
		dbSkip()
	End
	
	dbSelectArea("SD2")
	While !eof() .and. Sd2->D2_FILIAL == xFilial("SD2") .and. SF2->F2_DOC+SF2->F2_SERIE == SD2->D2_DOC+SD2->D2_SERIE
		_nParcela   := _nParcela + 1
		_nTotDesc   := _nTotDesc + SD2->D2_DESCON       // By RC 07/02/00
		
		dbSelectArea("SC6")
		DbSetOrder(1)
		dbseek(xfiliaL("SC6")+SD2->D2_PEDIDO+SD2->D2_ITEMPV)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Posiciona os Arquivos SC6 E SC6                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		dbSelectArea("SC5")
		DBSetOrder(1)
		dbSeek(xFilial("SC5")+SD2->D2_PEDIDO)
		
		dbSelectArea("SZV")
		dbSetOrder(1)
		dbSeek(xFilial("SZV")+SD2->D2_PEDIDO)
		
		_lfecha:=.T.
		While !eof() .and. SZV->ZV_FILIAL == xFilial("SZV") .AND. Alltrim(SD2->D2_PEDIDO) == Alltrim(SZV->ZV_NUMAV)
			If EMPTY(SZV->ZV_NFISCAL)
				_lfecha:=.F.
			Endif
			DbSelectArea("SZV")
			dbskip()
		End
		
		If _lfecha
			DbSelectArea("SC6")
			Reclock("SC6",.F.)
			SC6->C6_NOTA  :=SF2->F2_DOC
			SC6->C6_SERIE :=SF2->F2_SERIE
			SC6->C6_DATFAT:=SF2->F2_EMISSAO
			SC6->C6_QTDENT:=SC6->C6_QTDVEN
			msUnlock()
		Endif
		
		dbselectarea("SD2")
		dbSkip()
	End
	
	// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	// ³Calcula o Valor da Av's Especiais      ³
	// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	_nValorFaturado := _nValorFaturado - _nTotDesc  // By RC - 07/02/00
	_nTotalNota     := 0
	
	dbSelectArea("SD2")
	DbSetOrder(3)
	dbSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE)
	While !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .and. SF2->F2_DOC+SF2->F2_SERIE == SD2->D2_DOC+SD2->D2_SERIE
		RecLock("SD2",.F.)
		SD2->D2_PRCVEN := _nValorFaturado / SD2->D2_QUANT /_nParcela
		SD2->D2_TOTAL  := SD2->D2_PRCVEN * SD2->D2_QUANT
		SD2->D2_PRUNIT := SD2->D2_PRCVEN
		_nTotalNota := _nTotalNota + SD2->D2_TOTAL
		msUnlock()
		
		dbselectarea("SD2")
		dbSkip()
	End
	
	dbSelectArea("SF2")
	RecLock("SF2",.F.)
	SF2->F2_ValBrut := _nTotalNota
	SF2->F2_ValMerc := _nTotalNota
	SF2->F2_ValFat  := _nTotalNota
	SF2->F2_DESCONT := _ntotdesc
	msUnlock()
	
	// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	// ³Atualizacao do contas a Receber       ³
	// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	_nParcela := 0
	
	dbSelectarea("SE1")
	dbSetOrder(1)
	dbSeek(xFilial("SE1")+SF2->F2_PREFIXO+SF2->F2_DOC)
	While !eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. Alltrim(SF2->F2_DOC)==Alltrim(SE1->E1_NUM)
		IF SF2->F2_CLIENTE + SF2->F2_LOJA == SE1->E1_CLIENTE + SE1->E1_LOJA .and. ALLTRIM(SE1->E1_TIPO) =="NF" //20110701
			_nParcela := _nParcela + 1
		Endif
		DbSelectArea("SE1")
		dbSkip()
	End
	
	dbSeek(xFilial("SE1")+SF2->F2_PREFIXO+SF2->F2_DOC)
	While !eof() .and. SE1->E1_FILIAL == xFilial("SE1").and. Alltrim(SF2->F2_DOC)==Alltrim(SE1->E1_NUM)
		IF SE1->E1_CLIENTE + SE1->E1_LOJA == SF2->F2_CLIENTE+SF2->F2_LOJA .and. ALLTRIM(SE1->E1_TIPO) =="NF" //20110701
			RecLock("SE1",.F.)
			SE1->E1_VALOR   :=  _nTotalNota / _nParcela
			SE1->E1_SALDO   :=  _nTotalNota / _nParcela
			SE1->E1_VLCRUZ  :=  _nTotalNota / _nParcela
			SE1->E1_BASCOM1 :=  _nTotalNota / _nParcela
			//SE1->E1_COMIS1  :=  1 //20120820
			SE1->E1_FATPREF :=  SC5->C5_TPTRANS
			msUnlock()
		Endif
		DbSelectArea("SE1")
		dbSkip()
	End
	
	// Inclusao em 09/11/00 por Roger Cangianeli, para evitar a geracao
	// de notas fiscais com valor zerado, conforme solicitacao da Sra.Cidinha.
	If _nTotalNota == 0 .and. !_lErro
		_cMsg := "A nota fiscal foi gerada com valor zerado, favor corrigir e "
		_cMsg := _cMsg + "refazer o processo."
		_cMsg := _cMsg + "Qualquer problema, solicite auxilio da Informatica."
		MsgStop(_cMsg, "Dados Inconsistentes")
	EndIf
	
Endif // Av Especial

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//Ã Recalcular o contas a receber p/ este tipo de transacao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If SC5->C5_DIVVEN == "PUBL" .AND. SC5->C5_TPTRANS $ "04/09" .and. ;
	SC5->C5_AVESP == "N" // Somente AV Normal
	_nParcela         := 0
	_nValorFaturado   := 0
	_nTotDesc         := 0
	
	// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	// ³Conta quantas parcela ha no C.Receber ³
	// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectarea("SE1")
	dbSetOrder(1)
	dbSeek(xFilial("SE1")+SF2->F2_PREFIXO+SF2->F2_DOC)
	While !eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. Alltrim(SF2->F2_DOC)==Alltrim(SE1->E1_NUM)
		If SF2->F2_CLIENTE + SF2->F2_LOJA == SE1->E1_CLIENTE + SE1->E1_LOJA .and. ALLTRIM(SE1->E1_TIPO) =="NF" //20110701
			_nParcela := _nParcela + 1
		Endif
		DbSelectArea("SE1")
		dbSkip()
	End
	
	// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	// ³Totaliza o Valor da Nota              ³
	// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SD2")
	dbSetOrder(3)
	dbSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE)
	While !eof() .and. SF2->F2_DOC+SF2->F2_SERIE == SD2->D2_DOC+SD2->D2_SERIE
		_nValorFaturado := _nValorFaturado + SD2->D2_TOTAL
		_nTotdesc       := _ntotdesc + sd2->d2_descon
		dbSkip()
	End
	
	RecLock("SF2",.F.)
	SF2->F2_VALBRUT := _nValorFaturado
	SF2->F2_VALMERC := _nValorFaturado
	SF2->F2_VALFAT  := _nValorFaturado
	SF2->F2_DESCONT := _ntotdesc
	msUnlock()
	
	dbSelectArea("SE1")
	DbSetOrder(1)
	dbSeek(xFilial("SE1")+SF2->F2_PREFIXO+SF2->F2_DOC)
	While !eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. Alltrim(SF2->F2_DOC)==Alltrim(SE1->E1_NUM) .and. _nParcela <> 0
		If SE1->E1_CLIENTE+SE1->E1_LOJA == SF2->F2_CLIENTE+SF2->F2_LOJA .and. ALLTRIM(SE1->E1_TIPO) =="NF" //20110701
			RecLock("SE1",.F.)
			SE1->E1_VALOR   := _nValorFaturado / _nParcela
			SE1->E1_SALDO   := _nValorFaturado / _nParcela
			SE1->E1_VLCRUZ  := _nValorFaturado / _nParcela
			SE1->E1_BASCOM1 := _nValorFaturado / _nParcela
			//SE1->E1_COMIS1  := 1 //20120820
			
			//  SE1->E1_BASCOM2 := _nValorFaturado / _nParcela
			//  SE1->E1_BASCOM3 := _nValorFaturado / _nParcela
			//  SE1->E1_BASCOM4 := _nValorFaturado / _nParcela
			
			SE1->E1_FATPREF :=  SC5->C5_TPTRANS
			msUnlock()
		endif
		DbSelectArea("SE1")
		dbSkip()
	End
	
	DbselectArea("SF3")
	If SF3->F3_NFISCAL == SF2->F2_DOC
		RecLock("SF3",.F.)
		SF3->F3_VALCONT := SF2->F2_VALMERC
		IF SF3->F3_ISENICM <> 0
			SF3->F3_ISENICM := SF2->F2_VALMERC
		EndIf
		IF SF3->F3_OUTRICM <> 0
			SF3->F3_OUTRICM := SF2->F2_VALMERC
		EndIf
		IF SF3->F3_ISENIPI <> 0
			SF3->F3_ISENIPI := SF2->F2_VALMERC
		EndIf
		IF SF3->F3_OUTRIPI <> 0
			SF3->F3_OUTRIPI := SF2->F2_VALMERC
		EndIf
		msUnlock()
	EndIf
	
	// Inclusao em 09/11/00 por Roger Cangianeli, para evitar a geracao
	// de notas fiscais com valor zerado, conforme solicitacao da Sra.Cidinha.
	If _nValorFaturado == 0
		_cMsg := "A nota fiscal foi gerada com valor zerado, favor corrigir e "
		_cMsg := _cMsg + "refazer o processo."
		_cMsg := _cMsg + "Qualquer problema, solicite auxilio da Informatica."
		MsgStop(_cMsg, "Dados Inconsistentes")
	EndIf
	
Endif

dbSelectarea("SC6")
DbSetOrder(1)
dbseek(xFilial("SC6")+SC5->C5_NUM)
_lfecha:=.T.
While !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. Alltrim(SC5->C5_NUM)==Alltrim(SC6->C6_NUM) .AND. SC5->C5_AVESP=='S'
	If Empty(SC6->C6_NOTA)
		_lfecha:=.F.
	endif
	DbSelectArea("SC6")
	dbSkip()
End

If _lfecha .and. SC5->C5_AVESP=='S'
	DbSelectArea("SC5")
	Reclock("SC5",.F.)
	SC5->C5_NOTA:=SF2->F2_DOC
	msUnlock()
EndIf

RestArea(aAreaSE1)
RestArea(aAreaSC5)
RestArea(aAreaSD2)
RestArea(aArea)

Return