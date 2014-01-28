#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Rfatdbg()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_NREGSZS,NLASTKEY,VARPAR,NOPCX,AHEADER,NUSADO")
SetPrvt("_ACAMPOS,_CNAOEDIT,_NVEZES,_CVALID,_CCLIENTE,_CLOJA")
SetPrvt("_DEMISSAO,_CFATPROG,_CNUMAV,_CVEND,_CNOMCLI,NLINGETD")
SetPrvt("CTITULO,AC,AR,ACOLS,ACGD,CLINHAOK")
SetPrvt("CTUDOOK,LRETMOD2,_CMSG,_NPOSVAL,_NPOSCPG,_NPOSNF")
SetPrvt("_NPOSSER,_NPOSDT,_NPOSIT,_NPOSINS,_NPOSVEI,_NPOSMAT")
SetPrvt("_NPOSPRD,_NPOSREV,_NPOSTIT,_NPOSCVE,_NPOSDTC,_NPOSDTL")
SetPrvt("_NPOSLFA,_NPOSEDI,_NPOSSIT,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATA11   ³Autor: Roger Cangianeli       ³ Data:   26/01/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Rotina para Manutencao de Programacao de A.V.'s            ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Especifico PINI Editora Ltda.                              ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
_nRegSZS:= SZS->( Recno() )
nLastKey:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcao de acesso para o Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza

VARPAR    := "A"

If VARPAR $ "I"
    nOpcx := 3
ElseIf VARPAR $ "A"
    nOpcx := 6
Else
    nOpcx := 5
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aHeader                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aHeader:={}
nUsado:=0

dbSelectArea("SX3")
dbSetOrder(1)
_aCampos := {}
// Campos nao editados na Get Dados
_cNaoEdit:= "ZS_CODCLI/ZS_EMISSAO/ZS_FATPROG/ZS_FILIAL/ZS_FLAGPRO/ZS_NUMAV/"
_cNaoEdit:= _cNaoEdit + "ZS_OK/ZS_USERLGA/ZS_USERLGI/ZS_VEND"
dbSeek( "SZS" )
While !Eof() .and. SX3->X3_ARQUIVO == "SZS"
    If !AllTrim(SX3->X3_CAMPO) $ _cNaoEdit
        aAdd( _aCampos, SX3->X3_CAMPO )
        nUsado := nUsado + 1
    EndIf
    dbSkip()
End

dbSetOrder(2)
For _nVezes := 1 to Len(_aCampos)
    dbSeek(_aCampos[_nVezes])

    _cValid := "AllWaysTrue()"
    If AllTrim(_aCampos[_nVezes]) $ "ZS_NUMINS"
        _cValid := "ExecBlock('FAT11VG3', .F., .F.)"

    ElseIf AllTrim(_aCampos[_nVezes]) $ "ZS_NFISCAL"
        _cValid := "ExecBlock('FAT11VG4', .F., .F.)"

    ElseIf AllTrim(_aCampos[_nVezes]) $ "ZS_SERIE"
        _cValid := "ExecBlock('FAT11VG5', .F., .F.)"

    ElseIf AllTrim(_aCampos[_nVezes]) $ "ZS_EDICAO"
        _cValid := "ExecBlock('FAT11VG6', .F., .F.)"

    ElseIf AllTrim(_aCampos[_nVezes]) $ "ZS_DTNF"
        _cValid := ".F."

    ElseIf AllTrim(_aCampos[_nVezes]) $ "ZS_CONDPAG"
        _cValid := "ExistCpo('SE4', M->ZS_CONDPAG)"

    ElseIf AllTrim(_aCampos[_nVezes]) $ "ZS_SITUAC"
        _cValid := "Pertence('AA/CC')"

    EndIf

    aAdd( aHeader, { AllTrim(x3_titulo), x3_campo, x3_picture, x3_tamanho,;
        x3_decimal, _cValid, x3_usado, x3_tipo, x3_arquivo, x3_context } )

Next


// Posiciona no Pedido de Venda
dbSelectArea("SC5")
dbSetOrder(1)
dbSeek( xFilial("SC5")+SZS->ZS_NUMAV )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Cabecalho do Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cCliente   := IIf( nOpcx == 3, Space(6), SZS->ZS_CODCLI )
_cLoja      := IIf( nOpcx == 3, Space(2), "01" )
_dEmissao   := IIf( nOpcx == 3, stod(""), SC5->C5_EMISSAO )
_cFatProg   := IIf( nOpcx == 3, Space(1), SZS->ZS_FATPROG )
_cNumAV     := IIf( nOpcx == 3, Space(6), SZS->ZS_NUMAV )
_cVend      := IIf( nOpcx == 3, Space(6), SZS->ZS_VEND )

If nOpcx #3
	dbSelectArea("SA1")
	dbSetOrder(1)
	If dbSeek(xFilial("SA1")+_cCliente, .F.)
		_cLoja   := SA1->A1_LOJA
		_cNomCli := IIf( !Empty(SA1->A1_NREDUZ), SA1->A1_NREDUZ, Subs(SA1->A1_NOME,1,20) )
	EndIf

Else
	_cNomCli := Space(20)

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Rodape do Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLinGetD:=0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Titulo da Janela                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If VARPAR == "A"
    cTitulo:= cCadastro + " - Alteracao"

ElseIf VARPAR == "I"
    cTitulo:= cCadastro + " - Inclusao"

ElseIf VARPAR == "E"
    cTitulo:= cCadastro + " - Exclusao"

ElseIf VARPAR == "V"
    cTitulo:= cCadastro + " - Visualizar"

Else
    cTitulo:= cCadastro

EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Cabecalho do Modelo 2      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aC:={}
// aC[n,1] = Nome da Variavel Ex.:"cCliente"
// aC[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aC[n,3] = Titulo do Campo
// aC[n,4] = Picture
// aC[n,5] = Validacao
// aC[n,6] = F3
// aC[n,7] = Se campo e' editavel .t. se nao .f.
#IFDEF WINDOWS
    AADD(aC,{"_cNumAV"   , {15,10} , "Numero da A.V."  , "@!"   ,"ExecBlock('FAT11VC1',.f.,.f.)",,})
    AADD(aC,{"_dEmissao" , {15,200}, "Data Emissao "   , "@D"   ,,, .F. })
    AADD(aC,{"_cCliente" , {27,10} , "Cod. do Cliente" , "@!"   ,,, .F. })
    AADD(aC,{"_cLoja"    , {27,200}, "Loja"            , "@!"   ,,, .F. })
    AADD(aC,{"_cVend"    , {39,10} , "Cod.Vendedor"    , "@!"   ,'ExistCpo("SA3", _cVend )', "SA3", })
    AADD(aC,{"_cFatProg" , {39,200}, "Fat.Programado ?", "@!"   ,,, })

#ELSE
    AADD(aC,{"_cNumAV"   , {4,5} , "Numero da A.V."     , "@!"  ,"ExecBlock('FAT11VC1',.f.,.f.)",, })
    AADD(aC,{"_dEmissao" , {4,40}, "Data Emissao "      , "@D"  ,,, .F. })
    AADD(aC,{"_cCliente" , {5,5} , "Cod. do Cliente"    , "@!"  ,,, .F. })
    AADD(aC,{"_cLoja"    , {5,40}, "Loja"               , "@!"  ,,, .F. })
    AADD(aC,{"_cVend"    , {6,5} , "Cod.Vendedor"       , "@!"  ,'ExistCpo("SA3", _cVend )', "SA3", })
    AADD(aC,{"_cFatProg" , {6,40}, "Fat.Programado ?"   , "@!"  ,,, })

#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com descricao dos campos do Rodape do Modelo 2         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aR:={}
// aR[n,1] = Nome da Variavel Ex.:"cCliente"
// aR[n,2] = Array com coordenadas do Get [x,y], em Windows estao em PIXEL
// aR[n,3] = Titulo do Campo
// aR[n,4] = Picture
// aR[n,5] = Validacao
// aR[n,6] = F3
// aR[n,7] = Se campo e' editavel .T. se nao .F.
#IFDEF WINDOWS
    AADD(aR,{"_cNomCli" ,{130,10}, "Cliente ", "@!",,,.F.})
#ELSE
    AADD(aR,{"_cNomCli" , {22,05}, "Cliente ", "@!",,,.F.})
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aCols                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCols   := {}

dbSelectArea("SZS")
dbSetOrder(5)           // NUM + ITEM + INSERCAO
If !dbSeek(xFilial("SZS")+_cNumAV, .F.)
//If nOpcx == 3
    aAdd( aCols, { 0, Space(4), 0, 0, stod(""), Space(15), Space(6),;
        Space(3), Space(4), Space(4), Space(2), stod(""), stod(""),;
        Space(6), Space(3), stod(""), 0, Space(3), .F. } )

Else
    While !Eof() .and. SZS->ZS_FILIAL+SZS->ZS_NUMAV == xFilial("SZS")+_cNumAV
        aAdd( aCols, { ZS_ITEM, ZS_CODREV, ZS_NUMINS, ZS_EDICAO, ZS_DTCIRC,;
            ZS_CODPROD, ZS_CODMAT, ZS_CODTIT, ZS_CODVEIC, ZS_VEIC, ZS_SITUAC,;
            ZS_LIBPROG, ZS_LIBFAT, ZS_NFISCAL, ZS_SERIE, ZS_DTNF, ZS_VALOR,;
            ZS_CONDPAG, .F. } )
		dbSkip()
	End

Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com coordenadas da GetDados no modelo2                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF WINDOWS
    aCGD:={44,5,118,315}
#ELSE
    aCGD:={08,04,19,73}
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//cLinhaOk    := "ExecBlock('FAT11VG1',.f.,.f.)"
//cTudoOk     := "ExecBlock('FAT11VG2',.f.,.f.)"
cLinhaOk    := "AllWaysTrue()"
cTudoOk     := "AllWaysTrue()"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Modelo2                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Posiciona no registro que iniciou
dbSelectArea("SZS")
dbGoto(_nRegSZS)

If Empty(SZS->ZS_NUMAV) .and. VARPAR #'I'
	lRetMod2 := .F.
	_cMsg := "Operacao Ilegal !"
	#IFDEF WINDOWS
        MsgStop(_cMsg)
	#ELSE
        Alert(_cMsg)
	#ENDIF
	
Else
	lRetMod2 := Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)

