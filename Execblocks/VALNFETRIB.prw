#include "rwmake.ch" 
#INCLUDE "TOPCONN.CH"  //consulta SQL
//Danilo Pala 20100316: consultar titulo pai
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VALNFETRIB�Autor  �Danilo C S Pala     � Data �  20081208   ���
�������������������������������������������������������������������������͹��
���Desc.     � LOCALIZAR O TITULO DO TRIBUTO ESPECIFICADO IR/PIS/COFINS/CSLL���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � COMPRAS                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
                 
//E2_FILIAL + E2_PREFIXO + E2_NUM + E2_PARCELA + E2_TIPO + E2_FORNECE + E2_LOJA
User Function VALNFETRIB(mPREFIXO, mNUM, mEMISSAO, mTRIBUTO, cFORNECE, cLOJA)
Local mVALTRIBUTO  := 0
Local mPARCELA := SPACE(1)
Local mNATUREZA := SPACE(10)
Local mTIPO := SPACE(3)
Local mFORNECE := "UNIAO "
Local mLOJA := "00"
Private cQuery :=""

IF mTRIBUTO == "IR"
	mPARCELA := "1"
	mNATUREZA := "IRF"
	mTIPO := "TX "        
	mFORNECE := "UNIAO "
ELSEIF mTRIBUTO == "PIS"
	mPARCELA := "2"
	mNATUREZA := "PIS"
	mTIPO := "TX "      
	mFORNECE := "UNIAO "
ELSEIF mTRIBUTO == "PIS"
	mPARCELA := "2"
	mNATUREZA := "PIS"
	mTIPO := "TX "      
	mFORNECE := "UNIAO "
ELSEIF mTRIBUTO == "COFINS"
	mPARCELA := "3"
	mNATUREZA := "COFINS"
	mTIPO := "TX "      
	mFORNECE := "UNIAO "
ELSEIF mTRIBUTO == "CSLL"
	mPARCELA := "4"
	mNATUREZA := "CSLL"
	mTIPO := "TX "      
	mFORNECE := "UNIAO "
ELSEIF mTRIBUTO == "ISS"
	mPARCELA := "1"
	mNATUREZA := "ISS"
	mTIPO := "ISS"     
	mFORNECE := "000701" //20081212
	mLOJA := "01"
ELSEIF mTRIBUTO == "INSS"
	mPARCELA := "1"
	mNATUREZA := "INSS"
	mTIPO := "INS"  
	mFORNECE := "INSS  "
ELSEIF mTRIBUTO == "ICMS"
	mPARCELA := "4"
	mNATUREZA := "CSLL"
	mTIPO := "TX "      
	mFORNECE := "UNIAO "
ENDIF


/*DBSELECTAREA("SE2")
DBSETORDER(1)                               
IF DBSEEK(XFILIAL("SE2") + mPREFIXO + mNUM + mPARCELA + mTIPO + mFORNECE + mLOJA) ////E2_FILIAL + E2_PREFIXO + E2_NUM + E2_PARCELA + E2_TIPO + E2_FORNECE + E2_LOJA
	IF mEMISSAO == SE2->E2_EMISSAO   .and. ALLTRIM(SE2->E2_NATUREZ) == ALLTRIM(mNATUREZA)
		mVALTRIBUTO := SE2->E2_VALOR
	ELSE
		mVALTRIBUTO := 0		
	ENDIF
ELSE                         
	mVALTRIBUTO := 0
ENDIF*/            

cQuery := "SELECT E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_FORNECE, E2_LOJA, E2_VALOR, E2_EMISSAO, E2_NATUREZ FROM "+ RetSqlName("SE2") +" SE2 WHERE E2_FILIAL='"+ XFILIAL("SE2") +"' AND E2_NUM='"+ mNUM +"' AND E2_TIPO ='"+ mTIPO +"' AND E2_FORNECE ='"+ mFORNECE +"' AND E2_TITPAI='"+ mPREFIXO + mNUM + " NF " + cFORNECE + cLOJA +"' AND E2_NATUREZ='"+ mNATUREZA +"' AND SE2.D_E_L_E_T_<>'*'" //AND E2_LOJA='"+ mLOJA +"'  //AND E2_PREFIXO ='"+ mPREFIXO  +"'
TCQUERY cQuery NEW ALIAS "SE2TRIB"
TcSetField("SE2TRIB","E2_EMISSAO"   ,"D")
DbSelectArea("SE2TRIB")
DBGOTOP()
IF !eof()
	IF mEMISSAO == SE2TRIB->E2_EMISSAO   .and. ALLTRIM(SE2TRIB->E2_NATUREZ) == ALLTRIM(mNATUREZA)
		mVALTRIBUTO := SE2TRIB->E2_VALOR
	ELSE
		mVALTRIBUTO := 0		
	ENDIF
ELSE                         
	mVALTRIBUTO := 0
ENDIF     
DbCloseArea("SE2TRIB")


return (mVALTRIBUTO)