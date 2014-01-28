#include "rwmake.ch"
/*
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
SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,LIMITE,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CNATUREZA,ARETURN,SERNF,NOMEPROG")
SetPrvt("CPERG,NLASTKEY,LCONTINUA,NLIN,WNREL,CSTRING")
SetPrvt("TREGS,M_MULT,P_ANT,P_ATU,P_CNT,M_SAV20")
SetPrvt("M_SAV7,_ACAMPOS,_CNOME,XNOTA,MAGENCIA,XSERIE")
SetPrvt("XPEDIDO,MTPTRANS,XCLIENTE,XLOJA,XCODAG,MNOME")
SetPrvt("MEND,MBAIR,MMUNI,MESTA,MCEP,MDESC")
SETPRVT("_aCampos,_cNome,cFiltro,cChave,cIndex,cArq,_bCampos,_bNome,auxiliar")
SETPRVT("C,COL,quantidd, MCODPROD, MDESCRICAO, ca_campos, ca_nome")
setprvt("MNOME1, MDEST1, MV_ENDERECO1, MBAIRRO1, MNUM1, MCEP1, MEST1, MPEDIDO1")
setprvt("MNOME2, MDEST2, MV_END2, MBAIRRO2, MNUM2, MCEP2, MEST2, MPEDIDO2")
setprvt("MNOME3, MDEST3, MV_END3, MBAIRRO3, MNUM3, MCEP3, MEST3, MPEDIDO3")

li        := 1
LIN       := 0
CbTxt     := ""
CbCont    := ""
nOrdem    := 0
Alfa      := 0
Z         := 0
M         := 0
tamanho   := "G"
limite    := 220
titulo    := PADC("ETIQUETAS  ",74)
cDesc1    := PADC("Este programa ira emitir as Etiquetas",74)
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
wnrel     := "ETIQASLI"


/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Parametros : mv_par01 = Porte
/ ³Parametros : mv_par02 = Edicao
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

MsgAlert("Certifique-se que o arquivo de assinantes está atualizado")
If !Pergunte(cPerg)      //parametros de FAT110 em SX1  para montar a GUI
	Return
Endif

CSTRING:='SF2'
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.f.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

//dbUseArea(.T.,, "\SIGA\ARQASS\Pfat057.dbf","Pfat057",.F.,.F.) //21.04.2003
dbUseArea(.T.,, "\SIGA\ARQASS\ASSAT02.dbf","ASSAT02",.F.,.F.)

lEnd  := .F.
bBloco:= {|lEnd| IMPETIQ(@lEnd)}
Processa( bBloco, "Aguarde" ,"Processando...", .T. )

Return


//--------------------------------------------------------------------------------------------
Static Function IMPETIQ()

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
/*
DbSelectArea("Pfat057")
cIndex  := CriaTrab(nil,.f.)
cChave  := "CODPROD"
cFiltro := ""
IndRegua("Pfat057",cIndex,cChave,,cFiltro,"Filtrando ..")
Dbgotop()                             //12.04.2003
*/

DbSelectArea("ASSAT02")  // 12.04.2003
cIndex := CriaTrab(nil,.f.)
cChave  := "CODPROD"
cFiltro := "EDSUSP>=MV_PAR02 .and. EDIN<=MV_PAR02"
IndRegua("ASSAT02",cIndex,cChave,,cFiltro,"Filtrando ..")
Dbgotop()

//inserindo no ETIQ
while !eof()
	InserirETIQ()
	DbselectArea("ASSAT02")
	DbSkip()
end
//fechando pfat057
DbSelectArea("ASSAT02")
DbCloseArea()

dbUseArea(.T.,, "\SIGA\ARQASS\ASSAT02.dbf","ASSAT02",.F.,.F.)

DbSelectArea("ETIQ")
cIndex  := CriaTrab(nil,.f.)
cChave  := "CODPROD"
cFiltro := "ETIQ->PORTE == MV_PAR01 .and. ETIQ->SITUAC == 'AA'"
cFiltro := cFiltro+ ".and. ETIQ->EDSUSP>=MV_PAR02 .and. ETIQ->EDIN<=MV_PAR02"
IndRegua("ETIQ",cIndex,cChave,,cFiltro,"Filtrando ..")
Dbgotop()

