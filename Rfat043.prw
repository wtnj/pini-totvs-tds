#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFDEF WINDOWS
    #DEFINE SAY PSAY
#ENDIF

User Function Rfat043()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
//Alterado por Danilo C S Pala em 20050520: CFB
//Alterado por Danilo C S Pala em 20061031: ANG
//Alterado por Danilo C S Pala em 20070315: CFE
//Alterado por Danilo C S Pala em 20070328: NFS

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//�����������������������������������������������������������������������

SetPrvt("TITULO,CDESC1,CTITULO,REGUA,CCABEC1,CCABEC2")
SetPrvt("NCARACTER,TAMANHO,LIMITE,CPROGRAMA,CPERG,ARETURN")
SetPrvt("_ACAMPOS,_CARQ,CINDEX,_CKEY,M_PAG,LCONTINUA")
SetPrvt("WNREL,L,CDESC2,CDESC3,CSTRING,NLASTKEY")
SetPrvt("_CINDEX,_CFILTRO,MPRODUTO,MQTDE,MVALOR,MDESCRICAO")
SetPrvt("MTOTAL,")

#IFDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     #DEFINE SAY PSAY
#ENDIF
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: RELLIV    �Autor: Solange Nalini         � Data:   18/05/01 � ��
������������������������������������������������������������������������Ĵ ��
���Descri��o: Relatorio de Livros vendidos no m�s                        � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento                                      � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

//��������������������������������������������������������������Ŀ
//� Define Variaveis Ambientais                                  �
//����������������������������������������������������������������

//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Da data:                             �
//� mv_par02             // Ate a data:                          �
//� mv_par03             // Div. Vendas-->nao usado neste rel     �
//����������������������������������������������������������������
titulo :=PADC("RELATORIO DE LIVROS VENDIDOS",74)
cDesc1 :=PADC("Este programa emite relatorio de Livros vendiso no per�odo solicitado ",74)
cTitulo:= ' **** RELATORIO DE VENDAS DE LIVROS **** '
regua:=   '123456789 123456789 123456789 123456789 123456789 123456789'
cCabec1:= 'Cod.Produto   Descri��o                     Qtde      Valor R$'
cCabec2:=" "
NCARACTER:=12
tamanho:="M"
limite:=132

cprograma:="RELliv"
CPERG:='FAT014'

If !PERGUNTE(cPerg)
   Return
Endif

aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }

_aCampos := {{"codprod"  ,"C",15, 0} ,;
             {"descricao" ,"C",40, 0} ,;
             {"qtde" ,"N",6, 0} ,;
             {"VALOR"   ,"N",10,2}}

_cArq := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cArq,"RELLIV",.F.,.F.)
cIndex:=CriaTrab(Nil,.F.)
_cKey    := codprod
IndRegua("RELLIV",cIndex,_cKey,,,"Selecionando registros .. ")


M_PAG:=1
lContinua := .T.
wnrel    := "RELLIV"
L:= 0
cDesc2 :=""
cDesc3 :=""
cString:="SD2"
NLASTKEY:=0

//��������������������������������������������������������������Ŀ
//� Envia controle para a funcao SETPRINT                        �
//����������������������������������������������������������������
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
        Return
Endif

//��������������������������������������������������������������Ŀ
//� Verifica Posicao do Formulario na Impressora                 �
//����������������������������������������������������������������
SetDefault(aReturn,cString)

If nLastKey == 27
        Return
Endif

#IFDEF WINDOWS
    RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     RptStatus({|| Execute(RptDetail)})
    Return
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     Function RptDetail
Static Function RptDetail()
#ENDIF
//��������������������������������������������������������������Ŀ
//� Inicio do Processamento                                      �
//����������������������������������������������������������������


dbSelectArea("SD2")

//��������������������������������������������������������������Ŀ
//�  Prepara regua de impress�o                                  �
//����������������������������������������������������������������
_cIndex:=CriaTrab(Nil,.F.)
_cKey    := "DTOS(D2_EMISSAO)+D2_COD"
_cFiltro  := 'D2_FILIAL=="'+xFilial('SD2')+'".and.SUBS(D2_COD,1,2)="02"'
_cFiltro  := _cFiltro+ '.and. DTOS(D2_EMISSAO)>=MV_PAR01 .AND.'
_cFiltro  := _cFiltro+ '.and. DTOS(D2_EMISSAO)<=MV_PAR02'

IndRegua("SD2",_cIndex,_cKey,,_cFiltro,"Selecionando registros .. ")

SetRegua(RecCount())

While .T.
    IncRegua()

    If SD2->D2_SERIE #'UNI'.AND.D2_SERIE#'CNE'.AND.D2_SERIE#'CUP'.AND.D2_SERIE#'D1' .AND.D2_SERIE#'CFS' .AND.D2_SERIE#'CFA' .AND.D2_SERIE#'CFB' .AND.D2_SERIE#'ANG' .AND.D2_SERIE#'CFE' .AND. D2_SERIE#'NFS' //20050520 : CFB //20061031 ANG //20070315 CFE //20070328 NFS
       Dbskip()
       Loop
    Endif
    IF SD2->D2_TES=='650' .OR. SD2->D2_TES=='651'
       DBSELECTAREA("SD2")
       DBSKIP()
       LOOP
    ENDIF
    mProduto := SD2->D2_COD
    mQTDE    := SD2->D2_QTDVEN
    mVALOR   := SD2->D2_TOTAL

    dbSelectArea("SB1")
    dbSeek(XFILIAL()+MPRODUTO)
    MDESCRICAO:=SB1->B1_DESC
    Grava_Venda()
    DBSELECTAREA("SD2")
    dbSkip()
 End


Imprel()

SET DEVI TO SCREEN
dbSelectArea("RELSW")
Copy To I:\SIGA\SIGAADV\EXPORTA\LIVROS
dbCloseArea()
fErase(_cNome+".DBF")
fErase(cIndex+OrdBagExt())

If aRETURN[5] == 1
        Set Printer to
        dbcommitAll()
        ourspool(WNREL)
EndIf

MS_FLUSH()

Return


// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function Grava_Venda
Static Function Grava_Venda()
DBSELECTAREA("RELLIV")
DbSeek(MPRODUTO)
IF FOUND()
   RecLock("RELLIV",.F.)
     RELLIV->VALOR    := RELLIV->VALOR+mvalor
   RELLIV->(MsUnlock())
else
   RecLock("RELIV",.T.)
     RELLIV->CODPROD  := mCodProd
     RELLIV->descricao:= mDescricao
     RELLIV->qtde     := mqtde
     RELLIV->VALOR    := mvalor
   RELIV->(MsUnlock())
ENDIF

Return


// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function Imprel
Static Function Imprel()

mtotal   := 0
L:=0
dbSelectArea("RELLIV")
dbGoTop()

#IFDEF WINDOWS
    RptStatus({||_RunPrint2()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     RptStatus({||Execute(_RunPrint2)})
    Return
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     Function _RunPrint2
Static Function _RunPrint2()
#ENDIF

SetRegua(RECCOUNT())
While !EOF()

    IncRegua()
    If L == 0 .OR. L > 60
                CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
                L:=08
        Endif
    @ L,001 PSAY CODPROD
    @ L,015 PSAY DESCRICAO
    @ L,055 PSAY QTDE
    @ L,065 PSAY VALOR
    IF L > 60
        L       := 0
        M_PAG   := M_PAG + 1
        ELSE
        L       := L + 1
        ENDIF

End

Return
