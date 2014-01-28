#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
                              
//Danilo C S Pala 20060327: dados de enderecamento do DNE
User Function Pfat106e()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CDESC1,CDESC2,CDESC3,TITULO,ARETURN,CPROGRAMA")
SetPrvt("MHORA,CARQ,CSTRING,WNREL,NLASTKEY,L")
SetPrvt("NORDEM,M_PAG,NCARACTER,TAMANHO,CTITULO,CCABEC1")
SetPrvt("CCABEC2,LCONTINUA,MSAIDA,CPERG,MCONTA1,MCONTA2")
SetPrvt("MCONTA3,LEND,BBLOCO,CINDEX,CKEY,MVALIDA")
SetPrvt("CFILTRO,CCHAVE,CIND,MIND1,MCONTA,MPEDIDO")
SetPrvt("MITEM,MCODCLI,MCODDEST,MPROD,MCF,MCEP")
SetPrvt("MVALOR,MNOMECLI,MDEST,MEND,MMUN,MEST")
SetPrvt("MFONE,MCGC,MDTPG,MDTFAT,MDTPG2,MFILIAL")
SetPrvt("MBAIRRO,MPAGO,MPGTO,MPARC,MABERTO,MVEND")
SetPrvt("MEDVENC,MGRAVA,MDTVENC,MGRAT,MCODREV,MRESPCOB")
SetPrvt("MTITULO,_LSEEK,MEMAIL,MFAX,MATIV,MTPCLI")
SetPrvt("MFONE1,LIN,COL,LI,_ACAMPOS,_CNOME")
SetPrvt("MIND2,_SALIAS,AREGS,I,J,")

#IFNDEF WINDOWS
	// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     #DEFINE PSAY SAY
#ENDIF
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: PFAT106   쿌utor: Raquel Farias          � Data:   27/07/99 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri놹o: Impressao de Etiquetas para Mala Direta.                   � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento                                      � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿌ltera눯o           쿌lterado por: Raquel Farias   � Data:   10/04/00 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri눯o: Acrescentei consistencia de e1_hist=='LP'                  � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿗iberado para Usu쟲io em: 11/04/00                                    � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇 Observacao : Os progamas PFAT106E, PFAT106R e PFAT106C eram originalmen-굇
굇 te um s� que funcionava apenas para DOS. Por ocasi�o da conversao para  굇
굇 funcionamento em Windows decidiu-se que para melhor compreens�o do pro- 굇
굇 grama e afim de se seguir o padr�o Microsiga era melhor separar o pro-  굇
굇 grama de acordo com suas funcoes principais : Relatorio, Etiquetas e    굇
굇 Geracao de Arquivo.Foram criados,portando,os RDMAKES acima citados.     굇
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛FAT106E.PRX        � Gilberto A. de Oliveira Jr.  � Data:   16/04/00 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿌lteracoes:         �                                                 � 굇
굇쿒ilberto - 16.04.00 쿎onversao p/ Windows, separacao do antigo PFAT106� 굇
굇�                    쿮 substituicao de indices temporarios.           � 굇
굇쿒ilberto - 18.05.00 쿘V_PAR17, prioridade de processamento.           � 굇
굇�                    쿎lientes ou Produtos. Quando clientes cria indice� 굇
굇�                    퀃emporario por A1_CEP para o SA1 e processa pelo � 굇
굇�                    쿞A1.                                             � 굇
굇쿝aquel - 21.08.00   쿌crescentei grava눯o de 12 campos de controle no � 굇
굇�                    쿩Z7.                                             � 굇
굇�                    쿌crescentei valida눯o para assinaturas:          � 굇
굇�                    쿞e o mv_par16<>1 e Mv_par16<>2 o programa traba- � 굇
굇�                    쿹ha comparando a data de faturamento, se n�o tra-� 굇
굇�                    쿫alha comparando a data de circula눯o.           � 굇
굇쿒ilberto - 25.09.00 쿏espreza os registros que tenham situacao de nao � 굇
굇�                    퀁ecebimento de mailing no cadastro de destinata- � 굇
굇�                    퀁ios.                                            � 굇
굇읕컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Variaveis utilizadas para parametros                                    �
//쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� mv_par01 Do Produdo.........:                                           �
//� mv_par02 At� o Produto......:                                           �
//� mv_par03 Faturados/Venc de..:                                           �
//� mv_par04 Faturados/Venc at�.:                                           �
//� mv_par05 Do CEP.............:                                           �
//� mv_par06 At� CEP............:                                           �
//� mv_par07 Tipo...............: Pagas, Cortesia, Ambas.                   �
//� mv_par08 Situa눯o...........: Baixados, Em Aberto, Ambas.               �
//� mv_par09 Qtde da Selecao....:                                           �
//� mv_par10 Elimina duplicidade: Sim, Nao.                                 �
//� mv_par11 Cod. Promo눯o......:                                           �
//� mv_par12 Cod. Mailing.......:                                           �
//� mv_par13 Da Atividade.......:                                           �
//� mv_par14 At� Atividade......:                                           �
//� mv_par15 Tipo Cliente.......: Ass. Ativos, Ass. Cancelados, Outros.     �
//� mv_par16 Utilizacao.........: Mala Direta, TeleMarketing.               �
//� mv_par17 Prioridade Leitura.: Clientes,Produtos.                        �
//� mv_par18 Inclui representante: Sim  N�o                                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

#IFNDEF WINDOWS
	ScreenDraw("SMT050", 3, 0, 0, 0)
	SetCursor(1)
	SetColor("B/BG")
#ENDIF

cDesc1   := PADC("Este programa ira gerar o arquivo de clientes em etiquetas" ,74)
cDesc2   := PADC("Elimina duplicidade por codigo de cliente e destinatario",74)
cDesc3   := ""
Titulo   := PADC("ETIQUETAS",74)
aReturn  := { "Especial", 1,"Administra눯o", 1, 2, 1,"",1 }
cPrograma:="PFA106E"
MHORA    :=TIME()
cArq     :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString  :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
wnrel    :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
nLastKey := 00
L        := 00
nOrdem   := 00
m_pag    := 01
nCaracter:= 10
tamanho  := "P"
cTitulo  := ""
cCabec1  := ""
cCabec2  := ""
lContinua:= .T.
mSaida   := "3"

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Caso nao exista, cria grupo de perguntas.                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
cPerg    := "PF106E"
_ValidPerg()

