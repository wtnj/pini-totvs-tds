#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: Atualse1  ³Autor: Valdir Diocleciano     ³ Data:   25/09/02 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Atualizacao do campo Se1_dtalt                             ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Atualse1()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
SetPrvt("mData")
//cPerg     := "FAT025"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas.                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*Pergunte(cPerg,.T.)          // Pergunta no SX1

If !Pergunte(cPerg,.T.)
Return
Endif
*/
Processa({|| Atualiza()})

Static Function Atualiza()

dbSelectArea("SE1")
dbSetOrder(21)  ///dbSetOrder(15) AP5

ProcRegua(RecCount())

//While DTOS(SE3->E3_DATA) >= DTOS(MV_PAR01) .AND. DTOS(SE3->E3_DATA) <= DTOS(MV_PAR02)
While !Eof()
	mData := SE1->E1_BAIXA
	IncProc("Pedido: "+SE1->E1_PEDIDO)
	IF !EMPTY(SE1->E1_BAIXA)
		if EMPTY (SE1->E1_DTALT)
			RecLock("SE1",.F.)
			replace SE1->E1_DTALT with mData
			MsUnlock()
		endif
	ENDIF
	DBSKIP()
	LOOP
END
