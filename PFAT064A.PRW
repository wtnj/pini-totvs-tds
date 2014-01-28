#INCLUDE "RWMAKE.CH"
/*/
//20090930 Danilo C S Pala: CT1_TPCONT CHAR(4) ERA CHAR(2)
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT064   ³Autor: Raquel Farias          ³ Data: 26/08/99   ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Seleciona registros no CT2                                 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento  Liberado para Usu rio em:           ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat064A()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // De      D-8                          ³
//³ mv_par02             // At‚     D-8                          ³
//³ mv_par03 Conta       // De      C-20                         ³
//³ mv_par04 Conta       // At‚     C-20                         ³
//³ mv_par05 Tipo        // De      C-20                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cDesc1    := PADC("Este programa ira selecionar registros no arquivo" ,74)
Private cDesc2    := "  "
Private cDesc3    := ""
Private cPerg     := "PCON01"
Private mHora     := TIME()
Private cArq      := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
Private cString   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
Private aStru     := {}
Private aCT2      := {}
Private cArqPath  := GetMv("MV_PATHTMP")
Private _cString  := cArqPath+cString+".DBF"
Private mConta    := 0
Private cUpdt     := ""
Private cArqTempA := ""
Private cArqTempB := ""

If !PERGUNTE(cPerg)
	Return
Endif

lEnd:= .F.

Processa({|lEnd| P064Proc(@lEnd)})

Return

Static Function P064Proc()

DbSelectArea("CT2")

aStru := DbStruct()

cArqTempA := CriaTrab(aStru,.t.)
dbUseArea(.T.,,cArqTempA,"PFAT064",.F.,.F.)

cArqTempB := CriaTrab(aStru,.t.)
dbUseArea(.T.,,cArqTempB,"PFAT064B",.F.,.F.)

MsAguarde({|| FArqTrab()},"Aguarde" ,"Criando Estrutura de Saida...",lEnd)

// Debitos
DbSelectArea("CT2")
ProcRegua(RecCount())
If mv_par05 == 2
	DbSetOrder(8)
	DbSeek(xFilial("CT2")+"        "+DTOS(mv_par01)+mv_par03,.t.)
Else
	DbSetOrder(4)
	DbSeek(xFilial("CT2")+mv_par03+DTOS(mv_par01),.t.)
EndIf
nFields := FCount()
While ! Eof() .and. DTOS(CT2->CT2_DATA)<=DTOS(mv_par02) .and. Alltrim(mv_par04)<=Alltrim(CT2->CT2_DEBITO)
	IncProc("Debitos... "+Transform(CT2->CT2_DATA,"@E 99/99/99"))
	If mv_par05 == 2
		If DTOS(CT2->CT2_FECHCUS) == "        "
			DbSelectArea("CT2")
			DbSkip()
		EndIf	
    EndIf
    If Alltrim(CT2->CT2_DEBITO)<Alltrim(mv_par03) .or. Alltrim(CT2->CT2_DEBITO)>Alltrim(mv_par04)
		DbSelectArea("CT2")
		DbSkip()    
    EndIf
    For nC := 1 to nFields
    	AADD(aCT2,{Alltrim(Upper(FieldName(nC))),FieldGet(nC)}) 
    Next nC
    DbSelectArea("PFAT064")
    RecLock("PFAT064",.t.)
    For nC := 1 to nFields 
    	&(aCT2[nC,1]) := (aCT2[nC,1])
	Next nC
End

// Creditos
DbSelectArea("CT2")
ProcRegua(RecCount())
If mv_par05 == 2
	DbSetOrder(7)
	DbSeek(xFilial("CT2")+"        "+DTOS(mv_par01)+mv_par03,.t.)
Else
	DbSetOrder(5)
	DbSeek(xFilial("CT2")+mv_par03+DTOS(mv_par01),.t.)
EndIf
While ! Eof() .and. DTOS(CT2->CT2_DATA)<=DTOS(mv_par02) .and. Alltrim(mv_par04)<=Alltrim(CT2->CT2_DEBITO)
	IncProc("Creditos... "+Transform(CT2->CT2_DATA,"@E 99/99/99"))
	If mv_par05 == 2
		If DTOS(CT2->CT2_FECHCUS) == "        "
			DbSelectArea("CT2")
			DbSkip()
		EndIf	
    EndIf
    If Alltrim(CT2->CT2_DEBITO)<Alltrim(mv_par03) .or. Alltrim(CT2->CT2_DEBITO)>Alltrim(mv_par04)
		DbSelectArea("CT2")
		DbSkip()    
    EndIf
    For nC := 1 to nFields
    	AADD(aCT2,{Alltrim(Upper(FieldName(nC))),FieldGet(nC)}) 
    Next nC
    DbSelectArea("PFAT064B")
    RecLock("PFAT064B",.t.)
    For nC := 1 to nFields 
    	&(aCT2[nC,1]) := (aCT2[nC,1])
	Next nC
End

dbSelectArea("PFAT064")
Dbgotop()
While !Eof()
	If CT2_DC == 'X'
		Reclock("PFAT064",.f.)
		PFAT064->CT2_CREDIT := ' '
		MsUnlock()
	Endif
	
	If CT2_DC == 'C'
		RecLock("PFAT064",.f.)
		dbDelete()
		MsUnlock()
	Endif
	DbSkip()
End

Pack

dbSelectArea("PFAT064B")
Dbgotop()
While !Eof()
	If CT2_DC == 'X'
		RecLock("PFAT064B",.f.)
		PFAT064B->CT2_DEBITO := ' '
		MsUnlock()
		
	Endif
	If CT2_DC == 'D'
		RecLock("PFAT064B",.f.)
		dbDelete()
		MsUnlock()
	Endif
	DbSkip()
End

Pack

DbSelectArea("PFAT064B")
DbCloseArea()

dbSelectArea("PFAT064")
Append from &cArqTempB
DbGoTop()

ProcRegua(RecCount())

While !EOF()
	mContab     := ""
	mDescrConta := ""
	mAno        := YEAR (CT2_DATA)
	mMes        := MONTH(CT2_DATA)
	mData       := CT2_DATA
	mValor      := CT2_VALOR
	mEdicao     := CT2_EDICAO
	mLancamento := CT2_NUM
	mHist       := CT2_HIST
	mCodprod    := CT2_PRODUTO
	mLinha      := CT2_LINHA
	mTipo       := CT2_DC
	mGrconta    := ""
	mTpconta    := ""
	mDescrTp    := ""
	mCusto      := ""
	mProduto    := ""
	mNucleo     := ""
	mCCD        := ""
	mCCC        := ""
	mGrupoprod  := ""
	mCodEmpr    := ""
	mCodResp    := ""
	mCodNucleo  := ""
	mCodGeren   := ""
	mCodDetal   := ""
	mCodCusto   := ""
	mDesEmpr    := ""
	mDesResp    := ""
	mDesNucleo  := ""
	mDesGeren   := ""
	mDesDetal   := ""
	mDesCusto   := ""
	mCustoDeb   := CT2_CCD
	mCustoCred  := CT2_CCC
	mEmpresa    := SM0->M0_NOME
	
	If !Empty(PFAT064->CT2_DEBITO) .AND. PFAT064->CT2_DEBITO >= MV_PAR03 .AND. PFAT064->CT2_DEBITO <= MV_PAR04
		mContab := PFAT064->CT2_DEBITO
	Endif
	
	If !Empty(PFAT064->CT2_CREDIT) .AND. PFAT064->CT2_CREDIT >= MV_PAR03 .AND. PFAT064->CT2_DEBITO <= MV_PAR04
		mContab := PFAT064->CT2_CREDIT
	Endif

	If !Empty(PFAT064->CT2_DEBITO)
		mValor := mValor*(-1)
	Endif
	
	If !Empty(PFAT064->CT2_CCD) // .and. mValor < 0
		mCodEmpr   := SUBS(PFAT064->CT2_CCD,1,1)
		mCodResp   := SUBS(PFAT064->CT2_CCD,1,2)
		mCodNucleo := SUBS(PFAT064->CT2_CCD,1,3)
		mCodGeren  := SUBS(PFAT064->CT2_CCD,1,4)
		mCodDetal  := SUBS(PFAT064->CT2_CCD,1,9)
		mCodCusto  := SUBS(PFAT064->CT2_CCD,1,6)
	Endif
	
	If !Empty(PFAT064->CT2_CCC) .and. Empty(PFAT064->CT2_CCD) // .and. mValor > 0 
		mCodEmpr   := SUBS(PFAT064->CT2_CCC,1,1)
		mCodResp   := SUBS(PFAT064->CT2_CCC,1,2)
		mCodNucleo := SUBS(PFAT064->CT2_CCC,1,3)
		mCodGeren  := SUBS(PFAT064->CT2_CCC,1,4)
		mCodDetal  := SUBS(PFAT064->CT2_CCC,1,9)
		mCodCusto  := SUBS(PFAT064->CT2_CCC,1,6)
	Endif
	
	DbSelectArea("CT1")
	DbGoTop()
	If DbSeek(xFilial("CT1")+mContab) //,.T.)
		mDescrConta := CT1->CT1_DESC01
	Endif

	IF TRIM(CT1->CT1_TPCONT) == '00' .OR. TRIM(CT1->CT1_TPCONT) == '0000' //20090930
		RecLock('CT1',.F.)
		Replace CT1_TPCONTA With "    "
		MsUnlock()
	ENDIF
	
	mGrConta := SUBS(CT1->CT1_GRCONTA,1,2)+'00'
	
	DbSelectArea("SX5")
	DbGoTop()
	If DbSeek(xFilial("SX5")+'Z4'+Alltrim(mGrConta))
		mGrconta := mGrconta+' '+SX5->X5_DESCRI
	Endif	
	
	DbSelectArea("SX5")
		If DbSeek(xFilial("SX5")+'Z4'+AllTrim(CT1->CT1_GRCONT)+SUBSTR(CT1->CT1_TPCONT,3,2))//20090930
		mTpconta := CT1->CT1_GRCONT+IIF(Alltrim(CT1->CT1_TPCONT) == "","00",SUBSTR(CT1->CT1_TPCONT,3,2))+' '+SX5->X5_DESCRI //20090930
	Endif

	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+PFAT064->CT2_CCD)
		mCCD := CT3->CT3_DESC
	Endif
	
	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+PFAT064->CT2_CCC)
		mCCD := CT3->CT3_DESC
	Endif
	
	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+mCodEmpr)
		mDesEmpr := CT3->CT3_DESC
	Endif
	
	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+mCodResp)
		mDesResp := CT3->CT3_DESC
	Endif
	
	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+mCodGeren)
		mDesGeren := CT3->CT3_DESC
	Endif
	
	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+mCodDetal)
		mDesDetal:=CT3->CT3_DESC
	Endif

	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+mCodNucleo)
		mDesNucleo := CT3->CT3_DESC
	Endif
	
	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+mCodCusto)
		mDesCusto:=CT3->CT3_DESC
	Endif
	
	DbSelectArea("SX5")
	DbGoTop()
	If DbSeek(xFilial("SX5")+'98'+PFAT064->CT2_PROCESSO)
		mNucleo := PFAT064->CT2_PROCESSO+' '+SX5->X5_DESCRI
	Endif
	
	DbSelectArea("SB1")
	DbGoTop()
	If DbSeek(xFilial("SB1")+PFAT064->CT2_PRODUTO)
		mProduto := SB1->B1_DESC
		mNucleo  := SB1->B1_PROCESS
	Endif
	
	If Empty(Alltrim(mNucleo)) .and. (Empty(mCodprod) .or. Alltrim(mCodProd) == "0999999")
		mNucleo := mCodNucleo
	Endif
/*	
	DbSelectArea("SX5")
	DbGoTop()
	If DbSeek(xFilial("SX5")+'03'+SB1->B1_GRUPO)
		mGrupoprod := SX5->X5_DESCRI
	Endif
*/
	DbSelectArea("SBM")
	DbGoTop()
	If DbSeek(xFilial("SBM")+SB1->B1_GRUPO)
		mGrupoprod := SBM->BM_DESC
	Endif

	IF '-' $(PFAT064->CT2_DC)
		While PFAT064->CT2_NUM == mlancamento .and. '-'$(PFAT064->CT2_DC)
			mHist += mHist+CT2_HIST
			DbSkip()
		End
	Endif
	Grava()
	
	IncProc("Avaliando registro "+StrZero(Recno(),7)+" "+StrZero(mConta,7)+"Gravados")
	
	dbSelectArea("PFAT064")
	DbSkip()
