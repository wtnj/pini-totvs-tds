#include "rwmake.ch"    // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/ Alterado por Danilo C S Pala. 20050311
// danilo 20051110: Valdeir: alteracoes no layout exclusao da tes   
//20060315: Danilo C S Pala, inclusao dos dados de endere็amento para DNE
//20060406: Danilo C S Pala, consistencias para o encarte da entrega direta dos correios
//20060829: DANILO C S PALA: CONSISTENCIA BRASIL/EXTERIOR
//20080619 Danilo C S Pala: consistencia de enderecamento para postagem nos correios
//20090401 Danilo C S Pala: nao considerar avulsas
//20100729 Danilo C S Pala: Nome Fantasia no lugar do CliFat=ZN_NFANTAS
//20101029 Danilo C S Pala: Consistencia do estado e municipio do destinatario/cliente
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ฑฑ
ฑฑณPrograma: TRANSFO2  ณAutor: Raquel Ramalho         ณ Data:   01/06/03 ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณDescriao: Geracao do arquivo texto para Distribuidora                ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณUso      : Mขdulo de Faturamento                                      ณ ฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู ฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function Rfat112()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CLIE_DEST,CDESC1,CDESC2,CDESC3,MDESCR,CPERG")
SetPrvt("LCONTINUA,MV_PAR01,MAMPL,PORTE3,PORTE6,CANC")
SetPrvt("TOTETIQ,MDESCR1,MDESCR2,MDESCR3,_ARQE,_ARQC")
SetPrvt("_ACAMPOS,_CNOME,_CFILTRO,CINDEX,CKEY,XCONT")
SetPrvt("NPARC,NPARCVV,NPARCPG,NPARCAV,MPRODUTO,RESTO")
SetPrvt("MREVISTA,MNAO,MPORTE,MCLIENTE,MCODDEST,MPEDIDO")
SetPrvt("MORIGEM,MPEDANT,MITEMANT,MEDISA,MITEM,MEDINIC")
SetPrvt("MEDFIN,MEDSUSP,MEDVENC,MSITUAC,MTES,MCF")
SetPrvt("MNOTA,MSERIE,MCOMPL,CLIE_NOME,MEND,MBAIRRO")
SetPrvt("MMUN,MEST,MCEP,MFONE,MD,NEX,ATIVIDADE")
SetPrvt("ACHOU,MMOTIVO,EXSUSP,_ARQ,_ARQP,_SALIAS")
SetPrvt("AREGS,I,J,mGrat,CONTROLE, nqtd")
SetPrvt("MTPLOG, MLOGR, MNLOGR, MNCLOGR, BIntervalo, mAnunciante, _ARQALERTA, CONTALERTA")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ mv_par01             // Cod.da Revista                       ณ
//ณ mv_par02             // Edicao                               ณ
//ณ mv_par03             // Ampliada                             ณ
//ณ mv_par04             // Au Mais                              ณ
//ณ mv_par05             // Paga   Cortesia                      ณ
//ณ mv_par06             // Da atividade                         ณ
//ณ mv_par07             // Ate atividade                        ณ
//| mv_par08			 // Intervalo de CEP: DEntro/Fora/Ignorar|
//ณ mv_par09             // CEP de 								 ณ
//ณ mv_par10             // CEP ate		                         ณ
//ณ mv_par11             // Tipo de periodico                    ณ
//ณ mv_par12             // Tipo de periodico                    ณ  
//ณ mv_par13             // Brasil/Exterior	                     ณ  
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
CLIE_DEST:=SPACE(40)
cDesc1 :=PADC("Este programa ira gerar o arquivo para Intercourier" ,74)
cDesc2 :="  "
cDesc3 :=""

mDESCR :="  "
CONTROLE := ""
cPerg:="SAN017"
BIntervalo := .T.

//_ValidPerg()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica as perguntas selecionadas                                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !Pergunte(cPerg)
	Return
Endif

IF Lastkey()==27
	Return
Endif

lContinua := .T.

Processa({|| R008Proc()})

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณR008Proc()บAutor  ณMicrosiga           บ Data ณ  04/06/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณProcessamento                                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function R008Proc()

DBSELECTAREA("SZJ")
DBSETORDER(1)
If !DBSEEK(XFILIAL()+MV_PAR01+STR(MV_PAR02,4))
	Return
Endif
///*  para testes
IF SZJ->ZJ_DTCIRC < dDataBase
	MsgALERT("A DATA DA CIRCULACAO E MENOR QUE A DATA ATUAL","ATENCAO")
	If !PERGUNTE(cPerg)
		Return
	Endif
ENDIF

