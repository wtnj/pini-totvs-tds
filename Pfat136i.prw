#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

User Function Pfat136i()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("MFILTRO,MHORA,CARQ,CSTRING,CARQPATH,_CSTRING")
SetPrvt("CCHAVE,CFILTRO,CIND,MCONTA,MCONTA1,MCONTA2")
SetPrvt("MCONTA3,MPEDIDO,MITEM,MSITUAC,MDTSUSP,MDTVENC")
SetPrvt("MDTINIC,MEDSUSP,MEDIN,MQTDEX,MCF,MEDVENC")
SetPrvt("MCODCLI,MATUALIZA,MPER,MPER1,MPER2,MAMPLIADA")
SetPrvt("MPROD,MPARC,MPAGO,MABERTO,MFATOR,MDTPG")
SetPrvt("MPREFIXO,MPARCELA,MNUMERO,MTIPO,MMOTBX,MMOTIVO")
SetPrvt("MCONDICAO,MSALDO,MSALDO1,MCHAVE1,MCHAVE2,MPRODUTO")
SetPrvt("MPRODATU,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: PFAT136I  쿌utor: Raquel Ramalho         � Data:   28/08/01 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri눯o: Atualiza눯o da Edsusp p/ registro inadimpl na convers�o    � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento  Liberado para Usu쟲io em:           � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

#IFNDEF WINDOWS
    ScreenDraw("SMT050", 3, 0, 0, 0)
    SetCursor(1)
    SetColor("B/BG")
#ENDIF

mFiltro:=0
Do While .T.
   mHora     :=TIME()
   cArq      :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
   cString   :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
   cArqPath  :=GetMv("MV_PATHTMP")
   _cString  :=cArqPath+cString+".DBF"
   mFiltro:=mFiltro+1
   DbSelectArea("SC6")
   DbGoTop()
   cChave := IndexKey()
   Do Case
      Case mFiltro==1
           cFiltro:= "SUBS(C6_PRODUTO,1,4)=='0101' .AND. C6_EDVENC>=2791"
      Case mFiltro==2
           cFiltro:= "SUBS(C6_PRODUTO,1,4)=='0102' .AND. C6_EDVENC>=420 "
      Case mFiltro==3
           cFiltro:="SUBS(C6_PRODUTO,1,4)=='0103' .AND. C6_EDVENC>=339 "
      Case mFiltro==4
           cFiltro:="SUBS(C6_PRODUTO,1,4)=='0104' .AND. C6_EDVENC>=298 "
      Case mFiltro==5
           cFiltro:="SUBS(C6_PRODUTO,1,4)=='0105' .AND. C6_EDVENC>=394 "
      Case mFiltro==6
           cFiltro:="SUBS(C6_PRODUTO,1,4)=='0108' .AND. C6_EDVENC>=53  "
      Case mFiltro==7
           cFiltro:= "SUBS(C6_PRODUTO,1,4)=='0114' .AND. C6_EDVENC>=2791"
      OtherWise
           Exit
   EndCase

   cInd   := CriaTrab(NIL,.f.)
   IndRegua("SC6",cInd,cChave,,cFiltro,"Filtrando Pedidos...")
   COPY TO &_cString VIA "DBFCDXADS" // 20121106 

   DBSELECTAREA('SC6')
   RETINDEX('SC6')

   cArq:=_cString
   dbUseArea( .T.,, cArq,'EDIC', if(.F. .OR. .F., !.F., NIL), .F. )
   dbSelectArea('EDIC')
   mConta:=0
   mConta1:=0
   mConta2:=0
   mConta3:=0

   Do While !Eof()
      #IFNDEF WINDOWS
         @ 10,05 SAY "LENDO REGISTROS......." +StrZero(RECNO(),7)
         @ 11,05 SAY "GRAVANDO.............." +STR(MCONTA1,7)
         @ 12,05 SAY "REVISTA..............." +SUBS(EDIC->C6_PRODUTO,1,4)
      #ELSE
         MsProcTxt("Lendo Registros : "+Str(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
      #ENDIF

      mPedido  :=EDIC->C6_NUM
      mItem    :=EDIC->C6_ITEM
      mSituac  :=EDIC->C6_SITUAC
      mDtsusp  := stod("")
      mDtvenc  := stod("")
      mDtinic  := stod("")
      mEdsusp  :=EDIC->C6_EDSUSP
      mEdin    :=EDIC->C6_EDINIC
      mQtdex   :=(EDIC->C6_EDVENC)-(EDIC->C6_EDINIC)+1
      mCF      :=EDIC->C6_CF
      mEdvenc  :=EDIC->C6_EDVENC
      mCodcli  :=EDIC->C6_CLI
      mAtualiza:=""
      mPer     :=0
      mPer1    :=0
      mPer2    :=0
      mAmpliada:=""

      If Empty(mPedido)
         DbSelectArea("EDIC")
         DbSkip()
         Loop
      Endif

      If 'S' $(mPedido)
         DbSelectArea("EDIC")
         DbSkip()
         Loop
      Endif

      If SUBS(EDIC->C6_PRODUTO,5,3)=='001'
         DbSelectArea("EDIC")
         DbSkip()
         Loop
      Endif

      If EDIC->C6_EDINIC==9999
         DbSelectArea("EDIC")
         DbSkip()
         Loop
      Endif

      If SUBS(EDIC->C6_PRODUTO,5,3)=='008';
         .or. SUBS(EDIC->C6_PRODUTO,5,3)=='009';
         .or. SUBS(EDIC->C6_PRODUTO,5,3)=='010';
         .or. SUBS(EDIC->C6_PRODUTO,5,3)=='011'
         mAmpliada:='S'
      Endif

      mProd    :=SUBS(EDIC->C6_PRODUTO,1,4)
      If mProd=='0114'
         mProd:='0101'
         mAmpliada:='S'
      Endif

      If mEdsusp==0
         mEdsusp:=EDIC->C6_EDVENC
      Endif

      If '99' $(mcf)
         DbSelectArea("EDIC")
         DbSkip()
         Loop
      Endif

      DbSelectArea("SZJ")
      DbSeek(xFilial("SZJ")+mProd+STR(mEdvenc,4),.T.)
      If found()
         Mdtvenc:=ZJ_DTCIRC
      Else
        Alert("N�o localizou no cronograma"+mprod+str(medvenc,4))
        Alert("N�o localizou no cronograma"+mPedido+mItem)
        Alert("Atualize cronograma antes de reiniciar o processo")
      Endif

      DbSelectArea("SZJ")
      DbSeek(xFilial("SZJ")+mProd+STR(mEdin,4),.T.)
      If found()
         If mProd=='0108' .and. mEdin==53
            Mdtinic:=ZJ_DTCIRC+30
         Else
            Mdtinic:=ZJ_DTCIRC
         Endif
      Else
        Alert("N�o localizou no cronograma"+mprod+str(medvenc,4))
        Alert("N�o localizou no cronograma"+mPedido+mItem)
        Alert("Atualize cronograma antes de reiniciar o processo")
      Endif

      mConta2:=mConta2+1

      dbSelectArea("SE1")
	  DbOrderNickName("E1_PEDIDO") //dbSetOrder(27) 20130225  ///dbSetOrder(15) AP5  //20090114 era(21) //20090723 mp10 era(22) //dbSetOrder(26) 20100412
      dbGoTop()
      dbSeek(XFILIAL()+mPedido)
      If Found()
         mParc:=0
         mpago:=0
         mAberto:=0
         mFator:=0
         Do While SE1->E1_PEDIDO==mPedido
            mParc   :=MPARC+1
            mDtpg   :=SE1->E1_BAIXA
            mPrefixo:=SE1->E1_PREFIXO
            mParcela:=SE1->E1_PARCELA
            mNumero :=SE1->E1_NUM
            mTipo   :=SE1->E1_TIPO
            mMotbx  :="  "
            mMotivo :="  "

            mCondicao:=mPrefixo+mNumero+mParcela+mTipo+mCodcli
            If DTOC(mDtpg)<>'  /  /  ' .and. SE1->E1_SALDO==0;
               .AND.!'LP' $(SE1->E1_MOTIVO);
               .AND.!'CAN'$(SE1->E1_MOTIVO);
               .AND.!'DEV'$(SE1->E1_MOTIVO)

               dbSelectArea("SE5")
               dbSetOrder(7)
               dbGoTop()
               dbSeek(xFilial()+mCondicao)
               If Found()
                  Do While SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+;
                     SE5->E5_TIPO+SE5->E5_CLIFOR==mCondicao
                     If SE5->E5_RECPAG=='R'
                        mMotbx:=ALLTRIM(SE5->E5_MOTBX)
                     Endif
                     dbSkip()
                  Enddo
               Endif
               If mMotbx<>'CAN' .AND. mMotbx<>'DEV' .AND. mMotbx<>'LP'
                  mPago:=mPago+1
               Else
                  mAberto:=mAberto+1
                  mMotivo:=SUBS(SE5->E5_MOTBX,1,2)
               Endif
            Else
              IF SE1->E1_VENCTO<DATE()-90
                 mConta:=mConta+1
              ENDIF
              If SE1->E1_VENCTO+30 < DATE() //30 DIAS P/ PROCESSO DE COBRANCA
                 mAberto:=mAberto+1
                 mConta3:=mConta3+1
                 If 'LP' $(SE1->E1_MOTIVO).OR.;
                    'CAN'$(SE1->E1_MOTIVO).OR.;
                    'DEV'$(SE1->E1_MOTIVO)
                     mMotivo:=SUBS(SE1->E1_MOTIVO,1,2)
                 Endif
              Endif
            Endif
            dbSelectArea("SE1")
            dbSkip()
         Enddo
         mFator:=mPago/mParc
      Else
         mFator :=1
         mSituac:='AA'
      Endif

      iF mProd=='0108'
         mSaldo:=((mEdvenc-Medin)+1)*mFator
         mSaldo1:=mSaldo-(53-mEdin)
      Else
         mPer:=(mDtvenc-mDtinic)*mfator
         mPer1:=CTOD('01/08/01')-mDtinic

         If mDtinic>=ctod('01/08/01')
           mPer2:= mPer
         Else
           mPer2:= mPer-mPer1
         Endif
      Endif

      DbSelectArea("ZC6")
      DbSetOrder(7)
      DbSeek(xFilial("ZC6")+mPedido+mItem, .T.)
      If Found()
         DO WHILE ZC6->C6_NUM+ZC6->C6_ITEMPANT==MPEDIDO+MITEM
            mChave1 :=ZC6->C6_NUM
            mChave2 :=ZC6->c6_NUM+C6_ITEM
            mProduto:=SUBS(ZC6->C6_PRODUTO,1,4)
            DbSelectArea("SC6")
            DbGotop()
            DbSeek(xFilial("SC6")+mChave2, .T.)
            If found()
               mAtualiza:=""
               mEdin    :=SC6->C6_EDINIC
               mEdvenc  :=SC6->C6_EDVENC
               mProdatu :=SUBS(ZC6->C6_PRODUTO,1,4)

               DbSelectArea("SZJ")
               DbSeek(xFilial("SZJ")+mProdatu+STR(mEdin,4),.T.)
               If found()
                  mDtinic:=ZJ_DTCIRC
               Else
                 Alert("N�o localizou no cronograma"+mProdatu+Str(mEdin,4))
                 Alert("N�o localizou no cronograma"+mChave2)
                 Alert("Atualize cronograma antes de reiniciar o processo")
               Endif
               If mProd=='0108'
                  mEdsusp:=mEdin+mSaldo1
                  DbSelectArea("SZJ")
                  DbSeek(xFilial("SZJ")+mProdatu+STR(mEdsusp,4),.T.)
                  If found()
                      mDtsusp:=ZJ_DTCIRC
                  Endif
               Else
                  mDtsusp:=mDtinic+mPer2  // atualiza o pedido pelo per죓do em dias (deduz per죓do j� recebido).
               Endif

               If mFator<>1 .and. mDtsusp<date()-30
                  Do Case
                     Case mMotivo<>'  '
                          mSituac:=mMotivo
                      OtherWise
                          mSituac:='SI'
                   EndCase
               Else
                   mSituac:='AA'
               Endif

               If mProdatu=='0116'
                  If Month(mDtsusp)==07 .and. Year(mDtsusp)==2001
                     mDtsusp:=mDtsusp+30
                  Endif
               Endif

               If mProd<>'0108'
                  DbSelectArea("SZJ")
                  DbSeek(xFilial("SZJ")+mProdatu,.T.)
                  If found()
                     Do While ZJ_CODREV==mProdatu
                        IF MONTH(ZJ_DTCIRC)==MONTH(MDTSUSP) .AND. YEAR(ZJ_DTCIRC)==YEAR(MDTSUSP)
                           mEdsusp:=ZJ_EDICAO
                           mDtsusp:=ZJ_DTCIRC
                           EXIT
                        ENDIF
                          DbSkip()
                     Enddo
                  Else
                     Medsusp:=0
                     Alert("N�o localizou no cronograma"+mProdatu+Dtoc(mDtsusp))
                     Alert("N�o localizou no cronograma"+mChave2)
                     Alert("Atualize cronograma antes de reiniciar o processo")
                  Endif
               Endif

               If mFator<>1
                  IF mDtsusp<CTOD('01/08/2001')
                     Do Case
                        Case mProdatu=='0115'
                          mEdsusp:=1
                        Case mProdatu=='0116'
                          mEdsusp:=53
                     EndCase
                  Endif
               Endif

               If mAberto==0 .and. mFator==1
                  mEdsusp:=SC6->C6_EDVENC
               Endif

               If 'CP' $(SC6->C6_SITUAC)
                  mAtualiza:='N'
               Endif

               If 'SU' $(SC6->C6_SITUAC)
                  mAtualiza:='N'
               Endif

               If 'SE' $(SC6->C6_SITUAC)
                  mAtualiza:='N'
               Endif

               If SC6->C6_EDSUSP<>MEdsusp .and. mAtualiza<>'N'
                  mConta1:=mConta1+1
                  Reclock("SC6",.F.)
                  REPLACE C6_EDSUSP  WITH mEdsusp
                  REPLACE C6_DTCANC  WITH mDtsusp
                  REPLACE C6_SITUAC  WITH mSituac
                  SC6->(Msunlock())
                  mAtualiza:='E'
               Endif

               If SC6->C6_SITUAC<>mSituac .and. mAtualiza<>'N'
                  Reclock("SC6",.F.)
                  REPLACE C6_SITUAC  WITH mSituac
                  SC6->(Msunlock())
                  mAtualiza:='C'
               Endif
            Else
               mAtualiza:='N'
               Alert("N�o atualizou pedido"+mChave2)
               Alert("Atualize Pedido no SC6")
            Endif
            DbSelectArea("ZC6")
            DbSkip()
         Enddo
      Endif
      DbSelectArea("EDIC")
      If mAtualiza<>'N'
         REPLACE C6_SITUAC  WITH mAtualiza+'S'
      Endif
      DbSkip()
   ENDDO
   DbSelectArea("EDIC")
   DBCLOSEAREA()
   FErase(_cString)
   If mConta==mConta3
      Alert("N�o � necess쟲io rodar este programa. Avise CPD p/ verifica눯o")
      Alert("Todos os t죜ulos venceram a mais de 90 dias")
   Endif
ENDDO

DBSELECTAREA('SC6')
RETINDEX('SC6')

DBSELECTAREA('SZJ')
RETINDEX('SZJ')

DBSELECTAREA('ZC6')
RETINDEX('SZ6')


Return(nil)        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

