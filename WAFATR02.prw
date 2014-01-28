#INCLUDE "RWMAKE.CH"
/*/
Alterado por Danilo C S Pala em 20080506: ajustes diversos
//Alterado por Danilo C S Pala em 20090408: nosso numero 
//Alterado por Danilo C S Pala em 20101014: gravar nosso numero correto cNroDoc
//Alterado por Danilo C S Pala em 20101108: correcoes para gravar o nosso numero correto, pois estava gravando sem o digito
//Alterado por Danilo C S Pala em 20110330: CGC do cliente original e nao da agencia (Cida)
//Alterado por Danilo C S Pala em 20110705: nao reduzir valor do PIS e Cofins (Cidinha)//20110713 comentar esta parte //20110715: nova regra para evitar este problema
//Alterado por Danilo C S Pala em 20110725: nao era retencao, mas sim apuracao, regra desativada, pois a base foi ajustada.   
//Alterado por Danilo C S Pala em 20120504: PINILOGCONS
//Alterado por Danilo C S Pala em 20120816: alterar o valor do boleto apos 5 dias de vencimento, somando mora e juros
//Alterado por Danilo C S Pala em 20130627: mensagens (Bruno)
//Alterado por Danilo C S Pala em 20130723: implantar data de vencimento com mora e juros calculados (Iolanda) 
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � BLTCDBAR � Autor � Microsiga             � Data � 13/10/03 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � IMPRESSAO DO BOLETO BANCO ITAU COM CODIGO DE BARRAS        ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para Clientes Microsiga                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function WAFATR02()

LOCAL	aPergs := {} 
PRIVATE lExec    := .F.
PRIVATE cIndexName := ''
PRIVATE cIndexKey  := ''
PRIVATE cFilter    := ''
Private cNroDoc :=  ""
Private cDigDoc := ""
Private MHORA      := TIME()
Private dNovoVencto := stod("")

Tamanho  := "M"
titulo   := "Impressao de Boleto com Codigo de Barras"
cDesc1   := "Este programa destina-se a impressao do Boleto com Codigo de Barras."
cDesc2   := ""
cDesc3   := ""
cString  := "SE1"
wnrel    := "BOLETO_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
lEnd     := .F.
cPerg     :="BLTBAR"
aReturn  := {"Zebrado", 1,"Administracao", 2, 2, 1, "",1 }   
nLastKey := 0

dbSelectArea("SE1")

Aadd(aPergs,{"De Prefixo","","","mv_ch1","C",3,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Ate Prefixo","","","mv_ch2","C",3,0,0,"G","","MV_PAR02","","","","ZZZ","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"De Numero","","","mv_ch3","C",9,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Ate Numero","","","mv_ch4","C",9,0,0,"G","","MV_PAR04","","","","ZZZZZZ","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"De Parcela","","","mv_ch5","C",1,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Ate Parcela","","","mv_ch6","C",1,0,0,"G","","MV_PAR06","","","","Z","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"De Portador","","","mv_ch7","C",3,0,0,"G","","MV_PAR07","","","","","","","","","","","","","","","","","","","","","","","","","SA6","","","",""})
Aadd(aPergs,{"Ate Portador","","","mv_ch8","C",3,0,0,"G","","MV_PAR08","","","","ZZZ","","","","","","","","","","","","","","","","","","","","","SA6","","","",""})
Aadd(aPergs,{"De Cliente","","","mv_ch9","C",6,0,0,"G","","MV_PAR09","","","","","","","","","","","","","","","","","","","","","","","","","SE1","","","",""})
Aadd(aPergs,{"Ate Cliente","","","mv_cha","C",6,0,0,"G","","MV_PAR10","","","","ZZZZZZ","","","","","","","","","","","","","","","","","","","","","SE1","","","",""})
Aadd(aPergs,{"De Loja","","","mv_chb","C",2,0,0,"G","","MV_PAR11","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Ate Loja","","","mv_chc","C",2,0,0,"G","","MV_PAR12","","","","ZZ","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"De Emissao","","","mv_chd","D",8,0,0,"G","","MV_PAR13","","","","01/01/80","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Ate Emissao","","","mv_che","D",8,0,0,"G","","MV_PAR14","","","","31/12/03","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"De Vencimento","","","mv_chf","D",8,0,0,"G","","MV_PAR15","","","","01/01/80","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Ate Vencimento","","","mv_chg","D",8,0,0,"G","","MV_PAR16","","","","31/12/03","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Do Bordero","","","mv_chh","C",6,0,0,"G","","MV_PAR17","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Ate Bordero","","","mv_chi","C",6,0,0,"G","","MV_PAR18","","","","ZZZZZZ","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Reimpressao","","","mv_chj","C",1,0,0,"C","","MV_PAR19","Nao","No","No","","","Sim","Yes","Si","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Carteira","","","mv_chk","C",3,0,0,"G","","MV_PAR20","","","","175","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Juros/Dia","","","mv_chl","N",4,2,0,"G","","MV_PAR21","","","","0.17","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Multa","","","mv_chm","N",4,2,0,"G","","MV_PAR22","","","","2","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Desconto","","","mv_chn","N",9,2,0,"G","","MV_PAR23","","","","0","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Dias p/recebimento","","","mv_cho","N",2,0,0,"G","","MV_PAR24","","","","5","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aPergs,{"Novo Vencto do boleto","","","mv_chp","D",8,0,0,"G","","MV_PAR25","","","","23/07/13","","","","","","","","","","","","","","","","","","","","","","","","",""}) //20130723

AjustaSx1("BLTBAR",aPergs)

Pergunte (cPerg,.F.)

Wnrel := SetPrint(cString,Wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho,,)

If nLastKey == 27
	Set Filter to
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter to
	Return
Endif

cIndexName	:= Criatrab(Nil,.F.)
cIndexKey	:= "E1_NUM"
cFilter		+= "E1_FILIAL=='"+xFilial("SE1")+"'.And.E1_SALDO>0.And."
cFilter		+= "E1_PREFIXO>='" + MV_PAR01 + "'.And.E1_PREFIXO<='" + MV_PAR02 + "'.And." 
cFilter		+= "E1_NUM>='" + MV_PAR03 + "'.And.E1_NUM<='" + MV_PAR04 + "'.And."
cFilter		+= "E1_PARCELA>='" + MV_PAR05 + "'.And.E1_PARCELA<='" + MV_PAR06 + "'.And."
cFilter		+= "E1_PORTADO>='" + MV_PAR07 + "'.And.E1_PORTADO<='" + MV_PAR08 + "'.And."
cFilter		+= "E1_CLIENTE>='" + MV_PAR09 + "'.And.E1_CLIENTE<='" + MV_PAR10 + "'.And."
cFilter		+= "E1_LOJA>='" + MV_PAR11 + "'.And.E1_LOJA<='"+MV_PAR12+"'.And."
cFilter		+= "DTOS(E1_EMISSAO)>='"+DTOS(mv_par13)+"'.and.DTOS(E1_EMISSAO)<='"+DTOS(mv_par14)+"'.And."
cFilter		+= 'DTOS(E1_VENCREA)>="'+DTOS(mv_par15)+'".and.DTOS(E1_VENCREA)<="'+DTOS(mv_par16)+'".And.'
cFilter		+= "E1_NUMBOR>='" + MV_PAR17 + "'.And.E1_NUMBOR<='" + MV_PAR18 + "'.And."
cFilter		+= "!(E1_TIPO$MVABATIM)"
cFilter		+= " .And. E1_PORTADO<>'   '" 

IndRegua("SE1", cIndexName, cIndexKey,, cFilter, "Aguarde selecionando registros....")
DbSelectArea("SE1")
#IFNDEF TOP
	DbSetIndex(cIndexName + OrdBagExt())
#ENDIF
dbGoTop()
@ 001,001 TO 400,700 DIALOG oDlg TITLE "Sele��o de Titulos"
@ 001,001 TO 170,350 BROWSE "SE1" MARK "E1_OK"
@ 180,310 BMPBUTTON TYPE 01 ACTION (lExec := .T.,Close(oDlg))
@ 180,280 BMPBUTTON TYPE 02 ACTION (lExec := .F.,Close(oDlg))
ACTIVATE DIALOG oDlg CENTERED
	
dbGoTop()
If lExec
	Processa({|lEnd|MontaRel()})
Endif
RetIndex("SE1")
Ferase(cIndexName+OrdBagExt())

Return Nil

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �  MontaRel� Autor � Microsiga             � Data � 13/10/03 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � IMPRESSAO DO BOLETO LASER DO ITAU COM CODIGO DE BARRAS     ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para Clientes Microsiga                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function MontaRel()
LOCAL oPrint
LOCAL nX := 0
LOCAL aDadosEmp    := {	SM0->M0_NOMECOM                                    ,; //[1]Nome da Empresa
								SM0->M0_ENDCOB                                     ,; //[2]Endere�o
								AllTrim(SM0->M0_BAIRCOB)+", "+AllTrim(SM0->M0_CIDCOB)+", "+SM0->M0_ESTCOB ,; //[3]Complemento
								"CEP: "+Subs(SM0->M0_CEPCOB,1,5)+"-"+Subs(SM0->M0_CEPCOB,6,3)             ,; //[4]CEP
								"PABX/FAX: "+SM0->M0_TEL                                                  ,; //[5]Telefones
								"CNPJ: "+Subs(SM0->M0_CGC,1,2)+"."+Subs(SM0->M0_CGC,3,3)+"."+          ; //[6]
								Subs(SM0->M0_CGC,6,3)+"/"+Subs(SM0->M0_CGC,9,4)+"-"+                       ; //[6]
								Subs(SM0->M0_CGC,13,2)                                                    ,; //[6]CGC
								"I.E.: "+Subs(SM0->M0_INSC,1,3)+"."+Subs(SM0->M0_INSC,4,3)+"."+            ; //[7]
								Subs(SM0->M0_INSC,7,3)+"."+Subs(SM0->M0_INSC,10,3)                        }  //[7]I.E

LOCAL aDadosTit    := {}
LOCAL aDadosBanco  := {}
LOCAL aDatSacado   := {}
LOCAL aBolText     := {}
Local cNumCon      := ""
Local nDAtraso	   := 0

LOCAL nI        := 1
LOCAL aCB_RN_NN := {}
LOCAL nVlrAbat	:= 0
Local cCgcCli := space(14)

oPrint:= TMSPrinter():New( "Boleto Laser" )
oPrint:SetPortrait() // ou SetLandscape()
oPrint:StartPage()   // Inicia uma nova p�gina



dbGoTop()
ProcRegua(RecCount())
Do While !EOF()
	//Posiciona o SA6 (Bancos)
	DbSelectArea("SA6")
	DbSetOrder(1)
	DbSeek(xFilial("SA6")+SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA,.T.)
	
	//Posiciona na Arq de Parametros CNAB
	DbSelectArea("SEE")
	DbSetOrder(1)
	DbSeek(xFilial("SEE")+SE1->(E1_PORTADO+E1_AGEDEP+E1_CONTA),.T.)
	
	//Posiciona o SA1 (Cliente)
	DbSelectArea("SA1")
	DbSetOrder(1)
	DbSeek(xFilial()+SE1->E1_CLIENTE+SE1->E1_LOJA,.T.)
	cCgcCli := SA1->A1_Cgc //20110330
	
	DbSelectArea("SE1")
	cNumCon := Alltrim(StrTran(SA6->A6_NUMCON,"-",""))

	aDadosBanco  := {}
    AADD(aDadosBanco,SA6->A6_COD)                       // [1]Numero do Banco
    AADD(aDadosBanco,SA6->A6_NREDUZ)     	            	// [2]Nome do Banco
    AADD(aDadosBanco,SUBSTR(SA6->A6_AGENCIA, 1, 5))     // [3]Ag�ncia
    AADD(aDadosBanco,SUBSTR(cNumCon,1,Len(cNumCon)-1))	// [4]Conta Corrente
    AADD(aDadosBanco,SUBSTR(cNumCon,Len(cNumCon),1))	// [5]D�gito da conta corrente
    AADD(aDadosBanco," ")                               // [6]Codigo da Carteira
                                             
//	If Empty(SA1->A1_ENDCOB) //20080521 Danilo C S Pala
		aDatSacado   := {}
		AADD(aDatSacado,AllTrim(SA1->A1_NOME))                          	// [1]Raz�o Social
		AADD(aDatSacado,AllTrim(SA1->A1_COD )+"-"+SA1->A1_LOJA)           // [2]C�digo
		AADD(aDatSacado,AllTrim(ExecBlock("VCB01"))+" - "+AllTrim(ExecBlock("VCB02"))) // [3]Endere�o
		AADD(aDatSacado,AllTrim(ExecBlock("VCB04"))) 						// [4]Cidade
		AADD(aDatSacado,ExecBlock("VCB05"))                                	// [5]Estado
		AADD(aDatSacado,ExecBlock("VCB03"))                                	// [6]CEP
		//AADD(aDatSacado,SA1->A1_CGC)										// [7]CGC//20110330
		AADD(aDatSacado,cCgcCli)   					 					// [7]CGC		//20110330
		AADD(aDatSacado,SA1->A1_PESSOA)										// [8]PESSOA
		AADD(aDatSacado,10) //AADD(aDatSacado,SA1->A1_COMIS3)										// [8]PESSOA //Danilo C S Pala 20080516
/*	Else
		aDatSacado   := {}
		AADD(aDatSacado,AllTrim(SA1->A1_NOME))            	 				  	// [1]Raz�o Social
		AADD(aDatSacado,AllTrim(SA1->A1_COD )+"-"+SA1->A1_LOJA)               	// [2]C�digo
		AADD(aDatSacado,AllTrim(SA1->A1_ENDCOB)+"-"+AllTrim(SA1->A1_BAIRROC))  	// [3]Endere�o
		AADD(aDatSacado,AllTrim(SA1->A1_MUNC))	                               	// [4]Cidade
		AADD(aDatSacado,SA1->A1_ESTC)	                                       	// [5]Estado
		AADD(aDatSacado,SA1->A1_CEPC)                                          	// [6]CEP
		AADD(aDatSacado,SA1->A1_CGC)											// [7]CGC
		AADD(aDatSacado,SA1->A1_PESSOA)								 			// [8]PESSOA
		AADD(aDatSacado,10)	//	AADD(aDatSacado,SA1->A1_COMIS3)										// [8]PESSOA  //Danilo C S Pala 20080516
	Endif
*/	//20080521 Danilo C S Pala
	
	nVlrAbat   :=  SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,,SE1->E1_CLIENTE,SE1->E1_LOJA)
	/*IF nVlrAbat > 0 .and. (ALLTRIM(SE1->E1_DIVVEN)=='PUBL' .OR. ALLTRIM(SE1->E1_DIVVEN)=='MERC') //20110705 Cidinha //20110718: pulicidade e assinaturas/livros //20110725
		nVlrAbat := 0 //nVlrAbat - SE1->E1_PIS - SE1->E1_COFINS
	ENDIF*/

	//Aqui defino parte do nosso numero. Sao 8 digitos para identificar o titulo. 
	//Abaixo apenas uma sugestao
	
	If val(Alltrim(SE1->E1_NUMBCO))<>0 .or. mv_par19 == 2 //!Empty(SE1->E1_NUMBCO) 
		//cNroDoc := Alltrim(SE1->E1_NUMBCO) //U_RetNumParc() Danilo C S Pala 20080516
		//cNroDoc := strzero(val(Alltrim(SE1->E1_NUMBCO)),8) //20090408 //20101108
		cNroDoc := Left(Alltrim(SE1->E1_NUMBCO),8)
		//cDigDoc := Substr(Alltrim(SE1->E1_NUMBCO),9,1) //incluir este linha ou nao?
	Else
		cNroDoc := U_NOVONN(SEE->EE_CODIGO, SEE->EE_AGENCIA, SEE->EE_CONTA) //fezer mais testes para liberar a geracao
		//MsgStop(OemToAnsi(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA+": NOSSO NUMERO"),"ALERTA")
		//return
	Endif
	if cNroDoc ==""
		MsgStop(OemToAnsi(SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + ": SEM O NOSSO NUMERO"),"ALERTA")
		return
	endif
	
	If empty(mv_par25) //20130723 daqui
		dNovoVencto := SE1->E1_VENCTO
	Else
		If MsgYesNo("Uma nova data de vencimento foi digitada, deseja utiliz�-la?(Sim) Para deixar o vencimento original do t�tulo(N�o)")
			dNovoVencto := mv_par25
		Else
			dNovoVencto := SE1->E1_VENCTO
		Endif
	End If
	//Monta codigo de barras
	aCB_RN_NN    := Ret_cBarra(Subs(aDadosBanco[1],1,3)+"9",aDadosBanco[3],aDadosBanco[4],aDadosBanco[5],cNroDoc,ROUND(E1_VALOR-nVlrAbat,2),dNovoVencto ) // E1_VENCTO)20130723
	
	aDadosTit	:= {}
	AADD(aDadosTit,AllTrim(E1_NUM)+AllTrim(E1_PARCELA))       									   // [1] N�mero do t�tulo
	AADD(aDadosTit,E1_EMISSAO)                               									   // [2] Data da emiss�o do t�tulo
	AADD(aDadosTit,dDataBase)                    												      // [3] Data da emiss�o do boleto
	AADD(aDadosTit,dNovoVencto) //E1_VENCTO )20130723			                                 // [4] Data do vencimento
