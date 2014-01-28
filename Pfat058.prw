#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 21/03/02
/*/ Alterado por Danilo C S Pala em 20040505

//Danilo C S Pala em 20050609: nota  e serie
//Danilo C S Pala em 20110718: c6_valor / c6_qtdven
//Danilo C S Pala em 20110921: c6_tiporev: 0=mensal, 1=par, 2=impar solicitado por Sandra
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: PFAT058   �Autor: Raquel Farias          � Data:   27/09/99 � ��
������������������������������������������������������������������������Ĵ ��
���Descri��o: Gera��o do arquivo de Assinantes  - revistas               � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento  Liberado para Usu�rio em:           � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Altera��o           �Alterado por: Raquel Farias   � Data:   10/04/00 � ��
������������������������������������������������������������������������Ĵ ��
���Descri��o: Substitui c6_edfin por c6_edvenc a pedido da Solange       � ��
������������������������������������������������������������������������Ĵ ��
���Liberado para Usu�rio em: 10/04/00                                    � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
/*/
User Function Pfat058()

SetPrvt("CPERG,MREV1,MED1,MEDF1,MREV2,MED2")
SetPrvt("MEDF2,MREV3,MED3,MEDF3,MREV4,MED4")
SetPrvt("MEDF4,MREV5,MED5,MEDF5,MREV6,MED6")
SetPrvt("MEDF6,MREV7,MED7,MEDF7,MPRODUTO1,MPRODUTO2")
SetPrvt("MEDICAO1,MEDICAO2,MQTREV,MNUMED,MNUMREV,MNUMEDF")
SetPrvt("MCONTA,MREVISTA,MCOND,MEMPRESA,_CARQPATH,MMESANO")
SetPrvt("MVXPAR1,MVXPAR2,MVXPAR3,MVXPAR4 ,MVXPAR5 ,MVXPAR6")
SetPrvt("MVXPAR7,MVXPAR8,MVXPAR9,MVXPAR10,MVXPAR11,MVXPAR12")
SetPrvt("MVXPAR13,MVXPAR14,MVXPAR15,MVXPAR16,MVXPAR17,NVXPAR18,MVXPAR19")
SetPrvt("_ACAMPOS,_CNOME,CINDEX,MDTINCL,MCLIFAT")
SetPrvt("CKEY,_CSTRING,_CSEG,_CMSG,MVAR1,MVAR2")
SetPrvt("MVAR3,CCONDICAO1,CCONDICAO2,CCONDICAO3,CCONDICAO4,CCONDICAO5")
SetPrvt("CCONDICAO6,CCONDICAO,MCODCLI,MCODDEST,MPED,MPEDNOVO")
SetPrvt("MPEDIDO,MITEM,MCOD,MVALOR,MTES,MCF")
SetPrvt("MSITUAC,MDTPG,MDTSUSP,MDTCIRC1,MDTCIRC2,MFATOR")
SetPrvt("MPAGO,MPARC,MPER,MVENC,MEDSUSP,MABERTO")
SetPrvt("MPREFIXO,MPARCELA,MMUMERO,MTIPO,MMOTBX,MGRAT")
SetPrvt("MMOTIVO,MDUPL,MCODREV,MEDIN,MEDFIN,MEDVENC")
SetPrvt("MQTDEX,MNUMERO,MCONDICAO,MNOVOVEND,MNOVAREG,MVEND")
SetPrvt("MEQUIPE,MREGIAO,MNOMEVEND,MREGREN,MCEP,MNOME")
SetPrvt("MEST,MCODATIV,MCEPINI,MCEPFIN,MREG1,MVEND1")
SetPrvt("MPRODUTO,MIND1,CARQ,MPEDREN,MIT,MITEMREN")
SetPrvt("MITEMANT,MDESCR,MPEDRENOV,MPAGA1, NASSQTD, NCONTQTD, MNOTA, MSERIE, MTiporev")
// PARAMETROS EDITORA PINI
//��������������������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                                     �
//� mv_par01             // Cod.da Revista        (C-4)                      �
//� mv_par02             // Edicao Inicial        (N-4)                      �
//� mv_par03             // Edicao Final          (N-4)                      �
//� mv_par04             // Cod.da Revista        (C-4)                      �
//� mv_par05             // Edicao                (N-4)                      �
//� mv_par06             // Cod.da Revista        (C-4)                      �
//� mv_par07             // Edicao                (N-4)                      �
//� mv_par08             // Cod.da Revista        (C-4)                      �
//� mv_par09             // Edicao                (N-4)                      �
//� mv_par10             // Cod.da Revista        (C-4)                      �
//� mv_par11             // Edicao                (N-4)                      �
//� mv_par12             // Cod.da Revista        (C-4)                      �
//� mv_par13             // Edicao                (N-4)                      �
//� mv_par14             // Cod.da Revista        (C-4)                      �
//� mv_par15             // Edicao                (N-4)                      �
//� mv_par16             // Renova��o  Recupera��o Autom�tica Nenhum         �
//� mv_par17             // Cancelados Ativos-Repres Ativos-Sele��o  Nenhum  �
//� mv_par18             // Sim  N�o                                         �
//� mv_par19             // M�s/Ano                                          �
//����������������������������������������������������������������������������
// PARAMETROS PINI SISTEMAS
//��������������������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                                     �
//� mv_par01             // Cod.do Produto Inicial (C-15)                    �
//� mv_par02             // Cod.do Produto Final   (C-15)                    �
//� mv_par03             // Edicao Inicial         (N-04)                    �
//� mv_par04             // Edicao Final           (N-04)                    �
//� mv_par05             // Renova��o  Recupera��o Automatica  Nenhum        �
//� mv_par06             // Cancelados Ativos-Repres Ativos-Sele��o  Nenhum  �
//� mv_par07             // Sim  N�o                                         �
//� mv_par08             // M�s/Ano                                          �
//����������������������������������������������������������������������������
cPerg     := "PFAT20"
MREV1     := ""
MED1      := ""
MEDF1     := ""

