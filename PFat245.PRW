#include "rwmake.ch"
#include "ap5mail.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*   
20061003: Danilo C S Pala
20061110: Danilo C S Pala - alteracoes para nao calcular icms 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPFAT245   บAutor  ณDanilo C S Pala     บ Data ณ  20080327   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ GERA OS PEDIDOS GERENCIADOS POR CONTRATO(ZZW)              บฑฑ
ฑฑบ          ณ  														  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PFAT245
Private _cTitulo  := "GERACAO DOS PEDIDOS GERENCIADOS POR CONTRATO"
setprvt("_aCampos, _cNome, caIndex, caChave, caFiltro, cQuery, contPed, _cMsgINFO, ContSzk")
Private Memp := SM0->M0_CODIGO
Private contSZO := 0
Private contSZN := 0
Private mProduto :=  space(15)
Private mEdicao :=  space(4)
Private _cNumero := space(6)
Private _cCF := space(5)
Private dtEmissao := dDataBase
if (Memp<>"01" .and. Memp<>"02")
	MsgAlert("Esta rotina deve ser executada na ED ou PS")
	return
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica as perguntas selecionadas                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู


@ 010,001 TO 220,410 DIALOG oDlg TITLE _cTitulo      
@ 020,010 SAY "Parametros"
@ 030,010 SAY "Produto"
@ 030,050 Get mProduto Picture "@!" Size 40,10 F3("SB1") Valid(existcpo("SB1") .and. naovazio())
@ 050,010 SAY "Edicao"
@ 050,050 GET mEdicao  Picture "@R 9999" SIZE 40,11
@ 080,010 BUTTON "Processar" SIZE 40,15 ACTION   Processa({||GerarPedido()})
@ 080,070 BUTTON "Sair" SIZE 40,15 Action ( Close(oDlg) )
Activate Dialog oDlg CENTERED

Return


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncao Gerar Pedidoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Static Function GerarPedido()
//loop no zzw
//gerar os pedido

setprvt("cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3, wrnel, aReturn, cPrograma, tamanho")
setprvt("Li, NNUMERO,mhora")
                        
cCabec1   := 'CONTRATO    PEDIDO    PRODUTO'
cCabec2   := ''
xCabec1   := PADC('CONTRATO DE PERIODICOS',74)
MHORA      := TIME()
wnrel    := "Relatorio_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)                          
cDesc1   := PADC("Este programa ira gerar os pedidos dos Contratos ativos do produto e edicao" ,74)
cDesc2   := ""
cDesc3   := ""
aReturn  := { "Especial", 1,"Administraฦo", 1, 2, 1,"",1 }
mDESCR   := ""
CONTROLE := ""
cPerg    := ""
cTitulo  := "PFAT245"    
cPrograma := "PFAT245"
tamanho   := "G"
NNUMERO   := SPACE(6)

