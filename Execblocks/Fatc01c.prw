#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
//Danilo C S Pala 20100305: ENDBP
//Danilo C S Pala 20100817: c6_comis1
User Function Fatc01c()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Declaracao de variaveis utilizadas no programa atraves da funcao    Ё
//Ё SetPrvt, que criara somente as variaveis definidas pelo usuario,    Ё
//Ё identificando as variaveis publicas do sistema utilizadas no codigo Ё
//Ё Incluido pelo assistente de conversao do AP5 IDE                    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

SetPrvt("_NREGSA1,NLASTKEY,_CNUMAV,_CCOLOR,_CCURSOR,_CMSG")
SetPrvt("NOPCX,_CCLIENTE,AHEADER,NUSADO,CTITULO,NLINGETD")
SetPrvt("AC,AR,ACOLS,_CSTR,_LSZS,_CSTR2")
SetPrvt("_ACAMPOS,_CNOMARQ,_CKEY,_CMOTIVO,ACGD,CLINHAOK")
SetPrvt("CTUDOOK,LRETMOD2,")

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддддддддддддбддддддддддддддддддддддддддддддбдддддддддддддддддд© ╠╠
╠╠ЁPrograma: FATC01C   Ё  Autor: Roger Cangianeli       Data: 22/02/00   Ё ╠╠
╠╠цддддддддддддддддддддаддддддддддддддддддддддддддддддадддддддддддддддддд╢ ╠╠
╠╠ЁDescri┤ao: Consulta Geral de A.V.Оs                                   Ё ╠╠
╠╠цдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢ ╠╠
╠╠ЁUso          : Especifico PINI Editora Ltda.                          Ё ╠╠
╠╠юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды ╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
_nRegSA1:= SA1->( Recno() )
nLastKey:= 0

_cNumAv := Space(6)

#IFDEF WINDOWS
    @ 200,202 To 285,477 Dialog _oDlg Title OemToAnsi("Pedidos de Venda")
    @ 006,005 Say OemToAnsi("Digite o Numero do Pedido: ")
        @ 006,072 Get _cNumAV Picture "@!" Valid .T.
        @ 020,020 BmpButton Type 1 Action _ConfProc()// Substituido pelo assistente de conversao do AP5 IDE em 19/03/02 ==>         @ 020,020 BmpButton Type 1 Action Execute("_ConfProc")
        @ 021,077 BmpButton Type 2 Action _CancProc()// Substituido pelo assistente de conversao do AP5 IDE em 19/03/02 ==>         @ 021,077 BmpButton Type 2 Action Execute("_CancProc")
        Activate Dialog _oDlg

#ELSE
    _cColor := SetColor()
    _cCursor:= SetCursor()
    SetCursor(1)
    SetColor("B/BG")
    DrawAdvWin("ATENCAO" , 10, 15, 12, 50 )
    @ 011,017 SAY "Digite Numero do Pedido: "   GET _cNumAV Picture "@!"
    Read
    If !Empty(_cNumAV)
        SetCursor(_cCursor)
        SetColor(_cColor)
        _ConfProc()
    EndIf
#ENDIF

Return


// Cancela o Processamento
// Substituido pelo assistente de conversao do AP5 IDE em 19/03/02 ==> Function _CancProc
Static Function _CancProc()
        Close(_oDlg)
Return


// Confirmacao do Processamento
// Substituido pelo assistente de conversao do AP5 IDE em 19/03/02 ==> Function _ConfProc
Static Function _ConfProc()

If !Empty(_cNumAV)
    dbSelectArea("SC5")
    dbSetOrder(1)
    If !dbSeek(xFilial("SC5")+_cNumAV, .F.)
        _cMsg := "P.V. "+_cNumAV+" NAO ENCONTRADO !!!"
        #IFDEF WINDOWS
            MsgBox( _cMsg, "ATENCAO", "ALERT" )
        #ELSE
            Alert( _cMsg )
        #ENDIF
        Return

    EndIf

Else
    Return

EndIf

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Opcao de acesso para o Modelo 2                              Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza
nOpcx := 1

dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI)

_cCliente   := "Cliente:"+SA1->A1_COD + "/" + SA1->A1_LOJA + "-" + SA1->A1_NOME + " PV:" + _cNumAV

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Montando aHeader                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aHeader:={}
nUsado:=0

