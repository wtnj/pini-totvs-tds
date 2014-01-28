#include "rwmake.ch"
#include "ap5mail.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*   
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT178   ºAutor  ³Danilo C S Pala     º Data ³  20070123   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ inserir clientes e pedidos que ganharam brindes no siga    º±±
±±º          ³  														  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP7                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PFAT178
setprvt("_aCampos, _cNome, caIndex, caChave, caFiltro, cQuery, contPed, _cMsgINFO, ContSzk")
Private Memp := SM0->M0_CODIGO
Private contARQ := 0
Private contUPD := 0        
Private dtEmissao :=  date()
Private _cNumero := space(6)
Private _cCF := space(5)
Private marquivo := space(50) 
Private ncliente := space(6)       
Private contcliente := space(6)
Private contPedido := space(6)
Private nCgc := space(14)
Private nloja := space(2)
Private ndestinatario := space(6)
Private bcontinua := .F.
Private codcliente := space(6)
Private cPerg := "FAT178"
if Memp <> "01"
	MsgAlert("Este processamente deve ser executado na Editora")
	return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//³ FAT178
//³ Mv_par01: Pedido de
//³ Mv_par02: Pedido ate
//³ Mv_par03: Cliente de
//³ Mv_par04: Cliente ate
//³ Mv_par05: Produto
//³ Mv_par06: Arquivo
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

/*
LAYOUT TABELA BRINDE
BRINDE->CGC		CHAR (14)
BRINDE->CEP		CHAR (8)
BRINDE->NOME	CHAR (40)
BRINDE->LOGR  	CHAR (60)
BRINDE->TPLOGR 	CHAR (15)
BRINDE->CLOGR  	CHAR (40)
BRINDE->NLOGR  	CHAR (10)
BRINDE->BAIRRO	CHAR (20) 
BRINDE->CIDADE	CHAR (20)
BRINDE->UF		CHAR (2)
BRINDE->FONE	CHAR (20)
BRINDE->FONE2	CHAR (15)
BRINDE->EMAIL	CHAR (50)
BRINDE->UPDATE	CHAR (1)
*/


