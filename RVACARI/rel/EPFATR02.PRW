/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Exemplo de relatorio usando tReport com uma Section
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/

user function EPFATR02()

local oReport
local cPerg  := 'EPFATR02'
local cAlias := getNextAlias()
Private nNF  := ''

criaSx1(cPerg)
Pergunte(cPerg, .F.)

oReport := reportDef(cAlias, cPerg)

oReport:printDialog()

return  
          
//+-----------------------------------------------------------------------------------------------+
//! Rotina para montagem dos dados do relatório.                                  !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportPrint(oReport,cAlias)
                 
local oSecao1 := oReport:Section(1)

oSecao1:BeginQuery()

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

oSecao1:EndQuery()  

oReport:SetMeter((cAlias)->(RecCount()))  

oSecao1:Print()	   

return

//+-----------------------------------------------------------------------------------------------+
//! Função para criação da estrutura do relatório.                                                !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportDef(cAlias,cPerg)

local cTitle  := "Relatório de Clientes"
local cHelp   := "Permite gerar relatório de clientes."

local oReport
local oSection1

oReport	:= TReport():New('EPFATR02',cTitle,cPerg,{|oReport|ReportPrint(oReport,cAlias)},cHelp)

//Primeira seção
oSection1 := TRSection():New(oReport,"Clientes",{"SD2","SD1","SB1"})    

TRCell():New(oSection1,"D2_DOC"    , "SD2", "NF SAIDA")
TRCell():New(oSection1,"D2_SERIE"  , "SD2", "SERIE")   
TRCell():New(oSection1,"D2_EMISSAO", "SA1", "DT EMISSAO")   
TRCell():New(oSection1,"D2_COD"    , "SD2", "PRODUTO")   
TRCell():New(oSection1,"B1_DESC"   , "SB1", "DESCRICAO")   
TRCell():New(oSection1,"B1_TIPO"   , "SB1", "TIPO")   
TRCell():New(oSection1,"D2_QUANT"  , "SD2", "QTDE SAIDA")   
TRCell():New(oSection1,"D2_CUSTO1" , "SD2", "CUSTO SAIDA")   
TRCell():New(oSection1,"D1_DOC"    , "SD1", "NF ENTRADA")   
TRCell():New(oSection1,"D1_SERIE"  , "SD1", "SERIE")   
TRCell():New(oSection1,"D1_EMISSAO", "SD1", "DT EMISSAO")   
TRCell():New(oSection1,"D1_QUANT"  , "SD1", "QTDE ENTRADA")   
TRCell():New(oSection1,"D1_CUSTO"  , "SD1", "CUSTO ENTRADA")   
TRCell():New(oSection1,"saldo"     , "SD2", "SALDO")   
Return(oReport)

//+-----------------------------------------------------------------------------------------------+
//! Função para criação das perguntas (se não existirem)                                          !
//+-----------------------------------------------------------------------------------------------+
static function criaSX1(cPerg)

putSx1(cPerg, '01', 'Vendedor'            , '', '', 'mv_ch1', 'C', 6                     , 0, 0, 'G', '', 'SA3', '', '', 'mv_par01')
putSx1(cPerg, '02', 'Data de?'            , '', '', 'mv_ch2', 'D', 8                     , 0, 0, 'G', '', ''   , '', '', 'mv_par02')
putSx1(cPerg, '03', 'Data até?'           , '', '', 'mv_ch3', 'D', 8                     , 0, 0, 'G', '', ''   , '', '', 'mv_par03')

return    