#include "rwmake.ch"    // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/ at 20030703
REFORMULADO COM BASE NO RFAT112 POR DANILO C S PALA EM 27/06/2003
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ฑฑ
ฑฑณPrograma: RFAT024   ณAutor: Solange Nalini         ณ Data:   08/07/00 ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณDescriao: Geracao do arquivo texto para Distribuidora                ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณUso      : Mขdulo de Faturamento                                      ณ ฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู ฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function Rfat024()

SetPrvt("CLIE_DEST,CDESC1,CDESC2,CDESC3,MDESCR,CPERG")
SetPrvt("LCONTINUA,MV_PAR01,MAMPL,PORTE3,PORTE6,CANC")
SetPrvt("TOTETIQ,MDESCR1,MDESCR2,MDESCR3,_ARQE,_ARQC")
SetPrvt("_ACAMPOS,_CNOME,_CFILTRO,CINDEX,CKEY, CCHAVE, XCONT")
SetPrvt("NPARC,NPARCVV,NPARCPG,NPARCAV,MPRODUTO,RESTO")
SetPrvt("MREVISTA,MNAO,MPORTE,MCLIENTE,MCODDEST,MPEDIDO")
SetPrvt("MORIGEM,MPEDANT,MITEMANT,MEDISA,MITEM,MEDINIC")
SetPrvt("MEDFIN,MEDSUSP,MEDVENC,MSITUAC,MTES,MCF")
SetPrvt("MNOTA,MSERIE,MCOMPL,CLIE_NOME,MEND,MBAIRRO")
SetPrvt("MMUN,MEST,MCEP,MFONE,MD,NEX,ATIVIDADE")
SetPrvt("ACHOU,MMOTIVO,EXSUSP,_ARQ,_ARQP,_SALIAS")
SetPrvt("AREGS,I,J,mGrat,CONTROLE, cMsgAlerta")
SetPrvt("cAssinaturaCancelada, TITULO, ARETURN, WNREL")
SetPrvt("CPROGRAMA, NCARACTER, TAMANHO,MOBS, MORDEM, MLOCAL ")
SetPrvt("CABEC2,MPGA,CTITULO,CABEC1,L,NTAMANHO, _CNOMEIVC, _aCAMPOSIVC")
SetPrvt("TCAPITAL,TINTERIOR,TOUTROS,TTOTAL,M_PAG, _StringArq")
SetPrvt("TCANCELADO, _cNomeAVERIG, _aCamposAVERIG, _StringArqAVERIG, cAtividadeAVERIG")
SetPrvt("nPagoCapital,nPagoInterior, nPagoOutros, nPagoTotal")
SetPrvt("nGratuitoCapital,nGratuitoInterior, nGratuitoOutros, nGratuitoTotal")
SetPrvt("nTCCapital,nTCInterior, nTCOutros, nTCTotal")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ mv_par01             // Cod.da Revista                       ณ
//ณ mv_par02             // Edicao                               ณ
//ณ mv_par03             // Ampliada                             ณ
//ณ mv_par04             // Au Mais                              ณ
//ณ mv_par05             // Paga   Cortesia                      ณ
//ณ mv_par06             // Da atividade                         ณ
//ณ mv_par07             // Ate atividade                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
CLIE_DEST:=SPACE(40)
cDesc1 :=PADC("Este programa ira gerar o arquivo para Intercourier" ,74)
cDesc2 :="  "
cDesc3 :=""

mDESCR :="  "
CONTROLE := ""
cPerg:="SAN015"


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

Processa({|lEnd| R024Proc(@lEnd)}, "IVC", "Aguarde, Processando IVC...")

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
Static Function R024Proc()
//>>>>>ANTIGO
Private TITULO      := '** RELATORIO DA DISTRIBUICAO GEOGRAFICA ** '
Private cDesc1      := PADC("Este programa ira gerar o Relatorio Mensal da Distribuicao ",74)
Private cDesc2      := PADC("Geografica para o IVC",74)
Private cDesc3      := ""
Private cString     := 'SC6'
Private aReturn     := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
Private wnrel       := "DIVC"
Private nLastKey    := 0
Private CPROGRAMA   := "RFAT024"
Private lAbortPrint := .F.         
Private mHora       := TIME()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Envia controle para a funcao SETPRINT                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
wnrel := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

