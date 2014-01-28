#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
#IFNDEF WINDOWS
        #DEFINE PSAY SAY
#ENDIF
//Alterado por Danilo C S Pala em 20041014 : 930
//Danilo C S Pala 20060327: dados de enderecamento do DNE

User Function Pfin012()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("TITULO,CDESC1,CTITULO,NCARACTER,TAMANHO,LIMITE")
SetPrvt("ARETURN,CPROGRAMA,CPERG,_ACAMPOS,_CNOME,MTAXA")
SetPrvt("M_PAG,LCONTINUA,WNREL,L,CDESC2,CDESC3")
SetPrvt("CSTRING,NLASTKEY,CINDEX,CKEY,_CFILTRO,MNCODPORT")
SetPrvt("MNOME,MEND,MBAIRRO,MCIDADE,MCEP,MESTADO")
SetPrvt("MAVISO,MREGPOS,MCODCLI,MPEDIDO,MPRODUTO,MDUPL")
SetPrvt("MPARCELA,MVENCTO,MNVENCTO,MDIAS,MVALOR,MJUROS")
SetPrvt("MNVALOR,MCODDEST,MDEST,MTOTAL,MDUPLICATAS,")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 26/02/02 ==>         #DEFINE PSAY SAY
#ENDIF
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma : PFIN012  쿌utor: Solange Nalini         � Data:   26/04/99 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escricao: Cartas de Cobranca - Pini Sistemas                         � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿌lteracoes: 11.02.00 Conversao para Windows. Regularizacao de nao-con-� 굇
굇�                     formidades conf.OS desta data. Andreia Silva.    � 굇
굇�            14.02.00 Disponibilizacao do pgm para versao Dos - ADS.   � 굇
굇�                     Andreia Silva                                    � 굇
굇�            16.02.00 Testes e Validacoes para processamento na  versao� 굇
굇�                     Windows - ADS. Andreia Silva                     � 굇
굇�            23.02.00 Verificacao da criacao de indices, bem como mudan� 굇
굇�                     cas no Filtro. Andreia Silva                     � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : Especifico para Editora Pini - Modulo Financeiro           � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Vencidos At�                         �
//� mv_par02             // Do Portador                          �
//� mv_par03             // At� o Portador                       �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
titulo  := PADC("Extrato de Conta Corrente de Cliente  ",74)
cDesc1  := PADC("Este programa emite extrato de conta corrente de cliente",74)

cTitulo := ' **** Extrato de Conta Corrente  **** '

NCARACTER := 12
tamanho   := "M"
limite    := 132

aReturn   := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }

cprograma := "COBR"
CPERG     := 'FAT019'

If .Not. PERGUNTE(cPerg)
    Return
Endif

***********
_aCampos := {  {"CODCLI"   ,"C",6 ,0},;
               {"CODDEST"  ,"C",6 ,0},;
               {"DUPL"     ,"C",6 ,0},;
               {"PARCELA"  ,"C",1 ,0},;
               {"VENCTO"   ,"D",8 ,0},;
               {"NVENCTO"  ,"D",8 ,0},;
               {"VALOR"    ,"N",10,2},;
               {"NVALOR"   ,"N",10,2},;
               {"PEDIDO"   ,"C",6 ,0},;
               {"NOMEDEST" ,"C",40,0},;
               {"NOMECLI"  ,"C",40,0},;
               {"V_END"      ,"C",120,0},;
               {"BAIRRO"   ,"C",20,0},;
               {"CIDADE"   ,"C",20,0},;
               {"ESTADO"   ,"C",2 ,0},;
               {"CEP"      ,"C",8 ,0},;
               {"AVISO"    ,"C",9 ,0},;
               {"TPPROD"   ,"C",2 ,0}}

dbCreate("VERCOBP",_aCampos,__LocalDriver)
_cNome := "VERCOBP"
dbUseArea(.T.,, _cNome,"COBR",.F.,.F.)

