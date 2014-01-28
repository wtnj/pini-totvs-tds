#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/* Alterado por Danilo C S Pala em 20050603   
//Danilo C S Pala 20060328: dados de enderecamento do DNE, O endereco sera truncado conforme ciencia da Sandra Cecyn
//Danilo C S Pala 20060526: DESPESA COM BOLETO
//Danilo C S Pala 20100305: ENDBP
//Danilo C S Pala 20121018: cliente (Cicero) 
*浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
*� Programa    : LOTEFAT                                                     �
*� Descricao   : Lotes de Assinaturas e Livros                               �
*� Programador : Solange Nalini                                              �
*� Data        : 10/01/98                                                    �
*藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
*/
User Function Pfat009()     // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CBTXT,CBCONT,CABEC1,CABEC2,CTITULO,M_PAG")
SetPrvt("NCARACTER,TAMANHO,LIMITE,TITULO,CDESC1,CDESC2")
SetPrvt("CDESC3,ARETURN,SERNF,NOMEPROG,CPERG,NLASTKEY")
SetPrvt("LCONTINUA,WNREL,NTAMNF,CSTRING,TREGS,M_MULT")
SetPrvt("P_ANT,P_ATU,P_CNT,M_SAV20,M_SAV7,XREMESSA,XTOTREM")
SetPrvt("XQTDEP,XVLRFAT,XVLRPGO,XVLRCCD,L,XPEDINF,XTOTAL")
SetPrvt("XTOTINF,XPGOINF,XFATINF,XCCDINF,XPEDDIG,NOVAPAG")
SetPrvt("XPARCA,XPARCB,XPARCC,XPARCD,XPARCE,XPARCF,XREMINF")
SetPrvt("XPARC2,XDATA2,XPARC3,XDATA3,XPARC4,XDATA4")
SetPrvt("XPARC5,XDATA5,XPARC6,XDATA6,XVLRITEM,XVLRTITEM")
SetPrvt("XCLIENTE,XLOJACLI,XCONDPAG,XVEND1,XPEDIDO,XCODPROM")
SetPrvt("XTIPOOP,XDTCALC,XLOTEFAT,XDATA,XPARC1,XDATA1")
SetPrvt("XPAGA1,XPAGAD,XDESNF,XCODFAT,XNATOP,XNOMECLI")
SetPrvt("XENDCLI,XBAIRROCLI,XMUNCLI,XESTCLI,XCEPCLI,XTELCLI")
SetPrvt("XFAXCLI,XCGCCLI,XINSCRCLI,XINSCRMCLI,XCLIFAT,XLOJAFAT")
SetPrvt("XNOMECFA,XENDCLFA,XBAIRROCFA,XMUNCFA,XESTCFA,XCEPCFA")
SetPrvt("XTELCFA,XFAXCFA,XCGCCFA,XINSCRCFA,XINSCRMCFA,XVEND")
SetPrvt("XENDC,XBAIRROC,XCIDADEC,XESTC,XCEPC,MPRODUTO")
SetPrvt("MDESCRICAO,XCODDEST,XNOMEDEST,MENDEST,XBOLETO, XTOTBOL, MHORA")
//敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Lote                                 �
//� mv_par02             // Data                                 �
//青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰
//++++++++++++++++++++++++++++++++++++++
// Cabecalho e rodape
//++++++++++++++++++++++++++++++++++++++
cbtxt     := SPACE(10)
cbcont    := 0
cabec1    := " "
cabec2    := " "
cTitulo   := " RELATORIO DOS LOTES DE FATURAMENTO "
M_PAG     := 1
NCARACTER := 12
tamanho   := "M"
limite    := 132
titulo    := "LOTES DE FATURAMENTO "
cDesc1    := "Este programa ira emitir os Lotes de Faturamento de Livros e Assinaturas"
cDesc2    := ""
cDesc3    := ""

aReturn   := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
SERNF     := 'UNI'
nomeprog  := "LOTEFAT"

cPerg     := "FAT001"
nLastKey  := 0

lContinua := .T.
MHORA      := TIME()
wnrel     := "LOTEFAT_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

//敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�
//� Tamanho do Formulario (em Linhas)                         �
//青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�
nTamNf    := 50     // Apenas Informativo

//敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�
//� Verifica as perguntas selecionadas                                      �
//青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�
Pergunte(cPerg,.T.)               // Pergunta no SX1
cString   :="SC5"

//敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
//� Envia controle para a funcao SETPRINT                        �
//青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰
wnrel     := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
	Return
Endif

//敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
//� Verifica Posicao do Formulario na Impressora                 �
//青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

Processa({|| P009Proc()})

Return
/*
樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛�
臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼�
臼浜様様様様用様様様様様僕様様様冤様様様様様様様様様曜様様様冤様様様様様様傘�
臼�Programa  �PFAT009   �Autor  �Microsiga           � Data �  03/30/02   艮�
臼麺様様様様謡様様様様様瞥様様様詫様様様様様様様様様擁様様様詫様様様様様様恒�
臼�Desc.     �Processamento do relatorio                                  艮�
臼�          �                                                            艮�
臼麺様様様様謡様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様恒�
臼�Uso       � AP5                                                        艮�
臼藩様様様様溶様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様識�
臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼�
烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝�
*/
Static Function P009Proc()

//敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
//�  Prepara regua de impress�o                                  �
//青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰
XTOTAL    := 0  
XREMESSA  := 0 
XTOTBOL   := 0
XREMINF   := 0 
XTOTREM   := 0
XQTDEP    := 0
XVLRFAT   := 0
XVLRPGO   := 0
XVLRCCD   := 0
L         := 0
DBSELECTAREA("SZ6")
DBSEEK(xFILIAL()+MV_PAR01+DTOS(MV_PAR03))
XPEDINF := SZ6->Z6_QTDEPED
XTOTINF := SZ6->Z6_VALOR
XPGOINF := SZ6->Z6_VLRPGTO
XFATINF := SZ6->Z6_VLRFAT
XCCDINF := SZ6->Z6_VLRCCD
XPEDDIG := 0

// 13/05/02 Criacao do array para resumo dos pedidos
_aPed := {}
// 13/05/02 fim

