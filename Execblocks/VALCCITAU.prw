/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VALCCITAU ºAutor  ³DANILO C S PALA     º Data ³  20111028   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ RETORNA O NUMERO DO BANCO, AGENCIA E CONTA CORRENTE PARA   º±±
±±º          ³O SISPAG                 									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PINI                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VALCCITAU()
Local cRetorno  := ""
   
/*                                                     
341 OU 409
Nome do Campo  Significado  Posição  Picture  Conteúdo 
ZEROS  COMPLEMENTO DE REGISTRO  024  024  9(01)   
AGÊNCIA  NÚMERO AGÊNCIA CREDITADA  025  028  9(04)   
BRANCOS  COMPLEMENTO DE REGISTRO  029  029  x(01)   
ZEROS  COMPLEMENTO DE REGISTRO  030  035  9(06)   
CONTA  NÚMERO DE C/C CREDITADA  036  041  9(06)   
BRANCOS  COMPLEMENTO DE REGISTRO  042  042  X(01)   
DAC  DAC  DA  AGÊNCIA/CONTA CREDITADA  043  043  9(01) 
          
OUTROS
Nome do Campo  Significado  Posição  Picture  Conteúdo 
Agência  número agência CREDITADA  024   028  9(05)   
brancos  complemento de registro  029   029  X(01)   
Conta  Número dE C/C CREDITADA   030   041  9(12)   
brancos  complemento de registro   042   042  X(01)   
DAC   daC DA AGÊNCIA/Conta CREDITADA  043   043  X(01) 
*/

IF SUBSTR(SA2->A2_BANCO,1,3) =="341" .OR. SUBSTR(SA2->A2_BANCO,1,3) =="409"
	cRetorno := cRetorno + "0"
	cRetorno := cRetorno + strzero(val(SA2->A2_AGENCIA),4)
	cRetorno := cRetorno + " "
	cRetorno := cRetorno + "000000"
	cRetorno := cRetorno + SUBSTR(strzero(val(SA2->A2_NUMCON),7),1,6)
	cRetorno := cRetorno + " "
	cRetorno := cRetorno + RIGHT(ALLTRIM(SA2->A2_NUMCON),1)
ELSE
	cRetorno := cRetorno + strzero(val(SA2->A2_AGENCIA),5)
	cRetorno := cRetorno + " "
	cRetorno := cRetorno + SUBSTR(strzero(val(SA2->A2_NUMCON),13),1,12)
	cRetorno := cRetorno + " "
	cRetorno := cRetorno + RIGHT(ALLTRIM(SA2->A2_NUMCON),1)
ENDIF

RETURN(cRetorno)