/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMRD003  บAutor  ณTHIAGO COMELLI      บ Data ณ  06/21/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Envia WorkFlow de Aprovacao de Solicitacao de Compras      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑบ          ณ Necessario Criar Campo                                     บฑฑ
ฑฑบ          ณ Nome			Tipo	Tamanho	Titulo			OBS           บฑฑ
ฑฑบ          ณ C1_CODAPRO   C         6    Cod Aprovador                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function COMRD003()

Local cSuperior := PswRet()[1][11]
Local cTotItem := Strzero(Len(aCols),4)
Private cDiasA
Private cDiasE

//GRAVA O NOME DA FUNCAO NA Z03
U_CFGRD001(FunName())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica a Existencia de Parametro MV__TIMESCณ
//ณCaso nao exista. Cria o parametro.           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SX6")
If ! dbSeek("  "+"MV__TIMESC")
	RecLock("SX6",.T.)
	X6_VAR    	:= "MV__TIMESC"
	X6_TIPO 	:= "C"
	X6_CONTEUD 	:= "0305"
	X6_CONTENG 	:= "0305"
	X6_CONTSPA 	:= "0305"
	X6_DESCRIC	:= "DEFINE TEMPO EM DIAS DE TIMEOUT DA APROVACAO DE SO"
	X6_DESC1	:= "LICITACAO DE COMPRAS - EX: AVISO EM 3 DIAS E EXCLU"
	X6_DESC2	:= "SAO EM 5 DIAS = 0305                              "
	MsUnlock("SX6")
EndIf

cDiasA := SubStr(GetMv("MV__TIMESC"),1,2) //TIMEOUT Dias para Avisar Aprovador
cDiasE := SubStr(GetMv("MV__TIMESC"),3,2) //TIMEOUT Dias para Excluir a Solicitacao

Pergunte("COMRD3",.F.) //Carrega Perguntas

If ! Empty(cSuperior)
	RecLock("SC1",.F.)
	C1_CODAPRO := cSuperior
	MsUnlock()
	/*	If mv_par04 == 1 //Aprovacao por ITEM
	U_COMWF002()
	ElseIf SC1->C1_ITEM == cTotItem //Aprovacao por SOLICITACAO
	U_COMWF001()
	EndIf
	*/
	U_COMWF002() //Envio dos Detalhes da Solicitacao
	
	If SC1->C1_ITEM == cTotItem
		U_COMWF001(cSuperior) //Envido do Resumo da Solicitacao
	EndIf
	
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF001  บAutor  ณTHIAGO COMELLI      บ Data ณ  06/22/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Envia Workflow de Aprovacao de Solicitacao de Compras      บฑฑ
ฑฑบ          ณ Para quando a aprovacao e feita por SOLICITACAO            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function COMWF001(cAprov)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDeclara็ใo de Variaveisณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local cMvAtt := GetMv("MV_WFHTML")
Local cMailSup := UsrRetMail(cAprov)
Private oHtml

cQuery := " SELECT C1_NUM, C1_EMISSAO, C1_SOLICIT, C1_ITEM, C1_PRODUTO, C1_DESCRI, C1_UM, C1_QUANT, C1_DATPRF, C1_OBS, C1_CC, C1_CODAPRO, C1_USER"
cQuery += " FROM SC1010"
cQuery += " WHERE C1_NUM = '"+SC1->C1_NUM+"'"

MemoWrit("COMWF001.sql",cQuery)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRB", .F., .T.)

TcSetField("TRB","C1_EMISSAO","D")
TcSetField("TRB","C1_DATPRF","D")

COUNT TO nRec
//CASO TENHA DADOS
If nRec > 0
	
	dbSelectArea("TRB")
	dbGoTop()
	
	cNumSc		:= TRB->C1_NUM
	cSolicit	:= TRB->C1_SOLICIT
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณMuda o parametro para enviar no corpo do e-mailณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	PutMv("MV_WFHTML","T")
	
	oProcess:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
	oProcess:NewTask('Inicio',"\WORKFLOW\HTM\COMWF001.htm")
	oHtml   := oProcess:oHtml
	
	oHtml:ValByName("diasA"			, cDiasA)
	oHtml:ValByName("diasE"			, cDiasE)
	oHtml:ValByName("cNUM"			, TRB->C1_NUM)
	oHtml:ValByName("cEMISSAO"		, DTOC(TRB->C1_EMISSAO))
	oHtml:ValByName("cSOLICIT"		, TRB->C1_SOLICIT)
	oHtml:ValByName("cCODUSR"		, TRB->C1_USER)
	oHtml:ValByName("cAPROV"		, "")
	oHtml:ValByName("cMOTIVO"		, "")
	oHtml:ValByName("it.ITEM"		, {})
	oHtml:ValByName("it.PRODUTO"	, {})
	oHtml:ValByName("it.DESCRI"		, {})
	oHtml:ValByName("it.UM"			, {})
	oHtml:ValByName("it.QUANT"		, {})
	oHtml:ValByName("it.DATPRF"		, {})
	oHtml:ValByName("it.OBS"		, {})
	oHtml:ValByName("it.CC"			, {})
	
	dbSelectArea("TRB")
	dbGoTop()
	While !EOF()
		aadd(oHtml:ValByName("it.ITEM")       ,TRB->C1_ITEM			) //Item Cotacao
		aadd(oHtml:ValByName("it.PRODUTO")    ,TRB->C1_PRODUTO		) //Cod Produto
		aadd(oHtml:ValByName("it.DESCRI")     ,TRB->C1_DESCRI		) //Descricao Produto
		aadd(oHtml:ValByName("it.UM")         ,TRB->C1_UM			) //Unidade Medida
		aadd(oHtml:ValByName("it.QUANT")      ,TRANSFORM( TRB->C1_QUANT,'@E 999,999.99' )) //Quantidade Solicitada
		aadd(oHtml:ValByName("it.DATPRF")     ,DTOC(TRB->C1_DATPRF)) //Data da Necessidade
		aadd(oHtml:ValByName("it.OBS")        ,TRB->C1_OBS			) //Observacao
		aadd(oHtml:ValByName("it.CC")         ,TRB->C1_CC			) //Centro de Custo
		dbSkip()
	End
	
	//envia o e-mail
	cUser 				:= Subs(cUsuario,7,15)
	oProcess:ClientName(cUser)
	oProcess:cTo    	:= cMailSup
	oProcess:cBCC     	:= "thiagoc@cis.com.br"
	oProcess:cSubject  	:= "Aprova็ใo de SC - "+cNumSc+" - De: "+cSolicit
	oProcess:cBody    	:= ""
	oProcess:bReturn  	:= "U_COMWF01a()"
	//oProcess:bTimeOut := {{"U_COMWF01b()", 0 , 0, 3 },{"U_COMWF01c()", 0 , 0, 6 }}
	oProcess:bTimeOut := {{"U_COMWF01b()", Val(cDiasA) , 0, 0 },{"U_COMWF01c()", Val(cDiasE) , 0, 0 }}
	oProcess:Start()
	//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004","1001","ENVIO DE WORKFLOW PARA APROVACAO DE SC",cUsername)
	oProcess:Free()
	oProcess:= Nil
	
	PutMv("MV_WFHTML",cMvAtt)
	
	TRB->(dbCloseArea())
	
	WFSendMail({"01","01"})