DbSelectArea("SC5")
DbSetOrder(8)
DbSeek(xFilial("SC5")+MV_PAR01+dtos(MV_PAR03))
tregs  := LastRec()-Recno()+1
ProcRegua(tregs)
NOVAPAG    := .T.
lPrimRod   := .F.
While !Eof() .and. SC5->C5_FILIAL == xFilial("SC5") .and. SC5->C5_LOTEFAT == MV_PAR01 .and. DTOS(SC5->C5_DATA) == DTOS(MV_PAR03)
	IncProc("Listando Pedido " + Alltrim(SC5->C5_NUM))
   /* if SM0->M0_CODIGO = "03"
//		 NOVAPAG  := .T. //20031117 //20040804
	endif*/ //20040804
	XPARCA   := 'A'
	XPARCB   := 'B'
	XPARCC   := 'C'
	XPARCD   := 'D'
	XPARCE   := 'E'
	XPARCF   := 'F'
	XPARC2   := 0
	XDATA2   := CTOD('  /  /  ')
	XPARC3   := 0
	XDATA3   := CTOD('  /  /  ')
	XPARC4   := 0
	XDATA4   := CTOD('  /  /  ')
	XPARC5   := 0
	XDATA5   := CTOD('  /  /  ')
	XPARC6   := 0
	XDATA6   :=CTOD('  /  /  ')
	XVLRITEM :=0
	XVLRTITEM:=0
	IF NOVAPAG
		L := CABEC(CTITULO,CABEC1,CABEC2,NOMEPROG,TAMANHO,NCARACTER)
		L += 2
		@ L,000 PSAY '* LOTE : ' +MV_PAR01 +   '   DATA: '+DTOC(MV_PAR03)
		@ L,030 PSAY 'DIGITADO POR: ' + SC5->C5_USUARIO
		@ L,131 PSAY '*'
		LINHA()
		@ L,000 PSAY REPLICATE('*',132)
		LINHA()
		@ L,000 PSAY '| PEDIDO'
		@ L,008 PSAY '|  DADOS GERAIS DO PEDIDO'
		@ l,131 PSAY '|'
		LINHA()
		@ L,000 PSAY '|'+ REPLICATE('-',130)+'|'
		LINHA()
		NOVAPAG:=.F.
	ENDIF
	XCLIENTE  :=  SC5->C5_CLIENTE                  
	XLOJACLI  :=  SC5->C5_LOJACLI
	XCONDPAG  :=  SC5->C5_CONDPAG
	XVEND1    :=  SC5->C5_VEND1
	XPEDIDO   :=  SC5->C5_NUM
	XCODPROM  :=  SC5->C5_CODPROM
	XTIPOOP   :=  SC5->C5_TIPOOP
	XDTCALC   :=  SC5->C5_DTCALC
	XLOTEFAT  :=  SC5->C5_LOTEFAT
	XDATA     :=  SC5->C5_DATA
	XPARC1    :=  SC5->C5_PARC1
	XDATA1    :=  SC5->C5_DATA1
	XREMESSA  :=  SC5->C5_DESPREM         // 09/08/02
	XBOLETO   := 0 //20060526
		
	IF SC5->C5_PARC2>0
		XPARC2 := SC5->C5_PARC2
		XDATA2 := SC5->C5_DATA2
	ENDIF
	IF SC5->C5_PARC3>0
		XPARC3 := SC5->C5_PARC3
		XDATA3 := SC5->C5_DATA3
	ENDIF
	IF SC5->C5_PARC4>0
		XPARC4 := SC5->C5_PARC4
		XDATA4 := SC5->C5_DATA4
	ENDIF
	IF SC5->C5_PARC5>0
		XPARC5 := SC5->C5_PARC5
		XDATA5 := SC5->C5_DATA5
	ENDIF
	IF SC5->C5_PARC6>0
		XPARC6 := SC5->C5_PARC6
		XDATA6 := SC5->C5_DATA6
	ENDIF
	
	XPEDDIG++
	dbSelectArea("SZ9")
	dbSetOrder(2)
	dbSeek(Xtipoop)
	XPAGA1  := SZ9->Z9_PAGA1
	XPAGAD  := SZ9->Z9_PAGAD
	xDESNF  := SZ9->Z9_DESCR
	xCODFAT := SZ9->Z9_CODFAT
	IF SZ9->Z9_BOLETO1 ='S' .AND. SC5->C5_DESPBOL >0 //20060526 DAQUI
		XBOLETO := SC5->C5_DESPBOL
	ENDIF
	IF SZ9->Z9_BOLETOD ='S' .AND. SC5->C5_DESPBOL >0
		XBOLETO := XBOLETO + (SC5->C5_DESPBOL * (SZ9->Z9_QTDEP -1))
	ENDIF //20060526 ATE AQUI
	
	// 13/05/02 Gravacao de array com informacoes do pedido - inicio
	AADD(_aPed, {SC5->C5_CLIENTE, SC5->C5_NUM, SC5->C5_VLRPED, SC5->C5_DESPREM, XBOLETO, SC5->C5_TIPOOP}) //cliente 20121018
	// 13/05/02 fim            

	
	IF XPAGA1 == 'S'
		IF TRIM(xCODFAT)=='AVCC' .OR. TRIM(XCODFAT)=='1CCDB' .OR. SUBS(SZ9->Z9_TIPOOP,1,1)=='C'
			XVLRCCD := XVLRCCD+XPARC1
		ELSE
			XVLRPGO := XVLRPGO+XPARC1
		ENDIF
	ELSE
		XVLRFAT := XVLRFAT+XPARC1
	ENDIF
	IF XPAGAD == 'S'
		IF SUBS(SZ9->Z9_TIPOOP,1,1) == 'C'
			XVLRCCD := XVLRCCD+XPARC2+XPARC3+XPARC4+XPARC5+xparc6
		ELSE
			XVLRPGO := XVLRPGO+XPARC2+XPARC3+XPARC4+XPARC5+xparc6
		ENDIF
	ELSE
		XVLRFAT := XVLRFAT+XPARC2+XPARC3+XPARC4+XPARC5+xparc6
	ENDIF
	XTOTAL     := XTOTAL+XPARC1+XPARC2+XPARC3+XPARC4+XPARC5+xparc6
	XTOTREM    := XREMESSA+XTOTREM                                       // 09/08/02
	XTOTBOL    := XBOLETO + XTOTBOL

	xnatop := '511'
	
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek(xFilial()+xCLIENTE+xLOJACLI)
	XNOMECLI   := SA1->A1_NOME
	XENDCLI    := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060328
	XBAIRROCLI := SA1->A1_BAIRRO
	XMUNCLI    := SA1->A1_MUN
	XESTCLI    := SA1->A1_EST
	XCEPCLI    := SA1->A1_CEP
	XTELCLI    := SA1->A1_TEL
	XFAXCLI    := SA1->A1_FAX
	IF SA1->A1_CGC==' '
		XCGCCLI:= SA1->A1_CGCVAL
	ELSE
		XCGCCLI:= SA1->A1_CGC
	ENDIF
	XINSCRCLI  := SA1->A1_INSCR
	XINSCRMCLI := SA1->A1_INSCRM
	XCLIFAT    := SA1->A1_CLIFAT
	If xCLIFAT # ' '
		dbSeek(xFilial()+xCLIFAT)
		XLOJAFAT   := SA1->A1_LOJA
		XNOMECFA   := SA1->A1_NOME
		XENDCLFA   := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060328
		XBAIRROCFA := SA1->A1_BAIRRO
		XMUNCFA    := SA1->A1_MUN
		XESTCFA    := SA1->A1_EST
		XCEPCFA    := SA1->A1_CEP
		XTELCFA    := SA1->A1_TEL
		XFAXCFA    := SA1->A1_FAX
		IF SA1->A1_CGC == ' '
			XCGCCFA := SA1->A1_CGCVAL
		ELSE
			XCGCCFA := SA1->A1_CGC
		ENDIF
		XINSCRCFA    := SA1->A1_INSCR
		XINSCRMCFA   := SA1->A1_INSCRM
	ENDIF
	dbSelectArea("SA3")
	dbSetOrder(1)
	dbSeek(xFilial()+xVend1)
	XVEND := SA3->A3_NOME
	
	dbSelectArea("SZ5")
	dbSetOrder(1)
	IF XCLIFAT==SPACE(6)
		dbSeek(xFilial()+xCLIENTE+xLOJACLI)
	ELSE
		dbSeek(xFilial()+xCLIFAT+xLOJAFAT)
	ENDIF
	If found() .AND. SM0->M0_CODIGO <>"03"  //20100305
		xENDC    := ALLTRIM(SZ5->Z5_TPLOG)+ " " + ALLTRIM(SZ5->Z5_LOGR) + " " + ALLTRIM(SZ5->Z5_NLOGR) + " " + ALLTRIM(SZ5->Z5_COMPL) //20060328
		xBAIRROC := SZ5->Z5_BAIRRO
		xCIDADEC := SZ5->Z5_CIDADE
		xBAIRROC := SZ5->Z5_BAIRRO
		XESTC    := SZ5->Z5_ESTADO
		xCEPC    := SZ5->Z5_CEP
	Else
		xENDC    := " "
		xBAIRROC := " "
		xCIDADEC := " "
		xBAIRROC := " "
		XESTC    := ' '
		xCEPC    := " "
	Endif
	
	//20100305 DAQUI
	DbSelectArea("ZY3")
	DbSetOrder(1)
	IF XCLIFAT==SPACE(6)
		dbSeek(xFilial()+xCLIENTE+xLOJACLI)
	ELSE
		dbSeek(xFilial()+xCLIFAT+xLOJAFAT)
	ENDIF
	If found() .AND. SM0->M0_CODIGO =="03"
		xENDC    := ZY3->ZY3_END
		xBAIRROC := ZY3->ZY3_BAIRRO
		xCIDADEC := ZY3->ZY3_CIDADE
		xBAIRROC := ZY3->ZY3_BAIRRO
		XESTC    := ZY3->ZY3_ESTADO
		xCEPC    := ZY3->ZY3_CEP
	Endif //20100305 ATE AQUI
	
	@ L, 00 PSAY '| '+XPEDIDO
	@ L, 08 PSAY '| Cliente....: '
	@ L, 23 PSAY XNOMECLI
	
	@ L,68 PSAY '| END.COBR..: '
	@ L,82 PSAY substr(XENDC,1,48)
	@ L,131 PSAY '|'
	LINHA()
	@ L, 00 PSAY '| '+XCLIENTE
	@ L,08 PSAY '| Endereco..: '
	@ l,23 PSAY substr(XENDCLI,1,44)
	@ l,68 PSAY '|'
	@ l,82 PSAY 'Bairro..: '+trim(xbairroc)
	@ L,132 PSAY '|'
	LINHA()
	@ l,00 PSAY '|'
	@ L,08 PSAY '| Bairro....: '
	@ l,23 PSAY TRIM(XBAIRROCLI)
	@ l,68 PSAY '|'
	@ l,82 PSAY 'Cidade..:'+ trim(xcidadec) + ' ' +xestc+'  Cep..: '+xcepc
	@ l,132 PSAY '|'
	LINHA()
	@ l,00 PSAY '|'
	@ l,08 PSAY '| Cidade....: '
	@ l,23 PSAY  xmuncli + ' ' + xestcli +'   Cep..: '+ xcepcli
	@ l,68 PSAY '| Vend....: '
	@ l,82 PSAY  TRIM(xvend1)+'-'+SUBS(xvend,1,24) +' DT.CALC.:'+DTOC(XDTCALC)
	@ l,132 PSAY '|'
	LINHA()
	
	@ L, 00 PSAY '| '+XCODPROM
	//  @ l,00 PSAY '|'
	@ l,08 PSAY '| C.G.C.....: '
	@ L,23 PSAY XCGCCLI
	@ l,68 PSAY '|'
	@ l,132 PSAY '|'
	LINHA()
	@ l,00 PSAY '|'
	@ l,08 PSAY '| Inscr.Est.: '
	@ L,23 PSAY XINSCRCLI+'  I.MUN:'+XINSCRMCLI
	@ l,68 PSAY '| NAT.OPER: '
	@ l,82 PSAY  xnatop + ' Tipo Oper.: '+ xtipoop + ' Cond.Pagto.: '+ xcondpag
	@ l,132 PSAY '|'
	LINHA()
	@ l,00 PSAY '|'
	@ l,08 PSAY '| Resp. Cob.: '+SC5->C5_RESPCOB
	@ l,132 PSAY '|'
	LINHA()
	@ l,00 PSAY '|'
	@ l,08 PSAY '| Mens.Nota.: '+SUBSTR(SC5->C5_MENNOTA,1,100)
	@ l,132 PSAY '|'
	LINHA()
	@ l,00 PSAY '|'+replicate('-',130)+'|'
	LINHA()
	IF XCLIFAT # ' '
		@ L,00 PSAY "|"
		@ L,02 PSAY 'Fat.em nome de: ' + XCLIFAT+' ' +XNOMECFA
		@ l,132 PSAY '|'
		LINHA()
		@ L,00 PSAY "|"
		@ L,02 PSAY 'Endere�o......: ' +substr(xENDCLFA,1,45)+' -  ' +xBairroCFA +' - '+XMUNCFA+' - ' + XCEPCFA+' - ' +XESTCFA
		@ l,132 PSAY '|'
		LINHA()
		@ L,00 PSAY "|"
		@ L,02 PSAY 'CGC/CPF.......: ' +XCGCCFA
		@ L,45 PSAY 'I.EST..: ' +XINSCRCFA
		@ L,76 PSAY 'I.MUN..: ' +XINSCRMCFA
		@ l,132 PSAY '|'
		LINHA()
	ENDIF
	@ L,000 PSAY '|ITEM'
	@ L,005 PSAY '|PRODUTO'
	@ L,014 PSAY '|DESCRICAO'
	@ L,045 PSAY '|TES'
	@ L,049 PSAY '|NAT.OP'
	@ L,057 PSAY '|QTDE'
	@ L,062 PSAY '|V.UNIT.'
	@ L,075 PSAY '| V.TOTAL'
	@ L,088 PSAY '|EDINI'
	@ L,094 PSAY '|EDFIN'
	@ L,100 PSAY '|AL'  //20090330
	@ L,103 PSAY '|REV'
	@ L,107 PSAY '|SCC'
	@ L,111 PSAY '|TP'
	@ L,114 PSAY '|PEDREN'
	@ L,121 PSAY '|'
	@ L,122 PSAY 'PEDANT-IT'
	@ L,132 PSAY '|'
	LINHA()
	@ L,00 PSAY '|'+replicate('-',130)+'|'
	LINHA()
	dbSelectArea("SC6")
	DbOrderNickName("C6_CLI") //dbSetOrder(10) 20130225
	dbSeek(xFilial()+xCliente+xPedido)
	while !eof() .and. SC6->C6_FILIAL == xFilial("SC6") .and. SC6->C6_NUM == XPEDIDO .AND. SC6->C6_CLI == XCLIENTE
		IF SC6->C6_CLI # XCLIENTE .OR. SC6->C6_NUM # XPEDIDO
			Dbskip()
			Loop
		ENDIF
		MPRODUTO   := SC6->C6_PRODUTO
		DBSELECTAREA("SB1")
		DBSEEK(XFILIAL()+MPRODUTO)
		MDESCRICAO := SB1->B1_DESC
		
		IF L>55
			Roda(0,"",tamanho)
			//SETPRC(0,0)
			//L := 0
			//L := PROW()
			L := CABEC(CTITULO,CABEC1,CABEC2,NOMEPROG,TAMANHO,NCARACTER)
			L += 2
	    EndIf
		
		@ L,00 PSAY '|'
		@ L,02 PSAY SC6->C6_ITEM
		@ L,05 PSAY '|'
		@ L,06 PSAY SUBSTR(SC6->C6_PRODUTO,1,8)
		@ L,15 PSAY '|'
		@ L,16 PSAY SUBSTR(MDESCRICAO,1,27)
		@ L,45 PSAY '|'
		@ L,46 PSAY SC6->C6_TES
		@ L,49 PSAY '|'
		@ L,50 PSAY ALLTRIM(sc6->c6_cf)      // ACERTAR A PERGUNTA
		@ L,57 PSAY '|'
		@ L,58 PSAY SC6->C6_QTDVEN PICTURE '9999'
		@ L,62 PSAY '|'
		@ L,63 PSAY SC6->C6_PRCVEN PICTURE '@E 9,999,999.99'
		@ L,75 PSAY '|'
		@ L,76 PSAY SC6->C6_VALOR  PICTURE '@E 9,999,999.99'
		@ L,88 PSAY '|'
		@ L,90 PSAY str(SC6->C6_EDINIC,4)
		@ L,94 PSAY '|'
		@ L,96 PSAY str(SC6->C6_EDFIN,4)
		@ L,100 PSAY '|' + SC6->C6_LOCAL //20090330
		@ L,103 PSAY '|'
		@ L,104 PSAY SC6->C6_TIPOREV
		@ L,107 PSAY '|'
		@ L,108 PSAY SC6->C6_CODSCC
		@ L,111 PSAY '|'
		@ L,113 PSAY SC6->C6_TPPORTE
		@ L,114 PSAY '|'
		@ L,115 PSAY SC6->C6_PEDREN
		@ L,121 PSAY '|'
		@ L,123 PSAY SC6->C6_PEDANT+"-"+SC6->C6_ITEMANT
		@ L,132 PSAY '|'
		XVLRITEM  := XVLRITEM+SC6->C6_VALOR
		XVLRTITEM := XVLRTITEM+SC6->C6_VALOR
		XCODDEST  := SC6->C6_CLI+SC6->C6_CODDEST
		DBSELECTAREA("SZN")
		If DBSEEK(xFilial()+xcoddest)
			xNOMEDEST := SZN->ZN_NOME
			dbselectarea("SZO")
			If dbseek(xFilial()+xcoddest)
				MENDEST := TRIM(ZO_END)+' ' + TRIM(ZO_BAIRRO)+' ' +SUBS(ZO_CEP,1,5)+'-'+SUBS(ZO_CEP,5,3)+' ' +TRIM(ZO_CIDADE)+' '+TRIM(ZO_ESTADO)
			ELSE
				MENDEST := ' '
			ENDIF
			LINHA()
			@ L,00 PSAY '|'+replicate('-',130)+'|'
			LINHA()
			@ L,00 PSAY '|  COD.DESTINATARIO..:'+XCODDEST+' ' +XNOMEDEST
			@ L,132 PSAY '|'
			linha()
			@ L,00 PSAY '| Endereco..: '+SUBSTR(mendest,1,115)
			@ L,132 PSAY '|'
			LINHA()
			@ L,00 PSAY '|'+replicate('-',130)+'|'
		ENDIF
		DBSELECTAREA("SC6")
		LINHA()
		dbskip()
	End
	//@ L,00 PSAY '|'  //20060526
	@ L,00 PSAY '|  TOTAL...'     //20060526 era 62
    @ L,15  PSAY Transform(XVLRTITEM,"@E 9,999,999.99")       // 09/08/02 //20060526
    @ L,45  PSAY 'REMESSA...'                                  // 09/08/02           //20060526
    @ L,55 PSAY Transform(XREMESSA,"@E 9,999,999.99")        // 09/08/02 //20060526
    @ L,75  PSAY 'BOLETO...'                                 //20060526
    @ L,85 PSAY Transform(XBOLETO,"@E 9,999,999.99")        //20060526

	@ L,132 PSAY '|'
	LINHA()
	@ L,00  PSAY '|'+replicate('-',130)+'|'
	LINHA()
	@ L,00  PSAY '|'+ XPARCA +' '+ DTOC(XDATA1) + ' ' + STR(XPARC1,10,2)
	IF XPARC2#0
		@ L,24  PSAY      XPARCB +' '+ DTOC(XDATA2) + ' ' + STR(XPARC2,10,2)
	ENDIF
	IF XPARC3#0
		@ L,46  PSAY      XPARCC +' '+ DTOC(XDATA3) + ' ' + STR(XPARC3,10,2)
	ENDIF
	IF XPARC4#0
		@ L,68  PSAY      XPARCD +' '+ DTOC(XDATA4) + ' ' + STR(XPARC4,10,2)
	ENDIF
	IF XPARC5#0
		@ L,88  PSAY      XPARCE +' '+ DTOC(XDATA5) + ' ' + STR(XPARC5,10,2)
	ENDIF
	IF XPARC6#0
		@ L,110 PSAY      XPARCF +' '+ DTOC(XDATA6) + ' ' + STR(XPARC6,10,2)
	ENDIF
	@ L,132 PSAY '|'
	LINHA()
	@ L,00 PSAY '|'+replicate('-',130)+'|'
	LINHA()
	
	IF L>55
		Roda(0,"",tamanho)
		//SETPRC(0,0)
		//L       := 0
		//L       := PROW()
		L := CABEC(CTITULO,CABEC1,CABEC2,NOMEPROG,TAMANHO,NCARACTER)
		L += 2
		//NOVAPAG :=.T.
	ELSE
		@ L,00 PSAY REPLICATE('*',132)
	ENDIF
	
	LINHA()
	  
	//Roda(0,"",tamanho)
	dbSelectArea("SC5")
	dbSkip()
