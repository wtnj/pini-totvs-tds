#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
#IFNDEF WINDOWS
     #DEFINE PSAY SAY
#ENDIF

User Function Pfat138()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("LCONTINUA,ARETURN,CPROGRAMA,NLASTKEY,WNREL,L")
SetPrvt("NORDEM,CTAMANHO,NCARACTER,CTITULO,CCABEC1,CCABEC2")
SetPrvt("M_PAG,CDESC1,CDESC2,CDESC3,TITULO,CSTRING")
SetPrvt("TAMANHO,NOMEPROG,CBTXT,CPERG,LIMITE,_NQTLP")
SetPrvt("MAC,MAL,MAM,MAP,MBA,MCE")
SetPrvt("MDF,MES,MGO,MMA,MMG,MMS")
SetPrvt("MMT,MPA,MPB,MPE,MPI,MPR")
SetPrvt("MRJ,MRN,MRR,MRS,MRO,MSC")
SetPrvt("MSE,MSP,MTO,MEX,MACM,MALM")
SetPrvt("MAMM,MAPM,MBAM,MCEM,MDFM,MESM")
SetPrvt("MGOM,MMAM,MMGM,MMSM,MMTM,MPAM")
SetPrvt("MPBM,MPEM,MPIM,MPRM,MRJM,MRNM")
SetPrvt("MRRM,MRSM,MROM,MSCM,MSEM,MSPM")
SetPrvt("MTOM,MEXM,MACDCLI,MCODCLI,CINDEX,CKEY")
SetPrvt("MCODDEST,MEST,_SALIAS,AREGS,I,J")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 26/02/02 ==>      #DEFINE PSAY SAY
#ENDIF
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: PFAT138   쿌utor: Claudio                � Data:   06/08/01 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri눯o:  RELATORIO CONTAGEM DE ASSINATURAS POR ESTADO              � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo Faturamento                                         � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Variaveis utilizadas para parametros                                    �
//쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� mv_par01 Do Produdo.........:                                           �
//� mv_par02 At� o Produto......:                                           �
//� mv_par03 Tipo da Assinatura.: Pagos, Cortesia, Ambos                    �
//� mv_par04 Edi눯o Inicial.....:                                           �
//� mv_par05 Edi눯o Final.......:                                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

#IFNDEF WINDOWS
    ScreenDraw("SMT050", 3, 0, 0, 0)
    SetCursor(1)
    SetColor("B/BG")
#ENDIF

lContinua := .T.
aReturn   :={ "Especial", 1,"Administra눯o", 1, 2, 1,"",1 }
cPrograma :="PFAT138"
nLastKey  :=0
L         :=0
nOrdem    :=0
cTamanho  :="M"
nCaracter :=10
cTitulo   :=""
cCabec1   :=""
cCabec2   :=""
M_PAG     := 1

cDesc1    :=PADC("Este programa ira gerar o arquivo de cliente em relat줿io" ,74)
cDesc2    :=PADC("Relatorio de Contagem de Assinaturas por Estado" ,74)
cDesc3    :=""
Titulo    :=PADC("RELAT�RIO",74)
cTitulo   :=' ******  CONTAGEM DE CLIENTES  ****** '

cString := "SE1"
MHORA      := TIME()
wnRel   := "PFIN138_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
Tamanho := "M"
Titulo  := "CONTAGEM DE ASSINATURAS POR ESTADO"
cDesc1  := "Este programa imprimira todas as assinaturas geradas" 
cDesc2  := "automaticamente  de  acordo com os parametros solicitados." 
cDesc3  := "Especifico para Editora Pini Ltda." 

aReturn	:= { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }

NomeProg :="PFIN005"
nLastKey := 0
Cbtxt    := SPACE(10)
cPerg    := "PFAT13"
Limite   := 180
_nQtLP   := 0

wnRel:=SetPrint(cString,wnRel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,Tamanho)

_validPerg()

If !Pergunte(cPerg)
   Return
Endif

If  nLastKey == 27
    Return
Endif

SetDefault(aReturn,cString)

If  nLastKey == 27
    Return
Endif

#IFDEF WINDOWS
       RptStatus({|| R020PRC() })// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        RptStatus({|| Execute(R020PRC) })
#ELSE
       R020PRC()
#ENDIF

Return

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑uncao    � R020PRC  � Autor � Andreia Silva         � Data � 21/02/00 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escricao � Processa Relatorio                                         낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Especifico para Editora Pini. Modulo Financeiro            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴눙�
굇� Revisao  �                                          � Data �          낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION R020PRC
Static FUNCTION R020PRC()

