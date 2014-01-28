#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF

User Function Pfat107()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Declaracao de variaveis utilizadas no programa atraves da funcao    Ё
//Ё SetPrvt, que criara somente as variaveis definidas pelo usuario,    Ё
//Ё identificando as variaveis publicas do sistema utilizadas no codigo Ё
//Ё Incluido pelo assistente de conversao do AP5 IDE                    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

SetPrvt("ARETURN,CPROGRAMA,CSTRING,NLASTKEY,WNREL,L,MIDENT")
SetPrvt("NORDEM,TAMANHO,NCARACTER,LCONTINUA,CDESC1,CDESC2")
SetPrvt("CDESC3,CTITULO,CCABEC1,CCABEC2,CARQ,M_PAG")
SetPrvt("MCONTA4,MHORA,CARQPATH,_CSTRING,CPERG,MSAIDA")
SetPrvt("TITULO,MV_PAR01,_ACAMPOS,_CNOME,LEND,BBLOCO")
SetPrvt("MCEPINI,CINDEX,CKEY,MCONTA3,MCHAVE1,MCHAVE2")
SetPrvt("CMSG,MVALIDA,MIND3,CCHAVE,CFILTRO1,CFILTRO2")
SetPrvt("CFILTRO3,CFILTRO4,CFILTRO,CIND,MCONTA,MCONTA1")
SetPrvt("MCONTA2,MORIGEM,MCODCLI,MNOMECLI,MEND,MBAIRRO")
SetPrvt("MMUN,MEST,MCEP,MFAX,MEMAIL,MCOMPL,CLIMITE")
SetPrvt("MDDD,MDDD2,MDDD3,MDDD4,MDDD5,MDDD6")
SetPrvt("MFONE,MFONE2,MFONE3,MFONE4,MFONE5,MFONE6")
SetPrvt("MCGC,MCONTATO,MCODDEST,MNOMEDEST,MTIPO,MUTILIZA")
SetPrvt("MDTUTIL,MCODCON,LIN,COL,LI,CINDEX,CINDEX1,MCONTA5,MCORIGEM,mhora")

#IFNDEF WINDOWS
	// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     #DEFINE PSAY SAY
#ENDIF
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддддддддддддбддддддддддддддддддддддддддддддбдддддддддддддддддд© ╠╠
╠╠ЁPrograma: PFAT107   ЁAutor: Raquel Farias          Ё Data:   13/01/00 Ё ╠╠
╠╠цддддддддддддддддддддаддддддддддддддддддддддддддддддадддддддддддддддддд╢ ╠╠
╠╠ЁDescri┤ao: Gera arquivo de prospcts (arq/etiqueta/rel/contagem)       Ё ╠╠
╠╠цдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢ ╠╠
╠╠ЁUso      : M╒dulo de Faturamento                                      Ё ╠╠
╠╠юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды ╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis utilizadas para parametros                         Ё
//Ё mv_par01             // Origem Inicial     C-3               Ё
//Ё mv_par02             // Origem Final       C-3               Ё
//Ё mv_par03             // Cep Inicial        C-8               Ё
//Ё mv_par04             // Cep Final          C-8               Ё
//Ё mv_par05             // Da Cargo           C-3               Ё
//Ё mv_par06             // At┌ Cargo          C-3               Ё
//Ё mv_par07             // Contagem Arquivo Etiqueta Relat╒rio  Ё
//Ё mv_par08             // Sim Nфo                              Ё
//Ё mv_par09             // qtde de registros selecionados       Ё
//Ё mv_par10             // Televendas Mala Direta               Ё
//Ё mv_par11             // Data da sele┤ao                      Ё
//Ё mv_par12             // Cod. Promocao                        Ё
//Ё mv_par13             // Cod. Mailing                         Ё
//Ё mv_par14             // Da  Atividade                        Ё
//Ё mv_par15             // Ate Atividade                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

aReturn   :={ "Especial", 1,"Administra┤фo", 1, 2, 1,"",1 }
cPrograma :="PFAT107"
cString   :="PFAT107"
nLastKey  :=0
MHORA      := TIME()
wnrel     :="PFAT107_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
L         :=0
nOrdem    :=0
CLIMITE = 132
tamanho   :="G"
nCaracter :=10
lContinua :=.T.
cDesc1    :=""
cDesc2    :=""
cDesc3    :=""
cTitulo   :=""
cCabec1   :=""
cCabec2   :=""
carq      :=""
M_PAG     :=1
MCONTA4   :=0
MCONTA2   :=0
MCONTA5   :=0
MHORA     :=TIME()
cArq      :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString   :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cArqPath  :=GetMv("MV_PATHTMP")
_cString  :=cArqPath+cString+".DBF"