End

L := CABEC(CTITULO,CABEC1,CABEC2,NOMEPROG,TAMANHO,NCARACTER)
L += 2
@ L,00 PSAY '* LOTE : ' +MV_PAR01 +   '   DATA: '+DTOC(MV_PAR03)
@ L,30 PSAY 'DIGITADO POR: ' + SC5->C5_USUARIO
@ L,131 PSAY '*'
LINHA()
@ L,00 PSAY REPLICATE('*',132)
L += 3
@ L,31 PSAY   ' **********  RESUMO DO FATURAMENTO  ************'
L++
@ L,31 PSAY ' INFORMADO          DIGITADO           DIFERENCA'
L++
@ L,00 PSAY 'QTDE PEDIDOS....:'
@ l,38 PSAY STR(XPEDINF,3)
@ L,56 PSAY STR(XPEDDIG,3)
@ L,76 PSAY STR((XPEDINF-XPEDDIG),3)
L++
@ L,00 PSAY 'VALOR PAGTOS....:'
@ L,29 PSAY STR(XPGOINF,12,2)
@ L,47 PSAY STR(XVLRPGO,12,2)
@ L,67 PSAY STR((XPGOINF-XVLRPGO),12,2)
L++
@ L,00 PSAY 'VALOR C.CREDITO.:'
@ L,29 PSAY STR(XCCDINF,12,2)
@ L,47 PSAY STR(XVLRCCD,12,2)
@ L,67 PSAY STR((XCCDINF-XVLRCCD),12,2)
L++
@ L,00 PSAY 'VALOR REMESSA...:'                     // 09/08/02
@ L,29 PSAY STR(XREMINF,12,2)                      // 09/08/02
@ L,47 PSAY STR(XTOTREM,12,2)                      // 09/08/02
@ L,67 PSAY STR((XREMINF-XTOTREM),12,2)           // 09/08/02
L++                                                   
@ L,00 PSAY 'VALOR BOLETO...:'  //20060526
@ L,47 PSAY STR(XTOTBOL,12,2)  //20060526
L++  //20060526
@ L,00 PSAY 'A FATURAR.......:'
@ L,29 PSAY STR(XFATINF,12,2)
@ L,47 PSAY STR(XVLRFAT,12,2)
@ L,67 PSAY STR((XFATINF-XVLRFAT),12,2)
L++
@ L,00 PSAY 'VALOR TOTAL.....:'
@ L,29 PSAY STR(XTOTINF,12,2)
@ L,47 PSAY STR(XTOTAL,12,2)
@ L,67 PSAY STR((XTOTAL-XTOTINF),12,2)
L++

