#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

User Function Rfin003()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CPERG,CTITULO,CDESC1,CDESC2,CDESC3,CPROGRAMA")
SetPrvt("NLASTKEY,LCONTINUA,NCARACTER,_LANOATU,_CDTINI,_CDTFIM")
SetPrvt("_NMES02,_NMES03,_NMES04,_NMES05,_DDATAINI,_DDATAFIM")
SetPrvt("_CMSG,_CEMPFIL,_NEMPRESA,CFILANT,CEMPANT,_AVALDIV")
SetPrvt("_CDIVISAO,_LIDENT,_NSALDO,_NVALOR,_NACUM,_NPERC")
SetPrvt("_CARQ,_CARQ2,_CNEWARQ,_NVEZES,_CMES,_NMESID01")
SetPrvt("_NMESID02,_NMESID03,_NMESID04,_NMESID05,_NMESID06,_ACAMPOS")
SetPrvt("AREGS,I,J,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFINR03   ³Autor: Roger Cangianeli       ³ Data:   11/05/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio Indices de Cobranca por Produto                  ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Especifico PINI - Modulo Financeiro                        ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Release  : Tratamento a Lucros & Perdas. Roger Cangianeli - 13/09/00  ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Mes de Referencia                    ³
//³ mv_par02             // Ano de Referencia                    ³
//³ mv_par03             // Analitico / Sintetico                ³
//³ mv_par04             // Nome do Arquivo                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG       := 'FINR03'
ValidPerg()

If !PERGUNTE(cPerg)
    Return
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Ambientais                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cTitulo     := "INDICE DE COBRANCA POR PRODUTO - " + IIf(MV_PAR03==1, "Analitico", "Sintetico")
cDesc1      := "Este programa emite os titulos do contas a receber, apresentando  titulos "
cDesc2      := "pagos, L/P e aberto, de forma analitica ou sintetica, conforme parametros."
cDesc3      := "Especifico "+SM0->M0_NOME
cprograma   := "FINR03"
nLastKey    := 0
lContinua   := .T.
nCaracter   := 10

If nLastKey == 27
   Return
Endif


// Analisa qual sera a data inicial
_lAnoAtu := .T.
If Val(mv_par01) < 6
    _lAnoAtu := .F.
EndIf

If Val(mv_par01) == 12
    _cDtIni := "01/07/"
    _cDtFim := "31/12/"
    _nMes02 := 8
    _nMes03 := 9
    _nMes04 := 10
    _nMes05 := 11

ElseIf Val(mv_par01) == 11
    _cDtIni := "01/06/"
    _cDtFim := "30/11/"
    _nMes02 := 7
    _nMes03 := 8
    _nMes04 := 9
    _nMes05 := 10

ElseIf Val(mv_par01) == 10
    _cDtIni := "01/05/"
    _cDtFim := "31/10/"
    _nMes02 := 6
    _nMes03 := 7
    _nMes04 := 8
    _nMes05 := 9

ElseIf Val(mv_par01) == 9
    _cDtIni := "01/04/"
    _cDtFim := "30/09/"
    _nMes02 := 5
    _nMes03 := 6
    _nMes04 := 7
    _nMes05 := 8

ElseIf Val(mv_par01) == 8
    _cDtIni := "01/03/"
    _cDtFim := "31/08/"
    _nMes02 := 4
    _nMes03 := 5
    _nMes04 := 6
    _nMes05 := 7

ElseIf Val(mv_par01) == 7
    _cDtIni := "01/02/"
    _cDtFim := "31/07/"
    _nMes02 := 3
    _nMes03 := 4
    _nMes04 := 5
    _nMes05 := 6

ElseIf Val(mv_par01) == 6
    _cDtIni := "01/01/"
    _cDtFim := "30/06/"
    _nMes02 := 2
    _nMes03 := 3
    _nMes04 := 4
    _nMes05 := 5

ElseIf Val(mv_par01) == 5
    _cDtIni := "01/12/"
    _cDtFim := "31/05/"
    _nMes02 := 1
    _nMes03 := 2
    _nMes04 := 3
    _nMes05 := 4

ElseIf Val(mv_par01) == 4
    _cDtIni := "01/11/"
    _cDtFim := "30/04/"
    _nMes02 := 12
    _nMes03 := 1
    _nMes04 := 2
    _nMes05 := 3

ElseIf Val(mv_par01) == 3
    _cDtIni := "01/10/"
    _cDtFim := "31/03/"
    _nMes02 := 11
    _nMes03 := 12
    _nMes04 := 1
    _nMes05 := 2

ElseIf Val(mv_par01) == 2
    _cDtIni := "01/09/"
    If Year(MV_PAR02)%4 == 0
        _cDtFim := "29/02/"
    Else
        _cDtFim := "28/02/"
    EndIf
    _nMes02 := 10
    _nMes03 := 11
    _nMes04 := 12
    _nMes05 := 1

ElseIf Val(mv_par01) == 1
    _cDtIni := "01/08/"
    _cDtFim := "31/01/"
    _nMes02 := 09
    _nMes03 := 10
    _nMes04 := 11
    _nMes05 := 12

EndIf

If !_lAnoAtu
    _cDtIni := _cDtIni + Str( Val(MV_PAR02) - 1 )
Else
    _cDtIni := _cDtIni + MV_PAR02
EndIf
_cDtFim   := _cDtFim + MV_PAR02

// Datas do Vencimento dos Titulos.
_dDataIni := CtoD(_cDtIni)
_dDataFim := CtoD(_cDtFim)

#IFDEF WINDOWS
    Processa({||RunProc()})// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     Processa({||Execute(RunProc)})
#ELSE
    RunProc()
#ENDIF

Return


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio do Processamento                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function RunProc
Static Function RunProc()

// Gera os arquivos temporarios, conforme opcao
If MV_PAR03 == 2
    _GeraSint()
Else
    _GeraAnal()
EndIf

If "ADMIN" $ Upper(cUsuario)
    _GeraEsp()
EndIf


If !SM0->M0_CODIGO+SM0->M0_CODFIL $ "0101/0201"
    _cMsg := "Programa nao disponivel para esta Empresa e Filial. Favor Verificar !"
    #IFDEF WINDOWS
        MsgBox( _cMsg, "ATENCAO", "ALERT" )
    #ELSE
        Alert( _cMsg )
    #ENDIF

Else
    _cEmpFil := SM0->M0_CODIGO+SM0->M0_CODFIL

EndIf


// Executa o processamento nas duas empresas
// ( Editora Pini e Pini Sistemas, filial 01)

For _nEmpresa := 1 to 2

    If _nEmpresa == 2
        cFilAnt := "01"             // Codigo da Filial a ser Aberta
        If SM0->M0_CODIGO == "01"
            cEmpAnt := "02"         // Codigo da Empresa a ser Aberta
        Else
            cEmpAnt := "01"         // Codigo da Empresa a ser Aberta
        EndIf

        dbCloseAll()
        OpenFile()

        dbUseArea(.T.,,_cArq,"TRB",.F.,.F.)
        // Se Sintetico
        If MV_PAR03 == 2
            IndRegua( "TRB", _cArq, "MES+GRUPO", , , "Indexando TRB..." )
        Else
            IndRegua( "TRB", _cArq, "EMP+GRUPO+NUM+PARC", , , "Indexando TRB..." )
        EndIf

        // Abre espelho do SE1
        If "ADMIN" $ Upper(cUsuario)
            dbUseArea(.T.,,_cArq2,"TR2",.F.,.F.)
            IndRegua( "TR2", _cArq2, "EMP+GRUPO+SERIE+NUM+PARC", , , "Indexando TR2..." )
        EndIf

    EndIf

    dbSelectArea("SE1")
    #IFDEF WINDOWS
        ProcRegua(RecCount())
    #ELSE
        SetRegua(RecCount())
    #ENDIF

    dbSelectArea("SE1")
    dbSetOrder(7)
    dbSeek(xFilial("SE1")+DtoS(_dDataIni), .T. )
    While !Eof() .and. SE1->E1_VENCREA <= _dDataFim

        #IFDEF WINDOWS
            IncProc()
        #ELSE
            IncRegua()
        #ENDIF

        // Desconsiderar series LIV - CP0, cfe.instrucoes Srta.Tatiana
        // 18/07/00 - By RC
        If AllTrim(SE1->E1_SERIE) $ "CP0/LIV"
            dbSkip()
            Loop
        EndIf


        // Este array acumula valores por Divisao de Vendas
        _aValDiv    := {}
        _cDivisao   := "Outros     "+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )

        // Se identificar divisao de vendas e nao for venda Mercantil
        If AllTrim(SE1->E1_DIVVEN) $ "PUBL/SOFT/CURS/ENG"
            If SE1->E1_DIVVEN == "PUBL"
                _cDivisao := "Publicidade"+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )
            ElseIf SE1->E1_DIVVEN == "SOFT"
                _cDivisao := "Software   "+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )
            ElseIf SE1->E1_DIVVEN == "CURS"
                _cDivisao := "Cursos     "+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )
            Else
                _cDivisao := "Engenharia "+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )
            EndIf

            aAdd( _aValDiv, { _cDivisao, SE1->E1_VALOR, SE1->E1_SALDO })

        // Verifica se e da Publicidade, pelo numero do pedido
        ElseIf "P" $ SE1->E1_PEDIDO
            _cDivisao :=     "Publicidade"+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )

            aAdd( _aValDiv, { _cDivisao, SE1->E1_VALOR, SE1->E1_SALDO })

        // Verifica se e Assinatura - By RC - 18/07/00
        ElseIf "ASS" $ SE1->E1_SERIE
            _cDivisao :=     "Assinatura "+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )

            aAdd( _aValDiv, { _cDivisao, SE1->E1_VALOR, SE1->E1_SALDO })

        // Divisao nao identificada
        Else
            // Procura divisao de vendas no pedido
            _lIdent := .F.
            _nSaldo := 0
            _nValor := 0
            _nAcum  := 0

            dbSelectArea("SF2")
            dbSetOrder(1)
            If dbSeek(xFilial("SF2")+SE1->E1_NUM+SE1->E1_SERIE+SE1->E1_CLIENTE+SE1->E1_LOJA, .F.)

                dbSelectArea("SD2")
                dbSetOrder(3)
                If dbSeek(xFilial("SD2")+SE1->E1_NUM+SE1->E1_SERIE+SE1->E1_CLIENTE+SE1->E1_LOJA, .F.)
                    While !Eof() .and. SD2->D2_FILIAL+SD2->D2_DOC+SD2->D2_SERIE == ;
                        xFilial("SD2")+SE1->E1_NUM+SE1->E1_SERIE .and.;
                        SD2->D2_CLIENTE+SD2->D2_LOJA == SE1->E1_CLIENTE+SE1->E1_LOJA

                        dbSelectArea("SB1")
                        If dbSeek(xFilial("SB1")+SD2->D2_COD)
                            _lIdent := .T.
                            // Incluido em 14/02/01 por Raquel - Revista avulsa
                            If AllTrim(SB1->B1_GRUPO) == "0101"
                               _cDivisao := "Livros     "+ IIf(MV_PAR03==1, "-"+AllTrim(SE1->E1_SERIE), "" )
                            EndIf
                            If AllTrim(SB1->B1_GRUPO) == "0100"
                                If AllTrim(SB1->B1_COD) >= "0101001" .and. AllTrim(SB1->B1_COD) < "0109000"
                                    If Subs(SB1->B1_COD,5,3) == "001"
                                        _cDivisao := "Livros     "+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )
                                    Else
                                        _cDivisao := "Assinatura "+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )
                                    EndIf
                                Else
                                    _cDivisao := "Livros     "+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )
                                EndIf

                            // Incluido 27/07/00, cfe.intr.Srta.Raquel/Srta.Tatiana
                            ElseIf Subs(SB1->B1_GRUPO,1,2) == "02" .or. SB1->B1_TIPO == "LI"
                                _cDivisao := "Livros     "+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )

                            ElseIf SB1->B1_TIPO == "RC"
                                _cDivisao := "Rel.Custos "+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )

                            // Inclusao em 25/07/00 cfe.solic.Sra.Sandra/Srta.Tatiana - By RC
                            ElseIf SB1->B1_TIPO $ "TS/SW/PD"
                                _cDivisao := "Software   "+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )

                            Else
                                _cDivisao := "Outros     "+ IIf(MV_PAR05==1, "-"+AllTrim(SE1->E1_SERIE), "" )

                            EndIf

                            _nPerc := NoRound( SD2->D2_TOTAL / SF2->F2_VALBRUT, 6 )
                            _nSaldo:= NoRound( SE1->E1_SALDO * _nPerc, 2 )
                            _nValor:= NoRound( SE1->E1_VALOR * _nPerc, 2 )
                            _nAcum := _nAcum + _nValor

                            aAdd( _aValDiv, { _cDivisao, _nValor, _nSaldo })

                        EndIf

                        dbSelectArea("SD2")
                        dbSkip()

                    End

                    If _nAcum < SE1->E1_VALOR .and. _lIdent
                        _aValDiv[ Len(_aValDiv), 2 ] := _aValDiv[ Len(_aValDiv), 2 ] + ( SE1->E1_VALOR - _nAcum )
                    EndIf

                // IDENTIFICAR O PEDIDO - RC
                EndIf

            EndIf

            If !_lIdent
                _aValDiv    := {}
                aAdd( _aValDiv, { _cDivisao, SE1->E1_VALOR, SE1->E1_SALDO } )
            EndIf

        EndIf

        // Se Sintetico
        If MV_PAR03 == 2
            _GravSint()
        Else
            _GravAnal()
        EndIf

        // Grava espelho do arquivo SE1
        If "ADMIN" $ Upper(cUsuario)
            _GravEsp()
        EndIf

        dbSelectArea("SE1")
        dbSkip()

    End

    If _nEmpresa == 1
        dbSelectArea("TRB")
        _cArq := "RC" + Subs(_cArq,3,6)
        Copy to &_cArq VIA "DBFCDXADS" // 20121106 
        dbCloseArea()

        // Se gera arquivo espelho
        If "ADMIN" $ Upper(cUsuario)
            dbSelectArea("TR2")
            _cArq2 := "RC" + Subs(_cArq2,3,6)
            Copy to &_cArq2 VIA "DBFCDXADS" // 20121106 
            dbCloseArea()
        EndIf

    EndIf