cPerg :="PFAT54"

If !Pergunte(cPerg)
	Return
Endif

IF Lastkey()==27
	Return
Endif

IF MV_PAR07<>1 .AND. ALLTRIM(MV_PAR12)<>'N'
	DbSelectArea("ZZ7")
	DbSeek(xfilial()+MV_PAR12+MV_PAR13+STR(MV_PAR07,1))
	If Found()
		#IFDEF WINDOWS
			MsgStop("C╒digo j═ utilizado, informe c╒digo v═lido ou solicite manutencao no cad. Mailing")
		#ELSE
			Alert("C╒digo j═ utilizado, informe c╒digo v═lido ou solicite manutencao no cad. Mailing")
		#ENDIF
		Return
	Endif
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Valida gera┤фo do mailing  - Verifica promo┤фo               Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	#IFNDEF WINDOWS
		F_VERSZA()
		IF mValida=='N'
			RETURN
		ENDIF
	#ELSE
		F_VERSZA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        Execute(F_VERSZA)
		IF mValida=='N'
			RETURN
		ENDIF
	#ENDIF
Endif

IF MV_PAR07==2
	mSaida:='1'
ENDIF

IF MV_PAR07==3
	cDesc1    :=PADC("Este programa ira gerar o arquivo de clientes em etiquetas" ,74)
	cDesc2    :=PADC("Elimina duplicidade por nome+destinat═rio+cep",74)
	cDesc3    :=""
	cTitulo   :=PADC("ETIQUETAS",74)
	mSaida    :='3'
ENDIF

IF MV_PAR07==4
	cDesc1    :=PADC("Este programa ira gerar o arquivo de cliente em relat╒rio" ,74)
	cDesc2    :=PADC("Elimina duplicidade por nome+destinatario+cep",74)
	cDesc3    :=""
	cTitulo   :=PADC("RELATЮRIO",74)
	Titulo    :="**** PROSPECTS ****"
	mSaida    :='2'
ENDIF

IF VAL(MV_PAR01)==0  .OR. VAL(MV_PAR02)==0
	MV_PAR01:=SPACE(3)
ENDIF

#IFNDEF WINDOWS
	DrawAdvWin(" AGUARDE  - GERANDO ARQUIVO -  " , 8, 0, 15, 75 )
#ENDIF

_aCampos := {  {"CODCLI"  ,"C", 6,0},;
{"CODDEST" ,"C", 6,0},;
{"NOME"    ,"C",45,0},;
{"DEST"    ,"C",45,0},;
{"V_END"   ,"C",45,0},;
{"COMPL"   ,"C",20,0},;
{"BAIRRO"  ,"C",20,0},;
{"MUN"     ,"C",30,0},;
{"EST"     ,"C", 2,0},;
{"TIPO"    ,"C", 1,0},;
{"DDD"     ,"C",5,0},;
{"FONE"    ,"C",20,0},;
{"DDD2"     ,"C",5,0},;
{"FONE2"    ,"C",20,0},;
{"DDD3"     ,"C",5,0},;
{"FONE3"    ,"C",20,0},;
{"DDD4"     ,"C",5,0},;
{"FONE4"    ,"C",20,0},;
{"DDD5"     ,"C",5,0},;
{"FONE5"    ,"C",20,0},;
{"DDD6"     ,"C",5,0},;
{"FONE6"    ,"C",20,0},;
{"FAX"     ,"C",20,0},;
{"EMAIL"   ,"C",40,0},;
{"ORIGEM"  ,"C", 3,0},;
{"CGC"     ,"C", 14,0},;
{"CORIGEM" ,"C",60,0},;
{"CEP"     ,"C", 8,0},;
{"IDENT"   ,"C", 6,0}}
_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PFAT107",.F.,.F.)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Inicio do relatorio                                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
#IFNDEF WINDOWS
	INDEXA()
	SELECAO()
