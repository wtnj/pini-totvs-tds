/*/                                                                    
// Alterado por Danilo C S Pala 20050520: CFB
//Alterado por Danilo C S Pala em 20070315: CFE
//Alterado por Danilo C S Pala em 20070328: NFS
//Alterado por Danilo C S Pala em 20080220: SEN
//Alterado por Danilo C S Pala em 20090525: salgado solicitou   
//Alterado por Danilo C S Pala em 20100507: ECF
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ 16/03/02 ³ Execblock utilizado na contab.pis                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Valpis()

Local mPIS  := 0
Local aArea := GetArea()

DbSelectArea("SB1")  //20090525
DbSetOrder(1)
DbSeek(xFilial("SB1")+SD2->D2_COD)

DbSelectArea("SF4")
DbSetOrder(1)
DbSeek(xFilial("SF4")+SD2->D2_TES)

IF SF4->F4_DUPLIC=='S'
   If Trim(SD2->D2_SERIE) $'UNI%D1%CUP%PUB%CFA%CFS%CFB%ANG%CFE%NFS%SEN%ECF%8%4'  //20050520 CFB //20061031 ANG  //20070315 CFE  //20070328 NFS 	//20080220 SEN //20100507 ECF
	   if SB1->B1_TIPO=="RC" .OR. SB1->B1_TIPO=="SW" //20090525 salgado
   			mPIS:=SD2->D2_TOTAL*0.65/100 //20090525 salgado
       elseif SB1->B1_TIPO=="LI" .OR. SB1->B1_TIPO=="LC" .OR. SB1->B1_TIPO=="TC"//20090525 salgado
	       mPIS:= 0 //20090525 salgado
	   else
		    mPIS:=SD2->D2_TOTAL*1.65/100
  	   endif
   Endif
ENDIF   
                               
DbSelectArea("SF2")
DbSetOrder(1)
DbSeek(xFilial("SF2")+SD2->D2_DOC+SF2->F2_SERIE)


RestArea(aArea)

Return(mPIS)