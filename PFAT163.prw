#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/03/02
/*/     
Alterado por Danilo C S Pala em 20060116: ajustes solicitados pelo Cicero
//20060124: Alterar campos de produto e centro de custo para dentro do complemento
//Danilo C S Pala 20100305: ENDBP
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT163   ³Autor: Danilo C S Pala        ³ Data:   20060112 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera arquivo para DIRECT						             ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function PFAT163()

SetPrvt("Programa, MHORA, cArq, cString, _cString")
SetPrvt("LCONTINUA, CARQPATH, _CSTRING, MEMPRESA")
SetPrvt("_ACAMPOS, _CNOME, CINDEX, CKEY, CARQ") //farqtrab
SetPrvt("_ACAMP1, _CNOME1, CARQ1") //farqtrab

SetPrvt("_cTitulo, _ccMens1, cTexto1, cProcedimento, cMsgFinal") //tela
SetPrvt("CNOTA, CSERIE, ccodprod, cccusto")


Programa   := "PFAT163"
MHORA      := TIME()
cArq       := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString    := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)   
cArq1 	   := "DIRECT1"

lContinua  := .T.
cArqPath   :=GetMv("MV_PATHTMP")
_cString   :=cArqPath+cString+".DBF"
mEmpresa   := SM0->M0_CODIGO            

FArqTrab()

//TELA
_cTitulo  := "Gerar Arquivo para DIRECT"
_ccMens1  := "Fonte: \siga\arqass\opubl_b.dbf"
cTexto1 := "Resolver A"
cProcedimento := space(1)
cMsgFinal := space(200)
cserie :=  space(3)
cnota := space(6)
ccodprod   := space(9)
cccusto   := space(9)

@ 010,001 TO 220,300 DIALOG oDlg TITLE _cTitulo
@ 010,005 SAY "Serie"
@ 010,040 GET cSERIE
@ 025,005 SAY "Nota"
@ 025,040 GET cnota
@ 040,005 SAY "Produto"
@ 040,040 GET ccodprod
@ 055,005 SAY "C.Custo"
@ 055,040 GET cccusto
@ 055,080 BUTTON "Inserir nota" SIZE 40,11 ACTION Processa({||Inserir()})
@ 070,005 SAY "Arquivo:"
@ 070,030 BUTTON "Visualizar" SIZE 40,11 ACTION Processa({||Visualizar()})
@ 070,080 BUTTON "Limpar" SIZE 40,11 ACTION Processa({||Limpar()})
@ 085,030 BUTTON "Processar" SIZE 40,11 ACTION Processa({||ProcNota()})
@ 085,080 BUTTON "Fechar" SIZE 40,11 ACTION ( Close(oDlg) )
Activate Dialog oDlg CENTERED
      
//fechar os arquivos
DBselectArea(cArq)
DBCloseArea(cArq)
DBselectArea(cArq1)
DBCloseArea(cArq1)

return



//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ Inserir()                                                     ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Insere as notas fiscais no arquivo para processar em conjunto |
//³           ³ na funcao nota()             								  ³
//³           ³ 															  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function Inserir()
DbSelectArea(cArq1)
RecLock(cArq1,.T.)
	Replace serie   With  cserie
	Replace nota   With  cnota
	Replace codprod with ccodprod
	Replace ccusto With cccusto
MsUnlock()  
Return

	
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ FARQTRAB()                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Cria arquivos de trabalhos 									  ³
//³           ³                               								  ³
//³           ³ 															  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function FARQTRAB()
_aCampos := {}
AADD(_aCampos,{"CODREMET","C",4,0})
AADD(_aCampos,{"PRODUTO","C",4,0})
AADD(_aCampos,{"NOTA","C",12,0})
AADD(_aCampos,{"AR","C",1,0})
AADD(_aCampos,{"QTD","N",4,0})
AADD(_aCampos,{"VALOR","N",13,2})
AADD(_aCampos,{"NOME","C",40,0})
AADD(_aCampos,{"CENDER","C",60,0})
AADD(_aCampos,{"COMPL","C",20,0})
AADD(_aCampos,{"BAIRRO","C",40,0})
AADD(_aCampos,{"MUN","C",40,0})
AADD(_aCampos,{"ESTADO","C",2,0})
AADD(_aCampos,{"PAIS","C",20,0})
AADD(_aCampos,{"CEP","C",10,0})
AADD(_aCampos,{"EMAIL","C",30,0})
AADD(_aCampos,{"DDD","C",4,0})
AADD(_aCampos,{"TELFONE","C",11,0})
AADD(_aCampos,{"PEDIDO","C",30,0})
AADD(_aCampos,{"PESO","N",15,3})
AADD(_aCampos,{"TIPOPES","C",1,0})
AADD(_aCampos,{"CGC","C",16,0}) 
//APENAS PARA CONSTAR NAO DEVE SER 
AADD(_aCampos,{"QTDRET","N",2,0})
AADD(_aCampos,{"TIPOEND","C",1,0})
AADD(_aCampos,{"DTENTREGA","C",10,0})
AADD(_aCampos,{"COD1","C",1,0})
AADD(_aCampos,{"QTDPARC","N",2,0})
AADD(_aCampos,{"DT1PARC","C",8,0})
AADD(_aCampos,{"VL1PARC","N",13,2})
AADD(_aCampos,{"FP1PARC","C",1,0})

AADD(_aCampos,{"DT2PARC","C",8,0})
AADD(_aCampos,{"VL2PARC","N",13,2})
AADD(_aCampos,{"FP2PARC","C",1,0})

AADD(_aCampos,{"DT3PARC","C",8,0})
AADD(_aCampos,{"VL3PARC","N",13,2})
AADD(_aCampos,{"FP3PARC","C",1,0})

AADD(_aCampos,{"DT4PARC","C",8,0})
AADD(_aCampos,{"VL4PARC","N",13,2})
AADD(_aCampos,{"FP4PARC","C",1,0})

AADD(_aCampos,{"DT5PARC","C",8,0})
AADD(_aCampos,{"VL5PARC","N",13,2})
AADD(_aCampos,{"FP5PARC","C",1,0})

AADD(_aCampos,{"DT6PARC","C",8,0})
AADD(_aCampos,{"VL6PARC","N",13,2})
AADD(_aCampos,{"FP6PARC","C",1,0})     
// 20060124   AADD(_aCampos,{"CODPROD","C",9,0})     
// 20060124   AADD(_aCampos,{"CCUSTO","C",9,0})     


_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "NOTA"

dbUseArea(.T.,, _cNome,cArq,.F.,.F.)

dbSelectArea(cArq)
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")

           
_aCamp1 := {}
AADD(_aCamp1,{"SERIE","C",3,0})
AADD(_aCamp1,{"NOTA","C",6,0})
AADD(_aCamp1,{"CODPROD","C",9,0})     
AADD(_aCamp1,{"CCUSTO","C",9,0})     

_cNome1 := CriaTrab(_aCamp1,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "SERIE+NOTA"
dbUseArea(.T.,, _cNome1,cArq1,.F.,.F.)
dbSelectArea(cArq1)
Indregua(cArq1,cIndex,ckey,,,"Selecionando Registros do Arq")

Return



//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ VISUALIZAR()                                                  ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Visualizar o arquivo de notas								  ³
//³           ³                               								  ³
//³           ³ 															  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function VISUALIZAR()             
setprvt("oDlg1")
DbselectArea(cArq1)
DBGotop()
@ 200,001 TO 400,600 DIALOG oDlg1 TITLE "Arquivo de Notas"
@ 6,5 TO 100,250 BROWSE cArq1 FIELDS _aCamp1
@ 070,260 BUTTON "_Ok" SIZE 40,15 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED                           
return


//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ Limpar()                                                      ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Limpa o arquivo de notas 									  ³
//³           ³                               								  ³
//³           ³ 															  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function Limpar()
DBselectArea(cArq1)
dbgotop()
While !Eof()
      RECLOCK(cArq1,.F.)
      DELETE
      MsUnlock()
	DBSkip()
End        
MsgInfo("Arquivo limpo!")
return


//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ ProcNota()                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Processa o arquivo de notas 								  ³
//³           ³                               								  ³
//³           ³ 															  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function ProcNota()
setprvt("mnota, mserie, mvalor, mpeso, mqtd, mnome, mender")
setprvt("mcompl, mbairro, mmun, mestado, mpais, mcep") 
setprvt("memail, mddd, mtelefone, mpedido, mtppess, mcgc")
setprvt("mcodcli, mCODPROD, mccusto")
DBselectArea(cArq1)
dbgotop()
While !Eof()
	mnota 	 := NOTA
	mserie   := SERIE     
	mcodprod := substr(CODPROD,1,9)
	mccusto  := substr(CCUSTO,1,9)
	
	//cabecalho da nfs
	DbSelectArea("SF2")
	DBSetOrder(1)
	DbSeek(xFilial("SF2")+mnota+mserie)
    if  SF2->F2_DOC != mnota .or. SF2->F2_SERIE != mserie
    	DBSelectArea(cArq1)
    	DBSkip()
    	Loop
 	end if                           
 	mvalor := SF2->F2_VALBRUT
    mpeso  := SF2->F2_PLIQUI                      
    mcodcli := SF2->F2_CLIENTE
    mloja := SF2->F2_LOJA

    //cliente
 	DbSelectArea("SA1")
	dbsetorder(1)
	If DbSeek(xFilial("SA1")+mCodcli+mloja)
		mNome   := SA1->A1_NOME
		mcompl	:= ""
		mpais 	:= SA1->A1_PAIS
		memail  := SA1->A1_EMAIL
		mddd    := "" 
   		mtelefone := SUBSTR(trim(SA1->A1_TEL),1,11)
		mCgc    := "'"+TRIM(SA1->A1_CGC)+"'"
		IF LEN(MCGC) == 14
			mtppess	:= "J"
		ELSE
			mtppess := "F"
		END IF
		
//20100305 DAQUI
		IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
			DbSelectArea("ZY3")
			DbSetOrder(1)
			DbSeek(XFilial()+XCLI+XLOJA)
			mender  :=ZY3_END
			mbairro :=ZY3_BAIRRO
			mmun    :=ZY3_CIDADE
			mestado :=ZY3_ESTADO
			mcep    :="'"+ZY3_CEP+"'"
		ELSEIF SUBS(SA1->A1_ENDCOB,1,1)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
			DbselectArea("SZ5")
			DbsetOrder(1)
			DBSEEK(XFILIAL("SZ5")+SA1->A1_COD+SA1->A1_LOJA)
			mender  := SZ5->Z5_END
			mbairro := SZ5->Z5_BAIRRO
			mcep    := "'"+SZ5->Z5_CEP+"'"
			mmun 	:= SZ5->Z5_CIDADE
			mestado := SZ5->Z5_ESTADO
		ELSE
			mender  := SA1->A1_END
			mbairro := SA1->A1_BAIRRO
			mcep    := "'"+SA1->A1_CEP+"'"
			mmun 	:= SA1->A1_MUN
			mestado := SA1->A1_EST
		ENDIF
	else
		mNome   := ""
		mcompl	:= ""
		mpais 	:= ""
		memail  := ""
		mddd    := "" 
   		mtelefone := ""
		mCgc    := "00000000000000"
		mtppess := ""
		mender  := ""
		mbairro := ""
		mcep    := ""
		mmun 	:= ""
		mestado := ""
	end if

    //itens da NFS
    mqtd := 1 //cicero 20060116
    mpedido := ""            
    mcompl := "'"+MCODPROD + MCCUSTO +"'"   // 20060124
    
 //20060117   mCODPROD := ""
 //20060117   mccusto := ""
 	DbSelectArea("SD2")
	DBSetOrder(3)
	DbSeek(xFilial("SD2")+mnota+mserie)     
	While !Eof() .and. SD2->D2_DOC == mnota .and. SD2->D2_SERIE == mserie
		//mqtd := SD2->D2_QUANT  + mqtd Cicero 20060116
		mpedido 	:= SD2->D2_PEDIDO
 //20060117	    mCODPROD 	:= "'"+SD2->D2_COD+"'"
 //20060117	    mccusto 	:= "'"+SD2->D2_CCUSTO+"'"
		DBSkip()
	end
	
	//grava arquivo
	DbSelectArea(cArq)
	RecLock(cArq,.T.)
		Replace CODREMET with "9999"
		Replace PRODUTO with "'01'"
		Replace NOTA with mserie+mnota
		Replace AR with "N"
		Replace QTD with mqtd
		Replace VALOR with mvalor
		Replace NOME with mnome
		Replace CENDER with mender
		Replace COMPL with mcompl
		Replace BAIRRO with mbairro
		Replace MUN with mmun
		Replace ESTADO with mestado
		Replace PAIS with mpais
		Replace CEP with mcep
		Replace EMAIL with memail
		Replace DDD with mddd
		Replace TELFONE with mtelefone
		Replace PEDIDO with mpedido
		Replace PESO with mpeso
		Replace TIPOPES with mtppess
		Replace CGC with mcgc
        Replace COD1 with "N"        
// 20060124		Replace CODPROD with mCODPROD
// 20060124		Replace CCUSTO with mccusto
	MsUnlock()  
      
	DBselectArea(cArq1)
	DBSkip()
End                      

DbSelectArea("SF2")
DBCloseArea("SF2")
DbSelectArea("SD2")
DBCloseArea("SD2")
DbSelectArea("SA1")                                    

DBCloseArea("SA1")
DbSelectArea("SZ5")
DBCloseArea("SZ5")
      
DbSelectArea(cArq)
dbGoTop()
COPY TO &_cString VIA "DBFCDXADS" // 20121106 

Msginfo("Arquivo gerado: "+ _cString)
return