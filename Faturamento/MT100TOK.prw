 #INCLUDE "rwmake.ch"
#include "Protheus.ch"
#INCLUDE "ap5mail.ch"
#INCLUDE "TbiConn.ch"
#INCLUDE "TopConn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT100TOK  º Autor ³ Rodolfo Vacari     º Data ³  07/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ed. Pini                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/   

User Function MT100TOK

//mig Local _cAliasZA := GetNextAlias()
//mig Local _cCNPJ := Iif(cTipo $ "D|B", GetAdvfVal("SA1","A1_CGC",xFilial("SA1") + ca100for + cloja, 1, ""),;
//mig	 GetAdvfVal("SA2","A2_CGC",xFilial("SA2") + ca100for + cloja, 1, ""))    
//mig Local _aRetNFe 	 
//mig Local _cValidNfe := ""
//mig Local _aArea := GetArea()  
//mig Local _lPoder3 := .F. 
//mig //Local _cPosCFOP := aScan(aHeader, { |x| Alltrim(x[2]) == "D1_CF"})
//mig Local cOPBar := space(06)
//migPrivate aRPt 	 := {}
 //migPrivate _nOpcOP := .F.           
              
_lRet := .T.               

//Valida o XML                                      
//mig U_EPValSPED(l103auto) 	

Return


//Funcao para validar o ZY9
User Function EPValSPED(_lAuto)

Local _cAliasZY := GetNextAlias()
Local _cCNPJ := Iif(cTipo $ "D|B", GetAdvfVal("SA1","A1_CGC",xFilial("SA1") + ca100for + cloja, 1, ""),;
	 GetAdvfVal("SA2","A2_CGC",xFilial("SA2") + ca100for + cloja, 1, ""))    
Local _aRetNFe 	 
Local _cValidNfe := ""
Local _aArea := GetArea()
          
If !(cTipo $ "D|B") .And. SA2->A2_COD == ca100for .And. SA2->A2_LOJA == cloja  .And. SA2->A2_XXML == "S" .And. !(AllTrim(cEspecie) $ "SPED|CTE")
	MsgStop("O fornecedor: " + AllTrim(SA2->A2_NREDUZ) + " utiliza documentos eletrônicos, esta espécie é inválida", "cESPECIE")
	Return .F.
EndIf	
//verifica se o xml esta na base para preencher o campo F1_CHVNFE             
dbUseArea(.T.,"TOPCONN",TcGenQry(,,"SELECT ZY9_CHVNFE, ZY9_NFOK, ZY9_CANCEL FROM "+RetSQlName("ZY9") + " ZY9 WHERE ZY9_NOTA = '"+cNFiscal+"' "+;
		"AND ZY9_SERIE = '"+cSerie+"' AND ZY9_CNPJDE = '"+SM0->M0_CGC+"' AND ZY9_CNPJEM = '"+_cCNPJ+"' AND D_E_L_E_T_ = '' "), _cAliasZY,.T.,.F.)
TcSetField(_cAliasZY,"ZY9_NFOK","L",1,0)
TcSetField(_cAliasZY,"ZY9_CANCELA","L",1,0)
                                                                                           
If !(_cAliasZY)->(Eof()) .And. !(_cAliasZY)->ZY9_NFOK .And. !(_cAliasZY)->ZY9_CANCELA
	If FunName() $ "MATA100|MATA103"
		aNfeDanfe[13] := (_cAliasZY)->ZY9_CHVNFE		
	EndIf
	_cValidNfe    := (_cAliasZY)->ZY9_CHVNFE		
		
EndIf  
(_cAliasZY)->(dbCloseArea())
RestArea(_aArea)

//Valida se a chave esta preenchida e se é valida para o SEFAZ
If AllTrim(cEspecie) == "SPED|CTE" .And. ALLTRIM(cformul) == "N" .And. !Empty(_cValidNfe) .AND. SA2->A2_EST <> "PR" //.AND. alltrim(cTipo) <> 'D'
    _aRetNFe := U_ConNFeKey(_cValidNfe)
	If AllTrim(_aRetNFe[3]) != "100"
		If !_lAuto
			MsgStop("A nota fiscal não é válida junto ao SEFAZ. Contate o departamento fiscal","INVALIDNFE")
		Else
			AutoGrLog("A nota fiscal não é válida junto ao SEFAZ. Contate o departamento fiscal")	
		Endif                                                           		
	EndIf	
ElseIf AllTrim(cEspecie) $ "SPED|CTE" .And. ALLTRIM(cformul) == "N" .And. Empty(_cValidNfe) //.AND. alltrim(cTipo) <> 'D'
	If !_lAuto
		MsgInfo('Danfe não possui arquivo .XML, "Entre em contato com o Depto. Fiscal", você não conseguirá incluir esta nota',"NONFEKEY")
	Else
		AutoGrLog('Danfe não possui arquivo .XML "Entre em contato com o Depto. Fiscal"')	
	EndIf	 
	Return .F.     
EndIf 	

Return .T.