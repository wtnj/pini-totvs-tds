#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"
/*/ 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PINIPEDIDO³Autor: Danilo C S Pala        ³ Data:   20100811 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo:  Insere, edita e deleta PEDIDO para compra no              ³ ±±
±±³ no Site: PiniProtheusService									     | ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Pini														 ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
	aHeader
	[01] -> C5_NUM
	[02] -> C5_TIPO
	[03] -> C5_DIVVEN
	[04] -> C5_CODPROM
	[05] -> C5_IDENTIF
	[06] -> C5_CLIENTE
	[07] -> C5_LOJAENT
	[08] -> C5_LOJACLI
	[09] -> C5_CONDPAG
	[10] -> C5_VEND1
	[11] -> C5_VEND2
	[12] -> C5_VEND3
	[13] -> C5_VEND4
	[14] -> C5_VEND5
	[15] -> C5_EMISSAO
	[16] -> C5_TIPOCLI
	[17] -> C5_LOTEFAT
	[18] -> C5_DATA
	[19] -> C5_VLRPED
	[20] -> C5_TIPOOP
	[21] -> C5_DTCALC
	[22] -> C5_AVESP
	[23] -> C5_TPTRANS
	[24] -> C5_MENNOTA
	[25] -> C5_DESPREM
	[26] -> C5_NUMEXT
	[27] -> C5_CARTAO
	[28] -> C5_NUMERO
	[29] -> C5_VALID
	[30] -> C5_CODSEG
	[31] -> C5_TITULAR
	[32] -> C5_DEBBANC
	[33] -> C5_DEBAGEN
	[34] -> C5_DEBCONT
	[35] -> C5_DEBDAC
	[36] -> C5_DESPBOL
	[37] -> C5_OBSPED// ALTERADO PARA A OBSERVACAO GRAVADA NO SZK O C5_OBSPED FICARA EM BRANCO
	
	
	
	aDetails = array de aItem
		aItem
		[01] -> C6_NUM
		[02] -> C6_ITEM
		[03] -> C6_PRODUTO
		[04] -> C6_DESCRI
		[05] -> C6_TES
		[06] -> C6_LOCAL
		[07] -> C6_CF
		[08] -> C6_QTDVEN
		[09] -> C6_PRCVEN
		[10] -> C6_PRUNIT
		[11] -> C6_VALOR
		[12] -> C6_UM
		[13] -> C6_CLI
		[14] -> C6_LOJA
		[15] -> C6_COMIS1
		[16] -> C6_COMIS2
		[17] -> C6_COMIS3
		[18] -> C6_COMIS4
		[19] -> C6_COMIS5
		[20] -> C6_DATA
		[21] -> C6_ENTREGA
		[22] -> C6_TPOP
		[23] -> C6_TIPOREV
		[24] -> C6_EDINIC
		[25] -> C6_EDFIN
		[26] -> C6_EDVENC
		[27] -> C6_EDSUSP
		[28] -> C6_REGCOT
		[29] -> C6_TPPROG
		[30] -> C6_SITUAC
		[31] -> C6_CLASFIS 
		[31] -> C6_VALDESC
	
/*/
User Function PiniPedido(aHeader, aDetails)
Private nOpc := 3 // inclusao 
Private bRetorno := .F.
Private aCab    := {}
Private aItem   := {}
Private aItens   := {}
Private lMsHelpAuto := .t. // se .t. direciona as mensagens de help para o arq. de log
Private lMsErroAuto := .f. //necessario a criacao, pois sera //atualizado quando 

Private cNum := "A00002"
Private cTipo := "N"    
Private cDivven := "MERC"           
Private cCodProm := "N"
Private cIdentif := "."
Private cCliente := "DANILO"
Private cLoja := "01"               
Private cCondPagto := "201"
Private cVend1 := "000101"
Private cVend2 := space(6)
Private cVend3 := space(6)
Private cVend4 := space(6)
Private cVend5 := space(6)        
Private dEmissao := aHeader[18] //dDataBase
Private nValor := 10
Private cTipoOper := "13"
Private cObs := "."+space(119)
Private cLoteFat := aHeader[17] //"LOJ"
Private cTipocli := "F"
Private cAvesp := "N"
Private cTpTrans := "99" 
Private nDespRem := 0
Private cNumExt := ""
Private cCartaoOperadora := ""
Private cCartaoNumero := ""
Private dCartaoValidade := stod("")
Private cCartaoCodSeg := ""
Private cCartaoTitular := ""
Private cDebitoBanco := ""
Private cDebitoAgencia := ""
Private cDebitoConta := ""
Private cDebitoDAC := ""
Private cNossoNumero := ""
Private nDespesaBoleto := 0

        

