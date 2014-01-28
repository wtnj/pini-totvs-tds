#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

User Function Pfat131()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,LIMITE,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,ARETURN,NOMEPROG,CPERG,NLASTKEY")
SetPrvt("NLIN,WNREL,CSTRING,TREGS,M_MULT,P_ANT")
SetPrvt("P_ATU,P_CNT,M_SAV20,M_SAV7,_ACAMPOS,_CNOME")
SetPrvt("CCHAVE,CFILTRO,CIND,_SALIAS,AREGS,I")
SetPrvt("J,mhora")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT131   ³Autor: Rosane Rodrigues       ³ Data:   08/05/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Etiquetas dos Autores                                      ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Especifico PINI                                            ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Do c¢digo                            ³
//³ mv_par02             // At‚ o c¢digo                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li       := 0
LIN      := 0
CbTxt    := " "
CbCont   := " "
nOrdem   := 0
Alfa     := 0
Z        := 0
M        := 0
tamanho  := "G"
limite   := 220
titulo   := PADC("ETIQUETAS",74)
cDesc1   := PADC("Este programa ira emitir as Etiquetas dos Autores",70)
cDesc2   := " "
cDesc3   := " "

aReturn  := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
nomeprog := "PFAT131"

cPerg    := "PFT131"
_ValidPerg()

nLastKey := 0
nLin     := 0
MHORA      := TIME()
wnrel    := "ETIQAUT_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.T.)               // Pergunta no SX1
CSTRING  := 'SA3'

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
   Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica Posicao do Formulario na Impressora                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Prepara regua de impressÆo                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

tregs  := LastRec()-Recno()+1
m_mult := 1
If tregs > 0
   m_mult := 70/tregs
EndIf
p_ant   := 4
p_atu   := 4
p_cnt   := 0

_aCampos := {{"NOME"     ,"C",40,0},;
             {"V_END"     ,"C",40,0},;
             {"BAIRRO"    ,"C",20,0},;
             {"MUN"       ,"C",20,0},;
             {"CEP"       ,"C",8, 0},;
             {"EST"       ,"C",2, 2}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"ETIQAUT",.F.,.F.)

DbSelectArea("SA3")
DbSetOrder(2)
cChave := IndexKey()
cFiltro:= 'A3_TIPOVEN=="AT"'
cInd   := CriaTrab(NIL,.f.)
IndRegua("SA3",cInd,cChave,,cFiltro,"Filtrando...")
DbGoTop()

While !Eof()
   GRAVA_TEMP()
   dbSelectArea("SA3")
   dbSkip()
End

IMPETIQ()

set deviCE to screen
If aRETURN[5] == 1
   Set Printer to
   dbcommitAll()
   ourspool(WNREL)
EndIf
MS_FLUSH()

dbSelectArea("ETIQAUT")
dbCloseArea()
fErase(_cNome+".DBF")

dbSelectArea("SA3")
Retindex("SA3")
Return

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function Grava_Temp

Static Function Grava_Temp()
dbSelectArea("ETIQAUT")
Reclock("ETIQAUT",.t.)
ETIQAUT->NOME   :=  SA3->A3_NOME
ETIQAUT->V_END  :=  SA3->A3_END
ETIQAUT->BAIRRO :=  SA3->A3_BAIRRO
ETIQAUT->MUN    :=  SA3->A3_MUN
ETIQAUT->EST    :=  SA3->A3_EST
ETIQAUT->CEP    :=  SA3->A3_CEP
ETIQAUT->(msUnlock())
Return

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function Impetiq
Static Function Impetiq()
// Set DeviCE to Prin         

dbSelectArea("ETIQAUT") 

dbGoTop()
SetPrc(0,0)
While !EOF()
   @ LIN+LI,001 PSAY NOME
   dbSkip()
   @ LIN+LI,045 PSAY NOME
   dbSkip()
   @ LIN+LI,089 PSAY NOME
   dbSkip(-2)
   LI:=LI+1

   @ LIN+LI,001 PSAY V_END
   dbSkip()
   @ LIN+LI,045 PSAY V_END
   dbSkip()
   @ LIN+LI,089 PSAY V_END
   dbSkip(-2)
   LI:=LI+1

   @ LIN+LI,001 PSAY BAIRRO
   dbSkip()
   @ LIN+LI,045 PSAY BAIRRO
   dbSkip()     
   @ LIN+LI,089 PSAY BAIRRO
   dbSkip(-2)
   LI:=LI+1

   @ LIN+LI,001 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
   dbSkip()
   @ LIN+LI,045 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
   dbSkip()
   @ LIN+LI,089 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
   LI:=LI+1
   dbSkip()
   LI:=2
   setprc(0,0)
   lin:=prow()+1
End
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³VALIDPERG ³ Autor ³  Luiz Carlos Vieira   ³ Data ³ 16/07/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica as perguntas inclu¡ndo-as caso n„o existam        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Espec¡fico para clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Return(nil)        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02


// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _ValidPerg
Static Function _ValidPerg()
_sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

AADD(aRegs,{cPerg,"01","Do Codigo..........:","mv_ch1","C",6,0,0,"G","","mv_par01","","0108001","","","","","","","","","","","","","SA3"})
AADD(aRegs,{cPerg,"02","At‚ Codigo.........:","mv_ch2","C",6,0,0,"G","","mv_par02","","0108003","","","","","","","","","","","","","SA3"})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		SX1->(MsUnlock())
	Endif
Next
DbSelectArea(_sAlias)
Return
