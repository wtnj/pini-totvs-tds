#INCLUDE "RWMAKE.CH"
User Function LP61003V()
Local mvalor := 0
dbselectarea("SB1")
dbsetorder(1)
dbseek(xfilial("SB1")+SC6->C6_PRODUTO)
IF SB1->B1_GRUPO $"0300" // publicidade
	mvalor := sd2->d2_total
ELSEIF SB1->B1_GRUPO $"0100"           // revistas
	IF SUBS(SD2->D2_COD,5,3) <> "001" // assinaturas
		mvalor := sd2->d2_total
	endif
ELSEIF SB1->B1_GRUPO $"1000" // relatorios
	mvalor := sd2->d2_total
ELSEIF SUBS(SD2->D2_COD,1,2) $"34"   // manutencao piniweb
	mvalor := sd2->d2_total
ELSEIF subs(SB1->B1_GRUPO,1,2) $"36"   //  publicidade web
	mvalor := sd2->d2_total
ENDIF
RETURN(MVALOR)