MREV2     := ""
MED2      := ""
MEDF2     := ""

MREV3     := ""
MED3      := ""
MEDF3     := ""

MREV4     := ""
MED4      := ""
MEDF4     := ""

MREV5     := ""
MED5      := ""
MEDF5     := ""

MREV6     := ""
MED6      := ""
MEDF6     := ""

MREV7     := ""
MED7      := ""
MEDF7     := ""

MPRODUTO1 := ""
MPRODUTO2 := ""
MEDICAO1  := ""
MEDICAO2  := ""
MQTREV    := ""
MNUMED    := ""
MNUMREV   := ""
MNUMEDF   := ""
MCONTA    := ""
MREVISTA  := ""
MCOND     := ""
MEMPRESA  := SM0->M0_CODIGO

_cArqPath := GetMv("MV_PATHASS")   // GILBERTO - 02/10/00

//�������������������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                                      �
//���������������������������������������������������������������������������
If !Pergunte(cPerg)
	Return
Endif

MVXPAR01:=mv_par01
MVXPAR02:=mv_par02
MVXPAR03:=mv_par03
MVXPAR04:=mv_par04
MVXPAR05:=mv_par05
MVXPAR06:=mv_par06
MVXPAR07:=mv_par07
MVXPAR08:=mv_par08
MVXPAR09:=mv_par09
MVXPAR10:=mv_par10
MVXPAR11:=mv_par11
MVXPAR12:=mv_par12
MVXPAR13:=mv_par13
MVXPAR14:=mv_par14
MVXPAR15:=mv_par15
MVXPAR16:=mv_par16
MVXPAR17:=mv_par17
MVXPAR18:=mv_par18
MVXPAR19:=mv_par19

IF MEMPRESA == '01'       
	MMESANO  := MVXPAR19
	//substr(MVXPAR19,1,2)+substr(MVXPAR19,4,2) //MVXPAR19 20040505
ENDIF

IF MEMPRESA == '02'
	MVXPAR16 := MVXPAR05
	MVXPAR17 := MVXPAR06
	MVXPAR18 := MVXPAR07
	if len(trim(MVXPAR08)) < 5
		MMESANO := "0"+substr(MVXPAR08,1,1) + substr(MVXPAR08,3,2)
//	MMESANO  := substr(dtos("01/"+MVXPAR08),3,4)  //20040505
	else
		MMESANO := substr(MVXPAR08,1,2) + substr(MVXPAR08,4,2)
	end if
	//substr(MVXPAR08,1,2)+substr(MVXPAR08,4,2) // MVXPAR08 20040505
ENDIF

IF MVXPAR16 == 1 .OR. MVXPAR16 == 2 .OR. MVXPAR17 == 3
	IF EMPTY(MMESANO)
		MsgAlert("Informe MesAno da Renovacao ou Recuperacao")
		Return
	ENDIF
ENDIF

IF MVXPAR16 == 3 .AND. MVXPAR17 == 4
	ALERT("Selecione um tipo valido para gera�ao do arquivo")
	Return
ENDIF

_aCampos := {  {"NUMPED"        ,"C"    ,6      ,0} ,;
{"ITEM"         ,"C"    ,2      ,0},;
{"TES"          ,"C"    ,3      ,0},;
{"CF "          ,"C"    ,5      ,0},;
{"DUPL"         ,"C"    ,1      ,0},;
{"SITUAC"       ,"C"    ,2      ,0},;
{"CODCLI"       ,"C"    ,6      ,0},;
{"CODPROD"      ,"C"    ,15     ,0},;
{"DESCR"        ,"C"    ,40      ,0},;
{"CODVEND"      ,"C"    ,6      ,0},;
{"NOVOVEND"     ,"C"    ,6      ,0},;
{"EDIN"         ,"N"    ,4      ,0},;
{"EDFIN"        ,"N"    ,4      ,0},;
{"EDVENC"       ,"N"    ,4      ,0},;
{"EDSUSP"       ,"N"    ,4      ,0},;
{"NOME"         ,"C"    ,40     ,0},;
{"EQUIPE"       ,"C"    ,15     ,0},;
{"CEP"          ,"C"    ,8      ,0},;
{"EST"          ,"C"    ,2      ,0},;
{"REGIAO"       ,"C"    ,3      ,0},;
{"NOVAREG"      ,"C"    ,3      ,0},;
{"VALOR"        ,"N"    ,12     ,2},;
{"CODREV"       ,"C"    ,4      ,0},;
{"REGREN"       ,"C"    ,1      ,0},;
{"CODATIV"      ,"C"    ,7      ,0},;
{"PORTE"        ,"C"    ,1      ,0},;
{"PEDRENOV"     ,"C"    ,6      ,0},;
{"CODDEST"      ,"C"    ,6      ,0},;
{"INCLUSAO"     ,"D"    ,8      ,0},;
{"NOTA"     	,"C"    ,9      ,0},; //mp10
{"SERIE"      	,"C"    ,6      ,0},;
{"TIPOREV"     	,"C"    ,1      ,0}} //20110921

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PFAT058",.F.,.F.)

