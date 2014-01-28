#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"
/*/ 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT181   ³Autor: Danilo C S Pala        ³ Data:   20100811 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo:  Insere, edita e deleta Reserva de produto para compra no  ³ ±±
±±³ no Site: PiniProtheusService									     | ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Pini														 ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
/*
aReserva
[1] -> [Operacao : 1 Inclui,2 Altera,3 Exclui]
[2] -> [Tipo da Reserva]
[3] -> [Documento que originou a Reserva]
[4] -> [Solicitante]
[5] -> [Filial da Reserva]
[6] -> [Observacao] 
[7] -> cNumero := "000004"
[8] -> cProduto	:= PADR("02021752",15) //codProduto
[9] -> cLocal		:= "T5"
[10] -> nQuant		:= 1
*/
User Function ReservaAlmox(aReserva)
Private aOperacao   := {}
Private cNumero		:= ""
Private cProduto	:= ""
Private cLocal		:= ""
Private nQuant		:= 1
Private aLote		:= {}
Private aHeader   	:= {}
Private aCols     	:= {}
Private nQuantElim	:= 0     
Private nAcao		:= 1
Private aItens		:= {"Inserir","Editar", "Deletar"}
Private cSugestao	:= ""
Private cOpcao		:= ""
Private cTpReserva	:= "PD"
Private cDoc		:= ""
Private cSolicit	:= ""
Private cFilialR   := ""
Private cObs		:= ""

nAcao := aReserva[1]

cTpReserva	:= aReserva[2]
cDoc		:= aReserva[3]
cSolicit	:= aReserva[4]
cFilialR   := aReserva[5]
cObs		:= aReserva[6]
/*If nAcao == 1
	cNumero	:= GetSx8Num("SC0")
	ConfirmSX8()
Else*/
	cNumero	:= 	aReserva[7]
//Endif
cProduto	:= PADR(aReserva[8],15)
cLocal		:= aReserva[9]
nQuant		:= aReserva[10]

/*aOperacao
[1] -> [Operacao : 1 Inclui,2 Altera,3 Exclui]
[2] -> [Tipo da Reserva]
[3] -> [Documento que originou a Reserva]
[4] -> [Solicitante]
[5] -> [Filial da Reserva]
[6] -> [Observacao] */
aOperacao := {nAcao, cTpReserva, cDoc, cSolicit, cFilialR, cObs}
                  
/*aLote
[1] -> [Numero do Lote]
[2] -> [Lote de Controle]
[3] -> [Localizacao]
[4] -> [Numero de Serie] */
aLote := {"","","",""}

Begin Transaction
//A430Reserv ( < aOPERACAO > , < cNUMERO > , < cPRODUTO > , < cLOCAL > , < nQUANT > , < aLOTE > , [ aHEADER ] , [ aCOLS ] , [ nQUANTELIM ] )
A430Reserv ( aOperacao, cNumero, cProduto, cLocal, nQuant, aLote, aHeader, aCols)
End Transaction 
Return