mv_par01 := mv_par01+space(11)
MAMPL    := SZJ->ZJ_REVAMPL
PORTE3   := 0
PORTE6   := 0
CANC     := 0
TOTETIQ  := 0
CONTALERTA := 0

IF MV_PAR05 == 1
	CONTROLE := "P"
ELSEIF MV_PAR05 == 2
	CONTROLE := "G"
ELSEIF MV_PAR05 == 3
	CONTROLE := "A" 
ENDIF

If MV_PAR04 == 1
	MDESCR1 := TRIM(ZJ_DESCR)+'MAI'
Else
	MDESCR1 := TRIM(ZJ_DESCR)
Endif

MDESCR2 :=CONTROLE+'C'+MDESCR1
MDESCR3 :=CONTROLE+'P'+MDESCR1    

MDESCR1 := CONTROLE+MDESCR1

_ARQE := MDESCR1+ALLTRIM(STR(MV_PAR02,4))+'.TXT'
_ARQC := MDESCR2+ALLTRIM(STR(MV_PAR02,4))

_aCampos := {  {"NUMPED"  ,"C",6 ,0} ,;
{"ITEM"    ,"C",2 ,0} ,;
{"CODCLI"  ,"C",6 ,0} ,;
{"PORTE"   ,"C",2 ,0} ,;
{"CODDEST" ,"C",6 ,0} ,;
{"NOME"    ,"C",40,0} ,;
{"DEST"    ,"C",40,0} ,;
{"V_END"   ,"C",40,0} ,;
{"BAIRRO"  ,"C",20,0} ,;
{"MUN"     ,"C",20,0} ,;
{"CEP"     ,"C",8 ,0} ,;
{"EST"     ,"C",2 ,2} ,; //{"TES"     ,"C",3 ,0},; // danilo 20051110: Valdeir
{"FONE"    ,"C",15,0} ,;
{"COMPL"   ,"C",30,0} ,;
{"TESP"    ,"C",3 ,0} ,;          //* so para separar pagos
{"QTD"     ,"N",5 ,0} ,;
{"TPLOG"   ,"C",15 ,0},;    //20060315 Danilo
{"LOGR"    ,"C",60 ,0},;    //20060315 Danilo
{"NLOGR"   ,"C",10 ,0},;    //20060315 Danilo
{"CLOGR"   ,"C",40 ,0},;    //20060315 Danilo
{"TPPER"   ,"C",4 ,0}}      //20060406

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"ETIQP",.F.,.F.)

_aCampos :=   {{"NAO"     ,"C",3, 0} ,;
{"NUMPED"  ,"C",6, 0} ,;
{"ITEM"    ,"C",2, 0} ,;
{"EDSUSP"  ,"N",4, 0} ,;
{"EDISA"   ,"C",6, 0} ,;
{"SITUAC"  ,"C",2, 0} ,;
{"EDINIC"  ,"N",4, 0} ,;
{"EDFIN"   ,"N",4, 0} ,;
{"EDVENC"  ,"N",4, 0} ,;
{"PRODUTO" ,"C",15,0} ,;
{"PARC"    ,"N",3, 0} ,;
{"PARCPG"  ,"N",3, 0} ,;
{"PARCVV"  ,"N",3, 0} ,;
{"PARCAV"  ,"N",3, 0} ,;
{"CF"      ,"C",4, 0} ,;
{"ORIGEM"  ,"C",2, 0} ,;
{"TES"     ,"C",3, 0}}
_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"COMPLP",.F.,.F.)

_aCampos := {  {"NUMPED"  ,"C",6, 0} ,;
{"ITEM"    ,"C",2, 0} ,;
{"CODCLI"  ,"C",6, 0} ,;
{"PORTE"   ,"C",2, 0} ,;
{"PRODUTO" ,"C",15,0} ,;
{"CODDEST" ,"C",6, 0} ,;
{"NOME"    ,"C",40,0} ,;
{"DEST"    ,"C",40,0} ,;
{"V_END"   ,"C",40,0} ,;
{"BAIRRO"  ,"C",20,0} ,;
{"MUN"     ,"C",20,0} ,;
{"CEP"     ,"C",8 ,0} ,;
{"TES"     ,"C",3 ,0} ,;
{"EST"     ,"C",2 ,2} ,;
{"TESP"     ,"C",3 ,0},;
{"TPLOG"   ,"C",15 ,0},;    //20060315 Danilo
{"LOGR"    ,"C",60 ,0},;    //20060315 Danilo
{"NLOGR"   ,"C",10 ,0},;    //20060315 Danilo
{"CLOGR"   ,"C",40 ,0},;    //20060315 Danilo
{"TPPER"   ,"C",4 ,0}}      //20060406

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PORTE3",.F.,.F.)

