#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Rfat091()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("TITULO,CDESC1,CDESC2,CDESC3,TAMANHO,LIMITE")
SetPrvt("NOMEPROG,NTIPO,CABEC1,CABEC2,CABEC3,CBCONT")
SetPrvt("CBTXT,M_PAG,ARETURN,CPERG,CSTRING,NLINHA")
SetPrvt("LEND,CCTCFO,LCFOINVAL,ADADOS,AENTRADAS,ASAIDAS")
SetPrvt("AGRUPOS,NLASTKEY,WNREL,AIMP,DDTINI,DDTFIM")
SetPrvt("CIMP,CNRLIVRO,LQBRAALIQ,LQBRACFO,NINDICE,CPICTVAL")
SetPrvt("AL,AAPURADO,IX,NTVALCONTAB,NTBASECALC,NTVALTRIB")
SetPrvt("NTISENTAS,NTOUTRAS,NTGVALCONTAB,NTGBASECALC,NTGVALTRIB,NTGISENTAS")
SetPrvt("NTGOUTRAS,NTTVALCONTAB,NTTBASECALC,NTTVALTRIB,NTTISENTAS,NTTOUTRAS")
SetPrvt("XNI,CIMPOSTO,NPOS,CCFO,NALIQUOTA,NVALCONTAB")
SetPrvt("NBASECALC,NVALTRIB,NISENTAS,NOUTRAS,NO,LQUEBRADET")
SetPrvt("LQUEBRATOT,mhora")

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � MATRAPR  � Autor � Juan Jos� Pereira     � Data � 18/06/96 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Mapa resumo dos Livros Fiscais (ICMS/IPI)                  낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � RdMake                                                     낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Titulo:="Mapa Resumo dos Livros Fiscais"
cDesc1:="Este programa ir� imprimir um mapa com resumo dos lan놹mentos,"
cDesc2:="efetuados nos Livros Fiscais conforme par긩etros informados pelo"
cDesc3:="usu쟲io."
Tamanho:='M'
Limite:=132
MHORA := TIME()
Nomeprog:="MATRAPR_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
nTipo:=18
cabec1:=''
cabec2:=''
cabec3:=''
cbCont:=0
cbtxt:=Space(10)
m_pag:=1
aReturn := { "Zebrado", 1,"Administra뇙o", 2, 2, 1, "",1 }
cPerg   :="MTRAPR"
cString :="SF3"
nLinha	:=80
lEnd	:=.f.
cCtCFO	:="XXXX"
lCFOInval:=.f.
aDados	:=Array(7)
aEntradas:={}
aSaidas	:={}
aGrupos	:={}
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica as perguntas selecionadas                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
pergunte(cperg,.F.)
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Data inicial                         �
//� mv_par02             // Data Final                           �
//� mv_par03             // Imposto a apurar ? ICMS / IPI        �
//� mv_par04             // Livro Selecionado                    �
//� mv_par05             // Quebra? Aliquota / CFO / CFO/Aliquota�
//� mv_par06             // Indice de Conversao                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Envia controle para a funcao SETPRINT                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
nLastKey:=0
wnrel:=NomeProg
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.)
nLastKey:=IIf(LastKey()==27,27,nLastKey)
If nLastKey == 27
   	Return
Endif
SetDefault(aReturn,cString)
nLastKey:=IIf(LastKey()==27,27,nLastKey)
If nLastKey == 27
   	Return
Endif
#IFDEF WINDOWS
	RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> 	RptStatus({|| Execute(RptDetail)})

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION RptDetail
Static FUNCTION RptDetail()
#ENDIF

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� carrega paramentros                                          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
aImp		:={"IC","IP"}
dDtIni		:=mv_par01
dDtFim		:=mv_par02
cImp		:=aImp[mv_par03]
cNrLivro	:=mv_par04
If cImp=="IP"
	lQbraAliq:=.F.
	lQbraCFO:=.T.
