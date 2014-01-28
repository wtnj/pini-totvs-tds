#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
//Danilo C S Pala 20060324: dados de enderecamento do DNE                             
//Danilo C S Pala 20060525: DESPESA COM BOLETO
//Danilo C S Pala 20100305: ENDBP
//*ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
//*º Programa    : DUPLF                                                       º
//*º Descricao   : Duplicatas de livros e assinaturas                          º
//*º Programador : Solange Nalini                                              º
//*º Data        : 10/01/98                                                    º
//*ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
User Function Pfat027()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,LIMITE,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CNATUREZA,ARETURN,UNINF,NOMEPROG")
SetPrvt("CPERG,NLASTKEY,LCONTINUA,NLIN,WNREL,NTAMNF")
SetPrvt("CSTRING,TREGS,M_MULT,P_ANT,P_ATU,P_CNT")
SetPrvt("M_SAV20,M_SAV7,XNFISCAL,XPEDIDO,XSERIE,XTIPOOP")
SetPrvt("VLRTOTA,XDUPL1,XDUPLD,DUPL_NUM,DUPL_EMIS,DUPL_PARC")
SetPrvt("DUPL_CLIE,DUPL_VALOR,DUPL_VENC,DUPL_LOJA,CLIE_CGC,CLIE_NOME")
SetPrvt("CLIE_INSC,CLIE_ENDE,CLIE_MUNI,CLIE_ESTA,CLIE_CEP,CLIE_TELX")
SetPrvt("CLIE_FONE,CLIE_INSCM,XENDC,XBAIRROC,XCIDADEC,XESTADOC")
SetPrvt("XCEPC,mhora")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Nota de                              ³
//³ mv_par02             // Nota ate                             ³
//³ mv_par03             // Serie                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
li        := 0
LIN       := 0
CbTxt     := ""
CbCont    := ""
nOrdem    := 0
Alfa      := 0
Z         := 0
M         := 0
tamanho   := "G"
limite    := 220
titulo    := PADC("Duplicatas ",74)
cDesc1    := PADC("Este programa ira emitir as Duplicatas de Livros e Assinaturas",74)
cDesc2    := ""
cDesc3    := ""
cNatureza := ""

aReturn   := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
UNINF     := 'UNI'
nomeprog  := "DUPASLI"

cPerg     := "FAT004"
nLastKey  := 0
IF !PERGUNTE(cPerg)
	RETURN
ENDIF

lContinua := .T.
nLin      := 0
MHORA      := TIME()
wnrel     := "DUPLASLI_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tamanho do Formulario de Nota Fiscal (em Linhas)          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTamNf:=36     // Apenas Informativo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas, busca o padrao da Duplicata         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.f.)               // Pergunta no SX1

cString:="SE1"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,,,.F.)

If nLastKey == 27
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica Posicao do Formulario na Impressora                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

Processa({|| P027Proc()})

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³P027Proc  ºAutor  ³Microsiga           º Data ³  03/30/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Processamento                                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function P027Proc()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Prepara regua de impressÆo                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DBSELECTAREA('SC6')
DBSETORDER(4)
DbSeek(xFilial("SC6")+MV_PAR01+MV_PAR03)

tregs := LastRec()-Recno()+1

ProcRegua(tregs)

IF !FOUND()
	RETURN
ENDIF

