#include "rwmake.ch"  
/* Alterado por Danilo C S Pala em 20050201
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT401   ºAutor  ³Marcos Farineli     º Data ³  23/09/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Seleciona os pedidos de ate a emissao, para inserir na tab º±±
±±º          ³  de diferimento, atualiza o c5_dtlanc                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PFAT401()

CPERG := "ATR240"

pergunte(CPERG,.f.)

@ 96,42 TO 323,505 DIALOG oDlg TITLE "Geracao de Entrada de Assinaturas"
@ 8,10 TO 84,222
@ 91,139 BMPBUTTON TYPE 5 ACTION Pergunte(CPERG)
@ 91,168 BMPBUTTON TYPE 1 ACTION OkProc()
@ 91,196 BMPBUTTON TYPE 2 ACTION Close(oDlg)
@ 23,14 SAY "Este programa ira gerar o arquivos de Pedidos de Assinaturas"
@ 33,14 SAY "para efeito de diferimento"
@ 43,14 SAY "Conforme a Data de Emissao, considera apenas revistas e descarta"
@ 53,14 SAY "as avulsas. Apenas Insere na tabela caso nao exista"
ACTIVATE DIALOG oDlg Centered

Return 
             

// ********************************************************
Static Function OkProc()
Close(oDlg)
Processa({||PegaDados()})
Processa({||Contabiliza()})
report()
DbSelectarea("TRB")
DbClosearea("TRB")

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
Aadd(aCampos,{ "ITEM"    ,"C", 02, 0 } )  
Aadd(aCampos,{ "QTDEX"   ,"N", 03, 0 } )
Aadd(aCampos,{ "VL_DIFIT","N", 10, 2 } )
Aadd(aCampos,{ "DTINIC"  ,"D", 08, 0 } )
Aadd(aCampos,{ "DTFIM"   ,"D", 08, 0 } )
  
cArqTRB := CriaTrab(aCampos, .T.)

dbUseArea( .T.,, cArqTRB, "TRB", Nil, .F. )
Index on DTOS(EMISSAO)+PEDIDO to &carqtrb

Dbselectarea("SC5")
DBSETORDER(2)
DBSEEK(XFILIAL("SC5")+DTOS(MV_PAR01),.T.)
PROCREGUA(RECCOUNT())
WHILE !EOF() .AND. SC5->C5_EMISSAO <= MV_PAR02
	INCPROC("Gerando arquivo de Trabalho - Dia: "+DTOC(SC5->C5_EMISSAO))
	IF SC5->C5_DIVVEN <> "MERC"
		DBSELECTAREA("SC5")
		DBSKIP()
		LOOP
	ENDIF
	Dbselectarea("SC6")
	Dbsetorder(1)
	Dbseek(xfilial("SC6")+SC5->C5_NUM)
	While !eof() .and. SC6->C6_NUM == SC5->C5_NUM
		If SC6->C6_VALOR == 1 //.OR. SC6->C6_SITUAC == "CC"  // Ignora pedidos com valor 1 
			DbSelectArea("SC6")
			DbSkip()
			Loop
		EndIf

		IF (subs(SC6->C6_PRODUTO,1,2) <> "01") .OR. (subs(SC6->C6_PRODUTO,5,3) == "001") //somente revistas e descarta avulsas
			DBSELECTAREA("SC6")
			DBSKIP()
			LOOP	
		ENDIF
		
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial("SB1")+SC6->C6_PRODUTO)
		
		DbselectArea("SZJ")
		DbSetOrder(1)
		If DbSeek(xFilial("SZJ")+Substr(SC6->C6_PRODUTO,1,4)+Str(SC6->C6_EDINIC,4,0))
			dDataInic := SZJ->ZJ_DTCIRC
		Else
			dDataInic := stod("")
		EndIf
		If DbSeek(xFilial("SZJ")+Substr(SC6->C6_PRODUTO,1,4)+Str(SC6->C6_EDFIN,4,0))
			dDataFim := SZJ->ZJ_DTCIRC
		Else
			dDataFim := stod("")
		EndIf
				
		Dbselectarea("TRB")
		Reclock("TRB",.T.)
		TRB->PEDIDO   := SC6->C6_NUM
		TRB->EMISSAO  := SC5->C5_EMISSAO
		TRB->DTLANC   := SC5->C5_DTLANC
		TRB->VALOR    := SC6->C6_VALOR
		TRB->REVISTA  := SC6->C6_PRODUTO		
		TRB->EDINIC   := SC6->C6_EDINIC
		TRB->EDFIM    := SC6->C6_EDFIN
		TRB->ITEM     := SC6->C6_ITEM
		TRB->QTDEX    := SB1->B1_QTDEEX
		TRB->VL_DIFIT := IIF(SC6->C6_VLDIFIT == 0,ROUND(SC6->C6_VALOR/SB1->B1_QTDEEX,2),SC6->C6_VLDIFIT)
		TRB->DTINIC   := dDataInic
		TRB->DTFIM    := dDataFim
		msunlock("TRB")
		DBSELECTAREA("SC6")
		DBSKIP()
	END
	DBSELECTAREA("SC5")
	DBSKIP()
END 


******************************************************
Static Function Contabiliza()

_dDtBase     := dDataBase

DBSELECTAREA("TRB")
DBGOTOP() 
PROCREGUA(RECCOUNT())
WHILE !EOF()
	INCPROC("Gerando mapa - Dia: "+Dtoc(TRB->EMISSAO))
	If !Empty(TRB->DTLANC)
		Dbskip()
		Loop
	Endif
	DBSELECTAREA("SC5")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SC5")+TRB->PEDIDO)

	Reclock("SC5",.F.)
	SC5->C5_DTLANC := MV_PAR02
	MSUnlock()

	DbSelectArea("SC6")
	DbSetOrder(1)
	DbSeek(xFilial("SC6")+TRB->PEDIDO+TRB->ITEM)
	
	DbSelectArea("ZZL")
	DbSetOrder(1)
	If DbSeek(xFilial("ZZL")+TRB->PEDIDO+TRB->ITEM)
		DbSelectArea("TRB")
		DbSkip()
		Loop
	Else
		DbSelectArea("ZZL")
		RecLock("ZZL",.t.)
		ZZL->ZZL_PEDIDO := TRB->PEDIDO
		ZZL->ZZL_ITEM   := TRB->ITEM
		ZZL->ZZL_DATA   := TRB->EMISSAO
		ZZL->ZZL_CODREV := SUBSTR(TRB->REVISTA,1,4)
		ZZL->ZZL_VALOR  := TRB->VALOR
		ZZL->ZZL_DTINIC := TRB->DTINIC
		ZZL->ZZL_DTFIM  := TRB->DTFIM
		ZZL->ZZL_QTDEX  := TRB->QTDEX
		ZZL->ZZL_STATUS := ""
		ZZL->ZZL_VLDIF  := TRB->VL_DIFIT
		ZZL->ZZL_CODREV := SUBSTR(TRB->REVISTA,1,4)
		MsUnlock()
	EndIf
		
 	DbSelectArea("TRB")
   	DbSkip()        
End

dDataBase := _dDtBase

Return

************************
Static Function Report()

cString  := "SC5"
cDesc1   := OemToAnsi("Este programa tem como objetivo, listar os pedidos")
cDesc2   := OemToAnsi("de assinaturas contabilizados no mes.")
cDesc3   := ""
tamanho  := "M"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog := "PFAT401"
aLinha   := { }
nLastKey := 0
lEnd     := .f.
titulo   := "Contabizacao de Assinaturas"
cabec1   := "Pedido Cliente   Nome do Cliente                          Emissao  Revista  Edicao Edicao  Numero de          Valor"
cabec2   := "                                                                            Inic.   Final    Edicoes"
//             xxxxxx 222222/22 xxxxxcccccdddddssssseeeeerrrrrtttttyyyyy 99/99/99 xxxxxxx    9999   9999       9999  99,999,999.99
//             0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//                       1         2         3         4         5         6         7         8         9         10        11        12
cCancel  := "***** CANCELADO PELO OPERADOR *****"
nlin     := 80
m_pag    := 1  

wnrel    := "PFAT401"     

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

WHILE !EOF()
    IncRegua("Imprimindo - Dia: "+dtoc(trb->emissao)) 
	if nlin >58
	    nLin   := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
    	nLin   := nLin + 2
    endif
    @ nlin,0 PSAY trb->pedido
	dbselectarea("SC5")
	dbsetorder(1)
	dbseek(xFilial()+TRB->PEDIDO)
	dbselectarea("sa1")
	dbsetorder(1)
	dbseek(xFilial()+SC5->C5_CLIENTE+SC5->C5_LOJACLI)
    @ nLin,07 PSAY SC5->C5_CLIENTE+"/"+SC5->C5_LOJACLI
    @ nlin,17 psay subs(SA1->A1_NOME,1,40)
    @ nlin,58 psay TRB->EMISSAO
	@ nlin,67 psay TRB->REVISTA
	@ nlin,78 psay TRB->EDINIC  picture "@e 9999"
	@ nlin,85 psay TRB->EDFIM   picture "@e 9999"
	@ nlin,96 psay (TRB->EDFIM-TRB->EDINIC+1) picture "@e 9999"
    @ nLin,102 psay TRB->VALOR picture "@E 99,999,999.99"
	
	vtotal += TRB->VALOR
	numped := numped++
	nlin++
	dbselectarea("TRB")
	dbskip()
end

nlin++

@ nlin,00 psay "Numero de Pedidos: "
@ nlin,20 psay numped picture "@e 999,999"
@ nLin,102 psay vtotal picture "@E 99,999,999.99"

nlin++

Roda(0,"",tamanho)

Set Filter To
If aReturn[5] == 1
	Set Printer To
	Commit
    ourspool(wnrel) 
Endif

MS_FLUSH() 

Return