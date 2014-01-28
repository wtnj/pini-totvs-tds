#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATA09   ³Autor: Roger Cangianeli       ³ Data:   26/01/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Rotina para Manutencao de Faturamento Programado           ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Especifico PINI Editora Ltda.                              ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfata09(cTipo,nOpc)        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("_NREGSZV,NLASTKEY,AHEADER,NUSADO,_CCLIENTE")
SetPrvt("_CNUMAV,_NTOTPARC,_CVEND,_CLOJA,_CNOMCLI,NLINGETD")
SetPrvt("CTITULO,AC,AR,ACOLS,ACGD,CLINHAOK")
SetPrvt("CTUDOOK,M->ZV_NUMAV,LRETMOD2,_CMSG,_NPOSPAR,_NPOSVAL")
SetPrvt("_NPOSCPG,_NPOSANO,_NPOSNF,_NPOSSER,_NPOSDT,_NPOSTRA")
SetPrvt("_NPOSSIT,_NVEZES,")
Private nOpcx := nOpc

_nRegSZV:= SZV->( Recno() )
nLastKey:= 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Opcao de acesso para o Modelo 2                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// 3,4 Permitem alterar getdados e incluir linhas
// 6 So permite alterar getdados e nao incluir linhas
// Qualquer outro numero so visualiza
If cTipo $ "I"
	nOpcx := 3
ElseIf cTipo $ "A"
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
dbSetOrder(2)

dbSeek("ZV_NPARC")
nUsado:=nUsado+1
AADD(aHeader, { AllTrim(x3_titulo), x3_campo, x3_picture,x3_tamanho,;
	x3_decimal, "ExecBlock('FAT9VG03',.f.,.f.)", x3_usado, x3_tipo, x3_arquivo,;
	x3_context } )

dbSeek("ZV_VALOR")
nUsado:=nUsado+1
AADD(aHeader, { AllTrim(x3_titulo), x3_campo, x3_picture,x3_tamanho,;
    x3_decimal, "Positivo()", x3_usado, x3_tipo, x3_arquivo,;
	x3_context } )

dbSeek("ZV_CONDPAG")
nUsado:=nUsado+1
AADD(aHeader, { AllTrim(x3_titulo), x3_campo, x3_picture,x3_tamanho,;
	x3_decimal, x3_valid, x3_usado, x3_tipo, x3_arquivo,;
	x3_context } )

dbSeek("ZV_ANOMES")
nUsado:=nUsado+1
AADD(aHeader, { AllTrim(x3_titulo), x3_campo, x3_picture,x3_tamanho,;
	x3_decimal, "AllWaysTrue()", x3_usado, x3_tipo, x3_arquivo,;
	x3_context } )

dbSeek("ZV_NFISCAL")
nUsado:=nUsado+1
AADD(aHeader, { AllTrim(x3_titulo), x3_campo, x3_picture,x3_tamanho,;
	x3_decimal, 'ExecBlock("FAT9VG04", .F., .F.)', x3_usado, x3_tipo, x3_arquivo,;
	x3_context } )

dbSeek("ZV_SERIE")
nUsado:=nUsado+1
AADD(aHeader, { AllTrim(x3_titulo), x3_campo, x3_picture,x3_tamanho,;
	x3_decimal, 'ExecBlock("FAT9VG05", .F., .F.)', x3_usado, x3_tipo, x3_arquivo,;
	x3_context } )

dbSeek("ZV_DTNF")
nUsado:=nUsado+1
AADD(aHeader, { AllTrim(x3_titulo), x3_campo, x3_picture,x3_tamanho,;
	x3_decimal, ".F.", x3_usado, x3_tipo, x3_arquivo,;
	x3_context } )

dbSeek("ZV_SITUAC")
nUsado:=nUsado+1
AADD(aHeader, { AllTrim(x3_titulo), x3_campo, x3_picture,x3_tamanho,;
    x3_decimal, "Pertence('AA/CC')", x3_usado, x3_tipo, x3_arquivo,;
	x3_context } )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis do Cabecalho do Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cCliente   := IIf( nOpcx == 3, Space(6), SZV->ZV_CODCLI )
