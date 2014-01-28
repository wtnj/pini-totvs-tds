#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT061   ³Autor: Danilo Pala            ³ Data:  20130415  ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Gera‡Æo do arquivo de Assinantes  - tabelas de custo         ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Editora Pini  M¢dulo de Faturamento                        ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat061()
Local MEMPRESA  := SM0->M0_CODIGO
Local _cArqPath := GetMv("MV_PATHASS")
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


// PARAMETROS PINI SISTEMAS / Editora
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                     ³
//³ mv_par01             // Cod.do Produto Inicial (C-15)                    ³
//³ mv_par02             // Cod.do Produto Final   (C-15)                    ³
//³ mv_par03             // Edicao Inicial         (N-04)                    ³
//³ mv_par04             // Edicao Final           (N-04)                    ³
//³ mv_par05             // Renova‡Æo  Recupera‡Æo Automatica  Nenhum          ³
//³ mv_par06             // Cancelados Ativos-Repres Ativos-Sele‡Æo  Nenhum   ³
//³ mv_par07             // Sim  NÆo                                         ³
//³ mv_par08             // MˆesAno Renov/Rec                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg     := "PFAT061"
ValidPerg()
If !Pergunte(cPerg)
	Return
Endif

IF mv_par05 == 1 .OR. mv_par05 == 2 .OR. mv_par06 == 3
	IF EMPTY(mv_par08)
		MsgAlert("Informe MesAno da Renovacao ou Recuperacao")
		Return
	ENDIF
ENDIF

IF mv_par05 == 3 .AND. mv_par06 == 4
	ALERT("Selecione um tipo valido para gera‡ao do arquivo")
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

Processa({|| GERA()},"Aguarde...","Gerando Arquivo...",.t.)

While .T.
	cPerg     := "PFAT061"
	If !Pergunte(cPerg)
		Exit
	Endif
	If LastKey()== 27
		Exit
	Endif
	Processa({||Gera()},"Aguarde...","Gerando Arquivo de Clientes...",.t.)
END

_cString:= " "
_cSeg   := " "

If mv_par05 == 1 //Renovacao
	DbSelectArea("PFAT058")
	DbGoTop()
	_cString := _cArqPath+"RENOV"+mEmpresa+".DTC"
	_cSeg    := _cArqPath+"RN"+mEmpresa+mv_par08+".DTC"
Endif

If mv_par05 == 2 //Recuperacao
	DbSelectArea("PFAT058")
	DbGoTop()
	_cString := _cArqPath+"RENOV"+mEmpresa+".DTC"
	_cSeg    := _cArqPath+"RC"+mEmpresa+mv_par08+".DTC"
Endif

If mv_par06 == 1 //Cancelados
	DbSelectArea("PFAT058")
	DbGotop()
	_cString := _cArqPath+"ASSCANC"+Right(mEmpresa,1)+".DTC"
ElseIf mv_par06 == 2 //Ativos-Rep
	DbSelectArea("PFAT058")
	DbGotop()
	_cString := _cArqPath+"ASSAT"+mEmpresa+".DTC"
ElseIf mv_par06 == 3 //Ativos-Sel
	DbSelectArea("PFAT058")
	DbGoTop()
	_cString := _cArqPath+"ASSSEL"+mEmpresa+".DTC"
Endif

If mEmpresa == "01" .or. mEmpresa== "02" .and. !Empty(_cString)
	COPY TO &_cString 
	If !Empty(_cSeg)
		COPY TO &_cSeg 
	Endif
	_cMsg := "Arquivo Gerado com Sucesso em: "+_cString
	MsgInfo(_cMsg)
Endif

DbSelectArea("PFAT058")
DbCloseArea()

Return



//************************************************************
//Gera()
//************************************************************
Static Function GERA()
Local cQuery := ""

