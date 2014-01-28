#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
//Danilo C S Pala 20060321: dados de enderecamento do DNE, etiqueta com 9 linhas, sendo a ultima ponto(.)
//Danilo C S Pala 20100305: ENDBP
User Function Rfat018()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,LIMITE,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CNATUREZA,ARETURN,SERNF,NOMEPROG")
SetPrvt("CPERG,NLASTKEY,LCONTINUA,NLIN,WNREL,CSTRING")
SetPrvt("_CNOME,_ACAMPOS,_CCLIENTE,_CLOJA,CLIE_NOME,CLIE_ENDE")
SetPrvt("CLIE_BAIR,CLIE_MUNI,CLIE_ESTA,CLIE_CEP,NF,NOME")
SetPrvt("RESPCOB,v_END,BAIRRO,MUN,EST,CEP,mhora")

*ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
*º Programa    : ETIQ.prx                                                    º
*º Descricao   : Etiquetas  de livros e assinaturas e P.Sistemas             º
*º Programador : Solange Nalini                                              º
*º Data        : 18/05/98                                                    º
*º ALTERADO    : 14/10/00 - Retirado arq SZF(criado arq.temporario)          º
*ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // NF_inicial                           ³
//³ mv_par02             // NF_Final                             ³
//³ mv_par03             // Serie da N.Fiscal                    ³
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
titulo :=PADC("ETIQUETAS  ",74)
cDesc1 :=PADC("Este programa ira emitir as Etiquetas p/N.Fiscais",74)
cDesc2 :=""
cDesc3 :=""
cNatureza:=""

aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
SERNF:='UNI'
nomeprog:="etiq"

cPerg:="FAT004"
nLastKey:= 0

lContinua := .T.
nLin:=0
MHORA := TIME()
wnrel    := "ETIQASLI_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.T.)               // Pergunta no SX1

cString:="SF2"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DO WHILE LCONTINUA
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
  LCONTINUA:=.T.


  _cNome := CriaTrab(_aCampos,.t.)
  dbUseArea(.T.,, _cNome,"ETILA",.F.,.F.)
  _aCampos := {{"NF"     ,"C",6 ,0},;
               {"NOME"    ,"C",40 ,0},;
               {"RESPCOB" ,"C",40 ,0},;
               {"v_END"    ,"C",120 ,0},; 
               {"BAIRRO" ,"C",20 ,0},;
               {"MUN"    ,"C",40,0},;
               {"EST"    ,"C",2,0},;
               {"CEP"    ,"C",9,0}}

  _cNome := CriaTrab(_aCampos,.t.)
  dbUseArea(.T.,, _cNome,"ETILA",.F.,.F.)



  DBSELECTAREA('SF2')
  DBSETORDER(1)
  DbSeek(xFilial()+MV_PAR01+MV_PAR03)

  IF .NOT. FOUND()
      RETURN
  ENDIF
  DO WHILE SF2->F2_DOC>=MV_PAR01 .AND.  SF2->F2_DOC<=MV_PAR02
     DBSELECTAREA("SD2")
     DBSETORDER( )
     DBSEEK(XFILIAL()+SF2->F2_DOC+SF2->F2_SERIE)

     DBSELECTAREA("SC5")
     DBSETORDER(1)
     DBSEEK(XFILIAL()+XPEDIDO)

     IF SC5->C5_CLIFAT#SPACE(6)
        _cCliente:=SC5->C5_CLIFAT
        _CLOJA   :=SC5->C5_LOJCLIFAT
     ELSE
        _cCliente:=SC5->C5_CLIFAT
        _CLOJA   :=SC5->C5_LOJCLIFAT
     ENDIF

    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³  Inicio do levantamento dos dados do Cliente                 ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

    DbSelectArea("SA1")
    IF _CLOJA=='1 '
       _CLOJA:='01'
    ENDIF
    DBSEEK(xFilial()+_CCLIENTE+_CLOJA)
    CLIE_NOME := SA1->A1_NOME

    *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
    * VERIFICA ENDERECO DA COBRANCA                                    *
    *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*

	//20100305 DAQUI
	IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
		DbSelectArea("ZY3")
		DbSetOrder(1)
		DbSeek(XFilial()+XCLI+XLOJA)
		CLIE_ENDE :=ZY3_END
		CLIE_BAIR :=ZY3_BAIRRO
		CLIE_MUNI :=ZY3_CIDADE
		CLIE_ESTA :=ZY3_ESTADO
		CLIE_CEP  :=ZY3_CEP
	ELSEIF SUBS(SA1->A1_ENDCOB,1,1)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
       DbSelectArea("SZ5")
       DbSetOrder(1)
       DbSeek(XFilial()+XCLI+XLOJA)
       CLIE_ENDE := ALLTRIM(Z5_TPLOG)+ " " + ALLTRIM(Z5_LOGR) + " " + ALLTRIM(Z5_NLOGR) + " " + ALLTRIM(Z5_COMPL) //20060321
       CLIE_BAIR :=Z5_BAIRRO
       CLIE_MUNI :=Z5_CIDADE
       CLIE_ESTA :=Z5_ESTADO
       CLIE_CEP  :=Z5_CEP
    ELSE
       CLIE_ENDE := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060321
       CLIE_BAIR := SA1->A1_BAIRRO
       CLIE_MUNI := SA1->A1_MUN
       CLIE_ESTA := SA1->A1_EST
       CLIE_CEP  := SA1->A1_CEP
    ENDIF
    GRAVA_TEMP()
    DBSELECTAREA("SF2")
    DBSKIP()

    IMPETIQ()
 enddo
