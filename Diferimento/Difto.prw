#INCLUDE "RWMAKE.CH"                 
/* Alterado por Danilo C S Pala em 20050201
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDIFTO     บAutor  ณMicrosiga           บ Data ณ  02/02/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Contabiliza diferimento de publicidade e assinaturas       บฑฑ
ฑฑบ          ณRicardo solicitou somente assinaturas, edinic <>9999 20050202บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Difto()

CPERG := "CTBDIF"

ValidPerg()

Pergunte(CPERG,.f.)
@ 96,42 TO 323,505 DIALOG oDlg TITLE "Contabilizacao do Diferimento"
@ 8,10 TO 84,222
@ 91,139 BMPBUTTON TYPE 5 ACTION Pergunte(CPERG)
@ 91,168 BMPBUTTON TYPE 1 ACTION OkProc()
@ 91,196 BMPBUTTON TYPE 2 ACTION Close(oDlg)
@ 23,14 SAY "Este programa ira contabilizar o diferimento de publicidade e assinaturas."
@ 33,14 SAY "Ricardo solicitou para considerar apenas assinaturas, 20050202"
@ 43,14 SAY ""
@ 53,14 SAY ""
ACTIVATE DIALOG oDlg
Return nil

Static Function OkProc()

Close(oDlg)

Processa( {||PegaDados() } )

/*IF MV_PAR03 == 1
	Processa({||Contabiliza()})
Endif */ //20050203

report()
dbselectarea("trb")
dbclosearea("trb")
dbselectarea("rev")
dbclosearea("rev")

Return

Static Function Pegadados()
aCampo := {}
Aadd(aCampo,{"REVISTA", "C",04,0})
Aadd(aCampo,{"EDICAO" , "C",04,0})
Aadd(aCampo,{"VALOR"  , "N",12,2})
cArqTRB := CriaTrab(aCampo, .T.)
dbUseArea( .T.,, cArqTRB, "REV", Nil, .F. )
Index On REVISTA+edicao To &carqtrb

aCampos := {}
Aadd(aCampos,{"PEDIDO" ,"C",06,0})
Aadd(aCampos,{"VALOR"  ,"N",11,2})
Aadd(aCampos,{"VLADI"  ,"N",11,2})
Aadd(aCampos,{"VLDIF"  ,"N",11,2})
Aadd(aCampos,{"TIPO"   ,"C",01,0})
Aadd(aCampos,{"ITEM"   ,"C",02,0})
Aadd(aCampos,{"ULTDIF" ,"D",08,0})
Aadd(aCampos,{"EMISSAO","D",08,0})
Aadd(aCampos,{"PRODUTO","C",15,0})
Aadd(aCampos,{"CLIENTE","C",08,0})

cArqTRaB := CriaTrab(aCampos, .T.)
DbUseArea( .T.,, cArqTRaB, "TRB", Nil, .F. )
Index On dtos(emissao)+pedido+produto+item to &carqtrab

aCampos1 := {}
Aadd(aCampos1,{"VALOR"  ,"N",11,2})
Aadd(aCampos1,{"TIPO"   ,"C",01,0})
Aadd(aCampos1,{"REVISTA","C",04,0})
cArqTRaB1 := CriaTrab(aCampos1, .T.)
DbUseArea( .T.,, cArqTRaB1, "TRB1", Nil, .F. )
Index On TIPO+REVISTA to &carqtrab1

 DBSELECTAREA("SZJ") 
DBSETORDER(2)
DBSEEK(XFILIAL("SZJ")+DTOS(MV_PAR01),.T.)
PROCREGUA(RECCOUNT())
//Monta um array com as revistas e edicoes do intervalo de datas
cRev := "('"
WHILE !EOF() .AND. SZJ->ZJ_DTCIRC <= Mv_par02
	INCPROC("Gerando Arquivo de Trabalho - Dia: "+dtoc(szj->zj_dtcirc))
	dbselectarea("rev")
	If !dbseek(szj->zj_codrev+strzero(szj->zj_edicao,5))
		Reclock("REV",.T.)
		REV->REVISTA := SZJ->ZJ_CODREV
		REV->EDICAO  := STRZERO(SZJ->ZJ_EDICAO,4)
		MSUNLOCK("REV")
	ENDIF
	cRev += SZJ->ZJ_CODREV + ALLTRIM(STR(SZJ->ZJ_EDICAO))+"','"
	DBSELECTAREA("SZJ")
	DBSKIP()
