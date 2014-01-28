#include "rwmake.ch"
#include "ap5mail.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*   alterado em 20030828 por danilo
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PSSiga    ºAutor  ³Danilo C S Pala     º Data ³  20030812   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Pedido de Software Siga, programa para appendar os clientesº±±
±±º          ³  cadastrados pelo PSWeb									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/ 

User Function PSSiga
Private _cTitulo  := "Integracao do PSWeb/PSIntranet com PSSiga:Appendar"
Private ctexto := "Appendar"
Private cTexto1 := "Visualizar"
Private cTexto2 := "Fechar"
setprvt("_aCampos, _cNome, caIndex, caChave, caFiltro, cQuery, contPed, _cMsgINFO, ContSzk")
Private Memp := SM0->M0_CODIGO
Private contSZO := 0
Private contSZN := 0

if Memp <> "03"
	MsgAlert("Este processamente deve ser executado na BP S/A")
	return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


@ 010,001 TO 220,410 DIALOG oDlg TITLE _cTitulo
@ 010,010 SAY "**********CLIENTES**********"
@ 020,010 BUTTON cTexto SIZE 40,11 ACTION   Processa({||Appendar()})
@ 020,060 BUTTON cTexto1 SIZE 40,11 ACTION   Processa({||Visualizar()})
@ 040,010 SAY "**********PEDIDOS e ITENS DE PEDIDOS**********"
@ 050,010 BUTTON "Appendar" SIZE 40,11 ACTION   Processa({||AppPedido()})
@ 050,060 BUTTON "Vis. Pedidos" SIZE 40,11 ACTION   Processa({||VisPedido()})
@ 050,110 BUTTON "Vis. Itens" SIZE 40,11 ACTION   Processa({||VisItens()})
@ 070,060 SAY "**********SZN e SZO**********"
@ 070,010 BUTTON "Appendar SZN e SZO" SIZE 50,11 ACTION   Processa({||AppSZN()})
@ 090,120 BUTTON cTexto2 SIZE 40,15 Action ( Close(oDlg) )
Activate Dialog oDlg CENTERED

Return

//**********************************************************************************************
//   DANILO_SA1
//**********************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao para verificar se eh cliente³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function Visualizar()
setprvt("aCampos")
aCampos := {}
AADD(aCampos,{"A1_COD","CODIGO"})
AADD(aCampos,{"A1_NOME","NOME"})
AADD(aCampos,{"a1_nreduz","FANTASIA"})
AADD(aCampos,{"a1_end","ENDERECO"})
AADD(aCampos,{"a1_cep","CEP"})
AADD(aCampos,{"a1_bairro","BAIRRO"})
AADD(aCampos,{"a1_mun","MUNICIPIO"})
AADD(aCampos,{"a1_est","ESTADO"})
AADD(aCampos,{"a1_cgc","CNPJ/CPF"})
AADD(aCampos,{"a1_inscr","INSCR"})
AADD(aCampos,{"a1_inscrm","INSCRM"})
AADD(aCampos,{"a1_tel","TEL"})
AADD(aCampos,{"PROCESSADO","PROCESSADO?"})
AADD(aCampos,{"dataproc","dataproc"})

DbselectArea("SA1")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif
DbClosearea("SA1")

cQuery := "select a.*, to_char(dtprocessado) as dataproc from DANILO_SA1 a where processado ='N'"
TCQUERY cQuery NEW ALIAS "QUERY"

@ 200,001 TO 400,600 DIALOG oDlg1 TITLE "query"
@ 6,5 TO 100,250 BROWSE "Query" FIELDS aCampos
@ 070,260 BUTTON "_Ok" SIZE 40,15 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED

DBCloseArea("Query")
RETURN



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao Appendar³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function Appendar()
Private contador := 0
Private cUpdate := ""
DbselectArea("SA1")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif

cQuery := "select * from DANILO_SA1 where processado ='N'"
TCQUERY cQuery NEW ALIAS "QUERY"

