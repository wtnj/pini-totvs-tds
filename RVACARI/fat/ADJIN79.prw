#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch" 
#include "protheus.ch" 

User Function ADJIN79()          

Local cPerg := "ADJIN79"

If !Pergunte(cPerg)
	Return
Endif

SFT->(DBSELECTAREA("SFT"))
SFT->(DBSETORDER(6))
SFT->(DBGOTOP())  

cQuery := " SELECT FT_FILIAL, FT_TIPOMOV, FT_NFISCAL, FT_SERIE, COUNT(FT_ITEM) AS QTDEITEM,FT_VALCONT, FT_ISENICM, FT_PRCUNIT, FT_TOTAL, FT_BASEPIS, FT_BASECOF, SUM(E1_VALOR) AS E1_VALOR" 
cQuery += " FROM "+RETSQLNAME("SFT")+" SFT" 
cQuery += " JOIN "+RETSQLNAME("SE1")+" SE1 ON SE1.D_E_L_E_T_ != '*'"
cQuery += " AND SE1.E1_FILIAL = SFT.FT_FILIAL" 
cQuery += " AND SE1.E1_PREFIXO = SFT.FT_SERIE"  
cQuery += " AND SE1.E1_NUM = SFT.FT_NFISCAL " 
cQuery += " AND SE1.E1_CLIENTE = SFT.FT_CLIEFOR"
cQuery += " AND SE1.E1_LOJA = SFT.FT_LOJA"
cQuery += " WHERE SFT.D_E_L_E_T_ != '*'" 
cQuery += " AND FT_ENTRADA BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' " 
cQuery += " AND FT_SERIE = '21' "
cQuery += " GROUP BY FT_FILIAL, FT_TIPOMOV, FT_NFISCAL, FT_SERIE, FT_VALCONT, FT_ISENICM, FT_PRCUNIT, FT_TOTAL, FT_BASEPIS, FT_BASECOF " 

dbUseArea(.T., "TOPCONN", TCGenQry(, , cQuery), "TRB", .F., .T.)

Do While TRB->(!EOF())
    
		If SFT->(DBSEEK(TRB->FT_FILIAL+TRB->FT_TIPOMOV+TRB->FT_NFISCAL+TRB->FT_SERIE))
	    	
			SFT->(Reclock("SFT", .F.))
			  
			  SFT->FT_VALCONT 	:= TRB->E1_VALOR / TRB->QTDEITEM
			  SFT->FT_ISENICM  	:= TRB->E1_VALOR / TRB->QTDEITEM
			  SFT->FT_PRCUNIT  	:= TRB->E1_VALOR / TRB->QTDEITEM
			  SFT->FT_TOTAL		:= TRB->E1_VALOR / TRB->QTDEITEM
			  SFT->FT_BASEPIS		:= TRB->E1_VALOR / TRB->QTDEITEM
			  SFT->FT_BASECOF		:= TRB->E1_VALOR / TRB->QTDEITEM
			  SFT->FT_VALIMP5		:= TRB->E1_VALOR / TRB->QTDEITEM
			  SFT->FT_VALIMP6  	:= TRB->E1_VALOR / TRB->QTDEITEM
				
			SFT->(msUnLock())
		
		EndIf		
				
	TRB->(DBSKIP())
Enddo     
	
MSGINFO("Processamento OK V2!")
    
	TRB->(DBCLOSEAREA())

Return


User Function ADJFNAT()

SE1->(DBSELECTAREA("SE1"))
SE1->(DBSETORDER(2))
SE1->(DBGOTOP())  

cQuery := " SELECT E1_FILIAL,E1_CLIENTE,E1_LOJA,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO,E1_NATUREZ, Z9_NATBX2 " + CRLF                                                                                             
cQuery += " FROM SE1010 SE1 " + CRLF
cQuery += " JOIN SC5010 SC5 ON SC5.D_E_L_E_T_ != '*' AND SC5.C5_FILIAL = SE1.E1_FILIAL AND SC5.C5_NUM = SE1.E1_PEDIDO AND SC5.C5_CLIENTE = SE1.E1_CLIENTE AND SE1.E1_LOJA = SC5.C5_LOJACLI " + CRLF
cQuery += " JOIN SZ9010 SZ9 ON SZ9.D_E_L_E_T_ != '*' AND SC5.C5_FILIAL = SE1.E1_FILIAL AND SZ9.Z9_TIPOOP = SC5.C5_TIPOOP " + CRLF
cQuery += " WHERE SE1.D_E_L_E_T_ != '*' AND SE1.D_E_L_E_T_ != '*'  AND SE1.E1_EMISSAO >= '20140101' " + CRLF
cQuery += " AND E1_NATUREZ != Z9_NATBX2 " + CRLF
cQuery += " AND E1_PARCELA != 'A' AND E1_SALDO != 0 AND Z9_NATBX2 != ' ' " + CRLF
cQuery += " ORDER BY E1_EMISSAO " + CRLF

