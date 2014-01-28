#include "rwmake.ch"
#include "ap5mail.ch"
#include "TOTVS.CH"
/*     20030829
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEmailTesteบAutor  ณDanilo C S Pala     บ Data ณ  20110218   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Teste de envio de email pelo Gmail                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function EmailTeste
/*Private cServMail := "smtp.gmail.com:465"
Private cEmailConta := GETMV("MV_EMCONTA")//"dpala@pini.com.br"
Private cEmailSenha := GETMV("MV_EMSENHA")//"1235"
Private cBody := "<html><body><h1>chegou?</h1></body></html>"
Private cTitulo := "Teste siga"
Private lEnviado := .F.

/*CONNECT SMTP SERVER cServMail ACCOUNT cEmailConta PASSWORD cEmailSenha SSL RESULT lEnviado
SEND MAIL FROM cEmailConta TO cEmailConta SUBJECT cTitulo BODY cBody RESULT lEnviado
DISCONNECT SMTP SERVER
  */                                                                  


local oServer  := Nil
local oMessage := Nil
local nErr     := 0


local cPopAddr  := "pop.example.com"      // Endereco do servidor POP3
local cSMTPAddr := "smtp.gmail.com"     // Endereco do servidor SMTP
local cPOPPort  := 110                    // Porta do servidor POP
local cSMTPPort := 465                    // Porta do servidor SMTP
local cUser     := "dpala@pini.com.br"     // Usuario que ira realizar a autenticacao
local cPass     := "sano32"             // Senha do usuario
local nSMTPTime := 60                     // Timeout SMTP
             
// Instancia um novo TMailManager
oServer := tMailManager():New()    

// Usa SSL na conexao
oServer:setUseSSL(.T.)

// Inicializa
oServer:init(cPopAddr, cSMTPAddr, cUser, cPass, cPOPPort, cSMTPPort)

// Define o Timeout SMTP
if oServer:SetSMTPTimeout(nSMTPTime) != 0
  conout("[ERROR]Falha ao definir timeout")
  return .F.
endif

// Conecta ao servidor
nErr := oServer:smtpConnect()
if nErr <> 0
  conOut("[ERROR]Falha ao conectar: " + oServer:getErrorString(nErr))
  oServer:smtpDisconnect()
  return .F.
endif
                      
// Realiza autenticacao no servidor
nErr := oServer:smtpAuth(cUser, cPass)
if nErr <> 0
  conOut("[ERROR]Falha ao autenticar: " + oServer:getErrorString(nErr))
  oServer:smtpDisconnect()
  return .F.
endif

// Cria uma nova mensagem (TMailMessage)
oMessage := tMailMessage():new()
oMessage:clear()
oMessage:cFrom    := "dpala@pini.com.br"
oMessage:cTo      := "dpala@pini.com.br"
//oMessage:cCC      := "cc@example.com"
//oMessage:cBCC     := "bcc@example.com"
oMessage:cSubject := "Teste"
oMessage:cBody    := "Corpo do e-mail"
                                        
// Envia a mensagem
nErr := oMessage:send(oServer)
if nErr <> 0
  conout("[ERROR]Falha ao enviar: " + oServer:getErrorString(nErr))
  oServer:smtpDisconnect()
  return .F.
endif

// Disconecta do Servidor
oServer:smtpDisconnect()

return .T.

Return
