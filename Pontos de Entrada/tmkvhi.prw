#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function tmkvhi()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CCLITMK,CLOJA,_SALVAHEADER,_SALVCOLS,_CALIAS,_NINDORDSC6")
SetPrvt("_NREGORDSC6,_NINDORDSE1,_NREGORDSE1,_NINDORDSZ5,_NREGORDSZ5,AHEADER")
SetPrvt("_NUSADO,_NCNT,ACOLS,_X,_CCAMPO,_CVAR1")
SetPrvt("_CVAR2,_CVAR3,_CVAR4,_CVAR5,_ACAMPOS,_CAUX")


 /*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TMKMHI    ³ Autor ³ Fabio William         ³ Data ³ 15.04.97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Browse p/ Consulta dos Itens do Pedido.                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se o Cliente foi Preenchido³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//cCliTmk := "026770"
//cLoja   := "00"

If Empty(cCliTmk)
   MsgAlert("O Codigo do Cliente nao foi preenchido...")
   return nil
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Salva o Aheader                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_SalvAheader := Aheader
_SalvCols    := ACols


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Salva o Alias                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_cAlias := Alias()
DbSelectarea("SC6")
_nIndOrdSC6 := IndexOrd()
_nRegOrdSC6 := Recno()
DbSetOrder(09)  // Cliente
DBSelectArea("SE1")
_nIndOrdSE1 := IndexOrd()
_nRegOrdSE1 := Recno()
DbOrderNickName("C6_CLI") //dbSetOrder(10) 20130225 // Cliente + Loja
DBSelectArea("SZ5")
_nIndOrdSZ5 := IndexOrd()
_nRegOrdSZ5 := Recno()
DbsetOrder(1) // Cliente + Loja


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Posiciona arquivo de Cobranca    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectarea("SZ5")
DbSeek(xFilial()+cCLITMK+CLOJA)



//   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//   ³ Chama a tela de Processamento                          ³
//   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa( {|| RunProc() } )// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> Processa( {|| Execute(RunProc) } )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³RunProc   ³ Autor ³ Fabio William         ³ Data ³ 22/04/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Executa o Processamento de montagem dos menus               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> Function RunProc
Static Function RunProc()


_cAlias := "SC6"
dbSelectArea( _cAlias )
dbGoTop()
aHeader := {}
Select Sx3
DbSetOrder(02)
DbSeek("C6_NUM")
AADD(aHeader,{ TRIM(X3_TITULO), X3_CAMPO, X3_PICTURE,;
    X3_TAMANHO, X3_DECIMAL, " ",;
    X3_USADO, X3_TIPO, X3_ARQUIVO } )
DbSetOrder(01)
Seek _cAlias
_nUsado := 1
While !EOF() .And. X3_ARQUIVO == _cAlias
        If x3_usado != " " .And. cNivel >= X3_NIVEL .and. !RTRIM(X3_CAMPO) $ "C6_FILIAL/C6_COMIS1/C6_TIPOREV"
           _nUsado := _nUsado + 1
             AADD(aHeader,{ TRIM(X3_TITULO), X3_CAMPO, X3_PICTURE,;
                 X3_TAMANHO, X3_DECIMAL, " ",;
                 X3_USADO, X3_TIPO, X3_ARQUIVO } )
	EndIf
        Skip
EndDo


//   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//   ³ Conta quantos registros seram mostrados                ³
//   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea( _cAlias )
DbSeek(xFilial()+cCliTMK)
_nCnt := 0
While !EOF() .AND. SC6->C6_CLI == cCLITMK //.AND. SC6->C6_LOJA == CLOJA
     _nCnt := _nCnt + 1
    DbSkip()
EndDo

//   ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//   ³ Atualiza os campos a serem mostrados                   ³
//   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IF _nCnt == 0
   _nCnt := 1
Endif
aCOLS := Array(_nCnt,_nUsado+1)
dbSelectArea( _cAlias )
DbSeek(xFilial()+cCliTMK)
_nCnt := 0
While !EOF() .AND. SC6->C6_CLI == cCLITMK .AND. SC6->C6_LOJA == CLOJA
      _nCnt := _nCnt+1
//      _nUsado:=1
//      Select SX3
//      aCOLS[_nCnt][_nUsado] := SC6->C6_NUM
//      Seek _cAlias
      For _x := 1 to len (aHeader)
           _cCampo := aHeader[_x][2]
            aCOLS[_nCnt][_x] := &(_cAlias+"->"+_cCampo)
      Next _x
      aCOLS[_nCnt][_x] := .f. //Flag de Delecao
      dbSelectArea( _cAlias )
      Skip
EndDo
If _nCnt == 0
   DbGoBottom()
   dbskip()
      For _x := 1 to len (aHeader)
           _cCampo := aHeader[_x][2]
            aCOLS[1][_x] := &(_cAlias+"->"+_cCampo)
      Next _x
      aCOLS[1][_x] := .f. //Flag de Delecao
Endif
dbSelectArea( _cAlias )
@ 200,1 TO 500,640 DIALOG _odlg3 TITLE "Consulta dos Pedidos"
@ 08,5 SAY "Dados do Pedidos Venda"
@ 20,5 TO 93,300 MULTILINE  FREEZE 2
@ 130,100 BUTTON "_Ok" SIZE 40,15 ACTION Fecha()// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> @ 130,100 BUTTON "_Ok" SIZE 40,15 ACTION Execute(Fecha)
@ 130,150 BUTTON "_Titulos" SIZE 40,15 ACTION TitAberto()// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> @ 130,150 BUTTON "_Titulos" SIZE 40,15 ACTION Execute(TitAberto)


// implementa os dados de cobranca
_cVar1 := sz5->z5_end
_cVar2 := sz5->z5_bairro
_cvar3 := sz5->z5_cidade
_cvar4 := sz5->z5_estado
_cvar5 := sz5->z5_cep
@ 100,5 SAY "Cliente : "
@ 100,35 GET _cVar1
@ 110,5 SAY "Endereco : "
@ 110,35 GET _cVAR2
@ 120,5 SAY "Cidade  : "
@ 120,35 GET _cVAR3
@ 130,5 SAY "Estado : "
@ 130,35 GET _cVAR4
ACTIVATE DIALOG _odlg3 CENTERED
Fecha()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Volta o Aheader                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aheader := _SalvAheader
ACols   := _SalvCols
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Fecha     ³ Autor ³ Fabio William         ³ Data ³ 15.02.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Fecha a Janela e Volta o Alias Correto                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> Function Fecha
Static Function Fecha()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Volta o Alias                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SC6")
DbSetOrder(_nIndOrdSC6)
DbGoTo(_nRegOrdSC6)
DBSelectArea("SE1")
DbSetOrder(_nIndOrdSE1)
DbGoTo(_nRegOrdSE1)
DbSelectArea(_cAlias)
DBSelectArea("SZ5")
DbSetOrder(_nIndOrdSZ5)
DbGoTo(_nRegOrdSZ5)
Close(_odlg3)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³LineOk    ³ Autor ³ Ary Medeiros          ³ Data ³ 15.02.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Validacao da linha digitada na funcao MultiLine             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> Function LineOk
Static Function LineOk()
Return .t.



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³TiteAberto³ Autor ³ Fabio William         ³ Data ³ 29/04/98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Mostra os titulos em aberto                                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> Function TitAberto
Static Function TitAberto()

_cAlias := "SE1"
dbSelectArea( _cAlias )
_aCAMPOS := {'E1_NUM','E1_PARCELA','E1_VALOR','E1_EMISSAO','E1_VENCTO','E1_BAIXA','E1_PORTADO','E1_PEDIDO'}
aHeader := {}
Select Sx3
DbSetOrder(02)
_nUsado := 0
For _x := 1 to len(_aCampos)
    DbSeek(_aCampos[_x])
    _nUsado := _nUsado + 1
    AADD(aHeader,{ TRIM(X3_TITULO), X3_CAMPO, X3_PICTURE,;
                 X3_TAMANHO, X3_DECIMAL, " ",;
                 X3_USADO, X3_TIPO, X3_ARQUIVO } )
Next _x
DbSetOrder(01)

dbSelectArea( _cAlias )
dbSeek(xFilial()+cCliTmk+CLOJA)
_nCnt := 0
While !EOF() .And. SE1->E1_CLIENTE == cCLITMK .AND. SE1->E1_LOJA == CLOJA
//    IF SE1->E1_BAIXA == stod("")
       _nCnt := _nCnt+1
//    Endif
    DbSkip()
EndDo
if _nCnt == 0
   _nCnt := 1
Endif
aCOLS := Array(_nCnt+1,_nUsado+1)
_nCnt := 1

// inicializa  a primeira linha p/ evitar erros de interpretacao
For _x := 1 to len(_aCampos)
    IF _aCampos[_x] == "E1_NUM"
      _cAux := "ABAIXO"
    ELSE
    _cAux := CriaVar(_aCampos[_x])
    ENDIF
    aCOLS[_nCnt][_x] := _cAux
Next _x
aCOLS[_nCnt][len(_aCampos)+1] := .f. //Flag de Delecao

dbSelectArea( _cAlias )
DbSeek(xFilial()+cCLITMK+cLOJA)

While !EOF() .And. SE1->E1_CLIENTE == cCLITMK .AND. SE1->E1_LOJA == CLOJA

//    IF SE1->E1_BAIXA == CTOD(" /  /  ")
       _nCnt := _nCnt+1
        For _x := 1 to len(_aCampos)
            _cAux := &(_cAlias+"->"+_aCampos[_x])
            aCOLS[_nCnt][_x] := _cAux
        Next _x
        aCOLS[_nCnt][len(_aCampos)+1] := .f. //Flag de Delecao
//    endif
    dbSelectArea( _cAlias )
    Skip
EndDo
If _nCnt == 1
   msgalert("Nao ha titulos ")
   return
Endif


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³fecha a janela anterior          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Close(_odlg3)

dbSelectArea( _cAlias )
@ 200,1 TO 500,640 DIALOG _odlg4 TITLE "Titulos "
@ 20,5 TO 93,300 MULTILINE FREEZE 1
@ 120,100 BUTTON "_Ok" SIZE 40,15 ACTION Fecha2()// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> @ 120,100 BUTTON "_Ok" SIZE 40,15 ACTION Execute(Fecha2)
ACTIVATE DIALOG _odlg4 CENTERED
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Fecha2    ³ Autor ³ Fabio William         ³ Data ³ 15.02.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Fecha a Janela e Volta o Alias Correto                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> Function Fecha2
Static Function Fecha2()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Volta o Alias                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SC6")
DbSetOrder(_nIndOrdSC6)
DbGoTo(_nRegOrdSC6)
DBSelectArea("SE1")
DbSetOrder(_nIndOrdSE1)
DbGoTo(_nRegOrdSE1)
DbSelectArea(_cAlias)
Close(_odlg4)
Return
