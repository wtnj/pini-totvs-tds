#INCLUDE "RWMAKE.CH"
/*  
//Alterado por Danilo C S Pala em 20050520: CFB
//Alterado por Danilo C S Pala em 20070315: CFE
//Alterado por Danilo C S Pala em 20070328: NFS
//Alterado por Danilo C S Pala em 20080220: SEN
//Alterado por Danilo C S Pala em 20081031: STD
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RECBXVL   �Autor  �Microsiga           � Data �  04/02/02   ���
�������������������������������������������������������������������������͹��
���Desc.     �BAIXA DE TITULOS A RECEBER                                  ���
���          �RETORNA VALOR DO LANCAMENTO                                 ���
�������������������������������������������������������������������������͹��
���Uso       � AP5                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function RecBxVl()

Private mBxVl := 0

IF TRIM(SE1->E1_TIPO)=='NF'
   IF TRIM(SE1->E1_SERIE) $'UNI%CUP%D1%CFS%CFA%CFB%ANG%CFE%NFS%SEN%STD%8' //20050520 CFB //20061031 ANG  //20070315 CFE  //20070328 NFS //20080220 SEN //20081031 STD
      MBXVL:=SE1->E1_VALOR
   ENDIF
ENDIF

IF TRIM(SE1->E1_TIPO)=='CH'
   MBXVL:=SE1->E1_VALOR
ENDIF

RETURN(MBXVL)