#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ PFAT247  ³ Autor ³ Danilo C S Pala       ³ Data ³ 20091029 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Gerar daos para EVENTO da Swat, depois xmlevento           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Pini                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat247()
SetPrvt("_CALIAS,_NINDEX,_NREG,CPERG,_CMSG,AROTINA")
SetPrvt("CCADASTRO,VALIDADE,AREGS,I,J,")
_cAlias  := Alias()
_nIndex  := IndexOrd()
_nReg    := Recno()


aRotina := 	{{"Pesquisa" 	, "AxPesqui"						, 0, 1},; // Pesquisar
			{"Visualisa"	, "AxVisual"						, 0, 2},; // Visualiza
			{"Incluir"      ,"AxInclui" 						, 0, 3},; // Incluir
            {"Alterar"      ,"AxAltera" 						, 0, 4},; // Alterar             
            {"Excluir"      ,"AxDeleta" 						, 0, 5},; // Excluir
			{"Notas Fiscais","U_Pft247Det(1)"					, 0, 6},; //Atribuir NFS
			{"Xml Evento"	,'U_XmlEvento()'					, 0, 7}} //Gerar Xml Evento
			
dbselectarea("ZY0")
mBrowse( 6, 1,22,75,"ZY0",,,,)            // "C5_LIBEROK")

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)
Return










/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT247I  ºAutor  ³Danilo Pala         º Data ³  20091103   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Pft247Det(x)             
Local cChave   := ""
Local nLin
Local i        := 0
Local lRet     := .F.                               
Local cAlias   := "ZY1"
Local cProcura := ""     
Local nContS   := 0
Local cLibera  := ""

Private cT        := "Evento Swat"
Private aC        := {}
Private aR        := {}
Private aCGD      := {}
Private cLinOK    := ""
Private cAllOK    := .T. //"" //"u_VerTudOK()"
Private aGetsGD   := {}
Private bF4       := {|| }
Private cIniCpos  := "+ZY1_CODEVE"
Private nMax      := 15
Private aHeader   := {}
Private aCols     := {}
Private nCount    := 0
Private bCampo    := {|nField| FieldName(nField)}
Private aAlt      := {}   
Private xtipo     := x
Private nVlTot    := 0
Private nVlVend   := 0
Private cObs      := space(40)
Private cPagto    := space(03)
Private c1Comis   := space(06)
Private c2Comis   := space(06)
Private cTipoOper := space(03)
Private cTComis1 
Private cRegiao
Private nqItem    := 0
Private cCgc
Private cCodCli
Private cCodLoja
Public cInsNF := " "
Public cDelNF := " "


dbselectarea(cAlias)
For i := 1 to FCount()
	cCampo := FieldName(i)
	M->&(cCampo) := CriaVar(cCampo,.T.)
Next                 

dbselectarea("SX3")
dbsetorder(1)
dbseek(cAlias)

while !SX3->(EOF()) .and. SX3->X3_Arquivo == cAlias
	if X3Uso(SX3->X3_USADO)    .and.;
	   cNivel >= SX3->X3_Nivel .and.;
	   Trim(SX3->X3_CAMPO) $ "ZY1_CODEVE/ZY1_SERIE/ZY1_DOC/ZY1_EMISSAO"
	   //if xtipo == 1 //.and. Trim(SX3->X3_CAMPO) <> "ZZY_QTDTRA" .and. Trim(SX3->X3_CAMPO) <> "ZZY_QTDARM"
		   aAdd(aHeader, {Trim(SX3->X3_TITULO),;
		                       SX3->X3_CAMPO  ,;
		                       SX3->X3_PICTURE,;
		                       SX3->X3_TAMANHO,;
		                       SX3->X3_DECIMAL,;
		                       SX3->X3_VALID  ,;
		                       SX3->X3_USADO  ,;
		                       SX3->X3_TIPO   ,;
		                       SX3->X3_ARQUIVO,;
		                       SX3->X3_CONTEXT})
	   //endif
	endif
	sx3->(dbskip())
enddo

/*m->ZY0_CODEVE := (cAlias)->ZY0_CODEVE
m->ZY0_NOME   := (cAlias)->ZY0_NOME
m->ZY0_DATA  := (cAlias)->ZY0_DATA
  */
/*c1Comis := posicione("SA1",1,xfilial("SA1")+m->(ZZY_client+ZZY_loja),"A1_VEND")
c2Comis := posicione("SA3",1,xfilial("SA3")+c1Comis,"A3_GEREN")*/

cProcura := xfilial(cAlias)+ZY0->ZY0_CODEVE

dbselectarea(cAlias)
dbsetOrder(2)   //filial+codeve+serie+doc+emissao
dbseek(cProcura)