While !eof()// /*
	quantidd := 0
	
	DbSelectArea("ASSAT02")
	cIndex  := CriaTrab(nil,.f.)
	cChave  := "CODPROD"
	cFiltro := "ASSAT02->PORTE == MV_PAR01 .and. ETIQ->CODPROD == ASSAT02->CODPROD"
    cFiltro := cFiltro+ ".and. ASSAT02->EDSUSP>=MV_PAR02 .and. ASSAT02->EDIN<=MV_PAR02"
	IndRegua("ASSAT02",cIndex,cChave,,cFiltro,"Filtrando ..")
	dbGoTop()
	
	//while dos pedidos
	while !eof()
	//	DbSelectArea("PFAT057")// era pfat057
	
	
	//ATUALIZAR AS VARIAVEIS
	MNOME1 := ASSAT02->NOME
	MPEDIDO1 := ASSAT02->NUMPED
	MDESCRICAO := ASSAT02->DESCR
	MCODPROD := ASSAT02->CODPROD //somente na primeira
	DbSelectArea("SA1")
	If DbSeek(xFilial()+ASSAT02->CODCLI)
		mV_EndERECO1     := SA1->A1_END
		mBairro1  := SA1->A1_BAIRRO
		mMun1     := SA1->A1_MUN
		mEst1     := SA1->A1_EST
		mCEP1     := SA1->A1_CEP
		mDest1    := SPACE(40)
	Endif
	
	DbSelectArea("SZN")
	DbSeek(xFilial()+ASSAT02->CODCLI+ASSAT02->CODDEST)
	If Found()
		mDest1 := SZN->ZN_NOME
	Endif
	
	DbSelectArea("SZO")
	DbSeek(xFilial()+ASSAT02->CodCli+ASSAT02->CodDest)
	If Found()
		mV_EndERECO1    := SZO->ZO_END
		mBairro1 := SZO->ZO_BAIRRO
		mMun1    := SZO->ZO_CIDADE
		mEst1    := SZO->ZO_ESTADO
		mCEP1    := SZO->ZO_CEP
	Endif
	//FIM DE ATUALIZACAO DE VAR
	
	MNOME2 :=  ""
	MDEST2 :=  ""
	MV_END2 := ""
	MBAIRRO2 := ""
	MMUN2 := ""
	MCEP2 := ""
	MEST2 := ""
	MPEDIDO2 := ""
	
	MNOME3 :=  ""
	MDEST3 :=  ""
	MV_END3 := ""
	MBAIRRO3 := ""
	MMUN3 := ""
	MCEP3 := ""
	MEST3 := ""
	MPEDIDO3 := ""
	
	quantidd++
	
	DbSelectArea("ASSAT02")
	DbSkip()
	
	if !eof()
		//ATUALIZAR AS VARIAVEIS
		MNOME2 := ASSAT02->NOME
		MPEDIDO2 := ASSAT02->NUMPED
		DbSelectArea("SA1")
		If DbSeek(xFilial()+ASSAT02->CODCLI)
			mV_End2     := SA1->A1_END
			mBairro2  := SA1->A1_BAIRRO
			mMun2     := SA1->A1_MUN
			mEst2     := SA1->A1_EST
			mCEP2     := SA1->A1_CEP
			mDest2    := SPACE(40)
		Endif
		
		DbSelectArea("SZN")
		DbSeek(xFilial()+ASSAT02->CODCLI+ASSAT02->CODDEST)
		If Found()
			mDest2 := SZN->ZN_NOME
		Endif
		
		DbSelectArea("SZO")
		DbSeek(xFilial()+ASSAT02->CodCli+ASSAT02->CodDest)
		If Found()
			mV_End2    := SZO->ZO_END
			mBairro2 := SZO->ZO_BAIRRO
			mMun2    := SZO->ZO_CIDADE
			mEst2    := SZO->ZO_ESTADO
			mCEP2    := SZO->ZO_CEP
		Endif
		//FIM DE ATUALIZACAO DE VAR
		quantidd++
		DbSelectArea("ASSAT02")
		DbSkip()
	endif
	
	if !eof()
		//ATUALIZAR AS VARIAVEIS
		MNOME3 := ASSAT02->NOME
		MPEDIDO3 := ASSAT02->NUMPED
		DbSelectArea("SA1")
		If DbSeek(xFilial()+ASSAT02->CODCLI)
			mV_End3     := SA1->A1_END
			mBairro3  := SA1->A1_BAIRRO
			mMun3     := SA1->A1_MUN
			mEst3     := SA1->A1_EST
			mCEP3    := SA1->A1_CEP
			mDest3    := SPACE(40)
		Endif
		
		DbSelectArea("SZN")
		DbSeek(xFilial()+ASSAT02->CODCLI+ASSAT02->CODDEST)
		If Found()
			mDest3 := SZN->ZN_NOME
		Endif
		
		DbSelectArea("SZO")
		DbSeek(xFilial()+ASSAT02->CodCli+ASSAT02->CodDest)
		If Found()
			mV_End3    := SZO->ZO_END
			mBairro3 := SZO->ZO_BAIRRO
			mMun3    := SZO->ZO_CIDADE
			mEst3    := SZO->ZO_ESTADO
			mCEP3    := SZO->ZO_CEP
		Endif
		//FIM DE ATUALIZACAO DE VAR
		quantidd++
		DbSelectArea("ASSAT02")
		DbSkip()
	endif
	
	
	
	
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
	
	@ LIN+LI,001 PSAY SUBSTR(MBAIRRO1,1,40)+'              '+MPEDIDO1
	@ LIN+LI,045 PSAY SUBSTR(MBAIRRO2,1,40)+'              '+MPEDIDO2
	@ LIN+LI,089 PSAY SUBSTR(MBAIRRO3,1,40)+'              '+MPEDIDO3
	LI++
	
	@ LIN+LI,001 PSAY SUBSTR(MCEP1,1,5)+'-'+SUBSTR(MCEP1,6,3)+'   ' +SUBSTR(MMUN1,1,20)+' ' +SUBSTR(MEST1,1,2)
	@ LIN+LI,045 PSAY SUBSTR(MCEP2,1,5)+'-'+SUBSTR(MCEP2,6,3)+'   ' +SUBSTR(MMUN2,1,20)+' ' +SUBSTR(MEST2,1,2)
	@ LIN+LI,089 PSAY SUBSTR(MCEP3,1,5)+'-'+SUBSTR(MCEP3,6,3)+'   ' +SUBSTR(MMUN3,1,20)+' ' +SUBSTR(MEST3,1,2)
	LI++
	
	LI := 2
	lin:=prow()
	// /*
	end
	
	
	@ LIN+LI+1, 001 PSAY "PRODUTO...: " + MCODPROD
	@ LIN+LI+2, 001 PSAY "DESCRICAO.: "	 + MDESCRICAO
	@ LIN+LI+3, 001 PSAY "PORTE.....: " + mv_par01
	@ LIN+LI+4, 001 PSAY "QUANTIDADE: " + str(quantidd,7)
	//	@ LIN+LI+5, 001 PSAY ""  //ADICIONADO
	setprc(0,0)
	lin := prow()
	li := 2
	//	  */
	
	DbSelectArea("ETIQ")
	DbSkip()
	
end

//fechar as tabelas
DbSelectArea("ASSAT02")
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
if DbSeek(ASSAT02->CODPROD)
	if ASSAT02->PORTE == mv_par01
		PORTE := mv_par01
	endif
else
	RecLock("ETIQ",.t.)
	CODPROD := ASSAT02->CODPROD
	SITUAC  := ASSAT02->SITUAC
	PORTE   := ASSAT02->PORTE  
	EDSUSP  := ASSAT02->EDSUSP  
	EDIN    := ASSAT02->EDIN
	MsUnlock()
endif

return
