#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Rfatm02()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("_CEMPRESA,_CPATH,_AREGISTRO,_CARQSC5,_CINDSC5,_CARQSC6")
SetPrvt("_CINDSC6,_CARQSF2,_CINDSF2,_CARQSE1,_CINDSE1,_CARQSE3")
SetPrvt("_CINDSE3,_CARQSE5,_CINDSE5,_X,_CCHAVE,_CRESULTADO")
SetPrvt("_AARQATU,_CALIASATU,I,_CCAMPO,_CVALOR,")

/*/

複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: RFATM02   쿌utor: Fabio William          � Data:   07/07/97 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri놹o: Transfere o Pedido de Venda para a Empresa 010             � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento                                      � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿚bjetivo : Este programa transfere o pedido de venda para a empresa   � 굇
굇�         : 010, ele busca os titulos baixados dentro do periodo.      � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//敏컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩔
//납   MV_PAR01  Baixa de               납
//납   MV_PAR02  Baixa ate              납
//읒컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴줄


/*/
    Criterio de Geracao de Pedidos


    Parcela                 Baixa
                            (A) Aberto
                            (B) Baixado

    A,B,C                   A,A,A   Nao  Gera
    A,B,C                   B,A,A   Gera      desde que as baixas tenham mesma data
    A,B,C                   A,B,A   Gera      desde que as baixas tenham mesma data
    A,B,C                   A,A,B   Gera      desde que as baixas tenham mesma data
    A,B,C                   B,A,B   Gera      desde que as baixas tenham mesma data
    A,B,C                   B,B,A   Gera      desde que as baixas tenham mesma data
    A,B,C                   A,B,B   Gera      desde que as baixas tenham mesma data
    A,B,C                   B,B,B   Gera      desde que as baixas tenham mesma data

