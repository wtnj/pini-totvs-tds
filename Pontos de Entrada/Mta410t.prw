#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02
/*/ alterado por Danilo C S Pala em 20040712
// danilo c s pala em 20051125: cruzar novos cronogramas
//Danilo C S Pala em 20090414: Guia da Construcao 0127
//Danilo C S Pala em 20100913: Guia da Construcao 0127
//Danilo C S Pala em 20120215: Liberar automaticamente lote da FEICON
//Danilo C S Pala em 20120405: cruzar novos cronogramas (Cida)
//Danilo C S Pala em 20130705: Liberar se não for publicidade, opção ao parametro sugere quantidade liberada 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: MTA410T   ³Autor: Fabio William          ³ Data:   07/07/97 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Atualiza  o arquivo SC9 com lote e data do lote            ³ ±±
±±³           Atualiza  o arquivo SC5 Liberado OK                        ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso     : M¢dulo de Faturamento                                       ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Release : Roger Cangianeli - Otimizacao/Conversao Windows.02/02/00.   ³ ±±
±±³          Tratamento alteracao de A.V.'s Faturadas. - RC. 02/05/00.   ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Mta410t()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

SetPrvt("_LLIBERADO,_CALIAS,_NINDEX,_NREG,_NINDSA1,_NREGSA1")
SetPrvt("_NINDSC6,_NREGSC6,_NINDSC9,_NREGSC9,_NINDSA3,_NREGSA3")
SetPrvt("_NINDSB1,_NREGSB1,_LFATUR,_LFATUR2,_CMSG,_NTOTALAV")
SetPrvt("_NRESTO,_NINS,_X,_LINCLUI,_NREVISTA,_CPRODUTO")
SetPrvt("_CTES,_CCF,")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se ha libera‡Æo gerada     ³
//³ se nao houver volta o Status do SC6 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_lLiberado := .F.

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Salva Posicao Alias                            ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()

dbSelectarea("SA1")
_nIndSa1 := IndexOrd()
_nRegSa1 := Recno()
dbSetOrder(1)
dbSeek(xfilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI)

dbSelectarea("SC6")
_nIndSc6 := IndexOrd()
_nRegSc6 := Recno()
dbSetOrder(1)

dbSelectArea("SC9")
_nIndSc9 := IndexOrd()
_nRegSc9 := Recno()
dbSetOrder(1)

dbSelectArea("SA3")
_nIndSA3 := IndexOrd()
_nRegSA3 := Recno()
dbSetOrder(1)
dbSeek(xFilial("SA3")+SC5->C5_VEND1)

dbSelectArea("SB1")
_nIndSB1 := IndexOrd()
_nRegSB1 := Recno()
dbSetOrder(1)

dbSelectarea("SC6")
dbSeek(xFilial("SC6")+SC5->C5_NUM)
/*While !EOF() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC5->C5_NUM == SC6->C6_NUM  .and. SC6->C6_TES # '602' .AND. SC5->C5_TIPO # 'D' //20040712
	dbSelectArea("SB1")
	dbSeek(xFilial("SB1")+SC6->C6_PRODUTO)
	If SB1->B1_GRUPO == '0200' .OR. SB1->B1_GRUPO == '0201' .OR. SB1->B1_GRUPO == '0700'
		dbSelectarea("SC6")
		RecLock("SC6", .F.)
		SC6->C6_LOCAL   := SA3->A3_LOCAL
		msUnlock()
	EndIf
	dbSelectarea("SC6")
	dbSkip()
End
*/ // ateh aki 20040712
//dbSeek(xFilial("SC6")+SC5->C5_NUM)
If AllTrim(FUNNAME())=="MATA410" .AND. SC5->C5_DIVVEN == "PUBL"
	_lFatur  := .F.
	_lFatur2 := .F.
	// Se Alteracao
	If Altera
		dbSelectArea("SZS")
		dbSetOrder(1)
		If dbSeek(xFilial("SZS")+SC5->C5_NUM, .F.)
			While !Eof() .and. SZS->ZS_FILIAL == xFilial("SZS") .and. SZS->ZS_NUMAV == SC5->C5_NUM
				If !Empty(SZS->ZS_NFISCAL)
					_lFatur := .T.
					Exit
				EndIf
				dbSkip()
			End
			
			If !_lFatur
				dbSeek(xFilial("SZS")+SC5->C5_NUM)
				While !Eof() .and. SZS->ZS_FILIAL == xFilial("SZS") .and. SZS->ZS_NUMAV == SC5->C5_NUM
					RecLock("SZS", .F.)
					dbDelete()
					msUnlock()
					dbSkip()
				End
			Else
				_cMsg := "Alterar a Programacao de A.V.'s !!!"
				MsgAlert( _cMsg, "ATENCAO")
			EndIf
		EndIf
		
		dbSelectArea("SZV")
		dbSetOrder(1)
		If dbSeek(xFilial("SZV")+SC5->C5_NUM, .F.)
			While !Eof() .and. SZV->ZV_FILIAL == xFilial("SZV") .and. SZV->ZV_NUMAV == SC5->C5_NUM
				If !Empty(SZV->ZV_NFISCAL)
					_lFatur2 := .T.
					Exit
				EndIf
				dbSkip()
			End
			
			If !_lFatur2
				dbSeek(xFilial("SZV")+SC5->C5_NUM)
				While !Eof() .and. SZV->ZV_FILIAL == xFilial("SZV") .and. SZV->ZV_NUMAV == SC5->C5_NUM
					RecLock("SZV", .F.)
					dbDelete()
					msUnlock()
					dbSkip()
				End
			Else
				_cMsg := "Alterar o Faturamento Programado !!! "
				MsgAlert( _cMsg, "ATENCAO")
			EndIf
		EndIf
	EndIf
	
	// Nas Inclusoes ou Alteracoes
	If Inclui .or. ( Altera .and. !_lFatur .or. !_lFatur2 )
		// Alterado em 02/05/00 por RC
		_nTotalAV := 0
		dbSelectarea("SC6")
		dbSeek(xFilial("SC6")+SC5->C5_NUM)
		While !EOF() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NUM == SC5->C5_NUM
			If SC6->C6_TPPROG == "N"  // Somente p/ Av Normais
				_nResto:=0
				// Incluir no arquivo SZS av's Programadas
				_nIns:=0
				_nTotalAV:=_nTotalAV+SC6->C6_VALOR
				dbSelectArea("SZS")
				For _x := SC6->C6_EDINIC to SC6->C6_EDFIN
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³Verifica as edicoes pares impares mensais            ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					// 0 - Mensal
					// 1 - Par
					// 2 - Impares
					_lInclui := .f.
					_nResto:=MOD(_X,2)
					If _nResto == 0
						_nRevista := 'PAR'
					ELSE
						_nRevista := 'IMPAR'
					EndIf
					
					If     SC6->C6_TIPOREV == "1" .and. _nResto==0
						_lInclui := .t.
					ElseIf SC6->C6_TIPOREV == "2" .and. _nResto #0
						_lInclui := .t.
					ElseIf SC6->C6_TIPOREV == "0" // Mensal
						_lInclui := .t.
					ElseIf SC6->C6_TIPOREV == "3" // BIMESTRAL
						_lInclui := .t.
					EndIf
					
					If _lInclui .and. !_lFatur
						_nIns:=_nIns+1
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Posionar no Cronograma para buscar a Circulacao      ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						dbSelectArea("SZJ")
						/*/
						If SUBS(SC6->C6_PRODUTO,1,2)=='08'
							_cProduto:='08'+SUBS(SC6->C6_PRODUTO,3,2)
						ELSE
							_cProduto:='01'+SUBS(SC6->C6_PRODUTO,3,2) -SFRN/23/07
							//     _cProduto:='03'+SUBS(SC6->C6_PRODUTO,3,2)
						EndIf
						/*/
						
						// ALTERADO PARA TESTE NA INCLUSAO DA AV
						_cProduto := Space(4)
						DO CASE
							CASE SUBS(SC6->C6_PRODUTO,1,2)=='08'
								_cProduto:='08'+SUBS(SC6->C6_PRODUTO,3,2)
							CASE SUBS(SC6->C6_PRODUTO,1,3)=='030'
								_cProduto:='01'+SUBS(SC6->C6_PRODUTO,3,2)
							CASE SUBS(SC6->C6_PRODUTO,1,4)=='0320'
								_cProduto:='0115'
							CASE SUBS(SC6->C6_PRODUTO,1,4)=='0321'
								_cProduto:='0116'
							CASE SUBS(SC6->C6_PRODUTO,1,4)=='0318'
								_cProduto:='0118'
							CASE SUBS(SC6->C6_PRODUTO,1,4)=='0117'
								_cProduto:='0322'
							CASE SUBS(SC6->C6_PRODUTO,1,4)=='0324' //20051125
								_cProduto:='0124'
							CASE SUBS(SC6->C6_PRODUTO,1,4)=='0325' //20051125
								_cProduto:='0125'
							CASE SUBS(SC6->C6_PRODUTO,1,4)=='0326' //20051125
								_cProduto:='0126'
							CASE SUBS(SC6->C6_PRODUTO,1,4)=='0327' //20090414
								_cProduto:='0127'
							CASE SUBS(SC6->C6_PRODUTO,1,4)=='0331' //20120405
								_cProduto:='0131'
							CASE SUBS(SC6->C6_PRODUTO,1,4)=='0332' //20120405
								_cProduto:='0132'
						ENDCASE
						
						dbSeek(xFilial("SZJ")+_cProduto+STR(_x,4,0))
						
						dbSelectArea("SZS")
						RecLock("SZS",.T.)
						SZS->ZS_FILIAL  := xFilial("SZS")
						SZS->ZS_CODREV  := LEFT(SC6->C6_PRODUTO,4)
						SZS->ZS_EDICAO  := _X
						SZS->ZS_DTCIRC  := SZJ->ZJ_DTCIRC
						SZS->ZS_CODPROD := SC6->C6_PRODUTO
						SZS->ZS_VALOR   := SC6->C6_PRCVEN
						SZS->ZS_NUMAV   := SC6->C6_NUM
						SZS->ZS_ITEM    := SC6->C6_ITEM
						SZS->ZS_NUMINS  := _nIns
						SZS->ZS_SITUAC  := 'AA'
						SZS->ZS_CODMAT  := SC6->C6_CODMAT
						SZS->ZS_LIBPROG := SZJ->ZJ_DTCIRC
						SZS->ZS_CODTIT  := SC6->C6_CODTIT
						SZS->ZS_CODVEIC := _cProduto
						SZS->ZS_TPTRANS := SC5->C5_TPTRANS
						SZS->ZS_VEND    := SC5->C5_VEND1
						SZS->ZS_FATPROG := SC5->C5_AVESP
						SZS->ZS_CONDPAG := SC5->C5_CONDPAG
						SZS->ZS_CODCLI  := SC5->C5_CLIENTE
						SZS->ZS_VEIC    := subs(SZJ->ZJ_DESCR,1,4)
						msunlock()
					EndIf
				Next _x
				dbSelectArea("SC6")
				dbSkip()
				Loop
				// PROGRAMACAO ESPECIAL
			ElseIf SC6->C6_TPPROG #"N" .and. !_lFatur
				// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				// ³Posiciona Itens do Pedido                      ³
				// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				dbSelectarea("SC6")
				// Inclui no arquivo SZS av's Programadas
				_nIns     := 0
				_nTotalAV := _nTotalAV+SC6->C6_VALOR
				dbSelectArea("SZS")
				For _x := 1  TO SC6->C6_QTDVEN
					_nIns++
					RecLock("SZS",.T.)
					SZS->ZS_FILIAL  := xFilial("SZS")
					SZS->ZS_CODREV  := LEFT(SC6->C6_PRODUTO,4)
					SZS->ZS_CODPROD := SC6->C6_PRODUTO
					SZS->ZS_VALOR   := SC6->C6_PRCVEN
					SZS->ZS_NUMAV   := SC6->C6_NUM
					SZS->ZS_ITEM    := SC6->C6_ITEM
					SZS->ZS_NUMINS  := _nIns
					SZS->ZS_CODTIT  := SC6->C6_CODTIT
					SZS->ZS_SITUAC  := 'AA'
					msunlock()
				Next _x
				dbSelectArea("SC6")
				dbSkip()
				Loop
			EndIf
		End
		dbSelectarea("SC5")
		Reclock("SC5", .F.)
		SC5->C5_VLRPED := _nTotalAV
		msUnlock()
	EndIf
	
	// Inclusao de A.V.ïs Especiais
	If SC5->C5_AVESP  == "S" .and. Inclui
		// Alterado em 14/03/00 POR R.C. para programa de digitacao
		// automatica, conforme solicitacao da Sra.Cidinha.
		ExecBlock("RFAT092", .F., .F. )
		
	ElseIf SC5->C5_AVESP  == "S" .and. Altera
		dbSelectArea("SZV")
		dbSetOrder(1)
		If !dbSeek(xFilial("SZV")+SC5->C5_NUM, .F.)
			_cMsg := " Inclua a programacao no Faturamento Especial !"
			MsgStop(_cMsg, "ATENCAO")
		EndIf
	EndIf