If !Pergunte(cPerg)
	Return
Endif

IF Lastkey() == 27
	Return
Endif

DbSelectArea("ZZ7")
DbSeek(xfilial()+MV_PAR11+MV_PAR12+MSAIDA)
If Found()
	#IFDEF WINDOWS
		MsgStop(OEMTOANSI("Codigo ja utilizado, informe codigo valido ou solicite manuten눯o no cad. Mailing"))
	#ELSE
		Alert("Codigo ja utilizado, informe codigo valido ou solicite manuten놹o no cad. Mailing")
	#ENDIF
	Return
Endif
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Consiste parametro do CEP para o caso do processamento solicitado for por  �
//� clientes (SA1). Nao pode conter <branco> a <ZZZ> ou equivalente.           �
//� Deve ter um intervalo valido de CEP's.                                     �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
If mv_par17 == 1
	If mv_par05 == Space(Len(MV_PAR05))
		#IFDEF WINDOWS
			MsgStop("Verifique o Parametro CEP DE, pois o mesmo nao pode ser Branco !")
		#ELSE
			Alert("Verifique o Parametro CEP DE, pois o mesmo nao pode ser Branco !")
		#ENDIF
		Return
	EndIf
EndIf

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Valida gera눯o do mailing                                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

#IFNDEF WINDOWS
	F_VERSZA()
	IF mValida == 'N'
		RETURN
	ENDIF
#ELSE
	F_VERSZA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     Execute(F_VERSZA)
	IF mValida == 'N'
		RETURN
	ENDIF
#ENDIF

mConta1   :=0
mConta2   :=0
mConta3   :=0

FArqTrab()

#IFNDEF WINDOWS
	DrawAdvWin(" AGUARDE  - GERANDO ARQUIVO DE CLIENTES -  " , 8, 0, 15, 75 )
	If mv_par17 == 2   // produtos.
		Produtos()
	Else
		Clientes()
	Endif
	
	Limpa()
	Mostra()
#ELSE
	lEnd:= .F.
	If mv_par17 == 2
		bBloco:= { |lEnd| PRODUTOS()  }// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        bBloco:= { |lEnd| Execute(PRODUTOS)  }
	Else
		bBloco:= { |lEnd| CLIENTES()  }// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        bBloco:= { |lEnd| Execute(CLIENTES)  }
	Endif
	MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
	MOSTRA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     Execute(MOSTRA)
#ENDIF
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Atualiza arquivo de controle  - saida de mailing             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
#IFNDEF WINDOWS
	F_AtuZZ7()
#ELSE
	F_ATUZZ7()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     Execute(F_ATUZZ7)
#ENDIF

While .T.
	
	#IFNDEF WINDOWS
		ScreenDraw("SMT050", 3, 0, 0, 0)
		SetCursor(1)
		SetColor("B/BG")
		
		If !Pergunte(cPerg)
			Exit
		Endif
		
		If LastKey() == 27
			Exit
		Endif
		
		DrawAdvWin(" AGUARDE  - GERANDO ARQUIVO DE CLIENTES -  " , 8, 0, 15, 75 )
		
		If mv_par17 == 1
			Clientes()
		Else
			Produtos()
		EndIf
		
		Limpa()
		Mostra()
		
	#ELSE
		
		If !Pergunte(cPerg)
			Exit
		Endif
		
		If LastKey() == 27
			Exit
		Endif
		
		lEnd:= .F.
		
		If mv_par17 == 1
			bBloco:= { |lEnd| Clientes()  }// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>          bBloco:= { |lEnd| Execute(Clientes)  }
		Else
			bBloco:= { |lEnd| Produtos()  }// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>          bBloco:= { |lEnd| Execute(Produtos)  }
		EndIf
		
		MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
		Mostra()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>       Execute(Mostra)
		
	#ENDIF
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Valida gera눯o do mailing  - Verifica promo눯o               �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	#IFNDEF WINDOWS
		F_VERSZA()
		IF mValida == 'N'
			DbSelectArea(cArq)
			DbCloseArea()
			RETURN
		ENDIF
	#ELSE
		F_VERSZA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>       Execute(F_VERSZA)
		IF mValida == 'N'
			DbSelectArea(cArq)
			DbCloseArea()
			RETURN
		ENDIF
	#ENDIF
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Atualiza arquivo de controle  - saida de mailing             �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	#IFNDEF WINDOWS
		F_AtuZZ7()
	#ELSE
		F_ATUZZ7()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     Execute(F_ATUZZ7)
	#ENDIF
End

DbGoTop()

wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)
SetDefault(aReturn,cString)

If nLastKey == 27
	DbSelectArea(cArq)
	DbCloseArea()
	Return
Endif

DbSelectArea(cArq)
cIndex := CriaTrab(Nil,.F.)
cKey   := "CEP+NOME+NOMEDEST"
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")
dbGoTop()

#IFNDEF WINDOWS
	Etiqueta()
#ELSE
	RptStatus( {||Etiqueta()} )// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     RptStatus( {||Execute(Etiqueta)} )
#ENDIF

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Atualiza arquivo de controle  - saida de mailing             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
#IFNDEF WINDOWS
	F_AtuZZ7()
#ELSE
	F_ATUZZ7()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     Execute(F_ATUZZ7)
#ENDIF

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Retorna indices originais...                                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

DbSelectArea(cArq)
DbCloseArea()
DbSelectArea("SC6")
Retindex("SC6")
DbSelectArea("SC5")
Retindex("SC5")
DbSelectArea("SA1")
Retindex("SA1")
DbSelectArea("SZO")
Retindex("SZO")
DbSelectArea("SZN")
Retindex("SZN")
DbSelectArea("SE1")
Retindex("SE1")
DbSelectArea("SB1")
Retindex("SB1")
DbSelectArea("SZL")
Retindex("SZL")
DbSelectArea("SZA")
Retindex("SZA")
DbSelectArea("ZZ7")
Retindex("ZZ7")
DbSelectArea("SZJ")
Retindex("SZJ")
DbSelectArea("SX5")
Retindex("SX5")