Roda(0,"",Tamanho)

/*
//** FIM DO RELATORIO
IF L>55
	@ L,00 PSAY '* FIM * '
	@ L,131  PSAY  '.'
	L := 0
	SETPRC(0,0)
	L := PROW()
ELSE
	L := 55
	@ L,00 PSAY '* FIM * '
	@ L,131  PSAY  '.'
	L := 0
	SETPRC(0,0)
	L := PROW()
ENDIF
*/
// 13/05/02 Impressao do resumo dos pedidos - inicio

L := CABEC(CTITULO,CABEC1,CABEC2,NOMEPROG,TAMANHO,NCARACTER)
L += 2
@ L,000 PSAY '* LOTE : ' +MV_PAR01 +   '   DATA: '+DTOC(MV_PAR03)
@ L,030 PSAY 'DIGITADO POR: ' + SC5->C5_USUARIO
@ L,131 PSAY '*'
L++
@ L,000 PSAY REPLICATE('*',132)
L++
@ L,18 PSAY ' *********************************  RESUMO DO FATURAMENTO  ************************'
L++
@ L,18 PSAY ' CLIENTE   PEDIDO            VALOR            REMESSA        BOLETO        OPERACAO'  //20060526
L++

_Aped := ASORT(_aPed,,,{|x,y| UPPER(X[2]) < UPPER(Y[2])}) //_Aped := ASORT(_aPed,,,{|x,y| UPPER(X[1]) < UPPER(Y[1])})