DbSelectArea("SZL")
//cIndex := CriaTrab(Nil,.F.)
//cKey   := "ZL_FILIAL+ZL_CODREG"
//Indregua("SZL",cIndex,ckey,,,"Selecionando Registros do Arq")

//�������������������������������������������������������������������������Ŀ
//� Iinicio da grava��o do arquivo                                          �
//���������������������������������������������������������������������������

Processa({|lEnd| GERA(@lEnd)},"Aguarde...","Gerando Arquivo...",.t.)

While .T.
	cPerg := "PFAT20"
	If !Pergunte(cPerg)
		Exit
	Endif
	If LastKey()== 27
		Exit
	Endif
	Processa({|lEnd|Gera(@lEnd)},"Aguarde...","Gerando Arquivo de Clientes...",.t.)
END

_cString:= " "
_cSeg   := " "

If MVXPAR16 == 1
	DbSelectArea("PFAT058")
	DbGoTop()
	_cString := _cArqPath+"RENOV"+mEmpresa+".DTC"//".DBF" //20121106
	_cSeg    := _cArqPath+"RN"+mEmpresa+mMesano+".DTC"//".DBF" //20121106
Endif

If MVXPAR16 == 2
	DbSelectArea("PFAT058")
	DbGoTop()
	_cString := _cArqPath+"RENOV"+mEmpresa+".DTC"//".DBF" //20121106
	_cSeg    := _cArqPath+"RC"+mEmpresa+mMesano+".DTC"//".DBF" //20121106
Endif

If MVXPAR16 == 3
	DbSelectArea("PFAT058")
	DbGoTop()
	_cString := _cArqPath+"RENOV"+mEmpresa+".DTC"//".DBF" //20121106
	_cSeg    := _cArqPath+"RA"+mEmpresa+mMesano+".DTC"//".DBF" //20121106
Endif

If MVXPAR17 == 1
	DbSelectArea("PFAT058")
	DbGotop()
	_cString := _cArqPath+"ASSCANC"+Right(mEmpresa,1)+".DTC"//".DBF" //20121106
ElseIf MVXPAR17 == 2
	DbSelectArea("PFAT058")
	DbGotop()
	_cString := _cArqPath+"ASSAT"+mEmpresa+".DTC"//".DBF" //20121106
ElseIf MVXPAR17 == 3
	DbSelectArea("PFAT058")
	DbGoTop()
	_cString := _cArqPath+"ASSSEL"+mEmpresa+".DTC"//".DBF" //20121106
Endif

If mEmpresa == "01" .or. mEmpresa== "02" .and. !Empty(_cString)
	COPY TO &_cString //VIA "DBFCDXADS" // 20121106 
	If !Empty(_cSeg)
		COPY TO &_cSeg //VIA "DBFCDXADS" // 20121106 
	Endif
	_cMsg := "Arquivo Gerado com Sucesso em: "+_cString
	MsgInfo(_cMsg)
Endif

DbSelectArea("PFAT058")
DbCloseArea()

Return
//��������������������������������������������������������������Ŀ
//�  FUN��ES                                                     �
//����������������������������������������������������������������
Static Function GERA()

//��������������������������������������������������������������Ŀ
//�  MELHORIAS:                                                  �
//�  CRIAR PARAMETRO-> MQTREV:=GETMV("MV_QTREV")                 �
//�  CRIAR MATRIZ 1 A MQTREV                                     �
//�  CRIAR NOVAS PERGUNTAS QUANDO NECESSARIO                     �
//����������������������������������������������������������������

IF MEMPRESA == '01'
	MREV1  := MVXPAR01
	MED1   := MVXPAR02
	MEDF1  := MVXPAR03
	
	MREV2  := MVXPAR04
	MED2   := MVXPAR05
	MEDF2  := MED2
	
	MREV3   := MVXPAR06
	MED3    := MVXPAR07
	MEDF3   := MED3
	
	MREV4   := MVXPAR08
	MED4    := MVXPAR09
	MEDF4   := MED4
	
	MREV5   := MVXPAR10
	MED5    := MVXPAR11
	MEDF5   := MED5
	
	MREV6   := MVXPAR12
	MED6    := MVXPAR13
	MEDF6   := MED6
	
	MREV7   := MVXPAR14
	MED7    := MVXPAR15
	MEDF7   := MED7
	MQTREV  := 7
ENDIF

IF MEMPRESA == '02'
	MVXPAR16  := MVXPAR05
	MVXPAR17  := MVXPAR06
	MVXPAR18  := MVXPAR07
	
	MPRODUTO1 := MVXPAR01
	MPRODUTO2 := MVXPAR02
	MEDICAO1  := MVXPAR03
	MEDICAO2  := MVXPAR04
	MQTREV    := 1
ENDIF

MNUMED  := 0
MNUMREV := 0
MNUMEDF := 0
MCONTA  := 0