/*/


pergunte("FATM02",.F.)

// 郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
// �  Defines variaveis correntes    �
// 突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
_cEmpresa  := "010" // Empresa que sera extraido os pedidos
_cpath     := "\SIGA\DADOSADV\"
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define quais os titulos seram levados para a empresa   �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
_aRegistro := {}  // Total de Titulos baixados.

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define tela de apresentacao das campanhas.             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

#IFDEF WINDOWS
   @ 96,42 TO 323,505 DIALOG oDlg5 TITLE "Rotina de Geracao Pedido na Editora"
   @ 8,10 TO 84,222
   @ 91,139 BMPBUTTON TYPE 5 ACTION Pergunte("FATM02")
   @ 91,168 BMPBUTTON TYPE 1 ACTION OkProc()// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>    @ 91,168 BMPBUTTON TYPE 1 ACTION Execute(OkProc)
   @ 91,196 BMPBUTTON TYPE 2 ACTION Close(oDlg5)
   @ 23,14 SAY "Este programa ira gerar os Pedidos de Venda, baseado nos titulos baixados"
   @ 33,14 SAY "   - Ok - Dispara a Geracao "
   ACTIVATE DIALOG oDlg5
   Return
#ELSE

   DrawAdvWin("Rotina de Geracao Pedido " , 8, 0, 12, 75 )
   @ 10, 5 Say " A G U A R D E "
   @ 11, 5 say 'lendo registro ' +str(recno(),6)
   Pergunte("FATM02",.T.)
   OkProc()
   Return

#ENDIF



/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: OKPROC    쿌utor: Fabio William          � Data:   07/07/97 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri놹o: Processamento                                              � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento                                      � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿚bjetivo :                                                            � 굇
굇�         :                                                            � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function Okproc
Static Function Okproc()
#IFDEF WINDOWS
  Close(oDlg5)
#ENDIF


// 郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
// �  Abre os Arquivos               �
// 突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�

_cArqSC5 := _cPath + "SC5"+ _cEmpresa + ".dbf"
_cIndSc5 := _cPath + "SC5"+ _cEmpresa + ordbagext()
dbUseArea( .T.,,_cArqSC5, "TRBSC5", if(.T. .OR. .F., !.F., NIL), .F. )
DbSetIndex(_cIndSc5)

_cArqSC6 := _cPath + "SC6"+ _cEmpresa + ".dbf"
_cIndSc6 := _cPath + "SC6"+ _cEmpresa + ordbagext()
dbUseArea( .T.,,_cArqSC6, "TRBSC6", if(.T. .OR. .F., !.F., NIL), .F. )
DbSetIndex(_cIndSc6)

_cArqSF2 := _cPath + "SF2"+ _cEmpresa + ".dbf"
_cIndSF2 := _cPath + "SF2"+ _cEmpresa + ordbagext()
dbUseArea( .T.,,_cArqSF2, "TRBSF2", if(.T. .OR. .F., !.F., NIL), .F. )
DbSetIndex(_cIndSF2)

_cArqSF2 := _cPath + "SD2"+ _cEmpresa + ".dbf"
_cIndSF2 := _cPath + "SD2"+ _cEmpresa + ordbagext()
dbUseArea( .T.,,_cArqSD2, "TRBSD2", if(.T. .OR. .F., !.F., NIL), .F. )
DbSetIndex(_cIndSD2)

_cArqSE1 := _cPath + "SE1"+ _cEmpresa + ".dbf"
_cIndSE1 := _cPath + "SE1"+ _cEmpresa + ordbagext()
dbUseArea( .T.,,_cArqSE1, "TRBSE1", if(.T. .OR. .F., !.F., NIL), .F. )
DbSetIndex(_cIndSE1)

_cArqSE3 := _cPath + "SE3"+ _cEmpresa + ".dbf"
_cIndSE3 := _cPath + "SE3"+ _cEmpresa + ordbagext()
dbUseArea( .T.,,_cArqSE1, "TRBSE3", if(.T. .OR. .F., !.F., NIL), .F. )
DbSetIndex(_cIndSE1)

_cArqSE5 := _cPath + "SE5"+ _cEmpresa + ".dbf"
_cIndSE5 := _cPath + "SE5"+ _cEmpresa + ordbagext()
dbUseArea( .T.,,_cArqSE5, "TRBSE5", if(.T. .OR. .F., !.F., NIL), .F. )
DbSetIndex(_cIndSE1)

DbSelectArea("SE1")
DbSetOrder(22)  // Filial + Data da Baixa //mp10 era 16

#IFNDEF WINDOWS
   SetRegua(Reccount())
#ENDIF
DbSeek(xFilial()+MV_PAR01,.t.)

// 郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
// �  Verificar todas a duplicatas existentes.                   �
// 突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
Do While !eof()  .and. SE1->E1_BAIXA <= MV_PAR02

   #IFNDEF WINDOWS
      IncRegua()
   #ENDIF

   Aadd(_aRegistro,{SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA})

   DbSkip()

Enddo

// 郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
// �  Avaliar se deve ou nao ser Gerado o Pedido de Renovacao    �
// 突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴�
DbSetOrder(01)  // filial + prefixo + numero + parcela

For _x := 1 to len(_aRegistro)

   _cChave  := _aRegistro[_x][1]+_aRegistro[1][2] // Prefixo + Numero

   _cResultado := ""
   // 萊袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴錮�
   // 납 Verifica os titulos para saber se eles se enquadram       납
   // 납 na geracao do pedido de renovacao                         납
   // 납 o Programa GeraPed ira verificar se ja foi levado o titulo납
   // 납 para o financeiro da outra empresa.                       납
   // 冬袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴賈�
   DbSeek(xFilial()+_cChave)
   Do While !eof() .and. SE1->E1_PREFIXO+SE1->E1_NUM == _cChave
      if SE1->E1_PARCELA == ' '  // Pagamento unico a vista
         GeraPed()
         exit
      Endif
      If SE1->E1_BAIXA == mv_par01
         _cResultado := _cResultado + "B"
      endif
      DbSkip()
   Enddo
   DbSeek(xFilial()+_cChave)
   If "B" $ _cResultado
       GeraPed()
   Endif
Next _x

Return


// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function GeraPed
Static Function GeraPed()

DbSelectArea("SE1")
DbSeek(xFilial()+_cChave)

// 萊袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴錮�
// 납 Verifica se o Pedido foi Transportado.                    납
// 冬袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴賈�
DbSelectArea("SC5")
DbSetorder(01)
DbSeek(xFilial()+SE1->E1_PEDIDO)
If SC5->C5_GERADO == "S"  // Este Pedido Ja foi levado para outra empresa
   Atualiza()  // Atualiza os dados do SE1, SE5
   Return
Endif


// 萊袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴錮�
// 납 Atualiza o SC6                                            납
// 冬袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴賈�

_aArqAtu := "TRBSC6"
_cAliasAtu := "SC6"

DbSelectArea("SC6")
DbSeek(xFilial()+SE1->E1_PEDIDO)
Do While SE1->E1_PEDIDO == SC6->C6_NUM .AND. !eof()
   AtuArq()
   DbSelectArea("SC6")
   Dbskip()
Enddo

// 萊袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴錮�
// 납 Atualiza o SC5                                            납
// 冬袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴賈�

_aArqAtu := "TRBSC5"
_cAliasAtu := "SC5"
AtuArq()

// 萊袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴錮�
// 납 Atualiza o SE1                                            납
// 冬袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴賈�

_aArqAtu := "TRBSE1"
_cAliasAtu := "SE1"
DbSelectArea("SE1")
DbSetOrder(01)
DbSeek(xFilial()+_cChave)
Do While SE1->E1_PREFIXO+SE1->E1_NUM == _cChave .AND. !eof()
   AtuArq()
   DbSelectArea("SE1")
   DbSkip()
Enddo



// 萊袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴錮�
// 납 Atualiza o SE5                                            납
// 冬袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴賈�

_aArqAtu := "TRBSE5"
_cAliasAtu := "SE5"
DbSelectArea("SE5")
DbSetOrder(01)
DbSeek(xFilial()+_cChave)
Do While SE5->E5_PREFIXO+SE5->E5_NUMERO == _cChave .AND. !eof()
   AtuArq()
   DbSelectArea("SE5")
   DbSkip()
Enddo



//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Atualiza o Arquivo _cArqAtu                                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function AtuArq
Static Function AtuArq()
dbSelectArea(_cArqAtu)
RecLock(_cArqAtu,.T.)
For i := 1 TO FCount()
    DbSelectArea(_cAliasAtu)
    _cCampo := Alltrim(Field(i))   // Retorna o Nome do Campo
    if !Alltrim(_cValor) $ "C5_GERADO"  // Nao considerar o Gerado
       _cValor := &_cCampo
       DbSelectArea(_cArqAtu)
       FieldPut(FiledPos(_cCampo),_cValor)
    endif
    DbSelectArea(_cArqAtu)
Next i
DbSelectArea(_aArqAtu)
msunlock()

Return(nil)        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

