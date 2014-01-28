#include "rwmake.ch"
#include "ap5mail.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*   
20061003: Danilo C S Pala
20061110: Danilo C S Pala - alteracoes para nao calcular icms 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT240   ºAutor  ³Danilo C S Pala     º Data ³  20060921   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ GERA OS PEDIDOS DE SOFTWARE DE ACORDO COM OS CONTRATOS(ZZW)º±±
±±º          ³  														  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PFAT240
Private _cTitulo  := "GERACAO DOS PEDIDOS DE SOFTWARE GERENCIADOS EM CONTRATO"
setprvt("_aCampos, _cNome, caIndex, caChave, caFiltro, cQuery, contPed, _cMsgINFO, ContSzk")
Private Memp := SM0->M0_CODIGO
Private contSZO := 0
Private contSZN := 0
Private dtEmissao :=  date()
Private _cNumero := space(6)
Private _cCF := space(5)
if Memp <> "03"
	MsgAlert("Este processamente deve ser executado na BP S/A")
	return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


@ 010,001 TO 220,410 DIALOG oDlg TITLE _cTitulo      
@ 020,010 SAY "Utilize sempre o mesmo dia"
@ 030,010 SAY "Data"
@ 030,050 GET dtEmissao SIZE 40,11
@ 060,010 BUTTON "Processar" SIZE 40,15 ACTION   Processa({||GerarPedido()})
@ 060,070 BUTTON "Sair" SIZE 40,15 Action ( Close(oDlg) )
Activate Dialog oDlg CENTERED

Return


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao Gerar Pedido³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function GerarPedido()
//loop no zzw
//gerar os pedido

setprvt("cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3, wrnel, aReturn, cPrograma, tamanho,mhora")
setprvt("Li, NNUMERO")
                        
cCabec1   := 'CONTRATO    PEDIDO    PRODUTO'
cCabec2   := ''
xCabec1   := PADC('CONTRATO DE SOFTWARE',74)
MHORA      := TIME()
wnrel    := "Relatorio_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)                           
cDesc1   := PADC("Este programa ira gerar os pedidos dos Contratos de Software ativos na data" ,74)
cDesc2   := ""
cDesc3   := ""
aReturn  := { "Especial", 1,"Administra‡Æo", 1, 2, 1,"",1 }
mDESCR   := ""
CONTROLE := ""
cPerg    := ""
cTitulo  := "PFAT240"    
cPrograma := "PFAT240"
tamanho   := "G"
NNUMERO   := SPACE(6)

