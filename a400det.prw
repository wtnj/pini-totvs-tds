#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/06/02

User Function a400det()        // incluido pelo assistente de conversao do AP5 IDE em 13/06/02
                                      '
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CCPO,MV_PAR11,_NDIAS,_CMULTA,_CPRAZO,_CDESC")
SetPrvt("_CMSG1,_CMSG2,_CMSG3,_CMSG4,_CCGC,_ENDCOB")
SetPrvt("_BAICOB,_CEPCOB,_MUNCOB,_ESTCOB,")

// A200DET() - PARTE INTEGRANTE DO RDMAKE PFAT200A.PRX
// AUTOR : GILBERTO A. DE OLIVEIRA JR.
// DATA  : 01/11/2000


_cCpo:=""
_cCpo:=_cCpo+'"0585-5",'
_cCpo:=_cCpo+'"ATE O VENCIMENTO PAGAVEL EM QUALQUER BANCO",'
_cCpo:=_cCpo+'"APOS O VENCIMENTO PAGAVEL APENAS NO BANCO ITAU",'
_cCpo:=_cCpo+'"'+Dtoc(SE1->E1_VENCTO)+'",'
_cCpo:=_cCpo+'"'+Padr(Alltrim(SM0->M0_NOMECOM),30)+'",'
_cCpo:=_cCpo+'"'+Left(_cCampo1,4)+'/'+Substr(_cCampo1,5,5)+'-'+Right(_cCampo1,1)+'"'
_cCpo:=_cCpo+Chr(13)+Chr(10)

FWrite(_cTrab,_cCpo,Len(_cCpo))

/*/
ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
º SEGUNDA LINHA - RECIBO DO SACADO                             º
ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
/*/

_cCpo:=""
_cCpo:=_cCpo+'"'+Dtoc(SE1->E1_EMISSAO)+'",'
_cCpo:=_cCpo+'"'+Padr(SE1->E1_PREFIXO+Alltrim(SE1->E1_NUM)+SE1->E1_PARCELA,10)+'",' //mp10
_cCpo:=_cCpo+'"DM",'
_cCpo:=_cCpo+'"N",'
_cCpo:=_cCpo+'" ",'
_cCpo:=_cCpo+'"'+Alltrim(_cCart)+'/'+_cFaxAtu+'-'+Right(_cCampo3,1)+'",'
_cCpo:=_cCpo+'" ",'
_cCpo:=_cCpo+'"R$  ",'
_cCpo:=_cCpo+'" "'
_cCpo:=_cCpo+Chr(13)+Chr(10)

FWrite(_cTrab,_cCpo,Len(_cCpo))

/*/
ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
º TERCEIRA LINHA - RECIBO DO SACADO                            º
ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
/*/

//MV_PAR11:= iif(Empty(mv_par11),10,mv_par11)
//_nDias:= iif(Empty(_nDias),10,_nDias)

_cMulta:= Alltrim(Str((SE1->E1_VALOR * _nJuros)/100,10,2))
_cPrazo:= DTOC( SE1->E1_VENCTO + _nDias )                    /// anteriormente era fixado em 10 dias...
_cDesc := Alltrim(Str(_nDescon,10,2))

_cMsg1:= iif(_nJuros > 0 , "COBRAR R$ "+_cMulta+" POR DIA DE ATRASO." , Space(2) )   // 17/06/02
_cMsg2:= "NAO RECEBER APOS O DIA "+_cPrazo                                             // 17/06/02 
_cMsg3:= "                                            "                                // 18/06/02
//_cMsg3:= iif(_nDescon > 0 , "CONCEDER DESCONTO DE R$ "+_cDesc, Space(2) )            //  18/06/02

// _cMsg1:= "AUTORIZADO O RECEBIMENTO SEM JUROS/MULTA ATE 06/05/02."       17/06/02
// _cMsg2:= "NAO RECEBER APOS O DIA 06/05/02."                             17/06/02
// _cMsg3:= "MAIORES INFORMACOES 3224-8811 R. 213/214/244"                 17/06/02

