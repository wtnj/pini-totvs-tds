#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
    #DEFINE PSAY SAY
#ENDIF

User Function Rfat302()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CALIAS,_NINDEX,_NREG,CPERG,CSTRING,CDESC1")
SetPrvt("CDESC2,CDESC3,TAMANHO,ARETURN,NOMEPROG,LIMITE")
SetPrvt("ALINHA,NLASTKEY,NLIN,TITULO,CCABEC1,CCABEC2")
SetPrvt("CCANCEL,M_PAG,WNREL,_ACAMPOS,_CARQ,_CIND")
SetPrvt("_CKEY,_CFILTRO,_MPROD,_MQTDE,_MTOTP,_MVAL")
SetPrvt("_MNUM,_MDESCR,_MCONT,_MOTIVO,_MHIST,_MPERC")
SetPrvt("_MDESP,_LQTD,_CPAGTO,_MNOTA,_CARQDEST,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     #DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATR30   ³Autor: Rosane Rodrigues       ³ Data:   08/03/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: RELATORIO DE PGTOS POR PRODUTO                             ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Alteracao: Otimizado por Roger Cangianeli, em 31/10/00.               ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³   Parametros Utilizados                   ³
//³   mv_par01 = Produto  Inicial             ³
//³   mv_par02 = Produto  Final               ³
//³   mv_par03 = Data Inicial                 ³
//³   mv_par04 = Data Final                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cPerg    := "FAT018"
If !Pergunte(CPERG)
	Return
EndIf
cString  := "SC6"
cDesc1   := PADC("Este programa emite o relat¢rio dos pagamentos",70)
cDesc2   := PADC("por produto no per¡odo solicitado",70)
cDesc3   := PADC("Obs: os pedidos com S‚rie CP0 e LIV nÆo aparecem no relat¢rio",70)
tamanho  := "M"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFATR30"
limite   := 132
aLinha   := { }
nLastKey := 0
nLin     := 80
titulo   := "Pagamentos por Produto"
cCabec1  := "Produto Inicial : " + MV_PAR01 + SPACE(04) + "Produto Final : " + MV_PAR02 + SPACE(04) +;
	"Dt. Pagto Inicial : " + DTOC(MV_PAR03) + SPACE(04) + "Dt. Pagto Final : " + DTOC(MV_PAR04)
cCabec2  := " "
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1               //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel    := "RFATR30_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)       //Nome Default do relatorio em Disco
wnrel    := SetPrint(cString,wnrel,cPerg,space(25)+titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

SetDefault(aReturn,cString)

IF NLASTKEY==27 .OR. NLASTKEY==65
	RETURN
ENDIF

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Chama Relatorio                                ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF WINDOWS
RptStatus({|| RptDetail() })// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> RptStatus({|| Execute(RptDetail) })
#ELSE
RptDetail()
#ENDIF
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³RptDetail ³ Autor ³ Ary Medeiros          ³ Data ³ 15.02.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Impressao do corpo do relatorio                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function RptDetail
Static Function RptDetail()

_aCampos := {}
aAdd( _aCampos, { "CODPRO", "C", 15, 0 })
aAdd( _aCampos, { "DESCRI", "C", 30, 0 })
aAdd( _aCampos, { "PEDIDO", "C", 06, 0 })
aAdd( _aCampos, { "CODCLI", "C", 06, 0 })
aAdd( _aCampos, { "NOMCLI", "C", 40, 0 })
aAdd( _aCampos, { "QUANT",  "N", 10, 0 })
aAdd( _aCampos, { "FORMA",  "C", 20, 0 })
aAdd( _aCampos, { "NUM",    "C", 06, 0 })
aAdd( _aCampos, { "PARC",   "C", 01, 0 })
aAdd( _aCampos, { "VALOR",  "N", 14, 2 })
aAdd( _aCampos, { "PAGTO",  "C", 15, 0 })

_cArq := CriaTrab(_aCampos, .T.)
dbUseArea( .T., , _cArq, "TRB", .F., .F. )


dbSelectArea("SE5")
//_cInd    := CriaTrab(NIL,.F.)
//_cKey    := "E5_FILIAL+E5_NUMERO+E5_PARCELA"
//IndRegua("SE5",_cInd,_cKey,,,"Selecionando registros .. ")
dbSetOrder(7)

dbSelectArea("SE1")
//_cInd    := CriaTrab(NIL,.F.)
//_cKey    := "E1_FILIAL+E1_PEDIDO+E1_NUM+E1_PARCELA"
//_cFiltro := "E1_FILIAL == '"+xFilial("SE1")+"'"
//_cFiltro := _cFiltro+".and.DTOS(E1_DTALT)>=DTOS(CTOD('"+DTOC(MV_PAR03)+"'))"
//_cFiltro := _cFiltro+".and.DTOS(E1_DTALT)<=DTOS(CTOD('"+DTOC(MV_PAR04)+"'))"
//_cFiltro := _cFiltro+".and.MONTH(E1_BAIXA)<>0"
//_cFiltro := _cFiltro+".and.E1_SERIE<>'LIV'.AND.E1_SERIE<>'CP0'"
//IndRegua("SE1",_cInd,_cKey,,_cFiltro,"Selecionando registros .. ")
DbOrderNickName("E1_PEDIDO") //dbSetOrder(27) 20130225  ///dbSetOrder(15) AP5 //20090114 era(21) //20090723 mp10 era(22) //dbSetOrder(26) 20100412

_mProd := ""
_mQtde := 0
_mtotp := 0

dbSelectArea("SC6")
//_cInd    := CriaTrab(NIL,.F.)
//_cKey    := "C6_FILIAL+C6_PRODUTO+C6_NUM"
//IndRegua("SC6",_cInd,_cKey,,,"Selecionando registros .. ")
dbSetOrder(2)

SetRegua(Reccount())
dbSeek(xFilial("SC6")+MV_PAR01,.T.)
While !eof() .and. sc6->c6_produto <= mv_par02
	
	IncRegua()
	
	_mval   := 0
	_mNum   := SC6->C6_NUM
	_mDescr := " "
	_mCont  := 0
	_motivo := " "
	_mHist  := " "
	
	If _mProd <> SC6->C6_PRODUTO .and. _mProd <> " " .and. _mtotp <> 0
		nLin     := nLin + 2
		@ nlin,000 PSAY "Total de Pagamentos ..................................: "
		@ nlin,056 PSAY STR(_mQtde,6)
		@ nlin,108 PSAY _mtotp PICTURE "@E 9,999,999.99"
		_mQtde := 0
		_mtotp := 0
		nLin   := 80
	Endif
	
	DbSelectArea("SC5")
	DbSetOrder(01)
	If DbSeek(xFilial("SC5")+_mNum, .F.)
		_mPerc := (SC6->C6_VALOR * 100) / SC5->C5_VLRPED
		_mDesp := SC5->C5_DESPREM
		
		DbSelectArea("SZ9")
		DbSetOrder(01)
		If DbSeek(xFilial("SZ9")+SC5->C5_TIPOOP, .F.)
			_mDescr := SUBSTR(SZ9->Z9_DESCR,1,19)
		Endif
		
		DbSelectArea("SE1")
		If DbSeek(xFilial("SE1")+_mNum,.F.)
			While !Eof() .and. SE1->E1_FILIAL==xFilial("SE1") .and.;
					_mNum == SE1->E1_PEDIDO
				
                IncRegua()

				If SE1->E1_DTALT < MV_PAR03 .or. SE1->E1_DTALT > MV_PAR04 .or.;
						Empty(SE1->E1_BAIXA) .or. AllTrim(SE1->E1_SERIE) $ "LIV/CP0"
					dbSkip()
					Loop
				EndIf
				
				IF 'LUCROS E PERDAS' $(SE1->E1_HIST) .OR. 'NF CANCELA' $(SE1->E1_HIST) .OR.;
						'CAN' $(SE1->E1_MOTIVO)
					_motivo := SE1->E1_MOTIVO
					_mHist  := SE1->E1_HIST
				ENDIF
				
				DbSelectArea("SE5")
				If dbSeek(xFilial("SE5")+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA, .F.)
					IF 'CAN' $(SE5->E5_MOTBX)
						_Motivo := SE5->E5_MOTBX
					Endif
				Endif
				
				If nLin > 59
					nLin     := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18)
					nLin     := nLin + 2
					@ nlin,00 PSAY "Produto :  " + SC6->C6_DESCRI
					nLin     := nLin + 2
					//           1         2         3         4         5         6         7         8         9        10        11        12        13
					// 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
					@ nlin,00 PSAY "Pedido  Cliente  Nome do Cliente                          Qtde  Forma de Pgto        Valor Total   Duplicata  Valor Parcela  Dt.Pgto."
					nLin     := nLin + 1
					@ nlin,00 PSAY "------  -------  ---------------------------------------- ----  -------------------  ------------  ---------  -------------  --------"
					nLin     := nLin + 1
				Endif
				nLin := nLin + 1
				
				_mval := SE1->E1_VALOR
                _lQtd := .F.
				If _mCont == 0
                    @ nlin,000 PSAY SE1->E1_PEDIDO
					@ nlin,008 PSAY SC6->C6_CLI
					dbSelectArea("SA1")
					dbSetOrder(1)
					dbSeek(xFilial("SA1")+SC6->C6_CLI)
					@ nlin,017 PSAY SA1->A1_NOME
					@ nlin,058 PSAY STR(SC6->C6_QTDVEN,4)
                    _lQtd := .T.
					@ nlin,064 PSAY _mDescr
					@ nlin,086 PSAY SC5->C5_VLRPED * (_mPerc / 100) PICTURE "@E 99,999.99"
					_mQtde := _mQtde + SC6->C6_QTDVEN
					_mCont := 1
				Endif
				If SE1->E1_PARCELA == 'A' .OR. SE1->E1_PARCELA == ' '
					_mval  := SE1->E1_VALOR - _mDesp
				Endif
                @ nlin,099 PSAY SE1->E1_NUM+' '+SE1->E1_PARCELA
                @ nlin,111 PSAY _mval * (_mPerc / 100) PICTURE "@E 99,999.99"

                If _motivo == " " .and. _mHist == " "
                    _cPagto := DTOC(SE1->E1_BAIXA)
                    //@ nlin,125 PSAY SE1->E1_BAIXA
					_mtotp := _mtotp + (_mval * (_mPerc / 100))
                Else
                    If _motivo #" "
                        _cPagto := "NF CANC"
                        //@ nlin,125 PSAY "NF CANC"
                    Else
                        If "LUCROS E PERDAS" $(_mHist)
                            _cPagto := "L&P"
                            //@ nlin,125 PSAY "L&P"
                        Else
                            _cPagto := "NF CANC"
                            //@ nlin,125 PSAY "NF CANC"
                         Endif
                    Endif
                Endif
                @ nLin, 125 PSAY _cPagto

                dbSelectArea("TRB")
                RecLock("TRB", .T.)
                TRB->CODPRO := SC6->C6_PRODUTO
                TRB->DESCRI := SC6->C6_DESCRI
                TRB->PEDIDO := SE1->E1_PEDIDO
                TRB->CODCLI := SC6->C6_CLI
                TRB->NOMCLI := SA1->A1_NOME
                TRB->QUANT  := IIf( _lQtd, SC6->C6_QTDVEN, 0 )
                TRB->FORMA  := _mDescr
                TRB->NUM    := SE1->E1_NUM
                TRB->PARC   := AllTrim(SE1->E1_PARCELA)
                TRB->VALOR  := _mval * (_mPerc / 100)
                TRB->PAGTO  := _cPagto
                msUnlock()

				_motivo := " "
				_mHist  := " "
				_mnota  := SE1->E1_NUM
				DbSelectArea("SE1")
				DbSkip()
			Enddo
		Endif
	Endif
	_mProd := SC6->C6_PRODUTO
	DbSelectArea("SC6")
	DbSkip()
End

nLin := nLin + 2
@ nlin,000 PSAY "Total de Pagamentos ..................................: "
@ nlin,056 PSAY STR(_mQtde,6)
@ nlin,108 PSAY _mtotp PICTURE "@E 9,999,999.99"

dbSelectarea("SC6")
//RetIndex("SC6")
// Apaga Indice SC6
//fErase(_cInd+OrdBagExt())
//dbSelectarea("SE1")
//RetIndex("SE1")
//dbSelectarea("SC5")
//RetIndex("SC5")
//dbSelectarea("SE5")
//RetIndex("SE5")

Set Device to Screen
_cArqDest := "I:\SIGA\SIGAADV\EXPORTA\RFATR30.DBF"
dbSelectArea("TRB")
If RecCount() > 0
    Copy to &_cArqDest VIA "DBFCDXADS" // 20121106 
EndIf
dbCloseArea()
fErase(_cArq+".DBF")

If aReturn[5] == 1
    Set Printer To
    ourspool(wnrel) //Chamada do Spool de Impressao
Endif
MS_FLUSH() //Libera fila de relatorios em spool

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)

Return
