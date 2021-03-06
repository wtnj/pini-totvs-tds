#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02
/*/ 20040708 Danilo C S Pala
//20070604: COMENTAR C6_LOCAL: JOSE RICARDO
//20111125: Validacao smartpag
//20121205: obrigar digitacao do vendedor4: Cidinha
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: MTA410    �Autor: Roger Cangianeli       � Data:   09/02/00 � ��
������������������������������������������������������������������������Ĵ ��
���Descri�ao: Ponto de Entrada na confirmacao do Pedido de Venda         � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : Retorno Logico.                                            � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function Mta410()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

SetPrvt("_CALIAS,_NINDEX,_NREG,_LRET,_CMSG,_NSIGAEMFRENTE")
SetPrvt("X,_NVALPARC,_LENTRADA,_ATABDESUPORTE,_NPOSDOPRODUTO,_NPOSDAQUANTIDADE")
SetPrvt("_NPOSDOUNITARIO,_NPOSDOVALORTOTAL,_NPOSDAORIGEM,_NPOSDATES,_NPOSDOSUPORTE,_CGRUPODOPRODUTO")
SetPrvt("_LALTERACAO,I,G,_CSUPORTE,_NPOSDOGRUPO,_NAVISO,I2")
SetPrvt("_NVALOR_DO_RATEIO,ACOLS,_NARREDONDAMENTO,_NACERTO,_NACERTAGRUPOS,XY")
SetPrvt("XZ,_NNOVOVALOR,I3,_LERRO, _nProduto, _nPosdoLocal, _nPosC1, _nPosC2, _nCOMIS1")

_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()
_lRet   := .T.

// SE EDITORA PINI

If SM0->M0_CODIGO == "01"
	// DIVISAO DE VENDAS REFERENTE AO PEDIDO. ROGER.
	If M->C5_DIVVEN == "PUBL"
		_cMsg := ""
		If M->C5_TPTRANS $ "04/10/12" .and. Empty(M->C5_CODAG)
			_cMsg   := "Nos Tipos de Transacao 04 / 10 / 12 deve ser digitado "
			_cMsg   := _cMsg + "o Codigo da Agencia ! "
		EndIf
		
		If !Empty(_cMsg)
			MsgStop(_cMsg, " Atencao ")
		EndIf
		//Dividir percentual de comissao dos vendedores em caso de haver 2, a comissao eh por produto!!!
		//Solicitante cidinha, 20040826
		//Danilo C S Pala
	   /*	if !Empty(M->C5_VEND1) .and. !Empty(M->C5_VEND2)
			_nPosC1   := Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_COMIS1"})
			_nPosC2   := Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_COMIS2"})
			For I:= 1 To Len(aCols)
				If aCols[ I , Len(aCols[1]) ] == .F.
					_NCOMIS1 := ACOLS[I,_nPosC1]
					IF _NCOMIS1 <> 0
						ACOLS[I,_nPosC1] := (_NCOMIS1 /2)
						ACOLS[I,_nPosC2] := (_NCOMIS1 /2)
					Endif
				EndIf
			Next
			
		EndIf //ateh aki 20040826 */
	EndIf
