#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
    #DEFINE PSAY SAY
#ENDIF

User Function Rfatr08()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("_CALIAS,_NINDEX,_NREG,CPERG,CSTRING,CDESC1")
SetPrvt("CDESC2,CDESC3,TAMANHO,ARETURN,NOMEPROG,LIMITE")
SetPrvt("ALINHA,NLASTKEY,NLIN,TITULO,MNUM,CCABEC1")
SetPrvt("CCABEC2,CCANCEL,M_PAG,WNREL,_ACAMPOS,_CNOME")
SetPrvt("_CKEY,_CIND,_CARQ,_CFILTRO,_CQUANT,_CCODVEI")
SetPrvt("_CCODREV,_CEDIINI,_CEDIFIM,_DDTCIRC,AREGS,I")
SetPrvt("J,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     #DEFINE PSAY SAY
#ENDIF
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: RFATR08   쿌utor: Roger Cangianeli       � Data:   17/01/00 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri놹o: RELATORIO DE A.V. POR CLIENTE                              � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento de Publicidade                       � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//�   Parametros Utilizados                   �
//�   mv_par01 = Nom.Cliente Inicial          �
//�   mv_par02 = Nom.Cliente Final            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()

cPerg    := "PFAT58"
ValidPerg()
If !Pergunte(CPERG)
   Return
EndIf

cString  := "SE1"
cDesc1   := PADC("Este programa emite o relat줿io de A.V. por Cliente ",70)
cDesc2   := ""
cDesc3   := ""
tamanho  := "M"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFATR08"
limite   := 80
aLinha   := { }
nLastKey := 0
nLin     := 80
titulo   := "A.V. por Cliente"
mnum     := '00000P'

          //           1         2         3         4         5         6         7         8         9        10        11        12        13
          // 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
cCabec1  := "C.CLI  NOME DO CLIENTE                        AV/ITEM   REVISTA E.INI E.FIM DT.VENC. QTD.INS FORMATO / COR             PRECO     "
cCabec2  := "------ -------------------------------------- --------- ------- ----- ----- -------- ------- ------------------------- ----------"
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1               //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel    := "RFATR08_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)       //Nome Default do relatorio em Disco
wnrel    := SetPrint(cString,wnrel,cPerg,space(25)+titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

SetDefault(aReturn,cString)

If NLASTKEY==27 .OR. NLASTKEY==65
   RETURN
EndIf

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

_aCampos := {{"CODCLI" ,"C",6 ,0} ,;
             {"NOMECLI","C",40,0} ,;
             {"AV"     ,"C",6 ,0} ,;
             {"ITEM"   ,"C",2 ,0} ,;
             {"REVISTA","C",6 ,0} ,;
             {"EDINI"  ,"N",4 ,0} ,;
             {"EDFIM"  ,"N",4 ,0} ,;
             {"DTVENC" ,"D",8 ,0} ,;
             {"QTDINS" ,"N",2 ,0} ,;
             {"FORMATO","C",30,0} ,;
             {"VALOR"  ,"N",10,2}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"TRB",.F.,.F.)
_cKey:="NOMECLI+AV+ITEM"
IndRegua("TRB",_cNome,_cKey,,,"SELECIONANDO REGISTROS DO ARQ")

dbSelectArea("SZS")
_cInd := CriaTrab(_aCampos,.F.)
_cKey:="ZS_FILIAL+ZS_NUMAV+ZS_ITEM+ZS_CODREV+STR(ZS_NUMINS,3)"
IndRegua("SZS",_cInd,_cKey,,,"SELECIONANDO REGISTROS DO ARQ")

dbselectarea("SC5")
dbSetOrder(1)
_cArq    := CriaTrab(NIL,.F.)
_cKey    := indexkey()
_cFiltro  := 'C5_FILIAL=="'+xFilial("SC5")+'"'
_cFiltro  := _cFiltro + '.and.("P" $(C5_NUM) .OR. C5_DIVVEN == "PUBL")'
IndRegua("SC5",_cArq,_cKey,,_cFiltro,"Selecionando registros .. ")
SetRegua(Reccount()/2)
dbGoTop()
While !EOF()
    IncRegua()

    dbSelectArea("SA1")
    dbSeek(xFilial("SA1")+SC5->C5_CLIENTE)
    If SA1->A1_NOME < MV_PAR01 .or. SA1->A1_NOME > MV_PAR02
       dbSelectArea("SC5")
       IncRegua()
       dbSkip()
       Loop
    EndIf

    dbSelectArea("SC6")
    dbSetOrder(1)
    If dbSeek(xFilial("SC6")+SC5->C5_NUM,.F.)
       While !Eof() .and. SC5->C5_NUM == SC6->C6_NUM
          IncRegua()
          _cQuant  := Str(SC6->C6_QTDVEN,3)
          _cCodVei := "01" + Subs(SC6->C6_PRODUTO,3,2)
          _cCodrev := Subs(SC6->C6_PRODUTO,1,4)
          _cEdiIni := SC6->C6_EDINIC
          dbSelectArea("SZS")
          If dbSeek(xFilial("SZS")+SC6->C6_NUM+SC6->C6_ITEM+_cCodrev+_cQuant,.F.)
             While !EOF() .and. SZS->ZS_SITUAC == "CC"
                _cQuant := Str( Val(_cQuant)-1, 3 )
                dbSeek(xFilial("SZS")+SC6->C6_NUM+SC6->C6_ITEM+_cCodrev+_cQuant,.F.)
                IncRegua()
             End
             If Val(_cQuant) < 1
                dbSelectArea("SC6")
                dbSkip()
                Loop
             EndIf

             _cEdiFim := SZS->ZS_EDICAO
             _dDtCirc := SZS->ZS_DTCIRC
             dbSelectArea("SZJ")
             dbSetOrder(1)
             dbSeek(xFilial("SZJ")+_cCodVei)
             dbSelectArea("SB1")
             dbSetOrder(1)
             dbSeek(xFilial("SB1")+SZS->ZS_CODPROD)
             dbSelectArea("TRB")
             If RecLock("TRB",.T.)
                TRB->CODCLI  := SA1->A1_COD
                TRB->NOMECLI := SA1->A1_NOME
                TRB->AV      := SZS->ZS_NUMAV
                TRB->ITEM    := SZS->ZS_ITEM
                TRB->REVISTA := SZJ->ZJ_DESCR
                TRB->EDINI   := _cEdiIni
                TRB->EDFIM   := _cEdiFim
                TRB->DTVENC  := _dDtCirc
                TRB->QTDINS  := Val(_cQuant)
                TRB->FORMATO := SB1->B1_DESC
                TRB->VALOR   := SZS->ZS_VALOR
                msUnlock()
             EndIf

          EndIf
          dbSelectArea("SC6")
          IncRegua()
          dbSkip()
       End
    EndIf
    dbSelectArea("SC5")
    dbSkip()
End

dbSelectArea("TRB")
dbGoTop()
While !EOF()
   If nLin > 60
      nLin     := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18) //IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho
      nLin     := nLin + 2
   Endif

/*/
          //           1         2         3         4         5         6         7         8         9        10        11        12        13
          // 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234
cCabec1  := "C.CLI  NOME DO CLIENTE                          AV/ITEM   REVISTA E.INI E.FIM DT.VENC. QTD.INS  FORMATO / CORES            PRECO     "
cCabec2  := "------ ---------------------------------------- --------- ------- ----- ----- -------- -------  -------------------------  ----------"
/*/

   nLin := nLin + 1
   @ nlin,00  PSAY TRB->CODCLI
   @ nlin,07  PSAY Substr(TRB->NOMECLI,1,38)
   @ nlin,46  PSAY TRB->AV + IIf( !Empty(TRB->ITEM), "-" + TRB->ITEM, "" )
   @ nlin,56  PSAY TRB->REVISTA
   @ nlin,64  PSAY TRB->EDINI
   @ nlin,70  PSAY TRB->EDFIM
   @ nlin,76  PSAY TRB->DTVENC
   @ nlin,90  PSAY TRB->QTDINS PICTURE "@E 99"
   @ nlin,93  PSAY Subs(TRB->FORMATO,1,25)
   @ nlin,119 PSAY TRB->VALOR  PICTURE "@E 999,999.99"
   nLin   := nLin + 1
   dbSkip()

End

If RecCount() == 0
   Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18)
   @ 15, 00 PSAY "NAO HA DADOS A APRESENTAR !!! "
