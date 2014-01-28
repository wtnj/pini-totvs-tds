#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    º PARAM    º Autor ºGilberto A Oliveira º Data º  26/01/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÎÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o º Parametros para impressao dos boletos bancarios.           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÎÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       º                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat230a()

SetPrvt("_ATITULOS,_CARQREN,_CBANCO,_CAGENCIA,_CCONTA,_CCART")
SetPrvt("_CNOTADE,_CNOTAATE,_CSERIE,_NJUROS,_NDESCON,_NDIAS")
SetPrvt("_NDVENCTO,_CTEXTO1,_CTEXTO2,_CTEXTO3,_ACRA,_CSAVSCR1")
SetPrvt("_CSAVCUR1,_CSAVROW1,_CSAVCOL1,_CSAVCOR1,_LEMFRENTE,NOPCA")
SetPrvt("_CRETALIAS,_NRETRECNO,_NRETORDER,_CNRCTRL,_CPATHITAU,_CARQUIVO")
SetPrvt("_CMSG1,_CTRAB,_CFAXATU,LBARRA,_CCAMPO1,_CCAMPO2")
SetPrvt("_CCAMPO3,CDACCONTA,CDACNOSSO,NDIGCODBAR,_CVALOR,CCODBARRA")
SetPrvt("_CCPO1AUX,_CCPO2AUX,_CCPO3AUX,_CCPO,_ABOLETO,_NRECZE")
SetPrvt("NA,AMULTIPLIC,NSOMA,NB,_CCAMPO,ABASENUM")
SetPrvt("NMULTIPLIC,NC,NALGARISM1,NALGARISM2,NRESTO,NDIGITO")
SetPrvt("CCODIGO,NPESO,_ENDCOB,_BAICOB,_CEPCOB,_MUNCOB")
SetPrvt("_ESTCOB,_N,")
Private oDlgJan1

_aTitulos := PARAMIXB                          // PARAMETRO VINDO DO PFAT230

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cArqRen  := Alltrim(MV_PAR01)+".DBF"
_cBanco   := "341"
_cAgencia := "0585 "
_cConta   := "39886-0   "    // Conta Correta
//_cConta := "92273-5   "
_cCart    := "175"
_cNotaDe  := _aTitulos[1,1]
_cNotaAte := _aTitulos[Len(_aTitulos),1]
_cSerie   := _aTitulos[1,2]
_nJuros   := 0
_nDescon  := 0
_nDias    := 0
_nDVencto := 0

_cTexto1  := "Foram gerados os titulos "+_cNotaDe+" a "+_cNotaAte+" com a serie "+_cSerie
_cTexto2  := "Os boleto serao gerados para o Banco ITAU, Agencia:0585, Conta: 39886-0."
_cTexto3  := "Para Impressao dos Bloqueto Bancarios confirme os parametros... "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao da Interface                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 109,153 To 470,669 Dialog oDlgJan1 Title OemToAnsi("Parametros")

@ 007,009 To 057,247 Title OemToAnsi("Mensagem")
@ 076,009 To 143,247 Title OemToAnsi("Parametros")

@ 018,018 Say OemToAnsi(_cTexto1) Size 216,014
@ 025,018 Say OemToAnsi(_cTexto2) Size 216,014
@ 032,018 Say OemToAnsi(_cTexto3) Size 216,014

@ 089,016 Say OemToAnsi("Nota Fiscal De ")     Size 43,8
@ 107,016 Say OemToAnsi("Nota Fiscal At‚")     Size 37,8
@ 125,016 Say OemToAnsi("S‚rie")               Size 16,8
@ 089,136 Say OemToAnsi("Juros/Dia")           Size 26,8
@ 107,136 Say OemToAnsi("Desconto")            Size 25,8
@ 125,136 Say OemToAnsi("Dias p/ recebimento") Size 72,8

