#INCLUDE "rwmake.ch"
#include "Protheus.ch"
#INCLUDE "ap5mail.ch"
#INCLUDE "TbiConn.ch"
#INCLUDE "TopConn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EDVERCHV  º Autor ³ Rodolfo Vacari     º Data ³  07/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Schedule para verificar se as NF´s de Entrada são validas  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ED. Pini                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/   

User Function EDVERCHV(aEmp)

Local _cQuery := ""                       
Local _aRetNFe  

If !Empty(aEmp)
	PREPARE ENVIRONMENT EMPRESA aEmp[1] FILIAL aEmp[2] MODULO "EST"                        
Else
	aEmp := {SM0->M0_CODIGO, SM0->M0_CODFIL}	
EndIf	
Private _cTo      := GetNewPar("MV_XERRNF", "rodolfo@rvacari.com.br")

_cQuery := "SELECT DISTINCT F1_DOC, F1_SERIE, F1_FORNECE, A2_NOME, F1_LOJA, F1_EMISSAO, F1_DTDIGIT, F1_VALMERC, F1_TIPO, F1_CHVNFE "
_cQuery += "FROM "+RetSqlName("SF1")+" F1 LEFT JOIN "+RetSqlName("SA2")+" A2 "
_cQuery += "ON F1_FORNECE = A2_COD AND F1_LOJA = A2_LOJA AND F1.D_E_L_E_T_ = '' AND A2.D_E_L_E_T_ = '' "
_cQuery += "WHERE F1_DTDIGIT BETWEEN '"+DtoS(dDataBase-6)+"' AND '"+DtoS(dDataBase)+"' AND F1_ESPECIE = 'SPED' "
//_cQuery += "WHERE F1_DTDIGIT = '20120728' AND F1_ESPECIE = 'SPED' " //TESTE PARA O JUAREZ
_cQuery += "AND F1_FORMUL <> 'S' AND F1_CHVNFE <> '' AND F1_TIPO = 'N' "
_cQuery += "UNION ALL "
_cQuery += "SELECT DISTINCT F1_DOC, F1_SERIE, F1_FORNECE, A1_NOME, F1_LOJA, F1_EMISSAO, F1_DTDIGIT, F1_VALMERC, F1_TIPO, F1_CHVNFE "
_cQuery += "FROM "+RetSqlName("SF1")+" F1 LEFT JOIN "+RetSqlName("SA1")+" A1 "
_cQuery += "ON F1_FORNECE = A1_COD AND F1_LOJA = A1_LOJA AND F1.D_E_L_E_T_ = '' AND A1.D_E_L_E_T_ = '' "
_cQuery += "WHERE F1_DTDIGIT BETWEEN '"+DtoS(dDataBase-6)+"' AND '"+DtoS(dDataBase)+"' AND F1_ESPECIE = 'SPED' "
_cQuery += "AND F1_FORMUL <> 'S' AND F1_CHVNFE <> '' AND F1_TIPO = 'D' "
_cQuery += "ORDER BY F1_DOC, F1_SERIE "
TCQUERY _cQuery NEW ALIAS "QRY"
        
cMsg := ""
cMsg := '<span style="font-size: 70%"><h1>Inconsistência</h1></span><br><table><tr><th>Nota Fiscal</th><th>Emissao</th><th>Data Digitacao</th><th>Hora</th><th>Fornecedor</th><th>Chave NF-e</th><th>Empresa</th><th>Inconsistencia</th></tr>"
		
dbSelectArea("QRY")
dbGoTop()
While !EOF()
	_aRetNFe := U_ConNFeKey(ALLTRIM(QRY->F1_CHVNFE))
	
	If _aRetNFe[3] <> "100"		                 
		                                                  
    	cMsg += "<tr><td>"+QRY->F1_DOC+"/"+QRY->F1_SERIE+"</td>"
		cMsg += "<td>"+Dtoc(Stod(QRY->F1_EMISSAO))+" </td>"
		cMsg += "<td>"+Dtoc(Stod(QRY->F1_DTDIGIT))+"</td>"
		cMsg += "<td>"+Time()+"</td>"
		cMsg += "<td>"+QRY->F1_FORNECE+"-"+QRY->F1_LOJA+"</td>"						
		cMsg += "<td>"+ALLTRIM(QRY->F1_CHVNFE)+"</td>"						
		cMsg += "<td>"+alltrim(SM0->M0_FILIAL)+"</td>"
		cMsg += "<td  WIDTH=600px>" + _aRetNFe[3] + " -  " + AllTrim(_aRetNFe[4])+"</td></tr>"

	EndIf            
	
	dbSelectArea("QRY")
	QRY->(DBSKIP())
