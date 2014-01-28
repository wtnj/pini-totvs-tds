#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 30/03/02

User Function ATSF304()
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
         mReco:=Recno()
         IncProc("Data : "+Dtoc(F3_EMISSAO)+" ATUALIZANDO : "+StrZero(mConta,7))
         DBSELECTAREA("SD2")
         DBSETORDER(3)
         If DbSeek(xFilial("SD2")+SF3->F3_NFISCAL+SF3->F3_SERIE,.T.)
            do while SF3->F3_NFISCAL+SF3->F3_SERIE==SD2->D2_DOC+SD2->D2_SERIE
               If SD2->D2_CF<>SF3->F3_CFO .and. SD2->D2_EST<>SF3->F3_ESTADO
                  Reclock("SD2",.F.) 
                  REPLA D2_EST WITH SF3->F3_ESTADO
                  REPLA D2_CF  WITH SF3->F3_CFO
                  MsUnLock()
                  MCONTA++
               Endif 
               DbSkip()                       
            Enddo
         Endif
         DBSELECTAREA("SF3")
         DbSkip()           
      Enddo 
   Endif      
   MV_PAR01:=MV_PAR01+1
   IF MRECO<>0
      Exit
   ENDIF
Enddo
DbSelectArea("SF3")
Retindex("SF3")  
DbSelectArea("SD2")
Retindex("SD2")
Return
