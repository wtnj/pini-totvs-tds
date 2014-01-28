#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ฑฑ
ฑฑณPrograma: RECAUT    ณAutor: Rosane Lacava Rodriguesณ Data:   09/12/99 ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณDescriฦo: Recibos e Demonstrativos de direitos de Publicacao         ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณUso      : Mขdulo de Faturamento                                      ณ ฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู ฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function Rfat040()

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,MDT")
SetPrvt("M_PAG,MMES,MANO,MMESANO,CTITULO,CPROGRAMA")
SetPrvt("CTAMANHO,cLIMITE,NCARACTER,NLASTKEY,CDESC1,CDESC2")
SetPrvt("CDESC3,ARETURN,CARQ,CINDEX,CKEY,WNREL")
SetPrvt("CSTRING,MAUT,MNOME,MMOEDA,MDOC,MVMIN")
SetPrvt("MVIGPM,MVLBR,MVLLIQ,MVLISS,MQTDE,MTLIQ")
SetPrvt("MTBR,MFLAG,MPROD,L,MVLIRF,XQTDE")
SetPrvt("XLIQ,XBR,MTIT,MTIT1,MTIT2,MTIT3")
SetPrvt("MTIT4,")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Vari veis utilizadas para parametros     ณ
//ณ mv_par01             //Periodo Inicial   ณ
//ณ mv_par02             //Periodo Final     ณ
//ณ mv_par03             //Data Pagamento    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
CPERG := 'PFAT49'
IF !PERGUNTE(CPERG)
	RETURN
ENDIF

MDT       := DDATABASE
M_PAG     := 1
MMES      := MONTH(MV_PAR02)
MANO      := YEAR(MV_PAR02)
MMESANO   := STR(MONTH(MV_PAR02),2)+STR(YEAR(MV_PAR02),4)

cTitulo   := SPACE(04)+"***** RECIBOS E DEMONSTRATIVOS DE DIREITOS DE PUBLICACAO *****"
cPrograma := "RECAUT"
cTamanho  := "P"
// LIMITE    := 132
cLIMITE    := 80
nCaracter := 12
NLASTKEY  := 0

cDesc1    := PADC("Este programa gera os recibos e demonstrativos",70)
cDesc2    := PADC("de direitos de publicacao",70)
cDesc3    := "  "

aRETURN   := {"Especial", 1,"Administracao", 1, 2, 1," ",1 }

If Select("PGAUT") <> 0
	DbSelectArea("PGAUT")
	DbCloseArea()
EndIf

