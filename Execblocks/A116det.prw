#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³A116DET   ºAutor  ³Microsiga           º Data ³  03/30/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao de linhas de detalhe de boletos BANESPA           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/// Esse ExecBlock ‚ parte integrante do RdMake PFAT116.PRX
/// Foi necessario faze-lo separado do PFAT116.PRX pois o mesmo bloco abaixo
/// nao funciona como funcao interna. Quando interna o Return final abandona o
/// programa quando o certo seria apenas voltar ao ponto de chamada da funcao.
User Function A116det()        // incluido pelo assistente de conversao do AP5 IDE em 19/03/02

SetPrvt("_NSEQ,_CINCREMENTA,DET_001_A_001,DET_002_A_003,DET_004_A_017,DET_018_A_028")
SetPrvt("DET_029_A_037,DET_038_A_062,DET_063_A_065,DET_066_A_072,DET_073_A_082,DET_083_A_107")
SetPrvt("DET_108_A_108,DET_109_A_110,DET_111_A_120,DET_121_A_126,DET_127_A_139,DET_140_A_142")
SetPrvt("DET_143_A_147,DET_148_A_149,DET_150_A_150,DET_151_A_156,DET_157_A_158,DET_159_A_160")
SetPrvt("DET_161_A_173,DET_174_A_179,DET_180_A_192,DET_193_A_205,DET_206_A_218,DET_219_A_220")
SetPrvt("DET_221_A_234,DET_235_A_274,DET_275_A_314,DET_315_A_326,DET_327_A_334,DET_335_A_349")
SetPrvt("DET_350_A_351,DET_352_A_391,DET_392_A_393,DET_394_A_394,DET_395_A_400,_ADETALHES")
SetPrvt("_CLIN,_N2,")

_nSeq       := _nSeq + 1
_cIncrementa:= StrZero(_nSeq,6)

SA1->( DbSetOrder(1) )
SA1->( DbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA) )

Det_001_a_001 := "1"
Det_002_a_003 := "02"
Det_004_a_017 := Left(SM0->M0_CGC,14)
//Det_018_a_028:= Padr(Alltrim(SE1->E1_AGEDEP)+Alltrim(SE1->E1_CONTA),11," ")
Det_018_a_028 := Padr(Alltrim(MV_PAR02)+Alltrim(MV_PAR03),11," ")
Det_029_a_037 := Space(09)
Det_038_a_062 := Padr(SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA,25," ")
Det_063_a_065 := Left(MV_PAR02,3)
Det_066_a_072 := Strzero(_nFaixaAtu,7)
Det_073_a_082 := Space(10)
Det_083_a_107 := Space(25)
Det_108_a_108 := SE1->E1_SITUACA
Det_109_a_110 := "01"
Det_111_a_120 := Padr(SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA,10," ")
Det_121_a_126 := Strzero(Day(SE1->E1_VENCTO),2)+Strzero(Month(SE1->E1_VENCTO),2)+Right(Strzero(Year(SE1->E1_VENCTO),4),2)
Det_127_a_139 := Str( (SE1->E1_VALOR*100) ,13 )
Det_140_a_142 := mv_par01
Det_143_a_147 := StrZero(0,5)
Det_148_a_149 := "01"
Det_150_a_150 := "N"
Det_151_a_156 := GravaData(SE1->E1_EMISSAO,.F.)
Det_157_a_158 := "  "
Det_159_a_160 := "  "
Det_161_a_173 := Repl("9",13)    /// Str(9,13) /// Str((SE1->E1_VALOR*0.17),13)
Det_174_a_179 := Strzero(0,6)
Det_180_a_192 := Strzero(0,13)
Det_193_a_205 := Strzero(0,13)
Det_206_a_218 := Strzero(0,13)
Det_219_a_220 := If(Len(Trim(SA1->A1_CGC))<14,"01","02")
Det_221_a_234 := Strzero(Val(SA1->A1_CGC),14,0)
Det_235_a_274 := Left(SA1->A1_NOME,40)
Det_275_a_314 := Padr(ExecBlock("VCB01"),40," ")
Det_315_a_326 := Padr(ExecBlock("VCB02"),12," ")
Det_327_a_334 := Padr(ExecBlock("VCB03"),08," ")
Det_335_a_349 := Padr(ExecBlock("VCB04"),15," ")
Det_350_a_351 := Padr(ExecBlock("VCB05"),02," ")
Det_352_a_391 := Padr(ExecBlock("VCB06"),40," ")
Det_392_a_393 := Space(02)
Det_394_a_394 := Space(01)
Det_395_a_400 := _cIncrementa
//ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//º GRAVA DETALHES.               º
//ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
_aDetalhes:={}
Aadd(_aDetalhes,Det_001_a_001)
Aadd(_aDetalhes,Det_002_a_003)
Aadd(_aDetalhes,Det_004_a_017)
Aadd(_aDetalhes,Det_018_a_028)
Aadd(_aDetalhes,Det_029_a_037)
Aadd(_aDetalhes,Det_038_a_062)
Aadd(_aDetalhes,Det_063_a_065)
Aadd(_aDetalhes,Det_066_a_072)
Aadd(_aDetalhes,Det_073_a_082)
Aadd(_aDetalhes,Det_083_a_107)
Aadd(_aDetalhes,Det_108_a_108)
Aadd(_aDetalhes,Det_109_a_110)
Aadd(_aDetalhes,Det_111_a_120)
Aadd(_aDetalhes,Det_121_a_126)
Aadd(_aDetalhes,Det_127_a_139)
Aadd(_aDetalhes,Det_140_a_142)
Aadd(_aDetalhes,Det_143_a_147)
Aadd(_aDetalhes,Det_148_a_149)
Aadd(_aDetalhes,Det_150_a_150)
Aadd(_aDetalhes,Det_151_a_156)
Aadd(_aDetalhes,Det_157_a_158)
Aadd(_aDetalhes,Det_159_a_160)
Aadd(_aDetalhes,Det_161_a_173)
Aadd(_aDetalhes,Det_174_a_179)
Aadd(_aDetalhes,Det_180_a_192)
Aadd(_aDetalhes,Det_193_a_205)
Aadd(_aDetalhes,Det_206_a_218)
Aadd(_aDetalhes,Det_219_a_220)
Aadd(_aDetalhes,Det_221_a_234)
Aadd(_aDetalhes,Det_235_a_274)
Aadd(_aDetalhes,Det_275_a_314)
Aadd(_aDetalhes,Det_315_a_326)
Aadd(_aDetalhes,Det_327_a_334)
Aadd(_aDetalhes,Det_335_a_349)
Aadd(_aDetalhes,Det_350_a_351)
Aadd(_aDetalhes,Det_352_a_391)
Aadd(_aDetalhes,Det_392_a_393)
Aadd(_aDetalhes,Det_394_a_394)
Aadd(_aDetalhes,Det_395_a_400)
_cLin := ""
For _n2:= 1 to LEN(_aDetalhes)
    _cLin:=_cLin +  _aDetalhes[_n2]
Next
_cLin := _cLin + CHR(13)+CHR(10)

Return(_cLin)