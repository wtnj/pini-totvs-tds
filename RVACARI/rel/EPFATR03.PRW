/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Exemplo de relatorio usando tReport com uma Section
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EPFATR01  ºAutor  ³Thiago Lima Dyonisioº Data ³  11/13/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório de Anunciantes Ativos                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Editora PINI                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

user function EPFATR03()

local oReport
local cPerg  := 'EPFATR03'
local cAlias := getNextAlias()

criaSx1(cPerg)
Pergunte(cPerg, .F.)

oReport := reportDef(cAlias, cPerg)

oReport:printDialog()

return

//+-----------------------------------------------------------------------------------------------+
//! Função para criação da estrutura do relatório.                                                !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportDef(cAlias,cPerg)

local cTitle  := "Relatório de Poder de Terceiros"
local cHelp   := "Relatório de controle de material em poder de vendedores"
Local aOrdem  := {"Código do Vendedor", "Nome do Vendedor"}

local oReport
local oSection1
local oSection2
local oBreak1

oReport	:= TReport():New('EPFATR03',cTitle,cPerg,{|oReport|ReportPrint(oReport,cAlias)},cHelp)
oReport:SetPortrait()

//Primeira seção
oSection1 := TRSection():New(oReport,"Saídas",{"SD2","SB1",},aOrdem)    

TRCell():New(oSection1,"D2_DOC"    , "SD2", "NF SAIDA")
TRCell():New(oSection1,"D2_SERIE"  , "SD2", "SERIE")   
TRCell():New(oSection1,"D2_EMISSAO", "SD2", "DT EMISSAO")   
TRCell():New(oSection1,"D2_COD"    , "SD2", "PRODUTO")   
TRCell():New(oSection1,"B1_DESC"   , "SB1", "DESCRICAO")   
TRCell():New(oSection1,"B1_TIPO"   , "SB1", "TIPO")   
TRCell():New(oSection1,"D2_QUANT"  , "SD2", "QTDE SAIDA")   
TRCell():New(oSection1,"D2_CUSTO1" , "SD2", "CUSTO SAIDA")   
TRCell():New(oSection1,"saldo"     , "SD2", "SALDO")   

//Segunda seção
oSection2:= TRSection():New(oSection1,"Entradas",{"SD1"})
        
oSection2:SetLeftMargin(2)

TRCell():New(oSection1,"D1_DOC"    , "SD1", "NF ENTRADA")   
TRCell():New(oSection1,"D1_SERIE"  , "SD1", "SERIE")   
TRCell():New(oSection1,"D1_EMISSAO", "SD1", "DT EMISSAO")   
TRCell():New(oSection1,"D1_QUANT"  , "SD1", "QTDE ENTRADA")   
TRCell():New(oSection1,"D1_CUSTO"  , "SD1", "CUSTO ENTRADA")   

//Totalizador por cliente
//oBreak1 := TRBreak():New(oSection2,{|| (cAlias)->(A1_COD) },"Total:",.F.)                   
//TRFunction():New(oSection2:Cell("C6_QTDVEN" ), "TOT1", "SUM", oBreak1,,,, .F., .F.)
//TRFunction():New(oSection2:Cell("C6_VALOR" ), "TOT2", "SUM", oBreak1,,,, .F., .F.)

Return(oReport)

//+-----------------------------------------------------------------------------------------------+
//! Rotina para montagem dos dados do relatório.                                  !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportPrint(oReport,cAlias)

local oSection1b := oReport:Section(1)
local oSection2b := oReport:Section(1):Section(1)  
local cOrdem  

if oReport:Section(1):GetOrder() == 1
	cOrdem := "D2_DOC" 
else
	cOrdem := "D2_DOC"
endif
             
oSection1b:BeginQuery()

BeginSQL Alias cAlias
	
	SELECT DISTINCT D2_DOC, D2_SERIE, D2_EMISSAO, D2_COD, B1_DESC, B1_TIPO, D2_QUANT, D2_CUSTO1, 
	D1_DOC, D1_SERIE, D1_EMISSAO, D1_QUANT, D1_CUSTO, 

	CASE WHEN (D2_QUANT - (SELECT SUM(D1_QUANT) FROM %Table:SD1% SD1 WHERE D1_NFORI = D2_DOC AND D1_SERIORI = D2_SERIE AND D1_ITEMORI = D2_ITEM )) <> 0
		THEN (D2_QUANT - (SELECT SUM(D1_QUANT) FROM %Table:SD1% SD1 WHERE D1_NFORI = D2_DOC AND D1_SERIORI = D2_SERIE AND D1_ITEMORI = D2_ITEM ))
	ELSE D2_QUANT
	END SALDO	

	FROM %Table:SD2% SD2

	INNER JOIN %Table:SB1% SB1	
	ON B1_COD = D2_COD
	AND SB1.%NotDel%
	AND SD2.%NotDel%
	
	LEFT JOIN %Table:SD1% SD1	
	ON  D1_NFORI   = D2_DOC
	AND D1_SERIORI = D2_SERIE 
	AND D1_ITEMORI = D2_ITEM 
	AND SD1.%NotDel%	

	WHERE D2_CLIENTE = %Exp:MV_PAR01%
	AND D2_EMISSAO BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%

	ORDER BY D2_DOC	
			
EndSQL 

oSection1b:EndQuery()    
oSection2b:SetParentQuery()

oReport:SetMeter((cAlias)->(RecCount()))  

oSection2b:SetParentFilter({|cParam| (cAlias)->D2_DOC == cParam}, {|| (cAlias)->D2_DOC})

oSection1b:Print()	   

return

//+-----------------------------------------------------------------------------------------------+
//! Função para criação das perguntas (se não existirem)                                          !
//+-----------------------------------------------------------------------------------------------+
static function criaSX1(cPerg)

putSx1(cPerg, '01', 'Vendedor'            , '', '', 'mv_ch1', 'C', 6                     , 0, 0, 'G', '', 'SA1', '', '', 'mv_par01')
putSx1(cPerg, '02', 'Data de?'            , '', '', 'mv_ch2', 'D', 8                     , 0, 0, 'G', '', ''   , '', '', 'mv_par02')
putSx1(cPerg, '03', 'Data até?'           , '', '', 'mv_ch3', 'D', 8                     , 0, 0, 'G', '', ''   , '', '', 'mv_par03')

return    