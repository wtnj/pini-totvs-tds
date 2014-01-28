#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFat155   ºAutor  ³Danilo C S Pala     º Data ³  16/06/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Segunda-feria, novos alteracoes dos pedidos de orgaos publi-º±±
±±º          ³ cos da tmkt para pini Revistas: Cm e Au                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Pfat155

Private _cTitulo  := "Converte Orgaos Publicos da TMKT para o AP5"
Private _ccMens1  := "Fonte: \siga\arqass\OPTMKT.dbf" 
Private _ccMens2  := "Revistas: CM e AU"
Private cID := space(6)
Private cCodCliente := space(6)
Private cEndPrincipal := space(40)
Private lExisteDestinatario := .F.
Private cCodDest := space(6)
Private cNumeroPedido := 282730
Private nContaSC5 := 0
Private nContaSC6 := 0
Private nContaNAO := 0
Private nContaA := 0
Private nContaB := 0
Private nContaC := 0
Private nContaD := 0
Private cMsgFinal := space(200)
Private cVencimento := space(10)
Private cCodProduto
SetPRvt("_cDtInic, _cDtFin")



@ 010,001 TO 120,220 DIALOG oDlg TITLE _cTitulo
@ 005,010 SAY _ccMens1  
@ 015,010 SAY _ccMens2  
@ 035,010 BMPBUTTON TYPE 1 ACTION Processa({||Iniciar()})
@ 035,060 BMPBUTTON TYPE 2 ACTION ( Close(oDlg) )
Activate Dialog oDlg CENTERED

Return




//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao que inicia o processamento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function Iniciar()
DBUSEAREA(.T.,,"\SIGA\ARQASS\DEST.DBF","DEST",.F.,.F.)
DbSElectArea("DEST")
cIndex  := CriaTrab(nil,.f.)
cChave  := "ID"
cFiltro := ""
IndRegua("DEST",cIndex,cChave,,cFiltro,"Indexando ...")
Dbgotop()


DBUSEAREA(.T.,,"\SIGA\ARQASS\OPTMKT.DBF","OPUBL",.F.,.F.)
DbSElectArea("OPubl")
cIndex  := CriaTrab(nil,.f.)
cChave  := "ID"
cFiltro := ""
IndRegua("OPubl",cIndex,cChave,,cFiltro,"Indexando ...")
Dbgotop()
ProcRegua(Reccount())
While !Eof()  
	if (ALLTRIM(OPUBL->NOVO_PED) = "") .AND. (ALLTRIM(OPUBL->ZZ6_STATUS) <> "C")
		cID := OPubl->ID
		cCodCliente := ALLTRIM(OPubl->zz6_cod)
		DBSelectArea("DEST")
		DbSeek(cID)    
		cCodDest := ALLTRIM(DEST->ZZ6_CODDEST)
		InserirSC5()
		InserirSC6()
		cNumeroPedido++                          
	else               
		nContaNAO++
	endif
	limparVariaveis()
	DBSelectArea("OPubl")
	DBSkip()
	IncProc()
end

DBSelectArea("OPubl")
DbCloseArea("OPubl")
cMsgFinal := "Processamento finalizado! Atualizados: SC5: " + Alltrim(Str(nContaSC5))
cMsgFinal += ", SC6: " + Alltrim(Str(nContaSC6)) + " e NAO: " + Alltrim(Str(nContaNAO)) 
cMsgFinal += "|| A: " + Alltrim(Str(nContaA)) + ",  B: " + Alltrim(Str(nContaB))
cMsgFinal += ", C: " + Alltrim(Str(nContaC)) + " e D: " + Alltrim(Str(nContaD))
MsgAlert( cMsgFinal)
return


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Procedimento para inserir o Pedido³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function InserirSC5()
DBselectArea("SC5")
RecLock("SC5",.T.) //inserir .T.
SC5->C5_FILIAL := xFilial("SC5")
SC5->C5_NUM := Alltrim(STR(cNumeroPedido))
SC5->C5_CONDPAG := "201"
SC5->C5_CODPROM := OPUBL->ZZ6_ORIGEM  // Codigo da promocao.
SC5->C5_CLIENTE := cCodCliente
SC5->C5_TIPOCLI := "F"

if OPUBL->D_PROCED = "A"
	SC5->C5_PARC1 := 0
	SC5->C5_DATA1 := CtoD("  /  /  ")
	SC5->C5_PARC2 := 0
	SC5->C5_DATA2 := CtoD("  /  /  ")
	SC5->C5_PARC3 := 0
	SC5->C5_DATA3 := CtoD("  /  /  ")
	SC5->C5_PARC4 := 0
	SC5->C5_DATA4 := CtoD("  /  /  ")
	SC5->C5_PARC5 := 0
	SC5->C5_DATA5 := CtoD("  /  /  ")
	SC5->C5_PARC6 :=  0
	SC5->C5_DATA6 := CtoD("  /  /  ")
	nContaA++  // nao preenche valores para parcelas
