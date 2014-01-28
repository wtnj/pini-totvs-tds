#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/   Alterado por Danilo C S Pala em 20031211
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PLAACAUT  ³Autor: Rosane Lacava Rodrigues³ Data:   16/12/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de Demonstrativo de Direitos de Publicacao       ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat036()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CTITULO")
SetPrvt("CCABEC1,CCABEC2,CPROGRAMA,CTAMANHO,LIMITE,NCARACTER")
SetPrvt("NLASTKEY,MMESANO,CDESC1,CDESC2,CDESC3,M_PAG")
SetPrvt("ARETURN,CARQ,CINDEX,CKEY,CFILTRO,WNREL")
SetPrvt("CSTRING,MD,XD,MAUT,MNOME,MBRUTO")
SetPrvt("MVLBR,L,MVALIR,MVLIRF,MVLISS,mhora")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //Da data:          ³
//³ mv_par02             //Ate a data:       ³
//³ mv_par03             //Valor do IGPM     ³
//³ mv_par04             //Valor Minimo      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG := 'PFAT48'
IF !PERGUNTE(CPERG)
	RETURN
ENDIF

cTitulo   := SPACE(23)+"***** DEMONSTRATIVO *****"
cCabec1   := " "
cCabec2   := " "
cPrograma := "RFAT036"
cTamanho  := "M"
LIMITE    := 132
nCaracter := 12
NLASTKEY  := 0
MMESANO   := STR(MONTH(MV_PAR02),2)+STR(YEAR(MV_PAR02),4)
cDesc1    := PADC("Este programa gera o demonstrativo de direitos de publicacao",70)
cDesc2    := " "
cDesc3    := " "
M_PAG     := 1
aRETURN   := {"Especial", 1,"Administracao", 1, 2, 1," ",1 }

If Select("DIR") <> 0
	DbSelectArea("DIR")
	DbCloseArea()
EndIf

