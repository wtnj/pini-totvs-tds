#include "rwmake.ch"
/*/
Alterado por Danilo C S Pala em 20061123: CIDADE E ESTADO
Alterado por Danilo C S Pala em 20081215: equipe, regiao e atendimento: nova query
Alterado por Danilo C S Pala em 20090109: ARVORE
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATR52   ³Autor: Marcos Farineli        ³ Data:   20/09/02 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera arquivo DBF da Publicidade                            ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function rfatr52()

Private MHORA     ,CARQ      ,CSTRING    ,NLASTKEY
Private CCABEC2   ,LCONTINUA ,CARQPATH   ,_CSTRING  ,MEMPRESA   ,CPERG
Private LEND      ,BBLOCO     ,CMSG

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ mv_par01 Vencimento de:                                                 ³
//³ mv_par02 Vencimento at‚:                                                ³
//³ mv_par03 Baixado   Em Aberto    Ambos                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MHORA     := TIME()
cArq      := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
nLastKey  := 00
lContinua := .T.
cArqPath  := GetMv("MV_PATHTMP")
_cString  := cArqPath+cString+".DBF"
mEmpresa  := SM0->M0_CODIGO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso nao exista, cria grupo de perguntas.                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:="ATR241"

If !Pergunte(cPerg)
	Return
Endif

IF Lastkey()==27
	Return
Endif

lEnd:= .F.
bBloco:= {|lEnd| Filtra(@lEnd)}
Processa( bBloco, "Aguarde" ,"Processando...", .T. )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorna indices originais...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("TRB")
DbCloseArea()

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ Filtra()                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Filtra arquivo SE1 para ser utilizado no programa.            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function FILTRA()

Local cQuery := ""
ProcRegua(4)

IncProc("Gerando Query")


/*cQuery := "SELECT ZS_NUMAV AV,ZS_ITEM ITEM,ZS_CODREV REVISTA,ZS_NUMINS NUM_INSERC,"
cQuery += "ZS_EDICAO EDICAO,ZS_DTCIRC DATA_CIRC,A1_COD CLIENTE,A1_CEP CEP,A1_NOME NOME_CLI, A1_MUN CIDADE, A1_EST ESTADO," //20061123
cQuery += "ZS_CODPROD PROD,B1_DESC DESCR,ZS_VEND VEND,A3_NOME NOME_VEND,"
cQuery += "B1_GRUPO GRP_PROD,ZS_NFISCAL NF,"
cQuery += "(ZS_VALOR * DECODE(C5_TPTRANS,'04',0.8,'12',0.8,1.0)) VALOR_LIQ,"
cQuery += "DECODE(C5_TPTRANS,'04',0.8,'12',0.8,1.0) FATOR,C5_TPTRANS TP_TRANS "
cQuery += ", C6_CODTIT CODTIT, C6_SECTION SECAO "
cQuery += "FROM SZS010 SZS,SC5010 SC5,SB1010 SB1,SA1010 SA1,SA3010 SA3, SC6010 SC6 "
cQuery += "WHERE ZS_FILIAL = '  ' AND ZS_DTCIRC BETWEEN '"+DTOS(mv_par01)+"' AND '"+DTOS(mv_par02)+"' "
cQuery += "AND ZS_VALOR <> 1 AND ZS_SITUAC <> 'CC' AND SZS.D_E_L_E_T_ <> '*' "
cQuery += "AND C5_FILIAL = '01' AND C5_NUM = ZS_NUMAV AND C5_TPTRANS <> '03' AND SC5.D_E_L_E_T_ <> '*' "
cQuery += "AND B1_FILIAL = '  ' AND B1_COD = ZS_CODPROD AND SB1.D_E_L_E_T_ <> '*' "
cQuery += "AND A3_FILIAL = '  ' AND A3_COD = ZS_VEND AND SA3.D_E_L_E_T_ <> '*' "
cQuery += "AND A1_FILIAL = '  ' AND A1_COD = ZS_CODCLI AND A1_LOJA = '01' AND SA1.D_E_L_E_T_ <> '*' "
cQuery += "AND C6_FILIAL = '01' AND C6_NUM = C5_NUM AND C6_PRODUTO = ZS_CODPROD AND C6_ITEM = ZS_ITEM AND SC6.D_E_L_E_T_<>'*' "
cQuery += "ORDER BY ZS_DTCIRC,ZS_CODREV,ZS_CODPROD"
*/
                                                          
