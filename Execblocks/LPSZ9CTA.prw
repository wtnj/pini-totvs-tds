#INCLUDE "RWMAKE.CH"
/*/
//Alterado por Danilo C S Pala em 20130325: Sigaloja Feicon
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LPSZ9CTA  ºAutor  ³DANILO C S PALA     º Data ³  20110816   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ RETORNA A CONTA CONTABIL DA 1 OU DEMAIS PARCELAS/NATUREZA  º±±
±±º          ³ DO TIPO DE OPERACAO  									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LPSZ9CTA(cTipo)
Local mCta  := ''
Local aArea := GetArea()
Local cQuery := "" //20130325

IF ALLTRIM(SF2->F2_ESPECIE)=="CF" .AND. !EMPTY(SF2->F2_PDV) .AND. !EMPTY(SF2->F2_ECF) //20130325 
	cQuery := "select e1_naturez, e1_valor, e1_num, e1_prefixo, e1_emissao from " + RetSqlName("SE1") + " where e1_filial='" + xFilial("SE1") + "' and e1_prefixo='"+ SF2->F2_SERIE +"' and e1_num='"+ SF2->F2_DOC +"' and e1_emissao='"+ DTOS(SF2->F2_EMISSAO) +"'"
	if cTipo =="1"
		cQuery := cQuery + " and (e1_parcela=' ' or e1_parcela='A')"
	else
		cQuery := cQuery + " and (e1_parcela<>' ' and e1_parcela<>'A')"
	endif
	if EMPTY(SF2->F2_DTLANC)
		cQuery := cQuery + " and d_e_l_e_t_<>'*'"
	endif
	
	DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PINICR", .T., .F. )
	DbSelectArea("PINICR")
	dbGotop()
	If !EOF()
		IF alltrim(PINICR->E1_NATUREZ) =="CHEQUE"
			mCta := "11020101003         "
		ELSEIF alltrim(PINICR->E1_NATUREZ) =="CARTAO"
			mCta := "11020001004         "
		ELSEIF alltrim(PINICR->E1_NATUREZ) =="DINHEIRO"
			mCta := "11020101008         "
		ELSE
			mCta := ""
		ENDIF
	Else
		mCta := ""
	EndIf   
	DBCloseArea()
	
ELSE
	dbselectarea("SC5") 
	//DBGOTOP()
	dbsetorder(1)
	If dbseek(xfilial("SC5")+sd2->d2_pedido)     

		dbselectarea("SZ9") 
		//DBGOTOP()
		DBSETORDER(1)
		If DBSEEK(XFILIAL("SZ9")+SC5->C5_TIPOOP)
			if cTipo =="1"
				mCta :=SZ9->Z9_CONTA1
			elseif cTipo =="2"
				mCta :=SZ9->Z9_CONTA2
				if empty(MCTA)
					mCta :=SZ9->Z9_CONTA1
				endif
			else
				mCta :=SZ9->Z9_CONTA1
			endif
		Endif
	Endif
ENDIF

RestArea(aArea)
RETURN(mCta)