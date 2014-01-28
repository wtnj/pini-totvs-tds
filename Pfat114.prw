#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
#IFNDEF WINDOWS
    #DEFINE PSAY SAY
#ENDIF

User Function Pfat114()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CALIAS,_NINDEX,_NREG,_LRET,CPERG,NLINHA")
SetPrvt("_NLINPAG,CBTXT,CBCONT,NORDEM,TAMANHO,LIMITE")
SetPrvt("M_PAG,CTITULO,CDESC1,CDESC2,CDESC3,CSTRING")
SetPrvt("CPROGRAMA,ARETURN,NLASTKEY,LCONTINUA,NCARACTER,WNREL")
SetPrvt("_NCONT,_CDATA,_CSAUDA,_CDESC1,_CDESC2,_CDESC3")
SetPrvt("_CDESC4,_CDESC5,_CDESC11,_CDESC12,_CDESC13,_CDESC14")
SetPrvt("_CDESC15,_CDESC20,_CDESC30,_CDESC31,_CDESC32,_AVENCTOS")
SetPrvt("_CULTNUM,_LIMPRIME,_CBANCO,_NVEZES,_CTT,_CTEXTO")
SetPrvt("AREGS,I,J,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     #DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa:  PFAT114  ³Autor: Roger Cangianeli       ³ Data:   04/05/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Carta para Clientes da Publicidade                         ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : ESPECIFICO PINI EDITORA LTDA.                              ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()
_lRet   := .T.

cPerg   := "FAT114"
ValidPerg()

If Pergunte(cPerg)
    #IFDEF WINDOWS
        RptStatus({||_RunProc()}, "Imprimindo Cartas ...")// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>         RptStatus({||Execute(_RunProc)}, "Imprimindo Cartas ...")
    #ELSE
        _RunProc()
    #ENDIF

EndIf

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> __Return(_lRet)
Return(_lRet)        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02


// Execucao do Processamento
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _RunProc
Static Function _RunProc()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Ambientais                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLinha      := 0
_nLinPag    := 55   // Linhas impressas por pagina
CbTxt       := ""
CbCont      := ""
nOrdem      := 7
tamanho     := "P"
limite      := 80
m_pag       := 1
cTitulo     := "Carta para Cliente de Publicidade"
cDesc1      := "Este programa emite cartas indicando o banco portador dos titulos"
cDesc2      := "da Publicidade, por data de Emissao de Notas Fiscais."
cDesc3      := ""
cString     := "SE1"
cprograma   := "PFAT114"
aReturn     := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
nLastKey    := 0
lContinua   := .T.
nCaracter   := 10
MHORA      := TIME()
wnrel       := "PFAT114_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
wnrel       := SetPrint(cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.T.)
	
SetDefault(aReturn,cString)


dbSelectArea("SE1")
dbSetOrder(nOrdem)      // Fil+Vencto+Nome Cli+Prf+Num+Parc.

// Executa Contagem de Registros para Regua
dbSeek(xFilial("SE1")+DtoS(MV_PAR01), .T.)
_nCont  := 0
While !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and.;
    SE1->E1_VENCREA <= MV_PAR02
    If "P" $ SE1->E1_PEDIDO .and. SE1->E1_SALDO > 0
        _nCont := _nCont + 1
    EndIf
    dbSkip()
End

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³    Variaveis que serao Impressas                   ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Variaveis com dizeres acima da impressao das duplicatas.

// Local e Data
_cData  := "Sao Paulo, " + StrZero(Day(dDataBase),2) + " de " +;
    MesExtenso(Month(dDataBase)) + " de " + StrZero(Year(dDataBase),4) + "."

// Saudacao
_cSauda :=  "Prezado Cliente, "

// Mensagem 1
// Codigo BBBBB devera ser mantido, para troca na execucao do programa.
// Podera, se necessario, ser movido para qualquer das cinco variaveis. - RC
_cDesc1 := "Informamos que a cobranca decorrente da(s) Nota(s) Fiscal(is) abaixo, referente"
_cDesc2 := "a anuncios de publicidade, sera encaminhada pelo BBBBB, com o(s)"
_cDesc3 := "seguinte(s) vencimento(s) : "
_cDesc4 := ""
_cDesc5 := ""


// Variaveis com dizeres abaixo da impressao das duplicatas

// Mensagem 2
_cDesc11:= "No caso de o banco nao  entregar o boleto de cobranca ate a data de vencimento,"
_cDesc12:= "solicitamos a gentileza de entrar em contato com o nosso departamento de contas"
_cDesc13:= "a receber, atravez dos telefones  (0xx11)  224-8523 ou 224-8811,  ramais 213 ou"
_cDesc14:= "214, onde serao fornecidas  intrucoes  para  efetuar o pagamento."
_cDesc15:= ""

// Agradecimentos
_cDesc20:= "Certos de sua colaboracao, agradecemos antecipadamente."


// Assinatura
_cDesc30:= "__________________"
_cDesc31:= "Depto. de Cobranca"
_cDesc32:= "PINI EDITORA LTDA."

// Monta Regua e Executa Impressao
SetRegua(_nCont)
dbSeek(xFilial("SE1")+DtoS(MV_PAR01), .T.)
While !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and.;
    SE1->E1_VENCREA <= MV_PAR02

    If !"P" $ SE1->E1_PEDIDO .or. SE1->E1_SALDO <= 0
        dbSkip()
        Loop
    EndIf

    _aVenctos   := {}
    _cUltNum    := SE1->E1_NUM
    _lImprime   := .F.
    _cBanco     := SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA
    While !Eof() .and. SE1->E1_NUM == _cUltNum .and.;
        _cBanco == SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA  .and.;
        SE1->E1_VENCREA <= MV_PAR02

        If !"P" $ SE1->E1_PEDIDO .or. SE1->E1_SALDO <= 0
            dbSkip()
            Loop
        EndIf

        If Empty(_cBanco)
            dbSkip()
            IncRegua()
            _cUltNum    := SE1->E1_NUM
            _cBanco     := SE1->E1_PORTADO+SE1->E1_AGEDEP+SE1->E1_CONTA
            Loop
        EndIf

        _lImprime := .T.
        aAdd( _aVenctos, { SE1->E1_PARCELA, SE1->E1_VENCREA, SE1->E1_VALOR } )
        dbSkip()
        IncRegua()
    End

    If _lImprime
        _RunPrint()
    EndIf

End


Set Devi To Scre
If aRETURN[5] == 1
    Set Printer to
    dbcommitAll()
    ourspool(WNREL)
EndIf

Ms_Flush()

Return


// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _RunPrint
Static Function _RunPrint()

nLinha := 05
@ nLinha, 00 PSAY _cData

nLinha := nLinha + 3
@ nLinha, 00 PSAY _cSauda

dbSelectArea("SA6")
dbSetOrder(1)
dbSeek(xFilial("SA6")+_cBanco)
dbSelectArea("SE1")

nLinha  := nLinha + 3
For _nVezes := 1 to 5
    _cTT    := "_cDesc"+AllTrim(Str(_nVezes,0))
    _cTexto := &_cTT
    _cTexto := IIf("BBBBB" $ _cTexto, StrTran( _cTexto, "BBBBB", AllTrim(SA6->A6_NOME) ), _cTexto )
    If !Empty(_cTexto)
        @ nLinha, 00 PSAY _cTexto
        nLinha := nLinha + 1
    EndIf
Next

nLinha := nLinha + 1

_cTexto := ""
For _nVezes := 1 to Len(_aVenctos)
    If Str(_nVezes) $ "3/5/7/9/11/13/15/17/19/21/23/25"
        @ nLinha,000 PSAY _cTexto
        _cTexto := ""
        nLinha := nLinha + 1
    EndIf
    _cTexto := _cTexto + "     " + _cUltNum + "/" + _aVenctos[ _nVezes, 1 ] + " - " + DtoC(_aVenctos[ _nVezes, 2 ]) +;
               IIf(SE1->E1_MOEDA==1, " - R$ ", " - US$ " ) + AllTrim(Transform(_aVenctos[ _nVezes, 3 ], "@E 999,999,999.99"))
Next

@ nLinha, 000 PSAY _cTexto
nLinha := nLinha + 1

For _nVezes := 1 to 5

    _cTT    := "_cDesc"+AllTrim(Str(10+_nVezes))
    _cTexto := &_cTT
    nLinha := nLinha + 1
    @ nLinha, 00 PSAY _cTexto
Next

nLinha := nLinha + 2

@ nLinha, 000 PSAY _cDesc20
nLinha := nLinha + 7

@ nLinha, 000 PSAY _cDesc30
nLinha := nLinha + 1

@ nLinha, 000 PSAY _cDesc31
nLinha := nLinha + 1

@ nLinha, 000 PSAY _cDesc32
Eject


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
AADD(aRegs,{cPerg,"01","Data Vencimento De  ?","mv_ch1","D",08,0,2,"G","","mv_par01","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Data Vencimento Ate ?","mv_ch2","D",08,0,2,"G","","mv_par02","","","","","","","","","","","","","","",""})
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