Return

//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � F_VERSZA                                                      �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Valida gera눯o do arquivo  de dados                           �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   �                                                               �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function F_VERSZA
Static Function F_VERSZA()
DBSELECTAREA("SZA")
DBGOTOP()
DBSEEK(XFILIAL()+MV_PAR11)
IF !FOUND()
	#IFNDEF WINDOWS
		ALERT("Promocao nao cadastrada")
		ALERT("Entrar em contato com depto de Cadastro")
	#ELSE
		MsgStop(OEMTOANSI("Promocao nao cadastrada"))
		MsgStop("Entrar em contato com depto de Cadastro")
	#ENDIF
	mValida:="N"
ELSE
	DBSELECTAREA('SX5')
	DBGOTOP()
	DBSEEK(XFILIAL()+'91'+MV_PAR12)
	IF !FOUND()
		#IFNDEF WINDOWS
			ALERT("Mailing n�o cadastrado")
			ALERT("Entrar em contato com depto de Marketing")
		#ELSE
			MsgStop(OEMTOANSI("Mailing n�o cadastrado"))
			MsgStop("Entrar em contato com depto de Marketing")
		#ENDIF
		mValida:="N"
	ELSE
		mValida:="S"
	ENDIF
ENDIF
Return

//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � FATUZZ7                                                       �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Atualiza arquivo de controle de utilizacao.                   �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   �                                                               �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function F_AtuZZ7
Static Function F_AtuZZ7()

DbSelectArea("ZZ7")
RecLock("ZZ7",.T.)
Replace ZZ7_CODPRO With MV_PAR11
Replace ZZ7_CODMAI With MV_PAR12
Replace ZZ7_USUAR  With Subs(cUsuario,7,15)
Replace ZZ7_DATA   With Date()
Replace ZZ7_QTDE   With mConta1
Replace ZZ7_SAIDA  With MSAIDA
Replace ZZ7_PROD1  With MV_PAR01
Replace ZZ7_PROD2  With MV_PAR02
Replace ZZ7_CEP1   With MV_PAR05
Replace ZZ7_CEP2   With MV_PAR06
Replace ZZ7_ATIV1  With MV_PAR13
Replace ZZ7_ATIV2  With MV_PAR14
Replace ZZ7_TPCLI  With Str(MV_PAR15,1)
Replace ZZ7_UTILIZ With Str(MV_PAR16,1)
Replace ZZ7_DUPLIC With Str(MV_PAR10,1)
Replace ZZ7_SITUAC With Str(MV_PAR08,1)
Replace ZZ7_TPVEND With Str(MV_PAR07,1)
ZZ7->(MsUnLock())

Return


//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � PRODUTOS()                                                       �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Realiza leitura dos registros do SC6 ja filtrado e aplica     �
//�           � restante dos filtros de parametros. Prepara os dados para     �
//�           � serem gravados. Faz chamada a funcao GRAVA.                   �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   �                                                               �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function PRODUTOS
Static Function PRODUTOS()

mConta :=0
DbSelectArea("SC6")

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//쿚rdem 2 + DbSeek, substituindo o filtro indregua anteriormente    �
//퀅sado. Gilberto - 03.05.2000                                      �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

DbSetOrder(2)
DbGoTop()
DbSeek(xFilial("SC6")+MV_PAR01, .T.)

If ( SC6->C6_PRODUTO > MV_PAR02 )
	#IFNDEF WINDOWS
		Alert("Nao Existem Dados para serem apurados !")
	#ELSE
		MsgStop("Nao Existem Dados para serem apurados !")
	#ENDIF
Endif