mtaxa     := 0.17
M_PAG     := 1
lContinua := .T.
wnrel     := "COBR"
L         := 0
cDesc2    := " "
cDesc3    := " "

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Verifica as perguntas selecionadas.                                     �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

cString  := "SE1"
nLastKey := 0

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

#IFDEF WINDOWS
        RptStatus({|| ProcCC()})// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>         RptStatus({|| Execute(ProcCC)})
#ELSE
        ProcCC()
#ENDIF

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma : PROCC    쿌utor: Solange Nalini         � Data:   26/04/99 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escricao: Processa Cartas de Cobranca                                � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : Especifico para Editora Pini - Modulo Financeiro           � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function ProcCC
Static Function ProcCC()
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Inicio do Processamento                                      �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

dbSelectArea("SE1")
cIndex:=CriaTrab(Nil,.F.)
cKey:="DTOS(E1_VENCREA)+E1_NUM"
_cFiltro := 'E1_FILIAL == "'+ xFilial("SE1")+'"'
_cFiltro := _cFiltro + '.And. E1_SALDO > 0 .AND. E1_TIPO == "NF "'
_cFiltro := _cFiltro + '.And. (E1_SERIE == "UNI" .OR. E1_SERIE == "SER")'
Indregua("SE1",cIndex,ckey,,_cFiltro,"Selecionando Registros do Arq")
dbGoTop()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//�  Prepara regua de impress�o                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
SetRegua(Reccount())

mnCodPort := " "
mnome     := " "
mend      := " "
mbairro   := " "
mcidade   := " "
mcep      := " "
mestado   := " "

While !EOF() .and. DTOS(SE1->E1_VENCREA) <= DTOS(MV_PAR01)

  IncRegua()

  IF SM0->M0_CODIGO #'02'
     DBSKIP()
     LOOP
  ENDIF

  If SE1->E1_PORTADO < MV_PAR02 .OR. SE1->E1_PORTADO > MV_PAR03
     dbSkip()
     Loop
  EndIf

  If 'LUCROS E PERDAS' $(SE1->E1_HIST) .OR. 'CAN' $(SE1->E1_MOTIVO) .OR.;
     'NF CANCELADA' $(SE1->E1_HIST)
     dbSkip()
     Loop
  EndIf

  IF SE1->E1_DTCARTA <> CTOD('  /  /  ') .AND. DATE() < (SE1->E1_DTCARTA + 5)
     dbSkip()
     Loop
  EndIf

  IF DToC(SE1->E1_PGPROG)#" " .Or. SE1->E1_PORTADO=="916" .Or. SE1->E1_PORTADO=="900" .Or.;
     SE1->E1_PORTADO=="904" .Or. SE1->E1_PORTADO=="920" .Or. SE1->E1_PORTADO=="930" .Or. SE1->E1_PORTADO=="995" //20041014
     dbSkip()
     Loop
  ENDIF

  IF SE1->E1_PORTADO=="905" .Or. SE1->E1_PORTADO=="917"
     dbSkip()
     Loop
  ENDIF

  IF SE1->E1_PORTADO=='992' .AND. (SE1->E1_GRPROD=='0200' .OR. SE1->E1_GRPROD=='0700')
     dbSkip()
     Loop
  ENDIF

  Do Case
     CASE E1_PORTADO == '992'
          mAviso:=' '
          mnCodPort:='904'
     CASE E1_PORTADO == '991'
          mAviso:='2o.AVISO'
          mnCodPort:='992'
     OTHERWISE
          mnCodPort:='991'
          mAviso:='1o.AVISO'
  EndCase

   mRegPos  :=RecNo()
   mCodCli  := E1_CLIENTE
   mPedido  := E1_PEDIDO
   mproduto := E1_GRPROD // E1_TPPROD
   mdupl    := E1_NUM
   mparcela := E1_PARCELA
   mvencto  := E1_VENCREA
   mnvencto := date()+7
   mdias    := mnvencto - mvencto
   mValor   := E1_VALOR
   mJuros   := (E1_VALOR*(mtaxa/100))*mdias
   mNvalor  := E1_VALOR+mjuros

   dbSelectArea("SC6")
   dbSeek(xFilial()+mpedido)
   If Found()
      mCodDest:=C6_CODDEST
   Else
      mCodDest:='  '
   EndIf

   dbSelectArea("SA1")
   dbseek(xFilial()+mcodcli)
   If Found()
      mnome     := A1_NOME
      mend      := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060327
      mbairro   := A1_BAIRRO
      mcidade   := A1_MUN
      mcep      := A1_CEP
      mestado   := A1_EST
   EndIf
   mDest:=' '
   IF Val(mCodDest) #0
      dbSelectArea("SZN")
      DBSEEK(XFILIAL()+MCODCLI+MCODDEST)
      IF FOUND()
         MDEST:=ZN_NOME
      ENDIF
      DBSELECTAREA("SZO")
      DBSEEK(XFILIAL()+MCODCLI+MCODDEST)
      IF FOUND()
         mend   := ALLTRIM(SZO->ZO_TPLOG) + " " + ALLTRIM(SZO->ZO_LOGR) + " " + ALLTRIM(SZO->ZO_NLOGR) + " " + ALLTRIM(SZO->ZO_COMPL) //20060327
         mbairro:=ZO_BAIRRO
         mcidade:=ZO_CIDADE
         mcep   :=ZO_CEP
         mestado:=ZO_ESTADO
      ENDIF
   ENDIF

   IF MAVISO <> ' '
      Grava_Cobr()
   ENDIF

   dbSelectArea("SE1")
   RecLock("SE1",.F.)
   SE1->E1_CODPORT := mnCodPort
   SE1->E1_DTCARTA := DATE()
   SE1->E1_PORTADO := mnCodPort
   se1->(MsUnLock())

   dbSelectArea("SE1")
   dbSkip()
