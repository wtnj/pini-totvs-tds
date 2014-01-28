#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: FATAUT    ³Autor: Rosane Lacava Rodrigues³ Data:   06/12/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descricao: Relatorio do Fat dos Autores                               ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat127()

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,M_PAG")
SetPrvt("L,MBRUTO,MIRF,MISS,MLIQ,MMESANO")
SetPrvt("MMES,MANO,PMES,PANO,CTITULO,CCABEC1")
SetPrvt("CCABEC2,CPROGRAMA,CTAMANHO,LIMITE,NCARACTER,NLASTKEY")
SetPrvt("CDESC1,CDESC2,CDESC3,ARETURN,CARQ,CINDEX")
SetPrvt("CKEY,WNREL,CSTRING,MAUT,MNOME,MDOC")
SetPrvt("MVIGPM,MVMIN,MVLBR,MVLIRF,MVLISS,MVLLIQ, MCGC")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //Periodo Inicial   ³
//³ mv_par02             //Periodo Final     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG := 'PFT127'
IF !PERGUNTE(CPERG)
	RETURN
ENDIF

M_PAG   := 1
L       := 0
MBRUTO  := 0
MIRF    := 0
MISS    := 0
MLIQ    := 0
MMESANO := STR(MONTH(MV_PAR02),2)+STR(YEAR(MV_PAR02),4)
MMES    := MONTH(MV_PAR02)
MANO    := YEAR(MV_PAR02)

PMES    := MMES + 1
PANO    := MANO
IF PMES > 12
	PMES := 1
	PANO := (MANO + 1)
ENDIF

cTitulo   := SPACE(15)+"***** FAT - DIREITOS PUBLICACAO *****"
cCabec1   := "PRODUTO: 02.00.000"+SPACE(25)+"****** DEMONSTRATIVO DE DIREITOS AUTORAIS / "+STR(PMES,2)+" / "+STR(PANO,4)+" *****"
cCabec2   := "NOME DO AUTOR                              VL.BRUTO            VL.IRF          VL.ISS        VL.LIQUIDO   CPF/CNPJ"
cPrograma := "FATAUT"
cTamanho  := "M"
LIMITE    := 132
nCaracter := 12
NLASTKEY  := 0

cDesc1    := PADC("Este programa gera o relatorio do Fat dos direitos autorais",70)
cDesc2    := "  "
cDesc3    := "  "

aRETURN   := {"Especial", 1,"Administracao", 1, 2, 1," ",1 }

