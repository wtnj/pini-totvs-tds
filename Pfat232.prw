#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: PFAT232   �Autor: Mauricio Mendes        � Data:   31/05/01 � ��
������������������������������������������������������������������������Ĵ ��
���Descri�ao: Gera SC5/SC6, Atraves do recebimento dos titulos de renova � ��
���           cao automatica de assinaturas.                             � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento - RENOVACAO AUTOMATICA !!!           � ��
������������������������������������������������������������������������Ĵ ��
���OBSERV.  :                                                            � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function Pfat232()

SetPrvt("_LABORTO,CPERG,_CTITULO,_NVEZES,_NRECNOZZE,_IA")
SetPrvt("_CNUMNOVOPED,_CMSG4,_NPRECO_A_VISTA,_NPRECO_1_DE_3,_PEDRENOV,_ITEMREN")
SetPrvt("_VALOR,_CMSG1,_NVLRUNICA,_N3VEZES,MPRODUTO,_NEDINI")
SetPrvt("_NEDFIN,_DDTINI,_ARRAYSC6,I_FIELD,_VPRODUTO,I_NEW")
SetPrvt("_ARRAYSC5,_VCLIENTE,_VLOJACLI,_CPARCELA,_DVENCTO,_NVALOR")
SetPrvt("_CTIPOOP,_SALIAS,AREGS,I,J,")
Private lGeraPed := .f.

//����������������������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                                       �
//� mv_par01             //Banco                          "C",03               �
//� mv_par02             //Agencia                        "C",05               �
//� mv_par03             //Conta                          "C",10               �
//� mv_par04             //Nosso Numero                   "C",15               �
//������������������������������������������������������������������������������
_lAborto := .f.

//�������������������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                                      �
//���������������������������������������������������������������������������
cPerg:= "FAT232"

_ValidPerg()
If !Pergunte(cPerg,.T.)
   Return
Endif

_cTitulo := 'RENOVACAO DE ASSINATURA'

Processa({|| Principal()})

Return

Static Function Principal()

DbSelectArea("ZZE")
dbSetOrder(3)  // Banco+Agencia+Conta+NossoNumero
If !(dbSeek(xFilial("ZZE")+MV_PAR01+MV_PAR02+MV_PAR03+MV_PAR04))
   Alert("Titulo nao Cadastrado Verifique")
   Return
Endif
                                                      
While !Eof() .and. Alltrim(ZZE->ZZE_NNUM) == Alltrim(MV_PAR04)
	If DTOS(ZZE->ZZE_VENCTO) < DTOS(MV_PAR05) .OR. DTOS(ZZE->ZZE_VENCTO) > DTOS(MV_PAR06)
		DbSkip()
	Else
		Exit
	EndIf
End

If ALLTRIM(MV_PAR04) <> ALLTRIM(ZZE->ZZE_NNUM)
   Alert("Titulo nao Cadastrado Verifique, ou Parametros Incorretos")
   Return
Endif

// Se a Parcela for igual a A a renovacao e em tres vezes
// caso contrario e a vista
If Alltrim(ZZE->ZZE_PARCEL) == 'A'
   _nVezes:=3
Else
   _nVezes:=1
Endif

// Guarda Registro a Ser Renovado
_nrecnoZZe := Recno()

// Verificar abaixo necessidade de apagar registro da condicao nao escolhida
// pelo cliente.
dbSelectArea("ZZE")
dbSetOrder(3)
If dbSeek(xFilial("ZZE")+MV_PAR01+MV_PAR02+MV_PAR03+ZZE->ZZE_NNUMOL)
   RecLock("ZZE",.F.)
   DbDelete()
   MsUnlock()
Endif

dbSelectArea("ZZE")
dbGoto(_nrecnoZZe)

ProcRegua(_nVezes)

_Ia := 0

