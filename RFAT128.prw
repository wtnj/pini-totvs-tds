#INCLUDE "rwmake.ch"                       
#include "topconn.ch"
#include "tbiconn.ch"

/*/     
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFAT128   ³Autor: Danilo C S Pala        ³ Data:   20100920 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: RELATORIO DE NOTA FISCAL DE ENTRADA DE DEVOLUCAO           ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Pini					                                     ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function RFAT128() 
Private cQuery := ""
Private cMsg := ""
Private cArqPath := ""
Private cStringArq := ""
Private mHora := TIME()

cperg := "RFAT128"
ValidPerg()
Pergunte(cPerg,.t.)   

cQuery := "select d1_serie, d1_doc, d1_tipo, SUBSTR(F_CONVERTER_DATA_SIGA(d1_emissao),1,10) as emissao, b1_cod, b1_desc, b1_tipo, d1_quant, d1_vunit, d1_total, d1_cf, a1_cod, a1_loja, a1_nome, a1_cgc, a1_est, d1_seriori, d1_nfori, d1_itemori"
cQuery += " from "+ RetSqlName("SD1") +" sd1, "+ RetSqlName("SB1") +" sb1, "+ RetSqlName("SA1") +" sa1 
cQuery += " where d1_filial='"+ xFilial("SD1") +"' and d1_tipo='"+ iif(MV_PAR05==1,"B","D") +"' and d1_emissao>='"+ dtos(MV_PAR01) +"' and d1_emissao<='"+ dtos(MV_PAR02) +"' and d1_cod>='"+ MV_PAR03 +"' and d1_cod<='"+ MV_PAR04 +"' and sd1.d_e_l_e_t_<>'*' 
cQuery += " and b1_filial='"+ xFilial("SB1") +"' and b1_cod=d1_cod and sb1.d_e_l_e_t_<>'*'
cQuery += " and a1_filial='"+ xFilial("SA1") +"' and a1_cod=d1_fornece and sa1.d_e_l_e_t_<>'*'"

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "NFENTR", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
DbSelectArea("NFENTR")
If !EOF()
	cArqPath  :=GetMv("MV_PATHTMP")
	cStringArq := ALLTRIM(cArqPath)+ SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2) +".DBF"
	COPY TO &cStringArq VIA "DBFCDXADS" // 20121106 
	cMsg := cStringArq
Else
	cMsg := "Arquivo em branco!"
EndIf                           

MsgInfo(cMsg)       
DbSelectArea("NFENTR")
dbclosearea()     
Return              

           




Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
aAdd(aRegs,{cPerg,"01","Data de","Data de","Data de","mv_ch1","D",8,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Data ate","Data ate","Data ate","mv_ch2","D",8,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Produto de","Produto de","Produto de","mv_ch3","C",15,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","","",""})
aAdd(aRegs,{cPerg,"04","Produto ate","Produto ate","Produto ate","mv_ch4","C",15,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","","",""})
aAdd(aRegs,{cPerg,"05","Tipo NF","Tipo NF","Tipo NF","mv_ch5","N",01,0,2,"C","","MV_PAR05","Beneficiamento","Beneficiamento","Beneficiamento","","","Devolucao","Devolucao","Devolucao","","","","","","","","","","","","","","","","","","","","",""})
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