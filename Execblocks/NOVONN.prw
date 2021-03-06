#include "rwmake.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVONN	�Autor  �Danilo C S Pala     � Data �  20080521   ���
�������������������������������������������������������������������������͹��
���Desc.     � NOVO NOSSO NUMERO										  ���
���          �                               							  ���
�������������������������������������������������������������������������͹��
���Uso       � AP5                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function NOVONN(cBANCO, cAGENCIA, cCONTA)    
local cNOSSONUM := SPACE(8)
Local aArea := GetArea()
	//��������������������������������������������������������������Ŀ
	//� SEE - Cominicacao Remota p/guardar a Faixa Atual             �
	//����������������������������������������������������������������
	dbSelectArea("SEE")
	dbSetOrder(1)
	If dbSeek(xFilial("SEE")+cBANCO + cAGENCIA + cCONTA)
		cNOSSONUM := Left(Alltrim(SEE->EE_FAXATU),8)
		dbSelectArea("SEE")
		RecLock("SEE",.F.)
			SEE->EE_FAXATU := StrZero(Val(alltrim(cNOSSONUM))+1,8)
		MsUnLock()
	Else
		cNOSSONUM := ""
	Endif         
	
RestArea(aArea)
return (cNOSSONUM)