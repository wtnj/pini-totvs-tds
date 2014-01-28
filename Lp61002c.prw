#INCLUDE "RWMAKE.CH"
User Function LP61002C()
Local mcta := ''
dbselectarea("SB1")
dbsetorder(1)
dbseek(xfilial("SB1")+SC6->C6_PRODUTO)
IF SB1->B1_GRUPO $"0300" // publicidade
	MCTA := "21080101002"
ELSEIF SB1->B1_GRUPO $"0100"           // revistas
	IF SUBS(SD2->D2_COD,5,3) <> "001" // assinaturas
		MCTA := "21080101001"
	ELSE                                // avulsos
		If subs(sb1->b1_cod,1,4) $"0107"
		     mCta := '31010101002'
		Elseif subs(sb1->b1_cod,1,4) $"0115/0101/0102/0103/0104/0105/0114"
		     mCta := '31010103002'
		Elseif subs(sb1->b1_cod,1,4) $"0116"
		     mCta := '31010102002'
		Else
		     mCta := '31010101003'
		Endif
	endif
ELSEIF SB1->B1_GRUPO $"1000" // relatorios
	if sb1->b1_qtdeex <> 1
		MCTA := "21080101003" // assinaturas
	else
		MCTA := "31010109002" // avulsos
	ENDIF
ELSEIF SUBS(SD2->D2_COD,1,2) $"34"   // manutencao piniweb
	//MCTA := "21080101004"
	MCTA := "31010114008"
ELSEIF SB1->B1_GRUPO $"0200"   // livros
	MCTA := "31010105001"
ELSEIF SB1->B1_GRUPO $"0400"   // serv.engenharia
	MCTA := "31010110001"
ELSEIF SB1->B1_GRUPO $"0500"   // cursos
	MCTA := "31010110001"
ELSEIF SB1->B1_GRUPO $"0700"   // videos e cds
	if sb1->b1_tipo == "VI"   // videos
		MCTA := "31010107001" 
	ELSEif sb1->b1_tipo == "CD"   // cds
		MCTA := "31010106001" 
	ENDIF
ELSEIF SB1->B1_GRUPO $"0700"   // aparas
	MCTA := "31010108001" 
ELSEIF subs(SB1->B1_GRUPO,1,2) $"32/33"   //  web
	If subs(sb1->b1_cod,1,4) $"3210" // volare web
	     mCta := '31010113001'
	elseIf subs(sb1->b1_cod,1,4) $"3220" // strato
	     mCta := '31010113003'
	elseIf subs(sb1->b1_cod,1,4) $"3230" // essere web
	     mCta := '31010113005'
	elseIf subs(sb1->b1_cod,1,4) $"3240" // tcpo web
	     mCta := '31010113006'
	elseIf subs(sb1->b1_cod,1,4) $"3250" // pec
	     mCta := '31010113007'
	elseIf subs(sb1->b1_cod,1,4) $"3260" // pacote comprador
	     mCta := '31010113009'
	elseIf subs(sb1->b1_cod,1,4) $"3270" // pacote fornecedor
	     mCta := '31010113010'
	elseIf subs(sb1->b1_cod,1,4) $"3280" // senior
	     mCta := '31010113011'
	elseIf subs(sb1->b1_cod,1,4) $"3290" // corporate
	     mCta := '31010113012'
	elseIf subs(sb1->b1_cod,1,4) $"3300" // student
	     mCta := '31010113013'
	elseIf subs(sb1->b1_cod,1,4) $"3310" // pini delivery
	     mCta := '31010113014'
	elseIf subs(sb1->b1_cod,1,4) $"3320" // pré pago
	     mCta := '31010113008'
	endif
ELSEIF subs(SB1->B1_GRUPO,1,2) $"35"   //  cursos
	If subs(sb1->b1_cod,1,4) $"3510" // volare
	     mCta := '31010115001'
	elseIf subs(sb1->b1_cod,1,4) $"3520" // arcon
	     mCta := '31010115002'
	elseIf subs(sb1->b1_cod,1,4) $"3530" // strato
	     mCta := '31010115003'
	elseIf subs(sb1->b1_cod,1,4) $"3540" // project net
	     mCta := '31010115004'
	endif
ELSEIF subs(SB1->B1_GRUPO,1,2) $"36"   //  publicidade web
	If subs(sb1->b1_cod,1,4) $"3610"   // banners
	     mCta := '31010116001'
	elseIf subs(sb1->b1_cod,1,4) $"3620" // essere
	     mCta := '31010116002'
	elseIf subs(sb1->b1_cod,1,4) $"3630" // road show
	     mCta := '31010116004'
	endif
ELSEIF subs(SB1->B1_GRUPO,1,2) $"37"   //  outros servicos
    mCta := '31010117002'
ELSEIF subs(SB1->B1_GRUPO,1,2) $"31"   //  softwares
	If subs(sb1->b1_cod,1,4) $"3110"   // volare
	     mCta := '31010112001'
	elseIf subs(sb1->b1_cod,1,4) $"3120" // arcon
	     mCta := '31010112002'
	elseIf subs(sb1->b1_cod,1,4) $"3130" // strato
	     mCta := '31010112003'
	elseIf subs(sb1->b1_cod,1,4) $"3140" // essere
	     mCta := '31010112005'
	elseIf subs(sb1->b1_cod,1,4) $"3150" // tcpo
	     mCta := '31010112006'
	elseIf subs(sb1->b1_cod,1,4) $"3160" // project net
	     mCta := '31010112004'
	endif
ENDIF
RETURN(MCTA)