cArq      := 'DIRAUTAC.DBF'
dbUseArea(.T.,,cArq,"DIR") //,.F.,.F.)
MHORA := TIME()
WNREL     := "ACAUT_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING   := "DIR"
WNREL     := SETPRINT(CSTRING,WNREL,CPERG,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
SETDEFAULT(aRETURN,CSTRING)

cIndex    := CriaTrab(Nil,.F.)
cKey      := "NOMEAUT+STR(ANO,4)+STR(MES,2)+PRODUTO"
cFiltro   := "DIR->MESANO == MMESANO .OR. DIR->MESANO == SPACE(6)"
Indregua("DIR",cIndex,ckey,,cFiltro,"Selecionando Registros do Arq")

IF NLASTKEY == 27 .OR. NLASTKEY == 65
	DBCLOSEAREA()
	RETURN
ENDIF

Processa({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        RptStatus({|| Execute(RptDetail)})

Return

Static Function RptDetail()

MD := MV_PAR01
XD := DTOS(MD)

DBSELECTAREA("DIR")
//DBSETORDER(01)
DBGOTOP()
PROCREGUA(RECCOUNT())
WHILE !EOF()
	INCPROC("Lendo Registro: "+Padr(Str(recno()),7))
	
	MAUT   := CODAUT
	MNOME  := SPACE(40)
	MBRUTO := 0 
	MVLISS := 0
	MVLBR  := 0
	L      := 0

/* IF CODAUT == '002015' .or. CODAUT == '001071'
	MSGALERT ("ACHOU !!!")   
ENDIF  */

	DBSELECTAREA("SA3")
	DBSETORDER (01)
	DBSEEK(XFILIAL()+MAUT)
	IF FOUND()
		MNOME  := SA3->A3_NOME
	ENDIF
	
	IF L==0 .OR. L>55
		If L <> 0
			Roda(0,"",ctamanho)
		EndIf
		L := Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
		L += 2
		//@ L,00 PSAY REPLICATE ('*',132)
	ENDIF
	
	//L += 2
	@ L,01  PSAY "DIREITOS DE PUBLICACAO"
	L++
	@ L,01  PSAY "AUTOR : "  + MAUT +" "+ MNOME PICTURE "@!"
	L++
	@ L,01  PSAY "+"
	@ L,02  PSAY REPLICATE ('-',127)
	@ L,129 PSAY "+"
	L++
	@ L,01  PSAY "| FECHTO  |"
	@ L,12  PSAY "  CODIGO  |"
	@ L,24  PSAY "  LIVRO   |"
	@ L,36  PSAY "  QTDE  |"
	@ L,46  PSAY "   VALOR   |"
	@ L,59  PSAY "   VALOR   |"
	@ L,72  PSAY "   IGPM   |"
	@ L,84  PSAY " DIR PUBL |"
	@ L,96  PSAY " SALDO IGPM |"
	@ L,110 PSAY "    OBSERVACAO     |"
	L++
	@ L,01  PSAY "| MES/ANO |"
	@ L,12  PSAY "          |"
	@ L,24  PSAY "          |"
	@ L,36  PSAY " EXEMPL |"
	@ L,46  PSAY "   VENDA   |"
	@ L,59  PSAY "  DIR PUB  |"
	@ L,74  PSAY "        |"
	@ L,84  PSAY "   IGPM   |"
	@ L,96  PSAY "            |"
	@ L,110 PSAY "                   |"
	L++
	@ L,01  PSAY "+"
	@ L,02  PSAY REPLICATE ('-',127)
	@ L,129 PSAY "+"
	
	DBSELECTAREA("DIR")
	WHILE !Eof() .and. DIR->CODAUT == MAUT
		//IF DIR->MESANO#SPACE(06) .AND. DIR->MESANO#MMESANO
		//  DBSKIP()
		//  LOOP
		//ENDIF
		L++
		@ L,01  PSAY "| "+ STR(DIR->MES,2) + "/" + STR(DIR->ANO,4)
		@ L,11  PSAY "| "+ SUBS(DIR->PRODUTO,1,8)
		DBSELECTAREA("SB1")
		DBSETORDER(01)
		DBSEEK(XFILIAL()+DIR->PRODUTO)
		@ L,22  PSAY "| " + SB1->B1_TITULO
		DBSELECTAREA("DIR")
		@ L,34  PSAY "|" + STR(DIR->QTDE,8) + " |"
		@ L,46  PSAY DIR->VLVENDA  PICTURE "@E 999,999.99"
		@ L,57  PSAY "|"
		@ L,59  PSAY DIR->VLBRUTO  PICTURE "@E 999,999.99"
		@ L,70  PSAY "|"
		@ L,71  PSAY DIR->VLIGPM   PICTURE "@E 9,999.9999"
		@ L,82  PSAY "|"
		@ L,83  PSAY DIR->VLBRIGPM PICTURE "@E 9,999.9999"
		@ L,94  PSAY "|"
		MBRUTO := MBRUTO + DIR->VLBRIGPM
		@ L,95  PSAY MBRUTO        PICTURE "@E 9,999.9999"
		@ L,108 PSAY "| __________________ |"
		L++
		@ L,01  PSAY "+"
		@ L,02  PSAY REPLICATE ('-',127)
		@ L,129 PSAY "+"
		DBSKIP()
	END
	L += 2
	MVLBR := MBRUTO * MV_PAR03
	@ L,01 PSAY "VALOR BRUTO ACUMULADO ......: "
	@ L,33 PSAY MVLBR PICTURE "@E 999,999.99"
	L++
	IRF()
	@ L,01 PSAY "VALOR LIQUIDO ACUMULADO ....: "
	MVALIR := (MVLBR - MVLIRF - MVLISS)
	@ L,33 PSAY MVALIR PICTURE "@E 999,999.99"
	IF MVALIR >= MV_PAR04
		GRAVA()
	ENDIF
	Roda(0,"",cTamanho)
	DBSELECTAREA("DIR")
END

SET DEVICE TO SCREEN

IF aRETURN[5] ==1
	SET PRINTER TO
	DBCOMMITALL()
	OURSPOOL(WNREL)
ENDIF

MS_FLUSH()

DBCLOSEAREA()

DBSELECTAREA("SA3")
RETINDEX("SA3")

DBSELECTAREA("SB1")
RETINDEX("SB1")

DBSELECTAREA("SZZ")
RETINDEX("SZZ")

RETURN

Static FUNCTION IRF()

DBSELECTAREA("SZZ")
DBGOTOP()
IF SA3->A3_PESSOA == "F"
	WHILE !EOF()

		MVLISS := (MVLBR * 5/100)

		IF MVLBR >= SZZ->ZZ_VALORI .AND. MVLBR <= SZZ->ZZ_VALORF
			MVLIRF := ((MVLBR * (SZZ->ZZ_ALIQ/100)) - SZZ->ZZ_DEDUCAO)
		ENDIF
		DBSKIP()
	END
ENDIF
IF MVLIRF < 10
	MVLIRF := 0
ENDIF

RETURN

Static FUNCTION GRAVA()

DBSELECTAREA("DIR")
//DBSETORDER(01)
DBSEEK(MNOME)
WHILE !Eof() .and. DIR->CODAUT == MAUT
	IF DIR->MESANO == SPACE(06) .OR. DIR->MESANO == MMESANO
		RECLOCK("DIR",.F.)
		DIR->MESANO := MMESANO
		MSUNLOCK()
	ENDIF
	DBSKIP()
END

RETURN