//20080619 daqui
_aCampos := {  {"NUMPED"  ,"C",6, 0} ,;
{"ITEM"    ,"C",2, 0} ,;
{"CODCLI"  ,"C",6, 0} ,;
{"PRODUTO" ,"C",15,0} ,;
{"CODDEST" ,"C",6, 0} ,;
{"NOME"    ,"C",40,0} ,;
{"DEST"    ,"C",40,0} ,;
{"V_END"   ,"C",40,0} ,;
{"BAIRRO"  ,"C",20,0} ,;
{"MUN"     ,"C",20,0} ,;
{"CEP"     ,"C",8 ,0} ,;
{"TES"     ,"C",3 ,0} ,;
{"EST"     ,"C",2 ,2} ,;
{"TPLOG"   ,"C",15 ,0},;
{"LOGR"    ,"C",60 ,0},;
{"NLOGR"   ,"C",10 ,0},;
{"CLOGR"   ,"C",40 ,0}}
_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"ALERTA",.F.,.F.)
//20080619 ate daqui
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Seleciona no SC6 sข assinaturas ativas (ed.inicial e final)             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DBSELECTAREA('SC6')
_cFiltro := "C6_FILIAL == '"+xFilial("SC6")+"'"
_cFiltro := _cFiltro+".and.MV_PAR01 == C6_REGCOT" 
_cFiltro := _cFiltro+".and. C6_EDINIC<=MV_PAR02 .AND.C6_EDVENC>=MV_PAR02"