// For _Ia:=1 to _nVezes

   IncProc(STRZERO(_nVezes,2))

   //������������������������������������Ŀ
   //�  POSICIONA CADASTRO DE CLIENTES    �
   //��������������������������������������
   SA1->( DbSeek(xFilial("SA1")+ZZE->ZZE_CLIENT+ZZE->ZZE_LOJA) )

   _cNumNovoPed:= ZZE->ZZE_PEDIDO     // Novo numero para o pedido de renovacao.

   //��������������������������������������������������������Ŀ
   //� Caso a numeracao do pedido ja se encontro no arquivo,  �
   //� nao deixa passar...                                    �
   //����������������������������������������������������������
   // Verifica na primeira vez que passa das outras nao pois e a
   // geracao das parcelas
   If SC5->( DbSeek(xFilial("SC5")+_cNumNovoPed ) ) .Or. ;
      SC6->( DbSeek(xFilial("SC6")+_cNumNovoPed ) )
      _cMsg4:= "ATENCAO : PROBLEMAS COM A GERACAO DO BOLETO !!! O pedido de venda que esta "
      _cMsg4:=_cMsg4 + " sendo gerado ("+ alltrim( _cNumNovoPed) + ") ja se encontra no arquivo        de Pedidos !! "
      _cMsg4:=_cMsg4 + " Verifique a numeracao automatica do pedido... "
      _lAborto:= .T.

      MsgInfo(_cMsg4)  //
      Return
   EndIf

   _nPreco_a_Vista:= IIF(Alltrim(ZZE->ZZE_PARCEL) <> "A",ZZE->ZZE_VALOR,ROUND(ZZE->ZZE_VALOR*3,2))
   _nPreco_1_de_3 := IIF(Alltrim(ZZE->ZZE_PARCEL) == "A",ZZE->ZZE_VALOR,ROUND(ZZE->ZZE_VALOR/3,2))

   // Gera apenas uma vez o SC5
   DbSelectArea("SC5")
   DbSetOrder(1)
   DbSeek(xFilial("SC5")+ZZE->ZZE_PEDOLD)
   APPSC5()

   DbSelectArea("SC6")
   DbSetOrder(1)
   DbSeek( xFilial("SC6")+ZZE->ZZE_PEDOLD+ZZE->ZZE_ITEM)
   If lGeraPed
   	APPSC6()
   Else
   	DbSelectArea("SZJ")
	Retindex("SZJ")
	DbSelectArea("SA1")
	Retindex("SA1")
	DbSelectArea("SB1")
	Retindex("SB1")
	DbSelectArea("SZO")
	Retindex("SZO")
	DbSelectArea("SZN")
	Retindex("SZN")
   	Return
   EndIf
   
   _PedRenov := SC6->C6_NUM
   _ItemRen  := SC6->C6_ITEM
   _Valor    := SC6->C6_PRCVEN

   DbSelectArea("SC6")
   DbSetOrder(1)
   If DbSeek( xFilial("SC6")+ZZE->ZZE_PEDOLD+ZZE->ZZE_ITEM)
      RecLock("SC6",.F.)
      SC6->C6_PEDREN := _PedRenov
      SC6->C6_ITEMREN:= _ItemRen
      SC6->(MsUnlock())
   Endif

   dbSelectArea("ZZE")
   dbGoto(_nrecnoZZe)

   RecLock("ZZE",.f.)
   ZZE->ZZE_USO := "*"
   ZZE->(MsUnlock())

   // Mauricio  -  Liberar aqui depois para geracao de titulos a receber
   //GeraTitulo()
   //��������������������������������������������������������������Ŀ
   //� Controle de Rotina Abortada por Falta de Informacoes...      �
   //����������������������������������������������������������������
   Alert("Gerado Pedido No : "+_pedRenov + "  Valor :"+Str(_Valor,12,2))

DbSelectArea("SZJ")
Retindex("SZJ")

DbSelectArea("SA1")
Retindex("SA1")

DbSelectArea("SB1")
Retindex("SB1")

DbSelectArea("SZO")
Retindex("SZO")

DbSelectArea("SZN")
Retindex("SZN")

Return
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Funcao :  APPSC6    �Autor: Fabio William          � Data:   07/07/97 � ��
������������������������������������������������������������������������Ĵ ��
���Descri�ao: Gera SC5 e SC6 de renovacao.                               � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento - RENOVACAO AUTOMATICA !!!           � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function APPSC6()

