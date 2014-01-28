#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ PGPE001  ณ Autor ณ Danilo C S Pala       ณ Data ณ 20111220 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ FUNCIONARIO VS ATIVIDADES/CENTRO DE CUSTOS PERCENTUAL      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Pini                                                       ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function PGPE001()
SetPrvt("_CALIAS,_NINDEX,_NREG,CPERG,_CMSG,AROTINA")
SetPrvt("CCADASTRO,VALIDADE,AREGS,I,J,")
_cAlias  := Alias()
_nIndex  := IndexOrd()
_nReg    := Recno()


aRotina := 	{{"Pesquisa" 	, "AxPesqui"						, 0, 1},; // Pesquisar
			{"Atividade"    ,"U_PGPE001Det(SRA->RA_MAT)"    	, 0, 2}} //Inserir Atividade
			
dbselectarea("SRA")
mBrowse( 6, 1,22,75,"SRA",,,,)

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)
Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPGPE001DETบAutor  ณDanilo Pala         บ Data ณ  20111220   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PGPE001DET(xMAT)             
Local cChave   := ""
Local nLin
Local i        := 0
Local lRet     := .F.                               
Local cAlias   := "ZY7"
Local cProcura := ""     
Local nContS   := 0
Local cLibera  := ""

Private cT        := "Funcionario vs Atividade (Centro de Custo e percentual)"
Private aC        := {}
Private aR        := {}
Private aCGD      := {}
Private cLinOK    := ""
Private cAllOK    := "u_PGPE001TudOK()"
Private aGetsGD   := {}
Private bF4       := {|| }
Private cIniCpos  := "ZY7_MAT"
Private nMax      := 15
Private aHeader   := {}
Private aCols     := {}
Private nCount    := 0
Private bCampo    := {|nField| FieldName(nField)}
Private aAlt      := {}   
Private xtipo     := xMAT
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
	   Trim(SX3->X3_CAMPO) $ "ZY7_SEQUEN/ZY7_CC/ZY7_PERC"
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

cProcura := xfilial(cAlias)+xMat

dbselectarea(cAlias)
dbsetOrder(1)   //filial+codeve+serie+doc+emissao
dbseek(cProcura)

while !eof() .and. ZY7->ZY7_MAT == xMat

	aAdd(aCols,Array(Len(aHeader)+1))
	nLin := Len(aCols)
	For i:= 1 to Len(aHeader) 
		if aHeader[i][10] = "R" //.and. aHeader[i][2] <> "ZZY_QTDTRA" .and. aHeader[i][2] <> "ZZY_QTDARM" .and. aHeader[i][2] <> "ZZY_PVENDA"
   			aCols[nLin][i] := FieldGet(FieldPos(aHeader[i][2]))									   
		else
			aCols[nLin][i] := CriaVar(aHeader[i][2],.t.)
		endif       
	Next
	aCols[nLin][Len(aHeader)+1] = .F.
	aAdd(aAlt, Recno())
	nContS := nContS + 1
	dbselectarea(cAlias)
	dbskip()      
enddo

if nContS == 0
	//msgalert("Abrir direto programa para pegar as notas")
//	return nil
endif 
                                       

aAdd(aC,{"SRA->RA_MAT"     ,{20,10},"Matricula"         ,"@!"    ,           ,     ,.F.})
aAdd(aC,{"SRA->RA_NOME"    ,{20,80},"Sequencia"         ,"@!"    ,           ,     ,.F.})
/*aAdd(aC,{"cInsNF"			,{20,360},"Incluir NF?"      ,"@!"    ,"u_Pft247Ins(cInsNF)"   ,     ,.T.})
aAdd(aC,{"cDelNF"			,{20,420},"Deletar NF?"      ,"@!"    ,"u_Pft247Exc(cDelNF)"   ,     ,.T.})*/
aCGD := {50,5,108,280}

aAdd(aR,{"nVlTot" ,{68,10 },"Soma do Percentual","@E 999.99",,,.F.})/*
aAdd(aR,{"cObs"   ,{68,120},"Observa็๕es","@!"               ,,,.T.})
aAdd(aR,{"nVLVend",{83,10 },"Total Venda","@E 999,999,999.99",,,.F.})
                                                                     */