DbSelectArea("SC6")
//DbGotop()
ProcRegua(LastRec())
DbGotop()
While !Eof() .AND. !lEnd
	IF lEnd
		Return
	ENDIF
	MNUMED++
	MNUMREV++
	MNUMEDF++
	MVAR1   := 'MREV'+STR(MNUMREV,1)
	MVAR2   := 'MED' +STR(MNUMED,1)
	MVAR3   := 'MEDF'+str(MNUMEDF,1)
	
	IF MEMPRESA == '01'
		MREVISTA  := SUBS(&MVAR1,1,15)
		MPRODUTO1 := MREVISTA
		MPRODUTO2 := MREVISTA
		MEDICAO1  := &MVAR2
		MEDICAO2  := &MVAR3
		MCOND     := "SUBS(C6_PRODUTO,1,4) == '"+MREVISTA+"'"
	ENDIF
	
	IF MEMPRESA == '02'
		MREVISTA := '9999'
		MEDICAO1 := MVXPAR03
		MEDICAO2 := MVXPAR04
		MCOND    := "C6_PRODUTO >= '"+ MPRODUTO1 + "' .AND. C6_PRODUTO <= '" + MPRODUTO2 + "'"
	ENDIF
	
	IncProc("Produto: "+Alltrim(MPRODUTO1))
	
	IF MREVISTA <> '   '
		dbSelectArea('SC6')
		DbSetOrder(2)
		DbSeek(xFilial("SC6")+MPRODUTO1,.T.)
		
		//cIndex := CriaTrab(Nil,.F.)
		//cKey   := "C6_FILIAL+C6_PRODUTO"
		/*
		DO CASE
		CASE MVXPAR16==1 .OR. MVXPAR16==2 .OR. MVXPAR16==3
		cCondicao1 := ""
		cCondicao2 := "C6_FILIAL == '"+xFilial("SC6")+"'"
		cCondicao3 := " .AND. " + MCOND
		cCondicao4 := " .AND. C6_EDVENC <> 9999 .AND. C6_PEDREN == '      '"
		cCondicao5 := " .AND. C6_EDSUSP >= " + STR(MEDICAO1,4) + " .AND. C6_EDSUSP <= " + STR(MEDICAO2,4)
		cCondicao6 := " .AND. C6_EDSUSP <> C6_EDINIC"
		cCondicao  := cCondicao1 + cCondicao2 + cCondicao3 + cCondicao4 + cCondicao5 + cCondicao6
		Indregua("SC6",cIndex,ckey,,cCondicao,"Selecionando Registros do Arq")
		CASE MVXPAR17==1
		cCondicao  := ""
		cCondicao  := cCondicao + "C6_FILIAL == '"+xFilial("SC6")+"' .AND. "
		cCondicao  := cCondicao + MCOND + " .AND. "
		cCondicao  := cCondicao +"C6_EDVENC <> 9999 .AND. C6_PEDREN == '      ' .AND. "
		cCondicao  := cCondicao +"C6_EDSUSP >= " + STR(MEDICAO1,4) + " .AND. C6_EDSUSP <= " + STR(MEDICAO2,4)
		Indregua("SC6",cIndex,ckey,,cCondicao,"Selecionando Registros do Arq")
		CASE MVXPAR17==2 .OR. MVXPAR17==3
		cCondicao := ""
		cCondicao := cCondicao + "C6_FILIAL == '" + xFilial("SC6") + "'.AND. "
		cCondicao := cCondicao + MCOND + " .AND. "
		cCondicao := cCondicao + " C6_EDVENC <> 9999 .AND. "
		cCondicao := cCondicao + " C6_EDVENC >= " + STR(MEDICAO1,4)
		Indregua("SC6",cIndex,ckey,,cCondicao,"Selecionando Registros do Arq")
		OTHERWISE
		EXIT
		ENDCASE
		*/
		//DbGotop()
		
		// Condicao de acordo com o Case comentado acima
		If !((MVXPAR16==1 .OR. MVXPAR16==2 .OR. MVXPAR16==3) .OR. (MVXPAR17==1 .OR. MVXPAR17==2 .OR. MVXPAR17==3))
			Exit
		EndIf
		
		DbSelectArea("SC6")
		
		While !Eof() .and. SC6->C6_PRODUTO >= MPRODUTO1 .AND. SC6->C6_PRODUTO <= MPRODUTO2
			DbSelectArea("SC6")
  /*			 
			IF SC6->C6_NUM='272453'
				MSGALERT("ACHOU: "+ALLTRIM(SC6->C6_NUM))
			ENDIF
*/

			IncProc("Lendo Registro (SC6): "+StrZero(recno(),7)+' '+MREVISTA)
			
			Do Case
				Case MVXPAR16 == 1 .OR. MVXPAR16 == 2
					If  SC6->C6_EDVENC == 9999            .or. ;
						SC6->C6_PEDREN <> "      "        .or. ;
						SC6->C6_EDSUSP <  MEDICAO1        .or. ;
						SC6->C6_EDSUSP >  MEDICAO2        .or. ;
						SC6->C6_EDSUSP == SC6->C6_EDINIC
						DbSelectArea("SC6")
						DbSkip()
						Loop
					EndIf
				Case MVXPAR17 == 1
					If  SC6->C6_EDVENC == 9999            .or. ;
						SC6->C6_PEDREN <> "      "        .or. ;
						SC6->C6_EDSUSP <  MEDICAO1 .or. ;
						SC6->C6_EDSUSP >  MEDICAO2
						DbSelectArea("SC6")
						DbSkip()
						Loop
					EndIf
				Case MVXPAR17 == 2 .OR. MVXPAR17 == 3
					If  SC6->C6_EDVENC == 9999      .or. ;
						SC6->C6_EDFIN  == 9999      .or. ;
						SC6->C6_EDINIC == 9999      .or. ;
						SC6->C6_EDVENC < MEDICAO1
						DbSelectArea("SC6")
						DbSkip()
						Loop
					EndIf
			EndCase
			
			
			IF MEMPRESA = "01"      // Valdir 22/08/03
				
				//20030707 DANILO
				IF (SC6->C6_EDINIC > MVXPAR03 .AND. SUBSTR(SC6->C6_PRODUTO,1,4) = MVXPAR01)
					DbSelectArea("SC6")
					DbSkip()
					Loop
				ENDIF
				
				// -----------> Valdir 08/08/03 - inicio
				
				IF (SC6->C6_EDINIC > MVXPAR05 .AND. SUBSTR(SC6->C6_PRODUTO,1,4) = MVXPAR04)
					DbSelectArea("SC6")
					DbSkip()
					Loop
				ENDIF
				
				IF (SC6->C6_EDINIC > MVXPAR07 .AND. SUBSTR(SC6->C6_PRODUTO,1,4) = MVXPAR06)
					DbSelectArea("SC6")
					DbSkip()
					Loop
				ENDIF
				
				IF (SC6->C6_EDINIC > MVXPAR09 .AND. SUBSTR(SC6->C6_PRODUTO,1,4) = MVXPAR08)
					DbSelectArea("SC6")
					DbSkip()
					Loop
				ENDIF
				
				IF (SC6->C6_EDINIC > MVXPAR11 .AND. SUBSTR(SC6->C6_PRODUTO,1,4) = MVXPAR10)
					DbSelectArea("SC6")
					DbSkip()
					Loop
				ENDIF
				
				IF (SC6->C6_EDINIC > MVXPAR13 .AND. SUBSTR(SC6->C6_PRODUTO,1,4) = MVXPAR12)
					DbSelectArea("SC6")
					DbSkip()
					Loop
				ENDIF
				
				IF (SC6->C6_EDINIC > MVXPAR15 .AND. SUBSTR(SC6->C6_PRODUTO,1,4) = MVXPAR14)
					DbSelectArea("SC6")
					DbSkip()
					Loop
				ENDIF
				
				// -----------> Valdir 08/08/03 - fim
			ENDIF      // Valdir 22/08/03
			
			MCODCLI  := SC6->C6_CLI
			MCODDEST := SC6->C6_CODDEST
			MPED     := VAL(SC6->C6_NUMANT)
			MPEDNOVO := SC6->C6_NUM
			MPEDIDO  := SC6->C6_NUM
			MITEM    := SC6->C6_ITEM
			MCOD     := SC6->C6_PRODUTO
			MVALOR   := round(SC6->C6_VALOR / SC6->C6_QTDVEN,4) // SC6->C6_VALOR //20110718
			MTES     := SC6->C6_TES
			MCF      := ALLTRIM(SC6->C6_CF)
			MSITUAC  := SC6->C6_SITUAC
			MPEDRENOV:= SC6->C6_PEDREN                                     
			MNOTA	 := SC6->C6_NOTA    //20050609
			MSERIE	 := SC6->C6_SERIE  //20050609
			MTIPOREV := SC6->C6_TIPOREV //20110921
			MDTPG    := stod("")
			MDTSUSP  := stod("")
			MDTCIRC1 := stod("")
			MDTCIRC2 := stod("")
			MDTINCL  := stod("")         // 18/06/03
			MFATOR   := 0
			MPAGO    := 0
			MPARC    := 0
			MPER     := 0
			MVENC    := 0
			MEDSUSP  := 0
			MABERTO  := 0
			MPREFIXO := " "
			MCLIFAT  := " "
			MPARCELA := " "
			MMUMERO  := " "
			MTIPO    := " "
			MMOTBX   := " "
			MGRAT    := " "
			MMOTIVO  := " "
			MDUPL    := " "
			MPORTE   := " "
			MPAGA1   := " "
			IF SUBS(SC6->C6_PRODUTO,1,2) <> '17' .AND. MEMPRESA == '02'
				MCODREV := '9999'
			ELSE
				MCODREV := SUBS(SC6->C6_PRODUTO,1,4)
			ENDIF
			
			MEDIN    := SC6->C6_EDINIC
			MEDFIN   := SC6->C6_EDFIN
			MEDVENC  := SC6->C6_EDVENC
			MEDSUSP  := SC6->C6_EDSUSP
			MQTDEX   := (SC6->C6_EDVENC)-(SC6->C6_EDINIC) + 1
			MPORTE   := SC6->C6_TPPORTE
			MDTINCL  := SC6->C6_DATA     // 18/06/03
			NASSQTD	 := SC6->C6_QTDVEN // 20050329
			NCONTQTD :=  1 //20050329 CONTAGEM DE IMPRESSAO DA QUANTIDADE
			
			DbSelectArea("SB1")
			DbSetOrder(1)
			DbSeek(xFilial("SB1")+SC6->C6_PRODUTO)
			If SB1->B1_GRUPO == '0101'
				DbSelectArea("SC6")
				DbSkip()
				Loop
			EndIf
			
			DbSelectArea("SC5")
			DbSetOrder(1)
			DbSeek(xFilial("SC5")+SC6->C6_NUM,.T.)
			
			MCLIFAT := SC5->C5_CLIFAT
			
			DbSelectArea("SZ9")
			DbSetOrder(1)
			DbSeek(xFilial("SZ9")+SC5->C5_TIPOOP,.T.)
			MPAGA1:=SZ9->Z9_PAGA1
			
			
			DbSelectArea("SF4")
			DbSetOrder(1)
			DbSeek(xFilial("SF4")+SC6->C6_TES)
			MDUPL := SF4->F4_DUPLIC
			If SF4->F4_DUPLIC == 'N'
				IF 'CORTESIA'$(SF4->F4_TEXTO) .OR. 'DOACAO'$(SF4->F4_TEXTO)
					mGrat := 'S'
				Endif
			EndIf
			
			IF MVXPAR17 == 2 .OR. MVXPAR17 == 3
				//��������������������������������������������������������������Ŀ
				//�  VERIFICA INADIMPLENCIA.                                     �
				//�  ATUALIZA O CAMPO SITUAC NO ARQUIVO TEMPORARIO  E NO SC6     �
				//����������������������������������������������������������������
				IF MGRAT <> 'S'
					IF MSITUAC == 'AA' .OR. MSITUAC == 'SI' .OR. MSITUAC == '  '
						DBSELECTAREA("SE1")
						DbOrderNickName("E1_PEDIDO") //dbSetOrder(27) 20130225  ///dbSetOrder(15) AP5 //20090114 era(21) //20090723 mp10 era(22)//dbSetOrder(26) 20100412
						//DBGOTOP()
						If DBSEEK(XFILIAL("SE1")+MPEDIDO)
							WHILE !Eof() .and. SE1->E1_PEDIDO == MPEDIDO
								MPARC     := MPARC+1
								If MPAGA1=='S' .AND. SE1->E1_PARCELA $ (" /A")
									MDTPG:= SE1->E1_EMISSAO
								Else
									MDTPG:= SE1->E1_BAIXA
								Endif
								MPREFIXO  := SE1->E1_PREFIXO
								MPARCELA  := SE1->E1_PARCELA
								MNUMERO   := SE1->E1_NUM
								MTIPO     := SE1->E1_TIPO
								MMOTBX    := "  "
								
								IF MCLIFAT <> " "  
								   	MCONDICAO := MPREFIXO+MNUMERO+MPARCELA+MTIPO+MCLIFAT
								ELSE   	
								    MCONDICAO := MPREFIXO+MNUMERO+MPARCELA+MTIPO+MCODCLI
								ENDIF       
																
								IF DTOC(MDTPG) <> '  /  /  ' .AND. SE1->E1_SALDO==0;
									.AND.!'LP' $(SE1->E1_MOTIVO);
									.AND.!'CAN'$(SE1->E1_MOTIVO);
									.AND.!'DEV'$(SE1->E1_MOTIVO)
									
									DBSELECTAREA("SE5")
									DBSETORDER(7)
									//	DBGOTOP()
									If DBSEEK(XFILIAL("SE5")+MCONDICAO)
										WHILE !Eof() .and. SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+;
											SE5->E5_TIPO+SE5->E5_CLIFOR == MCONDICAO
											IF SE5->E5_RECPAG=='R'
												MMOTBX := SE5->E5_MOTBX
											ENDIF
											DbSelectArea("SE5")
											DbSKIP()
										END
									ENDIF
									IF MMOTBX<>'CAN' .AND. MMOTBX<>'DEV' .AND. MMOTBX<>'LP'
										MPAGO   := MPAGO+1
									ELSE
										MABERTO := MABERTO+1
										MMOTIVO := SUBS(SE5->E5_MOTBX,1,2)
									ENDIF
								Else
									IF SE1->E1_VENCTO+30 < dDataBase //30 DIAS P/ PROCESSO DE COBRANCA
										MABERTO:=MABERTO+1
										IF 'LP' $(SE1->E1_MOTIVO).OR.;
											'CAN'$(SE1->E1_MOTIVO).OR.;
											'DEV'$(SE1->E1_MOTIVO)
											MMOTIVO := SUBS(SE1->E1_MOTIVO,1,2)
										ENDIF
									ENDIF
								ENDIF
								DBSELECTAREA("SE1")
								DbSkip()
							END
							MFATOR := MPAGO/MPARC
						ELSE
							MFATOR  := 1
							MSITUAC := 'AA'
							MEDSUSP := MEDVENC
						ENDIF
						
						IF MFATOR < 1 .AND. MABERTO <> 0
							MVENC   := MQTDEX*MFATOR
							MEDSUSP := MEDIN+MVENC
							DBSELECTAREA("SZJ")
							//DBGOTOP()
							DbSetOrder(1)
							If DBSEEK(xFILIAL("SZJ")+MCODREV+STR(MEDSUSP,4,0))
								MDTSUSP := SZJ->ZJ_DTCIRC
							ENDIF
						ENDIF
						
						IF MABERTO<>0
							DO CASE
								CASE MONTH(MDTSUSP) < MONTH(DDATABASE) .AND. YEAR(MDTSUSP) <= YEAR(DDATABASE) .AND. EMPTY(MMOTIVO)
									MSITUAC := 'SI'
									
								CASE MONTH(MDTSUSP) > MONTH(DDATABASE) .AND. YEAR(MDTSUSP) >= YEAR(DDATABASE) .AND. EMPTY(MMOTIVO)
									MSITUAC := 'AA'
									
								CASE !EMPTY(MMOTIVO)
									MSITUAC := MMOTIVO
							ENDCASE
						ELSE
							MSITUAC := 'AA'
							MEDSUSP := MEDVENC
						ENDIF
						
						//14/09/01: ROTINA INSERIDA POR RAQUEL P/ TRATAR OS ITENS DA CONVERSAO
						IF MEMPRESA == '01'
							IF SC6->C6_TES == '700' .OR. SC6->C6_TES == '701'
								MSITUAC := SC6->C6_SITUAC
								MEDSUSP := SC6->C6_EDSUSP
							ENDIF
						ENDIF
						RECLOCK('SC6',.F.)
						REPLACE C6_SITUAC WITH MSITUAC
						REPLACE C6_EDSUSP WITH MEDSUSP
						MSUNLOCK()
					ENDIF
				ELSE
					IF MEMPRESA == '01'
						IF SC6->C6_TES == '700' .OR. SC6->C6_TES == '701'
							MSITUAC := SC6->C6_SITUAC
							MEDSUSP := SC6->C6_EDSUSP
						ELSE
							MEDSUSP := SC6->C6_EDVENC
							MSITUAC := SC6->C6_SITUAC
						ENDIF
					ENDIF
					IF MSITUAC == 'AA' .OR. MSITUAC == ' '
						RECLOCK('SC6',.F.)
						REPLACE C6_SITUAC WITH MSITUAC
						REPLACE C6_EDSUSP WITH MEDSUSP
						MSUNLOCK()
					ENDIF
				ENDIF
			ENDIF
			MCONTA++
			RELACIONA()
			GRAVA_TEMP()
			DbSelectArea('SC6')
			DbSkip()
		End
	Endif
	
	If MNUMED == MQTREV
		Exit
	Endif
