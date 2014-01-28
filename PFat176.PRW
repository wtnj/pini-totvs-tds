#include "rwmake.ch"
#include "ap5mail.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*   
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT176   ºAutor  ³Danilo C S Pala     º Data ³  20061129   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ inserir equipe de obra no siga: inserir clientes           º±±
±±º          ³  														  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PFAT176
setprvt("_aCampos, _cNome, caIndex, caChave, caFiltro, cQuery, contPed, _cMsgINFO, ContSzk")
Private Memp := SM0->M0_CODIGO
Private contSZO := 0
Private contSZN := 0
Private dtEmissao :=  date()
Private _cNumero := space(6)
Private _cCF := space(5)
Private marquivo := space(40) 
Private ncliente := space(6)       
Private nloja := space(2)
Private ndestinatario := space(6)
Private bcontinua := .F.
Private codcliente := 372104
if Memp <> "01"
	MsgAlert("Este processamente deve ser executado na Editora")
	return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


@ 010,001 TO 220,410 DIALOG oDlg TITLE "Equipe de Obra no Siga"
@ 020,010 SAY "Informe o nome do arquivo(siga\importa\)"
@ 035,010 GET marquivo
@ 060,010 BUTTON "Processar" SIZE 40,15 ACTION   Processa({||InserirCliente()})
@ 060,070 BUTTON "Sair" SIZE 40,15 Action ( Close(oDlg) )
Activate Dialog oDlg CENTERED

Return


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao Gerar Pedido³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function InserirCliente()
setprvt("cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3, wrnel, aReturn, cPrograma, tamanho")
setprvt("Li, NNUMERO, NCLIENTE")

dbUseArea(.T.,, "\SIGA\IMPORTA\"+MARQUIVO,"EQUIPE",.F.,.F.)
DbSelectArea("EQUIPE")
cIndex := CriaTrab(nil,.f.)
cChave  := "CNPFJ"
cFiltro := ""
IndRegua("EQUIPE",cIndex,cChave,,cFiltro,"Filtrando ..")
Dbgotop()

WHILE !Eof()    
	//verificar se o cliente existe
	ncliente 	:= EQUIPE->CLIENTE
	nloja 		:= EQUIPE->LOJA
	ndestinatario := EQUIPE->DEST
	DBSelectArea("SA1")
	DBSetOrder(1)     //(1) :A1_FILIAL + A1_COD +  A1_LOJA
	IF DBSeek(xfilial("SA1")+NCLIENTE+NLOJA) .AND. ALLTRIM(NCLIENTE) <> ""
		ncliente 	:= SA1->A1_COD
		nloja 		:= SA1->A1_LOJA  
		
		DbselectArea("SC6")
		DBSetOrder(5) //C6_FILIAL,C6_CLI,C6_LOJA,C6_PRODUTO,C6_NFORI,C6_SERIORI,C6_ITEMORI,R_E_C_N_O_,D_E_L_E_T_
		IF DBSeek(xfilial("SC6")+NCLIENTE+NLOJA+"0125002")
			bcontinua := .F.
		ELSE
			bcontinua := .T.
		ENDIF
	ELSE		           
		bcontinua := .T.
		//inserir cliente
		/*ncliente:= GetSx8Num("SA1")
		ConfirmSX8() */
		ncliente:= alltrim(str(codcliente))
		codcliente := codcliente + 1
		nloja := "01"
		ndestinatario := ""
		DBSelectArea("SA1")
		RECLOCK("SA1",.T.)  //INSERIR .T.
			SA1->A1_FILIAL  := xfilial("SA1")
			SA1->A1_COD     := ncliente
			SA1->A1_LOJA	:= nloja
		    SA1->A1_NOME    := EQUIPE->NOME
		    SA1->A1_NREDUZ  := EQUIPE->NOME
		    SA1->A1_CEP     := EQUIPE->CEP
		    SA1->A1_END     := substr(alltrim(EQUIPE->tplogr) +" "+ alltrim(EQUIPE->logr) +" "+ alltrim(EQUIPE->nlogr) +" "+ alltrim(EQUIPE->clogr),1,40)
		    SA1->A1_LOGR    := EQUIPE->LOGR  
		    SA1->A1_TPLOG   := EQUIPE->TPLOGR  
		    SA1->A1_COMPL   := EQUIPE->CLOGR  
		    SA1->A1_NLOGR   := EQUIPE->NLOGR  
		    SA1->A1_BAIRRO  := EQUIPE->BAIRRO
		    SA1->A1_MUN     := EQUIPE->CIDADE
		    SA1->A1_EST     := EQUIPE->UF
		    SA1->A1_TIPO    := "F"
		    SA1->A1_CGC     := EQUIPE->CNPFJ
		    //SA1->A1_INSCR   :=
		    //SA1->A1_INSCRM  :=
		    SA1->A1_TEL     := EQUIPE->FONE
		    //SA1->A1_TELEX   :=
		    SA1->A1_FAX     := EQUIPE->FONE2
		    SA1->A1_NATUREZ := "0101      "
		    //SA1->A1_ENDCOB  :=
		    SA1->A1_FLAGID  := "1"
		    SA1->A1_ATIVIDA := "9999040"
		    SA1->A1_TPCLI   := IF (LEN(RTRIM(EQUIPE->CNPFJ))<14, 'F', 'J')
		    SA1->A1_EMAIL   := EQUIPE->EMAIL
		    //SA1->A1_RG      :=
		    //SA1->A1_DTNASC  :=
		    SA1->A1_ORIGEM  :=  "811"
		    SA1->A1_PESSOA  := IF (LEN(RTRIM(EQUIPE->CNPFJ))<14, 'F', 'J')
		MSUNLOCK("SA1")				
	ENDIF
			
    if bcontinua
		_cNumero := GetSx8Num("SC5")
		ConfirmSX8()
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
			SC5->C5_VLRPED  := 1
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
			SC5->c5_Parc1   := 1
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
			SC5->C5_VEND1   := "000027"
			SC5->c5_vend2 := SPACE(6)
			SC5->c5_vend3 := SPACE(6)
			SC5->c5_vend4 := SPACE(6)
			SC5->c5_vend5 := SPACE(6)
			SC5->C5_AVESP   := "N"         
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
			SC6->C6_PRCVEN := 1
			SC6->C6_VALOR := 1
			SC6->C6_LOTEFAT := "999"
			SC6->C6_DATA := dDatabase
			SC6->C6_SITUAC := "AA"
			SC6->C6_CODDEST := NDESTINATARIO
			SC6->C6_TPPORTE := "0"
			SC6->C6_CLI := NCLIENTE
			SC6->C6_REGCOT := "0125"
			SC6->C6_TPPROG := "N" //normal
			SC6->C6_LOJA := NLOJA
			SC6->C6_PRODUTO := "0125002"
			SC6->C6_TPOP := "F"
			SC6->C6_EDINIC := 9
			SC6->C6_EDFIN := 14
			SC6->C6_EDVENC := 14
			SC6->C6_EDSUSP := 14
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
			SC6->C6_TES := "708"
			SC6->C6_CF := "6911"
			SC6->C6_LOCAL := SA3->A3_LOCAL
			SC6->C6_UM    := "UN"        
		MSUNLOCK("SC6")          
	endif

	DBSELECTAREA("EQUIPE")
	DBSKIP()          
END //WHILE	
MSGINFO("FIM DE PROCESSAMENTO!")
RETURN