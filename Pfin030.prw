#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ Pfin030  ณ Autor ณ Danilo C S Pala       ณ Data ณ 20121112 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Longo Prazo Curto Prazo LPCP                                 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Pini                                                       ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function Pfin030()
SetPrvt("_CALIAS,_NINDEX,_NREG,CPERG,_CMSG,AROTINA")
SetPrvt("CCADASTRO,VALIDADE,AREGS,I,J,")
Public cOpcaoTipo := "F"
_cAlias  := Alias()
_nIndex  := IndexOrd()
_nReg    := Recno()

cperg := "PINIFIN030"
ValidPerg()
if !Pergunte(cPerg,.t.)
	return
endif

if mv_par01==1 //Diferimento
	cOpcaoTipo := "D"
elseif mv_par01==2 //Emprestimo
	cOpcaoTipo := "E"
Else
	cOpcaoTipo := "F"
Endif 
	

aRotina := 	{{"Pesquisa" 	  ,"AxPesqui"			 , 0, 1},; // Pesquisar
				{"Visualisa"	  ,"U_Pfin030Det('V',ZYA->ZYA_CONTRA)", 0, 2},; // Visualiza
				{"Incluir"      ,"U_Pfin030Det('I','')", 0, 3},; // Incluir
            	{"Alterar"      ,"U_Pfin030Det('A',ZYA->ZYA_CONTRA)", 0, 4},; // Alterar             
            	{"Excluir"      ,"U_Pfin030Det('D',ZYA->ZYA_CONTRA)", 0, 5},; // Excluir
				{"Contabilizar" ,"U_Pfin030Det('C',ZYA->ZYA_CONTRA)", 0, 6},; //Contabilizar
				{"Estornar Ctb" ,"U_Pfin030Det('E',ZYA->ZYA_CONTRA)", 0, 7}}  //Estornar contabilizacao
			
dbselectarea("ZYA")
mBrowse( 6, 1,22,75,"ZYA",,,,)

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)
Return










/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPfin030CtbบAutor  ณDanilo Pala         บ Data ณ  20121112   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Pfin030Det(xtipo, xcontrato)
Local cChave   := ""
Local nLin
Local i        := 0
Local lRet     := .F.                               
Local cAliasA  := "ZYA"
Local cAlias   := "ZYB"
Local cProcura := ""     
Local nContS   := 0
Local cLibera  := ""

Private cT        := "LPCP"
Private aC        := {}
Private aR        := {}
Private aCGD      := {}
Private cLinOK    := ""
Private cAllOK    := .T. //"" //"u_VerTudOK()"
Private aGetsGD   := {}
Private bF4       := {|| }
Private cIniCpos  := "+ZYB_CONTRA"
Private nMax      := 15
Private aHeader   := {}
Private aCols     := {}
Private nCount    := 0
Private bCampo    := {|nField| FieldName(nField)}
Private aAlt      := {}   
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


dbselectarea(cAliasA)
For i := 1 to FCount()
	cCampo := FieldName(i)
	M->&(cCampo) := CriaVar(cCampo,.T.)
Next                 

dbselectarea("SX3")
dbsetorder(1)
dbseek(cAliasA)

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
	   Trim(SX3->X3_CAMPO) $ "ZYB_CONTRA/ZYB_PARCEL/ZYB_VENCTO/ZYB_FATURA/ZYB_JUROS/ZYB_AMORT/ZYB_SALDO"
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

if xtipo <>"I"
cProcura := xfilial(cAlias)+xcontrato
dbselectarea(cAlias)
dbsetOrder(1)   //filial+contrato
dbseek(cProcura)
while !eof() .and. ZYB->ZYB_CONTRA == ZYA->ZYA_CONTRA
	aAdd(aCols,Array(Len(aHeader)+1))
	nLin := Len(aCols)
	For i:= 1 to Len(aHeader) 
		if aHeader[i][10] = "R" //.and. aHeader[i][2] <> "ZZY_QTDVEN"
   			aCols[nLin][i] := FieldGet(FieldPos(aHeader[i][2]))									   
		else
			aCols[nLin][i] := CriaVar(aHeader[i][2],.t.)
		endif       
	Next
	aCols[nLin][Len(aHeader)+1] = .F.
	aAdd(aAlt, Recno())
	dbselectarea(cAlias)
	dbskip()      
enddo
else
	aCols := {}
endif
 
//montar se for alteracao ou visualizacao
if xtipo='A' .or. xtipo='V' .or. xtipo='D' .or. xtipo=='C' 
	dbselectarea("ZYA")
	dbsetOrder(1)   //filial+contrato
	IF DBSeek(xfilial("ZYA")+xcontrato) //gravar o cabecalho
		M->ZYA_CONTRA := ZYA->ZYA_CONTRA
		M->ZYA_DESCRI := ZYA->ZYA_DESCRI
		M->ZYA_NBANCO := ZYA->ZYA_NBANCO
		M->ZYA_CBANCO := ZYA->ZYA_CBANCO
		M->ZYA_VALOR := ZYA->ZYA_VALOR
		M->ZYA_TJUROS := ZYA->ZYA_TJUROS
		M->ZYA_NPARCE := ZYA->ZYA_NPARCE
		M->ZYA_DTINI := ZYA->ZYA_DTINI
		M->ZYA_DIAPAR := ZYA->ZYA_DIAPAR
		M->ZYA_CCVLP := ZYA->ZYA_CCVLP
		M->ZYA_CCJLP := ZYA->ZYA_CCJLP
		M->ZYA_CCVCP := ZYA->ZYA_CCVCP
		M->ZYA_CCJCP := ZYA->ZYA_CCJCP
		M->ZYA_LA := ZYA->ZYA_LA
		M->ZYA_TIPO := ZYA->ZYA_TIPO
		M->ZYA_CFORNE := ZYA->ZYA_CFORNE
	ENDIF
Else
	M->ZYA_TIPO := cOpcaoTipo
endif