cArq      := 'PGAUT.DBF'
dbUseArea(.T.,,cArq,"PGAUT")
cIndex    := CriaTrab(Nil,.F.)
cKey      := "NOMEAUT"
Indregua("PGAUT",cIndex,ckey,,,"Selecionando Registros do Arq")
MHORA      := TIME()
WNREL     := "FATAUT_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING   := "PGAUT"
NREL      := SETPRINT(CSTRING,WNREL,CPERG,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
SETDEFAULT(aRETURN,CSTRING)

IF NLASTKEY == 27 .OR. NLASTKEY == 65
	DBCLOSEAREA()
	RETURN
ENDIF

Processa({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        RptStatus({|| Execute(RptDetail)})

Return

Static Function RptDetail()

If Select("DIR") <> 0
	DbSelectArea("DIR")
	DbCloseArea()
EndIf

cArq   := 'DIRAUTAC.DBF'
dbUseArea(.T.,,cArq,"DIR")
cIndex := CriaTrab(Nil,.F.)
cKey   := "CODAUT+PRODUTO+STR(ANO,4)+STR(MES,2)"
MsAguarde({|| Indregua("DIR",cIndex,ckey,,,"Selecionando Registros do Arq")},"Aguarde","Gerando Indice Temporario (DIR)...")

DBSELECTAREA("PGAUT")
//DBSETORDER(01)
DBGOTOP()
PROCREGUA(RECCOUNT())
WHILE !EOF() .AND. PGAUT->MES == MONTH(MV_PAR02) .AND. PGAUT->ANO == YEAR(MV_PAR02)
	
	INCPROC("Autor: "+Alltrim(PGAUT->NOMEAUT))
	
	MAUT   := CODAUT
	MNOME  := NOMEAUT
	MDOC   := TIPODOC
	MVIGPM := PGAUT->VLIGPM
	MVMIN  := PGAUT->VLMINIMO
	MVLBR  := 0
	MVLIRF := 0
	MVLISS := 0
	MVLLIQ := 0
	MCGC := PGAUT->CGC                           

	/* consistencia alterada de a3_tipodoc para a3_tipiven a pedido da Raquel Reis	//20040106
	IF MDOC == 'P'
		DBSKIP()
		LOOP
	ENDIF */
	IF PGAUT->TIPOVEN <> "AT" //20040106
		DBSKIP()
		LOOP
	EndIF        
	
	IF L==0 .OR. L >= 55
		If L <> 0
			Roda(0,"",cTamanho)
		EndIf
		L := Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
		L += 2
	ENDIF
	
	WHILE ! Eof() .and. PGAUT->NOMEAUT == MNOME
		IF PGAUT->MOEDA == 'R'
			MVLBR  := MVLBR + PGAUT->VLBRUTO
		ENDIF
		DBSKIP()
	ENDDO
	
	DBSELECTAREA("DIR")
	DBSEEK(MAUT)
	WHILE !Eof() .and. DIR->CODAUT == MAUT
		IF (DIR->MESANO#MMESANO .AND. DIR->MESANO#SPACE(6)) .OR. (DIR->MES>=MONTH(MV_PAR02) .AND. DIR->ANO>=YEAR(MV_PAR02))
			DBSKIP()
			LOOP
		ENDIF
		MVLBR := MVLBR + (DIR->VLBRIGPM * MVIGPM)
		DBSKIP()
	END
	
	IRF()
	
	MVLLIQ := (MVLBR - MVLIRF - MVLISS)
	
	IF MVLLIQ >= MVMIN .AND. MDOC <> 'N'
		@ L,00  PSAY MNOME
		@ L,39  PSAY noround(MVLBR,2)  PICTURE "@E 999,999.99"
		@ L,58  PSAY noround(MVLIRF,2) PICTURE "@E 999,999.99"
		@ L,74  PSAY noround(MVLISS,2) PICTURE "@E 999,999.99"
		@ L,91  PSAY noround(MVLLIQ,2) PICTURE "@E 999,999.99"
		@ L,105 PSAY MCGC PICTURE "@!"
		
		MBRUTO := MBRUTO + MVLBR
		MIRF   := MIRF   + MVLIRF
		MISS   := MISS   + MVLISS
		MLIQ   := MLIQ   + MVLLIQ
		L += 2
	ENDIF
	DBSELECTAREA("PGAUT")
END

IF L >= 55
	Roda(0,"",cTamanho)
	L := Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
	L += 2
ENDIF

@ L,00 PSAY "TOTAL GERAL .................: "
@ L,40 PSAY MBRUTO PICTURE "@E 999,999.99"
@ L,59 PSAY MIRF   PICTURE "@E 999,999.99"
@ L,75 PSAY MISS   PICTURE "@E 999,999.99"
@ L,92 PSAY MLIQ   PICTURE "@E 999,999.99"

Roda(0,"",cTamanho)

SET DEVICE TO SCREEN

IF aRETURN[5] ==1
	SET PRINTER TO
	DBCOMMITALL()
	OURSPOOL(WNREL)
ENDIF

MS_FLUSH()

DBCLOSEAREA()

RETURN
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IRF       ºAutor  ³Microsiga           º Data ³  04/15/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Processa Imposto de Renda                                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION IRF()

DBSELECTAREA("SA3")
DBSEEK(XFILIAL("SA3")+MAUT)

DBSELECTAREA("SZZ")
DBGOTOP()

IF SA3->A3_PESSOA == "F"
	WHILE !EOF()             
		If mAut = '001084' //nao recolher ISS de Jose Fiker 20040108
			MVLISS := 0		
		Else
			MVLISS := (MVLBR * 5/100)   
		EndIf
			
		IF MVLBR >= SZZ->ZZ_VALORI .AND. MVLBR <= SZZ->ZZ_VALORF
			MVLIRF := ((MVLBR * (SZZ->ZZ_ALIQ/100)) - SZZ->ZZ_DEDUCAO)
		ENDIF
		DBSELECTAREA("SZZ")
		DBSKIP()
	END
ENDIF

IF MVLIRF < 10
	MVLIRF := 0
ENDIF

RETURN
