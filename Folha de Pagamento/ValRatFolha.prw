#INCLUDE "RWMAKE.CH"     
//Alterado por Danilo C S Pala em 20120801: Andre Rangel ADM: 27,24% e CUSTO: 72,76%
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ValRatFolha�Autor �Danilo C S Pala     � Data �  10/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Pini                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function ValRatFolha(nopcao)   //C=Custo(0.8191) e D=Despesa(0.1809)
Local nValor := SRZ->RZ_VAL
IF SM0->M0_CODIGO =="03" .AND. SUBSTR(SRZ->RZ_CC,1,3) =="005"
	MCTA := U_LPF0101D()
	DbSelectArea("ZY6")
	DbSetOrder(1)
	If DbSeek(xFilial("ZY6")+ALLTRIM(MCTA))
		if nopcao="C"
			nValor := round(SRZ->RZ_VAL * 0.7276,2)
		elseif nopcao="D"        
			nValor := nValor - (round(SRZ->RZ_VAL * 0.7276,2))
		else
			nValor := SRZ->RZ_VAL
		endif
	Else     
		if nopcao="D"        
			nValor := 0
		else
			nValor := SRZ->RZ_VAL
		endif
	EndIf
ELSE
	if nopcao="D"        
		nValor := 0
	else
		nValor := SRZ->RZ_VAL
	endif
ENDIF
RETURN(nValor)