//	AADD(aDadosTit,(E1_SALDO - nVlrAbat))                  	 // [5] Valor do t�tulo
	AADD(aDadosTit,ROUND(E1_VALOR - nVlrAbat,2))             									   // [5] Valor do t�tulo
	AADD(aDadosTit,aCB_RN_NN[3])								                                    // [6] Nosso n�mero (Ver f�rmula para calculo)
	AADD(aDadosTit,E1_PREFIXO)                               									   // [7] Prefixo da NF
	AADD(aDadosTit,E1_TIPO)	                           		                              // [8] Tipo do Titulo
	AADD(aDadosTit,10) //	AADD(aDadosTit,POSICIONE("SA1",1,xFilial("SA1")+E1_CLIENTE+E1_LOJA,"A1_COMIS3")/100)	// [9]  % juros por dia //Danilo C S Pala 20080516
	AADD(aDadosTit,10)//    AADD(aDadosTit,POSICIONE("SA1",1,xFilial("SA1")+E1_CLIENTE+E1_LOJA,"A1_COMIS2"))	      // [10] % multa por mes //Danilo C S Pala 20080516
	AADD(aDadosTit,POSICIONE("SF2",1,xFilial("SF2")+E1_NUM+E1_PREFIXO,"F2_NFELETR"))	      // [11] Numero da NF Eletronica
	