DbSelectArea("Query")
DBGoTop()
Procregua(Reccount())
While ! Eof()
	DBSelectArea("SA1")
	RECLOCK("SA1",.T.)  //INSERIR .T.
	SA1->A1_loja := QUERY->A1_loja
	SA1->a1_cod := QUERY->a1_cod
	SA1->a1_nome := QUERY->a1_nome
	SA1->a1_nreduz := QUERY->a1_nreduz
	SA1->a1_end := QUERY->a1_end
	SA1->a1_cep := QUERY->a1_cep
	SA1->a1_bairro := QUERY->a1_bairro
	SA1->a1_mun := QUERY->a1_mun
	SA1->a1_est := QUERY->a1_est
	SA1->a1_cgc := QUERY->a1_cgc
	SA1->a1_inscr := QUERY->a1_inscr
	SA1->a1_inscrm := QUERY->a1_inscrM
	SA1->a1_tel := QUERY->a1_tel
	SA1->a1_telex := QUERY->a1_telex
	SA1->a1_fax := QUERY->a1_fax
	SA1->a1_email := QUERY->a1_email
	SA1->a1_rg := QUERY->a1_rg
	SA1->a1_dtnasc := CtoD(ConverterData(QUERY->a1_dtnasc))
	SA1->a1_hpage := QUERY->a1_hpage
	SA1->a1_endcob := QUERY->a1_endcob
	SA1->a1_bairroc := QUERY->a1_bairroc
	SA1->a1_munc := QUERY->a1_munc
	SA1->a1_cepc  := QUERY->a1_cepc
	SA1->a1_estc  :=QUERY->a1_estc
	SA1->a1_tipo  := QUERY->a1_tipo
	SA1->a1_tpcli  := QUERY->a1_tpcli
	SA1->a1_porte  := QUERY->a1_porte
	SA1->a1_flagid  := QUERY->a1_flagid
	SA1->a1_naturez  := QUERY->a1_naturez
	SA1->a1_ativida  := QUERY->a1_ativida 
	SA1->A1_DTULAT  := DDATABASE //20030819
	MSUNLOCK("SA1")
	DbSelectArea("Query")
	DBSkip()
	IncProc()
	contador++
end
DBCloseArea("SA1")
DBCloseArea("Query")

cUpdate := "update DANILO_SA1 set processado = 'S', dtprocessado = sysdate where processado ='N'"
TCSQLExec(cUpdate)
MsgAlert(alltrim(str(Contador))+" cliente(s) inserido(s) com sucesso!")
RETURN






//**********************************************************************************************
//   DANILO_SC5
//**********************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao para VISIALIZAR OS PEDIDOS  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function VisPedido()
setprvt("A_pCampos")
a_pCampos := {}
AADD(a_pCampos,{"C5_NUM","NUMERO"})
AADD(a_pCampos,{"C5_CLIENTE","CLIENTE"})
AADD(a_pCampos,{"C5_CONDPAG","CONDPAG"})
AADD(a_pCampos,{"C5_DTCALC","DTCALC"})
AADD(a_pCampos,{"C5_VLRPED","VALOR"})
AADD(a_pCampos,{"C5_DATA","DATA"})
AADD(a_pCampos,{"C5_DIVVEN","DIVVEN"})
AADD(a_pCampos,{"c5_Parc1","parc1"})
AADD(a_pCampos,{"c5_Data1","DATA1"})
AADD(a_pCampos,{"c5_Parc2","PARC2"})
AADD(a_pCampos,{"c5_Data2","DATA2"})
AADD(a_pCampos,{"c5_Parc3","PARC3"})
AADD(a_pCampos,{"c5_Data3","DATA3"})
AADD(a_pcampos,{"c5_Parc4","PARC4"})
AADD(a_pCampos,{"c5_Data4","DATA4"})
AADD(a_pCampos,{"c5_Parc5","PARC5"})
AADD(a_pCampos,{"c5_Data5","DATA5"})
AADD(a_pCampos,{"c5_Parc6","PARC6"})
AADD(a_pCampos,{"c5_Data6","DATA6"})
AADD(a_pCampos,{"PROCESSADO","PROCESSADO?"})
AADD(a_pCampos,{"dataproc","dataproc"})