_cMsg1     := ""
_nVlrUnica := 0
_n3Vezes   := 0

// �����������������������������������Ŀ
// �  Posiciona o Cadastro de Produtos �
// �������������������������������������
DbSelectArea("SB1")
DbSetOrder(1)

mProduto := ""
mProduto := SC6->C6_PRODUTO

If Subs(SC6->C6_PRODUTO,5,3) == '002'
   mProduto := Subs(SC6->C6_PRODUTO,1,4) + '004'
Endif

If Subs(SC6->C6_PRODUTO,5,3) == '003'
   mProduto := Subs(SC6->C6_PRODUTO,1,4) + '005'
Endif

SB1->(DbSeek(xFilial("SB1")+mProduto))
SB5->(DbSeek(xFilial("SB5")+mProduto))

_nPreco_a_Vista := ZZE->ZZE_VALOR
_nPreco_1_de_3  := ZZE->ZZE_VALOR
_nEdIni         := SC6->C6_EDSUSP + 1

//�����������������������������������������������Ŀ
//� Busca data da circulacao da proxima revista.  �
//�������������������������������������������������
DbSelectArea("SZJ")
DbSetOrder(1)
DbSeek(xFilial("SZJ")+SubStr(SC6->C6_PRODUTO,1,4)+STR(_nEdIni,4))   // Busca data inicial da circulacao da revista.
While !Eof() .and. SubStr(SC6->C6_PRODUTO,1,4) == SZJ->ZJ_CODREV
    If SZJ->ZJ_DTCIRC <= dDatabase+7
       DbSelectArea("SZJ")
       DbSkip()
       Loop
    Endif
    Exit
End

_nEdIni := SZJ->ZJ_EDICAO
_nEdFin := (_nEdIni + SB1->B1_QTDEEX) - 1

//��������������������������������������Ŀ
//� Observa CRONOGRAMA da Revista (SZJ). �
//����������������������������������������
_dDtIni := SZJ->ZJ_DTCIRC

//���������������������������������������Ŀ
//�  CARREGA VARIAVEIS DA EDICAO ANTERIOR �
//�����������������������������������������
DbSelectArea("SC6")
_ArraySC6   := {}
For I_Field := 1 to FCount()
    AADD( _ArraySC6 , { Alltrim(Upper(FieldName(I_Field))) , FieldGet(I_Field) } )
Next

// Gatilho C6_PRODUTO
dbSelectArea("SB1")
dbSetOrder(1)
dbSeek(xFilial("SB1")+mProduto)
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_CLASFIS"}), 2 ] := SubStr(SB1->B1_ORIGPRO,1,1)+SB1->B1_CLASFIS
// Fim codificacao Gatilho

DbSelectArea("SC6")