wnrel := SetPrint("",wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
SetDefault(aReturn,"")
     
//HEADER                          

Li := 0

DbSelectArea("ZZW")                    
cIndex := CriaTrab(nil,.f.)
cChave  := "ZZW_FILIAL + DTOS(ZZW_DTINI)"
cFiltro := "(DTOS(dtEmissao)>=DTOS(ZZW_DTINI) .and. DTOS(dtEmissao)<=DTOS(ZZW_DTFIM)) .AND. ZZW_STATUS ='A'"
IndRegua("ZZW",cIndex,cChave,,cFiltro,"Filtrando ..")
Dbgotop()      
//Li++

WHILE !Eof() .and. ZZW->ZZW_FILIAL == xFilial("ZZW")
	IF ZZW->ZZW_STATUS = 'A'        
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
		IF DBSeek(xfilial("SC5")+ZZW->ZZW_NUM+DTOS(dtEmissao))
			NNUMERO := SC5->C5_NUM
		ELSE		
			//INSERIR SC5            
			DBSelectArea("SB1")
			DBSetOrder(1)     //B1_FILIAL_B1_COD
			DBSeek(xfilial("SB1")+ZZW->ZZW_PRODUT)

			DbSelectArea("SA1")
			DbSetOrder(1)
			DbSeek(xFilial("SA1")+ZZW->ZZW_CLIENT+ZZW->ZZW_LOJACL)
	
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
			DBsEEK(xFilial("SA3")+ZZW->ZZW_VEND1)

			_cNumero := GetSx8Num("SC5")
			ConfirmSX8()
			DBSelectArea("SC5")
			RECLOCK("SC5",.T.)  //INSERIR .T.
				SC5->C5_FILIAL  := xfilial("SC5")
				SC5->C5_NUM     := _cNumero
				SC5->C5_CONDPAG := ZZW->ZZW_CONDPG
				SC5->C5_CODPROM := ZZW->ZZW_CODPRO
				SC5->C5_CLIENTE := ZZW->ZZW_CLIENT
				SC5->C5_CLIENT  := ZZW->ZZW_CLIENT
				SC5->C5_LOJACLI := ZZW->ZZW_LOJACL
				SC5->C5_TIPOCLI := "F"
				SC5->C5_DTCALC  := dtEmissao
				SC5->C5_EMISSAO := dtEmissao
				SC5->C5_RESPCOB := ZZW->ZZW_RESPCO
				SC5->C5_VLRPED  := ZZW->ZZW_VALOR
				SC5->C5_DATA    := dtEmissao
				SC5->C5_TIPOOP  := ZZW->ZZW_TIPOOP
				SC5->C5_DIVVEN  := ZZW->ZZW_DIVVEN
				SC5->C5_LOTEFAT := ZZW->ZZW_LOTEFA
				SC5->C5_MENNOTA := ZZW->ZZW_MENNOT
				SC5->C5_TIPO    := "N"
				SC5->C5_TPTRANS := "99"
				SC5->C5_TRANSP  := SPACE(6)
				SC5->C5_IDENTIF := "."
				SC5->C5_TABELA  := ZZW->ZZW_TABELA
				SC5->C5_LOJAENT := ZZW->ZZW_LOJACL
				SC5->C5_CARTAO  := SPACE(20)
				SC5->C5_CODSEG  := SPACE(10)
				SC5->C5_NUMERO  := SPACE(20)
				SC5->C5_VALID   := stod("")
				SC5->C5_TITULAR := SPACE(40)
				SC5->c5_Parc1   := ZZW->ZZW_VALOR
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
				SC5->C5_VEND1   := ZZW->ZZW_VEND1
				IF ZZW->ZZW_TPCOM = "I" //INTERNO
					IF ZZW->ZZW_FLAG = "X" //PAGAR SOMENTE A PRIMEIRA VEZ
						SC5->c5_vend2 := SPACE(6)
						SC5->c5_vend3 := SPACE(6)
						SC5->c5_vend4 := SPACE(6)
						SC5->c5_vend5 := SPACE(6)
					ELSE					
						SC5->c5_vend2 := ZZW->ZZW_VEND2
						SC5->c5_vend3 := ZZW->ZZW_VEND3
						SC5->c5_vend4 := ZZW->ZZW_VEND4
						SC5->c5_vend5 := ZZW->ZZW_VEND5
				    ENDIF
				ELSE //EXTERNO PAGAR SEMPRE
						SC5->c5_vend2 := ZZW->ZZW_VEND2
						SC5->c5_vend3 := ZZW->ZZW_VEND3
						SC5->c5_vend4 := ZZW->ZZW_VEND4
						SC5->c5_vend5 := ZZW->ZZW_VEND5
				ENDIF
				SC5->C5_AVESP   := "N"         
			    SC5->C5_INCISS  :=  " " 
		    	SC5->C5_LIBEROK :=  " "
			    SC5->C5_OK      :=  "  "       
			    SC5->C5_MOEDA   := 1
   			    SC5->C5_TXMOEDA := 1
			    SC5->C5_CONTRAT := ZZW->ZZW_NUM
			MSUNLOCK("SC5")
			
			//INSERIR SC6
			DBSelectArea("SC6")
			RECLOCK("SC6",.T.)  //INSERIR .T.
				SC6->C6_FILIAL := xfilial("SC6")
				SC6->C6_ITEM := "01"
				SC6->C6_NUM := _cNumero
				SC6->C6_QTDVEN := ZZW->ZZW_QTDVEN
				//SC6->C6_PRUNIT := ZZW->ZZW_PRCUNI
				SC6->C6_PRCVEN := ZZW->ZZW_PRCUNI
				SC6->C6_VALOR := ZZW->ZZW_VALOR
				SC6->C6_LOTEFAT :=ZZW->ZZW_LOTEFA
				SC6->C6_DATA := dtEmissao
				SC6->C6_SITUAC := "AA"
				SC6->C6_CODDEST := SPACE(6)
				SC6->C6_TPPORTE := ZZW->ZZW_TPPORT
				SC6->C6_CLI := ZZW->ZZW_CLIENT
				SC6->C6_REGCOT := "9999           "
				SC6->C6_TPPROG := "N" //normal
				SC6->C6_LOJA := ZZW->ZZW_LOJACL
				SC6->C6_PRODUTO := ZZW->ZZW_PRODUT
				SC6->c6_SUP := " "
				SC6->C6_TPOP := "F"
			   //	SC6->C6_NUMSERI := //QueryITens->C6_NUMSERI //20030901
			   //	SC6->C6_VERSAO := //QueryITens->C6_VERSAO   //20030901 
				//SC6->C6_RAZSIS := //QueryITens->C6_RAZSIS //20030901
				SC6->C6_EDINIC := 9999
				SC6->C6_EDFIN := 9999
				SC6->C6_EDVENC := 9999
				SC6->C6_EDSUSP := 0
				SC6->C6_ENTREG := dtEmissao
				IF ZZW->ZZW_TPCOM = "I" 
					IF ZZW->ZZW_FLAG = "X" //PAGAR SOMENTE A PRIMEIRA VEZ
						SC6->C6_COMIS1 := 0
						SC6->C6_COMIS2 := 0
						SC6->C6_COMIS3 := 0
						SC6->C6_COMIS4 := 0
						SC6->C6_COMIS5 := 0
					ELSE					
						SC6->C6_COMIS1 := ZZW->ZZW_COMIS1
						SC6->C6_COMIS2 := ZZW->ZZW_COMIS2
						SC6->C6_COMIS3 := ZZW->ZZW_COMIS3
						SC6->C6_COMIS4 := ZZW->ZZW_COMIS4
						SC6->C6_COMIS5 := ZZW->ZZW_COMIS5
				    ENDIF
				ELSE //EXTERNO PAGAR SEMPRE
					SC6->C6_COMIS1 := ZZW->ZZW_COMIS1
					SC6->C6_COMIS2 := ZZW->ZZW_COMIS2
					SC6->C6_COMIS3 := ZZW->ZZW_COMIS3
					SC6->C6_COMIS4 := ZZW->ZZW_COMIS4
					SC6->C6_COMIS5 := ZZW->ZZW_COMIS5
				ENDIF
				SC6->C6_CLASFIS := Subs(SB1->B1_ORIGEM,1,1)+SB1->B1_CLASFIS
				SC6->C6_DESCRI := SB1->B1_DESC        
				SC6->C6_CODISS := SB1->B1_CODISS
				SC6->C6_TIPOREV := IF(SB1->B1_GRUPO=='0100',"","0")
				SC6->C6_TES := SB1->B1_TS
				SC6->C6_CF := _cCF
				SC6->C6_LOCAL := SA3->A3_LOCAL
				SC6->C6_UM    := "UN"        
				
				//SC6->C6_DTFIN   := //SZJ->ZJ_DTCIRC
				//SC6->C6_DTCIRC   := //SZJ->ZJ_DTCIRC

				DBCloseArea("SF4")
				DBCloseArea("SA1")
				DBCloseArea("SB1")
				DBCloseArea("SA3")
			MSUNLOCK("SC6")          
			//MARCAR FLAG NA TABELA DE GERENCIAMENTO DE CONTRATO DE SOFTWARE
			DBSelectArea("ZZW")
			RECLOCK("ZZW",.F.)  //INSERIR .T.
				ZZW->ZZW_FLAG := "X"
			MSUNLOCK("ZZW")
			NNUMERO := SC5->C5_NUM
		ENDIF //
		                                         
			//20061020
		@ Li,000 PSAY ZZW->ZZW_NUM
		@ Li,012 PSAY NNUMERO
		@ Li,023 PSAY ZZW->ZZW_PRODUT
		IF Li >= 55
			Li:=0
		ELSE
			Li++
		ENDIF

	ENDIF //STATUS
	DBSELECTAREA('ZZW')
	DBSKIP()          
END //WHILE	

SET DEVICE TO SCREEN
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF
MS_FLUSH()
RETURN