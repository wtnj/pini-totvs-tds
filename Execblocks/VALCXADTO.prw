#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VALCXADTO ºAutor  ³Danilo C S Pala     º Data ³  20081203   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ LOCALIZAR O MOVIMENTO DO CAIXINHA DO ADIANTAMENTO E PEGAR O VALOR DA SAIDAº±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PINI                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
                 
//EU_FILIAL + EU_NUM
User Function VALCXADTO(mTIPO, mNUM, mORI)
Local mVALMOV  := 0
Local mCONTAMOV := SPACE(20)
Local mFORNECE := SPACE(6)
Local mNREDUZ := SPACE(20)
Local mCCD := SPACE(9)
Local mCCC := SPACE(9)
Local mREQ := SPACE(12)

DBSELECTAREA("SEU")
DBSETORDER(1)                               
IF DBSEEK(XFILIAL("SEU") + mORI) //EU_FILIAL + EU_NUM
	mVALMOV := SEU->EU_VALOR
	mCONTAMOV := SEU->EU_CONTAD
	mFORNECE := SEU->EU_FORNECE
	mCCD := SEU->EU_CCD
	mCCC := SEU->EU_CCC
	mNREDUZ := posicione("SA2",1,xfilial("SA2")+mFORNECE,"A2_NREDUZ")
	mREQ := SEU->EU_NRCOMP
ELSE                         
	mVALMOV  := 0
	mCONTAMOV := SPACE(20)
	mFORNECE := SPACE(6)
	mNREDUZ := SPACE(20)
	mCCD := SPACE(9)
	mCCC := SPACE(9)
	mREQ := SPACE(12)
ENDIF                           
DBSEEK(XFILIAL("SEU") + mNUM) //DEPOSICIONA O ARQUIVO
IF mTIPO == "V" //VALOR
	return (mVALMOV)
ELSEIF mTIPO == "C" //CONTA
	return (mCONTAMOV)
ELSEIF mTIPO == "F" //FORNECEDOR
	return (alltrim(mNREDUZ))
ELSEIF mTIPO == "D" //CENTRO DE CUSTO DEBITO	
	return (mCCD)
ELSEIF mTIPO == "R" //CENTRO DE CUSTO CREDITO
	return (mCCC)
ELSEIF mTIPO == "Q" //NUMERO DA REQUISICAO
	return (mREQ)
ENDIF