End

cMsg:= "Arquivo Gerado com Sucesso em: "+_cString

DbSelectArea(cArq)
dbGoTop()
COPY TO &(_cString) VIA "DBFCDXADS" // 20121106 
MsgAlert(cMsg)

DbSelectArea("CT1")
Retindex("CT1")

DbSelectArea(cArq)
DbCloseArea()

DbSelectArea("PFAT064")
DbCloseArea()

//fErase(&cArqTempA)
//fErase(&cArqTempB)

//Grvdata()

Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ GRAVA()                                                       ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Realiza gravacao dos registros ideais (conforme parametros)   ³
//³           ³ para impressao de Relatorio.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function GRAVA()
mConta:=mConta+1

If Empty(mCodprod)
	mProduto:=" "
	mGrupoprod:=" "
Endif

If Empty(mCodEmpr)
	mDesEmpr  :=" "
	mDesResp  :=" "
	mDesNucleo:=" "
	mDesGeren :=" "
	mDesDetal :=" "
	mDesCusto :=" "
Endif

DbSelectArea(cArq)
RecLock(cArq,.T.)
Replace Empresa    With mEmpresa
Replace Ano        With mAno
Replace Mes        With mMes
Replace Conta      With mContaB
Replace DescrConta With mDescrConta
Replace GrConta    With mGrConta
Replace TpConta    With mTpconta
Replace Dta        With mData
Replace Valor      With mValor
Replace Produto    With mProduto
Replace Codprod    With mCodprod
Replace Nucleo     With mNucleo
Replace Grupoprod  With mGrupoprod
Replace CCD        With mCCD
Replace CCC        With mCCC
Replace CodEmpr    With mCodEmpr
Replace CodResp    With mCodResp
Replace CodNucleo  With mCodNucleo
Replace CodGeren   With mCodGeren
Replace CodDetal   With mCodDetal
Replace CodCusto   With mCodCusto
Replace DesEmpr    With mDesEmpr
Replace DesResp    With mDesResp
Replace DesNucleo  With mDesNucleo
Replace DesGeren   With mDesGeren
Replace DesDetal   With mDesDetal
Replace DesCusto   With mDesCusto
Replace Lancamento With mLancamento
Replace Linha      With mLinha
Replace Hist       With mHist
Replace Edicao     With mEdicao
Replace Tipo       With mTipo

