#include "rwmake.ch"        
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: Atualsz0  ³Autor: Valdir Diocleciano     ³ Data:   28/04/03 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Atualizacao do campo Sa3->a3_Local                         ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function AtualSa3()        
SetPrvt("cArqTEMP1,cKey,Chave,bBloco,codigo")

cArqTemp1 := "LOC_GER.DBF"
dbUseArea( .F.,, cArqTemp1,"TMP", .F. )

bBloco:= { |lEnd| ATUALIZA()  }

MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )

Static Function Atualiza()

dbselectarea("TMP")
dbgotop()

While !Eof()
	codigo := TMP->COD
	dbSelectArea("SA3")
	If DBSEEK(xFILIAL()+codigo)
		RecLock("SA3",.F.)
		SA3->A3_LOCAL := "T4" 
		MsUnlock()
	Endif
	dbselectarea("TMP")
	dbskip()
	loop
End
Return
