#include "rwmake.ch" 
/*/     Alterado por Danilo C S Pala em 20060801: refazer o filtro pois por indice nao funcionava 
Alterado por Danilo C S Pala em 20080917: inclusao do TPPER, para validacao dos correios
//Alterado por Danilo C S Pala em 20090414: novo codigo de produto, agora com 5 digitos
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT165   ³Autor: Danilo C S Pala        ³ Data:   20060620 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera arquivo de reclamacoes da entrega direta              ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function PFAT165() 
setprvt("_aCampos, _cNome, cIndex, cKey, cArq")
setprvt("_aCamp2, _cNome2, cArq2")
setprvt("_aCamp3, _cNome3, cArq3")
setprvt("_aCamp4, _cNome4, cArq4")
setprvt("_aCamp6, _cNome6, cArq6")
setprvt("mhora, mdata, mdataEnt, ncontUF, ncontTotal")
setprvt("cRevista, cEdicao, cSiglaRev")
setprvt("npeso, nlargura, naltura, ncomprimento, cFonte, nqtdper, mdtentrega, MtpPER")
setprvt("cSIGLAREV, cREVISTA")
setprvt("MCLIENTE, MCODDEST, CLIE_NOME")
setprvt("MEND , MBAIRRO,  MMUN,  MEST, MCEP, MFONE, ATIVIDADE, CLIE_DEST, MTPLOG, MLOGR, MNLOGR, MCLOGR, MTPPER,mhora")

Programa   := "PFAT164"
MHORA      := TIME()
mdata	   := dtos(date()) //20060214
mdata 	   := subs(mdata,7,2) + "-" + subs(mdata,5,2) +"-" + subs(mdata,1,4)+" 00:00"
cString    := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)         
mdtentrega := date()
MTPPER	   := SPACE(4)
     
cArq	   := "FONTE"

//header
private HTPREG := 1
private HTPARQ := "R"
private HCODEDIT := 27448
private HDTGER := mdata+":00"
private HVERSAO := "01.00.03"


//FOOTER
private FTPREG := 3
private FQTDREG := 0
 
//TELA
private ocorde := date()
private ocorate := date()
Private aItens := {"3610 AUR","3611 CMO","3630 TEC","4190 EOA","15136GDC"} //20090414

@ 010,001 TO 230,350 DIALOG oDlg TITLE "Arquivo de Reclamacoes para os Correios"
@ 010,005 SAY "Ocorrencias de"
@ 010,080 GET ocorde SIZE 40,12
@ 025,005 SAY "Ocorrencias ate"
@ 025,080 GET ocorate SIZE 40,12
@ 095,005 BUTTON "Gerar Arquivo" SIZE 40,12 ACTION Processa({||ProcArq()})
@ 095,070 BUTTON "Fechar" SIZE 40,12 ACTION ( Close(oDlg) )
Activate Dialog oDlg CENTERED
Return    




//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ ProcArq()                                                     ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ funcao que le o SZ1 e gera txt conforme o layout dos correios ³
//³           ³                               								  ³
//³           ³ 															  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function ProcArq()
setprvt("cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3, wrnel, aReturn")
setprvt("Li")
MHORA      := TIME()
wnrel    := "Relatorio_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)                           
cDesc1   := PADC("Este programa ira gerar o arquivo para os Correios" ,74)
cDesc2   := ""
cDesc3   := ""
aReturn  := { "Especial", 1,"Administra‡Æo", 1, 2, 1,"",1 }
mDESCR   := ""
CONTROLE := ""
cPerg    := ""
cTitulo  := "PFAT165"

wnrel := SetPrint("",wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
SetDefault(aReturn,"")
     
//HEADER
Li := 0
@ Li,000 PSAY HTPREG
@ Li,001 PSAY HTPARQ
@ Li,002 PSAY strzero(HCODEDIT,10)
@ Li,012 PSAY HDTGER 
@ Li,031 PSAY HVERSAO 
// DAKI 20060801
/*DBSELECTAREA('SZ1')
DBSETORDER(2)
DBSEEK(XFILIAL()+DTOS(OCORDE))
*/
DbSelectArea("SZ1")  
cIndex := CriaTrab(nil,.f.)
cChave  := "Z1_FILIAL + DTOS(Z1_DTOCORR) + Z1_PEDIDO"
cFiltro := "(DTOS(Z1_DTOCORR)>=DTOS(OCORDE) .and. DTOS(Z1_DTOCORR)<=DTOS(OCORATE))"
IndRegua("SZ1",cIndex,cChave,,cFiltro,"Filtrando ..")
Dbgotop()      
// ATE AKI 20060801
Li++

