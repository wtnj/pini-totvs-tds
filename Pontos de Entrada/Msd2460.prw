#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02
/*/// dANILO NAO DOBRAR A BASE DE ICMS 20050817
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: MSD2460   ³Autor: Desconhecido           ³ Data:   02/02/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Ponto de entrada na gravacao do item da Nota.              ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Release  : Roger Cangianeli - Padronizacao e Otimizacao.              ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Msd2460()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

SetPrvt("_APOSARQ,_NVEZ,_DDATA,_LERRO,_NVALOR,_NVALDESC")
SetPrvt("_NPERDESC,_CMSG,")
Private aArea, aAreaSC5, aAreaSC6, aAreaSD2, aAreaSF2, aAreaSE1
// **********************************************************************
// *****************        Gilberto    *********************************
// *  TOMAR O MAXIMO DE CUIDADO POSSIVEL QUANDO ALTERAR ESTE PROGRAMA;  *
// *  SOLICITAR A SRA.CIDINHA QUE TESTE O FATURAMENTO APOS SUAS MODIFI- *
// *  CACOES, POIS DEPOIS FICAMOS OUVINDO UM MONTE DOS USUARIOS.        *
// *  OBRIGADO !!!       ROGER.                                         *
// **********************************************************************
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Somente p/ a empresa Editora ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If SM0->M0_CODIGO == "02"
    RECLOCK("SD2",.F.)
    SD2->D2_CODISS:=SB1->B1_CODISS
    MSUNLOCK()
    Return
Endif

// Tratamento de base de ICMS para suporte informatico (software)
/* If SD2->D2_TES == "814" .and. Alltrim(SD2->D2_GRUPO) == "3800" //DANILO NAO DOBRAR A BASE! 20050817
   	RecLock("SD2",.f.)
   	SD2->D2_BASEICM := 2 * (SD2->D2_BASEICM)
   	SD2->D2_VALICM  := ROUND(SD2->D2_BASEICM * SD2->D2_PICM / 100,2)
   	MsUnlock()
EndIf
*/ //ATE AKI 20050817


// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³ Salva o Alias Corrente              ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aArea := GetArea()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiona os Arquivos SC5 E SC6                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC5")
aAreaSC5 := GetArea()
DBSETORDER(1)
dbSeek(xFilial("SC5")+SD2->D2_PEDIDO)

dbSelectArea("SC6")
aAreaSC6 := GetArea()
DBSETORDER(1)
dbSeek(xFilial("SC6")+SD2->D2_PEDIDO+SD2->D2_ITEMPV)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica o Grupo de Pergunta traz o Ano mes Faturamento ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SX1")
dbSetOrder(1)
dbSeek("LIBSZV    05") //MP10
_dData := Ctod(AllTrim(SX1->X1_CNT01))
_dData := Stod(AllTrim(SX1->X1_CNT01)) //20090129

// Se for faturamento Especial
_lErro := .F.
If SC5->C5_AVESP == "S"
    // Posiciona na parcela referente ao faturamento e atualiza
    // numero e data da nota fiscal
    dbSelectArea("SZV")
    DbSetOrder(1)
    If dbSeek(xFilial("SZV")+SD2->D2_PEDIDO, .F. )
        While !Eof() .and. SZV->ZV_NUMAV == SD2->D2_PEDIDO
            If Month(SZV->ZV_ANOMES) == Month(_dData) .and.;
                Year(SZV->ZV_ANOMES) ==  Year(_dData)
                If Empty(SZV->ZV_NFISCAL) .or. Val(SZV->ZV_NFISCAL) == 0
                    RecLock("SZV",.F.)
                    SZV->ZV_NFISCAL:=SD2->D2_DOC
                    SZV->ZV_DTNF   :=SD2->D2_EMISSAO
                    SZV->ZV_SERIE  :=SD2->D2_SERIE
                    msUnlock()
                EndIf
                Exit
            EndIf
            DbSelectArea("SZV")
            dbSkip()
        End
        // Caso nao encontre a parcela de faturamento, posiciona
        // na primeira parcela
        If SZV->ZV_NUMAV #SD2->D2_PEDIDO
            DbSelectArea("SZV")
            DbSetOrder(1)
            dbSeek(xFilial("SZV")+SD2->D2_PEDIDO)
        EndIf
    Else
        _lErro := .T.
    EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava N.F. se o item e' de Av programada            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SZS")
dbsetorder(1)
dbSeek(xFilial("SZS")+SD2->D2_PEDIDO+SD2->D2_ITEMPV)
While !EOF() .and. SZS->ZS_FILIAL == xFilial("SZS") .and. SC5->C5_AVESP == "N" .and. ;
                SZS->ZS_NUMAV+SZS->ZS_ITEM == SD2->D2_PEDIDO+SD2->D2_ITEMPV
        If !Empty(SZS->ZS_LIBFAT) .and. Val(SZS->ZS_NFISCAL)==0
                RecLock("SZS",.F.)
                SZS->ZS_NFISCAL := SD2->D2_DOC
                SZS->ZS_SERIE   := SD2->D2_SERIE
                SZS->ZS_DTNF    := SD2->D2_EMISSAO
                msUnlock()
        EndIf
        DbSelectArea("SZS")
        dbSkip()
End

If SC5->C5_DIVVEN == 'PUBL'
    If SC5->C5_AVESP == 'S' .and. SC5->C5_TPTRANS $ '12' .and. !_lErro
                _nValor     := SZV->ZV_VALOR-(SZV->ZV_VALOR*.20)
                _nValDesc   := SZV->ZV_VALOR-_nValor
                _nPerDesc   := 20
    ElseIf SC5->C5_AVESP == "S" .and. !_lErro
                _nValor     := SZV->ZV_VALOR
                _nValDesc   := 0
                _nPerDesc   := 0
    ElseIf SC5->C5_AVESP == "S" .and. _lErro
        _cMsg := "Nao foi encontrado o cadastramento de parcela. "
        _cMsg := _cMsg + "A NF sera gerada com valores errados. Verifique !"
         MsgStop(_cMsg, "ATENCAO")
        ElseIf SC5->C5_TPTRANS $ '04/09/12'
                _nValor     := SD2->D2_PRCVEN-(SD2->D2_PRCVEN*.20)
                _nValDesc   := SD2->D2_PRCVEN-_nValor
                _nPerDesc   := 20
        Else
                _nValor     := SD2->D2_PRCVEN
                _nValDesc   := 0
                _nPerDesc   := 0
        EndIf
    If !_lErro
        dbSelectArea("SD2")
        RecLock("SD2",.F.)
        SD2->D2_PRCVEN := _nValor
        SD2->D2_TOTAL  := _nValor * SD2->D2_QUANT
        SD2->D2_PRUNIT := _nValor
        SD2->D2_DESCON := _nValDesc * SD2->D2_QUANT
        SD2->D2_DESC   := _nPerDesc
        msUnlock()
    EndIf
EndIf

RestArea(aAreaSC5)
RestArea(aAreaSC6)
RestArea(aArea)

Return