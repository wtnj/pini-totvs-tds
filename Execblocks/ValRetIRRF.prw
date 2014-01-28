#include "rwmake.ch"
/*/                                                                       
// Alterado por Danilo C S Pala 20050520: CFB
//Alterado por Danilo C S Pala em 20070315: CFE
//Alterado por Danilo C S Pala em 20070328: NFS
//Alterado por Danilo C S Pala em 20080220: SEM
//Alterado por Danilo C S Pala em 20100114: 1
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³20/02/2004³ Execblock utilizado na RETENCAO DA CSLL(SI5)            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ DANILO CESAR SESTARI PALA										   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function ValRetIRRF()
Local MIRRF:=0
Local aArea := GetArea()

SetPrvt("MIRRF,")


// VERIFICACAO DO PRODUTO
IF SB1->B1_IRRF = "S"

	//VERIFICAR O CLIENTE
	DbSelectArea("SA1")
	DbSetOrder(1)
	DbSeek(xFilial("SA1")+SD2->D2_CLIENTE)
	//NATUREZA DO CLIENTE
	                                      
	DbSelectArea("SED")
	DbSetOrder(1)
	DbSeek(xFilial("SED")+SA1->A1_NATUREZ)
	IF SED->ED_CALCIRF = "S"
			
		//VERIFICAR O TES
		DbSelectArea("SF4")
		DbSetOrder(1)
		DbSeek(xFilial("SF4")+SD2->D2_TES)    //F4_PISCOF: 1=PIS, 2=COFINS, 3=AMBAS
		IF SF4->F4_DUPLIC=='S' .AND. (SF4->F4_PISCOF="3")
		  If Trim(SD2->D2_SERIE) $'UNI%D1%CUP%CFS%CFA%CFB%ANG%CFE%NFS%SEN%1%8'  //20050520 CFB //20061031 ANG  //20070315 CFE  //20070328 NFS //20080220 SEN
		     MIRRF := SD2->D2_TOTAL * SED->ED_PERCIRF /100
		   Endif
		ENDIF //TES
	ENDIF //CLIENTE
ENDIF //PRODUTO

             
DbSelectArea("SF2")
DbSetOrder(1)
DbSeek(xFilial("SF2")+SD2->D2_DOC+SF2->F2_SERIE)

RestArea(aArea)

Return(MIRRF)