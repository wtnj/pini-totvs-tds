#include "rwmake.ch"
#include "Fileio.ch"
#include "topconn.ch"
#include "tbiconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Pfat250   ºAutor  ³Danilo Pala         º Data ³  20120316   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³											                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                                                             
User Function Pfat250()
Private cCodProd := ""
Private cAlmoxOrigem := "" //almoxarifado de transferencia (origem)
Private cAlmoxDestino := ""  //almoxarifado padrao do produto (destino)
Private nQuant := 0      
Private cALMOXTRAB := "FC"
Private cTipo :="S" //S=Saida, E=Entrada
Private cSerie := ""
Private cDoc := ""
Private cClieFor := ""
Private dEmissao :=  ddatabase

cperg := "PFAT250"
ValidP3Perg()
if !Pergunte(cPerg,.t.)
	return
endif

cTipo := iif(MV_PAR01==1,"E","S" )
cSerie := MV_PAR02
cDoc := MV_PAR03
cClieFor := MV_PAR04
dEmissao :=  MV_PAR05
cALMOXTRAB := mv_par06

If cTipo=="S"
	cQuery := "SELECT D2_COD PRODUTO, D2_QUANT QTD, D2_SERIE SERIE, D2_DOC DOC, D2_CLIENTE CLIEFOR, D2_EMISSAO EMISSAO FROM "+ RETSQLNAME("SD2") +" WHERE D2_FILIAL='"+ XFILIAL("SD2") +"' AND D2_SERIE='"+ cSERIE +"' AND D2_DOC='"+ cDOC +"' AND D2_CLIENTE='"+ cCLIEFOR +"' AND D2_EMISSAO='"+ DTOS(dEMISSAO) +"' AND D_E_L_E_T_<>'*' ORDER BY D2_ITEM"
Else 
	cQuery := "SELECT D1_COD PRODUTO, D1_QUANT QTD, D1_SERIE SERIE, D1_DOC DOC, D1_FORNECE CLIEFOR, D1_EMISSAO EMISSAO FROM "+ RETSQLNAME("SD1") +" WHERE D1_FILIAL='"+ XFILIAL("SD1") +"' AND D1_SERIE='"+ cSERIE +"' AND D1_DOC='"+ cDOC +"' AND D1_FORNECE='"+ cCLIEFOR +"' AND D1_EMISSAO='"+ DTOS(dEMISSAO) +"' AND D_E_L_E_T_<>'*' ORDER BY D1_ITEM"
