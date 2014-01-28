#Include "Font.Ch"
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Descr.  | Tela para controle da rotina de Schedulagem via Job.
|------------------------------------------------------------------------------
| Alteracao                                          | Autor      | Data
|----------------------------------------------------|------------|------------
| 1.Alterado de AxCadastro para mBrowse para         | Flavio SG  | 25/04/01
|   possibilitar incluir controles e cor de Status.  |            |
| 2.Criado controle para Abilitar e Desabilitar uma  | Flavio SG  | 25/04/01
|   tarefa.                                          |            |
| 3.Criado controle para executar uma tarefa         | Flavio SG  | 25/04/01
|   manualmente.                                     |            |
| 4.Criado controle para abortar uma tarefa          | Flavio SG  | 25/04/01
|   em execução.                                     |            |
| 5.Criada uma mBrowse para consulta de historico    | Flavio SG  | 25/04/01
|   das execuções da tarefa posicionada.             |            |
| 6.Criada uma mBrowse para consulta do historico    | Flavio SG  | 11/05/01
|   dos erros ocorridos na execução posicionada da   |            |
|   tarefa.                                          |            |
| 7.Implementado um timer para atualização do browse | Flavio SG  | 01/06/01
|   automaticamente.                                 |            |
| 8.Controle de aborto de procedures que permite     | Flavio SG  | 21/12/01
|   efetuar o aborto apenas após uma hora da exe-    |            |
|   cução.                                           |            |
| 9.Adapatado para uso na Editora Pini Ltda          | Marcos     | 09/10/02
|                                                    | Farineli   |           
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
| Projeto | Editora Pini
|---------|--------------------------------------------------------------------
| Funcao  | RCFGA01  | Autor | Flavio S. Guimaraes     | Data | 10/01/2001
|---------|--------------------------------------------------------------------
| Descr.  | Mbrowse com todas as tarefas agendadas e funções para edição e
|         | controle das tarefas.
|---------|--------------------------------------------------------------------
| Param.  | NIL
|---------|--------------------------------------------------------------------
| Retorna | NIL
-------------------------------------------------------------------------------
*/
User Function RCFGA01()

LOCAL aCores
LOCAL nFreeze := 0
LOCAL bBrowse := { | oDlgMBrowse | U_TimerCreate( oDlgMBrowse, ZZO->(IndexKey()) ) }

//Variavel contendo o Job Ativo e Modelo Automático ou Manual para uso de todas
//as rotinas do agendamento inclusive as agendadas.
Private cJob, lAuto
cJob  := "X"
lAuto := .F.

//Variaveis a serem utilizadas pela rotina mBrowse.
Private cCadastro, aRotina

// Alimenta variavel cUsuario que vem vazia quando chamado pelo JOB
cCadastro := "Agendamento de execução de tarefas."
aCores	 := {{"ZZO->ZZO_STATUS 	== 'A'"	,"BR_AZUL" },;      // Ativo
{"ZZO->ZZO_STATUS	== 'E'"	,"BR_VERDE"},;      // Executando
{"ZZO->ZZO_STATUS	== 'X'"	,"BR_VERMELHO"},;   // Parando Execução
{"ZZO->ZZO_STATUS	== 'D'"	,"BR_CINZA"}}       // Desativado


//************************************************************************
//  Define Array contendo as Rotinas a executar do programa
//  ----------- Elementos contidos por dimensao ------------
//  1. Nome a aparecer no cabecalho
//  2. Nome da Rotina associada
//  3. Usado pela rotina
//  4. Tipo de Transação a ser efetuada
//     1 - Pesquisa e Posiciona em um Banco de Dados
//     2 - Simplesmente Mostra os Campos
//     3 - Inclui registros no Bancos de Dados
//     4 - Altera o registro corrente
//     5 - Remove o registro corrente do Banco de Dados
//     6 - Alteracao sem inclusao de registro
//************************************************************************
Private aRotina := {{"Pesquisar"  ,"axPesqui"   ,0,1} ,;
					{"Visualizar" ,"axVisual"   ,0,2} ,;
					{"Incluir"	  ,"axInclui"   ,0,3} ,;
					{"Alterar"	  ,"U_CFGAltera",0,4} ,;
					{"Excluir"	  ,"U_CFGDeleta",0,5} ,;
					{"Historico"  ,"U_CFGA01HS" ,0,4} ,;
					{"Ativ/Desat" ,"U_CFGA01ST" ,0,4} ,;
					{"Executar"	  ,"U_CFGA01EX" ,0,4} ,;
					{"Abortar"	  ,"U_CFGA01AB" ,0,4} ,;
					{"Legenda"	  ,"U_CFGA01LE" ,0,3}}