Else
	TRB->(dbCloseArea())
	MsgStop("Problemas no Envio do E-Mail de Aprova็ใo!","ATENวรO!")
EndIf
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF01a  บAutor  ณTHIAGO COMELLI      บ Data ณ  06/23/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retor Workflow de Aprovacao de Solicitacao de Compras      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COMWF01a(oProcess)

Local cMvAtt := GetMv("MV_WFHTML")
Local cNumSc	:= oProcess:oHtml:RetByName("cNUM")
Local cSolicit	:= oProcess:oHtml:RetByName("cSOLICIT")
Local cEmissao	:= oProcess:oHtml:RetByName("cEMISSAO")
Local cAprov	:= oProcess:oHtml:RetByName("cAPROV")
Local cMotivo	:= oProcess:oHtml:RetByName("cMOTIVO")
Local cCodSol	:= oProcess:oHtml:RetByName("cCODUSR")
Local cMailSol 	:= UsrRetMail(cCodSol)
Private oHtml

ConOut("Aprovando SC: "+cNumSc)

cQuery := " UPDATE SC1010"
cQuery += " SET C1_APROV = '"+cAprov+"'"
cQuery += " WHERE C1_NUM = '"+cNumSc+"'"

MemoWrit("COMWF01a.sql",cQuery)
TcSqlExec(cQuery)
TCREFRESH(RetSqlName("SC1"))


//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1002',"RETOR DE WORKFLOW PARA APROVACAO DE SC",cUsername)

oProcess:Finish()
oProcess:Free()
oProcess:= Nil

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicia Envio de Mensagem de Avisoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PutMv("MV_WFHTML","T")

oProcess:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
If cAprov == "L" //Verifica se foi aprovado
	oProcess:NewTask('Inicio',"\workflow\HTM\COMWF005.htm")
ElseIf cAprov == "R" //Verifica se foi rejeitado
	oProcess:NewTask('Inicio',"\workflow\HTM\COMWF006.htm")
EndIf
oHtml   := oProcess:oHtml

oHtml:valbyname("Num"		, cNumSc)
oHtml:valbyname("Req"    	, cSolicit)
oHtml:valbyname("Emissao"   , cEmissao)
oHtml:valbyname("Motivo"   , cMotivo)
oHtml:valbyname("it.Item"   , {})
oHtml:valbyname("it.Cod"  	, {})
oHtml:valbyname("it.Desc"   , {})

cQuery2 := " SELECT C1_ITEM, C1_PRODUTO, C1_DESCRI"
cQuery2 += " FROM SC1010"
cQuery2 += " WHERE C1_NUM = '"+cNumSc+"'"

MemoWrit("COMWF01a.sql",cQuery2)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery2),"TRB", .F., .T.)

COUNT TO nRec
//CASO TENHA DADOS
If nRec > 0
	
	dbSelectArea("TRB")
	dbGoTop()
	
	While !EOF()
		aadd(oHtml:ValByName("it.Item")		, TRB->C1_ITEM)
		aadd(oHtml:ValByName("it.Cod")		, TRB->C1_PRODUTO)
		aadd(oHtml:ValByName("it.Desc")		, TRB->C1_DESCRI)
		dbSkip()
	End
	
EndIf
TRB->(dbCloseArea())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncoes para Envio do Workflowณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//envia o e-mail
cUser 			  := Subs(cUsuario,7,15)
oProcess:ClientName(cUser)
//oProcess:cTo	  := "thiagoc@cis.com.br"
CONOUT("e-MAIL: "+cMailSol)
CONOUT("USERCOD "+cCodSol)
oProcess:cTo	  := cMailSol
oProcess:cBCC     := "thiagoc@cis.com.br"
If cAprov == "L" //Verifica se foi aprovado
	oProcess:cSubject := "SC Nฐ: "+cNumSc+" - Aprovada"
ElseIf cAprov == "R" //Verifica se foi rejeitado
	oProcess:cSubject := "SC Nฐ: "+cNumSc+" - Reprovada"
EndIf
oProcess:cBody    := ""
oProcess:bReturn  := ""
oProcess:Start()

//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
If cAprov == "L" //Verifica se foi aprovado
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1005',"APROVACAO DE WORKFLOW DE SC",cUsername)
ElseIf cAprov == "R" //Verifica se foi rejeitado
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1006',"REJEICAO DE WORKFLOW DE SC",cUsername)
EndIf

oProcess:Free()
oProcess:Finish()
oProcess:= Nil

PutMv("MV_WFHTML",cMvAtt)

WFSendMail({"01","01"})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF01b  บAutor  ณTHIAGO COMELLI      บ Data ณ  06/23/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Envia um Aviso para Aprovador apos periodo de TIMEOUT      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COMWF01b(oProcess)

Local cMvAtt 	:= GetMv("MV_WFHTML")
Local cNumSc	:= oProcess:oHtml:RetByName("cNUM")
Local cSolicit	:= oProcess:oHtml:RetByName("cSOLICIT")
Local cEmissao	:= oProcess:oHtml:RetByName("cEMISSAO")
Local cDiasA	:= oProcess:oHtml:RetByName("diasA")
Local cDiasE	:= oProcess:oHtml:RetByName("diasE")
Private oHtml

ConOut("AVISO POR TIMEOUT SC:"+cNumSc+" Solicitante:"+cSolicit)

oProcess:Free()
oProcess:= Nil

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicia Envio de Mensagem de Avisoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PutMv("MV_WFHTML","T")

oProcess:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
oProcess:NewTask('Inicio',"\workflow\HTM\COMWF003.htm")
oHtml   := oProcess:oHtml

oHtml:valbyname("Num"		, cNumSc)
oHtml:valbyname("Req"    	, cSolicit)
oHtml:valbyname("Emissao"   , cEmissao)
oHtml:valbyname("diasA"   	, cDiasA)
oHtml:valbyname("diasE"   	, Val(cDiasE)-Val(cDiasA))
oHtml:valbyname("it.Item"   , {})
oHtml:valbyname("it.Cod"  	, {})
oHtml:valbyname("it.Desc"   , {})

cQuery := " SELECT C1_ITEM, C1_PRODUTO, C1_DESCRI, C1_CODAPRO"
cQuery += " FROM SC1010"
cQuery += " WHERE C1_NUM = '"+cNumSc+"'"

MemoWrit("COMWF01b.sql",cQuery)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRB", .F., .T.)

COUNT TO nRec
//CASO TENHA DADOS
If nRec > 0
	
	dbSelectArea("TRB")
	dbGoTop()
	cMailSup := UsrRetMail(TRB->C1_CODAPRO)
	While !EOF()
		aadd(oHtml:ValByName("it.Item")		, TRB->C1_ITEM)
		aadd(oHtml:ValByName("it.Cod")		, TRB->C1_PRODUTO)
		aadd(oHtml:ValByName("it.Desc")		, TRB->C1_DESCRI)
		dbSkip()
	End
	
EndIf
TRB->(dbCloseArea())
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncoes para Envio do Workflowณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//envia o e-mail
cUser 			  := Subs(cUsuario,7,15)
oProcess:ClientName(cUser)
oProcess:cTo	  := cMailSup
oProcess:cBCC     := "thiagoc@cis.com.br"
oProcess:cSubject := "Aviso de TimeOut de SC Nฐ: "+cNumSc+" - De: "+cSolicit
oProcess:cBody    := ""
oProcess:bReturn  := ""
oProcess:Start()
//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1003',"TIMEOUT DE WORKFLOW PARA APROVACAO DE SC",cUsername)
oProcess:Free()
oProcess:Finish()
oProcess:= Nil

