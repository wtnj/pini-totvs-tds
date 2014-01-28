#include "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT171   ³Autor: Danilo c s Pala        ³ Data:20061026    ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: RELATORIO DE DIREITOS AUTORAIS TOTALIZADOS POR PRODUTO E   ³ ±±
±±³ AUTOR                                                                ³ ±±   
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function PFAT171()

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CDESC1")
SetPrvt("CDESC2,CDESC3,CTITULO,CCABEC1,CCABEC2,CPROGRAMA")
SetPrvt("CTAMANHO,LIMITE,NCARACTER,ARETURN,WNREL,CSTRING")
SetPrvt("NLASTKEY,_ACAMPOS,_CNOME,CINDEX,CKEY,_CFILTRO")
SetPrvt("MCLI,MPED,MPRD,M_PAG,L,MSUBT")
SetPrvt("MPRODUTO,MAUTOR, MTOTAUT, MQTD, MDESCRIC, cArqPath, cArquivo,mhora")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ MV_PAR01 PESQUISAR POR {1=EMISSAO, 2=PAGTO CLIENTE, 3=PAGTO AUTOR}
//³ MV_PAR02 DATA DE						 ³
//³ MV_PAR03 DATA ATE						 ³
//³ MV_PAR04 DO AUTOR						 ³
//³ MV_PAR05 ATE AUTOR						 ³
//³ MV_PAR06 DO PRODUTO						 ³
//³ MV_PAR07 ATE PRODUTO					 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:='FAT171' //FALTA
IF .NOT. PERGUNTE(cPerg)
   RETURN
ENDIF

cDesc1   := PADC("RELATORIO DE DIREITOS AUTORAIS POR PRODUTO E AUTOR",70)
cDesc2   := PADC("",70)
cDesc3   := " "                                                
IF MV_PAR01 == 1
	cTitulo  := "* RELATORIO DE DIREITOS AUTORAIS NOTAS EMITIDAS NO PERIODO: "+DTOC(MV_PAR02)+" A "+DTOC(MV_PAR03)+" *"
ELSEIF MV_PAR01 == 2
	cTitulo  := "* RELATORIO DE DIREITOS AUTORAIS PAGTO DE CLIENTES NO PERIODO: "+DTOC(MV_PAR02)+" A "+DTOC(MV_PAR03)+" *"
ELSEIF MV_PAR01 == 3
	cTitulo  := "* RELATORIO DE DIREITOS AUTORAIS PAGTO DE AUTORES NO PERIODO: "+DTOC(MV_PAR02)+" A "+DTOC(MV_PAR03)+" *"
ENDIF
//			          10        20        30        40        50        60        70        80        90        100       110       120
//           123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
cCabec1  := "SERIE  NOTA   ITEM PEDIDO EMISSAO  QUANTIDADE      VALOR NF  VALOR AUTOR     DESCONTOS       IGPM        STATUS"
cCabec2  := " "
cPrograma:= "PFAT171"
cTamanho := "M"
LIMITE   := 132 
nCaracter:= 12

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aReturn:={"Especial", 1,"Administracao", 1, 2, 1," ",1 }
MHORA      := TIME()
wnrel    :="PFAT171_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString  :="ZZV"
NLASTKEY := 0

wnrel:=SetPrint(cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,,,.F.)

IF NLASTKEY==27 .OR. NLASTKEY==65
   RETURN
ENDIF

SetDefault(aReturn,cString)

IF NLASTKEY==27 .OR. NLASTKEY==65
   RETURN
ENDIF

#IFDEF WINDOWS
RptStatus({|| RptDetail()})
Return




Static Function RptDetail()
#ENDIF
DBSELECTAREA("ZZV")
_cFiltro := "ZZV_FILIAL == '"+xFilial("ZZV")+"'"
IF MV_PAR01 ==1  //{1=EMISSAO, 2=PAGTO CLIENTE, 3=PAGTO AUTOR}
	_cFiltro := _cFiltro+" .and. DTOS(ZZV_EMISSA)>='"+DTOS(MV_PAR02)+"'"
	_cFiltro := _cFiltro+" .and. DTOS(ZZV_EMISSA)<='"+DTOS(MV_PAR03)+"'"
