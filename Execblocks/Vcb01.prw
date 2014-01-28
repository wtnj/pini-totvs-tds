#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
/*
//20070524 Danilo C S Pala: SC5->C5_TPTRANS == "12"
//Danilo C S Pala 20100305: ENDBP
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VCB01     ºAutor  ³Microsiga           º Data ³  03/27/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o endereco para o boleto                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Vcb01()
Local aArea := GetArea()

SetPrvt("MEND,MBAIRRO,MCEP,MCIDADE,MESTADO,")



DbselectArea("SC5")
DbSetOrder(1)
DbSeek(xFilial("SC5")+SE1->E1_PEDIDO)
If Trim(SC5->C5_DIVVEN) == "PUBL" .AND. (SC5->C5_TPTRANS == "04" .OR. SC5->C5_TPTRANS == "12") .AND. !EMPTY(SC5->C5_CODAG) //20070524 SC5->C5_TPTRANS == "12"
	DbselectArea("SA1")
	DbSetOrder(1)
	DBSEEK(XFILIAL()+SC5->C5_CODAG+SC5->C5_LOJACLI)
	IF SUBS(SA1->A1_ENDCOB,1,1)=='S'
		DbSelectArea("SZ5")
		DbSetOrder(1)
		If DbSeek(XFilial()+SC5->C5_CODAG)
			mEnd := SZ5->Z5_END
		ELSE
			mEnd := SA1->A1_END
		ENDIF
	ELSE
		mEnd := SA1->A1_END
	ENDIF
Else
	DbSelectArea("SA1")
	DbSetOrder(1)
	DbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA)
	
	//20100305 DAQUI
	IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
		DbSelectArea("ZY3")
		DbSetOrder(1)
		DbSeek(xFilial("ZY3")+SA1->A1_COD+SA1->A1_LOJA, .F. )
		mEnd    :=ZY3_END
		mBairro :=ZY3_BAIRRO
		mCidade    :=ZY3_CIDADE
		mEstado    :=ZY3_ESTADO
		mCep    :=ZY3_CEP
	ELSEIF SUBS(SA1->A1_ENDCOB,1,1)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
		DbselectArea("SZ5")
		DbsetOrder(1)
		DbSeek(xFilial("SZ5")+SA1->A1_COD+SA1->A1_LOJA)
		MEND    := SZ5->Z5_END
		MBAIRRO := SZ5->Z5_BAIRRO
		MCEP    := SZ5->Z5_CEP
		MCIDADE := SZ5->Z5_CIDADE
		MESTADO := SZ5->Z5_ESTADO
	Else
		MEND    := SA1->A1_END
		MBAIRRO := SA1->A1_BAIRRO
		MCEP    := SA1->A1_CEP
		MCIDADE := SA1->A1_MUN
		MESTADO := SA1->A1_EST
	EndIf
EndIf

If Empty(mEnd)
	mEnd := Space(40)
EndIf

RestArea(aArea)

Return(mEnd)