PutMv("MV_WFHTML",cMvAtt)

WFSendMail({"01","01"})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF01c  บAutor  ณTHIAGO COMELLI      บ Data ณ  06/23/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Exclui a solicitacao apos um periodo de TIMEOUT            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COMWF01c(oProcess)

Local cMvAtt 	:= GetMv("MV_WFHTML")
Local cNumSc	:= oProcess:oHtml:RetByName("cNUM")
Local cSolicit	:= oProcess:oHtml:RetByName("cSOLICIT")
Local cEmissao	:= oProcess:oHtml:RetByName("cEMISSAO")
Local cDiasA	:= oProcess:oHtml:RetByName("diasA")
Local cDiasE	:= oProcess:oHtml:RetByName("diasE")
Local cCodSol	:= RetCodUsr(cSolicit)
Local cMailSol 	:= UsrRetMail(cCodSol)
Local aCab := {}
Local aItem:= {}
Private oHtml

ConOut("EXCLUSAO POR TIMEOUT SC:"+cNumSc+" Solicitante:"+cSolicit)

cQuery := " SELECT C1_ITEM, C1_PRODUTO, C1_DESCRI, C1_CODAPRO"
cQuery += " FROM SC1010"
cQuery += " WHERE C1_NUM = '"+cNumSc+"'"

MemoWrit("COMWF01b.sql",cQuery)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRB", .F., .T.)

COUNT TO nRec
//CASO TENHA DADOS
If nRec > 0
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณInicia MsExecAuto da Exclusaoณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("TRB")
	dbGoTop()
	cMailSup := UsrRetMail(TRB->C1_CODAPRO)
	While !EOF()
		lMsErroAuto := .F.
		aCab:= {		{"C1_NUM",cNumSc,NIL}}
		Aadd(aItem, {	{"C1_ITEM",TRB->C1_ITEM,NIL}})
		
		Begin Transaction
		MSExecAuto({|x,y,z| mata110(x,y,z)},aCab,aItem,5) //Exclusao
		End Transaction
		
		dbSkip()
	End
	
	
	
	oProcess:Finish()
	oProcess:Free()
	oProcess:= Nil
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณInicia Envio de Mensagem de Avisoณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	PutMv("MV_WFHTML","T")
	
	oProcess:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
	oProcess:NewTask('Inicio',"\workflow\HTM\COMWF004.htm")
	oHtml   := oProcess:oHtml
	
	oHtml:valbyname("Num"		, cNumSc)
	oHtml:valbyname("Req"    	, cSolicit)
	oHtml:valbyname("Emissao"   , cEmissao)
	oHtml:valbyname("diasE"		, cDiasE)
	oHtml:valbyname("it.Item"   , {})
	oHtml:valbyname("it.Cod"  	, {})
	oHtml:valbyname("it.Desc"   , {})
	
	dbSelectArea("TRB")
	dbGoTop()
	
	While !EOF()
		aadd(oHtml:ValByName("it.Item")		, TRB->C1_ITEM)
		aadd(oHtml:ValByName("it.Cod")		, TRB->C1_PRODUTO)
		aadd(oHtml:ValByName("it.Desc")		, TRB->C1_DESCRI)
		dbSkip()
	End
	
EndIf
TRB->(dbCloseArea())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncoes para Envio do Workflowณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//envia o e-mail
cUser 			  := Subs(cUsuario,7,15)
oProcess:ClientName(cUser)
oProcess:cTo	  := cMailSup+";"+cMailSol
oProcess:cBCC     := "thiagoc@cis.com.br"
oProcess:cSubject := "Exclusใo por TimeOut - SC Nฐ: "+cNumSc+" - De: "+cSolicit
oProcess:cBody    := ""
oProcess:bReturn  := ""
oProcess:Start()
//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1004',"TIMEOUT EXCLUSAO DE WORKFLOW PARA APROVACAO DE SC",cUsername)
oProcess:Free()
oProcess:Finish()
oProcess:= Nil

PutMv("MV_WFHTML",cMvAtt)

WFSendMail({"01","01"})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF002  บAutor  ณTHIAGO COMELLI      บ Data ณ  06/22/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Envia Workflow de Aprovacao de Solicitacao de Compras      บฑฑ
ฑฑบ          ณ Para quando a aprovacao e feita por ITEM                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function COMWF002()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDeclara็ใo de Variaveisณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local cMvAtt := GetMv("MV_WFHTML")
Local cAprov := PswRet()[1][11]
Local cMailSup := UsrRetMail(cAprov)
LOCAL aMeses	:= {"Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"}
Private oHtml

cQuery := " SELECT C1_FILIAL, C1_NUM, C1_EMISSAO, C1_SOLICIT, C1_ITEM, C1_PRODUTO, C1_DESCRI, C1_UM, C1_QUANT, C1_DATPRF, C1_OBS, C1_CC, C1_CODAPRO, C1_QUJE, C1_LOCAL, Z2_NOME, B2_QATU, B1_EMIN, B1_QE, B1_UPRC"
cQuery += " FROM SC1"+xFILIAL("SC1")+"0 AS C1"
cQuery += " INNER JOIN SZ2010 AS Z2 ON C1_CC = Z2_COD"
cQuery += " INNER JOIN SB2"+xFILIAL("SB2")+"0 AS B2 ON C1_PRODUTO = B2_COD AND C1_LOCAL = B2_LOCAL"
cQuery += " INNER JOIN SB1"+xFILIAL("SB1")+"0 AS B1 ON C1_PRODUTO = B1_COD"
cQuery += " WHERE C1_NUM = '"+SC1->C1_NUM+"'"
cQuery += " AND C1_ITEM = '"+SC1->C1_ITEM+"'"

MemoWrit("COMWF002.sql",cQuery)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRB", .F., .T.)

TcSetField("TRB","C1_EMISSAO","D")
TcSetField("TRB","C1_DATPRF","D")