ElseIf SM0->M0_CODIGO == "03"
	_nSigaEmFrente := 0
	For x:= 1 to Len(aCols)
		If aCols[ X , Len(aCols[X]) ] == .F.
			_nSigaEmFrente:= _nSigaEmFrente + 1
		Endif
	Next
	If Len(aCols) != 0 .AND. _nSigaEmFrente > 0
		// Supoe-se, ao entrar no ponto de entrada, que os valores de software estao
		// corretos. Por necessidade e procedimento, os valores de software devem
		// ser sempre os valores do pedido quando se inicia o rateio de suporte.
		// tais informacoes sao de responsabilidade do usuario.
		// qualquer alteracao deve ser feita pela rotina de alteracao do pedido.
		If ALLTRIM(M->C5_TIPOOP) == "92"
			_nValParc:= 0
		ElseIf ALLTRIM(M->C5_CONDPAG)<>'201'
			_nValParc:=M->C5_VLRPED
		Else
			_nValParc:= M->C5_PARC1+M->C5_PARC2+M->C5_PARC3+M->C5_PARC4+M->C5_PARC5+M->C5_PARC6
		Endif
		
		_lRet:= .T.
		_lEntrada:= .T.
		//�����������������������������������������������������������������Ŀ
		//�  _aTabdeSuporte - array de auxilio a rotina.                    �
		//�����������������������������������������������������������������Ĵ
		//�  1� posicao - grupo a que se refere a apuracao.                 �
		//�  2� posicao - valor total de suporte que se apurou para o grupo.�
		//�  3� posicao - qtd. de itens de software do grupo pela qual sera �
		//�               rateado o valor de suporte.                       �
		//�               exemplo : R$ 5,00 de suporte dividido entre 2     �
		//�               itens de software, R$ 2,50 para cada item.        �
		//�  4� posicao - valor total sem suporte informatico para o grupo. �
		//�  5� posicao - valor total, soma de software+suporte, quando ja  �
		//�               rateado.                                          �
		//�  6� posicao - ultima linha de suporte informatico.              �
		//�������������������������������������������������������������������
		_aTabdeSuporte   := { {"38",0,0,0,0,0}}
		
		
		_nPosdoProduto   := Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_PRODUTO"})
		_nPosdaQuantidade:= Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_QTDVEN"})
		_nPosdoUnitario  := Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_PRCVEN"})
		_nPosdoValorTotal:= Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_VALOR"})
		_nPosdaOrigem    := Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_ORIGEM"})
		_nPosdaTES       := Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_TES"})
		_nPosdoSUPORTE   := Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_SUP"})
		_cGrupodoProduto := ""
		_lAlteracao      := .F.
		//������������������������������������������������������������������������Ŀ
		//�  Primeira leitura dos itens da acols, apenas itens nao deletados.      �
		//�  Apuracao da quantidade de itens de software e dos valores de suporte  �
		//�  para cada grupo.                                                      �
		//��������������������������������������������������������������������������
		For I:= 1 To Len(aCols)
			If aCols[ I , Len(aCols[1]) ] == .F.
				_cSuporte:= ACOLS[I,_nPosdoSUPORTE]
				IF _cSuporte == "S"
					_cGrupodoProduto:= Left( aCols[I,_nPosdoProduto],2)
					_nPosdoGrupo:= Ascan( _aTabdeSuporte,{|x| x[1]=='38'} )
					_lAlteracao:= iif( aCols[I,_nPosdaOrigem] $ "SO/SU" , .T. , _lAlteracao )
					If Subs( aCols[I,_nPosdoProduto],1,2) != "38"
						//������������������������������������������������������Ŀ
						//� Apura quantidade de itens de software para o grupo.  �
						//��������������������������������������������������������
						_aTabdeSuporte[_nPosdoGrupo,2]:= _aTabdeSuporte[_nPosdoGrupo,2] + aCols[I,_nPosdaQuantidade]
						_aTabdeSuporte[_nPosdoGrupo,4]:= _aTabdeSuporte[_nPosdoGrupo,4] + aCols[I,_nPosdoValorTotal]
					Endif
				Endif
			EndIf
		Next
		
		For G:= 1 To Len(aCols)
			If aCols[ G , Len(aCols[1]) ] == .F.
				_cSuporte:= ACOLS[G,_nPosdoSUPORTE]
				IF _cSuporte == "S"
					_cGrupodoProduto:= Left( aCols[G,_nPosdoProduto],2)
					_nPosdoGrupo:= Ascan( _aTabdeSuporte,{|x| x[1]=='38'} )
					_lAlteracao:= iif( aCols[G,_nPosdaOrigem] $ "SO/SU" , .T. , _lAlteracao )
					If Subs( aCols[G,_nPosdoProduto],1,2) =="38"
						//������������������������������������������������������Ŀ
						//� Apura valor do suporte informatico para o grupo.     �
						//��������������������������������������������������������
						_aTabdeSuporte[_nPosdoGrupo,3]:= _aTabdeSuporte[_nPosdoGrupo,3] +(_aTabdeSuporte[_nPosdoGrupo,2] * aCols[G,_nPosdoUnitario])
						aCols[G,_nPosdoValorTotal]   := _aTabdeSuporte[_nPosdoGrupo,2] * aCols[G,_nPosdoUnitario]
					Endif
				Endif
			EndIf
		Next
		
		_nAviso:=  1
		If _lAlteracao
			_cMsg   := "Os valores de suporte ja foram rateados pelo menos uma vez. Deseja ratear novamente ?"
			_nAviso := Aviso("Rateio do Suporte",_cMsg,{"SIM","NAO"})
		Endif
		
		If _nAviso ==  1
			//������������������������������������������������������������Ŀ
			//� Segunda leitura dos itens da acols. Consumacao do rateio.  �
			//��������������������������������������������������������������
			For I2 := 1 To Len(aCols)
				If aCols[ I2 , Len(aCols[1]) ] == .F.
					_cSuporte := Acols[I2,_nPosdoSUPORTE]
					If _cSuporte =="S"
						_cGrupodoProduto := Left( aCols[I2,_nPosdoProduto],2)
						//_nPosdoGrupo := Ascan( _aTabdeSuporte,{|x| x[1]==_cGrupodoProduto} )
						// _nPosdoGrupo := Ascan( _aTabdeSuporte,{|x| x[1]=='38'} )
						// If _nPosdoGrupo != 0
						If Subs( aCols[I2,_nPosdoProduto],1,2) != "38"
							_nValor_do_Rateio              := Round( _aTabdeSuporte[_nPosdoGrupo,3]/_aTabdeSuporte[_nPosdoGrupo,2], 2 )
							aCols[I2,_nPosdoUnitario]      := Round(aCols[I2,_nPosdoUnitario] - _nValor_do_Rateio,2)
							aCols[I2,_nPosdoValorTotal]    := Round(aCols[I2,_nPosdaQuantidade] * aCols[I2,_nPosdoUnitario],2)
							_aTabdeSuporte[_nPosdoGrupo,5] := Round(_aTabdeSuporte[_nPosdoGrupo,5] + aCols[I2,_nPosdoValorTotal],2)
							aCols[I2,_nPosdaOrigem] := "SO"
						Else
							_aTabdeSuporte[_nPosdoGrupo,5] := Round(_aTabdeSuporte[_nPosdoGrupo,5] + aCols[I2,_nPosdoValorTotal],2)
							_aTabdeSuporte[_nPosdoGrupo,6]:= I2
							aCols[I2,_nPosdaOrigem]:= "SU"
							aCols[I2,_nPosdaQuantidade]:=_aTabdeSuporte[_nPosdoGrupo,2]
							aCols[I2,_nPosdoValorTotal]:= Round(aCols[I2,_nPosdaQuantidade] * aCols[I2,_nPosdoUnitario],2)
						Endif
						// Endif
					EndIf
				Endif
			Next
			ObjectMethod(oGetdad:oBrowse,"Refresh()")
			_nArredondamento:= 0
			_nAcerto:= 0
			_nAcertaGrupos:= {}
			For xy:= 1 to LEN(_aTabdeSuporte)
				_nArredondamento:= _aTabdeSuporte[xy,4] - _aTabdeSuporte[xy,5]
				If _nArredondamento != 0
					If aCols[_aTabdeSuporte[xy,6],_nPosdaQuantidade] <> 1
						For xz:= Len(aCols) to 1 Step -1
							If aCols[xz,_nPosdaQuantidade] == 1
								//aCols[_aTabdeSuporte[xy,6],_nPosdoValorTotal]:= Round(aCols[_aTabdeSuporte[xy,6],_nPosdoValorTotal] + _nArredondamento,2)
								//aCols[_aTabdeSuporte[xy,6],_nPosdoUnitario]:= Round(aCols[_aTabdeSuporte[xy,6],_nPosdoValorTotal] / aCols[_aTabdeSuporte[xy,6],_nPosdaQuantidade],2 )
								aCols[xz,_nPosdoValorTotal]:= Round(aCols[xz,_nPosdoValorTotal] + _nArredondamento,2)
								aCols[xz,_nPosdoUnitario]:= Round(aCols[xz,_nPosdoValorTotal] / aCols[xz,_nPosdaQuantidade],2 )
								_nAcerto := _nAcerto + _nArredondamento
								Exit
							Endif
						Next
					Else
						//aCols[_aTabdeSuporte[xy,6],_nPosdoValorTotal]:= Round(aCols[_aTabdeSuporte[xy,6],_nPosdoValorTotal] + _nArredondamento,2)
						//aCols[_aTabdeSuporte[xy,6],_nPosdoUnitario]:= Round(aCols[_aTabdeSuporte[xy,6],_nPosdoValorTotal] / aCols[_aTabdeSuporte[xy,6],_nPosdaQuantidade],2 )
					Endif
				Endif
				
			Next
			ObjectMethod(oGetdad:oBrowse,"Refresh()")
		EndIf
		
		_nNovoValor:= 0
		
		For I3:= 1 To Len(aCols)
			If aCols[ I3 , Len(aCols[1]) ] == .F.
				SF4->( dbSeek(xfilial("SF4")+aCols[I3,_nPosdaTES]) )
				IF (SF4->F4_DUPLIC == "S" .AND. SF4->(FOUND()))
					_nNovoValor:= _nNovoValor + aCols[I3,_nPosdoValorTotal]
				ENDIF
			Endif
		Next
		
		If ( Round(_nNovoValor,2) != Round(_nValParc,2) )
			MsgBox("Valor dos itens nao bate com o total das parcelas. Verifique...","ATENCAO","ALERT" )
			MsgBox("Vlr. dos itens : "+alltrim(str(_nNovoValor,15,2))+"  Vlr. das Parcelas : "+alltrim(str(_nValParc,15,2)),"ATENCAO","ALERT" )
			_lRet:= .F.
		Endif
	EndIf