Private cItem := "01"
Private cProduto := "02021752"
Private cLocal := posicione("SB1",1,xfilial("SB1")+cProduto,"B1_LOCPAD")
Private nQtd := 1
Private nValorUnitario := 10
Private nValorTotal := 10
Private cDescricao := SB1->B1_DESC
Private cUnidade := SB1->B1_UM
Private cTES := SB1->B1_TS
Private cCF := posicione("SF4",1,xfilial("SF4")+cTES,"F4_CF")
Private nDesconto := 0
Private nComis1 := 0.1
Private nComis2 := 0
Private nComis3 := 0
Private nComis4 := 0
Private nComis5 := 0
Private nEdInic := 9999
Private nEdFin := 9999
Private nEdVenc := 9999
Private nEdSusp := 9999
Private cTpop := "F"
Private cClasFis := Subs(SB1->B1_ORIGEM,1,1)+SF4->F4_SITTRIB
Private cSituac := "AA"
Private cTipoRev := "0"
Private cRegcot := "99"+space(13)
Private cTpprog :="N"   

//loteFat
dbSelectArea("SZ6")
DBSetOrder(1)
If !DBSeek(xFilial("SZ6")+cLoteFat+dtos(dEmissao))
	reclock("SZ6",.t.) //insert
		SZ6->Z6_FILIAL := xFilial("SZ6")
		SZ6->Z6_LOTEFAT := cLoteFat
		SZ6->Z6_DATA := dEmissao
		SZ6->Z6_DIVVEN := cDivven
	msunlock()
