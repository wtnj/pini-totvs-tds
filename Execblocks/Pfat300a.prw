#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 21/03/02
/*/ Alterado por Danilo C S PAla em 20040217 para subtrair os valores retidos de Cofins, PIs e CSLL, alem do IRRf
//DANILO C S PALA 20080213: INCLUSAO DO MV_ITAULOC
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤└o    Ё PFAT300A Ё Autor Ё Alex Egydio           Ё Data Ё 26.05.98 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤└o Ё Processa informacoes para geracao do Boleto Itau           Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё PFAT200  (SEAL/EDITORA PINI)                               Ё╠╠
╠╠цддддддддддеддддддддддддддддддддддддддддддддддддддддддбддддддбдддддддддд╢╠╠
╠╠Ё Revis└o  Ё                                          Ё Data Ё          Ё╠╠
╠╠юддддддддддаддддддддддддддддддддддддддддддддддддддддддаддддддадддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
User Function Pfat300a()        // incluido pelo assistente de conversao do AP5 IDE em 21/03/02

SetPrvt("_CRETALIAS,_NRETRECNO,_NRETORDER,_CALERTA,_CNRCTRL,_CARQUIVO")
SetPrvt("_CPATHITAU,_NJUROS,_NMULTA1,_CTRAB,_CSERIE,_CMSGAVISO,_CMSGERROR")
SetPrvt("_CFAXATU,LBARRA,_CCAMPO1,_CCAMPO2,_CCAMPO3,CDACCONTA")
SetPrvt("CDACNOSSO,_CCART,_NDIAS,_NDESCON,NDIGCODBAR,_CVALOR")
SetPrvt("CCODBARRA,_CCPO1AUX,_CCPO2AUX,_CCPO3AUX,_CCPO,NA")
SetPrvt("AMULTIPLIC,NSOMA,NB,_CCAMPO,ABASENUM,NMULTIPLIC")
SetPrvt("NC,NALGARISM1,NALGARISM2,NRESTO,NDIGITO,CCODIGO")
SetPrvt("NPESO,_ENDCOB,_BAICOB,_CEPCOB,_MUNCOB,_ESTCOB")
SetPrvt("_N,CITAULOC, _cPathItau, CDISCO")

_cRetAlias:= Alias()
_nRetRecno:= Recno()
_nRetOrder:= IndexOrd()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё SEE - Comunica┤фo Remota p/guardar a Faixa Atual             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
DbSelectArea("SEE")
DbSetOrder(1)
DbSeek(xFilial("SEE")+MV_PAR01+MV_PAR02+MV_PAR03)

If EOF()
	Help("",1,"NAOFAIXA")
	DbSelectArea(_cRetAlias)
	DbSetOrder(_nRetOrder)
	DbGoto(_nRetRecno)
	Return
Endif

IF ALLTRIM(SEE->EE_NUMBCO) == "999"
	_cAlerta:= 'ATENCAO : A numeracao sequencial dos arquivos atingiu o limite (999) !!'
	_cAlerta:= _cAlerta+' Verifique no arquivo de Configuracao de CNABS o campo "Sequencial" '
	Alert( _cAlerta )
	DbSelectArea(_cRetAlias)
	DbSetOrder(_nRetOrder)
	DbGoto(_nRetRecno)
	Return
ENDIF

_cNrCtrl:= StrZero(Val(SEE->EE_NUMBCO)+1,3)

RecLock("SEE",.F.)
SEE->EE_NUMBCO:= _cNrCtrl
DbCommit()
MsUnLock()

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Seleciona Ordem dos Arquivos                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
DbSelectArea("SE1")
DbSetOrder(1)
DbSelectArea("SA1")
DbSetOrder(1)

//
// GILBERTO - 18/10/2000 P/ ED. PINI
//
//_cArquivo := Subs(cUsuario,7,3)+"0"+AllTrim(MV_PAR01)+".341"

_cPathItau:= Alltrim( GETMV("MV_ITAU") )
_cArquivo := SubS(cUsuario,7,3)
_cArquivo := _cArquivo+SM0->M0_CODIGO
_cArquivo := _cArquivo+_cNrCtrl
_cArquivo := _cArquivo+".341"

_nJuros   := MV_PAR08

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё SF2 - Cabecalho de NF de Saida                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

DbSelectArea("SF2")
DbSetOrder(1)
DbSeek(xFilial("SF2")+mv_par05,.T.)

If SF2->F2_DOC > MV_PAR06    //.OR. SF2->F2_SERIE #MV_PAR07
	MsgAlert("Nao foram encontrados Notas Fiscais para Impressao !! Verifique ...","Aten┤└o!")
	DbSelectArea(_cRetAlias)
	DbSetOrder(_nRetOrder)
	DbGoto(_nRetRecno)
	Return
EndIf

ProcRegua( RecCount() )

_cTrab := FCreate(_cArquivo)

While !Eof() .And. SF2->F2_DOC <= MV_PAR06
	IncProc()
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Identifica a serie da nota                                   Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If SF2->F2_SERIE #MV_PAR07           // Se a Serie do Arquivo for Diferente
		DbSkip()                           // do Parametro Informado !!!
		Loop
	Endif
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё SE1 - Contas a Receber                                       Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	_cSerie:= MV_PAR07
	DbSelectArea("SE1")
	DbSetOrder(1)
	DbSeek(xFilial("SE1")+_cSerie+SF2->F2_DOC)
	While !Eof() .And. SE1->E1_FILIAL+SE1->E1_NUM == xFilial("SE1")+SF2->F2_DOC
		
		If Alltrim(SE1->E1_TIPO)!="NF" .Or. SE1->E1_PREFIXO!=_cSerie
			DbSelectArea("SE1")
			DbSkip()
			Loop
		Endif
		
		IF !EMPTY(SE1->E1_BAIXA) .And.  SE1->E1_SALDO == 0
			DbSelectArea("SE1")
			DbSkip()
			Loop
		ENDIF
		
		If SE1->E1_VENCTO < mv_par12 .or. SE1->E1_VENCTO > mv_par13
			DbSelectArea("SE1")
			DbSkip()
			Loop
		Endif
		
		IF MV_PAR10 <> "."
			IF !(SE1->E1_PARCELA $ MV_PAR10 )
				DbSelectArea("SE1")
				DbSkip()
				Loop
			ENDIF
		ENDIF
		
		IF SE1->E1_SITUACA #"0"
			_cMsgAviso := "Aten┤фo: O titulo " + SE1->E1_NUM + SE1->E1_PARCELA + " " + SE1->E1_SERIE
			_cMsgAviso += " esta fora de CARTEIRA, transferido para o Banco " + Alltrim(SE1->E1_PORTADO) + "."
			_cMsgAviso += " Para reemitir esse boleto solicite a cobran┤a que transfira o "
			_cMsgAviso += " titulo para carteira."

			MsgInfo( OemToAnsi(_cMsgAviso ) )

			DbSelectArea("SE1")
			DbSkip()
			Loop
		ENDIF
		
		// Verifica se ja foi emitido boleto para esse titulo por
		// Outro Banco.
		If SE1->E1_BOLEM == "S"
			If AllTrim(SE1->E1_PORTADO) # AllTrim( MV_PAR01 )
				If AllTrim(SE1->E1_PORTADO) # "CX1" .AND. !Empty(SE1->E1_PORTADO)
					DbSelectArea("SA6")
					If dbSeek(xFilial("SA6")+SE1->E1_PORTADO)
						_cMsgError := "Ja foi Emitido Boleto para esse Titulo !!!"
						_cMsgError += "Titulo " + SE1->E1_NUM + " Parcela " + SE1->E1_PARCELA + " da Serie " + _cSerie
						_cMsgError += " com Boleto Emitido para o Banco : "
						_cMsgError += Alltrim(SE1->E1_PORTADO) + " Agencia : " + SE1->E1_AGEDEP + " Cta. Corrente : "
						_cMsgError += SE1->E1_CONTA
						_cMsgError += " Por favor, para esse t║tulo entre no Banco Correspondente..."

						MsgAlert(OemToAnsi(_cMsgError),OemToAnsi("Aten┤фo"))

						//*DBSELECTAREA("SE1")
						//*DBSKIP()
						//*LOOP
					EndIf
				Endif
			Endif
		Endif
		
		DbSelectArea("SC5")
		//DbSetOrder(5)
		//DbSeek(xFilial("SC5")+SF2->F2_DOC+_cSerie)
		DbSetOrder(1)
		DbSeek(xFilial("SC5")+SE1->E1_PEDIDO)
		/*
		IF ALLTRIM(SC5->C5_DIVVEN) == "PUBL"
			DbSelectArea("SE1")
			DbSkip()
			Loop
		ENDIF
		*/ // bOLOCO RETIRADO PARA EMISSAO DE BOLETOS DE PUBLICIDADE NA PINIWEB - Marcos - 29.04.02
		If Found()
			DbSelectArea("SZ9")
			DbSetOrder(1)
			DbSeek(xFilial("SZ9")+SC5->C5_TIPOOP)
			
			If SZ9->Z9_QTDEP == 0
				DbSelectArea("SE1")
				DbSkip()
				Loop
			EndIf
			If SZ9->Z9_QTDEP == 1
				If SE1->E1_PARCELA == "A" .Or. SE1->E1_PARCELA == " "
					If SZ9->Z9_BOLETO1 == "N" .OR. SZ9->Z9_BOLETO1 == " "
						DbSelectArea("SE1")
						DbSkip()
						Loop
					EndIf
				EndIf
				
			Else
				If SE1->E1_PARCELA == "A" .Or. SE1->E1_PARCELA == " "
					If SZ9->Z9_BOLETO1 == "N" .OR. SZ9->Z9_BOLETO1 == " "
						DbSelectArea("SE1")
						DbSkip()
						Loop
					EndIf
				 
				Else
					If SZ9->Z9_BOLETOD == "N" .OR. SZ9->Z9_BOLETOD == " "
						DbSelectArea("SE1")
						DbSkip()
						Loop
					EndIf
				Endif
				 
			Endif
		Else
	  		 
			DbSelectArea("SE1")
			DbSkip()
			Loop
		EndIf
		
		DbSelectArea("SE1")
		
		// _cTrab:=FCreate(_cArquivo)
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Preserva o nosso numero caso ja emitido                      Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		
		If !Empty(SE1->E1_NUMBCO)
			_cFaxAtu := Left(Alltrim(SE1->E1_NUMBCO),8)
		Else
			//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
			//Ё SEE - Cominicacao Remota p/guardar a Faixa Atual             Ё
			//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
			dbSelectArea("SEE")
			dbSetOrder(1)
			dbSeek(xFilial("SEE")+mv_par01+mv_par02+mv_par03)
			If !Eof()
				_cFaxAtu := Left(Alltrim(SEE->EE_FAXATU),8)
				dbSelectArea("SEE")
				RecLock("SEE",.F.)
				SEE->EE_FAXATU := StrZero(Val(_cFaxAtu)+1,8)
				MsUnLock()
			Endif
		Endif
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Calcula o Digito de Auto Conferencia                         Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		lBarra   := .F.
		_cCampo1 := Left(SEE->EE_AGENCIA,4) + Left(SEE->EE_CONTA,5)
		_cCampo2 := Left(SEE->EE_AGENCIA,4) + Left(SEE->EE_CONTA,5) + Alltrim(mv_par04)            // Agencia + Conta + Carteira
		_cCampo3 := Left(SEE->EE_AGENCIA,4) + Left(SEE->EE_CONTA,5) + Alltrim(mv_par04) + _cFaxAtu // Agencia + Conta + Carteira + Nosso Numero
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Calcula o D.A.C. (Digito de Auto-Conferencia) do nosso numero.        Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		A020Dig1()
		cDacConta := Right(_cCampo1,1)
		cDacNosso := Right(_cCampo3,1)
		
		_cCart   := MV_PAR04
		_nDias   := iif(Empty(mv_par11),10,mv_par11)
		_nJuros  := MV_PAR08
		_nMulta1 := MV_PAR14
		_nDescon := MV_PAR09
		
		//имммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╩
		//╨ INFORMACOES DO RECIBO DO SACADO                              ╨
		//лмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧
		//╨ PRIMEIRA LINHA                                               ╨
		//хмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪
		ExecBlock("A300DET",.F.,.F.)
	
		//имммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╩
		//╨ INFORMACOES DA FICHA DE CAIXA                                ╨
		//лмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧
		//╨ PRIMEIRA LINHA                                               ╨
		//хмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪
		ExecBlock("A300DET",.F.,.F.)
		
		//имммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╩
		//╨ INFORMACOES DO CODIGO DE BARRAS !!!!                         ╨
		//лмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧
		//╨ PRIMEIRA LINHA                                               ╨
		//хмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪
		nDigCodBar := 0
		_cValor    := Transform((SE1->E1_VALOR - (SE1->E1_COFINS + SE1->E1_CSLL + SE1->E1_PIS + SE1->E1_IRRF)), "@EZ 999999999999.99") //20040217
		cCodBarra  := "3419"+ Subs(_cValor,1,12) + Subs(_cValor,14,2)
		cCodBarra  += Left(SEE->EE_AGENCIA,4) + Left(SEE->EE_CONTA,5)
		cCodBarra  += cDacConta + alltrim(mv_par04) + _cFaxAtu + cDacNosso + "000"
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Calcula o D.A.C. (Digito de Auto-Conferencia) do Codigo de Barras.    Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		A020Dig2()
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Lay-Out do Codigo de Barras                                  Ё
		//Ё 01 - 04 : Banco                                              Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		lBarra    := .T.
		_cCpo1Aux := _cCampo1
		_cCpo2Aux := _cCampo2
		_cCpo3Aux := _cCampo3
		_cCampo1  := "3419" + LEFT(MV_PAR04,3) + LEFT(_cFaxAtu,2)
		_cCampo2  := Subs(_cFaxAtu,3,5) + Subs(_cFaxAtu,8,1) + cDacNosso + Left(SEE->EE_AGENCIA,3)
		_cCampo3  := Subs(SEE->EE_AGENCIA,4,1) + Subs(SEE->EE_CONTA,1,4) + Subs(SEE->EE_CONTA,5,1) + cDacConta + "000"
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Calcula o D.A.C. (Digito de Auto-Conferencia) do nosso numero.        Ё
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		A020Dig1()
		_cCpo := '"' + Left(_cCampo1,5) + '.' + Subs(_cCampo1,6,5) + '  '
		_cCpo += Left(_cCampo2,5) + '.' + Subs(_cCampo2,6,6) + '  '
		_cCpo += Left(_cCampo3,5) + '.' + Subs(_cCampo3,6,6) + '  ' + Str(nDigCodBar,1) + '  '
		_cCpo += Alltrim(Subs(_cValor,1,12)) + Subs(_cValor,14,2) + '",'
		_cCpo += '"3419' + Str(nDigCodBar,1) + Padl(Alltrim(Subs(_cValor,1,12)) + Subs(_cValor,14,2),14,"0")
		_cCpo += Alltrim(mv_par04) + _cFaxAtu + cDacNosso + Left(SEE->EE_AGENCIA,4) + Left(SEE->EE_CONTA,5)
		_cCpo += cDacConta + '000"' + Chr(13) + Chr(10)
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Grava      Codigo de Barras                                  Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		FWrite(_cTrab,_cCpo,Len(_cCpo))
		_cCampo1 := _cCpo1Aux
		_cCampo2 := _cCpo2Aux
		_cCampo3 := _cCpo3Aux
		
		//имммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╩
		//╨ INFORMACOES DO LAYOUT CODIGO DE BARRAS                       ╨
		//лмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧
		//╨ PRIMEIRA LINHA                                               ╨
		//хмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪
		ExecBlock("A300DET",.F.,.F.)
		
		//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Gravar Faixa Atual                                           Ё
		//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		DbSelectArea("SE1")
		RecLock("SE1",.F.)
		// criar see->ee_tipocob, c, 1
		// If SEE->EE_TIPOCOB=="S"                    // S = SEM REGISTRO
		SE1->E1_PORTADO:= Alltrim(mv_par01)      // banco...
		SE1->E1_AGEDEP := Alltrim(mv_par02)      // agencia...
		SE1->E1_CONTA  := Alltrim(mv_par03)      // conta corrente
		SE1->E1_BOLEM  := "S"
		SE1->E1_SITUACA:= "1"
		SE1->E1_OBS    := Iif( MV_PAR09 > 0, "DESCONTO R$ "+Alltrim(Str(MV_PAR09,10,2)), SE1->E1_OBS )
		// EndIf
		SE1->E1_NUMBCO := Alltrim(_cFaxAtu) + Alltrim(cDacNosso)
		MsUnLock()

		DbSelectArea("SE1")
		DbSkip()
	Enddo
	DbSelectArea("SF2")
	DbSkip()