nUsado:=nUsado+1
aAdd( aHeader, { Padc(_cCliente,70), "TEXTO", "", 80, 0,;
        "AllWaysTrue()", "─────┌", "C", "TRB", Space(1) } )

nUsado:=nUsado+1
aAdd( aHeader, { Padc(_cCliente,70), "TEXTO2", "", 80, 0,;
        "AllWaysTrue()", "─────┌", "C", "TRB", Space(1) } )

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Titulo da Janela                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cTitulo:= "Consulta Geral a Pedidos de Venda"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis do Rodape do Modelo 2                              Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nLinGetD:=0

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Array com descricao dos campos do Cabecalho do Modelo 2      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aC:={}
// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.

/*/
#IFDEF WINDOWS
        AADD(aC,{"_cCliente" , {15,10}  , "Cliente "  , "@!",,, .F. })
#ELSE
        AADD(aC,{"_cCliente" , {4,5}    , "Cliente "  , "@!",,, .F. })
#ENDIF
/*/

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Array com descricao dos campos do Rodape do Modelo 2         Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aR:={}
// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .T. se nao .F.

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Montando aCols                                               Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
aCols := {}

//
//              DADOS FUNDAMENTAIS
//
_cStr := "Endereco : " + AllTrim(SA1->A1_END) + " - " + AllTrim(SA1->A1_BAIRRO)
_cStr := _cStr + IIf( 76 - Len(_cStr) > 0, Space( 76 - Len(_cStr)), "" )
aAdd( aCols, { _cStr, _cStr, .F. } )

_cStr := "Cidade   : " + AllTrim(SA1->A1_MUN) + " - UF : " + SA1->A1_EST + " - CEP : " + Transform(SA1->A1_CEP, "@R 99999-999")
aAdd( aCols, { _cStr, _cStr, .F. } )

If Len(AllTrim(SA1->A1_CGC)) <= 11 .and. SA1->A1_TPCLI == "F"
        _cStr := "C.P.F.   : " + Transform( StrZero( Val(SA1->A1_CGC),11 ), "@R 999.999.999-99")     + "      - Insc.Est.: "+ IIf( Empty(SA1->A1_INSCR), "Nao Cadastrado", AllTrim(SA1->A1_INSCR) )
Else
        _cStr := "C.N.P.J. : " + Transform( StrZero( Val(SA1->A1_CGC),14 ), "@R 99.999.999/9999-99") + "  - Insc.Est.: "+ IIf( Empty(SA1->A1_INSCR), "Nao Cadastrada", AllTrim(SA1->A1_INSCR) )
EndIf
aAdd( aCols, { _cStr, _cStr, .F. } )

If !Empty(SA1->A1_INSCRM)
        _cStr := "Insc.Mun.: " +  AllTrim(SA1->A1_INSCRM)
    aAdd( aCols, { _cStr, _cStr, .F. } )
EndIf

_cStr := "Telefone : " + SA1->A1_TEL + "- Fax : " + IIf(!Empty(SA1->A1_FAX), SA1->A1_FAX, "Nao Cadastrado" )
aAdd( aCols, { _cStr, _cStr, .F. } )

dbSelectArea("SE4")
dbSetOrder(1)
dbSeek(xFilial("SE4")+SC5->C5_CONDPAG)

_cStr := "Cond.Pgto: " + SC5->C5_CONDPAG + " - " + SE4->E4_DESCRI

If SM0->M0_CODIGO == "01"
        _cStr := _cStr + "Tipo Trans.: " + SC5->C5_TPTRANS
        aAdd( aCols, { _cStr, _cStr, .F. } )
EndIf

dbSelectArea("SA3")
dbSetOrder(1)
dbSeek(xFilial("SA3")+SC5->C5_VEND1)

_cStr := "Contato  : " + SC5->C5_VEND1 + " - " + SA3->A3_NOME
aAdd( aCols, { _cStr, _cStr, .F. } )

If SM0->M0_CODIGO == "01"
        // Agencia
        If !Empty(SC5->C5_CODAG)
            _cStr := Repl( "-", 76 )
            aAdd( aCols, { _cStr, _cStr, .F. } )
            dbSelectArea("SA1")
            dbSetOrder(1)
            dbSeek(xFilial("SA1")+SC5->C5_CODAG)
            _cStr := "Agencia  : " + SC5->C5_CODAG + " - " + SA1->A1_NOME
            aAdd( aCols, { _cStr, _cStr, .F. } )
            dbSeek(xFilial("SA1")+SC5->C5_CLIENTE)
        EndIf

