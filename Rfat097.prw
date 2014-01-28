#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Rfat097()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CALIAS,_NINDEX,_NREG,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PCONA02   ³Autor: Roger Cangianeli       ³ Data:   05/12/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Recalculo Saldos em Estoque pelo Custo de Producao         ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Especifico PINI.                                           ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()

dbSelectArea("ZZ0")
dbSetOrder(1)
dbGoTop()

#IFDEF WINDOWS
    Processa({||_RunProc()}, "Alterando Estoques...")// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     Processa({||Execute(_RunProc)}, "Alterando Estoques...")
    Return
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     Function _RunProc
Static Function _RunProc()
#ENDIF

ProcRegua(RecCount())
While !Eof()

    IncProc()

    If ZZ0->ZZ0_CUSTO == 0
        dbSkip()
        Loop
    EndIf

    dbSelectArea("SB2")
    dbSetOrder(1)
    If dbSeek( xFilial("SB2")+ZZ0->ZZ0_COD, .F. )

        While !Eof() .and. SB2->B2_COD == ZZ0->ZZ0_COD .and.;
            SB2->B2_FILIAL == xFilial("SB2")

            /*
            If ( !Empty(SB2->B2_USAI) .and. Year(SB2->B2_USAI) #2000 ) .or.;
                SB2->B2_LOCAL == "99"
                dbSkip()
                Loop
            EndIf
            */
            
            RecLock("SB2", .F.)
            SB2->B2_CM1     := ZZ0->ZZ0_CUSTO
            SB2->B2_VATU1   := SB2->B2_QATU * SB2->B2_CM1
            SB2->B2_VFIM1   := SB2->B2_QFIM * SB2->B2_CM1

            SB2->B2_CM2     := xMoeda( SB2->B2_CM1,   1, 2, IIf( !Empty(SB2->B2_USAI), SB2->B2_USAI, dDataBase ) )
            SB2->B2_VATU2   := xMoeda( SB2->B2_VATU1, 1, 2, IIf( !Empty(SB2->B2_USAI), SB2->B2_USAI, dDataBase ) )
            SB2->B2_VFIM2   := xMoeda( SB2->B2_VFIM1, 1, 2, IIf( !Empty(SB2->B2_USAI), SB2->B2_USAI, dDataBase ) )

            SB2->B2_CM3     := xMoeda( SB2->B2_CM1,   1, 3, IIf( !Empty(SB2->B2_USAI), SB2->B2_USAI, dDataBase ) )
            SB2->B2_VATU3   := xMoeda( SB2->B2_VATU1, 1, 3, IIf( !Empty(SB2->B2_USAI), SB2->B2_USAI, dDataBase ) )
            SB2->B2_VFIM3   := xMoeda( SB2->B2_VFIM1, 1, 3, IIf( !Empty(SB2->B2_USAI), SB2->B2_USAI, dDataBase ) )

            SB2->B2_CM4     := xMoeda( SB2->B2_CM1,   1, 4, IIf( !Empty(SB2->B2_USAI), SB2->B2_USAI, dDataBase ) )
            SB2->B2_VATU4   := xMoeda( SB2->B2_VATU1, 1, 4, IIf( !Empty(SB2->B2_USAI), SB2->B2_USAI, dDataBase ) )
            SB2->B2_VFIM4   := xMoeda( SB2->B2_VFIM1, 1, 4, IIf( !Empty(SB2->B2_USAI), SB2->B2_USAI, dDataBase ) )

            SB2->B2_CM5     := xMoeda( SB2->B2_CM1,   1, 5, IIf( !Empty(SB2->B2_USAI), SB2->B2_USAI, dDataBase ) )
            SB2->B2_VATU5   := xMoeda( SB2->B2_VATU1, 1, 5, IIf( !Empty(SB2->B2_USAI), SB2->B2_USAI, dDataBase ) )
            SB2->B2_VFIM5   := xMoeda( SB2->B2_VFIM1, 1, 5, IIf( !Empty(SB2->B2_USAI), SB2->B2_USAI, dDataBase ) )
            SB2->(msUnlock())

            dbSkip()

        End

    EndIf

    dbSelectArea("SB9")
    dbSetOrder(1)
    If dbSeek( xFilial("SB9")+ZZ0->ZZ0_COD, .F. )
        While !Eof() .and. SB9->B9_FILIAL == xFilial("SB9") .and.;
            SB9->B9_COD == ZZ0->ZZ0_COD

            /*
            If Year(SB9->B9_DATA) #2000
                dbSkip()
                Loop
            EndIf
            */

            RecLock("SB9", .F.)
            SB9->B9_VINI1   := SB9->B9_QINI * ZZ0->ZZ0_CUSTO
            SB9->B9_VINI2   := xMoeda( SB9->B9_VINI1, 1, 2, SB9->B9_DATA )
            SB9->B9_VINI3   := xMoeda( SB9->B9_VINI1, 1, 3, SB9->B9_DATA )
            SB9->B9_VINI4   := xMoeda( SB9->B9_VINI1, 1, 4, SB9->B9_DATA )
            SB9->B9_VINI5   := xMoeda( SB9->B9_VINI1, 1, 5, SB9->B9_DATA )
            SB9->(msUnlock())

            dbSkip()
        End

    EndIf

    dbSelectArea("SD1")
    dbSetOrder(2)
    If dbSeek( xFilial("SD1")+ZZ0->ZZ0_COD, .F. )
        While !Eof() .and. ZZ0->ZZ0_COD == SD1->D1_COD .and.;
            SD1->D1_FILIAL == xFilial("SD1")

            /*
            If SD1->D1_DTDIGIT <= CTOD("01/01/00")
                dbSkip()
                Loop
            EndIf
            */

            RecLock("SD1", .F.)
            SD1->D1_CUSTO   := SD1->D1_QUANT * ZZ0->ZZ0_CUSTO
            SD1->D1_CUSTO2  := xMoeda( SD1->D1_CUSTO, 1, 2, SD1->D1_DTDIGIT )
            SD1->D1_CUSTO3  := xMoeda( SD1->D1_CUSTO, 1, 3, SD1->D1_DTDIGIT )
            SD1->D1_CUSTO4  := xMoeda( SD1->D1_CUSTO, 1, 4, SD1->D1_DTDIGIT )
            SD1->D1_CUSTO5  := xMoeda( SD1->D1_CUSTO, 1, 5, SD1->D1_DTDIGIT )
            SD1->(msUnlock())

            dbSkip()
        End

    EndIf


    dbSelectArea("SD3")
    dbSetOrder(3)
    If dbSeek( xFilial("SD3")+ZZ0->ZZ0_COD, .F. )
        While !Eof() .and. ZZ0->ZZ0_FILIAL == xFilial("ZZ0") .and.;
            ZZ0->ZZ0_COD == SD3->D3_COD

            /*
            If Year(SD3->D3_EMISSAO) #2000
                dbSkip()
                Loop
            EndIf

            If SD3->D3_TM #"002"
                dbSkip()
                Loop
            EndIf
            */

            RecLock("SD3", .F.)
            SD3->D3_CUSTO1  := SD3->D3_QUANT * ZZ0->ZZ0_CUSTO
            SD3->D3_CUSTO2  := xMoeda( SD3->D3_CUSTO1, 1, 2, SD3->D3_EMISSAO )
            SD3->D3_CUSTO3  := xMoeda( SD3->D3_CUSTO1, 1, 3, SD3->D3_EMISSAO )
            SD3->D3_CUSTO4  := xMoeda( SD3->D3_CUSTO1, 1, 4, SD3->D3_EMISSAO )
            SD3->D3_CUSTO5  := xMoeda( SD3->D3_CUSTO1, 1, 5, SD3->D3_EMISSAO )
            SD3->(msUnlock())

            dbSkip()
        End

    EndIf

    dbSelectArea("ZZ0")
    dbSkip()

End

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)
Return
