#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
/*/ Alterado por Danilo C S Pala em 20040712
Danilo C S Pala 20041203 DDATA_PAGTO
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT137   ³Autor: Rosane Lacava Rodrigues³ Data:   29/11/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descricao: Relatorio da Planilha de Pagamentos dos Autores            ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat137()

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CCABEC1")
SetPrvt("CCABEC2,CPROGRAMA,CTAMANHO,LIMITE,NCARACTER,NLASTKEY")
SetPrvt("CDESC1,CDESC2,CDESC3,ARETURN,_ACAMPOS,_CNOME")
SetPrvt("CINDEX1,CKEY,CINDEX2,WNREL,CSTRING,MD")
SetPrvt("XD,CARQ,CINDEX,_CFILTRO,MIND,CONT")
SetPrvt("MPEDIDO,MNOTA,MVEND,CONTINUA,MTES,MPROD")
SetPrvt("MNOME,MAUT,MMOEDA,MTIPO,MDOC,M_PAG")
SetPrvt("L,MBRUTO,MIRF,MISS,MLIQ,MMESANO")
SetPrvt("MVLBR,MVLIRF,MVLISS,MVLLIQ,MACHEI,CTITULO")
SetPrvt("MBCO,MAGEN,MCONTA,MANO,MMES, mpessoa, MTIPOVEN, MCGC")
SetPrvt("nConF, nContJ")
SetPrvt("FMBRUTO, FMIRF, FMISS, FMLIQ")
SetPrvt("JMBRUTO, JMIRF, JMISS, JMLIQ, MSerie, DDATA_PAGTO")


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

cCabec1   := "PRODUTO: 02.00.000"+SPACE(30)+"****** PERIODO: "+Transform(DTOC(MV_PAR01),"@R 99/99/99")+" A "+Transform(DTOC(MV_PAR02),"@R 99/99/99")+" *****"
cCabec2   := "AUTOR  NOME DO AUTOR                              VL.BRUTO    VL.IRF    VL.ISS    VL.LIQUIDO  BANCO    AGENCIA  C/CORRENTE                 CPF/CNPJ"
            //1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
            //         1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16
cPrograma := "PFAT137"
cTamanho  := "G"
//LIMITE    := 132
nCaracter := 12
NLASTKEY  := 0

cDesc1    := PADC("Este programa gera o arquivo de direitos autorais",70)
cDesc2    := PADC("e emite a planilha de pagamento dos autores",70)
cDesc3    := "  "

aReturn   := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }

_aCampos := {{"PRODUTO"  ,"C",15,0} ,;
{"PORC"     ,"N",6, 2} ,;
{"CODAUT"   ,"C",6, 0} ,;
{"NOMEAUT"  ,"C",40,0} ,;
{"MES"      ,"N",2, 0} ,;
{"ANO"      ,"N",4, 0} ,;
{"MOEDA"    ,"C",1, 0} ,;
{"TIPODOC"  ,"C",1, 0} ,;
{"QTDE"     ,"N",6, 0} ,;
{"VLMINIMO" ,"N",10,2} ,;
{"VLIGPM"   ,"N",10,4} ,;
{"VLBRUTO"  ,"N",10,2} ,;
{"CHAVE  "  ,"C",200,0} ,;
{"VLVENDA"  ,"N",10,2} ,;
{"PESSOA"  ,"C",1,0}, ; //20031209
{"TIPOVEN"  ,"C",2,0}, ; //20031210
{"CGC"  ,"C",14,0}} //20040108      


_cNome  := CriaTrab(_aCampos,.t.)

dbUseArea(.T.,, _cNome,"PGAUT",.F.,.F.)

CINDEX1 := CRIATRAB(NIL,.F.)
CKEY    := "CODAUT+PRODUTO" //era codaut+prodf
INDREGUA("PGAUT",CINDEX1,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")

Ctitulo  := "PLANILHA DE AUTORES"
WNREL    := "PFAT137"
CSTRING  := "PGAUT"
WNREL    := SETPRINT(CSTRING,WNREL,CPERG,cTitulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,"G")

SETDEFAULT(aRETURN,CSTRING)

IF NLASTKEY==27 .OR. NLASTKEY==65
	DBCLOSEAREA()
	RETURN
ENDIF

lEnd := .F.

Processa({|lEnd| RptDetail(@lEnd)})
Return










/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT137   ºAutor  ³Microsiga           º Data ³  12/09/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RptDetail()
MD := MV_PAR01
XD := DTOS(MD)

cArq := 'DIRAUTAC.DBF'

dbUseArea(.T.,,cArq,"DIR")

cIndex := CriaTrab(Nil,.F.)
cKey   := "CODAUT+PRODUTO+STR(ANO,4)+STR(MES,2)"
Indregua("DIR",cIndex,ckey,,,"Selecionando Registros do Arq")

cArq   := 'DIRAUTGE.DBF'
dbUseArea(.T.,,cArq,"GER")

cIndex := CriaTrab(Nil,.F.)
cKey   := "CODAUT+MESANO+MOEDA"
Indregua("GER",cIndex,ckey,,,"Selecionando Registros do Arq")

DBSELECTAREA("SE3")

DbSetOrder(4)
DBSEEK(XFILIAL("SE3")+XD,.T.)
PROCREGUA(RECCOUNT())
// Alltrim(SE3->E3_VEND) $ "000145/000205/000448/100091/000015/001008" .or. ;
WHILE !EOF() .AND. SE3->E3_FILIAL == xFilial("SE3") .and. DTOS(SE3->E3_DATA) <= DTOS(MV_PAR02) .and. !lEnd   

	//	If DTOS(SE3->E3_DATA) > DTOS(MV_PAR02) .or. ;
	//     		DTOS(SE3->E3_DATA) > DTOS(MV_PAR02) .or. ;     
  	IF	(SE3->E3_PARCELA <> "A" .and. SE3->E3_PARCELA <> " ")
		DbSelectArea("SE3")
		DbSkip()
		Loop
	EndIf
	
	INCPROC()
	
	IF SE3->E3_SITUAC <> ' ' .OR. SE3->E3_COMIS < 0
		CONT := -1
	ELSE
		CONT := 1
	ENDIF                        

	MPEDIDO := SE3->E3_PEDIDO
	MNOTA   := SE3->E3_NUM
	MVEND   := SE3->E3_VEND                 
	MSerie	:= SE3->E3_SERIE //20040713
	
	DBSELECTAREA("SA3")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SA3")+MVEND)
	IF !FOUND() .OR. SA3->A3_TIPOVEN == 'SP'        
		DBSELECTAREA("SE3")
		DBSKIP()
		LOOP
	ENDIF
	
	DBSELECTAREA("SD2")
	DBSETORDER(3)
	If !DBSEEK(xFilial("SD2")+MNOTA+MSerie) //20040713
		DBSELECTAREA("SE3")
		DBSKIP()
		LOOP
	Else
		While !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .and. SD2->D2_DOC == MNOTA  .and. SD2->D2_SERIE = MSERIE //20040713
			If Alltrim(MPEDIDO) <> Alltrim(SD2->D2_PEDIDO)
				DbSelectArea("SD2")
				DbSkip()
				Loop
			Else
				Exit
			EndIf
		End
	ENDIF
	
	CONTINUA := .T.

	WHILE  !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .AND. MNOTA == SD2->D2_DOC .AND. CONTINUA .and. SD2->D2_SERIE = MSERIE //20040713

		If !(SD2->D2_SERIE)$ "UNI/CUP/CFS" .or. SD2->D2_PEDIDO <> MPEDIDO //20040712 CFS
			DbSelectArea("SD2")
			DbSkip()
			Loop
		EndIf
		
		If Alltrim(MPEDIDO) <> Alltrim(SD2->D2_PEDIDO)
			DbSelectArea("SD2")
			DbSkip()
			Loop
		EndIf
		
		INCPROC("Nota: "+SD2->D2_SERIE+SD2->D2_DOC)
		MTES  := SD2->D2_TES
		MPROD := SD2->D2_COD
		MNOME := SPACE(40)
		
		DBSELECTAREA("SF4")
		DBSETORDER(1)
		DBSEEK(XFILIAL("SF4")+MTES)
		IF "VENDA" $(F4_TEXTO) .OR. "PREST SERV" $(F4_TEXTO)
			DBSELECTAREA("SZY")
			DBSETORDER(1)
			DBSEEK(XFILIAL("SZY")+MPROD)
			IF FOUND()
				WHILE !Eof() .and. SZY->ZY_FILIAL == xFilial("SZY") .and. SZY->ZY_PRODUTO == MPROD
					MAUT   := SZY->ZY_CODAUT
					MMOEDA := SZY->ZY_MOEDA
					MTIPO  := SZY->ZY_TIPO                                                         
					
			   /*		IF	((MAUT == '001149' .or.	MAUT == '001722' .or.	MAUT == '001723') .and. MPROD='0208518') .or. (MAUT == '001068' .and. MPROD='0202774') //20040713
						MsgAlert("Achou")
					EndIf   */
					
					DBSELECTAREA("SA3")
					DBSETORDER(1)
					If DBSEEK(XFILIAL("SA3")+MAUT)
						MNOME  := SA3->A3_NOME
						MDOC   := SA3->A3_TIPODOC
						MPESSOA := SA3->A3_PESSOA //20031209
						MTIPOVEN := SA3->A3_TIPOVEN // 20031210
						MCGC := SA3->A3_CGC // 20040108
					ENDIF
					
					//20041203 -Comissao em data errada
					//	if (SE3->E3_DATA >= STOD("20041025") .and. SE3->E3_DATA < STOD("20041125")) .and. SE3->E3_EMISSAO >STOD("20041025")
					if (SE3->E3_DATA = STOD("20041025"))
						DDATA_PAGTO := STOD("20041125")
					else
						DDATA_PAGTO := SE3->E3_DATA
					endif
					DBSELECTAREA("PGAUT")
					//DbSetOrder(1)
					DBSEEK(MAUT+MPROD)
					IF !FOUND()
						RECLOCK("PGAUT",.T.)
						IF MTIPO == 'N'
							PGAUT->VLVENDA  := (SD2->D2_TOTAL * CONT)
							PGAUT->VLBRUTO  := ((SZY->ZY_PORC/100) * PGAUT->VLVENDA)
							PGAUT->PORC     := SZY->ZY_PORC
						ELSE
							PGAUT->VLVENDA  := ((SD2->D2_QUANT * CONT) * SZY->ZY_PORC)
							PGAUT->VLBRUTO  := PGAUT->VLVENDA
							PGAUT->PORC     := 100.00
						ENDIF
						PGAUT->QTDE     := (SD2->D2_QUANT * CONT)
						PGAUT->PRODUTO  := MPROD
						PGAUT->TIPODOC  := MDOC
						PGAUT->CODAUT   := MAUT
						PGAUT->NOMEAUT  := MNOME
						PGAUT->MOEDA    := MMOEDA
						PGAUT->MES      := MONTH(DDATA_PAGTO)
						PGAUT->ANO      := YEAR(DDATA_PAGTO)
						PGAUT->VLIGPM   := MV_PAR03
						PGAUT->VLMINIMO := MV_PAR04
						PGAUT->CHAVE:=AllTrim(CHAVE)+'/'+MPEDIDO
						PGAUT->PESSOA := MPESSOA //20031209    
						PGAUT->TIPOVEN := MTIPOVEN //20031210
						PGAUT->CGC := MCGC //20040108
						MsUnlock()
					ELSE
						RECLOCK("PGAUT",.F.)
						IF MTIPO == 'N'
							PGAUT->VLVENDA := (PGAUT->VLVENDA + (SD2->D2_TOTAL * CONT))
							PGAUT->VLBRUTO := ((SZY->ZY_PORC/100) * PGAUT->VLVENDA)
						ELSE
							PGAUT->VLVENDA  := PGAUT->VLVENDA + ((SD2->D2_QUANT * CONT) * SZY->ZY_PORC)
							PGAUT->VLBRUTO  := PGAUT->VLVENDA
						ENDIF
						PGAUT->QTDE :=(PGAUT->QTDE  + (SD2->D2_QUANT * CONT))
						PGAUT->CHAVE:=AllTrim(CHAVE)+'/'+MPEDIDO
						MsUnlock()
					ENDIF
					DBSELECTAREA("SZY")
					DBSKIP()
				END
			ENDIF
		ENDIF
		
		DBSELECTAREA("SD2")
		DBSKIP()
		INCPROC()
	ENDDO
	DBSELECTAREA("SE3")
	DBSKIP()
	INCPROC()
