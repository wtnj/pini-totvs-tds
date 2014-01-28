USER FUNCTION ACERTAC6()
Processa({||PegaDados()})
return
*********
static function pegadados()
aCampos := {}
Aadd(aCampos,{ "PEDIDO"   ,"C", 06, 0 } )  
Aadd(aCampos,{ "produto"  ,"C", 15, 0 } )  
Aadd(aCampos,{ "parcelas" ,"N", 02, 0 } )  
Aadd(aCampos,{ "parcpagas","N", 02, 0 } )  
Aadd(aCampos,{ "prefixo"  ,"C", 03, 0 } )  
Aadd(aCampos,{ "titulo"   ,"C", 06, 0 } )  
Aadd(aCampos,{ "emissao"  ,"D", 08, 0 } )  
Aadd(aCampos,{ "EDINIC"   ,"N", 04, 0 } )  
Aadd(aCampos,{ "EDfim"    ,"N", 04, 0 } ) 
Aadd(aCampos,{ "EDsuspatu","N", 04, 0 } )  
Aadd(aCampos,{ "EDsuspok ","N", 04, 0 } )  
Aadd(aCampos,{ "EDVENC   ","N", 04, 0 } )
Aadd(aCampos,{ "EXADIC   ","N", 04, 0 } )
cArqTRB := CriaTrab(aCampos, .T.)
dbUseArea( .T.,, cArqTRB, "TRB", Nil, .F. )

DBSELECTAREA("SE1")
DbOrderNickName("E1_PEDIDO") //dbSetOrder(27) 20130225  ///dbSetOrder(15) AP5 //20090114 era(21) //20090723 mp10 era(22) //dbSetOrder(26) 20100412
DBGOTOP()
PROCREGUA(RECCOUNT())
DO WHILE !EOF()
	INCPROC("PEDIDO No.:"+SE1->E1_PEDIDO+" - Titulo: "+se1->e1_num)
	IF SE1->E1_PREFIXO <> "ASS" .AND. SE1->E1_PREFIXO <> "UNI" 
		dbselectarea("se1")
		DBSKIP()
		LOOP
	ENDIF
	if empty(se1->e1_pedido)
		dbselectarea("se1")
		dbskip()
		loop
	endif
	CHAVE := SE1->E1_NUM
	XPARCELAS := XPARCUNI := 0
	XPEDIDO := SE1->E1_PEDIDO
	XPARCPAGAS := XPARCUNIPG := 0
	DO WHILE !EOF() .AND. SE1->E1_NUM == CHAVE
		xemissao := se1->e1_emissao
		IF SE1->E1_PREFIXO == "UNI"
			XPARCUNI := XPARCUNI + 1
		ELSE
			XPARCELAS := XPARCELAS +1
		ENDIF
		IF SE1->E1_SALDO == 0
			IF SE1->E1_PREFIXO == "UNI"
				XPARCUNIPG := XPARCUNIPG + 1
			ELSE
				XPARCPAGAS := XPARCPAGAS+1
			ENDIF
		ENDIF	
		DBSKIP()
	ENDDO
	DBSELECTAREA("SC6")
	DBSETORDER(1)
	DBSEEK(XFILIAL()+XPEDIDO)
	DO WHILE !EOF() .AND. SC6->C6_NUM == XPEDIDO
	    IF SC6->C6_EDINIC == 9999
			dbselectarea("sc6")
	    	DBSKIP()
	    	LOOP
	    ENDIF
		IF SUBS(SC6->C6_PRODUTO,1,2) $ "01/10/11"
			NUMEDIC := SC6->C6_EDFIN-SC6-> C6_EDINIC+1
			if Xparcuni <> 0
				EDSUSPe := SC6->C6_EDINIC+((NUMEDIC/XPARCuni*XPARCuniPG)-1)
				Xparcelas:= Xparcuni
				Xparcpagas := Xparcunipg
				Xprefixo := "UNI"
			else
				EDSUSPe := SC6->C6_EDINIC+((NUMEDIC/XPARCELAS*XPARCPAGAS)-1)
				Xprefixo := "ASS"
			ENDIF
			IF EDSUSPE < SC6->C6_EDINIC
				EDSUSPE := SC6->C6_EDINIC
			ELSE
				EDSUSPE := EDSUSPE + SC6->C6_EXADIC
			ENDIF
			if edsuspe <> sc6->c6_edsusp
				dbselectarea("trb")
				reclock("trb",.t.)
				trb->pedido   := sc6->c6_num
				trb->produto  := sc6->c6_produto
				trb->parcelas := Xparcelas
				trb->parcpagas:= Xparcpagas
				TRB->PREFIXO  := XPREFIXO				
				trb->titulo   := chave
				trb->emissao  := xemissao
				TRB->EDINIC   := SC6->C6_EDINIC
				TRB->EDfim    := SC6->C6_EDfin
				TRB->EDsuspatu:= SC6->C6_EDSUSP
				TRB->EDVENC   := SC6->C6_EDVENC
				TRB->EXADIC   ç= SC6->C6_EXADIC
				TRB->EDsuspok := EDSUSPe
				msunlock("trb")
			ENDIF
/*
			RECLOCK("SC6",.F.)
			SC6->C6_EDSUSP := EDSUSPE
			MSUNLOCK()
*/
		ENDIF
		dbselectarea("sc6")
		DBSKIP()
	ENDDO
	DBSELECTAREA("SE1")
ENDDO