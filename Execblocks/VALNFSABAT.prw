#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VALNFSABATºAutor  ³Danilo C S Pala     º Data ³  20110629   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ LOCALIZAR O TITULO NO CONTAS A receber e pega o valor do   º±±
±±º          ³ pis ou cofins a abater                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
                 
//E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
User Function VALNFSABAT(mPREFIXO, mNUM, mEmissao, mTributo)
Local mValRet  := 0
Local mTIPO := "NF "
//mPREFIXO := "COM"

if (SD2->D2_SERIE=='UNI' .OR. TRIM(SD2->D2_SERIE)=='D1' .OR. SD2->D2_SERIE=='CUP' .OR. SD2->D2_SERIE=='CFS' .OR.SD2->D2_SERIE=='CFA' .OR. SD2->D2_SERIE=='PUB' .OR. SD2->D2_SERIE=='CFB' .OR. SD2->D2_SERIE=='CFC' .OR. SD2->D2_SERIE=='CFD' .OR. SD2->D2_SERIE=='ANG' .OR. SD2->D2_SERIE=='CFE' .OR. SD2->D2_SERIE=='NFS' .OR. SD2->D2_SERIE=='SEN' .OR. SD2->D2_SERIE=='STD' .OR. SD2->D2_SERIE=='ECF' .OR. SD2->D2_SERIE=='1  ' .OR. SD2->D2_SERIE=='8  ' .OR. SD2->D2_SERIE=='4  ')
	DBSELECTAREA("SE1")
	DBSETORDER(1)                               
	IF DBSEEK(XFILIAL("SE1") + mPREFIXO + mNUM + " " + mTIPO) ////E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
		IF mEMISSAO == SE1->E1_EMISSAO
			If mTributo=="PIS"
				mValRet  := SE1->E1_SABTPIS
			Elseif mTributo=="COFINS"
				mValRet  := SE1->E1_SABTCOF
			Elseif mTributo=="CSLL"
				mValRet  := SE1->E1_SABTCSL
			Else
				mValRet  := 0
			EndIf
		ELSE
			mValRet  := 0		
		ENDIF
	ELSE //dbseek1
		IF DBSEEK(XFILIAL("SE1") + mPREFIXO + mNUM + "A" + mTIPO) ////E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
			IF mEMISSAO == SE1->E1_EMISSAO
				If mTributo=="PIS"
					mValRet  := SE1->E1_SABTPIS
				Elseif mTributo=="COFINS"
					mValRet  := SE1->E1_SABTCOF
				Elseif mTributo=="CSLL"
					mValRet  := SE1->E1_SABTCSL
				Else
					mValRet  := 0
				EndIf
			ELSE
				mValRet  := 0		
			ENDIF
		ELSE //dbseek2
			mValRet  := 0
		ENDIF
	ENDIF //dbseek1

	mValRet := ROUND((SD2->D2_TOTAL/SF2->F2_VALMERC) * mValRet,2)
endif //serie


return (mValRet)