END
cRev := Substr(cRev,1,Len(cRev)-2) + ")"

If Len(cRev) == 2
	MsgAlert("Nao ha edicoes a diferir dentro do periodo especificado","Atencao")
	Return
EndIf

/* 20050202
cQueryPub := "SELECT SZS.ZS_NUMAV, SZS.ZS_ULTDIF, SZS.ZS_CODREV, SZS.ZS_VALOR, SZS.ZS_EDICAO, SC5.C5_EMISSAO, "
cQueryPub += " SC5.C5_CLIENTE, SC5.C5_LOJACLI"
cQueryPub += " FROM " + RetSqlName("SZS") + " SZS, " + RetSqlName("SC5") + " SC5 "
cQueryPub += " WHERE SZS.ZS_FILIAL = '" + xFilial("SZS") + "'"
cQueryPub += " AND SZS.ZS_DTCIRC BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "'"
cQueryPub += " AND SZS.D_E_L_E_T_ <> '*'"
cQueryPub += " AND SC5.C5_FILIAL = '" + xFilial("SC5") + "'"
cQueryPub += " AND SC5.C5_NUM = SZS.ZS_NUMAV"
cQueryPub += " AND SC5.D_E_L_E_T_ <> '*'"
cQueryPub += " ORDER BY SC5.C5_EMISSAO"

If Select("PUB") <> 0
	DbSelectArea("PUB")
	DbCloseArea()
EndIf

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQueryPub), "PUB", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")

TcSetField("PUB","C5_EMISSAO","D")
TcSetField("PUB","ZS_ULTDIF","D")
DbSelectArea("PUB")
DbGoTop()
ProcRegua(RecCount())
While !Eof()
	INCPROC("Gerando Arquivo de Trabalho - Dia: " + DTOC(PUB->C5_EMISSAO))
	DBSELECTAREA("REV")
	IF DBSEEK(PUB->ZS_CODREV+STRZERO(PUB->ZS_EDICAO,4))		
		RECLOCK("REV",.F.)
		REV->VALOR :=  REV->VALOR+pub->ZS_VALOR
		MSUNLOCK("REV")
		DBSELECTAREA("TRB")
		RECLOCK("TRB",.T.)
		TRB->PEDIDO  := PUB->ZS_NUMAV
		TRB->TIPO    := "P"
		TRB->ULTDIF  := PUB->ZS_ULTDIF
		TRB->EMISSAO := PUB->C5_EMISSAO
		TRB->PRODUTO := PUB->ZS_CODREV
		TRB->VALOR   := PUB->ZS_VALOR
		TRB->CLIENTE := PUB->C5_CLIENTE+PUB->C5_LOJACLI
		MSUNLOCK()
		if mv_par03 == 1
			if trb->ULTDIF < mv_par01
				dbselectarea("trb1")
				if !dbseek(trb->tipo+subs(trb->produto,1,4))
					reclock("trb1",.t.)
					trb1->tipo    := trb->tipo
					trb1->revista := subs(trb->produto,1,4)
					msunlock("trb")
				endif
				reclock("trb1",.f.)
				trb1->valor := trb1->valor+trb->valor
				msunlock()
				dbselectarea("szs")
				dbsetorder(1)
				dbseek(xfilial()+trb->pedido)
				reclock("szs",.f.)
				SZS->ZS_ULTDIF := mv_par02
				msunlock("szs")
	    	endif
		endif
	ENDIF
	DbSelectArea("PUB")
	DbSkip()
End

DbSelectArea("PUB")
DbCloseArea()
*/ //ateh aki 20050202