_cCpo:=""
_cCpo:=_cCpo+'"'+Transform((SE1->E1_VALOR-SE1->E1_IRRF), "@EZ 99,999,999,999.99")+'",'
_cCpo:=_cCpo+'"'+_cMsg1+'","'+_cMsg2+'","'+_cMsg3+'"'       
_cCpo:=_cCpo+Chr(13)+Chr(10)

FWrite(_cTrab,_cCpo,Len(_cCpo))

/*/
ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
º QUARTA E QUINTA LINHAS - RECIBO DO SACADO                    º
ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
/*/

//_cMsg4:= "PROTESTAR APOS 05 DIAS DO VENCIMENTO."
_cMsg4:= "  "
_cCpo:=""
//20040506
if SM0->M0_CODIGO = "01" 
	_cCpo:=_cCpo+'"                                               ","                                               ","                                               "'
elseif SM0->M0_CODIGO = "03"	 
//	_cCpo:=_cCpo+'"PROTESTAR APOS 05 DIAS DO VENCIMENTO.          ","                                               ","                                               "' //20051129
	_cCpo:=_cCpo+'"                                               ","                                               ","                                               "' //20051129
endif
_cCpo:=_cCpo+'"                                               ","                                               ","                                               "'
_cCpo:=_cCpo+Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

_cCpo:=""
_cCpo := _cCpo+'"NAO ACEITAMOS PAGAMENTOS VIA DOC, TRANSFERENCIA OU DEPOSITO SIMPLES","POIS NOSSO SISTEMA NAO IDENTIFICA ESTAS FORMAS DE PAGTO","                                               "' ///20060510
_cCpo:=_cCpo+Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pesquisa o Cadastro de Clientes p/ obter os Dados do Sacado. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea("SA1")
DbSeek( xFilial("SA1")+SE1->E1_CLIENTE + SE1->E1_LOJA )

_cCGC:= Space(LEN(SA1->A1_CGC))
If Empty(SA1->A1_CGC)
  _cCGC:= SA1->A1_CGCVAL
Else
   If Trim(Upper(SA1->A1_TPCLI)) == "J"
     _cCGC:= Transform(SA1->A1_CGC,"@R 99.999.999/9999-99")
   ElseIf Trim(Upper(SA1->A1_TPCLI))=="F"
     _cCGC:= Transform(SA1->A1_CGC,"@R 999.999.999-99")
   EndIf
EndIf

/*/
ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
º SEXTA LINHA - RECIBO DO SACADO                               º
ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
/*/

_EndCob:= Padr(U_VCB01(),40, " ")
_BaiCob:= Padr(U_VCB02(),12, " ")
_CEPCob:= U_VCB03()
_MunCob:= U_VCB04()
_EstCob:= U_VCB05()

// _cCGC:= Iif(Empty(SA1->A1_CGC),SA1->A1_CGCVAL,SA1->A1_CGC)

_cCpo:=""
_cCpo:=_cCpo+'"'+LEFT(SA1->A1_NOME,30)+'",'
_cCpo:=_cCpo+'"'+_cCGC+'",'
_cCpo:=_cCpo+'"'+_EndCob+'",'
_cCpo:=_cCpo+'"'+Left(_CEPCob,5)+'",'
_cCpo:=_cCpo+'"'+SubStr(_CEPCob,6,3)+'",'
_cCpo:=_cCpo+'"'+SubStr(_BaiCob,1,12)+'",'
_cCpo:=_cCpo+'"'+Left(_MunCob,15)+'",'
_cCpo:=_cCpo+'"'+_EstCob+'","                              "," "," "'
_cCpo:=_cCpo+Chr(13)+Chr(10)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava dados do Sacado                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

FWrite(_cTrab,_cCpo,Len(_cCpo))

// Substituido pelo assistente de conversao do AP5 IDE em 13/06/02 ==> __Return( .T. )
Return( .T. )        // incluido pelo assistente de conversao do AP5 IDE em 13/06/02