cQuery := "SELECT ZS_NUMAV AV,ZS_ITEM ITEM,ZS_CODREV REVISTA, B1_TITULO AS TITULO, ZS_NUMINS NUM_INSERC,"
cQuery += " ZS_EDICAO EDICAO, SUBSTR(f_converter_data_siga(ZS_DTCIRC),1,10) DATA_CIRC,A1_COD CLIENTE,A1_CEP CEP,A1_NOME NOME_CLI, A1_MUN CIDADE, A1_EST ESTADO,"
cQuery += " ZS_CODPROD PROD,B1_DESC DESCR,ZS_VEND VEND,A3_NOME NOME_VEND,"
cQuery += " B1_GRUPO GRP_PROD,ZS_NFISCAL NF,"
cQuery += " (ZS_VALOR * DECODE(C5_TPTRANS,'04',0.8,'12',0.8,1.0) * DECODE(C5_PUBREG2,'      ',1,0.5)) VALOR_LIQ,"
cQuery += " DECODE(C5_TPTRANS,'04',0.8,'12',0.8,1.0) FATOR,C5_TPTRANS TP_TRANS"
cQuery += " , C6_CODTIT CODTIT, C6_SECTION SECAO"
cQuery += " , C5_PUBEQUI EQUIPE, C5_PUBTIP1 TIPO, C5_PUBREG1 REGIAO, C5_PUBATE1 ATEND, DECODE(C5_PUBREG2,'      ',100,50) AS PORCENT"
cQuery += " , SUBSTR(F_SB5_ARVORE(B1_COD,1),1,60) ARVORE1, SUBSTR(F_SB5_ARVORE(B1_COD,2),1,60) ARVORE2, SUBSTR(F_SB5_ARVORE(B1_COD,3),1,60) ARVORE3, SUBSTR(F_SB5_ARVORE(B1_COD,4),1,60) ARVORE4" //20090109
cQuery += " FROM SZS010 SZS,SC5010 SC5,SB1010 SB1,SA1010 SA1,SA3010 SA3, SC6010 SC6"
cQuery += " WHERE ZS_FILIAL = '  ' AND ZS_DTCIRC BETWEEN '"+DTOS(mv_par01)+"' AND '"+DTOS(mv_par02)+"'"
cQuery += " AND ZS_VALOR <> 1 AND ZS_SITUAC <> 'CC' AND SZS.D_E_L_E_T_ <> '*'"
cQuery += " AND C5_FILIAL = '01' AND C5_NUM = ZS_NUMAV AND C5_TPTRANS <> '03' AND SC5.D_E_L_E_T_ <> '*'"
cQuery += " AND B1_FILIAL = '  ' AND B1_COD = ZS_CODPROD AND SB1.D_E_L_E_T_ <> '*'"
cQuery += " AND A3_FILIAL = '  ' AND A3_COD = ZS_VEND AND SA3.D_E_L_E_T_ <> '*'"
cQuery += " AND A1_FILIAL = '  ' AND A1_COD = ZS_CODCLI AND A1_LOJA = '01' AND SA1.D_E_L_E_T_ <> '*'"
cQuery += " AND C6_FILIAL = '01' AND C6_NUM = C5_NUM AND C6_PRODUTO = ZS_CODPROD AND C6_ITEM = ZS_ITEM AND SC6.D_E_L_E_T_<>'*'"
cQuery += " UNION ALL"
cQuery += " SELECT ZS_NUMAV AV,ZS_ITEM ITEM,ZS_CODREV REVISTA, B1_TITULO AS TITULO, ZS_NUMINS NUM_INSERC,"
cQuery += " ZS_EDICAO EDICAO, SUBSTR(f_converter_data_siga(ZS_DTCIRC),1,10) DATA_CIRC,A1_COD CLIENTE,A1_CEP CEP,A1_NOME NOME_CLI, A1_MUN CIDADE, A1_EST ESTADO,"
cQuery += " ZS_CODPROD PROD,B1_DESC DESCR,C5_VEND2 VEND,A3_NOME NOME_VEND,"
cQuery += " B1_GRUPO GRP_PROD,ZS_NFISCAL NF,"
cQuery += " (ZS_VALOR * DECODE(C5_TPTRANS,'04',0.8,'12',0.8,1.0) * DECODE(C5_PUBREG2,'      ',1,0.5)) VALOR_LIQ,"
cQuery += " DECODE(C5_TPTRANS,'04',0.8,'12',0.8,1.0) FATOR,C5_TPTRANS TP_TRANS"
cQuery += " , C6_CODTIT CODTIT, C6_SECTION SECAO"
cQuery += " , C5_PUBEQUI EQUIPE, C5_PUBTIP2 TIPO, C5_PUBREG2 REGIAO, C5_PUBATE2 ATEND, DECODE(C5_PUBREG2,'      ',100,50) AS PORCENT"
cQuery += " , SUBSTR(F_SB5_ARVORE(B1_COD,1),1,60) ARVORE1, SUBSTR(F_SB5_ARVORE(B1_COD,2),1,60) ARVORE2, SUBSTR(F_SB5_ARVORE(B1_COD,3),1,60) ARVORE3, SUBSTR(F_SB5_ARVORE(B1_COD,4),1,60) ARVORE4" //20090109
cQuery += " FROM SZS010 SZS,SC5010 SC5,SB1010 SB1,SA1010 SA1,SA3010 SA3, SC6010 SC6"
cQuery += " WHERE ZS_FILIAL = '  ' AND ZS_DTCIRC BETWEEN '"+DTOS(mv_par01)+"' AND '"+DTOS(mv_par02)+"'"
cQuery += " AND ZS_VALOR <> 1 AND ZS_SITUAC <> 'CC' AND SZS.D_E_L_E_T_ <> '*'"
cQuery += " AND C5_FILIAL = '01' AND C5_NUM = ZS_NUMAV AND C5_TPTRANS <> '03' AND SC5.D_E_L_E_T_ <> '*'"
cQuery += " AND B1_FILIAL = '  ' AND B1_COD = ZS_CODPROD AND SB1.D_E_L_E_T_ <> '*'"
cQuery += " AND A3_FILIAL = '  ' AND A3_COD = C5_VEND2 AND SA3.D_E_L_E_T_ <> '*'"
cQuery += " AND A1_FILIAL = '  ' AND A1_COD = ZS_CODCLI AND A1_LOJA = '01' AND SA1.D_E_L_E_T_ <> '*'"
cQuery += " AND C6_FILIAL = '01' AND C6_NUM = C5_NUM AND C6_PRODUTO = ZS_CODPROD AND C6_ITEM = ZS_ITEM AND SC6.D_E_L_E_T_<>'*'"
cQuery += " AND C5_PUBREG2<>'      '"
lEnd := .f.

IncProc("Checando Area Temporaria")

If Select("TRB") <> 0
	DbSelectArea("TRB")
	DbCloseArea()
EndIf

IncProc("Enviando Query")

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRB", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")

//TcSetField("TRB","DATA_CIRC"  ,"D")
TcSetField("TRB","DATA_CIRC","C",10,0)
TcSetField("TRB","ARVORE1"  ,"C",60,0)
TcSetField("TRB","ARVORE2"  ,"C",60,0)
TcSetField("TRB","ARVORE3"  ,"C",60,0)

Dbgotop()
IncProc("Copiando arquivo")

If File(_cString)
	FRename(_cString,(Substr(_cString,1,7)+".old"))
EndIf

COPY TO &_cString VIA "DBFCDXADS" // 20121106 

cMsg := "Arquivo gerado " + cString

MSGINFO(cMsg)

Return