if cOpcaoTipo <> "D"
	aAdd(aC,{"M->ZYA_CONTRA"  ,{20,10 },"Contrato"         ,"@E 999999999"         ,"ExistChav('ZYA')",     ,.T.})
	aAdd(aC,{"M->ZYA_DESCRI"  ,{20,130},"Descricao"        ,"@!"                   ,           ,     ,.T.})
	aAdd(aC,{"M->ZYA_TIPO"    ,{20,450},"Tipo"             ,"@!"                   , "Pertence('EFD')",  ,.T.})
	aAdd(aC,{"M->ZYA_NBANCO"  ,{35,10},"Banco"       	  ,"@!"                   ,           ,      ,.T.})
	aAdd(aC,{"M->ZYA_CBANCO"  ,{35,330},"Conta Banco"     ,"@!"                    ,"vazio().or. Ctb105Cta()","CT1",.T.})
	aAdd(aC,{"M->ZYA_VALOR"   ,{50,10},"Valor"     	     ,"@E 999,999,999,999.99" ,           ,      ,.T.})
	aAdd(aC,{"M->ZYA_TJUROS"  ,{50,130},"TotalJuros"       ,"@E 999,999,999,999.99",           ,     ,.T.})
	aAdd(aC,{"M->ZYA_NPARCE"  ,{50,260},"Num Parcelas"     ,"@E 999"               ,           ,     ,.T.})
	aAdd(aC,{"M->ZYA_DTINI"   ,{50,320},"Inicio"     	     ,                     ,           ,      ,.T.})
	aAdd(aC,{"M->ZYA_DIAPAR"  ,{50,400},"Dia parcela"       ,"@E 99"               ,           ,     ,.T.})
	aAdd(aC,{"M->ZYA_LA"      ,{50,500},"Contab."           ,"@!"                  ,           ,     ,.F.})
	aAdd(aC,{"M->ZYA_CCVCP"   ,{65,10},"Conta V CP"         ,                      ,"vazio().or. Ctb105Cta()","CT1",.T.})
	aAdd(aC,{"M->ZYA_CCJCP"   ,{65,200},"Conta J CP"        ,                      ,"vazio().or. Ctb105Cta()","CT1",.T.})
	aAdd(aC,{"M->ZYA_CCVLP"   ,{80,10},"Conta V LP"         ,                      ,"vazio().or. Ctb105Cta()","CT1",.T.})
	aAdd(aC,{"M->ZYA_CCJLP"   ,{80,200},"Conta J LP"        ,                      ,"vazio().or. Ctb105Cta()","CT1",.T.})
Else
	aAdd(aC,{"M->ZYA_CONTRA"  ,{20,10 },"Contrato"         ,"@E 999999999"         ,"ExistChav('ZYA')",     ,.T.})
	aAdd(aC,{"M->ZYA_DESCRI"  ,{20,130},"Descricao"        ,"@!"                   ,           ,     ,.T.})
	aAdd(aC,{"M->ZYA_TIPO"    ,{20,450},"Tipo"             ,"@!"                   , "Pertence('EFD')",  ,.T.})
	aAdd(aC,{"M->ZYA_NBANCO"  ,{35,10},"Despesa"       	  ,"@!"                   ,           ,      ,.T.})
	aAdd(aC,{"M->ZYA_CBANCO"  ,{35,280},"Conta Despesa"     ,"@!"                    ,"vazio().or. Ctb105Cta()","CT1",.T.})
	aAdd(aC,{"M->ZYA_CFORNE"  ,{35,450},"Conta Fornecedor" ,"@!"                    ,"vazio().or. Ctb105Cta()","CT1",.T.})
	aAdd(aC,{"M->ZYA_VALOR"   ,{50,10},"Valor"     	     ,"@E 999,999,999,999.99" ,           ,      ,.T.})
	aAdd(aC,{"M->ZYA_TJUROS"  ,{50,130},"TotalJuros"       ,"@E 999,999,999,999.99",           ,     ,.T.})
	aAdd(aC,{"M->ZYA_NPARCE"  ,{50,260},"Num Parcelas"     ,"@E 999"               ,           ,     ,.T.})
	aAdd(aC,{"M->ZYA_DTINI"   ,{50,320},"Inicio"     	     ,                     ,           ,      ,.T.})
	aAdd(aC,{"M->ZYA_DIAPAR"  ,{50,400},"Dia parcela"       ,"@E 99"               ,           ,     ,.T.})
	aAdd(aC,{"M->ZYA_LA"      ,{50,500},"Contab."           ,"@!"                  ,           ,     ,.F.})
	aAdd(aC,{"M->ZYA_CCVCP"   ,{65,10},"Conta V CP"         ,                      ,"vazio().or. Ctb105Cta()","CT1",.T.})
	//aAdd(aC,{"M->ZYA_CCJCP"   ,{65,200},"Conta J CP"        ,                      ,"vazio().or. Ctb105Cta()","CT1",.T.})
	aAdd(aC,{"M->ZYA_CCVLP"   ,{80,10},"Conta V LP"         ,                      ,"vazio().or. Ctb105Cta()","CT1",.T.})
	//aAdd(aC,{"M->ZYA_CCJLP"   ,{80,200},"Conta J LP"        ,                      ,"vazio().or. Ctb105Cta()","CT1",.T.})
Endif

/*aAdd(aC,{"cInsNF"			,{20,360},"Incluir NF?"      ,"@!"    ,"u_Pft247Ins(cInsNF)"   ,     ,.T.})
aAdd(aC,{"cDelNF"			,{20,420},"Deletar NF?"      ,"@!"    ,"u_Pft247Exc(cDelNF)"   ,     ,.T.})
*/
aCGD := {160,5,108,280}

/*aAdd(aR,{"nVlTot" ,{68,10 },"Total Custo","@E 999,999,999.99",,,.F.})
aAdd(aR,{"cObs"   ,{68,120},"Observa็๕es","@!"               ,,,.T.})
aAdd(aR,{"nVLVend",{83,10 },"Total Venda","@E 999,999,999.99",,,.F.})
                                                                     */
cLinOk := "u_PFin030LinOK()"
cAllOk := "u_PFin030AllOK()"

cTitulo := cT

aButtons := {{"BMPTRG",{|| U_GCOLSP30()},"Distribuir..."}}
	//{"BMPCALEN", {|| MsgInfo("Duvidas?")}, "Duvidas?"}}
	
	
/*
Modelo2(cTitulo, aCabec, aRodape, aGD, nOp, cLineOk, cAllOk, aGetsGD, bF4, cIniCpos, nMax, aCordW, lDelGetD, lMaximized, aButtons)
Parโmetros
cTํtulo:     Tํtulo da janela
aCabec:     Array com os campos do cabe็alho
aRodap้:     Array com os campos do rodap้
aGd:     Array com as posi็๕es para edi็ใo dos itens (GETDADOS)
nOp:     Modo de opera็ใo (3 ou 4 altera e inclui itens, 6 altera mas nใo inclui itens, qualquer outro n๚mero s๓ visualiza os itens)
cLineOk:     Fun็ใo para valida็ใo da linha
cAllOk:     Fun็ใo para valida็ใo de todos os dados (na confirma็ใo)
aGetsGD:     Array Gets editแveis (GetDados). (Default: Todos)
bF4:     Codeblock a ser atribuํdo a tecla F4. (Default: Nenhum)
cIniCpos:     String com o nome dos campos que devem ser inicializados ao teclar seta para baixo (GetDados).
nMax:     Limita o n๚mero de linhas (GetDados). (Default: 99)
aCordW:     Array com quatro elementos num้ricos, correspondendo เs coordenadas linha superior, coluna esquerda, linha interior e coluna direita, definindo a แrea de tela a ser usada. (Default: มrea de dados livre)
lDelGetD:     Determina se as linhas podem ser deletadas ou nใo (GetDados) (Default: .T.)
lMaximized:     Indica se a janela serแ maximizada.
aButtons:     Array com os bot๕es a serem adicionados เ EnchoiceBar.
*/
lRet := Modelo2(cTitulo,aC,aR,aCGD,4,cLinOK,cAllOk,,,cIniCpos,nMax,{01,01,550,950},.T., .T.,aButtons)

