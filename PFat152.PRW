#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFat152   ºAutor  ³Danilo C S Pala     º Data ³  06/06/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Este programa ira converter dados da tabela o_publ provenienº±±
±±º          ³ te da TMKT, inserindo em sc5, sc6 e quando necessario em   º±±
±±º          ³ szn e szo.                                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Pfat152

Private _cTitulo  := "Converte Orgaos Publicos da TMKT para o AP5"
Private _ccMens1  := "Fonte: \siga\arqass\o_publ.dbf"
Private cID := space(6)
Private cCodCliente := space(6)
Private cEndPrincipal := space(40)
Private lExisteDestinatario := .F.
Private cCodDest := space(6)
Private cNumeroPedido := 282300
Private nContaSC5 := 0
Private nContaSC6 := 0
Private nContaSZN := 0
Private nContaSZO := 0
Private nContaSA1 := 0 
Private nContaa := 0
Private nContab := 0
Private nContac := 0
Private nContad := 0
Private cMsgFinal := space(200)
Private nCodNovoCliente := 334090
Private lClienteNovo := .F.
Private cVencimento := space(10)
Private cCodProduto
SetPRvt("_cDtInic, _cDtFin")



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
	cID := OPubl->ID
	cCodCliente := OPubl->zz6_cod
	DBSelectArea("SA1")
	DBSetOrder(1)
	// verifica se eh cliente
	if	DbSeek(xFilial("SA1")+cCodCliente, .T.)
		// eh cliente
		// verifica destinatario
		if AllTrim(OPUBL->ZZ6_DEST) <> ""
			// tem destinatario
			DBSelectArea("SZN")
			DBSetOrder(1)
			if DBSeek(xFilial("SZN")+cCodCliente, .T.)
				// LOOP EM todos os destinatarios do cliente(indexado)
				While (SZN->ZN_CODCLI = cCodCliente) .and. (lExisteDestinatario = .F.)
					if alltrim(SZN->ZN_NOME) =  alltrim(OPUBL->ZZ6_DEST)
						//destinatario existe
						lExisteDestinatario := .T.
						cCodDest := SZN->ZN_CODDEST
						//procedimento para verificacoes do endereco do destinatario
						verificaEnderecoDestinatario()
					end if
					DbSelectArea("SZN")
					DBSkip()
				end
				// verifica szn se sim
				if !lExisteDestinatario
					cCodDest := alltrim(Str((val(cCodDest) + 5)))
					//inserir o mesmo destinatario com outro codigo para novo endereco
					InserirDestinatario()
					InserirEnderecoDestinatario()
				end if
			else
				//procedimento para inserir destinatario
				cCodDest := 5
				InserirDestinatario()
				VerificaEnderecoDestinatario()
			end if
		endif
	else
		// nao eh cliente, inserir
		MsgAlert("Problema em: "+cCodCliente)
	endif
	InserirSC5()
	InserirSC6()
	//inserir pedido e inserir item do pedido
	
	//fechar tables e next
	/*	DBSelectArea("SA1")
	dbCloseArea("SA1")
	DBSelectArea("SZN")
	DbCloseArea("SZN")
	DBSelectArea("SZO")
	DbCloseArea("SZO")*/
	cNumeroPedido++
	limparVariaveis()
	DBSelectArea("OPubl")
	DBSkip()
	IncProc()
end

DBSelectArea("OPubl")
DbCloseArea("OPubl")
cMsgFinal := "Processamento finalizado! Atualizados: SC5: " + Alltrim(Str(nContaSC5))
cMsgFinal += ", SC6: " + Alltrim(Str(nContaSC6)) + ", SZN: " + Alltrim(Str(nContaSZN))
cMsgFinal += ", SZO: " + Alltrim(Str(nContaSZO)) + " e SA1: " + Alltrim(Str(nContaSA1))
MsgAlert( cMsgFinal)
return


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao para inserir Destinatario³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function InserirDestinatario()
//politica de numero do destinatario
RecLock("SZN",.T.) //inserir .T.
ZN_FILIAL := xFilial("SZN")
ZN_CODCLI := cCodCliente
ZN_CODDEST := cCodDest
ZN_NOME := OPUBL->ZZ6_DEST
MsUnlock()      