Enddo

FClose(_cTrab)

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chamada externa para Impressa                                Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
/*
COPY FILE ("\SIGAADV\"+_cArquivo) TO (_cPathItau+_cArquivo)
WinExec(_cPathBol+_cPathItau+"IMPBLOQ "+_cArquivo)   
*/
cDisco := Alltrim(GetMV("MV_PATHBOL"))   
_cPathItau := Alltrim( GETMV("MV_ITAU") )                        
CITAULOC := Alltrim(GetMV("MV_ITAULOC")) //20080213
COPY FILE (_cArquivo) TO (_cPathItau+_cArquivo)
//WinExec(cDisco+_cPathItau+"IMPBLOQ "+_cArquivo,2 )  //20080213
WinExec(cDisco+CITAULOC+"IMPBLOQ "+_cArquivo,2 ) //20080213
Processa({|| GANHATEMPO()},"Gerando arquivo de boleto ...")
FErase(_cArquivo)

DbSelectArea(_cRetAlias)
DbSetOrder(_nRetOrder)
DbGoto(_nRetRecno)

Return
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддддбддддддбдддддддддддддддддддддддбддддддбддддддддд©╠╠
╠╠ЁFun┤└o    Ё A020Dig1   ЁAutor Ё Alex Egydio           Ё Data Ё28/05/98 Ё╠╠
╠╠цддддддддддеддддддддддддаддддддадддддддддддддддддддддддаддддддаддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Calcula o Digito Verificador dos 3 primeiros campos da     Ё╠╠
╠╠Ё          Ё Linha Digitavel.                                           Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё Especifico                                                 Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function A020Dig1()

