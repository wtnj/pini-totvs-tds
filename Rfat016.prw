#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
User Function Rfat016()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
//alterado Por Danilo C S Pala em 20040715
//alterado por Danilo C S Pala em 20080708
//Danilo C S Pala 20100305: ENDBP
SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,LIMITE,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CNATUREZA,ARETURN,SERNF,NOMEPROG")
SetPrvt("CPERG,NLASTKEY,LCONTINUA,NLIN,WNREL,NTAMNF")
SetPrvt("CSTRING,TREGS,M_MULT,P_ANT,P_ATU,P_CNT")
SetPrvt("M_SAV20,M_SAV7,XNFISCAL,XPEDIDO,XSERIE,MVLRTOTA")
SetPrvt("XPREFIXO,XTIPOOP,XCODAG,XTPTRANS,XCODCLI,XENDC")
SetPrvt("XBAIRROC,XCIDADEC,XESTADOC,XCEPC,DUPL_NUM,DUPL_EMIS")
SetPrvt("DUPL_PARC,DUPL_CLIE,DUPL_VALOR,DUPL_VENC,VLRTOTA,DUPL_LOJA")
SetPrvt("CLIE_CGC,CLIE_NOME,CLIE_INSC,CLIE_ENDE,CLIE_MUNI,CLIE_ESTA")
SetPrvt("CLIE_CEP,CLIE_TELX,CLIE_FONE,CLIE_INSCM,MNOMEAG,NVALOR,XDIVVEN, Memp,mhora")

*иммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╩
*╨ Programa    : DUPLF                                                       ╨
*╨ Descricao   : Duplicatas                                                  ╨
*╨ Programador : Solange Nalini                                              ╨
*╨ Data        : 10/01/98                                                    ╨
*хммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis utilizadas para parametros                         Ё
//Ё mv_par01             // nfЁ
//Ё mv_par02             // nf   
 //Ё mv_par03            // serie |
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
li:=0
LIN:=0
CbTxt:=""
CbCont:=""
nOrdem :=0
Alfa := 0
Z:=0
M:=0
tamanho:="G"
limite:=220
titulo :=PADC("Duplicatas ",74)
cDesc1 :=PADC("Este programa ira emitir as Duplicatas de Livros e Assinaturas",74)
cDesc2 :=""
cDesc3 :=""
cNatureza:=""
aReturn := {"Especial",1,"Administracao",1, 2, 1,"",1 }
SERNF:='UNI' //ou PUB , mas estah var nao eh utilizada
nomeprog:="DUPLPUB"
cPerg:="RFAT16"
nLastKey:= 0
lContinua := .T.
nLin:=0
MHORA := TIME()
wnrel    := "DUPLPUB"
Memp := SM0->M0_CODIGO

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Tamanho do Formulario de Nota Fiscal (em Linhas)          Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
nTamNf:=36     // Apenas Informativo

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica as perguntas selecionadas, busca o padrao da Duplicata         Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
Pergunte(cPerg,.T.)               // Pergunta no SX1

cString:="SE1"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Envia controle para a funcao SETPRINT                        Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)

If nLastKey == 27
	Return
Endif

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Verifica Posicao do Formulario na Impressora                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

Processa({|| R016Proc()})

Return

Static Function R016Proc()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё  Prepara regua de impressфo                                  Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
tregs := LastRec()-Recno()+1

DBSELECTAREA("SD2")
DbGotop()
DBSETORDER(3)
//DBSEEK(XFILIAL("SD2")+Padr(Alltrim(MV_PAR01),6),.t.) 20040630
DBSEEK(XFILIAL("SD2")+Padr(Alltrim(MV_PAR01),9)+MV_PAR03,.t.)     //20090803 mp10

IF !FOUND()
	RETURN
ENDIF

ProcRegua(tregs)

