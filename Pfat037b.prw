#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/                     
Alterado por Danilo C S Pala em 20120223: por query
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT037   ³Autor: Solange Nalini         ³ Data:   24/06/98 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Relatorio de comissoes a pagar                             ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Alterado em 17/11 - criado flag p/estorno e3_status(at‚ nova versao)  ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat037b()

SetPrvt("TITULO,CDESC1,CTITULO,CCABEC1,CCABEC2,XCABEC1")
SetPrvt("XCABEC2,NCARACTER,ARETURN,SERNF,CPROGRAMA,CPERG")
SetPrvt("NLASTKEY,M_PAG,LCONTINUA,WNREL,L,CBTXT")
SetPrvt("CBCONT,NORDEM,ALFA,Z,M,TAMANHO")
SetPrvt("CDESC2,CDESC3,CSTRING,TREGS,M_MULT,P_ANT")
SetPrvt("P_ATU,P_CNT,M_SAV20,M_SAV7,MVEND,MEMISSN")
SetPrvt("MNOMEVEND,MREGIAO,MEQUIPE,MVALTOT,MVALCOM,MVALBASE")
SetPrvt("MPREFIXO,MNUM,MPARCELA,MCODCLI,MLOJA,MVBASE")
SetPrvt("MPEDIDO,MVLRBASE,MPORC,MCOMIS,MTIPO,MSTATUS")
SetPrvt("MEMISSAO,MVENCTO,MBAIXA,MNOMECLI,MCALCCOM,MCALCFGTS")
SetPrvt("MCALCDSR,MTOTALCOM,MMSGSTATUS,mhora")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Da Regiao                            ³
//³ mv_par02             // At‚ Regiao                           ³
//³ mv_par03             // Data de Pagamento                    ³
//³ mv_par04             // Mensal/Semestral                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Titulo    := PADC("COMISSOES ",74)
cDesc1    := PADC("Este programa emite relatorio de Comissäes a pagar ",74)
cTitulo   := ' **** RELATORIO DE COMISSOES - '+TRIM(SM0->M0_NOME)+'**** '
//cTitulo   := ' **** RELATORIO DE COMISSOES **** '
// Regua para impressao dos sub-titulos
    //                 10        20        30        40        50        60        70         80        90        100      110       120     130         140      150       160
    //        123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 12456789'
cCabec1   := 'PEDIDO    CODIGO    LJ   NOME CLIENTE                                 DUPL         DATA      DATA        DATA             VALOR         %             VALOR       OBSERVACAO'
cCabec2   := '          CLIENTE                                                                  EMISSAO   VENCTO      PAGTO            BASE                     COMISSAO    '
xCabec1   := 'DEMONSTRATIVO DE VENDAS - RESUMO'
xCabec2   := ' '
nCaracter := 18
aReturn   := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
SERNF     := 'UNI'
cPrograma := "PFAT037B"
cPerg     := "FAT009"
nLastKey  := 0
M_PAG     := 1
lContinua := .T.
MHORA      := TIME()
wnrel     := "PFAT037B_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
L         := 0
CbTxt     := ""
CbCont    := ""
nOrdem    := 0
Alfa      := 0
Z         := 0
M         := 0
tamanho   := "G"
cDesc2    := ""
cDesc3    := ""
MMSGSTATUS := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas.                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.T.)               // Pergunta no SX1

cString:="SE3"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)

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

Processa({|| P037Proc()})

Return

Static Function P037Proc()


dbSelectArea("SE3")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Prepara regua de impressÆo                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*dbSetOrder(4)  //20120223
dbSeek(xFILIAL("SE3")+DTOS(MV_PAR03)+MV_PAR01,.T.)
ProcRegua(RecCount())
L := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)

While DTOS(SE3->E3_DATA) == DTOS(MV_PAR03) .AND. SE3->E3_REGIAO >= MV_PAR01 .AND. SE3->E3_REGIAO <= MV_PAR02
*/
if MV_PAR05 == SPACE(6)
	cqueryvend :=""
else
	cqueryvend :=" AND E3_VEND='"+ MV_PAR05 +"'"
endif

cQuery := "SELECT * FROM "+ RetSqlName("SE3") +" WHERE E3_FILIAL='"+ XFILIAL("SE3") +"' AND E3_DATA='"+ DTOS(MV_PAR03) +"' AND E3_REGIAO>='"+ MV_PAR01 +"' AND E3_REGIAO<='"+ MV_PAR02 +"' "+ cqueryvend +" AND D_E_L_E_T_<>'*' ORDER BY E3_DATA, E3_REGIAO, E3_VEND" //20120223 
TCQUERY cQuery NEW ALIAS "COMIS"
TcSetField("COMIS","E3_DATA"   ,"D")
DbSelectArea("COMIS")
DBGOTOP()
WHILE !EOF() 

   IncProc("Titulo: "+COMIS->E3_PREFIXO+COMIS->E3_NUM+COMIS->E3_PARCELA) //IncProc("Titulo: "+SE3->E3_PREFIXO+SE3->E3_NUM+SE3->E3_PARCELA) //20120223 
   
   	mVend   :=COMIS->E3_VEND //mVend   :=SE3->E3_VEND //20120223 
   // TESTE
