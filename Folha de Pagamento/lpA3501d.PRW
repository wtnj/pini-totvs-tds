#INCLUDE "RWMAKE.CH"
User Function LPA3501D()
Local mctadeb := ''
IF SUBS(SRZ->RZ_CC,1,3) $ "41 /410/411/21 /211/2  "
	MCTADEB := "42010202001"
ELSEIF SUBS(SRZ->RZ_CC,1,2) $"22"
	MCTADEB := "41010102001"
ELSEIF SUBS(SRZ->RZ_CC,1,2) $"23"
	MCTADEB := "42010103001"
ELSEIF SUBS(SRZ->rZ_CC,1,3) $"412"
	MCTADEB := "41010501001"
ELSEIF SUBS(SRZ->rZ_CC,1,3) $"414" // PESQUISA
	MCTADEB := "41020901001"			
ELSEIF SUBS(SRZ->RZ_CC,1,3) $"413"
	MCTADEB := "41010601001"
ELSEIF SUBS(SRZ->RZ_CC,1,3) $"415"
	MCTADEB := "41010501001"
ELSEIF SUBS(SRZ->RZ_CC,1,3) $"416"
	MCTADEB := "42010103001"    
ELSEIF SUBS(SRZ->RZ_CC,1,2) $"31"
	MCTADEB := "41020101001"
ELSEIF SUBS(SRZ->RZ_CC,1,2) $"32"
	MCTADEB := "41020301001"
else
	MCTADEB := "CC INVALIDO"
ENDIF
RETURN(MCTADEB)