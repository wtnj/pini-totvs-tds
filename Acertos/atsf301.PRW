#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 30/03/02

User Function ATSF301()
SetPrvt("CINDEX,CKEY,MCHAVE,CARQ,MCONTA,MCONTRIB,MEST,MCONTA1,MRECO")

cPerg:="FIS001"
If !Pergunte(cPerg,.t.)
   Return
Endif

lEnd  := .F.
bBloco:= {|lEnd| ATSF3proc(@lEnd)}
Processa( bBloco, "Aguarde" ,"Processando...", .T. )  

Return

Static Function ATSF3proc()        // incluido pelo assistente de conversao do AP5 IDE em 30/03/02


MCONTA:=0
MCONTA1:=0
MRECO:=0


Do While .T.
   DBSELECTAREA("SF3")
   ProcRegua(LastRec())
   DBGOTOP()
   MCONTA:=0
   If DbSeek(xFilial("SF3")+DTOS(MV_PAR01),.T.)
      do while SF3->F3_ENTRADA<=MV_PAR02
         IncProc("Data : "+Dtoc(F3_EMISSAO)+" ATUALIZANDO : "+StrZero(mConta,7))
         mChave:=F3_CLIEFOR
         mchave2:=F3_NFISCAL+F3_SERIE
         mContrib:=" "
         mReco:=Recno()
         DBSELECTAREA("SF3")
         IF ! F3_SERIE $('UNI/D1 /CUP') .AND. F3_CFO>='500'
            Reclock("SF3",.F.)
            DbDelete()
            MsUnLock()
         Endif 
         IF F3_CFO $('161 /165 /162 /163 /164 /262 /264 ') 
            Reclock("SF3",.F.)
            REPLA F3_ESPECIE WITH 'CTR'
            MCONTA:=MCONTA+1
            MsUnLock()
            DBSELECTAREA("SF1")
            If DbSeek(xFilial("SF1")+SF3->F3_NFISCAL,.T.) 
            Reclock("SF1",.F.)
            REPLA F1_ESPECIE WITH 'CTR'
            MsUnLock()
            Endif
         Endif
         DBSELECTAREA("SF3")
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
DbSelectArea("SF1")
Retindex("SF1")
Return