DbselectArea("SC5")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif
DbClosearea("SC5")

cQuery := "SELECT  TO_CHAR(C.DTPROCESSADO) AS DATAPROC, C.* FROM DANILO_SC5 C where C.processado ='N'"
TCQUERY cQuery NEW ALIAS "QUERYPEdido"

@ 200,001 TO 400,600 DIALOG oDlg2 TITLE "QUERYPEdido"
@ 6,5 TO 100,250 BROWSE "QUERYPEdido" FIELDS a_pCampos
@ 070,260 BUTTON "Fechar" SIZE 40,15 ACTION Close(oDlg2)
ACTIVATE DIALOG oDlg2 CENTERED
DBCloseArea("QUERYPEdido")
RETURN



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao Appendar PEDIDO³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function AppPEDIDO()
contPed := 0                                                                      
ContSzk := 0
Private cUpdate := ""
DbselectArea("SC5")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif

cQuery := "select * from DANILO_SC5 where processado ='N'"
TCQUERY cQuery NEW ALIAS "QUERYPedido"
//MSgAlert("Data_new: "+ ConverterData(QUERYPedido->C5_DTCALC))

DbSelectArea("QUERYPedido")
DBGoTop()
Procregua(Reccount())
While ! Eof()
	DBSelectArea("SC5")
	RECLOCK("SC5",.T.)  //INSERIR .T.
	SC5->C5_FILIAL := xfilial("SC5")
	SC5->C5_NUM := QUERYPedido->C5_NUM
	SC5->C5_CONDPAG := QUERYPedido->C5_CONDPAG
	SC5->C5_CODPROM := QUERYPedido->C5_CODPROM
	SC5->C5_CLIENTE := QUERYPedido->C5_CLIENTE
	SC5->C5_TIPOCLI := QUERYPedido->C5_TIPOCLI
	SC5->C5_DTCALC := CtoD(ConverterData(QUERYPedido->C5_DTCALC))
	SC5->C5_EMISSAO := CtoD(ConverterData(QUERYPedido->C5_EMISSAO))
	SC5->C5_RESPCOB := QUERYPedido->C5_RESPCOB
	SC5->C5_VLRPED := QUERYPedido->C5_VLRPED
	SC5->C5_DATA := CtoD(ConverterData(QUERYPedido->C5_DATA))
	SC5->C5_TIPOOP := QUERYPedido->C5_TIPOOP
	SC5->C5_DIVVEN := QUERYPedido->C5_DIVVEN
	SC5->C5_LOTEFAT := QUERYPedido->C5_LOTEFAT
	SC5->C5_MENNOTA := QUERYPedido->C5_MENNOTA
	SC5->C5_TIPO := QUERYPedido->C5_TIPO
	SC5->C5_TPTRANS := QUERYPedido->C5_TPTRANS
	SC5->C5_IDENTIF := QUERYPedido->C5_IDENTIF
	SC5->C5_TABELA := QUERYPedido->C5_TABELA
	SC5->C5_LOJACLI := QUERYPedido->C5_LOJACLI
	SC5->C5_LOJAENT := "01"
	SC5->C5_CARTAO := QUERYPedido->C5_CARTAO
	SC5->C5_CODSEG := QUERYPedido->C5_CODSEG
	SC5->C5_NUMERO := QUERYPedido->C5_NUMERO
	SC5->C5_VALID := CtoD(ConverterData(QUERYPedido->C5_VALID))
	SC5->C5_TITULAR := QUERYPedido->C5_TITULAR
	SC5->c5_Parc1 := QUERYPedido->c5_Parc1
	SC5->c5_Data1 := CtoD(ConverterData(QUERYPedido->c5_Data1))
	SC5->c5_Parc2 := QUERYPedido->c5_Parc2
	SC5->c5_Data2 := CtoD(ConverterData(QUERYPedido->c5_Data2))
	SC5->c5_Parc3 := QUERYPedido->c5_Parc3
	SC5->c5_Data3 := CtoD(ConverterData(QUERYPedido->c5_Data3))
	SC5->c5_Parc4 := QUERYPedido->c5_Parc4
	SC5->c5_Data4 := CtoD(ConverterData(QUERYPedido->c5_Data4))
	SC5->c5_Parc5 := QUERYPedido->c5_Parc5
	SC5->c5_Data5 := CtoD(ConverterData(QUERYPedido->c5_Data5))
	SC5->c5_Parc6 := QUERYPedido->c5_Parc6
	SC5->c5_Data6 := CtoD(ConverterData(QUERYPedido->c5_Data6))
	SC5->C5_USUARIO := SubStr(cUsuario,7,15)
	SC5->C5_VEND1 := QUERYPedido->C5_VEND1
	DbSelectArea("SA3")
	DBSetOrder(1)  //A3_FILIAL+A3_COD
	DBsEEK(xFilial("SA3")+QueryPedido->C5_VEND1)
	SC5->c5_vend3 := sa3->a3_super
	SC5->c5_vend4 := sa3->a3_geren
	SC5->c5_vend5 := sa3->a3_gerger
	IF TRIM(QUERYPedido->ZK_OBS) = "" 
		SC5->C5_AVESP := "N"
	ELSE                    
		SC5->C5_AVESP := "S"
		GerarSZK(QUERYPedido->C5_num, QUERYPedido->ZK_OBS)
	ENDIF
	DBCloseArea("SA3")
	MSUNLOCK("SC5")
	DbSelectArea("QUERYPedido")
	DBSkip()
	IncProc()
	contPed++
