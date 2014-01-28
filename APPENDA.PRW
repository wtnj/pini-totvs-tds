#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: APPENDA   ³Autor: Danilo                 ³ Data: 20030702   ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Append no AP5 											 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento  							         ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function APPENDA()
SetPrvt("cTipo")
Private _cTitulo  := "Append no AP5"
Private _ccMens1  := "Fonte:"
Private _ccMens2  := "Tabela:"
Private _ccMens3  := "Indice:"  
Private _ccMens4  := "Email:"  
Private _cFonte   := space(50)//"\IMPORT\SC5_ER.DBF"
Private _cTabela  := space(3)
Private _cIndice  := 1     
Private _cEmail   := space(50)
                                                    

@ 010,001 TO 140,250 DIALOG oDlg TITLE _cTitulo
@ 005,010 SAY _ccMens1
@ 005,035 GET _cFonte
@ 020,010 SAY _ccMens2
@ 020,035 GET _cTabela      
@ 020,070 SAY _ccMens3
@ 020,087 GET _cIndice      
@ 035,010 SAY _ccMens4
@ 035,035 GET _cEmail      
@ 050,030 BMPBUTTON TYPE 1 ACTION Processa({||Iniciar()})
@ 050,070 BMPBUTTON TYPE 2 ACTION ( Close(oDlg) )
Activate Dialog oDlg CENTERED
Return

Static Function Iniciar()
_cTabela := AllTrim(_cTabela)
_cFonte := AllTrim(_cFonte)   
_cEmail := AllTrim(_cEmail)
Envia("I")

DbSelectArea(_cTabela)
DBSetORder(_cIndice)

Append from &(_cFonte)         //sc5_ER.dbf
DBCloseArea(_cTabela)             

Envia("F")  
MsgAlert("Fim do processamento!")
return        


Static Function Envia(cTipo)

Private cDest     := _cEmail
Private cServMail := "172.22.4.51"
Private cSend     := "ap5@pini.com.br"
Private cBody     := "" 
Private cTitulo   := ""

if cTipo = "I"
	cTitulo += "Append do tabela "+Alltrim(_Ctabela)+": inicio"
	cBody += "Append Iniciado as "+Time()
else
	cTitulo += "Append do tabela "+Alltrim(_Ctabela)+": fim"
	cBody += "Append Finalizado as "+Time()
endif

CONNECT SMTP SERVER cServMail ACCOUNT cSend PASSWORD ""
SEND MAIL FROM cSend TO cDest SUBJECT cTitulo BODY cBody
DISCONNECT SMTP SERVER

Return