ENDDO

M_PAG   := 1
L       := 0
MBRUTO  := 0
MIRF    := 0
MISS    := 0
MLIQ    := 0
MMESANO := STR(MONTH(DDATA_PAGTO),2)+STR(YEAR(DDATA_PAGTO),4)
MMOEDA  := ' '

DBSELECTAREA("PGAUT")
//RETINDEX("PGAUT")
CINDEX2 := CRIATRAB(NIL,.F.)
CKEY    := "PESSOA+NOMEAUT+PRODUTO"
INDREGUA("PGAUT",CINDEX2,CKEY,,,"indexando")

//Gera as planilhas
PlanAutReal()
PlanConsig()
PlanAutDolar()

SET DEVICE TO SCREEN

IF aRETURN[5] ==1
	SET PRINTER TO
	DBCOMMITALL()
	OURSPOOL(WNREL)
ENDIF

MS_FLUSH()

COPY TO PGAUT.DBF

DBCLOSEAREA()    

DBSelectarea("DIR")
DBcloseArea("DIR")

DBSelectarea("GER")
DBcloseArea("GER")

DBSELECTAREA("SE3")
RETINDEX("SE3")

DBSELECTAREA("SA3")
RETINDEX("SA3")

DBSELECTAREA("SD2")
RETINDEX("SD2")

