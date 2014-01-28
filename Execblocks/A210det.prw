#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ A210DET  ³ Autor ³ Gilberto A Oliveira Jr³ Data ³ 23/11/00    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Criacao do Texto para impressao do Boleto Bancario do         ³±±
±±³          ³ Unibanco.                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ROTINAS AUXILIARES E RELACIONADAS.                                       ³±±
±±³ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                       ³±±
±±³ PFAT210.PRX     - Principal: Chama perguntas e aciona PFAT210A.          ³±±
±±³  PFAT210A.PRX   - Aciona A210DET, grava arquivo txt e chama Bloqueto.Exe.³±±
±±³*  A210DET.PRX   - Dados do Lay-Out para criacao do arquivo.txt           ³±±
±±³    NOSSONUM.PRX - Calcula Digito do Nosso Num. e incremente EE_FAXATU.   ³±±
±±³    CALMOD10.PRX - Calcula digitos de controle com base no Modulo 1021    ³±±
±±³    CALMOD11.PRX - Calcula digitos do Codigo de Barras com base no Mod.11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Observacao³ Caso queira compilar varios desses Rdmakes utilize a Bat      ³±±
±±³          ³ BOL409.                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function A210det()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

SetPrvt("_CCGC,_CAGCONTA,_CSACADO,_CVALOR,_CVENCTO,_CEMISSAO")
SetPrvt("MV_PAR11,_CMULTA,_CMULTA1,_CPRAZO,_CDESC,_CMSG1,_CMSG2")
SetPrvt("_CMSG3,_CMSG4,_ENDCOB,_BAICOB,_CEPCOB,_MUNCOB")
SetPrvt("_ESTCOB,_CNOSSONUMERO,_CFORMATVALOR,_CCODIGODEBARRAS,_CDIGITOCODBARRAS,_CPRIPARTEIPTE")
SetPrvt("_CSEGPARTEIPTE,_CTERPARTEIPTE,_CQUAPARTEIPTE,_CQUIPARTEIPTE,_CIPTE,_ATEXTO")

_cCGC:= SPACE(LEN(SA1->A1_CGC))
SA1->( DbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA) )
IF EMPTY(SA1->A1_CGC)
  _cCGC:= SA1->A1_CGCVAL
ELSE
   IF TRIM(UPPER(SA1->A1_TPCLI)) == "J"
     _cCGC:= Transform(SA1->A1_CGC,"@R 99.999.999/9999-99")
   ELSEIF TRIM(UPPER(SA1->A1_TPCLI))=="F"
     _cCGC:= Transform(SA1->A1_CGC,"@R 999.999.999-99")
   ENDIF
ENDIF

_cAgConta:= Left(SEE->EE_AGENCIA,4)+"/"+Left(SEE->EE_CONTA,3)+"."+Subs(SEE->EE_CONTA,4,3)+"-"+Right(Alltrim(SEE->EE_CONTA),1)
_cSacado := Left(SA1->A1_NOME,30)+" "+_cCGC
_cValor  := Transform((SE1->E1_VALOR - (SE1->E1_COFINS + SE1->E1_CSLL + SE1->E1_PIS + SE1->E1_IRRF)), "@E 99,999,999,999.99") //20040217
_cVencto := Left(DtoC(SE1->E1_VENCTO),6)+STR(YEAR(SE1->E1_VENCTO),4)
_cEmissao:= Left(DtoC(SE1->E1_EMISSAO),6)+STR(YEAR(SE1->E1_EMISSAO),4)