nA := 0

For nA := 1 To 3
	aMultiplic := {}   // Resultado das Multiplicacoes de cada algarismo
	nSoma      := 0    // Somatoria total dos algarismos de cada Multiplicacao
	nB         := 0
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Identifica qual o Campo da Linha Digitavel que tera o Digito Verifi-  Ё
	//Ё cador calculado.                                                      Ё
	//Ё Define a Base Numerica de Multiplicacao.                              Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If nA == 1
			_cCampo := _cCampo1
			If	lBarra
				aBaseNum:={ 2, 1, 2, 1, 2, 1, 2, 1, 2}
			Else
				aBaseNum:={ 2, 1, 2, 1, 2, 1, 2, 1, 2 }
			Endif
	ElseIf nA == 2
			_cCampo := _cCampo2
			If	lBarra
				aBaseNum := { 1, 2, 1, 2, 1, 2, 1, 2, 1, 2 }
			Else
				aBaseNum := { 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2 }
			Endif
	ElseIf nA == 3
			_cCampo := _cCampo3
			If	lBarra
				aBaseNum := { 1, 2, 1, 2, 1, 2, 1, 2, 1, 2 }
			Else
				aBaseNum := { 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2 }
			Endif
	EndIf
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Multiplica cada algarismo do Campo por uma Base Numerica de 2 e 1,    Ё
	//Ё atribuidos alternadamente e de tras para a frente, a partir da Decima Ё
	//Ё (10.) posicao. O Resultado sera armazenado no Array aMultiplic.       Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	For nB := Len(_cCampo) To 1 Step -1
		nMultiplic := Val( Subs(_cCampo,nB,1) ) * aBaseNum[nB]
		Aadd(aMultiplic, StrZero(nMultiplic,2) )
	Next nB
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Soma os algarismos do Resultado de cada Multiplicacao, fazendo uma    Ё
	//Ё somatoria total.                                                      Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	For nC := 1 To Len(aMultiplic)
		nAlgarism1 := Val( Subs(aMultiplic[nC],1,1) )
		nAlgarism2 := Val( Subs(aMultiplic[nC],2,1) )
		nSoma      := nSoma + nAlgarism1 + nAlgarism2
	Next nC
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Divide a Somatoria Total por 10, armazenando o Resto da Divisao.      Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	nResto := nSoma % 10
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё O Resto da Divisao sera subtraido de 10, resultando no Digito.        Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If nResto >= 1 .And. nResto <= 10
		nDigito := 10 - nResto
	Else
		nDigito := 0
	EndIf
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Agrega o Digito ao campo da Linha Digitavel.                          Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If nA == 1
			_cCampo1 := _cCampo1 + Str(nDigito,1)
	ElseIf nA == 2
			_cCampo2 := _cCampo2 + Str(nDigito,1)
	ElseIf nA == 3
			_cCampo3 := _cCampo3 + Str(nDigito,1)
	EndIf
	