_cNUMAV     := IIf( nOpcx == 3, Space(6), SZV->ZV_NUMAV )
_nTotParc   := IIf( nOpcx == 3, 0, SZV->ZV_TOTPARC )
_cVend      := IIf( nOpcx == 3, Space(6), SZV->ZV_VEND )
_cLoja      := IIf( nOpcx == 3, Space(2), "01" )

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
If cTipo == "A"
    cTitulo:= cCadastro + " - Alteracao"
ElseIf cTipo == "I"
    cTitulo:= cCadastro + " - Inclusao"
ElseIf cTipo == "E"
    cTitulo:= cCadastro + " - Exclusao"
ElseIf cTipo == "V"
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
AADD(aC,{"_cNUMAV"   , {15,10} , "Numero da A.V."  , "@!"    ,"ExecBlock('FAT9VC02',.f.,.f.)",,})
AADD(aC,{"_nTotParc" , {15,200}, "Total Parcelas"  , "@E 99" ,'_nTotParc > 0',,})
AADD(aC,{"_cCliente" , {30,13} , "Cod. do Cliente" , "@!"    ,"ExecBlock('FAT9VC01',.f.,.f.)", "SA1", .F. })
AADD(aC,{"_cLoja"    , {30,227}, "Loja"            , "@!"    ,,, .F.})
AADD(aC,{"_cVend"    , {45,14} , "Cod.Vendedor"    , "@!"    ,, "SA3", })

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
AADD(aR,{"_cNomCli" ,{175,10}, "Cliente ", "@!",,,.F.})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montando aCols                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCols := {}
If nOpcx == 3
    aAdd( aCols, { 0, 0, Space(03), dDataBase, Space(06), Space(03), stod(""), SZV->ZV_SITUAC, .F. } )
	
Else
	dbSelectArea("SZV")
	dbSetOrder(1)
	dbSeek(xFilial("SZV")+_cNUMAV, .T.)
	While !Eof() .and. SZV->ZV_FILIAL+SZV->ZV_NUMAV == xFilial("SZV")+_cNUMAV
        aAdd( aCols, { SZV->ZV_NPARC, SZV->ZV_VALOR, SZV->ZV_CONDPAG, SZV->ZV_ANOMES, SZV->ZV_NFISCAL, SZV->ZV_SERIE, SZV->ZV_DTNF, SZV->ZV_SITUAC, .F. } )
		dbSkip()
	End
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Array com coordenadas da GetDados no modelo2                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aCGD:={65,5,170,290}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Validacoes na GetDados da Modelo 2                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cLinhaOk    := "ExecBlock('FAT9VG01',.f.,.f.)"
cTudoOk     := "ExecBlock('FAT9VG02',.f.,.f.)"
M->ZV_NUMAV := _cNumAV      // Variavel necessaria para Validacao da Parcela

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Modelo2                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Posiciona no registro que iniciou
dbSelectArea("SZV")
dbGoto(_nRegSZV)

If Empty(SZV->ZV_NUMAV) .and. cTipo #'I'
	lRetMod2 := .F.
	_cMsg := "Operacao Ilegal !"
	MsgStop(_cMsg)
Else
	lRetMod2 := Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk,,,,,{125,0,500,600})
EndIf

// Posicao dos Campos na Get Dados
_nPosPar:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_NPARC"})
_nPosVal:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_VALOR"})
_nPosCpg:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_CONDPAG"})
_nPosAno:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_ANOMES"})
_nPosNF := aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_NFISCAL"})
_nPosSER:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_SERIE"})
_nPosDT := aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_DTNF"})
_nPosSit:= aScan( aHeader, {|x| AllTrim(x[2]) == "ZV_SITUAC"})