mBrowse( 6,1,22,75,"ZZO", , , , , ,aCores, , , nFreeze, bBrowse)

Return(NIL)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | TimerCreate   | Autor | Flavio S. Guimaraes       | Data | 11/05/2001
|---------|--------------------------------------------------------------------
| Descr.  | Inicia o Timer para atualizar o browse automaticamente.
|---------|--------------------------------------------------------------------
| Param.  | oDlgMBrowse = Objeto do browse para atualizar.
|         | nSeconds		= Tempo (em segundos) entre as atualizações.
|         | cSeekKey		= Chave do indice para passar ao SetFilter do Browse.
|---------|--------------------------------------------------------------------
| Retorna | .T.
-------------------------------------------------------------------------------
*/
User Function TimerCreate( oDlgMBrowse, cSeekKey )
LOCAL nTempo
LOCAL oBrowse := GetObjBrow()

//Carrega o parametro de tempo para atualização do browse no monitor.
dbSelectArea("SX6")
dbSetOrder(1)
If !dbSeek(xFilial("SX6")+"MV_SCHBROW")
	RecLock("SX6",.T.)
	SX6->X6_FIL     := xFilial("SX6")
	SX6->X6_VAR     := "MV_SCHBROW"
	SX6->X6_TIPO    := "N"
	SX6->X6_DESCRIC := "Indica o intervalo de tempo para atualização do"
	SX6->X6_DESC1	 := "browse de monitoramento. (em milésimos de"
	SX6->X6_DESC2 	 := "segundo)"
	SX6->X6_CONTEUD := "50000"
	MsUnlock()
EndIf
nTempo := GetMV("MV_SCHBROW")

// refresh no browse a cada nSeconds * 1000 milisegundos ( tempo minimo do timer eh de 5000 )
oTimer := TTimer( ):New( nTempo, {|| oBrowse:SetFilter( cSeekKey, NIL, NIL ), oBrowse:Reset() }, oDlgMBrowse)
oTimer:lActive := .T.

Return(NIL)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | CFGAltera   | Autor | Flavio S. Guimaraes       | Data | 11/05/2001
|---------|--------------------------------------------------------------------
| Descr.  | Chama axAltera apenas quando a tarefa nao estiver em execução.
|---------|--------------------------------------------------------------------
| Param.  | NIL
|---------|--------------------------------------------------------------------
| Retorna | .T.
-------------------------------------------------------------------------------
*/
USER FUNCTION CFGAltera()

If ZZO->ZZO_STATUS $ 'A_D'
	axAltera("ZZO",ZZO->(RecNo()),4)
Else
	MsgStop("Nao e possivel alterar uma tarefa em execução !")
EndIF

RETURN(.T.)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | CFGDeleta   | Autor | Flavio S. Guimaraes       | Data | 11/05/2001
|---------|--------------------------------------------------------------------
| Descr.  | Chama axDeleta apenas quando a tarefa nao estiver em execução.
|---------|--------------------------------------------------------------------
| Param.  | NIL
|---------|--------------------------------------------------------------------
| Retorna | .T.
-------------------------------------------------------------------------------
*/
USER FUNCTION CFGDeleta()
If ZZO->ZZO_STATUS $ 'A_D'
	axDeleta("ZZO",ZZO->(RecNo()),5)
Else
	MsgStop("Nao e possivel excluir uma tarefa em execução !")
EndIF
RETURN(.T.)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | CFGA01LE   | Autor | Flavio S. Guimaraes       | Data | 25/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Legenda das cores de Status.
|---------|--------------------------------------------------------------------
| Param.  | NIL
|---------|--------------------------------------------------------------------
| Retorna | .T.
-------------------------------------------------------------------------------
*/
USER FUNCTION CFGA01LE()

BrwLegenda( cCadastro, "Legenda", {	{ "BR_AZUL"     , "Ativo"}, ;
									{ "BR_VERDE"    , "Executando" },;
									{ "BR_VERMELHO" , "Parando Execução" },;
									{ "BR_CINZA"    , "Desativado" }})

RETURN(.T.)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | CFGA01EX   | Autor | Flavio S. Guimaraes       | Data | 25/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Executa manualmente a tarefa posicionada no ZZO.
|---------|--------------------------------------------------------------------
| Param.  | NIL
|---------|--------------------------------------------------------------------
| Retorna | .T.
-------------------------------------------------------------------------------
*/
USER FUNCTION CFGA01EX()
LOCAL lExec := .F.
LOCAL lOff  := .F.

