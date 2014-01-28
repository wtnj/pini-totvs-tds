#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
                                                                                                   
//Danilo C S Pala 20060321: dados de enderecamento do DNE, etiqueta com 9 linhas, sendo a ultima ponto(.)
//Danilo C S Pala 20100305: ENDBP
User Function Rfat017()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

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
SetPrvt("TREGS,M_MULT,P_ANT,P_ATU,P_CNT,M_SAV20")
SetPrvt("M_SAV7,_ACAMPOS,_CNOME,XNOTA,MAGENCIA,XSERIE")
SetPrvt("XPEDIDO,MTPTRANS,XCLIENTE,XLOJA,XCODAG,MNOME")
SetPrvt("MEND,MBAIR,MMUNI,MESTA,MCEP,mhora")

*ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
*º Programa    : ETIQUBP.prx                                                 º
*º Descricao   : Etiquetas  de PUBLICIDADE                                   º
*º Programador : Solange Nalini                                              º
*º Data        : 12/12/99                                                    º
*ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // NF_inicial                           ³
//³ mv_par02             // NF_Final                             ³
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
CSTRING:='SF2'

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


_aCampos := {  {"NOME"     ,"C",40, 0} ,;
               {"AGENCIA"  ,"C",40,0} ,;
               {"V_END"      ,"C",120,0} ,;
               {"BAIRRO"   ,"C",20,0} ,;
               {"MUN"      ,"C",20,0} ,;
               {"CEP"      ,"C",8, 0} ,;
               {"EST"      ,"C",2, 2}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"ETIQP",.F.,.F.)
***

DBSELECTAREA('SE1')
DBSETORDER(1)
DbSeek(xFilial()+MV_PAR03+MV_PAR01)

IF .NOT. FOUND()
    RETURN
ENDIF


DO WHILE SF2->F2_DOC >= MV_PAR01 .AND.  SF2->F2_DOC <=MV_PAR02
   IF SE1->E1_CODPORT#'423'
      DBSKIP()
      LOOP
   ENDIF

   XNOTA   :=SE1->E1_NUM
   MAGENCIA:=' '
   XSERIE  :=SE1->E1_SERIE

   XPEDIDO:=SE1->E1_PEDIDO

   DBSELECTAREA("SC5")
   DBSETORDER(1)
   DBSEEK(XFILIAL()+XPEDIDO)
   MTPTRANS:=SC5->C5_TPTRANS
   XCLIENTE:=SC5->C5_CLIENTE
   XLOJA:=SC5->C5_LOJACLI
   XCODAG:=SC5->C5_CODAG

   DBSELECTAREA("SA1")
   DBSETORDER(1)
   DBSEEK(xFilial()+XCLIENTE+XLOJA)
   MNOME  := SA1->A1_NOME
   MEND   := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060321
   MBAIR  := SA1->A1_BAIRRO
   MMUNI  := SA1->A1_MUN
   MESTA  := SA1->A1_EST
   MCEP   := SA1->A1_CEP

     //20100305 DAQUI
	IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
		DbSelectArea("ZY3")
		DbSetOrder(1)
		DbSeek(XFilial()+XCLIENTE+XLOJA)
		MEND  :=ZY3_END
		MBAIR :=ZY3_BAIRRO
		MMUNI :=ZY3_CIDADE
		MESTA :=ZY3_ESTADO
		MCEP  :=ZY3_CEP
    ELSEIF SUBS(SA1->A1_ENDCOB,1,1)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
        DbSelectArea("SZ5")
        DbSetOrder(1)
        DbSeek(XFilial()+XCLIENTE+XLOJA)
        IF FOUND()
          MEND   :=ALLTRIM(Z5_TPLOG)+ " " + ALLTRIM(Z5_LOGR) + " " + ALLTRIM(Z5_NLOGR) + " " + ALLTRIM(Z5_COMPL) //20060321
          MBAIR  :=Z5_BAIRRO
          MMUNI  :=Z5_CIDADE
          MESTA  :=Z5_ESTADO
          MCEP   :=Z5_CEP
        ENDIF
     ENDIF

     IF MTPTrans == "04"
        dbselectarea("SA1")
        dbseek(xfilial()+XCODAG)    // +_clojaag) - ACRESCENTAR
        if found()
           MAGENCIA:=SA1->A1_NOME
        Endif
        MEND   :=ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060321
        MBAIR  :=SA1->A1_BAIRRO
        MMUNI   :=SA1->A1_MUN
        MESTA  :=SA1->A1_EST
        MCEP   :=SA1->A1_CEP

    endif

    If MTPTRANS=='05' .OR. MTPTRANS=='09'
       dbselectarea("SA1")
       dbseek(xfilial()+XCODAG)
       if found()
          MAGENCIA:=' '
       Endif
    Endif

