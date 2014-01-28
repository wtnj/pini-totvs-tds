#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
//Danilo C S Pala 20100305: ENDBP
User Function Rfat026()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,LIMITE,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CNATUREZA,ARETURN,NOMEPROG,CPERG")
SetPrvt("NLASTKEY,LCONTINUA,WNREL,NTAMNF,CSTRING,TREGS")
SetPrvt("M_MULT,P_ANT,P_ATU,P_CNT,M_SAV20,M_SAV7")
SetPrvt("XMENSNF1,MENS,INICIO,NFOKI,_CENDC,_CBAIRROC")
SetPrvt("_CCIDADEC,_CESTADOC,XMENSNF2,_CCEPC,SERNF,_NOTANUM")
SetPrvt("_NOTAEMISS,_NOTACLIE,_NOTALOJA,_NOTAMERC,_NOTAVBRUT,_NOTAVEND")
SetPrvt("_NOTACOND,_DESCON,_CPREFIXO,_CPEDIDO,_CTES,_CCF")
SetPrvt("_CEMISSAO,_CCODAG,X_TPTRANS,_CCODCLI,_CLOJA,_CLOJAAG")
SetPrvt("NOTA_NATU,_CCGC,_CNOMECLI,_CINSCR,_CEND,_CBAIRRO")
SetPrvt("_CMUN,_CESTADO,_CCEP,_CFONE,COL,COL2")
SetPrvt("XPARCDUPL,XNUMDUPL,XVENCDUPL,XVALORDUPL,XDUPLICATAS,XLIN")
SetPrvt("NCOL,BB,NCOL1,NCOL2,NCOL3,NCOL4")
SetPrvt("NCOL5,NCOL6,_CITEM,_CQUANT,_CDESCUNIT,_VUNIT")
SetPrvt("_CTOTAL,_CITEMDESC,mhora")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa:           ³Autor: Solange Nalini         ³ Data:            ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Notas fiscais de Publicidade (           OKIDATA)          ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                          CPD         ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Da Nota Fiscal                       ³
//³ mv_par02             // At‚ a Nota Fiscal                    ³
//³ mv_par03             Serie									 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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
titulo :=PADC("Nota Fiscal - Nfiscal",74)
cDesc1 :=PADC("Este programa ira emitir a Nota Fiscal de Publicidade ",74)
cDesc2 :=""
cDesc3 :=""
cNatureza:=""

aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
nomeprog:="nfCPD"
cPerg:="FAT004"
nLastKey:= 0
lContinua := .T.
MHORA := TIME()
wnrel    := "NFPUBL_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Tamanho do Formulario de Nota Fiscal (em Linhas)          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

nTamNf:=66     // Apenas Informativo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas, busca o padrao da Nfiscal           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.T.)               // Pergunta no SX1

cString:="SF2"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

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


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Prepara regua de impressÆo                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
tregs := LastRec()-Recno()+1
m_mult := 1
IF tregs>0
   m_mult := 70/tregs
EndIf
p_ant := 4
p_atu := 4
p_cnt := 0
m_sav20 := dcursor(3)
m_sav7 := savescreen(23,0,24,79)
xmensnf1:=' '

DBSELECTAREA('SF2')
DBSETORDER(1)
DbSeek(xFilial()+MV_PAR01+MV_PAR03)

IF .NOT. FOUND()
    RETURN
ENDIF

MENS:=.F.
INICIO:=.T.

// Inicializa as variaveis
NFOKI:=' '