cQueryAss := "SELECT SC6.C6_NUM, SC6.C6_ITEM, SC6.C6_PRODUTO, SC6.C6_VLDIFIT, SC6.C6_EDINIC, SC6.C6_EDFIN, SC6.C6_ULTDIF, SC6.C6_EDSUSP, "
cQueryAss += " SC6.C6_TES, SC6.C6_VLADIFR, SC6.C6_VLDIFRD, SC5.C5_EMISSAO, SC5.C5_CLIENTE, SC5.C5_LOJACLI"
cQueryAss += " FROM " + RetSqlName("SC6") + " SC6, " + RetSqlName("SC5") + " SC5 "
cQueryAss += " WHERE SC6.C6_FILIAL = '" + xFilial("SC6") + "'"
cQueryAss += " AND SUBSTR(SC6.C6_PRODUTO,1,2) IN ('01','10','11')"
cQueryAss += " AND SUBSTR(SC6.C6_PRODUTO,5,3) <> '001' "
If SM0->M0_CODIGO $ "01/03"
	cQueryAss += " AND SC6.C6_CF NOT IN('599','699','799')"
	cQueryAss += " AND SC6.C6_EDINIC <>'9999' AND SC6.C6_TES <>'700' AND SC6.C6_TES <>'701' " //20050202
Else
	cQueryAss += " AND SC6.C6_CF NOT IN('599','699','799','593')"
EndIf
cQueryAss += " AND SC6.D_E_L_E_T_ <> '*'"
cQueryAss += " AND SC5.C5_FILIAL = '" + xFilial("SC5") + "'"
cQueryAss += " AND SC5.C5_NUM = SC6.C6_NUM"
cQueryAss += " AND SC5.C5_EMISSAO>='20000101'" //20050203
//cQueryAss += " AND SC5.C5_EMISSAO>='"+ DTOS(MV_PAR01) +"' AND SC5.C5_EMISSAO<='"+ DTOS(MV_PAR02) +"'" // teste 20050204
If SM0->M0_CODIGO == "01"
	cQueryAss += " AND SC5.C5_DIVVEN = 'MERC'"
EndIf
cQueryAss += " AND SC5.D_E_L_E_T_ <> '*'"
cQueryAss += " ORDER BY SC5.C5_EMISSAO"

If Select("ASS") <> 0
	DbSelectArea("ASS")
	DbCloseArea()
EndIf

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQueryAss), "ASS", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")

TcSetField("ASS","C5_EMISSAO","D")
TcSetField("ASS","C6_ULTDIF","D")
DbSelectArea("ASS")
DbGoTop()
ProcRegua(RecCount())
While ! Eof()
	INCPROC("Gerando arquivo de Trabalho - Dia: " + DTOC(ASS->C5_EMISSAO))
	DbSelectArea("SF4")
	DbSetOrder(1)
	DbSeek(xFilial("SF4")+ASS->C6_TES)
	If SF4->F4_DUPLIC <> "S"
		DbSelectArea("ASS")
		DbSkip()
		Loop
	EndIf
	DBSELECTAREA("REV")
	IF DBSEEK(SUBS(ASS->C6_PRODUTO,1,4))
		While !Eof() .and. Substr(ASS->C6_PRODUTO,1,4) == REV->REVISTA
			IF ASS->C6_EDINIC <= VAL(REV->EDICAO) .AND. ASS->C6_EDSUSP >= VAL(REV->EDICAO)  //REV->EDICAO eh a ultima edicao
				DbSelectArea("TRB")
				RECLOCK("TRB",.T.)
				TRB->PEDIDO := ASS->C6_NUM
				IF SUBS(ASS->C6_PRODUTO,1,2)$"10/11"
					TRB->TIPO   := "R"
				ELSE                 
					TRB->TIPO   := "A"
				ENDIF
				TRB->ITEM   := ASS->C6_ITEM
				TRB->EMISSAO:= ASS->C5_EMISSAO
				TRB->ULTDIF := ASS->C6_ULTDIF
				TRB->PRODUTO:= ASS->C6_PRODUTO
				TRB->VALOR  := ASS->C6_VLDIFIT
				TRB->CLIENTE:= ASS->C5_CLIENTE+ASS->C5_LOJACLI
				TRB->VLADI  := ASS->C6_VLADIFR //Valor a diferir				TRB->VLDIF  := ASS->C6_VLDIFRD //Valor diferido
				MSUNLOCK()
				if mv_par03 == 1
					if trb->ULTDIF < mv_par01
						dbselectarea("trb1")
						if !dbseek(trb->tipo+subs(trb->produto,1,4))
							reclock("trb1",.t.)
							trb1->tipo    := trb->tipo
							trb1->revista := subs(trb->produto,1,4)
							msunlock("trb1")     //analisar!!! 20050203
						endif
						reclock("trb1",.f.)
						trb1->valor := trb1->valor+trb->valor
						msunlock()
						dbselectarea("sC6")
						dbsetorder(1)
						dbseek(xfilial("SC6")+trb->pedido+TRB->ITEM+TRB->PRODUTO)
						reclock("SC6",.f.)