DBSELECTAREA("SF4")
RETINDEX("SF4")

DBSELECTAREA("SB1")
RETINDEX("SB1")
RETURN
       













/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PlanAutRealºAutor  ³Danilo C S Pala    º Data ³  12/10/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Planilha de PAgamento de Direitos de Publicacao em Reais    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/          
Static FUNCTION PlanAutReal()
nContF := 0
nContJ := 0
FMBRUTO := 0
FMIRF   := 0
FMISS   := 0
FMLIQ   := 0
JMBRUTO := 0
JMIRF   := 0
JMISS   := 0
JMLIQ   := 0
DBGOTOP()
PROCREGUA(RECCOUNT())
WHILE !EOF()                                        
/*if Pgaut->codaut ="001115" .or. Pgaut->codaut ="001341" //teste 20031210
	MsgAlert("Achou")
endif*/
	IF PGAUT->TIPOVEN <> "AT" //20031210
		DBSKIP()
		LOOP
	EndIF
    
    cTitulo  := SPACE(09)+"***** PLANILHA DE PAGAMENTOS - DIREITOS PUBLICACAO *****"
	IF L==0 .OR. L>63
		Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
		L:=9
//		@ L,00 PSAY "PAGAR ERNESTO RIPPER E JOSE FIKER DIA 11" //20041203
//		L:= L+1
//		@ L,00 PSAY "PAGAR LUIZ FERNANDO RUDGE E LESLIE AMENDOLARA DIA 20"
//		L:= L+2 //ateh aki
	ENDIF //mudou pra cah
    
	INCPROC("Autor: "+Alltrim(NOMEAUT))
	if PGAUT->PESSOA = "J"
		if nContJ = 0                     
			@ L,00 PSAY "SUBTOTAL DE PESSOA(S) FISICA(S)....: "+ AllTrim(Str(nContF))
			@ L,46 PSAY noround(FMBRUTO,2) PICTURE "@E 999,999.99"
			@ L,57 PSAY noround(FMIRF,2)   PICTURE "@E 999,999.99"
			@ L,67 PSAY noround(FMISS,2)   PICTURE "@E 999,999.99"
			@ L,78 PSAY noround(FMLIQ,2)   PICTURE "@E 999,999.99"
			L := L + 4
		Endif
		nContJ++
	Endif
	nContF++
	
	MAUT   := CODAUT
	MNOME  := NOMEAUT
	MDOC   := TIPODOC
	MVLBR  := 0
	MVLIRF := 0
	MVLISS := 0
	MVLLIQ := 0
	MACHEI := 'N'  
	mpessoa := PESSOA
	MCGC := CGC //20040108

