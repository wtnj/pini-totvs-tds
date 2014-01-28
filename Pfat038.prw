#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFDEF WINDOWS
        #DEFINE SAY PSAY
#ENDIF

User Function Pfat038()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("TITULO,CDESC1,CTITULO,CCABEC1,CCABEC2,NCARACTER")
SetPrvt("TAMANHO,LIMITE,ARETURN,CPROGRAMA,CPERG,_ACAMPOS")
SetPrvt("_CNOME,M_PAG,LCONTINUA,WNREL,L,CDESC2")
SetPrvt("CDESC3,CSTRING,NLASTKEY,MPEDIDO,MCODCLI,MCODVEND")
SetPrvt("MDTDIGIT,MVALOR,MNOMEVEND,MNOMECLI,MNOTA,MDATFAT")
SetPrvt("MTOTAL,CINDEX,MTOTVEND,MPART,mhora")

#IFDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>         #DEFINE SAY PSAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT038   ³Autor: Solange Nalini         ³ Data:   10/02/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de Vendas por Regiao de Vendas                   ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Ambientais                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Da data:                             ³
//³ mv_par02             // Ate a data:                          ³
//³ mv_par03             // Div. Vendas                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
titulo :=PADC("RELATORIO DE VENDAS ",74)
cDesc1 :=PADC("Este programa emite relatorio de Vendas no per¡odo solicitado ",74)

cTitulo:= ' **** RELATORIO DE VENDAS  **** '

//REGUA PARA P/ CABECALHO.
//                 10        20        30        40        50        60        70         80        90        100      110       120     130         140      150       160
//        123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 12456789'
cCabec1:='Cod.Cli. RazÆo Social                             Vend. Dt.Digit.      Valor R$          N.Fiscal       EmissÆo '
cCabec2:=" "
//NCARACTER:=18
//TESTAR TAMANHO
NCARACTER:=12
tamanho:="M"
limite:=132
//////////
aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }

cprograma:="PFAT011"
CPERG:='FAT014'

If .Not. PERGUNTE(cPerg)
    Return
Endif

***********
_aCampos := {  {"CODCLI"  ,"C",6, 0} ,;
               {"CODVEND" ,"C",4, 0} ,;
               {"DATADIG" ,"D",8, 0} ,;
               {"VALOR"   ,"N",10,2} ,;
               {"NFISCAL" ,"C",6, 0} ,;
               {"EMISSAO" ,"D",8, 0} ,;
               {"NOMECLI" ,"C",40,0} ,;
               {"NOMEVEN","C",40,0 }}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"RELSW",.F.,.F.)


**********
M_PAG:=1

lContinua := .T.
MHORA      := TIME()
wnrel    := "PFAT038_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)

L:= 0


cDesc2 :=""
cDesc3 :=""


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas.                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


cString:="SC5"
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

#IFDEF WINDOWS
       RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        RptStatus({|| Execute(RptDetail)})
       Return
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        Function RptDetail
Static Function RptDetail()
#ENDIF
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicio do Processamento                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


DBSELECTAREA("SC5")
Set Softseek on
DbSetOrder(2)
dbgotop()
dbSeek(xFilial()+DTOS(mv_par01))

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Prepara regua de impressÆo                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
setregua(Reccount())
do while dtoS(SC5->C5_EMISSAO)>=dtos(MV_PAR01) .and. dtos(SC5->C5_EMISSAO)<=dtos(mv_par02)
   Incregua()
   If C5_DIVVEN #mv_par03
      Dbskip()
      loop
   Endif
   mPedido  := C5_NUM
   mCodCli  := C5_CLIENTE
   mCodVend := C5_Vend1
   mDtdigit := C5_Emissao
   mValor   := C5_VlrPed

   dbSelectArea("SA3")
   dbSeek(xFilial()+mCodvend)
   If found()
      mNomevend := SA3->A3_NOME
   Endif


   dbSelectArea("SA1")
   dbSeek(xFilial()+mCodcli)
   If found()
      mNomecli := SA1->A1_NOME
   ENDIF
   dbSelectArea("SC6")
   dbSetOrder(1)
   dbSeek(xFilial()+mPedido)
   mNota    := C6_NOTA
   mDatFat  := C6_DATFAT

   Grava_Venda()
   dbSelectArea("SC5")
   DbSetOrder(2)
   dbSkip()
