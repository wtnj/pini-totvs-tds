#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/               
UPDATE 20071114 --CLIENTES
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: RFAT119   �Autor: Danilo c s Pala        � Data:20071108    � ��
������������������������������������������������������������������������Ĵ ��
���Descri��o: RELATORIO DE NOTAS FISCAIS DE ENTRADA                      � ��
���                                                                      � ��   
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento                                      � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function RFAT119()

SetPrvt("CPERG, cQuery, cQuery1, MHORA, cArq, cArqPath, cArquivo")
SetPrvt("cArq1, cArqPath1, cArquivo1")

//������������������������������������������Ŀ
//� Vari�veis utilizadas para parametros     �
//� MV_PAR01 DO FORNECEDOR                   |
//� MV_PAR02 ATE FORNECEDOR					 �
//� MV_PAR03 DO PRODUTO						 �
//� MV_PAR04 ATE PRODUTO					 �
//� MV_PAR05 DA SERIE						 �
//� MV_PAR06 ATE SERIE						 �
//� MV_PAR07 DA NOTA					 	 �
//� MV_PAR08 ATE NOTA					 	 �
//� MV_PAR09 DA EMISSAO					 	 �
//� MV_PAR10 ATE EMISSAO				 	 �
//��������������������������������������������
cPerg:='RFT119' 
IF .NOT. PERGUNTE(cPerg)
   RETURN
ENDIF

RptDetail()
Return




Static Function RptDetail()
DbSelectArea("SD1")
if RDDName() <> "TOPCONN"
		MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
		Return nil