End
Return

//���������Ŀ
//�Relaciona�
//�����������
Static Function Relaciona()
Local aArea    := GetArea()
Local aAreaSC5, aAreaSA3, aAreaSA1, aAreaSZO

MNOVOVEND := ' '
MNOVAREG  := ' '
MPEDIDO   := ' '
MVEND     := ' '
MEQUIPE   := ' '
MREGIAO   := ' '
MNOMEVEND := ' '
MREGREN   := ' '
MCEP      := ' '
MNOME     := ' '
MEST      := ' '
MDESCR:=' '

If MPED <> 0
	MPEDIDO := SC6->C6_NUMANT
Else
	MPEDIDO := SC6->C6_NUM
Endif

DbSelectArea("SC5")
aAreaSC5 := GetArea()
DbSetOrder(1)
If DbSeek(xFilial("SC5")+MPEDNOVO)
	MVEND := SC5->C5_VEND1
Endif
RestArea(aAreaSC5)

DbSelectArea("SA3")
aAreaSA3 := GetArea()
DbSetOrder(1)
If DbSeek(xFilial("SA3")+MVEND)
	MEQUIPE   := SA3->A3_EQUIPE
	MREGIAO   := SA3->A3_REGIAO
	MNOMEVEND := SA3->A3_NOME
	MREGREN   := SA3->A3_REGREN