/* 						if SC6->C6_NUM = '274642' .or. SC6->C6_NUM = '274641'
 							MsgAlert("Achou " + SC6->C6_NUM)
 						endif */
 
						SC6->C6_ULTDIF := mv_par02
						SC6->C6_VLADIFR := SC6->C6_VLADIFR - TRB->VALOR
						SC6->C6_VLDIFRD := SC6->C6_VLDIFRD + TRB->VALOR
						msunlock("SC6")
                	endif
				endif
				DBSELECTAREA("REV")
				RECLOCK("REV",.F.)
				REV->VALOR := REV->VALOR+ASS->C6_VLDIFIT
				MSUNLOCK("REV")
			ENDIF
			DbSelectArea("REV")
			DbSkip()
		End
	ENDIF
	DBSELECTAREA("ASS")
	DBSKIP()
END

DbSelectArea("ASS")
DbCloseArea()

RETURN

*****************************
static function Contabiliza()
AROTINA := {}
aRotina      := {{ "","" , 0 , 1},;
{ "","" , 0 , 2 },;
{ "","" , 0 , 3 },;
{ "","" , 0 , 4 } }
_nTotal      := 0
lHeadProva   := .F.
cLote := TABELA("09","PEDI",.T.)
_cArquivo :=""
_dDtBase     := dDataBase
DBSELECTAREA("TRB1")
DBGOTOP()
PROCREGUA(RECCOUNT())
DO WHILE !EOF()
	INCPROC("Gerando  lancamentos - Revista: "+trb1->revista)
	IF TRB1->TIPO == "P"
		CPadrao := "998"
	elseIF TRB1->TIPO == "A"
		CPadrao     := "999"
	ELSE
		CPADRAO := "994"
	endif
	lPadrao     := VerPadrao(cPadrao)
	If lPadrao
		If !lHeadProva
			dDataBase  := MV_PAR02
			nHdlPrv    := HeadProva(cLote,"DIFTO",Substr(cUsuario,7,6),@_cArquivo)
			lHeadProva := .T.
		End
		_nTotal := _nTotal + DetProva(nHdlPrv,cPadrao,"DIFTO",cLote) 
	Endif
	DbSelectArea("TRB1")
	DbSkip()
Enddo
If lHeadProva
	RodaProva(nHdlPrv,_nTotal)
	lDigita   := .T.
	IF MV_PAR04 == 1
		lAglutina := .T.
	ELSE
		lAglutina := .F.
	ENDIF
	IF MV_PAR05 == 1
		lDigita := .T.
	ELSE
		lDigita := .F.
	ENDIF
	cA100Incl(_cArquivo,nHdlPrv,3,cLote,lDigita,lAglutina)
Endif
If nHdlPrv != NIL
	FClose(nHdlPrv)
Endif

dDataBase := _dDtBase

Return

************************
Static Function Report()
cString:="SC5"
cDesc1:= OemToAnsi("Este programa tem como objetivo, listar o Diferimento dos")
cDesc2:= OemToAnsi("pedidos de publicidade,assinaturas e relatorios contabilizados no mes.")
cDesc3:= ""
tamanho:="M"
aReturn := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog:= "DIFTO"
aLinha  := { }
nLastKey := 0
lEnd := .f.
titulo      :="Diferimento de Publicidade, Assinaturas e Relatorios"
cabec1      :="Pedido Produto         Cliente   Nome do Cliente                     Emissao  Tipo   Vlr a Diferir   Diferimto Mes  Saldo a Diferir"
cabec2      :=""
//             xxxxxx XXXXXXXXXXXXXXX 222222/22 xxxxxcccccdddddssssseeeeerrrrrttttt 99/99/99 XXXX  999,999,999.99  999,999,999.99   999,999,999.99
//             0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//                       1         2         3         4         5         6         7         8         9         10        11        12        13
cCancel := "***** CANCELADO PELO OPERADOR *****"
nlin := 80
m_pag := 1
wnrel:="DIFERTO"
SetPrint(cString,wnrel,,titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)
If nLastKey == 27
	Set Filter To
	Return