Next nA

Return(Nil)
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддддбддддддбдддддддддддддддддддддддбддддддбддддддддд©╠╠
╠╠ЁFun┤└o    Ё A020Dig2   ЁAutor Ё Alex Egydio           Ё Data Ё 28/05/98Ё╠╠
╠╠цддддддддддеддддддддддддаддддддадддддддддддддддддддддддаддддддаддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Calcula o D.A.C. (Digito de Auto Conferencia) do Codigo de Ё╠╠
╠╠Ё          Ё Barras.                                                    Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁUso       Ё Especifico                                                 Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function A020Dig2()

cCodigo    := "3419" + Subs(_cValor,1,12) + Subs(_cValor,14,2)
cCodigo    += alltrim(mv_par04) + _cFaxAtu + cDacNosso
cCodigo    += Left(SEE->EE_AGENCIA,4) + Left(SEE->EE_CONTA,5) + cDacConta
cCodigo    += "000"

nPeso      := 2  // Peso a ser utilizado na Multiplicacao
nMultiplic := 0  // Resultado da Multiplicacao de cada algarismo pelo Peso
nSoma      := 0  // Soma total do resultado de cada Multiplicacao
nA         := 0

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Multiplica-se cada posicao do Codigo de Barras pelos "pesos" de 2 a 9,Ё
//Ё atribuidos de tras para a frente ┘ partir da 44. posicao. O resultado Ё
//Ё sera armazenado no Array aMultiplic.                                  Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
For nA := Len(cCodigo) To 1 Step -1
	If nPeso == 10
		nPeso := 2
	EndIf
	nMultiplic := Val( Subs(cCodigo,nA,1) ) * nPeso
	nPeso      := nPeso + 1
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Soma o Resultado da Multiplicacao.                                    Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	nSoma := nSoma + nMultiplic
Next nA
//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Divide a Soma Total por 11, armazenando o Resto da Divisao.           Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nResto :=  nSoma % 11

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё O Resto da Divisao sera subtraido de 11. Caso o Resto seja igual ┘ 0  Ё
//Ё ou 10, o D.A.C. sera igual ┘ 1.                                       Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
If nResto == 0 .Or. nResto == 1
	nDigCodBar := 1
