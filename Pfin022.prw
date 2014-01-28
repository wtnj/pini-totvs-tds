#include "rwmake.ch" 
/*/
Danilo C S Pala 20090122: baixar liquidacao em cartorio, e nao baixar se o titulo estiver no SERASA
//Danilo  C S Pala 20090325: manter a ordem original do arquivo
//Danilo  C S Pala 20090812: ajustes mp10 e1_num char(9)
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFIN022   ³Autor: Danilo C S Pala        ³ Data:   20081218 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Le o arquivo do relatorio de retorno de cnab e baixa os    ³ ±±
±±³titulos a receber correspondentes									 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function Pfin022()      
setprvt("_aCampos, _cNome, cIndex, cKey, cArq")
setprvt("_cTitulo, _ccMens1, cMsgFinal, cFonte, mBanco, mAgencia, mConta, ndesconto, njuros, cportador, cCont, cVencto, cConsist")

_cTitulo  := "Baixa os titulos a receber do relatorio de cnab de retorno"
_ccMens1  := "Exemplo: \siga\relato\dcsp\arquivo.txt"
cMsgFinal := space(200)
   
mBanco := space(6)
mAgencia := space(5)
mConta := space(10)
cFonte	  := space(80)
ndesconto := 0
njuros := 0
cportador := space(3)
cCont := 0
Private aItens := {"Itau922","ItauBP","Bradesco","Daycoval","Mercantil","Sofisa"}

Private aCores    := {{'(ALLTRIM(FONTE->OCORREN) == "06 - LIQUIDACAO NORMAL" .OR. ALLTRIM(FONTE->OCORREN) == "08 - LIQUIDACAO EM CARTORI") .AND. (ALLTRIM(FONTE->CONSIST) == "TITULO OK")', 'ENABLE'    },;
	                {'ALLTRIM(FONTE->CONSIST) != "TITULO OK"' , 'DISABLE'   }}
Private cString :="FONTE"
cFonte := __RELDIR + space(60)
@ 010,001 TO 230,350 DIALOG oDlg TITLE _cTitulo
@ 010,005 SAY _ccMens1
@ 020,005 GET cFonte 
@ 020,156 BUTTON "..." SIZE 15,10 ACTION RunDlg()
@ 035,005 SAY "Banco"
@ 035,040 GET mBanco SIZE 20,12 valid compBanco()  F3 "SA6"
@ 050,005 SAY "Agencia"
@ 050,040 GET mAgencia SIZE 30,12
@ 065,005 SAY "Conta"
@ 065,040 GET mConta SIZE 50,12
@ 080,005 BUTTON "Processar" SIZE 40,12 ACTION Processa({||ProcArq()})
@ 080,070 BUTTON "Fechar" SIZE 40,12 ACTION ( Close(oDlg) )

Activate Dialog oDlg CENTERED                                         
return


Static Function ProcArq()
_aCampos := {  {"TITULO"  ,"C",13 ,0} ,; //era10 mp10
{"BRANCO0" ,"C",3 ,0} ,;
{"TIPO"    ,"C",4 ,0} ,; //era4 mp10
{"CLIENTE" ,"C",6 ,0} ,;
{"BRANCO1" ,"C",1 ,0} ,;
{"LOJA"    ,"C",2 ,0} ,;
{"BRANCO2" ,"C",1 ,0} ,;
{"OCORREN" ,"C",27,0} ,;
{"DTOCOR"  ,"C",8 ,0} ,;
{"BRANCO3" ,"C",3 ,0} ,;
{"VLORIG"  ,"C",11,0} ,;
{"BRANCO4" ,"C",3 ,0} ,;
{"VLRECEB" ,"C",11,0} ,;
{"BRANCO5" ,"C",3 ,0} ,;
{"DESPESA" ,"C",11,0} ,;
{"BRANCO6" ,"C",3 ,0} ,;
{"DESCONT" ,"C",11,0} ,;
{"BRANCO7" ,"C",3 ,0} ,;
{"VLABAT"  ,"C",11,0} ,;
{"BRANCO8" ,"C",2 ,0} ,;
{"JUROS"   ,"C",11,0} ,;
{"BRANCO9" ,"C",2 ,0} ,;
{"VLIOF"   ,"C",11,0} ,;
{"BRANC10" ,"C",3 ,0} ,;
{"VLOUTRO" ,"C",11,0} ,;
{"BRANC11" ,"C",1 ,0} ,;
{"DTCRED"  ,"C",8,0} ,;
{"NUMTIT"  ,"C",23 ,0} ,;
{"CONSIST" ,"C",15,0} ,;
{"ORDEM"   ,"C",8,0}}  //20090327

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"FONTE",.F.,.F.)
dbSelectArea("FONTE")

bBloco := "APPEND FROM &cFonte SDF"
APPEND FROM &cFonte SDF
MsAguarde({|| bBloco},"Apendando arquivo de etiquetas...")
MSUNLOCK()
DBGOTOP()

cConsist := space(15) //mp10
While !Eof() //20090325 DAQUI              
	cConsist := space(15) //mp10
	DBSELECTAREA("SE1")
	dbSetOrder(1)
	If dbSeek(xfilial("SE1")+FONTE->TITULO+"NF ")
		cVencto :=  DTOS(SE1->E1_VENCREA)
		if EMPTY(SE1->E1_BAIXA) //mp10
			cConsist := "TITULO OK" //baixar
		else
			cConsist := "" //titulo ja baixado
		endif //mp10
	else
		cVencto :=  "99999999"  
		cConsist := space(15) //mp10
	endif
	RecLock("FONTE", .F.)
		REPLACE ORDEM WITH cVencto  
		REPLACE CONSIST WITH cConsist //mp10
	msUnlock()   
	cCont := cCont + 1
	dbselectarea("FONTE")
	dbskip()
End 
cIndex := CriaTrab(Nil,.F.) 
cKey   := "ORDEM+VLRECEB" // "TITULO" 
Indregua("FONTE",cIndex,ckey,,,"Selecionando Registros do Arq")
DBGOTOP() //20090325 ATE DAQUI PARA INDEXAR

While !Eof()
//INDICE 1: E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
	IF ALLTRIM(FONTE->TIPO) =="NF"
		if (ALLTRIM(FONTE->OCORREN) == "06 - LIQUIDACAO NORMAL" .OR. ALLTRIM(FONTE->OCORREN) == "08 - LIQUIDACAO EM CARTORI") .AND. ALLTRIM(FONTE->CONSIST) == "TITULO OK"
			cportador := posicione("SE1",1,xfilial("SE1")+FONTE->TITULO+"NF ","E1_PORTADO") 
			IF cportador == "111"
				MsgAlert("Titulo no SERASA: PREFIXO:" + substr(FONTE->TITULO,1,3) +"  NUMERO:"+ substr(FONTE->TITULO,4,9) +"   PARCELA:"+ substr(FONTE->TITULO,13,1))
			ELSE
				if MsgYEsNo("Baixar: PREFIXO:" + substr(FONTE->TITULO,1,3) +"  NUMERO:"+ substr(FONTE->TITULO,4,9) +"   PARCELA:"+ substr(FONTE->TITULO,13,1))
					ndesconto := val(alltrim(substr(FONTE->DESCONT,1,8) + substr(FONTE->DESCONT,10,2))) /100
					njuros := val(alltrim(substr(FONTE->JUROS,1,8) + substr(FONTE->JUROS,10,2))) /100
					Baixar(substr(FONTE->TITULO,1,3), substr(FONTE->TITULO,4,9), substr(FONTE->TITULO,13,1), ndesconto, njuros)
				endif
			ENDIF
		endif
	ELSE
		RecLock("FONTE", .F.)
		dbDelete()
		msUnlock()
	ENDIF                
	dbselectarea("FONTE")
	dbskip()
End
dbSelectArea("FONTE")
DBCloseArea()
Return

Static Function compBanco()
	mBanco := SA6->A6_COD
	mAgencia := SA6->A6_AGENCIA
	mConta := SA6->A6_NUMCON
RETURN (.T.)



Static Function Baixar(prefixo, numero, parcela, desconto, juros)
Local aVetor := {}
lMsErroAuto := .F.
aVetor := {{"E1_PREFIXO"	 ,prefixo             ,Nil},;
				{"E1_NUM"		 ,numero           ,Nil},;
				{"E1_PARCELA"	 ,parcela               ,Nil},;
				{"E1_TIPO"	    ,"NF "             ,Nil},;
				{"AUTMOTBX"	    ,"NOR"             ,Nil},;
				{"AUTDTBAIXA"	 ,dDataBase         ,Nil},;
				{"AUTDTCREDITO" ,dDataBase         ,Nil},;
				{"AUTHIST"	    ,'Baixa Automatica',Nil},; 
				{"AUTBANCO"	    ,mBanco,Nil},;
				{"AUTAGENCIA"	,mAgencia,Nil},;
				{"AUTCONTA"	    ,mConta,Nil},;
				{"AUTDESCONT"	,desconto    ,Nil },;
				{"AUTJUROS"	    ,juros    ,Nil },;
				{"AUTVALREC"	,SE1->E1_SALDO ,Nil }}


// Podera informar tambem as seguintes variaveis
// AUTBANCO
// AUTAGENCIA
//AUTCONTA
//AUTDESCONT
//AUTDECRESC
//AUTACRESC
//AUTMULTA
//AUTJUROS

MSExecAuto({|x,y| fina070(x,y)},aVetor,3) //Inclusao

If lMsErroAuto
	MOSTRAERRO()
/*Else
	MsgInfo("Titulo baixado com sucesso!")*/
Endif
Return

Static Function RunDlg()
cTipo := "Arquivos de Relatorios (*.##R) | *.##R | "
cTipo := cTipo + "Todos os Arquivos (*.*) | *.* "
cFonte := cGetFile(cTipo,"Dialogo de Selecao de Arquivos")
return