L:=0
MAC:=0
MAL:=0
MAM:=0
MAP:=0
MBA:=0
MCE:=0
MDF:=0
MES:=0
MGO:=0
MMA:=0
MMG:=0
MMS:=0
MMT:=0
MPA:=0
MPB:=0
MPE:=0
MPI:=0
MPR:=0
MRJ:=0
MRN:=0
MRR:=0
MRS:=0
MRO:=0
MSC:=0
MSE:=0
MSP:=0
MTO:=0
MEX:=0
MACM:=0
MALM:=0
MAMM:=0
MAPM:=0
MBAM:=0
MCEM:=0
MDFM:=0
MESM:=0
MGOM:=0
MMAM:=0
MMGM:=0
MMSM:=0
MMTM:=0
MPAM:=0
MPBM:=0
MPEM:=0
MPIM:=0
MPRM:=0
MRJM:=0
MRNM:=0
MRRM:=0
MRSM:=0
MROM:=0
MSCM:=0
MSEM:=0
MSPM:=0
MTOM:=0
MEXM:=0
MACDCLI:=""
MCODCLI:=""

DBUSEAREA(.T.,,"I:\SIGA\ARQASS\ASSAT01","TRAB",.F.,.F.)
cINDEX:=CriaTrab(NIL,.F.)
cKEY:="CODCLI+CODDEST"
INDREGUA("Trab",cINDEX,cKEY,,,"Selecionado Registro do arq")

DBGOTOP()
SETREGUA(RECCOUNT())
DO WHILE !EOF()
   INCREGUA()

   IF (TRAB->CODPROD < MV_PAR01) .OR. (TRAB->CODPROD > MV_PAR02)
       DbSelectArea("TRAB")
       DbSkip()
       Loop
   Endif

   IF (MV_PAR04 < TRAB->EDIN) .OR. (MV_PAR05 > TRAB->EDFIN) 
       DbSelectArea("TRAB")
       DbSkip()
       Loop
   Endif

   IF MV_PAR03 ==1
      IF "99" $ (TRAB->CF)
          DbSelectArea("TRAB")
          DbSkip()
          Loop
      Endif
   Endif

   IF MV_PAR03 ==2
      IF "11" $ (TRAB->CF)
          DbSelectArea("TRAB")
          DbSkip()
          Loop
      Endif     
   Endif

   MCODCLI := TRAB->CODCLI
   MCODDEST:= TRAB->CODDEST
   MEST    := TRAB->EST

   IF MEST == "AC"
      MAC:=MAC+1
   ELSEIF MEST == "AL"
      MAL:=MAL+1
   ELSEIF MEST == "AM"
      MAM:=MAM+1
   ELSEIF MEST == "AP"
      MAP:=MAP+1
   ELSEIF MEST == "BA"
      MBA:=MBA+1
   ELSEIF MEST == "CE"
      MCE:=MCE+1
   ELSEIF MEST == "DF"
      MDF:=MDF+1
   ELSEIF MEST == "ES"
      MES:=MES+1
   ELSEIF MEST == "GO"
      MGO:=MGO+1
   ELSEIF MEST == "MA"
      MMA:=MMA+1
   ELSEIF MEST == "MG"
      MMG:=MMG+1
   ELSEIF MEST == "MS"
      MMS:=MMS+1
   ELSEIF MEST == "MT"
      MMT:=MMT+1
   ELSEIF MEST == "PA"
      MPA:=MPA+1
   ELSEIF MEST == "PB"
      MPB:=MPB+1
   ELSEIF MEST == "PE"
      MPE:=MPE+1
   ELSEIF MEST == "PI"
      MPI:=MPI+1
   ELSEIF MEST == "PR"
      MPR:=MPR+1
   ELSEIF MEST == "RJ"
      MRJ:=MRJ+1
   ELSEIF MEST == "RN"
      MRN:=MRN+1
   ELSEIF MEST == "RR"
      MRR:=MRR+1
   ELSEIF MEST == "RS"
      MRS:=MRS+1
   ELSEIF MEST == "RO"
      MRO:=MRO+1
   ELSEIF MEST == "SC"
      MSC:=MSC+1
   ELSEIF MEST == "SE"
      MSE:=MSE+1
   ELSEIF MEST == "SP"
      MSP:=MSP+1
   ELSEIF MEST == "TO"
      MTO:=MTO+1
   ELSEIF MEST == "EX"
      MEX:=MEX+1
   ENDIF

   IF MACDCLI <> MCODCLI
      CHECA01()
   ENDIF

   MACDCLI:= MCODCLI
   DBSELECTAREA("TRAB")
   DBSKIP()
   
ENDDO

IF L==0 .OR. L>50
   Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
   @ 4,0 PSAY REPLICATE ("*",132)
   L:=6
ENDIF

