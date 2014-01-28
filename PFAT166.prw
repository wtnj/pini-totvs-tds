#include "rwmake.ch" 
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/     
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT166   ³Autor: Danilo C S Pala        ³ Data:   20060705 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera arquivo retorno da procedure sp_consignante           ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function PFAT166() 
setprvt("cMsg")
SETPRVT("_aCampos, _cNome, cIndex, cKey, cArq, cString, cArqPAth, _cString, MHORA")

private datade := date()
private dataate := date()
private consig := space(6)
                                                                                 
MHORA     := TIME()
cArq      := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+"LI"
cArqPath  := GetMv("MV_PATHTMP")
_cString  := cArqPath+cString+".DBF"


FARQTRAB()

@ 010,001 TO 230,350 DIALOG oDlg TITLE "Arquivo de Consignantes"
@ 010,005 SAY "Data de"
@ 010,080 GET datade SIZE 40,12
@ 025,005 SAY "Data ate"
@ 025,080 GET dataate SIZE 40,12
@ 040,005 SAY "Consignante"
@ 040,080 GET consig SIZE 40,12 F3 "SA2"
@ 095,005 BUTTON "Gerar Arquivo" SIZE 40,12 ACTION Processa({||ProcArq()})
@ 095,070 BUTTON "Fechar" SIZE 40,12 ACTION ( Close(oDlg) )
Activate Dialog oDlg CENTERED
Return    



Static Function ProcArq()
Private nQTD_ENT    := 0
Private nTOT_ENT    := 0
Private nQTD_VEND   := 0
Private nQTD_CORT   := 0
Private nQTD_DEV    := 0
Private nTOT_SAI    := 0 
Private nPRC_CAPA   := 0  
Private nPRC_LIQ    := 0 
Private nSALDO      := 0
         
DbSelectArea("SA2")
if RDDName() <> "TOPCONN"
		MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
		Return nil
endif

//Verifica se a Stored Procedure Teste existe no Servidor
If TCSPExist("SP_CONSIGNANTE")
	//SP_CONSIGNANTE(IN_CONSIG VARCHAR2, IN_DATADE VARCHAR2, IN_DATAATE VARCHAR2)
	aRet := TCSPExec("SP_CONSIGNANTE", consig, dtos(datade), dtos(dataate))
	

	cQuery := "SELECT B1_COD, B1_DESC, B1_PRV1, B1_CUSTD FROM "+ RetSqlName("SB1") + " WHERE B1_FILIAL='"+xfilial("SB1")+"' AND B1_CONSIG='" + CONSIG + "' AND D_E_L_E_T_<>'*'"
	TCQUERY cQuery NEW ALIAS "QUERYSB1"

	DbSelectArea("QUERYSB1")
	DBGoTop()
	Procregua(Reccount())        
	cMsg := ""
	While ! Eof()     
		nQTD_ENT    := 0
		nQTD_DEV    := 0
		nTOT_ENT    := 0
		nQTD_VEND   := 0
		nQTD_CORT   := 0
		nTOT_SAI    := 0 
		nPRC_CAPA   := QUERYSB1->B1_PRV1
		nPRC_LIQ    := QUERYSB1->B1_CUSTD
		nSALDO      := 0
		//cMsg := cMsg + QUERYSB1->B1_COD + QUERYSB1->B1_DESC +'/ '

		cQuery := "SELECT CONSIG, NOME_CONSIG, MES, PRODUTO, LIVRO, TIPO_NF, NOTA, SERIE, EMISSAO, QTD,  VALOR_UNI,  VALOR_TOT FROM NF_CONSIG WHERE PRODUTO ='" + QUERYSB1->B1_COD +"'"
		TCQUERY cQuery NEW ALIAS "QUERYC"

		DbSelectArea("QUERYC")
		DBGoTop()
		While ! Eof()
			IF QUERYC->TIPO_NF == "V"
				nQTD_VEND := nQTD_VEND + QUERYC->QTD
			ELSEIF QUERYC->TIPO_NF == "C"
				nQTD_CORT := nQTD_CORT + QUERYC->QTD
			ELSEIF QUERYC->TIPO_NF == "D"
				nQTD_DEV := nQTD_DEV + QUERYC->QTD
			ELSE //ENTRADA
				nQTD_ENT := nQTD_ENT + QUERYC->QTD
			ENDIF                      
			
			//cMsg := cMsg + QUERYC->NOTA + QUERYC->SERIE +'/ '
			DbSelectArea("QueryC")
			DBSkip()
		end          
		nTOT_ENT := nQTD_ENT
		nTOT_SAI := nQTD_VEND + nQTD_CORT + nQTD_DEV
		nSALDO   := nTOT_ENT - nTOT_SAI
		                               
		// INSERIR NO cARQ
		DbSelectArea(cArq)
		RecLock(cArq,.T.)
			Replace PRODUTO  with QUERYSB1->B1_COD
			Replace LIVRO    with QUERYSB1->B1_DESC
			Replace QTD_ENT  with nQTD_ENT
			Replace QTD_DEV  with nQTD_DEV
			Replace TOT_ENT  with nTOT_ENT
			Replace QTD_VEND with nQTD_VEND
			Replace QTD_CORT with nQTD_CORT
			Replace TOT_SAI  with nTOT_SAI
			Replace PRC_CAPA with QUERYSB1->B1_PRV1
			Replace PRC_LIQ  with QUERYSB1->B1_CUSTD
			Replace SALDO    with nSALDO
		MsUnlock()

		DbSelectArea("QUERYC")		                    
		DBCloseArea() // Fecha a Query
				
		DbSelectArea("QUERYSB1")
		DBSkip()
		IncProc()
	end 

