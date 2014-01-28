#include "rwmake.ch"
/* Alterado por Danilo C S Pala em 20040318
//Alterado por Danilo C S Pala em 20070118: alteracoes solicitadas pela Geralda da Transfolha
//Alterado por Danilo C S Pala em 20110405: correcao de logica: situac da ASSAT02 e nao da ETIQ     
//Danilo C S Pala em 20110921: c6_tiporev: 0=mensal, 1=par, 2=impar solicitado por Sandra//:na PSE: M=Mensal,S=Semanal,B=Bimestral
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RFAT110   ºAutor  ³Danilo C S Pala     º Data ³  13/02/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio de etiquetas                                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Rfat110()

//declaracao de variaveis
SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA,CONTADOR,M_PAG")
SetPrvt("Z,M,TAMANHO,LIMITE,TITULO,CDESC1,_cTitulo,MITEM1")
SetPrvt("CDESC2,CDESC3,CNATUREZA,ARETURN,SERNF,NOMEPROG,MITEM2")
SetPrvt("CPERG,NLASTKEY,LCONTINUA,NLIN,WNREL,CSTRING,MITEM3")
SetPrvt("TREGS,M_MULT,P_ANT,P_ATU,P_CNT,M_SAV20,CABEC1,CABEC2")
SetPrvt("M_SAV7,_ACAMPOS,_CNOME,XNOTA,MAGENCIA,XSERIE,EDICAO1")
SetPrvt("XPEDIDO,MTPTRANS,XCLIENTE,XLOJA,XCODAG,MNOME,LINHA,EDICAO2")
SetPrvt("MEND,MBAIR,MMUNI,MESTA,MCEP,MDESC,PROGRAMA,NCARACTER,EDICAO3")
SETPRVT("_aCampos,_cNome,cFiltro,cChave,cIndex,cArq,_bCampos,_bNome,auxiliar")
SETPRVT("C,COL,quantidd, mQuantidt, MCODPROD, MDESCRICAO, ca_campos, ca_nome")
setprvt("MNOME1, MDEST1, MV_ENDERECO1, MBAIRRO1, MNUM1, MCEP1, MEST1, MPEDIDO1, MTPLOGR1, MLOGR1, MNLOGR1, MCLOGR1")
setprvt("MNOME2, MDEST2, MV_END2, MBAIRRO2, MNUM2, MCEP2, MEST2, MPEDIDO2, MTPLOGR2, MLOGR2, MNLOGR2, MCLOGR2")
setprvt("MNOME3, MDEST3, MV_END3, MBAIRRO3, MNUM3, MCEP3, MEST3, MPEDIDO3, MTPLOGR3, MLOGR3, MNLOGR3, MCLOGR3")
setprvt("RESTO, MTIPOREV")

NCARACTER := 10
M_PAG     := 01
Li        := 0
Linha     := 60
LIN       := 0
CbTxt     := ""
CbCont    := ""
nOrdem    := 0
Alfa      := 0
Z         := 0
M         := 0
CONTADOR  := 1
//tamanho   := "G"
tamanho   := "P"
limite    := 220          
_cTitulo  := " **** RESUMO DOS RELATORIOS DE CUSTOS **** "
cDesc2    := ""
cDesc3    := ""
cNatureza := ""
aReturn   := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
SERNF     := 'UNI'
nomeprog  := "Rfat110"
cPerg     := "FAT110"
nLastKey  := 0
lContinua := .T.
nLin      := 0
mQuantidt := 0
Programa  := "RFAT110"
CABEC2    := ""
Cabec1   :=   " Produto        Descricao                                Porte     Quantidade "
//       12345678901234567890123456789012345678901234567890123456789012345678901234567890
//               10        20        30        40        50        60        70        80
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³Parametros : mv_par01 = Porte 						³
³Parametros : mv_par02 = Edicao						³
³Parametros : mv_par03 = Etiqueta, Arquivo Texto, Totais ³  
³Parametros : mv_par04 = Do produto					³ //20040318
³Parametros : mv_par05 = Ate produto				³ //20040318
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
  

MsgAlert("Certifique-se que o arquivo de assinantes está atualizado")
ValidPerg()
If !Pergunte(cPerg)      //parametros de FAT110 em SX1  para montar a GUI
	Return
Endif

If mv_par03 ==1
   ctitulo    := PADC("ETIQUETAS",74)
   wnrel      := 'EPS'+AllTrim(MV_PAR01)+AllTrim(STR(MV_PAR02,4))   
   cDesc1    := PADC("Este programa ira emitir as Etiquetas",74)
Endif
       
If mv_par03 ==2
   ctitulo    := PADC("ARQUIVO TXT",74)
   wnrel     :=  'APS'+AllTrim(MV_PAR01)+AllTrim(STR(MV_PAR02,4))   
   cDesc1    := PADC("Este programa ira gerar arquivo texto SDF para o distribuidor",74)
Endif

If mv_par03 ==3
   ctitulo    := PADC("TOTAIS",74) 
   wnrel     := 'TPS'+AllTrim(MV_PAR01)+AllTrim(STR(MV_PAR02,4))   
   cDesc1    :=  PADC("Este programa ira emitir os totais das Etiquetas",74)
Endif   


CSTRING:='SF2'

If nLastKey == 27
	Return
Endif

wnrel := SetPrint(cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.f.)
SetDefault(aReturn,cString)
If SM0->M0_CODIGO=="01"
	dbUseArea(.T.,, "\SIGA\ARQASS\ASSAT01.dtc","ASSAT",.F.,.F.)
Else
	dbUseArea(.T.,, "\SIGA\ARQASS\ASSAT02.dtc","ASSAT",.F.,.F.)
Endif

lEnd  := .F.

bBloco:= {|lEnd| IMPETIQ(@lEnd)}
Processa( bBloco, "Aguarde" ,"Processando...", .T. )

Return

//--------------------------------------------------------------------------------------------

Static Function IMPETIQ()

Li := 0
SET DEVICE TO PRINTER

// criar vetor
_aCampos := {}
AADD(_aCampos,{"CODPROD","C",15,0})
AADD(_aCampos,{"PORTE","C",1,0})
AADD(_aCampos,{"SITUAC","C",2,0})
AADD(_aCampos,{"EDSUSP","N",4,0})
AADD(_aCampos,{"EDIN","N",4,0})

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"ETIQ",.F.,.F.)
DBSelectArea("ETIQ")
caIndex  := CriaTrab(nil,.f.)
caChave  := "CODPROD"
caFiltro := ""
IndRegua("ETIQ",caIndex,caChave,,caFiltro,"Filtrando ..")
Dbgotop()

DbSelectArea("SZN")
DbSetOrder(1)
DbSelectArea("SZO")
DbSetOrder(1)

DbSelectArea("ASSAT")  // 12.04.2003
cIndex := CriaTrab(nil,.f.)
cChave  := "CODPROD"
cFiltro := "(EDSUSP>=MV_PAR02 .and. EDIN<=MV_PAR02) .and. (CODPROD>=MV_PAR04 .and. CODPROD<=MV_PAR05)" //20040318 - adicionou-se restr. de produtos
IndRegua("ASSAT",cIndex,cChave,,cFiltro,"Filtrando ..")
Dbgotop()

// Primeira leitura - contagem dos registros e gravacao do cabecalho do texto
IF mv_par03 == 2
	
	while !eof()
		If porte <> mv_par01
			DbSkip()
			loop
		Endif
		// daqui 20110921
		if SM0->M0_CODIGO=="02" //relatorio de custos pares e pares bimestral
			RESTO := MOD(MV_PAR02,2)
			IF RESTO == 0
				MTiporev := 'PAR'
			ELSE
				MTiporev := 'IMPAR'
			ENDIF
			IF (MTiporev == 'PAR' .AND. ASSAT->TIPOREV == 'B') //na PSE 
				//DbSelectArea("ASSAT")
				DbSkip()
				Loop
			ENDIF         
		endif
		//ate aqui 20110921
		CONTADOR := CONTADOR +1
		DbSkip()
		loop
	end
	
	@ Li,001 PSAY "EXPRESSA"
	@ Li,009 PSAY "000100"
	@ Li,015 PSAY "1"  //20060328 era 2
	@ Li,016 PSAY "RELATORIOS DE CUSTOS"
	@ Li,051 PSAY Transform(contador,"@E 999999")
	@ Li,057 PSAY SPACE(8)
	@ Li,065 PSAY SPACE(6)
	@ Li,071 PSAY "<<V004>>" //20060328 era <<V003>>
	
Endif

DbselectArea("ASSAT")
Dbgotop()

//inserindo no ETIQ
while !eof()                              
	/*if ASSAT->CODPROD="1013014"  //20110405
		msginfo("achou")
	endif*/

	InserirETIQ()
	DbselectArea("ASSAT")
	DbSkip()