cArq      := 'PGAUT.DBF'
dbUseArea(.T.,,cArq,"PGAUT")
MHORA := TIME()
WNREL     := "RECAUT_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING   := "PGAUT"
WNREL     := SETPRINT(CSTRING,WNREL,CPERG,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
SETDEFAULT(aRETURN,CSTRING)

cIndex    := CriaTrab(Nil,.F.)
cKey      := "NOMEAUT"
Indregua("PGAUT",cIndex,ckey,,,"Selecionando Registros do Arq")

IF NLASTKEY == 27 .OR. NLASTKEY == 65
	DBCLOSEAREA()
	RETURN
ENDIF

Processa({|| RptDetail()})

Return

Static Function RptDetail()

If Select("DIR") <> 0
	DbSelectArea("DIR")
	DbCloseArea()
EndIf

cArq     := 'DIRAUTAC.DBF'
dbUseArea(.T.,,cArq,"DIR")
cIndex   := CriaTrab(Nil,.F.)
cKey     := "CODAUT+PRODUTO+STR(ANO,4)+STR(MES,2)"
Indregua("DIR",cIndex,ckey,,,"Selecionando Registros do Arq")

DBSELECTAREA("PGAUT")
//DBSETORDER(01)
DBGOTOP()
PROCREGUA(RECCOUNT())
WHILE !EOF() .AND. PGAUT->MES == MONTH(MV_PAR02) .AND. PGAUT->ANO == YEAR(MV_PAR02)
	INCPROC("Lendo Autor: "+Alltrim(NOMEAUT))
	MVLIRF := 0
	MAUT   := CODAUT
	MNOME  := NOMEAUT
	MMOEDA := 'R$'
	MDOC   := TIPODOC
	MVMIN  := VLMINIMO
	MVIGPM := VLIGPM
	MVLBR  := 0
	MVLLIQ := 0
	MVLISS := 0
	MQTDE  := 0
	MTLIQ  := 0
	MTBR   := 0
	MFLAG  := 'P'
	
	//20060801
/*	if MAUT =="002015"
   		MSGALERT("achou")
	endif */
	IF MDOC=='P'
		DBSKIP()
		LOOP
	ENDIF
	
	WHILE !Eof() .and. PGAUT->NOMEAUT == MNOME
		IF PGAUT->MOEDA == 'R'
			MVLBR := MVLBR + PGAUT->VLBRUTO
		ENDIF
		DBSKIP()
	END
	
	DBSELECTAREA("DIR")
	DBSEEK(MAUT)
	WHILE !Eof() .and. DIR->CODAUT == MAUT
		IF (DIR->MESANO#MMESANO .AND. DIR->MESANO#SPACE(6)) .OR. (DIR->MES>=MONTH(MV_PAR02) .AND. DIR->ANO>=YEAR(MV_PAR02))
			DBSKIP()
			LOOP
		ENDIF
		MVLBR := MVLBR + (DIR->VLBRIGPM * MVIGPM)
		MFLAG := 'A'
		DBSKIP()
	END
	
	IRF()

	MVLLIQ := (MVLBR - MVLIRF - MVLISS)
	
	IF MVLLIQ >= MVMIN .AND. MDOC <> 'N'
		IMPR()
	ENDIF
	DBSELECTAREA("PGAUT")
END

DBSELECTAREA("PGAUT")
DBGOTOP()
PROCREGUA(RECCOUNT())
WHILE !EOF() .AND. PGAUT->MES == MONTH(MV_PAR02) .AND. PGAUT->ANO == YEAR(MV_PAR02)
	INCPROC("Lendo Autor: "+ Alltrim(NOMEAUT))
	MAUT   := CODAUT
	MNOME  := NOMEAUT
	MDOC   := TIPODOC
	MMOEDA := 'U$'
	MVLBR  := 0
	MVLLIQ := 0
	MVLISS := 0
	MQTDE  := 0
	MTLIQ  := 0
	MTBR   := 0
	MFLAG  := 'P'
	
	WHILE !Eof() .and. PGAUT->NOMEAUT == MNOME
		IF PGAUT->MOEDA == 'D'
			MVLBR := MVLBR + (PGAUT->QTDE * (PGAUT->PORC/100))
		ENDIF
		DBSKIP()
	END
	
	IF MVLBR > 0 .AND. MDOC <> 'N'
		MVLLIQ := MVLBR
		DBSELECTAREA("SA3")
		DBSETORDER(01)
		DBSEEK(XFILIAL()+MAUT)
		IF FOUND()
			CABECALHO()
			DBSELECTAREA("PGAUT")
			DBSETORDER(01)
			DBSEEK(MNOME)
			IF FOUND()
				WHILE !Eof() .and. PGAUT->NOMEAUT == MNOME
					IF PGAUT->MOEDA == 'D'
						@ L,01 PSAY SUBS(PGAUT->PRODUTO,1,8)
						MPROD := PGAUT->PRODUTO
						DBSELECTAREA("SB1")
						DBSETORDER(01)
						DBSEEK(XFILIAL()+MPROD)
						IF FOUND()
							@ L,10 PSAY SUBS(SB1->B1_DESC,1,30)
						ENDIF
						DBSELECTAREA("PGAUT")
						@ L,41 PSAY QTDE              PICTURE "@E 999999"
						@ L,48 PSAY QTDE              PICTURE "@E 999,999.99"
						@ L,60 PSAY PORC              PICTURE "@E 999.99"
						@ L,69 PSAY (QTDE*(PORC/100)) PICTURE "@E 999,999.99"
						MQTDE := MQTDE + QTDE
						MTLIQ := MTLIQ + QTDE
						MTBR  := MTBR  + (QTDE*(PORC/100))
						L := L+2
					ENDIF
					DBSKIP()
				END
				FIM()
			ENDIF
		ENDIF
	ENDIF
	DBSELECTAREA("PGAUT")
END

SET DEVI TO SCREEN

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

RETURN
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณIRF ()    บAutor  ณMicrosiga           บ Data ณ  04/15/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณProcessa IRF do Autor                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION IRF()

DBSELECTAREA("SA3")
DBSEEK(XFILIAL("SA3")+MAUT)

DBSELECTAREA("SZZ")
DBGOTOP()
IF SA3->A3_PESSOA == "F"
	WHILE !EOF()
		
		MVLISS := (MVLBR * 5/100)
		
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
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณIMPR()0   บAutor  ณMicrosiga           บ Data ณ  04/15/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressao                                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION IMPR()

DBSELECTAREA("SA3")
DBSETORDER(1)
IF DBSEEK(XFILIAL("SA3")+MAUT)
	CABECALHO()
	DBSELECTAREA("PGAUT")
	IF DBSEEK(MNOME)
		WHILE PGAUT->NOMEAUT == MNOME
			IF MFLAG == 'P'
				IF PGAUT->MOEDA == 'R'
					XQTDE := 0
					XLIQ  := 0
					XBR   := 0
					@ L,01 PSAY SUBS(PGAUT->PRODUTO,1,8)
					MPROD := PGAUT->PRODUTO
					DBSELECTAREA("SB1")
					DBSETORDER(01)
					IF DBSEEK(XFILIAL()+MPROD)
						@ L,10 PSAY SUBS(SB1->B1_DESC,1,30)
					ENDIF
					DBSELECTAREA("DIR")
					DBSEEK(MAUT+MPROD)
					WHILE !Eof() .and. DIR->CODAUT+DIR->PRODUTO == MAUT+MPROD
						IF (DIR->MESANO#MMESANO .AND. DIR->MESANO#SPACE(6)) .OR. (DIR->MES>=MONTH(MV_PAR02) .AND. DIR->ANO>=YEAR(MV_PAR02))
							DBSKIP()
							LOOP
						ENDIF
						XQTDE := QTDE + XQTDE
						XLIQ  := VLVENDA + XLIQ
						XBR   := VLBRUTO + XBR
						DBSKIP()
					END
					DBSELECTAREA("PGAUT")
					@ L,41 PSAY (QTDE+XQTDE)    PICTURE "@E 999999"
					@ L,48 PSAY (VLVENDA+XLIQ)  PICTURE "@E 999,999.99"
					@ L,60 PSAY PORC            PICTURE "@E 999.99"
					@ L,69 PSAY (VLBRUTO+XBR)   PICTURE "@E 999,999.99"
					MQTDE := MQTDE + (QTDE+XQTDE)
					MTLIQ := MTLIQ + (VLVENDA+XLIQ)
					MTBR  := MTBR  + (VLBRUTO+XBR)
					L := L+2
				ENDIF
			ENDIF
			DBSKIP()
		END
		FIM()
	ENDIF
ENDIF

RETURN

Static FUNCTION CABECALHO()
@ 00,00 PSAY AVALIMP(80)
@ 01,01 PSAY REPLICATE('-',79)

IF MDOC == 'R'
	@ 02,37 PSAY "RECIBO"
	MTIT  := "VALOR DOS DIREITOS AUTORAIS"
	MTIT1 := "Recebi da Editora Pini Ltda - CNPJ 60.859.519/0001-51, estabelecida a Rua "
	MTIT2 := "Anhaia, 964 - Bom Retiro - Sao Paulo, a importancia liquida supra citada, "
	MTIT3 := "ref a Direitos de Publicacao do mes "+STR(MMES,2)+"/"+STR(MANO,4)+", conforme demonstrativo "
	IF MFLAG == 'P'
		MTIT4 := "abaixo :"
	ELSE
		MTIT4 := "anexo :"
	ENDIF
ELSE
	@ 02,33 PSAY "DEMONSTRATIVO"
	MTIT  := "DEMONSTRATIVO DE PAGAMENTOS"
	MTIT1 := " "
	MTIT2 := SPACE(28) + "DEMONSTRATIVO DE VENDAS"
	MTIT3 := " "
	IF MFLAG == 'P'
		MTIT4 := " "
	ELSE
		MTIT4 := SPACE(36) + "ANEXO"
	ENDIF
ENDIF
@ 03,01 PSAY REPLICATE('-',79)
@ 05,32 PSAY "DADOS DO AUTOR"
@ 07,01 PSAY "NOME....: " + MNOME
@ 08,01 PSAY "ENDERECO: " + SA3->A3_END
@ 09,01 PSAY "CIDADE..: " + SA3->A3_MUN+SPACE(5)+'-'+SPACE(5)+SA3->A3_EST
@ 10,01 PSAY "CEP.....: " + SUBS(SA3->A3_CEP,1,5)+'-'+SUBS(SA3->A3_CEP,6,3)
@ 11,01 PSAY "CIC/CGC.: " + SA3->A3_CGC
@ 12,01 PSAY REPLICATE('-',79)
@ 14,26 PSAY MTIT
@ 16,01 PSAY "VALOR BRUTO .....: " + MMOEDA
@ 16,23 PSAY MVLBR  PICTURE "@E 999,999.99"
@ 18,01 PSAY "DESCONTOS:"
@ 20,01 PSAY "IMPOSTO DE RENDA : " + MMOEDA
@ 20,23 PSAY MVLIRF PICTURE "@E 999,999.99"
@ 21,01 PSAY "I.S.S ...........: " + MMOEDA
@ 21,23 PSAY MVLISS PICTURE "@E 999,999.99"
@ 21,60 PSAY (MVLIRF+MVLISS) PICTURE "@E 999,999.99"
@ 23,01 PSAY "VALOR LIQUIDO ...: " + MMOEDA
@ 23,23 PSAY MVLLIQ PICTURE "@E 999,999.99"
@ 25,01 PSAY "DATA PAGAMENTO ..: " + DTOC(MV_PAR03)
@ 26,01 PSAY REPLICATE('-',79)
@ 27,01 PSAY MTIT1
@ 28,01 PSAY MTIT2
@ 29,01 PSAY MTIT3+MTIT4
@ 30,01 PSAY REPLICATE('-',8)+' '+REPLICATE('-',30)+' '+REPLICATE('-',6)
@ 30,48 PSAY REPLICATE('-',10)+' '+REPLICATE('-',9)+' '+REPLICATE('-',11)
IF MFLAG == 'P'
	@ 31,01 PSAY "CODIGO"
	@ 31,10 PSAY "LIVRO"
	@ 31,42 PSAY "QTDE"
	@ 31,48 PSAY "VL. VENDAS"
	@ 31,59 PSAY "DIR PUBL."
	@ 31,69 PSAY "DIR PUBLIC."
	@ 32,41 PSAY "VENDID"
	@ 32,49 PSAY "LIQUIDO"
	@ 32,60 PSAY "PERCENT"
	@ 32,71 PSAY "BRUTO"
	@ 33,01 PSAY REPLICATE('-',8)+' '+REPLICATE('-',30)+' '+REPLICATE('-',6)
	@ 33,48 PSAY REPLICATE('-',10)+' '+REPLICATE('-',9)+' '+REPLICATE('-',11)
ENDIF

L := 35

RETURN

Static FUNCTION FIM()
IF MFLAG == 'P'
	@ L,01 PSAY "TOTAIS .............................: "
	@ L,41 PSAY MQTDE PICTURE "@E 999999"
	@ L,48 PSAY MTLIQ PICTURE "@E 999,999.99"
	@ L,69 PSAY MTBR  PICTURE "@E 999,999.99"
ENDIF
L := L+5
@ L,01 PSAY "SAO PAULO, "
@ L,12 PSAY MDT
@ L,55 PSAY REPLICATE('_',24)
L := L+1
@ L,55 PSAY "Assinatura do favorecido"
L := L+3
@ L,27   PSAY    "FAVOR DEVOLVER UMA VIA ASSINADA"
@ L+1,24 PSAY "A/C JOSIANI DE SOUZA - MANUAIS TECNICOS"   
@ L+2,32 PSAY        "EDITORA PINI LTDA"
@ L+3,27 PSAY   "RUA ANHAIA 964 - BOM RETIRO"
@ L+4,29 PSAY     "01130-900 SAO PAULO  SP"
RETURN
