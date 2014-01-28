#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
//Danilo C S Pala 20070302 reformulacao por query para melhorar desempenho
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RENPUBV   ³Autor: Rosane Lacava Rodrigues³ Data:   28/01/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de Renovacoes Publicidade por Vencto - Gerencia  ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat045()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CTITULO")
SetPrvt("CCABEC1,CCABEC2,CPROGRAMA,CTAMANHO,LIMITE,NCARACTER")
SetPrvt("NLASTKEY,CDESC1,CDESC2,CDESC3,M_PAG,NLIN")
SetPrvt("ARETURN,_ACAMPOS,_CNOME,CINDEX,CKEY,WNREL")
SetPrvt("CSTRING,_CFILTRO,MIND,MAV,MVEND,MCLI")
SetPrvt("MQTDE,MITEM,MINIC,mhora")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //Periodo Inicial   ³
//³ mv_par02             //Periodo Final     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG:='PFAT24'
IF !PERGUNTE(CPERG)
	RETURN
ENDIF

cTitulo  := SPACE(04)+"***** RELATORIO DE RENOVACOES / GERENCIA - POR VENCIMENTO *****"
cCabec1  := SPACE(50)+"***** PERIODO: " +DTOC(MV_PAR01)+ " A " +DTOC(MV_PAR02)+ "*****"
cCabec2  := "Vendedor Nome do Vendedor           Cliente Nome do Cliente                     Num.AV/It Revista EdIn EdFn Vencto. Ins Vl.Inser‡Æo"
cPrograma:= "RENPUBG"
cTamanho := "M"
LIMITE   := 132
nCaracter:= 10
NLASTKEY := 0
cDesc1   := PADC("Este programa gera o relatorio de renovacoes",70)
cDesc2   := PADC("da publicidade por vencimento - Gerˆncia",70)
cDesc3   := " "
M_PAG    := 1
nlin     := 80

