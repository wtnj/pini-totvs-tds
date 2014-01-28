/*/
-------------------------------------------------------------------------------
| Projeto | LIBERTY PAULISTA SEGUROS
|---------|--------------------------------------------------------------------
| Descr.  | Rotina de Schedulagem via Job.
|------------------------------------------------------------------------------
| Alteracao                                          | Autor      | Data
|----------------------------------------------------|------------|------------
| 1.Criação de Log em arquivo texto para identificar | Flavio SG  | 16/04/01
|   falhas de conexão com o TOPConnect               |            |
| 2.Criação de controle possibilitando definir qual  | Flavio SG  | 23/04/01
|   Job ira executar cada tarefa.		              |            |
| 3.Criação de 'buffer' para armazenar o conteudo    | Flavio SG  | 23/04/01
|   do arquivo de agendamento em memória.            |            |
| 4.Criação de opção para vincular uma tarefa a uma  | Flavio SG  | 23/04/01
|   pre-tarefa. Com isso a tarefa sera executada     |            |
|   apenas após o término da pre-tarefa.             |            |
| 5.Criação de controle na abertura de ambiente. Com | Flavio SG  | 23/04/01
|   isso o ambiente é aberto apenas durante a        |            |
|   execução da tarefa e com apenas as tabelas da    |            |
|   propria tarefa.                                  |            |
| 6.Criação de opção para executar uma tarefa        | Flavio SG  | 23/04/01
|   mediante solicitação do usuário. Ou seja,        |            |
|   independente do dia/hora agendado.               |            |
| 7.Criação de opção para abortar uma tarefa         | Flavio SG  | 24/04/01
|   mediante solicitação do usuário.                 |            |
| 8.Criação de opção para atualizar as quantidades   | Flavio SG  | 24/04/01
|   processadas durante a execução das tarefas.      |            |
| 9.Criação de opção para controlar o aborto da      | Flavio SG  | 02/05/01
|    execução manual de uma tarefa.                  |            |
|10.Ao executar uma tarefa desabilitada, foi altera- | Flavio SG  | 08/05/01
|   do para manter a tarefa desabilitada apos a      |            |
|   execução.                                        |            |
|11.Implementação de execução em cascata para        | Flavio SG  | 10/05/01
|   pre-tarefas.                                     |            |
|12.Implementação de controle para guardar historico | Flavio SG  | 11/05/01
|   dos erros ocorridos nas tarefas.                 |            |
|13.Foi criado um campo novo para informar ao usuário| Flavio SG  | 21/05/01
|   quando será a próxima execução da tarefa.        |            |
|14.Após a execução de uma tarefa pelo automático    | Flavio SG  | 21/05/01
|   foi colocada uma verificação de quando a execução|            |
|   estiver sendo efetuada em atraso para que a      |            |
|   próxima execução ocorra dentro do mesmo período. |            |
|15.Opção para executar o job via menu de um módulo. | Flavio SG  | 23/05/01
|16.Implementado o Job-Main. Sua função é monitorar  | Flavio SG  | 23/05/01
|   todos os jobs que estiver executando para quando |            |
|   haver queda, o job será iniciado automaticamente.|            |
|17.Ao iniciar um job, verifica se alguma tarefa     | Flavio SG  | 25/05/01
|   configurada para executar no proprio job esta    |            |
|   em execução e a ativa novamente.                 |            |
|18.Como esta ocorrendo de varios registros ficarem  | Flavio SG  | 26/11/01
|   travados. Ainda sem explicação. Foi colocado     |            |
|   um MsUnlockAll() para evitar o problema.         |            |
-------------------------------------------------------------------------------
/*/
#include "tbiconn.ch"
/*/
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | MainJob1/MainJob2 | Autor | Flavio S. Guimaraes  | Data | 23/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Funções para executar os jobs principais.
|         | A finalidade é executar alguns jobs em um servidor e outros em
|         | outro servidor.
|         | OBS:  SÃO ESTAS FUNÇÕES QUE DEVEM SER INCLUIDAS NO [ONSTART] DO
|         |       AP5SRV.INI
|---------|--------------------------------------------------------------------
| Exemplo | [ONSTART]
| de Uso  | Jobs=MAINJOB
| no      |
| AP5SRV. | [MAINJOB]
| INI     | MAIN=U_MainJob1
|         | ENVIRONMENT=Environment
|---------|--------------------------------------------------------------------
| Param.  | NIL
|---------|--------------------------------------------------------------------
| Retorna | NIL
-------------------------------------------------------------------------------
/*/
User Function MainJob1()
U_MainJob(1)
Return(NIL)

//User Function MainJob2()
//U_MainJob(2)
//Return(NIL)
/*/
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | MainJob      | Autor | Flavio S. Guimaraes     | Data | 23/05/2001
|---------|--------------------------------------------------------------------
| Descr.  | Função que monitora os Jobs. Quando um Job cair, será acionado
|         | novamente.
|---------|--------------------------------------------------------------------
| Param.  | nServer = Numero do servidor que esta chamando o MainJob.
|---------|--------------------------------------------------------------------
| Retorna | NIL
-------------------------------------------------------------------------------
/*/
User Function MainJob(nServer)
Local ni, nCount, nHdl, aHdl, nHdlTmp, cArqLck
Local aJobs := {}
Local aHdl  := {}
Private cJob

//Efetua lock para não ser possivel ativar duas vezes os mesmos jobs.
cArqLck := "JOB" + Str(nServer,1,0) + ".LCK"

While !KillApp()
	If File(cArqLck)
		nHdl := FOpen(cArqLck, 16)
		If nHdl < 0
			RETURN(NIL)
		EndIf
	Else
		nHdl := FCreate(cArqLck)
	EndIf

	If nHdl >= 0
		EXIT
	EndIf
	
	nCount := 1
	While !KillApp() .and. nCount <= 6
		Sleep(10000)
		nCount++
	End
End

//If nServer == 1
	cJob := "Main1"	//Jobs configurados para o Servidor 1
	AADD(aJobs, {"U_RFINJ20A","JOBA.LCK"})
