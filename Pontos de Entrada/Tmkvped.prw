#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function Tmkvped()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CSAY1,_CSAY2,_CSAY3,_CSAY4,_CSAY5,_CSAY6")
SetPrvt("_CGET1,_CGET2,_CGET3,_CGET4,_CGET5,_CGET6")
SetPrvt("_CGET11,_CGET12,_CGET13,_CGET14,_CGET15,_CGET16")
SetPrvt("_CGET21,_CGET22,_CGET23,_CGET24,_CGET25,_CGET26")
SetPrvt("_CSAY11,_CSAY12,_CSAY13,_CSAY14,_CSAY15,_CSAY16")
SetPrvt("_CNUMREFINI,_CNUMREFFIN,_CUSER,_CNUMPED,")

_cSay1 := OemToAnsi("Cod. Promo‡Æo :")
_cSay2 := OemToAnsi("Resp. Cobr.   :")
_cSay3 := OemToAnsi("Cliente Fat.  :")
_cSay4 := OemToAnsi("Tipo Opera‡Æo :")
_cSay5 := OemToAnsi("Data C lculo  :")
_cSay6 := OemToAnsi("Observa‡Æo.   :")

_cGet1 := SPACE(03)
_cGet2 := SPACE(40)
_cGet3 := SPACE(06)
_cGet4 := SPACE(03)
_cGet5 := dDataBase
_cGet6 := Space(40)

_cGet11 := stod("")
_cGet12 := stod("")
_cGet13 := stod("")
_cGet14 := stod("")
_cGet15 := stod("")
_cGet16 := stod("")

_cGet21 := 0.0
_cGet22 := 0.0
_cGet23 := 0.0
_cGet24 := 0.0
_cGet25 := 0.0
_cGet26 := 0.0

_cSay11 := "Parcela 1"
_cSay12 := "Parcela 2"
_cSay13 := "Parcela 3"
_cSay14 := "Parcela 4"
_cSay15 := "Parcela 5"
_cSay16 := "Parcela 6"
@ 0,0 TO 423,525 DIALOG oDlg6 TITLE "Dados Complementares"
@ 8,10 TO 184,272
@ 91,139 BUTTON "OK" Size 70,20  ACTION Grava()// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> @ 91,139 BUTTON "OK" Size 70,20  ACTION Execute(Grava)
@ 23,14 SAY _cSay1
@ 33,14 SAY _cSay2
@ 43,14 SAY _cSay3
@ 53,14 SAY _cSay4
@ 63,14 SAY _cSay5
@ 73,14 SAY _cSay6
@ 23,54 Get _cGet1  F3 "SZA"
@ 33,54 Get _cGet2  PICTURE "@S40"
@ 43,54 Get _cGet3  F3 "CLI"
@ 53,54 Get _cGet4  valid ExecBlock("ETMKA02",.F.,.F.)   F3 "SZ9"
@ 63,54 Get _cGet5  valid ExecBlock("ETMKA01",.F.,.F.)
@ 73,54 Get _cGet6      PICTURE "@S40"

// Mostra as parcelas

@  83,14 SAY _cSay11
@  93,14 SAY _cSay12
@ 103,14 SAY _cSay13
@ 113,14 SAY _cSay14
@ 123,14 SAY _cSay15
@ 133,14 SAY _cSay16

@  83,54 GET _cGet11        Object oGet11
@  93,54 GET _cGet12        Object oGet12
@ 103,54 GET _cGet13        Object oGet13
@ 113,54 GET _cGet14        Object oGet14
@ 123,54 GET _cGet15        Object oGet15
@ 133,54 GET _cGet16        Object oGet16

@  83,100 GET _cGet21       Object oGet21
@  93,100 GET _cGet22       Object oGet22
@ 103,100 GET _cGet23       Object oGet23
@ 113,100 GET _cGet24       Object oGet24
@ 123,100 GET _cGet25       Object oGet25
@ 133,100 GET _cGet26       Object oGet26

ACTIVATE DIALOG oDlg6 CENTERED
Return



// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> Function Grava
Static Function Grava()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cNumRefIni := "000000"
_cNumRefFin := "999999"
_cUser := Subs(cUsuario,7,15)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Obtem qual faixa de Numeracao que o vendedor pode trabalhar  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SX5")
DbSeek(xFilial("SX5")+"Z0")
Do While SX5->X5_TABELA == "Z0"
   if Rtrim(_cUser) $ SX5->X5_DESCRI
      _cNumRefIni := SUBS(SX5->X5_Descri,21,6)  // Primeiro Numero Referencia
      _cNumRefFin := SUBS(SX5->X5_Descri,28,6)  // Ultimo   Numero Referencia
  Endif

  Dbskip()
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Localiza qual sera o numero utilizado                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SC5")
DbSeek(xFilial()+_cNumRefFin,.t.)
DbSkip(-1)
//MSGALERT(SC5->C5_NUM)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Armazena qual sera o numero utilizado                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
if SC5->C5_NUM <_cNumRefIni
   _cNumPed :=  _cNumRefIni
else
   _cNumPed :=  Soma1(SC5->C5_NUM,6)
Endif
//MSGALERT(_CNUMPED)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona o Cadastro de Cliente                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("SA1")
DbSeek(xFilial("SA1")+SUA->UA_CLIENTE+SUA->UA_LOJA)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza os Cabecalho do Pedido                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RecLock("SC5",.T.)
SC5->C5_FILIAL  := xFilial("SC5")
SC5->C5_NUM     := _cNumPed
SC5->C5_CLIENTE := SUA->UA_CLIENTE
SC5->C5_LOJACLI := SUA->UA_LOJA
SC5->C5_LOJAENT := SUA->UA_LOJA
SC5->C5_TIPO    := SA1->A1_TIPO

SC5->C5_CODPROM  := _cGet1
SC5->C5_DIVVEN  := "MERC"
SC5->C5_CONDPAG := "201"
SC5->C5_TABELA  := "1"
SC5->C5_LOTEFAT := "100"
SC5->C5_DATA    := dDataBase
SC5->C5_DESPREM := SUA->UA_DESPESA //nDespesa
SC5->C5_TIPOOP  := _cGet4
SC5->C5_DTCALC  := _cGet5
SC5->C5_VEND1   := posicione("SA3",1,xfilial("SA3")+SUA->UA_VEND,"A3_COD") //SUA->UA_VEND
SC5->C5_VEND3   := SA3->A3_SUPER
SC5->C5_VEND4   := SA3->A3_GEREN
SC5->C5_VEND5   := SA3->A3_GERGER
SC5->C5_EMISSAO := dDataBase
SC5->C5_RESPCOB := _cGet2
SC5->C5_USUARIO := SUBS(CUSUARIO,7,15)
SC5->C5_CLIFAT  := _cGet3

SC5->C5_PARC1   := _cGet21
SC5->C5_PARC2   := _cGet22
SC5->C5_PARC3   := _cGet23
SC5->C5_PARC4   := _cGet24
SC5->C5_PARC5   := _cGet25
SC5->C5_PARC6   := _cGet26

SC5->C5_DATA1   := _cGet11
SC5->C5_DATA2   := _cGet12
SC5->C5_DATA3   := _cGet13
SC5->C5_DATA4   := _cGet14
SC5->C5_DATA5   := _cGet15
SC5->C5_DATA6   := _cGet16

DbSelectArea("SZ9")
DbSeek(xFilial()+_cGet4)
If  "CARTAO" $ SZ9->Z9_DESCR
   SC5->C5_MENNOTA := "CARTAO DE CREDITO"
Endif

msUnlock()



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza os Itens do Pedido de Venda                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DBSELECTAREA("SZ3")
DBSETORDER(1)
DbSeek(XFILIAL("SZ3")+SUB->UB_PRODUTO+SA3->A3_REGIAO) //POSICIONA A REGIAO DE VENDAS PARA COMISSAO

DbSelectarea("SUB")
DbSeek(xFilial("SUB")+SUA->UA_NUM)