EndIf


// Posicao dos Campos na Get Dados
_nPosVal:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_VALOR"})
_nPosCpg:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_CONDPAG"})
_nPosNF := aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_NFISCAL"})
_nPosSER:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_SERIE"})
_nPosDT := aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_DTNF"})
_nPosIt := aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_ITEM"})
_nPosIns:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_NUMINS"})
_nPosVei:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_VEIC"})
_nPosMat:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_CODMAT"})
_nPosPrd:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_CODPROD"})
_nPosRev:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_CODREV"})
_nPosTit:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_CODTIT"})
_nPosCve:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_CODVEIC"})
_nPosDTC:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_DTCIRC"})
_nPosDTL:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_LIBPROG"})
_nPosLfa:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_LIBFAT"})
_nPosEdi:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_EDICAO"})
_nPosSit:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZS_SITUAC"})


// No Windows existe a funcao de apoio CallMOd2Obj() que retorna o
// objeto Getdados Corrente
If lRetMod2 .and. VARPAR $ "I/E/A"
	
    If VARPAR $ "E"
        dbSelectArea("SZS")
        dbSetOrder(5)
        If dbSeek(xFilial("SZS")+_cNUMAV, .F.)
            While !Eof() .and. SZS->ZS_NUMAV == _cNUMAV
                RecLock("SZS", .F.)
				dbDelete()
				msUnlock()
				dbSkip()
			End
            _nRegSZS := Recno()     // Posicionamento apos execucao
			
		Else
			_cMsg := "A A.V. "+_cNUMAV+" Nao Foi Encontrada !!! Verifique."
			#IFDEF WINDOWS
                MsgBox(_cMsg, "ATENCAO", "ALERT")
			#ELSE
                Alert(_cMsg)
			#ENDIF
			
		EndIf
		
    ElseIf VARPAR $ "I/A"
        dbSelectArea("SZS")
        dbSetOrder(5)
        If dbSeek(xFilial("SZS")+_cNUMAV, .F.)
            While !Eof() .and. SZS->ZS_NUMAV == _cNUMAV
                RecLock("SZS", .F.)
				dbDelete()
				msUnlock()
				dbSkip()
			End
		EndIf
		
		For _nVezes := 1 to Len(aCols)
            If !aCols[ _nVezes, Len(aHeader)+1 ]
                RecLock("SZS", .T.)
                SZS->ZS_FILIAL  := xFilial("SZS")
                SZS->ZS_NUMAV   := _cNumAv
                SZS->ZS_ITEM    := aCols[_nVezes, _nPosIt]
                SZS->ZS_CODREV  := aCols[_nVezes, _nPosRev]
                SZS->ZS_NUMINS  := aCols[_nVezes, _nPosIns]
                SZS->ZS_EDICAO  := aCols[_nVezes, _nPosEdi]
                SZS->ZS_DTCIRC  := aCols[_nVezes, _nPosDTC]
                SZS->ZS_CODPROD := aCols[_nVezes, _nPosPrd]
                SZS->ZS_CODMAT  := aCols[_nVezes, _nPosMat]
                SZS->ZS_CODTIT  := aCols[_nVezes, _nPosTit]
                SZS->ZS_CODVEIC := aCols[_nVezes, _nPosCve]
                SZS->ZS_VEIC    := aCols[_nVezes, _nPosVei]
                SZS->ZS_SITUAC  := aCols[_nVezes, _nPosSit]
                SZS->ZS_LIBPROG := aCols[_nVezes, _nPosDTL]
                SZS->ZS_LIBFAT  := aCols[_nVezes, _nPosLfa]
                SZS->ZS_NFISCAL := aCols[_nVezes, _nPosNF]
                SZS->ZS_SERIE   := aCols[_nVezes, _nPosSER]
                SZS->ZS_DTNF    := IIf( !Empty(SZS->ZS_NFISCAL), aCols[_nVezes,_nPosDT], stod("") )
                SZS->ZS_EMISSAO := _dEmissao
                SZS->ZS_VALOR   := aCols[_nVezes, _nPosVal]
                SZS->ZS_VEND    := _cVend
                SZS->ZS_CONDPAG := aCols[_nVezes, _nPosCpg]
                SZS->ZS_CODCLI  := _cCliente
                SZS->ZS_FATPROG := _cFatProg
                msUnlock()
            EndIf
            If _nVezes == 1
                _nRegSZS := Recno()     // Posicionamento apos execucao
			EndIf
		Next
		
	EndIf
	
Endif

dbSelectArea("SZS")
dbSetOrder(5)
dbGoTo(_nRegSZS)

Return
