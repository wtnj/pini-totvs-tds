#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT153   ºAutor  ³Danilo C S Pala     º Data ³  06/12/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Atualiza o_publ->D_proced para o pfat152                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Pfat153

Private _cTitulo  := "Atualiza arquivo de Orgaos Publicos"
Private _ccMens1  := "Fonte: \siga\arqass\o_publ.dbf"
Private cProcedimento := space(1)
Private nValorAss := 0
// lParc_ refere-se aos pagamentos, se .F. foi pago!
Private lParcA := .F.
Private lParcB := .F.
Private lParcC := .F.
Private lParcD := .F.
Private lParcE := .F.
Private lParcF := .F.
Private lParcG := .F.
Private lParcH := .F.
Private lParcI := .F.
Private lParcJ := .F.
Private lParcK := .F.
Private lParcL := .F.
Private lParcM := .F.
Private lParcN := .F.
Private lParcO := .F.
Private lParcP := .F.
Private lParcQ := .F.
Private lParcR := .F.
Private lParcS := .F.
Private lParcT := .F.
Private lParcU := .F.
Private lParcW := .F.
Private lParcX := .F.
Private lParcY := .F.
Private lParcZ := .F.
Private lParcAA := .F.
Private lParcBB := .F.
Private lParcCC := .F.
Private nContaA := 0
Private nContaB := 0
Private nContaC := 0
Private nContaD := 0
Private cMsgFinal := space(200)


@ 010,001 TO 120,220 DIALOG oDlg TITLE _cTitulo
@ 005,010 SAY _ccMens1
@ 030,020 BMPBUTTON TYPE 1 ACTION Processa({||Iniciar()})
@ 030,060 BMPBUTTON TYPE 2 ACTION ( Close(oDlg) )
Activate Dialog oDlg CENTERED

Return




//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao que inicia o processamento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function Iniciar()