COUNT TO nRec
//CASO TENHA DADOS
If nRec > 0
	
	dbSelectArea("TRB")
	TRB->(dbGoTop())
	
	cNumSc		:= TRB->C1_NUM
	cSolicit	:= TRB->C1_SOLICIT
	cItem		:= TRB->C1_ITEM
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณMuda o parametro para enviar no corpo do e-mailณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	PutMv("MV_WFHTML","T")
	
	oProcess:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
	oProcess:NewTask('Inicio',"\WORKFLOW\HTM\COMWF002.htm")
	oHtml   := oProcess:oHtml
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณDados do Cabecalhoณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oHtml:ValByName("diasA"			, cDiasA)
	oHtml:ValByName("diasE"			, cDiasE)
	oHtml:ValByName("Num"		, TRB->C1_NUM				) //Numero da Cotacao
	oHtml:ValByName("Item1"		, TRB->C1_ITEM 				) //Item Cotacao
	oHtml:ValByName("CC"		, TRB->C1_CC				) //Centro de Custo
	oHtml:ValByName("DescCC"	, TRB->Z2_NOME				) //Descricao Centro de Custo
	oHtml:ValByName("Req"	  	, TRB->C1_SOLICIT			) //Nome Requisitante
	oHtml:ValByName("Emissao"	, DTOC(TRB->C1_EMISSAO)		) //Data de Emissao Solicitacao
	//oHtml:ValByName("cAPROV"	, ""						) //Variavel que Retorna "Aprovado / Rejeitado"
	//oHtml:ValByName("cMOTIVO"	, ""						) //Variavel que Retorna o Motivo da Rejeicao
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณSaldos em Estoqueณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oHtml:ValByName("Item"		, TRB->C1_ITEM		   		) //Item Cotacao
	oHtml:ValByName("CodProd"	, TRB->C1_PRODUTO	   		) //Cod Produto
	oHtml:ValByName("Desc"		, TRB->C1_DESCRI			) //Descricao Produto
	oHtml:ValByName("SaldoAtu"	, TRANSFORM(TRB->B2_QATU  		, PesqPict("SB2","B2_QATU" ,12))	) //Saldo Atual Estoque
	oHtml:ValByName("EstMin"	, TRANSFORM(TRB->B1_EMIN		, PesqPict("SB1","B1_EMIN" ,12))	) //Ponto de Pedido
	oHtml:ValByName("QuantSol"	, TRANSFORM(TRB->C1_QUANT - TRB->C1_QUJE , PesqPict("SC1","C1_QUANT",12))) //Saldo da Solicitacao
	oHtml:ValByName("UM"		, TRANSFORM(TRB->C1_UM			, PesqPict("SC1","C1_UM"))			) //Unidade de Medida
	oHtml:ValByName("Local"		, TRANSFORM(TRB->C1_LOCAL		, PesqPict("SC1","C1_LOCAL"))		) //Armazem da Solicitacao
	oHtml:ValByName("QuantEmb"	, TRANSFORM(TRB->B1_QE			, PesqPict("SB1","B1_QE"   ,09))	) //Quantidade Por Embalagem
	oHtml:ValByName("UPRC"		, TRANSFORM(TRB->B1_UPRC		, PesqPict("SB1","B1_UPRC",12))		) //Ultimo Preco de Compra
	oHtml:ValByName("Lead" 		, TRANSFORM(CalcPrazo(TRB->C1_PRODUTO,TRB->C1_QUANT), "999")		) //Lead Time
	oHtml:ValByName("DataNec"	, If(Empty(TRB->C1_DATPRF),TRB->C1_EMISSAO,TRB->C1_DATPRF)			)//Data da Necessidade
	oHtml:ValByName("DataCom"	, SomaPrazo(If(Empty(TRB->C1_DATPRF),TRB->C1_EMISSAO,TRB->C1_DATPRF), -CalcPrazo(TRB->C1_PRODUTO,TRB->C1_QUANT)))// Data para Comprar
	oHtml:ValByName("Obs"		, TRANSFORM(TRB->C1_OBS , "@!")										) //Observacao da Cotacao
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณOrdens de Produ็ใoณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oHtml:ValByName("op1.OP"		, {})//Coloca em Branco para
	oHtml:ValByName("op1.Prod"		, {})//caso nao tenha nenhuma OP
	oHtml:ValByName("op1.Ini"		, {})
	oHtml:ValByName("op1.QtdOp"		, {})
	oHtml:ValByName("op2.OP"		, {})
	oHtml:ValByName("op2.Prod"		, {})
	oHtml:ValByName("op2.Ini"		, {})
	oHtml:ValByName("op2.QtdOp"		, {})
	oHtml:ValByName("op3.OP"		, {})
	oHtml:ValByName("op3.Prod"		, {})
	oHtml:ValByName("op3.Ini"		, {})
	oHtml:ValByName("op3.QtdOp"		, {})
	
	//Query busca as OPs do produto
	cQuery1 := " SELECT D4_OP, D4_DATA, D4_QUANT, C2_PRODUTO"
	cQuery1 += " FROM SD4"+xFILIAL("SD4")+"0 AS D4"
	cQuery1 += " INNER JOIN SC2"+xFILIAL("SC2")+"0 AS C2"
	cQuery1 += " ON SUBSTRING(D4_OP,1,6) = C2_NUM"
	cQuery1 += " AND SUBSTRING(D4_OP,7,2) = C2_ITEM"
	cQuery1 += " AND SUBSTRING(D4_OP,9,3) = C2_SEQUEN"
	cQuery1 += " WHERE D4_COD = '"+TRB->C1_PRODUTO+"'"
	cQuery1 += " AND D4_QUANT > 0"
	cQuery1 += " AND D4.D_E_L_E_T_ <> '*'"
	cQuery1 += " AND C2.D_E_L_E_T_ <> '*'"
	cQuery1 += " ORDER BY D4_DATA"
	
	MemoWrit("COMWF002a.sql",cQuery1)
	dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery1),"TRB1", .F., .T.)
	
	TcSetField("TRB1","D4_DATA","D")
	
	COUNT TO nRec1
	//CASO TENHA DADOS
	If nRec1 > 0
		
		dbSelectArea("TRB1")
		TRB1->(dbGoTop())
		
		While !EOF()
			aadd(oHtml:ValByName("op1.OP")		, TRB1->D4_OP			) //Numero da OP 1
			aadd(oHtml:ValByName("op1.Prod")	, TRB1->C2_PRODUTO		) //Produto a Ser Produzido OP 1
			aadd(oHtml:ValByName("op1.Ini")		, DTOC(TRB1->D4_DATA)	) //Data da OP 1
			aadd(oHtml:ValByName("op1.QtdOp")	, TRANSFORM(TRB1->D4_QUANT , PesqPict("SD4","D4_QUANT",12))	) //Quantidade OP 1
			TRB1->(dbSkip())
			aadd(oHtml:ValByName("op2.OP")		, TRB1->D4_OP			) //Numero da OP 2
			aadd(oHtml:ValByName("op2.Prod")	, TRB1->C2_PRODUTO		) //Produto a Ser Produzido OP 2
			aadd(oHtml:ValByName("op2.Ini")		, DTOC(TRB1->D4_DATA)	) //Data da OP 2
			aadd(oHtml:ValByName("op2.QtdOp")	, TRANSFORM(TRB1->D4_QUANT , PesqPict("SD4","D4_QUANT",12))	) //Quantidade OP 2
			TRB1->(dbSkip())
			aadd(oHtml:ValByName("op3.OP")		, TRB1->D4_OP			) //Numero da OP 3
			aadd(oHtml:ValByName("op3.Prod")	, TRB1->C2_PRODUTO		) //Produto a Ser Produzido OP 3
			aadd(oHtml:ValByName("op3.Ini")		, DTOC(TRB1->D4_DATA)	) //Data da OP 3
			aadd(oHtml:ValByName("op3.QtdOp")	, TRANSFORM(TRB1->D4_QUANT , PesqPict("SD4","D4_QUANT",12))	) //Quantidade OP 3
			TRB1->(dbSkip())
		End
		
	Else
		
		aadd(oHtml:ValByName("op1.OP")		, "")
		aadd(oHtml:ValByName("op1.Prod")	, "")
		aadd(oHtml:ValByName("op1.Ini")		, "")
		aadd(oHtml:ValByName("op1.QtdOp")	, "")
		aadd(oHtml:ValByName("op2.OP")		, "")
		aadd(oHtml:ValByName("op2.Prod")	, "")
		aadd(oHtml:ValByName("op2.Ini")		, "")
		aadd(oHtml:ValByName("op2.QtdOp")	, "")
		aadd(oHtml:ValByName("op3.OP")		, "")
		aadd(oHtml:ValByName("op3.Prod")	, "")
		aadd(oHtml:ValByName("op3.Ini")		, "")
		aadd(oHtml:ValByName("op3.QtdOp")	, "")
	EndIf
	TRB1->(dbCloseArea())
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณConsumo Ultimos 12 Mesesณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//Query busca Consumo do produto
	cQuery2 := " SELECT *"
	cQuery2 += " FROM SB3"+xFILIAL("SB3")+"0"
	cQuery2 += " WHERE B3_COD = '"+TRB->C1_PRODUTO+"'"
	cQuery2 += " AND D_E_L_E_T_ <> '*'"
	
	MemoWrit("COMWF002b.sql",cQuery2)
	dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery2),"TRB2", .F., .T.)
	
	COUNT TO nRec2
	//CASO TENHA DADOS
	If nRec2 > 0
		
		dbSelectArea("TRB2")
		TRB2->(dbGoTop())
		
		cMeses := Space(5)
		nAno := YEAR(dDataBase)
		nMes := MONTH(dDataBase)
		aOrdem := {}
		
		For j := nMes To 1 Step -1 //Preenche Meses Anteriores do Ano Atual
			cMeses += aMeses[j]+"/"+Substr(Str(nAno,4),3,2)
			AADD(aOrdem,j)
		Next j
		
		nAno-- //Volta para Ano Anterior
		
		For j := 12 To nMes+1 Step -1 //Preenche Meses Finais do Ano Anterior
			cMeses += aMeses[j]+"/"+Substr(Str(nAno,4),3,2)
			AADD(aOrdem,j)
		Next j
		
		For j :=1 to 12 //Preenche as variaveis do HTML
			cVarMes := "Mes"+AllTrim(Str(j))
			oHtml:ValByName(cVarMes		, SubStr(cMeses,(j*6),6)) // Meses de Consumo
		Next j
		
		For j := 1 To Len(aOrdem)
			cMes    := StrZero(aOrdem[j],2)
			cCampos := "TRB2->B3_Q"+cMes
			oHtml:ValByName("CMes"+AllTrim(Str(j))	, TRANSFORM(&cCampos , PesqPict("SB3","B3_Q01",9))) //Valor de Consumo nos Meses
		Next j
		
		oHtml:ValByName("MedC"		, TRANSFORM(TRB2->B3_MEDIA, PesqPict("SB3","B3_MEDIA",8))) //Media de Consumo
		
	Else //Caso nao tenha dados
		
		oHtml:ValByName("MedC"		, "")
		For m := 1 To 12
			oHtml:ValByName("CMes"+AllTrim(Str(m))	, "")
			oHtml:ValByName("Mes"+AllTrim(Str(m))	, "")
		Next m
	EndIf
	TRB2->(dbCloseArea())
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณUltimos Pedidos de Compra ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oHtml:ValByName("it.NumP"			, {})
	oHtml:ValByName("it.ItemP"			, {})
	oHtml:ValByName("it.CodP"			, {})
	oHtml:ValByName("it.LjP"			, {})
	oHtml:ValByName("it.NomeP"			, {})
	oHtml:ValByName("it.QtdeP"			, {})
	oHtml:ValByName("it.UMP"			, {})
	oHtml:ValByName("it.VlrUnP"			, {})
	oHtml:ValByName("it.VlrTotP"		, {})
	oHtml:ValByName("it.EmiP"			, {})
	oHtml:ValByName("it.NecP"			, {})
	oHtml:ValByName("it.PraP"			, {})
	oHtml:ValByName("it.CondP"			, {})
	oHtml:ValByName("it.QtdeEntP"		, {})
	oHtml:ValByName("it.SalP"			, {})
	oHtml:ValByName("it.EliP"			, {})
	
	//Query busca Pedidos do Produto
	cQuery3 := " SELECT C7_NUM, C7_ITEM, C7_FORNECE, C7_LOJA, A2_NOME, C7_QUANT, C7_UM, C7_PRECO, C7_TOTAL, C7_EMISSAO, C7_DATPRF, C7_COND, C7_QUJE, C7_RESIDUO"
	cQuery3 += " FROM SC7"+xFILIAL("SC7")+"0 AS C7"
	cQuery3 += " INNER JOIN SA2010 AS A2 ON A2_COD = C7_FORNECE AND A2_LOJA = C7_LOJA"
	cQuery3 += " WHERE C7_FILIAL = '"+TRB->C1_FILIAL+"' AND C7_PRODUTO = '"+TRB->C1_PRODUTO+"'"
	cQuery3 += " AND C7.D_E_L_E_T_ <> '*'"
	cQuery3 += " AND A2.D_E_L_E_T_ <> '*'"
	cQuery3 += " ORDER BY C7_EMISSAO DESC"
	
	MemoWrit("COMWF002c.sql",cQuery3)
	dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery3),"TRB3", .F., .T.)
	
	TcSetField("TRB3","C7_EMISSAO","D")
	TcSetField("TRB3","C7_DATPRF","D")
	
	COUNT TO nRec3
	//CASO TENHA DADOS
	If nRec3 > 0
		
		dbSelectArea("TRB3")
		TRB3->(dbGoTop())
		
		nContador := 0
		
		While !TRB3->(EOF())
			
			nContador++
			If nContador > 03 //Numero de Pedidos
				Exit
			EndIf
			
			aadd(oHtml:ValByName("it.NumP")			, TRB3->C7_NUM		)
			aadd(oHtml:ValByName("it.ItemP")		, TRB3->C7_ITEM		)
			aadd(oHtml:ValByName("it.CodP")			, TRB3->C7_FORNECE	)
			aadd(oHtml:ValByName("it.LjP")			, TRB3->C7_LOJA		)
			aadd(oHtml:ValByName("it.NomeP")		, TRB3->A2_NOME		)
			aadd(oHtml:ValByName("it.QtdeP")		, TRANSFORM(TRB3->C7_QUANT , PesqPict("SC7","C7_QUANT",14))	)
			aadd(oHtml:ValByName("it.UMP")			, TRB3->C7_UM		)
			aadd(oHtml:ValByName("it.VlrUnP")		, TRANSFORM(TRB3->C7_PRECO, PesqPict("SC7","c7_preco",14))	)
			aadd(oHtml:ValByName("it.VlrTotP")		, TRANSFORM(TRB3->C7_TOTAL, PesqPict("SC7","c7_total",14))	)
			aadd(oHtml:ValByName("it.EmiP")			, DTOC(TRB3->C7_EMISSAO))
			aadd(oHtml:ValByName("it.NecP")			, DTOC(TRB3->C7_DATPRF)	)
			aadd(oHtml:ValByName("it.PraP")			, TRANSFORM(Val(DTOC(TRB3->C7_DATPRF))-Val(DTOC(TRB3->C7_EMISSAO)), "999"))
			aadd(oHtml:ValByName("it.CondP")		, TRB3->C7_COND		)
			aadd(oHtml:ValByName("it.QtdeEntP")		, TRANSFORM(TRB3->C7_QUJE, PesqPict("SC7","C7_QUJE",14))		)
			aadd(oHtml:ValByName("it.SalP")			, TRANSFORM(If(Empty(TRB3->C7_RESIDUO),TRB3->C7_QUANT-TRB3->C7_QUJE,0), PesqPict("SC7","C7_QUJE",14)))
			aadd(oHtml:ValByName("it.EliP")			, If(Empty(TRB3->C7_RESIDUO),'Nใo','Sim'))
			
			TRB3->(dbSkip())
		End
		
	Else //Caso nao tenha dados
		
		aadd(oHtml:ValByName("it.NumP")			, "")
		aadd(oHtml:ValByName("it.ItemP")		, "")
		aadd(oHtml:ValByName("it.CodP")			, "")
		aadd(oHtml:ValByName("it.LjP")			, "")
		aadd(oHtml:ValByName("it.NomeP")		, "")
		aadd(oHtml:ValByName("it.QtdeP")		, "")
		aadd(oHtml:ValByName("it.UMP")			, "")
		aadd(oHtml:ValByName("it.VlrUnP")		, "")
		aadd(oHtml:ValByName("it.VlrTotP")		, "")
		aadd(oHtml:ValByName("it.EmiP")			, "")
		aadd(oHtml:ValByName("it.NecP")			, "")
		aadd(oHtml:ValByName("it.PraP")			, "")
		aadd(oHtml:ValByName("it.CondP")		, "")
		aadd(oHtml:ValByName("it.QtdeEntP")		, "")
		aadd(oHtml:ValByName("it.SalP")			, "")
		aadd(oHtml:ValByName("it.EliP")			, "")
		
	EndIf
	TRB3->(dbCloseArea())
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณUltimos Fornecedoresณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	oHtml:ValByName("it1.CodF"			, {})
	oHtml:ValByName("it1.LjF"			, {})
	oHtml:ValByName("it1.NomeF"			, {})
	oHtml:ValByName("it1.TelF"			, {})
	oHtml:ValByName("it1.ContF"			, {})
	oHtml:ValByName("it1.FaxF"			, {})
	oHtml:ValByName("it1.UlComF"		, {})
	oHtml:ValByName("it1.MunicF"		, {})
	oHtml:ValByName("it1.UFF"			, {})
	oHtml:ValByName("it1.RisF"			, {})
	oHtml:ValByName("it1.CodForF"		, {})
	
	If mv_par03 == 1 // Amarracao por Produto
		
		//Query busca Fornecedores do Produto
		cQuery4 := " SELECT A5_FORNECE, A5_LOJA, A2_NOME, A2_TEL, A2_CONTATO, A2_FAX, A2_ULTCOM, A2_MUN, A2_EST, A2_RISCO, A5_CODPRF"
		cQuery4 += " FROM SA5010 AS A5"
		cQuery4 += " INNER JOIN SA2010 A2 ON A5_FORNECE = A2_COD AND A5_LOJA = A2_LOJA"
		cQuery4 += " WHERE A5_PRODUTO = '"+TRB->C1_PRODUTO+"'"
		cQuery4 += " AND A5.D_E_L_E_T_ <> '*'"
		cQuery4 += " AND A2.D_E_L_E_T_ <> '*'"
		cQuery4 += " order by  A2_ULTCOM DESC"
		
		MemoWrit("COMWF002d.sql",cQuery4)
		dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery4),"TRB4", .F., .T.)
		
		TcSetField("TRB4","A2_ULTCOM","D")
		
		COUNT TO nRec4
		//CASO TENHA DADOS
		If nRec4 > 0
			
			dbSelectArea("TRB4")
			TRB4->(dbGoTop())
			
			nContador := 0
			
			While !TRB4->(EOF())
				
				nContador++
				If nContador > 03 //Numero de Fornecedores
					Exit
				EndIf
				
				aadd(oHtml:ValByName("it1.CodF")		, TRB4->A5_FORNECE	) //Codigo do Fornecedor
				aadd(oHtml:ValByName("it1.LjF")			, TRB4->A5_LOJA		) //Codigo da Loja
				aadd(oHtml:ValByName("it1.NomeF")		, TRB4->A2_NOME		) //Nome do Fornecedor
				aadd(oHtml:ValByName("it1.TelF")		, TRB4->A2_TEL		) //Telefone do Fornecedor
				aadd(oHtml:ValByName("it1.ContF")		, TRB4->A2_CONTATO	) //Contato no Fornecedor
				aadd(oHtml:ValByName("it1.FaxF")		, TRB4->A2_FAX		) //Fax no Fornecedor
				aadd(oHtml:ValByName("it1.UlComF")		, DTOC(TRB4->A2_ULTCOM)	) //Ultima Compra com o Fornecedor
				aadd(oHtml:ValByName("it1.MunicF")		, TRB4->A2_MUN		) //Municipio do Fornecedor
				aadd(oHtml:ValByName("it1.UFF")			, TRB4->A2_EST		) //Estado do Fornecedor
				aadd(oHtml:ValByName("it1.RisF")		, TRB4->A2_RISCO	) //Risco do Fornecedor
				aadd(oHtml:ValByName("it1.CodForF")		, TRB4->A5_CODPRF	) //Codigo no Forncedor
				
				TRB4->(dbSkip())
			End
			
		Else //Caso nao tenha dados
			
			aadd(oHtml:ValByName("it1.CodF")		, ""	) //Codigo do Fornecedor
			aadd(oHtml:ValByName("it1.LjF")			, ""	) //Codigo da Loja
			aadd(oHtml:ValByName("it1.NomeF")		, ""	) //Nome do Fornecedor
			aadd(oHtml:ValByName("it1.TelF")		, ""	) //Telefone do Fornecedor
			aadd(oHtml:ValByName("it1.ContF")		, ""	) //Contato no Fornecedor
			aadd(oHtml:ValByName("it1.FaxF")		, ""	) //Fax no Fornecedor
			aadd(oHtml:ValByName("it1.UlComF")		, ""	) //Ultima Compra com o Fornecedor
			aadd(oHtml:ValByName("it1.MunicF")		, ""	) //Municipio do Fornecedor
			aadd(oHtml:ValByName("it1.UFF")			, ""	) //Estado do Fornecedor
			aadd(oHtml:ValByName("it1.RisF")		, ""	) //Risco do Fornecedor
			aadd(oHtml:ValByName("it1.CodForF")		, ""	) //Codigo no Forncedor
			
		EndIf
		TRB4->(dbCloseArea())
		
	Else
		
		//Query busca Fornecedores do Grupo de Produtos
		cQuery4 := " SELECT AD_FORNECE, AD_LOJA, A2_NOME, A2_TEL, A2_CONTATO, A2_FAX, A2_ULTCOM, A2_MUN, A2_EST, A2_RISCO"
		cQuery4 += " FROM SB1"+xFILIAL("SB1")+"0 AS B1"
		cQuery4 += " INNER JOIN SAD010 AS AD ON B1_GRUPO = AD_GRUPO"
		cQuery4 += " INNER JOIN SA2010 AS A2 ON AD_FORNECE = A2_COD AND AD_LOJA = A2_LOJA"
		cQuery4 += " WHERE B1_COD = '"+TRB->C1_PRODUTO+"'"
		cQuery4 += " AND AD.D_E_L_E_T_ <> '*'"
		cQuery4 += " AND A2.D_E_L_E_T_ <> '*'"
		cQuery4 += " AND B1.D_E_L_E_T_ <> '*'"
		cQuery4 += " ORDER BY  A2_ULTCOM DESC"
		
		MemoWrit("COMWF002d.sql",cQuery4)
		dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery4),"TRB4", .F., .T.)
		
		TcSetField("TRB4","A2_ULTCOM","D")
		
		COUNT TO nRec4
		//CASO TENHA DADOS
		If nRec4 > 0
			
			dbSelectArea("TRB4")
			TRB4->(dbGoTop())
			
			nContador := 0
			
			While !TRB4->(EOF())
				
				nContador++
				If nContador > 03 //Numero de Fornecedores
					Exit
				EndIf
				
				aadd(oHtml:ValByName("it1.CodF")		, TRB4->AD_FORNECE	) //Codigo do Fornecedor
				aadd(oHtml:ValByName("it1.LjF")			, TRB4->AD_LOJA		) //Codigo da Loja
				aadd(oHtml:ValByName("it1.NomeF")		, TRB4->A2_NOME		) //Nome do Fornecedor
				aadd(oHtml:ValByName("it1.TelF")		, TRB4->A2_TEL		) //Telefone do Fornecedor
				aadd(oHtml:ValByName("it1.ContF")		, TRB4->A2_CONTATO	) //Contato no Fornecedor
				aadd(oHtml:ValByName("it1.FaxF")		, TRB4->A2_FAX		) //Fax no Fornecedor
				aadd(oHtml:ValByName("it1.UlComF")		, DTOC(TRB4->A2_ULTCOM)	) //Ultima Compra com o Fornecedor
				aadd(oHtml:ValByName("it1.MunicF")		, TRB4->A2_MUN		) //Municipio do Fornecedor
				aadd(oHtml:ValByName("it1.UFF")			, TRB4->A2_EST		) //Estado do Fornecedor
				aadd(oHtml:ValByName("it1.RisF")		, TRB4->A2_RISCO	) //Risco do Fornecedor
				aadd(oHtml:ValByName("it1.CodForF")		, ""				) //Codigo no Forncedor
				TRB4->(dbSkip())
			End
			
		Else //Caso nao tenha dados
			
			aadd(oHtml:ValByName("it1.CodF")		, ""	) //Codigo do Fornecedor
			aadd(oHtml:ValByName("it1.LjF")			, ""	) //Codigo da Loja
			aadd(oHtml:ValByName("it1.NomeF")		, ""	) //Nome do Fornecedor
			aadd(oHtml:ValByName("it1.TelF")		, ""	) //Telefone do Fornecedor
			aadd(oHtml:ValByName("it1.ContF")		, ""	) //Contato no Fornecedor
			aadd(oHtml:ValByName("it1.FaxF")		, ""	) //Fax no Fornecedor
			aadd(oHtml:ValByName("it1.UlComF")		, ""	) //Ultima Compra com o Fornecedor
			aadd(oHtml:ValByName("it1.MunicF")		, ""	) //Municipio do Fornecedor
			aadd(oHtml:ValByName("it1.UFF")			, ""	) //Estado do Fornecedor
			aadd(oHtml:ValByName("it1.RisF")		, ""	) //Risco do Fornecedor
			aadd(oHtml:ValByName("it1.CodForF")		, ""	) //Codigo no Forncedor
			
		EndIf
		TRB4->(dbCloseArea())
		
	EndIf
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณFuncoes para Envio do Workflowณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//envia o e-mail
	cUser 			  := Subs(cUsuario,7,15)
	oProcess:ClientName(cUser)
	oProcess:cTo	  := cMailSup
	oProcess:cBCC     := "thiagoc@cis.com.br"
	oProcess:cSubject := "Aprova็ใo de SC Nฐ: "+cNumSc+" Item: "+cItem+" - De: "+cSolicit
	oProcess:cBody    := ""
	oProcess:bReturn  := "U_COMWF02a()"
	//oProcess:bTimeOut := {{"U_COMWF02b()", Val(cDiasA) , 0, 0 },{"U_COMWF02c()", Val(cDiasE) , 0, 0 }}
	//oProcess:bTimeOut := {{"U_COMWF02b()",0, 0, 05 },{"U_COMWF02c()",0, 0, 10 }}
	oProcess:Start()
	//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004","1001","ENVIO DE WORKFLOW PARA APROVACAO DE SC",cUsername)
	oProcess:Free()
	oProcess:= Nil
	
	PutMv("MV_WFHTML",cMvAtt)
	
