#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SISDEB	ºAutor  ³Danilo C S Pala     º Data ³  20041215   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ CNAB SISDEB: seleciona o pedido e retorna o valor corresponº±±
±±º          ³  dente a passada por parametro							  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function SISDEB(PEDIDO, COLUNA)
//User Function SISDEB()
/*
SetPrvt("_APARAMETROS")
_APARAMETROS := PARAMIXB
Private  valor
*/
DBSELECTAREA("SC5")
DBSETORDER(1)

IF pedido = "EMPRESA"
	IF SM0->M0_CODIGO = "01" //ed
		valor := "1342505000674"
	ELSEIF SM0->M0_CODIGO = "02" //ps
		valor := "1343308300063"
	ELSE //bp
		Valor := ""           
	ENDIF
	
ELSE
	IF DBSEEK(XFILIAL("SC5")+SE1->E1_PEDIDO)
		IF COLUNA = "BANCO"
			Valor := SC5->c5_debbanc
		ELSEIF COLUNA = "AGENCIA"
			Valor := SC5->c5_debagen
		ELSEIF COLUNA = "CONTA"
			Valor := SC5->c5_debcont
		ELSEIF COLUNA = "DAC"
			Valor := SC5->c5_debdac
		ENDIF
	ELSE
		VALOR := ""
	ENDIF
ENDIF

return (VALOR)