_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_FILIAL"}), 2 ] := xFilial("SC6")
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_ITEM"})  , 2 ] := "01"
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_NUM"})   , 2 ] := _cNumNovoPed
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_PRODUTO"}),2 ] := mProduto
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_NOTA"})  , 2 ] := ZZE->ZZE_NUM
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_TES"}) ,   2 ] := "601"
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_SERIE"}) , 2 ] := "REA"
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_QTDLIB"}), 2 ] := 0
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_BLQ"}) ,2 ] :="N"
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_ENTREG"}), 2 ] := dDataBase
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_QTDEMP"}), 2 ] := 0
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_QTDENT"}), 2 ] := 0
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_QTDVEN"}), 2 ] := 1
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_PRUNIT"}), 2 ] := iif(Alltrim(ZZE->ZZE_PARCEL)<>'A',ZZE->ZZE_VALOR,Round(ZZE->ZZE_VALOR*3,2))
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_PRCVEN"}), 2 ] := iif(Alltrim(ZZE->ZZE_PARCEL)<>'A',ZZE->ZZE_VALOR,Round(ZZE->ZZE_VALOR*3,2))
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_VALOR"}) , 2 ] := iif(Alltrim(ZZE->ZZE_PARCEL)<>'A',ZZE->ZZE_VALOR,Round(ZZE->ZZE_VALOR*3,2))
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_EDVENC"}) , 2 ] := _nEdFin
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_EDSUSP"}) , 2 ] := _nEdFin
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_EDINIC"}) , 2 ] := _nEdIni
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_EDFIN"})  , 2 ] := _nEdFin
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_DTINIC"}) , 2 ] := _dDtIni
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_DTFIN"})  , 2 ] := SZJ->ZJ_DTCIRC
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_DTCIRC"}) , 2 ] := SZJ->ZJ_DTCIRC
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_EDICAO"}) , 2 ] := 0
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_EDREAB"}) , 2 ] := 0
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_DTCANC"}) , 2 ] := stod("")
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_DTENVIO"}), 2 ] := stod("")
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_DATFAT"}) , 2 ] := stod("")
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_PEDANT"}) , 2 ] := ZZE->ZZE_PEDOLD
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_ITEMANT"}) , 2 ] := ZZE->ZZE_ITEM
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_LOTEFAT"}) , 2 ] := "915"
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_DATA"}) , 2 ] := dDatabase
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_EXADIC"}) , 2 ] := 0
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_SITUAC"}) , 2 ] := "AA"
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_COMIS1"}) , 2 ] := 0
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_COMIS2"}) , 2 ] := 0
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_COMIS3"}) , 2 ] := 0
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_COMIS4"}) , 2 ] := 0
_ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_COMIS5"}) , 2 ] := 0

_vProduto:= _ArraySC6[ Ascan(_ArraySC6,{|X| X[1] == "C6_PRODUTO"}), 2 ]

//������������������������������ͻ
//�  ATUALIZA DADOS PRINCIPAIS   �
//������������������������������ͼ

DbSelectArea("SC6")
RecLock("SC6",.T.)
For I_New:= 1 to FCount()
    If !Empty(_ArraySC6[I_New,2])
       FieldPut( I_New , _ArraySC6[I_New,2])
    EndIf
Next
SC6->(Msunlock())

Return
/*/
_FILIAL
_PREFIXO
_NUMERO
_PARCELA
_CLIENTE
_LOJA
_PEDIDO
_CONDPAG
_VENCTO
_VALOR
_BANCO
_AGENCIA
_CTACON
_NOSNUM
_INSTR01
_INSTR02
_INSTR03
_INSTR04
_NOMARQ
/*/


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Funcao :  APPSC5    �Autor: Fabio William          � Data:   07/07/97 � ��
������������������������������������������������������������������������Ĵ ��
���Descri�ao: Gera SC5 e SC6 de renovacao.                               � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento - RENOVACAO AUTOMATICA !!!           � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function APPSC5()

Local cMsg := ""

lGeraPed := .f.

DbSelectArea("SC5")
_ArraySC5:={}
For I_Field:= 1 to FCount()
    Aadd( _ArraySC5 , { Alltrim(Upper(FieldName(I_Field))), FieldGet(I_Field)} )
Next

