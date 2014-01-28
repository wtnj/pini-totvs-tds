#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 30/03/02
// Alterado por Danilo C S Pala 20050520: CFB
//Alterado por Danilo C S Pala em 20070315: CFE
//Alterado por Danilo C S Pala em 20070328: NFS
User Function ATSF303()
SetPrvt("CINDEX,CKEY,MCHAVE,CARQ,MCONTA,MCONTRIB,MEST,MCONTA1,MRECO")

cPerg:="FIS001"
If !Pergunte(cPerg,.t.)
   Return
Endif

lEnd  := .F.
bBloco:= {|lEnd| ATproc(@lEnd)}
Processa( bBloco, "Aguarde" ,"Processando...", .T. )  

Return

Static Function ATproc()        // incluido pelo assistente de conversao do AP5 IDE em 30/03/02
mReco:=0
Do While .T.
   DBSELECTAREA("SF3")
   ProcRegua(LastRec())
   DBGOTOP()
   MCONTA:=0
   If DbSeek(xFilial("SF3")+DTOS(MV_PAR01),.T.)
      do while F3_ENTRADA<=MV_PAR02
         IncProc("Data : "+Dtoc(F3_EMISSAO)+" ATUALIZANDO : "+StrZero(mConta,7))
         mChave:=F3_CLIEFOR
         mchave2:=F3_NFISCAL+F3_SERIE
         mContrib:=" "
         mReco:=Recno()
         DbSelectArea("SA1")
         DbSetOrder(1)
         If DbSeek(xFilial("SA1")+mCHAVE,.T.)
           If A1_COD==MCHAVE
              mEst:=A1_EST
              If ! EMPTY(A1_INSCR)
                 If 'ISEN' $ (A1_INSCR)
                    Reclock("SA1",.F.)
                    Repla A1_INSCR WITH '  '
                    MsUnLock()
                    mContrib:=" "
                 Else
                    mContrib:='S'
                 Endif
              ENDIF
           Endif

         Endif
         DBSELECTAREA("SF3")
         IF ! F3_SERIE $('UNI/D1 /CUP/CFS/CFA/CFB/ANG/CFE/NFS') .AND. F3_CFO>='500' //20050520 CFB //20061031 ANG //20070315 CFE  //20070328 NFS
            Reclock("SF3",.F.)
            DbDelete()
            MsUnLock()
         Endif
         IF F3_SERIE $('UNI/D1 /CUP/CFS/CFA/CFB/ANG/CFE/NFS') .AND. F3_CFO>='500' //20050520 CFB //20061031 ANG  //20070315 CFE  //20070328 NFS
            Reclock("SF3",.F.)

            If Empty(F3_ESTADO)
               REPLA F3_ESTADO WITH mEst  
               mConta:=mConta+1
            Endif

            IF F3_ESTADO='SP' .AND. SUBS(F3_CFO,1,1)='6'
               REPLA F3_CFO WITH '5'+SUBS(F3_CFO,2,4)
            ENDIF

            IF F3_ESTADO<>'SP' .AND. SUBS(F3_CFO,1,1)='5'
               REPLA F3_CFO WITH '6'+SUBS(F3_CFO,2,4)
            ENDIF

            IF F3_ESTADO='EX' .AND. SUBS(F3_CFO,1,1)<>'7'
               REPLA F3_CFO WITH '7'+SUBS(F3_CFO,2,4)
            ENDIF

            IF MCONTRIB='S' .AND. F3_CFO='612'
               REPLA F3_CFO WITH '619'
            ENDIF

            IF MCONTRIB='S' .AND. F3_CFO='611'
               REPLA F3_CFO WITH '618'
            ENDIF

            If Empty(F3_ESTADO) .AND.  SUBS(F3_CFO,1,1)='5'
              REPLA F3_ESTADO WITH 'SP'
            Endif

            If Empty(F3_ESTADO) .AND.  SUBS(F3_CFO,1,1)<>'5'
               REPLA F3_ESTADO WITH 'SP'
               REPLA F3_CFO WITH '5'+SUBS(F3_CFO,2,4)
            Endif

            MsUnLock()
         ENDIF
        skip
      enddo
   Endif
   MV_PAR01:=MV_PAR01+1
   IF MRECO<>0
      Exit
   ENDIF
Enddo
DbSelectArea("SF3")
Retindex("SF3")
Return