//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//º MENSAGENS                                                                 º
//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
Mv_Par11 := iif(Empty(mv_par11),10,mv_par11)
_cMulta  := Alltrim(Str(((SE1->E1_VALOR - (SE1->E1_COFINS + SE1->E1_CSLL + SE1->E1_PIS + SE1->E1_IRRF)) * MV_PAR08)/100,10,2)) //20040217
_cMulta1 := Alltrim(Str(((SE1->E1_VALOR - (SE1->E1_COFINS + SE1->E1_CSLL + SE1->E1_PIS + SE1->E1_IRRF)) * MV_PAR14)/100,10,2))  //20040217
_cPrazo  := DTOC( SE1->E1_VENCTO + mv_par11 )  /// anteriormente era fixado em 10 dias...
_cDesc   := Alltrim(Str(MV_PAR09,10,2))

//_cMsg1  := iif(mv_par08 > 0 , "COBRAR R$ "+_cMulta+" POR DIA DE ATRASO." , Space(2) )
//_cMsg2  := "NAO RECEBER APOS O DIA "+_cPrazo
//_cMsg3  := iif(mv_par09 > 0 , "CONCEDER DESCONTO DE R$ "+_cDesc, Space(2) )
//_cMsg4  := ""

	_cMsg1  := iif(mv_par14 > 0 , "APOS O VENCIMENTO COBRAR R$ "+_cMulta1+" DE MULTA." , Space(2) )
	_cMsg2  := iif(mv_par08 > 0 , "MAIS R$ "+_cMulta+" POR DIA DE ATRASO." , Space(2) )
	_cMsg3  := "NAO RECEBER APOS O DIA "+_cPrazo
	_cMsg3  += iif(mv_par09 > 0 , "     CONCEDER DESCONTO DE R$ "+_cDesc, "" )

If _Codemp = "02"
	_cMsg4  := "NAO ACEITAMOS PAGAMENTOS VIA DOC, TRANSFERENCIA OU DEPOSITO SIMPLES"
Elseif _Codemp = "03"
	_cMsg4  := "PROTESTAR APOS 05 DIAS DO VENCIMENTO. NAO ACEITAMOS PAGAMENTOS VIA DOC, TRANSFERENCIA OU DEPOSITO SIMPLES"
Endif

//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//º ENDERECO DO SACADO                                                        º
//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
_EndCob:= Padr( ExecBlock("VCB01"), 40, " ")
_BaiCob:= Padr( ExecBlock("VCB02"), 12," ")
_CEPCob:= ExecBlock("VCB03")
_MunCob:= ExecBlock("VCB04")
_EstCob:= ExecBlock("VCB05")

//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//º CODIGO DE BARRAS E IPTE                                                    º
//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
//_cNossoNumero     := ExecBlock("NossoNum",.F.,.F.)            // CALCULA E GRAVA AQUI O E1_NUMBCO.
_cNossoNumero     := ExecBlock("CNNA210",.F.,.F.)             // CALCULA E GRAVA AQUI O E1_NUMBCO.
_cFormatValor     := Left(StrZero((SE1->E1_VALOR - (SE1->E1_COFINS + SE1->E1_CSLL + SE1->E1_PIS + SE1->E1_IRRF)),15,2),12) //20040217
_cFormatValor     := _cFormatValor+Right(StrZero((SE1->E1_VALOR - (SE1->E1_COFINS + SE1->E1_CSLL + SE1->E1_PIS + SE1->E1_IRRF)),15,2),2) //20040217

_cCodigodeBarras  := "4099"
_cCodigodeBarras  := _cCodigodeBarras + _cFormatValor
_cCodigodeBarras  := _cCodigodeBarras + "5"
_cCodigodeBarras  := _cCodigodeBarras + RTRIM(SEE->EE_CODEMP)
_cCodigodeBarras  := _cCodigodeBarras + "00"
_cCodigodeBarras  := _cCodigodeBarras + _cNossoNumero
_cDigitoCodBarras := ExecBlock("CalMod11",.F.,.F.,_cCodigodeBarras)
_cCodigodeBarras  := Left(_cCodigodeBarras,4)+_cDigitoCodBarras+SubS(_cCodigodeBarras,5)