//Destrava todos os locks para todas as areas abertas (POR PRECAUÇÃO).
nArea := 1
While !Empty(Alias(nArea))
	dbSelectArea(Alias(nArea))
	MsUnlockAll()
	nArea++
End

dbSelectArea("ZZO")

//VALIDACO DA EXECUCAO
Do Case
	Case ZZO->ZZO_STATUS == "E" .OR. ZZO->ZZO_STATUS == "X" //Nao possibilita executar uma tarefa ja em execucao.
		MsgStop("Não é possível executar uma tarefa já em execução !")
		lExec := .F.
	Case ZZO->ZZO_STATUS == "D" //Quando a tarefa estiver desativada pede confirmação do usuário.
		lExec := MsgYesNo("ATENÇÃO! A tarefa '" + ALLTRIM(ZZO->ZZO_DESCR) + "' está DESATIVADA." + CHR(13) + CHR(13) + " Deseja executar mesmo assim ?")
		//Altera o status para "A" para que a rotina de execução não rejeite.
		If lExec
			lOff := .T.
			RecLock("ZZO", .F.)
			ZZO->ZZO_STATUS := "A"
			MsUnlock()
		EndIf
	Case ZZO->ZZO_STATUS == "A" //Pede confirmação do usuário.
		lExec := MsgYesNo("Confirma a execução da tarefa '" + ALLTRIM(ZZO->ZZO_DESCR) + "' ?")
	OtherWise //Não possibilita executar uma tarefa já em execução.
		MsgStop("Esta tarefa esta com uma situação não prevista pelo sistema ! [" + ZZO->ZZO_STATUS + "]")
		lExec := .F.
EndCase

//EXECUCAO
If lExec
	U_SCHExecTask(ZZO->(RecNo()), ZZO->ZZO_ORDEM, AllTrim(ZZO->ZZO_ARQS)) //Se a tarefa estava desabilitada, retorna para o status "D".
	If lOff
		dbSelectArea("ZZO")
		RecLock("ZZO", .F.)
		ZZO->ZZO_STATUS := "D"
		MsUnlock()
	EndIf
EndIF

//Destrava todos os locks para todas as areas abertas (POR PRECAUÇÃO).
nArea := 1
While !Empty(Alias(nArea))
	dbSelectArea(Alias(nArea))
	MsUnlockAll()
	nArea++
End

Return(.T.)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | CFGA01AB   | Autor | Flavio S. Guimaraes       | Data | 25/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Aborta uma execução em andamento.
|---------|--------------------------------------------------------------------
| Param.  | NIL
|---------|--------------------------------------------------------------------
| Retorna | .T.
-------------------------------------------------------------------------------
*/
USER FUNCTION CFGA01AB()
LOCAL cMsg, cInicProc, dInicProc, cLiberado, lAborta := .F.

//VALIDAÇÃO DO ABORTO DE EXECUÇÃO
Do Case
	Case ZZO->ZZO_STATUS == "E"
		dInicProc := CToD(Subs(ZZO->ZZO_ULTEXE,1,10))
		cInicProc := Subs(ZZO->ZZO_ULTEXE,12,5)
		cLiberado := U_SomaDtHr(dInicProc, cInicProc, 1, "H")
		If (!Empty(ZZO->ZZO_PROCS) .OR. "SQL" $ UPPER(ZZO->ZZO_FUNCAO)) .And. cLiberado > DToS(Date()) + Subs(Time(),1,5) //Não possibilita abortar a executação de uma tarefa que esta sendo abortada.
			cMsg := "ATENÇÃO!!!  O sistema não é capaz de solicitar o aborto ao Servidor de Banco." + Chr(13) + Chr(13)
			cMsg += "UTILIZE ESTA OPÇÃO APENAS APÓS TER VERIFICADO NO BANCO QUE A PROCEDURE NÃO ESTÁ SENDO EXECUTADA !" + Chr(13) + Chr(13)
			cMsg += "Mesmo assim, por questões de segurança, esta opção estará habilitada apenas" + Chr(13)
			cMsg += "em " + Subs(cLiberado,7,2) + "/" + Subs(cLiberado,5,2) + "/" + Subs(cLiberado,1,4) + " as " + Subs(cLiberado,9,5)
			MsgStop(cMsg)
			lAborta := .F.
		Else //Pede confirmação do usuário.
			lAborta := MsgYesNo("Confirma o cancelamento da execução da tarefa " + CHR(13) + "'" + ALLTRIM(ZZO->ZZO_DESCR) + "' ?")
		EndIf
	Case ZZO->ZZO_STATUS == "X"	//Não possibilita abortar a executação de uma tarefa que esta sendo abortada.
		MsgStop("Esta tarefa já está sendo abortada !")
		lAborta := .F.
	OtherWise //Não possibilita abortar a executação de uma tarefa que não esteja executando.
		MsgStop("Não é possível abortar uma tarefa que não esteja em execução !")
		lAborta := .F.