cQuery := "SELECT C6_CLI, C6_CODDEST, C6_NUMANT, C6_NUM, C6_ITEM, C6_PRODUTO, C6_VALOR , C6_QTDVEN, C6_TES, C6_CF, C6_SITUAC, C6_PEDREN, C6_NOTA, C6_SERIE, C6_TIPOREV, C6_EDINIC, C6_EDFIN, C6_EDVENC, C6_EDSUSP, C6_TPPORTE, C6_DATA, C5_NUM, C5_CLIFAT, C5_TIPOOP, C5_VEND1, B1_COD, B1_DESC" 
cQuery += " FROM "+ RetSqlName("SC6") +" SC6 "
cQuery += " LEFT OUTER JOIN "+ RETSQLNAME("SC5") +" SC5 ON (SC5.C5_FILIAL='"+ xFilial("SC5") +"' AND SC6.C6_NUM = SC5.C5_NUM AND SC6.C6_CLI=SC5.C5_CLIENTE AND SC5.D_E_L_E_T_<>'*' AND C5_IDENTIF<>'MIGRADO ')"
cQuery += " LEFT OUTER JOIN "+ RETSQLNAME("SB1") +" SB1 ON (SB1.B1_FILIAL='"+ xFilial("SB1") +"' AND SC6.C6_PRODUTO = SB1.B1_COD AND SB1.D_E_L_E_T_<>'*' AND B1_GRUPO<>'0101')"
cQuery += " WHERE C6_FILIAL='"+ xFilial("SC6") +"' AND C6_PRODUTO >= '"+ mv_par01 + "' AND C6_PRODUTO <= '" + mv_par02 + "' AND SC6.D_E_L_E_T_<>'*'"
If MV_PAR05==1 .OR. MV_PAR05==2 //renovacao ou Recuperacao
	cQuery += " AND C6_EDVENC<>9999 AND C6_PEDREN='      ' AND C6_EDSUSP="+ mv_par03 +" AND C6_EDINIC<="+ mv_par03 +" AND C6_EDSUSP<>C6_EDINIC"
ElseIf MV_PAR06==1 //Cancelados 
	cQuery += " AND C6_EDVENC<>9999 AND C6_PEDREN='      ' AND C6_EDSUSP="+ mv_par03 +" AND C6_EDINIC<="+ mv_par03
ElseIf MV_PAR06==2 .or.  MV_PAR06==3 //Ativos-Rep ou Ativos-Sel 
	cQuery += " AND C6_EDVENC<>9999 AND C6_EDFIN<>9999 AND C6_EDINIC<>9999 AND C6_EDVENC>="+ mv_par04