Endif
RestArea(aAreaSA3)

IF MVXPAR17 == 2
	MREGREN := 'S'
ENDIF

DbSelectArea("SA1")
aAreaSA1 := GetArea()
DbSetOrder(1)
If DbSeek(xFilial("SA1")+MCODCLI)
	MCEP     := SA1->A1_CEP
	MEST     := SA1->A1_EST
	MNOME    := SA1->A1_NOME
	MCODATIV := SA1->A1_ATIVIDA
Endif
RestArea(aAreaSA1)

DbSelectArea("SB1")
aAreaSB1 := GetArea()
DbSetOrder(1)
If DbSeek(xFilial("SB1")+MCOD)
	MDESCR     := SB1->B1_DESC
Endif
RestArea(aAreaSB1)

IF MCODDEST # ' '
	DbSelectArea("SZO")
	DbSetOrder(1)
	If DbSeek(xFilial("SZO")+MCODCLI+MCODDEST)
		MCEP := SZO->ZO_CEP
		MEST := SZO->ZO_ESTADO
	Endif
Endif

IF MVXPAR18 == 1
	IF SUBS(MCF,2,2) == '99' .and. MDUPL == 'N'
		MNOVAREG  := MREGIAO
		MNOVOVEND := MVEND
	ENDIF
	
	IF MREGREN == 'N' .AND. VAL(MNOVAREG) == 0
		MNOVAREG  := MREGIAO
		MNOVOVEND := MVEND
		IF MVXPAR16 == 2
			MNOVOVEND := '999999'
			MNOVAREG  := '999'
		ENDIF
	ENDIF
	
	IF MREGREN == 'S' .AND. MVXPAR16 == 2 .AND. VAL(MNOVAREG) == 0
		MNOVOVEND := '999998'
		MNOVAREG  := '998'
		MEQUIPE   := '   '
	ENDIF
	
	IF VAL(MNOVAREG) == 0
		DbSelectArea("SZL")
		DbSetOrder(1)
		DbSeek(xFilial("SZL")+MREGIAO)
		MCEPINI  := SZL->ZL_CEPINI
		MCEPFIN  := SZL->ZL_CEPFIN
		MNOVAREG := '   '
		
		If Found() .And. VAL(MCEP) >= VAL(MCEPINI) .AND. VAL(MCEP) <= VAL(MCEPFIN)
			MNOVAREG  := MREGIAO
			MNOVOVEND := '999999'
			MEQUIPE   := '   '
		Else
			DbSelectArea("SZL")
			DbGotop()
			While !eof()
				MCEPINI := SZL->ZL_CEPINI
				MCEPFIN := SZL->ZL_CEPFIN
				
				If VAL(MCEP) >= VAL(MCEPINI) .AND. VAL(MCEP) <= VAL(MCEPFIN)
					MNOVAREG  := SZL->ZL_CODREG
					MNOVOVEND := '999999'
					MEQUIPE   := '   '
					Exit
				Endif
				
				DbSkip()
				Loop
			End
		ENDIF
	ENDIF
	IF VAL(MNOVAREG) == 0
		MNOVAREG  := '001'
		MNOVOVEND := '999999'
		MEQUIPE   := '     '
	ENDIF
	IF MNOVAREG == MREGIAO
		MNOVOVEND := MVEND
	ENDIF
