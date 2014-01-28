#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
// A200DET() - PARTE INTEGRANTE DO RDMAKE PFAT200A.PRX
// AUTOR : GILBERTO A. DE OLIVEIRA JR.
// DATA  : 01/11/2000
User Function A230det()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

SetPrvt("_CCPO,MV_PAR11,_NDIAS,_CMULTA,_CPRAZO,_CDESC")
SetPrvt("_CMSG1,_CMSG2,_CMSG3,_CNOMECLI,_CCGC,_ENDCOB")
SetPrvt("_BAICOB,_CEPCOB,_MUNCOB,_ESTCOB,")

_cCpo := ""
_cCpo := _cCpo+'"0585-5",'
_cCpo := _cCpo+'"ATE O VENCIMENTO PAGAVEL EM QUALQUER BANCO",'
_cCpo := _cCpo+'"APOS O VENCIMENTO PAGAVEL APENAS NO BANCO ITAU",'
_cCpo := _cCpo+'"'+Dtoc(ZZE->ZZE_VENCTO)+'",'
_cCpo := _cCpo+'"'+Padr(Alltrim(SM0->M0_NOMECOM),30)+'",'
_cCpo := _cCpo+'"'+Left(_cCampo1,4)+'/'+Substr(_cCampo1,5,5)+'-'+Right(_cCampo1,1)+'"'
_cCpo := _cCpo+Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

/*/
ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ SEGUNDA LINHA - RECIBO DO SACADO                             บ
ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
/*/
_cCpo :=""
_cCpo := _cCpo+'"'+Dtoc(ZZE->ZZE_EMISSA)+'",'
_cCpo := _cCpo+'"'+Padr(ZZE->ZZE_PREFIX+ZZE->ZZE_NUM+ZZE->ZZE_PARCEL,10)+'",'
_cCpo := _cCpo+'"DM",'
_cCpo := _cCpo+'"N",'
_cCpo := _cCpo+'" ",'
_cCpo := _cCpo+'"'+Alltrim(_cCart)+'/'+_cFaxAtu+'-'+Right(_cCampo3,1)+'",'
_cCpo := _cCpo+'" ",'
_cCpo := _cCpo+'"R$  ",'
_cCpo := _cCpo+'" "'
_cCpo := _cCpo+Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

/*/
ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ TERCEIRA LINHA - RECIBO DO SACADO                            บ
ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
/*/
//MV_PAR11:= iif(Empty(mv_par11),10,mv_par11)
//_nDias:= iif(Empty(_nDias),10,_nDias)

_cMulta := Alltrim(Str((ZZE->ZZE_VALOR * _nJuros)/100,10,2))
_cPrazo := DTOC( ZZE->ZZE_VENCTO + _nDias )                    /// anteriormente era fixado em 10 dias...
_cDesc  := Alltrim(Str(_nDescon,10,2))
_cMsg1  := iif(_nJuros > 0 , "COBRAR R$ "+_cMulta+" POR DIA DE ATRASO." , Space(2) )
_cMsg2  := "NAO RECEBER APOS O DIA "+_cPrazo
_cMsg3  := iif(_nDescon > 0 , "CONCEDER DESCONTO DE R$ "+_cDesc, Space(2) )
_cCpo   := ""
_cCpo   := _cCpo+'"'+Transform((ZZE->ZZE_VALOR), "@EZ 99,999,999,999.99")+'",'
_cCpo   := _cCpo+'"'+_cMsg1+'","'+_cMsg2+'","'+_cMsg3+'"'
_cCpo   := _cCpo+Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

/*/
ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ QUARTA E QUINTA LINHAS - RECIBO DO SACADO                    บ
ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
/*/
_cCpo := ""
_cCpo := _cCpo+'"                                               ","                                               ","                                               "'
_cCpo := _cCpo+Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

_cCpo := ""
_cCpo := _cCpo+'"                                               ","                                               ","                                               "'
_cCpo := _cCpo+Chr(13)+Chr(10)
FWrite(_cTrab,_cCpo,Len(_cCpo))

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Pesquisa o Cadastro de Clientes p/ obter os Dados do Sacado. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DbSelectArea("SA1")
DbSeek( xFilial("SA1")+ZZE->ZZE_CLIENT + ZZE->ZZE_LOJA )
_cNomecli  := SA1->A1_NOME
_cCGC      := Space(LEN(SA1->A1_CGC))
If Empty(SA1->A1_CGC)
	_cCGC    := SA1->A1_CGCVAL
Else
	If Trim(Upper(SA1->A1_TPCLI)) == "J"
		_cCGC := Transform(SA1->A1_CGC,"@R 99.999.999/9999-99")
	ElseIf Trim(Upper(SA1->A1_TPCLI))=="F"
		_cCGC := Transform(SA1->A1_CGC,"@R 999.999.999-99")
	EndIf
EndIf

/*/
ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ SEXTA LINHA - RECIBO DO SACADO                               บ
ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
/*/
_EndCob := Padr(U_VCB01(),40) // Padr( ExecBlock("VCB01",.t.,.t.), 40, " ")
_BaiCob := Padr(U_VCB02(),12) // Padr( ExecBlock("VCB02",.t.,.t.), 12," ")
_CEPCob := U_VCB03() // ExecBlock("VCB03",.t.,.t.)
_MunCob := U_VCB04() // ExecBlock("VCB04",.t.,.t.)
_EstCob := U_VCB05() // ExecBlock("VCB05",.t.,.t.)

// _cCGC:= Iif(Empty(SA1->A1_CGC),SA1->A1_CGCVAL,SA1->A1_CGC)

_cCpo := ""
//*_cCpo:=_cCpo+'"'+LEFT(SA1->A1_NOME,30)+'",'
_cCpo += '"'+LEFT(_cNomecli,30)+'",'
_cCpo += '"'+_cCGC+'",'
_cCpo += '"'+_EndCob+'",'
_cCpo += '"'+Left(_CEPCob,5)+'",'
_cCpo += '"'+SubStr(_CEPCob,6,3)+'",'
_cCpo += '"'+SubStr(_BaiCob,1,12)+'",'
_cCpo += '"'+Left(_MunCob,15)+'",'
_cCpo += '"'+_EstCob+'","                              "," "," "'
_cCpo += Chr(13)+Chr(10)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Grava dados do Sacado                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
FWrite(_cTrab,_cCpo,Len(_cCpo))

Return( .T. )