DBUSEAREA(.T.,,"\SIGA\ARQASS\O_PUBL.DBF","OPUBL",.F.,.F.)
DbSElectArea("OPubl")
cIndex  := CriaTrab(nil,.f.)
cChave  := "ID"
cFiltro := ""
IndRegua("OPubl",cIndex,cChave,,cFiltro,"Indexando ...")
Dbgotop()
ProcRegua(Reccount())
While !Eof()
	
	// Verificando pagamentos
	If ( OPUBL->ZZ6_DTPGA = CTOD("  /  /  "))
		lParcA := .T.
	endif
	if ( OPUBL->ZZ6_DTPGB = CTOD("  /  /  ") )
		lParcB := .T.
	endif
	if ( OPUBL->ZZ6_DTPGC = CTOD("  /  /  ") )
		lParcC := .T.
	endif
	if ( OPUBL->ZZ6_DTPGD = CTOD("  /  /  "))
		lParcD := .T.
	endif
	if ( OPUBL->ZZ6_DTPGE = CTOD("  /  /  "))
		lParcE := .T.
	endif
	if ( OPUBL->ZZ6_DTPGF = CTOD("  /  /  "))
		lParcF := .T.
	endif
	if ( OPUBL->ZZ6_DTPGG = CTOD("  /  /  "))
		lParcG := .T.
	endif
	if ( OPUBL->ZZ6_DTPGH = CTOD("  /  /  "))
		lParcH := .T.
	endif
	if ( OPUBL->ZZ6_DTPGI = CTOD("  /  /  "))
		lParcI := .T.
	endif
	if ( OPUBL->ZZ6_DTPGJ = CTOD("  /  /  "))
		lParcJ := .T.
	endif
	if ( OPUBL->ZZ6_DTPGK = CTOD("  /  /  "))
		lParcK := .T.
	endif
	if ( OPUBL->ZZ6_DTPGL = CTOD("  /  /  "))
		lParcL := .T.
	endif
	if ( OPUBL->ZZ6_DTPGM = CTOD("  /  /  "))
		lParcM := .T.
	endif
	if ( OPUBL->ZZ6_DTPGN = CTOD("  /  /  "))
		lParcN := .T.
	endif
	if ( OPUBL->ZZ6_DTPGO = CTOD("  /  /  "))
		lParcO := .T.
	endif
	if ( OPUBL->ZZ6_DTPGP = CTOD("  /  /  "))
		lParcP := .T.
	endif
	if ( OPUBL->ZZ6_DTPGQ = CTOD("  /  /  "))
		lParcQ := .T.
	endif
	if ( OPUBL->ZZ6_DTPGR = CTOD("  /  /  "))
		lParcR := .T.
	endif
	if ( OPUBL->ZZ6_DTPGS = CTOD("  /  /  "))
		lParcS := .T.
	endif
	if ( OPUBL->ZZ6_DTPGT = CTOD("  /  /  "))
		lParcT := .T.
	endif
	if ( OPUBL->ZZ6_DTPGU = CTOD("  /  /  "))
		lParcU := .T.
	endif
	if ( OPUBL->ZZ6_DTPGV = CTOD("  /  /  "))
		lParcV := .T.
	endif
	if ( OPUBL->ZZ6_DTPGW = CTOD("  /  /  "))
		lParcW := .T.
	endif
	if ( OPUBL->ZZ6_DTPGX = CTOD("  /  /  "))
		lParcX := .T.
	endif
	if ( OPUBL->ZZ6_DTPGY = CTOD("  /  /  "))
		lParcY := .T.
	endif
	if ( OPUBL->ZZ6_DTPGZ = CTOD("  /  /  "))
		lParcZ := .T.
	endif
	if ( OPUBL->ZZ6_DTPGAA = CTOD("  /  /  "))
		lParcAA := .T.
	endif
	if ( OPUBL->ZZ6_DTPGBB = CTOD("  /  /  "))
		lParcBB := .T.
	endif
	if ( OPUBL->ZZ6_DTPGCC = CTOD("  /  /  "))
		lParcCC := .T.
	endif
	
	//boletos sem vencimento nem pagamento: cProcedimento := "C"
	IF ((OPUBL->ZZ6_VENCA = CTOD("  /  /  ")) .AND. lParcA .AND. ;
		(OPUBL->ZZ6_VENCB = CTOD("  /  /  ")) .AND. lParcB .AND.  ;
		(OPUBL->ZZ6_VENCC = CTOD("  /  /  ")) .AND. lParcC .AND.  ;
		(OPUBL->ZZ6_VENCD = CTOD("  /  /  ")) .AND. lParcD .AND.  ;
		(OPUBL->ZZ6_VENCE = CTOD("  /  /  ")) .AND. lParcE .AND.  ;
		(OPUBL->ZZ6_VENCF = CTOD("  /  /  ")) .AND. lParcF .AND.  ;
		(OPUBL->ZZ6_VENCG = CTOD("  /  /  ")) .AND. lParcG .AND.  ;
		(OPUBL->ZZ6_VENCH = CTOD("  /  /  ")) .AND. lParcH .AND.  ;
		(OPUBL->ZZ6_VENCI = CTOD("  /  /  ")) .AND. lParcI .AND.  ;
		(OPUBL->ZZ6_VENCJ = CTOD("  /  /  ")) .AND. lParcJ .AND.  ;
		(OPUBL->ZZ6_VENCK = CTOD("  /  /  ")) .AND. lParcK .AND.  ;
		(OPUBL->ZZ6_VENCL = CTOD("  /  /  ")) .AND. lParcL .AND.  ;
		(OPUBL->ZZ6_VENCM = CTOD("  /  /  ")) .AND. lParcM .AND.  ;
		(OPUBL->ZZ6_VENCN = CTOD("  /  /  ")) .AND. lParcN .AND.  ;
		(OPUBL->ZZ6_VENCO = CTOD("  /  /  ")) .AND. lParcO .AND.  ;
		(OPUBL->ZZ6_VENCP = CTOD("  /  /  ")) .AND. lParcP .AND.  ;
		(OPUBL->ZZ6_VENCQ = CTOD("  /  /  ")) .AND. lParcQ .AND.  ;
		(OPUBL->ZZ6_VENCR = CTOD("  /  /  ")) .AND. lParcR .AND.  ;
		(OPUBL->ZZ6_VENCS = CTOD("  /  /  ")) .AND. lParcS .AND.  ;
		(OPUBL->ZZ6_VENCT = CTOD("  /  /  ")) .AND. lParcT .AND.  ;
		(OPUBL->ZZ6_VENCU = CTOD("  /  /  ")) .AND. lParcU .AND.  ;
		(OPUBL->ZZ6_VENCV = CTOD("  /  /  ")) .AND. lParcV .AND.  ;
		(OPUBL->ZZ6_VENCW = CTOD("  /  /  ")) .AND. lParcW .AND.  ;
		(OPUBL->ZZ6_VENCX = CTOD("  /  /  ")) .AND. lParcX .AND.  ;
		(OPUBL->ZZ6_VENCY = CTOD("  /  /  ")) .AND. lParcY .AND.  ;
		(OPUBL->ZZ6_VENCZ = CTOD("  /  /  ")) .AND. lParcZ .AND.  ;
		(OPUBL->ZZ6_VENCAA = CTOD("  /  /  ")) .AND. lParcAA .AND. ;
		(OPUBL->ZZ6_VENCBB = CTOD("  /  /  ")) .AND. lParcBB .AND. ;
		(OPUBL->ZZ6_VENCCC = CTOD("  /  /  ")) .AND. lParcCC )
		cProcedimento := "C"
		Atualiza()
		nContaC++
		
		
		
		// boletos sem nenhum pagamento Proced := "D"
	ELSEIF (lParcA .AND. lParcB .AND. lParcC .AND. lParcD .AND. lParcE .AND. lParcF .AND. ;
		lParcG .AND. lParcH .AND. lParcI .AND. lParcJ .AND. lParcK .AND. lParcL .AND. ;
		lParcM .AND. lParcN .AND. lParcO .AND. lParcP .AND. lParcQ .AND. lParcR .AND. ;
		lParcS .AND. lParcT .AND. lParcU .AND. lParcV .AND. lParcW .AND. lParcX .AND. ;
		lParcY .AND. lParcZ .AND. lParcAA .AND. lParcBB .AND. lParcCC )
		cProcedimento := "D"
		Atualiza()
		nContaD++
	ELSE
		// totalmente pagos proced : = "A"
		nValorAss := OPUBL->ZZ6_VLASS
		if ( !lParcA .AND. OPUBL->ZZ6_VALOA = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcB .AND. OPUBL->ZZ6_VALOB = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcC .AND. OPUBL->ZZ6_VALOC = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcD .AND. OPUBL->ZZ6_VALOD = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcE .AND. OPUBL->ZZ6_VALOE = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcF .AND. OPUBL->ZZ6_VALOF = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcG .AND. OPUBL->ZZ6_VALOG = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcH .AND. OPUBL->ZZ6_VALOH = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcI .AND. OPUBL->ZZ6_VALOI = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcJ .AND. OPUBL->ZZ6_VALOJ = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcK .AND. OPUBL->ZZ6_VALOK = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcL .AND. OPUBL->ZZ6_VALOL = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcM .AND. OPUBL->ZZ6_VALOM = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcN .AND. OPUBL->ZZ6_VALON = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcO .AND. OPUBL->ZZ6_VALOO = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcP .AND. OPUBL->ZZ6_VALOP = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcQ .AND. OPUBL->ZZ6_VALOQ = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcR .AND. OPUBL->ZZ6_VALOR = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcS .AND. OPUBL->ZZ6_VALOS = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcT .AND. OPUBL->ZZ6_VALOT = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcU .AND. OPUBL->ZZ6_VALOU = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcV .AND. OPUBL->ZZ6_VALOV = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcW .AND. OPUBL->ZZ6_VALOW = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcX .AND. OPUBL->ZZ6_VALOX = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcY .AND. OPUBL->ZZ6_VALOY = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcZ .AND. OPUBL->ZZ6_VALOZ = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcAA .AND. OPUBL->ZZ6_VALOAA = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcBB .AND. OPUBL->ZZ6_VALOBB = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
		elseif ( !lParcCC .AND. OPUBL->ZZ6_VALOCC = nValorAss)
			cProcedimento := "A"
			Atualiza()
			nContaA++
			
			
			// tem pelo menos um paga com valor <> do valorAss Procedimento := "B"
		ELSE
			cProcedimento := "B"
			Atualiza()
			nContaB++
		ENDIF
	ENDIF
	
	limparVariaveis()
	DBSkip()
	IncProc()
end
DBSelectArea("OPubl")
DbCloseArea("OPubl")
cMsgFinal := "Processamento finalizado! Atualizados: A: " + Alltrim(Str(nContaA))
cMsgFinal += ", B: " + Alltrim(Str(nContaB)) + ", C: " + Alltrim(Str(nContaC))
cMsgFinal += ", D: " + Alltrim(Str(nContaD))
MsgAlert( cMsgFinal)

return



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao para atualizar o_publ    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function Atualiza()
RecLock("OPUBL",.F.) //update .F.
OPUBL->D_PROCED := cProcedimento
MsUnlock()
return


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Procedimento para limpar o conteudo das variaveis³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function LimparVariaveis()
cProcedimento := ""
nValorAss := 0
lParcA := .F.
lParcB := .F.
lParcC := .F.
lParcD := .F.
lParcE := .F.
lParcF := .F.
lParcG := .F.
lParcH := .F.
lParcI := .F.
lParcJ := .F.
lParcK := .F.
lParcL := .F.
lParcM := .F.
lParcN := .F.
lParcO := .F.
lParcP := .F.
lParcQ := .F.
lParcR := .F.
lParcS := .F.
lParcT := .F.
lParcU := .F.
lParcW := .F.
lParcX := .F.
lParcZ := .F.
lParcAA := .F.
lParcBB := .F.
lParcCC := .F.
return