if lRet
	If xtipo="A" .or. xtipo="I" 
		if MsgYesNo("Confirma os Dados Digitados?",cTitulo)
				dbselectarea("ZYA")
				dbsetOrder(1)
				IF DBSeek(xfilial("ZYA")+M->ZYA_CONTRA) //gravar o cabecalho
					reclock("ZYA",.f.)//update
						ZYA->ZYA_CONTRA := M->ZYA_CONTRA
						ZYA->ZYA_DESCRI := M->ZYA_DESCRI
						ZYA->ZYA_NBANCO := M->ZYA_NBANCO
						ZYA->ZYA_CBANCO := M->ZYA_CBANCO
						ZYA->ZYA_VALOR := M->ZYA_VALOR
						ZYA->ZYA_TJUROS := M->ZYA_TJUROS
						ZYA->ZYA_NPARCE := M->ZYA_NPARCE
						ZYA->ZYA_DTINI := M->ZYA_DTINI
						ZYA->ZYA_DIAPAR := M->ZYA_DIAPAR
						ZYA->ZYA_CCVLP := M->ZYA_CCVLP
						ZYA->ZYA_CCJLP := M->ZYA_CCJLP
						ZYA->ZYA_CCVCP := M->ZYA_CCVCP
						ZYA->ZYA_CCJCP := M->ZYA_CCJCP
						ZYA->ZYA_TIPO := M->ZYA_TIPO
						ZYA->ZYA_CFORNE := M->ZYA_CFORNE
					msunlock()
					
					//gravar os itens
					_posCONTRA := GDFieldPos("ZYB_CONTRA")
					_posPARCEL := GDFieldPos("ZYB_PARCEL")
					_posVENCTO := GDFieldPos("ZYB_VENCTO")
					_posFATURA := GDFieldPos("ZYB_FATURA")
					_posJUROS := GDFieldPos("ZYB_JUROS")
					_posAMORT := GDFieldPos("ZYB_AMORT")
					_posSALDO := GDFieldPos("ZYB_SALDO")
					For nLin := 1 to Len(aCols)
						dbselectarea("ZYB")
						dbsetOrder(1)
						IF DBSeek(xfilial("ZYB")+M->ZYA_CONTRA+Transform(nLin,"@E 99"))
							if !aCols[nLin][Len(aHeader)+1] //se .T. campo estแ deletado
									reclock("ZYB",.f.)//update
										ZYB->ZYB_CONTRA := aCols[nLin][_posCONTRA]
										ZYB->ZYB_PARCEL := aCols[nLin][_posPARCEL]
										ZYB->ZYB_VENCTO := aCols[nLin][_posVENCTO]
										ZYB->ZYB_FATURA := aCols[nLin][_posFATURA]
										ZYB->ZYB_JUROS := aCols[nLin][_posJUROS]
										ZYB->ZYB_AMORT := aCols[nLin][_posAMORT]
										ZYB->ZYB_SALDO := aCols[nLin][_posSALDO]
									msunlock()
							else //deletar
								reclock("ZYB",.f.)//delete
									dbdelete()
								msunlock()
							endif
						ELSE
							reclock("ZYB",.T.)//insert
								ZYB->ZYB_FILIAL :=XFILIAL("ZYB")
								ZYB->ZYB_CONTRA := aCols[nLin][_posCONTRA]
								ZYB->ZYB_PARCEL := aCols[nLin][_posPARCEL]
								ZYB->ZYB_VENCTO := aCols[nLin][_posVENCTO]
								ZYB->ZYB_FATURA := aCols[nLin][_posFATURA]
								ZYB->ZYB_JUROS := aCols[nLin][_posJUROS]
								ZYB->ZYB_AMORT := aCols[nLin][_posAMORT]
								ZYB->ZYB_SALDO := aCols[nLin][_posSALDO]
							msunlock()
						ENDIF
					Next
				ELSE //nao encontrado ZYA
					reclock("ZYA",.T.)//cabecalho
						ZYA->ZYA_FILIAL :=XFILIAL("ZYA")
						ZYA->ZYA_CONTRA := M->ZYA_CONTRA
						ZYA->ZYA_DESCRI := M->ZYA_DESCRI
						ZYA->ZYA_NBANCO := M->ZYA_NBANCO
						ZYA->ZYA_CBANCO := M->ZYA_CBANCO
						ZYA->ZYA_VALOR := M->ZYA_VALOR
						ZYA->ZYA_TJUROS := M->ZYA_TJUROS
						ZYA->ZYA_NPARCE := M->ZYA_NPARCE
						ZYA->ZYA_DTINI := M->ZYA_DTINI
						ZYA->ZYA_DIAPAR := M->ZYA_DIAPAR
						ZYA->ZYA_CCVLP := M->ZYA_CCVLP
						ZYA->ZYA_CCJLP := M->ZYA_CCJLP
						ZYA->ZYA_CCVCP := M->ZYA_CCVCP
						ZYA->ZYA_CCJCP := M->ZYA_CCJCP
						ZYA->ZYA_TIPO := M->ZYA_TIPO
						ZYA->ZYA_CFORNE := M->ZYA_CFORNE
					msunlock()
					//itens
					_posCONTRA := GDFieldPos("ZYB_CONTRA")
					_posPARCEL := GDFieldPos("ZYB_PARCEL")
					_posVENCTO := GDFieldPos("ZYB_VENCTO")
					_posFATURA := GDFieldPos("ZYB_FATURA")
					_posJUROS := GDFieldPos("ZYB_JUROS")
					_posAMORT := GDFieldPos("ZYB_AMORT")
					_posSALDO := GDFieldPos("ZYB_SALDO")
					For nLin := 1 to Len(aCols)
						if !aCols[nLin][Len(aHeader)+1] //se .T. campo estแ deletado
							dbselectarea("ZYB")
							dbsetOrder(1)
							IF DBSeek(xfilial("ZYB")+M->ZYA_CONTRA+Transform(nLin,"@E 99"))
								reclock("ZYB",.f.)//update
									ZYB->ZYB_CONTRA := aCols[nLin][_posCONTRA]
									ZYB->ZYB_PARCEL := aCols[nLin][_posPARCEL]
									ZYB->ZYB_VENCTO := aCols[nLin][_posVENCTO]
									ZYB->ZYB_FATURA := aCols[nLin][_posFATURA]
									ZYB->ZYB_JUROS := aCols[nLin][_posJUROS]
									ZYB->ZYB_AMORT := aCols[nLin][_posAMORT]
									ZYB->ZYB_SALDO := aCols[nLin][_posSALDO]
								msunlock()
							ELSE
								reclock("ZYB",.T.)//insert
									ZYB->ZYB_FILIAL :=XFILIAL("ZYB")
									ZYB->ZYB_CONTRA := aCols[nLin][_posCONTRA]
									ZYB->ZYB_PARCEL := aCols[nLin][_posPARCEL]
									ZYB->ZYB_VENCTO := aCols[nLin][_posVENCTO]
									ZYB->ZYB_FATURA := aCols[nLin][_posFATURA]
									ZYB->ZYB_JUROS := aCols[nLin][_posJUROS]
									ZYB->ZYB_AMORT := aCols[nLin][_posAMORT]
									ZYB->ZYB_SALDO := aCols[nLin][_posSALDO]
								msunlock()
							ENDIF
						endif
					Next
				ENDIF
		EndIf
	Elseif xtipo =="D" //deletar
		For nLin := 1 to Len(aCols) //deletar itens
			dbselectarea("ZYB")
			dbsetOrder(1)
			IF DBSeek(xfilial("ZYB")+M->ZYA_CONTRA+Transform(nLin,"@E 99"))
				reclock("ZYB",.f.)//delete
					dbdelete()
				msunlock()
			ENDIF
		Next
		dbselectarea("ZYA")
		dbsetOrder(1)
		IF DBSeek(xfilial("ZYA")+M->ZYA_CONTRA) //gravar o cabecalho
			reclock("ZYA",.f.)//update
				dbdelete()
			msunlock()
		ENDIF
	ElseIF xtipo=="C" //contabilizar
		dbselectarea("ZYA")
		dbsetOrder(1)
		IF DBSeek(xfilial("ZYA")+M->ZYA_CONTRA)
			if ZYA->ZYA_LA <> "S"
				Processa({|| Pfin030CTB(xcontrato)},"Aguarde a contabiliza็ใo...")
			else
				MsgAlert("Contrato jแ contabilizado! Se necessแrio efetue o estorno para habilitar a contabiliza็ใo")
			endif
		ENDIF
	EndIF	
