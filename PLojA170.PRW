#INCLUDE "LOJA170.CH"
#INCLUDE "rwmake.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o	 � LojA170	� Autor � Fernando Godoy	    � Data � 16/10/96 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Leitura X 							            		  ���
�������������������������������������������������������������������������Ĵ��
��� Uso		 � Generico 									              ���
�������������������������������������������������������������������������Ĵ��
���  DATA  � BOPS �Program.� MOTIVO DA ALTERACAO	                      ���
�������������������������������������������������������������������������Ĵ��
���02/07/99�21073A�Lucas & � Homologa��o Imp. Fiscal Epson TM-300AF ARG.  ���
���        �      �Fernades�                                              ���
���15/02/00�      �Kleber  � Homologa��o Imp. Fiscal Procomp ECF-IF/2011. ���
���13/03/00�Melhor�A.Veiga �Exclusao das chamadas a CriaAgente()          ���
���15/07/00�Melhor�A.Veiga �Alteracao na comunicacao com os ECFs (via DLL)���
���10/08/00�MELHOR�Marcos  �LjGetStation(), parametros da Estacao         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function PLojA170()

//�����������������������Ŀ
//� Define Variaveis      �
//�������������������������
LOCAL nOpca := 0,cBase := ""
LOCAL oDlg
Local   cImpressora := LJGetStation("IMPFISC")

If MsgYesNo("Confirma Impressao de Leitura X?","Confirme")
	nOpca := IIF(lj170OK(),1,0)
Else
	nOpca := 0
EndIf

If nOpca == 1
	Processa({|lEnd| lj170Leitura()})
Endif

Return