Else
	MsgStop("Foi encontrado um problema na Gera็ใo do E-Mail de Aprova็ใo. Favor avisar o Depto de Informแtica. NREC =","ATENวรO!")
EndIf

TRB->(dbCloseArea())

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF02a  บAutor  ณTHIAGO COMELLI      บ Data ณ  06/23/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retor Workflow de Aprovacao de Solicitacao de Compras      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COMWF02a(oProcess)

Local cMvAtt := GetMv("MV_WFHTML")
Local cNumSc	:= oProcess:oHtml:RetByName("Num")
Local cItemSc	:= oProcess:oHtml:RetByName("Item")
Local cSolicit	:= oProcess:oHtml:RetByName("Req")
Local cEmissao	:= oProcess:oHtml:RetByName("Emissao")
Local cDiasA	:= oProcess:oHtml:RetByName("diasA")
Local cDiasE	:= oProcess:oHtml:RetByName("diasE")
Local cCod		:= oProcess:oHtml:RetByName("CodProd")
Local cDesc		:= oProcess:oHtml:RetByName("Desc")
Local cAprov	:= oProcess:oHtml:RetByName("cAPROV")
Local cMotivo	:= oProcess:oHtml:RetByName("cMOTIVO")

Private oHtml

ConOut("Atualizando SC:"+cNumSc+" Item:"+cItemSc)

