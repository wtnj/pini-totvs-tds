#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
#IFNDEF WINDOWS
     #DEFINE PSAY SAY
#ENDIF

User Function pfin011()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//�����������������������������������������������������������������������

SetPrvt("CSTRING,WNREL,TAMANHO,TITULO,CDESC1,CDESC2")
SetPrvt("CDESC3,ARETURN,NOMEPROG,NLASTKEY,AORD,CBTXT")
SetPrvt("CPERG,LIMITE,_NVLRTOT,_NSDOTOT,_NVLRGER,_NSDOGER")
SetPrvt("CABEC1,CABEC2,CBCONT,LI,M_PAG,ADRIVER")
SetPrvt("NTIPO,MPORT,CINDEX,CEXPRES,CARQTMP,NINDEX")
SetPrvt("CABEC3,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 26/02/02 ==>      #DEFINE PSAY SAY
#ENDIF
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � PFIN011  � Autor � Rosane Rodrigues      � Data � 18/04/00 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Titulos em aberto no Contas a Receber. Utiliza somente o   ���
���          � arquivo SE1, conf. solicitacao da Editora Pini Ltda.       ���
���          � Somente p/ Pini Sistemas,pois considera o E1_PORTADO       ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico  Pini Sistema  e  PiniWeb.                      ���
�������������������������������������������������������������������������Ĵ��
���Alteracoes�                                          � Data �          ���
���          �                                          �      �          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
cString  := "SE1"
MHORA      := TIME()
wnRel    := "PFIN011_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
Tamanho  := "M"
Titulo   := "Titulos a Receber - Pini Sistemas Ltda"
cDesc1   := SPACE(02)+"Este programa imprimira somente titulos a receber, de acordo com os" 
cDesc2   := SPACE(08)+"parametros solicitados pelo usuario - Pini Sistemas"
cDesc3   := " "
aReturn  := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
NomeProg :="PFIN011"
nLastKey := 0
aOrd     := {}
Cbtxt	   := SPACE(10)
cPerg    := "PFIN07"
Limite   := 132           // P - 80 / M - 132 / G - 220
_nVlrTot := 0
_nSdoTot := 0
_nVlrGer := 0
_nSdoGer := 0
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01    // Data Vencto.   De                             �
//� mv_par02    //                Ate                            �
//� mv_par03    // Portador       De                             �
//� mv_par04    //                Ate                            �
//����������������������������������������������������������������
//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
pergunte(cPerg,.F.)

wnRel:=SetPrint(cString,wnRel,cPerg,space(15)+Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho)

If nLastKey == 27 
	Return
Endif

SetDefault(aReturn,cString)

If	nLastKey == 27
	Return
Endif

#IFDEF WINDOWS
   RptStatus({|| R011PRC() })// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>    RptStatus({|| Execute(R010PRC) })
#ELSE
   R011PRC()
#ENDIF

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � R010PRC  � Autor � Andreia Silva         � Data � 28/02/00 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Processa Relatorio                                         ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para Editora Pini Ltda.                         ���
�������������������������������������������������������������������������Ĵ��
���Revisao   �                                          � Data �          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION R010PRC
Static FUNCTION R011PRC()

//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para Impressao do Cabecalho e Rodape    �
//����������������������������������������������������������������
Cabec1  := " "
Cabec2  := " "
cbCont	:=  0
li      := 80
m_pag   := 1
aDriver := ReadDriver()
nTipo   := IIF(aReturn[4]==1,15,18)
mPort   := "ZZZZZ"
//��������������������������������������������������������������Ŀ
//� Filtra arquivo do Contas a Receber.                          �
//����������������������������������������������������������������

dbSelectArea("SE1")
dbSetOrder(1)
cIndex  := "E1_FILIAL + E1_PORTADO"
cExpres := 'E1_FILIAL == "'+ xFilial()
cExpres := cExpres + '" .And. DTOS(E1_VENCREA)  >= "'+ DTOS(mv_par01)
cExpres := cExpres + '" .And. DTOS(E1_VENCREA)  <= "'+ DTOS(mv_par02)
cExpres := cExpres + '" .And. E1_PORTADO        >= "'+ mv_par03
cExpres := cExpres + '" .And. E1_PORTADO        <= "'+ mv_par04 +'"'

cExpres := cExpres +".and.DTOS(E1_BAIXA)==DTOS(CTOD(' ')).and.DTOS(E1_PGPROG)==DTOS(CTOD(' '))"

cArqTmp := CriaTrab(NIL,.F.)
IndRegua("SE1", cArqTmp, cIndex,,cExpres,"Selecionando Registros ...")
nIndex := RetIndex("SE1")+1

#IFNDEF TOP
	dbSetIndex( cArqTmp + OrdBagExt())
#ENDIF

dbSelectArea("SE1")
dbSetOrder(nIndex)
dbGoTop()

SetRegua( RecCount() )

Cabec1:="Tit/Ser/Parc  Dt.Emis.  Venc.Real   Vlr.Orig.Titulo    Saldo a Receber  Codigo/Lj    Nome do Cliente    Port Numero Bancario  Nro.PV."
//       XXXXXX-XXX-X  XXXXXXXX  XXXXXXXX   99.999.999.999,99  99.999.999.999,99 XXXXXX-XX  XXXXXXXXXXXXXXXXXXXX XXX  XXXXXXXXXXXXXXX  XXXXXX
//       123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345
//                10        20        30        40        50        60        70        80        90        100       110       120       130         
Cabec2:=""
Cabec3:=""

Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)