//Solicitado pela Bianca em 07/02/07 - Andr� Luis - Introde % Juros no Cad.Cliente p/Boleto
//cJuros := If(aDadosTit[9]<=0,0.05,aDadosTit[9])  //20080520: Danilo C S Pala comentado
// Alteracao 04/05/2007 - ricardo cavalini - % multa por mes
//CMULTA := If(aDadosTit[10]<=0,0,aDadosTit[10]) //20080520: Danilo C S Pala comentado

	aBolText 	:= {}
//	AADD(aBolText,"Ap�s o vencimento cobrar R$ " + AllTrim(Transform(((aDadosTit[5]*0.05)/30),"@E 99,999.99")) + " por dia de atraso.")
/*	AADD(aBolText,"Ap�s o vencimento cobrar R$ " + AllTrim(Transform(((aDadosTit[5]*cJuros)/30),"@E 99,999.99")) + " por dia de atraso.")
	AADD(aBolText,"Ap�s o vencimento cobrar "    + AllTrim(Transform(CMULTA                    ,"@E 99,999")) + " % ao m�s de atraso.")
	AADD(aBolText,"Sujeito a Protesto apos 05 (cinco) dias do vencimento")*/ //20080520: Danilo C S Pala: daqui 
	
	_nJuros := MV_PAR21 //0.17 //****passado por parametro
	_nDescon := MV_PAR23 //0 //****passado por parametro
	_nMulta1 := MV_PAR22 //2 //****passado por parametro
	_nDias   := MV_PAR24 //****passado por parametro

	_cMulta1 := Alltrim(Str((aDadosTit[5] * _nMulta1)/100,10,2))
	_cMulta  := Alltrim(Str((aDadosTit[5] * _nJuros)/100,10,2))
	_cPrazo  := DTOC( aDadosTit[4] + _nDias )                    /// anteriormente era fixado em 10 dias...
	_cDesc   := Alltrim(Str(_nDescon,10,2))
	if dNovoVencto > SE1->E1_VENCTO //ddatabase > (aDadosTit[4] + 5) //daqui 20120816 //20130723
		nDAtraso := dNovoVencto - SE1->E1_VENCTO //ddatabase - aDadosTit[4] //20130723
		aDadosTit[5] := ROUND((aDadosTit[5] + val(_cMulta1) + (nDAtraso*val(_cMulta))),2)
		_cPrazo  := DTOC(dNovoVencto ) //ddatabase) 20130723
		aDadosTit[4] := dNovoVencto //ddatabase 20130723
		aCB_RN_NN    := Ret_cBarra(Subs(aDadosBanco[1],1,3)+"9",aDadosBanco[3],aDadosBanco[4],aDadosBanco[5],cNroDoc,aDadosTit[5],aDadosTit[4])
		//AADD(aBolText,"APOS O VENCIMENTO COBRAR R$ "+_cMulta +" POR DIA DE ATRASO.")
	elseif _nJuros > 0  //.and. ddatabase <= (aDadosTit[4] + 5) //ate 20120816 ERA if _nJuros > 0
		AADD(aBolText,"APOS O VENCIMENTO COBRAR R$ "+_cMulta1+" DE MULTA.")
		AADD(aBolText,"MAIS R$ "+_cMulta+" POR DIA DE ATRASO.")
	endif
	
	AADD(aBolText,"NAO RECEBER APOS O DIA "+_cPrazo)
	if _nDescon > 0
		AADD(aBolText,"     CONCEDER DESCONTO DE R$ "+_cDesc)
	endif  //20080520: Danilo C S Pala: ate aqui             
	AADD(aBolText,"N�O ACEITAMOS PAGAMENTOS VIA DOC, TRANSFER�NCIA OU DEP�SITO") //20130627  SIMPLES
	//AADD(aBolText,"POIS NOSSO SISTEMA N�O IDENTIFICA ESTAS FORMAS DE PAGAMENTO") 20130627
	AADD(aBolText,"SUJEITO A PROTESTO SE NAO FOR PAGO NO VENCTO") //20080609 inserido a pedido da Iolanda
	If SM0->M0_CODIGO=='01' //ED  DAQUI 20130627
		AADD(aBolText,"D�VIDAS, 2� VIA DE BOLETO, ATUALIZA��O OU PRORROGA��O LIGUE PARA (11) 2173-2445")
	Elseif SM0->M0_CODIGO=='03' //BP
		AADD(aBolText,"D�VIDAS, 2� VIA DE BOLETO, ATUALIZA��O OU PRORROGA��O LIGUE PARA (11) 2173-2443")
	EndIf //ate aqui 20130726
		

	If Marked("E1_OK")
		Impress(oPrint,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,aCB_RN_NN)
		U_PINILOGCONS(SM0->M0_CODIGO, SE1->E1_CLIENTE, SE1->E1_LOJA, SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, SE1->E1_EMISSAO, SE1->E1_PEDIDO, "BOL", "WAFATR02", "BOLETO POR EMAIL") //20120504
		nX := nX + 1
	EndIf

	DbSelectArea("SE1")
	dbSkip()
	IncProc()
	nI := nI + 1
