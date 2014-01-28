#INCLUDE "rwmake.ch"                       
#include "topconn.ch"
#include "tbiconn.ch"

/*/     
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFAT126   ³Autor: Danilo C S Pala        ³ Data:   20100716 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Razonete					                                 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Pini					                                     ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function RFAT126() 
setprvt("cArq, cArqPath, cArquivo")
setprvt("mhora, mdata, cQuery, nLastKey, nTotal")
Private cQuery := ""

cperg := "RFAT126"
ValidPerg()
Pergunte(cPerg,.t.)   


//DbSelectArea("ZZW")

cQuery := "select SUBSTR(f_converter_data_siga(ct2_data),1,10) as data, ct2_lote || ct2_sblote || ct2_doc || ct2_linha as LANCAMENTO, ct2_debito as debito,'' AS credito, trim(ct2_hist) as historico, round(CT2_VALOR,2) AS VL_DEBITO, 0 AS VL_CREDITO"
cQuery += " from "+ RetSqlName("CT2") +" where ct2_filial='"+ xFilial("CT2") +"' and ct2_data>='"+ DTOS(MV_PAR02) +"' and ct2_data<='"+ DTOS(MV_PAR03) +"' and d_e_l_e_t_<>'*' and (ct2_debito='"+ MV_PAR01 +"')"
cQuery += " UNION ALL"
cQuery += " select SUBSTR(f_converter_data_siga(ct2_data),1,10) as data, ct2_lote  || ct2_sblote || ct2_doc || ct2_linha as LANCAMENTO, '' AS ct2_debito, ct2_credit, trim(ct2_hist), 0 AS VL_DEBITO, round(CT2_VALOR,2) AS VL_CREDITO"
cQuery += " from "+ RetSqlName("CT2") +" where ct2_filial='"+ xFilial("CT2") +"' and ct2_data>='"+ DTOS(MV_PAR02) +"' and ct2_data<='"+ DTOS(MV_PAR03) +"' and d_e_l_e_t_<>'*' and (ct2_credit='"+ MV_PAR01 +"')"
cQuery += " UNION ALL"
cQuery += " select 'TOTAL' as data, '' as LANCAMENTO, '', '', '' AS HISTORICO, SUM(CASE WHEN(ct2_debito='"+ MV_PAR01 +"' ) THEN round(CT2_VALOR,2) ELSE 0 END) AS VL_DEBITO, SUM(CASE WHEN(ct2_credit='"+ MV_PAR01 +"') THEN round(CT2_VALOR,2) ELSE 0 END) AS VL_CREDITO"
cQuery += " from "+ RetSqlName("CT2") +" where ct2_filial='"+ xFilial("CT2") +"' and ct2_data>='"+ DTOS(MV_PAR02) +"' and ct2_data<='"+ DTOS(MV_PAR03) +"' and d_e_l_e_t_<>'*' and ((ct2_debito='"+ MV_PAR01 +"') OR (ct2_credit='"+ MV_PAR01 +"'))"
cQuery += " GROUP BY '','', '', '', ''"
MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "RAZONETE", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
TcSetField("RAZONETE","DATA","C",10)
TcSetField("RAZONETE","VL_DEBITO","N",14,2)
TcSetField("RAZONETE","VL_CREDITO","N",14,2)
//TcSetField("CONTRATO","DTINI" ,"D")
                   
DbSelectArea("RAZONETE")

MHORA     := TIME()
cArq      := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,4,2) +".DBF"
cArqPath   :=GetMv("MV_PATHTMP")                    
cArquivo := cArqPath+cArq
COPY TO &cArquivo VIA "DBFCDXADS" // 20121106              

MsgInfo(cArquivo)     
dbselectarea("RAZONETE")
dbclosearea()
Return              

           




Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
aAdd(aRegs,{cPerg,"01","Conta","Conta","Conta","mv_ch1","C",20,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","CT1","","","",""})
aAdd(aRegs,{cPerg,"02","Data de","Data de","Data de","mv_ch2","D",8,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Data ate","Data ate","Data ate","mv_ch3","D",8,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

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