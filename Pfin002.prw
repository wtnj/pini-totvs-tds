#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
#IFDEF WINDOWS
        #DEFINE SAY PSAY
#ENDIF

User Function Pfin002()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("TITULO,CDESC1,CTITULO,NCARACTER,TAMANHO,LIMITE")
SetPrvt("ARETURN,CPROGRAMA,CPERG,_CNOME,CINDEX,CKEY")
SetPrvt("MCODCLI,MTPPROD,M_PAG,LCONTINUA,WNREL,L")
SetPrvt("CDESC2,CDESC3,CSTRING,NLASTKEY,LIN,COL")
SetPrvt("LI,")

#IFDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 26/02/02 ==>         #DEFINE SAY PSAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFIN002   ³Autor: Solange Nalini         ³ Data:   26/04/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Etiquetas para cartas de cobranca                          ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
titulo :=PADC("ETIQUETAS PARA CARTAS DE COBRANCA ",74)
cDesc1 :=PADC("Este programa emite Etiquetas para cartas de cobranca",74)

cTitulo:= ' **** ETIQUETAS PARA CARTA DE COBRANCA  **** '

NCARACTER:=12
tamanho:="M"
limite:=132

aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }

cprograma:="ETIQCOB"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Cod.Portador                         ³
//³ mv_par02             // Do portador                          ³
//³ mv_par02             // Ate o portador                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG:='FAT019'

IF SM0->M0_CODIGO == '01'
  _cNome := "VERCOBR"
  dbUseArea(.T.,, _cNome,"VERCOBR",.F.,.F.)
  cIndex:=CriaTrab(Nil,.F.)
  cKey:="TPPROD+CEP+CODCLI+DUPL+PARCELA+DTOS(VENCTO)"
  Indregua("VERCOBR",cIndex,cKey,,,"AGUARDE....CRIANDO INDICE ")
ELSE
  _cNome := "VERCOBP"
  dbUseArea(.T.,, _cNome,"VERCOBP",.F.,.F.)
  cIndex:=CriaTrab(Nil,.F.)
  cKey:="TPPROD+CEP+CODCLI+DUPL+PARCELA+DTOS(VENCTO)"
  Indregua("VERCOBP",cIndex,cKey,,,"AGUARDE....CRIANDO INDICE ")
ENDIF

GO TOP
DO WHILE .NOT. EOF()
   MCODCLI:=CODCLI
   MTPPROD:=TPPROD
   DBSKIP()
   DO WHILE CODCLI==MCODCLI .AND. TPPROD==MTPPROD
      DELE
      DBSKIP()
   ENDDO
ENDDO

GO TOP

M_PAG:=1
lContinua := .T.
wnrel    := "ETIQCOB"
L:= 0
cDesc2 :=""
cDesc3 :=""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas.                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


cString:="SE1"
NLASTKEY:=0

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

cDesc1:=' '
cDesc2:=' '
cDesc3:=' '
cString:='COBR'
wnrel:="COBR"
//wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

//If nLastKey == 27
//   Return
//Endif

//NLASTKEY:=0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica Posicao do Formulario na Impressora                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//SetDefault(aReturn,cString)

//If nLastKey == 27
//   Return
//Endif

//SET DEVI TO PRINT
IF SM0->M0_CODIGO == '01'
   DBSELECTAREA("VERCOBR")
ELSE
   DBSELECTAREA("VERCOBP")
ENDIF
DBGOTOP()
SETPRC(0,0)
LIN:=0
COL:=1
LI:=0
DO WHILE .NOT. EOF()
                @ LIN+LI,001 PSAY NOMECLI
                DBSKIP()
                @ LIN+LI,043 PSAY NOMECLI
                DBSKIP()
                @ LIN+LI,087 PSAY NOMECLI
                DBSKIP(-2)
                LI:=LI+1

                @ LIN+LI,001 PSAY NOMEDEST
                DBSKIP()
                @ LIN+LI,043 PSAY NOMEDEST
                DBSKIP()
                @ LIN+LI,087 PSAY NOMEDEST
                DBSKIP(-2)
                LI:=LI+1

                @ LIN+LI,001 PSAY V_END
                DBSKIP()
                @ LIN+LI,043 PSAY V_END
                DBSKIP()
                @ LIN+LI,087 PSAY V_END
                DBSKIP(-2)
                LI:=LI+1

                @ LIN+LI,001 PSAY BAIRRO
                DBSKIP()
                @ LIN+LI,043 PSAY BAIRRO
                DBSKIP()
                @ LIN+LI,087 PSAY BAIRRO
                DBSKIP(-2)
                LI:=LI+1

                @ LIN+LI,001 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +CIDADE+' ' +ESTADO
                DBSKIP()
                @ LIN+LI,043 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +CIDADE+' ' +ESTADO
                DBSKIP()
                @ LIN+LI,087 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +CIDADE+' ' +ESTADO
                LI:=LI+1
                DBSKIP()

                LI:=2
                setprc(0,0)
                lin:=prow()
            ENDDO
SET DEVICE TO SCREEN



IF aRETURN[5] == 1
  Set Printer to
  dbcommitAll()
  ourspool(WNREL)
ENDIF
MS_FLUSH()

DBCLOSEAREA()
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> __Return()
Return()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
return