//Else
//	cJob := "Main2"	//Jobs configurados para o Servidor 2
//	AADD(aJobs, {"U_RFINJ20B","JOBB.LCK"})
//EndIf

While !KillApp()
	For nI := 1 To Len(aJobs)
		If File(aJobs[ni,2])
			nHdlTmp := FOpen(aJobs[ni,2], 16)
		Else
			nHdlTmp := FCreate(aJobs[ni,2])
		EndIf
		
		If nHdlTmp >= 0
			FClose(nHdlTmp)
			U_SCHMsg('Iniciando o Job ' + Right(aJobs[ni,1],1) + ' em ' + DTOC(Date()) + ' ' + Time() + '...')
			StartJob( aJobs[ni,1], GetEnvServer(), .F. )
		EndIf
	Next
	nCount := 1
	While !KillApp() .and. nCount <= 18
		Sleep(10000)
		nCount++
	End
End

For nI := 1 To Len(aHdl)
	FClose(aHdl[nI])
Next

FClose(nHdl)

Return(NIL)
/*/
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | JobSrv1/JobSrv2  | Autor | Flavio S. Guimaraes  | Data | 23/05/2001
|---------|--------------------------------------------------------------------
| Descr.  | Funções para serem utilizadas em menus de um módulo.
|         |   OBS: Possibilitam acionar a execução de um job pelo menu.
|---------|--------------------------------------------------------------------
| Param.  | NIL
|---------|--------------------------------------------------------------------
| Retorna | NIL
|---------|--------------------------------------------------------------------
| Parame- | StartJob(<funcao>,<ambiente>,<mono-processamento>)
| tros da |
| função  |     <funcao>             = Nome da função que será executada pelo Job.
| StartJob|     <ambiente>           = Nome do ambiente onde o Job será executado.
|         |     <mono-processamento> = (.F.) não aguarda pelo término do processamento do jopb acionado.
|         |                            (.T.) aguarda pelo término do processamento do jopb acionado.
-------------------------------------------------------------------------------
/*/
User Function JobSrv1()
StartJob("U_MAINJOB1", GetEnvServer(), .F. )  //Inicia o MainJob do Server 1
MsgStop("Job-Main1 Iniciado com Sucesso!")
Return(NIL)

//User Function JobSrv2()
//StartJob("U_MAINJOB2", GetEnvServer(), .F. )  //Inicia o MainJob do Server 2
//MsgStop("Job-Main2 Iniciado com Sucesso!")
//Return(NIL)
/*/
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | RFINJ20A...D  | Autor | Flavio S. Guimaraes     | Data | 23/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Funções para serem chamadas pelo MainJob. Cada uma executa o Job
|         | correspondente.
|---------|--------------------------------------------------------------------
| Param.  | NIL
|---------|--------------------------------------------------------------------
| Retorna | NIL
-------------------------------------------------------------------------------
/*/
User Function RFINJ20A()
U_RFINJ20('A')  //01
Return(NIL)

User Function RFINJ20B()
U_RFINJ20('B')	 //02
Return(NIL)

User Function RFINJ20C()
U_RFINJ20('C')  //03
Return(NIL)

User Function RFINJ20D()
U_RFINJ20('D')  //04
Return(NIL)
/*/
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | RFINJ20    | Autor | Flavio S. Guimaraes       | Data | 10/01/2001
|---------|--------------------------------------------------------------------
| Descr.  | Rotina de Principal de Schedulagem via Job.
|---------|--------------------------------------------------------------------
| Param.  | cNJob = Letra correspondente ao Job que esta executando esta função.
|---------|--------------------------------------------------------------------
| Retorna | NIL
-------------------------------------------------------------------------------
/*/
User Function RFINJ20(cNJob)
LOCAL aZZO, aZZOTmp, dDtZZO, cHrZZO
LOCAL nLoop, nCount, nHdl, cArq

//Variavel contendo o Job Ativo e Modelo Automático ou Manual para uso de todas
//as rotinas do agendamento inclusive as agendadas.
Private cJob, lAuto

cJob  := cNJob
lAuto := .T.

//Abre arquivo de lock em exclusivo para que o job seja monitorado pelo Job Main.
cArq  := "JOB" + AllTrim(Upper(cJob)) + ".LCK"
If File(cArq)
	nHdl := FOpen(cArq, 16)
Else
	nHdl := FCreate(cArq)
EndIf

//Devido a primeira conexação no Top abrir momentaneamente o SX2 exclusivo os demais Jobs
//aguardam um minuto para iniciar.
If cJob <> "A"
	nCount := 1
	While !KillApp() .and. nCount <= 18
		Sleep(10000)
		nCount++
	End
EndIf

// Carrega o vetor contendo todas as informacoes para o agendamento.
U_SCHMsg("Agendamento do AP5 INICIADO   em " + DTOC(Date()) + " " + Time() + "...")
aZZO := U_SCHCarregaZZO({})

// Verifica se ja houve uma parada do servidor Protheus para iniciar o array aZZO evitando erro no While abaixo.
If KillApp()
	aZZO := {{.F.}}
Else
	//Registra abertura do ambiente
	U_SCHMsg("  Ambiente aberto com SUCESSO [" + Time() + "]")
EndIf

//Executa enquanto o servidor Protheus estiver ativo e o parametro MV_SCHON estiver ligado.
While !KillApp() .AND. aZZO[1,1]
	For nLoop := 1 To LEN(aZZO)
		//As tarefas estão apenas apartir da posição 2 do vetor devido existir um cabeçalho na posição 1.
		If nLoop >= 2
			//Verifica se a tarefa esta ativa
			If aZZO[nLoop,02] == "A"
				//Verifica a data/hora inicial para execução da tarefa
				If Dtos(aZZO[nLoop,03]) + aZZO[nLoop,04] <= Dtos(Date()) + Left(Time(),5)
					//Verifica periodo de validade para execução
					If aZZO[nLoop,09] <= Date() .AND. aZZO[nLoop,10] >= Date()
						//Verifica se esta na hora de executar
						If U_SomaDtHr(aZZO[nLoop,11], aZZO[nLoop,12], aZZO[nLoop,05], aZZO[nLoop,06]) <= Dtos(Date()) + Left(Time(),5)
							U_SCHExecTask(aZZO[nLoop,14], aZZO[nLoop,01], aZZO[nLoop,13])
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
		//Atualiza o vetor aZZO
		aZZO := U_SCHCarregaZZO(aZZO)
		//Se o Server for parado ou se o parametro MV_SCHON for desligado.
		If KillApp() .Or. !aZZO[1,1]
			Exit
		EndIf
	Next
	nCount := 1
	While !KillApp() .and. nCount <= 12
		Sleep(aZZO[1,2] / 12)
		nCount++
	End
