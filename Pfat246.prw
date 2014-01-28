#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT246   ³Autor: Danilo c s Pala        ³ Data:20080327    ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: RELATORIO DE CONTRATOS               						 ³ ±±
±±³                                                                      ³ ±±   
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function PFAT246()

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CDESC1")
SetPrvt("CDESC2,CDESC3,CTITULO,CCABEC1,CCABEC2,CPROGRAMA")
SetPrvt("CTAMANHO,LIMITE,NCARACTER,ARETURN,WNREL,CSTRING")
SetPrvt("NLASTKEY,_ACAMPOS,_CNOME,CINDEX,CKEY,_CFILTRO")
SetPrvt("MCLI,MPED,MPRD,M_PAG,L,MSUBT")
SetPrvt("MPRODUTO,MAUTOR, MTOTAUT, MQTD, MDESCRIC, cArqPath, cArquivo, cQuery")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ MV_PAR01 TIPO {1=CONTRATO, 2=PEDIDO}	 |
//³ MV_PAR02 PRODUTO						 |
//³ MV_PAR03 EDICAO INICIO					 ³
//³ MV_PAR04 EDICAO FIN	    				 ³
//³ MV_PAR05 STATUS {1=TODOS, 2= ATIVOS, 3=INATIVOS, 4=CANCELADOS}|
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:='FAT246' 
IF .NOT. PERGUNTE(cPerg)
   RETURN
ENDIF
//#IFDEF WINDOWS
RptStatus({|| FCONTRATOS()})
Return




