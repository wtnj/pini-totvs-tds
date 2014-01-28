#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFAT057   ³Autor: Rosane Rodrigues       ³ Data:   27/01/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: RELATORIO DE INSERCOES LIBERADAS E NAO FATURADAS           ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento de Publicidade                       ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat057()

SetPrvt("CPERG,CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO")
SetPrvt("ARETURN,NOMEPROG,LIMITE,ALINHA,NLASTKEY,_MTOT")
SetPrvt("_MITEM,_MAV,_NAV,_NITEM,NLIN,TITULO")
SetPrvt("CCABEC1,CCABEC2,CCANCEL,M_PAG,WNREL,_CARQ")
SetPrvt("_CKEY,_CFILTRO,_MQTDE,AREGS,I,J,mhora")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³   Parametros Utilizados                   ³
//³   mv_par01 = Periodo Inicial              ³
//³   mv_par02 = Periodo Final                ³
//³   mv_par03 = Impressao Resumida  S/N      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg    := "PFAT24"
//ValidPerg()
If !Pergunte(CPERG)
   Return
EndIf

cString  := "SZS"
cDesc1   := PADC("Este programa emite o relat¢rio das inser‡äes",70)
cDesc2   := PADC("liberadas e nÆo faturadas por per¡odo",70)
cDesc3   := " "
tamanho  := "M"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFAT057"
limite   := 80
aLinha   := { }
nLastKey := 0
_mtot    := 0
_mitem   := 0
_mav     := 0
_nav     := SPACE(6)
_nitem   := SPACE(2)
nLin     := 80
titulo   := "Inser‡äes liberadas e nÆo faturadas"
cCabec1  := " "
cCabec2  := " "
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1      //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel    := "RFATR11_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)            //Nome Default do relatorio em Disco
wnrel    := SetPrint(cString,wnrel,cPerg,space(17)+titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

SetDefault(aReturn,cString)

IF NLASTKEY == 27 .OR. NLASTKEY == 65
   RETURN
ENDIF

DBSELECTAREA("SZS")
_cArq     := CriaTrab(NIL,.F.)
_cKey     := "ZS_FILIAL+DTOS(ZS_DTCIRC)+ZS_NUMAV+ZS_ITEM+STR(ZS_NUMINS)" //"ZS_NUMAV+ZS_ITEM+STR(ZS_NUMINS,3)"
_cFiltro  := "ZS_FILIAL == '"+xFilial("SZS")+"'"
//_cFiltro  += " .and. DTOS(ZS_DTCIRC) >= DTOS(CTOD('"+DTOC(MV_PAR01)+"'))"
//_cFiltro  += " .and. DTOS(ZS_DTCIRC) <= DTOS(CTOD('"+DTOC(MV_PAR02)+"'))"
_cFiltro  += " .and. ZS_SITUAC <> 'CC' .AND. ZS_FATPROG == 'N'"
IndRegua("SZS",_cArq,_cKey,,_cFiltro,"Selecionando registros .. ")

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Chama Relatorio                                ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>    RptStatus({|| Execute(RptDetail) })

DbSelectarea("SZS")
RetIndex("SZS")
Ferase(_cArq+OrdBagExt())


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³RptDetail ³ Autor ³ Ary Medeiros          ³ Data ³ 15.02.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Impressao do corpo do relatorio                             ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RptDetail()

cCabec1 := "Per¡odo Inicial : " + DTOC(MV_PAR01) + SPACE(10) + "Per¡odo Final : " + DTOC(MV_PAR02)
cCabec2 := " "
nLin := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18) //Impressao do cabecalho
nLin := nLin + 2

DBSELECTAREA("SZS")
dbGotop()
DbSeek(xFilial("SZS")+DTOS(MV_PAR01),.t.)
ProcRegua(Reccount())
While !eof() .and. SZS->ZS_FILIAL == xFilial("SZS") .and. DTOS(SZS->ZS_DTCIRC) <= DTOS(MV_PAR02)
   IncProc("Lendo AV: "+SZS->ZS_NUMAV)

   IF VAL(SZS->ZS_CODMAT) == 0 .OR. VAL(SZS->ZS_NFISCAL) <> 0 
      DbSkip()
      Loop
   ENDIF

   DbSelectArea("SC5")
   DbSetOrder(1)
   DbSeek(xFilial("SC5")+SZS->ZS_NUMAV)
   IF VAL(SC5->C5_TPTRANS) == 2 .OR. VAL(SC5->C5_TPTRANS) == 3 .OR. VAL(SC5->C5_TPTRANS) == 8
      DbSelectArea("SZS")
      DbSkip()
      Loop
   ENDIF

   _MQTDE := 0

   DbSelectArea("SA1")
   DbSetOrder(1)
   DbSeek(xFilial("SA1")+SZS->ZS_CODCLI)

   DbSelectArea("SC6")
   DbSetOrder(1)
   DbSeek(xFilial("SC6")+SZS->ZS_NUMAV+SZS->ZS_ITEM)
   _MQTDE := SC6->C6_QTDVEN

   If MV_PAR03 == 2     // IMPRESSAO RESUMIDA == NAO
       if _nitem <> SPACE(2) .AND. _nitem <> SZS->ZS_ITEM .and. _nav == SZS->ZS_NUMAV
          nlin := nLin + 1
          @ nlin,000 PSAY "TOTAL DO ITEM .......................................................: "
          @ nlin,106 PSAY _mitem PICTURE "@E 9,999,999.99"
          _mitem := 0
          nLin   += 2
       Endif

       if _nav <> SPACE(6) .AND. _nav <> SZS->ZS_NUMAV
          nlin := nLin + 1
          @ nlin,000 PSAY "TOTAL DO ITEM .......................................................: "
          @ nlin,106 PSAY _mitem PICTURE "@E 9,999,999.99"
          nLin   += 2
          @ nlin,000 PSAY "TOTAL DA AV .........................................................: "
          @ nlin,106 PSAY _mav   PICTURE "@E 9,999,999.99"
          _mitem := 0
          _mav   := 0
          nLin   += 2
          @ nlin,000 SAY REPLICATE ("-",132)
          nLin   += 2
       Endif
       nLin++
   ENDIF

   if nLin >= 55
      Roda(0,"",tamanho)
      cCabec1 := "Per¡odo Inicial : " + DTOC(MV_PAR01) + SPACE(10) + "Per¡odo Final : " + DTOC(MV_PAR02)
      cCabec2 := " "
      nLin := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18) //Impressao do cabecalho
      nLin := nLin + 2
