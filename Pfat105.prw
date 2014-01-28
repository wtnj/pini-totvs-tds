#include "rwmake.ch"        // incluido pel o assistente de conversao do AP5 IDE em 26/02/02

/*/
//Danilo C S Pala 20060327: dados de enderecamento do DNE
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: PFAT105   �Autor: Raquel Farias          � Data:   03/01/00 � ��
������������������������������������������������������������������������Ĵ ��
���Descri�ao: Geracao do arquivo DBF - p/ estatisticas da distribuicao   � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento                                      � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/


User Function Pfat105()

SetPrvt("CDESC1,CDESC2,CDESC3,MDESCR,CPERG,LCONTINUA")
SetPrvt("MCONTA,_ACAMPOS,_CNOME,CCHAVE,CFILTRO,CFILTRO1")
SetPrvt("CFILTRO2,CFILTRO3,CFILTRO5,CIND,MPEDIDO,MCODCLI")
SetPrvt("MCODDEST,MPRODUTO,MEDICAO,MQTDE,MNOMECLI,MNOMEDEST")
SetPrvt("MEND,MBAIRRO,MMUN,MCEP,MEST,MFONE")
SetPrvt("MROTEIRO,MSTATUSI,MDTOCORR,MSTATUS2,MPROVID,MCOND")
SetPrvt("NOMEDEST,bBloco, nContador")


//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // De                 D-8               �
//� mv_par02             // At�                D-8               �
//� mv_par03             // Do  Produto        C-15              �
//� mv_par04             // At� Produto        C-15              �
//� mv_par05             // Da  Edi��o         N-4               �
//� mv_par06             // At� Edi��o         N-4               �
//� mv_par07             // Correio Transfolha Outros C-1        �
//� mv_par08             // StatusI de         C-3               �
//� mv_par09             // StatusI at�        C-3               �
//����������������������������������������������������������������

MsgAlert("Este programa ira gerar o arquivo de ocorrencias")

MHORA     := TIME()
cString   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cArqPath  := GetMv("MV_PATHTMP")
_cString  := cArqPath+cString+".DBF"
mDESCR :="  "

cPerg:="PFAT28"

lContinua := .T.
//�������������������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                                      �
//���������������������������������������������������������������������������

If .Not. PERGUNTE(cPerg)
 	Return
Endif

MCONTA:=0
nContador := 0

bBloco:= {|lEnd| Gerar(@lEnd)}

MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )

MsgAlert("Registros processados: "+alltrim(str(MCONTA)) +". Validos:"+ alltrim(str(nContador)) +" em "+_CString)
return



Static Function Gerar()
//DrawAdvWin("**  GERACAO ARQUIVO - OCORRENCIAS  **" , 8, 0, 12, 75 )

_aCampos := {  {"NUMPED"  ,"C",6, 0},;
{"CODCLI"  ,"C",6, 0},;
{"CODDEST" ,"C",6, 0},;
{"PRODUTO" ,"C",12,0},;
{"EDICAO"  ,"N",4,0},;
{"QTDE"    ,"N",3,0},;
{"NOME"    ,"C",40,0},;
{"DEST"    ,"C",40,0},;
{"V_END"     ,"C",120,0},;
{"BAIRRO"  ,"C",20,0},;
{"CEP"     ,"C",8, 0},;
{"MUN"     ,"C",20,0},;
{"EST"     ,"C",2, 2},;
{"ROTEIRO" ,"C",10,0},;
{"FONE"    ,"C",15,0},;
{"STATUSI" ,"C",3, 0},;
{"STATUS2" ,"C",3, 0},;
{"OCORR"   ,"C",60,0},;
{"PROVID"  ,"C",60,0},;
{"DTOCORR" ,"D",8,0}}

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PFAT105",.F.,.F.)

DBSELECTAREA('SZ1')
cChave := IndexKey()
cFiltro:='DTOS(Z1_DTOCORR)>="'+DTOS(MV_PAR01)+'"'
cFiltro1:='.AND.DTOS(Z1_DTOCORR)<="'+DTOS(MV_PAR02)+'"'
cFiltro2:='.AND.Z1_CODPROD>="'+ MV_PAR03 +'" .AND. Z1_CODPROD<="'+ MV_PAR04 +'"'
cFiltro3:='.AND.Z1_EDICAO>='+ ALLTRIM(Str(MV_PAR05)) +' .AND. Z1_EDICAO<='+ ALLTRIM(Str(MV_PAR06))
cFiltro5:=cFiltro+cFiltro1+cFiltro2+cFiltro3
cInd:= CriaTrab(nil,.f.)
IndRegua("SZ1",cInd,cChave,,cFiltro5,"Filtrando ..")

DBGOTOP()
DO WHILE .NOT. EOF()
	MCONTA:=MCONTA+1
	//   @ 10, 5 Say "   A G U A R D E  - LENDO REGISTRO -> "+STR(MCONTA,7)
	MPEDIDO  :=""
	MCODCLI  :=""
	MCODDEST :=""
	MPRODUTO :=""
	MEDICAO  :=""
	MQTDE    :=""
	MNOMECLI :=""
	MNOMEDEST:=""
	MEND     :=""
	MBAIRRO  :=""
	MMUN     :=""
	MCEP     :=""
	MEST     :=""
	MFONE    :=""
	MROTEIRO :=""
	MSTATUSI :=""
	MDTOCORR :=""
	DBSELECTAREA('SZ1')
	MPEDIDO :=SZ1->Z1_PEDIDO
	MCODCLI :=SZ1->Z1_CODCLI
	MCODDEST:=SZ1->Z1_CODDEST
	MPRODUTO:=SZ1->Z1_CODPROD
	MEDICAO :=SZ1->Z1_EDICAO
	MQTDE   :=SZ1->Z1_QTDE
	MSTATUSI:=SZ1->Z1_STATUSI
	MSTATUS2:=SZ1->Z1_STATUS2
	MDTOCORR:=SZ1->Z1_DTOCORR
	MPROVID :=SZ1->Z1_PROVID
	MCOND   :='F'
	
	IF SZ1->Z1_STATUSI<MV_PAR08 .OR. SZ1->Z1_STATUSI>MV_PAR09
		DBSKIP()
		LOOP
	ENDIF
	
	IF 'DISTR' $(SZ1->Z1_PROVID) .AND. MV_PAR07==2
		MCOND:='T'
	ENDIF
	
	IF 'CORR' $(SZ1->Z1_PROVID) .AND. MV_PAR07==1
		MCOND:='T'
	ENDIF
	
	IF MV_PAR07==3
		MCOND:='T'
	ENDIF
	
	IF MCOND#'T'
		DBSKIP()
		LOOP
	ENDIF
	IF MV_PAR07<>3
		DBSELECTAREA('SC6')
		DbOrderNickName("C6_CLI") //dbSetOrder(10) 20130225
		DBSEEK(xfilial()+MCODCLI+MPEDIDO)
		IF FOUND()
			DO WHILE .T.
				IF SUBS(SC6->C6_REGCOT,1,4)==SUBS(SZ1->Z1_CODPROD,1,4)  .AND. SC6->C6_NUM==MPEDIDO
					MCODDEST:=SC6->C6_CODDEST
					MROTEIRO:=ALLTRIM(SC6->C6_ROTEIRO)
					RELACIONA()
					GRAVA_TEMP()
					EXIT
					DBSELECTAREA('SC6')
					DBSKIP()
				ELSE
					DBSKIP()
					IF SC6->C6_CLI==SZ1->Z1_CODCLI
						LOOP
					ELSE
						EXIT
					ENDIF
				ENDIF
			ENDDO
		ENDIF
	ELSE
		RELACIONA()
		GRAVA_TEMP()
	ENDIF
	DBSELECTAREA('SZ1')
	DBSKIP()
ENDDO

DBSELECTAREA("PFAT105")
DBGOTOP()
COPY TO &_cString VIA "DBFCDXADS" // 20121106 
DBCLOSEAREA()

DbSelectArea("SC6")
Retindex("SC6")

DbSelectArea("SA1")
Retindex("SA1")

DbSelectArea("SZO")
Retindex("SZO")

DbSelectArea("SZN")
Retindex("SZN")

DbSelectArea("SZ1")
Retindex("SZ1")

return



// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION RELACIONA
Static FUNCTION RELACIONA()

DBSELECTAREA("SA1")
DBSEEK(XFILIAL()+MCODCLI)
IF FOUND()
	MNOMECLI:=SA1->A1_NOME
ELSE
	MNOMECLI:='  '
ENDIF
MEND    := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060327
MBAIRRO := SA1->A1_BAIRRO
MMUN    := SA1->A1_MUN
MEST    := SA1->A1_EST
MCEP    := SA1->A1_CEP
MFONE   := SA1->A1_TEL
NOMEDEST:=SPACE(40)
IF MCODDEST#' '
	DBSELECTAREA("SZN")
	DBSEEK(XFILIAL()+MCODCLI+MCODDEST)
	IF FOUND()
		MNOMEDEST:= SZN->ZN_NOME
	ENDIF
	DBSELECTAREA("SZO")
	DBSEEK(XFILIAL()+MCODCLI+MCODDEST)
	IF FOUND()
		MEND    := ALLTRIM(SZO->ZO_TPLOG) + " " + ALLTRIM(SZO->ZO_LOGR) + " " + ALLTRIM(SZO->ZO_NLOGR) + " " + ALLTRIM(SZO->ZO_COMPL) //20060327
		MBAIRRO := SZO->ZO_BAIRRO
		MMUN    := SZO->ZO_CIDADE
		MEST    := SZO->ZO_ESTADO
		MCEP    := SZO->ZO_CEP
		MFONE   := SZO->ZO_FONE
	ENDIF
ELSE
	MNOMEDEST:='  '
ENDIF
RETURN



// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION GRAVA_TEMP
Static FUNCTION GRAVA_TEMP()
DBSELECTAREA("PFAT105")
Reclock("PFAT105",.t.)
REPLACE NUMPED   WITH  MPEDIDO
REPLACE CODCLI   WITH  MCODCLI
REPLACE CODDEST  WITH  MCODDEST
REPLACE PRODUTO  WITH  MPRODUTO
REPLACE EDICAO   WITH  MEDICAO
REPLACE QTDE     WITH  MQTDE
REPLACE NOME     WITH  MNOMECLI
REPLACE DEST     WITH  MNOMEDEST
REPLACE V_END      WITH  MEND
REPLACE BAIRRO   WITH  MBAIRRO
REPLACE MUN      WITH  MMUN
REPLACE CEP      WITH  MCEP
REPLACE EST      WITH  MEST
REPLACE FONE     WITH  MFONE
REPLACE ROTEIRO  WITH  MROTEIRO
REPLACE STATUSI  WITH  MSTATUSI
REPLACE STATUS2  WITH  MSTATUS2
REPLACE DTOCORR  WITH  MDTOCORR
REPLACE OCORR    WITH  SZ1->Z1_OCORR
REPLACE PROVID   WITH  MPROVID
PFAT105->(MSUnlock())
nContador++
RETURN