While !EOF() .And. ( mConta1 < MV_PAR09 ).And. ( SC6->C6_PRODUTO <= MV_PAR02 )
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Filtro:Deixa passar apenas o que estiver de acordo com os    �
	//� parametros.                                                  �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	#IFNDEF WINDOWS
		@ 10,05 SAY "LENDO ARQUIVO ........" +STR(RECNO(),7)
	#ELSE
		MsProcTxt("Lendo Registros : "+Str(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
	#ENDIF
	
	IF MV_PAR15 <> 1 .AND. MV_PAR15 <> 2
		IF ( SC6->C6_DATFAT < MV_PAR03 ) .OR. (SC6->C6_DATFAT > MV_PAR04)
			DbSkip()
			Loop
		ENDIF
	ENDIF
	IF (SC6->C6_PRODUTO < MV_PAR01)
		DbSkip()
		Loop
	ENDIF
	IF ALLTRIM(SC6->C6_CLI) == "040000"
		DbSkip()
		Loop
	ENDIF
	
	** GILBERTO - 25.09.2000
	
	dbSelectArea("SZN")
	If dbSeek( xFilial("SZN")+SC6->C6_CLI+SC6->C6_CODDEST )
		If !Empty(SZN->ZN_SITUAC)
			dbSelectArea("SC6")
			dbSkip()
			Loop
		EndIf
	EndIf
	dbSelectArea("SC6")
	
	**
	
	
	mPedido  := ""
	mItem    := ""
	mCodCli  := ""
	mCodDest := ""
	mProd    := ""
	mCF      := ""
	mCEP     := ""
	mValor   := 0
	mNomeCli := ""
	mDest    := ""
	mEnd     := ""
	mMun     := ""
	mEst     := ""
	mFone    := ""
	mCGC     := ""
	mDTPG    := ctod("  /  /  ")
	mDTFat   := ctod("  /  /  ")
	mDTPG2   := ctod("  /  /  ")
	mFilial  := ""
	mBairro  := ""
	mPago    := 0
	mPgto    := 0
	mParc    := 0
	mAberto  := 0
	mVend    := ""
	mEDVENC  := ""
	mGrava   := ""
	mDtVenc  := ctod("  /  /  ")
	mGrat    :=" "
	
	mProd   := SC6->C6_PRODUTO
	mCodRev := SUBS(SC6->C6_PRODUTO,1,4)
	mDTFat  := SC6->C6_DATFAT
	mCodCli := SC6->C6_CLI
	mPedido := SC6->C6_NUM
	mItem   := SC6->C6_ITEM
	mValor  := SC6->C6_VALOR
	mCF     := ALLTRIM(SC6->C6_CF) // GILBERTO - 02/01/01
	mCodDest:= SC6->C6_CODDEST
	mFilial := SC6->C6_FILIAL
	mEDVENC  := SC6->C6_EDSUSP
	
	DbSelectArea ("SC5")
	DbGoTop()
	DbSeek(xFilial("SC5")+mPedido)
	
	If Found()
		mVend:= C5_VEND1
		mRespcob:=C5_RESPCOB
	Endif
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Verifica se a assinatura esta ativa                          �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	
	If MV_PAR15 == 2  .AND. !EMPTY(SC6->C6_PEDREN)
		DbSelectArea("SC6")
		DbSkip()
		Loop
	Endif
	
	If MV_PAR15 == 1 .OR. MV_PAR15 == 2
		DbSelectArea ("SZJ")
		DbGoTop()
		
		IF SUBSTR(MV_PAR01,1,4) >= '1000' .AND. SUBSTR(MV_PAR02,1,4) <= '1105'
			mCodRev := '9999'
		ENDIF
		
		DbSeek(xFilial("SZJ")+mCodRev+Str(MEDVENC,4))
		If MV_PAR15 == 2
			If SZJ->ZJ_DTCIRC < MV_PAR03 .OR. SZJ->ZJ_DTCIRC > MV_PAR04
				DbSelectArea("SC6")
				DbSkip()
				Loop
			Endif
		Endif
		
		If MV_PAR15 == 1
			If SZJ->ZJ_DTCIRC < DATE()
				DbSelectArea("SC6")
				DbSkip()
				Loop
			Endif
		Endif
		
		If Subs(SC6->C6_PRODUTO,5,3) == '001'
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
	Endif
	
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Verifica o registro faz parte do cad de representante        �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	
	If MV_PAR18 == 2
		DbSelectArea("SZL")
		DbGoTop()
		DbSeek(xFilial("SZL")+MCODCLI)
		
		If Found()
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
	Endif
	
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Elimina duplicidade por codigo de cliente e destinat쟲io     �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	
	If MV_PAR10 == 1
		
		DbSelectArea(cArq)
		DbGoTop()
		DbSeek(mCodCli+mCodDest)
		If Found()
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
		
	Endif
	
	DbSelectArea("SF4")
	DbSetOrder(1)
	DbGoTop()
	DbSeek(xFilial("SF4")+SC6->C6_TES)
	If SF4->F4_DUPLIC == 'N'
		IF 'CORTESIA' $(SF4->F4_TEXTO).OR.'DOACAO' $(SF4->F4_TEXTO)
			mGrat:='S'
		Endif
	EndIf
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Verifica se � cortesia para par긩etro=pago                   �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	
	If MV_PAR07 == 1 .And. mGrat == 'S'
		DbSelectArea("SC6")
		DbSkip()
		Loop
	Endif
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Verifica se � pago para par긩etro=cortesia                   �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	
	If MV_PAR07 == 2 .AND. mGrat <> 'S'
		DbSelectArea("SC6")
		DbSkip()
		Loop
	Endif
	
	DbSelectArea("SE1")
	DbGoTop()
	DbSeek(xFilial("SE1")+mPedido)
	
	If Found()
		
		MDTPG := SE1->E1_BAIXA
		
		Do While ( SE1->E1_PEDIDO == MPEDIDO )
			
			mParc := mParc+1
			mDTPG2:= SE1->E1_BAIXA
			
			If DTOC(MDTPG2) <> "  /  /  ".And.SE1->E1_SALDO == 0;
				.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,2) <> 'LP';
				.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,4) <> 'CANC'
				mPago:=mPago+1
			Else
				If SE1->E1_VENCTO+30 < DATE()
					mAberto:=mAberto+1
				Endif
			Endif
			
			DbSkip()
		Enddo
		mPGTO:=mPAGO/mPARC
	Else
		mAberto:=99999
	Endif
	
	DbSelectArea("SC6")
	If SUBS(SC6->C6_CF,2,2) == "99"
		mAberto:=0
	Endif
	
	If MV_PAR08 == 1
		If mAberto <> 0
			DbSkip()
			Loop
		Endif
	Endif
	
	If MV_PAR08 == 2
		If mAberto == 0
			DbSkip()
			Loop
		Endif
	Endif
	
	#IFNDEF WINDOWS
		Grava()
	#ELSE
		GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>                 Execute(GRAVA)
	#ENDIF
	
	DbSelectArea("SC6")
	
	If EOF()
		Exit
	Else
		DbSkip()
	Endif
	
End

Return


//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � GRAVA()                                                       �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Realiza gravacao dos registros ideais (conforme parametros)   �
//�           � para impressao das etiquetas.                                 �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   �                                                               �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function GRAVA
Static Function GRAVA()

DbSelectArea("SB1")
DbSeek(xFilial("SB1")+mProd)
If Found()
	mTitulo:=SB1->B1_DESC
Else
	mTitulo:="  "
Endif

_lSeek:= .T.
If mv_par17 == 2         // Observacao : S� executa o bloco abaixo caso o
	// processamento seja pelo produto, pois se for por
	// cliente o SA1 j� est� posicionado.
	
	DbSelectArea("SA1")
	DbGoTop()
	_lSeek:= DbSeek(xFilial("SA1")+mCodCli)
	
	
EndIf

If _lSeek
	mNomeCli := SA1->A1_NOME
	mEnd     := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060327
	mBairro  := SA1->A1_BAIRRO
	mMun     := SA1->A1_MUN
	mEst     := SA1->A1_EST
	mCEP     := SA1->A1_CEP
	mFone    := SA1->A1_TEL
	mDest    := SPACE(40)
	mCGC     := SA1->A1_CGC
	mFone    := SA1->A1_TEL
	mEmail   := SA1->A1_EMAIL
	mFax     := SA1->A1_FAX
	mAtiv    := SA1->A1_ATIVIDA
	mTpCli   := SA1->A1_TPCLI
