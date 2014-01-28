#include "rwmake.ch"     
#include "protheus.ch"

/* 
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Ptemp2    �Autor  �Danilo C S Pala     � Data �  20090105   ���
�������������������������������������������������������������������������͹��
���Desc.     � 		  ���
���			 |	  													      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � PINI                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function PTEMP2
//if no rateio (d1_rateio) == "1"
//u_pcom001('00042P', 'A  ', '001668','01', 5000.01)


u_ajustevencto('SEN','002887   ','437850','01')
u_ajustevencto('SEN','002888   ','035383','01')
u_ajustevencto('SEN','002891   ','442131','01')
u_ajustevencto('SEN','002898   ','419783','01')
u_ajustevencto('SEN','002899   ','034501','01')
u_ajustevencto('SEN','002900   ','336893','01')
u_ajustevencto('SEN','002901   ','413511','01')
u_ajustevencto('SEN','002902   ','417931','01')
u_ajustevencto('SEN','002905   ','439762','01')
u_ajustevencto('SEN','002906   ','323244','01')

/*Local prefixo := "1  "
Local numero := "035065   "
Local cliente := "331958"
Local loja:= "01"
Local parcela :=" "             
Local historico :="SMARTPAG"
Local juros:=0             
Local desconto := 0
Local mBanco := "CX1"
Local mAgencia := space(5)
Local mConta := space(10)
Local aVetor := {}
lMsErroAuto := .F.
    

	dbSelectArea("SE1")
	dbSetOrder(2)
	//If dbSeek(xFilial("SE1")+SF2->F2_CLIENTE+SF2->F2_LOJA+SF2->F2_SERIE+SF2->F2_DOC,.T.)
	If dbSeek(xFilial("SE1")+cliente+loja+prefixo+numero,.T.)
		aVetor := {{"E1_PREFIXO"	 ,prefixo             ,Nil},;
				{"E1_NUM"		 ,numero           ,Nil},;
				{"E1_PARCELA"	 ,parcela               ,Nil},;
				{"E1_TIPO"	    ,"NF "             ,Nil},;
				{"AUTMOTBX"	    ,"NOR"             ,Nil},;
				{"AUTDTBAIXA"	 ,dDataBase         ,Nil},;
				{"AUTDTCREDITO" ,dDataBase         ,Nil},;
				{"AUTHIST"	    ,historico,Nil},; 
				{"AUTBANCO"	    ,mBanco,Nil},;
				{"AUTAGENCIA"	,mAgencia,Nil},;
				{"AUTCONTA"	    ,mConta,Nil},;
				{"AUTDESCONT"	,desconto    ,Nil },;
				{"AUTJUROS"	    ,juros    ,Nil },;
				{"AUTVALREC"	,SE1->E1_SALDO ,Nil }}

	MSExecAuto({|x,y| fina070(x,y)},aVetor,3) //Inclusao

	If lMsErroAuto
		MOSTRAERRO()
	Endif
Endif

      */


return