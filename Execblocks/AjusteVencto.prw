#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#include "protheus.ch"

/*/ 
Danilo C S Pala em 20110603: Baixar boletos smartpag automaticamente
Danilo C S Pala em 20110622: baixar serie 3 automaticamente
Danilo C S Pala em 20110708: smartpag somente primeira parcela
Danilo C S Pala em 20110812: despesa de remessa na baixa smartpag
Danilo C S Pala em 20110817: tipo de operacao com 2 naturezas e contas contabeis
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: AjusteVencto�Autor: Danilo C S Pala      � Data:   20110503 � ��
������������������������������������������������������������������������Ĵ ��
���Baseado no Pfat019A                                                   � ��
���Para ser chamado no ponto de entrada M460FIM                          � ��
���                                                                      � ��
������������������������������������������������������������������������Ĵ ��
���Uso : Pini                                                            � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function AjusteVencto(cPrefixo, cNumero, cCliente, cLoja)
SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,PREFIX")
SetPrvt("MDUPL,MPEDIDO,MSERIE,MLOTEFAT,MDATA,XCLIENTE")
SetPrvt("MCLIENTE,MPROD,MTIPOOP,MVAL1,MGRUPO,MITEM")
SetPrvt("MPEDANT,MITEMANT,NREGATUA,MEDIN,MCODCLI,MCODDEST")
SetPrvt("MITEMANT2,MPROGPA1,MPROGPAD,MNATUREZ,MEMISSAO,MPROGPAG")
SetPrvt("MVENCTO,MVENCREA,MVALOR,TREGS,M_MULT,P_ANT")
SetPrvt("P_ATU,P_CNT,M_SAV20,M_SAV7, MDESPBOL, MDESPREM, MQTDPARCELA")
SetPrvt("MCOUNT, MSOMADR, MSOMABOL, MPINISPG, DPINIDSG, dVencto")

//�����������������������������������������������������������������������Ŀ
//�Localiza os Itens do SD2 - Pela nota, pega a duplicata,serie e pedido  �
//�������������������������������������������������������������������������
//MsgAlert("AjusteVencto:1")
dbSelectarea("SF2")
dbSetOrder(1) //F1_FILIAL+F1_DOC+F1_SERIE+F1_CLIENTE+F1_LOJA+F1_FORMUL+F1_TIPO
if dbSeek(xFilial("SF2")+cNumero+cPrefixo+cCliente+cLoja,.T.)
	mDUPL    := ""
	mPEDIDO  := ""
	MSERIE   := ""
	MLOTEFAT := ""
	MDATA    := ""
	MSERIE   := ""
	XCLIENTE := ""
	mcliente := ""
	mprod    := ""
	MQTDPARCELA := 0
	MDESPREM := 0
	MDESPBOL := 0
	MCOUNT   := 0
	MSOMADR  := 0 
	MSOMABOL := 0            
	MPINISPG := "" //20110603
	DPINIDSG := STOD("")//20110603
	dVencto := STOD("") //20110704
	
	//MsgAlert("AjusteVencto:1.1")

	IF SF2->F2_SERIE == 'PUB'
		return(nil)
	ENDIF
	
	dbSelectArea("SD2")
	dbSetOrder(3)	
	If dbSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE+SF2->F2_CLIENTE+SF2->F2_LOJA)
		mDUPL   := SD2->D2_DOC
		mPEDIDO := SD2->D2_PEDIDO
		MSERIE  := SD2->D2_SERIE
		
		//MsgAlert("AjusteVencto:2")
	
		//�����������������������������������������������������������������������Ŀ
		//� Procura no Arq de Pedidos e verifica se o clifat e #do cliente       �
		//� Pega os valores das parcelas pela cond 201                            �
		//�������������������������������������������������������������������������
		dbSelectArea("SC5")
		dbSetOrder(1)
		If dbSeek(xFilial("SC5")+mPedido)
			MLOTEFAT := SC5->C5_LOTEFAT
			MDATA    := SC5->C5_DATA
			MSERIE   := SC5->C5_SERIE
			XCLIENTE := SC5->C5_CLIENTE
			MDESPREM := SC5->C5_DESPREM
			mTIPOOP  := SC5->C5_TIPOOP
			MPINISPG := SC5->C5_PINISPG //NUMERO DO BOLETO SMARTPAG //20110603
			DPINIDSG := SC5->C5_PINIDSG //DATA DE PAGTO DO BOLETO SMARTPAG //20110603
			IF VAL(C5_CLIFAT) # 0 .OR. !empty(SC5->C5_CLIFAT)
				mCLIENTE := SC5->C5_CLIFAT   
			ELSE
				mcliente := SC5->C5_CLIENTE
			ENDIF               

			//MsgAlert("AjusteVencto:3")
			
			/***************Pedido Anterior e Renovacao ***************************************/
			//1 Loop nos itens do Pedido Atual
			cQuery := "SELECT C6_NUM, C6_ITEM, C6_PRODUTO, C6_PEDANT, C6_ITEMANT, C6_EDINIC, C6_EDFIN, C6_EDVENC, C6_CLI, C6_LOJA, C6_CODDEST, C6_DATA FROM "+ RetSqlName("SC6") +" SC6 WHERE C6_FILIAL='"+ XFILIAL("SC6") +"' AND  C6_NUM='"+ MPEDIDO +"' AND SC6.D_E_L_E_T_<>'*'"
			TCQUERY cQuery NEW ALIAS "ITEMP"
			TcSetField("ITEMP","C6_DATA"   ,"D")
			DbSelectArea("ITEMP")
			DBGOTOP()
			WHILE !EOF() 
				IF !EMPTY(ITEMP->C6_PEDANT)
					//MsgAlert("AjusteVencto:3.1")
					//2Pesquisar Pedido Anterior
					cQuery := "SELECT C6_NUM, C6_ITEM, C6_PRODUTO, C6_PEDANT, C6_ITEMANT, C6_EDINIC, C6_EDFIN, C6_EDVENC, C6_CLI, C6_LOJA, C6_CODDEST, C6_DATA FROM "+ RetSqlName("SC6") +" SC6 WHERE C6_FILIAL='"+ XFILIAL("SC6") +"' AND C6_NUM='"+ ITEMP->C6_PEDANT +"' AND C6_ITEM='"+ ITEMP->C6_ITEMANT +"' AND C6_EDFIN<>0 AND C6_EDFIN<>9999 AND C6_EDVENC <= "+ TRANSFORM(ITEMP->C6_EDINIC,"@E 9999") +" AND SUBSTR(C6_PRODUTO,1,4)='"+ SUBSTR(ITEMP->C6_PRODUTO,1,4) +"'AND SC6.D_E_L_E_T_<>'*'"
					TCQUERY cQuery NEW ALIAS "ITEMPANT" 
					DbSelectArea("ITEMPANT")
					DBGOTOP()
					If !EOF()                  
						//MsgAlert("AjusteVencto:3.2")
						//3gravar Renovacao
						cQuery := "UPDATE "+ RetSqlName("SC6") +" SET C6_PEDREN='"+ ITEMP->C6_NUM +"', C6_ITEMREN='"+ ITEMP->C6_ITEM +"' WHERE C6_FILIAL='"+ XFILIAL("SC6") + "' AND C6_NUM='"+ ITEMPANT->C6_NUM +"' AND C6_ITEM='"+ ITEMPANT->C6_ITEM +"' AND D_E_L_E_T_<>'*'"
						nUpd :=	TCSQLExec(cQuery)
					    
					Else //localizar item do pedido anterior para atualiza-lo 
						//MsgAlert("AjusteVencto:3.3")
						cQuery := "SELECT C6_NUM, C6_ITEM, C6_PRODUTO, C6_PEDANT, C6_ITEMANT, C6_EDINIC, C6_EDFIN, C6_EDVENC, C6_CLI, C6_LOJA, C6_CODDEST, C6_DATA FROM "+ RetSqlName("SC6") +" SC6 WHERE C6_FILIAL='"+ XFILIAL("SC6") +"' AND C6_NUM='"+ ITEMP->C6_PEDANT +"' AND C6_EDFIN<>0 AND C6_EDFIN<>9999 AND C6_EDVENC <= "+ TRANSFORM(ITEMP->C6_EDINIC,"@E 9999") +" AND SUBSTR(C6_PRODUTO,1,4)='"+ SUBSTR(ITEMP->C6_PRODUTO,1,4) +"' AND SC6.D_E_L_E_T_<>'*'"
						//MsgAlert(cQuery)
						TCQUERY cQuery NEW ALIAS "ITEMPX" 
						DbSelectArea("ITEMPX")
						DBGOTOP()
						If !EOF()                
							//MsgAlert("AjusteVencto:3.4")
							//3gravar Renovacao
							cQuery := "UPDATE "+ RetSqlName("SC6") +" SET C6_PEDREN='"+ ITEMP->C6_NUM +"', C6_ITEMREN='"+ ITEMP->C6_ITEM +"' WHERE C6_FILIAL='"+ XFILIAL("SC6") + "' AND C6_NUM='"+ ITEMPX->C6_NUM +"' AND C6_ITEM='"+ ITEMPX->C6_ITEM +"' AND D_E_L_E_T_<>'*'"
							nUpd :=	TCSQLExec(cQuery)                                                                                                                                                                                                                             
							
							//4gravar ItemPedidoAnterior
							cQuery := "UPDATE "+ RetSqlName("SC6") +" SET C6_ITEMANT='"+ ITEMPX->C6_ITEM +"' WHERE C6_FILIAL='"+ XFILIAL("SC6") + "' AND C6_NUM='"+ ITEMP->C6_NUM +"' AND C6_ITEM='"+ ITEMP->C6_ITEM +"' AND D_E_L_E_T_<>'*'"
							nUpd :=	TCSQLExec(cQuery)                                                                                                                                                                                                                             
						Endif //ITEMANT2  
						DbSelectArea("ITEMPX")
						DbCloseArea()
						//MsgAlert("AjusteVencto:3.5")
					EndIf //ITEMPANT
					DbSelectArea("ITEMPANT")
					DbCloseArea()
					
				ENDIF //PEDANT

				DbSelectArea("ITEMP")
				DBSkip()
			END
			DbSelectArea("ITEMP")
			DbCloseArea()
			

			/*************** Alterar Titulos a Receber*************************************************************/
			dbSelectArea("SZ9")
			dbSetOrder(2)
			If dbSeek(mTIPOOP)
				mPROGPA1 := SZ9->Z9_PROGPA1
				mPROGPAD := SZ9->Z9_PROGPAD
				MQTDPARCELA :=  SZ9->Z9_QTDEP
			Endif        
			MCOUNT := 1
			MSOMADR := 0  
			MSOMABOL := 0 
			
			//MsgAlert("AjusteVencto:4")
	
			dbSelectArea("SE1")
			dbSetOrder(2)
			If dbSeek(xFilial("SE1")+SF2->F2_CLIENTE+SF2->F2_LOJA+SF2->F2_SERIE+SF2->F2_DOC,.T.)
				While !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_NUM == cNumero .AND. SE1->E1_PREFIXO == cPrefixo
					IF trim(SE1->E1_TIPO) <> 'NF'
						dbSelectArea("SE1")
						DBSKIP()
						LOOP
					ENDIF
					IF !EMPTY(SE1->E1_BAIXA) //DTOC(SE1->E1_BAIXA) # ' '
						MCOUNT := MCOUNT +1
						dbSelectArea("SE1")
						DBSKIP()
						LOOP
					ENDIF
					mNATUREZ := SE1->E1_NATUREZ
					mEMISSAO := SE1->E1_EMISSAO
					mPROGPAG := CTOD('  /  /  ')
					mVENCTO  := SE1->E1_VENCTO
					mVENCREA := SE1->E1_VENCREA
					
					IF SE1->E1_PARCELA == 'A' .OR. SE1->E1_PARCELA == ' '
						MCOUNT  := 1
						MSOMADR := 0
						MSOMABOL := 0
						If MPROGPA1 == 'S' //primeira paga
							mPROGPAG := SE1->E1_VENCREA
							mNATUREZ := SZ9->Z9_NATBX
						EndIf
					ELSE
						If mPROGPAD == 'S' //pagamento programado
							mPROGPAG := SE1->E1_VENCREA
							mNATUREZ := SZ9->Z9_NATBX2 // daqui 20110817
							if empty(mNATUREZ)
								mNATUREZ := SZ9->Z9_NATBX
							endif // ate aqui 20110817
						EndIf
					ENDIF
					If SE1->E1_VENCTO < SE1->E1_EMISSAO
						mVENCTO := SE1->E1_EMISSAO
					Endif
					IF SE1->E1_VENCREA < MVENCTO
						MVENCREA := MVENCTO
					ENDIF
					IF !Empty(SE1->E1_PGPROG) .AND. SE1->E1_PGPROG < MVENCREA
						MPROGPAG:=MVENCREA
					ENDIF
	
					//  TIRAR QUANDO A COMISSAO FOR PELA EMISSAO E O CARTAO DE CREDITO FOR
					//  COMISSIONADO PELO PROGRAMA DE ATUALIZACAO DE COMISSAO
					IF MTIPOOP=='16 '
						mVENCTO := SE1->E1_EMISSAO
						mVENCREA:= SE1->E1_EMISSAO
						mPROGPAG:= SE1->E1_EMISSAO
						mnaturez:= 'CC'
					ENDIF
			
					IF SUBS(MTIPOOP,1,1)=='8' .and. MTIPOOP <>'86 '  //20070302
						mnaturez:= 'DB'
					ENDIF
		
					IF MTIPOOP=='C2 '.OR. MTIPOOP == 'C3 '.OR. MTIPOOP == 'C4 '.OR. MTIPOOP == 'C5 '
						mnaturez:= 'CC'
					ENDIF
		
					IF MTIPOOP=='BND' //20081210
						mnaturez:= 'BNDES'
					ENDIF
		
					/*// CONDICAO ESPECIAL PARA CURSOS nao eh mais utilizado
					IF SC5->C5_CONDPAG == '702'
						IF SE1->E1_PARCELA == 'A'
							MVALOR:=300.00
						ELSE
							MVALOR:=200.00
						ENDIF
					ENDIF*/
	
					//Despesa de Remessa
					IF TRIM(SE1->E1_SERIE) # 'D1' .AND. MCOUNT = MQTDPARCELA //ultima parcela pegar a dif de valores para nao dar diferenca nos centavos
						MDESPREM := round((SC5->C5_DESPREM - MSOMADR),2)
						mVALOR := SE1->E1_VALOR + (MDESPREM)
						MSOMADR := MSOMADR + MDESPREM
					ELSEIF TRIM(SE1->E1_SERIE) # 'D1' .and. SC5->C5_DESPREM > 0
						MDESPREM := round((SC5->C5_DESPREM / MQTDPARCELA) ,2)
						mVALOR := SE1->E1_VALOR + MDESPREM
						MSOMADR := MSOMADR + MDESPREM
					ELSE 
						MDESPREM := 0 
						mVALOR := SE1->E1_VALOR
					endif
			
        	
					// 20060525: COBRAR TAXA ADMINSTRATIVA POR BOLETO
					MDESPBOL := 0
					IF ((SZ9->Z9_BOLETO1 =='S' .AND. MCOUNT ==1) .OR. (SZ9->Z9_BOLETOD =='S' .AND. MCOUNT >1)) .AND. SC5->C5_DESPBOL >0
						MDESPBOL := SC5->C5_DESPBOL
						MVALOR := MVALOR + MDESPBOL
						MSOMABOL := MSOMABOL + MDESPBOL
					ENDIF
					//20060525 ATE AQUI         
					
	                if (mPROGPA1 =="S" .AND. !EMPTY(MPINISPG)) .or. (Alltrim(cPrefixo)=="3") //20110603 //20110622
		                //MsgAlert("AjusteVencto:5.1")
		                If Alltrim(cPrefixo)=="3"
		                	dVencto := u_VenctoPiniPedido(SE1->E1_PEDIDO, SE1->E1_PARCELA)
		                	if dVencto < ddatabase //20110708
		                		dVencto := ddatabase
		                	endif
			                RecLock("SE1",.F.)
				                Replace SE1->E1_NATUREZ  WITH "LOJAPINI"
				                if !Empty(dVencto)
					                Replace SE1->E1_VENCTO  WITH dVencto
					                Replace SE1->E1_VENCREA  WITH dVencto
								endif
 							MsUnlock()
   							Baixar(SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, 0, 0, "LOJAPINI NFE CONTENT STUFF") //20110603
		                Else
							RecLock("SE1",.F.)    //daqui 20110812               
								Replace SE1->E1_NATUREZ  WITH mNATUREZ
				                Replace SE1->E1_VENCTO   with mVENCTO  
								Replace SE1->E1_VENCREA  with mVENCREA
								Replace SE1->E1_PGPROG   with mPROGPAG
								Replace SE1->E1_VALOR    with mVALOR
								Replace SE1->E1_CLIENTE  WITH MCLIENTE
								Replace SE1->E1_CLIPED   WITH XCLIENTE
								Replace SE1->E1_VLCRUZ   WITH MVALOR
								Replace SE1->E1_SALDO    WITH MVALOR
								Replace SE1->E1_TIPOOP   WITH MTIPOOP
								Replace SE1->E1_GRPROD   WITH MGRUPO
								Replace SE1->E1_DESPBOL   WITH MDESPBOL
								Replace SE1->E1_DESPREM   WITH MDESPREM //20110812: ate aqui
   							MsUnlock()
 							if SE1->E1_PARCELA ==" " .or. SE1->E1_PARCELA =="A" //20110708: somente primeira parcela
			                	RecLock("SE1",.F.)                   
					                Replace SE1->E1_NATUREZ  WITH "SMARTPAG"
						        MsUnlock()
	   							Baixar(SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, 0, 0, "SMARTPAG "+ ALLTRIM(MPINISPG) + " "+ DTOC(DPINIDSG)) //20110603
	   						endif
   						Endif
	                else
						//20060928 PROCESSAR APENAS 1 VEZ!!!IF (SE1->E1_DESPBOL =0 .and. SE1->E1_DESPREM =0) comentei era do Pfat019a
						RecLock("SE1",.F.)
						Replace SE1->E1_VENCTO   with mVENCTO
						Replace SE1->E1_VENCREA  with mVENCREA
						Replace SE1->E1_PGPROG   with mPROGPAG
						Replace SE1->E1_VALOR    with mVALOR
						Replace SE1->E1_CLIENTE  WITH MCLIENTE
						Replace SE1->E1_CLIPED   WITH XCLIENTE
						Replace SE1->E1_VLCRUZ   WITH MVALOR
						Replace SE1->E1_SALDO    WITH MVALOR
						Replace SE1->E1_NATUREZ  WITH mNATUREZ
						Replace SE1->E1_TIPOOP   WITH MTIPOOP
						Replace SE1->E1_GRPROD   WITH MGRUPO
						Replace SE1->E1_DESPBOL   WITH MDESPBOL  //20060525	
						Replace SE1->E1_DESPREM   WITH MDESPREM  //20060525	
						MsUnlock()
						//ENDIF // APENAS 1 VEZ 20060928 comentei era do Pfat019a
					endif

					MCOUNT := MCOUNT +1 //20060525
					
					//MsgAlert("AjusteVencto:5.2")
			
					dbSELECTAREA("SE1")
					dbSkip()
				End //While SE1
			EndIf //Dbseek SE1
			                        
			//MsgAlert("AjusteVencto:6")
			//trocar por update           cPrefixo, cNumero, cCliente, cLoja
			if mCliente <> cCliente
				cQuery := "UPDATE "+ RetSqlName("SD2") +" SET D2_CLIENTE='"+ MCliente +"' WHERE D2_FILIAL='"+ XFILIAL("SD2") + "' AND D2_DOC='"+ cNumero +"' AND D2_SERIE='"+ cPrefixo +"' and D2_CLIENTE='"+ cCliente +"'  AND D2_LOJA='"+ cLoja +"' AND D_E_L_E_T_<>'*'"
				nUpd :=	TCSQLExec(cQuery)
					
				cQuery := "UPDATE "+ RetSqlName("SF3") +" SET F3_CLIEFOR='"+ MCliente +"' WHERE F3_FILIAL='"+ XFILIAL("SF3") + "' AND F3_NFISCAL='"+ cNumero +"' AND F3_SERIE='"+ cPrefixo +"' and F3_CLIEFOR='"+ cCliente +"'  AND F3_LOJA='"+ cLoja +"' AND F3_EMISSAO='"+ DTOS(SF2->F2_EMISSAO) +"' AND D_E_L_E_T_<>'*'"
				nUpd :=	TCSQLExec(cQuery)
			Endif
		
			// Baixa(deleta) os pedidos no arquivo de controle de pedidos
			cQuery := "UPDATE "+ RetSqlName("SZD") +" SET ZD_LOTEFAT='"+ mLoteFat +"', ZD_DATA='"+ dtos(MDATA) +"', ZD_SITUAC='X' WHERE ZD_FILIAL='"+ XFILIAL("SZD") + "' AND ZD_PEDIDO='"+ MPEDIDO +"' AND ZD_SITUAC<>'X' AND D_E_L_E_T_<>'*'"
			nUpd :=	TCSQLExec(cQuery)
		

			DbSelectArea("SF2")
			RecLock("SF2",.F.)
				Replace SF2->F2_PROTOC  WITH '3'
				if mCliente <> cCliente
					Replace SF2->F2_CLIENTE WITH MCLIENTE          
				endif
				if SC5->C5_DESPREM >0 .or. MSOMABOL > 0
					Replace SF2->F2_DESPREM WITH SC5->C5_DESPREM
					Replace SF2->F2_VALBRUT WITH F2_VALMERC + SC5->C5_DESPREM + MSOMABOL  //20060525	
					Replace SF2->F2_VALFAT  WITH F2_VALMERC + SC5->C5_DESPREM + MSOMABOL  //20060525	
				endif
			SF2->(MsUnlock())      

			//MsgAlert("Ajuste de Vencto executado automaticamente!")

		Else //If dbSeek SC5
			Alert("Pedido nao Encontrado-> "+SF2->F2_DOC)
			return(nil)
		Endif
	EndIf //if dbSeek SD2
