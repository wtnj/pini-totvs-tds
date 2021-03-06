#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

User Function Cnna210()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CNUMERO,NRESULT,CDC,I,NTAM,NDC")
SetPrvt("_NAUXVAL,CDIG,NOSSONUM,CDIGOLD,_CMSGAVISO,_NAVISO")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴컴커굇
굇쿑un뇚o    � CNNA210  � Autor � Gilberto A Oliveira Jr� Data � 23/11/00    낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴컴캑굇
굇쿏escri뇚o � Especifico para calculo de Nosso Numero com Modulo 1129       낢�
굇�          � ( Multiplica-se de 2 ate 9 )                                  낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇� Uso      � Gen굍ico - Especifico do Rdmake A210DET.                      낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇� Observ.  � O arquivo SEE (Parametros Bancarios) deve estar posicionado   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇� ROTINAS AUXILIARES E RELACIONADAS.                                       낢�
굇� 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴                                       낢�
굇� PFAT210.PRX     - Principal: Chama perguntas e aciona PFAT210A.          낢�
굇�  PFAT210A.PRX   - Aciona A210DET, grava arquivo txt e chama Bloqueto.Exe.낢�
굇�   A210DET.PRX   - Dados do Lay-Out para criacao do arquivo.txt           낢�
굇�  * CNNA210.PRX  - Calcula Digito do Nosso Num. e incremente EE_FAXATU.   낢�
굇�    CALMOD10.PRX - Calcula digitos de controle com base no Modulo 1021    낢�
굇�    CALMOD11.PRX - Calcula digitos do Codigo de Barras com base no Mod.11 낢�
굇쳐컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿚bservacao� Caso queira compilar varios desses Rdmakes utilize a Bat      낢�
굇�          � BOL409.                                                       낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽
/*/

// UTILIZA-SE DO PADRAO CD1129 (MODULO 11 de 2 a 9)

cNumero:=Alltrim(  Strzero( Val(SEE->EE_FAXATU),14)  )

If Empty(SE1->E1_NUMBCO)

   //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
   //� Calcula digito para o nosso numero.                          �
   //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
   //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
   //� Grava Proximo Numero a ser utilizado.                        �
   //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

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

   //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
   //� Calcula digito mesmo que o nosso numero ja exista.           �
   //� Para confirma se esta correto...                             �
   //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

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