EndIf

  
Begin Transaction 
//SC5
aAdd(aCab ,{"C5_FILIAL", xfilial("SC5"), NIL})
aAdd(aCab ,{"C5_NUM", aHeader[01], NIL})
aAdd(aCab ,{"C5_TIPO", aHeader[02], NIL})
aAdd(aCab ,{"C5_DIVVEN", aHeader[03], NIL})
aAdd(aCab ,{"C5_CODPROM", aHeader[04], NIL})
aAdd(aCab ,{"C5_IDENTIF", aHeader[05], NIL})
aAdd(aCab ,{"C5_CLIENTE", aHeader[06], NIL})
aAdd(aCab ,{"C5_LOJAENT", aHeader[07], NIL})
aAdd(aCab ,{"C5_LOJACLI", aHeader[08], NIL})
aAdd(aCab ,{"C5_CONDPAG", aHeader[09], NIL})
aAdd(aCab ,{"C5_VEND1", aHeader[10], NIL})
aAdd(aCab ,{"C5_VEND2", aHeader[11], NIL})
aAdd(aCab ,{"C5_VEND3", aHeader[12], NIL})
aAdd(aCab ,{"C5_VEND4", aHeader[13], NIL})
aAdd(aCab ,{"C5_VEND5", aHeader[14], NIL})
aAdd(aCab ,{"C5_EMISSAO", aHeader[15], NIL})
aAdd(aCab ,{"C5_TIPOCLI", aHeader[16], NIL})
aAdd(aCab ,{"C5_LOTEFAT", aHeader[17], NIL})
aAdd(aCab ,{"C5_DATA", aHeader[18], NIL})
aAdd(aCab ,{"C5_VLRPED", aHeader[19], NIL})
aAdd(aCab ,{"C5_TIPOOP", aHeader[20], NIL})
aAdd(aCab ,{"C5_DTCALC", aHeader[21], NIL})
aAdd(aCab ,{"C5_AVESP", aHeader[22], NIL})
aAdd(aCab ,{"C5_TPTRANS", aHeader[23], NIL})
aAdd(aCab ,{"C5_MENNOTA", aHeader[24], NIL})
aAdd(aCab ,{"C5_DESPREM", aHeader[25], NIL})
aAdd(aCab ,{"C5_NUMEXT", aHeader[26], NIL})
aAdd(aCab ,{"C5_CARTAO", aHeader[27], NIL})
aAdd(aCab ,{"C5_NUMERO", aHeader[28], NIL})
aAdd(aCab ,{"C5_VALID", aHeader[29], NIL})
aAdd(aCab ,{"C5_CODSEG", aHeader[30], NIL})
aAdd(aCab ,{"C5_TITULAR", aHeader[31], NIL})
aAdd(aCab ,{"C5_DEBBANC", aHeader[32], NIL})
aAdd(aCab ,{"C5_DEBAGEN", aHeader[33], NIL})
aAdd(aCab ,{"C5_DEBCONT", aHeader[34], NIL})
aAdd(aCab ,{"C5_DEBDAC", aHeader[35], NIL})
aAdd(aCab ,{"C5_DESPBOL", aHeader[36], NIL})
//aAdd(aCab ,{"C5_OBSPED", aHeader[27], NIL})
aadd(aCab ,{"AUTDELETA" ,"N",Nil}) // Incluir sempre no último elemento do array de cada item


                 
For i:= 1 to Len(aDetails) 
	aLinha := aDetails[i]
	aItem := {}
	aAdd(aItem ,{"C6_FILIAL", xfilial("SC6"), NIL})
	aAdd(aItem,{"C6_NUM", aLinha[01], NIL})
	aAdd(aItem,{"C6_ITEM", aLinha[02], NIL})
	aAdd(aItem,{"C6_PRODUTO", aLinha[03], NIL})
	aAdd(aItem,{"C6_DESCRI", aLinha[04], NIL})
	aAdd(aItem,{"C6_TES", aLinha[05],NIL})
	aAdd(aItem,{"C6_LOCAL", aLinha[06], NIL})
	aAdd(aItem,{"C6_CF", aLinha[07], NIL})
	aAdd(aItem,{"C6_QTDVEN", aLinha[08], NIL})
	aAdd(aItem,{"C6_PRCVEN", aLinha[09], NIL})
	aAdd(aItem,{"C6_PRUNIT", aLinha[10], NIL})
	aAdd(aItem,{"C6_VALOR", aLinha[11], NIL})
	aAdd(aItem,{"C6_UM", aLinha[12], NIL})
	aAdd(aItem,{"C6_CLI", aLinha[13], NIL})
	aAdd(aItem,{"C6_LOJA", aLinha[14], NIL})
	aAdd(aItem,{"C6_COMIS1", aLinha[15], NIL})
	aAdd(aItem,{"C6_COMIS2", aLinha[16], NIL})
	aAdd(aItem,{"C6_COMIS3", aLinha[17], NIL})
	aAdd(aItem,{"C6_COMIS4", aLinha[18], NIL})
	aAdd(aItem,{"C6_COMIS5", aLinha[19], NIL})
	aadd(aItem,{"C6_DATA", aLinha[20], NIL})
	aadd(aItem,{"C6_ENTREGA", aLinha[21], NIL})
	aadd(aItem,{"C6_TPOP", aLinha[22], NIL})
	aadd(aItem,{"C6_TIPOREV", aLinha[23], NIL})
	aadd(aItem,{"C6_EDINIC", aLinha[24], NIL})
	aadd(aItem,{"C6_EDFIN", aLinha[25], NIL})
	aadd(aItem,{"C6_EDVENC", aLinha[26], NIL})
	aadd(aItem,{"C6_EDSUSP", aLinha[27], NIL})
	aadd(aItem,{"C6_REGCOT", aLinha[28], NIL})
	aadd(aItem,{"C6_TPPROG", aLinha[29], NIL})
	aadd(aItem,{"C6_SITUAC", aLinha[30], NIL})
	aadd(aItem,{"C6_CLASFIS", aLinha[31],NIL})
	aadd(aItem,{"C6_VALDESC", aLinha[32],NIL})
	//aadd(aItem,{"C6_QTDLIB", aLinha[08],NIL}) //20100825
	
	aadd(aItem,{"AUTDELETA" ,"N",Nil}) // Incluir sempre no último elemento do array de cada item
	
	aadd(aItens,aItem)
Next



MsExecAuto({|x,y,z| mata410(x,y,z)}, aCab, aItens, nOpc)
If lMsErroAuto
	DisarmTransaction()
	break
EndIf
End Transaction 
If lMsErroAuto
	/*
	Se estiver em uma aplicao normal e ocorrer alguma incosistencia nos parametros passados,mostrar na tela o log informando qual coluna teve a incosistencia.
	*/
	Mostraerro() 
	bRetorno := .F.
Else                                       
	If !empty(alltrim(aHeader[37]))
		DbSelectArea("SZK") //OBSERVACAO PEDIDO
		DBSetOrder(1)
		If !DBSeek(xFilial("SZK")+ aHeader[01])
			Reclock("SZK",.T.) //INSERT
		    	SZK->ZK_FILIAL  := xFilial("SZK")
				SZK->ZK_PEDIDO  := aHeader[01]
	    		SZK->ZK_OBS     := alltrim(aHeader[37])
			MsUnlock()                     
		EndIf
	EndIf

	bRetorno := .T.
EndIf
Return bRetorno