/* consistencia alterada de a3_tipodoc para a3_tipiven a pedido da Raquel Reis
	IF MDOC=='P'
		DBSKIP()
		LOOP
	ENDIF*/

//estava aki
	
	WHILE !Eof() .and. PGAUT->NOMEAUT == MNOME
		IF PGAUT->MOEDA == 'R'
			MVLBR := MVLBR + PGAUT->VLBRUTO
		ENDIF
		DBSKIP()   
	END
	
	DBSELECTAREA("DIR")
	DBSEEK(MAUT)
	WHILE !Eof() .and. DIR->CODAUT == MAUT
		IF (DIR->MESANO<>MMESANO .AND. DIR->MESANO<>SPACE(6)) .OR. (DIR->MES >= MONTH(MV_PAR02) .AND. DIR->ANO >= YEAR(MV_PAR02))

		ELSE
			MVLBR  := MVLBR + (DIR->VLBRIGPM * MV_PAR03)
			MACHEI := 'S'
		ENDIF
		DBSKIP()
	END
	
	DBSELECTAREA("SA3")
	//DBSETORDER(1)
	DBSEEK(XFILIAL("SA3")+MAUT)
	IF FOUND()
		MBCO   := SA3->A3_BCO1
		MAGEN  := SA3->A3_AGENCIA
		MCONTA := SA3->A3_CONTAC
	ENDIF
	
	IRF()
	MVLLIQ := (MVLBR - MVLIRF - MVLISS)
	
	IF MVLLIQ >= MV_PAR04 .AND. MDOC <> "N"