WHILE !Eof() .and. SZ1->Z1_FILIAL == xFilial("SZ1") .and. DTOS(SZ1->Z1_DTOCORR) <= DTOS(OCORATE)
	IF (SZ1->Z1_STATUSI = "1" .OR. SZ1->Z1_STATUSI = "4" .OR. SZ1->Z1_STATUSI = "7" .OR. SZ1->Z1_STATUSI = "8") .AND. EMPTY(SZ1->Z1_PROVID)
		//LOCALIZAR O ITEM DO PEDIDO                        
		DBSELECTAREA('SC6')
		DBSETORDER(1)
		DBSEEK(XFILIAL()+SZ1->Z1_PEDIDO)
		WHILE !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NUM == SZ1->Z1_PEDIDO
			IF SUBSTR(SC6->C6_PRODUTO,1,4) == SUBSTR(SZ1->Z1_CODPROD,1,4)
				//SELECIONAR A SIGLA DO PERIODICO
				Private aItens := {"3610 AUR","3611 CMO","3630 TEC","4190 EOA","15136GDC"} //20090414
    			if SUBSTR(SC6->C6_PRODUTO,1,4) == "0115"
    				cSiglaRev  := "CMO"
					cRevista   := "3611"
					MTPPER	   := "CMCM" //20080917
    			elseif SUBSTR(SC6->C6_PRODUTO,1,4) == "0116"
    				cSiglaRev  := "TEC"
					cRevista   := "3630"
					MTPPER	   := "TECH" //20080917
    			elseif SUBSTR(SC6->C6_PRODUTO,1,4) == "0124"
    			    cSiglaRev  := "AUR"
					cRevista   := "3610"
					MTPPER	   := "AUAU" //20080917
    			elseif SUBSTR(SC6->C6_PRODUTO,1,4) == "0125"
					cSiglaRev  := "EOA"
					cRevista   := "4190"
					MTPPER	   := "EOEO" //20080917
    			elseif SUBSTR(SC6->C6_PRODUTO,1,4) == "0127" //20090414
					cSiglaRev  := "GDC"
					cRevista   := "15136"
					MTPPER	   := "GDC "
				else // revista invalida
					DBSELECTAREA('SC6')
					DBSKIP()
    			endif               

		    	
    			MCLIENTE := SC6->C6_CLI
    			MCODDEST := SC6->C6_CODDEST
    			
    			DBSELECTAREA("SA1")
				DBSETORDER(1)
				IF DBSEEK(XFILIAL()+MCLIENTE)
					CLIE_NOME := SA1->A1_NOME
					MEND      := SA1->A1_END
					MBAIRRO   := SA1->A1_BAIRRO
					MMUN      := SA1->A1_MUN
					MEST      := SA1->A1_EST
					MCEP      := SA1->A1_CEP
					MFONE     := SA1->A1_TEL
					ATIVIDADE := SA1->A1_ATIVIDA
					CLIE_DEST := SPACE(40)
					MTPLOG	  := SA1->A1_TPLOG
					MLOGR	  := SA1->A1_LOGR
					MNLOGR	  := SA1->A1_NLOGR
					MCLOGR	  := SA1->A1_COMPL
				ELSE //NAO ENCONTROU O CLIENTE
					DBSELECTAREA('SC6')
					DBSKIP()
				ENDIF
	
				IF MCODDEST # ' '
					DBSELECTAREA("SZN")
					IF DBSEEK(XFILIAL()+MCLIENTE+MCODDEST)
						CLIE_DEST:=SZN->ZN_NOME
					ENDIF
					DBSELECTAREA("SZO")
					IF DBSEEK(XFILIAL()+MCLIENTE+MCODDEST)
						MEND    := SZO->ZO_END
						MBAIRRO := SZO->ZO_BAIRRO
						MMUN    := SZO->ZO_CIDADE
						MEST    := SZO->ZO_ESTADO
						MCEP    := SZO->ZO_CEP
						MFONE   := SZO->ZO_FONE
						MTPLOG	:= SZO->ZO_TPLOG
						MLOGR	:= SZO->ZO_LOGR
						MNLOGR	:= SZO->ZO_NLOGR
						MCLOGR	:= SZO->ZO_COMPL
					ENDIF
				ENDIF
				
				@ Li,000 PSAY "2"
				@ Li,001 PSAY cSiglaRev
				@ Li,006 PSAY STRZERO(SZ1->Z1_EDICAO,10)
				@ Li,016 PSAY MTPPER //20080917   ERA SPACE(4)
				@ Li,020 PSAY SC6->C6_NUM + SC6->C6_ITEM
				@ Li,040 PSAY "P" + MCLIENTE
				@ Li,060 PSAY CLIE_NOME
				@ Li,120 PSAY MLOGR
				@ Li,180 PSAY MTPLOG
				@ Li,195 PSAY MCLOGR
				@ Li,235 PSAY MNLOGR
				@ Li,245 PSAY MBAIRRO
				@ Li,305 PSAY MCEP
				@ Li,313 PSAY MMUN
				@ Li,383 PSAY MEST
				@ Li,385 PSAY SPACE(40)
				@ Li,425 PSAY "N" //ENDERECO COMERCIAL
				@ Li,426 PSAY "0001"
				@ Li,430 PSAY "N" //PROCON
				@ Li,431 PSAY "01" ///RECLAMACOES CONSECUTIVAS
				@ Li,433 PSAY "N" //PRIMEIRA VEZ Q RECEBE O PERIODICO
				@ Li,434 PSAY "N"
				@ Li,435 PSAY SPACE(60)
				@ Li,495 PSAY subs(dtos(SZ1->Z1_DTOCORR),7,2) + "/" + subs(dtos(SZ1->Z1_DTOCORR),5,2) +"/" + subs(dtos(SZ1->Z1_DTOCORR),1,4)
				@ Li,505 PSAY SZ1->Z1_PEDIDO+SZ1->Z1_CODCLI
				@ Li,517 PSAY "S"
				@ Li,518 PSAY SZ1->Z1_STATUSI
				@ Li,523 PSAY SZ1->Z1_OCORR + SPACE(438)
				///* teste 20060621
				DbSelectArea("SZ1")
				RecLock("SZ1",.F.)
					Replace Z1_PROVID with "ENVIADO PARA OS CORREIOS POR FTP EM "+ dtoc(date())
				MsUnlock()  
                //*/
		    	FQTDREG++
		    	Li++
			ENDIF

			DBSELECTAREA('SC6')
			DBSKIP()
		end
	ENDIF                  
	DBSELECTAREA('SZ1')
	DBSKIP()  
End

	//FOOTER
	@ Li,000 PSAY FTPREG
	@ Li,001 PSAY strzero(FQTDREG,10)

	SET DEVICE TO SCREEN
	IF aRETURN[5] == 1
		Set Printer to
		dbcommitAll()
		ourspool(WNREL)
	ENDIF
	MS_FLUSH()
Return