MsUnlock()
Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ FARQTRAB()                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Cria arquivo de trabalho para guardar registros que serao     ³
//³           ³ impressos em forma de etiquetas.                              ³
//³           ³ serem gravados. Faz chamada a funcao GRAVA.                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
STATIC Function FARQTRAB()

_aCampos := {}
AADD(_aCampos,{"Empresa   ","C",30,0})
AADD(_aCampos,{"CodEmpr   ","C",9,0})
AADD(_aCampos,{"CodResp   ","C",9,0})
AADD(_aCampos,{"CodNucleo ","C",9,0})
AADD(_aCampos,{"CodGeren  ","C",9,0})
AADD(_aCampos,{"CodCusto  ","C",9,0})
AADD(_aCampos,{"CodDetal  ","C",9,0})
AADD(_aCampos,{"DesEmpr   ","C",40,0})
AADD(_aCampos,{"DesResp   ","C",40,0})
AADD(_aCampos,{"DesNucleo ","C",40,0})
AADD(_aCampos,{"DesGeren  ","C",40,0})
AADD(_aCampos,{"DesCusto  ","C",40,0})
AADD(_aCampos,{"DesDetal  ","C",40,0})
AADD(_aCampos,{"Ano       ","N",4,0})
AADD(_aCampos,{"Mes       ","N",2,0})
AADD(_aCampos,{"Conta     ","C",40,0})
AADD(_aCampos,{"DescrConta","C",60,0})
AADD(_aCampos,{"GrConta   ","C",60,0})
AADD(_aCampos,{"TpConta   ","C",60,0})
AADD(_aCampos,{"Nucleo    ","C",60,0})
AADD(_aCampos,{"CCD       ","C",60,0})
AADD(_aCampos,{"CCC       ","C",60,0})
AADD(_aCampos,{"Dta       ","D",8,0})
AADD(_aCampos,{"Valor     ","N",12,2})
AADD(_aCampos,{"Codprod   ","C",15,0})
AADD(_aCampos,{"Produto   ","C",60,0})
AADD(_aCampos,{"Grupoprod ","C",40,0})
AADD(_aCampos,{"Lancamento","C",10,0})
AADD(_aCampos,{"Linha"     ,"C",3,0})
AADD(_aCampos,{"Hist      ","C",255,0})
AADD(_aCampos,{"Edicao    ","N",4,0})
AADD(_aCampos,{"Tipo      ","C",1,0})