Else
	mNomeCli := SPACE(40)
Endif

If mNomeCli <> "  "
	
	If mCodDest#" "
		
		DbSelectArea("SZN")
		DbSeek(xFilial("SZN")+mCodCli+mCodDest)
		
		If Found()
			mDest:= SZN->ZN_NOME
		Endif
		
		DbSelectArea("SZO")
		DbSeek(xFilial("SZO")+mCodCli+mCodDest)
		
		If Found()
			
			mEnd    := ALLTRIM(SZO->ZO_TPLOG) + " " + ALLTRIM(SZO->ZO_LOGR) + " " + ALLTRIM(SZO->ZO_NLOGR) + " " + ALLTRIM(SZO->ZO_COMPL) //20060327
			mBairro := SZO->ZO_BAIRRO
			mMun    := SZO->ZO_CIDADE
			mEst    := SZO->ZO_ESTADO
			mCEP    := SZO->ZO_CEP
			mFone1  := SZO->ZO_FONE
			
			If mFone1 <> "  "
				mFone:= mFone1
			Endif
			
		Endif
		
	Endif
	
Endif

If mCEP >= MV_PAR05 .And. MCEP <= MV_PAR06 .And. ;
	mCodCli   <> "  " .And. mAtiv >= MV_PAR13 .And. mAtiv <= MV_PAR14
	mGrava:= "S"
Endif

If MV_PAR15 == 2 .and. mTpCli == 'R'
	mGrava := "N"
Endif

If MV_PAR16 == 2 .And. Empty(mFone)
	mGrava:="N"
Endif

If MV_PAR19 == 1 .and. mTpCli <> 'F'
	mGrava:="N"
Endif

If MV_PAR19 == 2 .and. mTpCli <> 'J'
	mGrava:="N"
Endif

If mGrava == "S"
	mConta1:= mConta1+1
	
	#IFNDEF WINDOWS
		@ 11,05 SAY "GRAVANDO.............." +STR(mConta1,7)
	#ENDIF
	
	DbSelectArea(cArq)
	RecLock(cArq,.T.)
	Repla NumPed   With  mPedido
	Repla Item     With  mItem
	Repla CodCli   With  mCodCli
	Repla CodDest  With  mCodDest
	Repla CodProd  With  mProd
	Repla CF       With  mCF
	Repla CEP      With  mCEP
	Repla Valor    With  mValor
	Repla Nome     With  mNomeCli
	Repla NomeDest With  mDest
	Repla V_END      With  mEnd
	Repla Bairro   With  mBairro
	Repla Mun      With  mMun
	Repla Estado   With  mEst
	Repla Fone     With  mFone
	Repla Fax      With  mFax
	Repla EMAIL    With  mEMAIL
	Repla CGC      With  mCGC
	Repla DTPGTO   With  mDTPG
	Repla DTFAT    With  mDTFAT
	Repla PGTO     With  mPGTO
	Repla EMABERTO With  mAberto
	Repla Descr    With  mTitulo
	Repla CodVend  With  mVend
	Repla EDVENC   With mEDVENC
	Repla Respcob  With mRespcob
	MsUnlock()
Endif
Return

//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � LIMPA()                                                       �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Limpa tela para proximo Display.                              �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   � Utilizado apenas para Windows.                                �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function LIMPA
Static Function LIMPA()

@ 10,05 clear TO 10,70
@ 11,05 clear TO 10,70
@ 12,05 clear TO 10,70
@ 13,05 clear TO 10,70
@ 14,05 clear TO 10,70

Return

//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � MOSTRA()                                                      �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Mostra o resultado final da apuracao dos registros que serao  �
//�           � impressos como etiqueta de mala direta.                       �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   �                                                               �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function MOSTRA
Static Function MOSTRA()

#IFNDEF WINDOWS
	@ 10,05 SAY  'PRODUTO --------------->' +TRIM(MV_PAR01)+ ' A ' + TRIM(MV_PAR02)
	@ 11,05 SAY  'CEP    ---------------->' +MV_PAR05+ ' A ' + MV_PAR06
	@ 12,05 SAY  'QUANTIDADE SELECIONADA->' + STR(MV_PAR09,7,0)
	@ 13,05 SAY  'QUANTIDADE DO MAILING-->' + STR(MCONTA1,7,0)
	INKEY(0)
#ELSE
	@ 200,001 TO 400,450 DIALOG oDlg TITLE " Confirme ... "
	@ 003,010 TO 090,220
	@ 15,018 Say "Produto................: "+Trim(MV_PAR01)+ " A " + Trim(MV_PAR02)
	@ 30,018 Say "CEP....................: "+MV_PAR05      + " A " + MV_PAR06
	@ 45,018 SAY "Quantidade Selecionada.: "+STRZERO(MV_PAR09,7,0)
	@ 60,018 SAY "Quantidade do Mailing..: "+STRZERO(MCONTA1 ,7,0)
	@ 75,188 BMPBUTTON TYPE 01 ACTION Close(oDlg)
	Activate Dialog oDlg Centered
#ENDIF

Return

//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � ETIQUETA()                                                    �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Realiza Impressao das etiquetas conforme arquivo de trabalho. �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   �                                                               �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function ETIQUETA
Static Function ETIQUETA()

SetPrc(0,0)
Lin:= 0
Col:= 1
Li := 0

// DbSelectArea('PFAT106')
DbSelectArea(cArq)
Count to mConta

SetRegua(RecCount())

DbGoTop()

While ! EOF()
	
	IncRegua()
	
	@ Lin+Li,001 PSAY NOME
	DBSKIP()
	@ LIN+LI,043 PSAY NOME
	DBSKIP()
	@ LIN+LI,087 PSAY NOME
	DBSKIP(-2)
	LI:=LI+1
	
	IF ! EMPTY(NOMEDEST)
		@ LIN+LI,001 PSAY NOMEDEST
		DBSKIP()
		@ LIN+LI,043 PSAY NOMEDEST
		DBSKIP()
		@ LIN+LI,087 PSAY NOMEDEST
		DBSKIP(-2)
		LI:=LI+1
	ELSE
		@ LIN+LI,001 PSAY RESPCOB
		DBSKIP()
		@ LIN+LI,043 PSAY RESPCOB
		DBSKIP()
		@ LIN+LI,087 PSAY RESPCOB
		DBSKIP(-2)
		LI:=LI+1
	ENDIF
	
