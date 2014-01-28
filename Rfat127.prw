#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"  //consulta SQL

/*/   
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ฑฑ
ฑฑณPrograma: PFAT150   ณAutor: Danilo C S PAla        ณ Data:  20100909  ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณDescriao: Gera arquivo DBF 			                                 ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณUso      : Pini				                                         ณ ฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู ฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function Rfat127()           
Private Programa  := "RFAT127"
Private MHORA     := TIME()
Private cArq      := SUBS(CUSUARIO,7,3) + SUBS(MHORA,1,2) + SUBS(MHORA,7,2)
Private cString   := SUBS(CUSUARIO,7,3) + SUBS(MHORA,1,2) + SUBS(MHORA,7,2)
Private lContinua := .T.
Private cArqPath  := GetMv("MV_PATHTMP")
Private _cString  := cArqPath+cString+".DBF"             
private cQuery := ""

cPerg     := "RFAT127"

ValidPerg()

If !Pergunte(cPerg)
	Return
Endif          

 //space(400)
//Private cGerado := cArqPath+"PUBTIT.DBF"
cQuery := "SELECT SZS.ZS_NUMAV AS NUMAV, SZS.ZS_NUMINS AS NUMINS, SZS.ZS_ITEM AS ITEM, SZS.ZS_CODPROD AS PRODUTO, SUBSTR(F_CONVERTER_DATA_SIGA(ZS_DTCIRC),1,10) AS DTCIRC, A1_COD AS CLIENTE, A1_LOJA AS LOJA, A1_NOME AS NOME, E1_PREFIXO AS PREFIXO, E1_NUM AS TITULO, E1_PARCELA AS PARCELA, E1_TIPO AS TIPO, ((ZS_VALOR/C5_VLRPED)*E1_VALOR) AS VALOR, SUBSTR(F_CONVERTER_DATA_SIGA(E1_VENCTO),1,10) AS VENCTO"
cQuery += " FROM "+ RetSqlName("SE1") +" SE1, "+ RetSqlName("SZS") +" SZS, "+ RetSqlName("SC5") +" SC5, "+ RetSqlName("SA1") +" SA1 "
cQuery += " WHERE E1_FILIAL='"+ xFilial("SE1") +"' AND SE1.D_E_L_E_T_<>'*' AND ZS_FILIAL='"+ xFilial("SZS") +"' AND ZS_NUMAV = E1_PEDIDO AND SZS.D_E_L_E_T_<>'*' AND ZS_SERIE=E1_PREFIXO AND SZS.ZS_NFISCAL=E1_NUM AND E1_TIPO='NF'"
cQuery += " AND C5_FILIAL='"+ xFilial("SC5") +"' AND ZS_NUMAV= C5_NUM AND SC5.D_E_L_E_T_<>'*'"
cQuery += " AND A1_FILIAL='"+ xFilial("SA1") +"' AND C5_CLIENTE= A1_COD AND C5_LOJACLI = A1_LOJA AND SA1.D_E_L_E_T_<>'*'"
cQuery += " AND ZS_CODPROD >='"+ MV_PAR01 +"' AND ZS_CODPROD <='"+ MV_PAR02 +"' AND ZS_DTCIRC >= '"+DTOS(MV_PAR03)+"' AND  ZS_DTCIRC <= '"+DTOS(MV_PAR04)+"'"

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PUBTIT", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados...")

DBSELECTAREA("PUBTIT")
DBGOTOP()
//COPIAR
COPY TO &_cString VIA "DBFCDXADS" // 20121106 
MSGINFO(_cString)

DBSELECTAREA("PUBTIT")
DbCloseArea()
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidPerg บAutor  ณDanilo Pala         บ Data ณ  10/06/08   บฑฑ
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
//
//mv_par01 - Produto de
//mv_par02 - Produto Ate
//mv_par03 - Circulacao De
//mv_par04 - Circulacao Ate
aAdd(aRegs,{cPerg,"01","Produto De?   ","Produto De?   ","Produto De?   ","mv_ch1","C",15,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","","",""})
aAdd(aRegs,{cPerg,"02","Produto Ate?  ","Produto Ate?  ","Produto Ate?  ","mv_ch2","C",15,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","","",""})
aAdd(aRegs,{cPerg,"03","Circulacao De?","Circulacao De?","Circulacao De?","mv_ch3","D",08,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Circulacao Ate?","Circulacao Ate?","Circulacao Ate?","mv_ch4","D",08,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

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