_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "Dtos(Dta)+Conta"

dbUseArea(.T.,, _cNome,cArq,.F.,.F.)
dbSelectArea(cArq)
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³VALIDPERG ³ Autor ³  Luiz Carlos Vieira   ³ Data ³ 16/07/97 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica as perguntas inclu¡ndo-as caso n„o existam        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Espec¡fico para clientes Microsiga                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
STATIC Function _ValidPerg()

_sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

AADD(aRegs,{cPerg,"01","Data de............:","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Data at‚...........:","mv_ch2","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Conta  de..........:","mv_ch3","C",20,0,0,"G","","mv_par03","","","","","","","","","","","","","","","CT1"})
AADD(aRegs,{cPerg,"04","Conta  At‚.........:","mv_ch4","C",20,0,0,"G","","mv_par04","","","","","","","","","","","","","","","CT1"})
AADD(aRegs,{cPerg,"05","Tipo...............:","mv_ch5","G",01,0,2,"C","","mv_par05","Movimento","","","Complemento","","","","","","","","","","",""})

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
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GrvData   ³ Autor ³ Marcos Farineli       ³ Data ³ 22/07/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava a data de fechamento de custo no encerramento        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Espec¡fico Editora Pini                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GrvData()

mCond := " .AND. dtos(CT2_FECHCUS) == '        '"

