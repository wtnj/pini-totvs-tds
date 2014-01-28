#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: FAT9VC01  ³Autor: Roger Cangianeli       ³ Data:   26/01/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Validacao do Campo A.V. na Manutencao do SZV               ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Valida no ExecBlock RFATA09                                ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Fat9vc02()

SetPrvt("_LRET,_CCLIENTE,_CLOJA,_CVEND,ACOLS,_CMSG")

_lRet    := .F.

dbSelectArea("SC5")
dbSetOrder(1)
If dbSeek(xFilial("SC5")+_cNumAv, .F.)
	If SC5->C5_TPTRANS $ "11/12/13"
		_cCliente   := SC5->C5_CLIENTE
		_cLoja      := SC5->C5_LOJACLI
		_cVend      := SC5->C5_VEND1
		_lRet := .T.
		
		// Recria array carregando dados ja digitados
		dbSelectArea("SZV")
		dbSetOrder(1)
		If dbSeek(xFilial("SZV")+_cNUMAV, .F.)
			aCols := {}
			While !Eof() .and. SZV->ZV_FILIAL+SZV->ZV_NUMAV == xFilial("SZV")+_cNUMAV
                aAdd( aCols, { SZV->ZV_NPARC, SZV->ZV_VALOR, SZV->ZV_CONDPAG, SZV->ZV_ANOMES, SZV->ZV_NFISCAL, SZV->ZV_SERIE, SZV->ZV_DTNF, SZV->ZV_SITUAC, .F. } )
				dbSkip()
			End
		Endif
	Else
		_cMsg   := "Faturamento Especial somente pode ser efetuado em Tipos de Transacao 11, 12 e 13 ! Verifique."
            MsgStop(_cMsg, " Atencao ")
	EndIf
Else
    _cMsg   := "A.V. nao Encontrada !!!"
    MsgStop(_cMsg, " Atencao ")
EndIf

Return(_lRet)