#INCLUDE "RWMAKE.CH"
#include "topconn.ch"
#include "tbiconn.ch"

/*/
Alterado por Danilo C S Pala em 20120823: Tratar diferença de centavos (Andre)
Alterado por Danilo C S Pala em 20120911: Tratar diferença de centavos (Andre) item por item
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ LPGPERCC ³ Autor ³ Danilo C S Pala       ³ Data ³ 20120104 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ LANCAMENTO PADRAO DE RATEIO FUNCIONARIO VS ATIVIDADES      ³±±
±±³ POR CENTRO DE CUSTOS PERCENTUAL      								  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Pini                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function LPGPERCC(cTipo, cSeq) //cTipo=[C:conta,V:valor, G:Centro de Custo(grupo)]
Local mcta := ''   
Local nValor := 0
Local mCC := ''
Local cQuery := ""
Local cQueryV := ""
Local cValorAnt := ""
Local nSomaAnt := 0//20120911

DbSelectArea("ZY7")
DbSetOrder(1)
If DbSeek(xFilial("ZY7")+SRZ->RZ_MAT+transform(cSeq,"@E 9"))
	//20120823: daqui
	if cTipo=="V"
		cQuery := "select max(zy7_sequen) as ULTIMO from "+ RetSqlName("ZY7") + " where zy7_filial='"+ xfilial("ZY7") +"' and zy7_mat='"+ SRZ->RZ_MAT +"' and d_e_l_e_t_<>'*'"
		DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), "RATEIO", .F., .T.)
		if RATEIO->ULTIMO == cSeq //verificar se eh o ultimo da sequencia
			//sim:calcular o valor dos ultimos rateios e subtrair do valor do resumo da folha
			//cValorAnt := alltrim(TRANSFORM(SRZ->RZ_VAL, "@E 999,999,999.99"))
			//cValorAnt := StrTran(cValorAnt,".","")
			//cValorAnt := StrTran(cValorAnt,",",".")
			//cQueryV := "select NVL(round((sum(zy7_perc)* "+  cValorAnt +")/100,2),0) as SOMAANT from "+ RetSqlName("ZY7") + " where zy7_filial='"+ xfilial("ZY7") +"' and zy7_mat='"+ SRZ->RZ_MAT +"'  and zy7_sequen<"+ transform(cSeq,"@E 9") +" and d_e_l_e_t_<>'*'"
			//cQueryV := "select NVL(round((sum(zy7_perc)* "+  cValorAnt +")/100,2),0) as SOMAANT from "+ RetSqlName("ZY7") + " where zy7_filial='"+ xfilial("ZY7") +"' and zy7_mat='"+ SRZ->RZ_MAT +"'  and zy7_sequen<"+ transform(cSeq,"@E 9") +" and d_e_l_e_t_<>'*'"
			nSomaAnt := 0 //20120911
			cQueryV := "select zy7_perc from "+ RetSqlName("ZY7") + " where zy7_filial='"+ xfilial("ZY7") +"' and zy7_mat='"+ SRZ->RZ_MAT +"'  and zy7_sequen<"+ transform(cSeq,"@E 9") +" and d_e_l_e_t_<>'*'" //20120911
			DbUseArea(.T., "TOPCONN", TCGenQry(,,cQueryV), "VALORANT", .F., .T.)
			WHILE !Eof() //20120911
				nSomaAnt :=  nSomaAnt + ROUND((VALORANT->ZY7_PERC * SRZ->RZ_VAL)/100,2) //20120911
				DBSKIP() //20120911
			END //20120911
			nValor := ROUND(SRZ->RZ_VAL - nSomaAnt,2)  //ROUND(SRZ->RZ_VAL - VALORANT->SOMAANT,2) //20120911
			
			DBSelectArea("VALORANT")
			DBCloseArea()  
		else
			//nao: normal
			nValor := ROUND((ZY7->ZY7_PERC * SRZ->RZ_VAL)/100,2)
		endif
		DBSelectArea("RATEIO")
		DBCloseArea()  

	//20120823: ate aqui
	//nValor := ROUND((ZY7->ZY7_PERC * SRZ->RZ_VAL)/100,2) 20120823

	elseif cTipo=="C"
		//MCTA := U_LPF0101D
		DbSelectArea("ZZR")
		DbSetOrder(2)
		If DbSeek(xFilial("ZZR")+SRZ->RZ_PD+ZY7->ZY7_CC)
			MCTA := ZZR->ZZR_CONTAD
		Else
			MCTA := "CC INVALIDO"
		ENDIF

	else
		mCC := ZY7->ZY7_CC
	endif //20120823 fechar if
Else
	if cSeq = 1 
		if cTipo =="V"
			nValor := SRZ->RZ_VAL
		elseif cTipo =="C"
			MCTA := U_LPF0101D()	
		else
			mCC := SRZ->RZ_CC
		endif
	endif
ENDIF

RETURN iif(cTipo=="C",mCta, iif(cTipo=="V",nValor, mCC))