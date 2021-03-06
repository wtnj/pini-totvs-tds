#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 14/03/02
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: PFAT147   �Autor: Raquel Ramalho         � Data:   20/12/01 � ��
������������������������������������������������������������������������Ĵ ��
���Descri�ao: Gera arquivo para fluxo                                    � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento                                      � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function Pfat147()        // incluido pelo assistente de conversao do AP5 IDE em 14/03/02

SetPrvt("PROGRAMA,MHORA,CARQ,CSTRING,WNREL,NLASTKEY")
SetPrvt("L,NORDEM,M_PAG,NCARACTER,TAMANHO,CCABEC1")
SetPrvt("CCABEC2,LCONTINUA,CARQPATH,_CSTRING,MEMPRESA,CPERG")
SetPrvt("MCONTA1,MCONTA2,MCONTA3,MDTSALDO,MFILTRO1,CARQ1")
SetPrvt("CARQ2,CARQ3,LEND,BBLOCO,MACUMULADO,CMSG")
SetPrvt("CCHAVE,CFILTRO,CIND,CINDEX,CKEY,MDEBITO")
SetPrvt("MCREDITO,MBENEF,MPREFIXO,MHIST,MNATUREZA,MDATA")
SetPrvt("MTIPO,MCONTA,MAGENCIA,MBANCO,MCODNAT,MTIPODOC")
SetPrvt("MVALOR,MATUALIZA,MFLUXO,_CSTRING2,_CSTRING3,_CSTRING4")
SetPrvt("MVEND,_ACAMPOS,_CNOME,_SALIAS,AREGS,I")
SetPrvt("J,")
//�������������������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                                    �
//�������������������������������������������������������������������������Ĵ
//� mv_par01 Movimento de..:                                                �
//� mv_par02 Movimento at�.:                                                �
//� mv_par03 Prefixo.......:                                                �
//� mv_par04 Arquivo do CR.:                                                �
//� mv_par05 Arquivo do CP.:                                                �
//� mv_par06 Arquivo da CO.:                                                �
//� mv_par07 Portadores de Desconto:                                        �
//� mv_par08 Portadores de D+1:                                             �
//���������������������������������������������������������������������������
Programa  := "PFAT147"
MHORA     := TIME()
cArq      := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
wnrel     := SUBS(CUSUARIO,7,6)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
nLastKey  := 00
L         := 00
nOrdem    := 00
m_pag     := 01
nCaracter := 10
tamanho   := "M"
cCabec1   := ""
cCabec2   := ""
lContinua := .T.
cArqPath  := GetMv("MV_PATHTMP")
_cString  := cArqPath+cString+".DBF"
mEmpresa  := SM0->M0_CODIGO
//��������������������������������������������������������������Ŀ
//� Caso nao exista, cria grupo de perguntas.                    �
//����������������������������������������������������������������

cPerg := "PFT147"

//_ValidPerg()

If !Pergunte(cPerg)
	Return
Endif

IF Lastkey()==27
	Return
Endif

mConta1  := 0
mConta2  := 0
mConta3  := 0
mDtSaldo := MV_PAR01
mFiltro1 := MV_PAR03
cArq1    := MV_PAR04
cArq2    := MV_PAR05
cArq3    := MV_PAR06

FArqTrab()

Filtra()

lEnd:= .F.

bBloco:= {|lEnd| PRODUTOS(@lEnd)}
Processa(bBloco,"Aguarde","Processando...",.T.)

While .T.
	If !Pergunte(cPerg)
		Exit
	Endif
	If LastKey()== 27
		Exit
	Endif
	Filtra()
	lEnd  := .F.
	bBloco:= {|lEnd| PRODUTOS(@lEnd)}
	Processa( bBloco, "Aguarde" ,"Processando...", .T. )
End

DbSelectArea(cArq)
dbGoTop()

//If !Eof()
//	RecLock(cArq,.F.)
//	Replace Acumulado With (Credito-Debito) // Marcos - 17.05.02
//	MsUnlock()
//EndIf

mAcumulado := 0
	
While !Eof()
	RecLock(cArq,.F.)
	Replace Acumulado With mAcumulado - Debito + Credito
	MsUnlock()
	mAcumulado := Acumulado
	Dbskip()
End

