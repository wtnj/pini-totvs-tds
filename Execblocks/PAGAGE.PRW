#include "rwmake.ch"        

User Function PAGAGE()      

SetPrvt("_AGENCIACTA")

/////  VERIFICACAO DA AGENCIA E CONTA A SEREM UTILIZADOS NO DEPOSITO BANCARIO

_AGENCIACTA  :=  ""

IF SA2->A2_BANCO== "341"
   _AGENCIACTA := Padl(Substr(Alltrim(SA2->A2_AGENCIA),1,4),5,"0")+" "+Padl(Substr(Alltrim(SA2->A2_NUMCON),1,5),10,"0")+Right(Alltrim(SA2->A2_NUMCON),1)
Else
   _AGENCIACTA := Padl(Substr(Alltrim(SA2->A2_AGENCIA),1,5),5,"0")+" "+;
                  If(Substr(SA2->A2_NUMCON,5,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,4)),10,"0"),;
                  If(Substr(SA2->A2_NUMCON,6,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,5)),10,"0"),;
                  If(Substr(SA2->A2_NUMCON,7,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,6)),10,"0"),;
                  If(Substr(SA2->A2_NUMCON,8,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,7)),10,"0"),;
                  If(Substr(SA2->A2_NUMCON,9,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,8)),10,"0"),;
                  If(Substr(SA2->A2_NUMCON,10,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,9)),10,"0"),;
                  If(Substr(SA2->A2_NUMCON,11,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,10)),10,"0"),;                                    
                  Padl(Alltrim(SA2->A2_NUMCON),10,"0"))))))))+;
                  If(Substr(SA2->A2_NUMCON,5,1)=="-",If(Substr(SA2->A2_NUMCON,7,1)=" ",""+Right(Alltrim(SA2->A2_NUMCON),1),Substr(SA2->A2_NUMCON,6,2)),;   
                  If(Substr(SA2->A2_NUMCON,6,1)=="-",If(Substr(SA2->A2_NUMCON,8,1)=" ",""+Right(Alltrim(SA2->A2_NUMCON),1),Substr(SA2->A2_NUMCON,7,2)),;                  
                  If(Substr(SA2->A2_NUMCON,7,1)=="-",If(Substr(SA2->A2_NUMCON,9,1)=" ",""+Right(Alltrim(SA2->A2_NUMCON),1),Substr(SA2->A2_NUMCON,8,2)),;
                  If(Substr(SA2->A2_NUMCON,8,1)=="-",If(Substr(SA2->A2_NUMCON,10,1)=" ",""+Right(Alltrim(SA2->A2_NUMCON),1),Substr(SA2->A2_NUMCON,9,2)),;
                  If(Substr(SA2->A2_NUMCON,9,1)=="-",If(Substr(SA2->A2_NUMCON,11,1)=" ",""+Right(Alltrim(SA2->A2_NUMCON),1),Substr(SA2->A2_NUMCON,10,2)),;
                  If(Substr(SA2->A2_NUMCON,10,1)=="-",If(Substr(SA2->A2_NUMCON,12,1)=" ",""+Right(Alltrim(SA2->A2_NUMCON),1),Substr(SA2->A2_NUMCON,11,2)),;
                  " "))))))
EndIf

Return(_AGENCIACTA) 

User Function PAGAGE3()      

SetPrvt("_AGENCIACTA")

/////  VERIFICACAO DA AGENCIA E CONTA A SEREM UTILIZADOS NO DEPOSITO BANCARIO

_AGENCIACTA  :=  ""

IF SA2->A2_BANCO== "341"
   _AGENCIACTA := Padl(Substr(Alltrim(SA2->A2_AGENCIA),1,4),5,"0")+" "+Padl(Substr(Alltrim(SA2->A2_NUMCON),1,AT("-",SA6->A6_NUMCON)-1),12,"0")+" "+Right(Alltrim(SA2->A2_NUMCON),1)
Endif
Return(_AGENCIACTA) 


*******************************************

User Function PAGAGE2()      

SetPrvt("_AGENCIACTA")

/////  VERIFICACAO DA AGENCIA E CONTA A SEREM UTILIZADOS NO DEPOSITO BANCARIO

_AGENCIACTA  :=  ""

IF SA2->A2_BANCO== "341"
   _AGENCIACTA := Padl(Substr(Alltrim(SA2->A2_AGENCIA),1,4),5,"0")+" "+Padl(Substr(Alltrim(SA2->A2_NUMCON),1,5),12,"0")+Right(Alltrim(SA2->A2_NUMCON),1)