end
//fechando pfat057
DbSelectArea("ASSAT")
DbCloseArea()

If SM0->M0_CODIGO=="01"
	dbUseArea(.T.,, "\SIGA\ARQASS\ASSAT01.dtc","ASSAT",.F.,.F.)
Else
	dbUseArea(.T.,, "\SIGA\ARQASS\ASSAT02.dtc","ASSAT",.F.,.F.)
Endif

DbSelectArea("ETIQ")
cIndex  := CriaTrab(nil,.f.)
cChave  := "CODPROD"
cFiltro := "ETIQ->PORTE == MV_PAR01 " // .and. ETIQ->SITUAC == 'AA'" 20110405
cFiltro := cFiltro+ ".and. ETIQ->EDSUSP>=MV_PAR02 .and. ETIQ->EDIN<=MV_PAR02"
IndRegua("ETIQ",cIndex,cChave,,cFiltro,"Filtrando ..")
Dbgotop()

While !eof()
	quantidd := 0
	
	DbSelectArea("ASSAT")
	cIndex  := CriaTrab(nil,.f.)
	cChave  := "CODPROD"
	cFiltro := "ASSAT->PORTE == MV_PAR01 .and. ETIQ->CODPROD == ASSAT->CODPROD"
	cFiltro := cFiltro+ ".and. ASSAT->EDSUSP>=MV_PAR02 .and. ASSAT->EDIN<=MV_PAR02 .and. ASSAT->SITUAC=='AA'" //+ situac 20110405
	IndRegua("ASSAT",cIndex,cChave,,cFiltro,"Filtrando ..")
	dbGoTop()
	
	//while dos pedidos
	while !eof()          
		// daqui 20110921
		if SM0->M0_CODIGO=="02" //relatorio de custos pares e pares bimestral
			RESTO := MOD(MV_PAR02,2)
			IF RESTO == 0
				MTiporev := 'PAR'
			ELSE
				MTiporev := 'IMPAR'
			ENDIF
			IF (MTiporev == 'PAR' .AND. ASSAT->TIPOREV == 'B')
				DbSelectArea("ASSAT")
				DbSkip()
				Loop
			ENDIF         
		endif
		//ate aqui 20110921
		
		//ATUALIZAR AS VARIAVEIS
		MNOME1     := ASSAT->NOME
		MPEDIDO1   := ASSAT->NUMPED
		MITEM1     := ASSAT->ITEM
		EDICAO1    := ALLTRIM(STR(MV_PAR02)) 
		MDESCRICAO := ASSAT->DESCR
		MCODPROD   := ASSAT->CODPROD //somente na primeira
		DbSelectArea("SA1")
		If DbSeek(xFilial()+ASSAT->CODCLI)
			mV_EndERECO1 := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060323
			MTPLOGR1     := SUBSTR(SA1->A1_TPLOG,1,3) //20060328
			MLOGR1       := SUBSTR(SA1->A1_LOGR,1,50) //20060328
			MNLOGR1      := SUBSTR(SA1->A1_NLOGR,1,6) //20060328
			MCLOGR1      := SUBSTR(SA1->A1_COMPL,1,30) //20060328
			mBairro1     := SA1->A1_BAIRRO
			mMun1        := SA1->A1_MUN
			mEst1        := SA1->A1_EST
			mCEP1        := SA1->A1_CEP
			mDest1       := SPACE(40)
		Endif
		
		DbSelectArea("SZN")
		DbSeek(xFilial()+ASSAT->CODCLI+ASSAT->CODDEST)
		If Found()
			mDest1 := SZN->ZN_NOME
		Endif
		
		DbSelectArea("SZO")
		DbSeek(xFilial()+ASSAT->CodCli+ASSAT->CodDest)
		If Found()
			mV_EndERECO1 := ALLTRIM(SZO->ZO_TPLOG)+ " " + ALLTRIM(SZO->ZO_LOGR) + " " + ALLTRIM(SZO->ZO_NLOGR) + " " + ALLTRIM(SZO->ZO_COMPL) //20060323
			MTPLOGR1     := SUBSTR(SZO->ZO_TPLOG,1,3) //20060328
			MLOGR1       := SUBSTR(SZO->ZO_LOGR,1,50) //20060328
			MNLOGR1      := SUBSTR(SZO->ZO_NLOGR,1,6) //20060328
			MCLOGR1      := SUBSTR(SZO->ZO_COMPL,1,30) //20060328
			mBairro1     := SZO->ZO_BAIRRO
			mMun1        := SZO->ZO_CIDADE
			mEst1        := SZO->ZO_ESTADO
			mCEP1        := SZO->ZO_CEP
		Endif
		//FIM DE ATUALIZACAO DE VARIAVEIS
		
		IF MV_PAR03 == 2
			Li := Li+1
			@ Li,000 PSAY "<<GERASEQ>>" //mPedido1+mItem1 20060328
			@ Li,010 PSAY mNome1
			@ Li,060 PSAY IIF((SUBSTR(mDest1,1,3)=="A/C"), SUBSTR(MDEST1,5,40), SUBSTR(MDEST1,1,40))   //20070118
			@ Li,110 PSAY alltrim(MTPLOGR1) + " " + alltrim(MLOGR1) + " "+ alltrim(MNLOGR1) // 20070118
