#include "rwmake.ch"
/*   
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFIN018	ºAutor  ³Danilo C S Pala     º Data ³  20041215   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica se os pedidos(sc5) dos titulos do bordero contem  º±±
±±º          ³  os dados para o SISDEB									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PFIN018
// MONTAR TELA DE PARAMETROS                                        
Private DoBordero := space(6)
Private AteBordero := space(6)                                                    
Private col_inconsist
Private ped_inconsist

@ 010,001 TO 200,200 DIALOG oDlg TITLE "Consistencia SISDEB"
@ 005,010 SAY "Do bordero:"
@ 005,040 GET Dobordero 
@ 020,010 SAY "Ate bordero:"
@ 020,040 GET Atebordero  
/* ????
@ 005,010 SAY "Banco:"
@ 005,010 SAY "Agencia"
@ 005,010 SAY "Conta"
*/
@ 040,010 BUTTON "Processar" SIZE 40,11 ACTION Processa({||PROC_SISDEB()})
@ 040,050 BUTTON "Cancelar" SIZE 40,11 Action ( Close(oDlg) )
Activate Dialog oDlg CENTERED
RETURN
        



/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao que faz um loop no SE1, e verifica a consistencia dos dados no SC5³
//³para o SISDEB                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/
STATIC FUNCTION PROC_SISDEB      
SetPrvt("tamanho, limite, titulo, cDesc1, cDesc2")
SetPrvt("cDesc3, cNatureza, aReturn, SERNF, nomeprog")
SetPrvt("cPerg, nLastKey, lContinua, wnrel")
SetPrvt("")


tamanho  := "G"
limite   := 220
titulo   := PADC("Consistencia para SISDBE",74)
cDesc1   := PADC("Este programa verifica a consistencia dos dados",74)
cDesc2   := PADC("do pedido para gerar o CNAB ao SISDEB",74)
cDesc3   := ""
cNatureza:= ""

aReturn  := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
nomeprog := "FPIN018"
nLastKey := 0
lContinua:= .T.
wnrel    := "PFIN018 "
cString:="SE1"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica Posicao do Formulario na Impressora                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

LI:=0
LIN:=PROW()

//Lin := Cabec("Titulo","Cabec1","Cabec2",nomeprog,tamanho,15)  
//Lin := Lin +2
ProcRegua(100)
	@ LIN,003 PSAY "TITULO"
	@ LIN,016 PSAY "PEDIDO"
	@ LIN,024 PSAY "VALOR"
	@ LIN,034 PSAY "VENCIMENTO"
	@ LIN,044 PSAY "BAIXA"
	@ LIN,054 PSAY "CONSISTENCIA"  
	Lin++

DBSELECTAREA("SE1")
DBSETORDER(5)                  

DBSeek(xfilial("SE1")+dobordero)
While !EOF() .and. se1->e1_numbor >= Dobordero .and. se1->e1_numbor <= Atebordero
                     
	col_inconsist := ""   
	DBSelectArea("SC5")
	DBSetOrder(1)
	IF DBSEEK(XFILIAL("SC5")+se1->e1_pedido)
		if EMPTY(SC5->C5_DEBBANC)
			col_inconsist += "BANCO | "
		ENDIF
	
		IF EMPTY(SC5->C5_DEBAGEN)
			col_inconsist += "AGENCIA | "
		ENDIF

		IF EMPTY(SC5->C5_DEBCONT)
			col_inconsist += "CONTA | "
		ENDIF     
	
		IF EMPTY(SC5->C5_DEBDAC)
   			col_inconsist += "DAC | "
		ENDIF
	ELSE
		col_inconsist += "PEDIDO NAO LOCALIZADO!!!"
	ENDIF                      

	@ LIN,003 PSAY se1->E1_PREFIXO + se1->E1_NUM + se1->E1_PARCELA
	@ LIN,016 PSAY se1->e1_pedido
	@ LIN,024 PSAY se1->e1_VALOR 
	@ LIN,034 PSAY DTOC(se1->e1_VENCTO)
	@ LIN,044 PSAY DTOC(se1->e1_BAIXA)
	@ LIN,054 PSAY col_inconsist
	
	DBSelectArea("SE1")
	DBSkip()             
	LIN++
End

SET DEVICE TO SCREEN

SETPRC(0,0)
	
SET DEVICE TO PRINTER
	
SetPrc(0,0)
                        
SET DEVICE TO SCREEN        
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()

return