//20060327 daqui
	@ LIN+LI,001 PSAY substr(V_END,1,40)
	DbSkip()
	@ LIN+LI,043 PSAY substr(V_END,1,40)
	DbSkip()
	@ LIN+LI,087 PSAY substr(V_END,1,40)
	DbSkip(-2)
	Li:=Li+1

	@ LIN+LI,001 PSAY substr(V_END,41,40)
	DbSkip()
	@ LIN+LI,043 PSAY substr(V_END,41,40)
	DbSkip()
	@ LIN+LI,087 PSAY substr(V_END,41,40)
	DbSkip(-2)
	Li:=Li+1

	@ LIN+LI,001 PSAY substr(V_END,81,40)
	DbSkip()
	@ LIN+LI,043 PSAY substr(V_END,81,40)
	DbSkip()
	@ LIN+LI,087 PSAY substr(V_END,81,40)
	DbSkip(-2)
	Li:=Li+1
//20060327 ate aqui
	
	@ Lin+Li,001 PSAY BAIRRO+'          '+'('+NUMPED+')'
	DbSkip()
	@ Lin+Li,043 PSAY BAIRRO+'          '+'('+NUMPED+')'
	DbSkip()
	@ Lin+Li,087 PSAY BAIRRO+'          '+'('+NUMPED+')'
	DbSkip(-2)
	Li:=Li+1
	
	@ Lin+Li,001 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +Mun+' ' +ESTADO
	DbSkip()
	@ LIN+LI,043 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +Mun+' ' +ESTADO
	DbSkip()
	@ LIN+LI,087 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +Mun+' ' +ESTADO
	LI:=LI+1
	DbSkip()
	                                
	@ LIN+LI,001 PSAY "." //20060327
	LI:=LI+1          //20060327

	Li:=2
	SetPrc(0,0)
	Lin:=Prow()
	
End

@ Lin+Li  ,001 PSAY '****************************************'
@ Lin+Li+1,001 PSAY 'TOTAL...................:'+STR(MCONTA,7)
@ Lin+Li+2,001 PSAY '****************************************'

Set Devi To Screen
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()

Return


//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � FARQTRAB()                                                    �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Cria arquivo de trabalho para guardar registros que serao     �
//�           � impressos em forma de etiquetas.                              �
//�           � serem gravados. Faz chamada a funcao GRAVA.                   �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   �                                                               �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function FARQTRAB
Static Function FARQTRAB()
_aCampos:={}
AADD(_aCampos,{"NUMPED","C",6,0})
AADD(_aCampos,{"ITEM","C",2,0})
AADD(_aCampos,{"CF","C",5,0})
AADD(_aCampos,{"CODCLI","C",6,0})
AADD(_aCampos,{"NOME","C",40,0})
AADD(_aCampos,{"NOMEDEST","C",40,0})
AADD(_aCampos,{"V_END","C",120,0})
AADD(_aCampos,{"BAIRRO","C",20,0})
AADD(_aCampos,{"MUN","C",20,0})
AADD(_aCampos,{"ESTADO","C",2,0})
AADD(_aCampos,{"CEP","C",8,0})
AADD(_aCampos,{"CGC","C",14,0})
AADD(_aCampos,{"FONE","C",20,0})
AADD(_aCampos,{"FAX","C",20,0})
AADD(_aCampos,{"EMAIL","C",20,0})
AADD(_aCampos,{"CODPROD" ,"C",15,0})
AADD(_aCampos,{"DESCR","C",40,0})
AADD(_aCampos,{"DTPGTO","D",8,0})
AADD(_aCampos,{"DTFAT ","D",8,0})
AADD(_aCampos,{"VALOR","N",12,2})
AADD(_aCampos,{"PGTO","N",5,2})
AADD(_aCampos,{"EMABERTO","N",5,0})
AADD(_aCampos,{"CODVEND","C",6,0})
AADD(_aCampos,{"EDVENC","N",4,0})
AADD(_aCampos,{"CODDEST","C",6,0})
AADD(_aCampos,{"RESPCOB","C",40,0})

_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "CodCli+CodDEst"

// dbUseArea(.T.,, _cNome,"PFAT106",.F.,.F.)
dbUseArea(.T.,, _cNome,cArq,.F.,.F.)
// dbSelectArea("PFAT106")
dbSelectArea(cArq)
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� INDEXA SE1                                                              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

DbSelectArea("SE1")
dbSetOrder(21)  ///dbSetOrder(15) AP5

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� INDEXA SZL                                                              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

DbSelectArea("SZL")
cIndex:=CriaTrab(Nil,.F.)
cKey:="ZL_FILIAL+ZL_CODCLI"
Indregua("SZL",cIndex,ckey,,,"Selecionando Registros do Arq")
Retindex("SZL")
mInd2:=Retindex("SZL")
#IFNDEF TOP
	DbSetIndex( cIndex + OrdBagExt())
#ENDIF
DbSetOrder(mInd2+1)
DbGoTop()

Return

/*

Mudancas para poder filtrar atraves de clientes (sa1).

Criar pergunta no sx1 para saber qual � a prioridade de leitura
Selecionada para o relatorio, clientes ou produtos.
Indices do sc6 com chave do codigo do cliente.

Ordem 05 -> C6_FILIAL+C6_CLI+C6_LOJA+C6_PRODUTO.
Ordem 10 -> C6_FILIAL+C6_CLI+C6_NUM


Plano mestre :
--------------
Selecionar SA1, gerar indice por CEP (Temporario),
Manter o While principal com a selecao do SA1.
Pesquisar o SC6 com os clientes que tenham o CEP dentro da selecao
informada pelo usuario, entrar em while do sc6.
Verificar o restante dos filtros, como ja vinha sendo feito.


*/

