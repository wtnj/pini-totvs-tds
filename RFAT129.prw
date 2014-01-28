#include "rwmake.ch"        
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFAT129   ³Autor: DANILO CESAR SESTARI PALA ³ Data: 20110930³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio AVPROGRAMADA INICIO CIRCULACAO                   ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Pini													     ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function RFAT129()

SetPrvt("CPERG,_StringArq, cquery, MHORA, aRegs")
MHORA      := TIME()
_StringArq := "\SIGA\ARQTEMP\"+ SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2) +".DBF"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros      ³
//³ mv_par01             //Circulacao de      ³
//³ mv_par02             //Circulacao ate     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg    := "RFAT129"  
ValidPerg()
If !Pergunte(cPerg)
   Return
Endif

If Select("RFAT129") <> 0
	DbSelectArea("RFAT129")
	DbCloseArea()
EndIf
      
bBloco:= { |lEnd| RptDetail()  }
MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )

RETURN


Static Function RptDetail() 
cQuery := "select szs.zs_numav, szs.zs_item, szs.zs_codrev, sb1.b1_titulo, szs.zs_codprod, b1_desc, SUBSTR(F_SB5_ARVORE(b1_cod,1),1,60) ARVORE1, SUBSTR(F_SB5_ARVORE(b1_cod,2),1,60) ARVORE2, SUBSTR(F_SB5_ARVORE(b1_cod,3),1,60) ARVORE3, szs.zs_edicao, szs.zs_codcli, a1_nome, c5_tptrans, szs.zs_vend, a3_nome, sum(szs.zs_valor) totalbruto, sum( case c5_tptrans when '04' then 0.8*szs.zs_valor when '12' then 0.8*szs.zs_valor else szs.zs_valor end) as totalliq"
cQuery := cQuery + " from "+ RetSqlName("SZS") +" szs, vw_primeiraavprog vw, "+ RetSqlName("SC5") +" sc5, "+ RetSqlName("SA1") +" sa1, "+ RetSqlName("SB1") +" sb1, "+ RetSqlName("SA3") +" sa3"
cQuery := cQuery + " where szs.zs_filial='"+ xFilial("SZS") +"' and   szs.zs_numav=vw.zs_numav and szs.d_e_l_e_t_<>'*' and vw.zs_dtcirc>='"+ DTOS(MV_PAR01) +"' and vw.zs_dtcirc<='"+ DTOS(MV_PAR02) +"'"
cQuery := cQuery + " and c5_filial='"+ xFilial("SC5") +"' and c5_num= szs.zs_numav and sc5.d_e_l_e_t_<>'*'"
cQuery := cQuery + " and a1_filial='"+ xFilial("SA1") +"' and a1_cod=c5_cliente and a1_loja=c5_lojacli and sa1.d_e_l_e_t_<>'*'"
cQuery := cQuery + " and a3_filial='"+ xFilial("SA3") +"' and a3_cod=c5_vend1 and sa3.d_e_l_e_t_<>'*'"
cQuery := cQuery + " and b1_filial='"+ xFilial("SB1") +"' and b1_cod=zs_codprod and sb1.d_e_l_e_t_<>'*'"
cQuery := cQuery + " group by szs.zs_numav, szs.zs_item, szs.zs_codrev, sb1.b1_titulo, szs.zs_codprod, b1_desc, SUBSTR(F_SB5_ARVORE(b1_cod,1),1,60), SUBSTR(F_SB5_ARVORE(b1_cod,2),1,60), SUBSTR(F_SB5_ARVORE(b1_cod,3),1,60), szs.zs_edicao, szs.zs_codcli, a1_nome, c5_tptrans, szs.zs_vend, a3_nome"

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "RFAT129", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
DBSelectArea("RFAT129")
DBGotop()
COPY TO &_StringArq VIA "DBFCDXADS" // 20121106 
DBCLOSEAREA()   
MsgInfo(_StringArq)
RETURN




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValidPerg ºAutor  ³Marcio Torresson    º Data ³  10/06/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria parametros no SX1 nao existir os parametros.           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros      ³
//³ mv_par01             //Circulacao de      ³
//³ mv_par02             //Circulacao ate     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAdd(aRegs,{cPerg,"01","Circulacao de  ","Circulacao de  ","Circulacao de  ","mv_ch1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Circulacao ate ","Circulacao ate ","Circulacao ate ","mv_ch2","D",08,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

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