ENDDO
DbSelectArea("SF2")
Retindex("SF2")
DbSelectArea("SC5")
Retindex("SC5")
DbSelectArea("SA1")
Retindex("SA1")
DbSelectArea("SZ5")
Retindex("SZ5")

set devi to screen
IF aRETURN[5] == 1
  Set Printer to
  dbcommitAll()
  ourspool(WNREL)
ENDIF
MS_FLUSH()

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> __RETURN()
RETurn        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02


// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION GRAVA_TEMP
static FUNCTION GRAVA_TEMP()
DBSELECTAREA("ETILA")
   Reclock("ETILA",.T.)
   NF       :=  SF2->F2_DOC
   NOME     :=  CLIE_NOME
   RESPCOB  :=  SC5->C5_RESPCOB
   v_END    :=  CLIE_ENDE
   BAIRRO   :=  CLIE_BAIR
   MUN      :=  CLIE_MUNI
   EST      :=  CLIE_ESTA
   CEP      :=  CLIE_CEP
   ETILA->(Msunlock())
RETurn


// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION IMPETIQ
Static FUNCTION IMPETIQ()
SET DEVI TO PRINT
SETPRC(0,0)

DBSELECTAREA("ETILA")
DBGOTOP()
DO WHILE .NOT. EOF()
   @ LIN+LI,001 PSAY NOME
   DBSKIP()
   @ LIN+LI,045 PSAY NOME
   DBSKIP()
   @ LIN+LI,089 PSAY NOME
   DBSKIP(-2)
   LI:=LI+1

   @ LIN+LI,001 PSAY RESPCOB
   DBSKIP()
   @ LIN+LI,045 PSAY RESPCOB
   DBSKIP()
   @ LIN+LI,089 PSAY RESPCOB
   DBSKIP(-2)
   LI:=LI+1

    //20060317 DAQUI
                @ LIN+LI,001 PSAY SUBSTR(v_END,1,40)
                DBSKIP()
                @ LIN+LI,045 PSAY SUBSTR(v_END,1,40)
                DBSKIP()
                @ LIN+LI,089 PSAY SUBSTR(v_END,1,40) 
                DBSKIP(-2)
                LI:=LI+1
                
                @ LIN+LI,001 PSAY SUBSTR(v_END,41,40)
                DBSKIP()
                @ LIN+LI,045 PSAY SUBSTR(v_END,41,40)
                DBSKIP()
                @ LIN+LI,089 PSAY SUBSTR(v_END,41,40) 
                DBSKIP(-2)
                LI:=LI+1
                
                @ LIN+LI,001 PSAY SUBSTR(v_END,81,40)
                DBSKIP()
                @ LIN+LI,045 PSAY SUBSTR(v_END,81,40)
                DBSKIP()
                @ LIN+LI,089 PSAY SUBSTR(v_END,81,40) 
                DBSKIP(-2)
                LI:=LI+1                         
 //20060317 ATE AQUI

   @ LIN+LI,001 PSAY BAIRRO
   DBSKIP()
   @ LIN+LI,045 PSAY BAIRRO
   DBSKIP()
   @ LIN+LI,089 PSAY BAIRRO
   DBSKIP(-2)
   LI:=LI+1

   @ LIN+LI,001 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
   DBSKIP()
   @ LIN+LI,045 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
   DBSKIP()
   @ LIN+LI,089 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
   LI:=LI+1
   DBSKIP(-2)
	
	//20060320 DAQUI
	@ LIN+LI,001 PSAY "."
	LI:=LI+1          
	// 20060320 ATE AQUI       

   
   LI:=2
   setprc(0,0)
   lin:=prow()
ENDDO
SET DEVI TO SCREEN


IF aRETURN[5] == 1
  Set Printer to
  dbcommitAll()
  ourspool(WNREL)
ENDIF
MS_FLUSH()

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> __Return()
Return        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

return



