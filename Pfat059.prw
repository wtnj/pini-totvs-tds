#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFDEF WINDOWS
	#DEFINE SAY PSAY
#ENDIF

User Function Pfat059()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("_ACAMPOS,_CNOME,_CNOME2,CCABEC1,CCABEC2,NCARACTER")
SetPrvt("ARETURN,CPROGRAMA,NLASTKEY,M_PAG,LCONTINUA,L")
SetPrvt("CBTXT,CBCONT,NORDEM,ALFA,Z,M,MHORA")
SetPrvt("TAMANHO,TITULO,CTITULO,CDESC1,CDESC2,CDESC3")
SetPrvt("CPERG,CINDEX,CKEY,MIND,MCONTA,MCONTA1")
SetPrvt("MCONTA2,MCONTA3,MQTDE,MVALOR,MPEDIDO,MITEM")
SetPrvt("MPRODUTO,MCODCLI,MCODDEST,MMAILING,MPROMOCAO,MCF")
SetPrvt("MCEP,MCIDADE,MBAIRRO,MEST,MVEND,MTOTAL")
SetPrvt("MQTVEN,MMUN,CSTRING,CSTRING1,WNREL,_CSTRING,_CSTRING1")

//#IFDEF WINDOWS
//    #DEFINE SAY PSAY
//#ENDIF
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: PFAT059   쿌utor: Raquel Farias          � Data:   13/07/99 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escricao : Conta retorno da promocao                                 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so       : Modulo de Faturamento                                     � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿌lteracoes:                                                           � 굇
굇�25.11.99 - Cristina - TI1262 Comandos de tela, para serem rodadas     � 굇
굇�                             em ambiente Windows.                     � 굇
굇�22.12.99 - Raquel Farias     Testes e adaptacoes da Cristina p/ambien-� 굇
굇�                             te Windows.                              � 굇
굇�02.02.99 - Andreia  - TI0721 Termino da conversao para windows (botoes� 굇
굇�                             de acesso, parametros, filtros, etc.)    � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Cod. da Promocao                     �
//� mv_par02             // Cod. do Mailing                      �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Inicializa array para montagem do arquivo de trabalho        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
_aCampos := {  {"NUMPED"  ,"C",6, 0} ,;
{"ITEM"    ,"C",2, 0} ,;
{"CF "     ,"C",3 ,0} ,;
{"VEND"    ,"C",6 ,0} ,;
{"CODCLI"  ,"C",6, 0} ,;
{"CODDEST" ,"C",6, 0} ,;
{"CODPROD" ,"C",15,0} ,;
{"MAILING" ,"C",3, 0} ,;
{"PROMOCAO","C",3 ,0} ,;
{"QTDE"    ,"N",10 ,0} ,;
{"VALOR"   ,"N",10,2} ,;
{"CEP"     ,"C",8 ,0} ,;
{"BAIRRO"  ,"C",20 ,0},;
{"CIDADE"  ,"C",20 ,0},;
{"ESTADO"  ,"C",2 ,0}}

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Cria arq.trabalho e coloca o mesmo em uso.                   �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PFAT59",.F.,.F.)

_aCampos := {  {"CODIGO"  ,"C", 03, 0 } ,;
{"QTDPED"  ,"N", 06, 0 } ,;
{"VLTPED"  ,"N", 10, 2 } ,;
{"QTDFAT"  ,"N", 06, 0 } ,;
{"VLTFAT"  ,"N", 10, 2 },;
{"QTNFAT"  ,"N", 06, 0 } }

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Cria arq.trabalho e coloca o mesmo em uso.                   �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
_cNome2 := CriaTrab( _aCampos, .T. )
dbUseArea( .T., , _cNome2, "TRB", .F., .F. )

dbSelectArea("PFAT59")

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Inicializa variaveis de controle para o relatorio.(SETPRINT)�
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
cCabec1   :=""
cCabec2   :=""
nCaracter :=10
aReturn   :={ "Especial", 1,"Administracao", 1, 2, 1,"",1 }
cPrograma :="PFAT059"
nLastKey  :=0
m_pag     :=1
lContinua :=.T.
L         :=0
CbTxt     :=""
CbCont    :=""
nOrdem    :=0
Alfa      :=0
Z         :=0
M         :=0
tamanho   :="P"
titulo    :=PADC("Retorno por Mailing" ,74)
cTitulo   := ' **** Retorno por Mailing **** '
cDesc1    :=PADC("Retorno por mailing" ,74)
cDesc2    :=PADC("Grava pedidos faturados",74)
cDesc3    :=""
lContinua := .T.
cPerg     :="PFAT25"
MHORA     :=TIME()
cArqPath  :=GetMv("MV_PATHTMP")
cString   :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,4,2)

_cString  :=cArqPath+cString+".DBF"

cString1   :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
_cString1  :=cArqPath+cString1+".DBF"