Enddo

DBSELECTAREA("COBR")
DbGotop()

EXTRATO()
SET DEVI TO SCREEN
dbclosearea()

IF aRETURN[5] == 1
  Set Printer to
  dbcommitAll()
  ourspool(WNREL)
ENDIF
MS_FLUSH()

dbselectarea("SE1")
RETINDEX("SE1")

dbselectarea("SA1")
RETINDEX("SA1")
Return

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function Grava_Cobr
Static Function Grava_Cobr()
   dbSelectArea("COBR")
   RecLock("COBR",.T.)
   COBR->CODCLI   := mCodCli
   COBR->PEDIDO   := mPedido
   COBR->TPPROD   := mproduto
   COBR->DUPL     := mdupl
   COBR->PARCELA  := mparcela
   COBR->VENCTO   := mvencto
   COBR->NVENCTO  := mnvencto
   COBR->VALOR    := mValor
   COBR->NVALOR   := mnValor
   COBR->CODDEST  := MCODDEST
   COBR->NOMEDEST := MDEST
   COBR->NOMECLI  := MNOME
   COBR->V_END      := MEND
   COBR->BAIRRO   := MBAIRRO
   COBR->CIDADE   := MCIDADE
   COBR->ESTADO   := MESTADO
   COBR->CEP      := MCEP
   COBR->AVISO    := MAVISO
   COBR->(MsUnLock())