ENDIF

IF MVXPAR17 == 1 .OR. MVXPAR17 == 2 .OR. MVXPAR17 == 3
	MNOVOVEND := '999999'
	MEQUIPE   := '    '
ENDIF

IF MVXPAR18 == 2
	MNOVOVEND := '999999'
	MNOVAREG  := '999'
ENDIF
IF ALLTRIM(SA3->A3_EQUIPE) == 'PROFISSIONAIS' .AND. MVXPAR17 <> 3
	MNOVOVEND := '999997'
	MNOVAREG  := '997'
ENDIF
RestArea(aArea)
RETURN

//���������������������
//�Funcao Grava_temp()�
//���������������������
Static Function GRAVA_TEMP()
//20030704 : INSERIDO POR DANILO
IF DTOS(SC6->C6_DATA) < '20030301' .AND. Mgrat <> "S" .AND. MEMPRESA = "01"
	RETURN
ELSE
	WHILE (NCONTQTD <= NASSQTD) //20050329
		dbSelectArea("PFAT058")
		Reclock("PFAT058",.T.)
		replace NUMPED   With  MPEDIDO
		replace ITEM     With  MITEM
		replace CODCLI   With  MCODCLI
		replace CODDEST  With  MCODDEST
		replace CODPROD  With  MCOD
		replace CF       With  MCF
		replace TES      With  MTES
		replace DUPL     With  MDUPL
		replace SITUAC   With  MSITUAC
		replace EQUIPE   With  MEQUIPE
		replace CEP      With  MCEP
		replace EST      With  MEST
		replace EDIN     With  MEDIN
		replace EDFIN    With  MEDFIN
		replace EDVENC   With  MEDVENC
		replace EDSUSP   With  MEDSUSP
		replace REGIAO   With  MREGIAO
		replace CODVEND  With  MVEND
		replace VALOR    With  MVALOR
		replace CODREV   With  MCODREV
		replace REGREN   With  MREGREN
		replace NOME     With  MNOME
		MREG1   := VAL(MNOVAREG)
		replace NOVAREG  With  STRZERO(MREG1,3)
		MVEND1  := VAL(MNOVOVEND)
		replace NOVOVEND With  STRZERO(MVEND1,6)
		replace EQUIPE   With  MEQUIPE
		replace CODATIV  With  MCODATIV
		replace PORTE  With    MPORTE
		replace DESCR  With    MDESCR
		replace PEDRENOV With  MPEDRENOV
		replace INCLUSAO With  MDTINCL      // 18/06/03
		REPLACE NOTA WITH MNOTA //20050609
		REPLACE SERIE WITH MSERIE //20050609  
		REPLACE TIPOREV WITH MTIPOREV //20110921
		MsUnlock()
		NCONTQTD := NCONTQTD +1 //20050329
	END
