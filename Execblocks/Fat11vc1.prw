#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: FAT11VC1  ³Autor: Roger Cangianeli       ³ Data:   04/02/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Validacao do Campo A.V. na Manutencao do SZS               ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Valida no ExecBlock RFATA11                                ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Fat11vc1()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

SetPrvt("_LRET,_CCLIENTE,_CLOJA,_CVEND,_DEMISSAO,_CFATPROG")
SetPrvt("_CNOMCLI,ACOLS,_CMSG,")

_lRet    := .F.

dbSelectArea("SC5")
dbSetOrder(1)
If dbSeek( xFilial("SC5")+_cNumAv, .F. )
	_cCliente   := SC5->C5_CLIENTE
	_cLoja      := SC5->C5_LOJACLI
	_cVend      := SC5->C5_VEND1
	_dEmissao   := SC5->C5_EMISSAO
	_cFatProg   := SC5->C5_AVESP
	
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek( xFilial("SA1")+_cCliente+_cLoja )
	_cNomCli := IIf( !Empty(SA1->A1_NREDUZ), SA1->A1_NREDUZ, Subs(SA1->A1_NOME,1,20) )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Remonta a aCols, caso encontre dados no SZS.                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SZS")
	dbSetOrder(5)
	If dbSeek( xFilial("SZS")+_cNumAV, .F. )
		aCols   := {}
		While !Eof() .and. SZS->ZS_FILIAL+SZS->ZS_NUMAV == xFilial("SZS")+_cNumAV
			aAdd( aCols, { ZS_ITEM, ZS_CODREV, ZS_NUMINS, ZS_EDICAO, ZS_DTCIRC,;
			ZS_CODPROD, ZS_CODMAT, ZS_CODTIT, ZS_CODVEIC, ZS_VEIC, ZS_SITUAC,;
			ZS_LIBPROG, ZS_LIBFAT, ZS_NFISCAL, ZS_SERIE, ZS_DTNF, ZS_VALOR,;
			ZS_CONDPAG,ZS_DTCANC,.F. } )
			dbSkip()
		End
	Endif
	_lRet := .T.
Else  // Se nao for encontrada e nao for inclusao
	_cMsg   := "A.V. nao Encontrada !!!"
	MsgBox(_cMsg, " Atencao ", "STOP")
EndIf

Return(_lRet)