_cPriParteIPTE := "409"                                                      // Banco (1 a 3)
_cPriParteIPTE := _cPriParteIPTE+"9"                                         // Moeda (4 a 4), 9 = Reais
_cPriParteIPTE := _cPriParteIPTE+"5"                                         // Digito do CVT (5 a 5), 7744-"5"
_cPriParteIPTE := _cPriParteIPTE+Left(Alltrim(SEE->EE_CODEMP),4)              // Numero do Cliente no C¢d. de Barras
_cPriParteIPTE := ExecBlock("CalMod10",.F.,.F.,_cPriParteIPTE)               // Digito Verificador (M¢dulo 10)
_cSegParteIPTE := Right(RTrim(SEE->EE_CODEMP),3)                               // Continuacao do Nr. do Cliente...
_cSegParteIPTE := _cSegParteIPTE+"00"                                          // Campo vago.
_cSegParteIPTE := _cSegParteIPTE+Left(_cNossoNumero,5)                         // Primeira parte do Nosso Numero.
_cSegParteIPTE := ExecBlock("CalMod10",.F.,.F.,_cSegParteIPTE )                // Digito Verificador (M¢dulo 10)

_cTerParteIPTE := SubS(_cNossoNumero,6)                                        // Restante do Nosso Numero.
_cTerParteIPTE := ExecBlock("CalMod10",.F.,.F.,_cTerParteIPTE )                // Digito Verificador (M¢dulo 10)

_cQuaParteIPTE := _cDigitoCodBarras
_cQuiParteIPTE := Alltrim(Left(Str((SE1->E1_VALOR - (SE1->E1_COFINS + SE1->E1_CSLL + SE1->E1_PIS + SE1->E1_IRRF)),15,2),12)+Right(Alltrim(Str((SE1->E1_VALOR - (SE1->E1_COFINS + SE1->E1_CSLL + SE1->E1_PIS + SE1->E1_IRRF)),15,2)),2)) //20040217

_cIPTE := Left(_cPriParteIPTE,5)+"."+RTrim(SubS(_cPriParteIPTE,6))
_cIPTE := _cIPTE+" "+Left(_cSegParteIPTE,5)+"."+RTrim(SubS(_cSegParteIPTE,6))
_cIPTE := _cIPTE+" "+Left(_cTerParteIPTE,5)+"."+RTrim(SubS(_cTerParteIPTE,6))
_cIPTE := _cIPTE+"  "+_cQuaParteIPTE
_cIPTE := _cIPTE+" "+_cQuiParteIPTE

