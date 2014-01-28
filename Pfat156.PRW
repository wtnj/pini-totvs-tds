#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT156   ºAutor  ³Danilo C S Pala     º Data ³  23/06/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Atualiza OPubl_B.DBF identificar erro no proced = "B"      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Pfat156

Private _cTitulo  := "Orgaos Publicos"
Private _ccMens1  := "Fonte: \siga\arqass\opubl_b.dbf"
Private cTexto1 := "Resolver A"
Private cProcedimento := space(1)
Private nValorAss := 0
Private nValorPago := 0
Private nContaA := 0
Private nContaB := 0
Private nContaE := 0
Private nContaSC5 := 0
Private nContaNao := 0
Private cMsgFinal := space(200)


@ 010,001 TO 120,220 DIALOG oDlg TITLE _cTitulo
@ 005,010 SAY _ccMens1
@ 030,020 BMPBUTTON TYPE 1 ACTION Processa({||Iniciar()})
@ 030,060 BMPBUTTON TYPE 2 ACTION ( Close(oDlg) )
@ 045,040 BUTTON cTexto1 SIZE 40,11 ACTION Processa({||Resolver()})
Activate Dialog oDlg CENTERED

Return



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao que inicia o processamento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function Iniciar()

DBUSEAREA(.T.,,"\SIGA\ARQASS\OPUBL_B.DBF","OPUBL",.F.,.F.)
DbSElectArea("OPubl")
cIndex  := CriaTrab(nil,.f.)
cChave  := "ID"
cFiltro := ""
IndRegua("OPubl",cIndex,cChave,,cFiltro,"Indexando ...")
Dbgotop()
ProcRegua(Reccount())
While !Eof()
	
	nValorAss := OPUBL->ZZ6_VLASS
	// Verificando pagamentos
	If ( OPUBL->ZZ6_DTPGA <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOA
	endif
	if ( OPUBL->ZZ6_DTPGB <> stod("") )
		nValorPago := nValorPago + OPUBL->ZZ6_VALOB
	endif
	if ( OPUBL->ZZ6_DTPGC <> stod("") )
		nValorPago := nValorPago + OPUBL->ZZ6_VALOC
	endif
	if ( OPUBL->ZZ6_DTPGD <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOD
	endif
	if ( OPUBL->ZZ6_DTPGE <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOE
	endif
	if ( OPUBL->ZZ6_DTPGF <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOF
	endif
	if ( OPUBL->ZZ6_DTPGG <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOG
	endif
	if ( OPUBL->ZZ6_DTPGH <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOH
	endif
	if ( OPUBL->ZZ6_DTPGI <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOI
	endif
	if ( OPUBL->ZZ6_DTPGJ <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOJ
	endif
	if ( OPUBL->ZZ6_DTPGK <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOK
	endif
	if ( OPUBL->ZZ6_DTPGL <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOL
	endif
	if ( OPUBL->ZZ6_DTPGM <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOM
	endif
	if ( OPUBL->ZZ6_DTPGN <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALON
	endif
	if ( OPUBL->ZZ6_DTPGO <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOO
	endif
	if ( OPUBL->ZZ6_DTPGP <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOP
	endif
	if ( OPUBL->ZZ6_DTPGQ <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOQ
	endif
	if ( OPUBL->ZZ6_DTPGR <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOR
	endif
	if ( OPUBL->ZZ6_DTPGS <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOS
	endif
	if ( OPUBL->ZZ6_DTPGT <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOT
	endif
	if ( OPUBL->ZZ6_DTPGU <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOU
	endif
	if ( OPUBL->ZZ6_DTPGV <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOV
	endif
	if ( OPUBL->ZZ6_DTPGW <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOW
	endif
	if ( OPUBL->ZZ6_DTPGX <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOX
	endif
	if ( OPUBL->ZZ6_DTPGY <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOY
	endif
	if ( OPUBL->ZZ6_DTPGZ <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOZ
	endif
	if ( OPUBL->ZZ6_DTPGAA <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOAA
	endif
	if ( OPUBL->ZZ6_DTPGBB <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOBB
	endif
	if ( OPUBL->ZZ6_DTPGCC <> stod(""))
		nValorPago := nValorPago + OPUBL->ZZ6_VALOCC
	endif
	
	IF nValorPago = nValorAss
		// totalmente pagos proced : = "A"
		cProcedimento := "A"
		Atualiza()
		nContaA++
		// tem pelo menos um paga com valor < do valorAss Procedimento := "B"
	ELSEIF nValorPago > nValorAss
		cProcedimento := "E"
		Atualiza()
		nContaE++
	ELSE
		cProcedimento := "B"
		Atualiza()
		nContaB++
	ENDIF
	limparVariaveis()
	DBSkip()
	IncProc()
end
DBSelectArea("OPubl")
DbCloseArea("OPubl")
cMsgFinal := "Processamento finalizado! Atualizados: A: " + Alltrim(Str(nContaA))
cMsgFinal += ", B: " + Alltrim(Str(nContaB))+" e E: " + Alltrim(Str(nContaE))
MsgAlert( cMsgFinal)

return



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao para atualizar o_publ    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function Atualiza()
RecLock("OPUBL",.F.) //update .F.
OPUBL->D_PROCED := cProcedimento
OPUBL->VALOR_PAGO := nValorPago
MsUnlock()
return


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Procedimento para limpar o conteudo das variaveis³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function LimparVariaveis()
cProcedimento := ""
nValorAss := 0
nValorPago := 0
return


Static Function Resolver()

DBSelectArea("SC5")
DBSetORder(1)

DBUSEAREA(.T.,,"\SIGA\ARQASS\OP_B_A2.DBF","OP_B_A",.F.,.F.)
DbSElectArea("OP_B_A")
cIndex  := CriaTrab(nil,.f.)
cChave  := "ID"
cFiltro := ""
IndRegua("OP_B_A",cIndex,cChave,,cFiltro,"Indexando ...")   
DBSelectArea("OP_B_A")
Dbgotop()
ProcRegua(Reccount())
While !Eof()
	NovoPedido := OP_B_A->NOVO_PED
	
	if Len(AllTrim(NovoPedido)) < 1
		// nao processar
		nContaNao++
	else 
		DBSelectArea("SC5")
		DbSeek(xfilial("SC5")+NovoPedido)
		RecLock("SC5",.F.) //update .F.
		SC5->C5_PARC1 := 0
		SC5->C5_DATA1 := stod("")
		SC5->C5_PARC2 := 0
		SC5->C5_DATA2 := stod("")
		SC5->C5_PARC3 := 0
		SC5->C5_DATA3 := stod("")
		SC5->C5_PARC4 := 0
		SC5->C5_DATA4 := stod("")
		SC5->C5_PARC5 := 0
		SC5->C5_DATA5 := stod("")
		SC5->C5_PARC6 :=  0
		SC5->C5_DATA6 := stod("")
		MsUnlock()
		nContaSC5++
	endif
	//limparVariaveis
	NovoPedido := 0
	IncProc()
	DBSelectArea("OP_B_A")
	DBSkip()
end

DBSelectArea("SC5")
DBCloseArea("SC5")
DBSelectArea("OP_B_A")
DbCloseArea("OP_B_A")
cMsgFinal := "Atualizados: " + Alltrim(Str(nContaSC5)) +", nao atualizados: " +  Alltrim(Str(nContaNao))
MsgAlert( cMsgFinal)

return
