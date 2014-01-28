#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/06/02

User Function PFAT400()        // incluido pelo assistente de conversao do AP5 IDE em 13/06/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CALIAS,_NRECNO,_NORDER,_CPERG,_ACRA,_CSAVSCR1")
SetPrvt("_CSAVCUR1,_CSAVROW1,_CSAVCOL1,_CSAVCOR1,_LEMFRENTE,NOPCA")
SetPrvt("_CMSG,_SALIAS,_AREGS,I,J,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ PFAT400  ³ Autor ³ Alex Egydio (Original)³ Data ³ 25.05.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Pergunte do Boleto Itau quando chamado do MENU             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Especifico (SEAL)                                          ³±±
±±³ Uso      ³ Especifico (PINI) - Autor: Gilberto - Data: 17/10/2000     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ROTINAS RELACIONADAS                                                   ³±±
±±³                                                                       ³±±
±±³PFAT200       - PRINCIPAL                                              ³±±
±±³ PFAT200A     - LOOP                                                   ³±±
±±³  A200DET     - PREPARA DADOS DO ARQUIVO TEXTO.                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Revis„o  ³                                          ³ Data ³          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

_cAlias:= Alias()
_nRecno:= Recno()
_nOrder:= IndexOrd()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis PRIVADAS BASICAS                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_cPerg := "ITAUBO"
_ValidPerg()
Pergunte(_cPerg,.T.)

#IFNDEF WINDOWS

    _aCRA:= { "Parametros","Confirma","Redigita","Abandona" }
    
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Salva a Integridade dos dados de Entrada                     ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//    _cSavScr1 := SaveScreen(3,0,24,79)
    _cSavCur1 := SetCursor(0)
    _cSavRow1 := Row()
    _cSavCol1 := COL()
    _cSavCor1 := SetColor("bg+/b,,,")
    _lEmFrente:= .T.

    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Monta Tela Inicial Do Programa                               ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

    DispBegin()
 //   ScreenDraw("SMT250", 3, 0, 0, 0)
    @ 03,01 Say "Boleto - Itau                          " Color "b/w"
    SetColor("n/w,,,")
    @ 17,05 SAY Space(71) Color "b/w"
    DispEnd()
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Descricao generica do programa                               ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	SetColor("b/bg")
	@ 10,05 Say "Este programa tem como objetivo gerar o arquivo"
	@ 12,05 Say "de boletos itau para impressao.                " 
	While .T.
		   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		   //³ Verifica as perguntas selecionadas                           ³
		   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
           Pergunte(_cPerg,.F.)
           nOpcA:=menuh(_aCRA,17,6,"b/w,w+/n,r/w","PCRA","",1)
		   @ 17,05 SAY Space(71) Color "b/w"
           If nOpcA == 1
              Pergunte(_cPerg,.T.)
              Loop
		   ElseIf nOpcA == 3
              Loop
           ElseIf nOpcA == 4
              _lEmFrente:= .F.
		   Endif
           Exit
	Enddo

    Inkey()

    If mv_par01 #"341" .And. _lEmFrente
       _cMsg := "O Banco deve obrigatoriamente ser o 341 - Itau. Favor Verificar !!!"
       Alert(_cMsg)
       _lEmFrente:= .F.
    EndIf

    If Alltrim(mv_par02) #"0585" .And. _lEmFrente
       _cMsg := "A agˆncia deve obrigatoriamente ser 0585.  Favor Verificar !!!"
       Alert(_cMsg)
       _lEmFrente:= .F.
    Endif

	//20040106 conta da editora e da bp
	
	if SM0->M0_CODIGO = "01"   
		If !(Alltrim(mv_par03) $ "92273-5") .And. _lEmFrente
    	   _cMsg := "A conta deve obrigatoriamente ser 92273-5. Favor Verificar !!!"
        	Alert(_cMsg)
	       _lEmFrente:= .F.
	    Endif
	elseif SM0->M0_CODIGO = "03"
	    If !(Alltrim(mv_par03) $ "40659-8") .And. _lEmFrente
    	   _cMsg := "A conta deve obrigatoriamente ser 40659-8. Favor Verificar !!!"
        	Alert(_cMsg)
	       _lEmFrente:= .F.
	    Endif
	endif

    If !Alltrim(mv_par04) $ "109/175" .And. _lEmFrente
       _cMsg := "A carteira deve obrigatoriamente ser 109 ou 175. Favor Verificar !!!"
       Alert(_cMsg)
       _lEmFrente:= .F.
    EndIf

    If  nOpcA==2 .And. _lEmFrente
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Gera arq. para impressao do Boleto Itau                      ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        ExecBlock('PFAT400A',.F.,.F., MV_PAR07 )
	Endif

    RestScreen(3,0,24,79,_cSavScr1)
    SetCursor(_cSavCur1)
    DevPos(_cSavRow1,_cSavCol1)
    SetColor(_cSavCor1)

#ELSE

    Pergunte(_cPerg,.F.)

    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Monta Tela Inicial Do Programa                               ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    @ 96,42 TO 323,505 DIALOG oDlg TITLE "Boleto - Itau"
    @ 8,10 TO 84,222
    @ 91,136 BMPBUTTON TYPE 5 ACTION Pergunte(_cPerg,.T.)
    @ 91,166 BMPBUTTON TYPE 1 ACTION OkProc()// Substituido pelo assistente de conversao do AP5 IDE em 13/06/02 ==>     @ 91,166 BMPBUTTON TYPE 1 ACTION Execute(OkProc)
    @ 91,196 BMPBUTTON TYPE 2 ACTION Close(oDlg)

    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Descricao generica do programa                               ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    @ 23,14 SAY "Este programa tem como objetivo gerar o arquivo"
    @ 33,14 SAY "de boletos itau para impressao."
    ACTIVATE DIALOG oDlg CENTERED

    Return

// Substituido pelo assistente de conversao do AP5 IDE em 13/06/02 ==>     Function OkProc
Static Function OkProc()
            Pergunte(_cPerg,.F.)
            Close(oDlg)
            Processa( {|| RunProc() } )// Substituido pelo assistente de conversao do AP5 IDE em 13/06/02 ==>             Processa( {|| Execute(RunProc) } )
    Return

// Substituido pelo assistente de conversao do AP5 IDE em 13/06/02 ==>     Function RunProc
Static Function RunProc()

             If mv_par01 #"341"
                _cMsg := OemToAnsi('O Banco deve obrigatoriamente ser o 341 - Itau. Favor Verificar !!!')
                MsgBox(_cMsg,"* * * ATENCAO * * *","STOP")
                Return
             EndIf
             If Alltrim(mv_par02) #"0585"
                _cMsg := OemToAnsi("A agˆncia deve obrigatoriamente ser 0585.  Favor Verificar !!!")
                MsgBox(_cMsg,"* * * ATENCAO * * *","STOP")
                Return
             Endif    
             
            if SM0->M0_CODIGO = "01"   
				If !(Alltrim(mv_par03) $ "92273-5") .And. _lEmFrente
    	   		_cMsg := "A conta deve obrigatoriamente ser 92273-5. Favor Verificar !!!"
        		Alert(_cMsg)
	       		_lEmFrente:= .F.
	    		Endif
			elseif SM0->M0_CODIGO = "03"
            	If !(Alltrim(mv_par03) $ "40659-8")
                	_cMsg := OemToAnsi("A conta deve obrigatoriamente ser 40659-8. Favor Verificar !!!")
	                MsgBox(_cMsg,"* * * ATENCAO * * *","STOP")
    	            Return
        	     Endif
			endif
             If !Alltrim(mv_par04) $ "109/175"
                _cMsg := OemToAnsi("A carteira deve obrigatoriamente ser 109 ou 175. Favor Verificar !!!")
                MsgBox(_cMsg,"* * * ATENCAO * * *","STOP" )
                Return
             EndIf

             //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
             //³ Gera arq. para impressao do Boleto Itau                      ³
             //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
              ExecBlock('PFAT400A',.F.,.F., MV_PAR07)

#ENDIF

DbSelectArea(_cAlias)
DbSetOrder(_nOrder)
DbGoto(_nRecno)
Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³_ValidPerg³ Autor ³  Luiz Carlos Vieira   ³ Data ³ 18/11/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica as perguntas inclu¡ndo-as caso n„o existam        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Espec¡fico para clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 13/06/02 ==> Function _ValidPerg
Static Function _ValidPerg()

_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
_cPerg    := PADR(_cPerg,10) //mp10 x1_grupo char(10)
_aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
Aadd(_aRegs,{_cPerg,"01","Banco             ?","mv_ch1","C",03,0,0,"G","","mv_par01","","","","","","","","","","","","","","","SA6"})
Aadd(_aRegs,{_cPerg,"02","Agencia           ?","mv_ch2","C",05,0,0,"G","","mv_par02","","","","","","","","","","","","","",""})
Aadd(_aRegs,{_cPerg,"03","Conta             ?","mv_ch3","C",10,0,0,"G","","mv_par03","","","","","","","","","","","","","",""})
Aadd(_aRegs,{_cPerg,"04","Carteira          ?","mv_ch4","C",06,0,0,"G","","mv_par04","","","","","","","","","","","","","",""})
Aadd(_aRegs,{_cPerg,"05","Da Nota Fiscal    ?","mv_ch5","C",09,0,0,"G","","mv_par05","","","","","","","","","","","","","",""})
Aadd(_aRegs,{_cPerg,"06","Ate Nota Fiscal   ?","mv_ch6","C",09,0,0,"G","","mv_par06","","","","","","","","","","","","","",""})
Aadd(_aRegs,{_cPerg,"07","Serie             ?","mv_ch7","C",03,0,0,"G","","mv_par07","","","","","","","","","","","","","",""})
Aadd(_aRegs,{_cPerg,"08","Juros/Dia         ?","mv_ch8","N",05,2,0,"G","","mv_par08","","","","","","","","","","","","","",""})
Aadd(_aRegs,{_cPerg,"09","Desconto          ?","mv_ch9","N",10,2,0,"G","","mv_par09","","","","","","","","","","","","","",""})
Aadd(_aRegs,{_cPerg,"10","Parcelas          ?","mv_chA","C",10,0,0,"G","","mv_par10","","","","","","","","","","","","","",""})
Aadd(_aRegs,{_cPerg,"11","Dias p/Recebimento?","mv_chB","N",02,0,0,"G","","mv_par11","","","","","","","","","","","","","",""})
Aadd(_aRegs,{_cPerg,"12","Vencimento de     ?","mv_chC","D",02,0,0,"G","","mv_par12","","","","","","","","","","","","","",""})
Aadd(_aRegs,{_cPerg,"13","Vencimento Ate    ?","mv_chC","D",02,0,0,"G","","mv_par13","","","","","","","","","","","","","",""})

For i:=1 to Len(_aRegs)
    If !dbSeek(_cPerg+_aRegs[i,2])
       RecLock("SX1",.T.)
       For j:=1 to FCount()
           If j <= Len(_aRegs[i])
               FieldPut(j,_aRegs[i,j])
           Endif
       Next
       MsUnlock()
	Endif
Next

dbSelectArea(_sAlias)

Return