Else
	Do Case
		Case mv_par05==1 ; lQbraAliq:=.F. ; lQbraCFO:=.F.
		Case mv_par05==2 ; lQbraAliq:=.F. ; lQbraCFO:=.T.	
		Case mv_par05==3 ; lQbraAliq:=.T. ; lQbraCFO:=.T.	
	EndCase
Endif
nIndice		:=IIF(mv_par06>0,mv_par06,1)
cPictVal	:=IIF(nIndice!=1,"@E 999999999999.999","@E 999,999,999,999.99")
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define layout padrao do relatorio                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
aL:=Array(09)
aL[01]:="                                  RESUMO DOS VALORES LANCADOS DE #### NOS LIVROS FISCAIS"
aL[02]:="                                  ------------------------------------------------------"
aL[03]:="                                              PERIODO : ######## A ########"
aL[04]:="  CFO    ALIQ        VALOR CONTABIL        BASE DE CALCULO        VALOR TRIBUTADO             ISENTAS                OUTRAS"
aL[05]:=" ------ -------  ---------------------- ---------------------- ---------------------- ---------------------- ----------------------"
aL[06]:="  #########################################################"
aL[07]:="  ####   #####     ##################     ##################     ##################     ##################     ##################  "
aL[08]:="                 ---------------------- ---------------------- ---------------------- ---------------------- ----------------------"
aL[09]:="  TOTAL ######## # ##################     ##################     ##################     ##################     ##################  "
//       x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x123456789x12
//       0         10        20        30        40        50        60        70        80        90        100       110       120       130
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Apura valores dos livros fiscais                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
aApurado:=ResumeF3(cImp, dDtIni, dDtFim, cNrLivro, lQbraAliq, lQbraCFO, 2, @lEnd)
For ix:=1 to Len(aApurado)
	If mv_par05==1
		If aApurado[ix,1]!="ENTR"
			Loop 
		Endif
	Else
		If Val(Substr(aApurado[ix,1],1,1))>=5
			Loop
		Endif
	EndIf
	AADD(aEntradas,Aclone(aApurado[ix]))
Next
For ix:=1 to Len(aApurado)
	If mv_par05==1
		If aApurado[ix,1]!="SAID"
			Loop 
		Endif
	Else
		If Val(Substr(aApurado[ix,1],1,1))<5
			Loop
		Endif
	EndIf
	AADD(aSaidas,Aclone(aApurado[ix]))
Next
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Impressao                                                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
nTValContab	:=0
nTBaseCalc	:=0
nTValTrib	:=0
nTIsentas	:=0
nTOutras	:=0
nTGValContab:=0
nTGBaseCalc	:=0
nTGValTrib	:=0
nTGIsentas	:=0
nTGOutras	:=0
nTTValContab:=0
nTTBaseCalc	:=0
nTTValTrib	:=0
nTTIsentas	:=0
nTTOutras	:=0

If lQbraCFO
	AADD(aGrupos,{"1.00 - ENTRADAS E/OU AQUISICOES DE SERVICOS DO ESTADO",.T.})
	AADD(aGrupos,{"2.00 - ENTRADAS E/OU AQUISICOES DE SERVICOS DE OUTROS ESTADOS",.T.})
	AADD(aGrupos,{"3.00 - ENTRADAS E/OU AQUISICOES DE SERVICOS DO EXTERIOR",.T.})
	AADD(aGrupos,{"5.00 - SAIDAS E/OU PRESTACOES DE SERVICOS PARA O ESTADO",.T.})
	AADD(aGrupos,{"6.00 - SAIDAS E/OU PRESTACOES DE SERVICOS PARA OUTROS ESTADOS",.T.})
	AADD(aGrupos,{"7.00 - SAIDAS E/OU PRESTACOES DE SERVICOS PARA O EXTERIOR",.T.})
Else
	AADD(aGrupos,{"ENTRADAS",.T.})
	AADD(aGrupos,{"SAIDAS",.T.})