EndDo                                                                                                        
                                                                                                                                                                        
cMsg += "</table>"
U_MailNotify(_cTo,"","Inconsistência ao Validar a NF de Entrada---->Verifique!",{cMsg},{},.T.)                                                         		
wfNotSF1()

Return                                                                                                       

//Funcao para enviar email de notificacao de xml recebido sem nota lancada no sistema
Static Function wfNotSF1()
Local cAlias := GetNextAlias()                  
Local cHtml := '<htm><body><table><tr><th>Nota</th><th>Serie</th><th>Fornecedor/ Cliente</th><th>Emissao</th><th aling="right">Valor</th></tr>'
Local dDataAte := Dtos(dDataBase - &(SUPERGETMV("MV_XDTXMLE",.F.,"{3,30}"))[1])
Local dDataDe := Dtos(dDataBase - &(SUPERGETMV("MV_XDTXMLE",.F.,"{3,30}"))[2])
Local cTo := SuperGetMv("MV_XEMXMLE",.F., "rodolfo@rvacari.com.br")    
Local cCNPJ := Left(SM0->M0_CGC, 8)       
Local lSend := .F.               
      
BeginSql Alias cAlias    

%noparser% 
SELECT DISTINCT * FROM (
SELECT ZY9_NOTA, ZY9_SERIE, ZY9_EMISSA, CASE WHEN A2_COD IS NULL THEN A1_COD ELSE A2_COD END CODIGO,
CASE WHEN A2_LOJA IS NULL THEN A1_LOJA ELSE A2_LOJA END LOJA, CASE WHEN A2_NOME IS NULL THEN A1_NOME ELSE A2_NOME END NOME,
CASE WHEN A2_COD IS NULL THEN 'CLIENTE' ELSE 'FORNECEDOR' END ORIGEM, ZY9_VALOR FROM %Table:ZY9% ZY9
LEFT JOIN %Table:SA1% A1
ON ZY9_CNPJEM = A1_CGC AND A1.%notdel%
LEFT JOIN %Table:SA2% A2
ON ZY9_CNPJEM = A2_CGC AND A2.%notdel%
WHERE ZY9_EMISSA BETWEEN %Exp:dDataDe% AND %Exp:dDataAte%
AND LEFT(ZY9_CNPJDE, 8) = %Exp:cCNPJ% AND ZY9.%notdel%
AND ZY9_NOTA + ZY9_SERIE + ZY9_CNPJEM NOT IN(
	SELECT F1_CHVNFE FROM %Table:SF1% WHERE F1_EMISSAO BETWEEN %Exp:dDataDe% AND %Exp:dDataAte% AND %notDel%)
)AUX
ORDER BY ZY9_EMISSA, CODIGO, ZY9_NOTA

EndSql            

dbSelectArea(cAlias)
lSend := !Eof()
While !Eof()
    cHtml += "<tr><td>"+ (cAlias)->ZY9_NOTA + "</td><td>" + (cAlias)->ZY9_SERIE + "</td><td>" + (cAlias)->CODIGO + "/" + (cAlias)->LOJA + " - " + (cAlias)->NOME + "</td><td>" + DTOC(Stod((cAlias)->ZY9_EMISSA)) + '</td><td align="right">' + Transform((cAlias)->ZY9_VALOR, "@E 999,999,999.99") + "</td></tr>"
	dbSkip()
EndDo

(cAlias)->(dbCloseArea())

cHtml += "</table></body></html>"
               
If lSend                                       
	U_MailNotify(cTo,"","XML recepcionado sem nota cadastrada - " + AllTrim(SM0->M0_FILIAL),{cHtml},{},.F.)
EndIf
Return