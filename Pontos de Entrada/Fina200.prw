#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02
/* Alterado por Danilo C S Pala em 20040812
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FINA200   �Autor  �Microsiga           � Data �  05/11/02   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada no retorno do CNAB a receber               ���
���          �Altera o valor a receber                                    ���
�������������������������������������������������������������������������͹��
���Uso       � AP5                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Fina200()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

Private NVALREC

NVALREC:=(SE1->E1_VALOR + NJUROS + NMULTA )    //20040812 adicionar desp cobranca(taxa do banco) =>NDESPES
ndespes := 0                

Return(NVALREC)