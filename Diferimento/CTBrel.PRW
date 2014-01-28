#include "rwmake.ch"  
user function CTBREL()
CPERG := "CTBDIF"
ValidPerg()
pergunte(CPERG,.f.)
@ 96,42 TO 323,505 DIALOG oDlg TITLE "Contabilizacao de Relatorios"
@ 8,10 TO 84,222
@ 91,139 BMPBUTTON TYPE 5 ACTION Pergunte(CPERG)
@ 91,168 BMPBUTTON TYPE 1 ACTION OkProc()
@ 91,196 BMPBUTTON TYPE 2 ACTION Close(oDlg)
@ 23,14 SAY "Este programa ira contabilizar os pedidos de Assinaturas"
@ 33,14 SAY "de Relatorios."
@ 43,14 SAY ""
@ 53,14 SAY ""
ACTIVATE DIALOG oDlg
Return nil                                                                      

Static Function OkProc()
Close(oDlg)
Processa({||PegaDados()})
if mv_par03 == 1
	Processa({||Contabiliza()})
endif
report()
dbselectarea("trb")
dbclosearea("trb")

Return
***************************
Static Function PegaDados()
aCampos := {}
Aadd(aCampos,{ "PEDIDO"  ,"C", 06, 0 } )  
Aadd(aCampos,{ "EMISSAO" ,"D", 08, 0 } )  
Aadd(aCampos,{ "VALOR"   ,"N", 11, 2 } )  
Aadd(aCampos,{ "DTLANC"  ,"D", 08, 0 } )  
Aadd(aCampos,{ "EDINIC"  ,"N", 04, 0 } )  
Aadd(aCampos,{ "EDFIM"   ,"N", 04, 0 } )  
Aadd(aCampos,{ "REVISTA" ,"C", 04, 0 } )  
cArqTRB := CriaTrab(aCampos, .T.)
dbUseArea( .T.,, cArqTRB, "TRB", Nil, .F. )
inde on DTOS(EMISSAO)+PEDIDO to &carqtrb
dbselectarea("SC5")
DBSETORDER(2)
DBSEEK(XFILIAL()+DTOS(MV_PAR01),.T.)
PROCrEGUA(RECCOUNT())
DO WHILE !EOF() .AND. SC5->C5_EMISSAO <= MV_PAR02
	INCPROC("Gerando arquivo de Trabalho - Dia: "+dtoc(sc5->c5_emissao))
	dbselectarea("sc6")
	dbsetorder(1)
	dbseek(xfilial()+sc5->c5_num)
	do while !eof() .and. sc6->c6_num == sc5->c5_num
		If SC6->C6_VALOR == 1 .OR. sc6->c6_situac == "CC" .OR. SC6->C6_EDINIC == 9999 // Ignora pedidos com valor 1 ou cancelados
			DbSelectArea("SC6")
			DbSkip()
			Loop
		EndIf
		IF subs(c6_produto,5,3) == "001"
			DBSELECTAREA("SC6")
			DBSKIP()
			LOOP	
		ENDIF
		IF subs(c6_produto,1,2) <> "10" .and. subs(sc6->c6_produto,1,2) <> "11"
			DBSELECTAREA("SC6")
			DBSKIP()
			LOOP	
		ENDIF
		dbselectarea("trb")
		reclock("trb",.T.)
		trb->pedido := sc6->c6_num
		TRB->EMISSAO:= SC5->C5_EMISSAO
		TRB->DTLANC := SC5->C5_DTLANC
		TRB->VALOR  := SC6->C6_VALOR
		trb->revista:= sc6->c6_produto		
		trb->edinic := sc6->c6_edinic
		trb->edfim  := sc6->c6_edfin
		msunlock("trb")
		DBSELECTAREA("SC6")
		DBSKIP()
	ENDDO
	DBSELECTAREA("SC5")
	DBSKIP()
ENDDO 

*****************************
Static Function Contabiliza()
AROTINA := {}
aRotina      := {{ "","" , 0 , 1},;
                  { "","" , 0 , 2 },;
                  { "","" , 0 , 3 },;
                  { "","" , 0 , 4 } }
_nTotal      := 0
lHeadProva   := .F.
cLote := TABELA("09","PEDI",.T.)
_cArquivo :=""
_dDtBase     := dDataBase
DBSELECTAREA("TRB")
DBGOTOP() 
PROCREGUA(RECCOUNT())
DO WHILE !EOF()
	INCPROC("Gerando lancamentos - Dia: "+dtoc(trb->emissao))
	if !empty(trb->dtlanc)
		dbskip()
		loop
	endif
	CPadrao     := "995"
   	lPadrao     := VerPadrao(cPadrao)
   	If lPadrao                    
      	If !lHeadProva 
         	dDataBase  := MV_PAR02
         	nHdlPrv    := HeadProva(cLote,"INCREL",Substr(cUsuario,7,6),@_cArquivo)
         	lHeadProva := .T.
      	End
      	_nTotal := _nTotal + DetProva(nHdlPrv,cPadrao,"INCREL",cLote) 
		DBSELECTAREA("SC5")
		DBSETORDER(1)
		DBSEEK(XFILIAL()+TRB->PEDIDO)
		RECLOCK("SC5",.F.)
		SC5->C5_DTLANC := MV_PAR02
		MSUNLOCK()
   	Endif
 	DbSelectArea("TRB")
   	DbSkip()        