Else
	nDigCodBar := 11 - nResto
EndIf

Return(Nil)
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤└o    ЁA200LAYOUTЁ Autor Ё Alex Egydio           Ё Data Ё 26.05.98 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤└o Ё Gerar arquivo para impressao de Boleto Itau                Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё SEAA010  (SEAL)                                            Ё╠╠
╠╠цддддддддддеддддддддддддддддддддддддддддддддддддддддддбддддддбдддддддддд╢╠╠
╠╠Ё Revis└o  Ё                                          Ё Data Ё          Ё╠╠
╠╠юддддддддддаддддддддддддддддддддддддддддддддддддддддддаддддддадддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static FUNCTION A200LAYOUT()

//имммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╩
//╨ INFORMACOES DA FICHA DE CAIXA                                ╨
//лмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧
//╨ PRIMEIRA LINHA                                               ╨
//хмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪
_cCpo := ""
_cCpo += '"0585-5",'
_cCpo += '"ATE O VENCIMENTO PAGAVEL EM QUALQUER BANCO",'
_cCpo += '"APOS O VENCIMENTO PAGAVEL APENAS NO BANCO ITAU",'
_cCpo += '"' + Dtoc(SE1->E1_VENCTO) + '",'
_cCpo += '"' + Padr(Alltrim(SM0->M0_NOMECOM),30) + '",'
_cCpo += '"' + Left(_cCampo1,4) + '/' + Substr(_cCampo1,5,5) + '-' + Right(_cCampo1,1) + '"'
_cCpo += Chr(13) + Chr(10)

