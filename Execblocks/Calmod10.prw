#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

User Function Calmod10()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("_CNUMPAR,_NMULT,_NSOMA,_X1,_NPARTE,_CAUXVAR")
SetPrvt("_NVERNUM,_NDIGVER,_CNRCOMPLETO,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴컴커굇
굇쿑un뇚o    � CalcMod10� Autor � Gilberto A. Oliveira  � Data � 23/11/00    낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴컴캑굇
굇쿏escri뇚o � Calcula digito conforme as regras do Modulo 1021.             낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿛arametros� Deve ser passado o n즡ero sobre o qual ser� calculado o       낢�
굇�          � digito.                                                       낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿝etorno   � Sera retornado o n즡ero passado como parametro acrescido do   낢�
굇�          � digito calculado.                                             낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇� Uso      � Gen굍ico                                                      낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇� ROTINAS AUXILIARES E RELACIONADAS.                                       낢�
굇� 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴                                       낢�
굇� PFAT210.PRX     - Principal: Chama perguntas e aciona PFAT210A.          낢�
굇�  PFAT210A.PRX   - Aciona A210DET, grava arquivo txt e chama Bloqueto.Exe.낢�
굇�   A210DET.PRX   - Dados do Lay-Out para criacao do arquivo.txt           낢�
굇�    NOSSONUM.PRX - Calcula Digito do Nosso Num. e incremente EE_FAXATU.   낢�
굇� *  CALMOD10.PRX - Calcula digitos de controle com base no Modulo 1021    낢�
굇�    CALMOD11.PRX - Calcula digitos do Codigo de Barras com base no Mod.11 낢�
굇쳐컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑굇
굇쿚bservacao� Caso queira compilar varios desses Rdmakes utilize a Bat      낢�
굇�          � BOL409.                                                       낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽
/*/

_cNumPar:= ParamIXB
_nMult:= 2
_nSoma:= 0

For _x1:= Len(_cNumPar) to 1 Step -1

    _nParte:= Val(SubSt(_cNumPar,_x1,1))
    _cAuxVar:= Alltrim(Str(_nMult*_nParte,2))
    _nVerNum:= Iif(Len(_cAuxVar)>1,Val(Left(_cAuxVar,1))+Val(Right(_cAuxVar,1)),Val(_cAuxVar))
    _nSoma:= _nSoma + _nVerNum
    _nMult:= iif( _nMult == 2 , 1 , 2)

Next

//Alert( "Soma das Multiplicacoes: "+Str(_nSoma) )

_nDigVer:= 10 - MOD(_nSoma,10)

If _nDigVer >= 10
   _nDigVer:= 0
EndIf

_cNrCompleto:= _cNumPar+Str(_nDigVer,1)

//Alert("Digito Encontrado : "+Str(_nDigVer,1) )
// Substituido pelo assistente de conversao do AP5 IDE em 19/03/02 ==> __Return(_cNrCompleto)
Return(_cNrCompleto)        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02