@ 088,066 Get _cNotaDe  Size 35,10
@ 104,066 Get _cNotaAte Size 35,10
@ 122,066 Get _cSerie   Size 25,10
@ 088,192 Get _nJuros   Picture "@R 99.99" Size 46,10
@ 104,192 Get _nDescon  Picture "@R 99.99" Size 46,10
@ 122,192 Get _nDias    Size 35,10

@ 159,10 Button OemToAnsi("_Confirma") Size 36,16 Action Processa({|| GeraBloq()})// Substituido pelo assistente de conversao do AP5 IDE em 19/03/02 ==>        @ 159,10 Button OemToAnsi("_Confirma") Size 36,16 Action Execute(GeraBloq)
@ 160,63 Button OemToAnsi("_Aborta")   Size 36,16 Action Close(oDlgJan1)

Activate Dialog oDlgJan1

Return( .T. )
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    º GERABLOQ º Autor ºGilberto A Oliveira º Data º  26/01/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÎÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o º LOOP PRINCIPAL PARA IMPRESSAO DOS BLOQUETO BANCARIOS...    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÎÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       º ESPECIFICO PARA EDITORA PINI LTDA.                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GeraBloq()

Close(oDlgJan1)

_cRetAlias := Alias()
_nRetRecno := Recno()
_nRetOrder := IndexOrd()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SEE - Comunica‡Æo Remota p/guardar a Faixa Atual             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SEE")
DbSetOrder(1)
DbSeek(xFilial("SEE")+_cBanco+_cAgencia+_cConta)

If EOF()
	Help("",1,"NAOFAIXA")
	DbSelectArea(_cRetAlias)
	DbSetOrder(_nRetOrder)
	DbGoto(_nRetRecno)
	Return
Endif

_cNrCtrl := StrZero(Val(SEE->EE_NUMBCO)+1,3)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona Ordem dos Arquivos                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SA1")
DbSetOrder(1)

_cPathItau := Alltrim( GETMV("MV_ITAU") )
_cArquivo  := "BRA"                    //Bloq. Renov. Automatica. //// SubS(cUsuario,7,3)
_cArquivo  := _cArquivo+SM0->M0_CODIGO
_cArquivo  := _cArquivo+_cNrCtrl
_cArquivo  := _cArquivo+".341"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ ZZE - Titulos a Receber...                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("ZZE")
DbSetOrder(1)
DbSeek(xFilial("ZZE")+_cSerie+_cNotaDe,.T.)

If ZZE->ZZE_NUM > _cNotaAte
	_cMsg1:= "Nao foram encontrados Titulos para Impressao ! Verifique ..."
	MsgAlert(OemToAnsi(_cMsg1),"Aten‡„o!")
	DbSelectArea(_cRetAlias)
	DbSetOrder(_nRetOrder)
	DbGoto(_nRetRecno)
	Return
EndIf

ProcRegua( Len(_aTitulos) )

_cTrab:=FCreate(_cArquivo)