While !Eof()

   IncRegua()
   //��������������������������������������������������������������Ŀ
   //� Verifica se o usuario interrompeu o relatorio                �
   //����������������������������������������������������������������

	#IFDEF WINDOWS
		If lAbortPrint
	#ELSE
	Inkey()
                If LastKey() == 286
	#ENDIF
	@Prow()+1,001 PSAY "CANCELADO PELO OPERADOR"
	Exit
	Endif
   
   If 'CAN' $(SE1->E1_MOTIVO) .OR. 'DEV' $(SE1->E1_MOTIVO) .OR.;
      'CANC' $(SE1->E1_HIST) .OR. 'P' $(E1_PEDIDO) .OR. E1_DIVVEN == 'PUBL';
      .OR. SM0->M0_CODIGO == '01'
       dbSkip()
       Loop
   EndIf

   //��������������������������������������������������������������Ŀ
   //� Impede a impressao de titulos ja recebidos integralmente.    �
   //����������������������������������������������������������������

   If SE1->E1_SALDO == 0.00
      dbSelectArea("SE1")
      dbSkip()
      Loop
   Endif

   IF MPORT <> 'ZZZZZ' .AND. MPORT <> SE1->E1_PORTADO
      Li := Li + 2
      @ Li,00 PSAY "Total do Portador ...: "
      @ Li,35 PSAY _nVlrTot picture "@E 99,999,999.99"
      @ Li,54 PSAY _nSdoTot picture "@E 99,999,999.99"
      _nVlrtot := 0 
      _nSdotot := 0 
      Li       := 80
   ENDIF

   If Li >= 60
      Li := 0
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
   Endif

   //��������������������������������������������������������������Ŀ
   //� Direciona linha, coluna para impressao                       �
   //����������������������������������������������������������������

   @ Li,001 PSAY SE1->E1_NUM

   //��������������������������������������������������������������Ŀ
   //� Consiste se existe serie.                                    �
   //����������������������������������������������������������������
        If !Empty(SE1->E1_SERIE)
                @ Li,007 PSAY "/"
        Endif

   //��������������������������������������������������������������Ŀ
   //� Continua o direcionamento para impressao nas linhas e colunas�
   //� correspondentes.                                             �
   //����������������������������������������������������������������

   @ Li,008 PSAY SE1->E1_SERIE

   //��������������������������������������������������������������Ŀ
   //� Consiste se existem parcelas.                                �
   //����������������������������������������������������������������
        If !Empty(SE1->E1_PARCELA)
                @ Li,011 PSAY "/"
        Endif

   //��������������������������������������������������������������Ŀ
   //� Continua o direcionamento para impressao nas linhas e colunas�
   //� correspondentes.                                             �
   //����������������������������������������������������������������

   @ Li,012 PSAY SE1->E1_PARCELA
   @ Li,015 PSAY SE1->E1_EMISSAO
   @ Li,025 PSAY SE1->E1_VENCREA
   @ Li,035 PSAY Transform(SE1->E1_VALOR,"@E 99,999,999,999.99")
   @ Li,054 PSAY Transform(SE1->E1_SALDO,"@E 99,999,999,999.99")
   @ Li,072 PSAY SE1->E1_CLIENTE
   @ Li,078 PSAY "/"
   @ Li,079 PSAY SE1->E1_LOJA
   @ Li,083 PSAY SE1->E1_NOMCLI

   //��������������������������������������������������������������Ŀ
   //� Seleciona para impressao E1_PORTADO, conforme solicita��o da �
   //� Editora Pini Ltda.                                           �
   //����������������������������������������������������������������

   @ Li,104 PSAY SE1->E1_PORTADO
   @ Li,109 PSAY SE1->E1_NUMBCO
   @ Li,126 PSAY SE1->E1_PEDIDO

   //��������������������������������������������������������������Ŀ
   //� Totaliza o valor original e o valor a receber do titulo      �
   //����������������������������������������������������������������

   _nVlrTot := _nVlrTot + SE1->E1_VALOR
   _nSdoTot := _nSdotot + SE1->E1_SALDO
   _nVlrger := _nVlrger + SE1->E1_VALOR
   _nSdoGer := _nSdoGer + SE1->E1_SALDO

   Li    := Li + 1
   MPORT := SE1->E1_PORTADO

   dbSkip()
EndDo                   // Finaliza While principal

   //��������������������������������������������������������������Ŀ
   //� Imprime totais ref. ao valor original do titulo e o valor a  �
   //� receber.                                                     �
   //����������������������������������������������������������������

   Li := Li + 1
   @ Li,001 PSAY "Total do Portador ...: "
   @ Li,035 PSAY Transform(_nVlrTot,"@E 99,999,999,999.99")
   @ Li,054 PSAY Transform(_nSdoTot,"@E 99,999,999,999.99")

   Li := Li + 3
   @ Li,001 PSAY "Total Geral .........: "
   @ Li,035 PSAY Transform(_nVlrGer,"@E 99,999,999,999.99")
   @ Li,054 PSAY Transform(_nSdoGer,"@E 99,999,999,999.99")

Roda(cbcont,cbtxt,Tamanho)
//��������������������������������������������������������������Ŀ
//� Apaga indice de trabalho                                     �
//����������������������������������������������������������������

dbSelectArea("SE1")
Set Filter To
Set Index To
RetIndex("SE1")
Ferase( cArqTmp + OrdBagExt() )

//��������������������������������������������������������������Ŀ
//� Apresenta relatorio na tela                                  �
//����������������������������������������������������������������
Set Device To Screen
If aReturn[5] == 1
     Set Printer TO 
     dbcommitAll()
     ourspool(wnRel)
Endif
Ms_Flush()

Return