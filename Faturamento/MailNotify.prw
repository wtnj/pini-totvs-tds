#INCLUDE "protheus.ch"                                                                              
#include "TbiConn.ch"
#include "TbiCode.ch"
#INCLUDE "XMLXFUN.CH"  
#INCLUDE "AP5MAIL.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ EnvMail  บAutor  ณ Adriano Oliveira   บ Data ณ  08/02/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Envia email com ate dois anexos                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MailNotify(_cEmailTo,_cEmailBcc,_cAssunto,_aMsg,_aAttach,_lMostraMsg)

Local _ni          := 0
Local _lOk         := .F.
Local _lSendOk     := .F.
Local _lRet        := .T.
Local _cError      := ""
Local _cAttach1    := ""
Local _cAttach2    := ""
Local _cMsg        := ""
Local _cArqLog     := ""
Local _cMailConta  := "nfe_tst@rvacari.com.br" //GETMV("MV_EMCONTA")
Local _cMailServer := "smtp.rvacari.com.br:587" //GETMV("MV_RELSERV")
Local _cMailSenha  := "nfe123456" //GETMV("MV_EMSENHA") 
Local   cFileAttachment := ""
Local lResulSend	:= .T. 
//U_CheckPRW("MAILNOTIFY")
//If !AllTrim(GetEnvServer())=="BS_DISTR"
//	Return .F.
//EndIf	
// Monta o corpo do e-mail e cria o arquivo de log no sigaadv
_cMsg := "<html>"
_cMsg += "<DIV><SPAN class=610203920-12022004><FONT face=Verdana color=#ff0000 size=2>"
_cMsg += "<STRONG>Workflow - Servi็o Envio de Mensagens</STRONG></FONT></SPAN></DIV><hr>"   

For _ni := 1 To Len(_aMsg)
	_cMsg   	+= "<DIV><FONT face='Verdana' color='#000080' size='2'><SPAN class=216593018-10022004>"+_aMsg[_ni]+"</SPAN></FONT></DIV><p>"
   	_cArqLog 	:= _aMsg[_ni] + Chr(13) + Chr(10)
Next _ni

_cMsg += "</html>"
If "PALM" $ Upper(_cAssunto)
	MemoWrite("\Workflow\MailNotify\PALM_"+DtoS(dDataBase)+StrTran(Time(),":","")+".HTML",_cMsg)
Else
	MemoWrite("LOGWF_"+DtoS(dDataBase)+StrTran(Time(),":","")+".LOG",_cArqLog)
EndIf

//Verifica se existe o SMTP Server
If Empty(_cMailServer)
	If _lMostraMsg
		Help(" ",1,"SEMSMTP")
	EndIf
	Return(.F.)
EndIf

//Verifica se existe a CONTA
If Empty(_cMailConta)
	If _lMostraMsg
		Help(" ",1,"SEMCONTA")//"A Conta do email nao foi configurado !!!" ,"Atencao"
	EndIf
	Return(.F.)
EndIf

//Verifica se existe a Senha
If Empty(_cMailSenha)
	If _lMostraMsg
		Help(" ",1,"SEMSENHA")	//"A Senha do email nao foi configurado !!!" ,"Atencao"
	EndIf
	Return(.F.)
EndIf

// Verifica se existe destinatario
If Empty(_cEmailTo)
	Return(.F.)
EndIf

// Envia e-mail com os dados necessarios
CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT _lOk
If !_lOk .And. _lMostraMsg
   //	Aviso("Erro ao envio de e-mail","Erro ao conectar ao servidor SMTP",{"Fechar"})
EndIf

// Caso o sistema exija autenticacao, faz a autenticacao
//If GetMv("MV_RELAUTH")
	If !MailAuth(_cMailConta,_cMailSenha)
		If _lMostraMsg
			//MsgInfo("Nao foi possivel autenticar no servidor "+_cMailServer,OemToAnsi("Erro na autenticacao"))
		EndIf
	EndIf
//EndIf

If _lOk
	
	//Alterado: Douglas Rodrigues da Silva, cri็ใo de uma nova verifica็ใo antes da leitura do array.
	If ! ValType(_aAttach) == "U" 		
		If Len(_aAttach) > 0
			_cAttach1 := _aAttach[1]
			If Len(_aAttach) > 1
				_cAttach2 := _aAttach[2]
			EndIf
		EndIf
	EndIf
	
	//SEND MAIL FROM "nfe@rvacari.com.br" TO _cEmailTo BCC _cEmailBcc SUBJECT _cAssunto BODY _cMsg ATTACHMENT _cAttach1, _cAttach2 RESULT _lSendOk
	SEND MAIL FROM _cMailConta TO _cEmailTo SUBJECT _cAssunto BODY _cMsg ATTACHMENT cFileAttachment RESULT lResulSend 
	
	If !lResulSend
		//Erro no Envio do e-mail
		GET MAIL ERROR _cError
		If _lMostraMsg
			//MsgInfo(_cError,OemToAnsi("Erro no envio do e-mail"))
		EndIf
	EndIf
	
	DISCONNECT SMTP SERVER
	
Else
	
	//Erro na conexao com o SMTP Server
	GET MAIL ERROR _cError
	If _lMostraMsg
		//MsgInfo(_cError,OemToAnsi("Erro na conexao com o SMTP Server"))
	EndIf
	
EndIf

Return(lResulSend) 