dbUseArea(.T., "TOPCONN", TCGenQry(, , cQuery), "TRB", .F., .T.)

Do While TRB->(!EOF())
    
		If SE1->(DBSEEK( TRB->E1_FILIAL + TRB->E1_CLIENTE + TRB->E1_LOJA + TRB->E1_PREFIXO + TRB->E1_NUM + TRB->E1_PARCELA + TRB->E1_TIPO ))
	    	
			SE1->(Reclock("SE1", .F.))
			  
			  SE1->E1_NATUREZ = TRB->Z9_NATBX2
			  
			SE1->(msUnLock())
		
		EndIf		
				
	TRB->(DBSKIP())
Enddo     
	
MSGINFO("Processamento OK FIN1!")
    
	TRB->(DBCLOSEAREA())

Return  

User Function ADJFVLR()

Local _nPar := 0
Local cPerg := "ADJFVLR"

SE1->(DBSELECTAREA("SE1"))
SE1->(DBSETORDER(2))
SE1->(DBGOTOP())  

If !Pergunte(cPerg)
	Return
Endif

cQuery := " SELECT E1_FILIAL,E1_CLIENTE,E1_LOJA,E1_PREFIXO,E1_NUM,E1_TIPO, C5_NUM, C5_EMISSAO, C5_CLIENTE, C5_VLRPED, ROUND(C5_VLRPED /COUNT(SE1.E1_PARCELA),2) E1_VALPARC, COUNT(SE1.E1_PARCELA) AS E1_PARCELAS, C5_VLRPED, SUM(E1_VALOR), " + CRLF
cQuery += " SC5.C5_PARC1, SC5.C5_PARC2,SC5.C5_PARC3,SC5.C5_PARC4,SC5.C5_PARC5,SC5.C5_PARC6,SC5.C5_PARC7,SC5.C5_PARC8,SC5.C5_PARC9,SC5.C5_PARC10,SC5.C5_PARC11,SC5.C5_PARC12 " + CRLF
cQuery += " FROM SC5010 SC5 " + CRLF
cQuery += " JOIN SE1010 SE1 ON SE1.D_E_L_E_T_ != '*' " + CRLF
cQuery += " AND SE1.E1_FILIAL = SC5.C5_FILIAL " + CRLF
cQuery += " AND SE1.E1_NUM = SC5.C5_NOTA  " + CRLF
cQuery += " AND SE1.E1_SERIE = SC5.C5_SERIE " + CRLF
cQuery += " AND SE1.E1_CLIENTE = SC5.C5_CLIENTE " + CRLF
cQuery += " AND SE1.E1_LOJA = SC5.C5_LOJACLI " + CRLF
cQuery += " WHERE SC5.D_E_L_E_T_ != '*'  " + CRLF
cQuery += " AND SC5.C5_EMISSAO BETWEEN '20140425' AND '20140513' " + CRLF
cQuery += " AND SC5.C5_FILIAL = '01' " + CRLF
cQuery += " AND E1_NUM = '"+MV_PAR01+"'  " + CRLF
cQuery += " AND SUBSTR(SC5.C5_NUMEXT,1,3) = '000' " + CRLF
cQuery += " AND E1_FILIAL = '01' " + CRLF
cQuery += " GROUP BY E1_FILIAL,E1_CLIENTE,E1_LOJA,E1_PREFIXO,E1_NUM,E1_TIPO, C5_NUM, C5_EMISSAO, C5_CLIENTE, C5_VLRPED, " + CRLF
cQuery += " SC5.C5_PARC1, SC5.C5_PARC2,SC5.C5_PARC3,SC5.C5_PARC4,SC5.C5_PARC5,SC5.C5_PARC6,SC5.C5_PARC7,SC5.C5_PARC8,SC5.C5_PARC9,SC5.C5_PARC10,SC5.C5_PARC11,SC5.C5_PARC12 " + CRLF
cQuery += " ORDER BY SC5.C5_EMISSAO " + CRLF


dbUseArea(.T., "TOPCONN", TCGenQry(, , cQuery), "TRB", .F., .T.)

	_nPar := TRB->E1_PARCELAS