Else
   _AGENCIACTA := Padl(Substr(Alltrim(SA2->A2_AGENCIA),1,5),5,"0")+" "+;
                  If(Substr(SA2->A2_NUMCON,5,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,4)),12,"0"),;
                  If(Substr(SA2->A2_NUMCON,6,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,5)),12,"0"),;
                  If(Substr(SA2->A2_NUMCON,7,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,6)),12,"0"),;
                  If(Substr(SA2->A2_NUMCON,8,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,7)),12,"0"),;
                  If(Substr(SA2->A2_NUMCON,9,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,8)),12,"0"),;
                  If(Substr(SA2->A2_NUMCON,10,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,9)),12,"0"),;
                  If(Substr(SA2->A2_NUMCON,11,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,10)),12,"0"),;                                    
                  Padl(Alltrim(SA2->A2_NUMCON),12,"0"))))))))+;
                  If(Substr(SA2->A2_NUMCON,5,1)=="-",If(Substr(SA2->A2_NUMCON,7,1)=" ",""+Right(Alltrim(SA2->A2_NUMCON),1),Substr(SA2->A2_NUMCON,6,2)),;   
                  If(Substr(SA2->A2_NUMCON,6,1)=="-",If(Substr(SA2->A2_NUMCON,8,1)=" ",""+Right(Alltrim(SA2->A2_NUMCON),1),Substr(SA2->A2_NUMCON,7,2)),;                  
                  If(Substr(SA2->A2_NUMCON,7,1)=="-",If(Substr(SA2->A2_NUMCON,9,1)=" ",""+Right(Alltrim(SA2->A2_NUMCON),1),Substr(SA2->A2_NUMCON,8,2)),;
                  If(Substr(SA2->A2_NUMCON,8,1)=="-",If(Substr(SA2->A2_NUMCON,10,1)=" ",""+Right(Alltrim(SA2->A2_NUMCON),1),Substr(SA2->A2_NUMCON,9,2)),;
                  If(Substr(SA2->A2_NUMCON,9,1)=="-",If(Substr(SA2->A2_NUMCON,11,1)=" ",""+Right(Alltrim(SA2->A2_NUMCON),1),Substr(SA2->A2_NUMCON,10,2)),;
                  If(Substr(SA2->A2_NUMCON,10,1)=="-",If(Substr(SA2->A2_NUMCON,12,1)=" ",""+Right(Alltrim(SA2->A2_NUMCON),1),Substr(SA2->A2_NUMCON,11,2)),;
                  " "))))))
EndIf

Return(_AGENCIACTA) 

*******************************************


User Function PAGCC()      

SetPrvt("_CTA")

/////  VERIFICACAO DA CONTA A SEREM UTILIZADOS NO DEPOSITO BANCARIO

_CTA  :=  ""


IF SEA->EA_MODELO$"03/41/01"
  _CTA:=          If(Substr(SA2->A2_NUMCON,5,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,4)+Substr(SA2->A2_NUMCON,6,3)),10,"0"),;
                  If(Substr(SA2->A2_NUMCON,6,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,5)+Substr(SA2->A2_NUMCON,7,3)),10,"0"),;
                  If(Substr(SA2->A2_NUMCON,7,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,6)+Substr(SA2->A2_NUMCON,8,3)),10,"0"),;
                  If(Substr(SA2->A2_NUMCON,8,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,7)+Substr(SA2->A2_NUMCON,9,2)),10,"0"),;
                  If(Substr(SA2->A2_NUMCON,9,1)=="-",Padl(Alltrim(Substr(SA2->A2_NUMCON,1,8)+Substr(SA2->A2_NUMCON,10,1)),10,"0"),;
                  Padl(Alltrim(SA2->A2_NUMCON),10,"0"))))))
Else
  _CTA := "0000000000"
  
EndIf

Return(_CTA)   
                   
*********************************
User Function PAGAG()      

SetPrvt("_AG")

/////  VERIFICACAO DA AGENCIA A SEREM UTILIZADOS NO DEPOSITO BANCARIO

_AG  :=  ""

IF SEA->EA_MODELO$"03/41/01"
  _AG:= Padl(ALLTRIM(SA2->A2_AGENCIA),7,"0")          
Else
  _AG:= "0000000" 
EndIf

return(_AG)

************************************
User Function CGC()      

SetPrvt("_CPFCGC")

/////  VERIFICACAO DO CPF/CGC DO FORNECEDOR

_CPFCGC:= ""

If ! Empty(SA2->A2_TWCGC) 
   	_nCPFCGC:=VAL(SA2->A2_TWCGC)
   	_CPFCGC:=STRZERO(_nCPFCGC,14)
Else
   IF LEN(ALLTRIM(SA2->A2_CGC))==14
      	_CPFCGC:= ALLTRIM(SA2->A2_CGC)
   ELSEIF LEN(ALLTRIM(SA2->A2_CGC))==11
    	_CPFCGC:= "000"+ALLTRIM(SA2->A2_CGC)
   ELSE
    	_CPFCGC:= "00000000000000"
   EndIf
Endif   

return(_CPFCGC)    


User Function FORNECE()      

SetPrvt("_FORNECE")

/////  VERIFICACAO O FORNECEDOR VÁLIDO

_FORNECE:= ""

If ! Empty(SA2->A2_TWCGC) 
	_FORNECE:=SUBSTR(SA2->A2_NOMDEPB,1,53)
Else
   _FORNECE:=SUBSTR(SA2->A2_NOME,1,53)
Endif

return(_FORNECE)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PAGAGEI   ºAutor  ³Renan Paiva         º Data ³  23/06/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Programa para retornar a agencia e conta do favorecido     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
USER FUNCTION PAGAGEI()
      
Local _cRet := ""                                                            
Local _cDAC	:= ""

IF SA2->A2_BANCO== "341"
   _cRet := Padl(Substr(Alltrim(SA2->A2_AGENCIA),1,4),5,"0")+" "+Padl(Substr(Alltrim(SA2->A2_NUMCON),1,5),12,"0")+" "+Right(Alltrim(SA2->A2_NUMCON),1)
Else        
  _cRet := iif(at('-',SA2->A2_AGENCIA) > 0,padl(left(SA2->A2_AGENCIA,at('-',SA2->A2_AGENCIA)-1),5,"0"),padl(alltrim(left(SA2->A2_AGENCIA,5)),5,"0"))
  _cRet += " "
  _cRet += iif(at('-',SA2->A2_NUMCON) > 0,padl(left(SA2->A2_NUMCON,at('-',SA2->A2_NUMCON)-1),12,"0"),padl(alltrim(left(SA2->A2_NUMCON,10)),12,"0"))
  _cDAC := iif(at('-',SA2->A2_NUMCON) > 0,alltrim(substr(SA2->A2_NUMCON,at('-',SA2->A2_NUMCON)+1))," ")
  _cRet += padl(_cDAC,2)
EndIf       
   
Return _cRet