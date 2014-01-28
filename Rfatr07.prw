#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
  #DEFINE PSAY SAY
#ENDIF

User Function Rfatr07()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CPERG,CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO")
SetPrvt("ARETURN,NOMEPROG,LIMITE,ALINHA,NLASTKEY,NLIN")
SetPrvt("TITULO,CCABEC1,CCABEC2,CCANCEL,M_PAG,WNREL")
SetPrvt("_ACAMPOS,_CNOME,_CKEY,_CIND,_CALIAS,_NINDEX")
SetPrvt("_NREG,AREGS,I,J,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>   #DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATR07   ³Autor: Rosane Rodrigues       ³ Data:   14/01/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: RELATORIO DE N.F POR CLIENTE                               ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento de Publicidade                       ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³   Parametros Utilizados                   ³
//³   mv_par01 = Nom.Cliente Inicial          ³
//³   mv_par02 = Nom.Cliente Final            ³
//³   mv_par03 = Do Vencto                    ³
//³   mv_par04 = At‚ o Vencto                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cPerg    := "PFAT57"
ValidPerg()
If !Pergunte(CPERG)
   Return
EndIf
cString  := "SE1"
cDesc1   := PADC("Este programa emite o relat¢rio das N.F. por Cliente ",70)
cDesc2   := PADC("com vencimento no per¡odo solicitado.",70)
cDesc3   := " "
tamanho  := "M"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "RFATR07"
limite   := 80
aLinha   := { }
nLastKey := 0
nLin     := 80
titulo   := "N.F. por Cliente"
cCabec1  := "Per¡odo de Vencimento : " + DTOC(MV_PAR03) + ' A ' + DTOC(MV_PAR04)
cCabec2  := " " 
cCancel  := "***** CANCELADO PELO OPERADOR *****"
m_pag    := 1               //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel    := "RFATR07_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)       //Nome Default do relatorio em Disco
wnrel    := SetPrint(cString,wnrel,cPerg,space(25)+titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

SetDefault(aReturn,cString)

IF NLASTKEY==27 .OR. NLASTKEY==65
   RETURN
ENDIF

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Chama Relatorio                                ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF WINDOWS
   RptStatus({|| RptDetail() })// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>    RptStatus({|| Execute(RptDetail) })
#ELSE
   RptDetail()
#ENDIF
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
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function RptDetail
Static Function RptDetail()

_aCampos := {{"CODCLI" ,"C",6 ,0} ,;
             {"NOMECLI","C",40,0} ,;
             {"AV"     ,"C",6 ,0} ,;
             {"DUPLIC" ,"C",6 ,0} ,;
             {"PARC"   ,"C",1 ,0} ,;
             {"DTVENC" ,"D",8 ,0} ,;
             {"DTEMIS" ,"D",8 ,0} ,;
             {"VALDUP" ,"N",10,2} ,;
             {"VALNF"  ,"N",12,2}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"TRB",.F.,.F.)
_cKey:="NOMECLI+AV+DUPLIC+PARC"
IndRegua("TRB",_cNome,_cKey,,,"SELECIONANDO REGISTROS DO ARQ")

dbSelectArea("SE1")
_cInd   := CriaTrab(NIL,.F.)
_cKey   := "E1_FILIAL+DTOS(E1_VENCTO)+E1_PEDIDO"
IndRegua("SE1",_cInd,_cKey,,,"Selecionando registros .. ")

SetRegua(Reccount())
dbSeek( xFilial("SE1")+DTOS(MV_PAR03), .T. )
While !eof() .and. SE1->E1_VENCTO <= MV_PAR04
 
    IncRegua()

    If !"P" $ SE1->E1_PEDIDO
        dbSkip()
        Loop
    EndIf

    If 'CAN' $(SE1->E1_MOTIVO) .OR. 'DEV' $(SE1->E1_MOTIVO) .OR.;
        'CANC' $(SE1->E1_HIST)
        dbSkip()
        Loop
    EndIf

    dbSelectArea("SA1")
    dbSeek(xFilial("SA1")+SE1->E1_CLIENTE)
    If SA1->A1_NOME < MV_PAR01 .or. SA1->A1_NOME > MV_PAR02
        dbSelectArea("SE1")
        dbSkip()
        Loop
    EndIf

    dbSelectArea("SF2")
    dbSetOrder(1)
    If dbSeek(xFilial("SF2")+SE1->E1_NUM+SE1->E1_SERIE+SE1->E1_CLIENTE+SE1->E1_LOJA, .F.)
        dbSelectArea("TRB")
        If RecLock("TRB",.T.)
            TRB->CODCLI  := SE1->E1_CLIENTE
            TRB->NOMECLI := SA1->A1_NOME
            TRB->DUPLIC  := SE1->E1_NUM
            TRB->PARC    := SE1->E1_PARCELA
            TRB->DTVENC  := SE1->E1_VENCTO
            TRB->DTEMIS  := SE1->E1_EMISSAO
            TRB->VALDUP  := SE1->E1_VALOR
            TRB->VALNF   := SF2->F2_VALBRUT
            TRB->AV      := SE1->E1_PEDIDO
            msUnlock()
        EndIf
    EndIf

    dbSelectArea("SE1")
    dbSkip()

End

dbSelectArea("TRB")
dbgotop()
WHILE !EOF()
   if nLin > 60 
      nLin     := Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18) //IIF(aReturn[4]==1,15,18) ) //Impressao do cabecalho
      nLin     := nLin + 2
                   //           1         2         3         4         5         6         7         8         9        10        11        12        13
                   // 012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
      @ nlin,00 PSAY "Cliente   Nome do Cliente                             A.V.     N.F.   Val.N.Fiscal   Dt.Emissao   Num.Duplic.  Val.Duplic.  Dt.Vencto"
      nLin     := nLin + 1
      @ nlin,00 PSAY "-------   ----------------------------------------   ------   ------  ------------   ----------   -----------  -----------  ---------"
      nLin     := nLin + 1                                                                  
   Endif
   nLin := nLin + 1
   @ nlin,00  PSAY TRB->CODCLI
   @ nlin,10  PSAY TRB->NOMECLI
   @ nlin,53  PSAY TRB->AV
   @ nlin,62  PSAY TRB->DUPLIC
   @ nlin,70  PSAY TRB->VALNF  PICTURE "@E 999,999.99"
   @ nlin,86  PSAY TRB->DTEMIS
   @ nlin,98  PSAY TRB->DUPLIC + IIf( !Empty(TRB->PARC), "-" + TRB->PARC, "" )
   @ nlin,111 PSAY TRB->VALDUP PICTURE "@E 999,999.99"
   @ nlin,124 PSAY TRB->DTVENC
   nLin   := nLin + 1
   DBSKIP()
END

IF RECCOUNT() == 0
   Cabec(titulo,cCabec1,cCabec2,nomeprog,tamanho,18)
   @ 15, 00 PSAY "NAO HA DADOS A APRESENTAR !!! "
ENDIF

dbSelectArea("TRB")
dbCloseArea()
fErase(_cNome+".DBF")
fErase(_cNome+OrdBagExt())

dbSelectarea("SE1")
RetIndex("SE1")
// Apaga Indice SE1
fErase(_cInd+OrdBagExt())

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

_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()


   cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
   aRegs    := {}
   dbSelectArea("SX1")
   dbSetOrder(1)
   AADD(aRegs,{cPerg,"01","Nome Cliente Inicial?","mv_ch1","C",40,0,2,"G","","mv_par01","","","","","","","","","","","","","","",""})
   AADD(aRegs,{cPerg,"02","Nome Cliente Final  ?","mv_ch2","C",40,0,2,"G","","mv_par02","","","","","","","","","","","","","","",""})
   AADD(aRegs,{cPerg,"03","Vencimento Inicial  ?","mv_ch3","D",08,0,2,"G","","mv_par03","","","","","","","","","","","","","","",""})
   AADD(aRegs,{cPerg,"04","Vencimento Final    ?","mv_ch4","D",08,0,2,"G","","mv_par04","","","","","","","","","","","","","","",""})
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

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)

Return
