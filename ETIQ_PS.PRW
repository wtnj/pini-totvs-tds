#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Etiq_PS()

SetPrvt("LI,LIN,CBTXT,CBCONT,NORDEM,ALFA")
SetPrvt("Z,M,TAMANHO,LIMITE,TITULO,CDESC1")
SetPrvt("CDESC2,CDESC3,CNATUREZA,ARETURN,SERNF,NOMEPROG")
SetPrvt("CPERG,NLASTKEY,LCONTINUA,NLIN,WNREL,CSTRING")
SetPrvt("TREGS,M_MULT,P_ANT,P_ATU,P_CNT,M_SAV20")
SetPrvt("M_SAV7,_ACAMPOS,_CNOME,XNOTA,MAGENCIA,XSERIE")
SetPrvt("XPEDIDO,MTPTRANS,XCLIENTE,XLOJA,XCODAG,MNOME")
SetPrvt("MEND,MBAIR,MMUNI,MESTA,MCEP,mhora")

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
titulo    := PADC("ETIQUETAS  ",74)
cDesc1    := PADC("Este programa ira emitir as Etiquetas p/N.Fiscais",74)
cDesc2    := ""
cDesc3    := ""
cNatureza := ""
aReturn   := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
SERNF     := 'UNI'
nomeprog  := "etiq"
cPerg     := "FAT004"
nLastKey  := 0
lContinua := .T.
nLin      := 0
MHORA := TIME()
wnrel     := "ETIQASLI_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

Pergunte(cPerg,.f.)               // Pergunta no SX1

CSTRING:='SF2'

wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.f.)

If nLastKey == 27
   Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

dbUseArea(.T.,, "MG.DBF","ETIQP",.F.,.F.)

Processa({|| IMPETIQ()})

DBSELECTAREA("ETIQP")
DBCLOSEAREA()

Return

Static FUNCTION IMPETIQ()

SET DEVICE TO PRINTER
DBSELECTAREA("ETIQP")
ProcRegua(RecCount())
DBGOTOP()

SETPRC(0,0)

mCep := ""

WHILE !EOF()
   @ LIN+LI,001 PSAY SUBSTR(NOME,1,40)
   DBSKIP()
   @ LIN+LI,045 PSAY SUBSTR(NOME,1,40)
   DBSKIP()
   @ LIN+LI,089 PSAY SUBSTR(NOME,1,40)
   DBSKIP(-2)
   LI:=LI+1

   @ LIN+LI,001 PSAY SUBSTR(DEST,1,40)
   DBSKIP()
   @ LIN+LI,045 PSAY SUBSTR(DEST,1,40)
   DBSKIP()
   @ LIN+LI,089 PSAY SUBSTR(DEST,1,40)
   DBSKIP(-2)
   LI:=LI+1

   @ LIN+LI,001 PSAY SUBSTR(ENDER,1,40)
   DBSKIP()
   @ LIN+LI,045 PSAY SUBSTR(ENDER,1,40)
   DBSKIP()
   @ LIN+LI,089 PSAY SUBSTR(ENDER,1,40)
   DBSKIP(-2)
   LI:=LI+1

   @ LIN+LI,001 PSAY SUBSTR(BAIRRO,1,12)+'-' +SUBSTR(CIDADE,1,20)+'-' +SUBSTR(ESTADO,1,2)
   DBSKIP()
   @ LIN+LI,045 PSAY SUBSTR(BAIRRO,1,12)+'-' +SUBSTR(CIDADE,1,20)+'-' +SUBSTR(ESTADO,1,2)
   DBSKIP()
   @ LIN+LI,089 PSAY SUBSTR(BAIRRO,1,12)+'-' +SUBSTR(CIDADE,1,20)+'-' +SUBSTR(ESTADO,1,2)
   DBSKIP(-2)
   LI:=LI+1                                                	

   //mCep := STRZERO(CEP,8,0)
   @ LIN+LI,001 PSAY CEP //SUBSTR(mCep,1,5)+'-'+SUBSTR(mCep,6,3)
   DBSKIP()
   //mCep := STRZERO(CEP,8,0)
   @ LIN+LI,045 PSAY CEP //SUBSTR(mCep,1,5)+'-'+SUBSTR(mCep,6,3)
   DBSKIP()
   //mCep := STRZERO(CEP,8,0)
   @ LIN+LI,089 PSAY CEP //SUBSTR(mCep,1,5)+'-'+SUBSTR(mCep,6,3)
   LI:=LI+1
   DBSKIP()
   LI:=2

   setprc(0,0)

   lin:=prow()

IncProc("Linha: "+StrZero(Recno(),5))

END

SET DEVICE TO SCREEN

IF aRETURN[5] == 1
  Set Printer to
  dbcommitAll()
  ourspool(WNREL)
ENDIF

MS_FLUSH()

return