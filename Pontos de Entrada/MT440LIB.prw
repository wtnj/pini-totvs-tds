#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function MT440LIB()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_NQTDLIB,_NQTDJALIB,")


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±³Programa: MT440LIB  ³Autor: Fabio William          ³ Data:   07/07/97 ³ ±±
±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±³Descri‡ao: Retorna a quantida a ser liberada.                         ³ ±±
±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

Grupo de perguntas Ativo MTALIB
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ mv_par01 Ordem Processmento ?  Ped.+Item /Dt.Entrega+Ped.+Item³
//³ mv_par02 Pedido de          ?                                 ³
//³ mv_par03 Pedido ate         ?                                 ³
//³ mv_par04 Cliente de         ?                                 ³
//³ mv_par05 Cliente ate        ?                                 ³
//³ mv_par06 Dta Entrega de     ?                                 ³
//³ mv_par07 Dta Entrega ate    ?                                 ³
//³ mv_par08 Lote de                                              ³
//³ mv_par09 Lote Ate                                             ³
//³ mv_par10 Data Lote de                                         ³
//³ mv_par11 Data Lote Ate                                        ³
//³ mv_par12 Pedido da Publicidade                                ³
//³ mv_par13 Data Liberacao                                       ³
//³ mv_par14 Vendedor De                                          ³
//³ mv_par15 Vendedor Ate                                         ³
//³ mv_par16 Da Cond. Pagto                                       ³
//³ mv_par17 Ate a Cond de Pagto                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*/
If SC5->C5_DIVVEN #'PUBL'
	Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calcula a quantidade maxima a ser liberada   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_nQtdLib  := ( SC6->C6_QTDVEN - ( SC6->C6_QTDEMP + SC6->C6_QTDENT ) )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica a quantidade a ser liberada         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC5")
dbSeek(xFilial()+SC6->C6_NUM)

If SC5->C5_DIVVEN == "PUBL"
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Para Publicidade deve ser calculada a quantidade na hora  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	_nQtdLib := 0
	_nQtdJALib := 0
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Conta no SC9 a Quantidade Liberada  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("SC9")
	DbSeek(xFilial()+SC6->C6_NUM+SC6->C6_ITEM)
	Do While !eof() .and. SC9->C9_PEDIDO+SC9->C9_ITEM == SC6->C6_NUM+SC6->C6_ITEM
		IF Empty(SC9->C9_NFISCAL)
			_nQtdJALib := SC9->C9_QTDLIB + _nQtdJALib
			RecLock("SC9",.F.)
			DbDelete()
			Msunlock()
		Endif
		DbSelectarea("SC9")
		DbSkip()
	Enddo
	if _nQtdJALib > 0
		RecLock("SC6",.F.)
		SC6->C6_QTDEMP := SC6->C6_QTDEMP - _nQtdJALib
		IF SC6->C6_QTDEMP <= 0
			SC6->C6_QTDEMP := 0
		Endif
		msunlock()
	Endif
	
	
	IF SC5->C5_AVESP == "N" // Somente AV Com pagamento normal
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica a quantidade a ser liberada         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		DbSelectArea("SZS")
		DbSetOrder(01)
		DbSeek(xFilial()+SC6->C6_NUM+SC6->C6_ITEM)
		Do While !eof() .AND. SC6->C6_NUM+SC6->C6_ITEM == SZS->ZS_NUMAV+SZS->ZS_ITEM
			IF SC5->C5_TPTRANS#'02' .AND. SC5->C5_TPTRANS#'03'
				If VAL(SZS->ZS_NFISCAL) == 0 // Libera Somente Itens que temnha
					If Month(MV_PAR13) == Month(SZS->ZS_LIBPROG)
						IF Year(MV_PAR13) == Year(SZS->ZS_LIBPROG)
							IF SC5->C5_VEND1 >= MV_PAR14 .and. SC5->C5_VEND1 <= MV_PAR15
								IF "AA" $(SC6->C6_SITUAC)
									IF SZS->ZS_SITUAC == "AA"
										IF SC5->C5_CONDPAG>=MV_PAR16 .AND. SC5->C5_CONDPAG<=MV_PAR17
											IF !EMPTY(SZS->ZS_CODMAT)
												_nQtdLib := _nQtdLib + 1
												RecLock("SZS",.F.)
												SZS->ZS_LIBFAT:=dDataBase
												MsUnlock()
											Endif
										ENDIF
									Endif
								Endif
							Endif
						Endif
					endif
				Endif
			ENDIF
			DbSelectArea("SZS")
			DbSkip()
		Enddo
		
	Else // Programacao AV Especiais
		
		DbSelectArea("SZV")
		DbSetOrder(01)
		DbSeek(xFilial()+SC6->C6_NUM)
		Do While !eof() .AND. SC6->C6_NUM == SZV->ZV_NUMAV
			IF Month(SZV->ZV_ANOMES) == Month(MV_PAR13) .AND. ;
					YEAR(SZV->ZV_ANOMES) ==  YEAR(MV_PAR13) .AND. EMPTY(SZV->ZV_NFISCAL)
				_nQtdLib := _nQtdLib + 1
			Endif
			DbSelectArea("SZV")
			DbSkip()
		Enddo
	Endif
	
Endif


//
if _nqtdlib < 1
	_nqtdlib := 0
endif
// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> __return(_nQtdLib)
Return(_nQtdLib)        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02


