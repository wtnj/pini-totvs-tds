#INCLUDE "RWMAKE.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NNSIFRA   �Autor  �Thiago Lima Dyonisio� Data �  11/12/13   ���
�������������������������������������������������������������������������͹��
���Desc.     � Este programa � utilizado na gera��o do arquivo remessa    ���
���          � para o CNAB do banco SIFRA. Ele gera o NOSSO N�MERO,       ���
���          � utilizando m�dulo 11 com base 7.                           ���	
�������������������������������������������������������������������������͹��
���Uso       � Editora PINI                                               ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


User Function NNSIFRA()        

SetPrvt("CNUMERO,NRESULT,CDC,I,NTAM,NDC")
SetPrvt("_NAUXVAL,CDIG,NOSSONUM,")

//��������������������������������������������������������������Ŀ
//� Fun��o para gerar Nosso N�mero NNSIFRA()                     �
//����������������������������������������������������������������

cNumero := Alltrim(Strzero(Val(SEE->EE_FAXATU),11))   


If Empty(SE1->E1_NUMBCO)

   // Grava PROXIMO NUMERO a ser utilizado.
   
   DbSelectArea("SEE")
   RecLock("SEE",.F.)
   SEE->EE_FAXATU := Str(Val(cNumero)+1,Len(SEE->EE_FAXATU))
   MsUnlock()

   //��������������������������������������������������������������Ŀ
   //� Fun��o para encontrar o d�gito de auto confer�ncia           �
   //����������������������������������������������������������������
   
   nResult:= 0
   cDc    := ""
   i      := 0
   nTam   :=Len(Alltrim(cNumero))
   nDc    := 0
   _nAuxVal:= 2

   For i:= nTam To 1 Step -1
       nResult := nResult + (Val(SubS(cNumero,i,1)) * _nAuxVal )
       _nAuxVal:= iif( _nAuxVal == 7, 2, _nAuxVal + 1 )
   Next i

//   nResult:= nResult * 10
   nResult := nResult + 65
   nDC:= MOD(nResult,11)
   		   
	IF nDC <> 0 
   
		Nossonum := 11 - nDC

		IF Nossonum = 10
      		cDig := "P" 
		Else
			cDig := STR(Nossonum,1)
		EndIf   
	
	Else
			
		cDig := "0"
		
	Endif	
/*
   IF nDc > 7
      cDig := "0"
   Else
      cDig := STR(nDc,1)
   EndIF
  */
//   Nossonum := Alltrim(cNumero) + Alltrim(cDig)
	if cDig <> "P"
    	Nossonum := AllTrim(Str(Val(cNumero))) + AllTrim(Str(Val(cDig)))
    else
   		Nossonum := AllTrim(Str(Val(cNumero))) + AllTrim(cDig) 		
    endif
    
   DbSelectArea("SE1")
   RecLock("SE1",.F.)
   SE1->E1_NUMBCO := Nossonum
   MsUnlock()
Else
   NossoNum:= SE1->E1_NUMBCO
EndIf

Return(substr(NossoNum,1,12))       