while !eof() .and. ZY1->ZY1_CODEVE == ZY0->ZY0_CODEVE

	/*if (cAlias)->ZZY_ok == "OK"
		cLibera := "Não é possível executar nenhum movimento com uma nota encerradas, verifique!!!"
	elseif xtipo == 2 .and. (cAlias)->ZZY_qtdtra >= (cAlias)->ZZY_q3fim
		cLibera := "Não há valor a ser transportado para este produto, verifique!!!"
	else*/
		aAdd(aCols,Array(Len(aHeader)+1))
		nLin := Len(aCols)
		For i:= 1 to Len(aHeader) 
			if aHeader[i][10] = "R" //.and. aHeader[i][2] <> "ZZY_QTDVEN" .and. aHeader[i][2] <> "ZZY_QTDTRA" .and. aHeader[i][2] <> "ZZY_QTDARM" .and. aHeader[i][2] <> "ZZY_PVENDA"
	   			aCols[nLin][i] := FieldGet(FieldPos(aHeader[i][2]))									   
			else
				aCols[nLin][i] := CriaVar(aHeader[i][2],.t.)
			endif       
		Next
		aCols[nLin][Len(aHeader)+1] = .F.
		aAdd(aAlt, Recno())
		nContS := nContS + 1
	//endif              		
	dbselectarea(cAlias)
	dbskip()      
enddo

if nContS == 0
	msgalert("Abrir direto programa para pegar as notas")
//	return nil
endif 
                                       

aAdd(aC,{"ZY0->ZY0_CODEVE"  ,{20,10 },"Codigo Evento"    ,"@!"    ,           ,     ,.F.})
aAdd(aC,{"ZY0->ZY0_NOME"    ,{20,80},"Nome"              ,"@!"    ,           ,     ,.F.})
aAdd(aC,{"ZY0->ZY0_DATA"    ,{20,300},"Data"     	      ,        ,           ,     ,.F.})
aAdd(aC,{"cInsNF"			,{20,360},"Incluir NF?"      ,"@!"    ,"u_Pft247Ins(cInsNF)"   ,     ,.T.})
aAdd(aC,{"cDelNF"			,{20,420},"Deletar NF?"      ,"@!"    ,"u_Pft247Exc(cDelNF)"   ,     ,.T.})
aCGD := {50,5,108,280}

/*aAdd(aR,{"nVlTot" ,{68,10 },"Total Custo","@E 999,999,999.99",,,.F.})
aAdd(aR,{"cObs"   ,{68,120},"Observações","@!"               ,,,.T.})
aAdd(aR,{"nVLVend",{83,10 },"Total Venda","@E 999,999,999.99",,,.F.})
                                                                     */
cLinOk := "u_Pfat247LinOK()"

cTitulo := cT

lRet := Modelo2(cTitulo,aC,aR,aCGD,4,cLinOK,cAllOk,,,cIniCpos,nMax,{01,01,550,950},.f.)

/*if lRet
	if MsgYesNo("Confirma os Dados Digitados?",cTitulo)
		
		Processa({||U_Gravazzy(cAlias)},cTitulo,"Gerando as informações, aguarde por favor!!")
		
		if xtipo == 1
		   // Execução do cadastro do Pedido de venda (Mata410)
           u_gravaPED()
		elseif xtipo == 2
		   // Execução do cadastro de NF de Transporte (Mata103)
           u_gravaNFE()
		else
		   // Execução do cadastro de NF de Armazenagem (Mata103)
           u_gravaNFE()
		endif
		
	endif
else
	rollbackSX8()
endif*/

return nil                 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT247I  ºAutor  ³Danilo Pala         º Data ³  20091103   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Pft247Ins(cInsNF)
if cInsNF=="S"
	TelaNotasFiscais("Ins")
endif    
cInsNF := " "
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT247I  ºAutor  ³Danilo Pala         º Data ³  20091103   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Pft247Exc(cDelNF)
if cDelNF=="S"
	TelaNotasFiscais("Del")
endif    
cDelNF := " "
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT247LinOK  ºAutor  ³Danilo Pala         º Data ³  20091103   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PFAT247LinOK()

Return .T.


Static Function TelaNotasFiscais(cAcao)
PRIVATE lExec    := .F.
PRIVATE cIndexName := ''
PRIVATE cIndexKey  := ''
PRIVATE cFilter    := ''
Private cQuery := ""
Private cSerie :="UNI"
Private cDoNumero  :="370945   "
Private cAteNumero :="370961   "   
Private cVendedor := space(6)
if cAcao =="Ins"
	@ 000,000 TO 320,400 DIALOG oDlg TITLE "Parametros Consulta Nota Fiscal" 
	@ 001,005 TO 310,380
	@ 005,010 SAY "Serie:"
	@ 005,070 GET cserie  Picture "@!" F3("SF2") Valid ValSF2()
	@ 020,010 SAY "Do Numero:"
	@ 020,070 GET cDoNumero  Picture "@R 999999999"
	@ 035,010 SAY "Ate Numero"
	@ 035,070 GET cAteNumero  Picture "@R 999999999"
	//@ 050,010 SAY "Vendedor:"
	//@ 050,070 GET cVendedor  Picture "@!" F3("SA3")
	@ 115,010 BUTTON "OK" SIZE 40,20 ACTION Processa({||GetNotasFiscais(cSerie, cDoNumero, cAteNumero, "Ins")})
	//@ 115,070 BUTTON "Cancelar" SIZE 40,20 Action ( Close(oDlg) )
	Activate Dialog oDlg centered

