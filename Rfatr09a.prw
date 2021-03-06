#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
  #DEFINE PSAY SAY
#ENDIF

User Function Rfatr09a()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CPERG,CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO")
SetPrvt("ARETURN,NOMEPROG,ALINHA,NLASTKEY,NLIN,TITULO")
SetPrvt("CABEC1,CABEC2,CCANCEL,M_PAG,WNREL,_TBRUTO")
SetPrvt("_TLIQ,_CARQ,_CKEY,_CFILTRO,NINDEX,_CODVEIC")
SetPrvt("_MLIQ,_MQTDE,DTCIRCI,_CTPTRANS,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>   #DEFINE PSAY SAY
#ENDIF
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma : RFATR09a 쿌utor: Mauricio Mendes        � Data:  18/09/01  � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri놹o: Relatorio de Programa눯o de An즢cios por Revista / Edi눯o  � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento                                      � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//�   Parametros Utilizados                   �
//�   mv_par01 = Revista                      �
//�   mv_par02 = Edicao Inicial               �
//�   mv_par03 = Edicao Final                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

cPerg    := "PFAT52"
If .not. pergunte(cperg)
   Return
Endif

cString  := "SZS"
cDesc1   := PADC("Emite o relat줿io de programa눯o de an즢cios por Revista / Edi눯o",70)
cDesc2   := " "
cDesc3   := " "
tamanho  := "G"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFATR09"
aLinha   := { }
nLastKey := 0
nLin     := 80
titulo   := oemtoansi("Programa눯o de An즢cios - Revista / Edi눯o")
Cabec1   := " "
cabec2   := "Se� Descri눯o            Num AV/It  Ins/Qtd  Nome do Cliente            Descri눯o do Produto    Vl.Ins.Br. Vl.Ins.Liq TpTrans N.Fisc Client  Vend.   Ativo"
//cabec2   := "Se� Descri눯o            Num AV/It  Ins/Qtd  Nome do Cliente            Descri눯o do Produto    Vl.Ins.Br. Vl.Ins.Liq Vend    N.Fisc"
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1      //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel    := "RFATR09_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)            //Nome Default do relatorio em Disco
wnrel    := SetPrint(cString,wnrel,cPerg,space(15)+titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)
_Tbruto  := 0
_Tliq    := 0

SetDefault(aReturn,cString)



If nLastKey == 27 .or. nlastkey == 65
   Return
Endif

// 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// 쿎ria o arquivo temporario                      �
// 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

_cArq    := CriaTrab(NIL,.F.)
_cKey    := "ZS_CODTIT+STR(ZS_EDICAO,4)+ZS_NUMAV+ZS_ITEM"
DBSELECTAREA("SZS")
_cFiltro := 'ZS_FILIAL=="'+xFilial()+'".And.ZS_CODREV=="'+MV_PAR01+'"'
_cFiltro := _cFiltro + '.and.STR(ZS_EDICAO,4) >="'+str(MV_PAR02,4)+'".And.STR(ZS_EDICAO,4) <="'+str(MV_PAR03,4)+'"'
_cFiltro := _cFiltro + '.and.ZS_SITUAC <> "CC"'

IndRegua("SZS",_cArq,_cKey,,_cFiltro,"Selecionando registros .. ")
nIndex:=RetIndex("SZS")
#IFNDEF TOP
        dbSetIndex(_cArq+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()

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

SetRegua(Reccount()/3)
Do While !eof()

   if val(szs->zs_codmat) == 0
      dbskip()
      loop
   endif

   _CODVEIC := '01'+SUBSTR(SZS->ZS_CODREV,3,2)
   _mliq    := SZS->ZS_VALOR
   _mqtde   := 0

   DbSelectArea("SC5")
   DbSetOrder(01)
   DbSeek(xFilial("SC5")+SZS->ZS_NUMAV)

   DbSelectArea("SC6")
   DbSetOrder(01)
   DbSeek(xFilial("SC6")+SZS->ZS_NUMAV+SZS->ZS_ITEM)
   _mqtde := SC6->C6_QTDVEN

   DbSelectArea("SZJ")
   DbSetOrder(01)
   DbSeek(xFilial("SZJ")+_CODVEIC+STR(MV_PAR02,4))
   dtcirci  := SZJ->ZJ_DTCIRC

   DbSelectArea("SZJ")
   DbSetOrder(01)
   DbSeek(xFilial("SZJ")+_CODVEIC+STR(MV_PAR03,4))

   nLin := nLin + 2
   if nLin > 57
      Cabec1 := "Revista: "+MV_PAR01+" "+SZJ->ZJ_DESCR+"    Edicao Inicial: "+STR(MV_PAR02,4)+"  Dt.Circ.: "+DTOC(DTCIRCI)+"    Edicao Final: "+STR(MV_PAR03,4)+"  Dt.Circ.: "+DTOC(SZJ->ZJ_DTCIRC)
      nLin   := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15) //IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho
      nLin   := nLin + 2
   endif

   DbSelectArea("SA1")
   DbSeek(xFilial()+SC6->C6_CLI+SC6->C6_LOJA)

   DbSelectArea("SZW")
   DBSETORDER(01)
   DbSeek(xFilial("SZW")+SZS->ZS_CODTIT)

   DbSelectArea("SB1")
   DbSeek(xFilial("SB1")+SZS->ZS_CODPROD)

   if VAL(Sc5->c5_tptrans) == 4 .or. VAL(sc5->c5_tptrans) == 5
      _mliq := (SZS->ZS_VALOR - (SZS->ZS_VALOR * 0.20))
   Endif

/*/
   @ nLin,000 PSAY SZS->ZS_CODTIT
   @ nLin,004 PSAY SUBSTR(SZW->ZW_DESCR,1,20)
   @ nlin,025 PSAY SZS->ZS_NUMAV+'/'+SZS->ZS_ITEM
   @ nlin,037 PSAY str(SZS->ZS_NUMINS,2)+'/'+str(_mqtde,2)
   @ nLin,045 PSAY SUBST(SA1->A1_NOME,1,30)
   @ nlin,077 PSAY SUBST(SB1->B1_DESC,1,25)
   @ nlin,103 PSAY SZS->ZS_VALOR PICTURE "@E 999,999.99"
   @ nlin,114 PSAY _mliq PICTURE "@E 999,999.99"
   @ nlin,126 PSAY SZS->ZS_VEND                   
/*/

// alterado em 20/06/00 By RC
   @ nLin,000 PSAY SZS->ZS_CODTIT
   @ nLin,004 PSAY SUBSTR(SZW->ZW_DESCR,1,20)
   @ nlin,025 PSAY SZS->ZS_NUMAV+'/'+SZS->ZS_ITEM
   @ nlin,037 PSAY str(SZS->ZS_NUMINS,2)+'/'+str(_mqtde,2)
   @ nLin,045 PSAY SUBST(SA1->A1_NOME,1,25)
   @ nlin,072 PSAY SUBST(SB1->B1_DESC,1,23)
   @ nlin,096 PSAY SZS->ZS_VALOR PICTURE "@E 999,999.99"
   @ nlin,107 PSAY _mliq PICTURE "@E 999,999.99"

//   @ nlin,119 PSAY SZS->ZS_VEND
// Alterado em 06/07/00 By RC
   If Empty(SZS->ZS_NFISCAL)
        If SZS->ZS_TPTRANS == "02"
            _cTpTrans := "PERMUT"
        ElseIf SZS->ZS_TPTRANS == "03"
            _cTpTrans := "BONIFI"
        ElseIf SZS->ZS_TPTRANS $ "11/12/13"
            _cTpTrans := "PARCEL"
        ElseIf SZS->ZS_TPTRANS == "04"
            _cTpTrans := "FAT.AG"
        ElseIf SZS->ZS_TPTRANS == "08"
            _cTpTrans := "COOPER"
        Else
            _cTpTrans := SZS->ZS_TPTRANS
        EndIf
   Else
        _cTpTrans := SZS->ZS_TPTRANS
   EndIf
   // Alterado Mauricio 19/09/01
//   @ nlin,119 PSAY _cTpTrans
   @ nlin,119 PSAY SZS->ZS_TPTRANS

   @ nlin,126 PSAY SZS->ZS_NFISCAL
   //Impressao Adicionada por Mauricio 19/09/01
   @ nlin,133 PSAY SA1->A1_COD
   @ nlin,141 PSAY SZS->ZS_VEND
   @ nlin,150 PSAY SZS->ZS_SITUAC

   _Tbruto := _Tbruto + SZS->ZS_VALOR
   _Tliq   := _Tliq + _mliq
   
   DbSelectArea("SZS")
   DbSkip() 
Enddo

If _Tbruto == 0
   Cabec1 := "Revista: "+MV_PAR01+" "+SZJ->ZJ_DESCR+"    Edicao Inicial: "+STR(MV_PAR02,4)+"  Dt.Circ.: "+DTOC(DTCIRCI)+"    Edicao Final: "+STR(MV_PAR03,4)+"  Dt.Circ.: "+DTOC(SZJ->ZJ_DTCIRC)
   nLin   := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18) //IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho
else
   nLin := nLin + 3
   @ nlin,000 PSAY "TOTAL GERAL .................................................:"
   @ nlin,101 PSAY _Tbruto PICTURE "@E 9,999,999.99"
   @ nlin,112 PSAY _Tliq   PICTURE "@E 9,999,999.99"
Endif

DbSelectarea("SZS")
RetIndex("SZS")
Ferase(_cArq+OrdBagExt())

//Roda(0,"",tamanho)
Set Filter To
Set Device to Screen
If aReturn[5] == 1
        Set Printer To
        Commit
        ourspool(wnrel) //Chamada do Spool de Impressao
Endif
MS_FLUSH() //Libera fila de relatorios em spool
Return