Next


// Gera o Arquivo Sintetico
If MV_PAR03 == 2
    dbSelectArea("TRB")
    _cNewArq := "I:\SIGA\SIGAADV\EXPORTA\"+AllTrim(MV_PAR04)+".DBF"
    Copy to &_cNewArq VIA "DBFCDXADS" // 20121106 
    _cMsg   := "Gerado com sucesso o arquivo " + _cNewArq + "."

// Gera o arquivo Analitico
Else
    #IFNDEF WINDOWS
        SetRegua(5)
    #ELSE
        ProcRegua(5)
    #ENDIF
    dbSelectArea("TRB")
    _cNewArq := "I:\SIGA\SIGAADV\EXPORTA\"+AllTrim(MV_PAR04)+".DBF"
    Copy to &_cNewArq VIA "DBFCDXADS" // 20121106 
    #IFNDEF WINDOWS
        IncRegua()
    #ELSE
        IncProc()
    #ENDIF

    _cNewArq := "I:\SIGA\SIGAADV\EXPORTA\PINISIST.DBF"
    Copy to &_cNewArq for TRB->EMP == "02" 
    #IFNDEF WINDOWS
        IncRegua()
    #ELSE
        IncProc()
    #ENDIF

    _cNewArq := "I:\SIGA\SIGAADV\EXPORTA\OUTROS.DBF"
    Copy to &_cNewArq for TRB->EMP == "01" .and. "Outros" $ TRB->GRUPO
    #IFNDEF WINDOWS
        IncRegua()
    #ELSE
        IncProc()
    #ENDIF

    _cNewArq := "I:\SIGA\SIGAADV\EXPORTA\PUBLICID.DBF"
    Copy to &_cNewArq for TRB->EMP == "01" .and. "Publicidade" $ TRB->GRUPO
    #IFNDEF WINDOWS
        IncRegua()
    #ELSE
        IncProc()
    #ENDIF

    _cNewArq := "I:\SIGA\SIGAADV\EXPORTA\VENDMERC.DBF"
    Copy to &_cNewArq for TRB->EMP == "01" .and.;
                          !AllTrim(TRB->GRUPO) $ "Publicidade/Outros"
    #IFNDEF WINDOWS
        IncRegua()
    #ELSE
        IncProc()
    #ENDIF

    _cMsg   := "Gerado com sucesso o arquivo " + AllTrim(MV_PAR04) + "."