else
	rollbackSX8()
endif

return nil


//Contabilizacao
Static FUNCTION Pfin030CTB()
Local nAno := 2004
Local nCalendario := 0
Local nMes := 0
Local cMoeda := "01"
Local cContrato := ""
Local nParcela := 0
Local dVencto := ddatabase
Local nFatura := 0
Local nJuros := 0
Local nAmort := 0
Local nSaldo := 0
Local _lOk := .T. 
Local aCab := {} 
Local aItens := {}                       
Local nValor := 0
Local bCtbLP := .F.
Local nLPJuros := 0
Local nLPFaturas := 0
Local nLPParcelas := 0
Local nCtbLin := 1
Private lMsErroAuto := .F.

ProcRegua((M->ZYA_NPARCE +1)) 
IF M->ZYA_TIPO <>"D" //Emprestimo e Financiamento: contabilizacoes iguais

	//contabilizar provisao inicial DO BANCO E LP CP
	cQuery := "SELECT ZYB_CONTRA, SUM(ZYB_FATURA) AS FATURAS, SUM(ZYB_JUROS) AS JUROS, COUNT(ZYB_PARCEL) AS PARCELAS"
	cQuery += " FROM  "+ RetSqlName("ZYB") +" ZYB" 
	cQuery += " WHERE ZYB_FILIAL='"+ xFilial("ZYB") +"' and ZYB_CONTRA='"+ M->ZYA_CONTRA +"' AND ZYB_VENCTO>='"+ DTOS(MonthSum(aCols[1][GDFieldPos("ZYB_VENCTO")], 12)) +"' AND ZYB.D_E_L_E_T_<>'*'" //era M->ZYA_DTINI
	cQuery += " GROUP BY ZYB_CONTRA"
	MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PFIN030", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
	DBSelectArea("PFIN030")
	DBGotop()
	IF !EOF()
		bCtbLP := .T.
		nLPJuros := PFIN030->JUROS
		nLPFaturas := PFIN030->FATURAS
		nLPParcelas := PFIN030->PARCELAS
	ELSE
		bCtbLP := .F.
		nLPJuros := 0
		nLPFaturas := 0
		nLPParcelas := 0
	ENDIF
	DBSelectArea("PFIN030")
	DBCloseArea()
	
	IncProc("Provisใo")
	_lOk := .T. 
	aCab := {} 
	aItens := {}                       
	lMsErroAuto := .F. 

	aCab   := {{"DDATALANC"     ,M->ZYA_DTINI,NIL},; 
             	{"CLOTE"      ,"177777"     ,NIL},; 
             	{"CSUBLOTE"      ,"001"           ,NIL},; 
	     		{"CDOC"      , strzero(seconds(),6)     ,NIL},; 
    	       {"CPADRAO"     ,""               ,NIL},; 
              {"NTOTINF"     ,0               ,NIL},; 
				{"NTOTINFLOT"     ,0               ,NIL}} 
	//PROVISAO banco
	aAdd(aItens,{{"CT2_FILIAL",xfilial("CT2"), NIL},; 
                {"CT2_LINHA"      ,strzero(nCtbLin,3), NIL},; 
                {"CT2_MOEDLC"      ,"01"             , NIL},; 
                {"CT2_DC"        ,"1"                  , NIL},; 
                {"CT2_DEBITO"      ,M->ZYA_CBANCO, NIL},; 
                {"CT2_CREDIT"      ,"", NIL},; 
                {"CT2_VALOR"      ,(M->ZYA_VALOR - M->ZYA_TJUROS), NIL},; 
                {"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-U_PFIN030/004" , NIL},; 
                {"CT2_HIST"        ,"VALOR BANCO CONTRATO "+ALLTRIM(M->ZYA_CONTRA), NIL},;
                {"CT2_CCD"        ,"001", NIL},;
                {"CT2_CCC"        ,"001", NIL}})
	//provisao juros CP
	nCtbLin := nCtbLin + 1  
    aAdd(aItens,{{"CT2_FILIAL",xfilial("CT2"), NIL},; 
                {"CT2_LINHA"      ,strzero(nCtbLin,3), NIL},; 
                {"CT2_MOEDLC"      ,"01"             , NIL},; 
                {"CT2_DC"        ,"1"                  , NIL},; 
                {"CT2_DEBITO"      ,M->ZYA_CCJCP, NIL},; 
                {"CT2_CREDIT"      ,"", NIL},; 
                {"CT2_VALOR"      ,(M->ZYA_TJUROS - nLPJuros), NIL},; 
                {"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-U_PFIN030/005" , NIL},; 
                {"CT2_HIST"        ,"JUROS CP CONTRATO "+ALLTRIM(M->ZYA_CONTRA), NIL},;
                {"CT2_CCD"        ,"001", NIL},;
                {"CT2_CCC"        ,"001", NIL}})
    //provisao juros LP
    if bCtbLP
    	nCtbLin := nCtbLin + 1
    	aAdd(aItens,{{"CT2_FILIAL",xfilial("CT2"), NIL},; 
                {"CT2_LINHA"      ,strzero(nCtbLin,3), NIL},; 
                {"CT2_MOEDLC"      ,"01"             , NIL},; 
                {"CT2_DC"        ,"1"                  , NIL},; 
                {"CT2_DEBITO"      ,M->ZYA_CCJLP, NIL},; 
                {"CT2_CREDIT"      ,"", NIL},; 
                {"CT2_VALOR"      ,nLPJuros, NIL},; 
                {"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-U_PFIN030/006" , NIL},; 
                {"CT2_HIST"        ,"JUROS LP CONTRATO "+ALLTRIM(M->ZYA_CONTRA), NIL},;
                {"CT2_CCD"        ,"001", NIL},;
                {"CT2_CCC"        ,"001", NIL}})
		endif
	nCtbLin := nCtbLin + 1
	//provisao fatura CP
	aAdd(aItens,{{"CT2_FILIAL",xfilial("CT2"), NIL},; 
                {"CT2_LINHA"      ,strzero(nCtbLin,3), NIL},; 
                {"CT2_MOEDLC"      ,"01"             , NIL},; 
                {"CT2_DC"        ,"2"                  , NIL},; 
                {"CT2_DEBITO"      ,"", NIL},; 
                {"CT2_CREDIT"      ,M->ZYA_CCVCP, NIL},; 
                {"CT2_VALOR"      ,(M->ZYA_VALOR - nLPFaturas), NIL},; 
                {"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-U_PFIN030/007" , NIL},; 
                {"CT2_HIST"        ,"VALOR CP CONTRATO "+ALLTRIM(M->ZYA_CONTRA), NIL},;
                {"CT2_CCD"        ,"001", NIL},;
                {"CT2_CCC"        ,"001", NIL}})
    //provisao fatura LP
    if bCtbLP
    	nCtbLin := nCtbLin + 1
    	aAdd(aItens,{{"CT2_FILIAL",xfilial("CT2"), NIL},; 
                {"CT2_LINHA"      ,strzero(nCtbLin,3), NIL},; 
                {"CT2_MOEDLC"      ,"01"             , NIL},; 
                {"CT2_DC"        ,"2"                  , NIL},; 
                {"CT2_DEBITO"      ,"", NIL},; 
                {"CT2_CREDIT"      ,M->ZYA_CCVLP, NIL},; 
                {"CT2_VALOR"      ,nLPFaturas, NIL},; 
                {"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-U_PFIN030/008" , NIL},; 
                {"CT2_HIST"        ,"VALOR LP CONTRATO "+ALLTRIM(M->ZYA_CONTRA), NIL},;
                {"CT2_CCD"        ,"001", NIL},;
                {"CT2_CCC"        ,"001", NIL}})
	endif
	
    MSExecAuto( {|X,Y,Z| CTBA102(X,Y,Z)} ,aCab ,aItens, 3) 
	If lMsErroAuto
		MOSTRAERRO()
	EndIf


	For nLin := 1 to Len(aCols)
		if !aCols[nLin][Len(aHeader)+1] //se .T. campo estแ deletado
			_posCONTRA := GDFieldPos("ZYB_CONTRA")
			_posPARCEL := GDFieldPos("ZYB_PARCEL")
			_posVENCTO := GDFieldPos("ZYB_VENCTO")
			_posFATURA := GDFieldPos("ZYB_FATURA")
			_posJUROS := GDFieldPos("ZYB_JUROS")
			_posAMORT := GDFieldPos("ZYB_AMORT")
			_posSALDO := GDFieldPos("ZYB_SALDO")
			cContrato := aCols[nLin][_posCONTRA]
			nParcela := aCols[nLin][_posPARCEL]
			dVencto := aCols[nLin][_posVENCTO]
			nFatura := aCols[nLin][_posFATURA]
			nJuros := aCols[nLin][_posJUROS]
			nAmort := aCols[nLin][_posAMORT]
			nSaldo := aCols[nLin][_posSALDO]
		
			IncProc("Parcela "+strzero(nParcela,2)+"/"+STRZERO(M->ZYA_NPARCE,2))
		
			//verificar se existe calendแrio CTG, se esta aberto
			nCalendario := Year(dVencto) - nAno
			DBSelectArea("CTG")
			DBSetOrder(1) //CTG_FILIAL+CTG_CALEND+CTG_EXERC+CTG_PERIOD
			IF !DBSeek(xfilial("CTG")+strzero(nCalendario,3)+strzero(Year(dVencto),4)+strzero(Month(dVencto),2))
				reclock("CTG",.T.)//insert
	 				CTG_FILIAL := xFilial("CTG")
					CTG_CALEND := strzero(nCalendario,3)
					CTG_EXERC := strzero(Year(dVencto),4)
					CTG_PERIOD := strzero(Month(dVencto),2)
					CTG_DTINI := FirstDate(dVencto)
					CTG_DTFIM := LastDate(dVencto)
					CTG_STATUS:= "1"
				msunlock()
			ENDIF
				
			//verificar se existe moeda vs calenadแrio CTE
			DBSelectArea("CTE")
			DBSetOrder(1) //CTE_FILIAL+CTE_MOEDA+CTE_CALEND
			IF !DBSeek(xfilial("CTE")+cMoeda+strzero(nCalendario,3))
				reclock("CTE",.T.)//insert
	 				CTE_FILIAL := XFILIAL("CTE")
					CTE_MOEDA := "01"
					CTE_CALEND := strzero(nCalendario,3)
				msunlock()	
			ENDIF
		
			//fazer os lancamentos contแbeis
			_lOk := .T. 
			aCab := {} 
			aItens := {}                       
			//nValor := SEF->EF_VALOR??             
			lMsErroAuto := .F. 
			nCtbLin := 1

			aCab   := {{"DDATALANC"     ,dVencto     ,NIL},; 
              	{"CLOTE"      ,"177777"     ,NIL},; 
              	{"CSUBLOTE"   ,"001"           ,NIL},; 
	              {"CDOC"       ,strzero(seconds()+nLin,6)     ,NIL},; 
    		       {"CPADRAO"     ,""               ,NIL},; 
       	       {"NTOTINF"     ,0               ,NIL},; 
           	    {"NTOTINFLOT"     ,0               ,NIL}}
          //baixar CP Juros Despesa
      		nCtbLin := nCtbLin + 1
   	   		aAdd(aItens,{{"CT2_FILIAL",xfilial("CT2"), NIL},; 
                {"CT2_LINHA"      ,strzero(nCtbLin,3), NIL},; 
                {"CT2_MOEDLC"      ,"01"             , NIL},; 
                {"CT2_DC"        ,"3"                  , NIL},; 
                {"CT2_DEBITO"      ,"42010211001", NIL},; 
                {"CT2_CREDIT"      ,M->ZYA_CCJCP     , NIL},; 
                {"CT2_VALOR"      ,nJuros           , NIL},; 
                {"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-U_PFIN030/001" , NIL},; 
                {"CT2_HIST"        ,"JUROS CONTR N."+ALLTRIM(cContrato)+"/PARC."+strzero(nParcela,2)+"/"+STRZERO(M->ZYA_NPARCE,2), NIL},;
                {"CT2_CCD"        ,"001", NIL},;
                {"CT2_CCC"        ,"001", NIL}})
          if bCtbLP .and. nLin <= nLPParcelas
				//mover LP p CP Valor
				nCtbLin := nCtbLin + 1
				aAdd(aItens,{{"CT2_FILIAL",xfilial("CT2"), NIL},; 
              	{"CT2_LINHA"      ,strzero(nCtbLin,3), NIL},; 
              	{"CT2_MOEDLC"      ,"01"             , NIL},; 
              	{"CT2_DC"        ,"3"                  , NIL},; 
              	{"CT2_DEBITO"      ,M->ZYA_CCVLP, NIL},; 
              	{"CT2_CREDIT"      ,M->ZYA_CCVCP, NIL},; 
              	{"CT2_VALOR"      ,iif(nLin+12<= len(aCols),aCols[nLin+12][_posFATURA],nFatura), NIL},; 
              	{"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-U_PFIN030/002" , NIL},; 
              	{"CT2_HIST"        ,"BXA LP/CP CONTR N."+ALLTRIM(cContrato), NIL},;
                	{"CT2_CCD"        ,"001", NIL},;
                	{"CT2_CCC"        ,"001", NIL}})
    		   //mover LP p CP Juros
   		   		nCtbLin := nCtbLin + 1          
      			aAdd(aItens,{{"CT2_FILIAL",xfilial("CT2"), NIL},; 
	              	{"CT2_LINHA"      ,strzero(nCtbLin,3), NIL},; 
    	      	    	{"CT2_MOEDLC"      ,"01"             , NIL},; 
       	       	{"CT2_DC"        ,"3"                  , NIL},; 
              		{"CT2_DEBITO"      ,M->ZYA_CCJCP, NIL},; 
              		{"CT2_CREDIT"      ,M->ZYA_CCJLP, NIL},; 
              		{"CT2_VALOR"      ,iif(nLin+12<= len(aCols),aCols[nLin+12][_posJUROS],nJuros), NIL},; 
              		{"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-U_PFIN030/003" , NIL},; 
              		{"CT2_HIST"        ,"BXA LP/CP CONTR N."+ALLTRIM(cContrato), NIL},;
                		{"CT2_CCD"        ,"001", NIL},;
                		{"CT2_CCC"        ,"001", NIL}})
             endif
			
			MSExecAuto( {|X,Y,Z| CTBA102(X,Y,Z)} ,aCab ,aItens, 3) 
			If lMsErroAuto
				MOSTRAERRO()
			EndIf
		EndIf
	Next