Endif //If dbSeek SF2
Return(nil)




Static Function Baixar(prefixo, numero, parcela, desconto, juros, historico)
Local mBanco := "CX1"
Local mAgencia := space(5)
Local mConta := space(10)
Local aVetor := {}
lMsErroAuto := .F.
aVetor := {{"E1_PREFIXO"	 ,prefixo             ,Nil},;
				{"E1_NUM"		 ,numero           ,Nil},;
				{"E1_PARCELA"	 ,parcela               ,Nil},;
				{"E1_TIPO"	    ,"NF "             ,Nil},;
				{"AUTMOTBX"	    ,"NOR"             ,Nil},;
				{"AUTDTBAIXA"	 ,dDataBase         ,Nil},;
				{"AUTDTCREDITO" ,dDataBase         ,Nil},;
				{"AUTHIST"	    ,historico,Nil},; 
				{"AUTBANCO"	    ,mBanco,Nil},;
				{"AUTAGENCIA"	,mAgencia,Nil},;
				{"AUTCONTA"	    ,mConta,Nil},;
				{"AUTDESCONT"	,desconto    ,Nil },;
				{"AUTJUROS"	    ,juros    ,Nil },;
				{"AUTVALREC"	,(SE1->E1_SALDO - SE1->E1_IRRF),Nil }}


// Podera informar tambem as seguintes variaveis
// AUTBANCO
// AUTAGENCIA
//AUTCONTA
//AUTDESCONT
//AUTDECRESC
//AUTACRESC
//AUTMULTA
//AUTJUROS

MSExecAuto({|x,y| fina070(x,y)},aVetor,3) //Inclusao

If lMsErroAuto
	MOSTRAERRO()
/*Else
	MsgInfo("Titulo baixado com sucesso!")*/
Endif
Return