elseif OPUBL->D_PROCED = "C"
	SC5->C5_PARC1 := 0
	SC5->C5_DATA1 := CtoD("  /  /  ")
	SC5->C5_PARC2 := 0
	SC5->C5_DATA2 := CtoD("  /  /  ")
	SC5->C5_PARC3 := 0
	SC5->C5_DATA3 := CtoD("  /  /  ")
	SC5->C5_PARC4 := 0
	SC5->C5_DATA4 := CtoD("  /  /  ")
	SC5->C5_PARC5 := 0
	SC5->C5_DATA5 := CtoD("  /  /  ")
	SC5->C5_PARC6 :=  0
	SC5->C5_DATA6 := CtoD("  /  /  ")
	nContaC++
elseif OPUBL->D_PROCED = "B"
	SC5->C5_PARC1 := OPUBL->ZZ6_VALOA
	SC5->C5_DATA1 := OPUBL->ZZ6_VENCA
	SC5->C5_PARC2 := OPUBL->ZZ6_VALOB
	SC5->C5_DATA2 := OPUBL->ZZ6_VENCB
	SC5->C5_PARC3 := OPUBL->ZZ6_VALOC
	SC5->C5_DATA3 := OPUBL->ZZ6_VENCC
	SC5->C5_PARC4 := OPUBL->ZZ6_VALOD
	SC5->C5_DATA4 := OPUBL->ZZ6_VENCD
	SC5->C5_PARC5 := OPUBL->ZZ6_VALOE
	SC5->C5_DATA5 := OPUBL->ZZ6_VENCE
	SC5->C5_PARC6 :=  OPUBL->ZZ6_VALOF
	SC5->C5_DATA6 := OPUBL->ZZ6_VENCF
	nContaB++
else //d_proced = "D"
	SC5->C5_PARC1 := OPUBL->ZZ6_VALOA
	SC5->C5_DATA1 := OPUBL->ZZ6_VENCA
	SC5->C5_PARC2 := OPUBL->ZZ6_VALOB
	SC5->C5_DATA2 := OPUBL->ZZ6_VENCB
	SC5->C5_PARC3 := OPUBL->ZZ6_VALOC
	SC5->C5_DATA3 := OPUBL->ZZ6_VENCC
	SC5->C5_PARC4 := OPUBL->ZZ6_VALOD
	SC5->C5_DATA4 := OPUBL->ZZ6_VENCD
	SC5->C5_PARC5 := OPUBL->ZZ6_VALOE
	SC5->C5_DATA5 := OPUBL->ZZ6_VENCE
	SC5->C5_PARC6 :=  OPUBL->ZZ6_VALOF
	SC5->C5_DATA6 := OPUBL->ZZ6_VENCF
	nContaD++
endif

SC5->C5_DTCALC  := OPUBL->ZZ6_DTINCL
SC5->C5_EMISSAO := OPUBL->ZZ6_DTINCL
SC5->C5_RESPCOB  := OPUBL->ZZ6_NOMECO
SC5->C5_VLRPED := OPUBL->ZZ6_VLASS
SC5->C5_DATA := dDataBase
//SC5->C5_LIBEROK := ""
SC5->C5_TIPOOP := "01"
SC5->C5_NUMANT := ""
//SC5->C5_NOTA := ZZE->ZZE_NUM
//SC5->C5_SERIE := "REA"
SC5->C5_DIVVEN := "MERC"
SC5->C5_LOTEFAT := "900"
SC5->C5_USUARIO := SubStr(cUsuario,7,15)
SC5->C5_MENNOTA :="."
SC5->C5_MENPAD := ""
if len(alltrim(OPUBL->ZZ6_VEND))  = 0
	SC5->C5_VEND1 := "100"
else
	SC5->C5_VEND1 := OPUBL->ZZ6_VEND
endif
//preencher campos obrigatorios
SC5->C5_TIPO := "N"
SC5->C5_AVESP := "N"
SC5->C5_TPTRANS := "99" 
SC5->C5_IDENTIF := "1"
SC5->C5_TABELA := "1"
SC5->C5_LOJACLI := "01"
MsUnlock()
nContaSC5 += 1
DBCloseArea("SC5")

RecLock("OPUBL",.F.) //update .F.
OPUBL->NOVO_PED := Alltrim(STR(cNumeroPedido))
MsUnlock()
return




//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Procedimento para inserir o Item do Pedido³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function InserirSC6()
IF ((OPUBL->ZZ6_EDFIN - OPUBL->ZZ6_EDINIC +1) <= 12)
		if OPUBL->ZZ6_PRODUTO = "15"
			cCodProduto := "0115002"
		elseif OPUBL->ZZ6_PRODUTO = "16"
			cCodProduto := "0116002"
		else
			cCodProduto := "0124002"
		endif