//		@ L,00  PSAY substr(MPESSOA,1,1)     //teste, +2 nos delas
		@ L,00  PSAY MAUT
		@ L,07  PSAY Alltrim(MNOME)
		@ L,47  PSAY noround(MVLBR,2)  PICTURE "@E 999,999.99"
		@ L,57  PSAY noround(MVLIRF,2) PICTURE "@E 999,999.99"
		@ L,67  PSAY noround(MVLISS,2) PICTURE "@E 999,999.99"
		@ L,78  PSAY noround(MVLLIQ,2) PICTURE "@E 999,999.99"
		@ L,95  PSAY MBCO
		@ L,103 PSAY MAGEN
		@ L,114 PSAY MCONTA
		@ L,140 PSAY MCGC
		MBRUTO := MBRUTO + MVLBR
		MIRF   := MIRF   + MVLIRF
		MISS   := MISS   + MVLISS
		MLIQ   := MLIQ   + MVLLIQ
		
		if MPESSOA = "F"
			FMBRUTO := FMBRUTO + MVLBR
			FMIRF   := FMIRF   + MVLIRF
			FMISS   := FMISS   + MVLISS
			FMLIQ   := FMLIQ   + MVLLIQ		
		Else     
			JMBRUTO := JMBRUTO + MVLBR
			JMIRF   := JMIRF   + MVLIRF	
			JMISS   := JMISS   + MVLISS
			JMLIQ   := JMLIQ   + MVLLIQ
		Endif
		
		L:=L+2
		MMOEDA := 'R'
		FIXO()
		IF MACHEI == 'S'
			GRAVA()
		ENDIF
	ENDIF
	IF MVLLIQ < MV_PAR04 .AND. MDOC <> 'N'
		GRAVA()
	ENDIF
	DBSELECTAREA("PGAUT")  
END                      

If nContJ > 0
	@ L,00 PSAY "SUBTOTAL DE PESSOA(S) JURIDICA(S)....: "+ AllTrim(Str(nContJ))
	@ L,46 PSAY noround(JMBRUTO,2) PICTURE "@E 999,999.99"
	@ L,57 PSAY noround(JMIRF,2)   PICTURE "@E 999,999.99"
	@ L,67 PSAY noround(JMISS,2)   PICTURE "@E 999,999.99"
	@ L,78 PSAY noround(JMLIQ,2)   PICTURE "@E 999,999.99"
	L := L + 3