end
DBCloseArea("SC5")
DBCloseArea("QueryPEDIDO")

cUpdate := "update DANILO_SC5 set processado = 'S', dtprocessado = sysdate where processado ='N'"
TCSQLExec(cUpdate)
//MsgAlert(alltrim(str(contPed))+" pedidos(s) inserido(s) com sucesso!")
AppiTENS()
RETURN




//**********************************************************************************************
//   DANILO_SC6
//**********************************************************************************************

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao para VISUALIZAR OS ITENS DE PEDIDOS  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function VisiTENS()
setprvt("A_iCampos, aux_temp")
a_iCampos := {}
AADD(a_iCampos,{"C6_ITEM","ITEM"})
AADD(a_iCampos,{"C6_NUM","NUMERO"})
AADD(a_iCampos,{"C6_PRODUTO","PRODUTO"})
AADD(a_iCampos,{"C6_DESCRI","DESCR"})
AADD(a_iCampos,{"C6_TES","TES"})
AADD(a_iCampos,{"C6_CF","CF"})
AADD(a_iCampos,{"C6_QTDVEN","QTD"})
AADD(a_iCampos,{"C6_PRUNIT","PRUNIT"})
AADD(a_iCampos,{"C6_PRCVEN","PRCVEN"})
AADD(a_iCampos,{"C6_VALOR","VALOR"})
AADD(a_iCampos,{"C6_LOTEFAT","LOTEFAT"})
AADD(a_iCampos,{"C6_DATA","DATA"})
AADD(a_iCampos,{"C6_SITUAC","SITUAC"})
AADD(a_icampos,{"C6_CODDEST","CODDEST"})
AADD(a_iCampos,{"C6_TPPORTE","TPPORTE"})
AADD(a_iCampos,{"C6_CLI","CLIENTE"})
AADD(a_iCampos,{"C6_REGCOT","REGCOT"})
AADD(a_iCampos,{"C6_TIPOREV","TIPOREV"})
AADD(a_iCampos,{"C6_TPPROG","TPPROG"})
AADD(a_iCampos,{"C6_LOJA","LOJA"})
AADD(a_iCampos,{"PROCESSADO","PROCESSADO?"})
AADD(a_iCampos,{"dataproc","dataproc"})

DbselectArea("SC6")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif
DbClosearea("SC6")

