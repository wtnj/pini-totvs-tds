#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LOADPCLI  ºAutor  Danilo C S Pala      º Data ³  04/25/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function LoadPCli()
SetPrvt("MRET,")   
SetPrvt("_NREGSA1,NLASTKEY,NOPCX,_CCLIENTE,AHEADER,NUSADO")
SetPrvt("CTITULO,NLINGETD,AC,AR,ACOLS,_CSTR")
SetPrvt("_LPED,_ACAMPOS,_CNOMARQ,_CKEY,_CMSG,_CDTINIC")
SetPrvt("_CDTFIN,_CDTVENC,_CDTSUSP,_CMOTIVO,ACGD,CLINHAOK")
SetPrvt("CTUDOOK,LRETMOD2,cPedido")
MRET:='NOME'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aHeader                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aHeader:={}
nUsado:=0
	
nUsado:=nUsado+1
aAdd( aHeader, { "Detalhes do Pedido...", "TEXTO", "", 80, 0,;
"AllWaysTrue()", "€€€€€‚", "C", "TRB", Space(1) } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo da Janela                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo:= "Integração PiniProtheusService/Webass"
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Rodape do Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLinGetD:=0

// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza
nOpcx:=6

	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Cabecalho do Modelo 2      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aC:={}
// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.
//AADD(aC,{"_cCliente" , {15,10}  , "Cliente "  , "@!",,, .F. })
//cAlias:="SA1"
cPedido :=  space(10)
//cPedido :=CriaVar("A1_NOME",.T.)
//M->&("cPedido") := CriaVar("cPedido",.T.)

aAdd(aC,{"cPedido",{15,010},"Pedido","@!","u_AcharPcli()" ,,.T.})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Rodape do Modelo 2         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aR:={}
// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .T. se nao .F.
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aCols                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCols := {}


aAdd( aCols, { "Aqui aparecerão os detalhes do pedido...", .F. } )
                              
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com coordenadas da GetDados no modelo2                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCGD:= {30,5,125,200}
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cLinhaOk        := "AllWaysTrue()"
cTudoOk         := "AllWaysTrue()"
        
	                                                                                  
Private aPini := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Modelo2                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lRetMod2 := Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk,,,,,{125,50,500,635})

If lRetMod2
	if Len(aPini)>1
		MRET := aPini[2]
		M->a1_nreduz := substr(aPini[2],1,20)
		if len(alltrim(aPini[3]))<14
			M->a1_pessoa := "F"
			M->a1_tpcli := "F"
		else
			M->a1_pessoa := "J"
			M->a1_tpcli := "J"
		endif
		M->a1_cgc := aPini[3]
		M->a1_end := aPini[4]
		M->a1_bairro := aPini[5]
		M->a1_cep := aPini[6]
		M->a1_mun := aPini[7]
		M->a1_est := aPini[8]
		M->a1_tel := aPini[9]   
		M->a1_email := aPini[10]  
		M->a1_flagid := 1
	endif
Else
	MRET:= M->a1_nome
EndIf
DbSelectArea("SA1")
Return(MRET)                



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Achar     ºAutor  ³Marcio Torresson    º Data ³  10/06/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gatilho para o cadastro de cliente                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                                             
User Function AcharPcli()
Private codUsuario 	:= "21" //como testes usar o 1
Private cQuery 		:= ""
Private cRetorno	:= ""
aCols := {}// zerando o array acols
cQuery := "select numpedido, codclientepini, codclientefornecedor, nomecliente, cpfcnpj, email, fone, contato, endereco, bairro, cep, municipio, estado, tipopedido from pinipedido WHERE CODEMPRESA='"+ SM0->M0_CODIGO +"' AND CODUSUARIO="+ codUsuario +" AND numpedido='"+ alltrim(m->cPedido) +"'"
DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PINIPAR", .T., .F. )
DbSelectArea("PINIPAR")
dbGotop()                
aPini := {}

If !EOF()
	/*MRET :=	PINIPAR->NOMECLIENTE
	M->a1_email := PINIPAR->EMAIL
	M->a1_cgc := PINIPAR->CPFCNPJ
	M->a1_tel := PINIPAR->FONE
	M->a1_end := PINIPAR->ENDERECO
	M->a1_bairro := PINIPAR->BAIRRO
	M->a1_cep := PINIPAR->CEP
	M->a1_mun := PINIPAR->MUNICIPIO
	M->a1_est := PINIPAR->ESTADO*/                 
	aAdd( aPini, cPedido)
	aAdd( aPini, PINIPAR->NOMECLIENTE)
	aAdd( aPini, PINIPAR->CPFCNPJ)
	aAdd( aPini, PINIPAR->ENDERECO)
	aAdd( aPini, PINIPAR->BAIRRO)
	aAdd( aPini, PINIPAR->CEP)
	aAdd( aPini, PINIPAR->MUNICIPIO)
	aAdd( aPini, PINIPAR->ESTADO)
	aAdd( aPini, PINIPAR->FONE)
	aAdd( aPini, PINIPAR->EMAIL)
	
	aAdd( aCols, { "Pedido: "+ M->cPedido, .F. } )
	aAdd( aCols, { "  Nome: "+ PINIPAR->NOMECLIENTE, .F. } )
	aAdd( aCols, { "  CGC: "+ PINIPAR->CPFCNPJ, .F. } )
	aAdd( aCols, { "  Endereco: "+ PINIPAR->ENDERECO, .F. } )
	aAdd( aCols, { "  Bairro: "+ PINIPAR->BAIRRO, .F. } )
	aAdd( aCols, { "  CEP: "+ PINIPAR->CEP, .F. } )
	aAdd( aCols, { "  Municipio: "+ PINIPAR->MUNICIPIO, .F. } )
	aAdd( aCols, { "  Estado: "+ PINIPAR->ESTADO, .F. } )
	aAdd( aCols, { "  Fone: "+ PINIPAR->FONE, .F. } )
	aAdd( aCols, { "  Email: "+ PINIPAR->EMAIL, .F. } )
	

	DbSelectArea("SA1")	
	dbSetOrder(3) //A1_FILIAL + A1_CGC
	If dbSeek(xFilial("SA1")+PINIPAR->CPFCNPJ)
		MsgAlert("Atenção este CPF ou CPNJ já existe!"+ CHR(10)+CHR(13) +"Codigo:"+ SA1->A1_COD + CHR(10)+CHR(13) +"Nome:" +SA1->A1_NOME)
	EndIf
	
Else               
	aAdd( aCols, { "Pedido "+ M->cPedido +" nao localizado", .F. } )
	MRET := nil
EndIf   
DbSelectArea("PINIPAR")
DBCloseArea("PINIPAR")


// Para atualizar o GetDados, utilize a função CallMod2Obj, que o retorna
// como uma referência:
xObj := CallMod2Obj()
xObj:oBrowse:Refresh() // Remova o espaço antes do oBrowse...
//DbSelectArea("SA1")
return