ELSE //Diferimento //*****************************************************************************
//************************************************************************************************
	//contabilizar provisao inicial DO BANCO E LP CP
	cQuery := "SELECT ZYB_CONTRA, SUM(ZYB_FATURA) AS FATURAS, SUM(ZYB_JUROS) AS JUROS, COUNT(ZYB_PARCEL) AS PARCELAS"
	cQuery += " FROM  "+ RetSqlName("ZYB") +" ZYB" 
	cQuery += " WHERE ZYB_FILIAL='"+ xFilial("ZYB") +"' and ZYB_CONTRA='"+ M->ZYA_CONTRA +"' AND ZYB_VENCTO>='"+ DTOS(MonthSum(aCols[1][GDFieldPos("ZYB_VENCTO")], 12)) +"' AND ZYB.D_E_L_E_T_<>'*'" //era M->ZYA_DTINI
	cQuery += " GROUP BY ZYB_CONTRA"
	MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PFIN030", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
	DBSelectArea("PFIN030")
	DBGotop()
	IF !EOF()
		bCtbLP := .T.
		nLPJuros := PFIN030->JUROS
		nLPFaturas := PFIN030->FATURAS
		nLPParcelas := PFIN030->PARCELAS
	ELSE
		bCtbLP := .F.
		nLPJuros := 0
		nLPFaturas := 0
		nLPParcelas := 0
	ENDIF
	DBSelectArea("PFIN030")
	DBCloseArea()
	
	IncProc("Provisใo")
	
	_lOk := .T. 
	aCab := {} 
	aItens := {}                       
	lMsErroAuto := .F. 
	nCtbLin := 1

	aCab   := {{"DDATALANC"     ,M->ZYA_DTINI,NIL},; 
             	{"CLOTE"      ,"177777"     ,NIL},; 
             	{"CSUBLOTE"      ,"001"           ,NIL},; 
	     		{"CDOC"      , strzero(seconds(),6)     ,NIL},; 
    	       {"CPADRAO"     ,""               ,NIL},; 
              {"NTOTINF"     ,0               ,NIL},; 
				{"NTOTINFLOT"     ,0               ,NIL}}
	//provisao fatura CP
	aAdd(aItens,{{"CT2_FILIAL",xfilial("CT2"), NIL},; 
                {"CT2_LINHA"      ,strzero(nCtbLin,3), NIL},; 
                {"CT2_MOEDLC"      ,"01"             , NIL},; 
                {"CT2_DC"        ,"1"                  , NIL},; 
                {"CT2_DEBITO"      ,M->ZYA_CCVCP, NIL},; 
                {"CT2_CREDIT"      ,"", NIL},; 
                {"CT2_VALOR"      ,(M->ZYA_VALOR - nLPFaturas), NIL},; 
                {"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-U_PFIN030/011" , NIL},; 
                {"CT2_HIST"        ,ALLTRIM(ZYA->ZYA_DESCRI)+"/DIF CP N."+ALLTRIM(M->ZYA_CONTRA), NIL},;
                {"CT2_CCD"        ,"001", NIL},;
                {"CT2_CCC"        ,"001", NIL}})
    //provisao fatura LP
    if bCtbLP
    	nCtbLin := nCtbLin + 1
    	aAdd(aItens,{{"CT2_FILIAL",xfilial("CT2"), NIL},; 
                {"CT2_LINHA"      ,strzero(nCtbLin,3), NIL},; 
                {"CT2_MOEDLC"      ,"01"             , NIL},; 
                {"CT2_DC"        ,"1"                  , NIL},; 
                {"CT2_DEBITO"      ,M->ZYA_CCVLP, NIL},; 
                {"CT2_CREDIT"      ,"", NIL},; 
                {"CT2_VALOR"      ,nLPFaturas, NIL},; 
                {"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-U_PFIN030/012" , NIL},; 
                {"CT2_HIST"        ,ALLTRIM(ZYA->ZYA_DESCRI)+"/DIF LP N."+ALLTRIM(M->ZYA_CONTRA), NIL},;
                {"CT2_CCD"        ,"001", NIL},;
                {"CT2_CCC"        ,"001", NIL}})
	endif 
	//PROVISAO Despesa Fornecedor
	nCtbLin := nCtbLin + 1
	aAdd(aItens,{{"CT2_FILIAL",xfilial("CT2"), NIL},; 
                {"CT2_LINHA"      ,strzero(nCtbLin,3), NIL},; 
                {"CT2_MOEDLC"      ,"01"             , NIL},; 
                {"CT2_DC"        ,"2"                  , NIL},; 
                {"CT2_DEBITO"      ,"", NIL},; 
                {"CT2_CREDIT"      ,M->ZYA_CFORNE, NIL},; 
                {"CT2_VALOR"      ,(M->ZYA_VALOR), NIL},; 
                {"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-U_PFIN030/013" , NIL},; 
                {"CT2_HIST"        ,ALLTRIM(ZYA->ZYA_DESCRI)+"/DIF N."+ALLTRIM(M->ZYA_CONTRA), NIL},;
                {"CT2_CCD"        ,"001", NIL},;
                {"CT2_CCC"        ,"001", NIL}})
	
	
    MSExecAuto( {|X,Y,Z| CTBA102(X,Y,Z)} ,aCab ,aItens, 3) 
	If lMsErroAuto
		MOSTRAERRO()
	EndIf
	
	
	
	For nLin := 1 to Len(aCols)
		if !aCols[nLin][Len(aHeader)+1] //se .T. campo estแ deletado
			_posCONTRA := GDFieldPos("ZYB_CONTRA")
			_posPARCEL := GDFieldPos("ZYB_PARCEL")
			_posVENCTO := GDFieldPos("ZYB_VENCTO")
			_posFATURA := GDFieldPos("ZYB_FATURA")
			_posJUROS := GDFieldPos("ZYB_JUROS")
			_posAMORT := GDFieldPos("ZYB_AMORT")
			_posSALDO := GDFieldPos("ZYB_SALDO")
			cContrato := aCols[nLin][_posCONTRA]
			nParcela := aCols[nLin][_posPARCEL]
			dVencto := aCols[nLin][_posVENCTO]
			nFatura := aCols[nLin][_posFATURA]
			nJuros := aCols[nLin][_posJUROS]
			nAmort := aCols[nLin][_posAMORT]
			nSaldo := aCols[nLin][_posSALDO]
			
			IncProc("Parcela "+strzero(nParcela,2)+"/"+STRZERO(M->ZYA_NPARCE,2))
		
			//verificar se existe calendแrio CTG, se esta aberto
			nCalendario := Year(dVencto) - nAno
			DBSelectArea("CTG")
			DBSetOrder(1) //CTG_FILIAL+CTG_CALEND+CTG_EXERC+CTG_PERIOD
			IF !DBSeek(xfilial("CTG")+strzero(nCalendario,3)+strzero(Year(dVencto),4)+strzero(Month(dVencto),2))
				reclock("CTG",.T.)//insert
	 				CTG_FILIAL := xFilial("CTG")
					CTG_CALEND := strzero(nCalendario,3)
					CTG_EXERC := strzero(Year(dVencto),4)
					CTG_PERIOD := strzero(Month(dVencto),2)
					CTG_DTINI := FirstDate(dVencto)
					CTG_DTFIM := LastDate(dVencto)
					CTG_STATUS:= "1"
				msunlock()
			ENDIF
				
			//verificar se existe moeda vs calenadแrio CTE
			DBSelectArea("CTE")
			DBSetOrder(1) //CTE_FILIAL+CTE_MOEDA+CTE_CALEND
			IF !DBSeek(xfilial("CTE")+cMoeda+strzero(nCalendario,3))
				reclock("CTE",.T.)//insert
	 				CTE_FILIAL := XFILIAL("CTE")
					CTE_MOEDA := "01"
					CTE_CALEND := strzero(nCalendario,3)
				msunlock()	
			ENDIF
		
			//fazer os lancamentos contแbeis
			_lOk := .T. 
			aCab := {} 
			aItens := {}                       
			lMsErroAuto := .F. 
			nCtbLin := 1

			aCab   := {{"DDATALANC"     ,dVencto     ,NIL},; 
              	{"CLOTE"      ,"177777"     ,NIL},; 
              	{"CSUBLOTE"   ,"001"           ,NIL},; 
	              {"CDOC"       ,strzero(seconds()+nLin,6)     ,NIL},; 
    		       {"CPADRAO"     ,""               ,NIL},; 
       	       {"NTOTINF"     ,0               ,NIL},; 
           	    {"NTOTINFLOT"     ,0               ,NIL}}
          //baixar CP Valor Despesa
      		nCtbLin := nCtbLin + 1
   	   		aAdd(aItens,{{"CT2_FILIAL",xfilial("CT2"), NIL},; 
                {"CT2_LINHA"      ,strzero(nCtbLin,3), NIL},; 
                {"CT2_MOEDLC"      ,"01"             , NIL},; 
                {"CT2_DC"        ,"3"                  , NIL},; 
                {"CT2_DEBITO"      ,M->ZYA_CBANCO, NIL},; 
                {"CT2_CREDIT"      ,M->ZYA_CCVCP     , NIL},; 
                {"CT2_VALOR"      ,nFatura           , NIL},; 
                {"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-U_PFIN030/009" , NIL},; 
                {"CT2_HIST"        ,"BXA DIFERIMENTO N."+ALLTRIM(cContrato)+"-"+strzero(nParcela,2)+"/"+STRZERO(M->ZYA_NPARCE,2), NIL},;
                {"CT2_CCD"        ,"001", NIL},;
                {"CT2_CCC"        ,"001", NIL}})
          if bCtbLP .and. nLin <= nLPParcelas  
         	//mover LP p CP Valor
				nCtbLin := nCtbLin + 1
				aAdd(aItens,{{"CT2_FILIAL",xfilial("CT2"), NIL},; 
              	{"CT2_LINHA"      ,strzero(nCtbLin,3), NIL},; 
              	{"CT2_MOEDLC"      ,"01"             , NIL},; 
              	{"CT2_DC"        ,"3"                  , NIL},; 
              	{"CT2_DEBITO"      ,M->ZYA_CCVCP, NIL},; 
              	{"CT2_CREDIT"      ,M->ZYA_CCVLP, NIL},; 
              	{"CT2_VALOR"      ,iif(nLin+12<= len(aCols),aCols[nLin+12][_posFATURA],nFatura), NIL},; 
              	{"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-U_PFIN030/010" , NIL},; 
              	{"CT2_HIST"        ,"BXA LP/CP DIFERIMENTO N."+ALLTRIM(cContrato), NIL},;
                	{"CT2_CCD"        ,"001", NIL},;
                	{"CT2_CCC"        ,"001", NIL}})
 			endif
			
			MSExecAuto( {|X,Y,Z| CTBA102(X,Y,Z)} ,aCab ,aItens, 3) 
			If lMsErroAuto
				MOSTRAERRO()
			EndIf
		EndIf
	Next