_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_FILIAL"}) , 2 ] := xFilial("SC5")
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_NUM"})    , 2 ] := _cNumNovoPed
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_CONDPAG"}), 2 ] := "201"
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_CODPROM"}), 2 ] := "A30"  // Codigo da promocao.
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_PARC1"})  , 2 ] := iif( _nVezes == 1, _nPreco_a_Vista , _nPreco_1_de_3 )
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_DATA1"})  , 2 ] := iif( _nVezes == 1, dDataBase   , dDataBase )
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_PARC2"})  , 2 ] := iif( _nVezes == 1, 0               , _nPreco_1_de_3)
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_DATA2"})  , 2 ] := iif( _nVezes == 1, CTOD("")        , dDataBase + 30 )
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_PARC3"})  , 2 ] := iif( _nVezes == 1, 0               , _nPreco_1_de_3)
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_DATA3"})  , 2 ] := iif( _nVezes == 1, CTOD("")        , dDataBase + 60)
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_PARC4"})  , 2 ] := 0
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_DATA4"})  , 2 ] := CTOD("")
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_PARC5"})  , 2 ] := 0
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_DATA5"})  , 2 ] := CTOD("")
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_PARC6"})  , 2 ] := 0
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_DATA6"})  , 2 ] := CTOD("")
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_EMISSAO"}), 2 ] := dDataBase
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_DTCALC"}), 2 ]  := dDataBase
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_VLRPED"}) , 2 ] := iif( _nVezes == 1, ZZE->ZZE_VALOR,ZZE->ZZE_VALOR*3)
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_DATA"})   , 2 ] := dDataBase
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_LIBEROK"}), 2 ] := ""
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_TIPOOP"}) , 2 ] := iif( _nVezes == 1, "10", "30" )
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_NUMANT"}) , 2 ] := ""
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_NOTA"})   , 2 ] := ZZE->ZZE_NUM
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_SERIE"})  , 2 ] := "REA"
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_LOTEFAT"}), 2 ] := "915"
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_USUARIO"}), 2 ] := SubStr(cUsuario,7,15)
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_MENNOTA"}), 2 ] :="."
_ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_MENPAD"}), 2 ] := ""

// _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_FASESRA"}), 2 ] := "RA"+SubS(ZZE->ZZE_ARQREN,3,4)+"1"

_vCliente:= _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_CLIENTE"}), 2 ]
_vLojaCli:= _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_LOJACLI"}), 2 ]

cMsg += "O Sistema ira gerar um pedido com as seguintes informacoes:" + CHR(10) + CHR(13)
cMsg += "Numero : " + _cNumNovoPed + CHR(10) + CHR(13)
cMsg += "Cliente: " + C5_CLIENTE + CHR(10) + CHR(13)
cMsg += "Valor  : " + TRANSFORM(ZZE->ZZE_VALOR * _nVezes,"@E 999,999,999.99") + CHR(10) + CHR(13)
cMsg += "Em " + TRANSFORM(_nVezes,"@E 9") + " vez(es) de " + TRANSFORM(ZZE->ZZE_VALOR,"@E 999,999.99") + CHR(10) + CHR(13)
cMsg += "Caso voce confirme, o sistema ira gerar o pedido."

lGeraPed := MsgYesNo(cMsg,"Confirme Geracao do Pedido")

//���������������������������������������Ŀ
//�   Atualiza os dados do cabecalho.     �
//�����������������������������������������
If lGeraPed
	DbSelectArea("SC5")
	RecLock("SC5",.T.)

	For I_New:= 1 to FCount()
    	If !Empty(_ArraySC5[I_New,2])
       	FieldPut( I_New , _ArraySC5[I_New,2])
    	EndIf
	Next

	SC5->(MsUnLock())
EndIf

Return
/*/
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������Ŀ��
���Fun��o    �GERATITULO� Autor � Gilberto A. Oliveira  � Data � 19/01/01   ���
���������������������������������������������������������������������������Ĵ��
���Descri��o � Gera titulo para financeiro que sera a base do boleto do ban-���
���          � cario.                                                       ���
���������������������������������������������������������������������������Ĵ��
���Uso       � Espec�fico para clientes Microsiga                           ���
����������������������������������������������������������������������������ٱ�
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
/*/
Static Function GeraTitulo()

//�����������������������������������������������������Ŀ
//� Programacao do Titulo a Ser Paga No Valor Total.    �
//�������������������������������������������������������
DbSelectArea("SE1")
DbGotop()

If Ind_A == 1
  _cParcela:= ""
  _dVencto:= dDataBase  + GETMV("MV_DIAVENC")         // Parcela Unica
  _nValor:= _nPreco_a_Vista
  _cTipoOp:= "18"
Else
  _cParcela:= "A"
  _dVencto:= dDataBase  + GETMV("MV_DIAVENC")          // Segunda Parcela
  _nValor:= _nPreco_1_de_3
  _cTipoOp:= "34"
Endif

AADD( _aTitulos, { ZZE->ZZE_NUM ,  "REA" } )

