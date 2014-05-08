#include "rwmake.ch" 
/*/            
//Danilo C S Pala 20100902: configurar layout Bradesco e Mercantil
//Danilo C S Pala 20100921: configurar layout Daycoval e Real(Modelo2)
//Danilo C S Pala 20120830: Calcular valor de boleto gerado com juros e registra-lo
//Danilo C S Pala 20120910: Somar o juros calculado no caixa ao E1_SALDO
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFIN025   ³Autor: Danilo C S Pala        ³ Data:   20090422 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Le o arquivo de retorno de cnab e baixa os titulos 		 ³ ±±
±±³correspondentes                        								 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Pini                                                       ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function Pfin025()
setprvt("_aCampos, _cNome, cIndex, cKey, cArq")
setprvt("_cTitulo, _ccMens1, cMsgFinal, cFonte, mBanco, mAgencia, mConta, cportador, cCont, cVencto, cLayout")

_cTitulo  := "Baixa o cnab de retorno"
_ccMens1  := "Exemplo: \siga\cnab\arquivo.txt"
cMsgFinal := space(200)
   
mBanco := space(6)
mAgencia := space(5)
mConta := space(10)
cFonte	  := space(80)
cportador := space(3)
cLayout := space(10)
cCont := 0
Private VtpReg := space(1) //variavel valor
Private ItpReg := 0 //inicio 
Private TtpReg := 0 //tamanho
Private Vnossonum := space(9) //variavel valor
Private Inossonum := 0 //inicio 
Private Tnossonum := 0 //tamanho
Private Vvlreceb := 0 //variavel valor
Private Ivlreceb := 0 //inicio 
Private Tvlreceb := 0 //tamanho
Private Vdesconto := 0 //variavel valor
Private Idesconto := 0 //inicio 
Private Tdesconto := 0 //tamanho
Private Vjuros := 0 //variavel valor
Private Ijuros := 0 //inicio 
Private Tjuros := 0 //tamanho       
Private Vcodocor := space(2)//variavel valor
Private Icodocor := 0 //inicio 
Private Tcodocor := 0 //tamanho
Private Vtitulo := 0 //variavel valor //20100902
Private Ititulo := 0 //inicio  //20100902
Private Ttitulo := 0 //tamanho //20100902
Private VtpMod2 := "" //variavel valor //20100921
Private ItpMod2 := 0  //inicio //20100921
Private TtpMod2 := 0 //tamanho //20100921
Private Vvlboleto := 0 //variavel valor boleto //20120830
Private Ivlboleto := 0 //inicio //20120830
Private Tvlboleto := 0 //tamanho //20120830


Private aItens := {"Itau400","ItauBP","Bradesco","Daycoval","Mercantil","Safra","Sofisa","Real240","Real400","AbcBrasil","Banrisul"}

Private aCores    := {{'(ALLTRIM(FONTE->OCORREN) == "06 - LIQUIDACAO NORMAL" .OR. ALLTRIM(FONTE->OCORREN) == "08 - LIQUIDACAO EM CARTORI") .AND. (ALLTRIM(FONTE->CONSIST) == "TITULO OK")', 'ENABLE'    },;
	                {'ALLTRIM(FONTE->CONSIST) != "TITULO OK"' , 'DISABLE'   }}
Private cString :="FONTE"
cFonte := __RELDIR + space(60)
@ 010,001 TO 230,350 DIALOG oDlg TITLE _cTitulo
@ 010,005 SAY _ccMens1
@ 020,005 GET cFonte 
@ 020,156 BUTTON "..." SIZE 15,10 ACTION RunDlg()
@ 035,005 SAY "Layout"
@ 035,040 COMBOBOX cLayout ITEMS aItens SIZE 80,12
@ 050,005 SAY "Banco"
@ 050,040 GET mBanco SIZE 20,12 valid compBanco()  F3 "SA6"
@ 065,005 SAY "Agencia"
@ 065,040 GET mAgencia SIZE 30,12
@ 080,005 SAY "Conta"
@ 080,040 GET mConta SIZE 50,12
@ 095,005 BUTTON "Processar" SIZE 40,12 ACTION Processa({||ProcArq()})
@ 095,070 BUTTON "Fechar" SIZE 40,12 ACTION ( Close(oDlg) )

Activate Dialog oDlg CENTERED                                         
return


Static Function ProcArq()
_aCampos := {  {"LINHA"  ,"C",400 ,0} }
_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"FONTE",.F.,.F.)
dbSelectArea("FONTE")

bBloco := "APPEND FROM &cFonte SDF"
APPEND FROM &cFonte SDF
MsAguarde({|| bBloco},"Apendando arquivo de cnab...")
MSUNLOCK()
DBGOTOP()

if alltrim(cLayout) == "Itau400" // definir posicoes do layout
	ItpReg := 1 //inicio 
	TtpReg := 1 //tamanho
	Inossonum := 86 //inicio 
	Tnossonum := 9 //tamanho
	Idesconto := 241 //inicio 
	Tdesconto := 13 //tamanho
	Ijuros := 267 //inicio 
	Tjuros := 13 //tamanho       
	Icodocor := 109 //inicio 
	Tcodocor := 2 //tamanho
	Ivlreceb := 254 //inicio 
	Tvlreceb := 13 //tamanho
	Ivlboleto := 153 //inicio 
	Tvlboleto := 13 //tamanho
elseif alltrim(cLayout) == "Bradesco" .or. alltrim(cLayout) == "Mercantil" .or. alltrim(cLayout) == "Safra" .or. alltrim(cLayout) == "Daycoval" .or. alltrim(cLayout) == "Real400" .or. alltrim(cLayout) == "AbcBrasil"
	ItpReg := 1 //inicio 
	TtpReg := 1 //tamanho
	//Inossonum := 86 //inicio 
	//Tnossonum := 9 //tamanho
	Ivlreceb := 254 //inicio 
	Tvlreceb := 13 //tamanho
	Idesconto := 241 //inicio 
	Tdesconto := 13 //tamanho
	Ijuros := 267 //inicio 
	Tjuros := 13 //tamanho       
	Icodocor := 109 //inicio 
	Tcodocor := 2 //tamanho
	Ititulo := 117 //inicio //20100902
	Ttitulo := 10 //tamanho //20100902
elseif alltrim(cLayout) == "Real240"
	//T
	ItpReg := 8 //inicio 
	TtpReg := 1 //tamanho
	ItpMod2 :=14 //inicio
	TtpMod2 :=1 //tamanho
	Ititulo := 59 //inicio 
	Ttitulo := 15 //tamanho 
	Icodocor := 16 //inicio 
	Tcodocor := 2 //tamanho
	//U
	Ivlreceb := 78 //inicio  //valor nominal do titulo
	Tvlreceb := 15 //tamanho   
	Idesconto := 33 //inicio 
	Tdesconto := 15 //tamanho
	Ijuros := 18 //inicio 
	Tjuros := 15 //tamanho       
elseif alltrim(cLayout) == "Banrisul"
	ItpReg := 1 //inicio 
	TtpReg := 1 //tamanho
	Inossonum := 117 //inicio 
	Tnossonum := 10 //tamanho
	Idesconto := 241 //inicio 
	Tdesconto := 13 //tamanho
	Ijuros := 267 //inicio 
	Tjuros := 13 //tamanho       
	Icodocor := 109 //inicio 
	Tcodocor := 2 //tamanho
	Ivlreceb := 254 //inicio 
	Tvlreceb := 13 //tamanho
	Ivlboleto := 153 //inicio 
	Tvlboleto := 13 //tamanho   
	
else
 	msgstop("layout ainda nao desenvolvido para esta rotina")
 	return
endif

While !Eof()             
	VtpReg := substr(FONTE->LINHA, ItpReg, TtpReg)
	Vcodocor := substr(FONTE->LINHA, Icodocor,Tcodocor)
	Vtitulo := substr(FONTE->LINHA, Ititulo,Ttitulo) //20100902
	VtpMod2 := substr(FONTE->LINHA, ItpMod2,TtpMod2)
	if alltrim(cLayout) <> "Real240"
		Vnossonum := substr(FONTE->LINHA, Inossonum,Tnossonum)
		Vvlreceb := VAL(substr(FONTE->LINHA, Ivlreceb, Tvlreceb))/100
		Vdesconto := VAL(substr(FONTE->LINHA, Idesconto, Tdesconto))/100
		Vjuros := VAL(substr(FONTE->LINHA, Ijuros, Tjuros))/100
		Vvlboleto := VAL(substr(FONTE->LINHA, Ivlboleto, Tvlboleto))/100 //20120830
	endIf
	      
	if VtpReg == "1" .and. alltrim(cLayout) <> "Real240"//registro detalhe    
		If alltrim(cLayout) == "Itau400" //20100902
			if Vcodocor == "06" .or. Vcodocor == "08"//liquidacao normal //liquidacao em cartorio
				DBSELECTAREA("SE1")
				DbOrderNickName("E1_NUMBCO")  // dbSetOrder(25) 20130226 //nossonumero E1_FILIAL+E1_NUMBCO+E1_PORTADO //mp10 era 18 //20100413 dbSetOrder(24) 
				If dbSeek(xfilial("SE1")+Vnossonum)
					IF SE1->E1_PORTADO == "111"
						MsgAlert("Titulo no SERASA: PREFIXO:" + SE1->E1_PREFIXO +"  NUMERO:"+ SE1->E1_NUM +"   PARCELA:"+ SE1->E1_PARCELA)
					ELSE
						if MsgYEsNo("Baixar: PREFIXO:" + SE1->E1_PREFIXO +"  NUMERO:"+ SE1->E1_NUM +"   PARCELA:"+ SE1->E1_PARCELA)
							if Vvlboleto > SE1->E1_SALDO //20120830 daqui boleto gerado com juros somado ao valor principal
								Vjuros := Vvlboleto - SE1->E1_SALDO
								Vvlreceb := Vvlboleto
							else
								Vvlreceb := SE1->E1_SALDO + Vjuros //complementar com juros 20120910
							endif  //20120830 ate aqui
		
							Baixar(SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, Vdesconto, Vjuros, Vvlreceb) //20120830
						endif  
					ENDIF
				Else
					MsgAlert("Titulo nao localizado: Nossonumero: " + Vnossonum +"  Valor:"+ alltrim(str(Vvlreceb,10,2)))
				endif
				
				//Tratado por Douglas Silva 04/04/2014 para tratar as baixas do Banrisul
				DBSELECTAREA("SE1")
				DbOrderNickName("E1_IDCNAB")  // dbSetOrder(25) 20130226 //nossonumero E1_FILIAL+E1_NUMBCO+E1_PORTADO //mp10 era 18 //20100413 dbSetOrder(24) 
				If dbSeek(xfilial("SE1")+Vnossonum)
					IF SE1->E1_PORTADO == "111"
						MsgAlert("Titulo no SERASA: PREFIXO:" + SE1->E1_PREFIXO +"  NUMERO:"+ SE1->E1_NUM +"   PARCELA:"+ SE1->E1_PARCELA)
					ELSE
						if MsgYEsNo("Baixar: PREFIXO:" + SE1->E1_PREFIXO +"  NUMERO:"+ SE1->E1_NUM +"   PARCELA:"+ SE1->E1_PARCELA)
							if Vvlboleto > SE1->E1_SALDO //20120830 daqui boleto gerado com juros somado ao valor principal
								Vjuros := Vvlboleto - SE1->E1_SALDO
								Vvlreceb := Vvlboleto
							else
								Vvlreceb := SE1->E1_SALDO + Vjuros //complementar com juros 20120910
							endif  //20120830 ate aqui
		
							Baixar(SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, Vdesconto, Vjuros, Vvlreceb) //20120830
						endif  
					ENDIF
				Else
					MsgAlert("Titulo nao localizado: Nossonumero: " + Vnossonum +"  Valor:"+ alltrim(str(Vvlreceb,10,2)))
				endif
				
			endif
		ElseIf alltrim(cLayout) == "Bradesco" .or. alltrim(cLayout) == "Mercantil"  .or. alltrim(cLayout) == "Safra" .or. alltrim(cLayout) == "Daycoval" .or. alltrim(cLayout) == "Real400" .or. alltrim(cLayout) == "AbcBrasil"//20100902
			if Vcodocor == "06" .or. (Vcodocor == "15" .and. alltrim(cLayout) <> "Real400") .or. (Vcodocor == "08" .and. alltrim(cLayout) <> "Real400") //liquidacao normal //liquidacao em cartorio
				DBSELECTAREA("SE1")
				dbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUMERO+E1_PARCELA+E1_TIPO    1234567890    12345678901234567
				//SE1->E1_PREFIXO+ALLTRIM(SE1->E1_NUM)+SE1->E1_PARCELA               PUB123456A    PUB123456789ATIPO
				If dbSeek(xfilial("SE1")+substr(Vtitulo,1,9)+space(3)+substr(Vtitulo,10,1)+"NF")
					IF SE1->E1_PORTADO == "111"
						MsgAlert("Titulo no SERASA: PREFIXO:" + SE1->E1_PREFIXO +"  NUMERO:"+ SE1->E1_NUM +"   PARCELA:"+ SE1->E1_PARCELA)
					ELSE
						if MsgYEsNo("Baixar: PREFIXO:" + SE1->E1_PREFIXO +"  NUMERO:"+ SE1->E1_NUM +"   PARCELA:"+ SE1->E1_PARCELA)
							Vvlreceb := SE1->E1_SALDO + Vjuros //complementar com juros 20120910 //20120830
							Baixar(SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, Vdesconto, Vjuros, Vvlreceb)
						endif  
					ENDIF
				else
					MsgAlert("Titulo nao localizado: Titulo: " + Vtitulo +"  Valor:"+ alltrim(str(Vvlreceb,10,2)))
				endif
			endif
		EndIf        
	Elseif VtpReg == "3" .and. alltrim(cLayout) == "Real240"
		If VtpMod2 == "T"
			dbselectarea("FONTE")
			dbskip() //vai para VtpMod2="U"
			Vvlreceb := VAL(substr(FONTE->LINHA, Ivlreceb, Tvlreceb))/100
			Vdesconto := VAL(substr(FONTE->LINHA, Idesconto, Tdesconto))/100
			Vjuros := VAL(substr(FONTE->LINHA, Ijuros, Tjuros))/100
			if Vcodocor == "06" //liquidacao normal //baixa
				DBSELECTAREA("SE1")
				dbSetOrder(1) //E1_FILIAL+E1_PREFIXO+E1_NUMERO+E1_PARCELA+E1_TIPO    1234567890123    12345678901234567890123
				//SE1->E1_PREFIXO+ALLTRIM(SE1->E1_NUM)+SE1->E1_PARCELA               PUB123456   A    PUB123456789   ATIPO
				If dbSeek(xfilial("SE1")+substr(Vtitulo,1,9)+space(3)+substr(Vtitulo,13,1)+"NF")
					IF SE1->E1_PORTADO == "111"
						MsgAlert("Titulo no SERASA: PREFIXO:" + SE1->E1_PREFIXO +"  NUMERO:"+ SE1->E1_NUM +"   PARCELA:"+ SE1->E1_PARCELA)
					ELSE
						if MsgYEsNo("Baixar: PREFIXO:" + SE1->E1_PREFIXO +"  NUMERO:"+ SE1->E1_NUM +"   PARCELA:"+ SE1->E1_PARCELA)
							Vvlreceb := SE1->E1_SALDO + Vjuros //complementar com juros 20120910  //20120830
							Baixar(SE1->E1_PREFIXO, SE1->E1_NUM, SE1->E1_PARCELA, Vdesconto, Vjuros, Vvlreceb)
						endif  
					ENDIF
				else
					MsgAlert("Titulo nao localizado: Titulo: " + Vtitulo +"  Valor:"+ alltrim(str(Vvlreceb,10,2)))
				endif
			endif    
		EndIf
	endif
	cCont := cCont + 1
	dbselectarea("FONTE")
	dbskip()
End 

DbSelectArea("FONTE")
DBCloseArea()
Return


Static Function compBanco()
	mBanco := SA6->A6_COD
	mAgencia := SA6->A6_AGENCIA
	mConta := SA6->A6_NUMCON
RETURN (.T.)



Static Function Baixar(prefixo, numero, parcela, desconto, juros, recebido)
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
				{"AUTVALREC"	,recebido ,Nil }}


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
cTipo := "Arquivos de Relatorios (*.RET) | *.RET | "
cTipo := cTipo + "Todos os Arquivos (*.*) | *.* "
cFonte := cGetFile(cTipo,"Dialogo de Selecao de Arquivos")
return