ENDIF


	If !Empty(cContrato)
		dbselectarea("ZYA")
		dbsetOrder(1)
		IF DBSeek(xfilial("ZYA")+M->ZYA_CONTRA) //gravar o cabecalho
			reclock("ZYA",.f.)//update
				ZYA->ZYA_LA := "S"
			msunlock()
		ENDIF
	EndIf

Return
                 




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPFAT030LinOK  บAutor  ณDanilo Pala         บ Data ณ  20130106บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PFin030LinOK()

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPFAT030LinOK  บAutor  ณDanilo Pala         บ Data ณ  20130106บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PFin030AllOK()
Local lRet := .T.
Local nSaldo := 0
Local nJuros := 0
Local cMsg := ""
	For nLin:=1 to Len(aCols)
		nSaldo += aCols[nLin][GDFieldPos("ZYB_FATURA")]
		nJuros += aCols[nLin][GDFieldPos("ZYB_JUROS")]
	Next
	if nSaldo <> M->ZYA_VALOR
		lRet := .F.
		cMsg := "Somat๓ria de valores das parcelas ("+ Transform(nSaldo,"@EZ 999,999,999.99") +")  ้ diferente do valor do contrato ("+ Transform(M->ZYA_VALOR,"@EZ 999,999,999.99") +")"
	elseif nJuros <> M->ZYA_TJUROS
		lRet := .F.
		cMsg := "Somat๓ria de juros das parcelas ("+ Transform(nJuros,"@EZ 999,999,999.99") +") ้ diferente do total de juros do contrato("+ Transform(M->ZYA_TJUROS,"@EZ 999,999,999.99") +")"
	endif	
	if !empty(cMsg)
		MsgAlert(cMsg)
	endif
Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGCOLSP30  บAutor  ณDanilo Pala         บ Data ณ  20121220ฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User FUNCTION GCOLSP30()
	SetPrvt("_NLINHA_DA_ACOLS,_MATRIZNEW,_NUMITEM, _NPARCELAS")
	SetPrvt("_posCONTRA,_posPARCEL,_posVENCTO,_posFATURA,_posJUROS,_posAMORT,_posSALDO, _qtdColsAntes, nSaldo, dDtAux")
	_lContinua       := .T.
	
	
	if EMPTY(M->ZYA_CONTRA) 
		_lContinua := .F.
			cMsg := "Informe o n๚mero contrato!"
	Elseif M->ZYA_NPARCE <=0
		_lContinua := .F.
		cMsg := "Informe o n๚mero da parcela!"
	Elseif M->ZYA_VALOR <=0
		_lContinua := .F.
		cMsg := "Informe o valor!"
	Elseif M->ZYA_TJUROS <=0
		IF M->ZYA_TIPO <>"D"
			_lContinua := .F.
			cMsg := "Informe o Juros!"
		ENDIF
	Elseif EMPTY(M->ZYA_DTINI)
		_lContinua := .F.
		cMsg := "Informe a data de inํcio!"
	endif
	
	if _lContinua
		_nParcelas := M->ZYA_NPARCE
		_posCONTRA := GDFieldPos("ZYB_CONTRA")
		_posPARCEL := GDFieldPos("ZYB_PARCEL")
		_posVENCTO := GDFieldPos("ZYB_VENCTO")
		_posFATURA := GDFieldPos("ZYB_FATURA")
		_posJUROS := GDFieldPos("ZYB_JUROS")
		_posAMORT := GDFieldPos("ZYB_AMORT")
		_posSALDO := GDFieldPos("ZYB_SALDO")
	 
		//aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="ZYB_PARCEL"})]   := _NumItem
		_qtdColsAntes := Len(aCols)
		nSaldo := 0
		For _n:=1 to _nParcelas
			if _n> _qtdColsAntes
				AADD(aCols,Array(Len(aHeader)+1)) // linha em branco no aCols
				N++ 
				//aCols[N-1][nPos2]:= &(__READVAR) 
				For nX := 1 To Len(aHeader) 
    				aCols[LEN(aCols)][nX] := CriaVar(aHeader[nX][2],.T.)
    				//parte nova 
    				/*cField		:= aHeader[ nX ][ 2 ]
					nFieldPos	:= GdFieldPos( cField )
					IF ( nFieldPos > 0 )
						uCnt := aCols[ _n ][ nX ]
						GdFieldPut( cField , uCnt )	
					EndIF*/
					//ate aqui parte nova 
				Next nX
			endif 
			nLin := _n //Len(aCols)                  // Nr. da linha que foi criada. 
	      	aCols[nLin][_posCONTRA]  := M->ZYA_CONTRA 
    	  	aCols[nLin][_posPARCEL]  := nLin
      		if M->ZYA_DIAPAR >0 
      			if _n <=12 
      				dDtAux := MonthSum(M->ZYA_DTINI, _n)
      			else
      				nAno := noround((_n/12),0)
      				dDtAux := YearSum(M->ZYA_DTINI,nAno)
      				dDtAux := MonthSum(dDtAux, (_n -(12*nAno)))
      			endif 
      			aCols[nLin][_posVENCTO]  := STOD(SUBS(DTOS(dDtAux),1,6)+padl(M->ZYA_DIAPAR,2,"0"))
	      	else
    	  		aCols[nLin][_posVENCTO]  := (M->ZYA_DTINI +(30*(_n-1)))
      		Endif
      		If _n < _nParcelas
      			aCols[nLin][_posFATURA]  := round((M->ZYA_VALOR / _nParcelas),2)
      			nSaldo += aCols[nLin][_posFATURA]
		       aCols[nLin][_posJUROS]   := round((M->ZYA_TJUROS / _nParcelas),2)
    	   		aCols[nLin][_posAMORT]   := round((M->ZYA_VALOR / _nParcelas),2) - round((M->ZYA_TJUROS / _nParcelas),2) 
				aCols[nLin][_posSALDO]   := round((M->ZYA_VALOR - nSaldo),2)
      		Else
      			aCols[nLin][_posFATURA]  := round( (M->ZYA_VALOR - (round( (M->ZYA_VALOR / _nParcelas) ,2) *(_n-1) ) ) ,2)
      			nSaldo += aCols[nLin][_posFATURA]
	       	aCols[nLin][_posJUROS]   := round( (M->ZYA_TJUROS - (round( (M->ZYA_TJUROS / _nParcelas),2) *(_n-1) ) ) ,2)
       		aCols[nLin][_posAMORT]   := round( (aCols[nLin][_posFATURA] - aCols[nLin][_posJUROS]),2)
       		aCols[nLin][_posSALDO]   := round((M->ZYA_VALOR - nSaldo),2) 
				//aCols[nLin][_posSALDO]   := round((M->ZYA_VALOR - round(round((M->ZYA_VALOR/_nParcelas),2)*_n,2)),2)
      		EndIf
	       
    	    aCols[nLin][Len(aHeader)+1] := .F.
       	//aAdd(aAlt, Recno())  
		next _n
	else
		MsgAlert(cMsg)
	endif 
Return



Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
aAdd(aRegs,{cPerg,"01","Tipo?","Tipo?","Tipo?","mv_ch1","N",01,0,2,"C","","MV_PAR01","Diferimento","Diferimento","Diferimento","","","Emprestimo","Emprestimo","Emprestimo","","","Financiamento","Financiamento","Financiamento","","","","","","","","","","","","","","","",""})

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