//旼컴컴컴컴컴쩡컴컴컴컴컴컴컫컴컴컴쩡컴컴컴컴컴컫컴컴쩡컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � CLIENTES()   � Data � 28.05.2000 � Por� Gilberto A. Oliveira  �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컨컴컴컴좔컴컴컴컴컴컨컴컴좔컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Realiza leitura dos registros do SA1, filtra por escopo, con- �
//�           � forme os parametro mv_17 e aplica os outros filtros.          �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   � Funcao clone da PRODUTOS, cuja a prioridade e o SA1.             �
//�           � Para diminuir o tempo que se leva para conseguir etiquetas de �
//�           � poucos CEP's.                                                 �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function CLIENTES
Static Function CLIENTES()

mConta := 0
DbSelectArea("SA1")
DbSetOrder(6)
DbSeek(xFilial("SA1")+MV_PAR05, .T.)

If ( SA1->A1_CEP > MV_PAR06 )
	#IFNDEF WINDOWS
		Alert("O intervalo de CEP's nao foi encontrado no Cad.de Clientes!")
	#ELSE
		MsgStop("O intervalo de CEP's nao foi encontrado no Cad.de Clientes!")
	#ENDIF
EndIf

While !EOF() .And. ( mConta1 <  MV_PAR09 );
	.And. ( SA1->A1_CEP <= MV_PAR06 )

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Filtro:Deixa passar apenas o que estiver de acordo com os    �
	//� parametros.                                                  �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	
	DbSelectArea("SC6")
	DbSetOrder(5)
	DbSeek(xFilial("SC6")+SA1->A1_COD+SA1->A1_LOJA)
	
	If !Found()
		DbSelectArea("SA1")
		DbSkip()
		Loop
	EndIf
	
	While (SC6->C6_CLI+SC6->C6_LOJA) == (SA1->A1_COD+SA1->A1_LOJA);
		.And. !Eof();
		.And. SC6->C6_FILIAL == xFilial()
		
		#IFNDEF WINDOWS
			@ 10,05 SAY "LENDO ARQUIVO ........" +STR(RECNO(),7)
		#ELSE
			MsProcTxt("Lendo Registros : "+Str(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
		#ENDIF
		
		If MV_PAR15 <> 1 .AND. MV_PAR15 <> 2
			If (SC6->C6_DATFAT < MV_PAR03) .Or. ;
				(SC6->C6_DATFAT > MV_PAR04)
				DbSkip()
				Loop
			EndIf
		EndIf
		
		IF (SC6->C6_PRODUTO < MV_PAR01) .Or. ;
			(SC6->C6_PRODUTO > MV_PAR02)
			DbSkip()
			Loop
		ENDIF
		
		IF ALLTRIM(SC6->C6_CLI) == "040000"
			DbSkip()
			Loop
		ENDIF
		
		** GILBERTO - 25.09.2000
		
		dbSelectArea("SZN")
		If dbSeek( xFilial("SZN")+SC6->C6_CLI+SC6->C6_CODDEST )
			If !Empty(SZN->ZN_SITUAC)
				dbSelectArea("SC6")
				dbSkip()
				Loop
			EndIf
		EndIf
		dbSelectArea("SC6")
		
		**
		
		mPedido  := ""
		mItem    := ""
		mCodCli  := ""
		mCodDest := ""
		mProd    := ""
		mCF      := ""
		mCEP     := ""
		mValor   := 0
		mNomeCli := ""
		mDest    := ""
		mEnd     := ""
		mMun     := ""
		mEst     := ""
		mFone    := ""
		mCGC     := ""
		mDTPG    := ctod("  /  /  ")
		mDTFat   := ctod("  /  /  ")
		mDTPG2   := ctod("  /  /  ")
		mFilial  := ""
		mBairro  := ""
		mPago    := 0
		mPgto    := 0
		mParc    := 0
		mAberto  := 0
		mVend    := ""
		mEDVENC  := ""
		mGrava   := ""
		mGrat    :=" "
		
		mDtVenc  := ctod("  /  /  ")
		mProd   := SC6->C6_PRODUTO
		mCodRev := SUBS(SC6->C6_PRODUTO,1,4)
		mDTFat  := SC6->C6_DATFAT
		mCodCli := SC6->C6_CLI
		mPedido := SC6->C6_NUM
		mItem   := SC6->C6_ITEM
		mValor  := SC6->C6_VALOR
		mCF     := ALLTRIM(SC6->C6_CF)
		mCodDest:= SC6->C6_CODDEST
		mFilial := SC6->C6_FILIAL
		mEDVENC  := SC6->C6_EDSUSP
		
		DbSelectArea ("SC5")
		DbGoTop()
		DbSeek(xFilial("SC5")+mPedido)
		
		If Found()
			mVend:= C5_VEND1
			mRespcob:=C5_RESPCOB
		Endif
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Verifica se a assinatura esta ativa                          �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		
		If MV_PAR15 == 2  .AND. !EMPTY(SC6->C6_PEDREN)
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
		
		If MV_PAR15 == 1 .or. MV_PAR15 == 2
			DbSelectArea ("SZJ")
			DbGoTop()
			
			IF SUBSTR(MV_PAR01,1,4) >= '1000' .AND. SUBSTR(MV_PAR02,1,4) <= '1105'
				mCodRev := '9999'
			ENDIF
			
			DbSeek(xFilial("SZJ")+mCodRev+Str(MEDVENC,4))
			If MV_PAR15 == 2
				If SZJ->ZJ_DTCIRC < MV_PAR03 .OR. SZJ->ZJ_DTCIRC > MV_PAR04
					DbSelectArea("SC6")
					DbSkip()
					Loop
				Endif
			Endif
			If MV_PAR15 == 1
				If SZJ->ZJ_DTCIRC < DATE()
					DbSelectArea("SC6")
					DbSkip()
					Loop
				Endif
			Endif
			
			If Subs(SC6->C6_PRODUTO,5,3) == '001'
				DbSelectArea("SC6")
				DbSkip()
				Loop
			Endif
		Endif
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Verifica o registro faz parte do cad de representante        �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		
		If MV_PAR18 == 2
			DbSelectArea("SZL")
			DbGoTop()
			DbSeek(xFilial("SZL")+MCODCLI)
			
			If Found()
				DbSelectArea("SC6")
				DbSkip()
				Loop
			Endif
		Endif
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Elimina duplicidade por codigo de cliente e destinat쟲io     �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		
		If MV_PAR10 == 1
			DbSelectArea(cArq)
			DbGoTop()
			DbSeek(mCodCli+mCodDest)
			If Found()
				DbSelectArea("SC6")
				DbSkip()
				Loop
			Endif
		Endif
		
		DbSelectArea("SF4")
		DbSetOrder(1)
		DbGoTop()
		DbSeek(xFilial("SF4")+SC6->C6_TES)
		If SF4->F4_DUPLIC == 'N'
			IF 'CORTESIA' $(SF4->F4_TEXTO).OR.'DOACAO' $(SF4->F4_TEXTO)
				mGrat:='S'
			Endif
		EndIf
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Verifica se � cortesia para par긩etro=pago                   �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		
		If MV_PAR07 == 1 .And. mGrat == 'S'
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Verifica se � pago para par긩etro=cortesia                   �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		
		
		If MV_PAR07 == 2 .AND. mGrat <> 'S'
			DbSelectArea("SC6")
			DbSkip()
			Loop
		Endif
		
		DbSelectArea("SE1")
		DbGoTop()
		DbSeek(xFilial("SE1")+mPedido)
		
		If Found()
			
			MDTPG := SE1->E1_BAIXA
			
			Do While ( SE1->E1_PEDIDO == MPEDIDO ) .And. !Eof()
				
				mParc := mParc+1
				mDTPG2:= SE1->E1_BAIXA
				
				If DTOC(MDTPG2) <> "  /  /  ".And.SE1->E1_SALDO == 0;
					.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,2) <> 'LP';
					.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,4) <> 'CANC'
					mPago:=mPago+1
				Else
					If SE1->E1_VENCTO+30 < DATE()
						mAberto:=mAberto+1
					Endif
				Endif
				
				DbSkip()
				
			Enddo
			
			mPGTO:=mPAGO/mPARC
		Else
			mAberto:=99999
		Endif
		
		DbSelectArea("SC6")
		If SUBS(SC6->C6_CF,2,2) == "99"
			mAberto:=0
		Endif
		
		If MV_PAR08 == 1
			If mAberto <> 0
				DbSkip()
				Loop
			Endif
		Endif
		If MV_PAR08 == 2
			If mAberto == 0
				DbSkip()
				Loop
			Endif
		Endif
		
		#IFNDEF WINDOWS
			Grava()
		#ELSE
			GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>                       Execute(GRAVA)
		#ENDIF
		
		DbSelectArea("SC6")
		
		If EOF()
			Exit
		Else
			DbSkip()
		Endif
		
	End
	
	DbSelectArea("SA1")
	DbSkip()