DBSELECTAREA("CT2")
cChave  := IndexKey()
cFiltro := 'CT2_FILIAL == "' + xFilial("CT2") + '" .AND. DTOS(CT2_DATA) >= "' + DTOS(MV_PAR01) + '"'
cFiltro += ' .AND. DTOS(CT2_DATA) <= "' + DTOS(MV_PAR02) + '"'
cFiltro += ' .AND. Alltrim(CT2_DEBITO) >= "' + Alltrim(MV_PAR03) + '" .AND. Alltrim(CT2_DEBITO) <= "' + Alltrim(MV_PAR04) + '"'

If MV_PAR05 == 2
	cFiltro += mCond
Endif

cInd := CriaTrab(nil,.f.)
MsAguarde({|| IndRegua("CT2",cInd,cChave,,cFiltro,"Filtrando ..")},"Aguarde","Gravando Fechamento (D)...")

Dbgotop()

While !Eof()
	DbSelectArea("CT2")
	RecLock("CT2",.F.)
	CT2->CT2_FECHCUS := dDatabase
	MsUnlock()
	Dbskip()
End

DbSelectArea("CT2")
Retindex("CT2")

DBSELECTAREA('CT2')
cChave  := IndexKey()
cFiltro := 'CT2_FILIAL == "' + xFilial("CT2") + '" .AND. DTOS(CT2_DATA) >= "'+DTOS(MV_PAR01)+'"'
cFiltro += ' .AND. DTOS(CT2_DATA) <= "'+DTOS(MV_PAR02)+'"'
cFiltro += ' .AND. Alltrim(CT2_CREDIT) >= "' + Alltrim(MV_PAR03) + '" .AND. Alltrim(CT2_CREDIT) <= "' + Alltrim(MV_PAR04) + '"'
If MV_PAR05 == 2
	cFiltro += mCond
Endif

cInd := CriaTrab(nil,.f.)
MsAguarde({|| IndRegua("CT2",cInd,cChave,,cFiltro,"Filtrando ..")},"Aguarde","Gravando Fechamento (C)...")

Dbgotop()

While !Eof()
	DbSelectArea("CT2")
	RecLock("CT2",.F.)
	CT2->CT2_FECHCUS := dDatabase
	MsUnlock()
	Dbskip()
End

DbSelectArea("CT2")
RetIndex("CT2")

Return