WHILE !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NOTA>=MV_PAR01 .AND. SC6->C6_NOTA<=MV_PAR02
	IncProc("Processando "+Alltrim(SC6->C6_NOTA))

	XNFISCAL :=SC6->C6_NOTA
	XPEDIDO  :=SC6->C6_NUM
	XSERIE   :=SC6->C6_SERIE

	IF XSERIE <> MV_PAR03
		DBSKIP()
		LOOP
	ELSE
		WHILE !Eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NOTA==XNFISCAL .AND. SC6->C6_SERIE==MV_PAR03
			DBSKIP()
			IF SC6->C6_NOTA # XNFISCAL
				DBSKIP(-1)
				EXIT
			ENDIF
		END
	ENDIF
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  Inicio do levantamento dos dados da Nota Fiscal             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DBSELECTAREA("SC5")
	DBSETORDER(1)
	If DBSEEK(XFILIAL()+XPEDIDO)
		XTIPOOP := SC5->C5_TIPOOP
		XPEDIDO := SC5->C5_NUM
		VLRTOTA := SC5->C5_VLRPED + SC5->C5_DESPREM + SC5->C5_DESPBOL //20060526
	ENDIF
	dbSelectArea("SZ9")
	dbSetOrder(1)
	DbSetOrder(2)
	If DbSeek(XTIPOOP)
		XDUPL1 := SZ9->Z9_DUPL1
		XDUPLD := SZ9->Z9_DUPLD                    
		IF SZ9->Z9_BOLETO1 ='S' .AND. SC5->C5_DESPBOL >0 //20060526 DAQUI
			VLRTOTA := VLRTOTA + SC5->C5_DESPBOL
		ENDIF
		IF SZ9->Z9_BOLETOD ='S' .AND. SC5->C5_DESPBOL >0
			VLRTOTA := VLRTOTA + (SC5->C5_DESPBOL * (SZ9->Z9_QTDEP -1))
		ENDIF //20060526 ATE AQUI
	ENDIF
	IF XDUPL1 == 'N'
		DbSelectArea("SC6")
		Dbskip()
		loop
	ENDIF
	
	dbSelectArea("SE1")
	DbOrderNickName("E1_PEDIDO") //dbSetOrder(27) 20130225  ///dbSetOrder(15) AP5 //20090114 era(21) //20090723 mp10 era(22) //dbSetOrder(26) 20100412
	Dbseek(xFilial()+xpedido)
	WHILE !Eof() .and. SE1->E1_FILIAL == xFilial("SE1") .and. XPEDIDO==SE1->E1_PEDIDO
		
		// NOVO -  VERIFICA SE A DUPL E DE PUBL, SE FORi IMPRIME, SENAO VERIFICA ...
		IF SC5->C5_DIVVEN=='PUBL'
			IMPDUPL()
		ELSE
			IF SE1->E1_PARCELA == 'A' .OR. SE1->E1_PARCELA==' '
				IMPDUPL()
			ENDIF
			IF SE1->E1_PARCELA # 'A' .AND. SE1->E1_PARCELA#' ' .AND. XDUPLD=='S'
				IMPDUPL()
			ENDIF
		ENDIF
		DBSKIP()
	END
	
	DbSelectArea("SC6")
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

set device to screen

IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IMPDUPL() ºAutor  ³Microsiga           º Data ³  03/30/02   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static FUNCTION IMPDUPL()
//*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
//*                 LEVANTAMENTO DE DADOS DA DUPLICATA                  *
//*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
DUPL_NUM     := E1_NUM
DUPL_EMIS    := E1_EMISSAO                         // DATA EMISSAO
DUPL_PARC    := E1_PARCELA
DUPL_CLIE    := E1_CLIENTE                         // CODIGO DO CLIENTE
DUPL_VALOR   := E1_VALOR
DUPL_VENC    := E1_VENCTO
IF SE1->E1_VENCTO<=SE1->E1_EMISSAO
	DUPL_VENC :='A VISTA'
ENDIF
DUPL_LOJA    := E1_LOJA

//*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
//*                          DADOS DOs CLIENTE                          *
//*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
DbSelectArea("Sa1")
DBSEEK(xFilial()+DUPL_CLIE+DUPL_LOJA)
CLIE_CGC     := SA1->A1_CGC           // GILBERTO
IF EMPTY(CLIE_CGC)                 // 12.01.2001
	CLIE_CGC := SA1->A1_CGCVAL       // Conforme necessidade do Sr. Cicero.
ENDIF
CLIE_NOME  := SA1->A1_NOME
CLIE_INSC  := SA1->A1_INSCR
CLIE_ENDE  := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060324
CLIE_MUNI  := SA1->A1_MUN
CLIE_ESTA  := SA1->A1_EST
CLIE_CEP   := SA1->A1_CEP
CLIE_TELX  := SA1->A1_TELEX
CLIE_FONE  := SA1->A1_TEL
CLIE_INSCM := SA1->A1_INSCRM

