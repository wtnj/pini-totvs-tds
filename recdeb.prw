#INCLUDE "RWMAKE.CH"
/*/
//Alterado por Danilo C S Pala em 20050520: CFB
//Alterado por Danilo C S Pala em 20070315: CFE
//Alterado por Danilo C S Pala em 20070328: NFS
//Alterado por Danilo C S Pala em 20080220: SEN
//Alterado por Danilo C S Pala em 20081031: STD
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �RECDEB    � Autor �SOLANGE NALINI         � Data � 22/12/01 ���
�������������������������������������������������������������������������Ĵ��
���Descricao �EXECBLOCK --> RETORNA A CONTA DE DEBITA PARA O LANCAMENTO   ���
���          �---------     PADRAO NA CONTABILIZA��O DA BAIXA DO TITULO   ���
�������������������������������������������������������������������������Ĵ��
���Observacao�Chamado atraves do Lancto Padrao 520-01                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function RecDeb()

Local mctadeb := 'DEBITO'

IF ALLTRIM(SE1->E1_SERIE) $ "UNI/CUP/D1/LIV/ASS/CFS/CFA/CFB/ANG/CFE/SEN/STD/8"     //20050520: CFB //20061031 ANG  //20070315 CFE //20080220 SEN //20081031 STD
	DO CASE
		CASE ALLTRIM(SE5->E5_MOTBX) == "NOR"
			MCTADEB := SA6->A6_CONTA
		CASE ALLTRIM(SE5->E5_MOTBX) == "CAN" .AND. ALLTRIM(SE1->E1_SERIE) $ "UNI/CUP/D1 /CFS/CFA/CFB/ANG/CFE/NFS/SEN/8"   //20050520 CFB //20061031 ANG //20070315 CFE //20070328 NFS //20080220 SEN
			IF SUBS(SE1->E1_GRPROD,1,2) $ '01/02/07'
				MCTADEB := "31020102002"              //VENDA CANCELADA
			ELSE
				MCTADEB := "42020101007"              //REVERSAO DO FATURAMENTO
			ENDIF
		CASE ALLTRIM(SE5->E5_MOTBX) == "LP" .AND. ALLTRIM(SE1->E1_SERIE) $ "UNI/CUP/D1 /CFS/CFA/CFB/ANG/CFE/NFS/SEN/8" //20050520 CFB //20061031 ANG //20070315 CFE //20070328 NFS //20080220 SEN
			MCTADEB := "42020101003"
	ENDCASE
ELSE
	IF ALLTRIM(SE1->E1_TIPO) == "CH" .and. !SE1->(Eof())
		IF ALLTRIM(SE5->E5_MOTBX) == "NOR"
			MCTADEB := SA6->A6_CONTA
		ENDIF
		IF ALLTRIM(SE5->E5_MOTBX) == "CAN"
			MCTADEB := "11020101003"
		ENDIF
	ENDIF
ENDIF

RETURN(MCTADEB)