//			@ Li,113 PSAY MLOGR1 // 20070118
//			@ Li,163 PSAY MNLOGR1  // 20070118
			@ Li,169 PSAY MCLOGR1
			@ Li,199 PSAY mBairro1
			@ Li,229 PSAY SUBSTR(mCep1,1,5) + "-" + SUBSTR(mCep1,6,3)
			@ Li,238 PSAY mMun1
			@ Li,268 PSAY mEst1
			@ Li,270 PSAY Edicao1
			@ Li,300 PSAY SPACE(30) 
			@ Li,330 PSAY SPACE(5)  //20060328
			@ Li,335 PSAY SPACE(8)  //20060328
			@ Li,343 PSAY SPACE(6)  //20060328
			@ Li,349 PSAY mPedido1+mItem1 //20060328  SPACE(20)
			@ Li,369 PSAY SUBSTR(mDescricao,1,60) //20060328
			@ Li,429 PSAY SUBSTR(MCODPROD,1,10)   //20060328
			@ Li,439 PSAY SPACE(20) //20060328     
			
			DbSelectArea("ASSAT")
			DbSkip()
			LOOP
		ENDIF         
		
		MPEDIDO2 := "" 
		MITEM2   := ""
		EDICAO2  := "" 
		MNOME2   := ""
		MDEST2   := ""
		MV_END2  := ""
		MBAIRRO2 := ""
		MMUN2    := ""
		MCEP2    := ""
		MEST2    := ""
		
		MPEDIDO3 := ""
		MITEM3   := ""
	   	EDICAO3  := ""
		MNOME3   := ""
		MDEST3   := ""
		MV_END3  := ""
		MBAIRRO3 := ""
		MMUN3    := ""
		MCEP3    := ""
		MEST3    := ""
		
		quantidd++
		
		DbSelectArea("ASSAT")
		DbSkip()
		
		if !eof()
			//ATUALIZAR AS VARIAVEIS
			MNOME2     := ASSAT->NOME
			MPEDIDO2   := ASSAT->NUMPED
			MITEM2     := ASSAT->ITEM
			EDICAO2    := ALLTRIM(STR(MV_PAR02)) 
			DbSelectArea("SA1")
			If DbSeek(xFilial()+ASSAT->CODCLI)
				mV_End2  := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060323
				mBairro2 := SA1->A1_BAIRRO
				mMun2    := SA1->A1_MUN
				mEst2    := SA1->A1_EST
				mCEP2    := SA1->A1_CEP
				mDest2   := SPACE(40)
			Endif
			
			DbSelectArea("SZN")
			DbSeek(xFilial()+ASSAT->CODCLI+ASSAT->CODDEST)
			If Found()
				mDest2 := SZN->ZN_NOME
			Endif
			
			DbSelectArea("SZO")
			DbSeek(xFilial()+ASSAT->CodCli+ASSAT->CodDest)
			If Found()
				mV_End2  := ALLTRIM(SZO->ZO_TPLOG)+ " " + ALLTRIM(SZO->ZO_LOGR) + " " + ALLTRIM(SZO->ZO_NLOGR) + " " + ALLTRIM(SZO->ZO_COMPL) //20060323
				mBairro2 := SZO->ZO_BAIRRO
				mMun2    := SZO->ZO_CIDADE
				mEst2    := SZO->ZO_ESTADO
				mCEP2    := SZO->ZO_CEP
			Endif
			//FIM DE ATUALIZACAO DE VARIAVEIS
			quantidd++
			DbSelectArea("ASSAT")
			DbSkip()
		endif
		
		if !eof()
			//ATUALIZAR AS VARIAVEIS
			MNOME3   := ASSAT->NOME
			MPEDIDO3 := ASSAT->NUMPED
     		MITEM3   := ASSAT->ITEM 
     		EDICAO3  := ALLTRIM(STR(MV_PAR02))
			DbSelectArea("SA1")
			If DbSeek(xFilial()+ASSAT->CODCLI)
				mV_End3  := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060323
				mBairro3 := SA1->A1_BAIRRO
				mMun3    := SA1->A1_MUN
				mEst3    := SA1->A1_EST
				mCEP3    := SA1->A1_CEP
				mDest3   := SPACE(40)
			Endif
			
			DbSelectArea("SZN")
			DbSeek(xFilial()+ASSAT->CODCLI+ASSAT->CODDEST)
			If Found()
				mDest3 := SZN->ZN_NOME
			Endif
			
			DbSelectArea("SZO")
			DbSeek(xFilial()+ASSAT->CodCli+ASSAT->CodDest)
			If Found()
				mV_End3  := ALLTRIM(SZO->ZO_TPLOG)+ " " + ALLTRIM(SZO->ZO_LOGR) + " " + ALLTRIM(SZO->ZO_NLOGR) + " " + ALLTRIM(SZO->ZO_COMPL) //20060323
				mBairro3 := SZO->ZO_BAIRRO
				mMun3    := SZO->ZO_CIDADE
				mEst3    := SZO->ZO_ESTADO
				mCEP3    := SZO->ZO_CEP
			Endif
			//FIM DE ATUALIZACAO DE VARIAVEIS
			quantidd++
			DbSelectArea("ASSAT")
			DbSkip()
		endif


		if mv_par03 == 1     
 
	       	@ LIN+LI,001 PSAY MPEDIDO1 + '    ' + ALLTRIM(MITEM1) + '    ' + EDICAO1  
        	@ LIN+LI,045 PSAY MPEDIDO2 + '    ' + ALLTRIM(MITEM2) + '    ' + EDICAO2 
         	@ LIN+LI,089 PSAY MPEDIDO3 + '    ' + ALLTRIM(MITEM3) + '    ' + EDICAO3

		     LI := LI+1
		
			@ LIN+LI,001 PSAY SUBSTR(mNOME1,1,40)
			@ LIN+LI,045 PSAY SUBSTR(mNOME2,1,40)
			@ LIN+LI,089 PSAY SUBSTR(mNOME3,1,40)
		  	LI++
	
			@ LIN+LI,001 PSAY SUBSTR(MDEST1,1,40)
			@ LIN+LI,045 PSAY SUBSTR(MDEST2,1,40)
			@ LIN+LI,089 PSAY SUBSTR(MDEST3,1,40)
		   	LI := LI +1
			
			@ LIN+LI,001 PSAY SUBSTR(MV_ENDERECO1,1,40)
			@ LIN+LI,045 PSAY SUBSTR(MV_END2,1,40)
			@ LIN+LI,089 PSAY SUBSTR(MV_END3,1,40)
		   	LI++
		   	
		   	//20060323 DAQUI
		   	@ LIN+LI,001 PSAY SUBSTR(MV_ENDERECO1,41,40)
			@ LIN+LI,045 PSAY SUBSTR(MV_END2,41,40)
			@ LIN+LI,089 PSAY SUBSTR(MV_END3,41,40)
		   	LI++
		   	
		   	@ LIN+LI,001 PSAY SUBSTR(MV_ENDERECO1,81,40)
			@ LIN+LI,045 PSAY SUBSTR(MV_END2,81,40)
			@ LIN+LI,089 PSAY SUBSTR(MV_END3,81,40)
		   	LI++
		   	//20060323 ATE DAQUI
		
			@ LIN+LI,001 PSAY SUBSTR(MBAIRRO1,1,40)
			@ LIN+LI,045 PSAY SUBSTR(MBAIRRO2,1,40)
			@ LIN+LI,089 PSAY SUBSTR(MBAIRRO3,1,40)
			LI++
	
			@ LIN+LI,001 PSAY SUBSTR(MCEP1,1,5)+'-'+SUBSTR(MCEP1,6,3)+'   ' +SUBSTR(MMUN1,1,20)+' ' +SUBSTR(MEST1,1,2)
			@ LIN+LI,045 PSAY SUBSTR(MCEP2,1,5)+'-'+SUBSTR(MCEP2,6,3)+'   ' +SUBSTR(MMUN2,1,20)+' ' +SUBSTR(MEST2,1,2)
			@ LIN+LI,089 PSAY SUBSTR(MCEP3,1,5)+'-'+SUBSTR(MCEP3,6,3)+'   ' +SUBSTR(MMUN3,1,20)+' ' +SUBSTR(MEST3,1,2)
	  		LI++          
	  		