else  //Del
	GetNotasFiscais(cSerie, cDoNumero, cAteNumero, "Del")
endif
Return          


Static Function GetNotasFiscais(cSerie, cDoNumero, cAteNumero, cAcao)
if cAcao =="Ins"
	cQuery := "SELECT * FROM "+ RetSqlName("SF2") +" SF2 WHERE F2_FILIAL='"+ XFILIAL("SF2") +"' AND F2_SERIE='"+ cSerie +"' AND F2_DOC>='"+ cDoNumero +"' AND F2_DOC<='"+ cAteNumero +"' AND SF2.D_E_L_E_T_<>'*'"
	TCQUERY cQuery NEW ALIAS "NOTA"
	TcSetField("NOTA","F2_EMISSAO"   ,"D")
	DbSelectArea("NOTA")
	DBGOTOP()
	WHILE !EOF() 
		cQuery := "SELECT COUNT(*) AS QTD FROM "+ RetSqlName("ZY1") +" ZY1 WHERE ZY1_FILIAL='"+ XFILIAL("ZY1") +"' AND ZY1_SERIE='"+ NOTA->F2_SERIE +"' AND ZY1_DOC='"+ NOTA->F2_DOC +"' AND ZY1_EMISSA='"+ DTOS(NOTA->F2_EMISSAO) +"' AND ZY1.D_E_L_E_T_<>'*'"
		TCQUERY cQuery NEW ALIAS "EXISTE"
		DbSelectArea("EXISTE")
			IF EXISTE->QTD >=1 
				//JA EXISTE			
			ELSE
				DbSelectArea("ZY1")
				RECLOCK("ZY1",.T.)
				ZY1_FILIAL := XFILIAL("ZY1")
				ZY1_SERIE  := NOTA->F2_SERIE
				ZY1_DOC    := NOTA->F2_DOC
				ZY1_EMISSA := NOTA->F2_EMISSAO
				ZY1_STATUS := "A"  
                ZY1->(MSUnlock())
			ENDIF    
			DbSelectArea("EXISTE")
			DbCloseArea()
		DbSelectArea("NOTA")
		DBSkip()
	END
	DbSelectArea("NOTA")
	DbCloseArea()

	cString  := "ZY1"
	nLastKey := 0

	cIndexName	:= Criatrab(Nil,.F.)
	cIndexKey	:= "ZY1_SERIE+ZY1_DOC+ZY1_EMISSAO"
	cFilter		:= "ZY1_FILIAL=='"+xFilial("ZY1")+"'"
	cFilter		+= " .And. ZY1_SERIE='" + cSerie + "'" 
	cFilter		+= " .And. ZY1_DOC>='" + cDoNumero + "' .And. ZY1_DOC<='" + cAteNumero + "' .And. Empty(ZY1_CODEVE)" //='      '"

else
	cString  := "ZY1"
	nLastKey := 0

	cIndexName	:= Criatrab(Nil,.F.)
	cIndexKey	:= "ZY1_SERIE+ZY1_DOC+ZY1_EMISSAO"
	cFilter		:= "ZY1_FILIAL=='"+xFilial("ZY1")+"'"
	cFilter		+= ".And. ZY1_CODEVE='" + ZY0->ZY0_CODEVE + "'" 
endif

IndRegua("ZY1", cIndexName, cIndexKey,, cFilter, "Aguarde selecionando registros....")
DbSelectArea("ZY1")
#IFNDEF TOP
	DbSetIndex(cIndexName + OrdBagExt())
#ENDIF
                         
dbGoTop()
@ 001,001 TO 400,700 DIALOG oDlg TITLE "Seleção de Notas Fiscais: "+ iif(cAcao=="Ins","Incluir","Deletar")
@ 001,001 TO 170,350 BROWSE "ZY1" MARK "ZY1_OK"
@ 180,310 BMPBUTTON TYPE 01 ACTION (lExec := .T.,Close(oDlg))
@ 180,280 BMPBUTTON TYPE 02 ACTION (lExec := .F.,Close(oDlg))
ACTIVATE DIALOG oDlg CENTERED
	
dbGoTop()
If lExec
	WHILE !EOF() 
		If Marked("ZY1_OK")      
			if cAcao =="Ins"
				RECLOCK("ZY1",.F.) //update     
				ZY1_CODEVE := ZY0->ZY0_CODEVE
				ZY1_STATUS := "B"
				ZY1->(MSUnlock())
			else  //Del
				RECLOCK("ZY1",.F.) //update     
				ZY1_CODEVE := SPACE(6)
				ZY1_STATUS := "A"
				ZY1->(MSUnlock())
			endif
		EndIf
		DbSelectArea("ZY1")
		DBSkip()
	END
	MsgInfo("Reabra a consulta para aparecer as atualizacoes")
Endif

DbSelectArea("ZY1")
DbCloseArea()
Return Nil


Static Function ValSF2()
IF cSerie == "   "
	cSerie := SF2->F2_SERIE
	cDoNumero := SF2->F2_DOC
	cAteNumero := SF2->F2_DOC
endif
RETURN (.T.)