/*   IF SE3->E3_num=='023461'
       MSGALERT('ACHOU')
   ENDIF */
   dbSelectArea("SA3")
   dbSeek(xFILIAL("SA3")+mVEND)
   If Found()
      If SA3->A3_EMISSN=='N' .OR. SA3->A3_TIPOVEN == 'CT'
         dbSelectArea("COMIS") //dbSelectArea("SE3") //20120223
         dbskip()
         loop
      Endif
      MEMISSN   := SA3->A3_EMISSN
      mNOMEVEND := SA3->A3_NOME
      mREGIAO   := SA3->A3_REGIAO
      mEQUIPE   := SA3->A3_EQUIPE
   Endif
   mValtot  := 0
   mVALCOM  := 0
   mVALBASE := 0
   L        := 0
   
   DbSelectArea("COMIS") //dbSelectArea("SE3") //20120223
	While Alltrim(Mvend) == Alltrim(COMIS->E3_VEND) //While Alltrim(Mvend) == Alltrim(SE3->E3_VEND) //20120223
		If COMIS->E3_PER # MV_PAR04 //If SE3->E3_PER # MV_PAR04 //20120223
      		dbSkip()
      		Loop
   		Endif
        
   // TESTE
/*   IF SE3->E3_num=='023461'
       MSGALERT('ACHOU')
   ENDIF */

	mPREFIXO  := COMIS->E3_PREFIXO //mPREFIXO  := SE3->E3_PREFIXO //20120223
	mNUM      := COMIS->E3_NUM //mNUM      := SE3->E3_NUM //20120223
	mPARCELA  := COMIS->E3_PARCELA //mPARCELA  := SE3->E3_PARCELA //20120223
	mCODCLI   := COMIS->E3_CODCLI //mCODCLI   := SE3->E3_CODCLI //20120223
	mLOJA     := COMIS->E3_LOJA //mLOJA     := SE3->E3_LOJA //20120223
	mVBASE    := COMIS->E3_BASE //mVBASE    := SE3->E3_BASE //20120223
	mPEDIDO   := COMIS->E3_PEDIDO //mPEDIDO   := SE3->E3_PEDIDO //20120223
	mVLRBASE  := COMIS->E3_BASE //mVLRBASE  := SE3->E3_BASE //20120223
	mPORC     := COMIS->E3_PORC //mPORC     := SE3->E3_PORC //20120223 
    mCOMIS    := COMIS->E3_COMIS //mCOMIS    := SE3->E3_COMIS //20120223
	mTIPO     := COMIS->E3_TIPO //mTIPO     := SE3->E3_TIPO //20120223
	mVEND     := COMIS->E3_VEND //mVEND     := SE3->E3_VEND //20120223
	mSTATUS   := COMIS->E3_SITUAC //mSTATUS   := SE3->E3_SITUAC //20120223

   If val(COMIS->E3_SITUAC)==0 //If val(SE3->E3_SITUAC)==0 //20120223
      dbSelectArea("SE1")
      DBSETORDER(1)               // 23/09/02
      dbSeek(xFILIAL("SE1")+mPREFIXO+mNUM+mPARCELA)
      If Found()
         IF SE1->E1_EMISSAO < CTOD('01/11/2000') .OR.(SE1->E1_EMISSAO > CTOD('31/10/2000') .AND. SE1->E1_DIVVEN # 'SOFT')
            DBSELECTAREA("COMIS") //DBSELECTAREA("SE3") //20120223
            DBSKIP()
            LOOP
         ENDIF
         mEMISSAO := SE1->E1_EMISSAO
         mVENCTO  := SE1->E1_VENCTO
         mBAIXA   := SE1->E1_BAIXA
      Endif
   Else
      mEMISSAO := ' '
      mVENCTO  := ' '
      mBAIXA   := ' '
   Endif

   dbSelectArea("SA1")
      dbSeek(xFILIAL("SA1")+mCODCLI+mLOJA)
      If found()
         mNOMECLI := SA1->A1_NOME
      Endif
      DO CASE
         CASE MEMISSN == 'P'
              IMPPLAN()
         CASE MEMISSN == 'R'
              IMPRECI()
      ENDCASE

      dbSelectArea("COMIS") //dbSelectArea("SE3") //20120223
      dbSkip()
  End
  If MEMISSN == "P"
     @ l+2,00 PSAY 'TOTAL===========> '
     @ L+2,117 PSAY STR(mVALBASE,10,2)
     @ L+2,145 PSAY STR(mVALCOM,10,2)
  ELSEIF MEMISSN == 'R'
     IF VAL(MVEND)#10
        @ l+2,05 PSAY ' TOTAL DA PRODU€ÇO : '+STR(MVALBASE,10,2)
        @ L+4,05 PSAY ' TOTAL DE COMISSåES: '+STR(MVALCOM,10,2)
        @ L+5,05 PSAY '                      =========='
     ELSE
        MCALCCOM:=MVALBASE*.7915/100
        MCALCFGTS:=MVALBASE*.074084/100
        MCALCDSR :=MVALBASE*.134555/100
        MTOTALCOM:=MCALCCOM+MCALCFGTS+MCALCDSR
        @ L +2,10 PSAY 'TOTAL DA PRODUCAO......: ' + STR(MVALBASE,10,2)
        @ L +4,10 PSAY 'VALOR DE COMISSOES ....: ' + STR(MCALCCOM,10,2)
        @ L +6,10 PSAY 'VALOR FGTS ............: ' + STR(MCALCFGTS,10,2)
        @ L +8,10 PSAY 'VALOR DSR  ............: ' + STR(MCALCDSR,10,2)
        @ L+10,10 PSAY 'TOTAL DE COMISSOES.....: ' + STR(MTOTALCOM,10,2)
      ENDIF
    ENDIF
END

   IF L >= 55
      //SETPRC(0,0)
      Roda(0,"",tamanho)
      L := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
   ELSE
      L += 2
   ENDIF

Roda(0,"",tamanho)

SET DEVICE TO SCREEN

IF aRETURN[5] == 1
  Set Printer to
  dbcommitAll()
  ourspool(WNREL)
ENDIF

MS_FLUSH()   

DbSelectArea("COMIS")
DbCloseArea()

Return

Static FUNCTION IMPPLAN()

   IF L==0
      L := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
      L += 2
      @ L,001 PSAY  'REPRES.....:  ' + MVEND +' ' +MNOMEVEND +' '+'REGIAO: '+MREGIAO+' ' +'EQUIPE: ' + MEQUIPE
      L:=L+2
   ENDIF

   @ L,001 PSAY  mPEDIDO
   @ L,010 PSAY  mCODCLI
   @ L,020 PSAY  mLOJA
   @ L,025 PSAY  mNOMECLI
   @ L,070 PSAY  mNUM
   @ L,080 PSAY  mPARCELA
   @ L,083 PSAY  mEMISSAO
   @ L,093 PSAY  mVENCTO
   @ L,105 PSAY  mBAIXA
//  @ L,114 PSAY  STR(MVALOR,10,2)
   @ L,117 PSAY  STR(MVLRBASE,10,2)
   @ L,133 PSAY  STR(mPORC,6,3)
   
   
   DO CASE            
      CASE MSTATUS=='0'
	      MMSGSTATUS := ''
      CASE MSTATUS=='1'
	      MMSGSTATUS := 'FATURAMENTO CANCELADO'
      CASE MSTATUS=='2'
          MMSGSTATUS := 'ESTORNO DE VENDEDOR'
      CASE MSTATUS=='3'
          MMSGSTATUS :=  'ESTORNO DE PRODUTO'
      CASE MSTATUS=='4'
          MMSGSTATUS :=  'ESTORNO DE CLIENTE'
      CASE MSTATUS=='5'
          MMSGSTATUS :=  'COMISSAO PGA EM DUPLICIDADE'
      CASE MSTATUS=='6'
          MMSGSTATUS :=  'ESTORNO PARA ACERTO DE VALOR'
      OtherWise  //20060828
	      MMSGSTATUS := ''
   ENDCASE
   IF VAL(MSTATUS)>0
//      MVALTOT  := MVALTOT-MVALOR
      MVALCOM  := MVALCOM-MCOMIS
      MVALBASE := MVALBASE-MVLRBASE
      MCOMIS := MCOMIS * -1
   ELSE
//      MVALTOT  := MVALTOT+MVALOR
      MVALBASE := MVALBASE+MVLRBASE
      MVALCOM  := MVALCOM+MCOMIS
   ENDIF  
   @ L,145 PSAY  STR(MCOMIS,10,2)
   @ L,162 PSAY  MMSGSTATUS
   IF L >= 55
      //SETPRC(0,0)
      Roda(0,"",tamanho)
      L := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
      L += 2
   ELSE
      L++
   ENDIF

RETURN

Static FUNCTION IMPRECI()

   IF L==0
      CABEC(cTitulo,xCabec1,xCabec2,cPrograma,tamanho)
      L += 2
      @ L,001 PSAY  'REPRES.....:  ' + MVEND +' ' +MNOMEVEND +' '+'REGIAO: '+MREGIAO+' ' +'EQUIPE: ' + MEQUIPE
      L:=L+2
   ENDIF

   IF VAL(MSTATUS)>0
  //  MVALTOT  := MVALTOT-MVALOR
      MVALCOM  := MVALCOM-MCOMIS
      MVALBASE := MVALBASE-MVLRBASE
   ELSE
//    MVALTOT  := MVALTOT+MVALOR
      MVALBASE := MVALBASE+MVLRBASE
      MVALCOM  := MVALCOM+MCOMIS
   ENDIF

Return