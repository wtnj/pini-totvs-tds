#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"
/*/ 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT181   ³Autor: Danilo C S Pala        ³ Data:   20100810 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo:  Gerar Reserva de produto para compra no Site 		     ³ ±±
±±³ 																     | ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Pini														 ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat181()
/*Private aReserva   := {}
Private cNumero		:= SPACE(6)
Private cProduto	:= SPACE(15)
Private cLocal		:= SPACE(2)
Private nQuant		:= 1
Private aLote		:= {}
Private aHeader   	:= {}
Private aCols     	:= {}
Private nQuantElim	:= 0     
Private nAcao		:= 1
Private aItens		:= {"Inserir","Editar", "Deletar"}
Private cSugestao	:= ""
Private cOpcao		:= ""
Private lExec := .F.
Private cTpReserva	:= "PD"
Private cDoc		:= "000000000"
Private cSolicit	:= "LOJAPINI"
Private cFilialR   := "01"
Private cObs		:= "LOTEWS 000000001"

cSugestao := GetSx8Num("SC0")
cNumero	:= cSugestao

@ 158,84 To 460,900 Dialog oWinDlg Title OemToAnsi("Controle de Reserva")
@ 020,015 Say "Opcao"
@ 020,070 COMBOBOX cOpcao ITEMS aItens SIZE 90,90
@ 035,015 Say "Numero da reserva"
@ 035,070 Get cNumero Picture "@!" Size 100,10
@ 050,015 Say "Produto"
@ 050,070 Get cProduto Picture "@!" Size 100,10 F3("SB1") 
@ 065,017 Say "Local"
@ 065,070 Get cLocal Picture "@!" Size 20,10 F3("97") 
@ 080,017 Say "Quantidade" Size 20,10
@ 080,070 Get nQuant

@ 095,017 BmpButton Type 1 Action (lExec := .T.,Close(oWinDlg))
@ 095,070 BmpButton Type 2 Action (lExec := .F.,Close(oWinDlg))
Activate Dialog oWinDlg Centered              

If lExec

if cSugestao == cNumero
	ConfirmSX8()
Else 
	rollbackSX8()
EndIF

If cOpcao == "Inserir"
	nAcao :=1
ElseIf cOpcao == "Editar"
	nAcao :=2            
Else
	nAcao :=3
Endif

/*aReserva
[1] -> [Operacao : 1 Inclui,2 Altera,3 Exclui]
[2] -> [Tipo da Reserva]
[3] -> [Documento que originou a Reserva]
[4] -> [Solicitante]
[5] -> [Filial da Reserva]
[6] -> [Observacao] 
[7] -> cNumero := "000004"
[8] -> cProduto	:= PADR("02021752",15) //codProduto
[9] -> cLocal		:= "T5"
[10] -> nQuant		:= 1*/
/*aReserva := {nAcao, cTpReserva, cDoc, cSolicit, cFilialR, cObs, cNumero, cProduto, cLocal, nQuant}
u_ReservaAlmox(aReserva)

Else
	rollbackSX8()
EndIf*/

U_jobpini01("TELA")

Return