Endif
 
If nContJ <> 0 .and. nContF <> 0
	@ L,00 PSAY "TOTAL GERAL .................: "
	@ L,46 PSAY noround(MBRUTO,2) PICTURE "@E 999,999.99"
	@ L,57 PSAY noround(MIRF,2)   PICTURE "@E 999,999.99"
	@ L,67 PSAY noround(MISS,2)   PICTURE "@E 999,999.99"
	@ L,78 PSAY noround(MLIQ,2)   PICTURE "@E 999,999.99"
EndIf
RETURN


                









/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT137   ºAutor  ³Microsiga           º Data ³  12/10/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Planilha de Consignacao (Consignatario) em Reais           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/    
STATIC FUNCTION PlanConsig()
L      := 0
MBRUTO := 0
MIRF   := 0
MISS   := 0
MLIQ   := 0
MMOEDA := ' '
DBSELECTAREA("PGAUT")
DBGOTOP()
PROCREGUA(RECCOUNT())
WHILE !EOF()
/*if Pgaut->codaut ="001115"  .or. Pgaut->codaut ="001341"  //teste 20031210
	MsgAlert("Achou")
endif*/
	INCPROC("Autor: "+Alltrim(NOMEAUT))
	
	MAUT   := CODAUT
	MNOME  := NOMEAUT
	MDOC   := TIPODOC
	MVLBR  := 0
	MVLIRF := 0
	MVLISS := 0
	MVLLIQ := 0
	MACHEI := 'N'    
	mpessoa := PESSOA     
	MCGC := CGC //20040108
	                                                                      
/* consistencia alterada de a3_tipodoc para a3_tipiven a pedido da Raquel Reis	
/*	IF MDOC<>'P'
		DBSKIP()
		LOOP
	ENDIF*/
	IF PGAUT->TIPOVEN <> "CO" //20031210
		DBSKIP()
		LOOP
	EndIF
	
	cTitulo  := SPACE(09)+"***** PLANILHA DE PAGAMENTOS - CONSIGNACAO *****"
	IF L==0 .OR. L>63
		Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
		L:=9
	ENDIF
	
	WHILE !Eof() .and. PGAUT->NOMEAUT == MNOME
		IF PGAUT->MOEDA == 'R'
			MVLBR := MVLBR + PGAUT->VLBRUTO
		ENDIF
		DBSKIP()
	ENDDO
	
	DBSELECTAREA("DIR")
	DBSEEK(MAUT)
	WHILE !Eof() .and. DIR->CODAUT == MAUT
		IF (DIR->MESANO<>MMESANO .AND. DIR->MESANO<>SPACE(6)) .OR. (DIR->MES >= MONTH(MV_PAR02) .AND. DIR->ANO >= YEAR(MV_PAR02))
			DBSKIP()
			LOOP
		ENDIF
		MVLBR  := MVLBR + (DIR->VLBRIGPM * MV_PAR03)
		MACHEI := 'S'
		DBSELECTAREA("DIR")
		DBSKIP()
	END
	
	DBSELECTAREA("SA3")
	DBSETORDER(01)
	IF DBSEEK(XFILIAL()+MAUT)
		MBCO   := SA3->A3_BCO1
		MAGEN  := SA3->A3_AGENCIA
		MCONTA := SA3->A3_CONTAC   
	ENDIF
	
	IRF()
	
	MVLLIQ := (MVLBR - MVLIRF - MVLISS)
	
	IF MVLLIQ >= MV_PAR04 .AND. MDOC <> "N"
		@ L,00  PSAY MAUT
		@ L,07  PSAY MNOME
		@ L,46  PSAY noround(MVLBR,2)  PICTURE "@E 999,999.99"
		@ L,57  PSAY 0      PICTURE "@E 999,999.99"
		@ L,67  PSAY 0      PICTURE "@E 999,999.99"
		@ L,78  PSAY noround(MVLBR,2)  PICTURE "@E 999,999.99"
		@ L,95  PSAY MBCO
		@ L,103 PSAY MAGEN
		@ L,114 PSAY MCONTA                      
		@ L,140 PSAY MCGC
		MBRUTO := MBRUTO + MVLBR
		MIRF   := 0
		MISS   := 0
		MLIQ   := MBRUTO
		L:=L+2
		MMOEDA := 'R'
		FIXO()
		IF MACHEI == 'S'
			GRAVA()
		ENDIF
	ENDIF
	IF MVLLIQ < MV_PAR04 .AND. MDOC <> 'N'
		GRAVA()
	ENDIF
	DBSELECTAREA("PGAUT")