RecLock("OPUBL",.F.) //update .F.
OPUBL->NOVO_SZN := "S"
MsUnlock()
nContaSZN += 1
return




//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao para inserir Endereco de Destinatario³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function InserirEnderecoDestinatario()
RecLock("SZO",.T.) //inserir .T.
ZO_FILIAL := xFilial("SZO")
ZO_CODCLI := cCodCliente
ZO_CODDEST := cCodDest
ZO_END := OPUBL->ZZ6_ENDDEST
ZO_BAIRRO:= OPUBL->ZZ6_BAIDEST
ZO_CIDADE := OPUBL->ZZ6_MUNDEST
ZO_CEP := OPUBL->ZZ6_CEPDEST
ZO_ESTADO := OPUBL->ZZ6_ESTDEST
ZO_FONE := OPUBL->ZZ6_TELDEST
MsUnlock()

RecLock("OPUBL",.F.) //update .F.
OPUBL->NOVO_SZO := "S"
MsUnlock()
nContaSZO += 1
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
SC5->C5_TPTRANS := "0" // ????
SC5->C5_IDENTIF := "1"
SC5->C5_TABELA := "1" 
SC5->C5_LOJACLI := "N"
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
if !lClienteNovo  //cliente antigo
	IF ((OPUBL->ZZ6_EDFIN - OPUBL->ZZ6_EDINIC +1) <= 12)
		if OPUBL->ZZ6_PRODUTO = "15"
			cCodProduto := "0115004"
		elseif OPUBL->ZZ6_PRODUTO = "16"
			cCodProduto := "0116004"
		else
			cCodProduto := "0124004"
		endif
	ELSE
		if OPUBL->ZZ6_PRODUTO = "15"
			cCodProduto := "0115005"
		elseif OPUBL->ZZ6_PRODUTO = "16"
			cCodProduto := "0116005"
		else
			cCodProduto := "0124005"
		endif
	ENDIF
else //cliente novo
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
endif

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
SC6->C6_DATA := OPUBL->ZZ6_DTINCL
SC6->C6_entreg := OPUBL->ZZ6_DTINCL
SC6->C6_EXADIC := OPUBL->ZZ6_EXADIC
SC6->C6_SITUAC := "AA"
SC6->C6_CODDEST := cCodDest
SC6->C6_TPPORTE := "0"
SC6->C6_LOCAL := "99"
SC6->C6_CLI := cCodCliente   
SC6->C6_REGCOT := substr(cCodProduto,1,4)
//preencher campos obrigatorios
SC6->C6_TIPOREV := "1"
SC6->C6_TPPROG := "N"
SC6->C6_LOJA := "01"
SC6->C6_COMIS1 := 0.01 //OBRIGATORIO:  ?? QUAL VALOR???
//SC6->C6_COMIS2 := 0
//SC6->C6_COMIS3 := 0
//SC6->C6_COMIS4 := 0
//SC6->C6_COMIS5 := 0
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
cEndPrincipal := ""
lExisteDestinatario := .F.
cCodDest := ""
lClienteNovo := .F.
cVencimento := ""
cCodProduto := ""
_cDtInic := ""
_cDtFin := ""
return




//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Procedimento para verificar o endereco do destinatario³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function VerificaEnderecoDestinatario()
//verifica endereco de destinatario
if ALLTRIM(OPUBL->ZZ6_ENDDEST) <>  ""
	//tem endereco de destinatario
	DBSelectArea("SZO")
	DBSetOrder(1)
	if DBSeek(xFilial("SZO")+cCodCliente+cCodDest)
		// existe endereco do desinatario
		if AllTrim(SZO->ZO_END) <> OPUBL->ZZ6_ENDDEST
			// inserir novo destinatario e endereco
			// igual se nao existisse o destinatario
			lExisteDestinatario := .F.
		endif
	else
		cEndDest := OPUBL->ZZ6_ENDDEST
		cBairroDest := OPUBL->ZZ6_BAIDEST
		cCEPDest := OPUBL->ZZ6_CEPDEST
		cCidadeDest := OPUBL->ZZ6_MUNDEST
		cEstadoDest := OPUBL->ZZ6_ESTDEST
		cFoneDest := OPUBL->ZZ6_TELDEST
		// procedimento para inserir endereco de destinatario
		InserirEnderecoDestinatario()
	endif
endif
return
