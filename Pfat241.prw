#include "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT171   ³Autor: Danilo c s Pala        ³ Data:20061128    ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: RELATORIO DE CONTRATOS DE SOFTWARE						 ³ ±±
±±³                                                                      ³ ±±   
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function PFAT241()

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CDESC1")
SetPrvt("CDESC2,CDESC3,CTITULO,CCABEC1,CCABEC2,CPROGRAMA")
SetPrvt("CTAMANHO,LIMITE,NCARACTER,ARETURN,WNREL,CSTRING")
SetPrvt("NLASTKEY,_ACAMPOS,_CNOME,CINDEX,CKEY,_CFILTRO")
SetPrvt("MCLI,MPED,MPRD,M_PAG,L,MSUBT")
SetPrvt("MPRODUTO,MAUTOR, MTOTAUT, MQTD, MDESCRIC, cArqPath, cArquivo")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ MV_PAR01 TIPO {1=CONTRATO, 2=PEDIDO}	 |
//³ MV_PAR02 DATA INICIO					 ³
//³ MV_PAR03 DATA FIM						 ³
//³ MV_PAR04 STATUS {1=TODOS, 2= ATIVOS, 3=INATIVOS, 4=CANCELADOS}
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:='FAT241' 
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
{"VENCTO"   ,"D",8, 0}}
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
{"DTINICIO" ,"D",8, 0} ,;
{"DTFIM"    ,"D",8, 0} ,;
{"STATUS"   ,"C",1,0}}
_cNome  := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"CONTRATO",.F.,.F.)
CINDEX1 := CRIATRAB(NIL,.F.)
CKEY    := "CONTRATO+CLIENTE+PRODUTO"
INDREGUA("CONTRATO",CINDEX1,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")


DBSELECTAREA("ZZW")
_cFiltro := "ZZW_FILIAL == '"+xFilial("ZZW")+"'"
_cFiltro := _cFiltro+" .and. DTOS(ZZW_DTINI)>='"+DTOS(MV_PAR02)+"'"
_cFiltro := _cFiltro+" .and. '"+DTOS(MV_PAR03)+"'<=DTOS(ZZW_DTFIM)"
IF MV_PAR04 ==2  //³ MV_PAR04 STATUS {1=TODOS, 2= ATIVOS, 3=INATIVOS, 4=CANCELADOS}
	_cFiltro := _cFiltro+" .and. ZZW_STATUS='A'"
ELSEIF MV_PAR01 ==3
	_cFiltro := _cFiltro+" .and. ZZW_STATUS='I'"
ELSEIF MV_PAR01 ==4
	_cFiltro := _cFiltro+" .and. ZZW_STATUS='C'"	
ENDIF
CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="ZZW_FILIAL+ZZW_NUM+ZZW_CLIENT"
INDREGUA("ZZW",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")
DBgotop()        

SETREGUA(RECCOUNT())
DO WHILE .NOT. EOF()  
	IF MV_PAR01 == 2
		DBSelectArea("SC5")
		DBSetOrder(11)     //(B) :C5_FILIAL + C5_CONTRATO +  C5_EMISSAO + C5_NUM
		IF DBSeek(xfilial("SC5")+ZZW->ZZW_NUM)
			while !eof() .and. SC5->C5_CONTRATO == ZZW->ZZW_NUM
				dbselectarea("PEDSW")
				RECLOCK("PEDSW",.T.)
					PEDSW->CONTRATO := ZZW->ZZW_NUM
					PEDSW->CLIENTE  := ZZW->ZZW_CLIENT
					PEDSW->NOME     := ZZW->ZZW_NOMECL
					PEDSW->PEDIDO   := SC5->C5_NUM
					PEDSW->PRODUTO  := ZZW->ZZW_PRODUT
					PEDSW->VALOR    := SC5->C5_PARC1
					PEDSW->EMISSAO  := SC5->C5_DATA
					PEDSW->VENCTO   := SC5->C5_DATA1
				MsUnlock()
				DBSELECTAREA("SC5")
			   	DBSKIP()
			end
		ENDIF
	ELSE //MV_PAR01 ==1
		dbselectarea("CONTRATO")
		RECLOCK("CONTRATO",.T.)
			CONTRATO->CONTRATO := ZZW->ZZW_NUM
			CONTRATO->CLIENTE  := ZZW->ZZW_CLIENT
			CONTRATO->NOME     := ZZW->ZZW_NOMECL
			CONTRATO->PRODUTO  := ZZW->ZZW_PRODUT
			CONTRATO->VALOR    := ZZW->ZZW_VALOR
			CONTRATO->DTINICIO := ZZW->ZZW_DTINI
			CONTRATO->DTFIM    := ZZW->ZZW_DTFIM
			CONTRATO->STATUS   := ZZW->ZZW_STATUS
		MsUnlock()
	ENDIF
	DBSELECTAREA("ZZW")
	DBSKIP()
	INCREGUA()      
ENDDO                      

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
DBSELECTAREA("ZZW")
RETINDEX("ZZW")
DBCLOSEAREA("ZZW")
RETURN