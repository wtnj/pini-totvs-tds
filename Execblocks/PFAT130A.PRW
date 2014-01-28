/*/
//DANILO C S PALA 20080213: INCLUSAO DO MV_ITAULOC
//Danilo C S Pala 20120504: PINILOGCONS
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ PFAT130A ³ Autor ³ Alex Egydio           ³ Data ³ 12/04/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Processa informacoes para geracao do Boleto Itau           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PFAT130  (SEAL/EDITORA PINI)  (PUBLICIDADE)                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Revis„o  ³ BOLETO DE PUBLICIDADE                    ³ Data ³          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PFAT130A()

Private _nMulta1 := 0

_cRetAlias:= Alias()
_nRetRecno:= Recno()
_nRetOrder:= IndexOrd()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SEE - Comunica‡Æo Remota p/guardar a Faixa Atual             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Seleciona Ordem dos Arquivos                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SE1")
DbSetOrder(1)
DbSelectArea("SA1")
DbSetOrder(1)

_cPathItau := Alltrim( GETMV("MV_ITAU") )
_cArquivo  := SubS(cUsuario,7,3)
_cArquivo  := _cArquivo+SM0->M0_CODIGO
_cArquivo  := _cArquivo+_cNrCtrl
_cArquivo  := _cArquivo+".341"

_nJuros    := MV_PAR08

DbSelectArea("SE1")
DbSetOrder(1)
DbSeek(xFilial("SE1")+mv_par07+mv_par05,.T.)

If SE1->E1_PREFIXO+SE1->E1_NUM > MV_PAR07+MV_PAR06
   MsgAlert("Nao foram encontrados Titulos para Impressao !! Verifique ...")
   DbSelectArea(_cRetAlias)
   DbSetOrder(_nRetOrder)
   DbGoto(_nRetRecno)
   Return
EndIf

ProcRegua(RecCount())

_cTrab := FCreate(_cArquivo)

While !Eof() .And. SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_NUM <= MV_PAR06
      IncProc()
      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
      //³ Identifica a serie da nota                                   ³
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

      If SE1->E1_SERIE # MV_PAR07           // Se a Serie do Arquivo for Diferente
         DbSkip()                           // do Parametro Informado !!!
         Loop
      Endif

      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
      //³ SE1 - Contas a Receber                                       ³
      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
      _cSerie:= MV_PAR07

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

      IF MV_PAR10 <> "."
         IF !(SE1->E1_PARCELA $ MV_PAR10 )
            DbSelectArea("SE1")
            DbSkip()
            Loop
           ENDIF
      ENDIF

      IF SE1->E1_SITUACA # "0"

         _cMsgAviso:="Aten‡Æo: O titulo "+SE1->E1_NUM+SE1->E1_PARCELA+" "+SE1->E1_SERIE
         _cMsgAviso:=_cMsgAviso+" esta fora de CARTEIRA, transferido para o Banco "+Alltrim(SE1->E1_PORTADO)+"."
         _cMsgAviso:=_cMsgAviso+" Para reemitir esse boleto solicite a cobran‡a que transfira o "
         _cMsgAviso:=_cMsgAviso+" titulo para carteira."
         MsgInfo( OemToAnsi(_cMsgAviso ),"ATENCAO")

         DbSelectArea("SE1")
         DbSkip()
         Loop

      ENDIF

      // Verifica se ja foi emitido boleto para esse titulo por
      // Outro Banco.
      If SE1->E1_BOLEM == "S" .OR. !Empty(SE1->E1_NUMBCO)
         _cMsgError:= "Ja foi Emitido Boleto para esse Titulo !!!"
         _cMsgError:= _cMsgError+"Titulo "+SE1->E1_NUM+" Parcela "+SE1->E1_PARCELA + " da Serie " + _cSerie
         _cMsgError:= _cMsgError+" Verifique com a cobranca o nosso numero : "+alltrim(SE1->E1_NUMBCO)
         MsgAlert(OemToAnsi(_cMsgError),OemToAnsi("Aten‡Æo"))
         DbSkip()
         Loop
      Endif

      IF ALLTRIM(SE1->E1_DIVVEN) == "MERC"
         DbSelectArea("SE1")
         DbSkip()
         Loop
      ENDIF

       DbSelectArea("SE1")

       //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
       //³ Preserva o nosso numero caso ja emitido                      ³
       //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
       If !Empty(SE1->E1_NUMBCO)
          _cFaxAtu:=Left(Alltrim(SE1->E1_NUMBCO),8)
       Else
          //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
          //³ SEE - Cominicacao Remota p/guardar a Faixa Atual             ³
          //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
          dbSelectArea("SEE")
          dbSetOrder(1)
          dbSeek(xFilial("SEE")+mv_par01+mv_par02+mv_par03)
          If !Eof()
              _cFaxAtu:=Left(Alltrim(SEE->EE_FAXATU),8)
              dbSelectArea("SEE")
              RecLock("SEE",.F.)
              SEE->EE_FAXATU := StrZero(Val(_cFaxAtu)+1,8)
              MsUnLock()
          Endif
       Endif

       //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
       //³ Calcula o Digito de Auto Conferencia                         ³
       //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
       lBarra  := .F.
       _cCampo1:= Left(SEE->EE_AGENCIA,4)+Left(SEE->EE_CONTA,5)
       _cCampo2:= Left(SEE->EE_AGENCIA,4)+Left(SEE->EE_CONTA,5)+Alltrim(mv_par04)                   // Agencia + Conta + Carteira
       _cCampo3:= Left(SEE->EE_AGENCIA,4)+Left(SEE->EE_CONTA,5)+Alltrim(mv_par04)+_cFaxAtu // Agencia + Conta + Carteira + Nosso Numero
       //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
       //³ Calcula o D.A.C. (Digito de Auto-Conferencia) do nosso numero.        ³
       //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
       A020Dig1()
       cDacConta:=Right(_cCampo1,1)
       cDacNosso:=Right(_cCampo3,1)

       _cCart     := MV_PAR04
//       _nDias     := iif(Empty(mv_par11),10,mv_par11)       // 25/07
       _nDias     := iif(Empty(mv_par11),0,mv_par11)        // 25/07
       _nJuros    := MV_PAR08   
       _nMulta1   := MV_PAR14 
       _nDescon   := MV_PAR09

       /*/
       ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
       º INFORMACOES DO RECIBO DO SACADO                              º
       ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
       º PRIMEIRA LINHA                                               º
       ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
       /*/
        ExecBlock("A130DET",.F.,.F.)
       /*/
       ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
       º INFORMACOES DA FICHA DE CAIXA                                º
       ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
       º PRIMEIRA LINHA                                               º
       ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
       /*/
       ExecBlock("A130DET",.F.,.F.)
       /*/
       ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
       º INFORMACOES DO CODIGO DE BARRAS !!!!                         º
       ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
       º PRIMEIRA LINHA                                               º
       ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
       /*/
       nDigCodBar:=0
       _cValor   := Transform((SE1->E1_VALOR - SE1->E1_IRRF), "@EZ 999999999999.99")
       cCodBarra := "3419"+ Subs(_cValor,1,12) + Subs(_cValor,14,2) +;
       Left(SEE->EE_AGENCIA,4)+Left(SEE->EE_CONTA,5)+cDacConta+;
       alltrim(mv_par04)+_cFaxAtu+cDacNosso+"000"
       //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
       //³ Calcula o D.A.C. (Digito de Auto-Conferencia) do Codigo de Barras.    ³
       //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
       A020Dig2()
       //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
       //³ Lay-Out do Codigo de Barras                                  ³
       //³ 01 - 04 : Banco                                              ³
       //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
       lBarra  :=.T.
       _cCpo1Aux:= _cCampo1
       _cCpo2Aux:= _cCampo2
       _cCpo3Aux:= _cCampo3
       _cCampo1 := "3419"+LEFT(MV_PAR04,3)+LEFT(_cFaxAtu,2)
       _cCampo2 := Subs(_cFaxAtu,3,5)+Subs(_cFaxAtu,8,1)+cDacNosso+Left(SEE->EE_AGENCIA,3)
       _cCampo3 := Subs(SEE->EE_AGENCIA,4,1)+Subs(SEE->EE_CONTA,1,4)+Subs(SEE->EE_CONTA,5,1)+cDacConta+"000"
       //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
       //³ Calcula o D.A.C. (Digito de Auto-Conferencia) do nosso numero.        ³
       //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
       A020Dig1()
       _cCpo:= '"'+Left(_cCampo1,5)+'.'+Subs(_cCampo1,6,5)+'  '
       _cCpo:=_cCpo+Left(_cCampo2,5)+'.'+Subs(_cCampo2,6,6)+'  '
       _cCpo:=_cCpo+Left(_cCampo3,5)+'.'+Subs(_cCampo3,6,6)+'  '+Str(nDigCodBar,1)+'  '
       _cCpo:=_cCpo+Alltrim(Subs(_cValor,1,12)) + Subs(_cValor,14,2)+'",'
       _cCpo:=_cCpo+'"3419'+Str(nDigCodBar,1)+Padl(Alltrim(Subs(_cValor,1,12)) + Subs(_cValor,14,2),14,"0")
       _cCpo:=_cCpo+alltrim(mv_par04)+_cFaxAtu+cDacNosso+Left(SEE->EE_AGENCIA,4)+Left(SEE->EE_CONTA,5)+cDacConta+'000"'
       _cCpo:=_cCpo+Chr(13)+Chr(10)
       //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
       //³ Grava      Codigo de Barras                                  ³
       //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
       FWrite(_cTrab,_cCpo,Len(_cCpo))
       _cCampo1:=_cCpo1Aux
       _cCampo2:=_cCpo2Aux
       _cCampo3:=_cCpo3Aux
       /*/
       ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
       º INFORMACOES DO LAYOUT CODIGO DE BARRAS                       º
       ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
       º PRIMEIRA LINHA                                               º
       ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
       /*/
       ExecBlock("A130DET",.F.,.F.)
       //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
       //³ Gravar Faixa Atual                                           ³
       //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
       DbSelectArea("SE1")
       RecLock("SE1",.F.)
       // criar see->ee_tipocob, c, 1
       // If SEE->EE_TIPOCOB=="S"                       // S = SEM REGISTRO
             SE1->E1_PORTADO:= Alltrim(mv_par01)        // banco...
             SE1->E1_AGEDEP := Alltrim(mv_par02)        // agencia...
             SE1->E1_CONTA  := Alltrim(mv_par03)        // conta corrente
             SE1->E1_BOLEM  := "S"
             SE1->E1_SITUACA:= "1"
             SE1->E1_OBS    := Iif( MV_PAR09 > 0, "DESCONTO R$ "+Alltrim(Str(MV_PAR09,10,2)), SE1->E1_OBS )
       // EndIf

       SE1->E1_NUMBCO := Alltrim(_cFaxAtu) + Alltrim(cDacNosso)
       MsUnLock()
                     
       U_PINILOGCONS(SM0->M0_CODIGO, SE1->E1_CLIENTE, SE1->E1_LOJA, SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, SE1->E1_EMISSAO, SE1->E1_PEDIDO, "BOL", "FAT130", "BOLETO ITAU PUB") //20120504

       DbSelectArea("SE1")
       DbSkip()
End

FClose(_cTrab)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada externa para Impressa                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cDisco := Alltrim(GetMV("MV_PATHBOL"))                           
cPathBol := GetMv("MV_PATHBOL")   
CITAULOC := Alltrim(GetMV("MV_ITAULOC")) //20080213
//COPY FILE ("\SIGAADV\"+_cArquivo) TO (_cPathItau+_cArquivo)        //20080212
COPY FILE (_cArquivo) TO (_cPathItau+_cArquivo)
//WinExec(cPathBol+_cPathItau+"IMPBLOQ "+_cArquivo+" >Nul",2 ) //20080213
WinExec(cDisco+CITAULOC+"IMPBLOQ "+_cArquivo,2 ) //20080213
Processa({|| GANHATEMPO()},"Gerando arquivo de boleto ...")

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
                _cCampo:=_cCampo1
				If	lBarra
					aBaseNum:={ 2, 1, 2, 1, 2, 1, 2, 1, 2}
				Else
					aBaseNum:={ 2, 1, 2, 1, 2, 1, 2, 1, 2 }
				Endif
		Case nA == 2
                _cCampo:=_cCampo2
				If	lBarra
					aBaseNum := { 1, 2, 1, 2, 1, 2, 1, 2, 1, 2 }
				Else
					aBaseNum := { 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2 }
                Endif
		Case nA == 3
                _cCampo:=_cCampo3
				If	lBarra
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
Static Function A020Dig2

cCodigo    := "3419"                                                  + ;
              Subs(_cValor,1,12)+Subs(_cValor,14,2)                     + ;
              alltrim(mv_par04)+_cFaxAtu+cDacNosso                              + ;
     	      Left(SEE->EE_AGENCIA,4)+Left(SEE->EE_CONTA,5)+cDacConta + ;
              "000"
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

            /*/
            ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
            º INFORMACOES DA FICHA DE CAIXA                                º
            ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹
            º PRIMEIRA LINHA                                               º
            ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
            /*/

            _cCpo:=""
            _cCpo:=_cCpo+'"0585-5",'
            _cCpo:=_cCpo+'"ATE O VENCIMENTO PAGAVEL EM QUALQUER BANCO",'
            _cCpo:=_cCpo+'"APOS O VENCIMENTO PAGAVEL APENAS NO BANCO ITAU",'
            _cCpo:=_cCpo+'"'+Dtoc(SE1->E1_VENCTO)+'",'
            _cCpo:=_cCpo+'"'+Padr(Alltrim(SM0->M0_NOMECOM),30)+'",'
            _cCpo:=_cCpo+'"'+Left(_cCampo1,4)+'/'+Substr(_cCampo1,5,5)+'-'+Right(_cCampo1,1)+'"'
            _cCpo:=_cCpo+Chr(13)+Chr(10)

            FWrite(_cTrab,_cCpo,Len(_cCpo))

            /*/
            ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
            º SEGUNDA LINHA                                                º
            ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
            /*/

            _cCpo:=""
            _cCpo:=_cCpo+'"'+Dtoc(SE1->E1_EMISSAO)+'",'
            _cCpo:=_cCpo+'"'+Padr(SE1->E1_PREFIXO+Alltrim(SE1->E1_NUM)+SE1->E1_PARCELA,10)+'",' //mp10
            _cCpo:=_cCpo+'"DP",'
            _cCpo:=_cCpo+'"N",'
            _cCpo:=_cCpo+'" ",'
            _cCpo:=_cCpo+'"'+Alltrim(MV_PAR04)+'/'+_cFaxAtu+'-'+Right(_cCampo3,1)+'",'
            _cCpo:=_cCpo+'" ",'
            _cCpo:=_cCpo+'"R$  ",'
            _cCpo:=_cCpo+'" "'
            _cCpo:=_cCpo+Chr(13)+Chr(10)

            FWrite(_cTrab,_cCpo,Len(_cCpo))

            /*/
            ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
            º TERCEIRA LINHA                                               º
            ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
            /*/

            _cCpo:=""
            _cCpo:=_cCpo+'"'+Transform((SE1->E1_VALOR-SE1->E1_IRRF), "@EZ 99,999,999,999.99")+'",'
            // JADER 29/06/99 - TAXA JA DIVIDA POR 100
            //_cCpo:=_cCpo+'"SUJEITO A PROTESTO SE NAO FOR PAGO NO VENCTO.  ","APOS VENCIMENTO, IDA DE '+Alltrim(Transform((SE1->E1_VALOR - SE1->E1_IRRF)*_nJuros/3000,"@EZ 999,999.99"))+' R$  ","                                               "'
            _cCpo:=_cCpo+'"SUJEITO A PROTESTO SE NAO FOR PAGO NO VENCTO.  ","APOS VENCIMENTO, IDA DE '+Alltrim(Transform((SE1->E1_VALOR - SE1->E1_IRRF)*_nJuros/30,"@EZ 999,999.99"))+' R$  ","                                               "'
            _cCpo:=_cCpo+Chr(13)+Chr(10)

            FWrite(_cTrab,_cCpo,Len(_cCpo))

            /*/
            ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
            º QUARTA E QUINTA LINHA                                        º
            ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
            /*/

            _cCpo:=""
            _cCpo:=_cCpo+'"                                               ","                                               ","                                               "'
            _cCpo:=_cCpo+Chr(13)+Chr(10)
            FWrite(_cTrab,_cCpo,Len(_cCpo))

            _cCpo:=""
            _cCpo:=_cCpo+'"                                               ","                                               ","                                               "'
            _cCpo:=_cCpo+Chr(13)+Chr(10)
            FWrite(_cTrab,_cCpo,Len(_cCpo))

            /*/
            ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
            º SEXTA LINHA                                                  º
            ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
            /*/
            DbSelectArea("SA1")
            DbSetOrder(1)
            DbSeek( xFilial("SA1")+SE1->E1_CLIENTE + SE1->E1_LOJA )

            _EndCob:= Padr( ExecBlock("VCB01"), 40, " ")
            _BaiCob:= Padr( ExecBlock("VCB02"), 12," ")
            _CEPCob:= ExecBlock("VCB03")
            _MunCob:= ExecBlock("VCB04")
            _EstCob:= ExecBlock("VCB05")

            _cCpo:=""
            _cCpo:=_cCpo+'"'+Left(SA1->A1_NOME,30)+'",'
            _cCpo:=_cCpo+'"CNPJ - '+Transform(SA1->A1_CGC,"@R 99.999.999/9999-99")+'",'
            _cCpo:=_cCpo+'"'+_EndCob+'",'
            _cCpo:=_cCpo+'"'+Left(_CEPCob,5)+'",'
            _cCpo:=_cCpo+'"'+SubStr(_CEPCob,6,3)+'",'
            _cCpo:=_cCpo+'"'+SubStr(_BaiCob,1,12)+'","'+Left(_MunCob,15)+'",'
            _cCpo:=_cCpo+'"'+_EstCob+'","                              "," "," "'
            _cCpo:=_cCpo+Chr(13)+Chr(10)

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