cQuery := "SELECT  TO_CHAR(C.DTPROCESSADO) AS DATAPROC, C.* FROM DANILO_SC6 C where C.processado ='N'"
TCQUERY cQuery NEW ALIAS "QUERYItens"


@ 200,001 TO 400,600 DIALOG oDlg3 TITLE "QUERYItens"
@ 6,5 TO 100,250 BROWSE "QUERYItens" FIELDS a_iCampos
@ 070,260 BUTTON "Fechar" SIZE 40,15 ACTION Close(oDlg3)
ACTIVATE DIALOG oDlg3 CENTERED
DBCloseArea("QUERYItens")
RETURN



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao Appendar ITENS DE PEDIDO³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function AppiTENS()
SetPrvt("_LCONTINUA, _CCF")
SetPrvt("x1,")//teste
Private contITENS := 0
Private cUpdate := ""
DbselectArea("SC6")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif

cQuery := "select C6.*, C5.C5_VEND1 from DANILO_SC6 C6, DANILO_SC5 C5 where (C6.processado ='N') AND (C5.C5_NUM=C6.C6_NUM) AND (C5.C5_FILIAL=C6.C6_FILIAL)"
TCQUERY cQuery NEW ALIAS "QUERYITens"

DbSelectArea("QueryITens")
DBGoTop()
Procregua(Reccount())
While ! Eof()
	DBSelectArea("SC6")
	RECLOCK("SC6",.T.)  //INSERIR .T.
	SC6->C6_FILIAL := xfilial("SC6")
	SC6->C6_ITEM := QueryITens->C6_ITEM
	SC6->C6_NUM := QueryITens->C6_NUM
	//	SC6->C6_TES := QueryITens->C6_TES
	//	SC6->C6_CF := QueryITens->C6_CF
	SC6->C6_QTDVEN := QueryITens->C6_QTDVEN
	SC6->C6_PRUNIT := QueryITens->C6_PRUNIT
	SC6->C6_PRCVEN := QueryITens->C6_PRCVEN
	SC6->C6_VALOR := QueryITens->C6_VALOR
	SC6->C6_LOTEFAT := QueryITens->C6_LOTEFAT
	SC6->C6_DATA := CtoD(ConverterData(QueryITens->C6_DATA))
	SC6->C6_SITUAC := QueryITens->C6_SITUAC
	SC6->C6_CODDEST := QueryITens->C6_CODDEST
	SC6->C6_TPPORTE := QueryITens->C6_TPPORTE
	SC6->C6_CLI := QueryITens->C6_CLI
	SC6->C6_REGCOT := QueryITens->C6_REGCOT
	SC6->C6_TIPOREV := QueryITens->C6_TIPOREV
	SC6->C6_TPPROG := QueryITens->C6_TPPROG
	SC6->C6_LOJA := QueryITens->C6_LOJA
	SC6->C6_PRODUTO := QueryITens->C6_PRODUTO
	SC6->c6_SUP := QueryITens->C6_SUP
	SC6->C6_SITUAC := "AA"  //20030820
	SC6->C6_TPOP := "F"
	SC6->C6_NUMSERI := QueryITens->C6_NUMSERI //20030901
	SC6->C6_VERSAO := QueryITens->C6_VERSAO   //20030901 
	SC6->C6_RAZSIS := QueryITens->C6_RAZSIS //20030901
	DBSelectArea("SB1")
	DBSetOrder(1)     //B1_FILIAL_B1_COD
	DBSeek(xfilial("SB1")+QueryItens->C6_PRODUTO)
	SC6->C6_CLASFIS := Subs(SB1->B1_ORIGEM,1,1)+SB1->B1_CLASFIS
	SC6->C6_DESCRI := SB1->B1_DESC        
	SC6->C6_CODISS := SB1->B1_CODISS //20030820

	
	DbSelectArea("SA3")
	DBSetOrder(1)  //A3_FILIAL+A3_COD
	DBsEEK(xFilial("SA3")+QueryItens->C5_VEND1)
	SC6->C6_LOCAL := SA3->A3_LOCAL  //20030820
		
	DbSelectArea("SZ3")
	DBSetOrder(1)  //Z3_FILIAL+Z3_CODPROD+Z3_CODREG
	DBsEEK(XFILIAL("SZ3")+QUERYItens->C6_PRODUTO+SA3->A3_REGIAO)
	SC6->C6_COMIS1 :=  IIF(SA3->A3_TIPOVEN $ "OP", SZ3->Z3_COMOTEL, SZ3->Z3_COMREP1 )
	SC6->C6_COMIS4 := SZ3->Z3_COMGLOC
	SC6->C6_COMIS5 := SZ3->Z3_COMGGER
	SC6->C6_COMIS3 := SZ3->Z3_COMSUP
	SC6->C6_COMIS2 := SZ3->Z3_COMREP2
	//20030819
	SC6->C6_EDINIC := QueryItens->C6_EDINIC
	SC6->C6_EDFIN := QueryItens->C6_EDFIN
	SC6->C6_EDVENC := QueryItens->C6_EDFIN
	SC6->C6_EDSUSP := QueryItens->C6_EDINIC
	SC6->C6_TIPOREV := IF(SB1->B1_GRUPO=='0100',"","0")
	//ATEH AKI 
	           
	//20030820
	dbSelectArea("SZJ")
	dbSeek(xFilial("SZJ")+LEFT(SC6->C6_PRODUTO,4)+STR(SC6->C6_EDFIN,4))
	SC6->C6_DTFIN   := SZJ->ZJ_DTCIRC
	SC6->C6_DTCIRC   := SZJ->ZJ_DTCIRC
	DBcloseArea("SZJ")	
	SC6->C6_DTINIC := dDATABASE
	//ATEH AKI
	
	

		
	//ÚÄÄÄÄÄÄÄ¿
	//³GATSUP2³
	//ÀÄÄÄÄÄÄÄÙ
	DbSelectArea("SA1")
	DbSetOrder(1)
	DbSeek(xFilial("SA1")+SC6->C6_CLI+SC6->C6_LOJA)
	
	DbSelectArea("SF4")
	DbSetOrder(1)  
	DbSeek(xfilial("SF4")+SB1->B1_TS)
	_cCF:= AllTrim(SF4->F4_CF)
	
	If SA1->A1_EST == "SP" 
		_cCF:= '5'+SUBSTR(_cCF,2,3)
	ElseIf SA1->A1_EST=="EX"
		_cCF:='7'+SUBSTR(_cCF,2,3)
	ElseIf SA1->A1_EST <> "SP" .And. SA1->A1_EST=="EX"
		_cCF:='6'+SUBSTR(_cCF,2,3)
	EndIf

	SC6->C6_TES := SB1->B1_TS
	SC6->C6_CF := _cCF
	DBCloseArea("SF4")
	DBCloseArea("SA1")
	// ATEH AKI: GATSUP2
	
	
	DBCloseArea("SZ3")
	DBCloseArea("SB1")
	DBCloseArea("SA3")
	MSUNLOCK("SC6")
	DbSelectArea("QueryItens")
	DBSkip()
	IncProc()
	contITENS++
