#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/ Atualizado por Danilo C S Pala, em 20041026: Nao atualizar data para portadores = 904 920, 930
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: ATUACOM   ³Autor: Solange Nalini         ³ Data:   11/12/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Atulizacao da data de pagto de comissoes - Publicidade     ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat095()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("TITULO,CDESC1,CDESC2,CDESC3,NOMEPROG,CPERG")
SetPrvt("CSTRING,MDATA,CINDEX,CKEY,TREGS,M_MULT")
SetPrvt("P_ANT,P_ATU,P_CNT,M_SAV20,M_SAV7,MVEND")
SetPrvt("MREGPOS,MVAL,MPED,MNUM,MPARC,MREGIAO")
SetPrvt("MCONT,MTP,")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Ambientais                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Da Regiao                            ³
//³ mv_par02             // At‚ Regiao                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo  := PADC("COMISSOES ",74)
cDesc1  := PADC("Este programa atualiza a Data de Pagto das Comissoes - Publicidade",74)
cDesc2  := " "
cDesc3  := " "
nomeprog:= "ATUACOM"
cPerg   := "FAT009"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas.                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !PERGUNTE(cPerg)
	Return
Endif

cString := "SE3"
MDATA   := SPACE(8)

Processa({|| R095Proc()})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R095Proc  ºAutor  ³Microsiga           º Data ³  03/26/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Processamento                                              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R095Proc()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Prepara regua de impressÆo                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DBSELECTAREA("SE3")
cIndex:=CriaTrab(Nil,.F.)
cKey:="E3_FILIAL+DTOS(E3_DATA)+E3_REGIAO+E3_PER+E3_VEND"
Indregua("SE3",cIndex,ckey,,,"Selecionando Registros do Arq")
ProcRegua(LastRec()-Recno())
DBSEEK(XFILIAL()+MDATA)

WHILE !Eof() .and. SE3->E3_FILIAL == xFilial("SE3") .and. DTOS(SE3->E3_DATA) == MDATA
	
	IncProc("Processando Comissao do Titulo " + Alltrim(SE3->E3_SERIE+SE3->E3_NUM))
	MVEND   := SE3->E3_VEND

	DBSKIP()

	MREGPOS := RECNO()

	DBSKIP(-1)

	MVAL    := SE3->E3_BASE
	MPED    := SE3->E3_PEDIDO
	MNUM    := SE3->E3_NUM
	MPARC   := SE3->E3_PARCELA
	DBSELECTAREA("SA3")
	DBSETORDER(1)
	If DBSEEK(XFILIAL()+MVEND)
		IF VAL(SA3->A3_REGIAO) < VAL(MV_PAR01) .OR. VAL(SA3->A3_REGIAO) > VAL(MV_PAR02) .OR. SA3->A3_TIPOVEN <> 'CT'
			DBSELECTAREA("SE3")
			DBSKIP()
			LOOP
		ENDIF
	ENDIF
	
	MREGIAO := SA3->A3_REGIAO
	
	IF SE3->E3_SITUAC == ' '
		IF SE3->E3_BASE < 0
			MCONT := -1
		ELSE
			MCONT := 1
		ENDIF
		DBSELECTAREA("SE1")
		/*dbSetOrder(22)  ///dbSetOrder(15) AP5  //20090114 era(21) //20090723 mp10 indice alterado
		IF DBSEEK(XFILIAL("SE1")+MPED+MNUM+MPARC)*/
		dbSetOrder(1) //20090723 mp10 indice alterado
		IF DBSEEK(XFILIAL("SE1")+SE3->E3_PREFIXO+SE3->E3_NUM+SE3->E3_PARCELA+"NF") //20090723 mp10 indice alterado
         	//20041026 Nao atualizar data para portadores = 904 920, 930
	         if se1->e1_portado = '904' .or. se1->e1_portado = '920' .or. se1->e1_portado = '930'
		         DBSELECTAREA("SE3")
    		     DBSKIP()
        		 LOOP
	         end if //ateh aki 20041026
	
			IF SE1->E1_BASCOM1 <> 0
				MVAL := ((SE1->E1_BASCOM1 - SE1->E1_DESCONT) * MCONT)
				MTP  := SE1->E1_FATPREF
				DBSELECTAREA("SC5")
				DBSETORDER(1)
				If DBSEEK(XFILIAL("SC5")+MPED)
					MTP := SC5->C5_TPTRANS
				ENDIF
				IF VAL(MTP) == 5 .OR. VAL(MTP) == 13
					MVAL := (MVAL - (MVAL * 0.20))
				ENDIF
			ENDIF
		ENDIF
	ENDIF
	
	DBSELECTAREA("SE3")
	RECLOCK("SE3",.F.)
	REPLACE SE3->E3_DATA   WITH MV_PAR03
	REPLACE SE3->E3_REGIAO WITH MREGIAO
	REPLACE SE3->E3_PER    WITH MV_PAR04
	REPLACE SE3->E3_BASE   WITH MVAL
	REPLACE SE3->E3_COMIS  WITH (MVAL * (SE3->E3_PORC/100))
	MSUNLOCK()
	
	DBSELECTAREA("SE3")
	DBGOTO(MREGPOS)
END

DBSELECTAREA("SE3")
RETINDEX("SE3")

RETURN