EndIf

// INCLUIDO EM 18/12/00 - By RC
dbSelectArea("SC6")
dbSetOrder(1)
If dbSeek(xFilial("SC6")+SC5->C5_NUM, .F.)
	dbSelectArea("SF2")
	dbSetOrder(1)
	If dbSeek(xFilial("SF2")+SC6->C6_NOTA+SC6->C6_SERIE+SC6->C6_CLI+SC6->C6_LOJA, .F.)
		_lErro := .F.
		_cMsg  := ""
		If SC5->C5_VEND1 #SF2->F2_VEND1
			_lErro := .T.
			_cMsg  := " Vendedor 1 - "
		EndIf
		If SC5->C5_VEND2 #SF2->F2_VEND2
			_lErro := .T.
			_cMsg  := _cMsg +" Vendedor 2 - "
		EndIf
		If SC5->C5_VEND3 #SF2->F2_VEND3
			_lErro := .T.
			_cMsg  := _cMsg +" Vendedor 3 - "
		EndIf
		If SC5->C5_VEND4 #SF2->F2_VEND4
			_lErro := .T.
			_cMsg  := _cMsg +" Vendedor 4 - "
		EndIf
		If SC5->C5_VEND5 #SF2->F2_VEND5
			_lErro := .T.
			_cMsg  := _cMsg +" Vendedor 5 - "
		EndIf
		
		If _lErro
			RecLock("SF2", .F.)
			SF2->F2_VEND1   := SC5->C5_VEND1
			SF2->F2_VEND2   := SC5->C5_VEND2
			SF2->F2_VEND3   := SC5->C5_VEND3
			SF2->F2_VEND4   := SC5->C5_VEND4
			SF2->F2_VEND5   := SC5->C5_VEND5
			msUnlock()
			_cMsg := _cMsg + " foram alterados no cabecalho da N.F.Saida. "
			MsgAlert(_cMsg, "Atencao","ALERT")
		EndIf
	EndIf
	
	dbSelectArea("SE1")
	dbSetOrder(1)
	If dbSeek(xFilial("SE1")+SF2->F2_SERIE+SF2->F2_DOC, .F.)
		While !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_FILIAL == xFilial("SE1") .AND.;
			SF2->F2_DOC == SE1->E1_NUM .and. SF2->F2_SERIE == SE1->E1_SERIE
			If SE1->E1_SALDO <= 0
				dbSkip()
				Loop
			EndIf
			_lErro := .F.
			_cMsg  := ""
			If SE1->E1_VEND1 #SC5->C5_VEND1
				_lErro := .T.
				_cMsg  := " Vendedor 1 - "
			EndIf
			If SE1->E1_VEND2 #SC5->C5_VEND2
				_lErro := .T.
				_cMsg  := _cMsg +" Vendedor 2 - "
			EndIf
			If SE1->E1_VEND3 #SC5->C5_VEND3
				_lErro := .T.
				_cMsg  := _cMsg +" Vendedor 3 - "
			EndIf
			If SE1->E1_VEND4 #SC5->C5_VEND4
				_lErro := .T.
				_cMsg  := _cMsg +" Vendedor 4 - "
			EndIf
			If SE1->E1_VEND5 #SC5->C5_VEND5
				_lErro := .T.
				_cMsg  := _cMsg +" Vendedor 5 - "
			EndIf
			
			If _lErro
				RecLock("SE1", .F.)
				SE1->E1_VEND1  :=  SC5->C5_VEND1
				SE1->E1_VEND2  :=  SC5->C5_VEND2
				SE1->E1_VEND3  :=  SC5->C5_VEND3
				SE1->E1_VEND4  :=  SC5->C5_VEND4
				SE1->E1_VEND5  :=  SC5->C5_VEND5
				msUnlock()
				_cMsg := _cMsg + " foram alterados no Contas a Receber. "
				MsgAlert(_cMsg, "Atencao","ALERT")
			EndIf
			
			dbSelectArea("SE1")
			dbSkip()
		End
	EndIf
