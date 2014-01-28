#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"

/*
Alterado por Danilo C S Pala em 20110901: Validar pelo programa Valsmartpag pois estamos com problema no dblink
Alterado por Danilo C S Pala em 20111027: database link refeito
Alterado por Danilo C S Pala em 20120111: proibir a duplicidade de um numero de boleto smartpag (Marcia)       
Alterado por Danilo C S Pala em 20120531: Permitir digitar mais de uma vez o número do boleto smartpag, desde que a somatória seja, menor ou igual ao valor do boleto.
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValSMARTPAGºAutor  ³Danilo C S Pala    º Data ³  20110531   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validar Numero do boleto no Smartpag no Piniweb             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ValSmartpag()
Private mRet := .F.
Private cQuery := ""
Private cMsg := ""
Private cConteudo := ""
Private aConsulta := {}
Private cClientName := GetComputerName()
Private aInfoComp := GetSrvInfo() 
Private cServerName := ""
Private cpath := ""
cServerName := aInfoComp[1]
/*
Tabelas:
	TG6_SCDO@piniweb, -- Tabela que armazena os dados do cliente
	TB6_PEMN@piniweb, -- Tabela 1 cliente para N boletos
	TB7_BOLP@piniweb  -- * Tabela que armazena os dados do boleto

Campos:
	TB7_BOLP.BOLP7_DAT_PAGTO,  ### campo em que é atribuida a data de pagamento do boleto, via arquivo disponibilizado pela Carol ### 
	TB7_BOLP.BOLP7_NNUM,  ### chave unica identificadora do boleto pago via arquivo liberado pela Carol ###
*/

