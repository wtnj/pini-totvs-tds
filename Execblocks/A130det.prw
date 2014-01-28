#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
User Function A130det()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

SetPrvt("_CCPO,MV_PAR11,_NDIAS,_CMULTA,_CMULTA1,_CPRAZO,_CDESC")
SetPrvt("_CMSG1,_CMSG2,_CMSG3,_CCGC,_ENDCOB,_BAICOB")
SetPrvt("_CEPCOB,_MUNCOB,_ESTCOB,")

// A130DET() - PARTE INTEGRANTE DO RDMAKE PFAT130A.PRX
// AUTOR : GILBERTO A. DE OLIVEIRA JR.
// DATA  : 12/04/2001
// PROGRAMA PARA A PUBLICIDADE.

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
浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
� SEGUNDA LINHA - RECIBO DO SACADO                             �
藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕
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
浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
� TERCEIRA LINHA - RECIBO DO SACADO                            �
藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕
/*/
//MV_PAR11:= iif(Empty(mv_par11),10,mv_par11)
//_nDias:= iif(Empty(_nDias),10,_nDias)

_cMulta  := Alltrim(Str((SE1->E1_VALOR * _nJuros)/100,10,2))
_cMulta1 := Alltrim(Str((SE1->E1_VALOR * _nMulta1)/100,10,2))
_cPrazo  := DTOC( SE1->E1_VENCTO + _nDias )                    /// anteriormente era fixado em 10 dias...
_cDesc   := Alltrim(Str(_nDescon,10,2))

/*_cMsg1:= iif(_nMulta1 > 0 , "APOS O VENCIMENTO COBRAR R$ "+_cMulta1+" DE MULTA." , Space(2) )
_cMsg2:= iif(_nJuros  > 0 , "MAIS R$ "+_cMulta+" POR DIA DE ATRASO." , Space(2) )
_cMsg3:= "NAO RECEBER APOS O DIA "+_cPrazo
_cMsg3+= iif(_nDescon > 0 , "     CONCEDER DESCONTO DE R$ "+_cDesc, "" )
*/

_cMsg1:= iif(_nMulta1 > 0 , "APOS O VENCIMENTO COBRAR R$ "+_cMulta1+" DE MULTA." , Space(2) )
_cMsg2:= iif(_nJuros  > 0 , "MAIS R$ "+_cMulta+" POR DIA DE ATRASO.", "" )
_cMsg2+= iif(_nDescon > 0 , "     CONCEDER DESCONTO DE R$ "+_cDesc, "" )
_cMsg3:= "NAO RECEBER APOS O DIA "+_cPrazo
_cMsg3+= "     PROTESTAR APOS 05 DIAS DO VENCTO."

_cCpo:=""
_cCpo:=_cCpo+'"'+Transform((SE1->E1_VALOR-SE1->E1_IRRF), "@EZ 99,999,999,999.99")+'",'
_cCpo:=_cCpo+'"'+_cMsg1+'","'+_cMsg2+'","'+_cMsg3+'"'
_cCpo:=_cCpo+Chr(13)+Chr(10)

FWrite(_cTrab,_cCpo,Len(_cCpo))

/*/
浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
� QUARTA E QUINTA LINHAS - RECIBO DO SACADO                    �
藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕
/*/
_cCpo:=""
_cCpo:=_cCpo+'"                                               ","                                               ","                                               "'
_cCpo:=_cCpo+Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

_cCpo:=""
_cCpo := _cCpo+'"NAO ACEITAMOS PAGAMENTOS VIA DOC, TRANSFERENCIA OU DEPOSITO SIMPLES","POIS NOSSO SISTEMA NAO IDENTIFICA ESTAS FORMAS DE PAGTO","                                               "' ///20060510
_cCpo:=_cCpo+Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

//敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
//� Pesquisa o Cadastro de Clientes p/ obter os Dados do Sacado. �
//青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰
DbSelectArea("SA1")    
DbSetOrder(1)
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
浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
� SEXTA LINHA - RECIBO DO SACADO                               �
藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕
/*/
_EndCob:= Padr( ExecBlock("VCB01"), 40, " ")
_BaiCob:= Padr( ExecBlock("VCB02"), 12," ")
_CEPCob:= ExecBlock("VCB03")
_MunCob:= ExecBlock("VCB04")
_EstCob:= ExecBlock("VCB05")

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

//敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
//� Grava dados do Sacado                                        �
//青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰

FWrite(_cTrab,_cCpo,Len(_cCpo))

Return( .T. )