EndIf

dbSelectArea("TRB")
dbCloseArea()
fErase(_cNome+".DBF")
fErase(_cNome+OrdBagExt())

dbSelectArea("SZS")
RetIndex("SZS")
fErase(_cInd+OrdBagExt())

Set Device to Screen
If aReturn[5] == 1
    Set Printer To
    ourspool(wnrel) //Chamada do Spool de Impressao
Endif
MS_FLUSH() //Libera fila de relatorios em spool

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)

Return


/*/
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
귿컴컴컴컴컴쩡컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컫컴컴컴쩡컴컴컴컴커�
교Funcao    쿣ALIDPERG� Autor � Jose Renato July � Data � 25.01.99 낢
궁컴컴컴컴컴탠컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컨컴컴컴좔컴컴컴컴캑�
교Descricao � Verifica perguntas, incluindo-as caso nao existam.   낢
궁컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑�
교Uso       � SX1                                                  낢
궁컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑�
교Release   � 3.0i - Roger Cangianeli - 12/05/99.                  낢
굼컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function VALIDPERG
Static Function VALIDPERG()

   cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
   aRegs    := {}
   dbSelectArea("SX1")
   dbSetOrder(1)
   AADD(aRegs,{cPerg,"01","Nome Cliente Inicial?","mv_ch1","C",40,0,2,"G","","mv_par01","","","","","","","","","","","","","","",""})
   AADD(aRegs,{cPerg,"02","Nome Cliente Final  ?","mv_ch2","C",40,0,2,"G","","mv_par02","","","","","","","","","","","","","","",""})
   For i := 1 to Len(aRegs)
      If !dbSeek(cPerg+aRegs[i,2])
         RecLock("SX1",.T.)
         For j := 1 to FCount()
            If j <= Len(aRegs[i])
               FieldPut(j,aRegs[i,j])
            Endif
         Next
         MsUnlock()
      Endif
   Next

Return