#ELSE
	INDEXA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     Execute(INDEXA)
	lEnd:= .F.
	bBloco:= { |lEnd| SELECAO()  }// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     bBloco:= { |lEnd| Execute(SELECAO)  }
	MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
#ENDIF

IF MV_PAR07<>1
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Atualiza arquivo de controle  - saida de mailing             Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	#IFNDEF WINDOWS
		F_AtuZZ7()
	#ELSE
		F_ATUZZ7()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        Execute(F_ATUZZ7)
	#ENDIF
ENDIF

MCEPINI:=MV_PAR03

DO WHILE .T.
	MSGALERT(OEMTOANSI("QUANTIDADE ACUMULADA: "+str(mconta4,7,0)+" QUANTIDADE SELECIONADA: "+str(mconta2,7,0)))
	cPerg:="PFAT54"
	
	If !PERGUNTE(cPerg)
		exit
	Endif
	
	If LastKey()== 27
		exit
	Endif
	
	IF MV_PAR07<>1
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Valida gera┤фo do mailing  - Verifica promo┤фo               Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		
		#IFNDEF WINDOWS
			F_VERSZA()
			IF mValida=='N'
				DbSelectArea('PFAT107')
				DbCloseArea()
				RETURN
			ENDIF
		#ELSE
			F_VERSZA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>           Execute(F_VERSZA)
			IF mValida=='N'
				DbSelectArea('PFAT107')
				DbCloseArea()
				RETURN
			ENDIF
		#ENDIF
	ENDIF
	
	#IFNDEF WINDOWS
		DrawAdvWin(" AGUARDE  - GERANDO ARQUIVO -  " , 8, 0, 15, 75 )
		SELECAO()
	#ELSE
		lEnd:= .F.
		bBloco:= { |lEnd| SELECAO()  }
		MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
	#ENDIF
	
	IF MV_PAR07<>1
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Atualiza arquivo de controle  - saida de mailing             Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		#IFNDEF WINDOWS
			F_AtuZZ7()
		#ELSE
			F_ATUZZ7()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>           Execute(F_ATUZZ7)
		#ENDIF
	ENDIF
ENDDO

DBSELECTAREA("PFAT107")
cIndex:=CriaTrab(Nil,.F.)
cKey  :="NOME+DEST+TIPO+CEP"
Indregua("PFAT107",cIndex,ckey,,,"Selecionando Registros do Arq")

lEnd:= .F.
bBloco:= {|lEnd| FIM()}
MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )

#IFNDEF WINDOWS
	DrawAdvWin(" AGUARDE  - Processando ..", 8, 0, 15, 75 )
#ENDIF

DBSELECTAREA("PFAT107")
DBCLOSEAREA()

DBSELECTAREA("ZZ6")
Retindex("ZZ6")

DBSELECTAREA('SZ4')
Retindex("SZ4")

DBSELECTAREA('ZZ7')
Retindex("ZZ7")

DBSELECTAREA('SZA')
Retindex("SZA")

Static Function Fim()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Elimina duplicidade por codigo de cliente+destinatario       Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

IF MV_PAR08==1
	DBSELECTAREA("PFAT107")
	DBGOTOP()
	MCONTA3:=0
	
	DO WHILE .NOT. EOF()
		MCONTA3:=MCONTA3+1
		@ 10,05 PSAY 'LENDO REGISTRO : '+STR(MCONTA3,7)
		MCHAVE1:=NOME+DEST+CEP
		IF EOF()
			EXIT
		ELSE
			DBSKIP()
		ENDIF
		MCHAVE2:=NOME+DEST+CEP
		DO WHILE MCHAVE2==MCHAVE1
			Reclock("PFAT107",.F.)
			DELETE
			PFAT107->(MSunlock())
			IF EOF()
				EXIT
			ELSE
				DBSKIP()
				MCHAVE2:=NOME+DEST+CEP
			ENDIF
		ENDDO
	ENDDO
ENDIF

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Contagem dos registros selecionados                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
IF MV_PAR07==1
	DBSELECTAREA("PFAT107")
	COUNT TO MCONTA
	#IFNDEF WINDOWS
		MOSTRA()
	#ELSE
		MOSTRA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        Execute(MOSTRA)
	#ENDIF
ENDIF

