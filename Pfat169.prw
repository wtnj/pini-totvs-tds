#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/ 
20070207 Danilo C S Pala nao inserir mais pois quebra a chave primaria!!! nao tem consistencia na diraut
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT169   ³Autor: DANILO C S PALA        ³ Data:   20060829 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descricao: ATUALIZAR ZZV COM PAGAMENTO DOS CLIENTES COM BASE NAS      ³ ±±
±±³ COMISSOES (SE3)         											 ³ ±±
sp_dirautpgcli(in_datade => :in_datade,
                 in_dataate => :in_dataate);
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat169()

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
SetPrvt("JMBRUTO, JMIRF, JMISS, JMLIQ, MSerie, _ACAMPOSA, _CNOMEA, mprod_old, mvend_old, mpedido_old")
SetPrvt("MZZVSTATUS, MZZVDTCANC")


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //BAIXAS DE         ³
//³ mv_par02             //BAIXAS ATE        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//CPERG := 'PFAT48'
CPERG := 'FAT169'
IF !PERGUNTE(CPERG)
	RETURN
ENDIF

lEnd := .F.

//Processa({|lEnd| RptDetail(@lEnd)})
Processa({|lEnd| ProcArq(@lEnd)})
Return










/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT169   ºAutor  ³DANILO C S PALA     º Data ³  20060829   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RptDetail()
MD := MV_PAR01
XD := DTOS(MD)

