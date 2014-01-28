#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02

User Function Etmka04()        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CALIAS,_NPOSEDINIC,_NPOSEDFIN,_NPOSEDVENC,_NPOSPRODUTO,_CPRODUTO")
SetPrvt("_NORDEMSB1,_NREGSB1,_NORDEMSZ3,_NREGSZ3,ACOLS,")


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ETMKA04  ³ Autor ³ Fabio William         ³ Data ³ 18.05.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Preenche os Campos do Itens do Orcamento                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico para EDITORA PINI.                              ³±±
±±³          ³ Gatilhado pelo campo UB_PRODUTO                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³UpDate    ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

_cAlias    := Alias()
_nPosEDINIC  := ASCAN(aheader,{|x| alltrim(x[2])=="UB_EDINIC"})
_nPosEDFIN   := ASCAN(aheader,{|x| alltrim(x[2])=="UB_EDFIN"})
_nposEDVENC  := ASCAN(aheader,{|x| alltrim(x[2])=="UB_EDVENC"})
_nPosPRODUTO := ASCAN(aheader,{|x| alltrim(x[2])=="UB_PRODUTO"})

_cProduto :=  aCols[N,_nPosProduto]

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Salva Alias e Posiciona os arquivos     ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


DbSelectArea("SB1")
_nOrdemSB1 := IndexOrd()
_nRegSB1   := Recno()
DbSetOrder(01)
DbSeek(xFilial()+_cProduto)

DbSelectarea("SZ3")
_nOrdemSZ3 := IndexOrd()
_nRegSZ3   := Recno()
DbSeek(xFILIAL("SZ3")+_cProduto+SA3->A3_REGIAO)


aCols[N,_nposEDFIN]   :=  aCols[N,_nposEDINIC]+SB1->B1_QTDEEX
aCols[N,_nposEDVENC]  :=  aCols[N,_nposEDINIC]+SB1->B1_QTDEEX+SB1->B1_EXBONIF

DbSelectArea("SB1")
IndexOrd(_nOrdemSB1)
DbGoTo(_nRegSB1)

DbSelectarea("SZ3")
IndexOrd(_nOrdemSZ3)
DbGoTo(_nRegSZ3)

DbSelectarea(_cAlias)


// Substituido pelo assistente de conversao do AP5 IDE em 16/03/02 ==> __return(aCols[N,_nposEDINIC])
Return(aCols[N,_nposEDINIC])        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02



