#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
  #DEFINE PSAY SAY
#ENDIF

User Function Rfatr30a()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CPERG,CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO")
SetPrvt("ARETURN,NOMEPROG,LIMITE,ALINHA,NLASTKEY,NLIN")
SetPrvt("TITULO,CCABEC1,CCABEC2,CCANCEL,M_PAG,WNREL")
SetPrvt("_CIND,_CKEY,MLIMITE,_CFILTRO,_MPROD,_MQTDE")
SetPrvt("_MTOTP,_MVAL,_MNUM,_MDESCR,_MCONT,_MOTIVO")
SetPrvt("_MHIST,_MPERC,_MDESP,_MNOTA,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>   #DEFINE PSAY SAY
#ENDIF
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: RFATR30A  쿌utor: Rosane Rodrigues       � Data:   08/03/00 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri놹o: RELATORIO DE PGTOS POR PRODUTO - ATE 31/10/00(EMISSAO)     � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento         -alterado em 11/12/00solange � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//�   Parametros Utilizados                   �
//�   mv_par01 = Produto  Inicial             �
//�   mv_par02 = Produto  Final               �
//�   mv_par03 = Data Inicial                 �
//�   mv_par04 = Data Final                   �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

cPerg    := "FAT018"
If !Pergunte(CPERG)
   Return
EndIf
cString  := "SC6"
cDesc1   := PADC("Este programa emite o relat줿io dos pagamentos",70)
cDesc2   := PADC("por produto no per죓do solicitado, emissao ate 31/10/00",70)
cDesc3   := PADC("Obs: os pedidos com S굍ie CP0 e LIV n�o aparecem no relat줿io",70)
tamanho  := "M"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFATR30A"
limite   := 132
aLinha   := { }
nLastKey := 0
nLin     := 80
titulo   := "Pagamentos por Produto"
cCabec1  := "Produto Inicial : " + MV_PAR01 + SPACE(04) + "Produto Final : " + MV_PAR02 + SPACE(04) +;
            "Dt. Pagto Inicial : " + DTOC(MV_PAR03) + SPACE(04) + "Dt. Pagto Final : " + DTOC(MV_PAR04)
cCabec2  := "Emiss�es at� 31/10/2000"
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1               //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel    := "RFATR30A_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)       //Nome Default do relatorio em Disco
wnrel    := SetPrint(cString,wnrel,cPerg,space(25)+titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

SetDefault(aReturn,cString)

IF NLASTKEY==27 .OR. NLASTKEY==65
   RETURN
ENDIF

// 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// 쿎hama Relatorio                                �
// 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
#IFDEF WINDOWS
   RptStatus({|| RptDetail() })// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>    RptStatus({|| Execute(RptDetail) })
#ELSE
   RptDetail()
#ENDIF
Return
/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    쿝ptDetail � Autor � Ary Medeiros          � Data � 15.02.96 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o 쿔mpressao do corpo do relatorio                             낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function RptDetail
Static Function RptDetail()

dbSelectArea("SE5")
_cInd    := CriaTrab(NIL,.F.)
_cKey    := "E5_FILIAL+E5_NUMERO+E5_PARCELA"
IndRegua("SE5",_cInd,_cKey,,,"Selecionando registros .. ")

MLIMITE := CTOD("31/10/2000")


dbSelectArea("SE1")
** ACRESCENTADO O ULTIMO FILTRO(DT EMISSAO ATE 31/10/00)
_cInd    := CriaTrab(NIL,.F.)
_cKey    := "E1_FILIAL+E1_PEDIDO+E1_NUM+E1_PARCELA"

_cFiltro := "E1_FILIAL =='"+xFilial("SE1")+"'"
_cFiltro := _cFiltro+" .and. DTOS(E1_DTALT) >= '" +DTOS(MV_PAR03)+ "'"
_cFiltro := _cFiltro+" .and. DTOS(E1_DTALT) <= '" +DTOS(MV_PAR04)+ "'"
_cFiltro := _cFiltro+" .and. !Empty(E1_BAIXA) .and. !E1_SERIE $ 'LIV/CP0' "
_cFiltro := _cFiltro+" .and. DTOS(E1_EMISSAO) <= '" +DTOS(MLIMITE)+ "'"

IndRegua("SE1",_cInd,_cKey,,_cFiltro,"Selecionando registros .. ")

dbSelectArea("SC6")
_cInd    := CriaTrab(NIL,.F.)
_cKey    := "C6_FILIAL+C6_PRODUTO+C6_NUM"
IndRegua("SC6",_cInd,_cKey,,,"Selecionando registros .. ")

SetRegua(Reccount()/7)
dbSeek(xFilial("SC6")+MV_PAR01,.T.)

_mProd := " "
_mQtde := 0
_mtotp := 0

While !eof() .and. sc6->c6_produto <= mv_par02
    IncRegua()

    _mval   := 0
    _mnum   := SC6->C6_NUM
    _mDescr := " "
    _mCont  := 0
    _motivo := " "
    _mHist  := " "

    If _mProd <> SC6->C6_PRODUTO .and. _mProd <> " " .and. _mtotp <> 0
       nLin     := nLin + 2
       @ nlin,000 PSAY "Total de Pagamentos ..................................: "
       @ nlin,056 PSAY STR(_mQtde,6)
       @ nlin,108 PSAY _mtotp PICTURE "@E 9,999,999.99"
       _mQtde := 0
       _mtotp := 0
       nLin   := 80
    Endif

    DbSelectArea("SC5")
    DbSetOrder(01)
    DbSeek(xFilial("SC5")+_mnum)
    if Found()
       _mPerc := (SC6->C6_VALOR * 100) / SC5->C5_VLRPED
       _mDesp := SC5->C5_DESPREM

       DbSelectArea("SZ9")
       DbSetOrder(01)
       DbSeek(xFilial("SZ9")+SC5->C5_TIPOOP)
       If Found()
          _mDescr := SUBSTR(SZ9->Z9_DESCR,1,19)
       Endif

       DbSelectArea("SE1")
       DbSeek(xFilial("SE1")+_mnum,.T.)
       if found()
          Do While _mnum == SE1->E1_PEDIDO
             IF 'LUCROS E PERDAS' $(E1_HIST) .OR. 'NF CANCELA' $(E1_HIST) .OR.;
                'CAN' $(E1_MOTIVO)
                _motivo := SE1->E1_MOTIVO
                _mHist  := SE1->E1_HIST
             ENDIF

             DbSelectArea("SE5")
             DbSeek(xFilial("SE5")+SE1->E1_NUM+SE1->E1_PARCELA)
             If Found()
                IF 'CAN' $(E5_MOTBX)
                    _motivo := SE5->E5_MOTBX
                Endif
             Endif

             if nLin > 59
                nLin     := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18)
                nLin     := nLin + 2
                @ nlin,00 PSAY "Produto :  " + SC6->C6_DESCRI
                nLin     := nLin + 2
                             //           1         2         3         4         5         6         7         8         9        10        11        12        13
                             // 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012






//34567890123456789012345678901234567890123456789
                @ nlin,00 PSAY "Pedido  Cliente  Nome do Cliente                          Qtde  Forma de Pgto        Valor Total   Duplicata  Valor Parcela  Dt.Pgto."
                nLin     := nLin + 1
                @ nlin,00 PSAY "------  -------  ---------------------------------------- ----  -------------------  ------------  ---------  -------------  --------"
                nLin     := nLin + 1
             Endif
             nLin := nLin + 1

             _mval := SE1->E1_VALOR

             If _mCont == 0
                @ nlin,000 PSAY SE1->E1_PEDIDO
                @ nlin,008 PSAY SC6->C6_CLI
                dbSelectArea("SA1")
                dbSetOrder(1)
                dbSeek(xFilial("SA1")+SC6->C6_CLI)
                @ nlin,017 PSAY SA1->A1_NOME
                @ nlin,058 PSAY STR(SC6->C6_QTDVEN,4)
                @ nlin,064 PSAY _mDescr
                @ nlin,086 PSAY SC5->C5_VLRPED * (_mPerc / 100) PICTURE "@E 99,999.99"
                _mQtde := _mQtde + SC6->C6_QTDVEN
                _mCont := 1
             Endif
             If SE1->E1_PARCELA == 'A' .OR. SE1->E1_PARCELA == ' '
                _mval  := SE1->E1_VALOR - _mDesp
             Endif
             @ nlin,099 PSAY SE1->E1_NUM+' '+SE1->E1_PARCELA
             @ nlin,111 PSAY _mval * (_mPerc / 100) PICTURE "@E 99,999.99"
             if _motivo == " " .and. _mHist == " "
                @ nlin,125 PSAY SE1->E1_BAIXA
                _mtotp := _mtotp + (_mval * (_mPerc / 100))
             else
                if _motivo #" "
                   @ nlin,125 PSAY "NF CANC"
                else
                   if "LUCROS E PERDAS" $(_mHist)
                      @ nlin,125 PSAY "L&P"
                   else
                      @ nlin,125 PSAY "NF CANC"
                   endif
                endif
             endif
             _motivo := " "
             _mHist  := " "
             _mnota  := SE1->E1_NUM
             DbSelectArea("SE1")
             DbSkip()
          Enddo
       Endif
    Endif
    _mProd := SC6->C6_PRODUTO
    DbSelectArea("SC6")
    DbSkip()
End

nLin := nLin + 2
@ nlin,000 PSAY "Total de Pagamentos ..................................: "
@ nlin,056 PSAY STR(_mQtde,6)
@ nlin,108 PSAY _mtotp PICTURE "@E 9,999,999.99"

dbSelectarea("SC6")
RetIndex("SC6")
// Apaga Indice SC6
fErase(_cInd+OrdBagExt())
dbSelectarea("SE1")
RetIndex("SE1")
dbSelectarea("SC5")
RetIndex("SC5")
dbSelectarea("SE5")
RetIndex("SE5")

Set Device to Screen
If aReturn[5] == 1
    Set Printer To
    ourspool(wnrel) //Chamada do Spool de Impressao
Endif
MS_FLUSH() //Libera fila de relatorios em spool
Return