Endif
SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter To
	Return
Endif
RptStatus({|| RptDetail() })
Return

***************************
Static Function RptDetail()
vtotal    := 0
numped    := 0
totpubl   := 0
pedpubl   := 0
totass    := 0
pedass    := 0
totrel    := 0
pedrel    := 0
vladifass := 0
vladifrel := 0

DbSelectArea("TRB")
DBGOTOP()
SETREGUA(RECCOUNT())
WHILE !EOF()
	IncRegua("Imprimindo - Dia: "+TRANSFORM(trb->emissao,"@E 99/99/99"))
	if nlin >58
		nLin   := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
		nLin   := nLin + 2
	endif
	dbselectarea("sa1")
	dbsetorder(1)
	dbseek(xfilial("SA1")+TRB->CLIENTE)
	@ nlin,0 PSAY trb->pedido
	@ nlin,7 PSAY trb->PRODUTO
	@ nLin,23 PSAY Substr(TRB->CLIENTE,1,6) +"/"+Substr(TRB->CLIENTE,7,2)
	@ nlin,33 psay subs(sa1->a1_nome,1,35)
	@ nlin,69 psay trb->emissao
	if trb->tipo == "P"
		@ nlin,78  psay "PUBL."
		@ nLin,84  psay trb->valor picture "@E 999,999,999.99"
		@ nLin,100 psay trb->valor picture "@E 999,999,999.99"
		@ nLin,117 psay 0 picture "@E 999,999,999.99"
		TOTPUBL += TRB->VALOR
		PEDPUBL++
	ELSE
		if trb->tipo == "A"
			@ NLIN,78 PSAY "ASS."
			TOTASS += TRB->VALOR
			PEDASS++
			vladifass += IIF(DTOS(TRB->ULTDIF) > DTOS(MV_PAR01),TRB->VLADI+TRB->VALOR,TRB->VLADI)
		else
			@ nlin,78 PSAY "REL."
			TOTREL += TRB->VALOR
			PEDREL++
			vladifREL += IIF(DTOS(TRB->ULTDIF) > DTOS(MV_PAR01),TRB->VLADI+TRB->VALOR,TRB->VLADI)
		ENDIF
		@ nLin,84  psay IIF(DTOS(TRB->ULTDIF) > DTOS(MV_PAR01),TRB->VLADI+TRB->VALOR,TRB->VLADI) picture "@E 999,999,999.99"
		@ nLin,100 psay TRB->VALOR picture "@E 999,999,999.99"
		@ nLin,117 psay IIF(DTOS(TRB->ULTDIF) > DTOS(MV_PAR01),TRB->VLADI,TRB->VLADI-TRB->VALOR) picture "@E 999,999,999.99"
	ENDIF
	vtotal += trb->valor
	numped++
	nlin++
	dbselectarea("trb")
	dbskip()
end
nlin++
IF PEDPUBL <> 0
	@ nlin,00  psay "Numero de Pedidos de Publicidade: "
	@ nlin,35  psay pedpubl picture "@e 999,999"
	@ nLin,84  psay totpubl picture "@E 999,999,999.99"
	@ nLin,100 psay totpubl picture "@E 999,999,999.99"
	nlin++
ENDIF          
IF PEDASS <> 0
	@ nlin,00 psay "Numero de Pedidos de Assinaturas: "
	@ nlin,35 psay pedass picture "@e 999,999"
	@ nLin,84 psay vladifass+totass picture "@e 999,999,999.99"
	@ nLin,100 psay totass picture "@E 999,999,999.99"
	@ nLin,117 psay vladifass picture "@E 999,999,999.99"
	NLIN++