// No Windows existe a funcao de apoio CallMOd2Obj() que retorna o
// objeto Getdados Corrente
If lRetMod2 .and. cTipo $ "I/E/A"
	
	If cTipo $ "I"
		dbSelectArea("SZV")
		dbSetOrder(1)
		For _nVezes := 1 to Len(aCols)
            If !aCols[_nVezes, Len(aHeader)+1]
                If dbSeek(xFilial("SZV")+_cNUMAV+Str(aCols[_nVezes, 1]), .F.)
                    RecLock("SZV", .F.)
                Else
                    RecLock("SZV", .T.)
                EndIf
                SZV->ZV_FILIAL  := xFilial("SZV")
                SZV->ZV_CODCLI  := _cCliente
                SZV->ZV_NUMAV   := _cNUMAV
                SZV->ZV_TOTPARC := _nTotParc
                SZV->ZV_VEND    := _cVend
                SZV->ZV_NPARC   := aCols[_nVezes, _nPosPar]
                SZV->ZV_VALOR   := aCols[_nVezes, _nPosVal]
                SZV->ZV_CONDPAG := aCols[_nVezes, _nPosCpg]
                SZV->ZV_ANOMES  := aCols[_nVezes, _nPosAno]
                SZV->ZV_NFISCAL := aCols[_nVezes, _nPosNF]
                SZV->ZV_SERIE   := aCols[_nVezes, _nPosSER]
                SZV->ZV_DTNF    := IIf( !Empty(SZV->ZV_NFISCAL), aCols[_nVezes,_nPosDT], stod("") )
                SZV->ZV_TPTRANS := SC5->C5_TPTRANS
                SZV->ZV_SITUAC  := aCols[_nVezes, _nPosSit]
                msUnlock()
            EndIf
            // Escape de seguranca para total de parcelas igual a digitadas
			If _nVezes == _nTotParc
				Exit
			EndIf
		Next
		
	ElseIf cTipo $ "E"
		dbSelectArea("SZV")
		dbSetOrder(1)
		If dbSeek(xFilial("SZV")+_cNUMAV, .F.)
			While !Eof() .and. SZV->ZV_FILIAL == xFilial("SZV") .and. SZV->ZV_NUMAV == _cNUMAV
				RecLock("SZV", .F.)
				dbDelete()
				msUnlock()
				dbSkip()
			End
			_nRegSZV := Recno()     // Posicionamento apos execucao
		Else
			_cMsg := "A A.V. "+_cNUMAV+" Nao Foi Encontrada !!! Verifique."
                MsgBox(_cMsg, "ATENCAO", "ALERT")
		EndIf
		
	ElseIf cTipo $ "A"
		dbSelectArea("SZV")
		dbSetOrder(1)
		If dbSeek(xFilial("SZV")+_cNUMAV, .F.)
			While !Eof() .and. SZV->ZV_NUMAV == _cNUMAV
				RecLock("SZV", .F.)
				dbDelete()
				msUnlock()
				dbSkip()
			End
		EndIf
		
		For _nVezes := 1 to Len(aCols)
            If !aCols[_nVezes, Len(aHeader)+1]
                RecLock("SZV", .T.)
                SZV->ZV_FILIAL  := xFilial("SZV")
                SZV->ZV_CODCLI  := _cCliente
                SZV->ZV_NUMAV   := _cNUMAV
                SZV->ZV_TOTPARC := _nTotParc
                SZV->ZV_VEND    := _cVend
                SZV->ZV_NPARC   := aCols[_nVezes, _nPosPar]
                SZV->ZV_VALOR   := aCols[_nVezes, _nPosVal]
                SZV->ZV_CONDPAG := aCols[_nVezes, _nPosCpg]
                SZV->ZV_ANOMES  := aCols[_nVezes, _nPosAno]
                SZV->ZV_NFISCAL := aCols[_nVezes, _nPosNF]
                SZV->ZV_SERIE   := aCols[_nVezes, _nPosSER]
                SZV->ZV_DTNF    := IIf( !Empty(SZV->ZV_NFISCAL), aCols[_nVezes,_nPosDT], stod("") )
                SZV->ZV_TPTRANS := SC5->C5_TPTRANS
                SZV->ZV_SITUAC  := aCols[_nVezes, _nPosSit]
                msUnlock()
            EndIf
			If _nVezes == 1
				_nRegSZV := Recno()     // Posicionamento apos execucao
			EndIf
			// Escape de seguranca para total de parcelas igual a digitadas
			If _nVezes == _nTotParc
				Exit
			EndIf
		Next
	EndIf
Endif

dbSelectArea("SZV")
dbSetOrder(1)
dbGoTo(_nRegSZV)

Return