EndIf
// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Posiona Itens do Pedido                        ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectarea("SC6")
dbSeek(xFilial("SC6")+SC5->C5_NUM)
While !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NUM ==  SC5->C5_NUM
	If SC6->C6_QTDEMP + SC6->C6_QTDENT < SC6->C6_QTDVEN
		_lLiberado := .T.
	EndIf
	// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	// ³Atualiza SC9                                   ³
	// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectarea("SC9")
	dbSeek(xFilial("SC9")+SC6->C6_NUM+SC6->C6_ITEM)
	While !Eof() .and. SC9->C9_FILIAL == xFilial("SC9") .and. SC6->C6_NUM+SC6->C6_ITEM == SC9->C9_PEDIDO+SC9->C9_ITEM
		RecLock("SC9",.F.)
		SC9->C9_LOTEFAT := SC6->C6_LOTEFAT
		SC9->C9_LOCAL   := SC6->C6_LOCAL
		SC9->C9_DATA    := SC6->C6_DATA
		If SC5->C5_DIVVEN == "PUBL"
			SC9->C9_BLEST  := ""
		EndIf
		msunlock()
		Dbselectarea("SC9")
		DbSkip()
	End
	
	dbSelectArea("SZJ")
	dbSeek(xFilial("SZJ")+LEFT(SC6->C6_PRODUTO,4)+STR(SC6->C6_EDFIN,4))
	
	// Levanta e altera, se necessario as TES digitadas no pedido. SFRN
	_cTes := SC6->C6_TES
	_cCF  := SC6->C6_CF
	
	If SA1->A1_FLAGID=='2' .AND. SC6->C6_TES=='670'
		If SA1->A1_EST=='SP'
			_cTes := '671'
			_cCF  := '5303' //20090909
		Else
			_cTes := '671'
			_cCF  := '6303'  //20090909
		Endif
	Elseif  SA1->A1_FLAGID=='3' .AND. SC6->C6_TES=='670'
		_cTes := '672'
		_cCF  := '7301' //20090909
	Endif
	// ÚÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ¿
	// ³³ Atualiza os Campos dos Itens do Pedido de Venda               ³³
	// ÀÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÙ
	Reclock("SC6",.F.)
	SC6->C6_TES     := _cTes
	SC6->C6_CF      := _cCF
	SC6->C6_DTFIN   := SZJ->ZJ_DTCIRC
	msUnlock()
	dbSelectArea("SC6")
	dbSkip()