End
Return

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿣ALIDPERG � Autor �  Luiz Carlos Vieira   � Data � 16/07/97 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Verifica as perguntas inclu죒do-as caso n꼘 existam        낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Espec죉ico para clientes Microsiga                         낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _ValidPerg
Static Function _ValidPerg()

_sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg := PADR(cPerg,6)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

AADD(aRegs,{cPerg,"01","Do Produdo.........:","mv_ch1","C",15,0,0,"G","","mv_par01","","0108001","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"02","At� o Produto......:","mv_ch2","C",15,0,0,"G","","mv_par02","","0108003","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"03","Faturados/Venc de..:","mv_ch3","D",08,0,0,"G","","mv_par03","","'01/06/99'","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Faturados/Venc at�.:","mv_ch4","D",08,0,0,"G","","mv_par04","","'17/04/00'","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Do CEP.............:","mv_ch5","C",08,0,0,"G","","mv_par05","","12000000","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"06","At� CEP............:","mv_ch6","C",08,0,0,"G","","mv_par06","","12999999","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"07","Tipo...............:","mv_ch7","C",01,0,3,"C","","mv_par07","Pagos","","","Cortesias","","","Ambas","","","","","","","",""})
AADD(aRegs,{cPerg,"08","Situa눯o...........:","mv_ch8","C",01,0,3,"C","","mv_par08","Baixados","","","Em aberto","","","Ambas","","","","","","","",""})
AADD(aRegs,{cPerg,"09","Qtde da Selecao....:","mv_ch9","N",07,0,3,"G","","mv_par09","","9999999","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"10","Elimina duplicidade:","mv_chA","C",01,0,1,"C","","mv_par10","Sim","ZZZZZZZ","","Nao","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"11","Cod. Promo눯o......:","mv_chB","C",03,0,1,"G","","mv_par11","","N","","","","","","","","","","","","","SZA"})
AADD(aRegs,{cPerg,"12","Cod. Mailing.......:","mv_chC","C",03,0,1,"G","","mv_par12","","107","","","","","","","","","","","","","91"})
AADD(aRegs,{cPerg,"13","Da Atividade.......:","mv_chD","C",07,0,0,"G","","mv_par13","","","","","","","","","","","","","","","ZZ8"})
AADD(aRegs,{cPerg,"14","At� Atividade......:","mv_chE","C",07,0,0,"G","","mv_par14","","ZZZZZZZ","","","","","","","","","","","","","ZZ8"})
AADD(aRegs,{cPerg,"15","Tipo Cliente.......:","mv_chF","C",01,0,3,"C","","mv_par15","Ass. Ativos","","","Ass. Cancelados","","","Outros","","","","","","","",""})
AADD(aRegs,{cPerg,"16","Utilizacao.........:","mv_chG","C",01,0,1,"C","","mv_par16","Mala Direta","","","Telemarketing","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"17","Processa por.......:","mv_chH","C",01,0,1,"C","","mv_par17","Clientes","","","Produtos","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"18","Inclui Representante:","mv_chI","C",01,0,1,"C","","mv_par18","Sim","","","N�o","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"19","Natureza do Cliente:","mv_chj","C",01,0,1,"C","","mv_par19","Fisica","","","Juridica","","","Ambas","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		SX1->(MsUnlock())
	Endif
Next

DbSelectArea(_sAlias)

Return