EndIf

_cStr := Repl( "=", 76 )
aAdd( aCols, { _cStr, _cStr, .F. } )

//
//              ENDERECO PARA COBRANCA ( SE EXISTIR )
//
dbSelectArea("SZ5")
dbSetOrder(1)
If Subs(SA1->A1_ENDCOB,1,1) == "S" .and. ;
        dbSeek(xFilial("SZ5")+SA1->A1_COD+SA1->A1_LOJA, .F. )
    _cStr := PadC( "DADOS COMPLEMENTARES PARA COBRANCA : ", 72 )
        aAdd( aCols, { _cStr, _cStr, .F. } )
    _cStr := Repl("-", 76 )
        aAdd( aCols, { _cStr, _cStr, .F. } )
        _cStr := "Endereco : " + AllTrim(SZ5->Z5_END) + " - " + AllTrim(SZ5->Z5_BAIRRO)
        aAdd( aCols, { _cStr, _cStr, .F. } )
        _cStr := "Cidade   : " + AllTrim(SZ5->Z5_CIDADE) + " - UF : " + SZ5->Z5_ESTADO + " - CEP : " + Transform(SZ5->Z5_CEP, "@R 99999-999")
        aAdd( aCols, { _cStr, _cStr, .F. } )
Else
    _cStr := PadC( "NAO HA DADOS COMPLEMENTARES PARA COBRANCA !", 72 )
        aAdd( aCols, { _cStr, _cStr, .F. } )
EndIf
	//ENDERECO COBRANCA BP( SE EXISTIR ) 20100305 DAQUI
	dbSelectArea("ZY3")
	dbSetOrder(1)
	If SA1->A1_ENDBP ="S" .and. dbSeek(xFilial("ZY3")+SA1->A1_COD+SA1->A1_LOJA, .F. )
		_cStr := PadC( "DADOS COMPLEMENTARES PARA COBRANCA BP: ", 72 )
		//aAdd( aCols, { _cStr, .F. } )
		//_cStr := Repl("-", 76 )
		aAdd( aCols, { _cStr, .F. } )
		_cStr := "Endereco : " + ALLTRIM(ZY3_TPLOG)+ " " + ALLTRIM(ZY3_LOGR) + " " + ALLTRIM(ZY3_NLOGR) + " " + ALLTRIM(ZY3_COMPL) 
		_cStr := _cStr + "Bairro: "	+ AllTrim(ZY3->ZY3_BAIRRO)
		aAdd( aCols, { _cStr, .F. } )
		_cStr := "Cidade   : " + AllTrim(ZY3->ZY3_CIDADE) + " - UF : " + ZY3->ZY3_ESTADO + " - CEP : " + Transform(ZY3->ZY3_CEP, "@R 99999-999")
		aAdd( aCols, { _cStr, .F. } )
	Else
		_cStr := PadC( "NAO HA DADOS COMPLEMENTARES PARA COBRANCA BP!", 72 )
		aAdd( aCols, { _cStr, .F. } )
	EndIf
	//20100305 ATE AQUI
_cStr := Repl( "=", 76 )
aAdd( aCols, { _cStr, _cStr, .F. } )


//
//      PROGRAMACAO ESPECIAL DE A.V.Оs
//
_lSZS := .F.    // Se nao ha programacao de A.V.Оs

If "P" $ SC5->C5_NUM
    _cStr := PadC( "PROGRAMACOES DA A.V. : ", 72 )
    aAdd( aCols, { _cStr, _cStr, .F. } )

    _cStr := Repl( "-", 76 )
    aAdd( aCols, { _cStr, _cStr, .F. } )

Else
    _cStr := PadC( "ITENS DO PEDIDO " + SC5->C5_NUM + "- Data de Emissao : "+ DTOC(SC5->C5_EMISSAO), 72 )
    aAdd( aCols, { _cStr, _cStr, .F. } )

EndIf

// Seleciona Indices Utilizados
dbSelectArea("SC6")
dbSetOrder(1)
dbSelectArea("SB1")
dbSetOrder(1)

