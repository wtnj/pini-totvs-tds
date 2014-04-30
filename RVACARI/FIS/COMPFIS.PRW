#include "protheus.ch"  
#include "rwmake.ch"                                                                                                                           
#include "Topconn.ch"  

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³COMPFISE º Autor ³ Douglas Silva      º  Data ³  20/03/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Este fonte como objetivo ajustar os complementos das Notas º±±
±±º          ³ Fiscais Serie 21 Geração do SPED PIS COFINS                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±    
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function COMPFIS()
                                   
	Processa( {|lEnd| COMPFIS1()}, "Aguarde...","Incluindo os complementos fiscal NF21...", .T. )
	
Return

Static Function COMPFIS1
	
Local cPerg	:= "COMPFIS"
      
SFX->(DBSELECTAREA("SFX"))
SFX->(DBSETORDER(1))

SFT->(DBSELECTAREA("SFT"))
SFT->(DBSETORDER(1))     

////////////////////////////////////////////////////////////////////////////////////////////////////
// Perguntas do Programa Padrão                                                           		  //
////////////////////////////////////////////////////////////////////////////////////////////////////     

Pergunte(cPerg,.T.) // Pergunta no SX1

////////////////////////////////////////////////////////////////////////////////////////////////////
// Queri para consulta das notas gerada, dentro do periodo determinado no paramentro     		  //
////////////////////////////////////////////////////////////////////////////////////////////////////     

cQuery := "SELECT * " 
cQuery += "FROM "+RETSQLNAME("SFT") +" SFT "
cQuery += "WHERE SFT.D_E_L_E_T_ != '*' " 
cQuery += "AND FT_ENTRADA BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' "  
cQuery += "AND FT_SERIE = '21' "  
cQuery += "AND NOT EXISTS (SELECT FX_DOC FROM SFX010 SFX WHERE SFX.FX_DOC = SFT.FT_NFISCAL AND SFX.FX_SERIE = SFT.FT_SERIE AND SFT.FT_PRODUTO = SFX.FX_COD AND SFT.FT_ITEM = SFX.FX_ITEM)"
cQuery += "ORDER BY SFT.FT_NFISCAL "  

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRB", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")

Do While TRB->(!EOF())
    
 				//FX_FILIAL+FX_TIPOMOV+FX_SERIE+FX_DOC+FX_CLIFOR+FX_LOJA+FX_ITEM+FX_COD
	//If ! SFT->(DBSEEK(TRB->FT_FILIAL + "S" + TRB->FT_SERIE + TRB->FT_NFISCAL + TRB->FT_CLIEFOR + TRB->FT_LOJA + TRB->FT_ITEM + TRB->FT_PRODUTO))
		    
		Reclock("SFX",.T.)
			SFX->FX_FILIAL 	:= TRB->FT_FILIAL
			SFX->FX_TIPOMOV	:= "S"		
			SFX->FX_DOC		:= TRB->FT_NFISCAL
			SFX->FX_SERIE		:= TRB->FT_SERIE
			SFX->FX_CLIFOR	:= TRB->FT_CLIEFOR
			SFX->FX_LOJA		:= TRB->FT_LOJA
			SFX->FX_ITEM		:= TRB->FT_ITEM
			SFX->FX_COD		:= TRB->FT_PRODUTO
			SFX->FX_CLASCON	:= "99"
			SFX->FX_CLASSIF	:= "99"
			SFX->FX_TIPOREC	:= "0"
			SFX->FX_RECEP		:= TRB->FT_CLIEFOR
			SFX->FX_LOJAREC	:= TRB->FT_LOJA
			SFX->FX_TIPSERV	:= "9"
			SFX->FX_DTINI		:= STOD(TRB->FT_EMISSAO)
			SFX->FX_DTFIM		:= STOD(TRB->FT_EMISSAO)
			SFX->FX_PERFIS	:= SUBSTR(DTOS(MV_PAR01),5,2) + SUBSTR(DTOS(MV_PAR01),1,4)
			SFX->FX_TPASSIN	:= "1"
			SFX->FX_GRPCLAS	:= "01"
		MSUnLock()		
	
	//EndIf
	
TRB->(dbskip())
Enddo
     
TRB->(DBCLOSEAREA())     
     
MsgInfo("Concluido")

Return