END

@ L,00 PSAY "TOTAL GERAL .................: "
@ L,46 PSAY noround(MBRUTO,2) PICTURE "@E 999,999.99"
@ L,57 PSAY noround(MIRF,2)   PICTURE "@E 999,999.99"
@ L,67 PSAY noround(MISS,2)   PICTURE "@E 999,999.99"
@ L,78 PSAY noround(MLIQ,2)   PICTURE "@E 999,999.99"
RETURN














/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PlanAutDolarºAutor  ³Danilo C S PAla     º Data ³  12/10/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Planilha de direitos de publicacao (Autores) em dolar      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/            
Static Function PlanAutDolar()
L      := 0
MBRUTO := 0
MIRF   := 0
MISS   := 0

DBSELECTAREA("PGAUT")
//DBSETORDER(02)
DBGOTOP()
PROCREGUA(RECCOUNT())
WHILE !EOF()
	INCPROC("Autor: "+Alltrim(NOMEAUT))
	
	MAUT   := CODAUT
	MNOME  := NOMEAUT
	MDOC   := TIPODOC
	MVLBR  := 0
	MVLIRF := 0
	MVLISS := 0      
	mpessoa := PESSOA
	MCGC := CGC //20040108	
	/* consistencia alterada de a3_tipodoc para a3_tipiven a pedido da Raquel Reis
	IF MDOC=='P'
		DBSKIP()
		LOOP
	ENDIF*/
	IF PGAUT->TIPOVEN <> "AT" //20031210
		DBSKIP()
		LOOP
	EndIF
	
	cTitulo  := SPACE(09)+"***** PLANILHA DE PAGAMENTOS - DIREITOS PUBLICACAO *****"
	IF L==0 .OR. L>65
		Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
		L:=9
	ENDIF
	
	WHILE PGAUT->NOMEAUT == MNOME
		IF PGAUT->MOEDA == 'D'
			MVLBR := MVLBR + (PGAUT->QTDE * (PGAUT->PORC/100))
		ENDIF
		DBSELECTAREA("PGAUT")
		DBSKIP()
	END
	
	DBSELECTAREA("SA3")
	//DBSETORDER(01)
	IF DBSEEK(XFILIAL("SA3")+MAUT)
		MBCO   := SA3->A3_BCO1
		MAGEN  := SA3->A3_AGENCIA
		MCONTA := SA3->A3_CONTAC
	ENDIF
	
	IF MDOC <> "N" .AND. MVLBR > 0
		@ L,00  PSAY MAUT
		@ L,07  PSAY MNOME
		@ L,46  PSAY noround(MVLBR,2)  PICTURE "@E 999,999.99"
		@ L,57  PSAY noround(MVLIRF,2) PICTURE "@E 999,999.99"
		@ L,67  PSAY noround(MVLISS,2) PICTURE "@E 999,999.99"
		@ L,78  PSAY noround(MVLBR,2)  PICTURE "@E 999,999.99"
		@ L,95  PSAY MBCO
		@ L,103 PSAY MAGEN
		@ L,114 PSAY MCONTA         
		@ L,140 PSAY MCGC
		MBRUTO := MBRUTO + MVLBR
		MIRF   := MIRF   + MVLIRF
		MISS   := MISS   + MVLISS
		L:=L+2
		MMOEDA := 'D'
		MVLLIQ := MVLBR
		FIXO()
	ENDIF
	DBSELECTAREA("PGAUT")
END