WHILE !Eof() .and. SD2->D2_FILIAL == xFilial("SD2") .and. SD2->D2_DOC >= MV_PAR01 .AND. SD2->D2_DOC <= MV_PAR02
	
	IncProc("Lendo Titulo "+Alltrim(SD2->D2_SERIE+SD2->D2_DOC))
	/* 20/01/03 RAQUEL: COMENTADO PARA VIABILIZAR A EMISSAO DE DUPLICATAS P/ BP.
	IF SUBS(SD2->D2_PEDIDO,6,1)#'P'
		DBSKIP()
		LOOP
	ENDIF
	*/
	XNFISCAL := SD2->D2_DOC
	XPEDIDO  := SD2->D2_PEDIDO
	XSERIE   := SD2->D2_SERIE
	WHILE SD2->D2_DOC == XNFISCAL
		DBSKIP()
		IF SD2->D2_DOC # XNFISCAL .OR. SD2->D2_SERIE # XSERIE
			DBSKIP(-1)
			EXIT
		ENDIF
	END
	
	DBSELECTAREA("SF2")
	DBSETORDER(1)
	IF DBSEEK(XFILIAL("SD2")+SD2->D2_DOC+XSERIE)
		MVLRTOTA:=SF2->F2_VALBRUT
		XPREFIXO:=SF2->F2_PREFIXO
	ENDIF
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё  Inicio do levantamento dos dados da Nota Fiscal             Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	DBSELECTAREA("SC5")
	DBSETORDER(1)
	DBSEEK(XFILIAL("SC5")+XPEDIDO)
	IF FOUND()
		XTIPOOP  := SC5->C5_TIPOOP
		XPEDIDO  := SC5->C5_NUM         
		if memp <> '02' //20040715
			xcodag   := SC5->C5_CODAG
			XTPTRANS := SC5->C5_TPTRANS
		endif
		XCODCLI  := SC5->C5_CLIENTE
		XDIVVEN  := SC5->C5_DIVVEN
	ENDIF
   	
	dbSelectArea("SE1")
	DbSetOrder(1)
	Dbseek(xFilial("SE1")+XPREFIXO+SD2->D2_DOC)
//	IF XDIVVEN<>MV_PAR03 .OR. (SE1->E1_SERIE<>'UNI' .AND. SE1->E1_SERIE<>'PUB') .OR. SE1->E1_SITUA=='2'     200040706
	IF (SE1->E1_SERIE<>'UNI' .AND. SE1->E1_SERIE<>'PUB'.AND. SE1->E1_SERIE<>'SEN') .OR. SE1->E1_SITUA=='2'
		DBSELECTAREA("SD2")
		DBSKIP()
		LOOP
	ENDIF
	//ATENCAO SO PRA DESCONTOS
	//          IF SE1->E1_VALOR>930
	//
	//          DbSelectArea("SC6")
	//             Dbskip()
	//            loop
	//          ENDIF
	//          IF SE1->E1_VALOR<910
	//
	//           DbSelectArea("SC6")
	//             Dbskip()
	//            loop
	//          ENDIF
	
	// IF SE1->E1_PORTADO=='577'       //TIRA OS QUE FORAM PARA DESCONTO   20/01/03 RAQUEL: A COBRANCA TRANSFERE O TITULO PARA DESCONTO.
    //TIRA OS QUE FORAM PARA DESCONTO	
	///	DbSelectArea("SF2")
	//	Dbskip()
	//	loop
	//ENDIF
	
	WHILE XPEDIDO == SE1->E1_PEDIDO
		IMPDUPL()
		DBSKIP()
	END
	
	DbSelectArea("SD2")
	Dbskip()
	loop
END

DbSelectArea("SC6")
Retindex("SC6")

DbSelectArea("SC5")
Retindex("SC5")

DbSelectArea("SA1")
Retindex("SA1")

DbSelectArea("SZ5")
Retindex("SZ5")

DbSelectArea("SE1")
Retindex("SE1")

DbSelectArea("SZ9")
Retindex("SZ9")

DbSelectArea("SD2")
Retindex("SD2")

set device to screen
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()

Return

Static FUNCTION IMPDUPL()
//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
//*                 LEVANTAMENTO DE DADOS DA DUPLICATA                  *
//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
XENDC   :=' '
XBAIRROC:=' '
XCIDADEC:=' '
XESTADOC:=' '
XCEPC   :=' '
DBSELECTAREA("SE1")