EndDo
oPrint:EndPage()     // Finaliza a p�gina
oPrint:Preview()     // Visualiza antes de imprimir
Return nil


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �  Impress � Autor � Microsiga             � Data � 13/10/03 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � IMPRESSAO DO BOLETO LASERDO ITAU COM CODIGO DE BARRAS      ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para Clientes Microsiga                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function Impress(oPrint,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,aCB_RN_NN)
LOCAL oFont8
LOCAL oFont11c
LOCAL oFont10
LOCAL oFont14
LOCAL oFont16n
LOCAL oFont15
LOCAL oFont14n
LOCAL oFont24
LOCAL nI := 0
LOCAL nCont := 0 //20080521: Danilo C S Pala

//Parametros de TFont.New()
//1.Nome da Fonte (Windows)
//3.Tamanho em Pixels
//5.Bold (T/F)
oFont8  := TFont():New("Arial",9,8,.T.,.F.,5,.T.,5,.T.,.F.)
oFont11c := TFont():New("Courier New",9,11,.T.,.T.,5,.T.,5,.T.,.F.)
oFont10  := TFont():New("Arial",9,10,.T.,.T.,5,.T.,5,.T.,.F.)
oFont12  := TFont():New("Arial",9,12,.T.,.T.,5,.T.,5,.T.,.F.)
oFont14  := TFont():New("Arial",9,14,.T.,.T.,5,.T.,5,.T.,.F.)
oFont20  := TFont():New("Arial",9,20,.T.,.T.,5,.T.,5,.T.,.F.)
oFont21  := TFont():New("Arial",9,21,.T.,.T.,5,.T.,5,.T.,.F.)
oFont16n := TFont():New("Arial",9,16,.T.,.F.,5,.T.,5,.T.,.F.)
oFont15  := TFont():New("Arial",9,15,.T.,.T.,5,.T.,5,.T.,.F.)
oFont15n := TFont():New("Arial",9,15,.T.,.F.,5,.T.,5,.T.,.F.)
oFont14n := TFont():New("Arial",9,14,.T.,.F.,5,.T.,5,.T.,.F.)
oFont24  := TFont():New("Arial",9,24,.T.,.T.,5,.T.,5,.T.,.F.)

oPrint:StartPage()   // Inicia uma nova p�gina

/******************/
/* PRIMEIRA PARTE */
/******************/

nRow1 := 0
 
oPrint:Line (nRow1+0150,500,nRow1+0070, 500)
oPrint:Line (nRow1+0150,710,nRow1+0070, 710)

oPrint:Say  (nRow1+0084,100,aDadosBanco[2],oFont12 )	// [2]Nome do Banco //20080609 era oFont14
oPrint:Say  (nRow1+0075,513,aDadosBanco[1]+"-7",oFont21 )		// [1]Numero do Banco

oPrint:Say  (nRow1+0084,1900,"Comprovante de Entrega",oFont10)
oPrint:Line (nRow1+0150,100,nRow1+0150,2300)

oPrint:Say  (nRow1+0150,100 ,"Cedente",oFont8)
oPrint:Say  (nRow1+0200,100 ,aDadosEmp[1],oFont10)				//Nome + CNPJ

oPrint:Say  (nRow1+0150,1060,"Ag�ncia/C�digo Cedente",oFont8)
oPrint:Say  (nRow1+0200,1060,aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5],oFont10)

oPrint:Say  (nRow1+0150,1510,"Nro.Documento",oFont8)
oPrint:Say  (nRow1+0200,1510,aDadosTit[7]+aDadosTit[1],oFont10) //Prefixo +Numero+Parcela
// Alterado por Adriano Oliveira em 04/06/07 para impressao no numero da NF Eletronica
//oPrint:Say  (nRow1+0200,1510,aDadosTit[11],oFont10) //Numero da NF Eletronica

oPrint:Say  (nRow1+0250,100 ,"Sacado",oFont8)
oPrint:Say  (nRow1+0300,100 ,aDatSacado[1],oFont10)				//Nome

oPrint:Say  (nRow1+0250,1060,"Vencimento",oFont8)
oPrint:Say  (nRow1+0300,1060,StrZero(Day(aDadosTit[4]),2) +"/"+ StrZero(Month(aDadosTit[4]),2) +"/"+ Right(Str(Year(aDadosTit[4])),4),oFont10)

oPrint:Say  (nRow1+0250,1510,"Valor do Documento",oFont8)
oPrint:Say  (nRow1+0300,1550,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)

oPrint:Say  (nRow1+0400,0100,"Recebi(emos) o bloqueto/t�tulo",oFont10)
oPrint:Say  (nRow1+0450,0100,"com as caracter�sticas acima.",oFont10)
oPrint:Say  (nRow1+0350,1060,"Data",oFont8)
oPrint:Say  (nRow1+0350,1410,"Assinatura",oFont8)
oPrint:Say  (nRow1+0450,1060,"Data",oFont8)
oPrint:Say  (nRow1+0450,1410,"Entregador",oFont8)

oPrint:Line (nRow1+0250, 100,nRow1+0250,1900 )
oPrint:Line (nRow1+0350, 100,nRow1+0350,1900 )
oPrint:Line (nRow1+0450,1050,nRow1+0450,1900 ) //---
oPrint:Line (nRow1+0550, 100,nRow1+0550,2300 )

oPrint:Line (nRow1+0550,1050,nRow1+0150,1050 )
oPrint:Line (nRow1+0550,1400,nRow1+0350,1400 )
oPrint:Line (nRow1+0350,1500,nRow1+0150,1500 ) //--
oPrint:Line (nRow1+0550,1900,nRow1+0150,1900 )

oPrint:Say  (nRow1+0165,1910,"(  )Mudou-se"                                	,oFont8)
oPrint:Say  (nRow1+0205,1910,"(  )Ausente"                                    ,oFont8)
oPrint:Say  (nRow1+0245,1910,"(  )N�o existe n� indicado"                  	,oFont8)
oPrint:Say  (nRow1+0285,1910,"(  )Recusado"                                	,oFont8)
oPrint:Say  (nRow1+0325,1910,"(  )N�o procurado"                              ,oFont8)
oPrint:Say  (nRow1+0365,1910,"(  )Endere�o insuficiente"                  	,oFont8)
oPrint:Say  (nRow1+0405,1910,"(  )Desconhecido"                            	,oFont8)
oPrint:Say  (nRow1+0445,1910,"(  )Falecido"                                   ,oFont8)
oPrint:Say  (nRow1+0485,1910,"(  )Outros(anotar no verso)"                  	,oFont8)
           

/*****************/
/* SEGUNDA PARTE */
/*****************/

nRow2 := 0

//Pontilhado separador
For nI := 100 to 2300 step 50
	oPrint:Line(nRow2+0580, nI,nRow2+0580, nI+30)
Next nI

oPrint:Line (nRow2+0710,100,nRow2+0710,2300)
oPrint:Line (nRow2+0710,500,nRow2+0630, 500)
oPrint:Line (nRow2+0710,710,nRow2+0630, 710)

oPrint:Say  (nRow2+0644,100,aDadosBanco[2],oFont12 )		// [2]Nome do Banco //20080609 era oFont14
oPrint:Say  (nRow2+0635,513,aDadosBanco[1]+"-7",oFont21 )	// [1]Numero do Banco
oPrint:Say  (nRow2+0644,1800,"Recibo do Sacado",oFont10)

oPrint:Line (nRow2+0810,100,nRow2+0810,2300 )
oPrint:Line (nRow2+0910,100,nRow2+0910,2300 )
oPrint:Line (nRow2+0980,100,nRow2+0980,2300 )
oPrint:Line (nRow2+1050,100,nRow2+1050,2300 )

oPrint:Line (nRow2+0910,500,nRow2+1050,500)
oPrint:Line (nRow2+0980,750,nRow2+1050,750)
oPrint:Line (nRow2+0910,1000,nRow2+1050,1000)
oPrint:Line (nRow2+0910,1300,nRow2+0980,1300)
oPrint:Line (nRow2+0910,1480,nRow2+1050,1480)

