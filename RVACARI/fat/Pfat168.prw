#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
 //20070207 Danilo C S Pala: MUDANCA DA REGRA PARA TCPO: JOSIANI
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: Pfat168   ³Autor: Danilo c s Pala        ³ Data:20060828    ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: processa as notas inseridas no periodo incluindo na tabela ³ ±±
±±³ de direitos autorais ZZV010 qdo for o caso                           ³ ±±   
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function Pfat168()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CDESC1")
SetPrvt("CDESC2,CDESC3,CTITULO,CCABEC1,CCABEC2,CPROGRAMA")
SetPrvt("CTAMANHO,LIMITE,NCARACTER,ARETURN,WNREL,CSTRING")
SetPrvt("NLASTKEY,_ACAMPOS,_CNOME,CINDEX,CKEY,_CFILTRO")
SetPrvt("MCLI,MPED,MPRD,M_PAG,L,MSUBT")
SetPrvt("MPRODUTO,mhora")

//cSavTela   := SaveScreen( 0, 0,24,80)
//cSavCursor := SetCursor()
//cSavCor    := SetColor()
//cSavAlias  := Select()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_prod_de           //Do Produto:       ³
//³ mv_prod_ate          //Ate o Produto:    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:='FAT023'
IF .NOT. PERGUNTE(cPerg)
   RETURN
ENDIF

cDesc1   := PADC("Este programa emite a quantidade faturada por produto",70)
cDesc2   := PADC("no periodo solicitado",70)
cDesc3   := " "
cTitulo  := "* RELATORIO DE PRODUTOS FATURADOS * PERIODO: "+DTOC(MV_PAR03)+" A "+DTOC(MV_PAR04)+" *"
cCabec1  := "DUPLICATA  DT.EMISSAO  PEDIDO  QTDADE  CLIENTE"
cCabec2  := " "
cPrograma:= "PFAT168"
cTamanho := "M"
LIMITE   := 132 
nCaracter:= 12

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aReturn:={"Especial", 1,"Administracao", 1, 2, 1," ",1 }
MHORA      := TIME()
wnrel    :="PFAT168_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString  :="SD2"
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
       RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        RptStatus({|| Execute(RptDetail)})
       Return
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        Function RptDetail
Static Function RptDetail()
#ENDIF

_aCampos := {{"NUMPED"  ,"C",6, 0} ,;
             {"CODCLI"  ,"C",6, 0} ,;
             {"NOMECLI" ,"C",40,0} ,;
             {"QTDE"    ,"N",6, 0} ,;
             {"NUMNF"   ,"C",9, 0} ,;
             {"PRODUTO" ,"C",15,0} ,;
             {"DESCRIC" ,"C",40,0} ,;
             {"DTEMISS" ,"D",8, 0}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"FATPROD",.F.,.F.)