DO WHILE SF2->F2_DOC >= MV_PAR01 .AND.  SF2->F2_DOC <=MV_PAR02
   _cEndc   :=' '
   _cBAIRROC:=' '
   _cCIDADEC:=' '
   _cESTADOC:=' '
   XMENSNF2:=' '
   _cCEPC   :=SPACE(8)
   _cEndc   :=' '
    SERNF := SF2->F2_SERIE
   _NotaNum     := SF2->F2_DOC
   _NotaEmiss   := SF2->F2_EMISSAO
   _NotaClie    := SF2->F2_CLIENTE
   _NotaLoja    := SF2->F2_LOJA
   _NotaMerc    := SF2->F2_VALMERC
   _NotaVbrut   := SF2->F2_VALBRUT
   _NotaVend    := SF2->F2_VEND1
   _NotaCond    := SF2->F2_COND
   _Descon      := SF2->F2_DESCONT
   _cPrefixo    := SF2->F2_PREFIXO

   DBSELECTAREA("SD2")
   DBSETORDER(3)
   DBSEEK(XFILIAL()+SF2->F2_DOC)
   IF SUBS(SD2->D2_PEDIDO,6,1)#'P'
       DBSELECTAREA("SF2")
       DBSKIP()
       LOOP
   ENDIF

   _cPedido:=SD2->D2_pedido
   _cTes     := SD2->D2_TES
   _cCF      := SD2->D2_CF
   _cEmissao := SD2->D2_EMISSAO

   Dbselectarea("SC5")
   Dbsetorder(1)
   Dbseek(xfilial()+_cPedido)
   _cCodAg     := SC5->C5_Codag
   X_TPTRANS   := SC5->C5_TPTRANS
   _CCODCLI :=SC5->C5_CLIENTE
   _CLOJA   :=SC5->C5_LOJACLI
   //_CLOJAAG :=SC5->C5_LOJAAG

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³  Inicio do levantamento dos dados da Nota Fiscal             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

     DbSelectArea("SF4")
     DBSEEK(xFilial()+SD2->D2_TES)
     NOTA_NATU := SF4->F4_TEXTO

     *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
     *                          DADOS DO CLIENTE                          *
     *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*

     DbSelectArea("Sa1")
     DBSEEK(xFilial()+_cCodcli+_cLoja)
     IF VAL(SA1->A1_CGC)==0
        _CCGC  := SA1->A1_CGCVAL
     ELSE
        _CCGC := SA1->A1_CGC
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
		DbSeek(XFilial()+XCLI+XLOJA)
		_cEndc :=ZY3_END
		_cBAIRROC :=ZY3_BAIRRO
		_cCIDADEC :=ZY3_CIDADE
		_cESTADOC :=ZY3_ESTADO
		_cCEPC  :=ZY3_CEP
	ELSEIF SUBS(SA1->A1_ENDCOB,1,1)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
        DbSelectArea("SZ5")
        DbSetOrder(1)
        DbSeek(XFilial()+_cCodcli+_cLoja)
        IF FOUND()
           _cEndc   :=Z5_END
           _cBAIRROC:=Z5_BAIRRO
           _cCIDADEC:=Z5_CIDADE
           _cESTADOC:=Z5_ESTADO
           _cCEPC   :=Z5_CEP
        ELSE
           _cEndc   :=' '
           _cBAIRROC:=' '
           _cCIDADEC:=' '
           _cESTADOC:=' '
           _cCEPC   :=' '
        ENDIF
     ENDIF
           xmensnf1:= ' '

     IF X_TPTrans == "04" .OR. X_TPTRANS == "09" .OR. X_TPTRANS=='12'
        dbselectarea("SA1")
        dbseek(xfilial()+_cCodag)       // +_clojaag) - ACRESCENTAR
        if found()
           xmensnf1:=SA1->A1_NOME
        Endif
        _cEndc   :=SA1->A1_END
        _cBAIRROC:=SA1->A1_BAIRRO
        _cCIDADEC:=SA1->A1_MUN
        _cESTADOC:=SA1->A1_EST
        _cCEPC   :=SA1->A1_CEP
    endif

    If X_TPTRANS=='05' .OR. X_TPTRANS=='13'
       dbselectarea("SA1")
       dbseek(xfilial()+_cCodag)
       if found()
          xmensnf1:=SA1->A1_NOME
       Endif
    Endif

    *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
    *                   IMPRESSAO DA NOTA FISCAL                 *
    *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
    IF INICIO
       SETPRC(6,0)
      COL:=58
       COL2:=78
       @ 06,01  PSAY '.'
    ELSE
       SETPRC(0,0)
       @ 09,01  PSAY '.'
       COL:=55
       COL2:=78
       SETPRC(6,0)
    ENDIF

    @ 06,COL  PSAY 'XX'
    @ 06,COL2 PSAY _NOTANUM
    @ 07,008  PSAY ' '
