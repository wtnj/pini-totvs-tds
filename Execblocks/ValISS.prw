#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 21/03/02
/*/  Criado por Danilo C S Pala em 20090525: salgado solicitou
//Alterado por Danilo C S Pala em 20100507: ECF
//Alterado por Danilo C S Pala em 20100114: 1
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ 16/03/02 ³ Execblock utilizado no ISS                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ValISS()
Local mISS:=0
Local aArea := GetArea()

SetPrvt("MISS")

DbSelectArea("SB1")
DbSetOrder(1)
DbSeek(xFilial("SB1")+SD2->D2_COD)

DbSelectArea("SF4")
DbSetOrder(1)
DbSeek(xFilial("SF4")+SD2->D2_TES)
IF SF4->F4_DUPLIC=='S'
   If Trim(SD2->D2_SERIE)$'UNI%D1%CUP%CFA%CFB%CFS%ANG%CFE%NFS%SEN%ECF%1%8%4' //20090611 //20100507 ECF
   	   if SB1->B1_TIPO=="CD" //20090525 salgado
	   	   mISS:=0//20090525 salgado
   	   elseif SB1->B1_TIPO=="EV" //20090525 salgado
	   	   mISS:=SD2->D2_TOTAL * 5/100//20090525 salgado
   	   else
	      mISS:=SD2->D2_VALISS
	   endif
   Endif
ENDIF
             
DbSelectArea("SF2")
DbSetOrder(1)
DbSeek(xFilial("SF2")+SD2->D2_DOC+SF2->F2_SERIE)

RestArea(aArea)

Return(mISS)