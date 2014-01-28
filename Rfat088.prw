#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT004   ³Autor: Solange Nalini         ³ Data:   30/04/98 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Libera‡ao de Pedidos de Venda por lote                     ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Release  : Padronizacao e conversao Windows.Roger Cangianeli -02/02/00³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat088()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("_CALIAS,_NINDEX,_NREG,CSAVTELA,CSAVCURSOR,CSAVCOR")
SetPrvt("CSAVALIAS,CPERG,_CMSG,")

_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()
lEnd    := .f.

Processa({|lEnd| _RunProc(@lEnd)}, " LIBERACAO DE A.V. / ANUNCIO ")// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     Processa({||Execute(_RunProc)}, " LIBERACAO DE A.V. / ANUNCIO ")

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)

Return

Static Function _RunProc()

cPerg:="LIBPRO"

If !Pergunte(cPerg)
	Return
Endif

_cMsg := ""

ProcRegua(30)

While .T.
	dbSelectArea('SC5')
	dbSetOrder(1)
	If !dbSeek(xFilial("SC5")+MV_PAR03, .F.)
		_cMsg   := "Pedido nao Encontrado !"
		Exit
	EndIf
	
	If SC5->C5_CLIENTE #MV_PAR01
		_cMsg := "A A.V. NAO Pertence ao Cliente Parametrizado. Verifique!"
		Exit
	EndIf
	
	dbSelectArea("SZU")
	dbSetOrder(2)
	If !dbSeek(xFilial("SZU")+MV_PAR05, .F.)
		_cMsg := "Material Nao Cadastrado !"
		Exit
	EndIf
	
	dbSelectArea("SZS")
	dbSetOrder(1)    
	If dbSeek(xFilial("SZS")+MV_PAR03+MV_PAR04, .F.)
		While !eof() .and. SZS->ZS_NUMAV == MV_PAR03 .AND.;
			SZS->ZS_ITEM == MV_PAR04
			RecLock("SZS",.F.)
			SZS->ZS_CODMAT := MV_PAR05
			SZS->(msUnlock())
			IncProc()
			dbSelectArea("SZS")
			dbSkip("Lendo AV: "+SZS->ZS_NUMAV)
		End
		_cMsg := "Processamento Executado !"
		Exit
	Else
		_cMsg := "Item / A.V. nao Encontrada na Programacao !"
		Exit
	EndIf
End

If !Empty(_cMsg)
	MsgBox(_cMsg, "ATENCAO", "ALERT")
EndIf

Return