/*			@ LIN+LI,001 PSAY "." //20060323
			LI:=LI+1          //20060323
  */
            LI := 2
			lin:=prow()
		Endif

	End


	If mv_par03 == 1    
	
		@ LIN+LI+1, 001 PSAY "PRODUTO...: " + MCODPROD
		@ LIN+LI+2, 001 PSAY "DESCRICAO.: "	 + MDESCRICAO
		@ LIN+LI+3, 001 PSAY "PORTE.....: " + mv_par01
		@ LIN+LI+4, 001 PSAY "QUANTIDADE: " + str(quantidd,7)	 
		@ LIN+LI+5, 001 PSAY ".   "	
		@ LIN+LI+6, 001 PSAY ".   "	 //20060323
		@ LIN+LI+7, 001 PSAY ".   "	//20060323
		@ LIN+LI+8, 001 PSAY ".   "	//20060323
//		@ LIN+LI+9, 001 PSAY ".   "//20060323
	
		setprc(0,0)
		lin := prow()
 	  	li := 1    // era =5 20031008
	Endif
	
	If mv_par03 == 3
		If Linha >= 58
			Linha := 0
			Cabec(_cTitulo,Cabec1,Cabec2,Programa,Tamanho,nCaracter)
		Endif
		
		@ LIN+LI, 001 PSAY  MCODPROD
		@ LIN+LI, 016 PSAY  MDESCRICAO
		@ LIN+LI, 061 PSAY  mv_par01
		@ LIN+LI, 070 PSAY  str(quantidd,7)
		mQuantidt:=mQuantidt+quantidd
		setprc(0,0)
		li := 1
		linha := linha + 1
	endif
	
	DbSelectArea("ETIQ")
	DbSkip()