DBSELECTAREA("SE3")
_cFiltro := "E3_FILIAL == '"+xFilial("SE3")+"'"
_cFiltro := _cFiltro+".and.DTOS(E3_DATA)>=DTOS(CTOD('"+DTOC(MV_PAR01)+"'))"
_cFiltro := _cFiltro+".and.DTOS(E3_DATA)<=DTOS(CTOD('"+DTOC(MV_PAR02)+"'))"
_cFiltro := _cFiltro+".and.(E3_PARCELA=='A' .OR. E3_PARCELA == ' ') "
_cFiltro := _cFiltro+".and.(E3_PREFIXO <>'LIV' .AND. E3_PREFIXO <>'CP0' .AND. E3_PREFIXO <>'SNF' )"
CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="E3_FILIAL+DTOS(E3_EMISSAO)+E3_NUM+E3_SERIE"
INDREGUA("SE3",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")


DBGOTOP()
PROCREGUA(RECCOUNT())
WHILE !EOF() .AND. SE3->E3_FILIAL == xFilial("SE3") .and. DTOS(SE3->E3_DATA) <= DTOS(MV_PAR02) .and. !lEnd   

  	IF	(SE3->E3_PARCELA <> "A" .and. SE3->E3_PARCELA <> " ")
		DbSelectArea("SE3")
		DbSkip()
		Loop
	EndIf
	
	INCPROC()
	
	IF SE3->E3_SITUAC <> ' ' .OR. SE3->E3_COMIS < 0
		CONT := -1
		MZZVSTATUS := "4" //1 = ABERTO, 2= PAGO CLIENTE, 3 = PAGO AUTOR, 4 = CANCELADO CLIENTE
		MZZVDTCANC := SE3->E3_DATA
	ELSE
		CONT := 1
		MZZVSTATUS := "2"  //1 = ABERTO, 2= PAGO CLIENTE, 3 = PAGO AUTOR, 4 = CANCELADO CLIENTE
		MZZVDTCANC := CTOD('  /  /  ')
	ENDIF                        

	MPEDIDO := SE3->E3_PEDIDO
	MNOTA   := SE3->E3_NUM
	MVEND   := SE3->E3_VEND                 
	MSerie	:= SE3->E3_SERIE 
	
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
	If !DBSEEK(xFilial("SD2")+MNOTA+MSerie)
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
		IF SF4->F4_DUPLIC == "S"

			  		/*IF (trim(MPROD)='02021245') //20060802
						MsgAlert("Achou")
					EndIf */					
			   		If Alltrim(MPEDIDO) = Alltrim(mpedido_old) .AND. (ALLTRIM(MVEND_OLD) = ALLTRIM(MAUT))   .AND. (ALLTRIM(MPRODUTO_OLD) = ALLTRIM(MPROD)) //20050323
						dbselectarea("AUDIT")
						RECLOCK("AUDIT",.T.)
							AUDIT->PEDIDO :=     MPEDIDO           
							AUDIT->PRODUTO := MPROD
							AUDIT->VEND := MAUT
						MsUnlock()                                                                                           
					
						
						DbSelectArea("SD2")
				  		DbSkip()
						Loop
					EndIf    

			DBSELECTAREA("SZY")
			DBSETORDER(1)
			DBSEEK(XFILIAL("SZY")+MPROD)
			IF FOUND()
				WHILE !Eof() .and. SZY->ZY_FILIAL == xFilial("SZY") .and. SZY->ZY_PRODUTO == MPROD
					MAUT   := SZY->ZY_CODAUT
					MMOEDA := SZY->ZY_MOEDA
					MTIPO  := SZY->ZY_TIPO                                                         
					
/*						if alltrim(mpedido)= '397872' //20050323
							 MsgAlert("Achou")
						endif */

					DBSELECTAREA("SA3")
					DBSETORDER(1)
					If DBSEEK(XFILIAL("SA3")+MAUT)
						MNOME  := SA3->A3_NOME
						MDOC   := SA3->A3_TIPODOC
						MPESSOA := SA3->A3_PESSOA //20031209
						MTIPOVEN := SA3->A3_TIPOVEN // 20031210
						MCGC := SA3->A3_CGC // 20040108
					ENDIF                                   
					
					dbselectarea("PGAUDIT")
						RECLOCK("PGAUDIT",.T.)
							PGAUDIT->PEDIDO :=     MPEDIDO
							PGAUDIT->PRODUTO := MPROD
							PGAUDIT->VEND := MAUT
						MsUnlock()   
					

						DBSELECTAREA("ZZV")
						DbSetOrder(5)     // ZZV_FILIAL ZZV_NF ZZV_SERIE ZZV_ITEM ZZV_PRODUT ZZV_AUTOR
						DBSEEK(xfilial("ZZV") + SD2->D2_DOC + SD2->D2_SERIE + SD2->D2_ITEM + SD2->D2_COD + SZY->ZY_CODAUT)
						IF !FOUND()  // nao existia
			   				RECLOCK("ZZV",.T.)
								ZZV->ZZV_FILIAL		:= XFILIAL("ZZV")
								ZZV->ZZV_NF			:= SD2->D2_DOC
								ZZV->ZZV_SERIE 		:= SD2->D2_SERIE
								ZZV->ZZV_ITEM		:= val(SD2->D2_ITEM)  //20060828 ainda e numero, converter para char
								ZZV->ZZV_PEDIDO 	:= SD2->D2_PEDIDO
								ZZV->ZZV_PRODUT		:= SD2->D2_COD
								ZZV->ZZV_AUTOR		:= SZY->ZY_CODAUT
								ZZV->ZZV_EMISSA		:= SD2->D2_EMISSAO
								ZZV->ZZV_DTPGCL		:= SE3->E3_DATA // DATA DO PAGAMENTO DA COMISSAO AO VENDEDOR, LOGO DO DIREITO AUTORAL
								//ZZV->ZZV_DTPGAU
								ZZV->ZZV_VALNF		:= SD2->D2_TOTAL * CONT
								//ZZV->ZZV_VALAUT
								//ZZV->ZZV_ALIQ		:= mv_par03
								ZZV_PORC			:= SZY->ZY_PORC
								ZZV->ZZV_STATUS		:= MZZVSTATUS 		//1 = ABERTO, 2= PAGO CLIENTE, 3 = PAGO AUTOR, 4 = CANCELADO CLIENTE
								ZZV->ZZV_QTD		:= SD2->D2_QUANT * CONT
								ZZV->ZZV_MOEDA		:= SZY->ZY_MOEDA
								ZZV->ZZV_DTCANC		:= MZZVDTCANC
								ZZV->ZV_TPAUT		:= MTIPOVEN   
								ZZV->ZZV_DESCON		:= (((SD2->D2_COMIS1 + SD2->D2_COMIS2 + SD2->D2_COMIS3 + SD2->D2_COMIS4 + SD2->D2_COMIS5) /100) * SD2->D2_TOTAL) * CONT//20061106
							MsUnlock()
					ELSE //encontrou                    
						IF ZZV->ZZV_STATUS == '1'
			   				RECLOCK("ZZV",.F.)
			   					ZZV->ZZV_DTPGCL		:= SE3->E3_DATA // DATA DO PAGAMENTO DA COMISSAO AO VENDEDOR, LOGO DO DIREITO AUTORAL
								ZZV->ZZV_STATUS		:= MZZVSTATUS 		//1 = ABERTO, 2= PAGO CLIENTE, 3 = PAGO AUTOR, 4 = CANCELADO CLIENTE
								ZZV_PORC			:= SZY->ZY_PORC
								ZZV->ZZV_MOEDA		:= SZY->ZY_MOEDA
								ZZV->ZZV_DTCANC		:= MZZVDTCANC
							MsUnlock()
						ENDIF //STATUS = 1
					ENDIF                       
					DBSELECTAREA("SZY")
					DBSKIP()
				END                   
			ENDIF
		ENDIF  //SF4

		mpedido_old := mpedido //20050323
		MPRODUTO_OLD :=  MPROD
		MVEND_old := MAUT
		DBSELECTAREA("SD2")
		DBSKIP()
		INCPROC()
	ENDDO
	DBSELECTAREA("SE3")
	DBSKIP()
	INCPROC()
ENDDO

MSGINFO("FIM DE PROCESSAMENTO")
DBSELECTAREA("AUDIT")
COPY TO AUDIT.DBF VIA "DBFCDXADS" // 20121106 
DBCLOSEAREA()

DBSELECTAREA("PGAUDIT")
COPY TO PGAUDIT.DBF VIA "DBFCDXADS" // 20121106 
DBCLOSEAREA()
     
DBSELECTAREA("ZZV")
DBCLOSEAREA("ZZV")

DBSELECTAREA("SE3")
DBCLOSEAREA("SE3")

DBSELECTAREA("SA3")
DBCLOSEAREA("SA3")

DBSELECTAREA("SD2")
DBCLOSEAREA("SD2")

DBSELECTAREA("SF4")
DBCLOSEAREA("SF4")

DBSELECTAREA("SB1")
DBCLOSEAREA("SB1")
RETURN




Static Function ProcArq()
Private nQTD_ENT    := 0    
PRIVATE MHORA     := TIME()
Private cString   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
Private cArqPath  := GetMv("MV_PATHTMP")
Private _cString  := cArqPath+cString+".DBF"
         
DbSelectArea("zzv")
if RDDName() <> "TOPCONN"
		MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
		Return nil
endif

//Verifica se a Stored Procedure Teste existe no Servidor
If TCSPExist("sp_dirautpgcli")
	//SP_CONSIGNANTE(IN_CONSIG VARCHAR2, IN_DATADE VARCHAR2, IN_DATAATE VARCHAR2)
	aRet := TCSPExec("sp_dirautpgcli", dtos(mv_par01), dtos(mv_par02))

/* -- 20070207 nao inserir mais pois quebra a chave primaria!!! nao tem consistencia na diraut
	setprvt("aCampos")
	aCampos := {}
	AADD(aCampos,{"zzv_emissa","zzv_emissa" })
	AADD(aCampos,{"zzv_dtpgcl"  ,"zzv_dtpgcl"    })
	AADD(aCampos,{"zzv_dtpgau","zzv_dtpgau"    })

	cQuery := "SELECT zzv_nf, zzv_serie, zzv_item, zzv_pedido, zzv_produt, zzv_autor, zzv_emissa, zzv_dtpgcl, zzv_dtpgau, zzv_valnf, zzv_valaut, zzv_porc, zzv_status, zzv_qtd, zzv_moeda, zzv_tpaut, zzv_descon from DIRAUT"
	TCQUERY cQuery NEW ALIAS "QUERYAUT"

	DbSelectArea("QUERYAUT")
	DBGoTop()
	Procregua(Reccount())        
	cMsg := ""
	While ! Eof()     
		nQTD_ENT    := 0

		// INSERIR NO ZZV
		DbSelectArea("ZZV")
		RecLock("ZZV",.T.)
			REPLACE zzv_nf       WITH QUERYAUT->zzv_nf
			REPLACE zzv_serie    WITH QUERYAUT->zzv_serie
			REPLACE zzv_item     WITH QUERYAUT->zzv_item
			REPLACE zzv_pedido   WITH QUERYAUT->zzv_pedido
			REPLACE zzv_produt   WITH QUERYAUT->zzv_produt
			REPLACE zzv_autor    WITH QUERYAUT->zzv_autor
			REPLACE zzv_emissa   WITH STOD(QUERYAUT->zzv_emissa)
			REPLACE zzv_dtpgcl   WITH STOD(QUERYAUT->zzv_dtpgcl)
			REPLACE zzv_valnf    WITH QUERYAUT->zzv_valnf
			REPLACE zzv_porc     WITH noround(QUERYAUT->zzv_porc,2)
			REPLACE zzv_status   WITH QUERYAUT->zzv_status
			REPLACE zzv_qtd      WITH QUERYAUT->zzv_qtd
			REPLACE zzv_moeda    WITH QUERYAUT->zzv_moeda
			REPLACE zzv_tpaut    WITH QUERYAUT->zzv_tpaut
			REPLACE zzv_descon   WITH QUERYAUT->zzv_descon
			MsUnlock()
		DbSelectArea("QUERYAUT")
		DBSkip()
		IncProc()
	end 

cMsg:= "Arquivo gerado em: "+_cString
DbSelectArea("QUERYAUT")
DBGotop()
COPY TO &_cString
DBCloseArea()

//cMsg := cMsg + chr(13)+ "Arquivo Gerado NF em: "+_cString
*/
cMsg := "Fim de processamento" 
MSGINFO(cMsg)
EndIf

Return

