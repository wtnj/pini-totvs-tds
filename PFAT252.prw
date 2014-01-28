#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPfat252   บAutor  ณDanilo Pala         บ Data ณ  20130417   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ											                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                             
User Function Pfat252()
If sm0->m0_codigo <>'01'
	MsgAlert("Este programa deve ser executado na Editora Pini")
	Return
EndIf

If !MsgYesNo("Este programa faz a migra็ใo das Tabelas de Custo da PSE para Editora."+CHR(13)+"Prosseguir?","Aviso")
	Return
EndIf

cPerg     := "PFAT061"
if !Pergunte(cPerg,.t.)
	return
endif

Processa({||Proc252()} )

Return

Static Function Proc252()
Local cQuery := ""
Local cNum :=""

cQuery := "SELECT DISTINCT C5_NUM, C5_TIPO, C5_DIVVEN, C5_CODPROM, C5_CLIENTE, C5_IDENTIF, C5_LOJAENT, C5_LOJACLI, C5_TIPOCLI, C5_CONDPAG, C5_LOTEFAT, C5_DATA, C5_VLRPED, C5_DESPREM, C5_TIPOOP, C5_DTCALC, C5_VEND1, C5_COMIS1, C5_VEND2, C5_COMIS2, C5_VEND3, C5_COMIS3, C5_VEND4, C5_COMIS4, C5_VEND5, C5_COMIS5, C5_EMISSAO, C5_PARC1, C5_DATA1, C5_PARC2, C5_DATA2, C5_PARC3, C5_DATA3, C5_PARC4, C5_DATA4, C5_PARC5, C5_DATA5, C5_PARC6, C5_DATA6, C5_RESPCOB, C5_RESPCOM, C5_TPFRETE, C5_VOLUME1, C5_ESPECI1, C5_TIPLIB, C5_MENPAD, C5_LIBEROK, C5_OK, C5_SERIE, C5_USUARIO, C5_OBSPED, C5_NUMANT, C5_MOEDA, C5_PESOL, C5_PBRUTO, C5_MENNOTA, C5_PEDORIG, C5_NOTA" 
cQuery += " ,(select sum(e1_valor) valorPago from SE1020 SE1 where e1_filial='01' and e1_pedido=sc6.c6_num and SE1.d_e_l_e_t_<>'*' and e1_baixa<>'      ') as valorPago"
cQuery += " FROM SC6020 SC6 "
cQuery += " LEFT OUTER JOIN SC5020 SC5 ON (SC5.C5_FILIAL='01' AND SC6.C6_NUM = SC5.C5_NUM AND SC6.C6_CLI=SC5.C5_CLIENTE AND SC5.D_E_L_E_T_<>'*')"
cQuery += " LEFT OUTER JOIN SB1010 SB1 ON (SB1.B1_FILIAL='  ' AND SC6.C6_PRODUTO = SB1.B1_COD AND SB1.D_E_L_E_T_<>'*' AND B1_GRUPO<>'0101')"
cQuery += " WHERE C6_FILIAL='01' AND C6_PRODUTO >= '"+ mv_par01 + "' AND C6_PRODUTO <= '" + mv_par02 + "' AND SC6.D_E_L_E_T_<>'*'"
cQuery += " AND C6_EDVENC<>9999 AND C6_EDFIN<>9999 AND C6_EDINIC<>9999 AND C6_EDSUSP>="+ mv_par03 +" AND C6_EDINIC<="+ mv_par03
cQuery += " AND TRIM(C5_IDENTIF)<>'MIGRADO'"
cQuery += " ORDER BY C5_NUM"

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "MIGTAB", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
TcSetField("MIGTAB","C5_DATA"   ,"D")
TcSetField("MIGTAB","C5_DTCALC"   ,"D")
TcSetField("MIGTAB","C5_EMISSAO"   ,"D")
TcSetField("MIGTAB","C5_DATA1"   ,"D")
TcSetField("MIGTAB","C5_DATA2"   ,"D")
TcSetField("MIGTAB","C5_DATA3"   ,"D")
TcSetField("MIGTAB","C5_DATA4"   ,"D")
TcSetField("MIGTAB","C5_DATA5"   ,"D")
TcSetField("MIGTAB","C5_DATA6"   ,"D")
TcSetField("MIGTAB","VALORPAGO"   ,"N",12,2)