wnrel := SetPrint("",wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
SetDefault(aReturn,"")
     
//HEADER                          

Li := 0
//trocar por select
DbSelectArea("ZZW")
if RDDName() <> "TOPCONN"
		MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
		Return nil
endif
                            
cQuery := "SELECT * from "+ RetSqlName("ZZW") +" WHERE ZZW_FILIAL='" +xFilial("ZZW")+ "' AND ZZW_PRODUT='"+ mProduto +"' AND ZZW_EDINIC>="+ mEdicao +" AND ZZW_EDSUSP<='" + mEdicao + "' AND ZZW_STATUS='A' AND D_E_L_E_T_<>'*'"
TCQUERY cQuery NEW ALIAS "QUERYZZW"
DbSelectArea("QUERYZZW")
DBGOTOP()

PROCREGUA(RECCOUNT())
WHILE !EOF()
	INCPROC("Lendo Contrato: "+Alltrim(QUERYZZW->ZZW_NUM))
	
		IF QUERYZZW->ZZW_STATUS = 'A'        
		if Li == 0
			//Li := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
			@ Li,000 PSAY xCabec1
			Li++
			@ Li,000 PSAY cCabec1
			Li := Li +2
		endif     
		
		//20061020 verificar se o pedido ja existe
		DBSelectArea("SC5")
		DBSetOrder(11)     //(B) :C5_FILIAL + C5_CONTRATO +  C5_EMISSAO + C5_NUM
		IF DBSeek(xfilial("SC5")+QUERYZZW->ZZW_NUM+DTOS(dtEmissao))
			NNUMERO := SC5->C5_NUM
		ELSE		
			//INSERIR SC5            
			DBSelectArea("SB1")
			DBSetOrder(1)     //B1_FILIAL_B1_COD
			DBSeek(xfilial("SB1")+QUERYZZW->ZZW_PRODUT)

			DbSelectArea("SA1")
			DbSetOrder(1)
			DbSeek(xFilial("SA1")+QUERYZZW->ZZW_CLIENT+QUERYZZW->ZZW_LOJACL)
	
			DbSelectArea("SF4")
			DbSetOrder(1)  
			DbSeek(xfilial("SF4")+SB1->B1_TS)
			_cCF:= AllTrim(SF4->F4_CF)
			If SA1->A1_EST == "SP" 
				_cCF:= '5'+SUBSTR(_cCF,2,3)
			ElseIf SA1->A1_EST=="EX"
				_cCF:='7'+SUBSTR(_cCF,2,3)
			ElseIf SA1->A1_EST <> "SP" .And. SA1->A1_EST=="EX"
				_cCF:='6'+SUBSTR(_cCF,2,3)
			EndIf

			DbSelectArea("SA3")
			DBSetOrder(1)  //A3_FILIAL+A3_COD
			DBsEEK(xFilial("SA3")+QUERYZZW->ZZW_VEND1)
			
			DbSelectArea("SZJ")
			DbSetOrder(1)
			DbSeek(xFilial("SZJ")+SubStr(QUERYZZW->ZZW_PRODUT,1,4)+mEdicao)
			While !Eof() .and. SubStr(QUERYZZW->ZZW_PRODUT,1,4) == SZJ->ZJ_CODREV
			    If SZJ->ZJ_DTCIRC <= dDatabase+7
			       DbSelectArea("SZJ")
			       DbSkip()
			       Loop
			    Endif
			    Exit
			End

			_cNumero := GetSx8Num("SC5")
			ConfirmSX8()
			DBSelectArea("SC5")
			RECLOCK("SC5",.T.)  //INSERIR .T.
				SC5->C5_FILIAL  := xfilial("SC5")
				SC5->C5_NUM     := _cNumero
				SC5->C5_CONDPAG := QUERYZZW->ZZW_CONDPG
				SC5->C5_CODPROM := QUERYZZW->ZZW_CODPRO
				SC5->C5_CLIENTE := QUERYZZW->ZZW_CLIENT
				SC5->C5_CLIENT  := QUERYZZW->ZZW_CLIENT
				SC5->C5_LOJACLI := QUERYZZW->ZZW_LOJACL
				SC5->C5_TIPOCLI := "F"
				SC5->C5_DTCALC  := dtEmissao
				SC5->C5_EMISSAO := dtEmissao
				SC5->C5_RESPCOB := QUERYZZW->ZZW_RESPCO
				SC5->C5_VLRPED  := QUERYZZW->ZZW_VALOR
				SC5->C5_DATA    := dtEmissao
				SC5->C5_TIPOOP  := QUERYZZW->ZZW_TIPOOP
				SC5->C5_DIVVEN  := QUERYZZW->ZZW_DIVVEN
				SC5->C5_LOTEFAT := QUERYZZW->ZZW_LOTEFA
				SC5->C5_MENNOTA := QUERYZZW->ZZW_MENNOT
				SC5->C5_TIPO    := "N"
				SC5->C5_TPTRANS := "99"
				SC5->C5_TRANSP  := SPACE(6)
				SC5->C5_IDENTIF := "."
				SC5->C5_TABELA  := QUERYZZW->ZZW_TABELA
				SC5->C5_LOJAENT := QUERYZZW->ZZW_LOJACL
				SC5->C5_CARTAO  := SPACE(20)
				SC5->C5_CODSEG  := SPACE(10)
				SC5->C5_NUMERO  := SPACE(20)
				SC5->C5_VALID   := stod("")
				SC5->C5_TITULAR := SPACE(40)
				SC5->c5_Parc1   := QUERYZZW->ZZW_VALOR
				SC5->c5_Data1   := stod(substr(DTOS(dtEmissao),1,6) + substr(DTOS(ZZW->ZZW_DTCALC),7,2))
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
				SC5->C5_VEND1   := QUERYZZW->ZZW_VEND1
				SC5->c5_vend2 := QUERYZZW->ZZW_VEND2
				SC5->c5_vend3 := QUERYZZW->ZZW_VEND3
				SC5->c5_vend4 := QUERYZZW->ZZW_VEND4
				SC5->c5_vend5 := QUERYZZW->ZZW_VEND5
				SC5->C5_AVESP   := "N"         
			    SC5->C5_INCISS  :=  " " 
		    	SC5->C5_LIBEROK :=  " "
			    SC5->C5_OK      :=  "  "       
			    SC5->C5_MOEDA   := 1
   			    SC5->C5_TXMOEDA := 1
			    SC5->C5_CONTRAT := QUERYZZW->ZZW_NUM // 20080402
			MSUNLOCK("SC5")
			
			//INSERIR SC6
			DBSelectArea("SC6")
			RECLOCK("SC6",.T.)  //INSERIR .T.
				SC6->C6_FILIAL := xfilial("SC6")
				SC6->C6_ITEM := "01"
				SC6->C6_NUM := _cNumero
				SC6->C6_QTDVEN := QUERYZZW->ZZW_QTDVEN  
				SC6->C6_QTDLIB := 0
				SC6->C6_PRUNIT := QUERYZZW->ZZW_PRCUNI
				SC6->C6_PRCVEN := QUERYZZW->ZZW_PRCUNI
				SC6->C6_VALOR := QUERYZZW->ZZW_VALOR
				SC6->C6_LOTEFAT := QUERYZZW->ZZW_LOTEFA
				SC6->C6_DATA := dtEmissao
				SC6->C6_SITUAC := "AA"
				SC6->C6_CODDEST := SPACE(6)
				SC6->C6_TPPORTE := QUERYZZW->ZZW_TPPORT
				SC6->C6_CLI := QUERYZZW->ZZW_CLIENT
				SC6->C6_REGCOT := "9999           "
				SC6->C6_TPPROG := "N" //normal
				SC6->C6_LOJA := QUERYZZW->ZZW_LOJACL
				SC6->C6_PRODUTO := QUERYZZW->ZZW_PRODUT
				SC6->c6_SUP := " "
				SC6->C6_TPOP := "F"
				SC6->C6_EDINIC := val(mEdicao)
				SC6->C6_EDFIN  := val(mEdicao)
				SC6->C6_EDVENC := val(mEdicao)
				SC6->C6_EDSUSP := val(mEdicao)
				SC6->C6_DTFIN  := SZJ->ZJ_DTCIRC
				SC6->C6_DTCIRC := SZJ->ZJ_DTCIRC
				SC6->C6_ENTREG := dtEmissao
				SC6->C6_COMIS1 := QUERYZZW->ZZW_COMIS1
				SC6->C6_COMIS2 := QUERYZZW->ZZW_COMIS2
				SC6->C6_COMIS3 := QUERYZZW->ZZW_COMIS3
				SC6->C6_COMIS4 := QUERYZZW->ZZW_COMIS4
				SC6->C6_COMIS5 := QUERYZZW->ZZW_COMIS5
				SC6->C6_CLASFIS := Subs(SB1->B1_ORIGEM,1,1)+SB1->B1_CLASFIS
				SC6->C6_DESCRI := SB1->B1_DESC        
				SC6->C6_CODISS := SB1->B1_CODISS
				SC6->C6_TIPOREV := IF(SB1->B1_GRUPO=='0100',"","0")
				SC6->C6_TES     := SB1->B1_TS            
				SC6->C6_CF := _cCF
				SC6->C6_LOCAL  := SA3->A3_LOCAL
				SC6->C6_UM     := "UN"      
				SC6->C6_BLQ    :="N"           
				SC6->C6_ENTREG := dtEmissao
				SC6->C6_QTDEMP := 0 
				SC6->C6_QTDENT := 0          
				SC6->C6_EDICAO := 0     
				SC6->C6_EDREAB := 0   
				SC6->C6_DTCANC := stod("")     
				SC6->C6_DTENVIO := stod("")
				SC6->C6_DATFAT := stod("")
				SC6->C6_EXADIC := 0
			MSUNLOCK("SC6")          
			
			DBCloseArea("SZJ")
			DBCloseArea("SF4")
			DBCloseArea("SA1")
			DBCloseArea("SB1")
			DBCloseArea("SA3")

			//MARCAR FLAG NA TABELA DE GERENCIAMENTO DE CONTRATO DE SOFTWARE
			//trocar por update                                  
			cUpdate := "UPDATE "+ RetSqlName("ZZW") +" SET ZZW_FLAG='X' WHERE ZZW_FILIAL='"+xFilial("ZZW")+"' AND ZZW_NUM='" + QUERYZZW->ZZW_NUM +"' AND (ZZW_FLAG<>'X' OR ZZW_FLAG IS NULL) AND D_E_L_E_T_<>'*'"
			TCSQLExec(cUpdate)
			NNUMERO := SC5->C5_NUM
	    ENDIF //20080402
		                                         
			//20061020
		@ Li,000 PSAY QUERYZZW->ZZW_NUM
		@ Li,012 PSAY NNUMERO
		@ Li,023 PSAY QUERYZZW->ZZW_PRODUT
		@ Li,030 PSAY mEdicao
		IF Li >= 55
			Li:=0
		ELSE
			Li++
		ENDIF

	ENDIF //STATUS
	DBSELECTAREA("QUERYZZW")
	DBSKIP()
END //WHILE	

SET DEVICE TO SCREEN
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF
MS_FLUSH()              

DBSELECTAREA("QUERYZZW")
DBCLOSEAREA("QUERYZZW")
RETURN