cIndex:=CRIATRAB(NIL,.F.)
cKey:="PRODUTO+NUMNF"
INDREGUA("FATPROD",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")

Set Index To
DbSetIndex(CINDEX)
DbSetOrder(01)

/*DBSELECTAREA("SD2")
_cFiltro := "D2_FILIAL == '"+xFilial("SD2")+"'"
_cFiltro := _cFiltro+".and.D2_COD>=MV_PAR01.and.D2_COD<=MV_PAR02"
_cFiltro := _cFiltro+".and.DTOS(D2_EMISSAO)>=DTOS(CTOD('"+DTOC(MV_PAR03)+"'))"
_cFiltro := _cFiltro+".and.DTOS(D2_EMISSAO)<=DTOS(CTOD('"+DTOC(MV_PAR04)+"'))"
_cFiltro := _cFiltro+".and.(D2_SERIE <>'LIV' .AND. D2_SERIE <>'CP0' .AND. D2_SERIE <>'SNF' )"
CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="D2_FILIAL+DTOS(D2_EMISSAO)+D2_COD"
INDREGUA("SD2",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")
*/

cQuery := "SELECT * FROM " + RetSqlName("SD2") +" WHERE D2_FILIAL = '"+ xFilial("SD2") +"' AND D2_COD>='"+ MV_PAR01 +"' AND D2_COD<='"+ MV_PAR02 +"' AND D2_EMISSAO>='"+ DTOS(MV_PAR03) +"' AND D2_EMISSAO<='"+ DTOS(MV_PAR04) +"' AND D2_SERIE <>'LIV' AND D2_SERIE <>'CP0' AND D2_SERIE <>'SNF' AND D_E_L_E_T_<>'*'"
TCQUERY cQuery NEW ALIAS "QUERYSD2"
TcSetField("QUERYSD2","D2_EMISSAO"   ,"D")

DbSelectArea("QUERYSD2")
DBgotop()

SETREGUA(RECCOUNT())
DO WHILE .NOT. EOF() 
   INCREGUA()
   MCLI:=QUERYSD2->D2_CLIENTE
   MPED:=QUERYSD2->D2_PEDIDO
   MPRD:=QUERYSD2->D2_COD
                                                 
//SELECT F4_CODIGO FROM SF4010 WHERE F4_FILIAL='01' AND F4_TIPO='S' AND F4_DUPLIC='N'
	DbSelectArea("SF4")
	DbSetOrder(1)
	DbGoTop()
	DbSeek(xFilial("SF4")+QUERYSD2->D2_TES)
	If SF4->F4_DUPLIC == "N" .OR. SF4->F4_PINIDIR == "N"
		DBSelectArea("QUERYSD2")
		DBSKIP()
		LOOP
	EndIf

   IF QUERYSD2->D2_SERIE == 'LIV' .OR. QUERYSD2->D2_SERIE == 'CP0' .OR. QUERYSD2->D2_SERIE == 'SNF'   //20060802
		DBSelectArea("QUERYSD2")
		DBSKIP()
		LOOP
   ENDIF

	DBSELECTAREA("SA1")
	DBSEEK(XFILIAL()+MCLI)
    IF .NOT. FOUND()
          DBSELECTAREA("QUERYSD2")
          DBSKIP()
          LOOP
    ENDIF
    
    DBSELECTAREA("SB1")     
    DBSETORDER(1)
      DBSEEK(XFILIAL()+MPRD)
      IF .NOT. FOUND()
          DBSELECTAREA("QUERYSD2")
          DBSKIP()
          LOOP             
      ENDIF
      
      DBSELECTAREA("FATPROD")
      RECLOCK("FATPROD",.T.)
      FATPROD->PRODUTO  := QUERYSD2->D2_COD
      FATPROD->CODCLI   := QUERYSD2->D2_CLIENTE
      FATPROD->NUMPED   := QUERYSD2->D2_PEDIDO
      FATPROD->NUMNF    := QUERYSD2->D2_DOC   
      FATPROD->NOMECLI  := SA1->A1_NOME
      FATPROD->QTDE     := QUERYSD2->D2_QUANT
      FATPROD->DTEMISS  := QUERYSD2->D2_EMISSAO
      FATPROD->DESCRIC  := SB1->B1_DESC
      FATPROD->(MsUnlock())
      
	DBSELECTAREA("SZY")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SZY")+QUERYSD2->D2_COD)
	IF FOUND()
		WHILE !Eof() .and. SZY->ZY_FILIAL == xFilial("SZY") .and. SZY->ZY_PRODUTO == QUERYSD2->D2_COD
			MAUT   := SZY->ZY_CODAUT
			MMOEDA := SZY->ZY_MOEDA
			MTIPO  := SZY->ZY_TIPO                                                         
/*			if MTIPO == 'E' //MUDANCA DA REGRA PARA TCPO: JOSIANI
				DBSELECTAREA("SZY")
				DBSKIP()
				LOOP
			endif */
					
			/*if alltrim(mpedido)= '397872' //20050323
				 MsgAlert("Achou")
			endif */

			DBSELECTAREA("SA3")
			DBSETORDER(1)
			If DBSEEK(XFILIAL("SA3")+MAUT)
				MNOME  := SA3->A3_NOME
				MDOC   := SA3->A3_TIPODOC
				MPESSOA := SA3->A3_PESSOA //20031209
				MTIPOVEN := SA3->A3_TIPOVEN // 20031210
				MCGC := SA3->A3_CGC // 20040108
			ENDIF                                   
					
			DBSELECTAREA("ZZV")
			DbSetOrder(5)     // ZZV_FILIAL ZZV_NF ZZV_SERIE ZZV_ITEM ZZV_PRODUT ZZV_AUTOR
			DBSEEK(xfilial("ZZV") + QUERYSD2->D2_DOC + QUERYSD2->D2_SERIE + QUERYSD2->D2_ITEM + QUERYSD2->D2_COD + SZY->ZY_CODAUT)
			IF !FOUND()
				RECLOCK("ZZV",.T.)
					ZZV->ZZV_FILIAL		:= XFILIAL("ZZV")
					ZZV->ZZV_NF			:= QUERYSD2->D2_DOC
					ZZV->ZZV_SERIE 		:= QUERYSD2->D2_SERIE
					ZZV->ZZV_ITEM		:= val(QUERYSD2->D2_ITEM)  //20060828 ainda e numero, converter para char
					ZZV->ZZV_PEDIDO 	:= QUERYSD2->D2_PEDIDO
					ZZV->ZZV_PRODUT		:= QUERYSD2->D2_COD
					ZZV->ZZV_AUTOR		:= SZY->ZY_CODAUT
					ZZV->ZZV_EMISSA		:= QUERYSD2->D2_EMISSAO
					//ZZV->ZZV_DTPGCL
					//ZZV->ZZV_DTPGAU
					ZZV->ZZV_VALNF		:= QUERYSD2->D2_TOTAL
					//ZZV->ZZV_VALAUT
					//ZZV->ZZV_ALIQ
					ZZV->ZZV_PORC		:= SZY->ZY_PORC
					ZZV->ZZV_STATUS		:= "1" 		//1 = ABERTO, 2= PAGO CLIENTE, 3 = PAGO AUTOR, 4 = CANCELADO
					ZZV->ZZV_QTD		:= QUERYSD2->D2_QUANT
					ZZV->ZZV_MOEDA		:= SZY->ZY_MOEDA
					//ZZV->ZZV_DTCANC		:= MZZVDTCANC
					ZZV->ZZV_TPAUT			:= SA3->A3_TIPOVEN
					ZZV->ZZV_DESCON		:= (((QUERYSD2->D2_COMIS1 + QUERYSD2->D2_COMIS2 + QUERYSD2->D2_COMIS3 + QUERYSD2->D2_COMIS4 + QUERYSD2->D2_COMIS5) /100) * QUERYSD2->D2_TOTAL) //20061031
				MsUnlock()
			ELSE                        
				//JA EXITE 
			ENDIF                       
			DBSELECTAREA("SZY")
			DBSKIP()
		END                   
	ENDIF
	
   DBSELECTAREA("QUERYSD2")
   DBSKIP()
   INCREGUA()
ENDDO

DBSELECTAREA("FATPROD")
M_PAG   :=1
L       :=0
MSUBT   :=0
MPRODUTO:=' '

DBGOTOP()
SETREGUA(RECCOUNT())
DO WHILE .NOT. EOF()
   INCREGUA()
   IF MPRODUTO <> ' '
      IF MPRODUTO <> PRODUTO
         @ L,31   PSAY '------'
         @ L+1,15 PSAY 'TOTAL .......'
         @ L+1,31 PSAY MSUBT PICTURE "@E 999999" 
         MSUBT:=0
         L:=60
      ENDIF
   ENDIF

   IF L==0 .OR. L>59
      Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
      @ 8,00 PSAY "** PRODUTO: "
      @ 8,12 PSAY PRODUTO
      @ 8,27 PSAY DESCRIC
      L:=10
   ENDIF

   @ L,00 PSAY NUMNF  
   @ L,12 PSAY DTEMISS 
   @ L,23 PSAY NUMPED  
   @ L,31 PSAY QTDE
   @ L,39 PSAY NOMECLI                      

   MSUBT:=MSUBT+QTDE 
   MPRODUTO:=PRODUTO
   IF L>59
      L:=0
      M_PAG:=M_PAG+1
   ELSE
      L:=L+1
   ENDIF
   DBSKIP()
   INCREGUA()
ENDDO

@ L,31 PSAY '------'
L:=L+1
@ L,15 PSAY 'TOTAL .......'
@ L,31 PSAY MSUBT PICTURE "@E 999999"

SET DEVI TO SCREEN
DBCLOSEAREA()

/*IF aRETURN[5] ==1
   SET PRINTER TO
   DBCOMMITALL()
   OURSPOOL(WNREL)
ENDIF*/
MS_FLUSH()

DBSELECTAREA("QUERYSD2")
DBCLOSEAREA("QUERYSD2")
DBSELECTAREA("SF4")
RETINDEX("SF4")
DBSELECTAREA("SA1")
RETINDEX("SA1")
DBSELECTAREA("SB1")
RETINDEX("SB1")
RETURN