//    @ 10,030  PSAY 'FAX:0(XX11)224-0314'

    IF INICIO
       INICIO:=.F.
       INKEY(0)
    ENDIF
    @ 12,012 PSAY NOTA_NATU
    @ 12,035 PSAY _cCF
    @ 15,009 PSAY _cNomecli     + ' ' +_cCodcli
    @ 15,060 PSAY _cCGC
    @ 15,084 PSAY _cEmissao
    @ 17,009 PSAY _cEnd
    @ 17,049 PSAY _cBairro
    @ 17,068 PSAY SUBS(_cCep,1,5)+'-'+SUBS(_cCep,6,3)
    @ 19,009 PSAY _cMun
    @ 19,038 PSAY _cFone
    @ 19,055 PSAY _cEstado
    @ 19,061 PSAY _cInscr

    //  Endereco de cobranca
    @ 22,022 PSAY _cEndc
    @ 23,012 PSAY SUBS(_cCepc,1,5)+'-'+SUBS(_cCepc,6,3)


    @ 23,030 PSAY _cBairroc
    @ 23,065 PSAY _cCidadec
    @ 23,089 PSAY _cEstadoc


    DBSELECTAREA("SE1")
    DbSetOrder(1)
    xParcDUPL  := {}
    xNUMDUPL  := {}
    xVENCDUPL := {}
    XVALORDUPL :={}
    xDuplicatas := IIF(dbSeek(xFilial()+_cPrefixo+_NOTANUM,.T.),.T.,.F.)

    DO WHILE SE1->E1_PREFIXO == _CPREFIXO  .AND. SE1->E1_NUM == _NOTANUM .AND. ! EOF() .and. xduplicatas == .T.
       AADD(xParcDupl  , SE1->E1_PARCELA)
       AADD(xNumDupl   , SE1->E1_NUM)
       AADD(xVencDupl  , SE1->E1_VENCTO)
       AADD(xValorDupl , SE1->E1_VALOR)
       dbSkip()
    ENDDO
    xlin:=25
    ncol := 12
              bb:=1
     do while BB <= len(xvalordupl)

            NCOL1:=12
            NCOL2:=20
            NCOL3:=42
            NCOL4:=55
            NCOL5:=62
            NCOL6:=84

          @ xlin,ncoL1   PSAY xNumdupl[BB] +' ' + xparcdupl[BB]
          @ xlin,ncoL2   PSAY xvalordupl[BB]
          @ xlin,ncoL3   PSAY xvencdupl[BB]
          bb:=bb+1
          IF BB<=LEN(XVALORDUPL)
          @ xlin,ncoL4   PSAY xNumdupl[BB] +' ' + xparcdupl[BB]
          @ xlin,ncoL5   PSAY xvalordupl[BB]
          @ xlin,ncoL6   PSAY xvencdupl[BB]
          ENDIF
          xlin:=xlin+1
          BB:=BB+1
     enddo


    LIN:=31

    DbSelectArea('SD2')
    DO WHILE _NOTANUM==SD2->D2_DOC .AND. SD2->D2_SERIE == SERNF .AND. .NOT. EOF()
       _cItem  := SD2->D2_COD
       _cQuant := ABS(SD2->D2_QUANT)
       _CDescUnit:=SD2->D2_DESCON/SD2->D2_QUANT
       _Vunit  := ABS(SD2->D2_PRCVEN+_cdescunit)
       _CTotal := ABS(_VUNIT*_CQUANT)


       DBSELECTAREA("SC6")
       DBSETORDER(1)
       DBSEEK(XFILIAL()+SD2->D2_PEDIDO+SD2->D2_ITEMPV)
       IF FOUND()
       _cItemDesc := SC6->C6_DESCRI       && descricao do produto
       ENDIF

//      @ LIN+LI,058 PSAY '04'                             &&  SITUACAO TRIBUTARIA
      @ LIN+LI,021 PSAY _cItemDesc
      @ LIN+LI,061 PSAY _cQuant PICTURE "@E 999999"
      @ LIN+LI,068 PSAY _Vunit  PICTURE "@E 99,999.99"
      @ LIN+LI,079 PSAY _cTotal PICTURE "@E 999,999.99"

      DBSELECTAREA("SD2")
      DBSKIP()
      LIN:=LIN+1
   ENDDO

      // ... calcula o desconto da agencia para demonstrar na nota

      IF X_TPTRANS=='04' .OR. X_TPTRANS=='09' .OR. X_TPTRANS=='12'
         XMENSNF2   := "DESC. 20% P/AGENCIA = R$ " + LTRIM(STR(_DESCON,12,2))
      ELSE
         _notaVBrut := _NOTAMERC
      ENDIF
      @ 40,075 PSAY _NOTAVBRUT+_descon   PICTURE '@E 9,999,999,999.99'
      @ 42,075 PSAY _NotaVbrut  PICTURE '@E 9,999,999,999.99'

      LIN:=51
      @ LIN+1,25 PSAY _cPedido
      @ LIN+1,42 PSAY _NotaVend

      @ lin+2,23 PSAY xmensnf1
      @ lin+3,23 PSAY xmensnf2

      @ 60,080 PSAY X_TPTRANS
      @ 63,080 PSAY _NOTANUM
      DBSELECTAREA("SF2")
      DBSKIP()
      set device to screen

      SETPRC(0,0)
      LIN:=10
      @ LIN,00 PSAY CHR(27)+"2"

      p_cnt := p_cnt + 1
      p_atu := 3+INT(p_cnt*m_mult)
      If p_atu != p_ant
         p_ant := p_atu
          Restscreen(23,0,24,79,m_sav7)
          Restscreen(23,p_atu,24,p_atu+3,m_sav20)
      Endif
            set devi to print
            SetPrc(0,0)

            LIN:=7
            LI:=0
    ENDDO
        SET DEVI TO SCREEN
        DBSELECTAREA("SC6")
        DBSETORDER(1)

       IF aRETURN[5] == 1
          Set  Printer to
          dbcommitAll()
          ourspool(WNREL)
       ENDIF
MS_FLUSH()

