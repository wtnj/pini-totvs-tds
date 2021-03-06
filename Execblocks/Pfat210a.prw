#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
/*/ Alterado por Danilo C S Pala em 20040326
��������������������������������������������������������������������������������
��������������������������������������������������������������������������������
����������������������������������������������������������������������������Ŀ��
���Fun��o    � PFAT210A � Autor � Gilberto A. Oliveira  � Data � 23.11.00    ���
����������������������������������������������������������������������������Ĵ��
���Descri��o � Processa informacoes para geracao do Boleto Unibanco.         ���
����������������������������������������������������������������������������Ĵ��
��� Uso      � ESPECIFICO                                                    ���
����������������������������������������������������������������������������Ĵ��
��� Revis�o  �                                          � Data �             ���
����������������������������������������������������������������������������Ĵ��
��� ROTINAS AUXILIARES E RELACIONADAS.                                       ���
��� ����������������������������������                                       ���
��� PFAT210.PRX     - Principal: Chama perguntas e aciona PFAT210A.          ���
���* PFAT210A.PRX   - Aciona A210DET, grava arquivo txt e chama Bloqueto.Exe.���
���   A210DET.PRX   - Dados do Lay-Out para criacao do arquivo.txt           ���
���    CNNA210.PRX  - Calcula Digito do Nosso Num. e incremente EE_FAXATU.   ���
���    CALMOD10.PRX - Calcula digitos de controle com base no Modulo 1021    ���
���    CALMOD11.PRX - Calcula digitos do Codigo de Barras com base no Mod.11 ���
����������������������������������������������������������������������������Ĵ��
���Observacao� Caso queira compilar varios desses Rdmakes utilize a Bat      ���
���          � BOL409.                                                       ���
�����������������������������������������������������������������������������ٱ�
��������������������������������������������������������������������������������
��������������������������������������������������������������������������������
/*/
User Function Pfat210a()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

SetPrvt("_CRETALIAS,_NRETORDER,_NRETRECNO,_CALERTA,_CNRCTRL,_CPATHUNIBANCO")
SetPrvt("_CARQUIVO,_NJUROS,_NMULTA1,_CMSGERROR,_CTRAB,_NCONTABOLETO,_CSERIE")
SetPrvt("_CMSGAVISO,_ATEXTO,XY,_CLINHA,_CCONTA,_CMSGALERT")
SetPrvt("_N,_CODEMP, cUNIBLOC")

_cRetAlias:= Alias()
_nRetOrder:= IndexOrd()
_nRetRecno:= Recno()

//��������������������������������������������������������������Ŀ
//� SEE - Comunica��o Remota p/guardar a Faixa Atual             �
//����������������������������������������������������������������
// MV_PAR1 C 3  (BANCO)
// MV_PAR2 C 5  (AGENCIA)
// MV_PAR3 C 10 (CONTA)
// MV_PAR4 C 6  (CARTEIRA)
DbSelectArea("SEE")
DbSetOrder(1)
If !DbSeek(xFilial("SEE")+MV_PAR01+MV_PAR02+MV_PAR03)
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

//��������������������������������������������������������������Ŀ
//� Seleciona Ordem dos Arquivos                                 �
//����������������������������������������������������������������
DbSelectArea("SE1")
DbSetOrder(1)
DbSelectArea("SA1")
DbSetOrder(1)

_cPathUnibanco := Alltrim( GETMV("MV_UNIBANC") )
cUNIBLOC := Alltrim( GETMV("MV_UNIBLOC") )
// _cArquivo := SubS(cUsuario,7,3)+SUBS(AllTrim(MV_PAR01),1,3)+ +".DAT"
// CIC01001 - NOVO FORMATO

_cArquivo := SubS(cUsuario,7,3)
_cArquivo := _cArquivo+SM0->M0_CODIGO
_cArquivo := _cArquivo+_cNrCtrl
_cArquivo := _cArquivo+".DAT"
_Codemp   := SM0->M0_CODIGO
_nJuros   := MV_PAR08
_nMulta1  := MV_PAR14

//��������������������������������������������������������������Ŀ
//� SF2 - Cabecalho de NF de Saida                               �
//����������������������������������������������������������������

DbSelectArea("SF2")
DbSetOrder(1)
DbSeek(xFilial("SF2")+mv_par05,.T.)

If SF2->F2_DOC > MV_PAR06
	_cMsgError:= "Registro nao encontrado no Faturamento !!! Verifique os procedimentos ..."
	MsgAlert( OemToAnsi(_cMsgError), OemToAnsi("ATEN��O") )
	Return
EndIf

ProcRegua( RecCount() )

If File(_cArquivo)
	Ferase(_cArquivo)
Endif

_cTrab:= FCreate(_cArquivo)

_nContaBoleto:= 0