oPrint:Say  (nRow2+0710,100 ,"Local de Pagamento",oFont8)
oPrint:Say  (nRow2+0740,100 ,Alltrim(aDadosBanco[3]+"-"+aDadosBanco[5]),oFont10) //novo: Danilo C S Pala 20080520
oPrint:Say  (nRow2+0725,400 ,"AT� O VENCIMENTO PAG�VEL EM QUALQUER BANCO",oFont10)  //Danilo C S Pala 20080520
oPrint:Say  (nRow2+0765,400 ,"AP�S O VENCIMENTO PAG�VEL APENAS NO BANCO ITAU",oFont10) //Danilo C S Pala 20080520

oPrint:Say  (nRow2+0710,1810,"Vencimento"                                     ,oFont8)
cString	:= StrZero(Day(aDadosTit[4]),2) +"/"+ StrZero(Month(aDadosTit[4]),2) +"/"+ Right(Str(Year(aDadosTit[4])),4)
nCol := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow2+0750,nCol,cString,oFont11c)

oPrint:Say  (nRow2+0810,100 ,"Cedente"                                        ,oFont8)
oPrint:Say  (nRow2+0850,100 ,aDadosEmp[1]+"                  - "+aDadosEmp[6]	,oFont10) //Nome + CNPJ

oPrint:Say  (nRow2+0810,1810,"Ag�ncia/C�digo Cedente",oFont8)
cString := Alltrim(aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5])
nCol := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow2+0850,nCol,cString,oFont11c)

oPrint:Say  (nRow2+0910,100 ,"Data do Documento"                              ,oFont8)
oPrint:Say  (nRow2+0940,100, StrZero(Day(aDadosTit[2]),2) +"/"+ StrZero(Month(aDadosTit[2]),2) +"/"+ Right(Str(Year(aDadosTit[2])),4),oFont10)

oPrint:Say  (nRow2+0910,505 ,"Nro.Documento"                                  ,oFont8)
oPrint:Say  (nRow2+0940,605 ,aDadosTit[7]+aDadosTit[1]						,oFont10) //Prefixo +Numero+Parcela
// Alterado por Adriano Oliveira em 04/06/07 para impressao no numero da NF Eletronica
//oPrint:Say  (nRow2+0940,605 ,aDadosTit[11]						,oFont10) //Numero da Nf Eletronica

oPrint:Say  (nRow2+0910,1005,"Esp�cie Doc."                                   ,oFont8)
oPrint:Say  (nRow2+0940,1050,"DM"										,oFont10) //Tipo do Titulo // aDadosTit[8]

oPrint:Say  (nRow2+0910,1305,"Aceite"                                         ,oFont8)
oPrint:Say  (nRow2+0940,1400,"N"                                             ,oFont10)

oPrint:Say  (nRow2+0910,1485,"Data do Processamento"                          ,oFont8)
oPrint:Say  (nRow2+0940,1550,StrZero(Day(aDadosTit[3]),2) +"/"+ StrZero(Month(aDadosTit[3]),2) +"/"+ Right(Str(Year(aDadosTit[3])),4),oFont10) // Data impressao

oPrint:Say  (nRow2+0910,1810,"Nosso N�mero"                                   ,oFont8)
cString := Alltrim(Substr(aDadosTit[6],1,3)+"/"+Substr(aDadosTit[6],4))
nCol := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow2+0940,nCol,cString,oFont11c)

oPrint:Say  (nRow2+0980,100 ,"Uso do Banco"                                   ,oFont8)

oPrint:Say  (nRow2+0980,505 ,"Carteira"                                       ,oFont8)
oPrint:Say  (nRow2+1010,555 ,aDadosBanco[6]                                  	,oFont10)

oPrint:Say  (nRow2+0980,755 ,"Esp�cie"                                        ,oFont8)
oPrint:Say  (nRow2+1010,805 ,"R$"                                             ,oFont10)

oPrint:Say  (nRow2+0980,1005,"Quantidade"                                     ,oFont8)
oPrint:Say  (nRow2+0980,1485,"Valor"                                          ,oFont8)

oPrint:Say  (nRow2+0980,1810,"Valor do Documento"                          	,oFont8)
cString := Alltrim(Transform(aDadosTit[5],"@E 99,999,999.99"))
nCol := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow2+1010,nCol,cString ,oFont11c)

oPrint:Say  (nRow2+1050,100 ,"Instru��es (Todas informa��es deste bloqueto s�o de exclusiva responsabilidade do cedente)",oFont8)

/*20080521: Danilo C S Pala: daqui
oPrint:Say  (nRow2+1150,100 ,aBolText[1],oFont10)
//if cmulta > 0 //20080520Danilo C S Pala 
oPrint:Say  (nRow2+1200,100 ,aBolText[2],oFont10)
//endif
oPrint:Say  (nRow2+1250,100 ,aBolText[3],oFont10)
oPrint:Say  (nRow2+1300,100 ,aBolText[4],oFont10)
*/ 
For nCont:=1 to Len(aBolText)
	oPrint:Say  (nRow2+1050+(nCont*50),100 ,aBolText[nCont],oFont10)
Next //20080521: Danilo C S Pala: ate aqui

oPrint:Say  (nRow2+1050,1810,"(-)Desconto/Abatimento"                         ,oFont8)
oPrint:Say  (nRow2+1120,1810,"(-)Outras Dedu��es"                             ,oFont8)
oPrint:Say  (nRow2+1190,1810,"(+)Mora/Multa"                                  ,oFont8)
oPrint:Say  (nRow2+1260,1810,"(+)Outros Acr�scimos"                           ,oFont8)
oPrint:Say  (nRow2+1330,1810,"(=)Valor Cobrado"                               ,oFont8)

oPrint:Say  (nRow2+1400,100 ,"Sacado"                                         ,oFont8)
oPrint:Say  (nRow2+1430,400 ,aDatSacado[1]+" ("+aDatSacado[2]+")"             ,oFont10)
oPrint:Say  (nRow2+1483,400 ,aDatSacado[3]                                    ,oFont10)
oPrint:Say  (nRow2+1536,400 ,substr(aDatSacado[6],1,5)+"-"+substr(aDatSacado[6],6,3) +"    "+aDatSacado[4]+" - "+aDatSacado[5],oFont10) // CEP+Cidade+Estado

if len(alltrim(aDatSacado[7])) > 11 //if aDatSacado[8] = "J"
	oPrint:Say  (nRow2+1589,400 ,"CNPJ: "+TRANSFORM(aDatSacado[7],"@R 99.999.999/9999-99"),oFont10) // CGC
Else
	oPrint:Say  (nRow2+1589,400 ,"CPF: "+TRANSFORM(aDatSacado[7],"@R 999.999.999-99"),oFont10) 	// CPF
EndIf

oPrint:Say  (nRow2+1589,1850,Substr(aDadosTit[6],1,3)+Substr(aDadosTit[6],4)  ,oFont10)

oPrint:Say  (nRow2+1605,100 ,"Sacador/Avalista",oFont8)
oPrint:Say  (nRow2+1645,1500,"Autentica��o Mec�nica",oFont8)

oPrint:Line (nRow2+0710,1800,nRow2+1400,1800 ) 
oPrint:Line (nRow2+1120,1800,nRow2+1120,2300 )
oPrint:Line (nRow2+1190,1800,nRow2+1190,2300 )
oPrint:Line (nRow2+1260,1800,nRow2+1260,2300 )
oPrint:Line (nRow2+1330,1800,nRow2+1330,2300 )
oPrint:Line (nRow2+1400,100 ,nRow2+1400,2300 )
oPrint:Line (nRow2+1640,100 ,nRow2+1640,2300 )


/******************/
/* TERCEIRA PARTE */
/******************/

nRow3 := 0

For nI := 100 to 2300 step 50
	oPrint:Line(nRow3+1880, nI, nRow3+1880, nI+30)
Next nI

oPrint:Line (nRow3+2000,100,nRow3+2000,2300)
oPrint:Line (nRow3+2000,500,nRow3+1920, 500)
oPrint:Line (nRow3+2000,710,nRow3+1920, 710)

oPrint:Say  (nRow3+1934,100,aDadosBanco[2],oFont12 )		// 	[2]Nome do Banco //20080609 era oFont14
oPrint:Say  (nRow3+1925,513,aDadosBanco[1]+"-7",oFont21 )	// 	[1]Numero do Banco
oPrint:Say  (nRow3+1934,755,aCB_RN_NN[2],oFont15n)			//		Linha Digitavel do Codigo de Barras