cMsg := "Arquivo Gerado com Sucesso em: "+_cString

//MsAguarde("Aguarde" ,"Copiando Arquivo...", .T. )
DbSelectArea(cArq)
dbGoTop()
COPY TO &_cString VIA "DBFCDXADS" // 20121106 
MSGINFO(cMsg)

FErase("Fluxo.dbf")

//��������������������������������������������������������������Ŀ
//� Retorna indices originais...                                 �
//����������������������������������������������������������������
If !Empty(MV_PAR04)
	DbSelectArea("Arq")
	DbCloseArea()
Endif

If !Empty(MV_PAR05)
	DbSelectArea("Arq2")
	DbCloseArea()
Endif

If !Empty(MV_PAR06)
	DbSelectArea("Arq3")
	DbCloseArea()
Endif

DbSelectArea (cArq)
DbCloseArea()

DbSelectArea("Fluxo")
DbCloseArea()

DbSelectArea("SE5")
Retindex("SE5")

DbSelectArea("SE8")
Retindex("SE8")

DbSelectArea("SA6")
Retindex("SA6")

Return
//���������������������������������������������������������������������������Ŀ
//� Function  � Filtra()                                                      �
//���������������������������������������������������������������������������Ĵ
//� Descricao � Filtra arquivo SD2 para ser utilizado no programa.            �
//�����������������������������������������������������������������������������
Static Function FILTRA()
DbSelectArea("SE5")
DbGoTop()
cChave  := IndexKey()
cFiltro := 'DTOS(E5_DATA)>"'+DTOS(MV_PAR01)+'"'
cFiltro := Alltrim(cFiltro)+'.AND. DTOS(E5_DATA)<="'+DTOS(MV_PAR02)+'"'
cInd    := CriaTrab(NIL,.f.)
MsAguarde({|| IndRegua("SE5",cInd,cChave,,cFiltro,"Filtrando...")},"Aguarde","Gerando Indice Temporario (SE5)...")
Dbgotop()
Copy to Fluxo VIA "DBFCDXADS" // 20121106 
Return
//���������������������������������������������������������������������������Ŀ
//� Function  � PRODUTOS()                                                    �
//���������������������������������������������������������������������������Ĵ
//� Descricao �                                                               �
//�           �                                                               �
//�           �                                                               �
//���������������������������������������������������������������������������Ĵ
//� Observ.   �                                                               �
//�����������������������������������������������������������������������������
Static Function PRODUTOS()
cArq2  := 'FLUXO.DBF'
dbUseArea(.T.,,cArq2,"FLUXO", if(.F. .OR. .F., !.F., NIL),.F.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_CLIFOR+E5_PARCELA+E5_TIPODOC"
MsAguarde({|| Indregua("FLUXO",cIndex,ckey,,,"Selecionando Registros do Arq")}, "Aguarde", "Gerando Indice Temporario (SE5)...")

mAcumulado := 0
DbSelectArea("SA6")
DbGoTop()
ProcRegua(RecCount())
While !Eof()
	mDebito   := 0
	mCredito  := 0
	mBenef    := SM0->M0_NOMECOM
	mPrefixo  := "SLD"
	mHist     := SA6->A6_NOME
	mNatureza := "BAN"
	mData     := mDtSaldo
	mTipo     := '1'
	mConta    := SA6->A6_NUMCON
	mAgencia  := SA6->A6_AGENCIA
	mBanco    := SA6->A6_COD
	mCodNat   := ""
	mTipoDoc  := ""
	
	If Empty(SA6->A6_NUMCON) .OR. SA6->A6_FLUXCAI<>'S'
		Dbskip()
		Loop
	EndIf
	
	DbSelectArea("SE8")
	DbGoTop()
	If !DbSeek(xFilial("SE8")+SA6->A6_COD+SA6->A6_AGENCIA+SA6->A6_NUMCON+DTOS(mDtSaldo))
		DbGoTop()
		If DbSeek(xFilial("SA6")+SA6->A6_COD+SA6->A6_AGENCIA+SA6->A6_NUMCON)
			While DTOS(SE8->E8_DTSALAT) <= DTOS(mDtSaldo) .and. ;
				SA6->A6_COD+SA6->A6_AGENCIA+SA6->A6_NUMCON == SE8->E8_BANCO+SE8->E8_AGENCIA+SE8->E8_CONTA
				mCredito := SE8->E8_SALATUA
				DbSelectArea("SE8")
				DbSkip()
			End
		Endif
	Else
		mCredito := SE8->E8_SALATUA
	Endif
	
	If mPrefixo == "SLD"
		mNatureza := "SALDO"
	Endif
	
	GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 14/03/02 ==>                Execute(GRAVA)
	IncProc("Lendo Registros : "+Str(Recno(),7)+"  Gravando : "+StrZero(mConta1,7))
	
	DbSelectArea("SA6")
	DbSkip()
End

DbSelectArea("FLUXO")
cIndex := CriaTrab(Nil,.F.)
cKey   := "DTOS(E5_DATA)+E5_RECPAG"
Indregua("FLUXO",cIndex,ckey,,,"Indexando......")
DbGoTop()
ProcRegua(RecCount())
While !EOF()
	mDebito   := 0
	mCredito  := 0
	mData     := SE5->E5_DATA
	mTipo     := SE5->E5_RECPAG
	mBenef    := SE5->E5_BENEF
	mPrefixo  := SE5->E5_PREFIXO
	mHist     := SE5->E5_HISTOR
	mValor    := SE5->E5_VALOR
	mConta    := SE5->E5_CONTA
	mAgencia  := SE5->E5_AGENCIA
	mBanco    := SE5->E5_BANCO
	mAtualiza := ""
	mNatureza := ""
	mCodNat   := SE5->E5_NATUREZ
	mFluxo    := ""
	mTipoDoc  := SE5->E5_TIPODOC
	
	If mTipodoc == 'ES'
		mValor := mValor*-1
	Endif
	
	DbSelectArea("SA6")
	DbGoTop()
	If DbSeek(xFilial("SA6")+mBanco+mAgencia+mConta)
		mFluxo := SA6->A6_FLUXCAI
	Endif
	
	DbSelectArea("FLUXO")
	If AllTrim(E5_PREFIXO) $ mFiltro1 .OR. Empty(SE5->E5_PREFIXO)
		If E5_SITUACA <> 'C' .and. mFluxo == 'S'
			mAtualiza := 'S'
			If 'P' $(mTipo)
				If 'DC' $(E5_TIPODOC) //desconto
					mCredito := mValor
				Else
					mDebito  := mValor
				Endif
			Endif
			
			If 'R' $(mTipo)
				mCredito:=mValor
			Endif
		Endif
	Endif
	
	If mAtualiza == 'S'
		DbSelectArea("SED")
		DbGoTop()
		If DbSeek(xFilial("SED")+FLUXO->E5_NATUREZ)
			mNatureza := SED->ED_DESCRIC
		Endif
		
		GRAVA()
		IncProc("Lendo Registros : "+Str(Recno(),7)+" Gravando: "+StrZero(mConta1,7))
	Endif
	
	DbSelectArea("FLUXO")
	If EOF()
		Exit
	Else
		DbSkip()
	Endif
End

If !Empty (MV_PAR04)
	_cString2 := cArqPath+AllTrim(MV_PAR04)+'.DBF'
	dbUseArea( .T.,, _cString2,'ARQ', if(.F. .OR. .F., !.F., NIL), .F. )
	dbSelectArea('ARQ')
	cIndex := CriaTrab(Nil,.F.)
	cKey   := "VENCTO"
	Indregua("ARQ",cIndex,ckey,,,"Indexando......")
	ProcRegua(RecCount())
	While !Eof()
		mDebito   := 0
		mCredito  := 0
		mTipo     := 'R'
		mBenef    := SM0->M0_NOME
		mPrefixo  := SERIE
		mHist     := CODCLI+'/'+NOME
		mConta    := ""
		mAgencia  := ""
		mBanco    := Portado
		mAtualiza := ""
		mNatureza := "DUPLICATAS A RECEBER"
		
		RecLock("ARQ",.f.)
		Replace fluxo with 0
		MsUnlock()
		
		If PORTADO $ (MV_PAR07) .and. !Empty(PORTADO)
			Dbskip()
			Loop
		Endif
		
		If Empty(BAIXA)
			If PORTADO $(MV_PAR08)
				mData := VENCTO
			Else
				mData := VENCTO+1
			Endif
		Else
			mData := BAIXA
		Endif
		
		If !Empty(PORTADO) .and. PAGO == 0
			mValor    :=(PAGO+AVENCER-DESCONTO)*0.70
		Else
			mValor    :=(PAGO+AVENCER-DESCONTO)
		Endif
		
		If Empty(DTOS(BAIXA)) .and. mValor<>0
			mAtualiza := "S"
			If 'R' $(mTipo)
				mCredito := mValor
			Endif
		Endif
		
		If BAIXA > mDtSaldo .and. mValor <> 0
			mAtualiza := "S"
			If 'R' $(mTipo)
				mCredito := mValor
			Endif
		Endif
		
		DbSelectArea("SA6")
		DbGoTop()
		If DbSeek(xFilial()+mBanco)
			mConta := SA6->A6_NOME
		Endif
		
		If mAtualiza == 'S'
			DbSelectArea("ARQ")
			RecLock("ARQ",.F.)
			Replace fluxo with mvalor
			MsUnlock()
			GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 14/03/02 ==>                      Execute(GRAVA)
			IncProc("Lendo Registros : "+Str(Recno(),7)+" Gravando: "+StrZero(mConta1,7))
		Endif

		DbSelectArea("ARQ")
		If EOF()
			Exit
		Else
			DbSkip()
		Endif
	End
Endif

If !Empty (MV_PAR05)
	_cString3 := cArqPath+AllTrim(MV_PAR05)+'.DBF'
	dbUseArea( .T.,, _cString3,'ARQ2', if(.F. .OR. .F., !.F., NIL), .F. )
	dbSelectArea('ARQ2')
	cIndex    := CriaTrab(Nil,.F.)
	cKey      := "VENCTO"
	Indregua("ARQ2",cIndex,ckey,,,"Indexando......")
	DbGotop()
	ProcRegua(recCount())
	While !Eof()
		mDebito   := 0
		mCredito  := 0
		mTipo     := 'P'
		mBenef    := SM0->M0_NOME
		mPrefixo  := PREFIXO
		mHist     := FORNECE+'/'+NOMFOR
		mValor    := VALOR-DESCONT
		mConta    := ""
		mAgencia  := ""
		mBanco    := ""
		mAtualiza := ""
		mNatureza := "FORNECEDORES"
		mCodNat   := NATUREZA
		mData     := VENCTO
		
		If VENCTO < mDtsaldo
			mData := mDtsaldo
		Else
			mData := VENCTO
		Endif
		
		If Empty(DTOS(BAIXA)) .and. mValor <> 0
			mAtualiza := "S"
			If 'P' $(mTipo)
				mDebito := mValor
			Endif
		Endif
		
		If BAIXA > mDtSaldo .and. mValor <> 0
			mAtualiza := "S"
			If 'P' $(mTipo)
				mDebito := mValor
			Endif
		Endif
		
		If Empty(DTOS(BAIXA)) .and. Vencto<dDataBase
			mData := dDataBase
			mNatureza := "FORNECEDORES EM ABERTO"
		Endif
		
		If mAtualiza == 'S'
			GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 14/03/02 ==>                     Execute(GRAVA)
			IncProc("Lendo Registros : "+Str(Recno(),7)+"  Gravando: "+StrZero(mConta1,7))
		Endif
		DbSelectArea("ARQ2")
		If EOF()
			Exit
		Else
			DbSkip()
		Endif
	End
Endif

If !Empty (MV_PAR06)
	_cString4 := cArqPath+AllTrim(MV_PAR06)+'.DBF'
	dbUseArea( .T.,, _cString4,'ARQ3', if(.F. .OR. .F., !.F., NIL), .F. )
	dbSelectArea('ARQ3')
	cIndex := CriaTrab(Nil,.F.)
	cKey   := "VEND"
	Indregua("ARQ3",cIndex,ckey,,,"Indexando......")
	ProcRegua(RecCount())
	While !Eof()
		mDebito   := 0
		mCredito  := 0
		mData     := DATE()
		mTipo     := 'P'
		mBenef    := VEND+'/'+NOMEVEND
		mPrefixo  := 'CSV'
		mHist     := 'COMISSOES S/ VENDAS'
		mValor    := 0
		mConta    := ""
		mAgencia  := ""
		mBanco    := ""
		mAtualiza := ""
		mNatureza := "COMISSOES A PAGAR"
		mVend     := VEND
		
		While .T.
			If VEND == mVend
				mValor += COMISSAO
			Else
				Exit
			Endif
			DbSkip()
		End
		
		If mValor <> 0
			mAtualiza := "S"
			If 'P' $(mTipo)
				mDebito := mValor
			Endif
		Endif
		
		If mAtualiza == 'S'
			GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 14/03/02 ==>                      Execute(GRAVA)
			IncProc("Lendo Registros : "+Str(Recno(),7)+"  Gravando: "+StrZero(mConta1,7))
			dbSelectArea('ARQ3')
		Endif
	End
Endif

Return
//���������������������������������������������������������������������������Ŀ
//� Function  � GRAVA()                                                       �
//���������������������������������������������������������������������������Ĵ
//� Descricao � Realiza gravacao dos registros ideais (conforme parametros)   �
//�           � para impressao de Relatorio.                                  �
//���������������������������������������������������������������������������Ĵ
//� Observ.   �                                                               �
//�����������������������������������������������������������������������������
Static Function GRAVA()

mConta1++

DbSelectArea(cArq)
RecLock(cArq,.T.)
Replace Debito    With mDebito
Replace Credito   With mCredito
Replace Dta       With mData
Replace Tipo      With mTipo
Replace Benef     With mBenef
Replace Prefixo   With mPrefixo
Replace Hist      With mHist
Replace Natureza  With mNatureza
Replace Conta     With mConta
Replace Agencia   With mAgencia
Replace Banco     With mBanco
Replace CodNat    With mCodNat
Replace TipoDoc   With mTipoDoc
MsUnlock()

Return
//���������������������������������������������������������������������������Ŀ
//� Function  � FARQTRAB()                                                    �
//���������������������������������������������������������������������������Ĵ
//� Descricao � Cria arquivo de trabalho para guardar registros que serao     �
//�           � impressos em forma de etiquetas.                              �
//�           � serem gravados. Faz chamada a funcao GRAVA.                   �
//���������������������������������������������������������������������������Ĵ
//� Observ.   �                                                               �
//�����������������������������������������������������������������������������
Static Function FARQTRAB()

_aCampos := {}
AADD(_aCampos,{"Dta       ","D",8,0})
AADD(_aCampos,{"Debito    ","N",12,2})
AADD(_aCampos,{"Credito   ","N",12,2})
AADD(_aCampos,{"Acumulado ","N",12,2})
AADD(_aCampos,{"Natureza  ","C",30,0})
AADD(_aCampos,{"Benef     ","C",20,0})
AADD(_aCampos,{"Tipo      ","C",1,0})
AADD(_aCampos,{"Prefixo   ","C",3,0})
AADD(_aCampos,{"Hist      ","C",40,0})
AADD(_aCampos,{"Conta     ","C",10,0})
AADD(_aCampos,{"Agencia   ","C",5,0})
AADD(_aCampos,{"Banco     ","C",3,0})
AADD(_aCampos,{"CodNat    ","C",10,0})
AADD(_aCampos,{"TipoDoc   ","C",3,0})

_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "DTOS(Dta)+Tipo"
dbUseArea(.T.,, _cNome,cArq,.F.,.F.)
dbSelectArea(cArq)
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")

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
AADD(aRegs,{cPerg,"01","Movimento Banco de..:","mv_ch1","D",8,0,0,"G","","mv_par01","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Movimento Banco at�.:","mv_ch2","D",8,0,0,"G","","mv_par02","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Prefixo.............:","mv_ch3","C",15,0,0,"G","","mv_par03","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Arq Contas a Receber:","mv_ch4","C",08,0,0,"G","","mv_par04","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Arq Contas a Pagar..:","mv_ch5","C",08,0,0,"G","","mv_par05","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"06","Arq Comiss�es.......:","mv_ch6","C",08,0,0,"G","","mv_par06","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"07","Portadores de Desc..:","mv_ch7","C",15,0,0,"G","","mv_par07","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"08","Portadores Dia+0....:","mv_ch8","C",15,0,0,"G","","mv_par08","","","","","","","","","","","","","","",""})
For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

DbSelectArea(_sAlias)

Return