EndIf

//20040120
/* ///20070604
For x:= 1 to Len(aCols)
	_nPosdoProduto   := Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_PRODUTO"})
	
	_nProduto := aCols[x,_nPosdoProduto]
	DbSelectArea("SB1")
	If DbSeek(xFilial("SB1")+ _nProduto)
		if SB1->B1_GRUPO = "0200" .or. SB1->B1_GRUPO = "0201"  //20040126
			if MsgYEsNo("O vendedor ja entregou o livro?")
				_nPosdoLocal   := Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_LOCAL"}) //20040708
				aCols[x,_nPosdoLocal] := SA3->A3_LOCAL   //20040708
			else
				_nPosdoLocal   := Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_LOCAL"})
				aCols[x,_nPosdoLocal] := "T5"
			endif
		endif
	EndIf
Next //20040120 ateh aki
*///20070604

//20111125
dbSelectArea("SZ9")
dbSetOrder(2)
If dbSeek(M->C5_TIPOOP) 
	if UPPER(ALLTRIM(SZ9->Z9_NATBX))=="SMARTPAG"
		if EMPTY(M->C5_PINISPG) .OR. EMPTY(M->C5_PINIDSG)
			MsgAlert("Este tipo de opera��o requer o numero do smartpag, informe-o para continuar", "Atencao")
			_lRet := .F.	 
		endif	
	endif
EndIf

//20121205
If SM0->M0_CODIGO == "01" .and. M->C5_DIVVEN == "PUBL"
	If  EMPTY(M->C5_VEND4)
			MsgAlert("N�o esque�a de preencher o vendedor 4", "Atencao")
	Endif
EndIf
			

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)
Return(_lRet)