// Analisa Pedidos
dbSelectArea("SC6")
dbSeek(xFilial("SC6")+SC5->C5_NUM)
While !Eof() .and. SC6->C6_FILIAL+SC6->C6_NUM==xFilial("SC6")+SC5->C5_NUM

    // Se for pedido da Publicidade
    If "P" $ SC5->C5_NUM .and. SM0->M0_CODIGO == "01"   // Especifico Editora

        dbSelectArea("SZS")
        dbSetOrder(1)
        // If SC6->C6_TPPROG == "S" .and.;
        If dbSeek(xFilial("SZS")+SC5->C5_NUM+SC6->C6_ITEM, .F.)

            // Existe Programacao Especial
            If !_lSZS
                _lSZS := .T.
                _cStr := "IT IN REV  EDIC DT.CIRC. ST VALOR     N.F.   DESCRICAO           SECAO "
                //        99 99 XXXX 9999 99/99/99 XX 999999.99 XXXXXX XXXXXXXXXXXXXXXXXXX XXXXX
                _cStr2:= "SECAO                               CODMAT       C1"
                //        XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XXXXXX
                aAdd( aCols, { _cStr, _cStr2, .F. } )
            EndIf

            While !Eof() .and. SZS->ZS_FILIAL + SZS->ZS_NUMAV + SZS->ZS_ITEM ==;
                               xFilial("SZS") + SC6->C6_NUM   + SC6->C6_ITEM

                dbSelectArea("SB1")
                dbSeek(xFilial("SB1")+SC6->C6_PRODUTO)

                dbSelectArea("SZW")
                dbSetOrder(1)
                dbSeek(xFilial("SZW")+SC6->C6_CODTIT)

                // Linha do Item
                _cStr := SC6->C6_ITEM+Space(1)+STR(SZS->ZS_NUMINS,2,0)+Space(1)
                _cStr := _cStr + Subs(SZS->ZS_CODREV,1,4) + Space(1) + StrZero(SZS->ZS_EDICAO,4,0)
                _cStr := _cStr + Space(1) + DtoC(SZS->ZS_DTCIRC) + Space(1) + SZS->ZS_SITUAC
                _cStr := _cStr + Space(1) + Transform(SZS->ZS_VALOR, "@E 999999.99") + Space(1)
                _cStr := _cStr + SZS->ZS_NFISCAL + Space(1) + Subs(SB1->B1_DESC,1,19) + Space(1)
                _cStr := _cStr + IIf( !Empty(SC6->C6_CODTIT), Subs(SZW->ZW_DESCR,1,5), Space(5) )
                _cStr2:= IIf( !Empty(SC6->C6_CODTIT), Subs(SZW->ZW_DESCR,6,35), Space(35) )
                _cStr2:= _cStr2+ Space(1) + SZS->ZS_CODMAT + space(3) +Str(SC6->C6_COMIS1, 5, 2) //20100817
                aAdd( aCols, { _cStr, _cStr2, .F. } )

                dbSelectArea("SZS")
                dbSkip()

            End

//                   // Linha do Item 2
//                   _cStr := IIF(!Empty(SC6->C6_ROTEIRO),"Roteiro: " + SC6->C6_ROTEIRO, "")
//                   _cStr := _cStr + IIF(!Empty(SC6->C6_DTENVIO),"Data de Envio: " + DTOC(SC6->C6_DTENVIO), "")
//                   IF !EMPTY(SC6->C6_ROTEIRO) .OR. !EMPTY(SC6->C6_DTENVIO)
//                      aAdd( aCols, { _cStr, _cStr, .F. } )
//                   ENDIF
        EndIf

    // Pedidos de Outras Areas
    Else
        // Separacao Simples
        _cStr := Repl( "-", 76 )
        aAdd( aCols, { _cStr, _cStr, .F. } )

        dbSelectArea("SB1")
        dbSeek(xFilial("SB1")+SC6->C6_PRODUTO)

                dbSelectArea("SF4")
        dbSeek(xFilial("SF4")+SC6->C6_TES)

                // Pedido / Item
            _cStr := "Ped/Item:"+SC6->C6_NUM+"/"+SC6->C6_ITEM+"-"+ Subs(SB1->B1_DESC,1,38)
            _cStr := _cStr + Space( 57 - Len(_cStr) )       // + "-" + DTOC(SC6->C6_DATA)
            _cStr := _cStr + "-" + IIf( !Empty(SC6->C6_NUMANT), "Edisa:"+SC6->C6_NUMANT, "" )
            aAdd( aCols, { _cStr, _cStr, .F. } )

        // Quantidade / Valor
        _cStr := "Qtde:" + Str(SC6->C6_QTDVEN,4,0) + " Vlr.Unit:" + Str(SC6->C6_PRCVEN,8,2)
        _cStr := _cStr + " Vlr.Total:" + Str(SC6->C6_VALOR,10,2)
        _cStr := _cStr + " Nat.Oper.:" + AllTrim(SF4->F4_TEXTO)
        aAdd( aCols, { _cStr, _cStr, .F. } )

    EndIf

    dbSelectArea("SC6")
    dbSkip()