@ L,00 PSAY "TOTAL GERAL EM DOLAR U$ .....: "
@ L,46 PSAY noround(MBRUTO,2) PICTURE "@E 999,999.99"
@ L,57 PSAY noround(MIRF,2)   PICTURE "@E 999,999.99"
@ L,67 PSAY noround(MISS,2)   PICTURE "@E 999,999.99"
@ L,78 PSAY noround(MBRUTO,2) PICTURE "@E 999,999.99"
L:= L+2
@ L,00 PSAY "OBSERVACAO: PAGAMENTO EM DOLAR - U$"
RETURN









/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT137   ºAutor  ³Microsiga           º Data ³  12/09/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION IRF()
DBSELECTAREA("SZZ")
DBGOTOP()

IF SA3->A3_PESSOA == "F"
	WHILE !EOF()
		If mAut = '001084' //nao recolher ISS de Jose Fiker 20031210
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












/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT137   ºAutor  ³Microsiga           º Data ³  12/09/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION GRAVA()
DBSELECTAREA("PGAUT")
//DBSETORDER(02)
DBSEEK(mPESSOA+MNOME) //20031209

WHILE !Eof() .and. PGAUT->NOMEAUT == MNOME
	
	IF PGAUT->MOEDA == 'R'
		MPROD := PGAUT->PRODUTO
		MANO  := PGAUT->ANO //20041203
		MMES  := PGAUT->MES //20041203
		
		DBSELECTAREA("DIR")
		//DBSETORDER(01)
		IF DBSEEK (MAUT+MPROD+STR(MANO,4)+STR(MMES,2))
			RECLOCK("DIR",.F.)
			DIR->CODAUT   := MAUT
			DIR->NOMEAUT  := PGAUT->NOMEAUT   // 20/05/02 - Inclusao do Nome do Autor no arquivo "DIRAUTAC.DBF"
			DIR->MES      := MMES
			DIR->ANO      := MANO
			DIR->PRODUTO  := MPROD
			DIR->QTDE     := PGAUT->QTDE
			DIR->VLVENDA  := PGAUT->VLVENDA
			DIR->VLBRUTO  := PGAUT->VLBRUTO
			DIR->VLIGPM   := MV_PAR03
			DIR->VLBRIGPM := (PGAUT->VLBRUTO / MV_PAR03)
			MSUNLOCK()
		ELSE
			RECLOCK("DIR",.T.)
			DIR->CODAUT   := MAUT
			DIR->NOMEAUT  := PGAUT->NOMEAUT   // 20/05/02 - Inclusao do Nome do Autor no arquivo "DIRAUTAC.DBF"
			DIR->MES      := MMES
			DIR->ANO      := MANO
			DIR->PRODUTO  := MPROD
			DIR->QTDE     := PGAUT->QTDE
			DIR->VLVENDA  := PGAUT->VLVENDA
			DIR->VLBRUTO  := PGAUT->VLBRUTO
			DIR->VLIGPM   := MV_PAR03
			DIR->VLBRIGPM := (PGAUT->VLBRUTO / MV_PAR03)
			MSUNLOCK()
		ENDIF
	ENDIF
	DBSELECTAREA("PGAUT")
	DBSKIP()
END
RETURN













/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT137   ºAutor  ³Microsiga           º Data ³  12/09/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION FIXO()
DBSELECTAREA("GER")
//DBSETORDER(1)
DBSEEK(MAUT+MMESANO+MMOEDA)
IF FOUND()
	RECLOCK("GER",.F.)
	GER->CODAUT  := MAUT
	GER->VLBRUTO := MVLBR
	GER->VLIRF   := MVLIRF
	GER->VLISS   := MVLISS
	GER->VLLIQ   := MVLLIQ
	GER->MESANO  := MMESANO
	GER->MOEDA   := MMOEDA
	GER->(MSUNLOCK())
ELSE
	RECLOCK("GER",.T.)
	GER->CODAUT  := MAUT
	GER->VLBRUTO := MVLBR
	GER->VLIRF   := MVLIRF
	GER->VLISS   := MVLISS
	GER->VLLIQ   := MVLLIQ
	GER->MESANO  := MMESANO
	GER->MOEDA   := MMOEDA
	GER->(MSUNLOCK())
ENDIF
RETURN