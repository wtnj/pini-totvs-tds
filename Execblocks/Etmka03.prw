#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02

User Function Etmka03()        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CALIAS,_NPOSEDFIN,_NPOSEDVENC,_NPOSCLASFIS,_NPOSLOCAL,_NPOSPRODUTO")
SetPrvt("_NPOSCOM4,_NPOSCOM5,_NPOSCOM1,_NPOSCOM3,_NPOSDATA,_NPOSLOTEFAT")
SetPrvt("_NPOSREGCOT,_NPOSTIPOREV,_NPOSEDINIC,_NPOSSITUAC,_NPOSPORTE,_NPOSEDSUSP")
SetPrvt("_NPOSDTENVIO,_CPRODUTO,_NORDEMSB1,_NREGSB1,_NORDEMSZ3,_NREGSZ3")
SetPrvt("ACOLS,")


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ETMKA03  ³ Autor ³ Fabio William         ³ Data ³ 18.05.99 ³±±
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
_nPosEDFIN   := ASCAN(aheader,{|x| alltrim(x[2])=="UB_EDFIN"})
_nPosEDVENC  := ASCAN(aheader,{|x| alltrim(x[2])=="UB_EDVENC"})
_nPosCLASFIS := ASCAN(aheader,{|x| alltrim(x[2])=="UB_CLASFIS"})
_nPosLOCAL   := ASCAN(aheader,{|x| alltrim(x[2])=="UB_LOCAL"})
_nPosPRODUTO := ASCAN(aheader,{|x| alltrim(x[2])=="UB_PRODUTO"})
_nPosCOM4    := ASCAN(aheader,{|x| alltrim(x[2])=="UB_COMIS4"})
_nPosCOM5    := ASCAN(aheader,{|x| alltrim(x[2])=="UB_COMIS5"})
_nPosCOM1    := ASCAN(aheader,{|x| alltrim(x[2])=="UB_COMIS1"})
_nPosCOM3    := ASCAN(aheader,{|x| alltrim(x[2])=="UB_COMIS3"})
_nPosDATA    := ASCAN(aheader,{|x| alltrim(x[2])=="UB_DATA"})
_nPosLOTEFAT := ASCAN(aheader,{|x| alltrim(x[2])=="UB_LOTEFAT"})
_nPosREGCOT  := ASCAN(aheader,{|x| alltrim(x[2])=="UB_REGCOT"})
_nPosTIPOREV := ASCAN(aheader,{|x| alltrim(x[2])=="UB_TIPOREV"})
_nPosEDINIC  := ASCAN(aheader,{|x| alltrim(x[2])=="UB_EDINIC"})
_nPosEDFIN   := ASCAN(aheader,{|x| alltrim(x[2])=="UB_EDFIN"})
_nPosEDVENC  := ASCAN(aheader,{|x| alltrim(x[2])=="UB_EDVENC"})
_nPosSITUAC  := ASCAN(aheader,{|x| alltrim(x[2])=="UB_SITUAC"})
_nPosPORTE   := ASCAN(aheader,{|x| alltrim(x[2])=="UB_TPPORTE"})
_nPosEDSUSP  := ASCAN(aheader,{|x| alltrim(x[2])=="UB_EDSUSP"})
_nPosDTENVIO := ASCAN(aheader,{|x| alltrim(x[2])=="UB_DTENVIO"})

_cProduto :=  aCols[N,_nPosProduto]

// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
// ³Salva Alias e Posiciona os arquivos     ³
// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


DbSelectArea("SB1")
_nOrdemSB1 := IndexOrd()
_nRegSB1   := Recno()
DbSetOrder(01)
DbSeek(xFilial()+_cProduto)

DbSelectArea("SA3")
DbSeek(xFilial())
Do While xFilial("SA3") == SA3->A3_FILIAL .AND. RTRIM(CVEND)<>RTRIM(SA3->A3_NOME)
   Dbskip()
Enddo

DbSelectarea("SZ3")
_nOrdemSZ3 := IndexOrd()
_nRegSZ3   := Recno()
DbSetOrder(01)
DbSeek(xFILIAL("SZ3")+_cProduto+SA3->A3_REGIAO)
msgAlert(_cproduto)


aCols[N,_nPosLOCAL]   :=  SA3->A3_CODESTQ
aCols[N,_nPosPRODUTO] :=  SZ3->Z3_COMREP1
aCols[N,_nPosCOM4]  :=  SZ3->Z3_COMGLOC
aCols[N,_nPosCOM5]  :=  SZ3->Z3_COMGGER
aCols[N,_nPosCOM1]  :=  Iif(SA3->A3_tipoven=='OP',SZ3->Z3_COMOTEL,SZ3->Z3_COMREP1)
aCols[N,_nPosCOM3]  :=  SZ3->Z3_COMSUP
aCols[N,_nPosREGCOT]  :=  IF(SUBS(_cproduto,1,2)=='01',SUBS(_cProduto,1,4),"99")
aCols[N,_nPosSITUAC]  :=  'AA'
aCols[N,_nPosPORTE ]  :=  '0'
aCols[N,_nPosEDSUSP]  :=  CTOD('  /  /  ')
aCols[N,_nPosDTENVIO] :=  CTOD('  /  /  ')


aCols[N,_nPosTIPOREV] := IF('ASS' $(_cProduto)," ","0")
aCols[N,_nPosEDINIC]  := IF('ASS' $(_cProduto),0,9999)
aCols[N,_nPosEDFIN]   := IF('ASS' $(_cProduto),0,9999)
aCols[N,_nPosEDVENC]  := IF('ASS' $(_cProduto),0,9999)



aCols[N,_nPosDATA]    :=  dDataBase
aCols[N,_nPosLOTEFAT] :=   "100"

DbSelectArea("SB1")
IndexOrd(_nOrdemSB1)
DbGoTo(_nRegSB1)

DbSelectarea("SZ3")
IndexOrd(_nOrdemSZ3)
DbGoTo(_nRegSZ3)

DbSelectarea(_cAlias)
// Substituido pelo assistente de conversao do AP5 IDE em 16/03/02 ==> __return(_cProduto)
Return(_cProduto)        // incluido pelo assistente de conversao do AP5 IDE em 16/03/02





