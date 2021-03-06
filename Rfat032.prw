#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#INCLUDE "PROTHEUS.CH"

/*/   Alterado por Danilo C S Pala em 20040615
//Danilo C S Pala 20100305: ENDBP
//Danilo C S Pala 20100330: Mensagem para nota e titulo do produto
//Danilo C S Pala 20110704: E1_TIPO=="NF"
//Danilo C S Pala 20120503: PINILOGCONS
//Danilo C S Pala 20130607: Lei Transparencia 12741/2012
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa:           �Autor: Solange Nalini         � Data:            � ��
������������������������������������������������������������������������Ĵ ��
���Descri�ao: Notas fiscais de Publicidade (OKIDATA)                     � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento                                      � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function Rfat032()

SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,LIMITE,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CNATUREZA,ARETURN,NOMEPROG,CPERG")
SetPrvt("NLASTKEY,LCONTINUA,WNREL,NTAMNF,CSTRING,TREGS")
SetPrvt("M_MULT,P_ANT,P_ATU,P_CNT,M_SAV20,M_SAV7")
SetPrvt("XMENSNF1,MENS,INICIO,NFOKI,_CENDC,_CBAIRROC")
SetPrvt("_CCIDADEC,_CESTADOC,XMENSNF2,_CCEPC,SERNF,_NOTANUM")
SetPrvt("_NOTAEMISS,_NOTACLIE,_NOTALOJA,_NOTAMERC,_NOTAVBRUT,_NOTAVEND")
SetPrvt("_NOTACOND,_DESCON,_CPREFIXO,_CPEDIDO,_CTES,_CCF")
SetPrvt("_CEMISSAO,_CCODAG,X_TPTRANS,_CCODCLI,_CLOJA,NOTA_NATU")
SetPrvt("_CCGC,_CNOMECLI,_CINSCR,_CEND,_CBAIRRO,_CMUN")
SetPrvt("_CESTADO,_CCEP,_CFONE,COL,COL2,XPARCDUPL")
SetPrvt("XNUMDUPL,XVENCDUPL,XVALORDUPL,XDUPLICATAS,XLIN,NCOL")
SetPrvt("BB,NCOL1,NCOL2,NCOL3,NCOL4,NCOL5")
SetPrvt("NCOL6,MENSAG,_CITEM,_CQUANT,_CDESCUNIT,_VUNIT")
SetPrvt("_CTOTAL,_CITEMDESC,_CDVEIC,MQTDEI,ASZSREV,ASZSINS")
SetPrvt("ASZSEDI,ITENS,MREV1,MREVU,MEDIA,MEDIU")
SetPrvt("IMP,sDescAg, sDescAgValor, xMensagem,mhora, nTotTrib, nTotNota")
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Da Nota Fiscal                       �
//� mv_par02             // At� a Nota Fiscal     
//� mv_par03             // Serie da NF							 �
//����������������������������������������������������������������
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
titulo    := PADC("Nota Fiscal - Nfiscal",74)
cDesc1    := PADC("Este programa ira emitir a Nota Fiscal de Publicidade ",74)
cDesc2    := ""
cDesc3    := ""
cNatureza := ""
aReturn   := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
nomeprog  := "nfCPD"
cPerg     := "FAT032"
nLastKey  := 0
lContinua := .T.
MHORA := TIME()
wnrel     := "NFPUBL" 

//�����������������������������������������������������������Ŀ
//� Tamanho do Formulario de Nota Fiscal (em Linhas)          �
//�������������������������������������������������������������
nTamNf:=66     // Apenas Informativo

//�������������������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas, busca o padrao da Nfiscal           �
//���������������������������������������������������������������������������
Pergunte(cPerg,.T.)               // Pergunta no SX1

cString:="SF2"

//��������������������������������������������������������������Ŀ
//� Envia controle para a funcao SETPRINT                        �
//����������������������������������������������������������������
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,,.T.)

If nLastKey == 27
	Return
Endif

//��������������������������������������������������������������Ŀ
//� Verifica Posicao do Formulario na Impressora                 �
//����������������������������������������������������������������
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

Processa({|| RF032Proc()})

Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RF032Proc �Autor  �Microsiga           � Data �  04/04/02   ���
�������������������������������������������������������������������������͹��
���Desc.     � Impressao da nota                                          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP5                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RF032Proc()

//��������������������������������������������������������������Ŀ
//�  Prepara regua de impress�o                                  �
//����������������������������������������������������������������
xmensnf1:=' '

DBSELECTAREA("SF2")
DBSETORDER(1)
If !DbSeek(xFilial("SF2")+MV_PAR01+MV_PAR03)
	RETURN
ENDIF

tregs := IIF(MV_PAR02 <> MV_PAR01, ABS(Val(MV_PAR02)-Val(MV_PAR01))+1,1) // LastRec()-Recno()+1

MENS   := .F.
INICIO := .T.

NFOKI  := ' '

ProcRegua(tregs)

WHILE !Eof() .and. SF2->F2_FILIAL == xFilial("SF2") .and. SF2->F2_DOC >= MV_PAR01 .AND. SF2->F2_DOC <= MV_PAR02
	
	IncProc("Imprimindo Nota "+Alltrim(SF2->F2_SERIE+SF2->F2_DOC))
	_cEndc       := ' '
	_cBAIRROC    := ' '
	_cCIDADEC    := ' '
	_cESTADOC    := ' '
	XMENSNF2     := ' '
	_cCEPC       := SPACE(8)
	_cEndc       := ' '
	SERNF        := SF2->F2_SERIE
	_NotaNum     := SF2->F2_DOC
	_NotaEmiss   := SF2->F2_EMISSAO
	_NotaClie    := SF2->F2_CLIENTE
	_NotaLoja    := SF2->F2_LOJA
	_NotaMerc    := SF2->F2_VALMERC
	_NotaVbrut   := SF2->F2_VALBRUT
	_NotaVend    := SF2->F2_VEND1
	_NotaCond    := SF2->F2_COND
	_Descon      := 0 //SF2->F2_DESCONT
	_cPrefixo    := SF2->F2_PREFIXO
	nTotTrib     := 0
	
	DBSELECTAREA("SD2")
	DBSETORDER(3)
	DBSEEK(XFILIAL("SF2")+SF2->F2_DOC+SF2->F2_SERIE)
//	DBSEEK(XFILIAL("SF2")+SF2->F2_DOC+MV_PAR03)
	if SF2->F2_SERIE <> MV_PAR03
		DBSELECTAREA("SF2")
		DBSKIP()
		LOOP
	endif
	If mv_par04 == 1
		IF SUBS(SD2->D2_PEDIDO,6,1)#'P'
			DBSELECTAREA("SF2")
			DBSKIP()
			LOOP
		ENDIF
	EndIf
	
	_cPedido  := SD2->D2_PEDIDO
	_cTes     := SD2->D2_TES
	_cCF      := SD2->D2_CF
	_cEmissao := SD2->D2_EMISSAO
	
	Dbselectarea("SC5")
	Dbsetorder(1)
	Dbseek(xfilial("SC5")+_cPedido)
	_cCodAg     := SC5->C5_CODAG
	X_TPTRANS   := SC5->C5_TPTRANS
	_CCODCLI    := SC5->C5_CLIENTE
	_CLOJA      := SC5->C5_LOJACLI          
	xMENSAGEM   := trim(SC5->C5_MENNOTA)  //20100330
	
	//��������������������������������������������������������������Ŀ
	//�  Inicio do levantamento dos dados da Nota Fiscal             �
	//����������������������������������������������������������������
	DbSelectArea("SF4")
	DBSEEK(xFilial("SF4")+SD2->D2_TES)
	NOTA_NATU := SF4->F4_TEXTO
	//*��������������������������������������������������������������������*
	//*                          DADOS DO CLIENTE                          *
	//*��������������������������������������������������������������������*
	DbSelectArea("SA1")
	DBSEEK(xFilial("SA1")+_cCodcli+_cLoja)
	IF VAL(SA1->A1_CGC)==0
		_CCGC  := SA1->A1_CGCVAL
	ELSE
		_CCGC  := SA1->A1_CGC
	ENDIF
	_cNomeCli := SA1->A1_NOME
	_cInscr   := SA1->A1_INSCR
	_cEnd     := SA1->A1_END
	_CBairro  := SA1->A1_BAIRRO
	_cMun     := SA1->A1_MUN
	_cEstado  := SA1->A1_EST
	_cCep     := SA1->A1_CEP
	_cFone    := SA1->A1_TEL
	
//20100305 DAQUI
	IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
		DbSelectArea("ZY3")
		DbSetOrder(1)
		DbSeek(XFilial("ZY3")+_cCodcli+_cLoja)
		_cEndc :=ZY3_END
		_cBAIRROC :=ZY3_BAIRRO
		_cCIDADEC :=ZY3_CIDADE
		_cESTADOC :=ZY3_ESTADO
		_cCEPC  :=ZY3_CEP
	ELSEIF SUBS(SA1->A1_ENDCOB,1,1)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
		DbSelectArea("SZ5")
		DbSetOrder(1)
		DbSeek(XFilial("SZ5")+_cCodcli+_cLoja)
		IF FOUND()
			_cEndc    := SZ5->Z5_END
			_cBAIRROC := SZ5->Z5_BAIRRO
			_cCIDADEC := SZ5->Z5_CIDADE
			_cESTADOC := SZ5->Z5_ESTADO
			_cCEPC    := SZ5->Z5_CEP
		ELSE
			_cEndc    := ' '
			_cBAIRROC := ' '
			_cCIDADEC := ' '
			_cESTADOC := ' '
			_cCEPC    := ' '
		ENDIF
	ELSE
			_cEndc    := ' '
			_cBAIRROC := ' '
			_cCIDADEC := ' '
			_cESTADOC := ' '
			_cCEPC    := ' '
	ENDIF
	xmensnf1 := ' '
	
	IF X_TPTrans == "04" .OR. X_TPTRANS == "09" .OR. X_TPTRANS=='12'
		dbselectarea("SA1")
		dbseek(xfilial("SA1")+_cCodag)       // +_clojaag) - ACRESCENTAR
		if found()
			xmensnf1:=SA1->A1_NOME
		Endif
		_cEndc    := SA1->A1_END
		_cBAIRROC := SA1->A1_BAIRRO
		_cCIDADEC := SA1->A1_MUN
		_cESTADOC := SA1->A1_EST
		_cCEPC    := SA1->A1_CEP
	endif
	
	If X_TPTRANS=='05' .OR. X_TPTRANS=='13'
		dbselectarea("SA1")
		If dbseek(xfilial("SA1")+_cCodag)
			xmensnf1 := SA1->A1_NOME
		Endif
	Endif
	
	//*������������������������������������������������������������*
	//*                   IMPRESSAO DA NOTA FISCAL                 *
	//*������������������������������������������������������������*
	IF INICIO
		SETPRC(6,0)
		COL  := 58
		COL2 := 78
		@ 06,01  psay '.'
	ELSE
		SETPRC(0,0)
		@ 09,01  psay '.'
		COL  := 55
		COL2 := 78
		SETPRC(6,0)
	ENDIF
	
//	@ 06,COL  psay 'XX'
	@ 06,COL2 psay _NOTANUM
	@ 07,008  psay ' '
	//  @ 10,030  psay 'FAX:0(XX11)224-0314'
	
	IF INICIO
		INICIO := .F.
		INKEY(0)
	ENDIF
	@ 12,003 psay NOTA_NATU // -6
	@ 12,029 psay _cCF
	@ 15,003 psay _cNomecli     + ' ' +_cCodcli //-6
	@ 15,054 psay _cCGC //-6
	@ 15,078 psay _cEmissao//-6
	@ 17,003 psay _cEnd //-6
	@ 17,043 psay _cBairro //-6
	@ 17,063 psay SUBS(_cCep,1,5)+'-'+SUBS(_cCep,6,3) //-6
	@ 19,003 psay _cMun //-6
	@ 19,032 psay SUBS(_cFone,1,16) //-6
	@ 19,049 psay _cEstado //-6
	@ 19,054 psay _cInscr //-6
	
	//  Endereco de cobranca
	@ 22,016 psay _cEndc //-6
	@ 23,006 psay SUBS(_cCepc,1,5)+'-'+SUBS(_cCepc,6,3) //-6
	@ 23,024 psay _cBairroc //-6
	@ 23,059 psay _cCidadec //-6
	@ 23,083 psay _cEstadoc //-6
	
	DBSELECTAREA("SE1")
	DbSetOrder(1)
	xParcDUPL   := {}
	xNUMDUPL    := {}
	xVENCDUPL   := {}
	XVALORDUPL  := {}
	xDuplicatas := IIF(dbSeek(xFilial("SE1")+_cPrefixo+_NOTANUM,.T.),.T.,.F.)
	
	WHILE !EOF() .AND. SE1->E1_FILIAL == xFilial("SE1") .and. SE1->E1_PREFIXO == _CPREFIXO  .AND. SE1->E1_NUM == _NOTANUM .AND. ! EOF() .and. xduplicatas == .T. 
		if ALLTRIM(SE1->E1_TIPO) =="NF" //20110704
			AADD(xParcDupl  , SE1->E1_PARCELA)
			AADD(xNumDupl   , SE1->E1_NUM)
			AADD(xVencDupl  , SE1->E1_VENCTO)
			AADD(xValorDupl , SE1->E1_VALOR)
		endif
		dbSkip()
	END
	xlin := 25
	ncol := 12
	bb   := 1
	while BB <= len(xvalordupl)
		NCOL1 := 06 //-6
		NCOL2 := 14 //-6
		NCOL3 := 36 //-6
		NCOL4 := 49 //-6
		NCOL5 := 56 //-6
		NCOL6 := 78 //-6
		
		@ xlin,ncoL1   psay xNumdupl[BB] +' ' + xparcdupl[BB]
		@ xlin,ncoL2   psay xvalordupl[BB] Picture "@E 999,999,999.99"
		@ xlin,ncoL3   psay xvencdupl[BB]
		bb:=bb+1
		IF BB<=LEN(XVALORDUPL)
			@ xlin,ncoL4   psay xNumdupl[BB] +' ' + xparcdupl[BB]
			@ xlin,ncoL5   psay xvalordupl[BB] Picture "@E 999,999,999.99"
			@ xlin,ncoL6   psay xvencdupl[BB]
		ENDIF
		xlin++
		BB++
	end
	
	LIN := 31
	
	Mensag:={}
	
	IF SC5->C5_AVESP=='N'
		DbSelectArea("SD2")
		WHILE _NOTANUM==SD2->D2_DOC .AND. SD2->D2_SERIE == SERNF .AND. .NOT. EOF()
			_cItem     := SD2->D2_COD
			_cQuant    := ABS(SD2->D2_QUANT)
			_CDescUnit :=   SD2->D2_DESCON / SD2->D2_QUANT // 20040804
			_Vunit     := ABS(SD2->D2_PRCVEN + _cdescunit)   
			
			_CTotal    := ABS(_VUNIT * _CQUANT)
			_DESCON   += (_cDescUnit * _CQUANT)
			
			DbSelectArea("SB1")
			DbSetOrder(1)
			DbSeek(xFilial("SB1")+SD2->D2_COD)
			_cItemDesc := SUBS(SB1->B1_DESC,1,24)       && descricao do produto
			
			_CDVEIC:=SUBS(SB1->B1_TITULO,1,5) //20100330 : Cida
			//_CDVEIC := " "
			
			DBSELECTAREA("SC6")
			DBSETORDER(1)
			DBSEEK(XFILIAL("SC6")+SD2->D2_PEDIDO+SD2->D2_ITEMPV)
			IF FOUND()
				MQTDEI := SC6->C6_QTDVEN
			ENDIF
			
			aSZSREV := {}
			aSZSINS := {}
			aSZSEDI := {}
			
			dbSelectArea("SZS")
			DBSETORDER(4)
			Dbseek(xfilial("SZS")+SD2->D2_PEDIDO+SD2->D2_ITEMPV+SD2->D2_DOC+SD2->D2_SERIE)
			IF Found()
				ITENS:=0
				WHILE SZS->ZS_NFISCAL == SD2->D2_DOC .and. SZS->ZS_ITEM == SD2->D2_ITEMPV
					AADD(aSZSREV, SZS->ZS_VEIC)
					AADD(aSZSINS, SZS->ZS_NUMINS)
					AADD(aSZSEDI, SZS->ZS_EDICAO)
					DBSKIP()
					ITENS++
				END
				
				IF LEN(ASZSINS)>1
					MREV1 := ASZSEDI[1]
					MREVU := ASZSEDI[LEN(ASZSEDI)]
					IF MREVU>MREV1
						MEDIA := MREV1
						MEDIU := MREVU
					ELSE
						MEDIA := MREVU
						MEDIU := MREV1
					ENDIF
					
					AADD(MENSAG,aSZSREV[1]+" " + LTRIM(STR(MEDIA))+' A ' + ;
					LTRIM(STR(MEDIU)))
				ENDIF 
				Else        //20040702
					ITENS:=0
			ENDIF
			/*
			* ���������������������������������
			*     Detalhes do Item - Produto
			* ���������������������������������
			*/
			@ LIN+LI,003 psay TRIM(SD2->D2_COD) //-5
			@ LIN+LI,011 psay _cDVeic  //-5
			@ LIN+LI,016 psay _cItemDesc //-5
			IF ITENS==1
				@ LIN+LI,044 psay LTRIM(STR(ASZSINS[1],3))+'/'+LTRIM(STR(MQTDEI,3)) 
				@ LIN+LI,051 psay ASZSEDI[1]
				MENS:=.F.
			ELSE
				@ LIN+LI,044 psay " * "
				MENS:=.T.
			ENDIF
			
			@ LIN+LI,055 psay '04'                             &&  SITUACAO TRIBUTARIA  //-2
			@ LIN+LI,057 psay _cQuant PICTURE "@E 999"  //-2
			@ LIN+LI,062 psay _Vunit  PICTURE "@E 999,999.99" //-6
			@ LIN+LI,073 psay _cTotal PICTURE "@E 999,999.99" //-6
			
			GetAliqImp(_cItem ,_cTotal) //20130607
			
			DBSELECTAREA("SD2")
			DBSKIP()
			LIN++
		ENDDO
		
	ELSE
		DBSELECTAREA("SD2")
			_cItem    := SD2->D2_COD
			_cQuant   := ABS(SD2->D2_QUANT)
			_CDescUnit:= SD2->D2_DESCON // SD2->D2_DESCON/SD2->D2_QUANT // 20040308
			_Vunit    := ABS(SD2->D2_PRCVEN+_cdescunit)
			_CTotal   := ABS(_VUNIT*_CQUANT)
			_DESCON   += _cDescUnit
	
		DBSELECTAREA("SZV")
		DBSETORDER(2)
		DBSEEK(XFILIAL("SZV")+SF2->F2_DOC)
		@ LIN+LI,021 psay 'PARCELA '+LTRIM(STR(SZV->ZV_NPARC,2,0))+' REF. CAMPANHA'
		LI:=LI+1
		@ LIN+LI,021 psay 'PUBLICIT. PUBLIC. PINI' //-6
		@ LIN+LI,073 psay _CTOTAL PICTURE "@E 999,999.99"  //-6
		
		GetAliqImp(_cItem ,_cTotal) //20130607
		LIN:=LIN+1
	ENDIF
	// ... calcula o desconto da agencia para demonstrar na nota
	
	LIN:=52         //20040615

	IF X_TPTRANS=='04' .OR. X_TPTRANS=='09' .OR. X_TPTRANS=='12'
		XMENSNF2   := "DESC. 20% P/AGENCIA = R$ " + LTRIM(STR(_DESCON,12,2))
		sDEscAg := "20"
		sDescAgValor := LTRIM(STR(_DESCON,12,2))
		@ LIN+1,003 psay _NOTAVBRUT + _descon   PICTURE "@E 999,999.99"  //-6
		@ LIN+1,049 psay sDescAg 
		@ LIN+1,055 psay sDescAgValor 
		@ LIN+1,075 psay _NotaVbrut  PICTURE "@E 999,999.99"  //-6
	ELSE
		_notaVBrut := _NOTAMERC
		sDEscAg := ""                                             
		sDescAgValor := ""
		@ LIN+1,003 psay _NOTAVBRUT + _descon   PICTURE "@E 999,999.99"  //-6
