User Function MT103LCF()
Local cCampo:=UPPER(PARAMIXB[1]) 
Local lRet :=.T.
	Do Case	
	Case cCampo == "F1_DESCONT"	     
		lRet = .T.	
	Case cCampo == "F1_FRETE"	     
		lRet = .T.	
	Case cCampo == "F1_DESPESA"	     
		lRet = .T.	
	Case cCampo == "F1_SEGURO"	     
		lRet = .T.
	EndCase 
Return (lRet)