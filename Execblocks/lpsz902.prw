#INCLUDE "RWMAKE.CH"
//Alterado por Danilo C S Pala em 20070813: alterar cc para lucros e perdas
//Danilo C S Pala em 20110817: tipo de operacao com 2 naturezas e contas contabeis
//Danilo C S Pala em 20130411:  Feicon2013 
User Function LPSZ902()

Local mcta  := ''
Local aArea := GetArea()

IF (SM0->M0_CODIGO ='03' .AND. SE1->E1_PORTADO='904') .OR. (SM0->M0_CODIGO ='02' .AND. SE1->E1_PORTADO='920') //20070813
	MCTA := '31020102002'
ELSE
	If (SE1->E1_PREFIXO =="ECF" .OR. SE1->E1_PREFIXO =="EC1") .AND. ALLTRIM(SE1->E1_ORIGEM)=="LOJA701" .AND. EMPTY(SE1->E1_PEDIDO) // daqui 20130411
		If alltrim(SE1->E1_TIPO)=="CH"
			MCTA := '11020101003'
		ElseIf alltrim(SE1->E1_TIPO)=="R$"
			MCTA := '11020101008'
		ElseIf alltrim(SE1->E1_TIPO)=="CC"
			MCTA := '11020001004'
		Else
			MCTA := ''
		Endif
	Else  // ate aqui 20130411
		dbselectarea("sc5") 
		DBGOTOP()
		dbsetorder(1)
		dbseek(xfilial("SC5")+SE1->E1_PEDIDO)     

		dbselectarea("SZ9") 
		DBGOTOP()
		DBSETORDER(1)
		If DBSEEK(XFILIAL("SZ9")+SC5->C5_TIPOOP)
		   if SE1->E1_PARCELA=' ' .OR. SE1->E1_PARCELA='A'
				MCTA := SZ9->Z9_CONTA1
		   else
		   		MCTA := SZ9->Z9_CONTA2
	   			if empty(MCTA)
	   				MCTA := SZ9->Z9_CONTA1
	   			endif
			endif
		Endif
	Endif //20130411
ENDIF

RestArea(aArea)

RETURN(MCTA)