While !Eof() .And. SF2->F2_DOC <= MV_PAR06
	IncProc()
	//��������������������������������������������������������������Ŀ
	//� Identifica a serie da nota                                   �
	//����������������������������������������������������������������
	If SF2->F2_SERIE #mv_par07           // Se a Serie do Arquivo for Diferente
		DbSkip()                           // do Parametro Informado !!!
		Loop
	Endif
	
	//��������������������������������������������������������������Ŀ
	//� SE1 - Contas a Receber                                       �
	//����������������������������������������������������������������
	_cSerie:= MV_PAR07
	DbSelectArea("SE1")
	DbSetOrder(1)
	DbSeek(xFilial("SE1") + _cSerie + SF2->F2_DOC)
	
	While !Eof() .And. SE1->E1_FILIAL+SE1->E1_NUM==xFilial("SE1")+SF2->F2_DOC
		
		If Alltrim(SE1->E1_TIPO) <> "NF" .Or. Alltrim(SE1->E1_PREFIXO) <> Alltrim(_cSerie)
			DbSelectArea("SE1")
			DbSkip()
			Loop
		Endif
		
		If !EMPTY(SE1->E1_BAIXA) .And.  SE1->E1_SALDO == 0
			DbSelectArea("SE1")
			DbSkip()
			Loop
		EndIf
		
		If  (Alltrim(SE1->E1_NATUREZ) <> "0101") .and. (Alltrim(SE1->E1_NATUREZ) <> "0108")  // Boletos ou duplicatas //20040326
			DBSelectArea("SE1")
			DbSkip()
			Loop
		EndIf		
		
		IF MV_PAR10 <> "."
			IF !(Alltrim(SE1->E1_PARCELA) $ Alltrim(MV_PAR10))
				DbSelectArea("SE1")
				DbSkip()
				Loop
			ENDIF
		ENDIF
		
		// mv_par12 Vencimento de
		// mv_par13 Vencimento Ate
		If DTOS(SE1->E1_VENCTO) < DTOS(mv_par12) .or. DTOS(SE1->E1_VENCTO) > DTOS(mv_par13)
			DbSelectArea("SE1")
			DbSkip()
			Loop
		Endif
		
		// ALERT( SE1->E1_SITUACA )
		
		IF SE1->E1_SITUACA <> "0"
			
			_cMsgAviso:="Aten��o: O titulo "+SE1->E1_NUM+SE1->E1_PARCELA+" "+SE1->E1_SERIE
			_cMsgAviso:=_cMsgAviso+" esta fora de CARTEIRA, transferido para o Banco "+Alltrim(SE1->E1_PORTADO)+"."
			_cMsgAviso:=_cMsgAviso+" Para reemitir esse boleto solicite a cobran�a que transfira o "
			_cMsgAviso:=_cMsgAviso+" titulo para carteira."
			
			MsgInfo( OemToAnsi(_cMsgAviso ) )
			
			DbSelectArea("SE1")
			DbSkip()
			Loop
		ENDIF
		
		// Verifica se ja foi emitido boleto para esse titulo por
		// outro banco.
		If SE1->E1_BOLEM == "S"
			If AllTrim(SE1->E1_PORTADO) #AllTrim( MV_PAR01 )
				If AllTrim(SE1->E1_PORTADO) #"CX1" .And. !Empty(SE1->E1_PORTADO)
					If SA6->( dbSeek(xFilial("SA6")+SE1->E1_PORTADO) )
						_cMsgError:= "Ja foi Emitido Boleto para esse Titulo !!!"
						_cMsgError:= "Titulo "+SE1->E1_NUM+" Parcela "+SE1->E1_PARCELA + " da Serie " + _cSerie
						_cMsgError:= _cMsgError+" com Boleto Emitido para o Banco : "
						_cMsgError:= _cMsgError+Alltrim(SE1->E1_PORTADO)+" Agencia : "+SE1->E1_AGEDEP+ " Cta. Corrente : "
						_cMsgError:= _cMsgError+SE1->E1_CONTA
						_cMsgError:= _cMsgError+" Por favor, para esse t�tulo entre no Banco Correspondente..."
						
						MsgAlert(OemToAnsi(_cMsgError),OemToAnsi("Aten��o"))
						
						//DbSelectArea("SE1")
						//DbSkip()
						//Loop
					EndIf
				Endif
			Endif
		Endif
		
		// CONSISTENCIA PARA IMPEDIR QUE SEJA IMPRESSO BOLETO DE
		// TITULOS QUE NAO GERAM BOLETO. TITULOS A VISTA E OUTROS.
		DbSelectArea("SC5")
		//DbSetOrder(5)
		//DbSeek(xFilial("SC5")+SF2->F2_DOC+_cSERIE)
		DbSetOrder(1)
		Dbseek(xFilial("SC5")+SE1->E1_PEDIDO)
		
