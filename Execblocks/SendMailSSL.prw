#include "rwmake.ch"
/*    
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSendMailSSLบAutor  ณDanilo C S Pala     บ Data ณ  20110218   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Teste de envio de email pelo Gmail                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User function sendMailSSL(cFrom, cTo, cCC, cBC, cTitle, cBody, cFilename)
Local oServer  := Nil
local oMessage := Nil
local nErr     := 0


local cPopAddr  := "pop.example.com"      // Endereco do servidor POP3
local cSMTPAddr := GETMV("MV_RELSERV")     // Endereco do servidor SMTP
local cPOPPort  := 995                    // Porta do servidor POP
local cSMTPPort := 465                    // Porta do servidor SMTP
local cUser     := alltrim(GETMV("MV_EMCONTA")) // Usuario que ira realizar a autenticacao
local cPass     := alltrim(GETMV("MV_EMSENHA")) // Senha do usuario
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
oMessage:cFrom    := cFrom
oMessage:cTo      := cTo
oMessage:cCC      := cCC
oMessage:cBCC     := cBC
oMessage:cSubject := cTitle
oMessage:cBody    := cBody

//Adiciono um attach
If !empty(cFilename)
	If oMessage:AttachFile( cFilename ) < 0
		Conout( "Erro ao atachar o arquivo" )
		Return .F.
	Else                     
		//adiciono uma tag informando que ้ um attach e o nome do arq
		oMessage:AddAtthTag( 'Content-Disposition: attachment; filename='+ cFilename)
	EndIf
EndIf

                                       
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