IF MV_PAR07==2
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Copia selecao para arquivo dbf                               Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	cMsg:= "Arquivo Gerado com Sucesso em: "+_cString
	#IFNDEF WINDOWS
		DrawAdvWin(" AGUARDE  - COPIANDO ARQUIVO   " , 8, 0, 15, 75 )
		DBSELECTAREA("PFAT107")
		DBGOTOP()
		COPY TO &_cString VIA "DBFCDXADS" // 20121106 
		ALERT(cMsg)
	#ELSE
		DBSELECTAREA("PFAT107")
		DBGOTOP()
		DBSELECTAREA("PFAT107")
		DBGOTOP()
		COPY TO &_cString VIA "DBFCDXADS" // 20121106 
		MSGINFO(cMsg)
	#ENDIF
ENDIF

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define formato de saida do relatorio                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
IF MV_PAR07==3
	cArq:="pfat107"
	wnrel:=SetPrint(cArq,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
	SetDefault(aReturn,cString)
	If nLastKey == 27
		DbSelectArea('PFAT107')
		DbCloseArea()
		Return
	Endif
	#IFNDEF WINDOWS
		ETIQUETA()
	#ELSE
		ETIQUETA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        Execute(ETIQUETA)
	#ENDIF
ENDIF

IF MV_PAR07==4
	cArq:="PFAT107"
	wnrel:=SetPrint(cArq,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
	SetDefault(aReturn,cString)
	If nLastKey == 27
		DbSelectArea('PFAT107')
		DbCloseArea()
		Return
	Endif
	#IFNDEF WINDOWS
		RELATORIO()
	#ELSE
		RELATORIO()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        Execute(RELATORIO)
	#ENDIF
ENDIF
Return


//здддддддддддбддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Function  Ё F_AtuZZ7                                                      Ё
//цдддддддддддеддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
//Ё Descricao Ё Atualiza arquivo de controle de utilizacao.                   Ё
//цдддддддддддеддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
//Ё Observ.   Ё                                                               Ё
//юдддддддддддаддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function F_AtuZZ7
Static Function F_AtuZZ7()

IF MV_PAR07<>1
	DBSELECTAREA("ZZ7")
	RECLOCK("ZZ7",.T.)
	REPLACE ZZ7_CODPRO WITH MV_PAR12
	REPLACE ZZ7_CODMAI WITH MV_PAR13
	REPLACE ZZ7_USUAR  WITH SUBS(CUSUARIO,7,15)
	REPLACE ZZ7_DATA   WITH DATE()
	REPLACE ZZ7_QTDE   WITH MCONTA2
	REPLACE ZZ7_SAIDA  With MSAIDA
	REPLACE ZZ7_CEP1   With MV_PAR03
	REPLACE ZZ7_CEP2   With MV_PAR04
	REPLACE ZZ7_ATIV1  With MV_PAR14
	REPLACE ZZ7_ATIV2  With MV_PAR15
	REPLACE ZZ7_TPCLI  With 'P'
	REPLACE ZZ7_UTILIZ With Str(MV_PAR10,1)
	REPLACE ZZ7_DUPLIC With Str(MV_PAR08,1)
	ZZ7->(MSUNLOCK())
ENDIF

Return

//здддддддддддбддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Function  Ё F_VERSZA                                                      Ё
//цдддддддддддеддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
//Ё Descricao Ё Valida gera┤фo do arquivo  de dados                           Ё
//цдддддддддддеддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢
//Ё Observ.   Ё                                                               Ё
//юдддддддддддаддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function F_VERSZA
Static Function F_VERSZA()
DBSELECTAREA("SZA")
DBGOTOP()
DBSEEK(XFILIAL()+MV_PAR12)
IF !FOUND().AND. ALLTRIM(MV_PAR12)<>'N'
	#IFNDEF WINDOWS
		ALERT("Promo┤фo nфo cadastrada")
		ALERT("Entrar em contato com depto de Cadastro")
	#ELSE
		MsgStop("Promo┤фo nфo cadastrada")
		MsgStop("Entrar em contato com depto de Cadastro")
	#ENDIF
	mValida:="N"
ELSE
	DBSELECTAREA('SX5')
	DBGOTOP()
	DBSEEK(XFILIAL()+'91'+MV_PAR13)
	IF !FOUND()
		#IFNDEF WINDOWS
			ALERT("Mailing nфo cadastrado")
			ALERT("Entrar em contato com depto de Marketing")
		#ELSE
			MsgStop("Mailing nфo cadastrado")
			MsgStop("Entrar em contato com depto de Marketing")
		#ENDIF
		mValida:="N"
	ELSE
		mValida:="S"
	ENDIF
ENDIF
Return

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION INDEXA
Static FUNCTION INDEXA()
// DBSELECTAREA("SZ4")
// Retindex("SZ4")
// cIndex1:=CriaTrab(Nil,.F.)
// cKey:="Z4_FILIAL+Z4_CODCLI"
// Indregua("SZ4",cIndex,ckey,,,"Selecionando Registros do Arq")
// MIND3:=Retindex("SZ4")
// DBSETINDEX(CINDEX1)
// DBSETORDER(MIND3+1)
// DBGOTOP()
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION SELECAO
Static FUNCTION SELECAO()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Valida gera┤фo do mailing                                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
DBSELECTAREA("ZZ6")
DBGOTOP()
cArq:="ZZ6"
cChave  :=IndexKey()
cFiltro1:='ZZ6_ORIGEM>="'+MV_PAR01+'" .AND. ZZ6_ORIGEM<="'+MV_PAR02+'"'
cFiltro2:='.AND. ZZ6_CEP>="'+MV_PAR03+'" .AND. ZZ6_CEP<="'+MV_PAR04+'"'
cFiltro3:='.AND. ZZ6_CARGO>="'+MV_PAR05+'" .AND. ZZ6_CARGO<="'+MV_PAR06+'"'
cFiltro4:='.AND. ZZ6_ATIVID>="'+MV_PAR14+'" .AND. ZZ6_ATIVID<="'+MV_PAR15+'"'
cFiltro:=cFiltro1+cFiltro2+cFiltro3+cFiltro4
cInd   := CriaTrab(nil,.f.)
IndRegua(cArq,cInd,cChave,,cFiltro,"Filtrando ..")
DBGOTOP()
MCONTA :=0
MCONTA1:=0
MCONTA2:=0
MCONTA5:=0
DBSELECTAREA("ZZ6")
DBGOTOP()
DO WHILE .NOT. EOF() .AND. MCONTA2<>MV_PAR09
	MCONTA5++
	MORIGEM   := ZZ6_ORIGEM
	MCODCLI   := ZZ6_COD
	MNOMECLI  := ZZ6_NOME
	MEND      := ZZ6_END
	MCOMPL    := ZZ6_COMPL
	MBAIRRO   := ZZ6_BAIRRO
	MMUN      := ZZ6_MUN
	MEST      := ZZ6_ESTADO
	MCEP      := ZZ6_CEP
	MDDD      := ZZ6_DDD
	MFONE     := ZZ6_TEL
	MDDD2     := ZZ6_DDD2
	MFONE2    := ZZ6_TEL2
	MDDD3     := ZZ6_DDD3
	MFONE3    := ZZ6_TEL3
	MDDD4     := ZZ6_DDD4
	MFONE4    := ZZ6_TEL4
	MDDD5     := ZZ6_DDD5
	MFONE5    := ZZ6_TEL5
	MDDD6     := ZZ6_DDD6
	MFONE6    := ZZ6_TEL6
	MIDENT    := ZZ6_ID
	MFAX      := ZZ6_FAX
	MEMAIL    := ZZ6_EMAIL
	MCGC      := ZZ6_CGC
	MCONTATO  := ZZ6_CONTAT
	MCODDEST  := ""
	MNOMEDEST := ""
	MTIPO     := ""
	MUTILIZA  := ""
	MCORIGEM  := ""
	MDTUTIL   := DATE()
	
	IF DTOS(ZZ6_DTUTIL)>="'+DTOS(MV_PAR11)+'"
		DBSKIP()
		LOOP
	ENDIF
	
	IF MV_PAR10==1 .AND. EMPTY(MFONE)
		DBSKIP()
		LOOP
	ENDIF
	
	IF MV_PAR10==2
		IF EMPTY(MEND) .OR. EMPTY(MCEP)
			DBSKIP()
			LOOP
		ENDIF
	ENDIF
	
	IF VAL(MCODCLI)==0
		DBSKIP()
		LOOP
	ENDIF
	
	#IFNDEF WINDOWS
		@ 10, 5 Say "   A G U A R D E  - LIDOS"+" "+"ZZ6"+" "+"->"+STR(MCONTA5,7)
		@ 11, 5 Say "   A G U A R D E  - LENDO CEP -> "+MCEP
		@ 12, 5 Say "   A G U A R D E  - GRAVANDO  -> "+STR(MCONTA2,7)
	#ELSE
		MsProcTxt("Registros Lidos : "+Str(MCONTA5,7)+" Gravando: "+Str(mConta2,7))
	#ENDIF
	
	DO CASE
		CASE MV_PAR10==1
			MUTILIZA:='TELEVENDAS'
		CASE MV_PAR10==2
			MUTILIZA:='MALA DIRETA'
	ENDCASE
	
	IF MV_PAR07<>1
		Reclock("ZZ6",.F.)
		REPLACE ZZ6_UTILIZ   WITH MUTILIZA
		REPLACE ZZ6_DTUTIL   WITH MDTUTIL
		ZZ6->(MSunlock())
	ENDIF
	
	DBSELECTAREA('SX5')
	DBGOTOP()
	DBSEEK(XFILIAL()+'91'+MV_PAR12)
	IF !FOUND()
		MCORIGEM:=SX5->X5_DESCRI
	ENDIF
	IF MCEP>=MV_PAR03 .AND. MCEP<=MV_PAR04
		DBSELECTAREA("SZ4")
		DBGOTOP()
		DBSEEK(XFILIAL()+MCODCLI)
		IF FOUND()
			DO WHILE SZ4->Z4_CODCLI==MCODCLI
				MCODCON:=SZ4->Z4_CODCON
				MCONTATO:=SZ4->Z4_CONTATO
				IF !EMPTY(SZ4->Z4_FONE)
					MFONE:=Z4_FONE
				ENDIF
				IF !EMPTY(SZ4->Z4_FAX)
					MFAX:=Z4_FAX
				ENDIF
				IF !EMPTY(SZ4->Z4_EMAIL)
					MEMAIL:=Z4_EMAIL
				ENDIF
				GRAVA_TEMP()
				MCONTA4++
				MCONTA2++
				DBSELECTAREA("SZ4")
				DBSKIP()
				IF SZ4->Z4_CODCLI<>MCODCLI
					EXIT
				ENDIF
			ENDDO
		ELSE
			GRAVA_TEMP()
			MCONTA4++
			MCONTA2++
		ENDIF
	ENDIF
	DBSELECTAREA("ZZ6")
	DBSKIP()
ENDDO
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION MOSTRA
Static FUNCTION MOSTRA()
#IFNDEF WINDOWS
	@ 10,05 SAY  'Origem----------------->' +TRIM(MV_PAR01)+ ' A ' + TRIM(MV_PAR02)
	@ 11,05 SAY  'CEP    ---------------->' +MV_PAR03+ ' A ' + MV_PAR04
	@ 12,05 SAY  'Atividade-------------->' +MV_PAR14+ ' A ' + MV_PAR15
	@ 13,05 SAY  'Quantidade do Mailing-->' +STR(MCONTA,7,0)
	INKEY(0)
#ELSE
	@ 200,001 TO 400,450 DIALOG oDlg TITLE " Confirme ... "
	@ 003,010 TO 090,220
	@ 15,018 Say "Origem.................: "+Trim(MV_PAR01)+ " A " + Trim(MV_PAR02)
	@ 30,018 Say "CEP....................: "+MV_PAR03+ ' A ' + MV_PAR04
	@ 45,018 SAY "Atividade..............: "+MV_PAR14+ ' A ' + MV_PAR15
	@ 60,018 SAY "Quantidade do Mailing..: "+STRZERO(MCONTA,7,0)
	@ 75,188 BMPBUTTON TYPE 01 ACTION Close(oDlg)
	Activate Dialog oDlg Centered
#ENDIF
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION GRAVA_TEMP
Static FUNCTION GRAVA_TEMP()
DBSELECTAREA("PFAT107")
Reclock("PFAT107",.t.)
REPLACE CODCLI   WITH  MCODCLI
REPLACE CODDEST  WITH  MCODDEST
REPLACE NOME     WITH  MNOMECLI
IF MCONTATO == SPACE(40)
	REPLACE DEST     WITH  "."
ELSE
	REPLACE DEST     WITH  MCONTATO
ENDIF
REPLACE V_END    WITH  MEND
REPLACE COMPL    WITH  MCOMPL
REPLACE BAIRRO   WITH  MBAIRRO
REPLACE MUN      WITH  MMUN
REPLACE CEP      WITH  MCEP
REPLACE EST      WITH  MEST
REPLACE DDD      WITH  MDDD
REPLACE FONE     WITH  MFONE
REPLACE DDD2     WITH  MDDD2
REPLACE FONE2    WITH  MFONE2
REPLACE DDD3     WITH  MDDD3
REPLACE FONE3    WITH  MFONE3
REPLACE DDD4     WITH  MDDD4
REPLACE FONE4    WITH  MFONE4
REPLACE DDD5     WITH  MDDD5
REPLACE FONE5    WITH  MFONE5
REPLACE DDD6     WITH  MDDD6
REPLACE FONE6    WITH  MFONE6
REPLACE ORIGEM   WITH  MORIGEM
REPLACE TIPO     WITH  MTIPO
REPLACE CGC      WITH  MCGC
REPLACE CORIGEM  WITH  MCORIGEM
REPLACE IDENT    WITH  MIDENT
PFAT107->(MSUnlock())
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION ETIQUETA
Static FUNCTION ETIQUETA()
SETPRC(0,0)
LIN:=0
COL:=1
LI :=0
DBSELECTAREA('PFAT107')
cIndex:=CriaTrab(Nil,.F.)
cKey:="CEP+NOME+DEST"
Indregua("PFAT107",cIndex,ckey,,,"Selecionando Registros do Arq")
COUNT TO MCONTA
DBGOTOP()
DO WHILE .NOT. EOF()
	// Impressao do nome
	@ LIN+LI,001 PSAY ALLTRIM(NOME)
	DBSKIP()
	@ LIN+LI,044 PSAY ALLTRIM(NOME)
	DBSKIP()
	@ LIN+LI,087 PSAY ALLTRIM(NOME)
	DBSKIP(-2)
	LI:=LI+1
	
	// Impressao do destinatario
	@ LIN+LI,001 PSAY ALLTRIM(DEST)
	DBSKIP()
	@ LIN+LI,044 PSAY ALLTRIM(DEST)
	DBSKIP()
	@ LIN+LI,087 PSAY ALLTRIM(DEST)
	DBSKIP(-2)
	LI:=LI+1
	
	// Impressao do endereco
	@ LIN+LI,001 PSAY ALLTRIM(V_END)
	DBSKIP()
	@ LIN+LI,044 PSAY ALLTRIM(V_END)
	DBSKIP()
	@ LIN+LI,087 PSAY ALLTRIM(V_END)
	DBSKIP(-2)
	LI:=LI+1
	
	// Impressao do complemento do endereco e bairro
	IF COMPL == SPACE(20) .AND. BAIRRO == SPACE(20)
		@ LIN+LI,001 PSAY "."
	ELSEIF COMPL <> SPACE(20) .AND. BAIRRO == SPACE(20)
		@ LIN+LI,001 PSAY ALLTRIM(COMPL)
	ELSEIF COMPL <> SPACE(20) .AND. BAIRRO <> SPACE(20)
		@ LIN+LI,001 PSAY ALLTRIM(COMPL)+'/'+ALLTRIM(BAIRRO)
	ELSE
		@ LIN+LI,001 PSAY ALLTRIM(BAIRRO)
	ENDIF
	DBSKIP()
	
	IF COMPL == SPACE(20) .AND. BAIRRO == SPACE(20)
		@ LIN+LI,044 PSAY "."
	ELSEIF COMPL <> SPACE(20) .AND. BAIRRO == SPACE(20)
		@ LIN+LI,044 PSAY ALLTRIM(COMPL)
	ELSEIF COMPL <> SPACE(20) .AND. BAIRRO <> SPACE(20)
		@ LIN+LI,044 PSAY ALLTRIM(COMPL)+'/'+ALLTRIM(BAIRRO)
	ELSE
		@ LIN+LI,044 PSAY ALLTRIM(BAIRRO)
	ENDIF
	DBSKIP()
	
	IF COMPL == SPACE(20) .AND. BAIRRO == SPACE(20)
		@ LIN+LI,087 PSAY "."
	ELSEIF COMPL <> SPACE(20) .AND. BAIRRO == SPACE(20)
		@ LIN+LI,087 PSAY ALLTRIM(COMPL)
	ELSEIF COMPL <> SPACE(20) .AND. BAIRRO <> SPACE(20)
		@ LIN+LI,087 PSAY ALLTRIM(COMPL)+'/'+ALLTRIM(BAIRRO)
	ELSE
		@ LIN+LI,087 PSAY ALLTRIM(BAIRRO)
	ENDIF
	DBSKIP(-2)
	LI:=LI+1
	
	// Impressao do CEP, municipio e Estado
	@ LIN+LI,001 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+' ' +ALLTRIM(MUN)+' '+EST
	DBSKIP()
	@ LIN+LI,044 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+' ' +ALLTRIM(MUN)+' '+EST
	DBSKIP()
	@ LIN+LI,087 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+' ' +ALLTRIM(MUN)+' '+EST
	DBSKIP(-2)
	LI:=LI+1
	
	// Impressao do ID
	@ LIN+LI,001 PSAY '(' + IDENT + ')'
	DBSKIP()
	@ LIN+LI,044 PSAY '(' + IDENT + ')'
	DBSKIP()
	@ LIN+LI,087 PSAY '(' + IDENT + ')'
	LI:=LI+1
	DBSKIP()
	
	LI:=2
	setprc(0,0)
	lin:=prow()
ENDDO
@ LIN+LI  ,001 PSAY '****************************************'
@ LIN+LI+1,001 PSAY 'TOTAL...................:'+STR(MCONTA,7)
@ LIN+LI+2,001 PSAY '****************************************'

SET DEVI TO SCREEN
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF
MS_FLUSH()
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION RELATORIO
Static FUNCTION RELATORIO()
DBSELECTAREA('PFAT107')
cIndex:=CriaTrab(Nil,.F.)
cKey:="CEP+NOME+DEST"
Indregua("PFAT107",cIndex,ckey,,,"Selecionando Registros do Arq")
// SETREGUA(RECCOUNT())
DBGOTOP()
DO WHILE .NOT. EOF()
	//	IncRegua()
	IMPR3()
	IMPR2()
	DBSELECTAREA('PFAT107')
	
	@ L,01   PSAY 'COD CLI...: '+CODCLI
	@ L,27   PSAY 'COD DEST..: '+CODDEST
	@ L+1,01 PSAY 'NOME......: '+NOME
	@ L+1,76 PSAY 'CPF/CGC.:'   +TRIM(CGC)
	@ L+2,01 PSAY 'DEST......: '+DEST
	@ L+3,01 PSAY 'ENDERECO..: '+TRIM(V_END) + ' ' + TRIM(COMPL)
	@ L+3,76 PSAY 'BAIRRO..:'   +BAIRRO
	@ L+4,01 PSAY 'FONES.....: '+TRIM(DDD)+' '+TRIM(FONE)+'  '+TRIM(DDD2)+' '+TRIM(FONE2)+'  '+TRIM(DDD3)+' '+TRIM(FONE3);
	+'  '+TRIM(DDD4)+' '+TRIM(FONE4)+'  '+TRIM(DDD5)+' '+TRIM(FONE5)+'  '+TRIM(DDD6)+' '+TRIM(FONE6)
	@ L+5,01 PSAY 'CIDADE/EST: '+TRIM(MUN)+'   '+EST
	@ L+6,01 PSAY 'CEP.......: '+SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)
	@ L+7,01 PSAY REPLICATE('_',104)
	L:=L+8
	IF EOF()
		EXIT
	ELSE
		DBSKIP()
	ENDIF
ENDDO
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Termino do Relatorio                                         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SET DEVI TO SCREEN
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF
MS_FLUSH()
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION IMPR3
Static FUNCTION IMPR3()
IF L<>0
	IF L==65 .OR. L+7>65
		L:=0
	ELSE
		L:=L+1
	ENDIF
ENDIF
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION IMPR2
Static FUNCTION IMPR2()
@ 00,00 PSAY AVALIMP(132)
IF L==0
	L:=L+1
	CABEC(Titulo,cCabec1,cCabec2,cPrograma,tamanho,nCaracter)
	L:=4
	L:=L+2
ENDIF
RETURN