enddo

//DBSELECTAREA("RELSW")
//COPY TO JPIRES
//DBCLOSEAREA()
Imprel()


SET DEVICE TO SCREEN
IF aRETURN[5] == 1
  Set Printer to
  dbcommitAll()
  ourspool(WNREL)
ENDIF
MS_FLUSH()

Return



// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function Grava_Venda
Static Function Grava_Venda()

dbSelectArea("RELSW")
    DBAPPEND()
    Replace CODCLI   with  mCodcli
    Replace CODVEND  with  mCodvend
    Replace DATADIG  with  mDtdigit
    Replace VALOR    with  mValor
    Replace NFISCAL  with  mNota
    Replace EMISSAO  with  mDatFat
    Replace NOMECLI  with  mNomecli
    Replace NOMEVEN  with  mNomevend
Return


// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function Imprel
Static Function Imprel()
//  testar a pagina
   mtotal   := 0
   l:=0
   dbSelectArea("RELSW")
   cIndex:=CriaTrab(Nil,.F.)
   Indregua("RELSW",cIndex,dtoc(DATADIG),,,"AGUARDE....CRIANDO INDICE ")

   do While .not. eof()
   If l==0
      CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
      L:=08
   Endif

  //testar a pagina

   @ L,01 PSAY CODCLI
   @ L,10 PSAY NOMECLI
   @ L,51 PSAY CODVEND
   @ l,57 PSAY DATADIG
   @ l,69 PSAY STR(VALOR,12,2)
   @ l,90 PSAY NFISCAL
   @ l,105 PSAY EMISSAO
   mTotal := mTotal + VALOR
   IF L>60
      L:=0
      M_PAG:=M_PAG+1
   ELSE
      L:=L+1
   ENDIF
   DBSKIP()

//  IncRegua()

  ENDDO
  l:=l+1
  @ l,70 PSAY '------------'
  @ L+1,57 PSAY 'TOTAL...'
  @ l+1,69 PSAY STR(Mtotal,12,2)
  IF L>50
//     cCabec1:='        Cod.Vend. Nome                                         Valor        Partic.%'
      cCabec1:=' '
     L:=0
     M_PAG:=M_PAG+1
  ELSE
     l:= l+3
  Endif
//  endif

  IF L==0
    CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
  l:= 8
  ENDIF

     @ l,00 PSAY PADC("** RESUMO POR VENDEDOR **", 132)
     l:=L+2
     @ l,10 PSAY 'Codigo'
     @ l,20 PSAY 'Vendedor'
     @ l,72 PSAY 'Valor'
     @ l,95 PSAY 'Partic.%'
     l:=l+1
     @ l,10 PSAY '------'
     @ l,20 PSAY '--------'
     @ l,72 PSAY '-----'
     @ l,95 PSAY '--------'
     l:=l+2
//   dbSelectArea("RELSW")
  cIndex:=CriaTrab(NIL,.F.)
  Indregua("RELSW",cIndex,"codvend",,,"AGUARDE ..........")
  do while .not. eof()
     mtotvend := 0
     mcodvend := CODVEND
     mNomevend:= NOMEVEN
     do while mcodvend == Codvend
        mtotvend := mtotvend+valor
        dbskip()
     enddo
     mpart:=mtotvend*100/mtotal
     @ l,10 PSAY mcodvend
     @ l,20 PSAY mnomevend
     @ l,65 PSAY STR(mtotvend,12,2)
     @ l,95 PSAY trim(str(mpart,6,2))+' %'
     l:=l+2
     incregua()
  enddo

  @ L+1,10 PSAY 'Total ......'
  @ L+1,65 PSAY STR(MTOTAL,12,2)
  @ L+1,95 PSAY ' 100,00 %'
  dbclosearea()
Return