If !Pergunte(cPerg)
	Return
Endif

If LastKey()== 27
	Return
Endif

OkProc()
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: OkProc    쿌utor: Raquel Farias          � Data:   13/07/99 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escricao : Cria indices temporarios SC5/SD2                          � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so       : Modulo de Faturamento                                     � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿌lteracoes:                                                           � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

Static Function OkProc()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Cria indice temporario para o SC5 - Chave ( FILIAL + CODPROM)�
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
dbSelectArea("SC5")
cIndex:=CriaTrab(Nil,.F.)
cKey:="C5_FILIAL+C5_CODPROM"

MsAguarde({|| IndRegua("SC5",cIndex,ckey,,,)},"Aguarde","Selecionando registros ...")

Retindex("SC5")
mInd:=Retindex('SC5')
// dbSetIndex(cIndex+OrdBagExt())
dbSetOrder(mInd+1)
dbGoTop()

Processa({|| Executa()})
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: Executa   쿌utor: Raquel Farias          � Data:   13/07/99 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escricao : Alimenta arquivo temporario e inicializa impressao.       � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so       : Modulo de Faturamento                                     � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿌lteracoes:                                                           � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function Executa
Static Function Executa()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Inicializa variaveis para controle da funcao Executa()       �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
mConta   :=0
mConta1  :=0
mConta2  :=0
mConta3  :=0
mQtde    :=0
mValor   :=0
mPedido  :=""
mItem    :=""
mProduto :=""
mCodCli  :=""
mCodDest :=""
mMailing :=""
mPromocao:=""
mCF      :=""
mCEP     :=""
mCidade  :=""
mBairro  :=""
mEst     :=""
mVend    :=""
mTotal   :=0
mQtven   :=0
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Pesquisa na tabela SC5 parametro MV_PAR01 referente ao SX1   �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
dbSelectArea("SC5")
dbGoTop()
dbSeek(xFILIAL() + MV_PAR01 )
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Percorre arquivo enquanto a condicao satisfazer o mesmo.     �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

ProcRegua(RecCount())

WHILE !EOF()    

  INCPROC("Gerando arquivos ...")
	IF SC5->C5_CODPROM<>MV_PAR01
		EXIT
	ENDIF
	IF C5_MAILING<>MV_PAR02
		dbSkip()
		Loop
	EndIf
	mPedido  :=C5_NUM
	mCodCli  :=C5_CLIENTE
	mMailing :=C5_MAILING
	mPromocao:=C5_CODPROM
	mVend    :=C5_VEND1
	mConta2  :=mConta2+1
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Pesquisa no indice temporario o numero de pedido no SD2      �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	dbSelectArea('SC6')
	dbGoTop()
	dbSeek( xFILIAL() + mPedido )
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Caso tenha encontrado...                                     �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If Found()
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Percorre arquivo enquanto condicao satisfazer o mesmo        �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		While .T.
			IF SC6->C6_NUM==MPEDIDO
				mQtde   :=SC6->C6_QTDVEN
				mTotal  :=mTotal+SC6->C6_VALOR
				mItem   :=SC6->C6_ITEM
				mProduto:=SC6->C6_PRODUTO
				mCodDest:=SC6->C6_CODDEST
				mValor  :=SC6->C6_VALOR
				mCF     :=SC6->C6_CF
				mQtVen  :=mQtven+mQtde
				
				IF !Empty(SC6->C6_NOTA)
			   		mConta  :=mConta+mQtde   
					mConta3 :=mConta3+mValor
				Else
					mConta1:=mConta1+1
				ENDIF
				//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
				//� Pesquisa Cliente.                                            �
				//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
				dbSelectArea("SA1")
				dbSetOrder(1)
				dbSeek(xFilial()+mCodCli)
				IF Found()
					mBairro:=SA1->A1_BAIRRO
					mCidade:=SA1->A1_MUN
					mEst   :=SA1->A1_EST
					mCep   :=SA1->A1_CEP
				ENDIF
				//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
				//� Caso variavel mCodDest for diferente de ""                   �
				//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
				IF mCodDest#""
					//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
					//� Pesquisa no arquivo SZO                  .                   �
					//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
					dbSelectArea("SZO")
					dbSeek(xFilial()+mCodCli+mCodDest)
					IF Found()
						mBairro :=SZO->ZO_BAIRRO
						mMun    :=SZO->ZO_CIDADE
						mEst    :=SZO->ZO_ESTADO
						mCep    :=SZO->ZO_CEP
					EndIf
				ENDIF
				//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
				//� Seleciona arquivo de trabalho e grava no mesmo.              �
				//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
				dbSelectArea("PFAT59")
				Reclock("PFAT59",.t.)
				replace NUMPED   WITH  mPedido
				replace ITEM     WITH  mItem
				replace CODCLI   WITH  mCodCli
				replace CODDEST  WITH  mCodDest
				replace CODPROD  WITH  mProduto
				replace CF       WITH  mCF
				replace CEP      WITH  mCEP
				replace VALOR    WITH  mValor
				replace BAIRRO   WITH  mBairro
				replace CIDADE   WITH  mCidade
				replace ESTADO   WITH  mEst
				replace QTDE     WITH  mQtde
				replace MAILING  WITH  mMailing
				replace PROMOCAO WITH  mPromocao
				replace VEND     WITH  mVend
				PFAT59->(MsUnLock()) //dbUnlock()
				dbSelectArea('SC6')
				dbSkip()
			Else
				//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
				//� Sai do While.                                                �
				//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
				Exit
			EndIf
		End
	EndIf
	
	dbSelectArea("SC5")
	IF Eof()
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Se for fim de arquivo sai do While.                          �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		Exit
	Else
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//� Se nao for fim de arquivo pula registro                      �
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		dbSkip()
	EndIf
