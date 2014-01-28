#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 30/03/02

User Function ATSD201()
SetPrvt("CINDEX,CKEY,MCONTA,MGRUPO,MDESC")
lEnd  := .F.
bBloco:= {|lEnd| ATproc(@lEnd)}
Processa( bBloco, "Aguarde" ,"Processando...", .T. )  

Return

Static Function ATproc()   

DbSelectArea("SD2") 
ProcRegua(LastRec())
DBSETORDER(5)
DBGOTOP()
DBSEEK(XFILIAL()+'20020101',.T.)
DO WHILE .NOT. EOF() .AND. DTOS(D2_EMISSAO)>='20020101' .AND. SM0->M0_CODIGO $ ('01/02')
   IncProc("Data : "+Dtoc(D2_EMISSAO)+" ATUALIZANDO : "+StrZero(RECNO(),7))
   MCONTA:=' '                
   MGRUPO:=' '        
   MDESC:= ' '
   DbSelectArea("SB1") 
   DBSETORDER(1)
   DBGOTOP()
   DBSEEK(XFILIAL()+SD2->D2_COD,.T.) 
   MDESC:=SB1->B1_DESC  
   
   DbSelectArea("SD2") 
   IF SUBSTR(D2_COD,1,4)=='0307'
      MCONTA:='31010104001'
   ENDIF   
    
   IF SUBSTR(D2_COD,1,4)=='0301'  .or.SUBSTR(D2_COD,1,4)=='0302'  .or.;
      SUBSTR(D2_COD,1,4)=='0303'  .or. SUBSTR(D2_COD,1,4)=='0304'  .or.;
      SUBSTR(D2_COD,1,4)=='0305' 
      MCONTA:='31010104003'
   ENDIF      
   
   IF SUBSTR(D2_COD,1,4)=='0306'
      MCONTA:='31010104005'
   ENDIF   
   
   IF SUBSTR(D2_COD,1,4)=='0308'
      MCONTA:='31010104002'
   ENDIF  
     
   IF SUBSTR(D2_COD,1,4)=='0309'  .or. SUBSTR(D2_COD,1,4)=='0310'  .or. ;
      SUBSTR(D2_COD,1,4)=='0311'  .or. SUBSTR(D2_COD,1,4)=='0313'  .or.;
      SUBSTR(D2_COD,1,4)=='0315'  .or. SUBSTR(D2_COD,1,4)=='0316'  .or.; 
      SUBSTR(D2_COD,1,4)=='3630'  .or. SUBSTR(D2_COD,1,4)=='3610'  .or.;
      SUBSTR(D2_COD,1,4)=='0317'  .or. SUBSTR(D2_COD,1,4)=='0319' .or.  SUBSTR(D2_COD,1,4)=='0399'
      MCONTA:='31010104006'
   ENDIF      
   
   IF SUBSTR(D2_COD,1,2)=='08'
      MCONTA:='31010104006'
   ENDIF  
   
   IF SUBSTR(D2_COD,1,4)=='0312' .OR. SUBSTR(D2_COD,1,4)=='0323'
      MCONTA:='31010104005'
   ENDIF
   IF SUBSTR(D2_COD,1,4)=='0314' .OR. SUBSTR(D2_COD,1,4)=='0214'
      MCONTA:='31010104006'
   ENDIF
   IF SUBSTR(D2_COD,1,4)=='0318'
      MCONTA:='31010104004'
   ENDIF
   IF SUBSTR(D2_COD,1,4)=='0320'
      MCONTA:='31010104003'
   ENDIF
   IF SUBSTR(D2_COD,1,4)=='0321'
      MCONTA:='31010104002'
   ENDIF 
   
   IF SUBSTR(D2_COD,1,4)=='0322'
      MCONTA:='31010104007'
   ENDIF   
   
   IF SUBSTR(D2_COD,1,4)=='0699' .OR. SUBSTR(D2_COD,1,2)=='09'
      MCONTA:='31010108003'
   ENDIF
   
   IF SUBSTR(D2_COD,1,7)=='0202326' .OR. D2_GRUPO='0201' .OR. D2_GRUPO='0202'
      MCONTA:='31010105003'
   ENDIF    
   
   IF D2_GRUPO=='0100'  .and. subs(D2_cod,1,2)='01'
      MCONTA:='21080101001'
   ENDIF     
   
   IF SUBSTR(D2_COD,1,4)=='0107' .AND. SUBSTR(D2_COD,5,3)=='001'
      MCONTA:='31010101002'
   ENDIF    
         
   IF SUBSTR(D2_COD,1,4)=='0124' .AND. SUBSTR(D2_COD,5,3)=='001'       // AU CONVERSAO
      MCONTA:='31010101002'
   ENDIF        
   
   IF SUBSTR(D2_COD,1,4)=='0115' .AND. SUBSTR(D2_COD,5,3)=='001'
      MCONTA:='31010103002'
   ENDIF
   
   IF SUBSTR(D2_COD,1,4)=='0116' .AND. SUBSTR(D2_COD,5,3)=='001'
      MCONTA:='31010102002'
   ENDIF
   
   IF MCONTA=' ' .AND. D2_GRUPO='0101'
      MCONTA:='31010101003'
   ENDIF
   
   IF D2_GRUPO=='0200'
      MCONTA:='31010105001'
   ENDIF 
   
   IF D2_GRUPO=='0198'
      MCONTA:='31010101003'
   ENDIF


   IF D2_TP=='CD' .OR.  D2_TP='MR'
      MCONTA:='31010106001'
   ENDIF        
  
   IF D2_TP=='DC'
      MCONTA:='31010106002'
   ENDIF
          
   IF D2_TP=='VC'
      MCONTA:='31010107002'
   ENDIF
   
   IF D2_TP=='VI'
      MCONTA:='31010107001'
   ENDIF

   IF D2_GRUPO=='0601'
      MCONTA:='31010108001'
   ENDIF
   
   IF SUBSTR(D2_COD,1,2)=='10' 
      MCONTA:='31010109001'
   ENDIF

   IF SUBSTR(D2_COD,1,2)=='10' .AND. ' AV' $(MDESC)
      MCONTA:='31010109002'                             
      MGRUPO:='1001'
   ENDIF    
   
   IF SUBSTR(D2_COD,1,2)='04'
      MCONTA:='31010110001'
   ENDIF 
   
   IF SUBSTR(D2_COD,1,2)='05'
      MCONTA:='31010111001'
   ENDIF   
 
   RECLOCK('SD2',.F.)
   REPLA D2_CONTA WITH MCONTA
   IF MGRUPO<>' '
      REPLA D2_GRUPO WITH MGRUPO
   ENDIF
   MSUNLOCK()
   DBSKIP()
ENDDO
DbSelectArea("SD2")
Retindex("SD2")
Return