*...
  GRAVA_TEMP()
  DBSELECTAREA("SF2")
  DBSKIP()

  p_cnt := p_cnt + 1
  p_atu := 3+INT(p_cnt*m_mult)
  If p_atu != p_ant
     p_ant := p_atu
      Restscreen(23,0,24,79,m_sav7)
      Restscreen(23,p_atu,24,p_atu+3,m_sav20)
   Endif
ENDDO

IMPETIQ()

ENDDO

DbSelectArea("SC6")
Retindex("SC6")
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

DBSELECTAREA("ETIQP")
DBCLOSEAREA()

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> __RETURN()
Return()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02


// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION GRAVA_TEMP
Static FUNCTION GRAVA_TEMP()
DBSELECTAREA("ETIQP")

Reclock("ETIQP",.t.)
   replace NOME     WITH  MNOME
   REPLAce AGENCIA  WITH  MAGENCIA
   replace V_END    WITH  MEND
   replace BAIRRO   WITH  MBAIR
   replace MUN      WITH  MMUNI
   replace EST      WITH  MESTA
   replace CEP      WITH  MCEP
ETIQP->(MSUNLOCK())
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION IMPETIQ
Static FUNCTION IMPETIQ()
SET DEVI TO PRINT
DBSELECTAREA("ETIQP")
DBGOTOP()
SETPRC(0,0)
DO WHILE .NOT. EOF()
   @ LIN+LI,001 PSAY NOME
   DBSKIP()
   @ LIN+LI,045 PSAY NOME
   DBSKIP()
   @ LIN+LI,089 PSAY NOME
   DBSKIP(-2)
   LI:=LI+1

   @ LIN+LI,001 PSAY AGENCIA
   DBSKIP()
   @ LIN+LI,045 PSAY AGENCIA
   DBSKIP()
   @ LIN+LI,089 PSAY AGENCIA
   DBSKIP(-2)
   LI:=LI+1

 //20060321 DAQUI
   @ LIN+LI,001 PSAY SUBSTR(V_END,1,40)
   DBSKIP()
   @ LIN+LI,045 PSAY SUBSTR(V_END,1,40)
   DBSKIP()
   @ LIN+LI,089 PSAY SUBSTR(V_END,1,40) 
   DBSKIP(-2)
   LI:=LI+1
                
   @ LIN+LI,001 PSAY SUBSTR(V_END,41,40)
   DBSKIP()
   @ LIN+LI,045 PSAY SUBSTR(V_END,41,40)
   DBSKIP()
   @ LIN+LI,089 PSAY SUBSTR(V_END,41,40) 
   DBSKIP(-2)
   LI:=LI+1
                
   @ LIN+LI,001 PSAY SUBSTR(V_END,81,40)
   DBSKIP()
	@ LIN+LI,045 PSAY SUBSTR(V_END,81,40)
    DBSKIP()
    @ LIN+LI,089 PSAY SUBSTR(V_END,81,40) 
    DBSKIP(-2)
    LI:=LI+1                         
 //20060321 ATE AQUI


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
   DBSKIP()
           
	//20060321 DAQUI
	@ LIN+LI,001 PSAY "."
	LI:=LI+1          
	// 20060321 ATE AQUI       

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
Return()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

return
