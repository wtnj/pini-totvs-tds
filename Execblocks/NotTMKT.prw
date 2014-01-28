#include "rwmake.ch"
#include "ap5mail.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Rdmake    ³ NOTURNO  ³ Autor ³ Otavio Pinto          ³ Data ³ 05/03/01  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Copia dos arquivos da producao com tempo pre-definido.      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ NOTURNO()                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico - Editora PINI                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function NOTTMK()

Private _cTitulo  := "Backup Noturno"
Private _ccMens1  := "Hora Inicial.: "
Private _cTempo   := Time()
Private _ccMens2  := "Previsto para: "
Private _ccMens3  := "Hora Atual...: "
Private _cHora    := Time()
Private lEnd      := .F.
Private nCont     := 0
Private cSubdir   := DTOS(dDataBase)

//WinExec("C:\WINDOWS\COMMAND.COM /c md \BKP_AP5\"+cSubdir,2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 010,001 TO 250,400 DIALOG oDlg TITLE _cTitulo
@ 005,010 SAY _ccMens1
@ 005,100 SAY _cTempo  Picture "@R 99:99:99"
@ 015,010 SAY _ccMens2
@ 015,100 GET _cHora   Picture "@R 99:99:99" VALID _cHora >= _cTempo
@ 080,100 BMPBUTTON TYPE 1 ACTION ( Processa({||Copia2()},_ccMens1+_cTempo+"        "+_ccMens2+Transform(_cHora,"@R 99:99:99")), Close(oDlg))
@ 080,140 BMPBUTTON TYPE 2 ACTION ( Close(oDlg) )
Activate Dialog oDlg CENTERED

Return

Static Function Copia2()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa a funcao COPIA2()                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_lExecuta   := .F.
_cTempo     := Time()
_lProcessou := .F.

_nFinal     := ( 3600 * Val( Substr( _cHora,  01, 02 ) ) ) + ( 60 * Val( Substr( _cHora,  04, 02 ) ) ) + Val( Substr( _cHora,  07, 02 ) )
_nTempo     := ( 3600 * Val( Substr( _cTempo, 01, 02 ) ) ) + ( 60 * Val( Substr( _cTempo, 04, 02 ) ) ) + Val( Substr( _cTempo, 07, 02 ) )
_nTime      := (_nFinal - _nTempo)/30
_cTempoAux  := _cTempo



ProcRegua( _nTime )
If !Empty( _cHora ) .and. _cHora >= _cTempo
	While _cTempo < _cHora
		If _cTempo != _cTempoAux
			_cTempoAux := _cTempo
			IncProc("Hora Atual...: " + _cTempo)
		EndIf
		If lEnd // Cancela processamento
			Return .t.
		Endif
		_cTempo := Time()
		If _cTempo >= _cHora
			_lExecuta := .T.
			Exit
		Endif
		Sleep(30000)
	End
Else
	If Empty(_cHora)
		MsgStop("Hora nao pode ficar vazia!")
	Endif
	If _cHora < _cTempo
		MsgStop("Hora para execucao do processamento deve ser..."+chr(13)+chr(13)+;
		"...MAIOR ou IGUAL a HORA ATUAL.")
	Endif
	Envia("P")
Endif

nCont := 0

If _lExecuta
	Envia("I")
	dbSelectArea("SX2")
	dbSetOrder(1)
	dbGotop()
	While !Eof()
		cDriver   := __cRdd
		_cAlias   := SX2->X2_CHAVE
		If !Alltrim(_cAlias)$ "SC5/SC6/SD2/SF2/SZJ/ZZE/SE1/SA3" 
			dbSkip()
			Loop
		EndIf
		_cArquivo := RetArq(cDriver,_cAlias+"010",.T.)  // Nome do arquivo depEndEndo da Rdd
		IncProc( "Copiando o arquivo "+_cArquivo+".DBF" )
		
		//If MsFile(_cArquivo,,cDriver)     // Se o arquivo existir...
		//	If MsOpenDbf(.T.,cDriver,_cArquivo,_cAlias, .T., .F. ,.T.,.T.)
				_lProcessou := .F.
				dbSelectArea(_cAlias)
				dbGotop()
				_cAlias := "\BKP_AP5\"+cSubdir+"\"+_cArquivo+".DBF"    //+ALLTRIM(SX2->X2_PATH)
				Copy To &_cAlias
				dbCloseArea()
				_lProcessou := .T.
//			EndIf
//		EndIf
		//If _lProcessou // Se iniciou copia para a area de transferencia
   		//	MsAguarde({|| WinExec("C:\WINDOWS\COMMAND.COM /c move F:\BKP_AP5\"+_cArquivo+".dbf g:\bkp_ap5\",2)},"Copiando "+_cArquivo,"Aguarde fim da copia",.f.)
        nCont++
        //EndIf
		dbSelectArea("SX2")
		dbSkip()
	End
EndIf

dbCloseArea()

If _lProcessou
	Envia("F")
	MsgBox("Hora Inicial........... : "+transform(_cHora,"@r 99:99:99")+Chr(13)+;
	"Hora Final............. : "+transform(Time()  ,"@r 99:99:99"),"Backup concluido...")
Else
	MsgStop("Nao houve processamento ( Backup )","Processo Concluido...")
Endif

Return .T.

Static Function Envia(cTipo)

Private cDest     := "mfarineli@pini.com.br;1199309317@torpedoinfo.com.br;raquel@pini.com.br"  //"mfarineli@pini.com.br;josepires@pini.com.br;valdir@pini.com.br"
Private cServMail := "172.22.4.51"
Private cSend     := "ap5@pini.com.br"
Private cBody     := "" //"Nao responda esta mensagem."+CHR(10)+CHR(13) //O Backup da base foi programado para "+Time()
Private cTitulo   := "" // "AP5"

If cTipo == "P"
	cTitulo += "programacao"
	cBody += "Backup programado para "+Transform(_cHora,"@R 99:99:99") +" as "+Time()+CHR(10)+CHR(13)
	cBody += "pelo usuario "+Substr(cUsuario,7,13)+"."+CHR(10)+CHR(13)
	cBody += "FIM DA MENSAGEM."+CHR(10)+CHR(13)
ElseIf cTipo == "I"
	cTitulo += "iniciado"
	cBody += "Backup iniciado as "+Time()+"."+CHR(10)+CHR(13)
	cBody += "FIM DA MENSAGEM."+CHR(10)+CHR(13)
ElseIf cTipo == "F"
	cTitulo += "finalizado"
	cBody += "Backup finalizado as "+Time()+"."+CHR(10)+CHR(13)
	cBody += "Copiadas "+Str(nCont)+" tabelas."+CHR(10)+CHR(13)
	cBody += "FIM DA MENSAGEM."+CHR(10)+CHR(13)
EndIf

CONNECT SMTP SERVER cServMail ACCOUNT cSend PASSWORD ""
SEND MAIL FROM cSend TO cDest SUBJECT cTitulo BODY cBody
DISCONNECT SMTP SERVER

Return