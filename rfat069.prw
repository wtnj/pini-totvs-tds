#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFATR23   ³Autor: Rosane Rodrigues       ³ Data:   04/02/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: RELATORIO DE MATERIAIS POR CLIENTE - VIDEO                 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento de Publicidade                       ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function rfat069()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
Local aArea := GetArea()

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,NLASTKEY")
SetPrvt("CSAVTELA1,NLIN,_MLOC,")


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³   Parametros Utilizados                   ³
//³   MV_PAR01  = Do Cliente                  ³
//³   MV_PAR02  = At‚ o Cliente               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg    := "FIN450"
If !Pergunte(CPERG)
   Return
EndIf

nLastKey := 0
// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Chama Relatorio                                ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Processa({|| RptDetail() })// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>    RptStatus({|| Execute(RptDetail) })

RestArea(aArea)

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

Local cTexto
Local nCont := IIF(Val(MV_PAR01) <> Val(MV_PAR02), Abs(Val(MV_PAR02)-Val(MV_PAR01)),1)
DbSelectArea("SZU")
DbSetOrder(01)
DbSeek(Xfilial("SZU")+MV_PAR01,.T.)


SET DEVICE TO SCREEN

MsgInfo(OemToAnsi("Clique em OK para Iniciar"),OemToAnsi("CONSULTA DE MATERIAIS POR CLIENTE"))

ProcRegua(nCont)

While !Eof() .and. SZU->ZU_FILIAL == xFilial("SZU") .and. SZU->ZU_CLIENTE <= MV_PAR02
    IncProc("Verificando Cliente " + Alltrim(SZU->ZU_CLIENTE))
    //nlin := 5
    //@ nlin,01 SAY "CodCli Nome do Cliente                             Local / Respons vel      " 
    cTexto := "CodCli Nome do Cliente                             Local / Respons vel      "+CHR(10)+CHR(13) 
    //nLin++
    //@ nlin,01 SAY "CodMat Titulo do Material      Tipo                Observa‡äes              "
    cTexto := "CodMat Titulo do Material      Tipo                Observa‡äes              "+CHR(10)+CHR(13) 
    //nLin++
    //@ nlin,01 SAY REPLICATE ("+",76)
    cTexto := REPLICATE ("+",76)+CHR(10)+CHR(13) 
    //nLin += 2                                                                  
    FOR NLIN := 8 TO 22 .AND. SZU->ZU_CLIENTE <= MV_PAR02
        _mloc := " "
        If SZU->ZU_LOCALIZ == '0'
           _mloc := "PINI"
        Endif
        If SZU->ZU_LOCALIZ == '1'
           _mloc := "CLIENTE"
        Endif
        If SZU->ZU_LOCALIZ == '2'
           _mloc := "AGENCIA"
        Endif
        DbSelectArea("SA1")
        DbSetOrder(1)
        DbSeek(XFILIAL("SA1")+SZU->ZU_CLIENTE)
        //@ nlin,001 SAY SZU->ZU_CLIENTE+' '+SA1->A1_NOME+SPACE(6)+SZU->ZU_LOCALIZ+SPACE(3)+_mloc
        cTexto := Padr(SZU->ZU_CLIENTE,7)+Padr(SA1->A1_NOME,39)+Padr(SZU->ZU_LOCALIZ,4)+_mloc+CHR(10)+CHR(13) 
        //nlin++
        //@ nlin,001 SAY SZU->ZU_CODMAT+' '+SZU->ZU_TITULO+SPACE(4)+SZU->ZU_TIPOMAT+'  '+SUBST(SZU->ZU_OBS,1,23)
        cTexto := Padr(SZU->ZU_CODMAT,7)+Padr(SZU->ZU_TITULO,24)+Padr(SZU->ZU_TIPOMAT,18)+SUBST(SZU->ZU_OBS,1,23)+CHR(10)+CHR(13) 
        //nlin++
        //@ nlin,001 SAY REPLICATE("-",76)
        Msginfo(cTexto,"Cliente "+Alltrim(SZU->ZU_CLIENTE))
        DbSelectArea("SZU")
        DbSkip()
    NEXT

    DbSelectArea("SZU")
    If nLastKey == 27 .or. LastKey() == 27
        Exit
    EndIf
End

Return