cQuery := " UPDATE SC1010"
cQuery += " SET C1_APROV = '"+cAprov+"'"
cQuery += " WHERE C1_NUM = '"+cNumSc+"'"
cQuery += " AND C1_ITEM = '"+cItemSc+"'"

MemoWrit("COMWF02a.sql",cQuery)
TcSqlExec(cQuery)
TCREFRESH(RetSqlName("SC1"))

//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1002',"RETOR DE WORKFLOW PARA APROVACAO DE SC",cUsername)

oProcess:Finish()
oProcess:Free()
oProcess:= Nil

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicia Envio de Mensagem de Avisoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PutMv("MV_WFHTML","T")

oProcess:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
If cAprov == "L" //Verifica se foi aprovado
	oProcess:NewTask('Inicio',"\workflow\HTM\COMWF005.htm")
ElseIf cAprov == "R" //Verifica se foi rejeitado
	oProcess:NewTask('Inicio',"\workflow\HTM\COMWF006.htm")
EndIf
oHtml   := oProcess:oHtml

oHtml:valbyname("Num"		, cNumSc)
oHtml:valbyname("Req"    	, cSolicit)
oHtml:valbyname("Emissao"   , cEmissao)
oHtml:valbyname("Motivo"   , cMotivo)
oHtml:valbyname("it.Item"   , {})
oHtml:valbyname("it.Cod"  	, {})
oHtml:valbyname("it.Desc"   , {})
aadd(oHtml:ValByName("it.Item")		, cItemSc)
aadd(oHtml:ValByName("it.Cod")		, cCod)
aadd(oHtml:ValByName("it.Desc")		, cDesc)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncoes para Envio do Workflowณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//envia o e-mail
cUser 			  := Subs(cUsuario,7,15)
oProcess:ClientName(cUser)
oProcess:cTo	  := cMailSup
oProcess:cBCC     := "thiagoc@cis.com.br"

