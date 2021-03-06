#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function Sf2520e()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("_CALIAS,_NINDEX,_NREG,_NINDSD2,_NREGSD2,_NINDSC5")
SetPrvt("_NREGSC5,")

/*/

複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: SF2520E   쿌utor: Fabio William          � Data:   07/07/97 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri놹o: Volta a situacao antes da Preparacao.                      � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento                                      � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

IF SM0->M0_CODIGO #'01'    //ESTA PARTE TRATA APENAS DE PUBLICIDADE(EDITORA)

// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==>     __RETURN(.T.)
Return(.T.)        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02
        RETURN
ENDIF

_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()

DbSelectArea("SD2")
_nIndSD2 := IndexOrd()
_nRegSd2 := Recno()
DbSetOrder(01)

DbSelectArea("SC5")
_nIndSC5 := IndexOrd()
_nRegSC5 := Recno()

DbSelectArea("SD2")
DbSetOrder(03)
DbSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE)
While !eof() .and. SF2->F2_FILIAL+SF2->F2_DOC+SF2->F2_SERIE == xFilial("SD2")+SD2->D2_DOC+SD2->D2_SERIE
        //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
        //� Posiciona os Arquivos SC5 e SC6                     �
        //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
        DbSelectArea("SC5")
        DbSeek(xFilial("SC5")+SD2->D2_PEDIDO)

        If SC5->C5_AVESP == "S" // Somente AV Com pagamento Especial
                DbSelectArea("SZV")
                DbSetOrder(01)
                DbSeek(xFilial("SZV")+SD2->D2_PEDIDO)
                While !eof() .AND. xFilial("SZV")+SD2->D2_PEDIDO == SZV->ZV_FILIAL+SZV->ZV_NUMAV
                        If SZV->ZV_NFISCAL == SF2->F2_DOC
                                RecLock("SZV",.F.)
                                SZV->ZV_NFISCAL := "  "
                                SZV->ZV_SERIE   := "  "
                                SZV->ZV_DTNF    := CTOD('  /  /  ')
                                MsUnlock()
                        Endif
                        DbSkip()
                End
        Endif

        DbSelectArea("SZS")
        DbSetOrder(01)
        DbSeek(xFilial("SZS")+SD2->D2_PEDIDO+SD2->D2_ITEMPV)
        While !EOF() .AND. xFilial("SZS")+SD2->D2_PEDIDO+SD2->D2_ITEMPV == SZS->ZS_FILIAL+SZS->ZS_NUMAV+SZS->ZS_ITEM
                If SZS->ZS_NFISCAL == SF2->F2_DOC // Libera Somente Itens que tenha N.F.
                        RecLock("SZS",.F.)
                        SZS->ZS_NFISCAL := "  "
                        SZS->ZS_SERIE   := "  "
                        SZS->ZS_DTNF    := CTOD('  /  /  ')
                        SZS->ZS_LIBFAT  := CTOD('  /  /  ')
                        MsUnlock()
                EndIf
                DbSkip()
        End

        DbSelectArea("SD2")
        DbSkip()

Enddo

DbSelectArea("SD2")
DbSetOrder(_nIndSD2)
DbGoTo(_nRegSd2)

DbSelectArea("SC5")
DbSetorder(_nIndSC5)
DbGoTo(_nRegSC5)


dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)

Return