@ L,00 PSAY " TIPO DE ASSINATURA...: " + Alltrim(mv_par01) + "  A   " + Alltrim(mv_par02)  +  "    EDICAO...: " + strzero(mv_par04,5) + "  A  " + strzero(mv_par05,5)  

@ L+2,00 PSAY "    ******  ASSINATURAS DA REGIAO  ******          ******  ASSINANTES DA REGIAO  ******"

@ L+4,12  PSAY "TOTAL DO ESTADO AC: " + str((MAC),5)  + "                              " + str((MACM),5)
@ L+5,12  PSAY "TOTAL DO ESTADO AL: " + str((MAL),5)  + "                              " + str((MALM),5)
@ L+6,12  PSAY "TOTAL DO ESTADO AM: " + str((MAM),5)  + "                              " + str((MAMM),5)
@ L+7,12  PSAY "TOTAL DO ESTADO AP: " + str((MAP),5)  + "                              " + str((MAPM),5)
@ L+8,12  PSAY "TOTAL DO ESTADO BA: " + str((MBA),5)  + "                              " + str((MBAM),5)
@ L+9,12  PSAY "TOTAL DO ESTADO CE: " + str((MCE),5)  + "                              " + str((MCEM),5)
@ L+10,12 PSAY "TOTAL DO ESTADO DF: " + str((MDF),5)  + "                              " + str((MDFM),5)
@ L+11,12 PSAY "TOTAL DO ESTADO ES: " + str((MES),5)  + "                              " + str((MESM),5)
@ L+12,12 PSAY "TOTAL DO ESTADO GO: " + str((MGO),5)  + "                              " + str((MGOM),5)
@ L+13,12 PSAY "TOTAL DO ESTADO MA: " + str((MMA),5)  + "                              " + str((MMAM),5) 
@ L+14,12 PSAY "TOTAL DO ESTADO MG: " + str((MMG),5)  + "                              " + str((MMGM),5)
@ L+15,12 PSAY "TOTAL DO ESTADO MS: " + str((MMS),5)  + "                              " + str((MMSM),5)
@ L+16,12 PSAY "TOTAL DO ESTADO MT: " + str((MMT),5)  + "                              " + str((MMTM),5)
@ L+17,12 PSAY "TOTAL DO ESTADO PA: " + str((MPA),5)  + "                              " + str((MPAM),5)
@ L+18,12 PSAY "TOTAL DO ESTADO PB: " + str((MPB),5)  + "                              " + str((MPBM),5)
@ L+19,12 PSAY "TOTAL DO ESTADO PE: " + str((MPE),5)  + "                              " + str((MPEM),5)
@ L+20,12 PSAY "TOTAL DO ESTADO PI: " + str((MPI),5)  + "                              " + str((MPIM),5)
@ L+21,12 PSAY "TOTAL DO ESTADO PR: " + str((MPR),5)  + "                              " + str((MPRM),5)
@ L+22,12 PSAY "TOTAL DO ESTADO RJ: " + str((MRJ),5)  + "                              " + str((MRJM),5)
@ L+23,12 PSAY "TOTAL DO ESTADO RN: " + str((MRN),5)  + "                              " + str((MRNM),5)
@ L+24,12 PSAY "TOTAL DO ESTADO RO: " + str((MRO),5)  + "                              " + str((MROM),5)
@ L+25,12 PSAY "TOTAL DO ESTADO RR: " + str((MRR),5)  + "                              " + str((MRRM),5)
@ L+26,12 PSAY "TOTAL DO ESTADO RS: " + str((MRS),5)  + "                              " + str((MRSM),5) 
@ L+27,12 PSAY "TOTAL DO ESTADO SC: " + str((MSC),5)  + "                              " + str((MSCM),5)
@ L+28,12 PSAY "TOTAL DO ESTADO SE: " + str((MSE),5)  + "                              " + str((MSEM),5)
@ L+29,12 PSAY "TOTAL DO ESTADO SP: " + str((MSP),5)  + "                              " + str((MSPM),5)
@ L+30,12 PSAY "TOTAL DO ESTADO TO: " + str((MTO),5)  + "                              " + str((MTOM),5)
@ L+31,12 PSAY "TOTAL DO ESTADO EX: " + str((MEX),5)  + "                              " + str((MEXM),5)

@ L+33,12 PSAY "TOTAL GERAL.......: " + str((MAC+MAL+MAM+MAP+MBA+MCE+MDF+MES+MGO+MMA+MMG+MMS+MMT+MPA+MPB+MPE+MPI+MPR+MRJ+MRN+MRR+MRS+MRO+MSC+MSE+MSP+MTO+MEX),5)
@ L+33,68 PSAY str((MACM+MALM+MAMM+MAPM+MBAM+MCEM+MDFM+MESM+MGOM+MMAM+MMGM+MMSM+MMTM+MPAM+MPBM+MPEM+MPIM+MPRM+MRJM+MRNM+MRRM+MRSM+MROM+MSCM+MSEM+MSPM+MTOM+MEXM),5)

  IF MV_PAR03 == 1
     @ L+37,12 PSAY "CONTAGEM DOS PAGOS"
  ELSEIF MV_PAR03 == 2 
     @ L+37,12 PSAY "CONTAGEM DAS CORTESIA "
  ELSEIF MV_PAR03 == 3
     @ L+37,12 PSAY "CONTAGEM DOS PAGOS E CORTESIA "
  ENDIF