Endif
DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PINITRAN", .T., .F. )
TcSetField("PINITRAN","EMISSAO"   ,"D")
DbSelectArea("PINITRAN")
dbGotop()
While !EOF()
	cCodProd := PINITRAN->PRODUTO
	nQuant := PINITRAN->QTD       
	If cTipo=="S"	
		cAlmoxOrigem  := posicione("SB1",1,xfilial("SB1")+cCodProd,"B1_LOCPAD")
		cAlmoxDestino := cALMOXTRAB
	ELSE                                                                        
		cAlmoxOrigem  := cALMOXTRAB
		cAlmoxDestino := posicione("SB1",1,xfilial("SB1")+cCodProd,"B1_LOCPAD")
	ENDIF
	If nQuant >0
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Pega a variavel que identifica se o calculo do custo e' :    ³
		//³               O = On-Line                                    ³
		//³               M = Mensal                                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		PRIVATE cCusMed  := GetMv("MV_CUSMED")
		//PRIVATE cCadastro:= OemToAnsi(STR0001)	//"Transferˆncias"
		PRIVATE aRegSD3  := {}
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Verifica se o custo medio e' calculado On-Line               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cCusMed == "O"
			PRIVATE nHdlPrv // Endereco do arquivo de contra prova dos lanctos cont.
		    PRIVATE lCriaHeader := .T. // Para criar o header do arquivo Contra Prova
		    PRIVATE cLoteEst 	// Numero do lote para lancamentos do estoque
	    	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		    //³ Posiciona numero do Lote para Lancamentos do Faturamento     ³
		    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		    dbSelectArea("SX5")
		    dbSeek(xFilial()+"09EST")
	    	cLoteEst:=IIF(Found(),Trim(X5Descri()),"EST ")
		 EndIf
		//para estorno passar o 15o. par metro com .T.
		//Function a260Processa(cCodOrig,cLocOrig,    nQuant260   ,cDocto,        dEmis260, nQuant260D,cNumLote,cLoteDigi,dDtValid, cNumSerie,cLoclzOrig,cCodDest, cLocDest,      cLocLzDest,lEstorno,nRecOrig,nRecDest,cPrograma,    cEstFis,cServico,cTarefa,cAtividade,cAnomalia,cEstDest,cEndDest,cHrInicio,cAtuEst,cCarga,cUnitiza,cOrdTar,cOrdAti,cRHumano,cRFisico,nPotencia,cLoteDest)                                              
		a260Processa(cCodProd,           cAlmoxOrigem,nQuant     ,cSerie+cDoc, ddatabase,0         ,""      ,""       ,ddatabase,""       ,""        ,cCodProd,cAlmoxDestino ,""        ,.F.     ,0       ,0      , "U_PINIDOCTRANSF",""     ,""      ,""     ,""        ,""       ,""      ,""      ,""       ,"N"    ,""    ,""     ,""     ,""     ,""      ,""      ,0        ,"")	
		 /*
		-----------------------------------------------------------------------------
		±±³Fun??o    ³A260Processa  ³ Eveli Morasco             ³ Data ³ 16/01/92 ³±±
		-----------------------------------------------------------------------------
		±±³Descri??o ³ Processamento da inclusao                                  ³±±
		-----------------------------------------------------------------------------
		±±³Parametros³ExpC01: Codigo do Produto Origem - Obrigatorio              ³±±
		±±³          ³ExpC02: Almox Origem             - Obrigatorio              ³±±
		±±³          ³ExpN01: Quantidade 1a UM         - Obrigatorio              ³±±
		±±³          ³ExpC03: Documento                - Obrigatorio              ³±±
		±±³          ³ExpD01: Data                     - Obrigatorio              ³±±
		±±³          ³ExpN02: Quantidade 2a UM                                    ³±±
		±±³          ³ExpC04: Sub-Lote                 - Obrigatorio se Rastro "S"³±±
		±±³          ³ExpC05: Lote                     - Obrigatorio se usa Rastro³±±
		±±³          ³ExpD02: Validade                 - Obrigatorio se usa Rastro³±±
		±±³          ³ExpC06: Numero de Serie                                     ³±±
		±±³          ³ExpC07: Localizacao Origem                                  ³±±
		±±³          ³ExpC08: Codigo do Produto Destino- Obrigatorio              ³±±
		±±³          ³ExpC09: Almox Destino            - Obrigatorio              ³±±
		±±³          ³ExpC10: Localizacao Destino                                 ³±±
		±±³          ³ExpL01: Indica se movimento e estorno                       ³±±
		±±³          ³ExpN03: Numero do registro original (utilizado estorno)     ³±±
		±±³          ³ExpN04: Numero do registro destino (utilizado estorno)      ³±±
		±±³          ³ExpC11: Indicacao do programa que originou os lancamentos   ³±±
		±±³          ³ExpC12: cEstFis    - Estrutura Fisica          (APDL)       ³±±
		±±³          ³ExpC13: cServico   - Servico                   (APDL)       ³±±
		±±³          ³ExpC14: cTarefa    - Tarefa                    (APDL)       ³±±
		±±³          ³ExpC15: cAtividade - Atividade                 (APDL)       ³±±
		±±³          ³ExpC16: cAnomalia  - Houve Anomalia? (S/N)     (APDL)       ³±±
		±±³          ³ExpC17: cEstDest   - Estrututa Fisica Destino  (APDL)       ³±±
		±±³          ³ExpC18: cEndDest   - Endereco Destino          (APDL)       ³±±
		±±³          ³ExpC19: cHrInicio  - Hora Inicio               (APDL)       ³±±
		±±³          ³ExpC20: cAtuEst    - Atualiza Estoque? (S/N)   (APDL)       ³±±
		±±³          ³ExpC21: cCarga     - Numero da Carga           (APDL)       ³±±
		±±³          ³ExpC22: cUnitiza   - Numero do Unitizador      (APDL)       ³±±
		±±³          ³ExpC23: cOrdTar    - Ordem da Tarefa           (APDL)       ³±±
		±±³          ³ExpC24: cOrdAti    - Ordem da Atividade        (APDL)       ³±±
		±±³          ³ExpC25: cRHumano   - Recurso Humano            (APDL)       ³±±
		±±³          ³ExpC26: cRFisico   - Recurso Fisico            (APDL)       ³±±
		±±³          ³ExpN05: nPotencia  - Potencia do Lote                       ³±±
		±±³          ³ExpC27: cLoteDest  - Lote Destino da Transferencia          ³±±
		-----------------------------------------------------------------------------
		±±³ Uso      ³ Transferencia                                              ³±±
		-----------------------------------------------------------------------------
		*/
	endif

	DbSelectArea("PINITRAN")
	DbSkip()
End
dbselectarea("PINITRAN")
dbclosearea()
Return     



Static Function ValidP3Perg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
aAdd(aRegs,{cPerg,"01","Entrada/Saida" ,"Entrada/Saida" ,"Entrada/Saida" ,"mv_ch1","N",01,0,2,"C","","MV_PAR01","Entrada","Entrada","Entrada","","","Saida","Saida","Saida","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Serie"         ,"Serie"         ,"Serie"         ,"mv_ch2","C",03,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Documento"     ,"Documento"     ,"Documento"     ,"mv_ch3","C",09,4,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Cliente/Fornec","Cliente/Fornec","Cliente/Fornec","mv_ch4","C",06,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Emissao"       ,"Emissao"       ,"Emissao"       ,"mv_ch5","D",08,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","Almoxarifado"  ,"Almoxarifado"  ,"Almoxarifado"  ,"mv_ch6","C",02,0,0,"G","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

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