oPrint:Line (nRow3+2100,100,nRow3+2100,2300 )
oPrint:Line (nRow3+2200,100,nRow3+2200,2300 )
oPrint:Line (nRow3+2270,100,nRow3+2270,2300 )
oPrint:Line (nRow3+2340,100,nRow3+2340,2300 )

oPrint:Line (nRow3+2200,500 ,nRow3+2340,500 )
oPrint:Line (nRow3+2270,750 ,nRow3+2340,750 )
oPrint:Line (nRow3+2200,1000,nRow3+2340,1000)
oPrint:Line (nRow3+2200,1300,nRow3+2270,1300)
oPrint:Line (nRow3+2200,1480,nRow3+2340,1480)

oPrint:Say  (nRow3+2000,100 ,"Local de Pagamento",oFont8)
oPrint:Say  (nRow2+2030,100 ,Alltrim(aDadosBanco[3]+"-"+aDadosBanco[5]),oFont10) //novo: Danilo C S Pala 20080521
oPrint:Say  (nRow3+2015,400 ,"AT� O VENCIMENTO PAG�VEL EM QUALQUER BANCO",oFont10)  //Danilo C S Pala 20080521
oPrint:Say  (nRow3+2055,400 ,"AP�S O VENCIMENTO PAG�VEL APENAS NO BANCO ITAU",oFont10) //Danilo C S Pala 20080521

oPrint:Say  (nRow3+2000,1810,"Vencimento",oFont8)
cString := StrZero(Day(aDadosTit[4]),2) +"/"+ StrZero(Month(aDadosTit[4]),2) +"/"+ Right(Str(Year(aDadosTit[4])),4)
nCol	 	 := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow3+2040,nCol,cString,oFont11c)

oPrint:Say  (nRow3+2100,100 ,"Cedente",oFont8)
oPrint:Say  (nRow3+2140,100 ,aDadosEmp[1]+"                  - "+aDadosEmp[6]	,oFont10) //Nome + CNPJ

oPrint:Say  (nRow3+2100,1810,"Ag�ncia/C�digo Cedente",oFont8)
cString := Alltrim(aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5])
nCol 	 := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow3+2140,nCol,cString ,oFont11c)


oPrint:Say  (nRow3+2200,100 ,"Data do Documento"                              ,oFont8)
oPrint:Say (nRow3+2230,100, StrZero(Day(aDadosTit[2]),2) +"/"+ StrZero(Month(aDadosTit[2]),2) +"/"+ Right(Str(Year(aDadosTit[2])),4), oFont10)


oPrint:Say  (nRow3+2200,505 ,"Nro.Documento"                                  ,oFont8)
oPrint:Say  (nRow3+2230,605 ,aDadosTit[7]+aDadosTit[1]						,oFont10) //Prefixo +Numero+Parcela
// Alterado por Adriano Oliveira em 04/06/07 para impressao no numero da NF Eletronica
//oPrint:Say  (nRow3+2230,605 ,aDadosTit[11]						,oFont10) //Numero da NF Eletronica

oPrint:Say  (nRow3+2200,1005,"Esp�cie Doc."                                   ,oFont8)
oPrint:Say  (nRow3+2230,1050,"DM"										,oFont10) //Tipo do Titulo  aDadosTit[8]

oPrint:Say  (nRow3+2200,1305,"Aceite"                                         ,oFont8)
oPrint:Say  (nRow3+2230,1400,"N"                                             ,oFont10)

oPrint:Say  (nRow3+2200,1485,"Data do Processamento"                          ,oFont8)
oPrint:Say  (nRow3+2230,1550,StrZero(Day(aDadosTit[3]),2) +"/"+ StrZero(Month(aDadosTit[3]),2) +"/"+ Right(Str(Year(aDadosTit[3])),4)                               ,oFont10) // Data impressao


oPrint:Say  (nRow3+2200,1810,"Nosso N�mero"                                   ,oFont8)
cString := Alltrim(Substr(aDadosTit[6],1,3)+"/"+Substr(aDadosTit[6],4))
nCol 	 := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow3+2230,nCol,cString,oFont11c)


oPrint:Say  (nRow3+2270,100 ,"Uso do Banco"                                   ,oFont8)

oPrint:Say  (nRow3+2270,505 ,"Carteira"                                       ,oFont8)
oPrint:Say  (nRow3+2300,555 ,aDadosBanco[6]                                  	,oFont10)

oPrint:Say  (nRow3+2270,755 ,"Esp�cie"                                        ,oFont8)
oPrint:Say  (nRow3+2300,805 ,"R$"                                             ,oFont10)

oPrint:Say  (nRow3+2270,1005,"Quantidade"                                     ,oFont8)
oPrint:Say  (nRow3+2270,1485,"Valor"                                          ,oFont8)

oPrint:Say  (nRow3+2270,1810,"Valor do Documento"                          	,oFont8)
cString := Alltrim(Transform(aDadosTit[5],"@E 99,999,999.99"))
nCol 	 := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow3+2300,nCol,cString,oFont11c)

oPrint:Say  (nRow3+2340,100 ,"Instru��es (Todas informa��es deste bloqueto s�o de exclusiva responsabilidade do cedente)",oFont8)
/* Danilo C S Pala 20080521: daqui
oPrint:Say  (nRow3+2440,100 ,aBolText[1],oFont10)
if cmulta > 0
oPrint:Say  (nRow3+2490,100 ,aBolText[2],oFont10)
endif
oPrint:Say  (nRow3+2540,100 ,aBolText[3],oFont10)
oPrint:Say  (nRow3+2590,100 ,aBolText[4],oFont10)
*/
For nCont:=1 to Len(aBolText)
	oPrint:Say  (nRow2+2340+(nCont*50),100 ,aBolText[nCont],oFont10)
Next //20080521: Danilo C S Pala: ate aqui

oPrint:Say  (nRow3+2340,1810,"(-)Desconto/Abatimento"                         ,oFont8)
oPrint:Say  (nRow3+2410,1810,"(-)Outras Dedu��es"                             ,oFont8)
oPrint:Say  (nRow3+2480,1810,"(+)Mora/Multa"                                  ,oFont8)
oPrint:Say  (nRow3+2550,1810,"(+)Outros Acr�scimos"                           ,oFont8)
oPrint:Say  (nRow3+2620,1810,"(=)Valor Cobrado"                               ,oFont8)

oPrint:Say  (nRow3+2690,100 ,"Sacado"                                         ,oFont8)
oPrint:Say  (nRow3+2700,400 ,aDatSacado[1]+" ("+aDatSacado[2]+")"             ,oFont10)

if len(alltrim(aDatSacado[7])) > 11 //aDatSacado[8] = "J"
	oPrint:Say  (nRow3+2700,1750,"CNPJ: "+TRANSFORM(aDatSacado[7],"@R 99.999.999/9999-99"),oFont10) // CGC
Else
	oPrint:Say  (nRow3+2700,1750,"CPF: "+TRANSFORM(aDatSacado[7],"@R 999.999.999-99"),oFont10) 	// CPF
EndIf

oPrint:Say  (nRow3+2753,400 ,aDatSacado[3]                                    ,oFont10)
oPrint:Say  (nRow3+2806,400 ,substr(aDatSacado[6],1,5)+"-"+substr(aDatSacado[6],6,3) +"    "+aDatSacado[4]+" - "+aDatSacado[5],oFont10) // CEP+Cidade+Estado
oPrint:Say  (nRow3+2806,1750,Substr(aDadosTit[6],1,3)+Substr(aDadosTit[6],4)  ,oFont10)

oPrint:Say  (nRow3+2815,100 ,"Sacador/Avalista"                               ,oFont8)
oPrint:Say  (nRow3+2855,1500,"Autentica��o Mec�nica - Ficha de Compensa��o"                        ,oFont8)