End

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Se ha itens que foram liberados Volta Status de Liberacao       ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If _lLiberado
	dbSelectarea("SC5")
	RecLock("SC5",.F.)
	SC5->C5_LIBEROK := " "
	msUnlock()
EndIf             

dbSelectarea("SC5") //20100913 daqui
If empty(SC5->C5_TPFRETE)
	RecLock("SC5",.F.)
		SC5->C5_TPFRETE := "C"
	msUnlock()
Endif //20100913 ate aqui

If SC5->C5_LOTEFAT=="FEI" //20120215 daqui
	if MsgYesNo("Deseja liberar o pedido e emitir o cupom fiscal para a FEICON?")
		U_PFAT035(SC5->C5_NUM, "S")
	endif
Endif //20120215 ate aqui

If AllTrim(FUNNAME())=="MATA410" .AND. SC5->C5_DIVVEN <> "PUBL" .AND. SM0->M0_CODIGO=="01"//20130705 daqui
	if MsgYesNo("Deseja liberar o pedido?")
		U_PFAT035(SC5->C5_NUM, "R"+iif(inclui,"I","A"))
	endif
ElseIf SC5->C5_DIVVEN == "MERC" .AND. SM0->M0_CODIGO=="01" .AND. SC5->C5_LOTEFAT=="LOJ" .AND. SC5->C5_VEND1=="000101" .AND. AllTrim(FUNNAME())<>"MATA410"//jobpini01 (NAO VEIO DO CADASTRO DE PEDIDOS)
	 U_PFAT035(SC5->C5_NUM, "RJ") //RESERVA JOB
Endif //20130705 ate aqui

dbSelectarea("SC6")
dbsetOrder(_nIndSc6)
dbGoTo(_nRegSc6)

dbSelectArea("SC9")
dbSetOrder(_nIndSc9)
dbGoTo(_nRegSc9)

dbSelectArea("SA3")
dbSetOrder(_nIndSA3)
dbGoTo(_nRegSA3)

dbSelectArea("SB1")
dbSetOrder(_nIndSB1)
dbGoTo(_nRegSB1)

dbSelectarea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)

Return