/*		IF ALLTRIM(SC5->C5_DIVVEN) == "PUBL"
			DbSelectArea("SE1")
			DbSkip()
			Loop
		ENDIF
*/		
		If Found()
			DbSelectArea("SZ9")
			DbSetOrder(1)
			DbSeek(xFilial("SZ9")+SC5->C5_TIPOOP)
			If SZ9->Z9_QTDEP == 1
				If SE1->E1_PARCELA == "A" .Or. SE1->E1_PARCELA == " "
					If SZ9->Z9_BOLETO1 == "N" .OR. SZ9->Z9_BOLETO1 == " "
						DbSelectArea("SE1")
						DbSkip()
						Loop
					EndIf
				Endif
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
		
		SA1->(DbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA))
		
		_aTexto:={}
		
		// GRAVA AQUI DENTRO O E1_NUMBCO.
		ExecBlock("A210DET",.F.,.F.)
		
		For xy:= 1 to Len(_aTexto)
			_cLinha:= _aTexto[xy]+Chr(13)+Chr(10)
			FWrite(_cTrab,_cLinha,Len(_cLinha))
		Next
		
		_nContaBoleto:= _nContaBoleto + 1
		
		IncProc( "Gerando Boleto Nr.: "+StrZero( _nContaBoleto,5) )
		
		//��������������������������������������������������������������Ŀ
		//� Gravar Faixa Atual                                           �
		//����������������������������������������������������������������
		DbSelectArea("SE1")
		RecLock("SE1",.F.)
		
		SE1->E1_PORTADO:= Alltrim(mv_par01)     // Banco...
		SE1->E1_AGEDEP := Alltrim(mv_par02)     // Agencia...
		_cConta:= Alltrim(mv_par03)
		If ALLTRIM(MV_PAR03) == "1152758" .And. Alltrim(mv_par02) == "0138"
			_cConta:= "115275-8"
		ElseIf Alltrim(MV_PAR03) == "1152741" .And. Alltrim(MV_PAR02) == "0138"
			_cConta:= "115274 1"
		ElseIf Alltrim(MV_PAR03) == "1171162" .And. Alltrim(MV_PAR02) == "0138"
			_cConta:= "117116-2"
		EndIf
		SE1->E1_CONTA  := _cConta
		SE1->E1_BOLEM  := "S"
		SE1->E1_SITUACA:= "1"
		SE1->E1_OBS    := Iif( mv_par09 > 0, "DESCONTO DE R$ "+Alltrim(Str(MV_PAR09,10,2)), SE1->E1_OBS )
		
		//SE1->E1_NUMBCO := alltrim(_cFaxAtu) + alltrim(cDacNosso)
		//Nosso Numero sendo gravado na Rotina Externa NOSSONUM.PRX
		
		MsUnLock()
		
		DbSelectArea("SE1")
		DbSkip()
		
		If _nContaBoleto == 240
			_cMsgAviso:= "Aguarde a impressao dos boletos gerados e reinicie a partir"
			_cMsgAviso:=_cMsgAviso+" do Titulo : "+SE1->E1_NUM+" "+SE1->E1_PARCELA + " SERIE " + _cSerie
			Alert( "Numero de Boletos Ultrapassado !!" )
			Alert( _cMsgAviso )
			Exit
		EndIf
		
	Enddo
	
	If _nContaBoleto == 240
		Exit
	Endif
	
	DbSelectArea("SF2")
	DbSkip()
Enddo

FClose(_cTrab)

If _nContaBoleto > 0
	COPY FILE (_cArquivo) TO (_cPathUnibanco+_cArquivo)
EndIf
FErase(_cArquivo)

cDisco := Alltrim(GetMV("MV_PATHBOL"))

If _nContaBoleto > 0
	//��������������������������������������������������������������Ŀ
	//� Chamada externa para Impressa                                �
	//����������������������������������������������������������������
	//WinExec(cDisco+_cPathUnibanco+"BLOQUETO "+_cArquivo,2)  //20080214
	WinExec(cDisco+cUnibLOC+"BLOQUETO "+_cArquivo,2) //20080214
	Processa({|| GANHATEMPO()},"Gerando arquivo de boleto ...")// Substituido pelo assistente de conversao do AP5 IDE em 19/03/02 ==>         Processa({|| Execute(GANHATEMPO)},"Gerando arquivo de boleto ...")
Else
	_cMsgAlert:= "Aten��o : Nao foram gerados Boletos. Verifique o tipo de operacao..."
	MsgStop(_cMsgAlert)
EndIf

Return

Static Function GANHATEMPO()

ProcRegua(1000)
For _n := 1 to 1000
	IncProc()
Next

Return(nil)