Do While !eof() .and. SUA->UA_NUM == SUB->UB_NUM
   DbSelectArea("SC6")
   RecLock("SC6",.T.)
   SC6->C6_NUM         :=  _cNumPed
   SC6->C6_FILIAL      :=  xFilial("SC6")
   SC6->C6_ITEM        :=  SUB->UB_ITEM
   SC6->C6_PRODUTO     :=  SUB->UB_PRODUTO
   SC6->C6_UM          :=  SUB->UB_UM
   SC6->C6_QTDVEN      :=  SUB->UB_QUANT
   SC6->C6_PRCVEN      :=  SUB->UB_VRUNIT
   SC6->C6_VALOR       :=  SUB->UB_VLRITEM
   SC6->C6_QTDLIB      :=  0
   SC6->C6_TES         :=  SUB->UB_TES
   SC6->C6_CF          :=  SUB->UB_CF
   SC6->C6_GRADE       :=  "N"
   SC6->C6_LOCAL       :=  SUB->UB_LOCAL
   SC6->C6_CLI         :=  SUA->UA_CLIENTE
   SC6->C6_DESCONT     :=  SUB->UB_DESC
   SC6->C6_VALDESC     :=  SUB->UB_VALDESC
   SC6->C6_DESCRI      :=  posicione("SB1",1,xfilial("SB1")+SUB->UB_PRODUTO,"B1_DESC") //SUB->UB_DESCRI
   SC6->C6_PRUNIT      :=  SUB->UB_PRCTAB
   SC6->C6_GRADE       :=  "N"
   SC6->C6_EDINIC      :=  SUB->UB_EDINIC
   SC6->C6_EDFIN       :=  SUB->UB_EDFIN
   SC6->C6_EDVENC      :=  SUB->UB_EDVENC
   SC6->C6_EDSUSP      :=  SUB->UB_EDSUSP
   SC6->C6_TIPOREV     :=  SUB->UB_TIPOREV
   SC6->C6_CODDEST     :=  SUB->UB_CODDEST
   SC6->C6_CODSCC      :=  SUB->UB_CODSCC
//   SC6->C6_PEDREN      :=  SUB->UB_PEDREN
//   SC6->C6_ITEMREN     :=  SUB->UB_ITEMREN
   SC6->C6_SITUAC      :=  SUB->UB_SITUAC
   SC6->C6_DESCESP     :=  SUB->UB_DESCESP
   SC6->C6_VALESP      :=  SUB->UB_VALESP
   SC6->C6_TIPOASS     :=  SUB->UB_TIPOASS
   SC6->C6_TPPORTE     :=  SUB->UB_TPPORTE
   SC6->C6_PEDANT      :=  SUB->UB_PEDANT
   SC6->C6_ITEMANT     :=  SUB->UB_ITEMANT
   SC6->C6_LOTEFAT     :=  SUB->UB_LOTEFAT
   SC6->C6_DATA        :=  SUB->UB_DATA
   SC6->C6_REGCOT      :=  SUB->UB_REGCOT
   SC6->C6_DTENVIO     :=  SUB->UB_DTENVIO
   SC6->C6_ORIGEM      :=  SUB->UB_ORIGEM
   SC6->C6_NUMANT      :=  SUB->UB_NUMANT
   SC6->C6_DTCANC      :=  SUB->UB_DTCANC
   SC6->C6_EXADIC      :=  SUB->UB_EXADIC

   SC6->C6_COMIS1      :=  IIF(SA3->A3_TIPOVEN $ "OP", SZ3->Z3_COMOTEL, SZ3->Z3_COMREP1 )
   //SC6->C6_COMIS2      :=  SUB->UB_COMIS2
   SC6->C6_COMIS3      :=  SZ3->Z3_COMSUP
   SC6->C6_COMIS4      :=  SZ3->Z3_COMGLOC
   //SC6->C6_COMIS5      :=  SUB->UB_COMIS5

   DbSelectArea("SUB")
   DbSkip()
Enddo


Close(Odlg6)
Return




/*/
                    UB_VALICM
                    UB_VALIPI
 C6_ENTREG
                    UB_BASEICM
 C6_LOJA
                    UB_EMISSAO
 C6_NOTA
                    UB_ACRE
 C6_SERIE
                    UB_VALACRE
 C6_COMIS1
 C6_COMIS2
 C6_COMIS3
 C6_COMIS4
 C6_COMIS5
 C6_PEDCLI
 C6_BLOQUEI
 C6_GEROUPV
 C6_RESERVA
 C6_IPIDEV
 C6_LOTECTL
 C6_DTVALID
 C6_ITEMOP
 C6_NUMORC
 C6_CHASSI
 C6_OPC
                   C6_EDINIC
                   C6_EDFIN
 C6_LOCALIZ
 C6_NUMSERI
                   C6_TIPOREV
 C6_CODDEST
 C6_NUMOP
 C6_CODSCC
 C6_CLASFIS
                   C6_PEDREN
                   C6_ITEMREN
                   C6_SITUAC
                   C6_EDVENC
                   C6_EDSUSP
                   C6_DESCESP
                   C6_VALESP
                   C6_TIPOASS
                   C6_TPPORTE
 C6_PEDANT
 C6_ITEMANT
 C6_LOTEFAT
                   C6_DATA
                   C6_REGCOT
                   C6_DTENVIO
                   C6_ORIGEM
                   C6_NUMANT
                   C6_DTCANC
                   C6_EXADIC












/*/