EndCase

//ABORTO
If lAborta	//Destrava todos os locks para todas as areas abertas (POR PRECAUÇÃO).
	nArea := 1
	While !Empty(Alias(nArea))
		dbSelectArea(Alias(nArea))
		MsUnlockAll()
		nArea++
	End
	
	DbSelectArea("ZZO")
	RecLock("ZZO", .F.)
	ZZO->ZZO_STATUS := "X"
	ZZO->ZZO_ULTEXE := "Abortando..."
	MsUnlock()
	
	dbSelectArea("ZZP")
	RecLock("ZZP", .T.)
	ZZP->ZZP_FILIAL := xFilial("ZZP")
	ZZP->ZZP_DATA   := Date()
	ZZP->ZZP_HRINIC := Time()
	ZZP->ZZP_FUNCAO := ZZO->ZZO_FUNCAO
	ZZP->ZZP_DESCR  := ZZO->ZZO_DESCR
	ZZP->ZZP_ORDEM  := ZZO->ZZO_ORDEM
	ZZP->ZZP_USUEXE := Subs(cUsuario,7,15)
	ZZP->ZZP_OBS    := "Tarefa ABORTADA."
	MsUnlock()
	
	//Destrava todos os locks para todas as areas abertas (POR PRECAUÇÃO).
	nArea := 1
	While !Empty(Alias(nArea))
		dbSelectArea(Alias(nArea))
		MsUnlockAll()
		nArea++
	End
EndIF

Return(.T.)

/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | CFGA01ST   | Autor | Flavio S. Guimaraes       | Data | 25/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Ativa ou desativa a tarefa posicionada.
|---------|--------------------------------------------------------------------
| Param.  | NIL
|---------|--------------------------------------------------------------------
| Retorna | .T.
-------------------------------------------------------------------------------
*/
USER FUNCTION CFGA01ST()
LOCAL lInv := .F.
LOCAL cObs := ""
Local aOldArea := GetArea()

//VALIDAÇÃO DA ATIV/DESATIVAÇÃO DA TAREFA
Do Case
	Case ZZO->ZZO_STATUS == "A" //Pede confirmação do usuário.
		lInv := MsgYesNo("Confirma a DESATIVAÇÃO da tarefa '" + ALLTRIM(ZZO->ZZO_DESCR) + "' ?")
	Case ZZO->ZZO_STATUS == "D" //Pede confirmação do usuário.
		lInv := MsgYesNo("Confirma a ATIVAÇÃO da tarefa '" + ALLTRIM(ZZO->ZZO_DESCR) + "' ?")
	Case ZZO->ZZO_STATUS == "X" //Pede confirmação do usuário.
		lInv := MsgYesNo("Esta tarefa ainda não concluiu o processo de aborto. É recomendado aguardar a conclusão !" + CHR(13) + CHR(13) + " Confirma a ATIVAÇÃO mesmo assim ?")
	OtherWise //Não possibilita inverter o status de uma tarefa que esteja executando.
		MsgStop("Não é possível alterar o status de uma tarefa que esteja em execução!")
		lInv := .F.
EndCase