While !Eof() .And. ZZE->ZZE_NUM <= _cNotaAte
	IncProc(ZZE->ZZE_NUM)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Identifica a serie da nota                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ZZE->ZZE_PREFIX!=_cSerie
		DbSelectArea("ZZE")
		DbSkip()
		Loop
	Endif
	
	If !EMPTY(ZZE->ZZE_NNUM)
		DbSelectArea("ZZE")
		DbSkip()
		Loop
	EndIf
	
	//If AllTrim(ZZE->ZE_DIVVEN) == "PUBL"
	//   DbSelectArea("ZZE")
	//   DbSkip()
	//   Loop
	//EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ SEE - Cominicacao Remota p/guardar a Faixa Atual             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("SEE")
	DbSetOrder(1)
	If DbSeek(xFilial("SEE")+_cBanco+_cAgencia+_cConta)
		_cFaxAtu:=Left(Alltrim(SEE->EE_FAXATU),8)
		DbSelectArea("SEE")
		RecLock("SEE",.F.)
		SEE->EE_FAXATU := StrZero(Val(_cFaxAtu)+1,8)
		MsUnLock()
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o Digito de Auto Conferencia                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lBarra   := .F.
	_cCampo1 := Left(SEE->EE_AGENCIA,4)+Left(SEE->EE_CONTA,5)
	_cCampo2 := Left(SEE->EE_AGENCIA,4)+Left(SEE->EE_CONTA,5)+Alltrim(_cCart)                   // Agencia + Conta + Carteira
	_cCampo3 := Left(SEE->EE_AGENCIA,4)+Left(SEE->EE_CONTA,5)+Alltrim(_cCart)+_cFaxAtu // Agencia + Conta + Carteira + Nosso Numero
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o D.A.C. (Digito de Auto-Conferencia) do nosso numero.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	A020Dig1()
	cDacConta := Right(_cCampo1,1)
	cDacNosso := Right(_cCampo3,1)
	//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
	//º INFORMACOES DO RECIBO DO SACADO                              º
	//ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
	//º PRIMEIRA LINHA                                               º
	//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
	ExecBlock("A230DET",.F.,.F.)
	//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
	//º INFORMACOES DA FICHA DE CAIXA                                º
	//ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
	//º PRIMEIRA LINHA                                               º
	//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
	ExecBlock("A230DET",.F.,.F.)
	//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
	//º INFORMACOES DO CODIGO DE BARRAS !!!!                         º
	//ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
	//º PRIMEIRA LINHA                                               º
	//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
	nDigCodBar := 0
	_cValor    := Transform((ZZE->ZZE_VALOR), "@EZ 999999999999.99")
	cCodBarra  := "3419"+ Subs(_cValor,1,12) + Subs(_cValor,14,2) +;
	Left(SEE->EE_AGENCIA,4)+Left(SEE->EE_CONTA,5)+cDacConta+;
	Alltrim(_cCart)+_cFaxAtu+cDacNosso+"000"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o D.A.C. (Digito de Auto-Conferencia) do Codigo de Barras.    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	A020Dig2()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Lay-Out do Codigo de Barras                                  ³
	//³ 01 - 04 : Banco                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lBarra    := .T.
	_cCpo1Aux := _cCampo1
	_cCpo2Aux := _cCampo2
	_cCpo3Aux := _cCampo3
	_cCampo1  := "3419"+LEFT(_cCart,3)+LEFT(_cFaxAtu,2)
	_cCampo2  := Subs(_cFaxAtu,3,5)+Subs(_cFaxAtu,8,1)+cDacNosso+Left(SEE->EE_AGENCIA,3)
	_cCampo3  := Subs(SEE->EE_AGENCIA,4,1)+Subs(SEE->EE_CONTA,1,4)+Subs(SEE->EE_CONTA,5,1)+cDacConta+"000"
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Calcula o D.A.C. (Digito de Auto-Conferencia) do nosso numero.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	A020Dig1()
	_cCpo     := '"'+Left(_cCampo1,5)+'.'+Subs(_cCampo1,6,5)+'  '
	_cCpo     := _cCpo+Left(_cCampo2,5)+'.'+Subs(_cCampo2,6,6)+'  '
	_cCpo     := _cCpo+Left(_cCampo3,5)+'.'+Subs(_cCampo3,6,6)+'  '+Str(nDigCodBar,1)+'  '
	_cCpo     := _cCpo+Alltrim(Subs(_cValor,1,12)) + Subs(_cValor,14,2)+'",'
	_cCpo     := _cCpo+'"3419'+Str(nDigCodBar,1)+Padl(Alltrim(Subs(_cValor,1,12)) + Subs(_cValor,14,2),14,"0")
	_cCpo     := _cCpo+alltrim(_cCart)+_cFaxAtu+cDacNosso+Left(SEE->EE_AGENCIA,4)+Left(SEE->EE_CONTA,5)+cDacConta+'000"'
	_cCpo     := _cCpo+Chr(13)+Chr(10)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava      Codigo de Barras                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	FWrite(_cTrab,_cCpo,Len(_cCpo))
	_cCampo1 := _cCpo1Aux
	_cCampo2 := _cCpo2Aux
	_cCampo3 := _cCpo3Aux
	//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
	//º INFORMACOES DO LAYOUT CODIGO DE BARRAS                       º
	//ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
	//º PRIMEIRA LINHA                                               º
	//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
	ExecBlock("A230DET",.F.,.F.)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grava arquivo de Log de Boletos (ZZE).                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	_aBoleto:={}
	
	DbSelectArea("ZZE")
	RecLock("ZZE",.F.)
	ZZE->ZZE_BANCO   :=  Alltrim(_cBanco)
	ZZE->ZZE_AGENCIA :=  Alltrim(_cAgencia)
	ZZE->ZZE_CTACOR  :=  Substr(_cCampo1,5,5)+'-'+Right(_cCampo1,1)
	ZZE->ZZE_NNUM    :=  Alltrim(_cFaxAtu)+Alltrim(cDacNosso)
	ZZE->ZZE_INSTR1  := _cMsg1
	ZZE->ZZE_INSTR2  := _cMsg2
	ZZE->ZZE_INSTR3  := _cMsg3
	ZZE->ZZE_INSTR4  := ""
	ZZE->ZZE_ARQBOL  := _cArquivo
	ZZE->ZZE_ARQREN  := _cArqRen
	MsUnLock()
	
	_nRecZE := ZZE->(Recno())
	
	If Alltrim(ZZE->ZZE_PARCEL) == "A"
		dbskip(-1)
	Else
		dbskip()
	Endif
	
	Reclock("ZZE",.F.)
	ZZE->ZZE_NNUMOL := Alltrim(_cFaxAtu)+Alltrim(cDacNosso)
	MsUnLock()
	
	DbSelectArea("ZZE")
	dbGoto(_nRecZE)
	
	DbSelectArea("ZZE")
	DbSkip()