End         

If Mv_par03== 3     
   @ LIN+LI+2, 001 PSAY  'TOTAL............'
   @ LIN+LI+2, 070 PSAY  str(	mQuantidt,7) 
   @ LIN+LI+3, 070 PSAY  '       '
   setprc(0,0)    
 Endif

//fechar as tabelas
DbSelectArea("ASSAT")
DbCloseArea()

DbSelectArea("SA1")
DbCloseArea()

DbSelectArea("SZN")
DbCloseArea()

DbSelectArea("SZO")
DbCloseArea()

//DbSelectArea("SB1")     //12.04.2003
//DbCloseArea()

DbSelectArea("ETIQ")
DBcloseArea()

//bloco fim de impressao
SET DEVICE TO SCREEN

IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()

return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RFAT110   ºAutor  ³Danilo C S Pala     º Data ³  02/10/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Inserir em Etiq                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

static Function InserirEtiq()

//INSERINDO NO ETIQ

DbSelectArea("ETIQ")
// verifica se existe, se sim, verifica o porte para se igual ao mv_par01 atualiza-lo
if DbSeek(ASSAT->CODPROD)
	if ASSAT->PORTE == mv_par01
		PORTE := mv_par01
	endif
else
	RecLock("ETIQ",.t.)
	CODPROD := ASSAT->CODPROD
	//SITUAC  := ASSAT->SITUAC //NAO ATUALIZAR MAIS AQUI UTILIZAR DA ASSAT 20110405
	PORTE   := ASSAT->PORTE
	EDSUSP  := ASSAT->EDSUSP
	EDIN    := ASSAT->EDIN
	MsUnlock()
endif

return



//************************************************************
//ValidPerg()
//************************************************************
Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
aAdd(aRegs,{cPerg,"01","Porte","Porte","Porte","mv_ch1","C",1,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Edicao","Edicao","Edicao","mv_ch2","N",4,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Tipo de Saida","Tipo de Saida","Tipo de Saida","mv_ch3","C",01,0,0,"C","","MV_PAR03","Etiquetas","Etiquetas","Etiquetas","","","Arquivo Texto","Arquivo Texto","Arquivo Texto","","","Totais","Totais","Totais","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Produto de","Produto de","Produto de","mv_ch4","C",15,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","","",""})
aAdd(aRegs,{cPerg,"05","Produto ate","Produto ate","Produto ate","mv_ch5","C",15,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","","",""})

_nLimite := If(Len(aRegs[1])<FCount(),Len(aRegs[1]),FCount())
For i := 1 To Len(aRegs)
	If !DbSeek(cPerg + aRegs[i,2])
		Reclock("SX1", .T.)
		For j := 1 to _nLimite
			FieldPut(j, aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next
DbSelectArea(_sAlias)

Return(.T.)
