#include "rwmake.ch"
User Function Se5fi070()

Private aArea := GetArea()
Private _cMsg := ""

** GILBERTO - 09.01.2001 - PONTO DE ENTRADA PARA TENTAR DESCOBRIR
**                         PORQUE ALGUMAS BAIXAS ESTAO PRODUZINDO DIFERENCA
**                         ENTRE SE1 E SE5.

_cChaveSE5 := SE5->E5_PREFIXO + SE5->E5_NUMERO + SE5->E5_PARCELA + SE5->E5_CLIFOR
_cChaveSE1 := SE1->E1_PREFIXO + SE1->E1_NUM    + SE1->E1_PARCELA + SE1->E1_CLIENTE

If _cChaveSE5 <> _cChaveSE1
   _cMsg:= "Atencao : DADOS DA BAIXA NAO CORRESPONDEM AO TITULO NO FINANCEIRO !!"
   _cMsg:= _cMsg + " Favor entrar em contato com o Departamento de Informatica..."

   MsgAlert( OemToAnsi(_cMsg) )
EndIf

Return(.t.)