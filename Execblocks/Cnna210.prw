#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

User Function Cnna210()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CNUMERO,NRESULT,CDC,I,NTAM,NDC")
SetPrvt("_NAUXVAL,CDIG,NOSSONUM,CDIGOLD,_CMSGAVISO,_NAVISO")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ CNNA210  ³ Autor ³ Gilberto A Oliveira Jr³ Data ³ 23/11/00    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Especifico para calculo de Nosso Numero com Modulo 1129       ³±±
±±³          ³ ( Multiplica-se de 2 ate 9 )                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Gen‚rico - Especifico do Rdmake A210DET.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Observ.  ³ O arquivo SEE (Parametros Bancarios) deve estar posicionado   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ROTINAS AUXILIARES E RELACIONADAS.                                       ³±±
±±³ ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ                                       ³±±
±±³ PFAT210.PRX     - Principal: Chama perguntas e aciona PFAT210A.          ³±±
±±³  PFAT210A.PRX   - Aciona A210DET, grava arquivo txt e chama Bloqueto.Exe.³±±
±±³   A210DET.PRX   - Dados do Lay-Out para criacao do arquivo.txt           ³±±
±±³  * CNNA210.PRX  - Calcula Digito do Nosso Num. e incremente EE_FAXATU.   ³±±
±±³    CALMOD10.PRX - Calcula digitos de controle com base no Modulo 1021    ³±±
±±³    CALMOD11.PRX - Calcula digitos do Codigo de Barras com base no Mod.11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Observacao³ Caso queira compilar varios desses Rdmakes utilize a Bat      ³±±
±±³          ³ BOL409.                                                       ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

// UTILIZA-SE DO PADRAO CD1129 (MODULO 11 de 2 a 9)

cNumero:=Alltrim(  Strzero( Val(SEE->EE_FAXATU),14)  )

If Empty(SE1->E1_NUMBCO)

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Calcula digito para o nosso numero.                          ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Grava Proximo Numero a ser utilizado.                        ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   DbSelectArea("SEE")
   RecLock("SEE",.F.)
   SEE->EE_FAXATU := Str(Val(cNumero)+1,Len(SEE->EE_FAXATU))
   MsUnlock()

   nResult:= 0
   cDc    := ""
   i      := 0
   nTam   :=Len(Alltrim(cNumero))
   nDc    := 0
   _nAuxVal:= 2

   For i:= nTam To 1 Step -1
       nResult := nResult + (Val(SubS(cNumero,i,1)) * _nAuxVal )
       _nAuxVal:= iif( _nAuxVal == 9, 2, _nAuxVal + 1 )
   Next i

   nResult := nResult * 10
   nDC     := MOD(nResult,11)

   cDig:=Iif( nDc > 9 , "0" , STR(nDc,1) )

   NossoNum := Alltrim(cNumero) + Alltrim(cDig)

   DbSelectArea("SE1")
   RecLock("SE1",.F.)
   SE1->E1_NUMBCO := Nossonum
   MsUnlock()

Else

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Calcula digito mesmo que o nosso numero ja exista.           ³
   //³ Para confirma se esta correto...                             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   cDigOld:= Right(Alltrim(SE1->E1_NUMBCO),1)
   cNumero:= SubS(Alltrim(SE1->E1_NUMBCO),1,LEN(AllTrim(SE1->E1_NUMBCO))- 1)
   cNumero:= Alltrim(StrZero(Val(cNumero),14))

   nResult := 0
   cDc     := ""
   i       := 0
   nTam    :=Len(Alltrim(cNumero))
   nDc     := 0
   _nAuxVal:= 2
   For i:= nTam To 1 Step -1
       nResult  := nResult + (Val(SubS(cNumero,i,1)) * _nAuxVal )
       _nAuxVal := iif( _nAuxVal == 9, 2, _nAuxVal + 1 )
   Next i
   nResult := nResult * 10
   nDC     := MOD(nResult,11)
   cDig    := Iif( nDc > 9 , "0" , STR(nDc,1) )

   If cDig #cDigOld
      //_cMsgAviso:= "Digito de Controle existente para esse titulo esta incorreto (Errado: " +cDigOld+" - Correto: "+cDig+". Deseja Substituir ??"
      //_nAviso:= Aviso("Digito Incorreto",_cMsgAviso,{"SIM","NAO"})
      RecLock("SE1",.F.)
      SE1->E1_NUMBCO:= cNumero+cDig
      MsUnLock()
   EndIf

   NossoNum:= SE1->E1_NUMBCO

EndIf

// Substituido pelo assistente de conversao do AP5 IDE em 19/03/02 ==> __Return(NossoNum)
Return(NossoNum)        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