ELSEIF MV_PAR01 ==2
	_cFiltro := _cFiltro+" .and. DTOS(ZZV_DTPGCL)>='"+DTOS(MV_PAR02)+"'"
	_cFiltro := _cFiltro+" .and. DTOS(ZZV_DTPGCL)<='"+DTOS(MV_PAR03)+"'"
ELSE
	_cFiltro := _cFiltro+" .and. DTOS(ZZV_DTPGAU)>='"+DTOS(MV_PAR02)+"'"
	_cFiltro := _cFiltro+" .and. DTOS(ZZV_DTPGAU)<='"+DTOS(MV_PAR03)+"'"  
	_cFiltro := _cFiltro+" .and. ZZV_STATUS='3'"
ENDIF
_cFiltro := _cFiltro+" .and. ZZV_AUTOR>=MV_PAR04 .and. ZZV_AUTOR<=MV_PAR05"
_cFiltro := _cFiltro+" .and. ZZV_PRODUT>=MV_PAR06 .and. ZZV_PRODUT<=MV_PAR07"
CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="ZZV_FILIAL+ZZV_AUTOR+ZZV_PRODUT+ZZV_NF+ZZV_SERIE+ZZV_ITEM+DTOS(ZZV_EMISSA)"
INDREGUA("ZZV",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")
DBgotop()

MQTD     := 0 
MSUBT    := 0
MTOTAUT  := 0
MAUTOR   := ""
MDESCRIC := SPACE(40)           
MPRODUTO := ""
L        := 0

SETREGUA(RECCOUNT())
DO WHILE .NOT. EOF() 
	IF MPRODUTO <> ZZV->ZZV_PRODUT
		if MPRODUTO <> ""
			@ L,08   PSAY '----------------------------------------------------------------------------------'
	        @ L+1,15 PSAY 'QTD PRODUTO:'
    	    @ L+1,36 PSAY MQTD PICTURE "@E 999999" 
    	    @ L+1,43 PSAY "TOTAL:"
    	    @ L+1,62 PSAY MSUBT PICTURE "@E 999,999.99" 
        	MQTD  := 0 
	        MSUBT := 0
    	    L:=60       
   		endif
        DBSELECTAREA("SB1")     
		DBSETORDER(1)
      	IF DBSEEK(XFILIAL("SB1")+ZZV->ZZV_PRODUT)
			MDESCRIC := SB1->B1_DESC
			MPRODUTO := SB1->B1_COD
      	ENDIF
	ENDIF
	IF MAUTOR  <> ZZV->ZZV_AUTOR 
		if MAUTOR <>""
		    @ L,08   PSAY '----------------------------------------------------------------------------------'
    	    @ L+1,15 PSAY 'TOTAL DO AUTOR:'
        	@ L+1,62 PSAY MTOTAUT PICTURE "@E 999,999.99" 
	        MTOTAUT := 0
    		L := 0
  		endif
		DBSELECTAREA("SA3")
		DBSETORDER(1)
		If DBSEEK(XFILIAL("SA3")+ZZV->ZZV_AUTOR)
			MNOME  := SA3->A3_NOME
			MDOC   := SA3->A3_TIPODOC
			MPESSOA := SA3->A3_PESSOA //20031209
			MTIPOVEN := SA3->A3_TIPOVEN // 20031210
			MCGC := SA3->A3_CGC // 20040108
		ENDIF                                   
	ENDIF
	
   	IF L==0 .OR. L>59
      Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
      @ 8,00 PSAY "AUTOR: "
      @ 8,10 PSAY MAUTOR + ' / '+ SA3->A3_NOME
      @ 9,00 PSAY "** PRODUTO: "
      @ 9,12 PSAY MPRODUTO
      @ 9,27 PSAY MDESCRIC
      L:=11
   	ENDIF

//	     	            10        20        30        40        50        60        70        80         90        100       110       120
//             123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
//cCabec1  := "SERIE  NOTA   ITEM PEDIDO EMISSAO  QUANTIDADE   VALOR NF     VALOR AUTOR       DESCONTOS     IGPM    STATUS"

   	@ L,00 PSAY ZZV->ZZV_SERIE
   	@ L,08 PSAY ZZV->ZZV_NF
   	@ L,15 PSAY ZZV->ZZV_ITEM
   	@ L,20 PSAY ZZV->ZZV_PEDIDO
   	@ L,27 PSAY ZZV->ZZV_EMISSA
   	@ L,36 PSAY ZZV->ZZV_QTD PICTURE "@E 999999" 
   	@ L,49 PSAY ZZV->ZZV_VALNF PICTURE "@E 999,999.99" 
   	@ L,62 PSAY ZZV->ZZV_VALAUT PICTURE "@E 999,999.99" 
   	@ L,76 PSAY ZZV->ZZV_DESCON PICTURE "@E 999,999.99" 
   	@ L,85 PSAY ZZV->ZZV_ALIQ PICTURE "@E 999,999.9999" 
   	IF ZZV->ZZV_STATUS == "1"
	   	@ L,104 PSAY "ABERTO"
   	ELSEIF ZZV->ZZV_STATUS == "2"
   	   	@ L,104 PSAY "PAGO CLIENTE"
   	ELSEIF ZZV->ZZV_STATUS == "3"
   	   	@ L,104 PSAY "PAGO AUTOR"
   	ELSEIF ZZV->ZZV_STATUS == "4"
   	   	@ L,104 PSAY "CANCELADO"
   	ELSE
   	   	@ L,104 PSAY ""
	ENDIF   	   	
   	
   	IF L>59
      L:=0
      M_PAG:=M_PAG+1
   	ELSE
      L:=L+1
   	ENDIF
   	
   	MSUBT	 := MSUBT + ZZV->ZZV_VALAUT
   	MTOTAUT  := MTOTAUT + ZZV->ZZV_VALAUT
   	MQTD	 := MQTD + ZZV->ZZV_QTD
	MAUTOR   := ZZV->ZZV_AUTOR
   	MPRODUTO := ZZV->ZZV_PRODUT
   	DBSELECTAREA("ZZV")
   	DBSKIP()
   	INCREGUA()
ENDDO               
L++
@ L,08   PSAY '----------------------------------------------------------------------------------'
L++
@ L,15 PSAY 'QTD PRODUTO:'
@ L,36 PSAY MQTD PICTURE "@E 999999" 
@ L,43 PSAY "TOTAL:"
@ L,49 PSAY MSUBT PICTURE "@E 999,999.99" 
L++
@ L,08   PSAY '----------------------------------------------------------------------------------'
L++
@ L,15 PSAY 'TOTAL DO AUTOR:'
@ L,62 PSAY MTOTAUT PICTURE "@E 999,999.99" 
   
        
cArqPath   :=GetMv("MV_PATHTMP")                    
cArquivo := cArqPath+"NOVOAUT.DBF"
COPY TO &cArquivo VIA "DBFCDXADS" // 20121106 

MsgInfo(cArquivo)

SET DEVI TO SCREEN
DBCLOSEAREA()

IF aRETURN[5] ==1
   SET PRINTER TO
   DBCOMMITALL()
   OURSPOOL(WNREL)
ENDIF
MS_FLUSH()

DBSELECTAREA("ZZV")
RETINDEX("ZZV")
DBCLOSEAREA("ZZV")
DBSELECTAREA("SA3")
DBCLOSEAREA("SA3")
DBSELECTAREA("SB1")
DBCLOSEAREA("SB1")
RETURN