If cAprov == "L" //Verifica se foi aprovado
	oProcess:cSubject := "SC Nฐ: "+cNumSc+" - Item: "+cItemSc+" - Aprovada"
ElseIf cAprov == "R" //Verifica se foi rejeitado
	oProcess:cSubject := "SC Nฐ: "+cNumSc+" - Item: "+cItemSc+" - Reprovada"
EndIf

oProcess:cBody    := ""
oProcess:bReturn  := ""
oProcess:Start()

//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
If cAprov == "L" //Verifica se foi aprovado
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1005',"TIMEOUT DE WORKFLOW PARA APROVACAO DE SC",cUsername)
ElseIf cAprov == "R" //Verifica se foi rejeitado
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1006',"TIMEOUT DE WORKFLOW PARA APROVACAO DE SC",cUsername)
EndIf

oProcess:Free()
oProcess:Finish()
oProcess:= Nil

PutMv("MV_WFHTML",cMvAtt)

WFSendMail({"01","01"})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF02b  บAutor  ณTHIAGO COMELLI      บ Data ณ  06/23/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Envia um Aviso para Aprovador apos periodo de TIMEOUT      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COMWF02b(oProcess)

Local cMvAtt 	:= GetMv("MV_WFHTML")
Local cNumSc	:= oProcess:oHtml:RetByName("Num")
Local cItemSc	:= oProcess:oHtml:RetByName("Item")
Local cSolicit	:= oProcess:oHtml:RetByName("Req")
Local cEmissao	:= oProcess:oHtml:RetByName("Emissao")
Local cDiasA	:= oProcess:oHtml:RetByName("diasA")
Local cDiasE	:= oProcess:oHtml:RetByName("diasE")
Local cCod		:= oProcess:oHtml:RetByName("CodProd")
Local cDesc		:= oProcess:oHtml:RetByName("Desc")
Private oHtml

