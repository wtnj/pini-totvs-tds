#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"
/*   
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRFIN005	บAutor  ณDanilo C S Pala     บ Data ณ  20090831   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio de pagamentos									  บฑฑ
ฑฑบ          ณ  		           										  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PINI                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function RFIN005()
SetPrvt("CPERG,_StringArq, cquery, MHORA, aRegs")

MHORA      := TIME()
_StringArq := "\SIGA\ARQTEMP\"+ SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2) +".DBF"

cPerg := "RFIN05"
ValidPerg()
Pergunte(cPerg,.t.)   

//--TITULOS AVULSOS: pegar conta do fornecedor
cQuery := "select e2_prefixo as prefixo, e2_num as num, e2_parcela as parcela, e2_tipo as tipo, e2_naturez as natureza, (select ed_descric from "+ RetSqlName("SED") +" where ed_filial='"+xfilial("SED")+"' and ed_codigo=e2_naturez and d_e_l_e_t_<>'*') as descnat, e2_fornece as fornece, e2_loja as loja, a2_nome as nome, e2_vencto as vencto, e2_emissao as emissao, e2_baixa as baixa, e2_valor as valorTit, e2_valor as valor, e2_hist as hist, e2_descont as desconto, e2_multa as multa, e2_juros as juros, e2_correc  as correc, e2_valliq as valliq,  e2_vencori as vencori, e2_saldo as saldo, 1 as porc, '' as produto, '' as descprod, 0 as valoritem, 0 as valornf,  '' as contaD, '' as descD, '' as grupoD, '' as tipoD, a2_conta as contaC, ct1_desc01 as descC, ct1_grcont as grupoC, ct1_tpcont as tipoC, '' as CCD, '' as descCCD"
cQuery := cQuery + " from "+ RetSqlName("SE2") +" se2, "+ RetSqlName("SA2") +" sa2 left outer join "+ RetSqlName("CT1") +" ct1 on (ct1.ct1_filial='"+xfilial("CT1")+"' and ct1.ct1_conta=a2_conta and ct1.d_e_l_e_t_<>'*') "
IF MV_PAR03 ==1 //EMISSAO
	cQuery := cQuery + " where e2_filial='"+xfilial("SE2")+"' and e2_fornece>='"+ MV_PAR01 +"' and e2_fornece<='"+ MV_PAR02 +"' and e2_emissao>='"+ DTOS(MV_PAR04) +"' and e2_emissao<='"+ DTOS(MV_PAR05) +"' and e2_tipo<>'NF' and se2.d_e_l_e_t_<>'*' "
ELSE
	cQuery := cQuery + " where e2_filial='"+xfilial("SE2")+"' and e2_fornece>='"+ MV_PAR01 +"' and e2_fornece<='"+ MV_PAR02 +"' and e2_vencto>='"+ DTOS(MV_PAR04) +"' and e2_vencto<='"+ DTOS(MV_PAR05) +"' and e2_tipo<>'NF' and se2.d_e_l_e_t_<>'*' "
ENDIF

cQuery := cQuery + " and a2_filial='"+xfilial("SA2")+"' and a2_cod=e2_fornece and a2_loja=e2_loja and sa2.d_e_l_e_t_<>'*'"
cQuery := cQuery + " union all "
//--NFs
cQuery := cQuery + " select e2_prefixo as prefixo, e2_num as num, e2_parcela as parcela, e2_tipo as tipo, e2_naturez as natureza, (select ed_descric from "+ RetSqlName("SED") +" where ed_filial='"+xfilial("SED")+"' and ed_codigo=e2_naturez and d_e_l_e_t_<>'*') as descnat, e2_fornece as fornece, e2_loja as loja, a2_nome as nome, e2_vencto as vencto, e2_emissao as emissao, e2_baixa as baixa, e2_valor as valortit, (d1_total/f1_valmerc)*e2_valor as valor, e2_hist as hist, (d1_total/f1_valmerc)*e2_descont as desconto, (d1_total/f1_valmerc)*e2_multa as multa, (d1_total/f1_valmerc)*e2_juros as juros, (d1_total/f1_valmerc)*e2_correc as correc, (d1_total/f1_valmerc)*e2_valliq as valliq,  e2_vencori as vencori, (d1_total/f1_valmerc)*e2_saldo as saldo, (d1_total/f1_valmerc) as porc, d1_cod as produto, d1_descri as descprod, d1_total as valoritem, f1_valmerc as valornf, d1_conta contaD, ct1p.ct1_desc01 descD, ct1p.ct1_grcont grupoD, ct1p.ct1_tpcont tipoD, a2_conta contaC, ct1.ct1_desc01 descC, ct1.ct1_grcont grupoC, ct1.ct1_tpcont tipoC, d1_cc as CCD, (select ctt_desc01 from ctt010 where ctt_filial='"+xfilial("CTT")+"' and ctt_custo=d1_cc and d_e_l_e_t_<>'*') as descCCD"
cQuery := cQuery + " from "+ RetSqlName("SE2") +" se2, "+ RetSqlName("SF1") +" sf1 , "+ RetSqlName("SD1") +" sd1 left outer join "+ RetSqlName("CT1") +" ct1p on (ct1p.ct1_filial='"+xfilial("CT1")+"' and ct1p.ct1_conta=d1_conta and ct1p.d_e_l_e_t_<>'*'), "+ RetSqlName("SA2") +" sa2 left outer join "+ RetSqlName("CT1") +" ct1 on (ct1_filial='"+xfilial("CT1")+"' and ct1_conta=a2_conta and ct1.d_e_l_e_t_<>'*') "
IF MV_PAR03 ==1 //EMISSAO
	cQuery := cQuery + " where e2_filial='"+xfilial("SE2")+"' and e2_fornece>='"+ MV_PAR01 +"' and e2_fornece<='"+ MV_PAR02 +"' and e2_emissao>='"+ DTOS(MV_PAR04) +"' and e2_emissao<='"+ DTOS(MV_PAR05) +"' and e2_tipo='NF' and se2.d_e_l_e_t_<>'*' "
ELSE 
	cQuery := cQuery + " where e2_filial='"+xfilial("SE2")+"' and e2_fornece>='"+ MV_PAR01 +"' and e2_fornece<='"+ MV_PAR02 +"' and e2_vencto>='"+ DTOS(MV_PAR04) +"' and e2_vencto<='"+ DTOS(MV_PAR05) +"' and e2_tipo='NF' and se2.d_e_l_e_t_<>'*' "
ENDIF
cQuery := cQuery + " and f1_filial='"+xfilial("SF1")+"' and f1_prefixo=e2_prefixo and f1_doc=e2_num and f1_fornece=e2_fornece and f1_loja=e2_loja and f1_emissao=e2_emissao and f1_tipo='N' and sf1.d_e_l_e_t_<>'*' "
cQuery := cQuery + " and d1_filial='"+xfilial("SD1")+"' and d1_serie=f1_serie and d1_doc=f1_doc and d1_fornece=f1_fornece and d1_loja=f1_loja and d1_emissao=f1_emissao and sd1.d_e_l_e_t_<>'*' and d1_rateio<>'1'"
cQuery := cQuery + " and a2_filial='"+xfilial("SA2")+"' and a2_cod=e2_fornece and a2_loja=e2_loja and sa2.d_e_l_e_t_<>'*'"
cQuery := cQuery + " union all"
//--NFs rateadas
cQuery := cQuery + " select e2_prefixo as prefixo, e2_num as num, e2_parcela as parcela, e2_tipo as tipo, e2_naturez as natureza, (select ed_descric from "+ RetSqlName("SED") +" where ed_filial='"+xfilial("SED")+"' and ed_codigo=e2_naturez and d_e_l_e_t_<>'*') as descnat, e2_fornece as fornece, e2_loja as loja, a2_nome as nome, e2_vencto as vencto, e2_emissao as emissao, e2_baixa as baixa, e2_valor as valortit, (de_custo1/d1_total)*e2_valor as valor, e2_hist as hist, (de_custo1/d1_total)*e2_descont as desconto, (de_custo1/d1_total)*e2_multa as multa, (de_custo1/d1_total)*e2_juros as juros, (de_custo1/d1_total)*e2_correc as correc, (de_custo1/d1_total)*e2_valliq as valliq,  e2_vencori as vencori, (de_custo1/d1_total)*e2_saldo as saldo, (de_custo1/d1_total) as porc, d1_cod as produto, d1_descri as descprod, d1_total as valoritem, f1_valmerc as valornf, de_conta contaD, ct1r.ct1_desc01 descD, ct1r.ct1_grcont grupoD, ct1r.ct1_tpcont tipoD, a2_conta contaC, ct1.ct1_desc01 descC, ct1.ct1_grcont grupoC, ct1.ct1_tpcont tipoC, de_cc as CCD, (select ctt_desc01 from ctt010 where ctt_filial='"+xfilial("CTT")+"' and ctt_custo=de_cc and d_e_l_e_t_<>'*') as descCCD"
cQuery := cQuery + " from "+ RetSqlName("SE2") +" se2, "+ RetSqlName("SF1") +" sf1 , "+ RetSqlName("SD1") +" sd1, "+ RetSqlName("SA2") +" sa2 left outer join "+ RetSqlName("CT1") +" ct1 on (ct1_filial='"+xfilial("CT1")+"' and ct1_conta=a2_conta and ct1.d_e_l_e_t_<>'*'), "+ RetSqlName("SDE") +" sde left outer join "+ RetSqlName("CT1") +" ct1r on (ct1r.ct1_filial='"+xfilial("CT1")+"' and ct1r.ct1_conta=de_conta and ct1r.d_e_l_e_t_<>'*')"
IF MV_PAR03 ==1 //EMISSAO
	cQuery := cQuery + " where e2_filial='"+xfilial("SE2")+"' and e2_fornece>='"+ MV_PAR01 +"' and e2_fornece<='"+ MV_PAR02 +"' and e2_emissao>='"+ DTOS(MV_PAR04) +"' and e2_emissao<='"+ DTOS(MV_PAR04) +"' and e2_tipo='NF' and se2.d_e_l_e_t_<>'*' "
ELSE
	cQuery := cQuery + " where e2_filial='"+xfilial("SE2")+"' and e2_fornece>='"+ MV_PAR01 +"' and e2_fornece<='"+ MV_PAR02 +"' and e2_vencto>='"+ DTOS(MV_PAR04) +"' and e2_vencto<='"+ DTOS(MV_PAR04) +"' and e2_tipo='NF' and se2.d_e_l_e_t_<>'*' "
ENDIF
cQuery := cQuery + " and f1_filial='"+xfilial("SF1")+"' and f1_prefixo=e2_prefixo and f1_doc=e2_num and f1_fornece=e2_fornece and f1_loja=e2_loja and f1_emissao=e2_emissao and f1_tipo='N' and sf1.d_e_l_e_t_<>'*'"
cQuery := cQuery + " and d1_filial='"+xfilial("SD1")+"' and d1_serie=f1_serie and d1_doc=f1_doc and d1_fornece=f1_fornece and d1_loja=f1_loja and d1_emissao=f1_emissao and sd1.d_e_l_e_t_<>'*' and d1_rateio='1'"
cQuery := cQuery + " and de_filial='"+xfilial("SDE")+"' and de_serie=d1_serie and de_doc=d1_doc and de_fornece=d1_fornece and de_loja=d1_loja and de_itemnf=d1_item and sde.d_e_l_e_t_<>'*' "
cQuery := cQuery + " and a2_filial='"+xfilial("SA2")+"' and a2_cod=e2_fornece and a2_loja=e2_loja and sa2.d_e_l_e_t_<>'*'"


MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PAGTO", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")

TcSetField("PAGTO","VENCTO"   ,"D")
TcSetField("PAGTO","EMISSAO"  ,"D")
TcSetField("PAGTO","BAIXA"    ,"D")
TcSetField("PAGTO","VENCORI"  ,"D")


COPY TO &_StringArq VIA "DBFCDXADS" // 20121106 
DBCLOSEAREA()   
MsgInfo(_StringArq)
Return             


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidPerg บAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria parametros no SX1 nao existir os parametros.           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
//mv_par01 - Fornecedor de
//mv_par02 - Fornecedor ate
//mv_par03 - Filtrar por
//mv_par04 - Data de
//mv_par05 - Data ate


aAdd(aRegs,{cPerg,"01","Fornecedor de? ","Fornecedor de? ","Fornecedor de? ","mv_ch1","C",06,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","SA2","","","",""})
aAdd(aRegs,{cPerg,"02","Fornecedor ate?","Fornecedor ate?","Fornecedor ate?","mv_ch2","C",06,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","SA2","","","",""})
aAdd(aRegs,{cPerg,"03","Filtrar por?   ","Filtrar por?   ","Filtrar por?   ","mv_ch3","C",01,0,0,"C","","MV_PAR03","Emissao","Emissao","Emissao","","","Vencto","Vencto","Vencto","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Data de?       ","Data de?       ","Data de?       ","mv_ch4","D",08,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Data ate?      ","Data ate?      ","Data ate?      ","mv_ch5","D",08,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

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