_aTexto:= {}
Aadd(_aTexto,"[BLOQUETO]")
Aadd(_aTexto,"CEDE"+CHR(61)+Alltrim(SM0->M0_NOMECOM))
Aadd(_aTexto,"AGCO"+CHR(61)+Alltrim(_cAgConta))
Aadd(_aTexto,"SACA"+CHR(61)+Alltrim(_cSacado))
Aadd(_aTexto,"NONU"+CHR(61)+_cNossoNumero)
Aadd(_aTexto,"VENC"+CHR(61)+_cVencto)
Aadd(_aTexto,"NUDO"+CHR(61)+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)
Aadd(_aTexto,"MOED"+CHR(61)+"R$")
Aadd(_aTexto,"QADO"+CHR(61)+"")       // QUANTIDADE
Aadd(_aTexto,"VADO"+CHR(61)+_cValor)
Aadd(_aTexto,"DADO"+CHR(61)+_cEmissao)
Aadd(_aTexto,"ESDO"+CHR(61)+"DM")
Aadd(_aTexto,"DAPR"+CHR(61)+_cEmissao)
Aadd(_aTexto,"CVT"+CHR(61)+"7744.5")
Aadd(_aTexto,"CART"+CHR(61)+"20")
Aadd(_aTexto,"SAAV"+CHR(61)+"")      // SACADOR AVALISTA
Aadd(_aTexto,"LOPA01"+CHR(61)+"ATE  O VENCIMENTO,  PAGAVEL  EM  QUALQUER  BANCO.  APOS  VENCIMENTO,  EM")
Aadd(_aTexto,"LOPA02"+CHR(61)+"QUALQUER AGENCIA UNIBANCO SEGUINDO AS DISPOSICOES DO CAMPO  'INSTRUCOES'")
Aadd(_aTexto,"INST01"+CHR(61)+_cMsg1)
Aadd(_aTexto,"INST02"+CHR(61)+_cMsg2)
Aadd(_aTexto,"INST03"+CHR(61)+_cMsg3)
Aadd(_aTexto,"INST04"+CHR(61)+_cMsg4)
Aadd(_aTexto,"END01"+CHR(61)+_EndCob)
Aadd(_aTexto,"END02"+CHR(61)+_CEPCob+"  "+_BaiCob+"  "+_MunCob+"  "+_EstCob)
Aadd(_aTexto,"IPTE"+CHR(61)+_cIPTE)
Aadd(_aTexto,"COBA"+CHR(61)+_cCodigodeBarras)
Aadd(_aTexto,"MODI"+CHR(61)+"")  // CAMPO EM INSTRUCOES ACIMA DA MENSAGEM
Aadd(_aTexto,"MUDI"+CHR(61)+"")  // CAMPO EM INSTRUCOES ACIMA DA MENSAGEM
Aadd(_aTexto,"DESC"+CHR(61)+"")  // CAMPO EM INSTRUCOES ACIMA DA MENSAGEM
Aadd(_aTexto,"COMP"+CHR(61)+"3")
Aadd(_aTexto,"MDAG"+CHR(61)+"1")
Aadd(_aTexto,"BMP"+CHR(61)+"")
Aadd(_aTexto,"SBMP"+CHR(61)+"")

Return(.T.)
/*/  FIM /*/

/*/
4099507289438000000020231012365455000
409950728943800000002023101235711165400
40995072894380000000200000000356412000
409             - Codigo do Banco                   (01 a 03)
9               - Moeda (9=Reais)                   (04 a 04)
5               - Trans. CVT (7744-"5")             (05 a 05)
0728            - Nr. Cliente no Cod. Bar.          (06 a 09)
9               - D.V. Modulo 10                    (10 a 10)

438             - Cont. Nr. Cliente no Cod.Bar.     (11 a 13)
00              - Campo Vago                        (14 a 15)
00000           - Nr. Ref. do Cliente (inicio)      (16 a 20)
2               - D.V. Modulo 10                    (21 a 21)

0231012357      - Nr. Ref. do Cliente (Cont.)       (22 a 31)
1               - D.V. Modulo 10                    (32 a 32)
1               - D.V. do codigo de barras          (33 a 33)
165400          - Valor do Titulo                   (34 a 47)

0728438 = Nr.Cliente no Cod.Barras.
000000231012357 = Nr. Ref. do Cliente (Nosso Numero !!).
--------------------------------------------------------------------------------
Para calculo do codigo de barras (Cobranca Especial Sem Registro) :

Posicoes  Tamanho  Cont‚udo
--------  -------  --------
01 a 03      3      Identificacao do Banco (409)
04 a 04      1      Moeda 9 = Reais
05 a 05      1      Digito Verificador do C¢d. Barras (m¢dulo 11 de 2 a 9)
06 a 19     14      Valor do T¡tulo
20 a 20      1      C¢digo para Transa‡Æo CVT=5
21 a 27      7      No. Cliente no C¢d. Barras (000.000-DV)
28 a 29      2      00 (vago) - preencher com Zeros
30 a 44     15      No. Referˆncia do Cliente (Nosso Numero)

// simulacao codigo de barras //
4099000000000120005072843800000000000000035
4329876543298765432987654329876543298765432

4099000000000015005072843800000000000000027
4329876543298765432987654329876543298765432

4099000000001654005072843800000000231012357
4329876543298765432987654329876543298765432
/*/