oPrint:Line (nRow3+2000,1800,nRow3+2690,1800 )
oPrint:Line (nRow3+2410,1800,nRow3+2410,2300 )
oPrint:Line (nRow3+2480,1800,nRow3+2480,2300 )
oPrint:Line (nRow3+2550,1800,nRow3+2550,2300 )
oPrint:Line (nRow3+2620,1800,nRow3+2620,2300 )
oPrint:Line (nRow3+2690,100 ,nRow3+2690,2300 )

oPrint:Line (nRow3+2850,100,nRow3+2850,2300  )

//habilidado em 23/03/07 - Cfe. Sol. Bianca - Suporte interno Carol - alterado Andre Salgado
//MSBAR("INT25",25.5,1,aCB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.5,Nil,Nil,"A",.F.)

//MSBAR("INT25",13.5,0.9,aCB_RN_NN[1],oPrint,.F.,Nil,Nil,0.023,1.5,Nil,Nil,"A",.F.)

MSBAR3("INT25",25,1.0,aCB_RN_NN[1],oPrint,.F.,,,,1.2,,,,.f.)

// Danilo Pala: teste 20080516
DbSelectArea("SE1")
RecLock("SE1",.f.)
SE1->E1_NUMBCO 	:=	cNroDoc + cDigDoc //subs(aCB_RN_NN[3],4,8)+subs(aCB_RN_NN[3],13,1)   // Nosso n�mero (Ver f�rmula para calculo) //20101014 //20101108
//SE1->E1_PORTADO := Alltrim(aDadosBanco[1])      // banco...
//SE1->E1_AGEDEP  := Alltrim(aDadosBanco[3])      // agencia...
//SE1->E1_CONTA   := Alltrim(aDadosBanco[4]+aDadosBanco[5])      // conta corrente
SE1->E1_BOLEM   := "S"
SE1->E1_SITUACA := "1"
SE1->E1_OBS     := Iif( _nDescon > 0, "DESCONTO R$ "+Alltrim(Str(_nDescon,10,2)), SE1->E1_OBS )
MsUnlock()                    
 //Danilo Pala: teste 20080516

oPrint:EndPage() // Finaliza a p�gina

Return Nil

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � Modulo10 � Autor � Microsiga             � Data � 13/10/03 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � IMPRESSAO DO BOLETO LASE DO ITAU COM CODIGO DE BARRAS      ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para Clientes Microsiga                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function Modulo10(cData)
LOCAL L,D,P := 0
LOCAL B     := .F.
L := Len(cData)
B := .T.
D := 0
While L > 0
	P := Val(SubStr(cData, L, 1))
	If (B)
		P := P * 2
		If P > 9
			P := P - 9
		End
	End
	D := D + P
	L := L - 1
	B := !B
End
D := 10 - (Mod(D,10))
If D = 10
	D := 0
End
Return(D)

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � Modulo11 � Autor � Microsiga             � Data � 13/10/03 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � IMPRESSAO DO BOLETO LASER DO ITAU COM CODIGO DE BARRAS     ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para Clientes Microsiga                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function Modulo11(cData)
LOCAL L, D, P := 0
L := Len(cdata)
D := 0
P := 1
While L > 0
	P := P + 1
	D := D + (Val(SubStr(cData, L, 1)) * P)
	If P = 9
		P := 1
	End
	L := L - 1
End
D := 11 - (mod(D,11))
If (D == 0 .Or. D == 1 .Or. D == 10 .Or. D == 11)
	D := 1
End
Return(D)


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �Ret_cBarra� Autor � Microsiga             � Data � 13/10/03 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � IMPRESSAO DO BOLETO LASE DO ITAU COM CODIGO DE BARRAS      ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para Clientes Microsiga                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function Ret_cBarra(cBanco,cAgencia,cConta,cDacCC,cNroDoc,nValor,dVencto)

LOCAL cValorFinal := strzero(int(nValor*100),10)
LOCAL nDvnn			:= 0
LOCAL nDvcb			:= 0
LOCAL nDv			:= 0
LOCAL cNN			:= ''
LOCAL cRN			:= ''
LOCAL cCB			:= ''
LOCAL cS			:= ''
LOCAL cFator      := strzero(dVencto - ctod("07/10/97"),4)
LOCAL cCart			:= Alltrim(MV_PAR20) //***passado por parametro "109" 20080521
LOCAL cMoeda		:= '9' //real = 9
cMoeda := Subs(cBanco,4,1) 

//-----------------------------
// Definicao do NOSSO NUMERO
// ----------------------------
 
/*IF mv_par19 == 2
	cCart:= Alltrim(Str(Val(Substr(cCart,1,1)+1)))+Substr(cCart,2,2)
EndIf */

cS    := alltrim(cAgencia) + alltrim(cConta) + alltrim(cCart) + alltrim(cNroDoc)
nDvnn := modulo10(cS) // digito verifacador Agencia + Conta + Carteira + Nosso Num //comentado danilo c s pala  20080605
cNN   := cCart + cNroDoc + '-' + AllTrim(Str(nDvnn))
cDigDoc := alltrim(str(nDvnn)) //20101108 digito gerado

//----------------------------------
//	 Definicao do CODIGO DE BARRAS
//----------------------------------
cS:= cBanco + cFator +  cValorFinal + Subs(cNN,1,11) + Subs(cNN,13,1) + alltrim(cAgencia) + alltrim(cConta) + alltrim(cDacCC) + '000'
nDvcb := modulo11(cS)
cCB   := SubStr(cS, 1, 4) + AllTrim(Str(nDvcb)) + SubStr(cS,5,25) + AllTrim(Str(nDvnn))+ SubStr(cS,31)

//cCB := "34191" + cFator +  cValorFinal + Subs(cNN,1,11) + alltrim(Str(nDvnn)) + alltrim(cAgencia) + alltrim(cConta) + alltrim(cDacCC) + '000' //danilo c s pala 20080605
cCB := Subs(cBanco,1,3) + cMoeda + AllTrim(Str(nDvcb)) + cFator +  cValorFinal + Subs(cNN,1,11) + alltrim(Str(nDvnn)) + alltrim(cAgencia) + alltrim(cConta) + alltrim(cDacCC) + "000" //danilo c s pala 20080605

//nDvcb := modulo11(cS)
//cCB   := SubStr(cS, 1, 4) + AllTrim(Str(nDvcb)) + SubStr(cS,5,25) + AllTrim(Str(nDvnn))+ SubStr(cS,31)


//-------- Definicao da LINHA DIGITAVEL (Representacao Numerica)
//	Campo 1			Campo 2			Campo 3			Campo 4		Campo 5
//	AAABC.CCDDX		DDDDD.DDFFFY	FGGGG.GGHHHZ	K			UUUUVVVVVVVVVV

// 	CAMPO 1:
//	AAA	= Codigo do banco na Camara de Compensacao
//	  B = Codigo da moeda, sempre 9
//	CCC = Codigo da Carteira de Cobranca
//	 DD = Dois primeiros digitos no nosso numero
//	  X = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo

cS    := cBanco + cCart + SubStr(cNroDoc,1,2)
nDv   := modulo10(cS)
cRN   := SubStr(cS, 1, 5) + '.' + SubStr(cS, 6, 4) + AllTrim(Str(nDv)) + '  '      

// 	CAMPO 2:
//	DDDDDD = Restante do Nosso Numero
//	     E = DAC do campo Agencia/Conta/Carteira/Nosso Numero
//	   FFF = Tres primeiros numeros que identificam a agencia
//	     Y = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo

cS :=Subs(cNN,6,6) + Alltrim(Str(nDvnn))+ alltrim(Subs(cAgencia,1,3))
nDv:= modulo10(cS)
//cRN := Subs(cBanco,1,3) + "9" + Subs(cCart,1,1)+'.'+ Subs(cCart,2,3) + Subs(cNN,4,2) + SubStr(cRN,11,1)+ ' '+  Subs(cNN,6,5) +'.'+ Subs(cNN,11,1) + Alltrim(Str(nDvnn))+ Subs(cAgencia,1,3) +Alltrim(Str(nDv)) + ' '   //danilo c s pala 20080605
cRN := Subs(cBanco,1,3) + cMoeda + Subs(cCart,1,1)+'.'+ Subs(cCart,2,3) + Subs(cNN,4,2) + SubStr(cRN,11,1)+ ' '+  Subs(cNN,6,5) +'.'+ Subs(cNN,11,1) + Alltrim(Str(nDvnn))+ Subs(cAgencia,1,3) +Alltrim(Str(nDv)) + ' ' //danilo c s pala 20080605