End

FClose(_cTrab)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada externa para Impressa                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
COPY FILE ("\SIGAADV\"+_cArquivo) TO (_cPathItau+_cArquivo)
FErase(_cArquivo)

DbSelectArea(_cRetAlias)
DbSetOrder(_nRetOrder)
DbGoto(_nRetRecno)

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ A020Dig1   ³Autor ³ Alex Egydio           ³ Data ³28/05/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula o Digito Verificador dos 3 primeiros campos da     ³±±
±±³          ³ Linha Digitavel.                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function A020Dig1()

nA := 0

For nA := 1 To 3
	aMultiplic := {}  // Resultado das Multiplicacoes de cada algarismo
	nSoma      := 0   // Somatoria total dos algarismos de cada Multiplicacao
	nB         := 0
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Identifica qual o Campo da Linha Digitavel que tera o Digito Verifi-  ³
	//³ cador calculado.                                                      ³
	//³ Define a Base Numerica de Multiplicacao.                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Do Case
		Case nA == 1
			_cCampo := _cCampo1
			If      lBarra
				aBaseNum := { 2, 1, 2, 1, 2, 1, 2, 1, 2}
			Else
				aBaseNum := { 2, 1, 2, 1, 2, 1, 2, 1, 2 }
			Endif
		Case nA == 2
			_cCampo := _cCampo2
			If      lBarra
				aBaseNum := { 1, 2, 1, 2, 1, 2, 1, 2, 1, 2 }
			Else
				aBaseNum := { 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2 }
			Endif
		Case nA == 3
			_cCampo := _cCampo3
			If      lBarra
				aBaseNum := { 1, 2, 1, 2, 1, 2, 1, 2, 1, 2 }
			Else
				aBaseNum := { 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2 }
			Endif
	EndCase
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Multiplica cada algarismo do Campo por uma Base Numerica de 2 e 1,    ³
	//³ atribuidos alternadamente e de tras para a frente, a partir da Decima ³
	//³ (10.) posicao. O Resultado sera armazenado no Array aMultiplic.       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nB := Len(_cCampo) To 1 Step -1
		nMultiplic := Val( Subs(_cCampo,nB,1) ) * aBaseNum[nB]
		Aadd(aMultiplic, StrZero(nMultiplic,2) )
	Next nB
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Soma os algarismos do Resultado de cada Multiplicacao, fazendo uma    ³
	//³ somatoria total.                                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For nC := 1 To Len(aMultiplic)
		nAlgarism1 := Val( Subs(aMultiplic[nC],1,1) )
		nAlgarism2 := Val( Subs(aMultiplic[nC],2,1) )
		nSoma      := nSoma + nAlgarism1 + nAlgarism2
	Next nC
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Divide a Somatoria Total por 10, armazenando o Resto da Divisao.      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nResto := nSoma % 10
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ O Resto da Divisao sera subtraido de 10, resultando no Digito.        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nResto >= 1 .And. nResto <= 10
		nDigito := 10 - nResto
	Else
		nDigito := 0
	EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Agrega o Digito ao campo da Linha Digitavel.                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Do Case
		Case nA == 1
			_cCampo1 := _cCampo1 + Str(nDigito,1)
		Case nA == 2
			_cCampo2 := _cCampo2 + Str(nDigito,1)
		Case nA == 3
			_cCampo3 := _cCampo3 + Str(nDigito,1)
	EndCase
Next nA

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ A020Dig2   ³Autor ³ Alex Egydio           ³ Data ³ 28/05/98³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Calcula o D.A.C. (Digito de Auto Conferencia) do Codigo de ³±±
±±³          ³ Barras.                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico                                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function A020Dig2()
cCodigo    := "3419" + Subs(_cValor,1,12)+Subs(_cValor,14,2)    + alltrim(_cCart) + _cFaxAtu+cDacNosso + ;
			  Left(SEE->EE_AGENCIA,4)	 +Left(SEE->EE_CONTA,5) + cDacConta       + "000"
nPeso      := 2  // Peso a ser utilizado na Multiplicacao
nMultiplic := 0  // Resultado da Multiplicacao de cada algarismo pelo Peso
nSoma      := 0  // Soma total do resultado de cada Multiplicacao
nA         := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Multiplica-se cada posicao do Codigo de Barras pelos "pesos" de 2 a 9,³
//³ atribuidos de tras para a frente … partir da 44. posicao. O resultado ³
//³ sera armazenado no Array aMultiplic.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For nA := Len(cCodigo) To 1 Step -1
	If nPeso == 10
		nPeso := 2
	EndIf
	nMultiplic := Val( Subs(cCodigo,nA,1) ) * nPeso
	nPeso      := nPeso + 1
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Soma o Resultado da Multiplicacao.                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nSoma := nSoma + nMultiplic
Next nA
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Divide a Soma Total por 11, armazenando o Resto da Divisao.           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nResto :=  nSoma % 11
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ O Resto da Divisao sera subtraido de 11. Caso o Resto seja igual … 0  ³
//³ ou 10, o D.A.C. sera igual … 1.                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nResto == 0 .Or. nResto == 1
	nDigCodBar := 1
Else
	nDigCodBar := 11 - nResto
EndIf

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³A200LAYOUT³ Autor ³ Alex Egydio           ³ Data ³ 26.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Gerar arquivo para impressao de Boleto Itau                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SEAA010  (SEAL)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Revis„o  ³                                          ³ Data ³          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static FUNCTION A200LAYOUT()

//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//º INFORMACOES DA FICHA DE CAIXA                                º
//ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
//º PRIMEIRA LINHA                                               º
//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
_cCpo := ""
_cCpo += '"0585-5",'
_cCpo += '"ATE O VENCIMENTO PAGAVEL EM QUALQUER BANCO",'
_cCpo += '"APOS O VENCIMENTO PAGAVEL APENAS NO BANCO ITAU",'
_cCpo += '"'+DtoC(ZZE->ZZE_VENCTO)+'",'
_cCpo += '"'+Padr(Alltrim(SM0->M0_NOMECOM),30)+'",'
_cCpo += '"'+Left(_cCampo1,4)+'/'+Substr(_cCampo1,5,5)+'-'+Right(_cCampo1,1)+'"'
_cCpo += Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//º SEGUNDA LINHA                                                º
//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
_cCpo := ""
_cCpo += '"'+Dtoc(ZZE->ZZE_EMISSA)+'",'
_cCpo += '"'+Padr(ZZE->ZZE_PREFIX+ZZE->ZZE_NUM+ZZE->ZZE_PARCEL,10)+'",'
_cCpo += '"DP",'
_cCpo += '"N",'
_cCpo += '" ",'
_cCpo += '"'+AllTrim(_cCart)+'/'+_cFaxAtu+'-'+Right(_cCampo3,1)+'",'
_cCpo += '" ",'
_cCpo += '"R$  ",'
_cCpo += '" "'
_cCpo += Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//º TERCEIRA LINHA                                               º
//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
_cCpo := ""
_cCpo += '"'+Transform((ZZE->ZZE_VALOR), "@EZ 99,999,999,999.99")+'",'
// JADER 29/06/99 - TAXA JA DIVIDA POR 100
//_cCpo:=_cCpo+'"SUJEITO A PROTESTO SE NAO FOR PAGO NO VENCTO.  ","APOS VENCIMENTO, IDA DE '+Alltrim(Transform((ZZE->ZZE_VALOR)*_nJuros/3000,"@EZ 999,999.99"))+' R$  ","                                               "'
_cCpo += '"SUJEITO A PROTESTO SE NAO FOR PAGO NO VENCTO.  ","APOS VENCIMENTO, IDA DE '+Alltrim(Transform((ZZE->ZZE_VALOR)*_nJuros/30,"@EZ 999,999.99"))+' R$  ","                                               "'
_cCpo += Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//º QUARTA E QUINTA LINHA                                        º
//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
_cCpo := ""
_cCpo += '"                                               ","                                               ","                                               "'
_cCpo += Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

_cCpo := ""
_cCpo += '"                                               ","                                               ","                                               "'
_cCpo += Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//º SEXTA LINHA                                                  º
//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
DbSelectArea("SA1")
dbSetOrder(1)
DbSeek( xFilial("SA1")+ZZE->ZZE_CLIENT + ZZE->ZZE_LOJA )

_EndCob := Padr( U_VCB01(), 40," ") //Padr( U_VCB01R(), 40," ")
_BaiCob := Padr( U_VCB02(), 12," ") //Padr( U_VCB02R(), 12," ")
_CEPCob := U_VCB03() //U_VCB03R()
_MunCob := U_VCB04() //U_VCB04R()
_EstCob := U_VCB05() //U_VCB05R()

_cCpo := ""
_cCpo += '"'+Left(SA1->A1_NOME,30)+'",'
_cCpo += '"CNPJ - '+Transform(SA1->A1_CGC,"@R 99.999.999/9999-99")+'",'
_cCpo += '"'+_EndCob+'",'
_cCpo += '"'+Left(_CEPCob,5)+'",'
_cCpo += '"'+SubStr(_CEPCob,6,3)+'",'
_cCpo += '"'+SubStr(_BaiCob,1,12)+'","'+Left(_MunCob,15)+'",'
_cCpo += '"'+_EstCob+'","                              "," "," "'
_cCpo += Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

Return
// Funcao utilizada pelo fato que no Windows nao e possivel imprimir no mesmo
// tempo de processamento que o DOS, portanto nao imprimia sem 'Ganhar tempo'.
// Jader Cezar - 22/06/99.

Static Function GANHATEMPO()

ProcRegua(1000)
For _n := 1 to 1000
	IncProc()
Next

Return