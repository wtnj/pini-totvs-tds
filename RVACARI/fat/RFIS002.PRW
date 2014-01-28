#include "rwmake.ch"
/*   
Alterado em 20061205: Danilo C S Pala: retirar frase e adicionar duplicatas
Alterado em 20061211: Danilo C S Pala : CLIFAT
//Alterado por Danilo C S Pala em 20080220: SEN
//Alterado por Danilo C S Pala em 20080221: Correcao do tamanho dos campos causado pela Migracao para MP8
//Alterado por Danilo C S Pala em 20081031: STD
//Alterado por Danilo C S Pala em 20090226: SEN para Editora
//Alterado por Danilo C S Pala em 20090604: Salgado -  nao reter ISS   
//Alterado por Danilo C S Pala em 20090827: Cicero - incluir informacoes
//Alterado por Danilo C S Pala em 20110404: Cicero - incluir serie 8
//Alterado por Danilo C S Pala em 20121128: Cicero eventos web
//Alterado por Danilo C S Pala em 20130423: Cicero - incluir serie 4
//Alterado por Danilo C S Pala em 20130610: Lei Transparencia 12741/2012
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RFIS002	ºAutor  ³Danilo C S Pala     º Data ³  20060807   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ gerar arquivo DE NOTA FISCAL ELETRONICA PARA PREFEITURA DE º±±
±±º          ³SAO PAULO           										  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGA                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function RFIS002()
// MONTAR TELA DE PARAMETROS                                        
Private dataDe := date()
Private dataAte := date()
Private col_inconsist
Private ped_inconsist
PRIVATE NQTDREG := 0
PRIVATE NTOTALDEB := 0
PRIVATE NBANCO := SPACE(3)
PRIVATE NAGENCIA := SPACE(5)
PRIVATE NCONTA := SPACE(10)
PRIVATE MCLIENTE := SPACE(6)
PRIVATE PINIINSCRM := 0
Private nTotTrib := 0
Private nTotNota := 0

IF SM0->M0_CODIGO == "01" //Editora Pini Ltda.
	PINIINSCRM := 10069445
ELSEIF SM0->M0_CODIGO == "02" //Pini Serviços de Engenharia Ltda.
	PINIINSCRM :=  80178600
ELSEIF SM0->M0_CODIGO == "03" //BP S.A.
	PINIINSCRM := 29237335
ELSE 
	PINIINSCRM := 0
ENDIF

@ 010,001 TO 230,350 DIALOG oDlg TITLE "Arquivo de Notas Fiscais Eletronicas"
@ 010,005 SAY "Data de"
@ 010,080 GET datade SIZE 40,12
@ 025,005 SAY "Data ate"
@ 025,080 GET dataate SIZE 40,12
@ 095,005 BUTTON "Gerar Arquivo" SIZE 40,12 ACTION Processa({||ProcNFEl()})
@ 095,070 BUTTON "Fechar" SIZE 40,12 ACTION ( Close(oDlg) )
Activate Dialog oDlg CENTERED
Return    



/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao que faz um loop no SD2, e verifica se e servico ou nao            ³
//³				                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/
STATIC FUNCTION ProcNFEl()
SetPrvt("tamanho, limite, titulo, cDesc1, cDesc2")
SetPrvt("cDesc3, cNatureza, aReturn, SERNF, nomeprog")
SetPrvt("cPerg, nLastKey, lContinua, wnrel")
SetPrvt("")
PRIVATE MCGC := SPACE(14)
PRIVATE MINSCRM := SPACE(8)
PRIVATE MINSCRE := SPACE(12)
PRIVATE MNOME := SPACE(75)
PRIVATE MTPLOGR := SPACE(3)
PRIVATE MLOGR := SPACE(50)
PRIVATE MNLOGR := SPACE(10)
PRIVATE MCOMPL := SPACE(30)
PRIVATE MBAIRRO := SPACE(30)
PRIVATE MMUN := SPACE(50)
PRIVATE MUF := SPACE(2)
PRIVATE MCEP := SPACE(8)
PRIVATE MEMAIL := SPACE(75)
PRIVATE MDESCRICAO := SPACE(50)
PRIVATE TOTSERV := 0
PRIVATE TOTDEV := 0
PRIVATE VALSERV := 0
PRIVATE VALDEV := 0
PRIVATE MSERIE := SPACE(5)
PRIVATE MSERVICO := SPACE(1)
PRIVATE MNFSERV := SPACE(1)
PRIVATE MALIQUOTA := SPACE(4)
PRIVATE MNFALIQ := SPACE(4)
PRIVATE CODISS	:= 0
PRIVATE MPESSOA := SPACE(1)
PRIVATE NCOUNT := 0
PRIVATE MPEDIDO := SPACE(6)
PRIVATE MPRODUTOS := SPACE(500)
PRIVATE	NVALORTOTAL :=  0
PRIVATE MDUPLIC :=  SPACE(300)
PRIVATE MRETISS := SPACE(1)
PRIVATE MCODFAT := "" //20090827
PRIVATE MVENDEDORES := "" //20090827
PRIVATE MMENNOTA := "" //20090827
Private MHORA      := TIME()

tamanho  := "G"
limite   := 220
titulo   := PADC("Nota Fiscal Eletronica",74)
cDesc1   := PADC("Este programa gera o arquivo de NF Eletronica",74)
cDesc2   := ""
cDesc3   := ""
cNatureza:= ""

aReturn  := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
nomeprog := "RFIS002"
nLastKey := 0
lContinua:= .T.
wnrel    := "RFIS002_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString:="SF2"
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica Posicao do Formulario na Impressora                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

LI:=0
LIN:=PROW()

ProcRegua(100)
	
                                        
// HEADER DE ARQUIVO
@ LIN,000 PSAY "1001"+ strzero(PINIINSCRM,8) + DTOS(DATADE)+DTOS(DATAATE)

//REGISTROS DETALHES
DBSELECTAREA("SF2")        
cIndex := CriaTrab(nil,.f.)
cChave  := "F2_FILIAL + DTOS(F2_EMISSAO) + F2_DOC + F2_SERIE"
cFiltro := "(DTOS(F2_EMISSAO)>=DTOS(DATADE) .and. DTOS(F2_EMISSAO)<=DTOS(DATAATE))"
IndRegua("SF2",cIndex,cChave,,cFiltro,"Filtrando ..")
Dbgotop()      

    
TOTSERV := 0
TOTDEV := 0         
While !EOF() .and. dtos(SF2->F2_EMISSAO) >= dtos(DATADE) .and. dtos(SF2->F2_EMISSAO) <= dtos(DATAATE)
	MSERVICO := " "      
	MNFSERV  := " "
	MALIQUOTA := "0000"    
	MNFALIQ := "0000"
	CODISS	:= 0
	VALDEV := 0
	VALSERV := 0 // 20060808 RICARDO: CONSIDERAR APENAS SERVICOS
	MPEDIDO := SPACE(6)
	MPRODUTOS := ""
	nTotTrib := 0 //20130610
	nTotNota := 0 //20130610
                             
	// LOOP NO ITENS DA NOTA
	DBSELECTAREA("SD2")
	DBSetOrder(3) // FILIAL + DOC + SERIE + CLIENTE + LOJA
	DBSeek(xfilial("SD2") + SF2->F2_DOC + SF2->F2_SERIE) // + SF2->F2_CLIENTE 20061211
	While !EOF() .and. (dtos(SD2->D2_EMISSAO) == dtos(SF2->F2_EMISSAO)) .and. (SD2->D2_DOC == SF2->F2_DOC) .AND. (SD2->D2_SERIE == SF2->F2_SERIE)
	
		DBSelectArea("SB1")
		DBSetOrder(1)
		IF DBSEEK(XFILIAL("SB1")+ SD2->D2_COD)
	   		DO CASE
			CASE SB1->B1_TIPO=="CD"            // Para CD/MANUAL.
				MSERVICO := "N"
				MALIQUOTA := "0500"
				//VALDEV := VALDEV + SD2->D2_TOTAL  //DEDUZIR AS MIDIAS  //20060808 ricardo considerar apenas os servicos
			CASE SB1->B1_TIPO=="TS"            // Para Servi‡o (Treinamento).
				MSERVICO := "S"
				MALIQUOTA := "0500"
			CASE SB1->B1_TIPO=="SW"            // Para Servi‡o (Software).
				MSERVICO := "S"    
				MALIQUOTA := "0200"
			CASE SB1->B1_TIPO=="SE"            // Para Servi‡os Especiais Pini Sistemas.
				MSERVICO := "S"    
				MALIQUOTA := "0500"
			CASE SB1->B1_TIPO=="RC"            // Para "Servi‡os" Relatorio de Custo.
				MSERVICO := "S"    
				MALIQUOTA := "0500"
			CASE SB1->B1_TIPO=="PD"            // Para "Servi‡os" Cursos Profissionalizantes de Desenvolvimento.
				MSERVICO := "S"    
				MALIQUOTA := "0500"
			CASE SB1->B1_TIPO=="TM"            // Para "TAXA DE MANUTENCAO"
				MSERVICO := "S"    
				MALIQUOTA := "0300"  //20080201 cicero alteracao da aliquota                                     
			CASE SB1->B1_TIPO=="WW"            // Para WEB
				MSERVICO := "S"    
				MALIQUOTA := "0500"
			CASE SB1->B1_TIPO=="CS"            // Para CURSO
				MSERVICO := "S"    
				MALIQUOTA := "0500"
			CASE SB1->B1_TIPO=="EV"            // Para Eventos
				MSERVICO := "S"    
				MALIQUOTA := "0500" //20090616
			CASE SB1->B1_TIPO=="EW"            // Para Eventos Web //20121128
				MSERVICO := "S"    
				MALIQUOTA := "0500"
			OTHERWISE                          // Para qualquer outro tipo.
				MSERVICO := "N"
				MALIQUOTA := "0500"
			ENDCASE                           


			
			IF MSERVICO == "S"
				MNFSERV := "S"
				MPEDIDO := SD2->D2_PEDIDO     
				//MPRODUTOS := TRIM(MPRODUTOS) + TRIM(SB1->B1_DESC) + "|" //20110420
				CODISS	:= SB1->B1_CODISS
				MNFALIQ := MALIQUOTA
				VALSERV := VALSERV + SD2->D2_TOTAL //20060808 ricardo considerar apenas os servicos

				//20110420 daqui
				MPRODUTOS := TRIM(MPRODUTOS) + "COD:"+TRIM(SB1->B1_COD) +"; DESC:"+ TRIM(SB1->B1_DESC) +"; QTD:" + TRANSFORM(SD2->D2_QUANT,"@E 999") +"; VL:" + TRANSFORM(SD2->D2_PRCVEN, "@E 999,999,999.99") +"; TOT:" + TRANSFORM(SD2->D2_TOTAL, "@E 999,999,999.99")+ "|"   
				//20110420 ate aqui 
				
				GetAliqImp(SD2->D2_COD ,SD2->D2_TOTAL) //20130610
				
			END
		END //SB1
	
		DBSelectArea("SD2")
		DBSkip()             
	END // LOOP DO SD2

//	IF MNFSERV == "S" .AND. ((SF2->F2_SERIE=="UNI" .and. SM0->M0_CODIGO<>"01") .or. (SF2->F2_SERIE == "SEN") .or. (SF2->F2_SERIE == "STD") .or. (SF2->F2_SERIE == "8  ") .or. (SF2->F2_SERIE == "4  ")) //20080220 SEN //20081031 STD //20090226 .and. SM0->M0_CODIGO<>"01" //20110404 //20130423
	IF MNFSERV == "S" .AND. ((SF2->F2_SERIE=="UNI" .and. SM0->M0_CODIGO<>"01") .or. (SF2->F2_SERIE == "SEN") .or. (SF2->F2_SERIE == "STD") .or. (SF2->F2_SERIE == "8  ") .or. (SF2->F2_SERIE == "4  ") .or. (SF2->F2_SERIE == "5  ")) //01/11/2013 - Thiago Lima - Incluido série 5
		DbSelectArea("SC5")
		DbSetOrder(1)  
		IF DbSeek(xFilial("SC5")+MPEDIDO) // DEDUZIR A DESPESA DE REMESSA
			IF ALLTRIM(SC5->C5_CLIFAT) ==""
				MCLIENTE :=  SF2->F2_CLIENTE
			ELSE
				MCLIENTE := SC5->C5_CLIFAT
			ENDIF
			MVENDEDORES := SC5->C5_VEND1 //20090827
			MMENNOTA := SC5->C5_MENNOTA  //20090828
			DbSelectArea("SZ9")
			DbSetOrder(1)  
			IF DbSeek(xFilial("SZ9")+SC5->C5_TIPOOP) // DEDUZIR A DESPESA DE REMESSA
				MCODFAT := SZ9->Z9_CODFAT //20090828
			ELSE
				MCODFAT := "" //20090828
			ENDIF
		ELSE
			MCLIENTE :=  SF2->F2_CLIENTE
			MCODFAT := "" //20090827
			MVENDEDORES := SF2->F2_VEND1 //20090827
			MMENNOTA := "" //20090828
			MCODFAT := "" //20090828
		END //20061211: CLIFAT
		
		MSERIE := 	SF2->F2_SERIE + space(2)

		// localizar o cliente
		DBSelectArea("SA1")
		DBSetOrder(1)
		IF DBSEEK(XFILIAL("SA1")+ MCLIENTE)
			MCGC := SA1->A1_CGC
			MINSCRM := SA1->A1_INSCRM
			MINSCRE := SA1->A1_INSCR
			MNOME := substr(SA1->A1_NOME + space(75),1,75) //20080221 75 char
			MTPLOGR := substr(SA1->A1_TPLOG,1,3)
			MLOGR := substr(SA1->A1_LOGR,1,50)
			MNLOGR := substr(SA1->A1_NLOGR,1,10) //20080221 75 char
			MCOMPL := substr(SA1->A1_COMPL,1,30)
			MBAIRRO := substr(SA1->A1_BAIRRO,1,30) // + space(10) //20080221 30 char
			MMUN := substr(SA1->A1_MUN+space(50),1,50)  //20080221 50 char
			MUF := substr(SA1->A1_EST,1,2) //20080221 2 char
			MCEP := substr(SA1->A1_CEP,1,8) //20080221 8 char
			MEMAIL := substr(SA1->A1_EMAIL+space(75),1,75) //20080221 75 char
		ELSE
			MCGC := SPACE(14)
			MINSCRM := SPACE(8)
			MINSCRE := SPACE(12)
			MNOME := SPACE(75)
			MTPLOGR := SPACE(3)
			MLOGR := SPACE(50)
			MNLOGR := SPACE(10)
			MCOMPL := SPACE(30)
			MBAIRRO := SPACE(30)
			MMUN := SPACE(50)
			MUF := SPACE(2)
			MCEP := SPACE(8)
			MEMAIL := SPACE(75)
		ENDIF      
		IF LEN(trim(MCGC)) == 14
			MPESSOA := "2"
		ELSEIF LEN(trim(MCGC)) == 11
			MPESSOA := "1"
		ELSE
			MPESSOA := "3"
		ENDIF
		
	//20080625
	IF SB1->B1_TIPO=="EV" .AND. SA1->A1_EST=="SP" .AND. ALLTRIM(SA1->A1_MUN)=="SAO PAULO" .AND. MPESSOA=="2"
		MRETISS := "2" //20090604 Salgado: nao reter ISS
	ELSE              
		MRETISS := "2"
	ENDIF
                
	//20130610 daqui
	If nTotTrib > 0
		nTotNota 	:= VALSERV
		cPercTrib	:= Transform( round(((nTotTrib / nTotNota) * 100),2),	"@R 9999.99")
		MMENNOTA :=  alltrim(MMENNOTA) + "; VALOR APROXIMADO DOS TRIBUTOS: R$ " +alltrim(Transform(nTotTrib,"@R 999,999,999.99"))+" ("+alltrim(cPercTrib)+"%) FONTE: IBPT."
	EndIf
	//20130610 ate aqui
                
                
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ CONTAS A RECEBER                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MDUPLIC := ""
	DbSelectArea("SE1")
	DbSetOrder(1)
	If dbSeek(xFilial("SE1")+SF2->F2_SERIE+SF2->F2_DOC,.T.)
		While !Eof() .And. (SE1->E1_NUM == SF2->F2_DOC .AND. SE1->E1_PREFIXO == SF2->F2_SERIE)
			If !("NF" $ SE1->E1_TIPO)
				DbSkip()
				Loop
			Endif
			NVALORTOTAL :=  SE1->E1_VALOR -(SE1->E1_COFINS + SE1->E1_PIS + SE1->E1_CSLL +SE1->E1_IRRF)
			MDUPLIC := MDUPLIC +"| "+ SE1->E1_PREFIXO +"  "+ SE1->E1_NUM +" " + SE1->E1_PARCELA + "  "+  Transform(NVALORTOTAL,"@E 999,999.99") +"  "+ dtoc(SE1->E1_VENCTO)
			DbSkip()
		End
	EndIf

//		MPRODUTOS := MPRODUTOS + "| | | | "+ RTRIM(MDUPLIC) //20090827
		MPRODUTOS := MPRODUTOS + "| | | | "+ RTRIM(MDUPLIC) +" | PEDIDO: "+ MPEDIDO + " | VENDEDOR:" +MVENDEDORES + " | CODFAT:"+ MCODFAT +" | "+ MMENNOTA //20090828
		//MPRODUTOS := MPRODUTOS + "| | | | | | | | | | | |O REGISTRO DAS OPERACOES RELATIVAS A PRESTACAO DE SERVICOS, CONSTANTE DESTE DOCUMENTO, DEVERA SER CONVERTIDO POR NF-e" // 20060814
		DBSELECTAREA("SF2")	
		// REGISTRO DETALHE
		LIN := LIN +1
		@ LIN,000 PSAY "2RPS-M" + MSERIE + STRZERO(VAL(SF2->F2_DOC),12) + DTOS(SF2->F2_EMISSAO) + "T" ;
		+ STRZERO((VALSERV * 100),15) + STRZERO((VALDEV * 100),15) + STRZERO(VAL(CODISS),5) + MNFALIQ + MRETISS + MPESSOA + STRZERO(VAL(MCGC),14) ;
		+ STRZERO(VAL(MINSCRM),8) + STRZERO(VAL(MINSCRE),12) + MNOME + MTPLOGR + MLOGR + MNLOGR + MCOMPL ;
		+ MBAIRRO + MMUN + MUF + MCEP + MEMAIL + MPRODUTOS

		TOTSERV := TOTSERV + VALSERV
	 	TOTDEV := TOTDEV +  VALDEV
	 	NCOUNT++
	 END // MNFSERV
	
	DBSelectArea("SF2")
	DBSkip()
End //LOOP SF2

LIN := LIN +1
// RODAPE DO ARQUIVO
@ LIN,000 PSAY "9"+ STRZERO(NCOUNT,7) + STRZERO((TOTSERV * 100),15) + STRZERO((TOTDEV * 100),15)
LIN := LIN +1
@ LIN,000 PSAY ""    

SET DEVICE TO SCREEN

SETPRC(0,0)
	
SET DEVICE TO PRINTER
	
SetPrc(0,0)
                        
SET DEVICE TO SCREEN        
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()         

DBSELECTAREA("SA1")
DBCLOSEAREA("SA1")

DBSELECTAREA("SD2")
DBCLOSEAREA("SD2")

DBSELECTAREA("SB1")
DBCLOSEAREA("SB1")

/*DBSELECTAREA("SC5")
DBCLOSEAREA("SC5") */