//INVERSAO DO STATUS
If lInv
	dbSelectArea("ZZO")
	RecLock("ZZO", .F.)
	If ZZO->ZZO_STATUS == "X"
		ZZO->ZZO_ULTEXE := ""
	EndIf
	
	If ZZO->ZZO_STATUS == "A"
		ZZO->ZZO_PRXEXE := "Desativando..."
		cObs := "Tarefa DESATIVADA."
	Else
		ZZO->ZZO_PRXEXE := "Ativando..."
		
		If ZZO->ZZO_STATUS == "X"
			cObs := "Tarefa ATIVADA EM PROCESSO DE ABORTO !!!"
		Else
			cObs := "Tarefa ATIVADA."
		EndIf
	EndIf
	
	ZZO->ZZO_STATUS := IIF(ZZO->ZZO_STATUS == "A", "D", "A")
	MsUnlock()
	
	dbSelectArea("ZZP")
	RecLock("ZZP", .T.)
	ZZP->ZZP_FILIAL := xFilial("ZZP")
	ZZP->ZZP_DATA   := Date()
	ZZP->ZZP_HRINIC := Time()
	ZZP->ZZP_FUNCAO := ZZO->ZZO_FUNCAO
	ZZP->ZZP_DESCR  := ZZO->ZZO_DESCR
	ZZP->ZZP_ORDEM  := ZZO->ZZO_ORDEM
	ZZP->ZZP_USUEXE := Subs(cUsuario,7,15)
	ZZP->ZZP_OBS    := cOBS
	MsUnlock()
EndIf

RestArea(aOldArea)

Return(.T.)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | CFGA01HS   | Autor | Flavio S. Guimaraes       | Data | 25/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Tela de consulta de historico.
|---------|--------------------------------------------------------------------
| Param.  | NIL
|---------|--------------------------------------------------------------------
| Retorna | .T.
-------------------------------------------------------------------------------
*/
USER FUNCTION CFGA01HS()

LOCAL cTCadastro, aTRotina
LOCAL cFilIni, cFilFin

//Guarda em variaveis temporarias as configurações da mbrowse chamadora
cTCadastro := cCadastro
aTRotina   := AClone(aRotina)

cCadastro := "Histórico do Agendamento da Tarefa '" + AllTrim(ZZO->ZZO_DESCR) + "'."
aRotina := { {"Det. Erros"  ,"U_CFGA01ER",0,4} }

cFilIni := cFilFin := 'xFilial("ZZP") + ZZO->ZZO_ORDEM'
//ZZP->(dbSetOrder(2))
mBrowse( 6,1,22,75,"ZZP", , , , , , , cFilIni, cFilFin)

cCadastro := cTCadastro
aRotina   := AClone(aTRotina)

Return(.T.)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | CFGA01ER   | Autor | Flavio S. Guimaraes       | Data | 25/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Tela de consulta do historico de erros.
|---------|--------------------------------------------------------------------
| Param.  | NIL
|---------|--------------------------------------------------------------------
| Retorna | .T.
-------------------------------------------------------------------------------
*/
USER FUNCTION CFGA01ER()

LOCAL cTCadastro, aTRotina
LOCAL cFilIni, cFilFin

//Guarda em variaveis temporarias as configurações da mbrowse chamadora
cTCadastro := cCadastro
aTRotina   := AClone(aRotina)

cCadastro := "Histórico dos Erros Ocorridos na Tarefa '" + AllTrim(ZZO->ZZO_DESCR) + "'."
aRotina   := {}

cFilIni := cFilFin := 'xFilial("ZZQ") + ZZP->ZZP_ORDEM + DToS(ZZP->ZZP_DATA) + ZZP->ZZP_HRINIC'
//ZZQ->(dbSetOrder(1))
mBrowse( 6,1,22,75,"ZZQ", , , , , , , cFilIni, cFilFin)

cCadastro := cTCadastro
aRotina   := AClone(aTRotina)

Return(.T.)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | ValidJob   | Autor | Flavio S. Guimaraes       | Data | 25/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Função para validação da digitação do Job.
|---------|--------------------------------------------------------------------
| Param.  | cJob = O Job digitado
|---------|--------------------------------------------------------------------
| Retorna | (.T.) quando for valido.
-------------------------------------------------------------------------------
*/
USER FUNCTION ValidJob(cJob)

LOCAL lRet

lRet := (cJob >= 'A' .And. cJob <= 'T')

If !lRet
	MsgStop("Os Jobs válidos são:  (de) 'A' (até) 'T' !")
EndIF

Return(lRet)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | ValidTsk   | Autor | Flavio S. Guimaraes       | Data | 25/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Função para validação da pre-tarefa
|---------|--------------------------------------------------------------------
| Param.  | cOrdem  = O código da tarefa.
|         | cPreTsk = O código da pre-tarefa.
|---------|--------------------------------------------------------------------
| Retorna | (.T.) quando for valido.
-------------------------------------------------------------------------------
*/
USER FUNCTION ValidTsk(cOrdem, cPreTsk)

LOCAL lRet

lRet := (cOrdem <> cPreTsk)

If !lRet
	MsgStop("A pre-tarefa não pode ser a própria tarefa !")
EndIF

Return(lRet)