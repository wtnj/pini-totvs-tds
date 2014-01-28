#include "rwmake.ch"
/*   
Danilo 20050609: incrementar numero sequencial
Danilo 20050704: zerar iof
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFIN019	ºAutor  ³Danilo C S Pala     º Data ³  20050419   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ gerar arquivo para sisdeb								  º±±
±±º          ³                     										  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PFIN019
// MONTAR TELA DE PARAMETROS                                        
Private DoBordero := space(6)
Private AteBordero := space(6)                                                    
Private col_inconsist
Private ped_inconsist
PRIVATE NQTDREG := 0
PRIVATE NTOTALDEB := 0
PRIVATE NBANCO := SPACE(3)
PRIVATE NAGENCIA := SPACE(5)
PRIVATE NCONTA := SPACE(10)
PRIVATE MNOME := SPACE(30)
PRIVATE MCGC := SPACE(14)


@ 010,001 TO 200,200 DIALOG oDlg TITLE "Consistencia SISDEB"
@ 005,010 SAY "Do bordero:"
@ 005,040 GET Dobordero 
@ 020,010 SAY "Ate bordero:"
@ 020,040 GET Atebordero   
@ 035,010 SAY "Banco: "
@ 035,040 GET NBANCO F3("BCO")

/* ????
@ 005,010 SAY "Banco:"
@ 005,010 SAY "Agencia"
@ 005,010 SAY "Conta"
*/
@ 055,010 BUTTON "Processar" SIZE 40,12 ACTION Processa({||PROC_SISDEB()})
@ 055,050 BUTTON "Fechar" SIZE 40,12 Action ( Close(oDlg) )
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
SetPrvt("mhora")


tamanho  := "G"
limite   := 220
titulo   := PADC("Consistencia para SISDBE",74)
cDesc1   := PADC("Este programa verifica a consistencia dos dados",74)
cDesc2   := PADC("do pedido para gerar o CNAB ao SISDEB",74)
cDesc3   := ""
cNatureza:= ""

aReturn  := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
nomeprog := "FPIN019"
nLastKey := 0
lContinua:= .T.
MHORA      := TIME()
wnrel    := "PFIN019_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
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

// localizar o SEE
DBSelectArea("SEE")
DBSetOrder(1)
IF DBSEEK(XFILIAL("SEE")+ SA6->A6_COD + SA6->A6_AGENCIA+ SA6->A6_NUMCON)

ENDIF
	
                                        
// HEADER DE ARQUIVO
@ LIN,000 PSAY "34100000         2";
+ SM0->M0_CGC + U_SISDEB("EMPRESA","") + "       0" + SUBSTR(SEE->EE_AGENCIA,1,4) ;
+" 0000000"+ SUBS(SEE->EE_CONTA,1,5) + " " + SUBS(SEE->EE_CONTA,7,1) ;
+ SM0->M0_NOME + space(15) +"BANCO ITAU"+ space(30) + "1" ;
+ STRZERO(DAY(DDATABASE),2)+STRZERO(MONTH(DDATABASE),2)+SUBSTR(DTOS(DDATABASE),1,4) ;  
+ SUBS(TIME(),1,2)+SUBS(TIME(),4,2)+SUBS(TIME(),7,2) + SEE->EE_ULTDSK ;
+ "04000000" +space(69)      
    
LIN := LIN +1

// HEADER DE LOTE
@ LIN,000 PSAY "34100011D0550030 2"+ SM0->M0_CGC + U_SISDEB("EMPRESA","")+ SPACE(7);
+ "0"+ SUBSTR(SEE->EE_AGENCIA,1,4) + " 0000000"+ SUBS(SEE->EE_CONTA,1,5);
+ " "+ SUBS(SEE->EE_CONTA,7,1) + SM0->M0_NOME + SPACE(55) + "RUA ANHAIA" +SPACE(20) ;
+ STRZERO(964, 5) + SPACE(15) + SM0->M0_CIDCOB + SM0->M0_CEPCOB + SM0->M0_ESTCOB + SPACE(18)

DBSELECTAREA("SE1")
DBSETORDER(5)                  
        
DBSeek(xfilial("SE1")+dobordero)
While !EOF() .and. se1->e1_numbor >= Dobordero .and. se1->e1_numbor <= Atebordero
	LIN := LIN +1

	NQTDREG := NQTDREG + 1     
	NTOTALDEB := NTOTALDEB + SE1->E1_SALDO
	
	// localizar o cliente
	DBSelectArea("SA1")
	DBSetOrder(1)
	IF DBSEEK(XFILIAL("SA1")+ SE1->E1_CLIENTE)
		MNOME := SA1->A1_NOME
		MCGC := SA1->A1_CGC
	ELSE
		MNOME := ""
		MCGC := ""
	ENDIF      

	DBSELECTAREA("SE1")
	
	// DETALHE DE LOTE                    
	@ LIN,000 PSAY "34100013" + STRZERO(NQTDREG,5) + "A0000003410"+ U_SISDEB(SE1->E1_PEDIDO,"AGENCIA");
	+ " 0000000"+ U_SISDEB(SE1->E1_PEDIDO,"CONTA") + " " + U_SISDEB(SE1->E1_PEDIDO,"DAC") + substr(MNOME,1,30) ;
	+ SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA + space(10) + SE1->(STRZERO(DAY(E1_VENCTO),2)+STRZERO(MONTH(E1_VENCTO),2)+STRZERO(YEAR(E1_VENCTO),4));
	+ "REA" + STRZERO(0,15) + STRZERO(INT(SE1->E1_SALDO*100),15) + SPACE(28)+ SPACE(15);
	+ "00"+ STRZERO(0,17)+ SPACE(16)  + SPACE(4) + MCGC + SPACE(10)
	
	
	DBSelectArea("SE1")
	DBSkip()             
End                   

LIN := LIN +1
// TRAILLER DE LOTE                            
@ LIN,000 PSAY "34100015"+ SPACE(9) + STRZERO(INT(NQTDREG + 2),6) + STRZERO(INT(NTOTALDEB*100),18);
+ STRZERO(0,18) + SPACE(171)+ SPACE(10)

LIN := LIN +1
//TRAILLER DE ARQUIVO
@ LIN,000 PSAY "34199999"+ SPACE(9) + "000001" + STRZERO(NQTDREG+4,6) +SPACE(211)
LIN := LIN +1
@ LIN,000 PSAY ""    

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

DBSELECTAREA("SEE")                                                                        
RECLOCK("SEE",.F.) //Update = F                         //20050608
	SEE->EE_ULTDSK := STRZERO(val(SEE->EE_ULTDSK) + 1, 6)
MSUNLOCK("SEE")
DBCLOSEAREA("SEE")    

DBSELECTAREA("SA1")
DBCLOSEAREA("SA1")

DBSELECTAREA("SE1")
DBCLOSEAREA("SE1")

return