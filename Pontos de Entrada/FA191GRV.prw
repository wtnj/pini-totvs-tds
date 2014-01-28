#include "rwmake.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA191GRV  ºAutor  ³Danilo C S Pala     º Data ³  20120925   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Grava dados de cheques recebidos                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

//O ponto de entrada FA191GRV é chamado após a gravação (inclusão, alteração e exclusão) de Cheques Recebidos. Programa Fonte FINA191.PRW
User Function FA191GRV()          
local _lOk := .T. 
local aCab := {} 
local aItens := {}                       
local nValor := SEF->EF_VALOR             
private lMsErroAuto := .F. 

If INCLUI                 

	aCab   := {     {"DDATALANC"     ,dDataBase     ,NIL}     ,; 
              {"CLOTE"      ,"008850"     ,NIL}     ,; 
              {"CSUBLOTE"      ,"001"           ,NIL}     ,; 
              {"CDOC"      , strzero(seconds(),6)     ,NIL}     ,; 
    	      {"CPADRAO"     ,""               ,NIL}     ,; 
              {"NTOTINF"     ,0               ,NIL}     ,; 
              {"NTOTINFLOT"     ,0               ,NIL}} 

	aAdd(aItens,{     {"CT2_FILIAL"      ,"01"               , NIL},; 
                {"CT2_LINHA"      ,"001"             , NIL},; 
                {"CT2_MOEDLC"      ,"01"             , NIL},; 
                {"CT2_DC"        ,"3"                  , NIL},; 
                {"CT2_DEBITO"      ,"11020101012"     , NIL},; 
                {"CT2_CREDIT"      ,"21080202002"     , NIL},; 
                {"CT2_VALOR"      ,nValor           , NIL},; 
                {"CT2_ORIGEM"      ,SUBS(CUSUARIO,7,15)+"-FA191GRV" , NIL},; 
                {"CT2_HIST"        ,"RECEB CH "+ALLTRIM(SEF->EF_NUM) + "-TIT "+ALLTRIM(SEF->EF_TITULO), NIL}}) 

	MSExecAuto( {|X,Y,Z| CTBA102(X,Y,Z)} ,aCab ,aItens, 3) 
	If lMsErroAuto
		MOSTRAERRO()
	EndIf
EndIf

Return NIL