End

If !_lSZS .and. "P" $ SC5->C5_NUM .and. SM0->M0_CODIGO == "01"  // Especifico Editora
    _cStr := PadC( "NAO HA PROGRAMACOES PARA ESTA A.V. !", 72 )
    aCols[ Len(aCols), 1 ] := _cStr
EndIf

_cStr := Repl( "=", 76 )
aAdd( aCols, { _cStr, _cStr, .F. } )

//
//   FATURAMENTO ESPECIAL DE A.V.Оs
//

If SM0->M0_CODIGO == "01"               // Especifico Editora Pini
        dbSelectArea("SZV")
        dbSetOrder(1)
        // If SC5->C5_AVESP == "S" .and.
        If dbSeek( xFilial("SZV") + SC5->C5_NUM, .F.)
            _cStr := PadC( "FORMA DE PAGAMENTO / PARCELAMENTO :", 72 )
            aAdd( aCols, { _cStr, _cStr, .F. } )
            _cStr := Repl( "-", 76 )
            aAdd( aCols, { _cStr, _cStr, .F. } )
            _cStr := "PARCELA     VALOR       MES/ANO  N.FISCAL DT. N.F.  SITUACAO  "
                   // XX / XX  9,999,999.99   99/9999  999999   99/99/99  XXXXXXXXX
            aAdd( aCols, { _cStr, _cStr, .F. } )
            While !Eof() .and. SZV->ZV_FILIAL+SZV->ZV_NUMAV == xFilial("SZV")+SC5->C5_NUM
                _cStr := StrZero(SZV->ZV_NPARC,2,0) + " / " + StrZero(SZV->ZV_TOTPARC,2,0) + Space(2)
                _cStr := _cStr + TransForm(SZV->ZV_VALOR, "@E 9,999,999.99") + Space(3)
                _cStr := _cStr + StrZero( Month(SZV->ZV_ANOMES), 2 ) + "/"
                _cStr := _cStr + AllTrim(Str(Year(SZV->ZV_ANOMES))) + Space(2)
                _cStr := _cStr + SZV->ZV_NFISCAL +Space(3)+ DtoC(SZV->ZV_DTNF) + Space(2)
                _cStr := _cStr + IIf( SZV->ZV_SITUAC == "AA", "ATIVO", "CANCELADO" )
                aAdd( aCols, { _cStr, _cStr, .F. } )
                dbSkip()
            End
            _cStr := Repl( "=", 76 )
            aAdd( aCols, { _cStr, _cStr, .F. } )

        ElseIf "P" $ SC5->C5_NUM
            _cStr := PadC( "NAO HA FATURAMENTOS ESPECIAIS !", 72 )
            aAdd( aCols, { _cStr, _cStr, .F. } )
            _cStr := Repl( "=", 76 )
            aAdd( aCols, { _cStr, _cStr, .F. } )

        EndIf

EndIf