aRETURN:={"Especial", 1,"Administracao", 2, 2, 1," ",1 }

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/* //20070201 reformulacao
_aCampos := {{"CODVEND"  ,"C",6 ,0} ,;
{"CODCLI"   ,"C",6, 0} ,;
{"NUMAV"    ,"C",6, 0} ,;
{"ITEM"     ,"C",2, 0} ,;
{"INICIAL"  ,"N",4, 0} ,;
{"FINAL"    ,"N",4 ,0} ,;
{"PRODUTO"  ,"C",7 ,0} ,;
{"DTCIRC"   ,"D",8, 0} ,;
{"VALOR"    ,"N",10,2} ,;
{"QTDE"     ,"N",4, 0}}

If Select("RENOV") <> 0
	DbSelectArea("RENOV")
	DbCloseArea()
EndIf

_cNome  := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"RENOV",.F.,.F.)
CINDEX  := CRIATRAB(NIL,.F.)
CKEY    := "CODVEND+CODCLI+NUMAV+ITEM"
MsAguarde({|| INDREGUA("RENOV",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice (RENOV)...")
*/ //20070201 reformulacao ate aqui
MHORA := TIME()
WNREL   := "RENPUBG_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING := "SZS"
WNREL   := SETPRINT(CSTRING,WNREL,CPERG,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
SETDEFAULT(aRETURN,CSTRING)

IF NLASTKEY==27 .OR. NLASTKEY==65
	DBCLOSEAREA()
	RETURN
ENDIF

RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        RptStatus({|| Execute(RptDetail)})

Return

Static Function RptDetail()
/*  //20070201 reformulacao daqui
dbselectarea("SZS")
_cFiltro := "ZS_FILIAL == '"+xFilial("SZS")+"'"
_cFiltro := _cFiltro+".and. ZS_SITUAC <> 'CC' .AND. ZS_CODTIT <> SPACE(03)"
CINDEX   := CRIATRAB(NIL,.F.)
CKEY     := "ZS_FILIAL+ZS_NUMAV+ZS_ITEM+STR(ZS_NUMINS,3)"
MsAguarde({|| INDREGUA("SZS",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (SZS)...")
//RETINDEX("SZS")
//MIND:=RETINDEX("SZS")
//DBSETINDEX(CINDEX)
//MIND:=MIND+1

dbselectarea("SC5")
_cFiltro := "C5_FILIAL == '"+xFilial("SC5")+"'"
_cFiltro := _cFiltro+".and.C5_DIVVEN =='PUBL'"
CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="C5_FILIAL+C5_NUM"
MsAguarde({|| INDREGUA("SC5",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (SC5)...")

DBGOTOP()

SETREGUA(RECCOUNT()/6)

WHILE !EOF() .AND. SC5->C5_FILIAL == xFilial("SC5") .and. SC5->C5_DIVVEN == 'PUBL'
	INCREGUA()
	MAV   := SC5->C5_NUM
	MVEND := SC5->C5_VEND1
	MCLI  := SC5->C5_CLIENTE
	DBSELECTAREA("SC6")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SC6")+MAV)
	IF FOUND()
		WHILE !Eof() .and. SC6->C6_FILIAL == xFilial ("SC6") .and. SC6->C6_NUM == MAV
			MQTDE := SC6->C6_QTDVEN
			MITEM := SC6->C6_ITEM
			MINIC := SC6->C6_EDINIC
			DBSELECTAREA("SZS")
			//DBSETORDER (MIND)
			DBSEEK(XFILIAL("SZS")+MAV+MITEM+STR(MQTDE,3))
			IF FOUND() .AND. SZS->ZS_DTCIRC >= MV_PAR01 .AND. SZS->ZS_DTCIRC <= MV_PAR02
				DBSELECTAREA("RENOV")
				RECLOCK("RENOV",.T.)
				RENOV->CODVEND := MVEND
				RENOV->CODCLI  := MCLI
				RENOV->QTDE    := MQTDE
				RENOV->NUMAV   := MAV
				RENOV->ITEM    := MITEM
				RENOV->INICIAL := MINIC
				RENOV->FINAL   := SZS->ZS_EDICAO
				RENOV->DTCIRC  := SZS->ZS_DTCIRC
				RENOV->PRODUTO := SZS->ZS_VEIC
				RENOV->VALOR   := SZS->ZS_VALOR
				RENOV->(MSUNLOCK())
			ENDIF
			DBSELECTAREA("SC6")
			DBSKIP()
			INCREGUA()
		END
	ENDIF
	DBSELECTAREA("SC5")
	DBSKIP()
END
*/  //20070201 reformulacao ate aqui
//20070201 reformulacao query
cQuery := "select c5_vend1 as CODVEND, c5_cliente as CODCLI, c5_codag as CODAG, c5_num as NUMAV, c6_item as ITEM, c6_edinic as INICIAL, zs_edicao as FINAL, ZS_VEIC as PRODUTO, c6_descri as DESCR, zs_dtcirc as DTCIRC, zs_valor as VALOR, c6_qtdven as QTDE"
cQuery := cQuery + " from "+ RetSqlName("SZS") +" ZS, "+ RetSqlName("SC5") +" C5, "+ RetSqlName("SC6") +" C6"
cQuery := cQuery + " where c5_filial='"+xfilial("SC5")+"' and c6_filial='"+xfilial("SC6")+"' and c5_num = c6_num and c5_divven='PUBL' "
cQuery := cQuery + " and zs_filial='"+xfilial("SZS")+"' and zs_numav = c6_num and zs_item = c6_item and zs_numins = c6_qtdven"
cQuery := cQuery + " and zs_situac<>'CC' and zs_codtit<>'   '  and ZS_DTCIRC>='"+ dtos(MV_PAR01) +"' and ZS_DTCIRC<='"+ dtos(MV_PAR02) +"'"
cQuery := cQuery + " and zs.d_e_l_e_t_<>'*' and c5.d_e_l_e_t_<>'*' and c6.d_e_l_e_t_<>'*'"
cQuery := cQuery + " order by CODVEND,CODCLI,CODAG,NUMAV,ITEM"
//TCQUERY cQuery NEW ALIAS "RENOV" //20070301 query
MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "RENOV", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")

TcSetField("RENOV","DTCIRC"   ,"D")

DBSELECTAREA("RENOV")
//DBSETORDER(1)  //20070201 reformulacao
DBGOTOP()
WHILE !EOF()
	If nlin > 60
		nlin := Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho,18)
		nlin := nlin + 2
	Endif
	MVEND  := CODVEND
	MCLI   := CODCLI
	DBSELECTAREA("SA3")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SA3")+MVEND)
	DBSELECTAREA("SA1")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SA1")+MCLI)
	@ nlin,001 PSAY RENOV->CODVEND
	@ nlin,009 PSAY SUBST(SA3->A3_NOME,1,26)
	@ nlin,036 PSAY RENOV->CODCLI
	@ nlin,044 PSAY SUBST(SA1->A1_NOME,1,35)
	@ nlin,080 PSAY RENOV->NUMAV+'/'+RENOV->ITEM
	@ nlin,092 PSAY RENOV->PRODUTO
	@ nlin,098 PSAY RENOV->INICIAL
	@ nlin,103 PSAY RENOV->FINAL
	@ nlin,108 PSAY RENOV->DTCIRC
	@ nlin,116 PSAY RENOV->QTDE
	@ nlin,120 PSAY RENOV->VALOR PICTURE "@E 9,999,999.99"
	nlin := nlin + 2
	DbSelectArea("RENOV")
	DbSkip()
END

DBSELECTAREA("RENOV")
SET DEVICE TO SCREEN

IF aRETURN[5] ==1
	SET PRINTER TO
	DBCOMMITALL()
	OURSPOOL(WNREL)
ENDIF

MS_FLUSH()

DBCLOSEAREA()

DBSELECTAREA("SC6")
RETINDEX("SC6")

DBSELECTAREA("SC5")
RETINDEX("SC5")

DBSELECTAREA("SA3")
RETINDEX("SA3")

DBSELECTAREA("SA1")
RETINDEX("SA1")

DBSELECTAREA("SZS")
RETINDEX("SZS")

RETURN