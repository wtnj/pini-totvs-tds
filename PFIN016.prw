#INCLUDE "RWMAKE.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: LUCPER    ³Autor: SOLANGE NALINI         ³ Data:  28/04/01  ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Preparacao dos titulos para Lucros e Perdas                ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo Financeiro - Espec¡fico PINI                        ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User Function PFIN016()
//ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ MV_PAR01 ³ Data do Cancelamento: ³
//ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:="FIN001"

If !Pergunte(cPerg)
   Return
Endif

IF Lastkey()==27
   Return
Endif

xDATA1 := mv_par01-185
xDATA2 := mv_par01-365
lEnd:= .F.

Processa({|lEnd|PF16Proc(@lEnd)},"Aguarde","Processando",.t.)

Return

Static Function PF16Proc()

nCont := 0

DbSelectArea("SE1")
DbSetOrder(6)
DbGoTop()
ProcRegua(RecCount())

While SE1->E1_FILIAL == xFilial("SE1") .and. DTOS(SE1->E1_EMISSAO) <= DTOS(xData1) .and. !EOF()
   IncProc("Data: "+TRANSFORM(SE1->E1_EMISSAO,"@E 99/99/99"))
   If SE1->E1_SALDO == 0 .or. Alltrim(SE1->E1_TIPO) <> "NF" .or. !Alltrim(SE1->E1_SERIE) $ "UNI/SER/CAN" .or. !Empty(SE1->E1_BAIXA)
       DbSelectArea("SE1")
       DbSkip()
       Loop
   EndIf
   DbSelectArea("SF2")
   DbSetOrder(1)
   DbSeek(xfilial("SF2")+SE1->E1_NUM+SE1->E1_SERIE)
   nValNF   := SF2->F2_VALBRUT-SF2->F2_DESPREM
   nCont++
   IncProc("Atualizando: "+StrZero(nCont,6)+" "+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA)
   If nValNF <= 5000
      If Dtos(SE1->E1_EMISSAO) <= Dtos(xDATA1)
         ALT_NAT()
      Endif
   Else
      If Dtos(SE1->E1_EMISSAO) <= Dtos(xDATA2)
         ALT_NAT()
      Endif
   Endif

   DBSELECTAREA("SE1")
   Dbskip()
End

RETURN

Static Function ALT_NAT()

If Alltrim(SE1->E1_SERIE) $ "ASS"
	cNaturez  := 'CAN'
	cPortado  := 'CAN'
	cAgedep   := '00000'
	cConta    := '0000000000'
	cSituaca  := '0'
Else
	cNaturez  := 'LP'
	cPortado  := 'BLP'
	cAgedep   := '99999'
	cConta    := '9999999999'
	cSituaca  := '0'
EndIf

DbSelectarea("SE1")
Reclock("SE1",.F.)
SE1->E1_NATUREZ := cNaturez
SE1->E1_PORTADO := cPortado
SE1->E1_AGEDEP  := cAgedep
SE1->E1_CONTA   := cConta
SE1->E1_SITUACA := cSituaca
MsUnlock()

Return