//
//      DUPLICATAS / FATURAS PARA O CLIENTE
//
dbSelectArea("SE1")
DbOrderNickName("E1_PEDIDO") //dbSetOrder(27) 20130225 ///dbSetOrder(15) AP5  //20090114 era(21) //20090723 mp10 era(22) //dbSetOrder(26)20100412 //dbSetOrder(26) 20100412
If dbSeek(xFilial("SE1")+SC5->C5_NUM, .F.)
    // MONTA ARQUIVO E INDICE
    _aCampos := {}
    aAdd( _aCampos, { "TIPO"    , "C",  1, 0 })
    aAdd( _aCampos, { "DUPL"    , "C",  6, 0 })
    aAdd( _aCampos, { "PARC"    , "C",  1, 0 })
    aAdd( _aCampos, { "VALOR"   , "N", 14, 2 })
    aAdd( _aCampos, { "EMISSAO" , "D",  8, 0 })
    aAdd( _aCampos, { "VENCTO"  , "D",  8, 0 })
    aAdd( _aCampos, { "BAIXA"   , "D",  8, 0 })
    aAdd( _aCampos, { "MOTBX"   , "C",  9, 0 })
    aAdd( _aCampos, { "PORT"    , "C",  3, 0 })
    aAdd( _aCampos, { "PEDIDO"  , "C",  6, 0 })

    _cNomArq := CriaTrab( _aCampos, .T. )
    dbUseArea(.T.,, _cNomArq,"TRB",.F.,.F.)
    _cKey:="TIPO+PEDIDO+DUPL+PARC"
    Indregua("TRB",_cNomArq,_cKey,,,"AGUARDE....CRIANDO INDICE ")


    // LEVANTAMENTO
    dbSelectArea("SE1")
    While !Eof() .and. SE1->E1_PEDIDO == SC5->C5_NUM
        dbSelectArea("TRB")
        If !dbSeek( SE1->E1_PEDIDO + SE1->E1_NUM + SE1->E1_PARCELA, .F. )
            If !Empty(SE1->E1_BAIXA)