FWrite(_cTrab,_cCpo,Len(_cCpo))

//имммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╩
//╨ SEGUNDA LINHA                                                ╨
//хмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪
_cCpo := ""
_cCpo += '"' + Dtoc(SE1->E1_EMISSAO) + '",'
_cCpo += '"' + Padr(SE1->E1_PREFIXO+Alltrim(SE1->E1_NUM)+SE1->E1_PARCELA,10) + '",' //mp10
_cCpo += '"DP",'
_cCpo += '"N",'
_cCpo += '" ",'
_cCpo += '"' + Alltrim(MV_PAR04) + '/' + _cFaxAtu + '-' + Right(_cCampo3,1) + '",'
_cCpo += '" ",'
_cCpo += '"R$  ",'
_cCpo += '" "'
_cCpo += Chr(13) + Chr(10)

FWrite(_cTrab,_cCpo,Len(_cCpo))

//имммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╩
//╨ TERCEIRA LINHA                                               ╨
//хмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪
_cCpo := ""
_cCpo += '"' + Transform((SE1->E1_VALOR - (SE1->E1_COFINS + SE1->E1_CSLL + SE1->E1_PIS + SE1->E1_IRRF)), "@EZ 99,999,999,999.99") + '",' //20040217
// JADER 29/06/99 - TAXA JA DIVIDA POR 100
//_cCpo:=_cCpo+'"SUJEITO A PROTESTO SE NAO FOR PAGO NO VENCTO.  ","APOS VENCIMENTO, IDA DE '+Alltrim(Transform((SE1->E1_VALOR - SE1->E1_IRRF)*_nJuros/3000,"@EZ 999,999.99"))+' R$  ","                                               "'
_cCpo += '"SUJEITO A PROTESTO SE NAO FOR PAGO NO VENCTO.  ","APOS VENCIMENTO, IDA DE ' + Alltrim(Transform((SE1->E1_VALOR - (SE1->E1_COFINS + SE1->E1_CSLL + SE1->E1_PIS + SE1->E1_IRRF))*_nJuros/30,"@EZ 999,999.99")) + ' R$  ","                                               "' //20040217
_cCpo += Chr(13) + Chr(10)