EndIf

dbSelectArea("TRB")
dbCloseArea()
fErase(_cArq+".DBF")
fErase(_cArq+OrdBagExt())


// Retorna aos arquivos Originais
cFilAnt := "01"             // Codigo da Filial a ser Aberta
If SM0->M0_CODIGO == "01"
    cEmpAnt := "02"         // Codigo da Empresa a ser Aberta
Else
    cEmpAnt := "01"         // Codigo da Empresa a ser Aberta
EndIf

dbCloseAll()
OpenFile()

#IFDEF WINDOWS
    MsgBox(_cMsg, "FIM DE PROCESSAMENTO", "STOP")
#ELSE
    Alert(_cMsg)
#ENDIF

Return



//  ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//  º    Funcao de Gravacao do arquivo Analitico            º
//  ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _GravAnal
Static Function _GravAnal()

For _nVezes := 1 to Len(_aValDiv)

    If SE1->E1_BAIXA > _dDataFim .or. Empty(SE1->E1_BAIXA) .or.;
        Subs(SE1->E1_MOTIVO,1,2) == "LP"

        If !dbSeek( cEmpAnt + _aValDiv[_nVezes,1] + SE1->E1_NUM + SE1->E1_PARCELA, .F. )
            RecLock("TRB", .T.)
            TRB->EMP    := cEmpAnt
            TRB->GRUPO  := _aValDiv[_nVezes,1]
            TRB->NUM    := SE1->E1_NUM
            TRB->PARC   := SE1->E1_PARCELA
            TRB->NOME   := SE1->E1_NOMCLI
            TRB->EMISSAO:= SE1->E1_EMISSAO
            TRB->VENCTO := SE1->E1_VENCREA
            TRB->VALOR  := _aValDiv[_nVezes,2]
            TRB->(msUnlock())

        Else
            RecLock("TRB", .F.)
