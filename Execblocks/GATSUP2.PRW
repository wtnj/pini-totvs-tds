#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 07/05/02
/*     20031015
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ GATSUP2    ³ Autor ³Gilberto A. de Oliveira³ Data ³ 21.08.00  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³De acordo com o produto informado, gera linhas de suporte,     ³±±
±±³          ³informatico.                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GATSUP2()        // incluido pelo assistente de conversao do AP5 IDE em 07/05/02

SetPrvt("_LCONTINUA,_NPOSDOEDINIC,_NPOSDOEDFIN,_CSUP,_CPROD,_APOSARQ")
SetPrvt("_NVEZ,_ASUPINF,_CPRODUTO,_NLINHA_DA_ACOLS,_NUMITEM,X1")
SetPrvt("_CCHAVESB1,_NITEM_SUPORTE,_MATRIZNEW,_N,ACOLS,_CAREA")
SetPrvt("_NORDEM,_NRECNO,_CCF,")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ caso nao exista produto na primeira linha da acols.  ³
//³ ou nao existirem elementos na acols, retorna.        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_lContinua       := .T.
_nPosdoEdInic:= Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_EDINIC"})
_nPosdoEdFin := Ascan( aHeader,{|x| UPPER(Alltrim(x[2]))=="C6_EDFIN"})
_cSup        := aCols[n,aScan(aHeader ,{|x| Upper(AllTrim(x[2]))=="C6_SUP" })]

If Empty( aCols[1,aScan(aHeader ,{|x| Upper(AllTrim(x[2]))=="C6_PRODUTO" })])
	_lContinua:= .F.
EndIf

If Len(aCols) == 0
	_lContinua:= .F.
EndIf

if aCols[n,aScan(aHeader ,{|x| Upper(AllTrim(x[2]))=="C6_SUP" })] =="N"
	_lContinua:= .F.
endif

If _lContinua
	
	// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	// ³ Salva o Ambiente.                   ³
	// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	_aPosArq:= { {Alias(),0,0}, {"SC5",0,0}, {"SC6",0,0}, {"SB1",0,0} }
	For _nVez := 1 to Len(_aPosArq)
		dbSelectArea( _aPosArq[_nVez,1] )
		_aPosArq[_nVez,2] := IndexOrd()
		_aPosArq[_nVez,3] := Recno()
	Next
	
	// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	// ³ Inicio do codigo principal          ³
	// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	_aSupInf        := {}
	_cProduto       := SPACE(15)
	_nLinha_da_Acols:= n
	_NumItem        := STR( LEN(aCols) )
	_cProduto       := aCols[_nLinha_da_Acols,aScan(aHeader ,{|x| Upper(AllTrim(x[2]))=="C6_PRODUTO" })]
	
	If aCols[ _nLinha_da_Acols , Len(aCols[_nLinha_da_Acols]) ] == .F.
		If SB1->B1_TIPO  $  "SW;TM"
			For x1:=1 to 4
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ monta chave e verifica a existencia do suporte informatico  ³
				//³ no cadastro de produtos.                                    ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If alltrim(_cProduto)== "0701063" //20110429
					_cChaveSB1 := "0701066"
				Else
					_cChaveSB1:= "3800"+strzero(x1,3)
				Endif
				_cChaveSB1:= PADR(_cChaveSB1,38)
				SB1->( DbSeek(xFilial("SB1")+_cChaveSB1 ) )
				SF4->( DbSeek(xfilial("SF4")+SB1->B1_TS ) )  //   "802" ) )
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ caso o produto exista no b1.                       ³
				//³ caso o suporte ainda nao faca parte da acols.      ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				IF SB1->( FOUND() )
					_nItem_Suporte:= ASCAN(aCols,{|x| Upper(AllTrim(x[2]))==ALLTRIM(_cChaveSB1)})
					If _nItem_Suporte==0
						GERAACOLS()
					Else
					EndIf
				ENDIF
			Next
		Endif
	EndIf
	// ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	// ³ Retorna Alias Original              ³
	// ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For _nVez := 2 to Len(_aPosArq)
		dbSelectArea(_aPosArq[_nVez,1])
		dbSetOrder(_aPosArq[_nVez,2])
		dbGoTo(_aPosArq[_nVez,3])
	Next
	dbSelectArea(_aPosArq[1,1])
	dbSetOrder(_aPosArq[1,2])
	dbGoTo(_aPosArq[1,3])
EndIf
//Return(_cProd)        // incluido pelo assistente de conversao do AP5 IDE em 07/05/02

Return(_cSup)        // incluido pelo assistente de conversao do AP5 IDE em 07/05/02

Static FUNCTION GERAACOLS()

_MatrizNew:= {}
For _n:=1 to Len( aCols[_nLinha_da_Acols] )
	Aadd( _MatrizNew , aCols[_nLinha_da_Acols, _n])
Next _n

If Len(_MatrizNew) > 0
	
	Aadd(aCols,_MatrizNew)
	_NumItem := StrZero(Val(_NumItem)+1,2)
	aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_ITEM"})]   := _NumItem
	aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_QTDVEN"})] := 1
	aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_PRODUTO"})]:= SB1->B1_COD
	aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_DESCRI"})] := SB1->B1_DESC
	aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_CODISS"})] := SB1->B1_CODISS //20031015
	if x1==2        
	   aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_VALOR"})]  := (SB1->B1_PRV1)
	   aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_PRCVEN"})] := (SB1->B1_PRV1)
	   //	aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_VALOR"})]  := (SB1->B1_UPRC/10)
	   //aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_PRCVEN"})] := (SB1->B1_UPRC/10)
	else     
       aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_VALOR"})]  := (SB1->B1_PRV1)
	   aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_PRCVEN"})] := (SB1->B1_PRV1)
	   //	aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_VALOR"})]  := SB1->B1_UPRC    // B1_PRV1
	  //	aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_PRCVEN"})] := SB1->B1_UPRC     // B1_PRV1
	endif
	
	_cArea:= Alias()
	
	DbSelectArea("SA1")
	_nOrdem:= IndexOrd()
	_nRecno:= Recno()
	DbSetOrder(1)
	DbSeek(xFilial("SA1")+M->C5_CLIENTE+M->C5_LOJACLI)
	_cCF:= AllTrim(SF4->F4_CF)
	
	If SA1->A1_EST == "SP" 
		_cCF:= '5'+SUBSTR(_cCF,2,3)
	ElseIf SA1->A1_EST=="EX"
		_cCF:='7'+SUBSTR(_cCF,2,3)
	ElseIf SA1->A1_EST <> "SP" .And. SA1->A1_EST<>"EX"  //20050926
		_cCF:='6'+SUBSTR(_cCF,2,3)
	EndIf
	
	DbSetOrder(_nOrdem)
	DbGoto(_nRecno)
	DbSelectArea(_cArea)
	aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_TES"})]:= SB1->B1_TS
	aCols[Len(aCols),aScan(aHeader,{|x| Upper(AllTrim(x[2]))=="C6_CF"})] := _cCF
	aCols[Len(aCols),_nPosdoEdInic] := 9999
	aCols[Len(aCols),_nPosdoEdFin ] := 9999
Endif

Return