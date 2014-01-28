#INCLUDE "RWMAKE.CH"
/*/
//20090930 Danilo C S Pala: CT1_TPCONT CHAR(4) ERA CHAR(2)
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT064   ³Autor: Raquel Farias          ³ Data: 26/08/99   ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Seleciona registros no Si2                                 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento  Liberado para Usu rio em:           ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat301()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // De      D-8                          ³
//³ mv_par02             // At‚     D-8                          ³
//³ mv_par03 Conta       // De      C-20                         ³
//³ mv_par04 Conta       // At‚     C-20                         ³
//³ mv_par05 Tipo        // De      C-20                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cDesc1    := PADC("Este programa ira selecionar registros no arquivo" ,74)
cDesc2    := "  "
cDesc3    := ""
cPerg     := "PCON01"
mHora     := TIME()
cArq      := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cArqPath  := GetMv("MV_PATHTMP")
_cString  := cArqPath+cString+".DBF"
mConta    := 0

If !PERGUNTE(cPerg)
	Return
Endif

lEnd:= .F.

MsAguarde({|| FArqTrab()},"Aguarde" ,"Processando...",lEnd)

mCond := '.AND. DTOS(ZZK_FECHCUS) == " "'

DBSELECTAREA("ZZK")
cChave  := "ZZK_FILIAL+DTOS(ZZK_DATA)"
cFiltro := 'DTOS(ZZK_DATA) >= "'+DTOS(MV_PAR01)+'"'
cFiltro += '.AND. DTOS(ZZK_DATA) <= "'+DTOS(MV_PAR02)+'"'
cFiltro += '.AND. ZZK_DEBITO >= "'+MV_PAR03+'" .AND. ZZK_DEBITO <= "'+MV_PAR04+'"'

If MV_PAR05 == 2
	cFiltro += mCond
Endif

cInd := CriaTrab(nil,.f.)
MsAguarde({|| IndRegua("ZZK",cInd,cChave,,cFiltro,"Filtrando ..")},"Aguarde","Filtrando (ZZK)...")
Dbgotop()

Copy Structure to &(cArqPath+"\PFAT301.DBF")

Copy to &(cArqPath+"\PFAT301A.DBF") VIA "DBFCDXADS" // 20121106 

Processa({|| P301Proc()})

Return

Static Function P301Proc()

DbSelectArea("ZZK")

Dbgotop()
If MV_PAR05 == 1
	While !Eof()
		RecLock("ZZK",.F.)
		ZZK->ZZK_FECHCUS := dDatabase
		MsUnlock()
		Dbskip()
	End
Endif

DBSELECTAREA("ZZK")
Retindex()
Set Filter To
cChave  := "ZZK_FILIAL+DTOS(ZZK_DATA)"
cFiltro := 'DTOS(ZZK_DATA) >= "'+DTOS(MV_PAR01)+'"'
cFiltro += ' .AND. DTOS(ZZK_DATA) <= "'+DTOS(MV_PAR02)+'"'
cFiltro += ' .AND. ZZK_CREDITO >= "'+MV_PAR03+'" .AND. ZZK_CREDITO <= "'+MV_PAR04+'"'

If MV_PAR05 == 2
	cFiltro += mCond
Endif

cInd := CriaTrab(nil,.f.)
MsAguarde({|| IndRegua("ZZK",cInd,cChave,,cFiltro,"Filtrando ..")},"Aguarde","Filtrando Novamente (ZZK)...")
Dbgotop()

Copy to &(cArqPath+"PFAT301B.DBF") VIA "DBFCDXADS" // 20121106 

Dbgotop()
IF MV_PAR05 == 1
	While ! Eof()
		RecLock("ZZK",.F.)
		ZZK->ZZK_FECHCUS := dDatabase
		MsUnlock()
		Dbskip()
	Enddo
Endif

Retindex()

cArqTemp1 := cArqPath+"PFAT301A.DBF"
dbUseArea( .T.,, cArqTemp1,"PFAT301", .f., .F. )

dbSelectArea("PFAT301")
Dbgotop()
While !Eof()
//	If PFAT301->ZZK_DC == 'X'
		Reclock("PFAT301",.f.)
		PFAT301->ZZK_CREDITO := ''
		MsUnlock()
//	Endif
	
//	If PFAT301->ZZK_DC == 'C'
//		RecLock("PFAT301",.f.)
//		dbDelete()
//		MsUnlock()
//	Endif
	DbSkip()
End

pack

cArqTemp1 := cArqPath+"PFAT301B.DBF"
dbUseArea( .T.,, cArqTemp1,"PFAT301B", .f., .F. )

dbSelectArea("PFAT301B")
Dbgotop()
While !Eof()
//	If PFAT301B->ZZK_DC == 'X'
		RecLock("PFAT301B",.f.)
		PFAT301B->ZZK_DEBITO := ''
		MsUnlock()
		
//	Endif
//	If PFAT301B->ZZK_DC == 'D'
//		RecLock("PFAT301B",.f.)
//		dbDelete()
//		MsUnlock()
//	Endif
	DbSkip()
End

pack

DbSelectArea("PFAT301B")
DbCloseArea()

dbSelectArea("PFAT301")
Append from &(cArqPath+"PFAT301B.DBF")
DbGoTop()

ProcRegua(RecCount())

While !EOF()
	mContab     := ""
	mDescrConta := ""
	mAno        := YEAR (PFAT301->ZZK_DATA)
	mMes        := MONTH(PFAT301->ZZK_DATA)
	mData       := PFAT301->ZZK_DATA
	mValor      := PFAT301->ZZK_VALOR
	mEdicao     := PFAT301->ZZK_EDICAO
	mLancamento := PFAT301->ZZK_NUM
	mHist       := PFAT301->ZZK_HIST
	mCodprod    := PFAT301->ZZK_PRODUT
	mLinha      := PFAT301->ZZK_LINHA
	mTipo       := IIF(!EMPTY(ALLTRIM(PFAT301->ZZK_CREDITO)),"C","D") //PFAT301->ZZK_DC
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
	
	If MV_PAR05 == 2 .and. ! Empty(DTOS(PFAT301->ZZK_FECHCU))
		Dbskip()
		Loop
	Endif
	
	mCustoDeb   := PFAT301->ZZK_CCD
	mCustoCred  := PFAT301->ZZK_CCC
	mEmpresa    := SM0->M0_NOME
	
	If !Empty(PFAT301->ZZK_DEBITO) .AND. PFAT301->ZZK_DEBITO >= MV_PAR03 .AND. PFAT301->ZZK_DEBITO <= MV_PAR04
		mContab := PFAT301->ZZK_DEBITO
	Endif
	
	If !Empty(PFAT301->ZZK_CREDITO) .AND. PFAT301->ZZK_CREDITO >= MV_PAR03 .AND. PFAT301->ZZK_DEBITO <= MV_PAR04
		mContab := PFAT301->ZZK_CREDITO
	Endif

	If !Empty(PFAT301->ZZK_DEBITO)
		mValor := mValor*(-1)
	Endif
	
	If !Empty(PFAT301->ZZK_CCD) // .and. mValor < 0
		mCodEmpr   := SUBS(PFAT301->ZZK_CCD,1,1)
		mCodResp   := SUBS(PFAT301->ZZK_CCD,1,2)
		mCodNucleo := SUBS(PFAT301->ZZK_CCD,1,3)
		mCodGeren  := SUBS(PFAT301->ZZK_CCD,1,4)
		mCodDetal  := SUBS(PFAT301->ZZK_CCD,1,9)
		mCodCusto  := SUBS(PFAT301->ZZK_CCD,1,6)
	Endif
	
	If !Empty(PFAT301->ZZK_CCC) .and. Empty(PFAT301->ZZK_CCD) // .and. mValor > 0 
		mCodEmpr   := SUBS(PFAT301->ZZK_CCC,1,1)
		mCodResp   := SUBS(PFAT301->ZZK_CCC,1,2)
		mCodNucleo := SUBS(PFAT301->ZZK_CCC,1,3)
		mCodGeren  := SUBS(PFAT301->ZZK_CCC,1,4)
		mCodDetal  := SUBS(PFAT301->ZZK_CCC,1,9)
		mCodCusto  := SUBS(PFAT301->ZZK_CCC,1,6)
	Endif
	
	DbSelectArea("CT1")
	DbGoTop()
	If DbSeek(xFilial("CT1")+mContab) //,.T.)
		mDescrConta := CT1->CT1_DESC
	Endif
	
	IF TRIM(CT1->CT1_TPCONT) == '00' .OR. TRIM(CT1->CT1_TPCONT) == '0000' //20090930
		RecLock('CT1',.F.)
		Repla CT1_TPCONTA With "    "
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
	If DbSeek(xFilial("CT3")+PFAT301->ZZK_CCD) //, .T.)
		mCCD := CT3->CT3_DESC
	Endif
	
	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+PFAT301->ZZK_CCC) //, .T.)
		mCCD := CT3->CT3_DESC
	Endif
	
	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+mCodEmpr) //, .T.)
		mDesEmpr := CT3->CT3_DESC
	Endif
	
	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+mCodResp) //, .T.)
		mDesResp := CT3->CT3_DESC
	Endif
	
	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+mCodGeren) //, .T.)
		mDesGeren := CT3->CT3_DESC
	Endif
	
	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+mCodDetal) //, .T.)
		mDesDetal:=CT3->CT3_DESC
	Endif

	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+mCodNucleo) //, .T.)
		mDesNucleo := CT3->CT3_DESC
	Endif
	
	DbSelectArea("CT3")
	DbGoTop()
	If DbSeek(xFilial("CT3")+mCodCusto) //, .T.)
		mDesCusto:=CT3->CT3_DESC
	Endif
	
	DbSelectArea("SX5")
	DbGoTop()
	If DbSeek(xFilial("SX5")+'98'+PFAT301->ZZK_PROCES) //, .T.)
		mNucleo := PFAT301->ZZK_PROCES+' '+SX5->X5_DESCRI
	Endif
	
	DbSelectArea("SB1")
	DbGoTop()
	If DbSeek(xFilial("SB1")+PFAT301->ZZK_PRODUT) //, .T.)
		mProduto := SB1->B1_DESC
		mNucleo  := SB1->B1_PROCESS
	Endif
	
	If Empty(Alltrim(mNucleo)) .and. (Empty(mCodprod) .or. Alltrim(mCodProd) == "0999999")  //.and. !Empty(mCodprod)
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
    If DbSeek(xFilial("SBM")+SB1->B1_GRUPO)
    	mGrupoprod := SBM->BM_DESC
    Endif
	
	dbSelectArea("PFAT301")
	DbSkip()
	
//	IF '-' $(PFAT301->ZZK_DC)
//		While PFAT301->ZZK_NUM == mlancamento .and. '-'$(PFAT301->ZZK_DC)
//			mHist += mHist+PFAT301->ZZK_HIST
//			DbSkip()
//		End
//	Endif
	
	Grava()
	
	dbSelectArea("PFAT301")
	
	IncProc("Lendo Registro : "+Alltrim(StrZero(Recno(),7))+" Gravando...... "+Alltrim(StrZero(mConta,7)))
	
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

DbSelectArea("PFAT301")
DbCloseArea()

fErase('PFAT301A.DBF')
fErase('PFAT301B.DBF')

Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ GRAVA()                                                       ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Realiza gravacao dos registros ideais (conforme parametros)   ³
//³           ³ para impressao de Relatorio.                                  ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
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
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
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

Return(.T.)

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