Endif
cQuery += " AND TRIM(C5_IDENTIF)<>'MIGRADO'"
cQuery += " ORDER BY C6_PRODUTO"

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "SC6CONS", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
TcSetField("SC6CONS","C6_DATA"   ,"D")
DbSelectArea("SC6CONS")
DbGotop()
ProcRegua(Reccount()) 
While !Eof() 
		
	IncProc("Produto: "+Alltrim(SC6CONS->C6_PRODUTO)+"-"+Alltrim(SC6CONS->C6_NUM))
				
	MCODCLI  := SC6CONS->C6_CLI
	MCODDEST := SC6CONS->C6_CODDEST
	MPED     := VAL(SC6CONS->C6_NUMANT)
	MPEDNOVO := SC6CONS->C6_NUM
	MPEDIDO  := SC6CONS->C6_NUM
	MITEM    := SC6CONS->C6_ITEM
	MCOD     := SC6CONS->C6_PRODUTO
	MVALOR   := round(SC6CONS->C6_VALOR / SC6CONS->C6_QTDVEN,4)
	MTES     := SC6CONS->C6_TES
	MCF      := ALLTRIM(SC6CONS->C6_CF)
	MSITUAC  := SC6CONS->C6_SITUAC
	MPEDRENOV:= SC6CONS->C6_PEDREN                                     
	MNOTA	 := SC6CONS->C6_NOTA
	MSERIE	 := SC6CONS->C6_SERIE
	MTIPOREV := SC6CONS->C6_TIPOREV
	MDTPG    := stod("")
	MDTSUSP  := stod("")
	MDTCIRC1 := stod("")
	MDTCIRC2 := stod("")
	MDTINCL  := stod("")
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
	IF SUBS(SC6CONS->C6_PRODUTO,1,2) <> '17'
		MCODREV := '9999'
	ELSE
		MCODREV := SUBS(SC6CONS->C6_PRODUTO,1,4)
	ENDIF
	MEDIN    := SC6CONS->C6_EDINIC
	MEDFIN   := SC6CONS->C6_EDFIN
	MEDVENC  := SC6CONS->C6_EDVENC
	MEDSUSP  := SC6CONS->C6_EDSUSP
	MQTDEX   := (SC6CONS->C6_EDVENC)-(SC6CONS->C6_EDINIC) + 1
	MPORTE   := IIF(Empty(SC6CONS->C6_TPPORTE),"0",SC6CONS->C6_TPPORTE)
	MDTINCL  := SC6CONS->C6_DATA
	NASSQTD  := SC6CONS->C6_QTDVEN
	NCONTQTD :=  1
	
			
	If !Empty(SC6CONS->C5_NUM)
		MCLIFAT := SC6CONS->C5_CLIFAT
	
		DbSelectArea("SZ9")
		DbSetOrder(1)
		DbSeek(xFilial("SZ9")+SC6CONS->C5_TIPOOP,.T.)
		MPAGA1:=SZ9->Z9_PAGA1	
	Endif
			
	DbSelectArea("SF4")
	DbSetOrder(1)
	If DbSeek(xFilial("SF4")+SC6CONS->C6_TES)
		MDUPL := SF4->F4_DUPLIC
		mGrat := 'N'
		If SF4->F4_DUPLIC == 'N'
			IF 'CORTESIA'$(SF4->F4_TEXTO) .OR. 'DOACAO'$(SF4->F4_TEXTO)
				mGrat := 'S'
			ENDIF
		EndIf
	EndIf
			
	IF MV_PAR06 == 2 .OR. MV_PAR06 == 3
		//************************************************************
		//  VERIFICA INADIMPLENCIA
		//  ATUALIZA O CAMPO SITUAC NO ARQUIVO TEMPORARIO  E NO SC6
		//************************************************************
		IF MGRAT <> 'S'
			IF MSITUAC == 'AA' .OR. MSITUAC == 'SI' .OR. MSITUAC == '  '
				DBSELECTAREA("SE1")
				DbOrderNickName("E1_PEDIDO")
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
							If DBSEEK(XFILIAL("SE5")+MCONDICAO)
								WHILE !Eof() .and. SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+;
									SE5->E5_TIPO+SE5->E5_CLIFOR == MCONDICAO
									IF SE5->E5_RECPAG=='R'
										MMOTBX := SE5->E5_MOTBX
									ENDIF
									DbSelectArea("SE5")
									DbSKIP()
								END
							EndIf
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
					END //while SE1
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
				
				//TRATAR OS ITENS DA CONVERSAO
				IF MEMPRESA == '01'
					IF SC6CONS->C6_TES == '700' .OR. SC6CONS->C6_TES == '701'
						MSITUAC := SC6CONS->C6_SITUAC
						MEDSUSP := SC6CONS->C6_EDSUSP
					ENDIF
				ENDIF
				cQuery := "UPDATE "+ RetSqlName("SC6") +" SET C6_SITUAC='"+ MSITUAC +"', C6_EDSUSP="+ alltrim(str(MEDSUSP)) +" WHERE C6_FILIAL='"+ XFILIAL("SC6") + "' AND C6_NUM='"+ SC6CONS->C6_NUM +"' AND C6_ITEM='"+ SC6CONS->C6_ITEM +"' AND D_E_L_E_T_<>'*' AND C6_PRODUTO='"+ SC6CONS->C6_PRODUTO +"'"
				nUpd :=	TCSQLExec(cQuery)
			ENDIF
		ELSE //gratuita
			IF MEMPRESA == '01'
				IF SC6CONS->C6_TES == '700' .OR. SC6CONS->C6_TES == '701'
					MSITUAC := SC6CONS->C6_SITUAC
					MEDSUSP := SC6CONS->C6_EDSUSP
				ELSE
					MEDSUSP := SC6CONS->C6_EDVENC
					MSITUAC := SC6CONS->C6_SITUAC
				ENDIF
			ENDIF
			IF MSITUAC == 'AA' .OR. MSITUAC == ' '
				cQuery := "UPDATE "+ RetSqlName("SC6") +" SET C6_SITUAC='"+ MSITUAC +"', C6_EDSUSP="+ alltrim(str(MEDSUSP)) +" WHERE C6_FILIAL='"+ XFILIAL("SC6") + "' AND C6_NUM='"+ SC6CONS->C6_NUM +"' AND C6_ITEM='"+ SC6CONS->C6_ITEM +"' AND D_E_L_E_T_<>'*' AND C6_PRODUTO='"+ SC6CONS->C6_PRODUTO +"'"
				nUpd :=	TCSQLExec(cQuery)
			ENDIF
		ENDIF
	ENDIF
	MCONTA++
	RELACIONA()
	GRAVA_TEMP()
	DbSelectArea('SC6CONS')
	DbSkip()
		
	/*If MNUMED == MQTREV
		Exit
	Endif*/
End //while SC6CONS
DbSelectArea("SC6CONS")
DBCloseArea()
Return




//************************************************************
//Relaciona
//************************************************************
Static Function Relaciona()
Local aArea    := GetArea()

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

//If MPED <> 0
//	MPEDIDO := SC6CONS->C6_NUMANT
//Else
	MPEDIDO := SC6CONS->C6_NUM