Endif	

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Imprime Entradas                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
SetRegua(Len(aEntradas)+Len(aSaidas))
For xni:=1 to Len(aEntradas)
	IncRegua()
	If Interrupcao(@lEnd)	
		Exit
	Endif
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Imprime cabecalho                                            �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If nLinha>60
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)			
		nLinha:=PROW()+1
		FmtLin(,Replic("*",132),,,@nLinha)
		nLinha:=nLinha+1
		cImposto:=IIf(cImp=="IP","IPI ","ICMS")
		FmtLin({cImposto},aL[01],,,@nLinha)
		FmtLin(,aL[02],,,@nLinha)
		nLinha:=nLinha+1
		FmtLin({DTOC(dDtIni),DTOC(dDtFim)},aL[03],,,@nLinha)
		nLinha:=nLinha+1
		FmtLin(,{aL[04],aL[05]},,,@nLinha)
	Endif
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Imprime descricao de grupo de CFOs                           �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸	
	nPos:=Ascan(aGrupos,{|X|Substr(X[1],1,1)==Substr(aEntradas[xni,1],1,1)})
	If nPos>0 .and. aGrupos[nPos,2]
		nLinha:=nLinha+1
		FmtLin({aGrupos[nPos,1]},aL[06],,,@nLinha)
		FmtLin({Replic("-",Len(aGrupos[nPos,1]))},aL[06],,,@nLinha)
		nLinha:=nLinha+1
		aGrupos[nPos,2]:=.F.
	Endif
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Detalhe                                                      �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸	
	If cImp=="IP"
		cCFO		:=aEntradas[xni,01]
		nAliquota	:=0
		If cCFO!=cCtCFO
			aDados[01]:=Substr(cCFO,1,1)+"."+Substr(cCFO,2)
			cCtCFO:=cCFO
		Endif
		If !lCFOInval
			lCFOInval:=(Substr(cCFO,4,1)=="*")
		Endif
	Else
		cCFO		:=IIF(lQbraCFO,aEntradas[xni,1],'')
		nAliquota	:=IIF(!lQbraAliq.and.lQbraCFO,0,aEntradas[xni,2])
		If !Empty(cCFO) .and. cCtCFO!=cCFO
			aDados[01]:=IIF(lQbraCFO,Substr(cCFO,1,1)+"."+Substr(cCFO,2),)
			cCtCFO:=cCFO
			If !lCFOInval
				lCFOInval:=(Substr(cCFO,4,1)=="*")
			Endif
		Endif
		aDados[02]:=IIF(!lQbraAliq.and.lQbraCFO,,Transform(nAliquota,"@E 99.99"))
	Endif

	nValContab	:=NoRound(aEntradas[xni,11]/nIndice,IIF(nIndice!=1,3,2))
	nBaseCalc	:=NoRound(aEntradas[xni,03]/nIndice,IIF(nIndice!=1,3,2))
	nValTrib	:=NoRound(aEntradas[xni,04]/nIndice,IIF(nIndice!=1,3,2))
	nIsentas	:=NoRound(aEntradas[xni,05]/nIndice,IIF(nIndice!=1,3,2))
	nOutras		:=NoRound(aEntradas[xni,06]/nIndice,IIF(nIndice!=1,3,2))

	aDados[03]:=nValContab
	aDados[04]:=nBaseCalc
	aDados[05]:=nValTrib
	aDados[06]:=nIsentas
	aDados[07]:=nOutras

	FmtLin(@aDados,aL[07],cPictVal,,@nLinha) // <= Funcao de Impressao da Linha
	//Afill(aDados,NIL)
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Acumuladores                                                 �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸		
	If Substr(cCfo,1,1)$"123567" .or. (!lQbraAliq.and.!lQbraCFO)
		nTValContab	:=nTValContab+nValContab
		nTBaseCalc	:=nTBaseCalc+nBaseCalc
		nTValTrib	:=nTValTrib+nValTrib
		nTIsentas	:=nTIsentas+nIsentas
		nTOutras	:=nTOutras+nOutras

		nTGValContab:=nTGValContab+nValContab
		nTGBaseCalc	:=nTGBaseCalc+nBaseCalc
		nTGValTrib	:=nTGValTrib+nValTrib
		nTGIsentas	:=nTGIsentas+nIsentas
		nTGOutras	:=nTGOutras+nOutras

		nTTValContab:=nTTValContab+nValContab
		nTTBaseCalc	:=nTTBaseCalc+nBaseCalc
		nTTValTrib	:=nTTValTrib+nValTrib
		nTTIsentas	:=nTTIsentas+nIsentas
		nTTOutras	:=nTTOutras+nOutras
	Endif 
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Totais                                                       �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸		
	no:=IIf(xni<Len(aEntradas),xni+1,xni)
	lQuebraDet:=.F.
	lQuebraTot:=.F.
	If !(!lQbraAliq .and. !lQbraCFO)
		
		If (xni==no .or. aEntradas[xni,1]!=aEntradas[no,1])
			lQuebraDet:=(lQbraCFO.and.lQbraAliq)
			nPos:=Ascan(aGrupos,{|X|Substr(X[1],1,1)==Substr(aEntradas[no,1],1,1)})
			If xni==no .or. (nPos>0.and.aGrupos[nPos,2])
				lQuebraTot:=.T.
			Endif
			If nPos==0
				lQuebraDet:=.F.
				lQuebraTot:=.F.
			Endif				
		EndIf
		
	EndIf 
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Sub-Totais                                                   �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸		
	If lQuebraDet .and. Substr(cCFO,1,1)$'123567'
		FmtLin(,aL[08],,,@nLinha)
		aDados[01]:=Substr(cCFO,1,1)+"."+Substr(cCFO,2)
		aDados[03]:=nTValContab
		aDados[04]:=nTBaseCalc
		aDados[05]:=nTValTrib
		aDados[06]:=nTIsentas
		aDados[07]:=nTOutras
		FmtLin(@aDados,aL[09],cPictVal,,@nLinha)
		//Afill(aDados,NIL)
		nLinha:=nLinha+1
		nTValContab:=0
		nTBaseCalc:=0
		nTValTrib:=0
		nTIsentas:=0
		nTOutras:=0
	Endif 
	If lQuebraTot .and. Substr(cCFO,1,1)$'123567'
		FmtLin(,aL[08],,,@nLinha)
		aDados[01]:=IIf(lQbraCFO,Substr(cCFO,1,1)+".00",)
		aDados[03]:=nTGValContab
		aDados[04]:=nTGBaseCalc
		aDados[05]:=nTGValTrib
		aDados[06]:=nTGIsentas
		aDados[07]:=nTGOutras
		FmtLin(@aDados,aL[09],cPictVal,,@nLinha)
		//Afill(aDados,NIL)
		nLinha:=nLinha+1
		nTGValContab:=0
		nTGBaseCalc:=0
		nTGValTrib:=0
		nTGIsentas:=0
		nTGOutras:=0
	Endif 		
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Total das Entradas                                           �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸		
	If xni==Len(aEntradas)
		FmtLin(,aL[08],,,@nLinha)
		aDados[01]:="ENTRADAS"
		aDados[03]:=nTTValContab
		aDados[04]:=nTTBaseCalc
		aDados[05]:=nTTValTrib
		aDados[06]:=nTTIsentas
		aDados[07]:=nTTOutras
		FmtLin(@aDados,aL[09],cPictVal,,@nLinha)
		//Afill(aDados,NIL)
		nLinha:=nLinha+1
	Endif