cLinOk := "u_PGPE001LinOK()"

cTitulo := cT

lRet := Modelo2(cTitulo,aC,aR,aCGD,4,cLinOK,cAllOk,,,cIniCpos,nMax,{01,01,550,950},.T.)

if lRet
	if MsgYesNo("Confirma os Dados Digitados?",cTitulo)
		Processa({||U_Gravazy7(cAlias, xMAT)},cTitulo,"Gerando as informa็๕es, aguarde por favor!!")
	endif
else
	rollbackSX8()
endif

return nil                 




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPGPE001LinOK  บAutor  ณDanilo Pala     บ Data ณ  20111220   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PGPE001LinOK()
Local lRet := .t.

if Len(aCols) >5
	lRet := .f.
	MsgInfo("ษ permitido cadastrar at้ 5 atividades",cTitulo)	
endif*/

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPGPE001TudOK  บAutor  ณDanilo Pala     บ Data ณ  20111221   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica os dados se estใo tudo certos                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                             
User Function PGPE001TudOK()

Local lRet := .t.
Local i    := 0
Local nPerc := 0

For i := 1 to Len(aCols)
	if !empty(aCols[i][3])
		If !aCols[i][Len(aHeader)+1] //se .T. campo estแ deletado
			nPerc := nPerc + aCols[i][3]
		EndIf
	endif
	if empty(aCols[i][1]) .or. empty(aCols[i][2]) .or. empty(aCols[i][3])
		msgInfo("Existem campos obrigat๓rios em branco!",cTitulo)
    	lRet := .f.
	endif
Next

if nPerc <> 100
	MsgInfo("A somatoria dos percentuais deve ser igual a 100!!!",cTitulo)
	lRet := .f.
endif

Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGravazy7  บAutor  ณDanilo Pala         บ Data ณ  20111221   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava os dados ajustados e digitados na tela                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                             
User Function Gravazy7(cAlias, xMAT)

Local nLin
Local y
Local nNrCampo
ProcRegua(Len(aCols))
dbselectarea(cAlias)
dbsetOrder(1)
//deletar registros antigos
/*if dbseek(xfilial("ZY7")+xMAT)
	while !eof() .and. ZY7_MAT==xMAT
		RECLOCK(cAlias,.F.)
			DBDELETE()
		MSUNLOCK()
		DBSKIP()
	end
endif*/
For nLin := 1 to Len(aCols)
	dbselectarea("ZY7")
	dbsetOrder(1) //ZY7_FILIAL+ZY7_MAT+ZY7_SEQUEN
	IF DBSeek(xfilial("ZY7")+xMAT+Transform(nLin,"@E 99"))
		if !aCols[nLin][Len(aHeader)+1] //se .T. campo estแ deletado
			reclock("ZY7",.f.)//update
				(cAlias)->ZY7_filial  := xfilial(cAlias)
				(cAlias)->ZY7_MAT     := xMAT
				(cAlias)->ZY7_SEQUEN  := nLin
				(cAlias)->ZY7_CC      := aCols[nLin][2]
				(cAlias)->zy7_PERC    := aCols[nLin][3]
			MSUNLOCK()
		else //deletar
			reclock("ZY7",.f.)//delete
				dbdelete()
			msunlock()
		endif
	ELSE
		if !aCols[nLin][Len(aHeader)+1] //se .T. campo estแ deletado
			reclock("ZY7",.t.)//insert
				(cAlias)->ZY7_filial  := xfilial(cAlias)
				(cAlias)->ZY7_MAT     := xMAT
				(cAlias)->ZY7_SEQUEN  := nLin
				(cAlias)->ZY7_CC      := aCols[nLin][2]
				(cAlias)->zy7_PERC    := aCols[nLin][3]
			MSUNLOCK()
		else //deletar
			reclock("ZY7",.f.)//delete
				dbdelete()
			msunlock()
		endif
	ENDIF
Next
Return nil