//*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
//*                          ENDERECO DE COBRANCA                     *
//*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
//20100305 DAQUI
IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
	DbSelectArea("ZY3")
	DbSetOrder(1)
	DbSeek(XFilial()+DUPL_CLIE+DUPL_LOJA)
	XENDC    :=ZY3_END
	XBAIRROC :=ZY3_BAIRRO
	XCIDADEC :=ZY3_CIDADE
	XESTADOC :=ZY3_ESTADO
	XCEPC    :=ZY3_CEP
ELSEIF SUBS(SA1->A1_ENDCOB,1,1)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
	DbSelectArea("SZ5")
	DbSetOrder(1)
	DbSeek(XFilial()+DUPL_CLIE+DUPL_LOJA)
	XENDC    := ALLTRIM(Z5_TPLOG)+ " " + ALLTRIM(Z5_LOGR) + " " + ALLTRIM(Z5_NLOGR) + " " + ALLTRIM(Z5_COMPL) //20060324
	XBAIRROC := SZ5->Z5_BAIRRO
	XCIDADEC := SZ5->Z5_CIDADE
	XESTADOC := SZ5->Z5_ESTADO
	XCEPC    := SZ5->Z5_CEP
ELSE
	XENDC    := ' '
	XBAIRROC := ' '
	XCIDADEC := ' '
	XESTADOC := ' '
	XCEPC    := ' '
ENDIF

//*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
//*                   IMPRESSAO DA NOTA FISCAL                 *
//*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
SET DEVICE TO PRINTER
@ LIN,005 psay ' '
@ LIN,062 psay DUPL_EMIS
LI += 3
@ LIN+LI,005 psay VLRTOTA  PICTURE '@E 999,999.99'
@ LIN+LI,020 psay DUPL_NUM
@ LIN+LI,030 psay DUPL_VALOR PICTURE '@E 999,999.99'
@ LIN+LI,046 psay DUPL_NUM+' '+DUPL_PARC
@ LIN+LI,059 psay DUPL_VENC
LI += 7
@ LIN+LI,018 psay CLIE_NOME                         // nome do cliente
@ LIN+LI,064 psay CLIE_FONE                         // fone do cliente
LI ++
@ LIN+LI,018 psay CLIE_ENDE                        // endereco do cliente
LI++
@ LIN+LI,018 psay CLIE_MUNI                         // cep do cliente
@ LIN+LI,042 psay CLIE_CEP                          // cep do cliente
@ LIN+LI,055 psay CLIE_ESTA                         // estado do cliente
@ LIN+LI,066 psay CLIE_TELX                         // data de emissao
LI++
@ LIN+LI,018 psay XENDC                         // data de emissao
LI++
@ LIN+LI,018 psay XCIDADEC                         // data de emissao
@ LIN+LI,065 psay XCEPC                         // data de emissao
@ LIN+LI,078 psay XESTADOC                        // data de emissao
LI++
@ LIN+LI,018 psay CLIE_CGC                         // inscricao estadual
@ LIN+LI,043 psay CLIE_INSC                         // inscricao estadual
@ LIN+LI,066 psay CLIE_INSCM
LI += 2
@ LIN+li,020 psay Subs(RTRIM(SUBS(EXTENSO(DUPL_VALOR),1,55)) + REPLICATE("*",54),1,54)
li++
@ LIN+li,020 psay Subs(RTRIM(SUBS(EXTENSO(DUPL_VALOR),56,55)) + REPLICATE("*",54),1,54)
li++
@ LIN+li,020 psay Subs(RTRIM(SUBS(EXTENSO(DUPL_VALOR),112,55)) + REPLICATE("*",54),1,54)
li++
@ LIN+li,020 psay Subs(RTRIM(SUBS(EXTENSO(DUPL_VALOR),168,55)) + REPLICATE("*",54),1,54)
LI++
@ LIN+LI,50 psay DUPL_CLIE
LI++
@ LIN+LI,00 psay ' '

SetPrc(0,0)
LIN := 14
LI  := 0

//SET DEVICE TO SCREEN
DbSelectArea("SE1")
RecLock("SE1",.F.)
SE1->E1_DUPLEM := 'S'
msUnlock()

return