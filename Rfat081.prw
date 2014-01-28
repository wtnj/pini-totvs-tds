#include "rwmake.ch" 
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT081   ³Autor: Desconhecido           ³ Data:   06/07/98 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Consulta de titulos por numero bancario                    ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo Financeiro                                          ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat081()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

Private cIndex, cKey, mNumbco
Private oDlg1, oNumBco, oDuplic
Private lCheck1 := .f.

dbSelectArea("SE1")
cIndex := CriaTrab(Nil,.F.)
cKey   := "E1_FILIAL+E1_NUMBCO"
MsAguarde({|| Indregua("SE1",cIndex,ckey,,,"Selecionando Registros do Arq")},"Aguarde", "Construindo Indice Temporario")

DBGOTOP()

MNUMBCO := SPACE(15)
mDuplic := Space(15)

@ 188, 322 To 350, 707 Dialog oDlg1 Title OemToAnsi("Pesquisa por Numero Bancario")
@ 010, 015 Say OemToAnsi("Digite o No. Bancario ") Size 75,10
@ 010, 095 Get mNumBco Size 75,10 Object oNumBco
@ 025, 015 Say OemToAnsi("Duplicata ") Size 75,10
@ 025, 095 Get mDuplic When .f. Size 75,10 Object oDuplic
//@ 055, 015 CheckBox oCheck1 Var lCheck1 Prompt OemtoAnsi("Completa Zeros") Size 75,10 of oDlg1
@ 055, 100 BmpButton Type 1 Action (mDuplic := R081Proc(mNumBco),ObjectMethod(oDuplic,"SetText(mDuplic)"))
@ 055, 150 BmpButton Type 2 Action Close(oDlg1)
//ObjectMethod(oDuplic,"SetText(mDuplic)")
Activate Dialog oDlg1 CENTERED

DbSelectArea("SE1")
RetIndex("SE1")

Return

Static Function R081Proc(mNumBco)

Local cDupl := Space(15)

DbSelectArea("SE1")

If lCheck1
	mNumBco := Strzero(Val(mNumBco),15)
EndIf	

If DBSEEK(xFilial("SE1")+MNUMBCO)
    cDupl := SE1->E1_NUM + SE1->E1_PARCELA
Else
	cDupl := "Nao Localizado!"
ENDIF

RETURN(cDupl)