#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
	#include "inkey.ch"
#ELSE
//	#Include "vkey.ch"
#ENDIF

User Function Rfat015()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CALERT,CMENS,CSAVEMENUH,CALIAS,NPOSLOTCTL,NPOSLOTE")
SetPrvt("NPOSDVALID,CDOCUMENTO,CSERIE,CTITULO,AC,AR")
SetPrvt("NUSADO,AHEADER,ACOLS,ACGD,CLINHAOK,CTUDOOK")
SetPrvt("LTUDOOK,LVALIDAR,LRETMOD2,CNUMSEQ,I,")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==> 	#include "inkey.ch"
#ELSE
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==> 	#Include "vkey.ch"
#ENDIF
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ CRIALOC  ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 16/04/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cria registro de movimentacao por Localizacao (SDB)        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Compatibilizacao Versao 2.05 / 2.06                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Mostra texto alertando sobre o objetivo do programa          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

#IFDEF WINDOWS
	cAlert:=OemToAnsi("Aten‡„o")
	cMens :=       OemToAnsi("Esta rotina deve ser executada em modo")+chr(13)
	cMens :=cMens+ OemToAnsi("exclusivo, e os produtos a serem")+chr(13)
	cMens :=cMens+ OemToAnsi("digitados nao devem ter nenhum movimen-")+chr(13)
	cMens :=cMens+ OemToAnsi("to em aberto (OP's, Empenhos, NF's a ")+chr(13)
	cMens :=cMens+ OemToAnsi("faturar, etc.)")+chr(13)
	Tone(3500,1)
	MsgAlert(cMens,cAlert)
	Tone(3500,1)
	cMens :=			OemToAnsi("Este programa foi construido com o objetivo de adequar ")
	cMens :=cMens+ OemToAnsi("os Saldos em Estoque existentes ao controle de ")
	cMens :=cMens+ OemToAnsi("Localiza‡„o F¡sica do Estoque.As informa‡”es aqui ")
	cMens :=cMens+ OemToAnsi("digitadas ir„o gerar Saldo por Localiza‡„o F¡sica.")
	MsgAlert(cMens,cAlert)
#ELSE
	Tone(3500,1)
	cSaveMenuh := SaveScreen(10,14,19,64)
	Set Color To w+/r
	@ 10,16 Clear To 18,64
	@ 11,19 To 17,61
	@ 11,30 Say " A  T  E  N  C  Ž  O "
	@ 12,21 Say "Esta rotina deve ser executada em modo"
	@ 13,21 Say "exclusivo, e os produtos a serem digita-"
	@ 14,21 Say "dos nao devem ter nenhum movimento em "
	@ 15,21 Say "aberto (OP's, Empenhos, NF's a faturar"
	@ 16,21 Say ",Etc.)"
	Set Color To w/r
	@ 18,42 Say "Pressione uma tecla."
	Set Color To b/n
	@ 11,14 Clear To 19,15
	@ 19,14 Clear To 19,62
	@ 19,42,19,43 Box "°"
	@ 12,14,12,15 Box "°"
	Inkey(0)
	RestScreen(10,14,19,64,cSaveMenuh)
	cSaveMenuh := SaveScreen(05,05,13,51)
	Tone(3500,1)
	cSaveMenuh := SaveScreen(10,14,19,70)
	Set Color To w+/r
	@ 10,16 Clear To 18,70
	@ 11,19 To 17,67
	@ 11,30 Say " A  T  E  N  C  Ž  O "
	@ 12,21 Say "Este programa foi construido com o objetivo " 
	@ 13,21 Say "de adequar os Saldos em Estoque existentes "
	@ 14,21 Say "ao controle de Localiza‡„o F¡sica do Esto-"
	@ 15,21 Say "que.As informa‡”es aqui digitadas ir„o "
	@ 16,21 Say "gerar Saldo por Localiza‡„o F¡sica."
	Set Color To w/r
	@ 18,42 Say "Pressione uma tecla."
	Set Color To b/n
	@ 11,14 Clear To 19,15
	@ 19,14 Clear To 19,68
	@ 19,42,19,43 Box "°"
	@ 12,14,12,15 Box "°"
	Inkey(0)
	RestScreen(10,14,19,70,cSaveMenuh)
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas pelo programa                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cAlias:="SDA"
nPosLotCtl:=5
nPosLote:=6
nPosdValid:=8

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis dos Gets de Cabecalho                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cDocumento:=CriaVar("DA_DOC")
cSerie:=CriaVar("DA_SERIE")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo da Janela                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo:="Cria‡„o de Localiza‡„o F¡sica"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Cabecalho do Modelo 2      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aC:={}
aR:={}

#IFDEF WINDOWS
	AADD(aC,{"cDocumento"   ,{20,5},"Documento","@!",,,.T.})
	AADD(aC,{"cSerie"       ,{20,120},"Serie","@!",,,.T.})