Next
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Imprime Saidas                                               �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
nTValContab	:=0
nTBaseCalc	:=0
nTValTrib	:=0
nTIsentas	:=0
nTOutras	:=0
nTGValContab:=0
nTGBaseCalc	:=0
nTGValTrib	:=0
nTGIsentas	:=0
nTGOutras	:=0
nTTValContab:=0
nTTBaseCalc	:=0
nTTValTrib	:=0
nTTIsentas	:=0
nTTOutras	:=0

For xni:=1 to Len(aSaidas)
	IncRegua()
	If Interrupcao(@lEnd)
		Exit
	Endif
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Imprime cabecalho                                            �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If nLinha>55
		cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)			
		nLinha:=PROW()+1
		FmtLin(,Replic("*",132),,,@nLinha)
		nLinha:=nLinha+1
		cImposto:=IIf(cImp=="IP","IPI ","ICMS")
		FmtLin({cImposto},aL[01],,,@nLinha)
		FmtLin(,aL[02],,,@nLinha)
		nLinha:=nLinha+1
		FmtLin({DTOC(dDtIni),DTOC(dDtFim)},aL[03],,,@nLinha)
		nLinha:=nLinha+1
		FmtLin(,{aL[04],aL[05]},,,@nLinha)
	Endif
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Imprime descricao de grupo de CFOs                           �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸	
	nPos:=Ascan(aGrupos,{|X|Substr(X[1],1,1)==Substr(aSaidas[xni,1],1,1)})
	If nPos>0 .and. aGrupos[nPos,2]
		nLinha:=nLinha+1
		FmtLin({aGrupos[nPos,1]},aL[06],,,@nLinha)
		FmtLin({Replic("-",Len(aGrupos[nPos,1]))},aL[06],,,@nLinha)
		nLinha:=nLinha+1
		aGrupos[nPos,2]:=.F.
	Endif
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Detalhe                                                      �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸	
	If cImp=="IP"
		cCFO		:=aSaidas[xni,01]
		nAliquota	:=0
		If cCFO!=cCtCFO
			aDados[01]:=Substr(cCFO,1,1)+"."+Substr(cCFO,2)
			cCtCFO:=cCFO
		Endif
		If !lCFOInval
			lCFOInval:=(Substr(cCFO,4,1)=="*")
		Endif
	Else
		cCFO		:=IIF(lQbraCFO,aSaidas[xni,1],'')
		nAliquota	:=IIF(!lQbraAliq.and.lQbraCFO,0,aSaidas[xni,2])
		If !Empty(cCFO) .and. cCtCFO!=cCFO
			aDados[01]:=IIF(lQbraCFO,Substr(cCFO,1,1)+"."+Substr(cCFO,2),)
			cCtCFO:=cCFO
			If !lCFOInval
				lCFOInval:=(Substr(cCFO,4,1)=="*")
			Endif
		Endif
		aDados[02]:=IIF(!lQbraAliq.and.lQbraCFO,,Transform(nAliquota,"@E 99.99"))
	Endif
	nValContab	:=NoRound(aSaidas[xni,11]/nIndice,IIF(nIndice!=1,3,2))
	nBaseCalc	:=NoRound(aSaidas[xni,03]/nIndice,IIF(nIndice!=1,3,2))
	nValTrib	:=NoRound(aSaidas[xni,04]/nIndice,IIF(nIndice!=1,3,2))
	nIsentas	:=NoRound(aSaidas[xni,05]/nIndice,IIF(nIndice!=1,3,2))
	nOutras		:=NoRound(aSaidas[xni,06]/nIndice,IIF(nIndice!=1,3,2))

	aDados[03]:=nValContab
	aDados[04]:=nBaseCalc
	aDados[05]:=nValTrib
	aDados[06]:=nIsentas
	aDados[07]:=nOutras

	FmtLin(@aDados,aL[07],cPictVal,,@nLinha) // <= Funcao de Impressao da Linha
	//Afill(aDados,NIL)
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Acumuladores                                                 �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸		
	If Substr(cCfo,1,1)$"123567" .or. (!lQbraAliq.and.!lQbraCFO)
		nTValContab	:=nTValContab+nValContab
		nTBaseCalc	:=nTBaseCalc+nBaseCalc
		nTValTrib	:=nTValTrib+nValTrib
		nTIsentas	:=nTIsentas+nIsentas
		nTOutras	:=nTOutras+nOutras

		nTGValContab:=nTGValContab+nValContab
		nTGBaseCalc	:=nTGBaseCalc+nBaseCalc
		nTGValTrib	:=nTGValTrib+nValTrib
		nTGIsentas	:=nTGIsentas+nIsentas
		nTGOutras	:=nTGOutras+nOutras

		nTTValContab:=nTTValContab+nValContab
		nTTBaseCalc	:=nTTBaseCalc+nBaseCalc
		nTTValTrib	:=nTTValTrib+nValTrib
		nTTIsentas	:=nTTIsentas+nIsentas
		nTTOutras	:=nTTOutras+nOutras
	Endif
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Totais                                                       �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸		
	no:=IIf(xni<Len(aSaidas),xni+1,xni)
	lQuebraDet:=.F.
	lQuebraTot:=.F.
	If !(!lQbraAliq .and. !lQbraCFO)
		If (xni==no .or. aSaidas[xni,1]!=aSaidas[no,1])
			lQuebraDet:=(lQbraCFO.and.lQbraAliq)
			nPos:=Ascan(aGrupos,{|X|Substr(X[1],1,1)==Substr(aSaidas[no,1],1,1)})
			If xni==no .or. (nPos>0.and.aGrupos[nPos,2])
				lQuebraTot:=.T.
			Endif
			If nPos==0
				lQuebraDet:=.F.
				lQuebraTot:=.F.
			Endif				
		EndIf
	EndIf
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Sub-Totais                                                   �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸		
	If lQuebraDet .and. Substr(cCFO,1,1)$'123567'
		FmtLin(,aL[08],,,@nLinha)
		aDados[01]:=Substr(cCFO,1,1)+"."+Substr(cCFO,2)
		aDados[03]:=nTValContab
		aDados[04]:=nTBaseCalc
		aDados[05]:=nTValTrib
		aDados[06]:=nTIsentas
		aDados[07]:=nTOutras
		FmtLin(@aDados,aL[09],cPictVal,,@nLinha)
		//Afill(aDados,NIL)
		nLinha:=nLinha+1
		nTValContab:=0
		nTBaseCalc:=0
		nTValTrib:=0
		nTIsentas:=0
		nTOutras:=0
	Endif
	If lQuebraTot .and. Substr(cCFO,1,1)$'123567'
		FmtLin(,aL[08],,,@nLinha)
		aDados[01]:=IIf(lQbraCFO,Substr(cCFO,1,1)+".00",)
		aDados[03]:=nTGValContab
		aDados[04]:=nTGBaseCalc
		aDados[05]:=nTGValTrib
		aDados[06]:=nTGIsentas
		aDados[07]:=nTGOutras
		FmtLin(@aDados,aL[09],cPictVal,,@nLinha)
		//Afill(aDados,NIL)
		nLinha:=nLinha+1
		nTGValContab:=0
		nTGBaseCalc:=0
		nTGValTrib:=0
		nTGIsentas:=0
		nTGOutras:=0
	Endif		
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Total das Saidas                                             �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸		
	If xni==Len(aSaidas)
		FmtLin(,aL[08],,,@nLinha)
		aDados[01]:="SAIDAS"
		aDados[03]:=nTTValContab
		aDados[04]:=nTTBaseCalc
		aDados[05]:=nTTValTrib
		aDados[06]:=nTTIsentas
		aDados[07]:=nTTOutras
		FmtLin(@aDados,aL[09],cPictVal,,@nLinha)
		//Afill(aDados,NIL)
		nLinha:=nLinha+1
	Endif
Next
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Rodape                                                       �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸		
If (Len(aEntradas)>0.or.Len(aSaidas)>0) .and. !lEnd
	If lCFOInval
		nLinha:=nLinha+2
		FmtLin(," * <- CFOS NAO CADASTRADOS NA TABELA [13] ",,,@nLinha)
		FmtLin(,"",,,@nLinha)
	EndIf
	roda(cbcont,cbtxt,tamanho)
Endif
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Spool de Impressao                                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Set Device to Screen
Set Printer to
If aReturn[5] == 1
    dbcommitAll()	
    ourspool(wnrel)
Endif

MS_FLUSH()

RETURN