END
dbSelectArea("PFAT59")
dbGoTop()
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Copia arquivo para o diretorio especificado.                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

COPY TO &_cString VIA "DBFCDXADS" // 20121106 
dbSelectArea("TRB")
RecLock("TRB", .T.)
TRB->CODIGO  := MV_PAR02
TRB->QTDPED  := mConta2
TRB->VLTPED  := mTotal
TRB->QTDFAT  := mConta
TRB->VLTFAT  := mConta3
TRB->QTNFAT  := mConta1
trb->(msUnlock())

COPY TO &_CSTRING1 VIA "DBFCDXADS" // 20121106 

cMsg := 'Arquivos gerados com sucesso:  ' +_cString + '  e  ' +_cString1
msgAlert (cmsg)
dbSelectArea("TRB")
dbCloseArea()
fErase(_cNome2+".DBF")

cString:='SD1'

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Inicializa janela de impressao.                              �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
wnrel  := 'PFAT059_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
wnrel  := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)

If nLastKey == 27
	dbSelectArea("PFAT59")
	PFAT59->(dbCloseArea())
	FErase(_cNome+".DBF")
	Return
Endif

SetDefault(aReturn,cString)

IF L>60
	L:=0
ENDIF
IF L==0
	L:=L+1
	Cabec(cTitulo,cCabec1,cCabec2,cPrograma,tamanho,nCaracter)
	L:=4
	//	@ L+1,00 pSAY REPLICATE('*',79)
	L:=6
ENDIF
@ L+02,10 pSAY  'Cod. Promocao...............: ' +MV_PAR01
@ L+03,10 pSAY  'Cod. Mailing  ..............: ' +MV_PAR02

@ L+05,10 PSAY  'Numero de Pedidos...........: ' +Transform(mConta2,"@E 9,999,999,999")
@ L+06,10 PSAY  'Qtde dos Itens..............: ' +Transform(mQtven,"@E 9,999,999,999")
@ L+07,10 PSAY  'Vl Total dos Pedidos........: ' +Transform(mTotal,"@E 99,999,999.99")

@ L+09,10 PSAY  'Numero de Pedidos Faturados.: ' +Transform((mConta2-mConta1),"@E 9,999,999,999")
@ L+10,10 PSAY  'Qtde dos Itens Faturados....: ' +Transform(mConta,"@E 9,999,999,999")
@ L+11,10 PSAY  'Valor Faturado..............: ' +Transform(mConta3,"@E 99,999,999.99")

@ L+13,10 PSAY  'No. de Pedidos nao Faturados: ' +Transform(mConta1,"@E 9,999,999,999")
@ L+14,10 PSAY  'Qtde dos Itens nao Faturados: ' +Transform((mQtven-mConta),"@E 9,999,999,999")
@ L+15,10 PSAY  'Valor nao Faturado..........: ' +Transform((mTotal-mConta3),"@E 99,999,999.99")

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Termino do Relatorio                                         �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Set Device To Screen
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF
MS_FLUSH()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Fecha arquivo temporario e deleta.                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
dbSelectArea("PFAT59")
PFAT59->(dbCloseArea())
FErase(_cNome+".DBF")

dbSelectArea("SA1")
Retindex("SA1")

dbSelectArea("SC5")
Retindex("SC5")

dbSelectArea("SC6")
Retindex("SC6")

dbSelectArea("SZO")
Retindex("SZO")

dbSelectArea("SD2")
Retindex("SD2")

Return
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma:CloseWindow쿌utor: Raquel Farias          � Data:   13/07/99 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escricao : Fecha/Deleta aquivo temporario .                          � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so       : Modulo de Faturamento                                     � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿌lteracoes:                                                           � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function CloseWindow
Static Function CloseWindow()
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Fecha arquivo temporario e deleta.                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
dbSelectArea("PFAT59")
PFAT59->(dbCloseArea())
FErase(_cNome+".DBF")

Return ( .T. )