//'		@ LIN+1,020 psay sDescAg 
//'		@ LIN+1,030 psay sDescAgValor 
		@ LIN+1,075 psay _NotaVbrut  PICTURE "@E 999,999.99"  //-6
	ENDIF

	LIN = LIN+1
//	LIN:=51 20040615
	@ LIN+3,003 psay trim(_cPedido)  //-6
	@ LIN+3,023 psay xMensagem 	//20100330
	
	//20130607 daqui
	If nTotTrib > 0
		nTotNota 	:= _NotaMerc
		cPercTrib	:= Transform( round(((nTotTrib / nTotNota) * 100),2),	"@R 9999.99")
		@ LIN+4,023 psay  "VALOR APROXIMADO DOS TRIBUTOS: R$ " +alltrim(Transform(nTotTrib,"@R 999,999,999.99"))+" ("+alltrim(cPercTrib)+"%) FONTE: IBPT."
	EndIf
	//20130607 ate aqui
	
	@ LIN+5,003 psay _NotaVend //-6
	@ LIN+5,023 psay xmensnf1 

//	@ lin+3,23 psay xmensnf2
	
   /*	if len(mensag)>0
		IMP := 1
		FOR IMP :=1 TO LEN(MENSAG)
			@ LIN+4,23 psay MENSAG[IMP]
			LIN++
		NEXT
	ENDIF
	@ 60,080 psay X_TPTRANS*/
	@ lin+10,078 psay _NOTANUM 
	DBSELECTAREA("SF2")
	DBSKIP()
	SET DEVICE TO SCREEN
	
	SETPRC(0,0)
	LIN := 10
	
	SET DEVICE TO PRINTER
	SetPrc(0,0)
	
	LIN := 7
	LI  := 0
	
	U_PINILOGCONS(SM0->M0_CODIGO, _NotaClie, _NotaLoja, SERNF, _NotaNum, "", _NotaEmiss, _cPedido, "REL", "RFAT032", "NOTA FISCAL") //20120503