if !empty(M->C5_PINISPG)
	DBSELECTAREA("SA1") 
	DbSetOrder(1)
	IF DBSEEK(XFILIAL("SA1")+M->C5_CLIENTE+M->C5_LOJACLI)
		///* daqui 20110901
		cQuery := "SELECT TG6_SCDO.SCDO6_COD as COD, TG6_SCDO.SCDO6_NOM AS NOME, replace(replace(replace(replace(TG6_SCDO.SCDO6_CPFCNPJ,'.',''),'/',''), '-',''),' ','') AS CGC, TG6_SCDO.SCDO6_EMAIL AS EMAIL, TG6_SCDO.SCDO6_FONE AS FONE, TG6_SCDO.SCDO6_ENDE AS ENDERECO, TG6_SCDO.SCDO6_BAIRRO AS BAIRRO, TG6_SCDO.SCDO6_CIDA AS CIDADE, TG6_SCDO.SCDO6_UF AS UF, TG6_SCDO.SCDO6_CEP AS CEP, TB6_PEMN.PEMN6_COD AS COD2, TB7_BOLP.BOLP7_COD AS COD3, TB7_BOLP.BOLP7_AREA AS AREA, TO_CHAR(TB7_BOLP.BOLP7_NNUM) AS BOLETO, TB7_BOLP.BOLP7_VAL AS VALOR, TB7_BOLP.BOLP7_PARC AS PARCELA, TO_CHAR(TB7_BOLP.BOLP7_DAT_EM,'yyyyMMdd') as EMISSAO, TO_CHAR(TB7_BOLP.BOLP7_DAT_PROC,'yyyyMMdd') as DTPROC, TO_CHAR(TB7_BOLP.BOLP7_DAT_VENC,'yyyyMMdd') as VENCTO, TO_CHAR(TB7_BOLP.BOLP7_DAT_PAGTO,'yyyyMMdd') as DTPAGTO, TB7_BOLP.NOSSO_NUM_MD5 AS NUMMD5, TB7_BOLP.BOLP7_COD_MD5 AS CODMD5 FROM TG6_SCDO@piniweb, TB6_PEMN@piniweb, TB7_BOLP@piniweb WHERE TG6_SCDO.SCDO6_COD = TB6_PEMN.SCDO6_COD AND TB6_PEMN.PEMN6_COD = TB7_BOLP.PEMN6_COD AND TB7_BOLP.BOLP7_NNUM="+ ALLTRIM(STR(VAL(M->C5_PINISPG)))
		DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PINISPAG", .T., .F. )
		DbSelectArea("PINISPAG")
		dbGotop()                
		If !EOF()     
			if !empty(PINISPAG->DTPAGTO)
				If ALLTRIM(SA1->A1_CGC) == ALLTRIM(PINISPAG->CGC)
					cQuery := "SELECT SUM(C5_PARC1) AS SOMAPG FROM "+ RetSqlName("SC5") +" WHERE C5_FILIAL='"+ XFILIAL("SC5") +"' AND C5_PINISPG='"+ ALLTRIM(STR(VAL(M->C5_PINISPG))) +"' AND D_E_L_E_T_<>'*' AND C5_NUM<>'"+ M->C5_NUM +"'" //DAQUI 20120531
					DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "QSOMAPG", .T., .F. )
					DbSelectArea("QSOMAPG")
					dbGotop()     
					IF (QSOMAPG->SOMAPG + M->C5_PARC1) <= PINISPAG->VALOR .or. ((LEN(SA1->A1_CGC)>11) .AND. ((QSOMAPG->SOMAPG + M->C5_PARC1) <= (PINISPAG->VALOR * 1.02)) )

						cMsg := "Boleto: "+ Alltrim(PINISPAG->BOLETO) + "  Cliente: "+ Alltrim(PINISPAG->NOME) + CHR(10)+CHR(13)
						cMsg += "Valor: "+  TRANSFORM(PINISPAG->VALOR, "@R 999,999,999.99") + " Pago em: " + DTOC(STOD(PINISPAG->DTPAGTO))
						MsgInfo(cMsg)
						M->C5_PINIDSG := STOD(PINISPAG->DTPAGTO)
						mRet := .T.
					ELSE           
						cMsg := "Boleto: "+ Alltrim(PINISPAG->BOLETO) + "  Cliente: "+ Alltrim(PINISPAG->NOME) + CHR(10)+CHR(13)
						cMsg += "Valor: "+  TRANSFORM(PINISPAG->VALOR, "@R 999,999,999.99") + " Pago em: " + DTOC(STOD(PINISPAG->DTPAGTO)) + CHR(10)+CHR(13)
						cMsg += "ATENCAO, A SOMA DOS PEDIDOS EMITIDOS COM ESTE SMARTPAG É MAIOR QUE O VALOR DO BOLETO!"
						MsgAlert(cMsg) //IF MsgYesNo(cMsg)
						M->C5_PINIDSG := stod("")
						mRet := .F.
					ENDIF//DAQUI 20120531
					DbSelectArea("QSOMAPG")
					DBCloseArea("QSOMAPG")
				Else           
					cMsg := "Boleto: "+ Alltrim(PINISPAG->BOLETO) + "  Cliente: "+ Alltrim(PINISPAG->NOME) + CHR(10)+CHR(13)
					cMsg += "Valor: "+  TRANSFORM(PINISPAG->VALOR, "@R 999,999,999.99") + " Pago em: " + DTOC(STOD(PINISPAG->DTPAGTO)) + CHR(10)+CHR(13)
					cMsg += "ATENCAO ESTE BOLETO FOI EMITIDO PARA UM CLIENTE DE CPF/CNPJ DIFERENTE"  + CHR(10)+CHR(13)
					cMsg += iif(LEN(ALLTRIM(PINISPAG->CGC))==14, (" CNPJ BOLETO: "+ Transform(PINISPAG->CGC,"@R 99.999.999/9999-99")), (" CPF BOLETO: "+ Transform(PINISPAG->CGC,"@R 999.999.999-99"))) + iif(LEN(ALLTRIM(SA1->A1_CGC))==14, (" CNPJ CLIENTE: "+ Transform(SA1->A1_CGC,"@R 99.999.999/9999-99")), (" CPF CLIENTE: "+ Transform(SA1->A1_CGC,"@R 999.999.999-99"))) + CHR(10)+CHR(13)
					cMsg += "INFORME O NUMERO DO BOLETO CORRETO!"
					MsgAlert(cMsg) //IF MsgYesNo(cMsg)
						//M->C5_PINIDSG := STOD(PINISPAG->DTPAGTO)
						//mRet := .T.	
					//ELSE
						M->C5_PINIDSG := stod("")
						mRet := .F.
					//ENDIF
				EndIf
			else
				MsgInfo("O pagamento do Boleto ainda não foi compensado/processado no Smartpag")
				M->C5_PINIDSG := stod("")
				mRet := .F.
			endif
		Else     
			MsgInfo("Boleto não encontrado no Smartpag")
			M->C5_PINIDSG := stod("")
			mRet := .F.
		Endif
		DbSelectArea("PINISPAG")
		DBCloseArea("PINISPAG")
		//ate aqui 20110901*/ 

		/* daqui 20111027
		if cServerName == cClientName
			cpath := "C:\Protheus10\Protheus_Data\SIGA\ValSmartpag\"
		else  
			cpath := "K:\ValSmartpag\"
			If File(cpath + "Valsmartpag.exe")
				cpath := "K:\ValSmartpag\"
			Else
				cpath := "Valsmartpag.exe (*.exe) | *.RET"
				cpath := cGetFile ( cpath,"Dialogo de Selecao de Arquivos", 0, "C:\", .F., GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY)
			EndIf
		endif
		
		WaitRun(cpath + "valsmartpag "+ ALLTRIM(STR(VAL(M->C5_PINISPG))) +" "+ Alltrim(substr(cUsuario,7,6)),0)
		//WaitRun("cmd.exe /k C:\Protheus10\Protheus_Data\siga\ValSmartpag\valsmartpag.exe "+ ALLTRIM(STR(VAL(M->C5_PINISPG))) +" "+ Alltrim(substr(cUsuario,7,6)),3)
		//Processa({|| GANHATEMPO()},"Abrindo arquivo de boleto ...")  
		cConteudo := u_PiniFRead("\siga\ValSmartPag\temp\"+ Alltrim(substr(cUsuario,7,6)) +".txt")
		aConsulta := StrTokArr(cConteudo,"|")
		//MsgAlert(cConteudo)
		if len(aConsulta)>1 
			if !empty(aConsulta[20]) //dtpagto
				If ALLTRIM(SA1->A1_CGC) == ALLTRIM(aConsulta[3]) //
					cMsg := "Boleto: "+ Alltrim(aConsulta[14]) + "  Cliente: "+ Alltrim(aConsulta[2]) + CHR(10)+CHR(13)
					cMsg += "Valor: "+  TRANSFORM(aConsulta[15], "@R 999,999,999.99") + " Pago em: " + DTOC(STOD(aConsulta[20]))
					MsgInfo(cMsg)
					M->C5_PINIDSG := STOD(aConsulta[20])
					mRet := .T.
				Else           
					cMsg := "Boleto: "+ Alltrim(aConsulta[14]) + "  Cliente: "+ Alltrim(aConsulta[2]) + CHR(10)+CHR(13)
					cMsg += "Valor: "+  TRANSFORM(aConsulta[15], "@R 999,999,999.99") + " Pago em: " + DTOC(STOD(aConsulta[20])) + CHR(10)+CHR(13)
					cMsg += "ATENCAO ESTE BOLETO FOI EMITIDO PARA UM CLIENTE DE CPF/CNPJ DIFERENTE"  + CHR(10)+CHR(13)
					cMsg += iif(LEN(ALLTRIM(aConsulta[3]))==14, (" CNPJ BOLETO: "+ Transform(aConsulta[3],"@R 99.999.999/9999-99")), (" CPF BOLETO: "+ Transform(aConsulta[3],"@R 999.999.999-99"))) + iif(LEN(ALLTRIM(SA1->A1_CGC))==14, (" CNPJ CLIENTE: "+ Transform(SA1->A1_CGC,"@R 99.999.999/9999-99")), (" CPF CLIENTE: "+ Transform(SA1->A1_CGC,"@R 999.999.999-99"))) + CHR(10)+CHR(13)
					cMsg += "INFORME O NUMERO DO BOLETO CORRETO!"
					MsgAlert(cMsg) 
					M->C5_PINIDSG := stod("")
					mRet := .F.
				EndIf
			else
				MsgInfo("O pagamento do Boleto ainda não foi compensado/processado no Smartpag")
				M->C5_PINIDSG := stod("")
				mRet := .F.
			endif
		Else     
			MsgInfo("Boleto não encontrado no Smartpag")
			M->C5_PINIDSG := stod("")
			mRet := .F.
		Endif
		*/ //ate aqui 20111027
	ELSE //cliente nao localizado                       
		MsgInfo("Cliente não localizado")
		M->C5_PINIDSG := stod("")
		mRet := .F.
	ENDIF
Else //vazio
	M->C5_PINIDSG := stod("")
	mRet := .T.
Endif
    
Return(MRET)