//Endif

If !Empty(SC6CONS->C5_VEND1)
	MVEND := SC6CONS->C5_VEND1
Else
	MVEND := ""
Endif


DbSelectArea("SA3")
DbSetOrder(1)
If DbSeek(xFilial("SA3")+MVEND)
	MEQUIPE   := SA3->A3_EQUIPE
	MREGIAO   := SA3->A3_REGIAO
	MNOMEVEND := SA3->A3_NOME
	MREGREN   := SA3->A3_REGREN
Endif


IF MV_PAR06 == 2
	MREGREN := 'S'
ENDIF

DbSelectArea("SA1")
DbSetOrder(1)
If DbSeek(xFilial("SA1")+MCODCLI)
	MCEP     := SA1->A1_CEP
	MEST     := SA1->A1_EST
	MNOME    := SA1->A1_NOME
	MCODATIV := SA1->A1_ATIVIDA
Endif

If !Empty(SC6CONS->B1_COD)
	MDESCR     := SC6CONS->B1_DESC
Endif


IF !Empty(MCODDEST)
	DbSelectArea("SZO")
	DbSetOrder(1)
	If DbSeek(xFilial("SZO")+MCODCLI+MCODDEST)
		MCEP := SZO->ZO_CEP
		MEST := SZO->ZO_ESTADO
	Endif
Endif

IF MV_PAR07 == 1 //SIM
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
	
	IF MREGREN == 'S' .AND. MV_PAR05 == 2 .AND. VAL(MNOVAREG) == 0
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
ELSE //NAO
	MNOVOVEND := '999999'
	MNOVAREG  := '999'
ENDIF

IF MV_PAR06 == 1 .OR. MV_PAR06 == 2 .OR. MV_PAR06 == 3
	MNOVOVEND := '999999'
	MEQUIPE   := '    '
ENDIF

IF ALLTRIM(SA3->A3_EQUIPE) == 'PROFISSIONAIS' .AND. MV_PAR06 <> 3
	MNOVOVEND := '999997'
	MNOVAREG  := '997'
ENDIF
RETURN



//************************************************************
//Funcao Grava_temp()
//************************************************************
Static Function GRAVA_TEMP()
IF DTOS(SC6CONS->C6_DATA) < '20030301' .AND. Mgrat <> "S" .AND. MEMPRESA = "01"
	RETURN
ELSE
	WHILE (NCONTQTD <= NASSQTD)
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


//************************************************************
//ValidPerg()
//************************************************************
Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
aAdd(aRegs,{cPerg,"01","Produto de?","Produto de?","Produto de?","mv_ch1","C",15,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","","",""})
aAdd(aRegs,{cPerg,"02","Produto ate?","Produto ate?","Produto ate?","mv_ch2","C",15,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","","",""})
aAdd(aRegs,{cPerg,"03","Edicao de?","Edicao de?","Edicao de?","mv_ch3","C",15,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","","",""})
aAdd(aRegs,{cPerg,"04","Edicao ate?","Edicao ate?","Edicao ate?","mv_ch4","C",15,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","","",""})
aAdd(aRegs,{cPerg,"05","Tipo","Tipo","Tipo","mv_ch5","N",01,0,2,"C","","MV_PAR05","Renovacao","Renovacao","Renovacao","","","Recuperacao","Recuperacao","Recuperacao","","","Nenhum","Nenhum","Nenhum","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","Ou","Ou","Ou","mv_ch6","N",01,0,2,"C","","MV_PAR06","Cancelados","Cancelados","Cancelados","","","Ativos-Rep","Ativos-Rep","Ativos-Rep","","","Ativos-Sel","Ativos-Sel","Ativos-Sel","","","Nenhum","Nenhum","Nenhum","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","Trata Nova Regiao?","Trata Nova Regiao?","Trata Nova Regiao?","mv_ch7","N",01,0,2,"C","","MV_PAR06","Sim","Sim","Sim","","","Nao","Nao","Nao","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"08","MesAno da Renov/Rec?","MesAno da Renov/Rec?","MesAno da Renov/Rec?","mv_ch8","C",4,0,0,"G","","MV_PAR08","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

_nLimite := If(Len(aRegs[1])<FCount(),Len(aRegs[1]),FCount())
For i := 1 To Len(aRegs)
	If !DbSeek(cPerg + aRegs[i,2])
		Reclock("SX1", .T.)
		For j := 1 to _nLimite
			FieldPut(j, aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next
DbSelectArea(_sAlias)

Return(.T.)