DUPL_NUM   := SE1->E1_NUM
DUPL_EMIS  := SE1->E1_EMISSAO                         && DATA EMISSAO
DUPL_PARC  := SE1->E1_PARCELA
DUPL_CLIE  := SE1->E1_CLIENTE                         && CODIGO DO CLIENTE
DUPL_VALOR := SE1->E1_VALOR
DUPL_VENC  := SE1->E1_VENCTO
VLRTOTA    := SE1->E1_VALOR
IF SE1->E1_VENCTO <= SE1->E1_EMISSAO
	DUPL_VENC := 'A VISTA'
ENDIF
DUPL_LOJA  := SE1->E1_LOJA

//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
//*                          DADOS DO CLIENTE                          *
//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
DbSelectArea("Sa1")
DBSEEK(xFilial()+DUPL_CLIE+DUPL_LOJA)
IF VAL(SA1->A1_CGC)==0
	CLIE_CGC  := SA1->A1_CGCVAL
ELSE
	CLIE_CGC := SA1->A1_CGC
ENDIF
CLIE_NOME := SA1->A1_NOME
CLIE_INSC := SA1->A1_INSCR
CLIE_ENDE := SA1->A1_END
CLIE_MUNI := SA1->A1_MUN
CLIE_ESTA := SA1->A1_EST
CLIE_CEP  := SUBS(SA1->A1_CEP,1,5)+'-'+SUBS(SA1->A1_CEP,6,3)
CLIE_TELX := SA1->A1_TELEX
CLIE_FONE := SA1->A1_TEL
CLIE_INSCM:= SA1->A1_INSCRM
//20100305 DAQUI
IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
	DbSelectArea("ZY3")
	DbSetOrder(1)
	DbSeek(XFilial()+dupl_clie+dupl_loja)
	XENDC 	 :=ZY3_END
	XBAIRROC :=ZY3_BAIRRO
	XCIDADEC :=ZY3_CIDADE
	XESTADOC :=ZY3_ESTADO
	XCEPC    :=ZY3_CEP 
ELSEIF TRIM(SA1->A1_ENDCOB)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
	DbSelectArea("SZ5")
	DbSetOrder(1)
	DbSeek(XFilial()+dupl_clie+dupl_loja)
	IF FOUND()
		XENDC    := SZ5->Z5_END
		XBAIRROC := SZ5->Z5_BAIRRO
		XCIDADEC := SZ5->Z5_CIDADE
		XESTADOC := SZ5->Z5_ESTADO
		XCEPC    := SUBS(SZ5->Z5_CEP,1,5)+'-'+SUBS(SZ5->Z5_CEP,6,3)
	ELSE
		XENDC    := ' '
		XBAIRROC := ' '
		XCIDADEC := ' '
		XESTADOC := ' '
		XCEPC    := ' '
	ENDIF
ELSE
	XENDC    := ' '
	XBAIRROC := ' '
	XCIDADEC := ' '
	XESTADOC := ' '
	XCEPC    := ' '
ENDIF
MNOMEAG := '  '   
if memp <> '02' //20040715
IF XTPTrans == "04" .OR. XTPTRANS == '12'
	dbselectarea("SA1")
	If dbseek(xfilial()+XCodag)
		MNOMEAG:=' -  A/C '+ SA1->A1_NOME
	ENDIF
	IF SUBS(SA1->A1_ENDCOB,1,1)=='S'
		DbSelectArea("SZ5")
		DbSetOrder(1)
		If DbSeek(XFilial()+XCodAG)
			XENDC    := SZ5->Z5_END
			XBAIRROC := SZ5->Z5_BAIRRO
			XCIDADEC := SZ5->Z5_CIDADE
			XESTADOC := SZ5->Z5_ESTADO
			XCEPC    := SUBS(SZ5->Z5_CEP,1,5)+'-'+SUBS(SZ5->Z5_CEP,6,3)
		ELSE
			XENDC    := SA1->A1_END
			XBAIRROC := SA1->A1_BAIRRO
			XCIDADEC := SA1->A1_MUN
			XESTADOC := SA1->A1_EST
			XCEPC    := SUBS(SA1->A1_CEP,1,5)+'-'+SUBS(SA1->A1_CEP,6,3)
		ENDIF
	ELSE
		XENDC    := SA1->A1_END
		XBAIRROC := SA1->A1_BAIRRO
		XCIDADEC := SA1->A1_MUN
		XESTADOC := SA1->A1_EST
		XCEPC    := SUBS(SA1->A1_CEP,1,5)+'-'+SUBS(SA1->A1_CEP,6,3)
	ENDIF
