#INCLUDE "RWMAKE.CH"
/*/
旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴왯컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
�                                       납 DOMINIO   -> C6_PRODUTO          �
� GATILHO : GATTES1.PRX                 납 C.DOMINIO -> C6_TES              �
� OBJETIVO: AUXILIAR DIGITACAO DA TES   납 SEQUENCIA -> 18                  �
�                                       납 REGRA     -> EXECBLOCK("GATTES1")�
�                                       납 TIPO      -> P                   �
� AUTOR : GILBERTO AMANCIO DE OLIVEIRA  납 SEEK      -> N                   �
� DATA  : 18/08/00                      납 ALIAS     ->                     �
�                                       납 ORDEM     ->                     �
� USO   : ESPECIFICO PINI SISTEMAS.     납 PROPRI    -> U                   �
�         EMPRESA 02.                   납 CONDICAO  ->                     �
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴牡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
/*/
User Function Gattes1()

Local aArea

/*
旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
� Definicao da TES                                                          �
�                                                                           �
� 703  -  Para Pini Sistemas vender produtos da Editora Pini.               �
�         Produtos do Grupo 0100, 0200 e 0700.                              �
� 702  -  Para "dobrar" base de ICM. Suporte Informatico da P.S. (CD,Disk)  �
�         Produto onde os digitos 3 e 4 formam "95".                        �
�         Deve estar corretamente cadastrado no SB1 (B1_TS).                �
� 701  -  Para venda de servico/software, reduz base de ISS em 85%.         �
�         Produtos onde o tipo e SW.                                        �
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*/

aArea := GetArea()

_cTes:= SB1->B1_TS

IF SM0->M0_CODIGO == "02"

   _cGrupo_TES_703:= "0100/0200/0700"
   //_cGrupo_TES_702:= "1195/1495/1595/1795"
   _cTipo_TES_701 := "SW"

   Do Case
      Case ( Alltrim(SB1->B1_GRUPO) $ _cGrupo_TES_703 )
           _cTes:= "703"
      Case ( Alltrim(SB1->B1_TIPO)  $ _cTipo_TES_701 ) .And. SUBS(SB1->B1_COD,3,2)<>"95"
           _cTes:= "701"
   EndCase

   If Empty(_cTES)
      _cTes:= "700"
   EndIF

   DbSelectArea("SF4")
   DbSetOrder(1)
   DbSeek( xFilial("SF4")+_cTes )

   _cCF:= Alltrim(SF4->F4_CF)

   DbSelectArea("SA1")
   DbSetOrder(1)
   DbSeek(xFilial("SA1")+M->C5_CLIENTE+M->C5_LOJACLI)

   If SA1->A1_EST <> "SP" .And.  SUBS(_cCF,1,3) == "599"
      _cCF:= "699"+SUBS(_cCF,4,1)
   ElseIf SA1->A1_EST <> "SP" .And. _cCF == "512"
      _cCF:= "612"
   ElseIf SA1->A1_EST <> "SP" .And. _cCF == "511"
      _cCF:= "611"
   EndIf
   
   IF SA1->A1_EST == 'EX'
      _cCF:='7'+SUBS(_cCF,2,3)
   ENDIF

   aCols[n,aScan(aHeader ,{|x| Upper(AllTrim(x[2]))=="C6_CF" })]:= _cCF    ///SF4->F4_CF

ENDIF

// FINALIZA ...

RestArea(aArea)

Return(_cTES)