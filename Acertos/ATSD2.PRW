#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 30/03/02

/*SetPrvt("CINDEX,CKEY,MCHAVE,CARQ,MCONTA,")

lEnd  := .F.
bBloco:= {|lEnd| ATSD2(@lEnd)}
Processa( bBloco, "Aguarde" ,"Processando...", .T. )   
	
Static Function ATSD2()        // incluido pelo assistente de conversao do AP5 IDE em 30/03/02
ProcRegua(LastRec())
DBSELECTAREA("SD2")
cArq := "SD2"
cIndex := CriaTrab(Nil,.F.)
cKey:="D2_PEDIDO+D2_ITEMPV+D2_DOC       +D2_SERIE"
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")
DBGOTOP()
MCONTA:=0 
do while !eof()    
   IncProc("Lendo Registros : "+Str(Recno(),7)+"  DELETANDO...... "+StrZero(mConta,7))
   mchave=D2_PEDIDO+D2_ITEMPV+D2_DOC+D2_SERIE
   skip
   do while D2_PEDIDO+D2_ITEMPV+D2_DOC+D2_SERIE=mchave
       MCONTA:=MCONTA+1
       Reclock("SD2",.F.)
       dbdelete()
       MsUnLock()
       skip
   enddo
enddo
DbSelectArea("SD2")
Retindex("SD2")
Return*/