DbSelectArea("MIGTAB")
DbGotop()
ProcRegua(Reccount()) 
While !Eof()
	IncProc("Pedido: "+Alltrim(MIGTAB->C5_NUM))
	If MIGTAB->C5_VLRPED < MIGTAB->VALORPAGO
		MsgAlert("Pedido "+ MIGSEL->C5_NUM +" nao foi baixado totalmente")
	Else
	
		//VERIFICAR SE JA FOI IMPORTADO
		cQuery := "SELECT C5_NUM, C5_NUMEXT FROM "+ RetSqlName("SC5") +" SC5 WHERE C5_FILIAL='"+ xfilial("SC5") +"' AND TRIM(C5_NUMEXT)='PSE"+ MIGTAB->C5_NUM+"' AND TRIM(C5_IDENTIF)='PSE' AND D_E_L_E_T_<>'*'"
		DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "MIGSEL", .T., .F. )
		DbSelectArea("MIGSEL")
		DbGotop()
		If !Eof()
			MsgAlert("Pedido "+ MIGSEL->C5_NUMEXT +" jแ migrado para o "+ MIGSEL->C5_NUM)
		Else
	
			DBSelectArea("SC5")
			cNum	:= JobPNPed()
			Begin Transaction
			//SC5
			RECLOCK("SC5",.T.) //insert
			C5_FILIAL := xfilial("SC5")
			C5_NUM := cNum 
			C5_AVESP:= "N"
			C5_NUMEXT := "PSE"+ MIGTAB->C5_NUM
			C5_TIPO := MIGTAB->C5_TIPO
			C5_DIVVEN := MIGTAB->C5_DIVVEN
			C5_CODPROM := MIGTAB->C5_CODPROM
			C5_CLIENTE := MIGTAB->C5_CLIENTE
			C5_IDENTIF := "PSE"
			C5_LOJAENT := MIGTAB->C5_LOJAENT
			C5_LOJACLI := MIGTAB->C5_LOJACLI
			C5_TIPOCLI := MIGTAB->C5_TIPOCLI
			C5_CONDPAG := MIGTAB->C5_CONDPAG
			C5_LOTEFAT := MIGTAB->C5_LOTEFAT
			C5_DATA := MIGTAB->C5_DATA
			C5_VLRPED := MIGTAB->C5_VLRPED
			C5_DESPREM := MIGTAB->C5_DESPREM
			C5_TIPOOP := MIGTAB->C5_TIPOOP
			C5_DTCALC := MIGTAB->C5_DTCALC
			C5_VEND1 := MIGTAB->C5_VEND1
			C5_VEND2 := MIGTAB->C5_VEND2
			C5_VEND3 := MIGTAB->C5_VEND3
			C5_VEND4 := MIGTAB->C5_VEND4
			C5_VEND5 := MIGTAB->C5_VEND5
			C5_EMISSAO := MIGTAB->C5_EMISSAO
			C5_PARC1 := MIGTAB->C5_PARC1
			C5_DATA1 := MIGTAB->C5_DATA1
			C5_PARC2 := MIGTAB->C5_PARC2
			C5_DATA2 := MIGTAB->C5_DATA2
			C5_PARC3 := MIGTAB->C5_PARC3
			C5_DATA3 := MIGTAB->C5_DATA3
			C5_PARC4 := MIGTAB->C5_PARC4
			C5_DATA4 := MIGTAB->C5_DATA4
			C5_PARC5 := MIGTAB->C5_PARC5
			C5_DATA5 := MIGTAB->C5_DATA5
			C5_PARC6 := MIGTAB->C5_PARC6
			C5_DATA6 := MIGTAB->C5_DATA6
			C5_RESPCOB := MIGTAB->C5_RESPCOB
			C5_RESPCOM := MIGTAB->C5_RESPCOM
			C5_TPFRETE := MIGTAB->C5_TPFRETE
			C5_VOLUME1 := MIGTAB->C5_VOLUME1
			C5_ESPECI1 := MIGTAB->C5_ESPECI1
			C5_TIPLIB := MIGTAB->C5_TIPLIB
			C5_MENPAD := MIGTAB->C5_MENPAD
			C5_LIBEROK := MIGTAB->C5_LIBEROK
			C5_OK := MIGTAB->C5_OK
			C5_SERIE := MIGTAB->C5_SERIE
			C5_NOTA := MIGTAB->C5_NOTA
			C5_USUARIO := MIGTAB->C5_USUARIO
			C5_OBSPED := MIGTAB->C5_OBSPED
			C5_NUMANT := MIGTAB->C5_NUMANT
			C5_MOEDA := MIGTAB->C5_MOEDA
			C5_PESOL := MIGTAB->C5_PESOL
			C5_PBRUTO := MIGTAB->C5_PBRUTO
			C5_MENNOTA := MIGTAB->C5_MENNOTA
			C5_PEDORIG := MIGTAB->C5_PEDORIG
			MSUNLOCK()
			
			//IMPORTAR ITENS	
			cQuery := "SELECT C6_FILIAL, C6_ITEM, C6_PRODUTO, C6_UM, C6_DESCRI, C6_QTDVEN, C6_PRCVEN, C6_VALOR, C6_TIPOREV, C6_TES, C6_PEDANT, C6_ITEMANT, C6_EDINIC, C6_EDFIN, C6_QTDENT, C6_QTDENT2, C6_EDVENC, C6_CODDEST, C6_ENTREG, C6_DATFAT, C6_LOCAL, C6_CF, C6_NUMANT, C6_CLI, C6_DESCONT, C6_VALDESC, C6_LOJA, C6_NOTA, C6_SERIE, C6_NUM, C6_COMIS1, C6_COMIS2, C6_COMIS3, C6_COMIS4, C6_COMIS5, C6_PRUNIT, C6_CLASFIS, C6_REGCOT, C6_SUP, C6_SITUAC, C6_EDSUSP, C6_LOTEFAT, C6_DATA, C6_CODISS, C6_DTENVIO, C6_DTCANC, C6_DTINIC, C6_DTFIN, C6_ULTDIF, C6_TPPORTE"
			cQuery += " FROM SC6020 SC5 WHERE C6_FILIAL='01' AND C6_NUM='"+ MIGTAB->C5_NUM +"' AND C6_CLI='"+ MIGTAB->C5_CLIENTE +"' AND D_E_L_E_T_<>'*'"
			cQuery += " ORDER BY C6_NUM, C6_ITEM"
			DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "MIGITEM", .T., .F. )
			TcSetField("MIGITEM","C6_DATA","D")
			TcSetField("MIGITEM","C6_DATFAT","D")
			TcSetField("MIGITEM","C6_ENTREG","D")
			TcSetField("MIGITEM","C6_DTENVIO","D")
			TcSetField("MIGITEM","C6_DTCANC","D")
			TcSetField("MIGITEM","C6_DTINIC","D")
			TcSetField("MIGITEM","C6_DTFIN","D")
			TcSetField("MIGITEM","C6_ULTDIF","D")
			DbSelectArea("MIGITEM")
			DbGotop()
			While !Eof()
				RECLOCK("SC6",.T.) //insert
				C6_FILIAL := XFILIAL("SC6")
				C6_NUM := cNum
				C6_ITEM := MIGITEM->C6_ITEM
				C6_PRODUTO := MIGITEM->C6_PRODUTO
				C6_UM := MIGITEM->C6_UM
				C6_DESCRI := MIGITEM->C6_DESCRI
				C6_QTDVEN := MIGITEM->C6_QTDVEN
				C6_PRCVEN := MIGITEM->C6_PRCVEN
				C6_VALOR := MIGITEM->C6_VALOR
				C6_TIPOREV := MIGITEM->C6_TIPOREV
				C6_TES := "701"
				C6_PEDANT := MIGITEM->C6_PEDANT
				C6_ITEMANT := MIGITEM->C6_ITEMANT
				C6_EDINIC := MIGITEM->C6_EDINIC
				C6_EDFIN := MIGITEM->C6_EDFIN
				C6_QTDENT := MIGITEM->C6_QTDENT
				C6_QTDENT2 := MIGITEM->C6_QTDENT2
				C6_EDVENC := MIGITEM->C6_EDVENC
				C6_CODDEST := MIGITEM->C6_CODDEST
				C6_ENTREG := MIGITEM->C6_ENTREG
				C6_DATFAT := MIGITEM->C6_DATFAT
				C6_LOCAL := MIGITEM->C6_LOCAL
				C6_CF := MIGITEM->C6_CF
				C6_NUMANT := MIGITEM->C6_NUMANT
				C6_CLI := MIGITEM->C6_CLI
				C6_DESCONT := MIGITEM->C6_DESCONT
				C6_VALDESC := MIGITEM->C6_VALDESC
				C6_LOJA := MIGITEM->C6_LOJA
				C6_NOTA := MIGITEM->C6_NOTA
				C6_SERIE := MIGITEM->C6_SERIE
				C6_COMIS1 := MIGITEM->C6_COMIS1
				C6_COMIS2 := MIGITEM->C6_COMIS2
				C6_COMIS3 := MIGITEM->C6_COMIS3
				C6_COMIS4 := MIGITEM->C6_COMIS4
				C6_COMIS5 := MIGITEM->C6_COMIS5
				C6_PRUNIT := MIGITEM->C6_PRUNIT
				C6_CLASFIS := MIGITEM->C6_CLASFIS
				C6_REGCOT := MIGITEM->C6_REGCOT
				C6_SUP := MIGITEM->C6_SUP
				C6_SITUAC := MIGITEM->C6_SITUAC
				C6_EDSUSP := MIGITEM->C6_EDSUSP
				C6_LOTEFAT := MIGITEM->C6_LOTEFAT
				C6_DATA := MIGITEM->C6_DATA
				C6_CODISS := MIGITEM->C6_CODISS
				C6_DTENVIO := MIGITEM->C6_DTENVIO
				C6_DTCANC := MIGITEM->C6_DTCANC 
				C6_DTINIC := MIGITEM->C6_DTINIC 
				C6_DTFIN := MIGITEM->C6_DTFIN 
				C6_ULTDIF := MIGITEM->C6_ULTDIF
				C6_TPPORTE := MIGITEM->C6_TPPORTE
				MSUNLOCK()
			
				DbSelectArea("MIGITEM")
				DbSkip()
			End	
			DbSelectArea("MIGITEM") 
			dbclosearea()
	
			//UPDATE NO PEDIDO DA PSE
			cQuery := "UPDATE SC5020 SET C5_IDENTIF='MIGRADO ' WHERE C5_FILIAL='01' AND C5_NUM='"+ MIGTAB->C5_NUM +"' AND D_E_L_E_T_<>'*'"
			nUpd :=	TCSQLExec(cQuery)

			End Transaction
		EndIf 
		DbSelectArea("MIGSEL") 
		dbclosearea()
	EndIf //nao baixado totalmente
		
	DbSelectArea("MIGTAB")
	DbSkip()
End
dbselectarea("MIGTAB")
dbclosearea()

Return     

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณJobPNPedบAutor  ณDanilo C S Pala Data ณ  20130502   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function JobPNPed()
Private cQuery 		:= ""
Private cNumPed	:= ""
Private lNumPed	:= .F.

WHILE lNumPed == .F.
	DBSelectArea("SC5")
	cNumPed	:= GetSx8Num("SC5")
	ConfirmSX8()
	if cNumPed <> nil
		cQuery := "SELECT count(c5_num) as qtd FROM "+ RETSQLNAME("SC5") +" where C5_FILIAL='"+ XFILIAL("SC5") + "' AND C5_NUM='"+ cNumPed +"' AND D_E_L_E_T_<>'*'"
		DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PINIPAR", .T., .F. )
		DbSelectArea("PINIPAR")
		dbGotop()
		If !EOF()
			if PINIPAR->QTD >=1
				lNumPed	:= .F. //encontrou, pegar o proximo
			else
				lNumPed	:= .T.	
			endif
		Else
			lNumPed	:= .T.
		EndIf    
		DBCloseArea()
	else
		cNumPed := "A41000" //inicializador padrao
		lNumPed	:= .F.
	endif
end
Return Alltrim(cNumPed)