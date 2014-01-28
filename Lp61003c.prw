#INCLUDE "RWMAKE.CH"
User Function LP61003C()
Local mcta := ''
dbselectarea("SB1")
dbsetorder(1)
dbseek(xfilial("SB1")+SC6->C6_PRODUTO)
IF SB1->B1_GRUPO $"0300" // publicidade
	MCTA := "51010103001"
ELSEIF SB1->B1_GRUPO $"0100"           // revistas
	MCTA := "51010102001"
ELSEIF SB1->B1_GRUPO $"1000" // relatorios
	MCTA := "51010104001" 
ELSEIF SUBS(SD2->D2_COD,1,2) $"34"   // manutencao piniweb
	MCTA := "51010105001"
ENDIF
RETURN(MCTA)