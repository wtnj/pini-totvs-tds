#include "rwmake.ch" 
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFIN024   ³Autor: Danilo C S Pala        ³ Data:   20090212 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: baixar os titulos do portador 955                          ³ ±±
±±³                                    									 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Pini														 ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function Pfin024()
setprvt("_aCampos, _cNome, cIndex, cKey, cArq")
setprvt("_cTitulo, _ccMens1, cMsgFinal, cFonte, mBanco, mAgencia, mConta, ndesconto, njuros, cportador")
Private cCodPort := "955"
Private dDoVencto := ddatabase
Private dAteVencto := ddatabase

_cTitulo  := "Baixa do portador 955"
cMsgFinal := space(200)
   
mBanco := space(6)
mAgencia := space(5)
mConta := space(10)
cFonte	  := space(80)
ndesconto := 0
njuros := 0
cportador := space(3)

cFonte := __RELDIR + space(60)
@ 010,001 TO 430,350 DIALOG oDlg TITLE _cTitulo
@ 010,005 SAY _cTitulo                                     
@ 035,005 SAY "Portador"
@ 035,040 GET cCodPort SIZE 20,12
@ 050,005 SAY "Do vencto"
@ 050,040 GET dDoVencto
@ 065,005 SAY "Ate vencto"
@ 065,040 GET dAteVencto
@ 080,005 SAY "Banco"
@ 080,040 GET mBanco SIZE 20,12 valid compBanco()  F3 "SA6"
@ 095,005 SAY "Agencia"
@ 095,040 GET mAgencia SIZE 30,12
@ 110,005 SAY "Conta"
@ 110,040 GET mConta SIZE 50,12
@ 125,005 BUTTON "Processar" SIZE 40,12 ACTION Processa({||ProcArq()})
@ 125,070 BUTTON "Fechar" SIZE 40,12 ACTION ( Close(oDlg) )

Activate Dialog oDlg CENTERED                                         
return


Static Function ProcArq()               
Private cQuery := space(200)
Private cString := "PFIN024"
//e1_vencrea>'20080630' and e1_vencrea<='20090212'
cQuery := "select E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO from se1010 where e1_filial='"+xfilial("SE1")+"' and e1_baixa='        ' and e1_portado='"+ cCodPort +"' and d_e_l_e_t_<>'*' and e1_vencrea>'"+ dtos(dDoVencto) +"' and e1_vencrea<='"+ dtos(dAteVencto) +"' and e1_saldo >0"

DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cString, .F., .T.)
dbSelectArea(cString)
dbGoTop()       

While !Eof()
	//INDICE 1: E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
	cportador := posicione("SE1",1,xfilial("SE1")+PFIN024->E1_PREFIXO+PFIN024->E1_NUM+PFIN024->E1_PARCELA+PFIN024->E1_TIPO,"E1_PORTADO") 
	IF cportador == "955"
		Baixar(PFIN024->E1_PREFIXO, PFIN024->E1_NUM, PFIN024->E1_PARCELA, PFIN024->E1_TIPO, ndesconto, njuros)
	ENDIF
	dbselectarea(cString)
	dbskip()
End
dbSelectArea(cString)
DBCloseArea()
Return

Static Function compBanco()
	mBanco := SA6->A6_COD
	mAgencia := SA6->A6_AGENCIA
	mConta := SA6->A6_NUMCON
RETURN (.T.)



Static Function Baixar(prefixo, numero, parcela, tipo, desconto, juros)
Local aVetor := {}
lMsErroAuto := .F.
aVetor := {{"E1_PREFIXO"	 ,prefixo             ,Nil},;
				{"E1_NUM"		 ,numero           ,Nil},;
				{"E1_PARCELA"	 ,parcela               ,Nil},;
				{"E1_TIPO"	    ,tipo             ,Nil},;
				{"AUTMOTBX"	    ,"NOR"             ,Nil},;
				{"AUTDTBAIXA"	 ,dDataBase         ,Nil},;
				{"AUTDTCREDITO" ,dDataBase         ,Nil},;
				{"AUTHIST"	    ,'ASSINATURAS/CONTENT STUFF',Nil},; 
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