ENDIF
IF PEDREL <> 0
	@ nlin,00 psay "Numero de Pedidos de Relatorios: "
	@ nlin,35 psay pedrel picture "@e 999,999"
	@ nLin,84 psay vladifrel+totrel picture "@e 999,999,999.99"
	@ nLin,100 psay totrel picture "@E 999,999,999.99"
	@ nLin,117 psay vladifrel picture "@E 999,999,999.99"
	NLIN++
ENDIF
nlin := nlin +1
if nlin >58
	nLin   := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
	nLin   := nLin + 2
endif
DBSELECTAREA("REV")
DBGOTOP()
SETREGUA(RECCOUNT())
DO WHILE !EOF()
	incregua()
	IF REV->VALOR == 0
		DBSKIP()
		LOOP
	ENDIF
	if nlin >58
		nLin   := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
		nLin   := nLin + 2
	endif
	@ nlin,00 psay "Revista: "+rev->revista
	@ nlin,20 psay "Edicao: "+rev->edicao
	@ nLin,100 psay rev->valor picture "@E 999,999,999.99"
	nlin := nlin +1
	dbskip()
enddo
IF PEDPUBL <> 0
	@ nlin,00  psay "Numero de Pedidos de Publicidade: "
	@ nlin,35  psay pedpubl picture "@e 999,999"
	@ nLin,84  psay totpubl picture "@E 999,999,999.99"
	@ nLin,100 psay totpubl picture "@E 999,999,999.99"
	nlin := nlin +1
ENDIF          
IF PEDASS <> 0
	@ nlin,00 psay "Numero de Pedidos de Assinaturas: "
	@ nlin,35 psay pedass picture "@e 999,999"
	@ nLin,84 psay vladifass+totass picture "@e 999,999,999.99"
	@ nLin,100 psay totass picture "@E 999,999,999.99"
	@ nLin,117 psay vladifass picture "@E 999,999,999.99"
	NLIN := NLIN +1
ENDIF
IF PEDREL <> 0
	@ nlin,00 psay "Numero de Pedidos de Relatorios: "
	@ nlin,35 psay pedrel picture "@e 999,999"
	@ nLin,84 psay vladifrel+totrel picture "@e 999,999,999.99"
	@ nLin,100 psay totrel picture "@E 999,999,999.99"
	@ nLin,117 psay vladifrel picture "@E 999,999,999.99"
	NLIN := NLIN +1
ENDIF

Roda(0,"",tamanho)
Set Filter To
If aReturn[5] == 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif
MS_FLUSH()
Return

***************************
Static Function ValidPerg()

_cSavAlias := Alias()

dbSelectArea("SX1")
dbSetOrder(1)

cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs :={}

AADD(aRegs,{cPerg,"01","Data de            ?", "" , "" ,"mv_ch1","D",8 ,0,0,"G","","mv_par01","", "" , "" , "","","", "" , "" , "","", "" , "" , "","", "" , "" , "","", "" , "" , "","","","","", ""})
AADD(aRegs,{cPerg,"02","Data ate           ?", "" , "" ,"mv_ch2","D",8 ,0,0,"G","","mv_par02","", "" , "" , "","","", "" , "" , "","", "" , "" , "","", "" , "" , "","", "" , "" , "","","","","", ""})
AADD(aRegs,{cPerg,"03","Gera Lancamentos   ?", "" , "" ,"mv_ch3","N",1 ,0,0,"C","","mv_par03","Sim", "" , "" , "","","Nao", "" , "" , "","", "" , "" , "","", "" , "" , "","", "" , "" , "","","","","", ""})
AADD(aRegs,{cPerg,"04","Aglutina Lancamtos ?", "" , "" ,"mv_ch4","N",1 ,0,0,"C","","mv_par04","Sim", "" , "" , "","","Nao", "" , "" , "","", "" , "" , "","", "" , "" , "","", "" , "" , "","","","","", ""})
AADD(aRegs,{cPerg,"05","Mostra Lancamentos ?", "" , "" ,"mv_ch5","N",1 ,0,0,"C","","mv_par05","Sim", "" , "" , "","","Nao", "" , "" , "","", "" , "" , "","", "" , "" , "","", "" , "" , "","","","","", ""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			FieldPut(j,aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next

dbSelectArea(_cSavAlias)

RETURN