ENDIF
endif // 20070715
//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*
//*                   IMPRESSAO DA NOTA FISCAL                 *
//*дддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд*

@ LIN,05 PSAY ' '
@ LIN   ,062 PSAY DUPL_EMIS
LI:=LI+3
NVALOR:=VLRTOTA
@ LIN+LI,005 PSAY MVLRTOTA   PICTURE '@E 999,999.99'
@ LIN+LI,020 PSAY DUPL_NUM
@ LIN+LI,030 PSAY NVALOR  PICTURE '@E 999,999.99'
@ LIN+LI,046 PSAY DUPL_NUM+' '+DUPL_PARC
@ LIN+LI,059 PSAY DUPL_VENC
LI:=LI+7
@ LIN+LI,018 PSAY TRIM(CLIE_NOME)+ '  '+MNOMEAG
LI:=LI+1
@ LIN+LI,018 PSAY CLIE_ENDE
@ LIN+LI,058 PSAY 'Fone: ' +CLIE_FONE
LI:=LI+1
@ LIN+LI,018 PSAY CLIE_MUNI                         && cep do cliente
@ LIN+LI,042 PSAY CLIE_CEP                          && cep do cliente
@ LIN+LI,055 PSAY CLIE_ESTA                         && estado do cliente
@ LIN+LI,066 PSAY CLIE_TELX                         && data de emissao
LI:=LI+1
@ LIN+LI,018 PSAY XENDC                         && data de emissao
LI:=LI+1
@ LIN+LI,018 PSAY XCIDADEC                         && data de emissao
@ LIN+LI,065 PSAY XCEPC                         && data de emissao
@ LIN+LI,078 PSAY XESTADOC                        && data de emissao
LI:=LI+1
@ LIN+LI,018 PSAY CLIE_CGC                         && inscricao estadual
@ LIN+LI,043 PSAY CLIE_INSC                         && inscricao estadual
@ LIN+LI,066 PSAY CLIE_INSCM
LI:=LI+2
@ LIN+li,020 PSAY Subs(RTRIM(SUBS(EXTENSO(NVALOR),1,55)) + REPLICATE("*",54),1,54)
li:= li + 1
@ LIN+li,020 PSAY Subs(RTRIM(SUBS(EXTENSO(NVALOR),56,55)) + REPLICATE("*",54),1,54)
li:= li + 1
@ LIN+li,020 PSAY Subs(RTRIM(SUBS(EXTENSO(NVALOR),112,55)) + REPLICATE("*",54),1,54)
li:= li + 1
@ LIN+li,020 PSAY Subs(RTRIM(SUBS(EXTENSO(NVALOR),168,55)) + REPLICATE("*",54),1,54)
LI:=LI+2
@ LIN+LI,50 PSAY DUPL_CLIE          
if Memp <>'02'   //20040715
	@ LIN+LI,60 PSAY XTPTRANS +'/'+ XPEDIDO
else 
	@ LIN+LI,60 PSAY XPEDIDO
endif //20040715
LI:=LI+2
@ LIN+LI,00 PSAY ' '

SetPrc(0,0)
liN := 12
@ LIN,00 PSAY ' '
LI:=0

//                SET DEVI TO SCREEN

DbSelectArea("SE1")
RecLock("SE1",.F.)
replace E1_DUPLEM WITH 'S'

MSUnlock()

return