cMsg:= "Arquivo Gerado PRODUTO em: "+_cString
DbSelectArea("QUERYSB1")
DBGotop()
DbSelectArea(cArq)
dbGoTop()
COPY TO &_cString VIA "DBFCDXADS" // 20121106 

DbSelectArea("QUERYSB1")
DBCloseArea()

cString   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+"NF"
cArqPath  := GetMv("MV_PATHTMP")
_cString  := cArqPath+cString+".TXT"
cQuery := "SELECT CONSIG, NOME_CONSIG, MES, PRODUTO, LIVRO, TIPO_NF, NOTA, SERIE, EMISSAO, QTD,  VALOR_UNI, VALOR_TOT FROM NF_CONSIG"
TCQUERY cQuery NEW ALIAS "QUERYNF"
DbSelectArea("QUERYNF")
dbGoTop()
COPY TO &_cString SDF

DbSelectArea("QUERYNF")
DBCloseArea()

cMsg := cMsg + chr(13)+ "Arquivo Gerado NF em: "+_cString
MSGINFO(cMsg)
EndIf

Return





//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ FARQTRAB()                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function FARQTRAB()
cArq      := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
_aCampos := {}

AADD(_aCampos,{"PRODUTO"   ,"C",  15,0})
AADD(_aCampos,{"LIVRO"     ,"C",  40,0})
AADD(_aCampos,{"QTD_ENT"   ,"N",  12,2})
AADD(_aCampos,{"TOT_ENT"   ,"N",  12,2})
AADD(_aCampos,{"QTD_VEND"  ,"N",  12,2})
AADD(_aCampos,{"QTD_CORT"  ,"N",  12,2})
AADD(_aCampos,{"QTD_DEV"   ,"N",  12,2})
AADD(_aCampos,{"TOT_SAI"   ,"N",  12,2})
AADD(_aCampos,{"PRC_CAPA"  ,"N",  12,2})
AADD(_aCampos,{"PRC_LIQ"   ,"N",  12,2})
AADD(_aCampos,{"SALDO"     ,"N",  12,2})
_cNome := CriaTrab(_aCampos,.t.)

cIndex := CriaTrab(Nil,.F.)
cKey   := "PRODUTO"
dbUseArea(.T.,, _cNome,cArq,.F.,.F.)
dbSelectArea(cArq)

MsAguarde({|| Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")},"Aguarde","Gerando Indice Temporario (TRB)...")

Return
