#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Pfat034()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CBTXT,CBCONT,NORDEM,ALFA,Z,M")
SetPrvt("TAMANHO,LIMITE,TITULO,CDESC1,CDESC2,CDESC3")
SetPrvt("CNATUREZA,ARETURN,NOMEPROG,CPERG,NLASTKEY,LCONTINUA")
SetPrvt("LIN,LI,WNREL,NTAMNF,CSTRING,mhora")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: PFAT034   쿌utor: Solange Nalini         � Data:   10/01/98 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri놹o: Emissao de etiquetas de clientes                           � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento                                      � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Da Nota Fiscal                       �
//� mv_par02             // Ate a Nota Fiscal                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
CbTxt:=""
CbCont:=""
nOrdem :=0
Alfa := 0
Z:=0
M:=0
tamanho:="M"
limite:=132
titulo :=PADC(" ETIQUETAS",74)
cDesc1 :=PADC("Este programa ira emitir ETIQUETAS DE CLIENTES",74)

cDesc2 :=""
cDesc3 :=PADC("da Nfiscal",74)
cNatureza:=""
aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
nomeprog:="TESTE"
cPerg:="FAT004"
nLastKey:= 0
lContinua := .T.
Lin:=0
LI:=0
MHORA      := TIME()
wnrel    := "TETIQ_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)



//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Tamanho do Formulario de Nota Fiscal (em Linhas)          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

nTamNf:=72     // Apenas Informativo

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Verifica as perguntas selecionadas, busca o padrao da Nfiscal           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Pergunte(cPerg,.T.)               // Pergunta no SX1

cString:="SA1"

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Envia controle para a funcao SETPRINT                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
   Return
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica Posicao do Formulario na Impressora                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

//VerImp()

                DbSelectArea("Sa1")
                DBGOTOP()
                SET DEVIce TO PRINTer
                DO WHILE .NOT. EOF()
                @ LIN+LI,001 psay SA1->A1_NOME
                DBSKIP()
                @ LIN+LI,045 psay SA1->A1_NOME
                DBSKIP(-1)
                LI:=LI+1
                @ LIN+LI,001 psay SA1->A1_END
                DBSKIP()
                @ LIN+LI,045 psay SA1->A1_END
                DBSKIP(-1)
                LI:=LI+1
                @ LIN+LI,001 psay SA1->A1_MUN
                DBSKIP()
                @ LIN+LI,045 psay SA1->A1_MUN
                DBSKIP(-1)
                LI:=LI+1
                @ LIN+LI,001 psay SA1->A1_EST
                DBSKIP()
                @ LIN+LI,045 psay SA1->A1_EST
                DBSKIP(-1)
                LI:=LI+1
                @ LIN+LI,001 psay SA1->A1_CEP
                DBSKIP()
                LI:=LI+1
                @ LIN+LI,045 psay SA1->A1_CEP
                DBSKIP()
                LI:=LI+1
                setprc(0,0)
                lin:=prow()
            ENDDO

      @ LIN+LI,00 psay ' '
                SetPrc(0,0)
                liN := 14
                LI:=0
                SET DEVIce TO SCREEN
                DbSelectArea("SE1")
                RecLock("SE1",.F.)
                   replace E1_DUPLEM WITH 'S'
                se1->(msUnlock())
RETURN .T.

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> __Return()
Return()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