MsgAlert("O arquivo deve estar em SIGA\IMPORTA\")
If !Pergunte(cPerg)      //parametros de FAT110 em SX1  para montar a GUI
	Return
Endif
                
lEnd  := .F.

bBloco:= {|lEnd| InserirCliente()}  
Processa( bBloco, "Aguarde" ,"Processando...", .T. )
Return


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao Gerar Pedido³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function InserirCliente()
setprvt("cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3, wrnel, aReturn, cPrograma, tamanho")
setprvt("Li, NNUMERO, NCLIENTE, cMSG")            

//verificar se o produto existe
DBSelectArea("SB1")
DBSetOrder(1)
IF !DBSeek(xfilial("SB1")+MV_PAR05)
	MSGALERT("PRODUTO NAO LOCALIZADO, PROCESSAMENTO ABORTADO!")
	RETURN
ENDIF

//abrir o arquivo
MARQUIVO := MV_PAR06      
dbUseArea(.T.,, "\SIGA\IMPORTA\"+MARQUIVO,"BRINDE",.F.,.F.)
DbSelectArea("BRINDE")
cIndex := CriaTrab(nil,.f.)
cChave  := "CGC"
cFiltro := ""
IndRegua("BRINDE",cIndex,cChave,,cFiltro,"Filtrando ..")
Dbgotop()

_cNumero := Mv_par01
contARQ := 0
contUPD := 0                  
contcliente := MV_PAR03
contPedido := MV_PAR01

WHILE !Eof() .and. _cNumero <= MV_PAR02 .AND. contCliente <= MV_PAR04
	//verificar se o cliente existe
	nCgc := BRINDE->CGC
	DBSelectArea("SA1")
	DBSetOrder(3)     //(3) :A1_FILIAL + A1_CGC
	IF DBSeek(xfilial("SA1")+NCGC) .AND. ALLTRIM(NCGC) <> ""
		ncliente 	:= SA1->A1_COD
		nloja 		:= SA1->A1_LOJA  
		
		if SA1->A1_CEP == BRINDE->CEP
			DbselectArea("SC6")
			DBSetOrder(5) //C6_FILIAL,C6_CLI,C6_LOJA,C6_PRODUTO,C6_NFORI,C6_SERIORI,C6_ITEMORI,R_E_C_N_O_,D_E_L_E_T_
			IF DBSeek(xfilial("SC6")+NCLIENTE+NLOJA+"0000293")
				bcontinua := .F.
			ELSE
				bcontinua := .T.
			ENDIF
		else
			bcontinua := .F.
		endif
	ELSE		           
		bcontinua := .T.
		//inserir cliente
		/*ncliente:= GetSx8Num("SA1")
		ConfirmSX8() */
		contCliente := alltrim(str(val(contCliente) + 1))
		ncliente:= alltrim(str(contCliente))
		nloja := "01"
		ndestinatario := ""
		DBSelectArea("SA1")
		RECLOCK("SA1",.T.)  //INSERIR .T.
			SA1->A1_FILIAL  := xfilial("SA1")
			SA1->A1_COD     := ncliente
			SA1->A1_LOJA	:= nloja
		    SA1->A1_NOME    := BRINDE->NOME
		    SA1->A1_NREDUZ  := BRINDE->NOME
		    SA1->A1_CEP     := BRINDE->CEP
		    SA1->A1_END     := substr(alltrim(BRINDE->tplogr) +" "+ alltrim(BRINDE->logr) +" "+ alltrim(BRINDE->nlogr) +" "+ alltrim(BRINDE->clogr),1,40)
		    SA1->A1_LOGR    := BRINDE->LOGR  
		    SA1->A1_TPLOG   := BRINDE->TPLOGR  
		    SA1->A1_COMPL   := BRINDE->CLOGR  
		    SA1->A1_NLOGR   := BRINDE->NLOGR  
		    SA1->A1_BAIRRO  := BRINDE->BAIRRO
		    SA1->A1_MUN     := BRINDE->CIDADE
		    SA1->A1_EST     := BRINDE->UF
		    SA1->A1_TIPO    := "F"
		    SA1->A1_CGC     := BRINDE->CGC
		    //SA1->A1_INSCR   :=
		    //SA1->A1_INSCRM  :=
		    SA1->A1_TEL     := BRINDE->FONE
		    //SA1->A1_TELEX   :=
		    SA1->A1_FAX     := BRINDE->FONE2
		    SA1->A1_NATUREZ := "0101      "
		    //SA1->A1_ENDCOB  :=
		    SA1->A1_FLAGID  := "1"
		    SA1->A1_ATIVIDA := "9999040"//??
		    SA1->A1_TPCLI   := IF (LEN(RTRIM(BRINDE->CGC))<14, 'F', 'J')
		    SA1->A1_EMAIL   := BRINDE->EMAIL
		    //SA1->A1_RG      :=
		    //SA1->A1_DTNASC  :=
		    SA1->A1_ORIGEM  :=  "811"//??
		    SA1->A1_PESSOA  := IF (LEN(RTRIM(BRINDE->CGC))<14, 'F', 'J')
		MSUNLOCK("SA1")				
	ENDIF
			
    if bcontinua
		/*_cNumero := GetSx8Num("SC5")
		ConfirmSX8()*/
		_cNumero := alltrim(str(val(_cNumero) + 1))
		DBSelectArea("SC5")
		RECLOCK("SC5",.T.)  //INSERIR .T.
			SC5->C5_FILIAL  := xfilial("SC5")
			SC5->C5_NUM     := _cNumero
			SC5->C5_CONDPAG := "201"
			SC5->C5_CODPROM := "N"
			SC5->C5_CLIENTE := NCLIENTE
			SC5->C5_CLIENT  := NCLIENTE
			SC5->C5_LOJACLI := NLOJA
			SC5->C5_TIPOCLI := "F"
			SC5->C5_DTCALC  := dDatabase
			SC5->C5_EMISSAO := dDatabase
			SC5->C5_VLRPED  := 1 //??
			SC5->C5_DATA    := dDatabase
			SC5->C5_TIPOOP  := "90"
			SC5->C5_DIVVEN  := "MERC"
			SC5->C5_LOTEFAT := "999"
			SC5->C5_TIPO    := "N"
			SC5->C5_TPTRANS := "99"
			SC5->C5_TRANSP  := SPACE(6)
			SC5->C5_IDENTIF := "."
			SC5->C5_TABELA  := "   "
			SC5->C5_LOJAENT := NLOJA
			SC5->C5_VALID   := stod("")
			SC5->c5_Parc1   := 1//??
			SC5->c5_Data1   := dDatabase
			SC5->c5_Parc2   := 0
			SC5->c5_Data2   := CTOD("")
			SC5->c5_Parc3   := 0
			SC5->c5_Data3   := CTOD("")
			SC5->c5_Parc4   := 0
			SC5->c5_Data4   := CTOD("")
			SC5->c5_Parc5   := 0
			SC5->c5_Data5   := CTOD("")
			SC5->c5_Parc6   := 0
			SC5->c5_Data6   := CTOD("")
			SC5->C5_USUARIO := SubStr(cUsuario,7,15)
			SC5->C5_VEND1   := "000100"
			SC5->c5_vend2 := SPACE(6)
			SC5->c5_vend3 := SPACE(6)
			SC5->c5_vend4 := SPACE(6)
			SC5->c5_vend5 := SPACE(6)
			SC5->C5_AVESP   := "N" //??
	    	SC5->C5_INCISS  :=  " " 
    		SC5->C5_LIBEROK :=  " "
	    	SC5->C5_OK      :=  "  "       
		    SC5->C5_MOEDA   := 1
		    SC5->C5_TXMOEDA := 1
		MSUNLOCK("SC5")
			
		//INSERIR SC6
		DBSelectArea("SC6")
		RECLOCK("SC6",.T.)  //INSERIR .T.
			SC6->C6_FILIAL := xfilial("SC6")
			SC6->C6_ITEM := "01"
			SC6->C6_NUM := _cNumero
			SC6->C6_QTDVEN := 1
			SC6->C6_PRCVEN := 1 //??
			SC6->C6_VALOR := 1 //??
			SC6->C6_LOTEFAT := "999"
			SC6->C6_DATA := dDatabase
			SC6->C6_SITUAC := "AA"
			SC6->C6_CODDEST := NDESTINATARIO
			SC6->C6_TPPORTE := "0"
			SC6->C6_CLI := NCLIENTE
			SC6->C6_REGCOT := space(4)
			SC6->C6_TPPROG := "N" //normal
			SC6->C6_LOJA := NLOJA
			SC6->C6_PRODUTO := Mv_par05 //"0000293"
			SC6->C6_TPOP := "F"
			SC6->C6_EDINIC := 999
			SC6->C6_EDFIN := 999
			SC6->C6_EDVENC := 999
			SC6->C6_EDSUSP := 999
			SC6->C6_ENTREG := dDatabase
			SC6->C6_COMIS1 := 0.1
			SC6->C6_COMIS2 := 0
			SC6->C6_COMIS3 := 0
			SC6->C6_COMIS4 := 0
			SC6->C6_COMIS5 := 0
			SC6->C6_CLASFIS := Subs(SB1->B1_ORIGEM,1,1)+SB1->B1_CLASFIS
			SC6->C6_DESCRI := SB1->B1_DESC        
			SC6->C6_CODISS := SB1->B1_CODISS
			SC6->C6_TIPOREV := ""
			SC6->C6_TES := "708"  //??
			SC6->C6_CF := "6911"  //??
			SC6->C6_LOCAL := "99"
			SC6->C6_UM    := "UN"        
		MSUNLOCK("SC6")          
		
		RECLOCK("BRINDE",.F.)  //UPDATE .F.
			BRINDE->UPDATE :=  "S"
		MSUNLOCK("BRINDE")          
		contUPD := contUPD + 1
	endif
	
	contARQ := contARQ + 1
	DBSELECTAREA("BRINDE")
	DBSKIP()          
END //WHILE	                    
cMSG := "FIM DE PROCESSAMENTO!"
cMSG := cMSG + Chr(13) + Chr(10)
cMSG := cMSG + "QTD REGISTROS: " + alltrim(STR(contARQ))
cMSG := cMSG + Chr(13) + Chr(10)
cMSG := cMSG + "QTD INSERIDOS: " + alltrim(STR(contUPD))
cMSG := cMSG + Chr(13) + Chr(10)
cMSG := cMSG + "ULTIMO PEDIDO: " + _cNumero
cMSG := cMSG + Chr(13) + Chr(10)
cMSG := cMSG + "ULTIMO CLIENTE: " + contCliente
MSGINFO(cMSG)
RETURN