NCARACTER:=12
tamanho:="P"
//>>>>>ATE AKI
                    



DBSELECTAREA("SZJ")
DBSETORDER(1)
If !DBSEEK(XFILIAL()+MV_PAR01+STR(MV_PAR02,4))
	Return
Endif
/*  para testes
IF SZJ->ZJ_DTCIRC < dDataBase
	MsgALERT("A DATA DA CIRCULACAO E MENOR QUE A DATA ATUAL","ATENCAO")
	If !PERGUNTE(cPerg)
		Return
	Endif
ENDIF*/

mv_par01 := mv_par01+space(11)
MAMPL    := SZJ->ZJ_REVAMPL
PORTE3   := 0
PORTE6   := 0
CANC     := 0
TOTETIQ  := 0

IF MV_PAR05 == 1
	CONTROLE := "P"
ELSEIF MV_PAR05 == 2
	CONTROLE := "G"
ELSE
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
{"EST"     ,"C",2 ,2} ,;
{"TES"     ,"C",3 ,0},;
{"FONE"    ,"C",15,0},;
{"COMPL"   ,"C",30,0},;
{"TESP"     ,"C",3 ,0}}          //* so para separar pagos

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
{"TES"     ,"C",3 ,0},;
{"EST"     ,"C",2 ,2},;
{"TESP"     ,"C",3 ,0}}
_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PORTE3",.F.,.F.)



//>>>rfat024 anterior
_cNomeAVERIG   :="AVERIG"
_aCamposAVERIG := {   {"PEDIDO"   ,"C",6 ,  0} ,;
{"C6_DATA"  ,"D",8 , 0} ,;
{"EDINIC"   ,"N",5 , 0} ,;
{"EDVENC"   ,"N",5 , 0} ,;
{"EDSUSP"   ,"N",5 , 0} ,;
{"CANCELADO","C",1 , 0} ,;
{"PAGO"     ,"C",1 , 0},;
{"ATIVIDADE","C",7 , 0}}
_cNomeAVERIG := CriaTrab(_aCamposAVERIG,.t.)
dbUseArea(.T.,,_cNomeAVERIG,"AVERIG",.F.,.F.)
DBSELECTAREA("AVERIG")
cIndex := CriaTrab(Nil,.F.)
cChave := "PEDIDO"
MsAguarde({|| Indregua("AVERIG",cIndex,cCHAVE,,,"AGUARDE....CRIANDO INDICE ")},"Aguarde","Gerando Indice Temporario (AVERIG)...")

_CNOMEIVC   :="IVC"
_aCamposIVC := {   {"ESTADO"   ,"C",2 ,  0} ,;
{"CAPITAL"  ,"N",5 ,  0} ,;
{"INTERIOR" ,"N",5 ,  0} ,;
{"OUTROS"   ,"N",5 ,  0} ,;
{"TOTAL"    ,"N",5 ,  0} ,;
{"ORDEM"    ,"N",2 ,  0} ,;
{"OBS "     ,"C",20,  0} ,;
{"PAGOSN"   ,"C",1 ,  0} ,;
{"CANCELADO","N",5 ,  0}} 
_cNomeIVC := CriaTrab(_aCamposIVC,.t.)
dbUseArea(.T.,,_cNomeIVC,"IVC",.F.,.F.)
                                             
DBSELECTAREA("IVC")
cIndex := CriaTrab(Nil,.F.)
cChave := "STR(ORDEM,2,0)+ESTADO+PAGOSN"
MsAguarde({|| Indregua("IVC",cIndex,cCHAVE,,,"AGUARDE....CRIANDO INDICE ")},"Aguarde","Gerando Indice Temporario (IVC)...")
//>>>ATE AKI


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Seleciona no SC6 sข assinaturas ativas (ed.inicial e final)             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DBSELECTAREA('SC6')
_cFiltro := "C6_FILIAL == '"+xFilial("SC6")+"'"
_cFiltro := _cFiltro+".and.MV_PAR01 == C6_REGCOT" // .AND. DTOS(C6_DATA)>='20030301'"
_cFiltro := _cFiltro+".and.MV_PAR02>=C6_EDINIC .AND. MV_PAR02<=C6_EDVENC"