ConOut("AVISO POR TIMEOUT SC:"+cNumSc+" Item:"+cItemSc+" Solicitante:"+cSolicit)

oProcess:Free()
oProcess:= Nil

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicia Envio de Mensagem de Avisoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PutMv("MV_WFHTML","T")

oProcess:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
oProcess:NewTask('Inicio',"\workflow\HTM\COMWF003.htm")
oHtml   := oProcess:oHtml

oHtml:valbyname("Num"		, cNumSc)
oHtml:valbyname("Req"    	, cSolicit)
oHtml:valbyname("Emissao"   , cEmissao)
oHtml:valbyname("diasA"   	, cDiasA)
oHtml:valbyname("diasE"   	, Val(cDiasE)-Val(cDiasA))
oHtml:valbyname("it.Item"   , {})
oHtml:valbyname("it.Cod"  	, {})
oHtml:valbyname("it.Desc"   , {})
aadd(oHtml:ValByName("it.Item")		, cItemSc)
aadd(oHtml:ValByName("it.Cod")		, cCod)
aadd(oHtml:ValByName("it.Desc")		, cDesc)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncoes para Envio do Workflowณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//envia o e-mail
cUser 			  := Subs(cUsuario,7,15)
oProcess:ClientName(cUser)
oProcess:cTo	  := cMailSup
oProcess:cBCC     := "thiagoc@cis.com.br"
oProcess:cSubject := "Aviso de TimeOut de SC Nฐ: "+cNumSc+" Item: "+cItemSc+" - De: "+cSolicit
oProcess:cBody    := ""
oProcess:bReturn  := ""
oProcess:Start()
//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1003',"TIMEOUT DE WORKFLOW PARA APROVACAO DE SC",cUsername)
oProcess:Free()
oProcess:Finish()
oProcess:= Nil

PutMv("MV_WFHTML",cMvAtt)

WFSendMail({"01","01"})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF02c  บAutor  ณTHIAGO COMELLI      บ Data ณ  06/23/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Exclui a solicitacao apos um periodo de TIMEOUT            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COMWF02c(oProcess)
Local cMvAtt 	:= GetMv("MV_WFHTML")
Local cNumSc	:= oProcess:oHtml:RetByName("Num")
Local cItemSc	:= oProcess:oHtml:RetByName("Item")
Local cSolicit	:= oProcess:oHtml:RetByName("Req")
Local cEmissao	:= oProcess:oHtml:RetByName("Emissao")
Local cDiasE	:= oProcess:oHtml:RetByName("diasE")
Local cCod		:= oProcess:oHtml:RetByName("CodProd")
Local cDesc		:= oProcess:oHtml:RetByName("Desc")
Local cCodSol	:= RetCodUsr(cSolicit)
Local cMailSol 	:= UsrRetMail(cCodSol)
Private oHtml

ConOut("EXCLUSAO POR TIMEOUT SC:"+cNumSc+" Item:"+cItemSc+" Solicitante:"+cSolicit)

cQuery := " UPDATE SC1010"
cQuery += " SET D_E_L_E_T_ = '*'"
cQuery += " WHERE C1_NUM = '"+cNumSc+"'"
cQuery += " AND C1_ITEM = '"+cItemSc+"'"

MemoWrit("COMWF02c.sql",cQuery)
TcSqlExec(cQuery)
TCREFRESH(RetSqlName("SC1"))

oProcess:Finish()
oProcess:Free()
oProcess:= Nil

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicia Envio de Mensagem de Avisoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PutMv("MV_WFHTML","T")

oProcess:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
oProcess:NewTask('Inicio',"\workflow\HTM\COMWF004.htm")
oHtml   := oProcess:oHtml

oHtml:valbyname("Num"		, cNumSc)
oHtml:valbyname("Req"    	, cSolicit)
oHtml:valbyname("Emissao"   , cEmissao)
oHtml:valbyname("diasE"		, cDiasE)
oHtml:valbyname("it.Item"   , {})
oHtml:valbyname("it.Cod"  	, {})
oHtml:valbyname("it.Desc"   , {})
aadd(oHtml:ValByName("it.Item")		, cItemSc)
aadd(oHtml:ValByName("it.Cod")		, cCod)
aadd(oHtml:ValByName("it.Desc")		, cDesc)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncoes para Envio do Workflowณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//envia o e-mail
cUser 			  := Subs(cUsuario,7,15)
oProcess:ClientName(cUser)
oProcess:cTo	  := cMailSup+";"+cMailSol
oProcess:cBCC     := "thiagoc@cis.com.br"
oProcess:cSubject := "Exclusใo por TimeOut - SC Nฐ: "+cNumSc+" Item: "+cItemSc+" - De: "+cSolicit
oProcess:cBody    := ""
oProcess:bReturn  := ""
oProcess:Start()
//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1004',"TIMEOUT EXCLUSAO DE WORKFLOW PARA APROVACAO DE SC",cUsername)
oProcess:Free()
oProcess:Finish()
oProcess:= Nil

PutMv("MV_WFHTML",cMvAtt)

WFSendMail({"01","01"})

Return