/*                If "DEV" $ SE1->E1_MOTIVO
                    If SE1->E1_PORTADOR == "904"
                        _cMotivo := "L&P"
                    Else
                        _cMotivo := "DEV"
                    EndIf
                ElseIf "DACAO" $ SE1->E1_MOTIVO
                    _cMotivo := "DACAO"
                ElseIf "CAN" $ SE1->E1_MOTIVO
                    _cMotivo := "CANC"
                Else
                    _cMotivo := "PAGTO"
                EndIf */
					//20041220 comentado ateh daki 
					//20041222
						If DTOS(SE1->E1_BAIXA) <> "        " .And. SE1->E1_SALDO==0 .AND. !'LP'$(SE1->E1_MOTIVO);
							.AND. !'CAN'$(SE1->E1_MOTIVO) .AND. !'DEV'$(SE1->E1_MOTIVO) .AND. (!'920'$(SE1->E1_PORTADO) .and. !'930'$(SE1->E1_PORTADO) .and. !'904'$(SE1->E1_PORTADO))  
							_cMotivo := "PAGO"
						Else
						 Do Case
						 Case DTOS(SE1->E1_VENCTO) < DTOS(DDATABASE-30) .AND. !Alltrim(SE1->E1_MOTIVO)$"CAN" .AND. !Alltrim(SE1->E1_PORTADO)$"920/CAN/930" //20041014
							//mInadimpl := TRB->E1_VALOR
							_cMotivo := "INADIMPLENTE"
						 Case DTOS(SE1->E1_VENCTO) < DTOS(DDATABASE) .AND. !Alltrim(SE1->E1_MOTIVO)$"CAN/LP" .AND. !Alltrim(SE1->E1_PORTADO)$"920/CAN/995/930" //20041014
							//mVencido  := TRB->E1_VALOR
							_cMotivo := "VENCIDO"
						 Case Alltrim(SE1->E1_MOTIVO)$"CAN" .OR. alltrim(SE1->E1_PORTADO)$"920/CAN/930"
							//mCanc     := TRB->E1_VALOR
							_cMotivo := "CANCELADO"
						 Case Alltrim(SE1->E1_MOTIVO)=="LP" .or. Alltrim(SE1->E1_PORTADO)$"BLP/995" .or. Alltrim(SE1->E1_PORTADO) == "904" //20041027 ALTERADO E1_CODPORT PARA E1_PORTADO
							_cMotivo := "LP"
						 OtherWise
							//mAberto   := TRB->E1_VALOR
							_cMotivo := ""
						 EndCase
						Endif
            Else
                _cMotivo := ""
            EndIf

            RecLock("TRB", .T.)
            TRB->TIPO   := IIf(Subs(SE1->E1_PEDIDO, 6, 1) == "P", "P", "" )
            TRB->DUPL   := SE1->E1_NUM
            TRB->PARC   := SE1->E1_PARCELA
            TRB->VALOR  := SE1->E1_VALOR
            TRB->EMISSAO:= SE1->E1_EMISSAO
            TRB->VENCTO := SE1->E1_VENCTO
            TRB->BAIXA  := SE1->E1_BAIXA
            TRB->MOTBX  := _cMotivo
            TRB->PORT   := SE1->E1_PORTADO
            TRB->PEDIDO := SE1->E1_PEDIDO
            msUnlock()
        EndIf

        dbSelectArea("SE1")
        dbSkip()
    End

    // APRESENTACAO
    dbSelectArea("TRB")
    dbGoTop()
    If RecCount() > 0
        If Empty(TRB->TIPO)
            _cStr := PadC( "DUPLICATAS / FATURAMENTO PARA O CLIENTE", 72 )
            aAdd( aCols, { _cStr, _cStr, .F. } )
            _cStr := Repl( "-", 76 )
            aAdd( aCols, { _cStr, _cStr, .F. } )
            _cStr := "Dupl/NF P Valor      Emissao  Vencto   Dt.Pgto. Mot.Baixa Port Pedido"
            //        999999  9 999,999.99 99/99/99 99/99/99 99/99/99 XXXXXXXXX  XXX XXXXXX
            aAdd( aCols, { _cStr, _cStr, .F. } )
            While !Eof() .and. Empty(TRB->TIPO)
                _cStr := TRB->DUPL + Space(2) + TRB->PARC + Space(1) + Transform( TRB->VALOR, "@E 999,999.99")
                _cStr := _cStr + Space(1) + DtoC(TRB->EMISSAO) + Space(1) + DtoC(TRB->VENCTO) + Space(1) + DtoC(TRB->BAIXA)
                _cStr := _cStr + Space(1) + TRB->MOTBX + Space(2) + TRB->PORT + Space(1) + TRB->PEDIDO
                aAdd( aCols, { _cStr, _cStr, .F. } )
                dbSkip()
            End
            If !Eof()
                _cStr := Repl( "=", 76 )
                aAdd( aCols, { _cStr, _cStr, .F. } )
            EndIf
        EndIf

        If !Empty(TRB->TIPO) .and. !Eof()
            _cStr := PadC( "DUPLICATAS / FATURAMENTO PARA O CLIENTE", 72 )
            aAdd( aCols, { _cStr, _cStr, .F. } )
            _cStr := Repl( "-", 76 )
            aAdd( aCols, { _cStr, _cStr, .F. } )
            _cStr := "Dupl/NF P Valor      Emissao  Vencto   Dt.Pgto. Mot.Baixa Port Pedido"
            //        999999  9 999,999.99 99/99/99 99/99/99 99/99/99 XXXXXXXXX  XXX XXXXXX
            aAdd( aCols, { _cStr, _cStr, .F. } )
            While !Eof() .and. !Empty(TRB->TIPO)
                _cStr := TRB->DUPL + Space(2) + TRB->PARC + Space(1) + Transform( TRB->VALOR, "@E 999,999.99")
                _cStr := _cStr + Space(1) + DtoC(TRB->EMISSAO) + Space(1) + DtoC(TRB->VENCTO) + Space(1) + DtoC(TRB->BAIXA)
                _cStr := _cStr + Space(1) + TRB->MOTBX + Space(2) + TRB->PORT + Space(1) + TRB->PEDIDO
                aAdd( aCols, { _cStr, _cStr, .F. } )
                dbSkip()
            End
        EndIf

    Else
        _cStr := PadC( "NAO HA DUPLICATAS A APRESENTAR !!!", 72 )
        aAdd( aCols, { _cStr, _cStr, .F. } )

    EndIf

    dbSelectArea("TRB")
    dbCloseArea()
    fErase( _cNomArq + ".DTC")//20121106 era dbf
    fErase( _cNomArq + OrdBagExt() )

EndIf

_cStr := Repl( "=", 76 )
aAdd( aCols, { _cStr, _cStr, .F. } )

_cStr := PadC( "F I M  D A  C O N S U L T A  ! ! !", 72 )
aAdd( aCols, { _cStr, _cStr, .F. } )

_cStr := Repl( "=", 76 )
aAdd( aCols, { _cStr, _cStr, .F. } )

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Array com coordenadas da GetDados no modelo2                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
#IFDEF WINDOWS
        aCGD:={44,5,118,315}
#ELSE
        aCGD:={05,04,20,73}
#ENDIF

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Validacoes na GetDados da Modelo 2                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cLinhaOk        := "AllWaysTrue()"
cTudoOk         := "AllWaysTrue()"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Chamada da Modelo2                                           Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("SA1")
lRetMod2 := Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)

// Posiciona no registro que iniciou
dbSelectArea("SA1")
dbGoto(_nRegSA1)

Return