CINDEX := CRIATRAB(NIL,.F.)
CKEY   := "SC6->C6_FILIAL+SC6->C6_REGCOT"
INDREGUA("SC6",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")
DBSEEK(XFILIAL()+MV_PAR01,.T.)   // Soft Seek on (.T.)

nRegs := Abs(LastRec() - Recno())+1

DBSELECTAREA("SC6")
DBGOTOP()

ProcRegua(nregs)
xcont := 0
WHILE !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. MV_PAR01 == SC6->C6_REGCOT
	xcont++
	IncProc("REGISTROS LIDOS "+ALLTRIM(STR(xcont,6,0)))
	nparc   := 0
	nparcvv := 0
	nparcpg := 0
	nparcav := 0
	mGrat   :=""
	cAssinaturaCancelada := ""
	mproduto:= SC6->C6_PRODUTO
	
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
	
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณRESTRICOES SE PAGA/CORTESIAณ
//ณOBS: AMBAS NAO RESTRINGE   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If MV_PAR05 == 2 .and. mGrat <> 'S'//nao cortesia
		DBSELECTAREA("SC6")
		DBSKIP()
		LOOP
	ENDIF
	
	If MV_PAR05 == 1 .and. mGrat == 'S'//nao paga
		DBSELECTAREA("SC6")
		DBSKIP()
		LOOP
	ENDIF

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณPOSICIONA CLIENTEณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	DBSELECTAREA("SA1")
	DBSETORDER(1)
	IF DBSEEK(XFILIAL()+MCLIENTE)
		CLIE_NOME:=SA1->A1_NOME
	ELSE
		CLIE_NOME:='  '
	ENDIF
	
	MEND      := SA1->A1_END
	MBAIRRO   := SA1->A1_BAIRRO
	MMUN      := SA1->A1_MUN
	MEST      := SA1->A1_EST
	MCEP      := SA1->A1_CEP
	MFONE     := SA1->A1_TEL
	ATIVIDADE := SA1->A1_ATIVIDA
	CLIE_DEST := SPACE(40)
	
	IF MCODDEST # ' '
		DBSELECTAREA("SZN")
		IF DBSEEK(XFILIAL()+MCLIENTE+MCODDEST)
			CLIE_DEST:=SZN->ZN_NOME
		ENDIF
		DBSELECTAREA("SZO")
		IF DBSEEK(XFILIAL()+MCLIENTE+MCODDEST)
			MEND    := SZO->ZO_END
			MBAIRRO := SZO->ZO_BAIRRO
			MMUN    := SZO->ZO_CIDADE
			MEST    := SZO->ZO_ESTADO
			MCEP    := SZO->ZO_CEP
			MFONE   := SZO->ZO_FONE
		ENDIF
	ENDIF
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
	DBSETORDER(15)
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
		ENDIF
	ELSE
		GR_TEMP2()
	ENDIF
	dbselectarea("SC6")
	DBSKIP()
END

// MARCA O FIM DE ARQUIVO
dbselectarea("ETIQP")
RECLOCK("ETIQP",.T.)
REPLACE NUMPED   WITH  'FIM DE'
REPLACE ITEM     WITH ' A'
REPLACE CODCLI   WITH 'RQUIVO'
MSUNLOCK()

//fim de relatorio rfat024 versao anterior
CABEC2 := 'PAGOS'
MPGA   := 'P'
CABEC2 := 'GRATUITOS'
MPGA   := 'G'
IMPRIME_IVC()

// CRIANDO ARQUIVOS IVC
DBSELECTAREA("IVC")
_StringArq := "\SIGAADV\ETIQUETAS\ESPECIAIS\"+ SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2) +".DBF"
COPY TO &_StringArq
DBCLOSEAREA()     

DBSELECTAREA("AVERIG")
_StrArqAVERIG := "\SIGAADV\ETIQUETAS\ESPECIAIS\AVERIG" +SUBS(MHORA,7,2) +".DBF"
COPY TO &_StrArqAVERIG
DBCLOSEAREA()     

/*
_ARQE := "\SIGAADV\ETIQUETAS\"+MDESCR1+ALLTRIM(STR(MV_PAR02,4))+ ".TXT"
_ARQ  := "\SIGAADV\ETIQUETAS\ESPECIAIS\"+MDESCR1+ALLTRIM(STR(MV_PAR02,4))+ ".DBF"
COPY TO &_ARQE SDF
COPY TO &_ARQ
DBCLOSEAREA()
DBSELECTAREA("COMPLP")
_ARQC := "\SIGAADV\ETIQUETAS\ESPECIAIS\"+MDESCR2+ALLTRIM(STR(MV_PAR02,4))+".DBF"
COPY TO &_ARQC
DBCLOSEAREA()
DBSELECTAREA("PORTE3")
_ARQP := "\SIGAADV\ETIQUETAS\ESPECIAIS\"+MDESCR3+ALLTRIM(STR(MV_PAR02,4))+".DBF"
COPY TO &_ARQP
DBCLOSEAREA()*/

cMsgFim := "TOTAL DE ETIQUETAS......."+STR(TOTETIQ,6,0)+CHR(10)+CHR(13)
cMsgFim += "TOTAL DE INADIMPLENTES..."+STR(CANC,6,0)   +CHR(10)+CHR(13)
cMsgFim += "TOTAL DO PORTE3 ........."+STR(PORTE3,6,0) +CHR(10)+CHR(13)
cMsgFim += "TOTAL DO PORTE6 ........."+STR(PORTE6,6,0) +CHR(10)+CHR(13)

MsgStop(OemToAnsi(cMsgFim),"RESUMO DO PROCESSAMENTO")

cMsgAlerta := "Arquivo gerado: "+ _StringArq +CHR(10)+CHR(13)
cMsgAlerta += "Averiguacao: "+ _StrArqAVERIG +CHR(10)+CHR(13)
MsgAlert(OemToAnsi(cMsgAlerta))


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


Set Device To Screen

If aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
EndIf

Ms_Flush()

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
//ALTERADO EM 30/06/2003
IF SA1->A1_ATIVIDA >= MV_PAR06 .AND. SA1->A1_ATIVIDA <= MV_PAR07 .AND. DTOS(SC6->C6_DATA)>='20030301'
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
	REPLACE TES      WITH  MTES
	REPLACE TESP     WITH  MTES
	MSUNLOCK()
	TOTETIQ++
	cAssinaturaCancelada := "N"
	GerarIVC()
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
	cAssinaturaCancelada := "S"
	GerarIVC()
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
	MSUNLOCK()
ENDIF

RETURN

















/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGERAR_IVC บAutor  ณMicrosiga           บ Data ณ  27/06/2003 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGERACAO DO IVC                                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GerarIVC()
	dC6_DataAVERIG := SC6->C6_DATA
	nEdinicAVERIG := mEDINIC
	nEdvencAVERIG := mEdvenc
	nEdsuspAVERIG := mEdsusp
	cAtividadeAVERIG := ATIVIDADE	
   
	// saber se eh pago ou gratiuto OK
	IF mGRAT == "S"
		MPAGOSN := "G"
	ELSE
		MPAGOSN := "P"
	ENDIF
	
	MOBS   := ' '
	mordem := 0
	MLOCAL:=' '
	mCidade := mMUN	
		
//Classificacao da assinatura para IVC	
	If ALLTRIM(MCIDADE) == 'PORTO VELHO' .AND. MEST == 'RO'
		MLOCAL:='C'
		MORDEM:=5
	ElseIf  ALLTRIM(MCIDADE) # 'PORTO VELHO' .AND. MEST == 'RO'
		MLOCAL:='I'
		MORDEM:=5
	ElseIf ALLTRIM(MCIDADE) == 'BOA VISTA' .AND. MEST == 'RR'
		MLOCAL:='C'
		MORDEM:= 6
	ElseIf ALLTRIM(MCIDADE) # 'BOA VISTA' .AND. MEST == 'RR'
		MLOCAL:='I'
		MORDEM:= 6
	ElseIf ALLTRIM(MCIDADE) == 'BELEM' .AND. MEST == 'PA'
		MLOCAL:='C'
		MORDEM:= 4
	ElseIf ALLTRIM(MCIDADE)#'BELEM' .AND. MEST=='PA'
		MLOCAL:='I'
		MORDEM:= 4
	ElseIf ALLTRIM(MCIDADE)=='ARACAJU' .AND. MEST=='SE'
		MLOCAL:='C'
		MORDEM:= 16
	ElseIf ALLTRIM(MCIDADE)#'ARACAJU' .AND. MEST=='SE'
		MLOCAL:='I'
		MORDEM:= 16
	ElseIf ALLTRIM(MCIDADE)=='MACAPA' .AND. MEST=='AP'
		MLOCAL:='C'
		MORDEM:=2
	ElseIf ALLTRIM(MCIDADE)#'MACAPA' .AND. MEST=='AP'
		MLOCAL:='I'
		MORDEM:= 2
	ELseIf ALLTRIM(MCIDADE)=='SAO PAULO' .AND. MEST=='SP'
		MLOCAL:='C'
		MORDEM:= 20
	ElseIf ALLTRIM(MCIDADE)#'SAO PAULO' .AND. MEST=='SP'
		MLOCAL:='I'
		MORDEM:= 20
	ElseIf ALLTRIM(MCIDADE)=='VITORIA' .AND. MEST=='ES'
		MLOCAL:='C'
		MORDEM:= 17
	ElseIf ALLTRIM(MCIDADE)#'VITORIA' .AND. MEST=='ES'
		MLOCAL:='I'
		MORDEM:= 17
	ElseIf ALLTRIM(MCIDADE) $('TERESINA/TEREZINA/TEREZINHA') .AND. MEST=='PI'
		MLOCAL:='C'
		MORDEM:=14
	ElseIf ALLTRIM(MCIDADE) # 'TERESINA' .and.  ALLTRIM(MCIDADE)#'TEREZINA' .and. ALLTRIM(MCIDADE) #'TEREZINHA' .AND. MEST=='PI'
		MLOCAL:='I'
		MORDEM:= 14
	ElseIf ALLTRIM(MCIDADE) $ ('SAO LUIS/SAO LUIZ') .AND. MEST=='MA'
		MLOCAL:='C'
		MORDEM:= 11
	ElseIf ALLTRIM(MCIDADE) #'SAO LUIS' .and. ALLTRIM(MCIDADE)#'SAO LUIZ' .AND. MEST=='MA'
		MLOCAL:='I'
		MORDEM:= 11
	ElseIf ALLTRIM(MCIDADE)=='RIO BRANCO' .AND. MEST=='AC'
		MORDEM:=1
		MLOCAL:='C'
	ElseIf ALLTRIM(MCIDADE)#'RIO BRANCO' .AND. MEST=='AC'
		MLOCAL:='I'
		MORDEM:=1
	ElseIf ALLTRIM(MCIDADE)=='NATAL' .AND. MEST=='RN'
		MLOCAL:='C'
		MORDEM:= 15
	ElseIf ALLTRIM(MCIDADE)#'NATAL' .AND. MEST=='RN'
		MLOCAL:='I'
		MORDEM:= 15
	ElseIf ALLTRIM(MCIDADE)=='FORTALEZA' .AND. MEST=='CE'
		MLOCAL:='C'
		MORDEM:= 9
	ElseIf ALLTRIM(MCIDADE)#'FORTALEZA' .AND. MEST=='CE'
		MLOCAL:='I'
		MORDEM:= 9
	ElseIf ALLTRIM(MCIDADE)=='MACEIO' .AND. MEST=='AL'
		MLOCAL:='C'
		MORDEM:= 7
	ElseIf ALLTRIM(MCIDADE)#'MACEIO' .AND. MEST=='AL'
		MLOCAL:='I'
		MORDEM:= 7
	ElseIf ALLTRIM(MCIDADE)=='MANAUS' .AND. MEST=='AM'
		MLOCAL:='C'
		MORDEM:= 3
	ElseIf ALLTRIM(MCIDADE)#'MANAUS' .AND. MEST=='AM'
		MLOCAL:='I'
		MORDEM:= 3
	ElseIf ALLTRIM(MCIDADE)=='RECIFE' .AND. MEST=='PE'
		MLOCAL:='C'
		MORDEM:= 13
	ElseIf ALLTRIM(MCIDADE)#'RECIFE' .AND. MEST=='PE'
		MLOCAL:='I'
		MORDEM:= 13
	ElseIf ALLTRIM(MCIDADE)=='SALVADOR' .AND. MEST=='BA'
		MLOCAL:='C'
		MORDEM:= 8
	ElseIf ALLTRIM(MCIDADE)#'SALVADOR' .AND. MEST=='BA'
		MLOCAL:='I'
		MORDEM:= 8
	ElseIf ALLTRIM(MCIDADE)=='JOAO PESSOA' .AND. MEST=='PB'
		MLOCAL:='C'
		MORDEM:= 12
	ElseIf ALLTRIM(MCIDADE)#'JOAO PESSOA' .AND. MEST=='PB'
		MLOCAL:='I'
		MORDEM:= 12
	ElseIf MEST=='EX'
		MLOCAL:='O'
		MORDEM:= 29
	ElseIf ALLTRIM(MCIDADE)=='BELO HORIZONTE' .AND. MEST=='MG'
		MLOCAL:='C'
		MORDEM:= 18
	ElseIf ALLTRIM(MCIDADE)#'BELO HORIZONTE' .AND. MEST=='MG'
		MLOCAL:='I'
		MORDEM:=  18
	ElseIf ALLTRIM(MCIDADE)=='RIO DE JANEIRO' .AND. MEST=='RJ'
		MLOCAL:='C'
		MORDEM:= 19
	ElseIf ALLTRIM(MCIDADE)#'RIO DE JANEIRO' .AND. MEST=='RJ'
		MLOCAL:='I'
		MORDEM:= 19
	ElseIf ALLTRIM(MCIDADE)=='PALMAS' .AND. MEST=='TO'
		MLOCAL:='C'
		MORDEM:=28
	ElseIf ALLTRIM(MCIDADE)#'PALMAS' .AND. MEST=='TO'
		MLOCAL:='I'
		MORDEM:= 28
	ElseIf ALLTRIM(MCIDADE)=='GOIANIA' .AND. MEST=='GO'
		MLOCAL:='C'
		MORDEM:= 25
	ElseIf ALLTRIM(MCIDADE)#'GOIANIA' .AND. MEST=='GO'
		MLOCAL:='I'
		MORDEM:= 25
	ElseIf ALLTRIM(MCIDADE)=='CAMPO GRANDE' .AND. MEST=='MS'
		MLOCAL:='C'
		MORDEM:= 27
	ElseIf ALLTRIM(MCIDADE)#'CAMPO GRANDE' .AND. MEST=='MS'
		MLOCAL:='I'
		MORDEM:=  27
	ElseIf ALLTRIM(MCIDADE)=='CUIABA' .AND. MEST=='MT'
		MLOCAL:='C'
		MORDEM:= 26
	ElseIf ALLTRIM(MCIDADE)#'CUIABA' .AND. MEST=='MT'
		MLOCAL:='I'
		MORDEM:= 26
	ElseIf ALLTRIM(MCIDADE)=='BRASILIA' .AND. MEST=='DF'
		MLOCAL:='C'
		MORDEM:= 24
	ElseIf ALLTRIM(MCIDADE)#'BRASILIA' .AND. MEST=='DF'
		MLOCAL:='I'
		MORDEM:= 24
	ElseIf ALLTRIM(MCIDADE)=='PORTO ALEGRE' .AND. MEST=='RS'
		MLOCAL:='C'
		MORDEM:= 23
	ElseIf ALLTRIM(MCIDADE)#'PORTO ALEGRE' .AND. MEST=='RS'
		MLOCAL:='I'
		MORDEM:= 23
	ElseIf ALLTRIM(MCIDADE)=='FLORIANOPOLIS' .AND. MEST=='SC'
		MLOCAL:='C'
		MORDEM:= 22
	ElseIf ALLTRIM(MCIDADE)#'FLORIANOPOLIS' .AND. MEST=='SC'
		MLOCAL:='I'
		MORDEM:= 22
	ElseIf ALLTRIM(MCIDADE)=='CURITIBA' .AND. MEST=='PR'
		MLOCAL:='C'
		MORDEM:=21
	ElseIf ALLTRIM(MCIDADE)#'CURITIBA' .AND. MEST=='PR'
		MLOCAL:='I'
		MORDEM:= 21
	EndIf
	If Empty(MLOCAL)  .OR. Empty(MORDEM)
		MOBS:=SC6->C6_NUM
	Endif    
	       
// ASS CANCELADAS	
	IF cAssinaturaCancelada == "S"
		MPAGOSN := "C"
	ENDIF

	GRAVA_IVC()
return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGRAVA_IVC บAutor  ณMicrosiga           บ Data ณ  25/06/2003 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION GRAVA_IVC()  

IF ATIVIDADE >= MV_PAR06 .AND. ATIVIDADE <= MV_PAR07

	GRAVA_AVERIG()	     //inserido para averiguacao 26/06/2003

	DBSELECTAREA("IVC")
	DBSEEK(STR(MORDEM,2,0)+MEST+MPAGOSN)
	IF !FOUND()
		Reclock("IVC",.t.)
		replace ORDEM  WITH MORDEM
		do case
			case mlocal=='C'
				replace CAPITAL WITH 1
			CASE MLOCAL=='I'
				replace INTERIOR WITH 1
			CASE MLOCAL=='O'
				replace OUTROS WITH 1
//			CASE MLOCAL=='D' ; 	replace CANCELADO WITH 1; return //INSERIDO POR DANILO C S PALA EM 25/06/2003*/
		ENDCASE
		replace OBS    WITH MOBS
		replace ESTADO WITH MEST
		replace PAGOSN WITH MPAGOSN
		replace TOTAL  WITH 1
	ELSE
		Reclock("IVC",.F.)
		do case
			case mlocal == 'C'
				replace CAPITAL  WITH CAPITAL+1
			CASE MLOCAL == 'I'
				replace INTERIOR WITH INTERIOR+1
			CASE MLOCAL == 'O'
				replace OUTROS   WITH OUTROS+1
//			CASE MLOCAL=='D' ;	replace CANCELADO WITH CANCELADO+1;	return //INSERIDO POR DANILO C S PALA EM 25/06/2003*/
		ENDCASE
			replace TOTAL  WITH TOTAL+1
		If ! Empty(MOBS)
			replace OBS    WITH ALLTRIM(OBS)+'/'+MOBS
		Endif
	ENDIF
		MsUnlock()
ENDIF

RETURN

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณIMPRIME   บAutor  ณMicrosiga           บ Data ณ  03/26/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION IMPRIME_IVC()
CTITULO  := '** DISTRIBUICAO GEOGRAFICA - IVC **'
CABEC1   := 'REVISTA: '+TRIM(MDESCR)+ ' - EDICAO: '+ TRIM(STR(MV_PAR02,4,0))+' - ASSINANTES '+CABEC2
CABEC2   := ' '
l        := 0
NTAMANHO := 'P'

If nLastKey == 27
	Return
Endif

DBSELECTAREA("IVC")
DBGOTOP()
/*TCAPITAL  := 0 //20030702
TINTERIOR := 0
TOUTROS   := 0
TTOTAL    := 0 
TCANCELADO := 0
M_PAG     := 1             */

nPagoCapital	:= 0
nPagoInterior	:= 0
nPagoOutros		:= 0
nPagototal		:= 0
nGratuitoCapital:= 0
nGratuitoInterior:= 0
nGratuitoOutros := 0
nGratuitoTotal  := 0
nTCCapital :=0
nTCInterior := 0
nTCOutros :=0
nTCTotal := 0
// 20030702 ATE AKI 

WHILE !EOF()
/*	IF MPGA # PAGOSN
		DBSKIP()
		LOOP
	ENDIF*/
	IF L <> 0
		IF L == 64     //.OR. L+10>=64
			L := 0
		ELSE
			L++
		ENDIF
	ENDIF
	
	IF L == 0
		L++
		CABEC(cTitulo,Cabec1,Cabec2,cPrograma,Ntamanho,nCaracter)
		L := 8
		@ L,22 PSAY 'CAPITAL'
		@ L,35 PSAY 'INTERIOR'
		@ L,44 PSAY 'OUTROS'
		@ L,55 PSAY 'TOTAL'
		@ L,66 PSAY 'STATUS'
		@ L,75 PSAY 'OBS'
		L:=L+2
	ENDIF
	
	@ L,02 PSAY 'ASS DO ESTADO ->'+ESTADO
	@ L,22 PSAY CAPITAL
	@ L,35 PSAY INTERIOR
	@ L,44 PSAY OUTROS
	@ L,55 PSAY TOTAL
	@ L,66 PSAY PAGOSN
	@ L,77 PSAY OBS
	if PAGOSN = "P" //20030703
		nPagoCapital	+= CAPITAL
		nPagoInterior	+= INTERIOR
		nPagoOutros		+= OUTROS
		nPagoTotal		+= TOTAL
	elseif PAGOSN = "G"
		nGratuitoCapital += CAPITAL
		nGratuitoInterior += INTERIOR
		nGratuitoOutros += OUTROS
		nGratuitoTotal	+= TOTAL
	elseif PAGOSN = "C"
		nTCCapital := CAPITAL + nTCCapital
		nTCInterior := INTERIOR + nTCInterior
		nTCOutros := OUTROS + nTCOutros
		nTCTotal := TOTAL + nTCTotal
	end if
/*	TCAPITAL  := TCAPITAL+CAPITAL
	TINTERIOR := TINTERIOR+INTERIOR
	TOUTROS   := TOUTROS+OUTROS
	TTOTAL    := TTOTAL+TOTAL
//	TCANCELADO:= TCANCELADO+CANCELADO*/ //20030702 ATE AKI
	DBSKIP()
END  

IF L > 59
	L := 0
	L++
	CABEC(cTitulo,Cabec1,Cabec2,cPrograma,Ntamanho,nCaracter)
	L := 8
	@ L,22 PSAY 'CAPITAL'
	@ L,35 PSAY 'INTERIOR'
	@ L,44 PSAY 'OUTROS'
	@ L,55 PSAY 'TOTAL'
	@ L,66 PSAY 'STATUS'
	@ L,75 PSAY 'OBS'
ENDIF
                
@ L+2,02 PSAY "TOTALIZACAO"

@ L+3,02 PSAY "PAGOS(P):"
@ L+3,22 PSAY STR(nPagoCAPITAL,5,0)
@ L+3,35 PSAY STR(nPagoINTERIOR,5,0)
@ L+3,44 PSAY STR(nPagoOUTROS,5,0)
@ L+3,55 PSAY STR(nPagoTOTAL,5,0)
//@ L+3,74 PSAY ' '

@ L+4,02 PSAY "GRATUITOS(G):"
@ L+4,22 PSAY STR(nGratuitoCAPITAL,5,0)
@ L+4,35 PSAY STR(nGratuitoINTERIOR,5,0)
@ L+4,44 PSAY STR(nGratuitoOUTROS,5,0)
@ L+4,55 PSAY STR(nGratuitoTOTAL,5,0)

@ L+5,02 PSAY "CANCELADOS(C):"
@ L+5,22 PSAY STR(nTCCAPITAL,5,0)
@ L+5,35 PSAY STR(nTCINTERIOR,5,0)
@ L+5,44 PSAY STR(nTCOUTROS,5,0)
@ L+5,55 PSAY STR(nTCTOTAL,5,0)


RETURN
      
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGRAVA_AVERIG บAutor  ณDANILO C S PALA  บ Data ณ  06/27/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ INSERE EM AVERIG                                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION GRAVA_AVERIG()  
DBSelectArea("AVERIG")
Reclock("AVERIG",.t.)
replace PEDIDO  WITH mPedido
replace C6_DATA    WITH dC6_DataAVERIG
replace EDINIC  WITH nEdinicAVERIG
replace EDVENC WITH nEdvencAVERIG
replace EDSUSP WITH nEdsuspAVERIG   
REPLACE PAGO WITH MPAGOSN  
REPLACE ATIVIDADE WITH cAtividadeAVERIG
if MLOCAL == "D"
	replace CANCELADO WITH "S"
endif
MsUnlock()
RETURN