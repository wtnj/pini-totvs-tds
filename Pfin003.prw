#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
/*/ Alterado por Danilo C S Pala em 20041014 : 930
//Danilo C S Pala 20060327: dados de enderecamento do DNE
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa : COBR     �Autor: Solange Nalini         � Data:   26/04/99 � ��
������������������������������������������������������������������������Ĵ ��
���Descricao: Cartas de Cobranca - Editora Pini                          � ��
������������������������������������������������������������������������Ĵ ��
���Alteracoes: 11.02.00 Conversao para Windows. Regularizacao de nao-con-� ��
���                     formidades conf.OS desta data. Andreia Silva.    � ��
���            14.02.00 Disponibilizacao do pgm para versao Dos - ADS.   � ��
���                     Andreia Silva                                    � ��
���            16.02.00 Testes e Validacoes para processamento na  versao� ��
���                     Windows - ADS. Andreia Silva                     � ��
���            23.02.00 Verificacao da criacao de indices, bem como mudan� ��
���                     cas no Filtro. Andreia Silva                     � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : Especifico para Editora Pini - Modulo Financeiro           � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function Pfin003()

SetPrvt("TITULO,CDESC1,CTITULO,NCARACTER,TAMANHO,LIMITE")
SetPrvt("ARETURN,CPROGRAMA,CPERG,_ACAMPOS,_CARQ,MTAXA")
SetPrvt("M_PAG,LCONTINUA,WNREL,L,CDESC2,CDESC3")
SetPrvt("CSTRING,NLASTKEY,CINDEX,CKEY,_CFILTRO,MNCODPORT")
SetPrvt("MNOME,MEND,MBAIRRO,MCIDADE,MCEP,MESTADO")
SetPrvt("MAVISO,MREGPOS,MCODCLI,MPEDIDO,MPRODUTO,MDUPL")
SetPrvt("MPARCELA,MVENCTO,MNVENCTO,MDIAS,MVALOR,MJUROS")
SetPrvt("MNVALOR,MCODDEST,MDEST,MTOTAL,MDUPLICATAS,")
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Vencidos At�                         �
//� mv_par02             // Do Portador                          �
//� mv_par03             // At� o Portador                       �
//����������������������������������������������������������������
titulo     := PADC("Extrato de Conta Corrente de Cliente  ",74)
cDesc1     := PADC("Este programa emite extrato de conta corrente de cliente",74)
cTitulo    := ' **** Extrato de Conta Corrente  **** '
nCaracter  := 12
tamanho    := "M"
limite     := 132
aReturn    := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
cprograma  := "COBR"
cPerg      := 'FAT019'

If !PERGUNTE(cPerg)
	Return
Endif

_aCampos  := { 	{"CODCLI"    ,"C",6 ,0},;
				{"CODDEST"   ,"C",6 ,0},;
				{"DUPL"      ,"C",6 ,0},;
				{"PARCELA"   ,"C",1 ,0},;
				{"VENCTO"    ,"D",8 ,0},;
				{"NVENCTO"   ,"D",8 ,0},;
				{"VALOR"     ,"N",10,2},;
				{"NVALOR"    ,"N",10,2},;
				{"PEDIDO"    ,"C",6 ,0},;
				{"NOMEDEST"  ,"C",40,0},;
				{"NOMECLI"   ,"C",40,0},;
				{"V_END"     ,"C",120,0},;
				{"BAIRRO"    ,"C",20,0},;
				{"CIDADE"    ,"C",20,0},;
				{"ESTADO"    ,"C",2 ,0},;
				{"CEP"       ,"C",8 ,0},;
				{"AVISO"     ,"C",9 ,0},;
				{"TPPROD"    ,"C",2 ,0}}

// Alterado em 07/07/00 por RC
//dbCreate("VERCOBR",_aCampos,__LocalDriver)

_cArq   := CriaTrab(_aCampos, .T.)
dbUseArea( .T., , _cArq, "TRB", .F., .F.)
_cArq   := "VERCOBR"

Copy to &_cArq

dbCloseArea()

dbUseArea( .T., , _cArq, "TRB", .F., .F.)

mtaxa     := 0.12
M_PAG     := 1
lContinua := .T.
wnrel     := "COBRANCA"
L         := 0
cDesc2    := " "
cDesc3    := " "

//�������������������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas.                                     �
//���������������������������������������������������������������������������
cString  := "SE1"
nLastKey := 0

//��������������������������������������������������������������Ŀ
//� Envia controle para a funcao SETPRINT                        �
//����������������������������������������������������������������
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)

If nLastKey == 27
	Return
Endif

//��������������������������������������������������������������Ŀ
//� Verifica Posicao do Formulario na Impressora                 �
//����������������������������������������������������������������
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

Processa({|| ProcCC()})

Return
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa : PROCC    �Autor: Solange Nalini         � Data:   26/04/99 � ��
������������������������������������������������������������������������Ĵ ��
���Descricao: Processa Cartas de Cobranca                                � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : Especifico para Editora Pini - Modulo Financeiro           � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ProcCC()
//��������������������������������������������������������������Ŀ
//� Inicio do Processamento                                      �
//����������������������������������������������������������������

dbSelectArea("SE1")

cIndex:=CriaTrab(Nil,.F.)
cKey:="DTOS(E1_VENCREA)+E1_NUM"

_cFiltro := 'E1_FILIAL == "'+ xFilial("SE1")+'"'
_cFiltro := _cFiltro + '.And. E1_SALDO > 0 .AND. E1_TIPO == "NF "'
_cFiltro := _cFiltro + '.And. E1_DIVVEN <> "PUBL"'
_cFiltro := _cFiltro + '.And. !E1_SERIE $"LIV/CP0"'

MsAguarde({|| Indregua("SE1",cIndex,ckey,,_cFiltro,"Selecionando Registros do Arq")},"Aguarde", "Gerando Indice Temporario...",.t.)

//��������������������������������������������������������������Ŀ
//�  Prepara regua de impress�o                                  �
//����������������������������������������������������������������
ProcRegua(Reccount())

mnCodPort := " "
mnome     := " "
mend      := " "
mbairro   := " "
mcidade   := " "
mcep      := " "
mestado   := " "

DbSelectArea("SE1")
ProcRegua(RecCount())
dbGoTop()
While !EOF() .and. DTOS(SE1->E1_VENCREA) <= DTOS(MV_PAR01)
	IncProc("Titulo "+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)
	IF SM0->M0_CODIGO # '01'
		DBSKIP()
		LOOP
	ENDIF
	
	If SE1->E1_CODPORT < MV_PAR02 .OR. SE1->E1_CODPORT > MV_PAR03
		dbSkip()
		Loop
	EndIf
	
	If 'P' $(SE1->E1_PEDIDO) .OR. 'LUCROS E PERDAS' $(SE1->E1_HIST) .OR.;
		'NF CANCELADA' $(SE1->E1_HIST) .OR. 'CAN' $(SE1->E1_MOTIVO)
		dbSkip()
		Loop
	EndIf
	
	IF DTOS(SE1->E1_DTCARTA) <> "        "  .AND. Dtos(dDataBase) < dtos(SE1->E1_DTCARTA + 5)
		dbSkip()
		Loop
	EndIf
	
	IF SE1->E1_PORTADO == "920" .Or. SE1->E1_PORTADO == "930" .Or. SE1->E1_PORTADO == "904" .OR. SE1->E1_CODPORT == "905" .Or. Dtos(SE1->E1_PGPROG) <> "        " .Or.;
		SE1->E1_CODPORT == "995" .Or. SE1->E1_CODPORT == "XX1" .Or. SE1->E1_CODPORT == "XX2" //20041014
		dbSkip()
		Loop
	ENDIF
	
	IF Alltrim(SE1->E1_CODPORT) == "XX5" .Or. Alltrim(SE1->E1_CODPORT) == "CAR" .Or. Alltrim(SE1->E1_CODPORT) == "425" .Or.;
		Alltrim(SE1->E1_CODPORT) == "904"
		dbSkip()
		Loop
	ENDIF
	
	IF SE1->E1_CODPORT=='992' .AND. (SE1->E1_GRPROD=='0200' .OR. SE1->E1_GRPROD=='0700')
		dbSkip()
		Loop
	ENDIF
	
	Do Case
		CASE SE1->E1_CODPORT == '992'
			mAviso     := ' '
			mnCodPort  := '992'
		CASE SE1->E1_CODPORT == '991'
			mAviso     := '2o.AVISO'
			mnCodPort  := '992'
		OTHERWISE
			mnCodPort  := '991'
			mAviso     := '1o.AVISO'
	EndCase
	
	mRegPos  := RecNo()
	mCodCli  := SE1->E1_CLIENTE
	mPedido  := SE1->E1_PEDIDO
	mproduto := SE1->E1_GRPROD // E1_TPPROD
	mdupl    := SE1->E1_NUM
	mparcela := SE1->E1_PARCELA
	mvencto  := SE1->E1_VENCREA
	mnvencto := dDataBase+7
	mdias    := mnvencto - mvencto
	mValor   := SE1->E1_VALOR
	mJuros   := (SE1->E1_VALOR*(mtaxa/100))*mdias
	mNvalor  := SE1->E1_VALOR+mjuros
	
	dbSelectArea("SC6")
	dbSeek(xFilial("SC6")+mpedido)
	If Found()
		mCodDest := SC6->C6_CODDEST
	Else
		mCodDest := '  '
	EndIf
	
	dbSelectArea("SA1")
	dbseek(xFilial("SA1")+mcodcli)
	If Found()
		mnome     := SA1->A1_NOME
		mend      := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060327
		mbairro   := SA1->A1_BAIRRO
		mcidade   := SA1->A1_MUN
		mcep      := SA1->A1_CEP
		mestado   := SA1->A1_EST
	EndIf
	mDest := ' '
	IF Val(mCodDest) <> 0
		dbSelectArea("SZN")
		If dbSeek(XFILIAL("SZN")+MCODCLI+MCODDEST, .F.)
			MDEST := SZN->ZN_NOME
		ENDIF
		dbSelectArea("SZO")
		If DBSEEK(XFILIAL("SZO")+MCODCLI+MCODDEST, .F.)
			mend    := ALLTRIM(SZO->ZO_TPLOG) + " " + ALLTRIM(SZO->ZO_LOGR) + " " + ALLTRIM(SZO->ZO_NLOGR) + " " + ALLTRIM(SZO->ZO_COMPL) //20060327
			mbairro := SZO->ZO_BAIRRO
			mcidade := SZO->ZO_CIDADE
			mcep    := SZO->ZO_CEP
			mestado := SZO->ZO_ESTADO
		ENDIF
	ENDIF
	
	IF MAVISO <> ' '
		Grava_Cobr()
	ENDIF
	
	dbSelectArea("SE1")
	RecLock("SE1",.F.)
	SE1->E1_CODPORT  := mnCodPort
	SE1->E1_DTCARTA  := dDataBase
	MsUnLock()
	
	dbSelectArea("SE1")
	dbSkip()
End

dbSelectArea("TRB")
DbGotop()

EXTRATO()

SET DEVICE TO SCREEN
dbclosearea()

IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF
MS_FLUSH()

dbSelectArea("SE1")
RETINDEX()

dbSelectArea("SA1")
RETINDEX()

Return

Static Function Grava_Cobr()
dbSelectArea("TRB")
RecLock("TRB",.T.)
TRB->CODCLI   := mCodCli
TRB->PEDIDO   := mPedido
TRB->TPPROD   := mproduto
TRB->DUPL     := mdupl
TRB->PARCELA  := mparcela
TRB->VENCTO   := mvencto
TRB->NVENCTO  := mnvencto
TRB->VALOR    := mValor
TRB->NVALOR   := mnValor
TRB->CODDEST  := MCODDEST
TRB->NOMEDEST := MDEST
TRB->NOMECLI  := MNOME
TRB->V_END    := MEND
TRB->BAIRRO   := MBAIRRO
TRB->CIDADE   := MCIDADE
TRB->ESTADO   := MESTADO
TRB->CEP      := MCEP
TRB->AVISO    := MAVISO
MsUnLock()
Return

Static Function EXTRATO()
mTotal   := 0
l:=0
dbSelectArea("TRB")
//   cIndex:=CriaTrab(Nil,.F.) Alt.07/07/00 By RC
cKey:="TPPROD+CEP+CODCLI+DUPL+PARCELA+DTOS(VENCTO)"
Indregua("TRB",_cArq, cKey,,,"Aguarde....Criando indice")
dbGoTop()

While !Eof()
	If l == 0
		@ l,00   PSAY "EDITORA PINI LTDA"
		@ L,62   PSAY 'CONTAS A RECEBER'
		@ L+1,00 PSAY 'EMISSAO:'+DTOC(dDataBase)
		@ L+1,62 PSAY AVISO
		@ L+3,26 PSAY 'EXTRATO DE CONTA CORRENTE'
		L:=L+5
	Endif
	
	@ L,00   PSAY 'COD.CLIENTE...: ' + codcli + ' ' +nomecli
	@ L+1,00 PSAY 'DESTINATARIO..: ' + nomedest
	@ L+2,00 PSAY 'ENDERECO .....: ' + ALLTRIM(V_END)
	@ L+3,00 PSAY 'BAIRRO........: ' + BAIRRO
	@ L+4,00 PSAY 'CEP/CIDADE/EST: ' + SUBSTR(CEP,1,5)+'-'+SUBSTR(CEP,6,3)+' ' +CIDADE+' '+ESTADO
	L:=L+6
	
	@ L,00 PSAY   'PRODUTO/SERVICO'
	@ L+1,00 PSAY '==============='
	L:=L+3
	MPEDIDO:=PEDIDO
	dbSelectArea("SC6")
	DBSEEK(xFilial("SC6") + mPedido )
	While !EOF() .And. SC6->C6_NUM==mPEDIDO
		IF SUBS(SC6->C6_PRODUTO,1,2)=='99' .OR. SC6->C6_TES=='650' .OR. SC6->C6_TES=='651'
			dbSkip()
			Loop
		ENDIF
		DO CASE
			CASE SUBS(SC6->C6_PRODUTO,1,2)=='01'
				@  L,00 PSAY 'REVISTA...: ' + SC6->C6_DESCRI
			CASE SUBS(SC6->C6_PRODUTO,1,2)=='02'
				@ L,00 PSAY 'LIVRO......: ' + SC6->C6_DESCRI
			CASE SUBS(SC6->C6_PRODUTO,1,2)=='07'
				@ L,00 PSAY 'VIDEO/CDROM: ' + SC6->C6_DESCRI
			OTHERWISE
				@ L,00 PSAY SC6->C6_DESCRI
		ENDCASE
    	DbSelectArea("SC6")
		DbSkip()

		IF L>60
			L:=0
		ELSE
			L:=L+1
		ENDIF
	ENDDO
	
	L:=25
	MDUPLICATAS := SPACE(1)
	@ L,000 PSAY 'DUPLICATA'
	@ L,012 PSAY ' VENCTO'
	@ L,027 PSAY 'VLR ORIGINAL'
	@ L,047 PSAY 'NOVO VENCTO'
	@ L,062 PSAY 'VLR ATUALIZADO'
	@ L+1,000 PSAY '========='
	@ L+1,012 PSAY '========'
	@ L+1,027 PSAY '============'
	@ L+1,047 PSAY '==========='
	@ L+1,062 PSAY '=============='
	L += 2
	
	dbSelectArea("TRB")
	WHILE !Eof() .And. mPedido == Pedido
		@ L,000 PSAY DUPL+' '+PARCELA
		@ L,012 PSAY VENCTO
		@ L,029 PSAY Round(VALOR,2)
		@ L,048 PSAY NVENCTO
		@ L,066 PSAY Round(NVALOR,2)
		
		mDuplicatas += ' ' + DUPL+' '+PARCELA
		dbSkip()
		
		IF L>60
			L:=0
		ELSE
			L:=L+1
		ENDIF
		DbselectArea("TRB")
		DbSkip()
	END
	
	L:=40
	@ L,00 PSAY 'DESTAQUE E ENCAMINHE A EDITORA PINI LTDA - COBRANCA - R ANHAIA, 964'
	@ L+1,00 PSAY 'CAPITAL/SP   CEP 01130-900'
	@ L+2,00 PSAY REPLICATE('-',80)
	@ L+4,00 PSAY ' [ ]  EM ANEXO SEGUE O COMPROVANTE DE PAGAMENTO DA(S) DUPLICATA(S) ABAIXO:'
	@ L+6,00 PSAY ' [ ]  EM ANEXO SEGUE O CHEQUE NO............., DO BANCO ............, NO'
	@ L+7,00 PSAY '      VALOR ATUALIZADO INFORMADO PARA PAGAMENTO DA(S) DUPLICATAS ABAIXO:'
	@ L+9,00 PSAY '      DUPLICATA(S): ' +MDUPLICATAS
	
	L:=0
	dbSelectArea("TRB")
	DbSkip()
End
Return