//            If SE1->E1_BAIXA > _dDataFim .or. Empty(SE1->E1_BAIXA)
                TRB->VALOR  := TRB->VALOR + _aValDiv[_nVezes,2]
//            Else
//                TRB->VALOR  := TRB->VALOR + _aValDiv[_nVezes,3]
//            EndIf
            TRB->(msUnlock())

        EndIf

    EndIf

Next

Return



//  ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//  º    Funcao de Gravacao do arquivo Sintetico            º
//  ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _GravSint
Static Function _GravSint()

dbSelectArea("TRB")
_cMes := StrZero(Year(SE1->E1_VENCREA),4) + StrZero(Month(SE1->E1_VENCREA),2)

// Mes Inicial do Relatorio
If Month(SE1->E1_VENCREA) == Month(_dDataIni)   //.or. SE1->E1_BAIXA < SE1->E1_VENCREA
    _nMesId01 := Month(_dDataIni)
    _nMesId02 := _nMes02
    _nMesId03 := _nMes03
    _nMesId04 := _nMes04
    _nMesId05 := _nMes05
    _nMesId06 := Month(_dDataFim)

ElseIf Month(SE1->E1_VENCREA) == _nMes02
    _nMesId01 := _nMes02
    _nMesId02 := _nMes03
    _nMesId03 := _nMes04
    _nMesId04 := _nMes05
    _nMesId05 := Month(_dDataFim)
    _nMesId06 := 0

ElseIf Month(SE1->E1_VENCREA) == _nMes03
    _nMesId01 := _nMes03
    _nMesId02 := _nMes04
    _nMesId03 := _nMes05
    _nMesId04 := Month(_dDataFim)
    _nMesId05 := 0
    _nMesId06 := 0

ElseIf Month(SE1->E1_VENCREA) == _nMes04
    _nMesId01 := _nMes04
    _nMesId02 := _nMes05
    _nMesId03 := Month(_dDataFim)
    _nMesId04 := 0
    _nMesId05 := 0
    _nMesId06 := 0

ElseIf Month(SE1->E1_VENCREA) == _nMes05
    _nMesId01 := _nMes05
    _nMesId02 := Month(_dDataFim)
    _nMesId03 := 0
    _nMesId04 := 0
    _nMesId05 := 0
    _nMesId06 := 0

Else
    _nMesId01 := Month(_dDataFim)
    _nMesId02 := 0
    _nMesId03 := 0
    _nMesId04 := 0
    _nMesId05 := 0
    _nMesId06 := 0

EndIf


