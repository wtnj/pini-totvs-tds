#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL       
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: Pfat248   ³Autor: DANILO CESAR SESTARI PALA ³ Data: 20091109³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Renumerar itens das dos pedidos do lote                    ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Pini													     ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat248(pPedido)
SetPrvt("CPERG")
cPerg := "FAT001"
Private cQuery := ""
Private cUpdate := ""
Private nContItem := 0
Private cMsg := ""
Private _cArqPath  := GetMv("MV_PATHTMP")
Private cNomeArquivo :=_cArqPath + "LOG_PFAT248.TXT"

/*
MV_PAR01 = DE LOTE
MV_PAR02 = ATE LOTE
MV_PAR03 = DATA DO LOTE DE
MV_PAR04 = DATA DO LOTE ATE
MV_PAR05 = NUMERO DA 1 NOTA FISCAL
*/
                             
if pPedido == "" .or. pPedido == nil
	MsgAlert("Atenção esta rotina RENUMERA os itens dos pedidos do lote")
	If !Pergunte(cPerg)
	   Return
	Endif
	cQuery := "SELECT * FROM "+ RetSqlName("SC5") +" SC5 WHERE C5_FILIAL='"+ XFILIAL("SC5") +"' AND C5_LOTEFAT>='"+ MV_PAR01 +"' AND C5_LOTEFAT<='"+ MV_PAR02 +"' AND C5_DATA>='"+ dtos(MV_PAR03) +"'  AND C5_DATA<='"+ dtos(MV_PAR04) +"' AND SC5.D_E_L_E_T_<>'*' AND C5_SERIE='   ' AND C5_NOTA='         ' ORDER BY C5_NUM"
else
	cQuery := "SELECT * FROM "+ RetSqlName("SC5") +" SC5 WHERE C5_FILIAL='"+ XFILIAL("SC5") +"' AND C5_NUM='"+ pPedido +"' AND SC5.D_E_L_E_T_<>'*' AND C5_SERIE='   ' AND C5_NOTA='         ' ORDER BY C5_NUM"
Endif
	
TCQUERY cQuery NEW ALIAS "PEDIDO"
DbSelectArea("PEDIDO")
DBGOTOP()
WHILE !EOF()       
	nContItem := 1             
	//antes de continuar verificar se ja foi faturado ou liberado algum item!!
	cQuery := "SELECT COUNT(*) as QTDLIB FROM "+ RetSqlName("SC9") +" SC9 WHERE C9_FILIAL='"+ XFILIAL("SC9") +"' AND C9_PEDIDO='"+ PEDIDO->C5_NUM +"' AND SC9.D_E_L_E_T_<>'*'"
	TCQUERY cQuery NEW ALIAS "PEDLIB"
	DbSelectArea("PEDLIB")
	DBGOTOP()
	IF PEDLIB->QTDLIB >= 1
		cMsg += PEDIDO->C5_NUM + ": PEDIDO JA CONTEM ITEM(S) LIBERADO(S)" + chr(13)
	ELSE	
	
		cQuery := "SELECT COUNT(*) AS QTDFAT FROM "+ RetSqlName("SC6") +" SC6 WHERE C6_FILIAL='"+ XFILIAL("SC6") +"' AND C6_NUM='"+ PEDIDO->C5_NUM +"' AND (C6_SERIE <>'   ' OR C6_NOTA<>'         ' OR C6_DATFAT<>'        ' ) AND SC6.D_E_L_E_T_<>'*'"
		TCQUERY cQuery NEW ALIAS "PEDFAT"
		DbSelectArea("PEDFAT")
		DBGOTOP()
		IF PEDFAT->QTDFAT >=1         
			cMsg += PEDIDO->C5_NUM + ": PEDIDO JA CONTEM ITEM(S) FATURADO(S)" + chr(13)		
		ELSE	

			cQuery := "SELECT * FROM "+ RetSqlName("SC6") +" SC6 WHERE C6_FILIAL='"+ XFILIAL("SC6") +"' AND C6_NUM='"+ PEDIDO->C5_NUM +"' AND C6_SERIE ='   ' AND C6_NOTA='         ' AND C6_DATFAT='        ' AND SC6.D_E_L_E_T_<>'*' ORDER BY C6_NUM, C6_ITEM"
			TCQUERY cQuery NEW ALIAS "ITEMPEDIDO"
			DbSelectArea("ITEMPEDIDO")
			DBGOTOP()
			WHILE !EOF()   
				cUpdate := "UPDATE "+ RetSqlName("SC6") +" SET C6_ITEM='"+ strzero(nContItem,2) +"' WHERE C6_FILIAL='"+ xFilial("SC6") +"' AND C6_NUM='" + ITEMPEDIDO->C6_NUM +"' AND C6_ITEM='" + ITEMPEDIDO->C6_ITEM +"' AND R_E_C_N_O_="+ Transform(ITEMPEDIDO->R_E_C_N_O_,"@E 999999999999999")  +" AND D_E_L_E_T_<>'*'"
				TCSQLExec(cUpdate)

				cMsg += PEDIDO->C5_NUM + " "+ITEMPEDIDO->C6_ITEM +" PARA "+ strzero(nContItem,2) + chr(13)
			
				nContItem := nContItem + 1
				DbSelectArea("ITEMPEDIDO")
				DBSkip()
			END
			DbSelectArea("ITEMPEDIDO")
			DbCloseArea()
		ENDIF
	DbSelectArea("PEDFAT")
	DbCloseArea()
			
	ENDIF //PEDLIBERADO
	DbSelectArea("PEDLIB")
	DbCloseArea()
	
	DbSelectArea("PEDIDO")
	DBSkip()
END
DbSelectArea("PEDIDO")
DbCloseArea()           

                                                   

MemoWrit(cNomeArquivo,cMsg)
If pPedido == "" .or. pPedido == nil
	MsgInfo("Gerado arquivo "+ Alltrim(cNomeArquivo))
EndIf
Return