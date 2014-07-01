#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPINISPCONTRIBบAutor  ณDANILO C S PALA     บ Data ณ  20130129บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PINI                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
USER FUNCTION PINISPCONTRIB()
SetPrvt("CPERG,_StringArq, cquery, MHORA, aRegs")
MHORA      := TIME()
_StringArq := "\SIGA\ARQTEMP\"+ SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2) +".DBF"

CPERG := 'PSPCONTRIB'
ValidPerg()
IF !PERGUNTE(CPERG)
	RETURN
ENDIF


DbSelectArea("SFT")
if RDDName() <> "TOPCONN"
		MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
		Return nil
endif

IF MV_PAR01==1
//RELATORIO
	//PSE
	cQuery := "select 'PSE' as empresa, ft_conta, ft_aliqpis, ft_aliqcof, sum(ft_valcont) valorcont, sum(ft_total) total  from sft020 FT "
	cQuery := cQuery + " where ft_filial='"+ xFilial("SFT") +"' AND ft_entrada>='"+ dtos(mv_par02) +"' AND ft_entrada<='"+ dtos(mv_par03) +"' and FT.d_e_l_e_t_<>'*'  "
	cQuery := cQuery + " and (FT_CSTPIS<>'  ' OR FT_BASEPIS>0) AND FT_TIPOMOV='S'"
	cQuery := cQuery + " group by ft_conta , ft_aliqpis, ft_aliqcof"
	cQuery := cQuery + " UNION ALL " 
	//BP
	cQuery := cQuery + "select 'BP' as empresa, ft_conta, ft_aliqpis, ft_aliqcof, sum(ft_valcont) valorcont, sum(ft_total) total  from sft030 FT "
	cQuery := cQuery + " where ft_filial='"+ xFilial("SFT") +"' AND ft_entrada>='"+ dtos(mv_par02) +"' AND ft_entrada<='"+ dtos(mv_par03) +"' and FT.d_e_l_e_t_<>'*'  "
	cQuery := cQuery + " and (FT_CSTPIS<>'  ' OR FT_BASEPIS>0) AND FT_TIPOMOV='S'"
	cQuery := cQuery + " group by ft_conta , ft_aliqpis, ft_aliqcof"
	cQuery := cQuery + " UNION ALL "
	//ED
	cQuery := cQuery + "select 'ED' as empresa, ft_conta, ft_aliqpis, ft_aliqcof, sum(ft_valcont) valorcont, sum(ft_total) total  from sft010 FT "
	cQuery := cQuery + " where ft_filial='"+ xFilial("SFT") +"' AND ft_entrada>='"+ dtos(mv_par02) +"' AND ft_entrada<='"+ dtos(mv_par03) +"' and FT.d_e_l_e_t_<>'*'  "
	cQuery := cQuery + " and (FT_CSTPIS<>'  ' OR FT_BASEPIS>0) AND FT_TIPOMOV='E'"
	cQuery := cQuery + " group by ft_conta , ft_aliqpis, ft_aliqcof"
	cQuery := cQuery + " order by empresa, ft_conta ,ft_aliqpis, ft_aliqcof"
	

	MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PSPCONTRIB", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
	TcSetField("PSPCONTRIB","FT_ALIQPIS","N",5,2)
	TcSetField("PSPCONTRIB","FT_ALIQCOF","N",5,2)
	TcSetField("PSPCONTRIB","VALORCONT","N",18,2)
	TcSetField("PSPCONTRIB","TOTAL","N",18,2)
	DBSelectArea("PSPCONTRIB")
	DBGotop()
	COPY TO &_StringArq VIA "DBFCDXADS" // 20121106 
	DBCLOSEAREA()
	cMsg := _StringArq 
ELSE
//PROCEDURE
	//Verifica se a Stored Procedure Teste existe no Servidor
	If TCSPExist("SP_SPEDCONTRIBUICOES")
		//SP_CONSIGNANTE(IN_CONSIG VARCHAR2, IN_DATADE VARCHAR2, IN_DATAATE VARCHAR2)
		aRet := TCSPExec("SP_SPEDCONTRIBUICOES", dtos(mv_par02), dtos(mv_par03))
		cMsg := "Fim de processamento" 
	EndIf
ENDIF
MSGINFO(cMsg)

RETURN

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
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Vari veis utilizadas para parametros      ณ
//ณ mv_par01             Vencto de            ณ
//ณ mv_par02             Vencto ate           ณ
//ณ mv_par03             Tipo				  ณ
//ณ mv_par04             Natureza             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aAdd(aRegs,{cPerg,"01","Tipo","Tipo","Tipo","mv_ch1","N",01,0,2,"C","","MV_PAR01","Relatorio","Relatorio","Relatorio","","","Updates","Updates","Updates","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Data de  ","Data de  ","Data de  ","mv_ch2","D",08,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Data ate ","Data ate ","Data ate ","mv_ch3","D",08,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

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