For _nVezes := 1 to Len(_aValDiv)

    If !dbSeek( _cMes + _aValDiv[_nVezes,1], .F.)

        RecLock("TRB", .T.)
        TRB->GRUPO  := _aValDiv[_nVezes,1]
        TRB->MES    := _cMes
        TRB->VENCTO := _aValDiv[_nVezes,2]

        // Nao Baixados
        If Empty(SE1->E1_BAIXA) .or. SE1->E1_BAIXA > _dDataFim
            TRB->AB30   := _aValDiv[_nVezes,2]
            TRB->AB60   := IIf( _nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
            TRB->AB90   := IIf( _nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
            TRB->AB120  := IIf( _nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
            TRB->AB150  := IIf( _nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
            TRB->AB180  := IIf( _nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            // Se titulo reabilitado
            If SE1->E1_REAB == "S"
                TRB->REC30  := _aValDiv[_nVezes,2]
                TRB->REC60  := IIf( _nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->REC90  := IIf( _nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->REC120 := IIf( _nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->REC150 := IIf( _nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->REC180 := IIf( _nMesId06 == 0, 0, _aValDiv[_nVezes,2] )
            EndIf

        // Pago em ate 30 Dias Ou pagamentos Antecipados ( 01/06/00 - By RC )
        ElseIf ( Month(SE1->E1_BAIXA) == _nMesId01 .and.;
            Year(SE1->E1_BAIXA) == Year(SE1->E1_VENCREA) ) .or.;
            SE1->E1_BAIXA < SE1->E1_VENCREA

            // Se nao for titulo de Lucros e Perdas
            If Subs(SE1->E1_MOTIVO,1,2) #"LP"
                // Coluna PAGOS
                TRB->PAG30  := _aValDiv[_nVezes,2]
                TRB->PAG60  := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG90  := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG120 := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG150 := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG180 := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := _aValDiv[_nVezes,3]
                TRB->AB60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,3] )

            // Se baixado por Lucros e Perdas
            Else
                TRB->LP30   := _aValDiv[_nVezes,2]
                TRB->LP60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := _aValDiv[_nVezes,2]
                TRB->AB60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            EndIf

        // Pago no Segundo Mes
        ElseIf Month(SE1->E1_BAIXA) == _nMesId02

            // Se nao for titulo de Lucros e Perdas
            If Subs(SE1->E1_MOTIVO,1,2) #"LP"
                // Coluna PAGOS
                TRB->PAG60  := _aValDiv[_nVezes,2]
                TRB->PAG90  := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG120 := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG150 := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG180 := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := _aValDiv[_nVezes,2]
                TRB->AB60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,3] )

            // Se baixado por Lucros e Perdas
            Else
                TRB->LP60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := _aValDiv[_nVezes,2]
                TRB->AB60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            EndIf

        // Pago no Terceiro Mes
        ElseIf Month(SE1->E1_BAIXA) == _nMesId03

            If Subs(SE1->E1_MOTIVO,1,2) #"LP"
                // Coluna PAGOS
                TRB->PAG90  := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG120 := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG150 := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG180 := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := _aValDiv[_nVezes,2]
                TRB->AB60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,3] )

            // Se baixado por Lucros e Perdas
            Else
                TRB->LP90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := _aValDiv[_nVezes,2]
                TRB->AB60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            EndIf


        // Quarto Mes
        ElseIf Month(SE1->E1_BAIXA) == _nMesId04

            If Subs(SE1->E1_MOTIVO,1,2) #"LP"
                // Coluna PAGOS
                TRB->PAG120 := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG150 := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG180 := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := _aValDiv[_nVezes,2]
                TRB->AB60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,3] )

            // Se baixado por Lucros e Perdas
            Else
                TRB->LP120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := _aValDiv[_nVezes,2]
                TRB->AB60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            EndIf


        // Quinto Mes
        ElseIf Month(SE1->E1_BAIXA) == _nMesId05

            If Subs(SE1->E1_MOTIVO,1,2) #"LP"
                // Coluna PAGOS
                TRB->PAG150 := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG180 := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := _aValDiv[_nVezes,2]
                TRB->AB60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,3] )

            // Se baixado por Lucros e Perdas
            Else
                TRB->LP150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := _aValDiv[_nVezes,2]
                TRB->AB60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            EndIf


        // Sexto Mes
        ElseIf Month(SE1->E1_BAIXA) == _nMesId06

            If Subs(SE1->E1_MOTIVO,1,2) #"LP"

                // Coluna PAGOS
                TRB->PAG180 := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := _aValDiv[_nVezes,2]
                TRB->AB60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,3] )

            // Se baixado por Lucros e Perdas
            Else
                TRB->LP180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := _aValDiv[_nVezes,2]
                TRB->AB60   := IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            EndIf

        EndIf

    Else

        RecLock("TRB", .F.)
        TRB->VENCTO := TRB->VENCTO + _aValDiv[_nVezes,2]

        // Nao Baixados
        If Empty(SE1->E1_BAIXA) .or. SE1->E1_BAIXA > _dDataFim
            TRB->AB30   := TRB->AB30  + _aValDiv[_nVezes,2]
            TRB->AB60   := TRB->AB60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
            TRB->AB90   := TRB->AB90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
            TRB->AB120  := TRB->AB120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
            TRB->AB150  := TRB->AB150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
            TRB->AB180  := TRB->AB180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            // Se titulo reabilitado
            If SE1->E1_REAB == "S"
                TRB->REC30  := TRB->REC30  + _aValDiv[_nVezes,2]
                TRB->REC60  := TRB->REC60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->REC90  := TRB->REC90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->REC120 := TRB->REC120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->REC150 := TRB->REC150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->REC180 := TRB->REC180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            EndIf


        // Pago em ate 30 Dias
        ElseIf Month(SE1->E1_BAIXA) == _nMesId01 .or.;  // Tratamento a pgtos
            SE1->E1_BAIXA < SE1->E1_VENCREA             // antecipado.RC 1/6

            // Se nao for titulo de Lucros e Perdas
            If Subs(SE1->E1_MOTIVO,1,2) #"LP"
                // Coluna PAGOS
                TRB->PAG30  := TRB->PAG30 + _aValDiv[_nVezes,2]
                TRB->PAG60  := TRB->PAG60 + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG90  := TRB->PAG90 + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG120 := TRB->PAG120+ IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG150 := TRB->PAG150+ IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG180 := TRB->PAG180+ IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := TRB->AB30  + _aValDiv[_nVezes,3]
                TRB->AB60   := TRB->AB60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB90   := TRB->AB90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB120  := TRB->AB120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB150  := TRB->AB150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB180  := TRB->AB180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,3] )

            // Se baixado por Lucros e Perdas
            Else
                TRB->LP30   := TRB->LP30  + _aValDiv[_nVezes,2]
                TRB->LP60   := TRB->LP60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP90   := TRB->LP90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP120  := TRB->LP120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP150  := TRB->LP150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP180  := TRB->LP180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := TRB->AB30  + _aValDiv[_nVezes,2]
                TRB->AB60   := TRB->AB60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := TRB->AB90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := TRB->AB120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := TRB->AB150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := TRB->AB180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            EndIf

        // Pago no Segundo Mes
        ElseIf Month(SE1->E1_BAIXA) == _nMesId02

            // Se nao for titulo de Lucros e Perdas
            If Subs(SE1->E1_MOTIVO,1,2) #"LP"
                // Coluna PAGOS
                TRB->PAG60  := TRB->PAG60 + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG90  := TRB->PAG90 + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG120 := TRB->PAG120+ IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG150 := TRB->PAG150+ IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG180 := TRB->PAG180+ IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := TRB->AB30  + _aValDiv[_nVezes,2]
                TRB->AB60   := TRB->AB60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB90   := TRB->AB90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB120  := TRB->AB120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB150  := TRB->AB150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB180  := TRB->AB180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,3] )

            // Se baixado por Lucros e Perdas
            Else
                TRB->LP60   := TRB->LP60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP90   := TRB->LP90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP120  := TRB->LP120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP150  := TRB->LP150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP180  := TRB->LP180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := TRB->AB30  + _aValDiv[_nVezes,2]
                TRB->AB60   := TRB->AB60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := TRB->AB90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := TRB->AB120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := TRB->AB150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := TRB->AB180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            EndIf

        // Pago no Terceiro Mes
        ElseIf Month(SE1->E1_BAIXA) == _nMesId03

            If Subs(SE1->E1_MOTIVO,1,2) #"LP"
                // Coluna PAGOS
                TRB->PAG90  := TRB->PAG90  +IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG120 := TRB->PAG120 +IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG150 := TRB->PAG150 +IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG180 := TRB->PAG180 +IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := TRB->AB30  + _aValDiv[_nVezes,2]
                TRB->AB60   := TRB->AB60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := TRB->AB90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB120  := TRB->AB120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB150  := TRB->AB150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB180  := TRB->AB180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,3] )

            // Se baixado por Lucros e Perdas
            Else
                TRB->LP90   := TRB->LP90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP120  := TRB->LP120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP150  := TRB->LP150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP180  := TRB->LP180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := TRB->AB30  + _aValDiv[_nVezes,2]
                TRB->AB60   := TRB->AB60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := TRB->AB90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := TRB->AB120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := TRB->AB150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := TRB->AB180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            EndIf


        // Quarto Mes
        ElseIf Month(SE1->E1_BAIXA) == _nMesId04

            If Subs(SE1->E1_MOTIVO,1,2) #"LP"
                // Coluna PAGOS
                TRB->PAG120 := TRB->PAG120 + _aValDiv[_nVezes,2]
                TRB->PAG150 := TRB->PAG150 +IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG180 := TRB->PAG180 +IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := TRB->AB30  + _aValDiv[_nVezes,2]
                TRB->AB60   := TRB->AB60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := TRB->AB90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := TRB->AB120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB150  := TRB->AB150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB180  := TRB->AB180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,3] )

            // Se baixado por Lucros e Perdas
            Else
                TRB->LP120  := TRB->LP120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP150  := TRB->LP150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP180  := TRB->LP180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := TRB->AB30  + _aValDiv[_nVezes,2]
                TRB->AB60   := TRB->AB60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := TRB->AB90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := TRB->AB120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := TRB->AB150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := TRB->AB180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            EndIf


        // Quinto Mes
        ElseIf Month(SE1->E1_BAIXA) == _nMesId05

            If Subs(SE1->E1_MOTIVO,1,2) #"LP"
                // Coluna PAGOS
                TRB->PAG150 := TRB->PAG150 +IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->PAG180 := TRB->PAG180 +IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := TRB->AB30  + _aValDiv[_nVezes,2]
                TRB->AB60   := TRB->AB60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := TRB->AB90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := TRB->AB120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := TRB->AB150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,3] )
                TRB->AB180  := TRB->AB180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,3] )

            // Se baixado por Lucros e Perdas
            Else
                TRB->LP150  := TRB->LP150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->LP180  := TRB->LP180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

                // Coluna Abertos
                TRB->AB30   := TRB->AB30  + _aValDiv[_nVezes,2]
                TRB->AB60   := TRB->AB60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := TRB->AB90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := TRB->AB120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := TRB->AB150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := TRB->AB180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            EndIf


        // Sexto Mes
        ElseIf Month(SE1->E1_BAIXA) == _nMesId06

            If Subs(SE1->E1_MOTIVO,1,2) #"LP"

                // Coluna PAGOS
                TRB->PAG180 := TRB->PAG180 + _aValDiv[_nVezes,2]

                // Coluna Abertos
                TRB->AB30   := TRB->AB30  + _aValDiv[_nVezes,2]
                TRB->AB60   := TRB->AB60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := TRB->AB90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := TRB->AB120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := TRB->AB150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := TRB->AB180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,3] )

            // Se baixado por Lucros e Perdas
            Else
                TRB->LP180  := TRB->LP180 + _aValDiv[_nVezes,2]

                // Coluna Abertos
                TRB->AB30   := TRB->AB30  + _aValDiv[_nVezes,2]
                TRB->AB60   := TRB->AB60  + IIf(_nMesId02 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB90   := TRB->AB90  + IIf(_nMesId03 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB120  := TRB->AB120 + IIf(_nMesId04 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB150  := TRB->AB150 + IIf(_nMesId05 == 0, 0, _aValDiv[_nVezes,2] )
                TRB->AB180  := TRB->AB180 + IIf(_nMesId06 == 0, 0, _aValDiv[_nVezes,2] )

            EndIf

        EndIf

    EndIf

    // Atualiza Indice de Inadimplencia
    TRB->INA30   := NoRound( TRB->AB30  / TRB->VENCTO, 6 )
    TRB->INA60   := NoRound( TRB->AB60  / TRB->VENCTO, 6 )
    TRB->INA90   := NoRound( TRB->AB90  / TRB->VENCTO, 6 )
    TRB->INA120  := NoRound( TRB->AB120 / TRB->VENCTO, 6 )
    TRB->INA150  := NoRound( TRB->AB150 / TRB->VENCTO, 6 )
    TRB->INA180  := NoRound( TRB->AB180 / TRB->VENCTO, 6 )

    TRB->(msUnlock())

Next

Return


//  ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//  º    Funcao de Gravacao do arquivo Espelho SE1          º
//  ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _GravEsp
Static Function _GravEsp()

For _nVezes := 1 to Len(_aValDiv)

    If SE1->E1_BAIXA <= _dDataFim .and. !Empty(SE1->E1_BAIXA) .and.;
        Subs(SE1->E1_MOTIVO,1,2) #"LP"

        If !dbSeek( cEmpAnt + _aValDiv[_nVezes,1] + SE1->E1_SERIE + SE1->E1_NUM + SE1->E1_PARCELA, .F. )
            RecLock("TR2", .T.)
            TR2->EMP    := cEmpAnt
            TR2->GRUPO  := _aValDiv[_nVezes,1]
            TR2->SERIE  := SE1->E1_SERIE
            TR2->NUM    := SE1->E1_NUM
            TR2->PARC   := SE1->E1_PARCELA
            TR2->VENCTO := SE1->E1_VENCREA
            TR2->VALOR  := _aValDiv[_nVezes,2]
            TR2->(msUnlock())
        Else
            RecLock("TR2", .F.)
                TR2->VALOR  := TR2->VALOR + _aValDiv[_nVezes,2]
            TR2->(msUnlock())
        EndIf

    EndIf

Next

Return

//  ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//  º    Funcao de Geracao do arquivo Sintetico             º
//  ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _GeraSint
Static Function _GeraSint()

_aCampos := { }
aAdd( _aCampos, { "GRUPO"   , "C", 15, 0 } )
aAdd( _aCampos, { "MES"     , "C", 06, 0 } )
aAdd( _aCampos, { "VENCTO"  , "N", 16, 2 } )

// Vencimento 30 Dias
aAdd( _aCampos, { "PAG30"   , "N", 14, 2 } )
aAdd( _aCampos, { "LP30"    , "N", 14, 2 } )
aAdd( _aCampos, { "REC30"   , "N", 14, 2 } )
aAdd( _aCampos, { "AB30"    , "N", 14, 2 } )
aAdd( _aCampos, { "INA30"   , "N", 10, 6 } )

// Vencimento 60 Dias
aAdd( _aCampos, { "PAG60"   , "N", 14, 2 } )
aAdd( _aCampos, { "LP60"    , "N", 14, 2 } )
aAdd( _aCampos, { "REC60"   , "N", 14, 2 } )
aAdd( _aCampos, { "AB60"    , "N", 14, 2 } )
aAdd( _aCampos, { "INA60"   , "N", 10, 6 } )

// Vencimento 90 Dias
aAdd( _aCampos, { "PAG90"   , "N", 14, 2 } )
aAdd( _aCampos, { "LP90"    , "N", 14, 2 } )
aAdd( _aCampos, { "REC90"   , "N", 14, 2 } )
aAdd( _aCampos, { "AB90"    , "N", 14, 2 } )
aAdd( _aCampos, { "INA90"   , "N", 10, 6 } )

// Vencimento 120 Dias
aAdd( _aCampos, { "PAG120"   , "N", 14, 2 } )
aAdd( _aCampos, { "LP120"    , "N", 14, 2 } )
aAdd( _aCampos, { "REC120"   , "N", 14, 2 } )
aAdd( _aCampos, { "AB120"    , "N", 14, 2 } )
aAdd( _aCampos, { "INA120"   , "N", 10, 6 } )

// Vencimento 150 Dias
aAdd( _aCampos, { "PAG150"   , "N", 14, 2 } )
aAdd( _aCampos, { "LP150"    , "N", 14, 2 } )
aAdd( _aCampos, { "REC150"   , "N", 14, 2 } )
aAdd( _aCampos, { "AB150"    , "N", 14, 2 } )
aAdd( _aCampos, { "INA150"   , "N", 10, 6 } )

// Vencimento 180 Dias
aAdd( _aCampos, { "PAG180"   , "N", 14, 2 } )
aAdd( _aCampos, { "LP180"    , "N", 14, 2 } )
aAdd( _aCampos, { "REC180"   , "N", 14, 2 } )
aAdd( _aCampos, { "AB180"    , "N", 14, 2 } )
aAdd( _aCampos, { "INA180"   , "N", 10, 6 } )

_cArq := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,,_cArq,"TRB",.F.,.F.)
IndRegua("TRB",_cArq, "MES+GRUPO", , ,"Indexando TRB...")

Return


// ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
// º   Funcao de Geracao de Dados Analiticos       º
// ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _GeraAnal
Static Function _GeraAnal()

_aCampos := {}
aAdd ( _aCampos, {"EMP"     ,"C", 02, 0 } )
aAdd ( _aCampos, {"GRUPO"   ,"C", 15, 0 } )
aAdd ( _aCampos, {"NUM"     ,"C", 06, 0 } )
aAdd ( _aCampos, {"PARC"    ,"C", 01, 0 } )
aAdd ( _aCampos, {"NOME"    ,"C", 30, 0 } )
aAdd ( _aCampos, {"EMISSAO" ,"D", 08, 0 } )
aAdd ( _aCampos, {"VENCTO"  ,"D", 08, 0 } )
aAdd ( _aCampos, {"VALOR"   ,"N", 14, 2 } )

_cArq := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cArq,"TRB",.F.,.F.)
IndRegua( "TRB", _cArq, "EMP+GRUPO+NUM+PARC", , , "Indexando TRB..." )

Return

// ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
// º   Funcao de Geracao de Arquivo Espelho SE1    º
// ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _GeraEsp
Static Function _GeraEsp()

dbSelectArea("SE1")
_aCampos := {}
aAdd ( _aCampos, {"EMP"     ,"C", 02, 0 } )
aAdd ( _aCampos, {"SERIE"   ,"C", 03, 0 } )
aAdd ( _aCampos, {"NUM"     ,"C", 06, 0 } )
aAdd ( _aCampos, {"PARC"    ,"C", 01, 0 } )
aAdd ( _aCampos, {"VENCTO"  ,"D", 08, 0 } )
aAdd ( _aCampos, {"GRUPO"   ,"C", 15, 0 } )
aAdd ( _aCampos, {"VALOR"   ,"N", 16, 2 } )

_cArq2 := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cArq2,"TR2",.F.,.F.)
IndRegua( "TR2", _cArq2, "EMP+GRUPO+SERIE+NUM+PARC", , , "Indexando TR2..." )