ELSE
		if OPUBL->ZZ6_PRODUTO = "15"
			cCodProduto := "0115003"
		elseif OPUBL->ZZ6_PRODUTO = "16"
			cCodProduto := "0116003"
		else
			cCodProduto := "0124002"
		endif
ENDIF

DbSelectArea("SB1")
DBSetOrder(1)
DbSeek(xFilial("SB1")+cCodProduto)
//procedimento para inserir em SC6
DBselectArea("SC6")
RecLock("SC6",.T.) //inserir .T.
SC6->C6_FILIAL := xFilial("SC6")
SC6->C6_ITEM := "01"
SC6->C6_NUM := Alltrim(STR(cNumeroPedido))
SC6->C6_PRODUTO := cCodProduto
SC6->C6_DESCRI := SB1->B1_DESC
//SC6->C6_NOTA :=
SC6->C6_TES := "700"
if ALLTRIM(OPUBL->ZZ6_ESTADO) = "SP"
	SC6->C6_CF = "5101"
else
	SC6->C6_CF = "6101"
endif
//SC6->C6_SERIE := "REA"
SC6->C6_QTDLIB := 0
SC6->C6_BLQ :="N"
SC6->C6_QTDEMP := 0
SC6->C6_QTDENT := 0
SC6->C6_QTDVEN := OPUBL->ZZ6_QTDE
SC6->C6_PRUNIT := OPUBL->ZZ6_VLASS
SC6->C6_PRCVEN := OPUBL->ZZ6_VLASS
SC6->C6_VALOR := OPUBL->ZZ6_VLASS
SC6->C6_EDINIC := OPUBL->ZZ6_EDINIC
SC6->C6_EDVENC := OPUBL->ZZ6_EDFIN
SC6->C6_EDSUSP := OPUBL->ZZ6_EDSUSP
SC6->C6_EDFIN := OPUBL->ZZ6_EDFIN

DBselectArea("SZJ")
DBSetOrder(1)
If dbSeek( xFilial("SZJ") + "01" + Subs(SC6->C6_PRODUTO, 3, 2) + STR(OPUBL->ZZ6_EDINIC, 4, 0), .F. )
	_cDtInic := SZJ->ZJ_DTCIRC
Else
	_cDtInic := CtoD("  /  /  ")
EndIf
If dbSeek( xFilial("SZJ") + "01" + Subs(SC6->C6_PRODUTO, 3, 2) + STR(OPUBL->ZZ6_EDFIN, 4, 0), .F. )
	_cDtFin := SZJ->ZJ_DTCIRC
Else
	_cDtFin := CtoD("  /  /  ")
EndIf
SC6->C6_DTINIC := _cDtInic
SC6->C6_DTFIN := _cDtFin
SC6->C6_DTCIRC:= _cDtInic
SC6->C6_EDICAO := 0
SC6->C6_EDREAB := 0
SC6->C6_DTCANC := OPUBL->ZZ6_DTCANC
SC6->C6_DTENVIO := CTOD("  /  /  ")
SC6->C6_DATFAT := CTOD("  /  /  ")
//SC6->C6_PEDANT := ZZE->ZZE_PEDOLD
//SC6->C6_ITEMANT := ZZE->ZZE_ITEM
SC6->C6_LOTEFAT := "900"
SC6->C6_DATA := dDataBase
SC6->C6_entreg := OPUBL->ZZ6_DTINCL
SC6->C6_EXADIC := OPUBL->ZZ6_EXADIC
SC6->C6_SITUAC := "AA"
SC6->C6_CODDEST := cCodDest
SC6->C6_TPPORTE := "0"
SC6->C6_LOCAL := "99"
SC6->C6_CLI := cCodCliente
SC6->C6_REGCOT := substr(cCodProduto,1,4)
//preencher campos obrigatorios
SC6->C6_TIPOREV := "0"
SC6->C6_TPPROG := "N"
SC6->C6_LOJA := "01"
SC6->C6_COMIS1 := 0 //OBRIGATORIO:  ?? QUAL VALOR???
SC6->C6_COMIS2 := 0
SC6->C6_COMIS3 := 0
SC6->C6_COMIS4 := 0
SC6->C6_COMIS5 := 0
MsUnlock()
DbSelectArea("SB1")
DBCloseArea("SB1")
DbSelectArea("SZJ")
DBCloseArea("SZJ")
DBCloseArea("SC6")
nContaSC6 += 1
return




//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Procedimento para limpar o conteudo das variaveis³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function LimparVariaveis()
cID := ""
cCodCliente := ""
cCodDest := ""
cVencimento := ""
cCodProduto := ""
_cDtInic := ""
_cDtFin := ""
return