DBSELECTAREA("TRAB")
DBCLOSEAREA ("TRAB")

Set Device To Screen
If aReturn[5] == 1
     Set Printer TO 
     dbcommitAll()
     ourspool(wnRel)
Endif
Ms_Flush()

Return

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿣ALIDPERG � Autor �  Luiz Carlos Vieira   � Data � 16/07/97 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Verifica as perguntas inclu죒do-as caso n꼘 existam        낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Espec죉ico para clientes Microsiga                         낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _ValidPerg
Static Function _ValidPerg()

      _sAlias := Alias()
      DbSelectArea("SX1")
      DbSetOrder(1)
      cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
      aRegs:={}

      // Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

      AADD(aRegs,{cPerg,"01","Do Produdo.........:","mv_ch1","C",15,0,0,"G","","mv_par01","","","","","","","","","","","","","","",""})
      AADD(aRegs,{cPerg,"02","At� o Produto......:","mv_ch2","C",15,0,0,"G","","mv_par02","","","","","","","","","","","","","","",""})
      AADD(aRegs,{cPerg,"03","Tipo da Assinatura.:","mv_ch3","C",01,0,3,"C","","mv_par03","Pagos","","","Cortesias","","","Ambos","","","","","","","",""})
      AADD(aRegs,{cPerg,"04","Edi눯o Inicial.....:","mv_ch4","N",05,0,3,"G","","mv_par04","","","","","","","","","","","","","","",""})
      AADD(aRegs,{cPerg,"05","Edi눯o Final.......:","mv_ch5","N",05,0,3,"G","","mv_par05","","","","","","","","","","","","","","",""})

      For i:=1 to Len(aRegs)
          If !dbSeek(cPerg+aRegs[i,2])
          RecLock("SX1",.T.)
             For j:=1 to FCount()
                 If j <= Len(aRegs[i])
                    FieldPut(j,aRegs[i,j])
                 Endif
             Next
            SX1->(MsUnlock())
           Endif
      Next

      DbSelectArea(_sAlias)

Return

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION CHECA01
Static FUNCTION CHECA01()

    IF MEST == "AC"
       MACM:=MACM+1
    ELSEIF MEST == "AL"
       MALM:=MALM+1
    ELSEIF MEST == "AM"
       MAMM:=MAMM+1
    ELSEIF MEST == "AP"
       MAPM:=MAPM+1
    ELSEIF MEST == "BA"
       MBAM:=MBAM+1
    ELSEIF MEST == "CE"
       MCEM:=MCEM+1
    ELSEIF MEST == "DF"
       MDFM:=MDFM+1
    ELSEIF MEST == "ES"
       MESM:=MESM+1
    ELSEIF MEST == "GO"
       MGOM:=MGOM+1
    ELSEIF MEST == "MA"
       MMAM:=MMAM+1
    ELSEIF MEST == "MG"
       MMGM:=MMGM+1
    ELSEIF MEST == "MS"
       MMSM:=MMSM+1
    ELSEIF MEST == "MT"
       MMTM:=MMTM+1
    ELSEIF MEST == "PA"
       MPAM:=MPAM+1
    ELSEIF MEST == "PB"
       MPBM:=MPBM+1
    ELSEIF MEST == "PE"
       MPEM:=MPEM+1
    ELSEIF MEST == "PI"
       MPIM:=MPIM+1
    ELSEIF MEST == "PR"
       MPRM:=MPRM+1
    ELSEIF MEST == "RJ"
       MRJM:=MRJM+1
    ELSEIF MEST == "RN"
       MRNM:=MRNM+1
    ELSEIF MEST == "RR"
       MRRM:=MRRM+1
    ELSEIF MEST == "RS"
       MRSM:=MRSM+1
    ELSEIF MEST == "RO"
       MROM:=MROM+1
    ELSEIF MEST == "SC"
       MSCM:=MSCM+1
    ELSEIF MEST == "SE"
       MSEM:=MSEM+1
    ELSEIF MEST == "SP"
       MSPM:=MSPM+1
    ELSEIF MEST == "TO"
       MTOM:=MTOM+1
    ELSEIF MEST == "EX"
       MEXM:=MEXM+1
    ENDIF

Return
