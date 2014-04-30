#INCLUDE "protheus.CH"
User Function LPSA601()
// ALTERACAO DA CONTA CONTAB DOS CARTOES DE CREDITO, ANDRE/JOSE RICARDO, Danilo C S Pala 20040903
//Alteracao da conta contab de debito ANDRE/JOSE RICARDO, Danilo C S Pala 20040928
//20080909 Alterado por Danilo C S Pala: e1_naturez = CI
//Alterado por Danilo C S Pala em 20110704: SMARTPAG
//Alterado por Danilo C S Pala em 20110718: JOSE RICARDO/MARCIA DEB A IDENTIFICAR
//Alterado por Danilo C S Pala em 20111208: V ELECTRON e M MAESTRO
//Danilo C S Pala em 20130411:  Feicon2013
Local mcta  := space(20) // ''
Local aArea := GetArea()
If ALLTRIM(SE1->E1_ORIGEM)=="LOJA010" .AND. EMPTY(SE1->E1_PEDIDO) // daqui 20130411
	If alltrim(SE1->E1_TIPO)=="CH"
		MCTA := '21080202002'
	ElseIf alltrim(SE1->E1_TIPO)=="R$"
		MCTA := '21080202001'
	ElseIf alltrim(SE1->E1_TIPO)=="CC"
		MCTA := '21080202003'
	ElseIf alltrim(SE1->E1_TIPO)=="CD"
		MCTA := '21080202003'
	Else
		MCTA := ''
	Endif
Else  // ate aqui 20130411
	If Empty(SE1->E1_PORTADO)   
		IF (subs(SE1->E1_NATUREZ,1,2) $ "CA/CM/CV/CI") .or. alltrim(SE1->E1_NATUREZ)=="V ELECTRON" .or. alltrim(SE1->E1_NATUREZ)=="M MAESTRO"//20040903  //20080909 //20111208
   			MCTA:='21080202003'  //20040903
		ELSEIF (subs(SE1->E1_NATUREZ,1,2) $ "CH") //20040928
			MCTA:='21080202002'  //20040928
		ELSEIF (subs(SE1->E1_NATUREZ,1,3) $ "DEP/DH /DP /BX ") //20040928
			MCTA:='21080202001'  //20040928
		ELSEIF ALLTRIM(SE1->E1_NATUREZ) ==	'SMARTPAG' //20110704
			MCTA:='21080202005'
		ELSE                  
			MCTA:='21080202001' //20110718
    	END IF
	Else   
	   dbselectarea("SA6") 
	   DBGOTOP()
	   dbsetorder(1)
	   dbseek(xfilial("SA6")+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA)        
	   If Found()
      		MCTA:=SA6->A6_CONTA 
	   Endif
	Endif
Endif
RestArea(aArea)

RETURN(MCTA)