CINDEX := CRIATRAB(NIL,.F.)
CKEY   := "SC6->C6_FILIAL+SC6->C6_REGCOT"
INDREGUA("SC6",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")
DBSEEK(XFILIAL()+MV_PAR01,.T.)   // Soft Seek on (.T.)

nRegs := Abs(LastRec() - Recno())+1

DBSELECTAREA("SC6")
DBGOTOP()

ProcRegua(nregs)
xcont := 0
ภWHILE !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. MV_PAR01 == SC6->C6_REGCOT
	xcont++
	IncProc("REGISTROS LIDOS "+ALLTRIM(STR(xcont,6,0)))
	nparc   := 0
	nparcvv := 0
	nparcpg := 0
	nparcav := 0
	mGrat   :=""
	mproduto:= SC6->C6_PRODUTO
	
	if sc6->c6_num=='209286'
		MsgAlert("Achou "+ sc6->c6_num)
	endif
	
	RESTO := MOD(MV_PAR02,2)
	IF RESTO == 0
		MREVISTA := 'PAR'
	ELSE
		MREVISTA := 'IMPAR'
	ENDIF
	
	IF MREVISTA == 'IMPAR' .AND. SC6->C6_TIPOREV == '1' .OR. MREVISTA == 'PAR' .AND. SC6->C6_TIPOREV == '2'
		DBSKIP()
		LOOP
	ENDIF
	
	IF SC6->C6_EDFIN=9999 .OR. SC6->C6_EDINIC=9999
		DBSKIP()
		LOOP
	ENDIF

	IF SUBSTR(SC6->C6_PRODUTO,5,3)=='001' //20090401 avulsas
		DBSKIP()
		LOOP
	ENDIF

	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Tratamento das ampliadas pelo parametro no SZJ - ZJ_REVAMPL             ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	IF MAMPL == 'N' .OR. MAMPL == ' '
		IF SUBS(SC6->C6_PRODUTO,5,3)=='008' .OR. SUBS(SC6->C6_PRODUTO,5,3)=='009';
			.OR. SUBS(SC6->C6_PRODUTO,5,3)=='010'.OR. SUBS(SC6->C6_PRODUTO,5,3)=='011'
			DBSKIP()
			LOOP
		ENDIF
	ENDIF
	
	MNAO 	:= ' '
	MPORTE   := SC6->C6_TPPORTE
	MCLIENTE := SC6->C6_CLI
	MCODDEST := SC6->C6_CODDEST
	MPEDIDO  := SC6->C6_NUM
	MORIGEM  := SC6->C6_ORIGEM
	MPEDANT  := SC6->C6_PEDANT
	MITEMANT := SC6->C6_ITEMANT
	MEDISA   := SC6->C6_NUMANT
	MITEM    := SC6->C6_ITEM
	MPRODUTO := SC6->C6_PRODUTO
	MEDINIC  := SC6->C6_EDINIC
	MEDFIN   := SC6->C6_EDFIN
	MEDSUSP  := SC6->C6_EDSUSP
	MEDVENC  := SC6->C6_EDVENC
	MSITUAC  := SC6->C6_SITUAC
	MTES     := SC6->C6_TES
	MCF      := SC6->C6_CF
	MNOTA    := SC6->C6_NOTA
	MSERIE   := SC6->C6_SERIE
	MTES     := SC6->C6_TES
	MCOMPL   := SC6->C6_OBSDISTR
   NQTD := SC6->C6_QTDVEN     //20050311
	DbSelectArea("SF4")
	DbSetOrder(1)
	DbGoTop()
	DbSeek(xFilial("SF4")+SC6->C6_TES)
	If SF4->F4_DUPLIC=='N' .OR. 'CORTESIA' $(SF4->F4_TEXTO) .OR. 'DOACAO' $(SF4->F4_TEXTO)
		mGrat:='S'
	EndIf
	
	If '651'$(SC6->C6_TES) .OR. '701'$(SC6->C6_TES) .OR. '650' $(SC6->C6_TES)
		mGrat:='S'
	ENDIF
	
	//20060406
	mAnunciante := ' '
	If '650' $(SC6->C6_TES)
		mAnunciante := 'S' 
	Else
		mAnunciante := 'N' 
	ENDIF 
	
	if mAnunciante == 'N' .and. mv_par12 ==1 //anunciante sim
		DBSELECTAREA("SC6")
		DBSKIP()
		LOOP
	elseif mAnunciante == 'S' .and. mv_par12 ==2 //anunciante nao
		DBSELECTAREA("SC6")
		DBSKIP()
		LOOP
	endif
	//20060406 ATE AQUI
	
	If MV_PAR05 == 2 .and. mGrat <> 'S'
		DBSELECTAREA("SC6")
		DBSKIP()
		LOOP
	ENDIF
	
	If MV_PAR05 == 1 .and. mGrat == 'S'
		DBSELECTAREA("SC6")
		DBSKIP()
		LOOP
	ENDIF
	
	If MV_PAR05 == 1 .and. DTOS(SC6->C6_DATA)<'20030301'
	   DBSELECTAREA("SC6")
	   DBSKIP()
	   LOOP
	ENDIF
	
	DBSELECTAREA("SA1")
	DBSETORDER(1)
	IF DBSEEK(XFILIAL()+MCLIENTE)
		CLIE_NOME:=SA1->A1_NOME
	ELSE
		CLIE_NOME:='  '
	ENDIF

	IF	MV_PAR13 == 1 .AND. SA1->A1_EST =="EX"  // BRASIL //20060829	
		DBSELECTAREA("SC6")
	   	DBSKIP()
	   	LOOP
	ELSEIF  MV_PAR13 == 2 .AND. SA1->A1_EST <>"EX" // EXTERIOR
		DBSELECTAREA("SC6")
	   	DBSKIP()
	   	LOOP
	ENDIF //20060829 ATE AKI
	
	MEND      := SA1->A1_END
	MBAIRRO   := SA1->A1_BAIRRO
	MMUN      := SA1->A1_MUN
	MEST      := SA1->A1_EST
	MCEP      := SA1->A1_CEP
	MFONE     := SA1->A1_TEL
	ATIVIDADE := SA1->A1_ATIVIDA
	CLIE_DEST := SPACE(40)
	MTPLOG	  := SA1->A1_TPLOG  //20060315 DANILO
	MLOGR	  := SA1->A1_LOGR   //20060315 DANILO
	MNLOGR	  := SA1->A1_NLOGR  //20060315 DANILO
	MCLOGR	  := SA1->A1_COMPL  //20060315 DANILO

	
	IF MCODDEST # ' '
		DBSELECTAREA("SZN")
		IF DBSEEK(XFILIAL()+MCLIENTE+MCODDEST)
			CLIE_DEST:=SZN->ZN_NOME  
			//DAQUI 20100729
			IF SZN->ZN_FLAGFAN =="S" 
				CLIE_NOME := SZN->ZN_NFANTAS
			ENDIF // ATE AQUI 20100729
		ENDIF
		DBSELECTAREA("SZO")
		IF DBSEEK(XFILIAL()+MCLIENTE+MCODDEST)
			MEND    := SZO->ZO_END
			MBAIRRO := SZO->ZO_BAIRRO
			MMUN    := SZO->ZO_CIDADE
			MEST    := SZO->ZO_ESTADO
			MCEP    := SZO->ZO_CEP
			MFONE   := SZO->ZO_FONE
			MTPLOG	:= SZO->ZO_TPLOG  //20060315 DANILO
			MLOGR	:= SZO->ZO_LOGR   //20060315 DANILO
			MNLOGR	:= SZO->ZO_NLOGR  //20060315 DANILO
			MCLOGR	:= SZO->ZO_COMPL  //20060315 DANILO
		ENDIF
	ENDIF                             
	
	//20060406: verifica se o intervalo de CEP eh valido
	if mv_par08 == 1 //dentro
		if MCEP >= mv_par09 .and. MCEP <= mv_par10
			BIntervalo := .T.
		else
			BIntervalo := .F.
		endif		
	elseif mv_par08 == 2 //fora
		if MCEP <= mv_par09 .or. MCEP >= mv_par10
			BIntervalo := .T.
		else
			BIntervalo := .F.
		endif		
    else //ignorar
	    BIntervalo := .T.
    endif 
    
    if !BIntervalo
    	DBSELECTAREA("SC6")
		DBSKIP()
		LOOP
	endif 
	//20060406 ate aqui	
    	
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ  Verifica se a assinatura  gratuita e se nฦo esta suspensa  ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DBSELECTAREA("SC6")
	MNAO := ' '
	IF MGRAT=='S'.OR. SC6->C6_ORIGEM=='ED'
		MEDSUSP:=SC6->C6_EDSUSP
		IF SC6->C6_EDSUSP#0 .AND. SC6->C6_EDSUSP<=MV_PAR02 .AND. SC6->C6_EDSUSP<SC6->C6_EDVENC
			GR_TEMP2()
			DBSELECTAREA("SC6")
			DBSKIP()
			LOOP
		ENDIF
		IF SC6->C6_TPPORTE=='3' .OR. SC6->C6_TPPORTE=='6'
			IF SC6->C6_TPPORTE=='3'
				PORTE3++
			ELSE
				PORTE6:=PORTE6+1
			ENDIF
			GR_PORTE()
		ELSE
			GR_TEMP1()
			IF (ALLTRIM(MTPLOG)=="" .AND. ALLTRIM(MLOGR)=="" .AND. ALLTRIM(MNLOGR)=="" .AND. ALLTRIM(MCLOGR)=="") .or. empty(MEST)//20080619 //20101029
				INSERTALERTA()
			ENDIF
		ENDIF
		DBSELECTAREA("SC6")
		DBSKIP()
		LOOP
	ENDIF
	IF SC6->C6_SITUAC=='CP' .OR. SC6->C6_SITUAC=='SE' .OR. SC6->C6_SITUAC=='SU' .OR. SC6->C6_SITUAC=='SC';
		.OR. SC6->C6_SITUAC='LP' .OR. SC6->C6_SITUAC='CA'
		MEDSUSP:=SC6->C6_EDSUSP
		IF SC6->C6_EDSUSP#0 .AND. SC6->C6_EDSUSP<=MV_PAR02.AND. SC6->C6_EDSUSP<SC6->C6_EDVENC
			GR_TEMP2()
		ELSE
			GR_TEMP1()
			IF (ALLTRIM(MTPLOG)=="" .AND. ALLTRIM(MLOGR)=="" .AND. ALLTRIM(MNLOGR)=="" .AND. ALLTRIM(MCLOGR)=="") .or. empty(MEST) .or. empty(MMUN)//20080619 //20101029
				INSERTALERTA()
			ENDIF
		ENDIF
		DBSELECTAREA("SC6")
		DBSKIP()
		LOOP
	ENDIF
	
	MD:= dDataBase - 22
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ  Verifica no B1 quantos exemplares corresponde a revista     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DBSELECTAREA("SB1")
	IF DBSEEK(XFILIAL()+MPRODUTO)
		nex:=SB1->B1_QTDEEX
	ENDIF
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ  Verifica se h  titulos vencidos h  mais de 22 dias ou se    ณ
	//ณ  h  pagamentos que reabilitem assinaturas supensas.          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DBSELECTAREA("SE1")
	dbSetOrder(27)  ///dbSetOrder(15) AP5 //20090114 era(21) //20090723 mp10 era(22) //dbSetOrder(26) 20100412
	IF !DBSEEK(XFILIAL()+MPEDIDO)
		MNAO    := 'NAO'
		MEDSUSP := SC6->C6_EDSUSP
		IF SC6->C6_EDSUSP#0 .AND. SC6->C6_EDSUSP<=MV_PAR02 .AND. SC6->C6_EDSUSP<SC6->C6_EDVENC
			GR_TEMP2()
			DBSELECTAREA("SC6")
			DBSKIP()
			LOOP
		ENDIF
		IF SC6->C6_TPPORTE=='3' .OR. SC6->C6_TPPORTE=='6'
			IF SC6->C6_TPPORTE=='3'
				PORTE3++
			ELSE
				PORTE6:=PORTE6+1
			ENDIF
			GR_PORTE()
		ELSE
			GR_TEMP1()
			IF (ALLTRIM(MTPLOG)=="" .AND. ALLTRIM(MLOGR)=="" .AND. ALLTRIM(MNLOGR)=="" .AND. ALLTRIM(MCLOGR)=="") .or. empty(MEST) .or. empty(MMUN)//20080619 //20101029
				INSERTALERTA()
			ENDIF
		ENDIF
		DBSELECTAREA("SC6")
		DBSKIP()
		LOOP
	ENDIF
	
	DBSELECTAREA("SE1")
	WHILE MPEDIDO == SE1->E1_PEDIDO
		IF SC6->C6_NOTA #SE1->E1_NUM .AND. SC6->C6_SERIE# SE1->E1_SERIE
			DBSKIP()
			LOOP
		ENDIF
		nparc++
		IF !EMPTY(SE1->E1_BAIXA)
			*Verifica no E5 o motivo da baixa
			DBSELECTAREA("SE5")
			DBSETORDER(7)
			DBSEEK(XFILIAL()+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO)
			//*.................................................................
			//*NO SE5 pode repetir o numero e a parcela porque nฦo grava a serie,
			//*entฦo comparo o cliente do E1 com o CLIFOR do E5.
			//*.................................................................
			IF FOUND()
				ACHOU:=.T.
				WHILE SE5->E5_PREFIXO==SE1->E1_PREFIXO .AND. SE1->E1_NUM==SE5->E5_NUMERO;
					.AND. SE5->E5_PARCELA==SE1->E1_PARCELA .AND. SE5->E5_TIPO==SE1->E1_TIPO;
					.and. achou
					IF SE1->E1_CLIENTE#SE5->E5_CLIFOR
						SKIP
						IF SE1->E1_NUM==E5_NUMERO
							LOOP
						ENDIF
					ENDIF
					IF SE1->E1_CLIENTE==SE5->E5_CLIFOR
						IF SE5->E5_RECPAG=='R'
							MMOTIVO:=TRIM(SE5->E5_MOTBX)
						ELSE
							MMOTIVO:=TRIM(SE1->E1_MOTIVO)
						ENDIF
					ELSE
						MMOTIVO:=TRIM(SE1->E1_MOTIVO)
					ENDIF
					ACHOU:=.F.
				END
			ELSE
				* pode nao encontrar o SE5 porque nem todos os LP e CAN estao no E5
				* ai considera-se o motivo do E1
				MMOTIVO:=TRIM(SE1->E1_MOTIVO)
			ENDIF
			
			IF MMOTIVO=='DEV' .OR.  MMOTIVO=='CAN' .OR. MMOTIVO=='LP'
				NPARCVV:=NPARCVV+1
			ELSE
				NPARCPG:=NPARCPG+1
			ENDIF
		ELSE
			IF SE1->E1_VENCTO<=MD
				NPARCVV:=NPARCVV+1
			ELSE
				NPARCAV:=NPARCAV+1
			ENDIF
		ENDIF
		DBSELECTAREA("SE1")
		DBSKIP()
	END
	IF NPARCPG==NPARC .OR. NPARCAV==NPARC
		MEDSUSP:=0
	ELSE
		EXSUSP := NEX/NPARC
		EXSUSP := EXSUSP*NPARCPG
		MEDSUSP:= SC6->C6_EDINIC + EXSUSP
		MEDSUSP:= INT(MEDSUSP)
	ENDIF
	
	//13/09/01:ROTINA INCLUIDA POR RAQUEL - TRATA OS ITENS DA CONVERSAO
	IF MTES=='700' .OR. MTES=='701'
		IF SM0->M0_CODIGO=='01'  .AND. DTOS(SC6->C6_DATA)<='20021231'
			MEDSUSP:=SC6->C6_EDSUSP+1
		ENDIF
	ENDIF
	
	// se edicao de suspensao for maior que a edicao atual desprezar
	If MEDSUSP>mv_par02  .OR. MEDSUSP==0
		MEDSUSP:=0
		IF SC6->C6_TPPORTE=='3' .OR. SC6->C6_TPPORTE=='6'
			IF SC6->C6_TPPORTE=='3'
				PORTE3++
			ELSE
				PORTE6:=PORTE6+1
			ENDIF
			GR_PORTE()
		ELSE
			GR_TEMP1()
			IF (ALLTRIM(MTPLOG)=="" .AND. ALLTRIM(MLOGR)=="" .AND. ALLTRIM(MNLOGR)=="" .AND. ALLTRIM(MCLOGR)=="") .or. empty(MEST) .or. empty(MMUN)//20080619 //20101029
				INSERTALERTA()
			ENDIF
		ENDIF
	ELSE
		GR_TEMP2()
	ENDIF
	dbselectarea("SC6")
	DBSKIP()
END

// MARCA O FIM DE ARQUIVO

dbselectarea("ETIQP")
/*RECLOCK("ETIQP",.T.)
REPLACE NUMPED   WITH  'FIM DE'
REPLACE ITEM     WITH ' A'
REPLACE CODCLI   WITH 'RQUIVO'
MSUNLOCK()
*/
_ARQE := "\SIGA\ETIQUETAS\"+MDESCR1+ALLTRIM(STR(MV_PAR02,4))+ ".TXT" //20080417
_ARQ  := "\SIGA\ETIQUETAS\ESPECIAIS\"+MDESCR1+ALLTRIM(STR(MV_PAR02,4))+ ".DBF" //20080417
COPY TO &_ARQE SDF
COPY TO &_ARQ VIA "DBFCDXADS" // 20121106 
DBCLOSEAREA()
DBSELECTAREA("COMPLP")
_ARQC := "\SIGA\ETIQUETAS\ESPECIAIS\"+MDESCR2+ALLTRIM(STR(MV_PAR02,4))+".DBF" //20080417
COPY TO &_ARQC VIA "DBFCDXADS" // 20121106 
DBCLOSEAREA()
DBSELECTAREA("PORTE3")
_ARQP := "\SIGA\ETIQUETAS\ESPECIAIS\"+MDESCR3+ALLTRIM(STR(MV_PAR02,4))+".DBF" //20080417
COPY TO &_ARQP VIA "DBFCDXADS" // 20121106 
DBCLOSEAREA()
DBSELECTAREA("ALERTA")
_ARQALERTA := "\SIGA\ETIQUETAS\ALERTA"+ALLTRIM(MV_PAR01)+ ".DBF" //20080619
COPY TO &_ARQALERTA VIA "DBFCDXADS" // 20121106 
DBCLOSEAREA()     

cMsgFim := "TOTAL DE ETIQUETAS......."+STR(TOTETIQ,6,0)+CHR(10)+CHR(13)
cMsgFim += "TOTAL DE INADIMPLENTES..."+STR(CANC,6,0)   +CHR(10)+CHR(13)
cMsgFim += "TOTAL DO PORTE3 ........."+STR(PORTE3,6,0) +CHR(10)+CHR(13)
cMsgFim += "TOTAL DO PORTE6 ........."+STR(PORTE6,6,0) +CHR(10)+CHR(13)
cMsgFim += "TOTAL DO ALERTA ........."+STR(CONTALERTA,6,0) +CHR(10)+CHR(13)

MsgInfo(OemToAnsi(cMsgFim),"RESUMO DO PROCESSAMENTO")

INKEY(0)

IF LASTKEY()==27
	RETURN
ENDIF

DbSelectArea("SC6")
Retindex("SC6")
DbSelectArea("SA1")
Retindex("SA1")
DbSelectArea("SE5")
Retindex("SE5")
DbSelectArea("SE1")
Retindex("SE1")

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGR_TEMP1()บAutor  ณMicrosiga           บ Data ณ  04/06/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION GR_TEMP1()
// 20030630 > DANILO
IF SA1->A1_ATIVIDA >= MV_PAR06 .AND. SA1->A1_ATIVIDA <= MV_PAR07 //.AND. DTOS(SC6->C6_DATA)>='20030301'
	DBSELECTAREA("ETIQP")
	Reclock("ETIQP",.t.)
	REPLACE NUMPED   WITH  MPEDIDO
	REPLACE ITEM     WITH  MITEM
	REPLACE CODCLI   WITH  MCLIENTE
	REPLACE PORTE    WITH  MPORTE
	REPLACE CODDEST  WITH  MCODDEST
	REPLACE NOME     WITH  CLIE_NOME
	REPLACE DEST     WITH  CLIE_DEST
	REPLACE V_END    WITH  MEND
	REPLACE BAIRRO   WITH  MBAIRRO
	REPLACE MUN      WITH  MMUN
	REPLACE CEP      WITH  MCEP
	REPLACE EST      WITH  MEST
	REPLACE FONE     WITH  MFONE
	REPLACE COMPL    WITH  MCOMPL
//	REPLACE TES      WITH  MTES // danilo 20051110: Valdeir
	REPLACE TESP     WITH  MTES     
	REPLACE QTD 	 WITH NQTD               //20050311
	REPLACE TPLOG	 WITH MTPLOG //20060315 DANILO
	REPLACE LOGR	 WITH MLOGR  //20060315 DANILO
	REPLACE NLOGR	 WITH MNLOGR //20060315 DANILO
	REPLACE CLOGR	 WITH MCLOGR //20060315 DANILO	            
	REPLACE TPPER	 WITH mv_par11 //20060406
	MSUNLOCK()
	TOTETIQ++
	
	DBSELECTAREA("SC6")
	Reclock("SC6",.F.)
	
	REPLACE C6_DTENVIO WITH DDATABASE
	
	MSUNLOCK()
ENDIF
RETURN
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGR_TEMP2()บAutor  ณMicrosiga           บ Data ณ  04/06/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION GR_TEMP2()

IF SA1->A1_ATIVIDA >= MV_PAR06 .AND. SA1->A1_ATIVIDA <= MV_PAR07
	DBSELECTAREA("COMPLP")
	Reclock("COMPLP",.t.)
	REPLACE NUMPED  WITH  MPEDIDO
	REPLACE ITEM    WITH  MITEM
	REPLACE PARC    WITH  NPARC
	REPLACE PARCPG  WITH  NPARCPG
	REPLACE PARCVV  WITH  NPARCVV
	REPLACE PARCAV  WITH  NPARCAV
	REPLACE CF      WITH  MCF
	REPLACE ORIGEM  WITH  MORIGEM
	REPLACE TES     WITH  MTES
	REPLACE EDISA   WITH  MEDISA
	REPLACE EDSUSP  WITH  MEDSUSP
	REPLACE PRODUTO WITH  MPRODUTO
	REPLACE EDINIC  WITH  MEDINIC
	REPLACE EDFIN   WITH  MEDFIN
	REPLACE EDVENC  WITH  MEDVENC
	REPLACE SITUAC  WITH  MSITUAC
	REPLACE NAO     WITH  MNAO
	MSUNLOCK()
	CANC++
ENDIF
RETURN
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGR_PORTE()บAutor  ณMicrosiga           บ Data ณ  04/06/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION GR_PORTE()

IF SA1->A1_ATIVIDA >= MV_PAR06 .AND. SA1->A1_ATIVIDA <= MV_PAR07
	DBSELECTAREA("PORTE3")
	Reclock("PORTE3",.t.)
	REPLACE NUMPED   WITH  MPEDIDO
	REPLACE ITEM     WITH  MITEM
	REPLACE CODCLI   WITH  MCLIENTE
	REPLACE PORTE    WITH  MPORTE
	REPLACE CODDEST  WITH  MCODDEST
	REPLACE NOME     WITH  CLIE_NOME
	REPLACE DEST     WITH  CLIE_DEST
	REPLACE V_END    WITH  MEND
	REPLACE BAIRRO   WITH  MBAIRRO
	REPLACE MUN      WITH  MMUN
	REPLACE CEP      WITH  MCEP
	REPLACE EST      WITH  MEST
	REPLACE PRODUTO  WITH  MPRODUTO
	REPLACE TES      WITH  MTES
	REPLACE TESP     WITH  MTES
	REPLACE TPLOG	 WITH MTPLOG //20060315 DANILO
	REPLACE LOGR	 WITH MLOGR  //20060315 DANILO
	REPLACE NLOGR	 WITH MNLOGR //20060315 DANILO
	REPLACE CLOGR	 WITH MCLOGR //20060315 DANILO	
	REPLACE TPPER	 WITH mv_par11 //20060406
	MSUNLOCK()
	
	DBSELECTAREA("SC6")
	
	Reclock("SC6",.F.)
	REPLACE C6_DTENVIO WITH DDATABASE
	MSUNLOCK()
ENDIF
RETURN

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณInsertAlertaบAutor  ณDanilo C S Pala   บ Data ณ  20080619   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION InsertAlerta()
	DBSELECTAREA("ALERTA")
	Reclock("ALERTA",.t.)
		REPLACE NUMPED   WITH  MPEDIDO
		REPLACE ITEM     WITH  MITEM
		REPLACE CODCLI   WITH  MCLIENTE
		REPLACE CODDEST  WITH  MCODDEST
		REPLACE NOME     WITH  CLIE_NOME
		REPLACE DEST     WITH  CLIE_DEST
		REPLACE V_END    WITH  MEND
		REPLACE BAIRRO   WITH  MBAIRRO
		REPLACE MUN      WITH  MMUN
		REPLACE CEP      WITH  MCEP
		REPLACE EST      WITH  MEST
		REPLACE PRODUTO  WITH  MPRODUTO
		REPLACE TPLOG	 WITH MTPLOG
		REPLACE LOGR	 WITH MLOGR
		REPLACE NLOGR	 WITH MNLOGR
		REPLACE CLOGR	 WITH MCLOGR
	MSUNLOCK()	
	CONTALERTA++
	DBSELECTAREA("SC6")
return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidperg บAutor  ณMicrosiga           บ Data ณ  04/06/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _ValidPerg()

_sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

AADD(aRegs,{cPerg,"04","AU Mais............:","mv_chA","C",01,0,0,"C","","mv_par10","Sim","","","Nao","","","","","","","","","","",""})

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