End

//Log de Finalização em arquivo texto e console.
If aZZO[1,1]
	U_SCHMsg("Agendamento do AP5 FINALIZADO em " + DTOC(Date()) + " " + Time() + ".")
Else
	U_SCHMsg("Agendamento do AP5 CANCELADO via parametro MV_SCHON em " + DTOC(Date()) + " " + Time() + ".")
EndIf

//Libera arquivo de lock.
FClose(nHdl)
Return(NIL)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | SCHCarregaZZO  | Autor | Flavio S. Guimaraes    | Data | 23/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Lê o arquivo de agendamento "ZZO" e todos os parametros referente
|         | ao agendamento para montar um vetor com o conteudo de todas as
|         | tarefas agendadas APENAS PARA O JOB ATIVO e todas as configurações
|         | do agendamento.
|---------|--------------------------------------------------------------------
| Param.  | aZZO = Conteudo atual do vetor apenas para retornar quando não for
|         |        possível abrir o ambiente.
|---------|--------------------------------------------------------------------
| Retorna | Vetor:  {{<MV_SCHON //01>, <MV_SCHTMP //02>, <MV_SCHZZO //03>},
|         |          { <ZZO_ORDEM  //01>,
|         |            <ZZO_STATUS //02>,
|         |            <ZZO_DTINIC //03>,
|         |            <ZZO_HRINIC //04>,
|         |            <ZZO_TEMPO  //05>,
|         |            <ZZO_UN     //06>,
|         |            <ZZO_DESCR  //07>,
|         |            <ZZO_FUNCAO //08>,
|         |            <ZZO_DE     //09>,
|         |            <ZZO_ATE    //10>,
|         |            <ZZO_DTULTP //11>,
|         |            <ZZO_HRULTP //12>,
|         |            <ZZO_ARQS   //13>,
|         |            <RecNo()    //14> }, ... }
|         |
|         | OBS: MV_SCHON  = Indica se a rotina de agendamento esta ativa.
|         |      MV_SCHTMP = Indica o intervalo de tempo para verificacao das
|         |                  tarefas no agendamento. (em milesimos de segundo).
|         |      MV_SCHZZO = Indica o intervalo de tempo para atualizar o vetor
|         |                  aZZO com as informações de agendamento. (minutos).
-------------------------------------------------------------------------------
*/
User Function SCHCarregaZZO(aZZO)
LOCAL  aPLTmp, lOn, nLoop, nAtuZZO, cPrxExe, nArea
LOCAL  lAberto := .F.

STATIC nVezes := 1
STATIC dDtZZO := Date()
STATIC cHrZZO := Time()

//Se nao for a primeira vez a executar, verifica se esta na hora de atualizar.
If nVezes > 1
	If U_SomaDtHr(dDtZZO, cHrZZO, aZZO[1,3], "MN") > Dtos(Date()) + Left(Time(),5)
		Return(aZZO)
	EndIf
EndIf


//Registra o dia/hora da atualização
dDtZZO := Date()
cHrZZO := Time()


//Abre o ambiente. Se não for possível e é a primeira vez, continua tentando.
While !lAberto .And. !KillApp()
	lAberto := U_SCHAbreEnv("ZZO")
	
	If !lAberto
		U_SCHMsg("  Aguardando por nova tentativa. [" + Time() + "]")
		//Aguarda três segundos para nova tentativa.
		Sleep(5000)
		
		//Registra o dia/hora da nova atualização
		dDtZZO := Date()
		cHrZZO := Time()
	EndIf
	
	If nVezes > 1
		Exit
	EndIf
End


//Se foi possivel abrir o ambiente
If lAberto
	
	//Carrega o parametro de job ligado ou desligado em variavel.
	dbSelectArea("SX6")
	dbSetOrder(1)
	If !dbSeek(xFilial("SX6")+"MV_SCHON")
		RecLock("SX6",.T.)
		SX6->X6_FIL     := xFilial("SX6")
		SX6->X6_VAR     := "MV_SCHON"
		SX6->X6_TIPO    := "L"
		SX6->X6_DESCRIC := "Indica se a rotina de agendamento esta ativa"
		SX6->X6_CONTEUD := "T"
		MsUnlock()
	EndIf
	lOn   := GetMV("MV_SCHON")
	
	//Carrega o parametro de tempo para loop em variavel.
	If !dbSeek(xFilial("SX6")+"MV_SCHTMP")
		RecLock("SX6",.T.)
		SX6->X6_FIL     := xFilial("SX6")
		SX6->X6_VAR     := "MV_SCHTMP"
		SX6->X6_TIPO    := "N"
		SX6->X6_DESCRIC := "Indica o intervalo de tempo para verificacao das"
		SX6->X6_DESC1	 := "tarefas no agendamento. (em milésimos de segundo)"
		SX6->X6_CONTEUD := "50000"
		MsUnlock()
	EndIf
	nLoop := GetMV("MV_SCHTMP")
	
	//Carrega o parametro de tempo para atualizacao do buffer do ZZO.
	If !dbSeek(xFilial("SX6")+"MV_SCHZZO")
		RecLock("SX6",.T.)
		SX6->X6_FIL     := xFilial("SX6")
		SX6->X6_VAR     := "MV_SCHZZO"
		SX6->X6_TIPO    := "N"
		SX6->X6_DESCRIC := "Indica o intervalo de tempo para atualizar o"
		SX6->X6_DESC1   := "buffer de informações de agendamento."
		SX6->X6_DESC2   := "(em minutos)"
		SX6->X6_CONTEUD := "5"
		MsUnlock()
	EndIf
	nAtuZZO := GetMV("MV_SCHZZO")
	
	//Carrega o parametro de usuario para alcadas
	If !dbSeek(xFilial("SX6")+"MV_USERALC")
		RecLock("SX6",.T.)
		SX6->X6_FIL     := xFilial("SX6")
		SX6->X6_VAR     := "MV_USERALC"
		SX6->X6_TIPO    := "C"
		SX6->X6_DESCRIC := "Nome do usuario de alcadas utilizado pelo"
		SX6->X6_DESC1   := "sistema."
		SX6->X6_DESC2   := " "
		SX6->X6_CONTEUD := "SISTEMAS"
		MsUnlock()
	EndIf
	if Empty(cUsuario)
		cUsuario := Space(06)+PadR(Upper(AllTrim(GetMv("MV_USERALC"))),15)
	endif
	//Carrega cabecalho do vetor aZZO com as configuracoes do agendamento.
	ASIZE(aZZO, 0)
	AADD(aZZO, {lOn, nLoop, nAtuZZO})
	
	//Destrava todos os locks para todas as areas abertas (POR PRECAUÇÃO).
	nArea := 0
	While !Empty(Alias(nArea))
		dbSelectArea(Alias(nArea))
		MsUnlockAll()
		nArea++
	End
	
	//Carrega todas as tarefas agendadas APENAS para o JOB ativo.
	dbSelectArea("ZZO")
	dbGoTop()
	While !Eof()
		
		If AllTrim(ZZO->ZZO_JOB) <> AllTrim(cJob) //Verifica se a tarefa esta configurada para o job ativo.
			dbSelectArea("ZZO")
			dbSkip()
			Loop
		EndIf
		
		//Atualiza o campo de próxima execução
		If ZZO->ZZO_STATUS == "A" .Or. ZZO->ZZO_STATUS == "D"
			dbSelectArea("ZZO")
			
			If ZZO->ZZO_STATUS == "A"
				cPrxExe := U_SomaDtHr(ZZO->ZZO_DTULTP, ZZO->ZZO_HRULTP, ZZO->ZZO_TEMPO, ZZO->ZZO_UN)
				RecLock("ZZO", .F.)
				ZZO->ZZO_PRXEXE := Subs(cPrxExe,7,2) + "/" + Subs(cPrxExe,5,2) + "/" + Subs(cPrxExe,1,4) + " " + Subs(cPrxExe,9)
				MsUnlock()
				
			ElseIf ZZO->ZZO_STATUS == "D"
				RecLock("ZZO", .F.)
				ZZO->ZZO_PRXEXE := 'Desativada!'
				MsUnlock()
			EndIf
		EndIf
		
		//O job esta sendo iniciado e verificou que existe uma execução automática executando (travada)
		If nVezes == 1 .And. ZZO->ZZO_STATUS == "E" //.And. AllTrim(ZZO->ZZO_USUEXE) == "[Automatico]"
			dbSelectArea("ZZO")
			RecLock("ZZO", .F.)
			ZZO->ZZO_STATUS := "A"
			ZZO->ZZO_PRXEXE := "Ativando..."
			MsUnlock()
		EndIf
		
		aPLTmp := {}
		AADD(aPLTmp, ZZO->ZZO_ORDEM)         //01
		AADD(aPLTmp, ZZO->ZZO_STATUS)        //02
		AADD(aPLTmp, ZZO->ZZO_DTINIC)        //03
		AADD(aPLTmp, ZZO->ZZO_HRINIC)        //04
		AADD(aPLTmp, ZZO->ZZO_TEMPO)         //05
		AADD(aPLTmp, ZZO->ZZO_UN)            //06
		AADD(aPLTmp, ZZO->ZZO_DESCR)         //07
		AADD(aPLTmp, ZZO->ZZO_FUNCAO)        //08
		AADD(aPLTmp, ZZO->ZZO_DE)            //09
		AADD(aPLTmp, ZZO->ZZO_ATE)           //10
		AADD(aPLTmp, ZZO->ZZO_DTULTP)        //11
		AADD(aPLTmp, ZZO->ZZO_HRULTP)  		 //12
		AADD(aPLTmp, AllTrim(ZZO->ZZO_ARQS)) //13
		AADD(aPLTmp, RecNo())     		     //14
		
		AADD(aZZO, aPLTmp)
		
		dbSelectArea("ZZO")
		dbSkip()
	End
	
	//Destrava todos os locks para todas as areas abertas (POR PRECAUÇÃO).
	nArea := 0
	While !Empty(Alias(nArea))
		dbSelectArea(Alias(nArea))
		MsUnlockAll()
		nArea++
	End
	
	dbSelectArea("ZZO")
EndIf
nVezes++
Return(aZZO)
/*/
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | SCHAbreEnv    | Autor | Flavio S. Guimaraes    | Data | 23/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Funcao para abertura de ambiente com verificação de conexão com
|         | o TopConnect.
|---------|--------------------------------------------------------------------
| Param.  | cTabelas = Contem todas as tabelas a serem abertas no ambiente.
|---------|--------------------------------------------------------------------
| Retorna | (.T.) se foi possível abrir o ambiente ou (.F.) caso contrário.
-------------------------------------------------------------------------------
/*/
User Function SCHAbreEnv(cTabelas)

LOCAL nCon, cDataBase, cAlias, cServer, cConType
LOCAL cTabs, cTabAtu
LOCAL cInIfile := GetADV97()

If lAuto //Quando for abrir o ambiente em automatico.
	//Monta variavel com todas as tabelas que serao abertas segundo o parametro cTabelas.
	cTabs := ""
	For nX := 1 To Int(Len(cTabelas) / 3)
		cTabs += IIf(Empty(cTabs),'',',') + '"' + Subs(cTabelas, (nX * 3) - 2, 3) + '"'
	Next
	Prepare Environment Empresa "01" Filial "01" Tables eVal({|| cTabs }) Modulo "ESP"
Else
	//Abre as tabelas que não estiverem abertas
	For nX := 1 To Int(Len(AllTrim(cTabelas)) / 3)
		cTabAtu := AllTrim(Subs(cTabelas, (nX * 3) - 2, 3))
		If !Empty(cTabAtu)
			If Select(cTabAtu) == 0
				If !ChkFile(cTabAtu, .F.)
					MsgStop("Não foi possível abrir a tabela '" + cTabAtu + "' !" + CHR(13) + CHR(13) + "A tarefa não pode ser executada.")
					Return(.F.)
				EndIf
			EndIf
		EndIf
	Next
EndIf

Return(.T.)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | SCHExecTask   | Autor | Flavio S. Guimaraes    | Data | 23/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Executa a tarefa correspondente ao parametro nZZORec e atualiza
|         | a tabela de agendamento e historico do mesmo.
|---------|--------------------------------------------------------------------
| Param.  | nZZORec     = Numero do registro no ZZO da tarefa a ser executada.
|         | nZZOOrdem   = Codigo da tarefa a ser executada
|         | cZZOTabelas = Tabelas para abrir no ambiente da tarefa a executar
|---------|--------------------------------------------------------------------
| Retorna | NIL
-------------------------------------------------------------------------------
*/
User Function SCHExecTask(nZZORec, cZZOOrdem, cZZOTabelas)

LOCAL cPreTsk, aPreTsk, nLoop, nArea

cZZOTabelas := AllTrim(cZZOTabelas)
cZZOTabelas += IIf(At('ZZO', cZZOTabelas) == 0, 'ZZO', '')
cZZOTabelas += IIf(At('ZZP', cZZOTabelas) == 0, 'ZZP', '')
//cZZOTabelas += IIf(At('ZZQ', cZZOTabelas) == 0, 'ZZQ', '')

//Faz tentativa de abrir o ambiente
If !U_SCHAbreEnv(cZZOTabelas)
	U_SCHMsg("  Aguardando por nova tentativa. [" + Time() + "]")
	Sleep(5000)
	Return(NIL)
EndIf

//Destrava todos os locks para todas as areas abertas (POR PRECAUÇÃO).
nArea := 0
While !Empty(Alias(nArea))
	dbSelectArea(Alias(nArea))
	MsUnlockAll()
	nArea++
End

//Posiciona na tarefa a executar
dbSelectArea("ZZO")
dbSetOrder(1)
dbGoTo(nZZORec)

//Verifica se a tarefa posicionada corresponde à tarefa acionada.
If cZZOOrdem <> ZZO->ZZO_ORDEM
	U_SCHMsg("  Tarefa nº " + AllTRim(cZZOOrdem) + " IGNORADA ate a próxima atualização do Buffer [" + Time() + "]")
	Sleep(5000)
	Return(NIL)
EndIf

//Verifica diretamente no arquivo de agendamento se a tarefa esta ativa.
If ZZO->ZZO_STATUS <> "A"
	Sleep(5000)
	Return(NIL)
EndIf

//Verifica se existe pre-rotina e se nao esta executando.
aPreTsk := {}
Do While !Empty(ZZO->ZZO_PRETSK)
	dbSelectArea("ZZO")
	If dbSeek(xFilial("ZZO")+ZZO->ZZO_PRETSK)
		cPreTsk := ZZO->ZZO_PRETSK
		AADD(aPreTsk, {ZZO->(RecNo()), ZZO->ZZO_ARQS} )
		
		//A pre-rotina nao esta ativa.
		Do Case
			Case ZZO->ZZO_STATUS == "E"	//A pre-rotina esta executando.
				//Posiciona na tarefa a executar e grava OBS
				dbSelectArea("ZZO")
				dbGoTo(nZZORec)
				RecLock("ZZO", .F.)
				ZZO->ZZO_OBS := "Aguardando final de exec. da Pre-Tarefa " + AllTRim(cPreTsk)
				MsUnlock()
				
				Sleep(5000)
				Return(NIL)
			Case ZZO->ZZO_STATUS == "X"	//A pre-rotina esta sendo abortada.
				//Posiciona na tarefa a executar e grava OBS
				dbSelectArea("ZZO")
				dbGoTo(nZZORec)
				RecLock("ZZO", .F.)
				ZZO->ZZO_OBS := "A Pre-Tarefa " + AllTrim(cPreTsk) + " esta sendo abortada."
				MsUnlock()
				
				Sleep(5000)
				Return(NIL)
			Case ZZO->ZZO_STATUS == "D" //A pre-rotina esta desativada.
				//Posiciona na tarefa a executar e grava OBS
				dbSelectArea("ZZO")
				dbGoTo(nZZORec)
				RecLock("ZZO", .F.)
				ZZO->ZZO_OBS := "A Pre-Tarefa " + AllTrim(cPreTsk) + " esta desativada."
				MsUnlock()
				
				Sleep(5000)
				Return(NIL)
		EndCase
	Else 	//Nao existe a pre-rotina.
		cPreTsk := ZZO->ZZO_PRETSK
		//Posiciona na tarefa a executar e grava OBS
		dbSelectArea("ZZO")
		dbGoTo(nZZORec)
		RecLock("ZZO", .F.)
		ZZO->ZZO_OBS := "Pre-Tarefa " + AllTrim(cPreTsk) + " Inexistente"
		MsUnlock()
		
		Sleep(5000)
		Return(NIL)
	EndIf
End

//Executa as Pre-Tarefas
For nLoop := Len(aPreTsk) To 1 Step -1
	//Abre o ambiente para as pretarefas.
	If !U_SCHAbreEnv(aPreTsk[nLoop,2])
		U_SCHMsg("  Aguardando por nova tentativa. [" + Time() + "]")
		Sleep(5000)
		Return(NIL)
	EndIf
	
	//Posiciona na pre-tarefa a executar.
	dbSelectArea("ZZO")
	dbGoTo(aPreTsk[nLoop,1])
	U_SCHExecute(cZZOOrdem)
Next

//Posiciona na tarefa a executar.
dbSelectArea("ZZO")
dbGoTo(nZZORec)
U_SCHExecute("")

Return(NIL)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | SCHExecute   | Autor | Flavio S. Guimaraes    | Data | 10/05/2001
|---------|--------------------------------------------------------------------
| Descr.  | Executa a tarefa que estiver posicionada no ZZO
|---------|--------------------------------------------------------------------
| Param.  | cPosTsk = Código da Pós-Tarefa que esta acionando esta execução.
|			 |           OBS: Quando a execução for pela propria tarefa, este
|         |                parametro recebe "".
|---------|--------------------------------------------------------------------
| Retorna | NIL
-------------------------------------------------------------------------------
*/
User Function SCHExecute(cPosTsk)
LOCAL dInicProc, cInicProc, cTarefa, cUltExe, cPrxExe, nArea

dInicProc := Date()
cInicProc := Time()

//Marca que a tarefa esta sendo executada
dbSelectArea("ZZO")
RecLock("ZZO", .F.)
ZZO->ZZO_STATUS := "E"

ZZO->ZZO_PROCES := 0
ZZO->ZZO_PROCOK := 0
ZZO->ZZO_ERROS  := 0

ZZO->ZZO_ULTEXE := StrZero(Day(dInicProc),2) + "/" + StrZero(Month(dInicProc),2) + "/" + StrZero(Year(dInicProc),4) + " " + Left(cInicProc,5)
ZZO->ZZO_OBS    := ""

//If lAuto
//	ZZO->ZZO_USUEXE := "[Automatico]"
//Else
//	ZZO->ZZO_USUEXE := Subs(cUsuario,7,15)
//EndIf

MsUnlock()

dbSelectArea("ZZP")
RecLock("ZZP", .T.)
ZZP->ZZP_FILIAL := xFilial("ZZP")
ZZP->ZZP_DATA   := Date()
ZZP->ZZP_HRINIC := Time()                                                            
ZZP->ZZP_FUNCAO := ZZO->ZZO_FUNCAO
ZZP->ZZP_DESCR  := ZZO->ZZO_DESCR
ZZP->ZZP_ORDEM  := ZZO->ZZO_ORDEM
//ZZP->ZZP_USUEXE := ZZO->ZZO_USUEXE
ZZP->ZZP_OBS    := "Executando" + IIF(Empty(cPosTsk),""," (Via Tsk " + AllTrim(cPosTsk) + ")") + "..."
MsUnlock()


//Executa a Tarefa
cTarefa   := AllTrim(ZZO->ZZO_FUNCAO)
Eval({ || &cTarefa })


dbSelectArea("ZZO")
RecLock("ZZO", .F.)
If ZZO->ZZO_STATUS == "X"
	ZZO->ZZO_STATUS := "D"
	ZZO->ZZO_OBS := "Tarefa ABORTADA pelo usuario" + IIF(Empty(cPosTsk),""," (Via Tsk " + AllTrim(cPosTsk) + ")")
Else
	ZZO->ZZO_STATUS := "A"
	ZZO->ZZO_OBS := "Tarefa executada com sucesso" + IIF(Empty(cPosTsk),""," (Via Tsk " + AllTrim(cPosTsk) + ")")
EndIf

ZZO->ZZO_ULTEXE := StrZero(Day(dInicProc),2) + "/" + StrZero(Month(dInicProc),2) + "/" + StrZero(Year(dInicProc),4) + " " + Left(cInicProc,5) + " até " + Left(Time(),5)

If lAuto
	If Upper(Alltrim(ZZO->ZZO_UN)) == 'MN' .OR. Upper(Alltrim(ZZO->ZZO_UN)) == 'H'
		ZZO->ZZO_DTULTP := dInicProc
		ZZO->ZZO_HRULTP := cInicProc
	ElseIf Upper(Alltrim(ZZO->ZZO_UN)) == 'D'
		//Verifica se a execução nao ocorreu antes da hora agendada (quando houver atraso)
		If Left(Time(),5) >= ZZO->ZZO_HRINIC
			ZZO->ZZO_DTULTP := dInicProc
			ZZO->ZZO_HRULTP := ZZO->ZZO_HRINIC
		Else //Se a execução ocorreu antes da hora agendada, marca a ultima execução de forma que
			//a seguinte seja executada no mesmo período (para evitar futuro atraso).
			cUltExe := U_SomaDtHr(dInicProc, ZZO->ZZO_HRINIC, ZZO->ZZO_TEMPO * -1, ZZO->ZZO_UN)
			ZZO->ZZO_DTULTP := CTOD(Subs(cUltExe, 7, 2)+"/"+Subs(cUltExe, 5, 2)+"/"+Subs(cUltExe, 1, 4))
			ZZO->ZZO_HRULTP := ZZO->ZZO_HRINIC
		EndIf
	ElseIf Upper(Alltrim(ZZO->ZZO_UN)) == 'M' 	//Verifica se a execução nao ocorreu antes da hora agendada (quando houver atraso)
		If StrZero(Day(Date()),2) <= StrZero(Day(ZZO->ZZO_DTINIC),2)
			ZZO->ZZO_DTULTP := CTOD(StrZero(Day(ZZO->ZZO_DTINIC),2)+"/"+StrZero(Month(Date()),2)+"/"+Right(StrZero(Year(Date()),4),2))
			ZZO->ZZO_HRULTP := ZZO->ZZO_HRINIC
		Else //Se a execução ocorreu antes da hora agendada, marca a ultima execução de forma que
			//a seguinte seja executada no mesmo período (para evitar futuro atraso).
			cUltExe := U_SomaDtHr(dInicProc, ZZO->ZZO_HRINIC, ZZO->ZZO_TEMPO * -1, ZZO->ZZO_UN)
			ZZO->ZZO_DTULTP := CTOD(StrZero(Day(ZZO->ZZO_DTINIC),2)+"/"+Subs(cUltExe, 5, 2)+"/"+Subs(cUltExe, 1, 4))
			ZZO->ZZO_HRULTP := ZZO->ZZO_HRINIC
		EndIf
	EndIf
	
	cPrxExe := U_SomaDtHr(ZZO->ZZO_DTULTP, ZZO->ZZO_HRULTP, ZZO->ZZO_TEMPO, ZZO->ZZO_UN)
	ZZO->ZZO_PRXEXE := Subs(cPrxExe,7,2) + "/" + Subs(cPrxExe,5,2) + "/" + Subs(cPrxExe,1,4) + " " + Subs(cPrxExe,9)
EndIf

dbSelectArea("ZZO")
MsUnLock()

dbSelectArea("ZZP")
RecLock("ZZP", .F.)
ZZP->ZZP_HRFIM  := Time()
ZZP->ZZP_PROCOK := ZZO->ZZO_PROCOK
ZZP->ZZP_ERROS  := ZZO->ZZO_ERROS
ZZP->ZZP_PROCES := ZZO->ZZO_PROCES
ZZP->ZZP_OBS    := ZZO->ZZO_OBS
MsUnlock()


//Destrava todos os locks para todas as areas abertas (POR PRECAUÇÃO).
nArea := 0
While !Empty(Alias(nArea))
	dbSelectArea(Alias(nArea))
	MsUnlockAll()
	nArea++
End

Return(NIL)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | SomaDtHr   | Autor | Flavio S. Guimaraes     | Data | 10/01/2001
|---------|--------------------------------------------------------------------
| Descr.  | Acrescenta uma quantidade de tempo à uma determinada data e hora.
|---------|--------------------------------------------------------------------
| Param.  | dDataOrg  = Data para calcular acrescimo de tempo
|         | cHoraOrg  = Hora para calcular acrescimo de tempo
|         | nTempo    = Quantidade de tempo a acrescentar
|         | cUn       = Unidade de Tempo a acrescentar
|---------|--------------------------------------------------------------------
| Retorna | NIL
-------------------------------------------------------------------------------
*/
User Function SomaDtHr(dDataOrg, cHoraOrg, nTempo, cUn)

Private nRestoHr := 0, nRestoDia := 0, nRestoAno := 0, nSoma
Private cMn, cHr, cMes, cAno, cData

cUn := AllTrim(Upper(cUn))

If cUn == "MN" .Or. cUn == "H" //Controla Minuto ou Hora
	If cUn == "MN" //Minuto
		nSoma 	:= Val(Subs(cHoraOrg,4,2)) + nTempo
		nRestoHr := Int(nSoma / 60)
		cMn 		:= StrZero((nSoma % 60),2)
	Else
		cMn := Subs(cHoraOrg,4,2)
	EndIf
	
	//Hora
	nSoma 	 := Val(Subs(cHoraOrg,1,2)) + nRestoHr + IIf(cUn == "H", nTempo, 0)
	nRestoDia := Int(nSoma / 24)
	cHr 		 := StrZero((nSoma % 24),2)
Else
	cMn := Subs(cHoraOrg,4,2)
	cHr := Subs(cHoraOrg,1,2)
EndIf

If cUn == "D" .Or. nRestoDia > 0 //Dia
	cData := DTOS(dDataOrg + nRestoDia + IIf(cUn == "D", nTempo, 0))
Else
	If cUn == "M" //Mes
		nSoma 	 := Month(dDataOrg) + nTempo
		nRestoAno := Int((nSoma - 1) / 12)
		cMes 		 := StrZero((nSoma % 12),2)
		
		If cMes == "00"
			cMes := "12"
		EndIf
	Else
		cMes      := StrZero(Month(dDataOrg),2)
	EndIf
	
	//Hora
	nSoma := Year(dDataOrg) + nRestoAno + IIf(cUn == "A", nTempo, 0)
	cAno	 := StrZero(nSoma,4)
	cData := cAno + cMes + StrZero(Day(dDataOrg),2)
EndIf

Return(cData + cHr + ":" + cMn)



/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | SCHMsg   | Autor | Flavio S. Guimaraes     | Data | 16/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Mostra mensagem no console e grava a mesma no arquivo de log.
|---------|--------------------------------------------------------------------
| Param.  | cLogMsg  = Mensagem para registrar no console e arquivo de Log.
|---------|--------------------------------------------------------------------
| Retorna | NIL
-------------------------------------------------------------------------------
*/
USER FUNCTION SCHMsg(cLogMsg)
Static cLogErro := ""
Static cLogName := ""

If Empty(cLogName)
	//Log de Inicialização em arquivo texto e console.
	ConOut("")
	cLogName := ".\SCH\" + cJob + DTOS(Date()) + Left(Time(),2) + Subs(Time(),4,2) + ".LOG"
EndIf

ConOut("JOB [" + cJob + "]: " + cLogMsg)
cLogErro += IIF(cLogErro == "", "", Chr(13) + Chr(10)) + cLogMsg

If File(".\SCH")
	MemoWrit(cLogName, cLogErro)
EndIf
RETURN(NIL)



/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | SCHStopTask   | Autor | Flavio S. Guimaraes    | Data | 24/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Funcao para ser utilizada pelas tarefas agendadas.
|         | Verifica se a tarefa pode continuar a ser executada ou deve
|         | abortar a execução.
|---------|--------------------------------------------------------------------
| Param.  | NIL
|---------|--------------------------------------------------------------------
| Retorna | (.T.) quando a tarefa deve ser abortada.
-------------------------------------------------------------------------------
*/
User Function SCHStopTask()

//Retorna .T. quando a tarefa for abortada pelo usuario.
If ZZO->ZZO_STATUS == "X" .OR. KillApp()
	Return(.T.)
EndIf
Return(.F.)



/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | SCHQtdeInic   | Autor | Flavio S. Guimaraes    | Data | 24/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Funcao para ser utilizada pelas tarefas agendadas.
|         | Recebe a informação de quantos registros serão processados.
|---------|--------------------------------------------------------------------
| Param.  | nQtdeInic = Quantidade de registros que serão processados pela
|			 |             rotina.
|---------|--------------------------------------------------------------------
| Retorna | NIL
-------------------------------------------------------------------------------
*/
User Function SCHQtdeInic(nQtdeInic)
LOCAL cAlias := Alias()

dbSelectArea("ZZO")
RecLock("ZZO", .F.)
ZZO->ZZO_PROCES := nQtdeInic
MsUnlock()

dbSelectArea(cAlias)
Return(NIL)



/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | SCHQtdeAtual   | Autor | Flavio S. Guimaraes    | Data | 24/04/2001
|---------|--------------------------------------------------------------------
| Descr.  | Funcao para ser utilizada pelas tarefas agendadas.
|         | Recebe a informação de quantos registros foram processados.
|---------|--------------------------------------------------------------------
| Param.  | nQtdeOK   = Quantidade de registros que foram processados com
|         |             sucesso
|         | nQtdeErro = Quantidade de registros que foram ignorados por
|         |             conter inconsistências.
|         | [lFinal]  = (.T.) quando for a posição final do processamento
|         |             OBS: quando for (.T.) a posição será gravada
|         |                  momentaneamente. TENHA CUIDADO COM A PERFORMANCE!
|         | [aErros]  = Array opcional contendo a descrição de cada erro
|         |             ocorrido na tarefa.
|         |             OBS: o conteudo deste array será gravado apenas no
|         |                  final do processo (quando lFinal for .T.)
|         |             Estrutura do array:
|         |               {{<chave do registro com erro (tam. max.  20 caracteres) //01>,
|	   	  |						 <descrição do erro	        (tam. max.  50 caracteres) //02>,
|         |						 <descrição da solucao       (tam. max. 200 caracteres) //03>}, ...}
|---------|--------------------------------------------------------------------
| Retorna | NIL
-------------------------------------------------------------------------------
*/
User Function SCHQtdeAtual(nQtdeOK, nQtdeErro, lFinal, aErros)
LOCAL cAlias := Alias(), nLoop
STATIC nVezes := 1

//Controla Default dos parametros
If lFinal == NIL
	lFinal := .F.
EndIF

If aErros == NIL
	aErros := {}
EndIF

//Executa alternadamente por motivo de performance.
If !lFinal .And. nVezes < 10
	nVezes++
	Return(NIL)
EndIf
nVezes := 1

dbSelectArea("ZZO")
RecLock("ZZO", .F.)
ZZO->ZZO_PROCOK := nQtdeOK
ZZO->ZZO_ERROS  := nQtdeErro

//Grava OBS para que o usuario verifique se a tarefa esta sendo executada.
ZZO->ZZO_OBS    := "Executando a Tarefa: " + Time()
MsUnlock()

//Grava o conteudo do array aErros.
/*
If lFinal
	dbSelectArea("ZZQ")
	For nLoop := 1 To Len(aErros)
		RecLock("PLV", .T.)
		PLV->PLV_FILIAL := xFilial("PLV")
		PLV->PLV_DATA   := ZZP->ZZP_DATA
		PLV->PLV_HRINIC := ZZP->ZZP_HRINIC
		PLV->PLV_ORDEM  := ZZP->ZZP_ORDEM
		PLV->PLV_CHAVE  := aErros[nLoop, 1]
		PLV->PLV_ERRO   := aErros[nLoop, 2]
		PLV->PLV_SOLUC  := aErros[nLoop, 3]
		MsUnlock()
	Next
EndIf
*/
dbSelectArea(cAlias)
Return(NIL)
/*
-------------------------------------------------------------------------------
| Projeto | Editora Pini Ltda
|---------|--------------------------------------------------------------------
| Funcao  | SCHAbortado   | Autor | Flavio S. Guimaraes    | Data | 02/05/2001
|---------|--------------------------------------------------------------------
| Descr.  | Funcao para ser utilizada pelas tarefas agendadas.
|         | Recebe a informação de que a tarefa foi abortada e quantos
|         | registros foram processados.
|---------|--------------------------------------------------------------------
| Param.  | nQtdeOK   = Quantidade de registros que foram processados com
|         |             sucesso
|         | nQtdeErro = Quantidade de registros que foram ignorados por
|         |             conter inconsistências.
|         |
|         | [aErros]  = Array opcional contendo a descrição de cada erro
|         |             ocorrido na tarefa.
|         |             OBS: o conteudo deste array será gravado apenas no
|         |                  final do processo (quando lFinal for .T.)
|         |             Estrutura do array:
|         |               {{<chave do registro com erro (tam. max.  20 caracteres) //01>,
|         |						 <descrição do erro	        (tam. max.  50 caracteres) //02>,
|         |						 <descrição da solucao       (tam. max. 200 caracteres) //03>}, ...}
|---------|--------------------------------------------------------------------
| Retorna | NIL
-------------------------------------------------------------------------------
*/
User Function SCHAbortado(nQtdeOK, nQtdeErro, aErros)
LOCAL cAlias := Alias()
LOCAL nLoop

If aErros == NIL
	aErros := {}
EndIF

dbSelectArea("ZZO")
RecLock("ZZO", .F.)
ZZO->ZZO_STATUS := "X"
ZZO->ZZO_ULTEXE := "Abortando..."
ZZO->ZZO_PROCOK := nQtdeOK
ZZO->ZZO_ERROS  := nQtdeErro
MsUnlock()

//Grava o conteudo do array aErros.
/*
dbSelectArea("PLV")
For nLoop := 1 To Len(aErros)
	RecLock("PLV", .T.)
	PLV->PLV_FILIAL := xFilial("PLV")
	PLV->PLV_DATA   := ZZP->ZZP_DATA
	PLV->PLV_HRINIC := ZZP->ZZP_HRINIC
	PLV->PLV_ORDEM  := ZZP->ZZP_ORDEM
	PLV->PLV_CHAVE  := aErros[nLoop, 1]
	PLV->PLV_ERRO   := aErros[nLoop, 2]
	PLV->PLV_SOLUC  := aErros[nLoop, 3]
	MsUnlock()
Next
*/

dbSelectArea(cAlias)
Return(NIL)