#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 21/03/02
/*/  Alterado por Danilo C S Pala, em 20040818                         
// Alterado por Danilo C S Pala 20050520: CFB                             
//Alterado por Danilo C S Pala em 20070315: CFE
//Alterado por Danilo C S Pala em 20070328: NFS
//Alterado por Danilo C S Pala em 20080220: SEN
//Alterado por Danilo C S Pala em 20090525: salgado solicitou
��������������������������������������������������������������������������
��������������������������������������������������������������������������
����������������������������������������������������������������������Ŀ��
��� 16/03/02 � Execblock utilizado na cofins                           ���
����������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������
��������������������������������������������������������������������������
/*/
User Function Valcof()        // incluido pelo assistente de conversao do AP5 IDE em 21/03/02
Local mCOF:=0
Local aArea := GetArea()

SetPrvt("MCOF,")

DbSelectArea("SB1") //20090525
DbSetOrder(1)
DbSeek(xFilial("SB1")+SD2->D2_COD)

DbSelectArea("SF4")
DbSetOrder(1)
DbSeek(xFilial("SF4")+SD2->D2_TES)
IF SF4->F4_DUPLIC=='S'
   If Trim(SD2->D2_SERIE) $'UNI%D1%CUP%PUB%CFA%CFB%CFS%ANG%CFE%NFS%SEN%8'  //20050520 CFB //20061031 ANG  //20070315 CFE  //20070328 NFS //20080220 SEN
   	   if SB1->B1_TIPO=="RC" .OR. SB1->B1_TIPO=="SW"//20090525 salgado
	   	   mCOF:=SD2->D2_TOTAL*3/100 //20090525 salgado                        
	   elseif SB1->B1_TIPO=="LI" .OR. SB1->B1_TIPO=="LC" .OR. SB1->B1_TIPO=="TC"//20090525 salgado
	 	   mCOF:=0 //20090525 salgado
   	   else
	      mCOF:=SD2->D2_TOTAL*7.6/100     //20040130 era: mCOF:=SD2->D2_TOTAL*3/100
	   endif
   Endif
ENDIF
             
DbSelectArea("SF2")
DbSetOrder(1)
DbSeek(xFilial("SF2")+SD2->D2_DOC+SF2->F2_SERIE)

RestArea(aArea)

Return(MCOF)