#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 30/03/02

SetPrvt("CINDEX,CKEY,MCHAVE,CARQ,MCONTA,MCONTRIB,MEST.MCONTA1,")

lEnd  := .F.
bBloco:= {|lEnd| ATSD201(@lEnd)}
Processa( bBloco, "Aguarde" ,"Processando...", .T. )  
	
Static Function ATSD201()        // incluido pelo assistente de conversao do AP5 IDE em 30/03/02
cPerg:="FIS001"
MCONTA:=0
MCONTA1:=0
MRECO:=0
If !Pergunte(cPerg)
   Return
Endif  

Local cQuerySD2 := ""
cQuerySD2 += "SELECT * FROM " + RetSqlName("SD2") + " SD2"
cQuerySD2 += " WHERE SD2.D2_FILIAL = '" + xFilial("SD2") + "'"
cQuerySD2 += " AND SD2.D2_EMISSAO BETWEEN '" + DTOS(MV_PAR01) + "' AND '" + DTOS(MV_PAR02) + "'"
cQuerySD2 += " AND SD2.D_E_L_E_T_ <> '*' "
cQuerySD2 += " ORDER BY SD2.D2_FILIAL, SD2.D2_EMISSAO"  
lEnd := .f.

If Select("TRB") <> 0
	DbselectArea("TRB")
	DbCloseArea()
EndIf	

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuerySD2), "TRB", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")

TcSetField("TRB","D2_EMISSAO","D")

   DbselectArea("TRB")
   Dbgotop()
   do while !eof() .AND. TRB->D2_EMISSAO<=MV_PAR02  
      IncProc("Lendo Registros : "+Str(mReco(),7)+" ATUALIZANDO : "+StrZero(mConta,7))
      mChave:=D2_CLIENTE
      mContrib:=" "
      mReco:=mReco-1
      DbSelectArea("SA1")
      DbSetOrder(1)
      If DbSeek(xFilial("SA1")+mCHAVE,.T.)
        If A1_COD==MCHAVE
           mEst:=A1_EST 
           If ! EMPTY(A1_INSCR)
              If 'ISEN' $ (A1_INSCR)
                 mContrib:=' '
              Else
                 mContrib:='S'
              Endif
           ENDIF         
        Endif   
      Endif                       
      DBSELECTAREA("TRB")   
      IF D2_SERIE $('UNI/D1/CUP') .AND. D2_CF>='500' 
         Reclock("TRB",.F.)
  
         If Empty(D2_EST) 
            REPLA D2_EST WITH mEST
            MCONTA1:=MCONTA1+1
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

         IF MCONTRIB='S' .AND. D2_CF='612'
            REPLA D2_CF WITH '619' 
            MCONTA:=MCONTA+1
         ENDIF

         IF MCONTRIB='S' .AND. D2_CF='611'
            REPLA D2_CF WITH '618' 
            MCONTA:=MCONTA+1
         ENDIF  
         MsUnLock() 
      ENDIF
      DbSelectArea("SC6")
      DbSetOrder(1)
      If DbSeek(xFilial("SC6")+TRB->D2_PEDIDO+TRB->D2_ITEMPV,.T.)   
         If TRB->D2_CF<>SC6->C6_CF .and. TRB->d2_pedido==c6_num .and. TRB->d2_itempv==c6_item .and. TRB->d2_cod==c6_produto
            Reclock("SC6",.F.)
            C6_CF:=TRB->D2_CF 
            MsUnLock() 
         Endif
      Endif
      DbSelectArea("TRB")
      skip
   enddo  

MSGALERT("ATUALIZOU CF" +STR(MCONTA,7)+" REGISTROS")  
MSGALERT("ATUALIZOU ESTADO" +STR(MCONTA1,7)+" REGISTROS")
  
DbSelectArea("TRB")
DbCloseArea()
Return