DBSELECTAREA("SF2")
DBCLOSEAREA("SF2")
return


/* 20130607 Lei Transparencia 12741/2012 */
Static Function GetAliqImp(cSD2Produto, nSD2Total)
Local lServico := IIF(!Empty(SB1->B1_CODISS),.T.,.F.)
Local nTributo := 0
Local nAliqImp := 0
Local nSYDRecno	:= 0
Local nSYDIndex := 0 
Local nEL0Recno	:= 0
Local nEL0Index	:= 0

DbSelectArea("SB1")
DbSetOrder(1)
If DbSeek(xFilial("SB1")+cSD2Produto)
/*	If lServico - THIAGO - ALTERAÇÃO EM 14/11/2013
		If SB1->B1_IMPNCM == 0
			nEL0Recno:= EL0->(RECNO())
			nEL0Index:= EL0->(IndexOrd()) 			
			EL0->(dbSetOrder(1))
			if ( EL0->(dbSeek(xFilial("EL0")+SB1->B1_POSIPI)) )	
				nAliqImp := EL0->EL0_ALIQIM
			endif			
			EL0->(DBSETORDER(nEL0Index))
			EL0->(DBGOTO(nEL0Recno))
		Else
			nAliqImp := SB1->B1_IMPNCM
		EndIf
	Else
*/ 
		If SB1->B1_IMPNCM == 0
			nSYDRecno:= SYD->(RECNO())
			nSYDIndex:= SYD->(IndexOrd()) 			
			SYD->(dbSetOrder(1))
			if ( SYD->(dbSeek(xFilial("SYD")+SB1->B1_POSIPI)) )	
				nAliqImp := SYD->YD_ALIQIMP
			endif			
			SYD->(DBSETORDER(nSYDIndex))
			SYD->(DBGOTO(nSYDRecno))
		Else
			nAliqImp := SB1->B1_IMPNCM
		EndIf
//	EndIf - THIAGO
Else
	nAliqImp := 0
Endif
//nAliquota:= nAliqImp //GetAliqImp()
nTributo := Round( ((nSD2Total * nAliqImp)/100),2) //era  SD2->D2_TOTAL * nAliquota  
nTotTrib+= nTributo

Return