#ELSE
	AADD(aC,{"cDocumento"   ,{6,5},"Documento","@!",,,.T.})
	AADD(aC,{"cSerie"       ,{6,30},"Serie" ,"@!",,,.T.})
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aHeader                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nUsado:=0
aHeader:={}
dbSelectArea("SX3")
dbSetOrder(2)
dbSeek("DA_PRODUTO")
AADD(aHeader,{TRIM(x3_titulo),x3_campo,x3_picture,x3_tamanho,x3_decimal,"NaoVazio() .And. ExistCpo('SB1') .And. Localiza(M->DA_PRODUTO)",x3_usado,x3_tipo,x3_arquivo,x3_context})
dbSeek("DA_LOCAL")
AADD(aHeader,{TRIM(x3_titulo),x3_campo,x3_picture,x3_tamanho,x3_decimal,"NaoVazio() .And. Existcpo('SB2',aCols[n,1]+M->DA_LOCAL)",x3_usado,x3_tipo,x3_arquivo,x3_context})
dbSeek("DB_LOCALIZ")
AADD(aHeader,{TRIM(x3_titulo),x3_campo,x3_picture,x3_tamanho,x3_decimal,"ExistCpo('SBE',aCols[n,2]+M->DB_LOCALIZ)",x3_usado,x3_tipo,x3_arquivo,x3_context})
dbSeek("DB_QUANT")
AADD(aHeader,{TRIM(x3_titulo),x3_campo,x3_picture,x3_tamanho,x3_decimal,"M->DB_QUANT > 0",x3_usado,x3_tipo,x3_arquivo,x3_context})
dbSeek("DA_LOTECTL")
AADD(aHeader,{TRIM(x3_titulo),x3_campo,x3_picture,x3_tamanho,x3_decimal,"IF(Rastro(aCols[n,1]),NaoVazio(),Vazio())",x3_usado,x3_tipo,x3_arquivo,x3_context})
dbSeek("DA_NUMLOTE")
AADD(aHeader,{TRIM(x3_titulo),x3_campo,x3_picture,x3_tamanho,x3_decimal,"IF(Rastro(aCols[n,1],'S'),NaoVazio(),Vazio())",x3_usado,x3_tipo,x3_arquivo,x3_context})
dbSeek("DB_NUMSERI")
AADD(aHeader,{TRIM(x3_titulo),x3_campo,x3_picture,x3_tamanho,x3_decimal,"IF(Rastro(aCols[n,1]),NaoVazio(),Vazio())",x3_usado,x3_tipo,x3_arquivo,x3_context})
dbSeek("B7_DTVALID")
AADD(aHeader,{TRIM(x3_titulo),x3_campo,x3_picture,x3_tamanho,x3_decimal,"IF(Rastro(aCols[n,1]),NaoVazio(),Vazio())",x3_usado,x3_tipo,x3_arquivo,x3_context})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aCols                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCols:={{CriaVar("DA_PRODUTO"),CriaVar("DA_LOCAL"),CriaVar("DB_LOCALIZ"),CriaVar("DB_QUANT"),CriaVar("DA_LOTECTL"),CriaVar("DA_NUMLOTE"),CriaVar("DB_NUMSERI"),CriaVar("B7_DTVALID"),.F.}}

dbSelectArea(cAlias)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com coordenadas da GetDados no modelo2                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF WINDOWS
	aCGD:={44,5,118,315}
#ELSE
	aCGD:={09,04,17,73}
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cLinhaOk:="ExecBlock('LinOkLoc',.F.,.F.)"
cTudoOk:="AllwaysTrue()"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Modelo2                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAlias)
lTudoOk :=.T.
lValidar:=.T.
lRetMod2:=.T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ativa tecla F4 para comunicacao com Saldos dos Lotes         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFNDEF WINDOWS
	SetKey( K_F4, {|a,b,c| F4Lote(a,b,c,"A650",aCols[n,1],aCols[n,2])} )
#ELSE
	SetKey( VK_F4,{ || F4Lote(,,,"A650",aCols[n,1],aCols[n,2]) })
#ENDIF
		
While .T.
	lRetMod2:=Modelo2(cTitulo,aC,aR,aCGD,3,cLinhaOk,cTudoOk)
	If lRetMod2 .and. !lTudoOk
		Loop
	Endif
	Exit
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Desativa tecla F4 para comunicacao com Saldos dos Lotes      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFNDEF WINDOWS
	Set Key K_F4 TO
#ELSE
	Set Key VK_F4 TO
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava producao                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If lRetMod2.and.lTudoOk
	Processa()
Endif
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> __RETURN(NIL)
Return(NIL)        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Processa  ³ Autor ³ Rodrigo de A. Sartorio³ Data ³ 16/04/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava saldo na localizacao                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function Processa
Static Function Processa()
// Obtem numero sequencial do movimento
cNumSeq:=ProxNum()

// ("DA_PRODUTO")
// ("DA_LOCAL")
// ("DB_LOCALIZ")
// ("DB_QUANT")
// ("DA_LOTECTL")
// ("DA_NUMLOTE")
// ("DB_NUMSERI")

// Varre o ACols gravando o SDB
For i:=1 to Len(aCols)
	If !(aCols[i,Len(aCols[i])])
		RecLock("SDB",.T.)
		Replace DB_FILIAL		With xFilial()
		Replace DB_PRODUTO	With aCols[i,1]
		Replace DB_LOCAL		With aCols[i,2]
		Replace DB_LOCALIZ	With aCols[i,3]
		Replace DB_QUANT 		With aCols[i,4]
		Replace DB_LOTECTL	With aCols[i,5]
		If Rastro(aCols[i,1],"S")
			Replace DB_NUMLOTE	With aCols[i,6]
		EndIf
		Replace DB_NUMSERI	With aCols[i,7]
		Replace DB_ORIGEM		With "ACE"
		Replace DB_DOC			With cDocumento
		Replace DB_SERIE		With cSerie
		Replace DB_DATA		With dDataBase
		Replace DB_NUMSEQ		With cNumSeq
		Replace DB_TM			With "499"
		Replace DB_TIPO		With "M"
		SDB->(MsUNLOCK())
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Soma saldo em estoque por localizacao fisica (SBF)     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		GravaSBF("SDB")
	EndIf
Next i
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> __RETURN(NIL)
Return(NIL)        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