Enddo   
If lHeadProva
    RodaProva(nHdlPrv,_nTotal)             
	IF MV_PAR04 == 1
		lAglutina := .T.
	ELSE
		lAglutina := .F.
	ENDIF
	IF MV_PAR05 == 1
		lDigita := .T.
	ELSE
		lDigita := .F.
	ENDIF
    cA100Incl(_cArquivo,nHdlPrv,3,cLote,lDigita,lAglutina)
Endif
If nHdlPrv != NIL
   FClose(nHdlPrv)
Endif

dDataBase := _dDtBase
Return

************************
Static Function Report()
cString:="SC5"
cDesc1:= OemToAnsi("Este programa tem como objetivo, listar os pedidos")
cDesc2:= OemToAnsi("de assinaturas de relatorios contabilizados no mes.")
cDesc3:= ""
tamanho:="M"
aReturn := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog:= "CTBREL"
aLinha  := { }
nLastKey := 0
lEnd := .f.
titulo      :="Contabizacao de Assinaturas de Relatorios"
cabec1      :="Pedido Cliente   Nome do Cliente                          Emissao  Relat.  Edicao Edicao  Numero de          Valor"
cabec2      :="                                                                            Inic.   Final    Edicoes"
//             xxxxxx 222222/22 xxxxxcccccdddddssssseeeeerrrrrtttttyyyyy 99/99/99 xxxxxxx    9999   9999       9999  99,999,999.99
//             0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       1         2         3         4         5         6         7         8         9         10        11        12
cCancel := "***** CANCELADO PELO OPERADOR *****"
nlin := 80
m_pag := 1  
wnrel:="CTBREL"     
SetPrint(cString,wnrel,,titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)
If nLastKey == 27
    Set Filter To
    Return
Endif
SetDefault(aReturn,cString)

If nLastKey == 27
    Set Filter To
    Return
Endif
RptStatus({|| RptDetail() })
Return

***************************
Static Function RptDetail()
vtotal := 0
numped := 0
DbSelectArea("TRB")
DBGOTOP()
SETREGUA(RECCOUNT())
DO WHILE !EOF()
    IncRegua("Imprimindo - Dia: "+dtoc(trb->emissao)) 
	if nlin >58
	    nLin   := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
    	nLin   := nLin + 2
    endif
    @ nlin,0 PSAY trb->pedido
	dbselectarea("sc5")
	dbsetorder(1)
	dbseek(xfilial()+trb->pedido)
	dbselectarea("sa1")
	dbsetorder(1)
	dbseek(xfilial()+sc5->c5_cliente+sc5->c5_lojaCLI)
    @ nLin,07 PSAY sc5->c5_cliente+"/"+sc5->c5_lojaCLI
    @ nlin,17 psay subs(sa1->a1_nome,1,40)
    @ nlin,58 psay trb->emissao
	@ nlin,67 psay trb->revista
	@ nlin,78 psay trb->edinic picture "@e 9999"
	@ nlin,85 psay trb->edfim picture "@e 9999"
	@ nlin,96 psay trb->edfim-trb->edinic+1 picture "@e 9999"
    @ nLin,102 psay trb->valor picture "@E 99,999,999.99"
	vtotal := vtotal + trb->valor
	numped := numped +1
	nlin := nlin+1
	dbselectarea("trb")
	dbskip()
enddo
nlin := nlin +1
@ nlin,00 psay "Numero de Pedidos: "
@ nlin,20 psay numped picture "@e 999,999"
@ nLin,102 psay vtotal picture "@E 99,999,999.99"
nlin := nlin +1
Roda(0,"",tamanho)
Set Filter To
If aReturn[5] == 1
	Set Printer To
	Commit
    ourspool(wnrel) 
Endif
MS_FLUSH() 
Return
***************************
Static Function ValidPerg()
_cSavAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs :={}
AADD(aRegs,{cPerg,"01","Data de            ?", "" , "" ,"mv_ch1","D",8 ,0,0,"G","","mv_par01","", "" , "" , "","","", "" , "" , "","", "" , "" , "","", "" , "" , "","", "" , "" , "","","","","", ""})
AADD(aRegs,{cPerg,"02","Data ate           ?", "" , "" ,"mv_ch2","D",8 ,0,0,"G","","mv_par02","", "" , "" , "","","", "" , "" , "","", "" , "" , "","", "" , "" , "","", "" , "" , "","","","","", ""})
AADD(aRegs,{cPerg,"03","Gera Lancamentos   ?", "" , "" ,"mv_ch3","N",1 ,0,0,"C","","mv_par03","Sim", "" , "" , "","","Nao", "" , "" , "","", "" , "" , "","", "" , "" , "","", "" , "" , "","","","","", ""})
AADD(aRegs,{cPerg,"04","Aglutina Lancamtos ?", "" , "" ,"mv_ch4","N",1 ,0,0,"C","","mv_par04","Sim", "" , "" , "","","Nao", "" , "" , "","", "" , "" , "","", "" , "" , "","", "" , "" , "","","","","", ""})
AADD(aRegs,{cPerg,"05","Mostra Lancamentos ?", "" , "" ,"mv_ch5","N",1 ,0,0,"C","","mv_par05","Sim", "" , "" , "","","Nao", "" , "" , "","", "" , "" , "","", "" , "" , "","", "" , "" , "","","","","", ""})
For i:=1 to Len(aRegs)
   If !dbSeek(cPerg+aRegs[i,2])
      RecLock("SX1",.T.)
      For j:=1 to FCount()
         FieldPut(j,aRegs[i,j])
      Next
      MsUnlock()
   Endif
Next
dbSelectArea(_cSavAlias)
RETURN