Return


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Funcao    ³VALIDPERG³ Autor ³ Jose Renato July ³ Data ³ 25.01.99 ³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±³Descricao ³ Verifica perguntas, incluindo-as caso nao existam.   ³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±³Uso       ³ SX1                                                  ³±
±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±³Release   ³ 3.0i - Roger Cangianeli - 12/05/99.                  ³±
±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function VALIDPERG
Static Function VALIDPERG()

cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs    := {}
dbSelectArea("SX1")
dbSetOrder(1)
AADD(aRegs,{cPerg,"01","Mes de Referencia  ?","mv_ch1","C",02,0,2,"G","","mv_par01","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Ano de Referencia  ?","mv_ch2","C",04,0,2,"G","","mv_par02","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Analitico/Sintetico?","mv_ch3","N",01,0,2,"C","","mv_par03","Analitico","","","Sintetico","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Nome do Arquivo    ?","mv_ch4","C",08,0,2,"G","","mv_par04","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Separar Series     ?","mv_ch5","N",01,0,2,"C","","mv_par05","Sim","","","Nao","","","","","","","","","","",""})
For i := 1 to Len(aRegs)
  If !dbSeek(cPerg+aRegs[i,2])
     RecLock("SX1",.T.)
     For j := 1 to FCount()
        If j <= Len(aRegs[i])
           FieldPut(j,aRegs[i,j])
        Endif
     Next
     SX1->(MsUnlock())
  Endif
Next
Return

