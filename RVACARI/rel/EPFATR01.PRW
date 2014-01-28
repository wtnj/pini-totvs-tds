/*BEGINDOC
//����������������������������������������������������Ŀ
//�Exemplo de relatorio usando tReport com uma Section
//������������������������������������������������������
ENDDOC*/

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �EPFATR01  �Autor  �Thiago Lima Dyonisio� Data �  11/13/13   ���
�������������������������������������������������������������������������͹��
���Desc.     � Relat�rio de Anunciantes Ativos                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Editora PINI                                               ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function EPFATR01()

local oReport
local cPerg  := 'ANUNATIVOS'
local cAlias := getNextAlias()

criaSx1(cPerg)
Pergunte(cPerg, .F.)

oReport := reportDef(cAlias, cPerg)

oReport:printDialog()

return  
          
//+-----------------------------------------------------------------------------------------------+
//! Rotina para montagem dos dados do relat�rio.                                  !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportPrint(oReport,cAlias)
                 
local oSecao1 := oReport:Section(1)

oSecao1:BeginQuery()

BeginSQL Alias cAlias
	
	SELECT  DISTINCT A1_COD, A1_NOME, A1_NREDUZ, A1_CGC 
	FROM %Table:SA1% SA1
	
	INNER JOIN %Table:SZS% SZS
 	ON ZS_CODCLI = A1_COD
	AND SZS.%NotDel%

	WHERE ZS_DTCIRC >= %Exp:MV_PAR01% 
	
	ORDER BY A1_COD//%Exp:cOrdem%   
	
EndSQL 

oSecao1:EndQuery()  

oReport:SetMeter((cAlias)->(RecCount()))  

oSecao1:Print()	   

return

//+-----------------------------------------------------------------------------------------------+
//! Fun��o para cria��o da estrutura do relat�rio.                                                !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportDef(cAlias,cPerg)

local cTitle  := "Relat�rio de Anunciantes Ativos"
local cHelp   := "Permite gerar relat�rio de anunciantes ativos."

local oReport
local oSection1

oReport	:= TReport():New('ANUNCIANTES',cTitle,cPerg,{|oReport|ReportPrint(oReport,cAlias)},cHelp)

//Primeira se��o
oSection1 := TRSection():New(oReport,"Rela��o de Anunciantes Ativos",{"SA1"})    

TRCell():New(oSection1,"A1_COD"		, "SA1", "Codigo"		)
TRCell():New(oSection1,"A1_NOME"	, "SA1", "Nome"			)   
TRCell():New(oSection1,"A1_NREDUZ"	, "SA1", "Nome Fantasia")   
TRCell():New(oSection1,"A1_CGC"		, "SA1", "CNPJ / CPF"	)   

Return(oReport)

//+-----------------------------------------------------------------------------------------------+
//! Fun��o para cria��o das perguntas (se n�o existirem)                                          !
//+-----------------------------------------------------------------------------------------------+
static function criaSX1(cPerg)

putSx1(cPerg, '01', 'Data de corte'          , '', '', 'mv_ch1', 'D',08, 0, 0, 'G', '', '', '', '', 'mv_par01')

return    