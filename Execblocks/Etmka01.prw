#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02

User Function Etmka01()        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CGET11,_CGET21,_CGET12,_CGET22,_CGET13,_CGET23")
SetPrvt("_CGET14,_CGET24,_CGET15,_CGET25,_CGET16,_CGET26")

 /*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ETMKA01   ³ Autor ³ Fabio William         ³ Data ³ 11.05.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Atualiza os Campos da Tela Complemtar de dados              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³Disparado pelo campo cGet5 do programa TMKVPED              ³±±
±±³          ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

// nLiquido Valor Liquido que esta no Telemarketing
//

// _cGet4  == Tipo de Operacao
// _cGet5  == Data do Calculo
// _cGet11 == Data Parcela1
// _cGet12 == Data Parcela2
// _cGet13 == Data Parcela3
// _cGet14 == Data Parcela4
// _cGet15 == Data Parcela5
// _cGet16 == Data Parcela6

//  _cGet21 == Valor da Parcela 1
//  _cGet22 == Valor da Parcela 2
//  _cGet23 == Valor da Parcela 3
//  _cGet24 == Valor da Parcela 4
//  _cGet25 == Valor da Parcela 5
//  _cGet26 == Valor da Parcela 6
             
Private nLiquido := SUA->UA_VLRLIQ
DbSelectArea("SZ9")
DbSeek(xFilial()+_cGet4)
If !eof()
   IF SZ9->Z9_DIASP1 #0
      _cGet11 :=  SZ9->Z9_DIASP1 + _cGet5
   else
      _cGet11 :=  dDataBase
  Endif
  _cGet21 := nLiquido/SZ9->Z9_QTDEP

  IF SZ9->Z9_QTDEP >= 2
     IF SZ9->Z9_DIASP1 == 0
       _cGet12 :=  SZ9->Z9_DIASDP + _cGet5
     Else
       _cGet12 :=  SZ9->Z9_DIASDP + _cGet5
      Endif
     _cGet22 := nLiquido/SZ9->Z9_QTDEP
  Endif
  IF SZ9->Z9_QTDEP >= 3
    _cGet13 := SZ9->Z9_DIASDP  + _cGet12
    _cGet23 := nLiquido/SZ9->Z9_QTDEP
  Endif
  IF SZ9->Z9_QTDEP >= 4
     _cGet14 := SZ9->Z9_DIASDP + _cGet13
     _cGet24 := nLiquido/SZ9->Z9_QTDEP
  Endif
  IF SZ9->Z9_QTDEP >= 5
    _cGet15 := SZ9->Z9_DIASDP  + _cGet14
    _cGet25 := nLiquido/SZ9->Z9_QTDEP
  Endif
  IF SZ9->Z9_QTDEP >= 6
    _cGet16 := SZ9->Z9_DIASDP  + _cGet15
    _cGet26 := nLiquido/SZ9->Z9_QTDEP
  Endif

   ObjectMethod(oGet11,"Refresh()")
   ObjectMethod(oGet21,"Refresh()")
   ObjectMethod(oGet12,"Refresh()")
   ObjectMethod(oGet22,"Refresh()")
   ObjectMethod(oGet13,"Refresh()")
   ObjectMethod(oGet23,"Refresh()")
   ObjectMethod(oGet14,"Refresh()")
   ObjectMethod(oGet24,"Refresh()")
   ObjectMethod(oGet15,"Refresh()")
   ObjectMethod(oGet25,"Refresh()")
   ObjectMethod(oGet16,"Refresh()")
   ObjectMethod(oGet26,"Refresh()")
Endif
// Substituido pelo assistente de conversao do AP5 IDE em 16/03/02 ==> __return(.t.)
Return(.t.)        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02