// 	CAMPO 3:
//	     F = Restante do numero que identifica a agencia
//	GGGGGG = Numero da Conta + DAC da mesma
//	   HHH = Zeros (Nao utilizado)
//	     Z = DAC que amarra o campo, calculado pelo Modulo 10 da String do campo
cS    := Subs(cAgencia,4,1) + Subs(cConta,1,4) +  Subs(cConta,5,1)+Alltrim(cDacCC)+'000'
nDv   := modulo10(cS)
cRN   := cRN + Subs(cAgencia,4,1) + Subs(cConta,1,4) +'.'+ Subs(cConta,5,1)+Alltrim(cDacCC)+'000'+ Alltrim(Str(nDv))

//	CAMPO 4:
//	     K = DAC do Codigo de Barras
cRN   := cRN + ' ' + AllTrim(Str(nDvcb)) + '  '

// 	CAMPO 5:
//	      UUUU = Fator de Vencimento
//	VVVVVVVVVV = Valor do Titulo
cRN   := cRN + cFator + StrZero(Int(nValor * 100),14-Len(cFator))

cNN   := cCart + cNroDoc + '-' + AllTrim(Str(nDvnn))

//bloco1 := "3419"+cCart + SubStr(cNroDoc,1,2) "3419109" + SubStr(cNroDoc,1,2) 20080521 //danilo c s pala 20080605
bloco1 := Subs(cBanco,1,3) + cMoeda + cCart + SubStr(cNroDoc,1,2) //danilo c s pala 20080605
bloco1 += StrZero(modulo10(bloco1),1)
bloco1 := SubStr(bloco1,1,5) + "." + SubStr(bloco1,6,5) + " "

bloco2 := SubStr(cNroDoc,3,6) + StrZero(modulo10(Subs(cAgencia,1,4)+Subs(cConta,1,5)+cCart+SubStr(cNroDoc,1,8)),1) + Subs(cAgencia,1,3) //SubStr(cNroDoc,3,6) + StrZero(modulo10(Subs(cAgencia,1,4)+Subs(cConta,1,5)+"109"+SubStr(cNroDoc,1,8)),1) + Subs(cAgencia,1,3) //20080521
bloco2 += StrZero(modulo10(bloco2),1)
bloco2 := SubStr(bloco2,1,5) + "." + SubStr(bloco2,6,6) + " "

bloco3 := Subs(cAgencia,4,1) + Subs(cConta,1,6) + cDacCC + "000" //20080605 era "0" no lugar de cDacCC
bloco3 += StrZero(modulo10(bloco3),1)
bloco3 := SubStr(bloco3,1,5) + "." + SubStr(bloco3,6,6) + " "

/*//bloco4 := "3419" + cFator + cValorFinal + cCart + SubStr(cNroDoc,1,8) //"3419" + cFator + cValorFinal + "109" + SubStr(cNroDoc,1,8) //20080521  // danilo c s pala 20080605
bloco4 := Subs(cBanco,1,3) + cMoeda + cFator + cValorFinal + cCart + SubStr(cNroDoc,1,8) // danilo c s pala 20080605
bloco4 += StrZero(modulo10(cCart+SubStr(cNroDoc,1,8)),1) //StrZero(modulo10("109"+SubStr(cNroDoc,1,8)),1) //20080521
bloco4 += Subs(cAgencia,1,4) + Subs(cConta,1,5) + cDacCC + "000"  //20080605 era "0" no lugar de cDacCC
bloco4 := StrZero(Modulo11(bloco4),1) + " "*/ //Danilo c S Pala em 20080609: comentado, pois ja foi calculado acima
bloco4 := StrZero(nDvcb,1)+" " //Danilo c S Pala em 20080609: pegar que ja foi calculado acima

bloco5 := cFator + cValorFinal

cRN := bloco1 + bloco2 + bloco3 + bloco4 + bloco5

Return({cCB,cRN,cNN})


/*/
���������������������������������������������������������������������������������
�����������������������������������������������������������������������������Ŀ��
���Fun��o    � AjustaSx1    � Autor � Microsiga            	� Data � 13/10/03 ���
�����������������������������������������������������������������������������Ĵ��
���Descri��o � Verifica/cria SX1 a partir de matriz para verificacao          ���
�����������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para Clientes Microsiga                    	  		���
������������������������������������������������������������������������������ٱ�
���������������������������������������������������������������������������������
����������������������������������������������������������������������������������
/*/
Static Function AjustaSX1(cPerg, aPergs)

Local _sAlias	:= Alias()
Local aCposSX1	:= {}
Local nX 		:= 0
Local lAltera	:= .F.
Local nCondicao
Local cKey		:= ""
Local nJ			:= 0
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aCposSX1:={"X1_PERGUNT","X1_PERSPA","X1_PERENG","X1_VARIAVL","X1_TIPO","X1_TAMANHO",;
			"X1_DECIMAL","X1_PRESEL","X1_GSC","X1_VALID",;
			"X1_VAR01","X1_DEF01","X1_DEFSPA1","X1_DEFENG1","X1_CNT01",;
			"X1_VAR02","X1_DEF02","X1_DEFSPA2","X1_DEFENG2","X1_CNT02",;
			"X1_VAR03","X1_DEF03","X1_DEFSPA3","X1_DEFENG3","X1_CNT03",;
			"X1_VAR04","X1_DEF04","X1_DEFSPA4","X1_DEFENG4","X1_CNT04",;
			"X1_VAR05","X1_DEF05","X1_DEFSPA5","X1_DEFENG5","X1_CNT05",;
			"X1_F3", "X1_GRPSXG", "X1_PYME","X1_HELP" }

dbSelectArea("SX1")
dbSetOrder(1)
For nX:=1 to Len(aPergs)
	lAltera := .F.
	If MsSeek(cPerg+Right(aPergs[nX][11], 2))
		If (ValType(aPergs[nX][Len(aPergs[nx])]) = "B" .And.;
			 Eval(aPergs[nX][Len(aPergs[nx])], aPergs[nX] ))
			aPergs[nX] := ASize(aPergs[nX], Len(aPergs[nX]) - 1)
			lAltera := .T.
		Endif
	Endif
	
	If ! lAltera .And. Found() .And. X1_TIPO <> aPergs[nX][5]	
 		lAltera := .T.		// Garanto que o tipo da pergunta esteja correto
 	Endif	
	
	If ! Found() .Or. lAltera
		RecLock("SX1",If(lAltera, .F., .T.))
		Replace X1_GRUPO with cPerg
		Replace X1_ORDEM with Right(aPergs[nX][11], 2)
		For nj:=1 to Len(aCposSX1)
			If 	Len(aPergs[nX]) >= nJ .And. aPergs[nX][nJ] <> Nil .And.;
				FieldPos(AllTrim(aCposSX1[nJ])) > 0
				Replace &(AllTrim(aCposSX1[nJ])) With aPergs[nx][nj]
			Endif
		Next nj
		MsUnlock()
		cKey := "P."+AllTrim(X1_GRUPO)+AllTrim(X1_ORDEM)+"."

		If ValType(aPergs[nx][Len(aPergs[nx])]) = "A"
			aHelpSpa := aPergs[nx][Len(aPergs[nx])]
		Else
			aHelpSpa := {}
		Endif
		
		If ValType(aPergs[nx][Len(aPergs[nx])-1]) = "A"
			aHelpEng := aPergs[nx][Len(aPergs[nx])-1]
		Else
			aHelpEng := {}
		Endif

		If ValType(aPergs[nx][Len(aPergs[nx])-2]) = "A"
			aHelpPor := aPergs[nx][Len(aPergs[nx])-2]
		Else
			aHelpPor := {}
		Endif

		PutSX1Help(cKey,aHelpPor,aHelpEng,aHelpSpa)
	Endif
Next
Return