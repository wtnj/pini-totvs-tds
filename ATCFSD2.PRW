#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 30/03/02

// Alterado por Danilo C S Pala 20050520: CFB
//Alterado por Danilo C S Pala em 20070315: CFE
//Alterado por Danilo C S Pala em 20070328: NFS
//Alterado por Danilo C S Pala em 20080220: SEN
//Alterado por Danilo C S Pala em 20081031: STD
/*SetPrvt("CINDEX,CKEY,MCHAVE,CARQ,MCONTA,MCONTRIB,MEST,MCONTA1,MRECO")

lEnd  := .F.
bBloco:= {|lEnd| ATSD201(@lEnd)}
Processa( bBloco, "Aguarde" ,"Processando...", .T. )
  */
Static Function ATSD201()        // incluido pelo assistente de conversao do AP5 IDE em 30/03/02
cPerg:="FIS001"
MCONTA:=0
MCONTA1:=0
MRECO:=0
If !Pergunte(cPerg)
   Return
Endif
Do While .T. 
DBSELECTAREA("SD2")
ProcRegua(LastRec())
DBGOTOP()
DbSetOrder(5)
If DbSeek(xFilial("SD2")+DTOS(MV_PAR01),.T.)
   do while !eof() .AND. SD2->D2_EMISSAO<=MV_PAR02
      IncProc("Data:"+DTOC(D2_EMISSAO)+"  Registros Atualizados: "+StrZero(mConta,7))
      mChave:=D2_CLIENTE
      mContrib:="N"
      mReco:=Recno()
      DbSelectArea("SA1")
      DbSetOrder(1)
      If DbSeek(xFilial("SA1")+mCHAVE,.T.)
        If A1_COD==MCHAVE
           mEst:=A1_EST
           If ! EMPTY(A1_INSCR)
              If 'ISEN' $ (A1_INSCR)
                 mContrib:='N'
              Else
                 mContrib:='S'
              Endif
           ENDIF
        Endif
      Endif         
      
      Reclock("SA1",.F.)
      SA1->A1_FLAGID :=mContrib
      MsUnLock()     
      
      DBSELECTAREA("SD2")     
      IF D2_DOC='001101' .or. D2_DOC='001189'    .or. D2_DOC='001140' 
         MSGALERT("ACHOU PEDIDO")
      ENDIF
      IF D2_SERIE $('UNI/D1 /CUP/LIV/PUB/CFS/CFA/CFB/ANG/CFE/NFS/SEN/STD/   /8  ') .AND. D2_TES>='500'      //20040816: PUB  //20050520 CFB //20061031 ANG //20070315 CFE //20070328 NFS //20080220 SEN //20081031 STD
         Reclock("SD2",.F.)

         If Empty(D2_EST)
            REPLA D2_EST WITH mEST
            MCONTA1:=MCONTA1+1
         Endif

         If DTOS(SD2->D2_EMISSAO)<='20001231'  .and. SM0->M0_CODIGO=='01'
            REPLA D2_CLASFIS WITH '04'
         Endif
         
         If DTOS(SD2->D2_EMISSAO)>'20001231'  .and. SM0->M0_CODIGO=='01'
            REPLA D2_CLASFIS WITH '040'
         Endif         
         
         If DTOS(SD2->D2_EMISSAO)<='20001231' .and. D2_GRUPO='3800'.and. SM0->M0_CODIGO=='03'
            REPLA D2_CLASFIS WITH '00'
         Endif
         
         If DTOS(SD2->D2_EMISSAO)>'200031231' .and. D2_GRUPO='3800'.and. SM0->M0_CODIGO=='03'
            REPLA D2_CLASFIS WITH '000'
         Endif

         IF D2_EST='SP' .AND. SUBS(D2_CF,1,1)='6'
            REPLA D2_CF WITH '5'+SUBS(D2_CF,2,4)
            MCONTA:=MCONTA+1
         ENDIF

         IF D2_EST<>'SP' .AND. SUBS(D2_CF,1,1)='5'
            REPLA D2_CF WITH '6'+SUBS(D2_CF,2,4)
            MCONTA:=MCONTA+1
         ENDIF

         IF D2_EST='EX' .AND. SUBS(D2_CF,1,1)<>'7'
            REPLA D2_CF WITH '7'+SUBS(D2_CF,2,4)
            MCONTA:=MCONTA+1
         ENDIF
         
         IF YEAR(D2_EMISSAO)<=2002
            IF MCONTRIB<>'S' .AND. D2_CF='612 '
               REPLA D2_CF WITH '619'
               MCONTA:=MCONTA+1
            ENDIF

            IF MCONTRIB<>'S' .AND. D2_CF='611 '
               REPLA D2_CF WITH '618'
               MCONTA:=MCONTA+1
            ENDIF

            IF D2_CF='518 ' .AND. D2_EST='SP'
               REPLA D2_CF WITH '511'
            ENDIF  
         Endif
            
         IF YEAR(D2_EMISSAO)>=2003
               IF MCONTRIB<>'S' .AND. D2_CF='6102'
               REPLA D2_CF WITH '6108'
               MCONTA:=MCONTA+1
            ENDIF

            IF MCONTRIB<>'S' .AND. D2_CF='6101'
               REPLA D2_CF WITH '6107'
               MCONTA:=MCONTA+1
            ENDIF

            IF D2_CF='6107' .AND. D2_EST='SP'
               REPLA D2_CF WITH '5101'
            ENDIF   

            IF D2_CF='6108' .AND. D2_EST='SP'
               REPLA D2_CF WITH '5102'
            ENDIF  
               
                  
            IF D2_CF='552 '
               REPLA D2_CF WITH '5303'
            Endif  
            
            IF D2_CF='652 '
               REPLA D2_CF WITH '6303'
            Endif
            
            IF D2_CF='553 '
               REPLA D2_CF WITH '5307'
            Endif  
            
            IF D2_CF='653 '
               REPLA D2_CF WITH '6307'
            Endif
            
            IF D2_CF='511 '
               REPLA D2_CF WITH '5101'
            Endif  
            
            IF D2_CF='611 '
               REPLA D2_CF WITH '6101'
            Endif                  
            
            IF D2_CF='512 '
               REPLA D2_CF WITH '5102'
            Endif  
            
            IF D2_CF='612 '
               REPLA D2_CF WITH '6102'
            Endif   
            IF D2_CF='522 '
               REPLA D2_CF WITH '5152'
            Endif  
            
            IF D2_CF='622 '
               REPLA D2_CF WITH '6152'
            Endif
         Endif
         
         MsUnLock()
      ENDIF
      DbSelectArea("SC6")
      DbSetOrder(1)
      If DbSeek(xFilial("SC6")+SD2->D2_PEDIDO+SD2->D2_ITEMPV,.T.)
         If SD2->D2_CF<>SC6->C6_CF .and. sd2->d2_pedido==c6_num .and. sd2->d2_itempv==c6_item .and. sd2->d2_cod==c6_produto
            Reclock("SC6",.F.)
            C6_CF:=SD2->D2_CF
            MsUnLock()
         Endif
          Reclock("SC6",.F.)
          C6_CLASFIS:=SD2->D2_CLASFIS
          MsUnLock()
      Endif
      DbSelectArea("SD2")
      skip
   enddo
Endif
MV_PAR01:=MV_PAR01+1
IF MRECO<>0
   Exit
ENDIF
Enddo
MSGALERT("ATUALIZOU CF" +STR(MCONTA,7)+" REGISTROS")
MSGALERT("ATUALIZOU ESTADO" +STR(MCONTA1,7)+" REGISTROS")
DbSelectArea("SD2")
Retindex("SD2")
Return