For ni := 1 to Len(_aPed)
	@ L,19 PSAY _aPed[ni,1] //cliente 20121018
	@ L,29 PSAY _aPed[ni,2]
	@ L,39 PSAY Transform(_aPed[ni,3],"@E 9,999,999.99")
	@ L,58 PSAY Transform(_aPed[ni,4],"@E 9,999,999.99")
	@ L,74 PSAY Transform(_aPed[ni,5],"@E 9,999,999.99") //20060526
	@ L,93 PSAY (_aPed[ni,6]) //20060526
	Linha()
Next ni

Roda(0,"",Tamanho)

// 13/05/02 fim

SET DEVICE TO SCREEN
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()

Return
/*
樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛樛�
臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼�
臼浜様様様様用様様様様様僕様様様冤様様様様様様様様様曜様様様冤様様様様様様傘�
臼�Programa  �LINHA     �Autor  �Microsiga           � Data �  03/30/02   艮�
臼麺様様様様謡様様様様様瞥様様様詫様様様様様様様様様擁様様様詫様様様様様様恒�
臼�Desc.     �Adiciona Linha                                              艮�
臼�          �                                                            艮�
臼麺様様様様謡様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様恒�
臼�Uso       � AP5                                                        艮�
臼藩様様様様溶様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様識�
臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼臼�
烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝烝�
*/
Static FUNCTION LINHA()
IF L>55 // 60
	Roda(0,"",tamanho)
	//SETPRC(0,0)
	//L := 0
	//L := PROW()
	L := CABEC(CTITULO,CABEC1,CABEC2,NOMEPROG,TAMANHO,NCARACTER)
    L += 2
ELSE
	L++
ENDIF

RETURN