FWrite(_cTrab,_cCpo,Len(_cCpo))

//имммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╩
//╨ QUARTA E QUINTA LINHA                                        ╨
//хмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪
_cCpo := ""
_cCpo += '"                                               ","                                               ","                                               "'
_cCpo += Chr(13) + Chr(10)

FWrite(_cTrab,_cCpo,Len(_cCpo))

_cCpo := ""
_cCpo += '"                                               ","                                               ","                                               "'
_cCpo += Chr(13) + Chr(10)

FWrite(_cTrab,_cCpo,Len(_cCpo))

//имммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╩
//╨ SEXTA LINHA                                                  ╨
//хмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪
DbSelectArea("SA1")
DbSeek( xFilial("SA1")+SE1->E1_CLIENTE + SE1->E1_LOJA )

_EndCob := Padr( ExecBlock("VCB01"), 40, " ")
_BaiCob := Padr( ExecBlock("VCB02"), 12," ")
_CEPCob := ExecBlock("VCB03")
_MunCob := ExecBlock("VCB04")
_EstCob := ExecBlock("VCB05")

_cCpo := ""
_cCpo += '"' + Left(SA1->A1_NOME,30) + '",'
_cCpo += '"CNPJ - ' + Transform(SA1->A1_CGC,"@R 99.999.999/9999-99") + '",'
_cCpo += '"' + _EndCob + '",'
_cCpo += '"' + Left(_CEPCob,5) + '",'
_cCpo += '"' + SubStr(_CEPCob,6,3) + '",'
_cCpo += '"' + SubStr(_BaiCob,1,12) + '","' + Left(_MunCob,15) + '",'
_cCpo += '"' + _EstCob + '","                              "," "," "'
_cCpo += Chr(13) + Chr(10)

FWrite(_cTrab,_cCpo,Len(_cCpo))

Return(Nil)
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤└o    ЁGanhaTempoЁ Autor Ё Alex Egydio           Ё Data Ё 26.05.98 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤└o Ё Gerar arquivo para impressao de Boleto Itau                Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё SEAA010  (SEAL)                                            Ё╠╠
╠╠цддддддддддеддддддддддддддддддддддддддддддддддддддддддбддддддбдддддддддд╢╠╠
╠╠Ё Revis└o  Ё                                          Ё Data Ё          Ё╠╠
╠╠юддддддддддаддддддддддддддддддддддддддддддддддддддддддаддддддадддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
// Funcao utilizada pelo fato que no Windows nao e possivel imprimir no mesmo
// tempo de processamento que o DOS, portanto nao imprimia sem 'Ganhar tempo'.
// Jader Cezar - 22/06/99.
Static Function GANHATEMPO()

ProcRegua(1000)
For _n := 1 to 1000
	IncProc()
Next

Return(nil)