Static Function FCONTRATOS()
_aCampos := {{"CONTRATO"  ,"C",6,0} ,;
{"CLIENTE"  ,"C",6, 0} ,;
{"NOME"     ,"C",40, 0} ,;
{"PEDIDO"   ,"C",6, 0} ,;
{"PRODUTO"  ,"C",15,0} ,;
{"VALOR"    ,"N",12,2} ,;
{"EMISSAO"  ,"D",8, 0} ,;
{"EDINIC"  ,"N",4, 0} ,;
{"EDFIN"  ,"N",4, 0} ,;
{"EDSUSP"   ,"N",4, 0}}
_cNome  := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PEDSW",.F.,.F.)
CINDEX1 := CRIATRAB(NIL,.F.)
CKEY    := "CONTRATO+CLIENTE+PEDIDO+PRODUTO"
INDREGUA("PEDSW",CINDEX1,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")


_aCampos := {{"CONTRATO"  ,"C",6,0} ,;
{"CLIENTE"  ,"C",6, 0} ,;
{"NOME"     ,"C",40, 0} ,;
{"PRODUTO"  ,"C",15,0} ,;
{"VALOR"    ,"N",12,2} ,;
{"EDINIC"  ,"N",4, 0} ,;
{"EDFIN"  ,"N",4, 0} ,;
{"EDSUSP"   ,"N",4, 0},;
{"STATUS"   ,"C",1,0}}
_cNome  := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"CONTRATO",.F.,.F.)
CINDEX1 := CRIATRAB(NIL,.F.)
CKEY    := "CONTRATO+CLIENTE+PRODUTO"
INDREGUA("CONTRATO",CINDEX1,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")


//trocar por select
DbSelectArea("ZZW")
if RDDName() <> "TOPCONN"
		MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
		Return nil
endif
                            
cQuery := "SELECT zzw_num, zzw_client, zzw_nomecl, zzw_dtatu, zzw_valor, zzw_valoro, zzw_produt, zzw_edinic, zzw_edfin, zzw_edsusp, zzw_status from "+ RetSqlName("ZZW") +" WHERE ZZW_FILIAL='" +xFilial("ZZW")+ "' AND ZZW_PRODUT='"+ MV_PAR02 +"' AND ZZW_EDINIC>="+ MV_PAR03 +" AND ZZW_EDSUSP<='" + MV_PAR04 + "' AND ZZW_STATUS='A' AND D_E_L_E_T_<>'*'"
IF MV_PAR05 ==1  //³ MV_PAR05 STATUS {1=TODOS, 2= ATIVOS, 3=INATIVOS, 4=CANCELADOS}
	_cFiltro := ""
ELSEIF MV_PAR05 ==2  //³ MV_PAR05 STATUS {1=TODOS, 2= ATIVOS, 3=INATIVOS, 4=CANCELADOS}
	_cFiltro := _cFiltro+" AND ZZW_STATUS='A'"
ELSEIF MV_PAR01==3
	_cFiltro := _cFiltro+" AND ZZW_STATUS='I'"
ELSEIF MV_PAR01 ==4
	_cFiltro := _cFiltro+" AND ZZW_STATUS='C'"	
ENDIF     
cQuery := cQuery + _cFiltro

TCQUERY cQuery NEW ALIAS "QUERYZZW"
DbSelectArea("QUERYZZW")
DBGOTOP()

PROCREGUA(RECCOUNT())
WHILE !EOF()
	INCPROC("Lendo Contrato: "+Alltrim(QUERYZZW->ZZW_NUM))
	IF MV_PAR01 == 2
		DBSelectArea("SC5")
		DBSetOrder(11)     //(B) :C5_FILIAL + C5_CONTRATO +  C5_EMISSAO + C5_NUM
		IF DBSeek(xfilial("SC5")+QUERYZZW->ZZW_NUM)
			while !eof() .and. SC5->C5_CONTRATO == QUERYZZW->ZZW_NUM
				DBSelectArea("SC6")
				DBSetOrder(1)     //(1) :C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
				IF DBSeek(xfilial("SC6")+SC5->C5_NUM+"01"+QUERYZZW->ZZW_PRODUT)
					dbselectarea("PEDSW")
					RECLOCK("PEDSW",.T.)
						PEDSW->CONTRATO := ZZW->ZZW_NUM
						PEDSW->CLIENTE  := ZZW->ZZW_CLIENT
						PEDSW->NOME     := ZZW->ZZW_NOMECL
						PEDSW->PEDIDO   := SC5->C5_NUM
						PEDSW->PRODUTO  := SC6->C6_PRODUTO
						PEDSW->VALOR    := SC5->C5_PARC1
						PEDSW->EMISSAO  := SC5->C5_DATA
						PEDSW->EDINIC   := SC6->C6_EDINIC
						PEDSW->EDFIN    := SC6->C6_EDFIN
						PEDSW->EDSUSP   := SC6->C6_EDSUSP
					MsUnlock()
				ENDIF
				DBSELECTAREA("SC5")
			   	DBSKIP()
			end
		ENDIF
	ELSE //MV_PAR01 ==1
		dbselectarea("CONTRATO")
		RECLOCK("CONTRATO",.T.)
			CONTRATO->CONTRATO := QUERYZZW->ZZW_NUM
			CONTRATO->CLIENTE  := QUERYZZW->ZZW_CLIENT
			CONTRATO->NOME     := QUERYZZW->ZZW_NOMECL
			CONTRATO->PRODUTO  := QUERYZZW->ZZW_PRODUT
			CONTRATO->VALOR    := QUERYZZW->ZZW_VALOR
			CONTRATO->EDINIC := ZZW->ZZW_EDINIC
			CONTRATO->EDFIN := ZZW->ZZW_EDFIN
			CONTRATO->EDSUSP    := ZZW->ZZW_EDSUSP
			CONTRATO->STATUS   := QUERYZZW->ZZW_STATUS
		MsUnlock()
	ENDIF
	DBSELECTAREA("QUERYZZW")
	DBSKIP()
END //WHILE	
IF MV_PAR01 == 2
	dbselectarea("PEDSW")
	cArqPath   :=GetMv("MV_PATHTMP")                    
	cArquivo := cArqPath+"PEDSW.DBF"
ELSE
	dbselectarea("CONTRATO")
	cArqPath   :=GetMv("MV_PATHTMP")                    
	cArquivo := cArqPath+"CONTRATO.DBF"
ENDIF
COPY TO &cArquivo VIA "DBFCDXADS" // 20121106 
MsgInfo(cArquivo)  
DBSELECTAREA("PEDSW")
DBCLOSEAREA("PEDSW")
DBSELECTAREA("CONTRATO")
DBCLOSEAREA("CONTRATO")	
DBSELECTAREA("SC5")
DBCLOSEAREA("SC5")
DBSELECTAREA("SC6")
DBCLOSEAREA("SC6")
DBSELECTAREA("QUERYZZW")
DBCLOSEAREA("QUERYZZW")
RETURN