END
SET DEVICE TO SCREEN
DBSELECTAREA("SC6")
DBSETORDER(1)

IF aRETURN[5] == 1
	Set  Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()

Return



/* 20130607 Lei Transparencia 12741/2012 */
Static Function GetAliqImp(cSD2Produto, nSD2Total)
Local lServico := IIF(!Empty(SB1->B1_CODISS),.T.,.F.)
Local nTributo := 0
Local nAliqImp := 0
Local nSYDRecno	:= 0
Local nSYDIndex := 0 
Local nEL0Recno	:= 0
Local nEL0Index	:= 0

DbSelectArea("SB1")
DbSetOrder(1)
If DbSeek(xFilial("SB1")+cSD2Produto)
	If lServico
		If SB1->B1_IMPNCM == 0
			nEL0Recno:= EL0->(RECNO())
			nEL0Index:= EL0->(IndexOrd()) 			
			EL0->(dbSetOrder(1))
			if ( EL0->(dbSeek(xFilial("EL0")+SB1->B1_POSIPI)) )	
				nAliqImp := EL0->EL0_ALIQIM
			endif			
			EL0->(DBSETORDER(nEL0Index))
			EL0->(DBGOTO(nEL0Recno))
		Else
			nAliqImp := SB1->B1_IMPNCM
		EndIf
	Else
		If SB1->B1_IMPNCM == 0
			nSYDRecno:= SYD->(RECNO())
			nSYDIndex:= SYD->(IndexOrd()) 			
			SYD->(dbSetOrder(1))
			if ( SYD->(dbSeek(xFilial("SYD")+SB1->B1_POSIPI)) )	
				nAliqImp := SYD->YD_ALIQIMP
			endif			
			SYD->(DBSETORDER(nSYDIndex))
			SYD->(DBGOTO(nSYDRecno))
		Else
			nAliqImp := SB1->B1_IMPNCM
		EndIf 
	EndIf
Else
	nAliqImp := 0
Endif
//nAliquota:= nAliqImp //GetAliqImp()
nTributo := Round( ((nSD2Total * nAliqImp)/100),2) //era  SD2->D2_TOTAL * nAliquota  
nTotTrib+= nTributo

Return