RecLock("SE1",.T.)
SE1->E1_FILIAL  := xFilial("SE1")
SE1->E1_PREFIXO := "RNA"              // Renovacao Automatica.
SE1->E1_NUM     := ZZE->ZZE_NUM        // Numero do Titulo da Renovacao Automatica.
SE1->E1_PARCELA := _cParcela
SE1->E1_TIPO    := "NF"
SE1->E1_PEDIDO  := _cNumNovoPed
SE1->E1_NATUREZ := "0101"
SE1->E1_CLIENTE := _vCliente
SE1->E1_LOJA    := _vLojaCli
SE1->E1_NOMCLI  := SA1->A1_NREDUZ
SE1->E1_EMISSAO := dDataBase
SE1->E1_VENCTO  := _dVencto                   /// -->  Calcular Vencimento de acordo com o passado pelo Wagner
SE1->E1_VENCREA := DataValida(_dVencto)       /// --> Apenas para Teste...
SE1->E1_VALOR   := _nValor                    /// -->  Preco a Vista.
SE1->E1_OBS     := "RENOVACAO  AUTOMATICA"
SE1->E1_EMIS1   := dDataBase
SE1->E1_VENCORI := dDataBase
SE1->E1_SITUACA := "0"
SE1->E1_SALDO   := _nValor
SE1->E1_VEND1   := _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_VEND1"}), 2 ]
SE1->E1_VEND2   := _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_VEND2"}), 2 ]
SE1->E1_VEND3   := _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_VEND3"}), 2 ]
SE1->E1_VEND4   := _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_VEND4"}), 2 ]
SE1->E1_VEND5   := _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_VEND5"}), 2 ]
SE1->E1_COMIS1  := _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_COMIS1"}), 2 ]
SE1->E1_COMIS2  := _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_COMIS2"}), 2 ]
SE1->E1_COMIS3  := _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_COMIS3"}), 2 ]
SE1->E1_COMIS4  := _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_COMIS4"}), 2 ]
SE1->E1_COMIS5  := _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_COMIS5"}), 2 ]
SE1->E1_MOEDA   := 1
SE1->E1_BASCOM1 := iif( _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_COMIS1"}), 2 ] #0 , _nValor , 0 )
SE1->E1_BASCOM2 := iif( _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_COMIS2"}), 2 ] #0 , _nValor , 0 )
SE1->E1_BASCOM3 := iif( _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_COMIS3"}), 2 ] #0 , _nValor , 0 )
SE1->E1_BASCOM4 := iif( _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_COMIS4"}), 2 ] #0 , _nValor , 0 )
SE1->E1_BASCOM5 := iif( _ArraySC5[ Ascan(_ArraySC5,{|X| X[1] == "C5_COMIS5"}), 2 ] #0 , _nValor , 0 )
SE1->E1_OCORREN := "01"
SE1->E1_VLCRUZ  := _nValor
SE1->E1_SERIE   := "RNA"
SE1->E1_STATUS  := "A"
SE1->E1_ORIGEM  := "PFAT230 "
SE1->E1_FLUXO   := "N"
SE1->E1_CLIPED  := _vCliente
SE1->E1_TIPOOP  := _cTipoOp                        /// por enquanto para teste enquanto nao se defini tipo de operacao a ser usado.
SE1->E1_GRPROD  := Left(_vProduto,4)
SE1->E1_DIVVEN  := "MERC"
SE1->(MsUnLock())
ConfirmSX8()

//SE1->E1_PORTADO:=     //----> GRAVADO APOS A EMISSAO DO BOLETO LASER.
//SE1->E1_AGEDEP :=     //----> GRAVADO APOS A EMISSAO DO BOLETO LASER.
//SE1->E1_NUMBCO :=     //----> GRAVADO APOS A EMISSAO DO BOLETO LASER.
//SE1->E1_CONTA  :=     //----> GRAVADO APOS A EMISSAO DO BOLETO LASER.
//SE1->E1_BOLEM  :=     //----> GRAVADO APOS A EMISSAO DO BOLETO LASER.
//SE1->E1_CODPORT:=     //----> GRAVADO MANUALMENTE NA BAIXA...
//SE1->E1_IRRF   :=
//SE1->E1_ISS    :=
//SE1->E1_DESCONT:=     // ---> SOMENTE NA BAIXA
//SE1->E1_MULTA  :=     // ---> SOMENTE NA BAIXA
//SE1->E1_JUROS  :=     // ---> SOMENTE NA BAIXA
//SE1->E1_CORREC :=     // ---> SOMENTE NA BAIXA
//SE1->E1_VALLIQ :=     // ---> SOMENTE NA BAIXA
//SE1->E1_INDICE := ""
//SE1->E1_BAIXA  :=
//SE1->E1_NUMBOR :=
//SE1->E1_DATABOR:=
//SE1->E1_HIST   :=
//SE1->E1_LA     :=
//SE1->E1_LOTE   :=
//SE1->E1_MOTIVO :=
//SE1->E1_MOVIMEN:=
//SE1->E1_OP     :=
//SE1->E1_CONTRAT:=
//SE1->E1_SUPERVI:= ""
//SE1->E1_VALJUR :=
//SE1->E1_PORCJUR:=
//SE1->E1_FATPREF:=
//SE1->E1_FATURA :=
//SE1->E1_OK     :=
//SE1->E1_PROJETO:=
//SE1->E1_CLASCON:=
//SE1->E1_VALCOM1:=   --> Calculado apos rotina de acerto de comissoes.
//SE1->E1_VALCOM2:=   --> Calculado apos rotina de acerto de comissoes.
//SE1->E1_VALCOM3:=   --> Calculado apos rotina de acerto de comissoes.
//SE1->E1_VALCOM4:=   --> Calculado apos rotina de acerto de comissoes.
//SE1->E1_VALCOM5:=   --> Calculado apos rotina de acerto de comissoes.
//SE1->E1_INSTR1 :=
//SE1->E1_INSTR2 :=
//SE1->E1_DTVARIA:=
//SE1->E1_VARURV :=
//SE1->E1_DTFATUR:=
//SE1->E1_NUMNOTA:=
//SE1->E1_IDENTEE:=
//SE1->E1_NUMCART:=
//SE1->E1_DESCFIN:=      --> TESTAR FUTURAMENTE PARA SABER SE FUNCIONA EM CASO DE DESCONTO...
//SE1->E1_DUPLEM :=
//SE1->E1_DIADESC:=
//SE1->E1_CARTAO :=
//SE1->E1_PGPROG :=
//SE1->E1_CARTVAL:=
//SE1->E1_CARTAUT:=
//SE1->E1_COMPG  :=
//SE1->E1_ADM    :=
//SE1->E1_ORDPAGO:=
//SE1->E1_INSS   :=
//SE1->E1_VLRREAL:=
//SE1->E1_TRANSF :=
//SE1->E1_BCOCHQ :=
//SE1->E1_AGECHQ :=
//SE1->E1_CTACHQ :=
//SE1->E1_NUMLIQ :=
//SE1->E1_FLSERV :=
//SE1->E1_DTCANC :=
//SE1->E1_HISTBX :=
//SE1->E1_DTCARTA:=
//SE1->E1_DTALT  :=
//SE1->E1_REAB   :=
// ExecBlock("PFAT230A")

Return
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �VALIDPERG � Autor �  Luiz Carlos Vieira   � Data � 16/07/97 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Verifica as perguntas inclu�ndo-as caso n�o existam        ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Espec�fico para clientes Microsiga                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function _ValidPerg()

_sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3
AADD(aRegs,{cPerg,"01","Banco              ","mv_ch1","C",03,0,0,"G","","mv_par01","","","","","","","","","","","","","","","SA6"})
AADD(aRegs,{cPerg,"02","Agencia            ","mv_ch2","C",05,0,0,"G","","mv_par02","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Conta              ","mv_ch3","C",10,0,0,"G","","mv_par03","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Nosso Numero       ","mv_ch4","C",15,0,0,"G","","mv_par04","","","","","","","","","","","","","","",""})

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