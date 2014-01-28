#INCLUDE "RWMAKE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuPremio บAutor  ณMarcos Farineli     บ Data ณ  24/07/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Atualiza o premio Pini na Tablespace do site               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico Premio Pini                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AtuPremio()

Private cQuery := ""

If !MsgYesNo("Deseja Prosseguir ?","Atualizacao do Premio")
	Return
EndIf

GeraLog()

cQuery += "SELECT SC6.C6_DTFIN , SC6.C6_PEDANT, SC6.C6_ITEMANT"
cQuery += " FROM   SIGAWEB.PREMIO_PINI@PINIWEB PREMIO, SC6010 SC6"
cQuery += " WHERE  SC6.C6_FILIAL = '01'"
cQuery += " AND    SC6.C6_PRODUTO LIKE '01%'"
cQuery += " AND    SC6.C6_PEDANT <> '      '"
cQuery += " AND    SC6.C6_DTFIN >= TO_CHAR(SYSDATE,'YYYYMMDD')"
cQuery += " AND    SC6.C6_DTCANC = '        '"
cQuery += " AND    SC6.C6_DTFIN <> '        '"
cQuery += " AND    SC6.C6_DTFIN <> PREMIO.DT_FIM_ASSIN"
cQuery += " AND    SC6.D_E_L_E_T_ <> '*'"
cQuery += " AND    SC6.C6_PEDANT = PREMIO.COD_ASSINATURA"
cQuery += " AND    SC6.C6_ITEMANT = PREMIO.COMPL_ASSINATURA"
cQuery += " ORDER BY SC6.C6_DTFIN"

If Select("TRB") <> 0
	DbSelectArea("TRB")
	DbCloseArea()
EndIf

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRB", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")

DbSelectArea("TRB")
DbGoTop()

lEnd := .f.

Processa( {|lEnd| AtuProc(@lEnd)}, "Aguarde" ,"Processando...", .T. )

DbSelectArea("TRB")
Copy to &("\siga\relato\mfmf\selatpr.dbf")  VIA "DBFCDXADS" // 20121106 
DbCloseArea()

DbSelectArea("LOGATU")
Copy To &("\siga\relato\mfmf\logatu.dbf")  VIA "DBFCDXADS" // 20121106 
DbCloseArea()

MsgAlert("Finalizado")

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณATUPROC   บAutor  ณMarcos Farineli     บ Data ณ  24/07/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Processamento                                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtuProc()

Private cUpdt := ""

DbSelectArea("TRB")
ProcRegua(RecCount())

While !Eof() .and. !lEnd
	IncProc("Atualizando Pedido "+TRB->C6_PEDANT+"-"+TRB->C6_ITEMANT)
	
	If lEnd
		Exit
	EndIf
	
	cUpdt := "UPDATE SIGAWEB.PREMIO_PINI@PINIWEB SET DT_FIM_ASSIN = '"+TRB->C6_DTFIN + "', FLG_AP5 = 1"
	cUpdt += " WHERE COD_ASSINATURA = '" + TRB->C6_PEDANT + "' AND COMPL_ASSINATURA = '" + TRB->C6_PEDANT + "'"

    If TcSqlExec(cUpdt) < 0
    	DbSelectArea("LOGATU")
    	RecLock("LOGATU",.t.)
    	LOGATU->PEDIDO  := TRB->C6_PEDANT
    	LOGATU->COMPL   := TRB->C6_ITEMANT
    	LOGATU->DTATUAL := TRB->C6_DTFIN
    	LOGATU->ERRO    := "S"
    	MsUnlock()
    Else
		DbSelectArea("LOGATU")
    	RecLock("LOGATU",.t.)
    	LOGATU->PEDIDO  := TRB->C6_PEDANT
    	LOGATU->COMPL   := TRB->C6_ITEMANT
    	LOGATU->DTATUAL := TRB->C6_DTFIN
    	LOGATU->ERRO    := "N"
    	MsUnlock()
    EndIf    	
    
    cUpdt := "COMMIT"
    
    TcSqlExec(cUpdt)
    
    DbSelectArea("TRB")
    DbSkip()
End

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGeralog   บAutor  ณMarcos Farineli     บ Data ณ  24/07/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera arquivo para log                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Geralog()

Private cNomArq, aCampos := {}

AADD(aCampos,{"PEDIDO"    ,"C",6 ,0})
AADD(aCampos,{"COMPL"     ,"C",3 ,0})
AADD(aCampos,{"DTATUAL"   ,"C",8 ,0})
AADD(aCampos,{"ERRO"      ,"C",1 ,0})

cNomArq := CriaTrab(aCampos,.t.)

If Select("LOGATU") <> 0
	DbSelectArea("LOGATU")
	DbCloseArea()
EndIf	

dbUseArea(.T.,, cNomArq,"LOGATU",.F.,.F.)

Return