end
DBCloseArea("SC6")
DBCloseArea("QueryItens")

cUpdate := "update DANILO_SC6 set processado = 'S', dtprocessado = sysdate where processado ='N'"
TCSQLExec(cUpdate)


_cMsgINFO:= alltrim(str(contPed))+" pedidos(s) inserido(s) com sucesso!"+CHR(13)
_cMsgINFO:= _cMsgINFO + alltrim(str(contITENS))+" itens de pedidos(s) inserido(s) com sucesso!"+CHR(13)
_cMsgINFO:= _cMsgINFO + alltrim(str(ContSzk))+" aviso(s) especial(is) com sucesso!"
MsgInfo(OemToAnsi(_cMsgInfo))
RETURN
                                    



static Function GErarSZK(pedido, obs)
DBSelectArea("SZK")
	RECLOCK("SZK",.T.)  //INSERIR .T.
		SZK->ZK_FILIAL := xFILIAL("SZK")
		SZK->ZK_PEDIDO := PEDIDO
		SZK->ZK_OBS := OBS
		ContSzk++
	MSUNLOCK("SZK")	
return






//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³converterData³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
static Function ConverterData(data_old)             //12345678
setprvt("data_new")                      //20030814
data_new := substr(data_old,7,2)+"/"+substr(data_old,5,2)+"/"+substr(data_old,3,2)
return data_new