Do While TRB->(!EOF())
    
	For n := 1 To _nPar
	
		nValor := 0

	If _nPar == 1		
			_cParc := " "
			nValor := TRB->C5_PARC1
	Else
		If n == 1
			_cParc := "A"
			nValor := TRB->C5_PARC1
		ElseIf n == 2
			_cParc := "B"
			nValor := TRB->C5_PARC2
		ElseIf n == 3
			_cParc := "C"          
			nValor := TRB->C5_PARC3
		ElseIf n == 4
			_cParc := "D"          
			nValor := TRB->C5_PARC4
		ElseIf n == 5
			_cParc := "E"          
			nValor := TRB->C5_PARC5
		ElseIf n == 6
			_cParc := "F"          
			nValor := TRB->C5_PARC6
		ElseIf n == 7
			_cParc := "G"          
			nValor := TRB->C5_PARC7
		ElseIf n == 8
			_cParc := "H"          
			nValor := TRB->C5_PARC8
		ElseIf n == 9
			_cParc := "I"          
			nValor := TRB->C5_PARC9
		ElseIf n == 10
			_cParc := "J"          
			nValor := TRB->C5_PARC10
		ElseIf n == 11
			_cParc := "L"          
			nValor := TRB->C5_PARC11
		ElseIf n == 12
			_cParc := "M"          
			nValor := TRB->C5_PARC12
		Else
	   		_cParc := " "          
			nValor := TRB->C5_PARC1
		Endif
	Endif
	  
		If SE1->(DBSEEK( TRB->E1_FILIAL + TRB->E1_CLIENTE + TRB->E1_LOJA + TRB->E1_PREFIXO + TRB->E1_NUM + _cParc + TRB->E1_TIPO )) .And. _cParc == "A"
	    	
	    	If SE1->E1_SALDO == 0	
				SE1->(Reclock("SE1", .F.))
				 	SE1->E1_VALOR	:= nValor
				 	SE1->E1_VALLIQ	:= nValor
				 	SE1->E1_VLCRUZ	:= nValor
				SE1->(msUnLock())
				
				SE5->(DBSELECTAREA("SE5"))
				SE5->(DBSETORDER(7))
				SE5->(DBGOTOP())  
				
				If SE5->(DBSEEK(SE1->E1_FILIAL+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO+SE1->E1_CLIENTE+SE1->E1_LOJA))
					SE5->(Reclock("SE5", .F.))
					 	SE5->E5_VALOR		:= nValor
					 	SE5->E5_VLMOED2		:= nValor
					SE5->(msUnLock())
				EndIf
				                                                                                     
			ElseIf SE1->E1_SALDO != 0	
				SE1->(Reclock("SE1", .F.))
					SE1->E1_SALDO		:= nValor
				 	SE1->E1_VALOR		:= nValor
				 	SE1->E1_VALLIQ		:= nValor
				 	SE1->E1_VLCRUZ		:= nValor
				SE1->(msUnLock())
			EndIf
			
		EndIf
		
		If SE1->(DBSEEK( TRB->E1_FILIAL + TRB->E1_CLIENTE + TRB->E1_LOJA + TRB->E1_PREFIXO + TRB->E1_NUM + _cParc + TRB->E1_TIPO )) .And. _cParc != "A"
	    	
	    	If SE1->E1_SALDO == 0	
				SE1->(Reclock("SE1", .F.))
				 	SE1->E1_VALOR		:= nValor
				 	SE1->E1_VALLIQ		:= nValor
				 	SE1->E1_VLCRUZ		:= nValor
				SE1->(msUnLock())
				
				SE5->(DBSELECTAREA("SE5"))
				SE5->(DBSETORDER(7))
				SE5->(DBGOTOP())  
				
				If SE5->(DBSEEK(SE1->E1_FILIAL+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO+SE1->E1_CLIENTE+SE1->E1_LOJA) )
					SE5->(Reclock("SE5", .F.))
					 	SE5->E5_VALOR		:= nValor
					 	SE5->E5_VLMOED2		:= nValor
					SE5->(msUnLock())
				EndIf
				                                                                                     
			ElseIf SE1->E1_SALDO != 0	
				SE1->(Reclock("SE1", .F.))
					SE1->E1_SALDO		:= nValor
				 	SE1->E1_VALOR		:= nValor
				 	SE1->E1_VALLIQ		:= nValor 
				 	SE1->E1_VLCRUZ		:= nValor 
				SE1->(msUnLock())
			EndIf
			
		EndIf		
				
	Next n			
	TRB->(DBSKIP())
Enddo     
	
MSGINFO("Processamento OK FIN2!")
    
	TRB->(DBCLOSEAREA())

Return