Return

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function EXTRATO
Static Function EXTRATO()
   mTotal   := 0
   l:=0
   dbSelectArea("COBR")
   cIndex:=CriaTrab(Nil,.F.)
   cKey:="TPPROD+CEP+CODCLI+DUPL+PARCELA+DTOS(VENCTO)"
   Indregua("COBR",cIndex,cKey,,,"Aguarde....Criando indice")
   dbGoTop()

   While !Eof()
     If l == 0
        @ l,00   PSAY "PINI SISTEMAS LTDA"
        @ L,62   PSAY 'CONTAS A RECEBER'
        @ L+1,00 PSAY 'EMISSAO:'+DTOC(DATE())
        @ L+1,62 PSAY AVISO
        @ L+3,26 PSAY 'EXTRATO DE CONTA CORRENTE'
        L:=L+5
     Endif

     @ L,00   PSAY 'COD.CLIENTE...: ' + codcli + ' ' +nomecli
     @ L+1,00 PSAY 'DESTINATARIO..: ' + nomedest
     @ L+2,00 PSAY 'ENDERECO .....: ' + ALLTRIM(V_END)
     @ L+3,00 PSAY 'BAIRRO........: ' + BAIRRO
     @ L+4,00 PSAY 'CEP/CIDADE/EST: ' + SUBSTR(CEP,1,5)+'-'+SUBSTR(CEP,6,3)+' ' +CIDADE+' '+ESTADO
     L:=L+6

     @ L,00 PSAY   'PRODUTO/SERVICO'
     @ L+1,00 PSAY '==============='
     L:=L+3
     MPEDIDO:=PEDIDO
     DBSELECTAREA("SC6")
     DBSEEK(xFilial() + mPedido )
     While !EOF() .And. C6_NUM==mPEDIDO
        IF SUBS(C6_PRODUTO,1,2)=='99' .OR. C6_TES=='650' .OR. C6_TES=='651'
           dbSkip()
           Loop
        ENDIF
        DO CASE
           CASE SUBS(C6_PRODUTO,1,2)=='01'
             @  L,00 PSAY 'REVISTA...: ' + C6_DESCRI
           CASE SUBS(C6_PRODUTO,1,2)=='02'
             @ L,00 PSAY 'LIVRO......: ' + C6_DESCRI
           CASE SUBS(C6_PRODUTO,1,2)=='07'
             @ L,00 PSAY 'VIDEO/CDROM: ' + C6_DESCRI
           OTHERWISE
             @ L,00 PSAY C6_DESCRI
         ENDCASE

         dbSkip()

         IF L>60
            L:=0
         ELSE
            L:=L+1
         ENDIF
     ENDDO

     L:=25
     MDUPLICATAS:=SPACE(1)
     @ L,00 PSAY 'DUPLICATA'
     @ L,12 PSAY ' VENCTO'
     @ L,27 PSAY 'VLR ORIGINAL'
     @ L,47 PSAY 'NOVO VENCTO'
     @ L,62 PSAY 'VLR ATUALIZADO'
     @ L+1,00 PSAY '========='
     @ L+1,12 PSAY '========'
     @ L+1,27 PSAY '============'
     @ L+1,47 PSAY '==========='
     @ L+1,62 PSAY '=============='
     L:=L+2

     dbSelectArea("COBR")
     WHILE !Eof() .And. mPedido == Pedido
       @ L,00 PSAY DUPL+' '+PARCELA
       @ L,12 PSAY VENCTO
       @ L,29 PSAY VALOR
       @ L,48 PSAY NVENCTO
       @ L,66 PSAY NVALOR

       mDuplicatas:=mDuplicatas+' ' + DUPL+' '+PARCELA
       dbSkip()

       IF L>60
          L:=0
       ELSE
          L:=L+1
       ENDIF
     ENDDO

     L:=40
     @ L,00 PSAY 'DESTAQUE E ENCAMINHE A PINI SISTEMAS LTDA - COBRANCA - R ANHAIA,964'
     @ L+1,00 PSAY 'CAPITAL/SP   CEP 01130-900'
     @ L+2,00 PSAY REPLICATE('-',80)
     @ L+4,00 PSAY ' [ ]  EM ANEXO SEGUE O COMPROVANTE DE PAGAMENTO DA(S) DUPLICATA(S) ABAIXO:'
     @ L+6,00 PSAY ' [ ]  EM ANEXO SEGUE O CHEQUE NO............., DO BANCO ............, NO'
     @ L+7,00 PSAY '      VALOR ATUALIZADO INFORMADO PARA PAGAMENTO DA(S) DUPLICATAS ABAIXO:'
     @ L+9,00 PSAY '      DUPLICATA(S): ' +MDUPLICATAS

     L:=0
     DBSELECTAREA("COBR")
   EndDo
Return