//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao Appendar DESTINATARIOS  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function AppSZN()
Private cUpdate := ""
DbselectArea("SZN")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif

cQuery := "select * from DANILO_SZN ZN where (ZN.processado ='N')"
TCQUERY cQuery NEW ALIAS "QUERYSZN"

DbSelectArea("QUERYSZN")
DBGoTop()
Procregua(Reccount())
While ! Eof()
	DBSelectArea("SZN")
	RECLOCK("SZN",.T.)  //INSERIR .T.
	SZN->ZN_FILIAL := xfilial("SZN")
	SZN->ZN_CODCLI := QUERYSZN->ZN_CODCLI
	SZN->ZN_CODDEST := QUERYSZN->ZN_CODDEST
	SZN->ZN_NOME := QUERYSZN->ZN_NOME
	SZN->ZN_DEPTO := QUERYSZN->ZN_DEPTO
	SZN->ZN_CARGO := QUERYSZN->ZN_CARGO
	SZN->ZN_ENDEST := QUERYSZN->ZN_ENDEST
	SZN->ZN_SITUAC := QUERYSZN->ZN_SITUAC
	MSUNLOCK("SZN")
	DbSelectArea("QuerySZN")
	DBSkip()
	IncProc()
	contSZN++
end
DBCloseArea("SZN")
DBCloseArea("QuerySZN")

cUpdate := "update DANILO_SZN set processado = 'S', dtprocessado = sysdate where processado ='N'"
TCSQLExec(cUpdate)

AppSZO()
RETURN



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao Appendar ENDERECO DE DESTINATARIOS  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function AppSZO()
Private cUpdate := ""
DbselectArea("SZO")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif

cQuery := "select * from DANILO_SZO ZO where (ZO.processado ='N')"
TCQUERY cQuery NEW ALIAS "QUERYSZO"

DbSelectArea("QUERYSZO")
DBGoTop()
Procregua(Reccount())
While ! Eof()
	DBSelectArea("SZO")
	RECLOCK("SZO",.T.)  //INSERIR .T.
	SZO->ZO_FILIAL := xfilial("SZO")
	SZO->ZO_CODCLI := QUERYSZO->ZO_CODCLI
	SZO->ZO_CODDEST := QUERYSZO->ZO_CODDEST
	SZO->ZO_END := QUERYSZO->ZO_END
	SZO->ZO_BAIRRO := QUERYSZO->ZO_BAIRRO
	SZO->ZO_CIDADE := QUERYSZO->ZO_CIDADE
	SZO->ZO_CEP := QUERYSZO->ZO_CEP
	SZO->ZO_ESTADO := QUERYSZO->ZO_ESTADO
	SZO->ZO_FONE := QUERYSZO->ZO_FONE
	MSUNLOCK("SZO")
	DbSelectArea("QuerySZO")
	DBSkip()
	IncProc()
	contSZO++
end
DBCloseArea("SZO")
DBCloseArea("QuerySZO")

cUpdate := "update DANILO_SZO set processado = 'S', dtprocessado = sysdate where processado ='N'"
TCSQLExec(cUpdate)

_cMsgINFO := alltrim(str(contSZN))+" Destinatario(s) inserido(s) com sucesso!"+CHR(13)
_cMsgINFO += alltrim(str(contSZN))+" Enderecos de destinatario(s) inserido(s) com sucesso!"
MsgInfo(OemToAnsi(_cMsgInfo))
RETURN