endif
//FORNECEDOR
cQuery := "SELECT F1_TIPO AS TIPONF, F1_SERIE AS SERIE, F1_DOC AS NFE, D1_ITEM AS ITEM, F1_EMISSAO AS EMISSAO, D1_COD AS PRODUTO, D1_UM AS UNID, B1_DESC AS PROD, B1_TIPO AS TIPO, D1_TES AS TES, F4_TEXTO AS NAT, D1_CF AS CF, D1_CONTA AS CONTA, D1_QUANT AS QTD, D1_VUNIT AS VLUNIT, D1_TOTAL AS VLTOTIT, F1_VALMERC AS VLMRCNFE, F1_VALBRUT AS VLBRTNFE, F1_FORNECE AS COD, A2_NOME AS NOME, A2_CGC AS CGC, A2_MUN AS MUN, A2_EST AS UF"
cQuery := cQuery + " FROM "+ RetSqlName("SA2") + " SA2, "+ RetSqlName("SB1") + " SB1, "+ RetSqlName("SF1") + " SF1, "+ RetSqlName("SD1") + " SD1, "+ RetSqlName("SF4") + " SF4 WHERE SA2.A2_FILIAL='"+xfilial("SA2")+"' AND  SB1.B1_FILIAL ='"+xfilial("SB1")+"' AND SF1.F1_FILIAL='"+xfilial("SF1")+"' AND  SD1.D1_FILIAL='"+xfilial("SD1")+"' AND SF4.F4_FILIAL='"+ xFilial("SF4") +"'"
cQuery := cQuery + " AND SA2.A2_COD = SF1.F1_FORNECE AND SA2.A2_LOJA = SF1.F1_LOJA AND SF1.F1_DOC = SD1.D1_DOC AND SF1.F1_SERIE = SD1.D1_SERIE AND SF1.F1_EMISSAO = SD1.D1_EMISSAO AND SD1.D1_COD = SB1.B1_COD AND SD1.D1_TES=SF4.F4_CODIGO"
cQuery := cQuery + " AND SA2.A2_COD>='"+ MV_PAR01 +"' AND SA2.A2_COD<='"+ MV_PAR02 +"' AND SB1.B1_COD >='"+ MV_PAR03 +"' AND SB1.B1_COD <='"+ MV_PAR04 +"' AND SF1.F1_SERIE>='"+ MV_PAR05 +"' AND SF1.F1_SERIE<='"+ MV_PAR06 +"' AND SF1.F1_DOC>='"+ MV_PAR07 +"' AND SF1.F1_DOC<='"+ MV_PAR08 +"' AND SF1.F1_EMISSAO>='"+ DTOS(MV_PAR09) +"' AND SF1.F1_EMISSAO<='"+ DTOS(MV_PAR10) +"'"
cQuery := cQuery + " AND SA2.D_E_L_E_T_<>'*' AND SB1.D_E_L_E_T_<>'*' AND SF1.D_E_L_E_T_<>'*' AND SD1.D_E_L_E_T_<>'*'"
//cQuery := cQuery + " ORDER BY F1_TIPO, F1_SERIE, F1_DOC, D1_ITEM"
//CLIENTE
cQuery := cQuery + " UNION "                              
cQuery := cQuery + " SELECT F1_TIPO AS TIPONF, F1_SERIE AS SERIE, F1_DOC AS NFE, D1_ITEM AS ITEM, F1_EMISSAO AS EMISSAO, D1_COD AS PRODUTO, D1_UM AS UNID, B1_DESC AS PROD, B1_TIPO AS TIPO, D1_TES AS TES, F4_TEXTO AS NAT, D1_CF AS CF, D1_CONTA AS CONTA, D1_QUANT AS QTD, D1_VUNIT AS VLUNIT, D1_TOTAL AS VLTOTIT, F1_VALMERC AS VLMRCNFE, F1_VALBRUT AS VLBRTNFE, F1_FORNECE AS COD, A1_NOME AS NOME, A1_CGC AS CGC, A1_MUN AS MUN, A1_EST AS UF"
cQuery := cQuery + " FROM "+ RetSqlName("SA1") + " SA1, "+ RetSqlName("SB1") + " SB1, "+ RetSqlName("SF1") + " SF1, "+ RetSqlName("SD1") + " SD1, "+ RetSqlName("SF4") + " SF4 WHERE SA1.A1_FILIAL='"+xfilial("SA1")+"' AND  SB1.B1_FILIAL ='"+xfilial("SB1")+"' AND SF1.F1_FILIAL='"+xfilial("SF1")+"' AND  SD1.D1_FILIAL='"+xfilial("SD1")+"' AND SF4.F4_FILIAL='"+ xFilial("SF4") +"'"
cQuery := cQuery + " AND SA1.A1_COD = SF1.F1_FORNECE AND SA1.A1_LOJA = SF1.F1_LOJA AND SF1.F1_DOC = SD1.D1_DOC AND SF1.F1_SERIE = SD1.D1_SERIE AND SF1.F1_EMISSAO = SD1.D1_EMISSAO AND SD1.D1_COD = SB1.B1_COD AND SD1.D1_TES=SF4.F4_CODIGO"
cQuery := cQuery + " AND SA1.A1_COD>='"+ MV_PAR01 +"' AND SA1.A1_COD<='"+ MV_PAR02 +"' AND SB1.B1_COD >='"+ MV_PAR03 +"' AND SB1.B1_COD <='"+ MV_PAR04 +"' AND SF1.F1_SERIE>='"+ MV_PAR05 +"' AND SF1.F1_SERIE<='"+ MV_PAR06 +"' AND SF1.F1_DOC>='"+ MV_PAR07 +"' AND SF1.F1_DOC<='"+ MV_PAR08 +"' AND SF1.F1_EMISSAO>='"+ DTOS(MV_PAR09) +"' AND SF1.F1_EMISSAO<='"+ DTOS(MV_PAR10) +"'"
cQuery := cQuery + " AND SA1.D_E_L_E_T_<>'*' AND SB1.D_E_L_E_T_<>'*' AND SF1.D_E_L_E_T_<>'*' AND SD1.D_E_L_E_T_<>'*'"
//cQuery := cQuery + " ORDER BY F1_TIPO, F1_SERIE, F1_DOC, D1_ITEM"

TCQUERY cQuery NEW ALIAS "QUERYNFE"
DbSelectArea("QUERYNFE")
DBGOTOP()

MHORA     := TIME()
cArq      := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,4,2) +".DBF"
cArqPath   :=GetMv("MV_PATHTMP")                    
cArquivo := cArqPath+cArq
COPY TO &cArquivo VIA "DBFCDXADS" // 20121106              

MsgInfo(cArquivo)

DBSELECTAREA("QUERYNFE")
DBCLOSEAREA()

RETURN