/*/
                      01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
                                1         2         3         4         5         6         7         8         9        10        11        12        13
/*/
      @ nlin,0  PSAY "Cliente  Nome do Cliente                           Num.Av  Item   Cond.Pag   Ins/Qtde   Edi‡Æo   Dt.Circ.   Val.Inser‡ao   Cod.Mat."
      nlin++
      @ nlin,0  PSAY "-------  ----------------------------------------  ------  ----   --------   --------   ------   --------   ------------   --------"
      nLin += 2
   Endif

   @ nlin,000 PSAY SZS->ZS_CODCLI
   @ nlin,009 PSAY SA1->A1_NOME
   @ nlin,051 PSAY SZS->ZS_NUMAV
   @ nlin,059 PSAY SZS->ZS_ITEM
// @ nlin,066 PSAY SUBST(SZS->ZS_CODPROD,1,8)
   @ nlin,066 PSAY SZS->ZS_CONDPAG
   @ nlin,077 PSAY STR(SZS->ZS_NUMINS,2)+" / "+STR(_mqtde,2)
   @ nlin,088 PSAY SZS->ZS_EDICAO
   @ nlin,097 PSAY DTOC(SZS->ZS_DTCIRC)
   @ nlin,108 PSAY SZS->ZS_VALOR PICTURE "@E 999,999.99"
   @ nlin,123 PSAY SC5->C5_TPTRANS

   nLin++
   _mtot  += SZS->ZS_VALOR
   _mitem += SZS->ZS_VALOR
   _mav   += SZS->ZS_VALOR
   _nav   := SZS->ZS_NUMAV
   _nitem := SZS->ZS_ITEM

   DbSelectArea("SZS")
   DbSkip()
End

If _mtot <> 0
    IF MV_PAR03 == 2
       nlin++
       @ nlin,000 PSAY "TOTAL DO ITEM .......................................................: "
       @ nlin,106 PSAY _mitem PICTURE "@E 9,999,999.99"
       nLin   += 2
       @ nlin,000 PSAY "TOTAL DA AV .........................................................: "
       @ nlin,106 PSAY _mav   PICTURE "@E 9,999,999.99"
       nLin   += 4
       @ nlin,000 PSAY "TOTAL GERAL .........................................................: "
       @ nlin,106 PSAY _mtot  PICTURE "@E 9,999,999.99"
    ELSE
       nLin   += 4
       @ nlin,000 PSAY "TOTAL GERAL .........................................................: "
       @ nlin,106 PSAY _mtot  PICTURE "@E 9,999,999.99"
    ENDIF
Else
   Roda(0,"",tamanho)
   cCabec1 := "Per¡odo Inicial : " + DTOC(MV_PAR01) + SPACE(10) + "Per¡odo Final : " + DTOC(MV_PAR02)
   cCabec2 := " "
   nLin := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18) //Impressao do cabecalho
   nLin += 2
   @ nlin,0  PSAY "Cliente  Nome do Cliente                           Num.Av  Item   Cond.Pag   Ins/Qtde   Edi‡Æo   Dt.Circ.   Val.Inser‡ao   Tp Trans"
   nlin++
   @ nlin,0  PSAY "-------  ----------------------------------------  ------  ----   --------   --------   ------   --------   ------------   --------"
Endif

Roda(0,"",tamanho)

Set Device to Screen
If aReturn[5] == 1
        Set Printer To
        ourspool(wnrel) //Chamada do Spool de Impressao
Endif

MS_FLUSH() //Libera fila de relatorios em spool

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
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function VALIDPERG
Static Function VALIDPERG()

   cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
   aRegs    := {}
   dbSelectArea("SX1")
   dbSetOrder(1)
   AADD(aRegs,{cPerg,"01","Periodo Inicial     ?","mv_ch1","D",08,0,2,"G","","mv_par01","","","","","","","","","","","","","","",""})
   AADD(aRegs,{cPerg,"02","Periodo Final       ?","mv_ch2","D",08,0,2,"G","","mv_par02","","","","","","","","","","","","","","",""})
   AADD(aRegs,{cPerg,"03","Impressao Resumida  ?","mv_ch3","N",01,0,2,"C","","mv_par03","Sim","","","Nao","","","","","","","","","","",""})
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