ENDIF

Return

Static FUNCTION RENOV()

//��������������������������������������������������������������Ŀ
//� Deleta renovados e preenche campo c6_pedren,c6_itemren no sc6�
//����������������������������������������������������������������
MPEDIDO  := '  '
MITEM    := '  '
MPRODUTO := '  '

DBSELECTAREA("SC6")
DbSetOrder(12)
//cIndex := CriaTrab(Nil,.F.)
//cKey   := "C6_FILIAL+C6_PEDANT+C6_ITEMANT"
//Indregua("SC6",cIndex,ckey,,,"Selecionando Registros do Arq")

DBSELECTAREA("PFAT058")
DBGOTOP()
ProcRegua(RecCount())
WHILE !EOF()
	IncProc("Atualizando Renovacoes: "+STRZERO(RECNO(),7))
	MPEDIDO  := PFAT058->NUMPED
	MITEM    := PFAT058->ITEM
	MPRODUTO := PFAT058->CODPROD
	//��������������������������������������������������������������Ŀ
	//� Procura pedido anterior no sc6   ->c6_pedant e c6_itemant    �
	//����������������������������������������������������������������
	DBSELECTAREA("SC6")
	DbSetOrder(12)
	If DbSeek(xFilial("SC6")+MPEDIDO+MITEM)
		IF VAL(SC6->C6_NUMANT)<>0
			MPED  := SC6->C6_NUMANT
		ELSE
			MPED  := SC6->C6_NUM
		ENDIF
		
		MPEDREN  := MPED
		MIT      := VAL(SC6->C6_ITEM)
		MITEMREN := STR(MIT,1)
		
		DBSELECTAREA("PFAT058")
		Reclock("PFAT058",.F.)
		DBDELETE()
		Msunlock()
	ELSE
		DBSELECTAREA("SC6")
		DBGOTOP()
		MITEMANT := '  '
		If DbSeek(xFilial("SC6")+MPEDIDO+MITEMANT)
			WHILE !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_PEDANT == MPEDIDO
				IF SUBS(SC6->C6_PRODUTO,1,4) <> SUBS(MPRODUTO,1,4)
					DbSelectArea("SC6")
					DBSKIP()
					LOOP
				ELSE
					IF VAL(SC6->C6_NUMANT)<>0
						MPED :=SC6->C6_NUMANT
					ELSE
						MPED :=SC6->C6_NUM
					ENDIF
					MPEDREN  := MPED
					MIT      := VAL(SC6->C6_ITEM)
					MITEMREN := STR(MIT,1)
					
					DBSELECTAREA("PFAT058")
					Reclock("PFAT058",.F.)
					DBDELETE()
					Msunlock()
					EXIT
				ENDIF
			END
		ENDIF
	ENDIF
	DBSELECTAREA("PFAT058")
	DBSKIP()
END

RETURN
