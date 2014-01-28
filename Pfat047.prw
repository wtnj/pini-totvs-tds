#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
//20080225 Danilo C S Pala: correcao para ajustes causados pela Migracao para MP8
//Danilo C S Pala 20100305: ENDBP
User Function Pfat047()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,TITULO")
SetPrvt("_ACAMPOS,_CNOME,MSERIE,MNF,MCLI,MPEDIDO")
SetPrvt("XRESPCOB,CLIE_NOME,MEND,MBAIRRO,MMUN,MEST")
SetPrvt("MCEP,CINDEX,CKEY,ARETURN,CDESC1,CDESC2")
SetPrvt("CDESC3,CSTRING,WNREL,NLASTKEY,LIN,COL")
SetPrvt("LI,MLOJA,mhora")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG    := 'FAT048'

If !PERGUNTE(cPerg)
	Return
Endif

TITULO   := 'ETIQUETAS'

_aCampos :=   {{"NF"  ,"C",6, 0} ,;
{"NOME" ,"C",40,0} ,;
{"RESPCOB","C",40,0} ,;
{"V_END","C",40,0} ,;
{"BAIRRO"  ,"C",20,0} ,;
{"CIDADE"  ,"C",20,0} ,;
{"CEP"     ,"C",8, 0} ,;
{"EST"  ,"C",2, 2}}

If Select("ETIQNF") <> 0
	DbSelectArea("ETIQNF")
	DbCloseArea()
EndIf

_cNome   := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"ETIQNF",.F.,.F.)

Procura()

WHILE .T.
	cPerg:="FAT048"
	
	If !PERGUNTE(cPerg)
		Exit
	Endif
	Procura()
END
Imprime()
Return

Static Function Procura()
mNF      := mv_par01
mSerie   := mv_par02
DBSELECTAREA("SC6")
dbSetOrder(4)
dbSeek(xfilial("SC6")+mNF+mSerie)
If found()
	mCLI    := SC6->C6_CLI     
	mLOJA	:= SC6->C6_LOJA
	mPedido := SC6->C6_NUM
	DBSELECTAREA("SC5")
	DBSETORDER(1)
	DBSEEK(XFILIAL()+MPEDIDO)
	IF FOUND()
		IF SC5->C5_RESPCOB==SPACE(40)
			XRESPCOB:= ' '
		ELSE
			XRESPCOB:='A/C '+SC5->C5_RESPCOB
		ENDIF
	ENDIF
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³  Inicio do levantamento dos dados do Cliente                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea("SA1")
	DbSetOrder(1)
	DBSEEK(xFilial("SA1")+MCLI)
	CLIE_NOME := SA1->A1_NOME
	//*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
	//* VERIFICA ENDERECO DA COBRANCA                                    *
	//*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
//20100305 DAQUI
	IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
		DbSelectArea("ZY3")
		DbSetOrder(1)
		DbSeek(XFilial()+MCLI+MLOJA)
		MEND    :=ZY3_END
		MBAIRRO :=ZY3_BAIRRO
		MMUN    :=ZY3_CIDADE
		MEST    :=ZY3_ESTADO
		MCEP    :=ZY3_CEP
	ELSEIF SUBS(SA1->A1_ENDCOB,1,1)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
		DbSelectArea("SZ5")
		DbSetOrder(1)
		DbSeek(XFilial()+MCLI+MLOJA)
		MEND    := SZ5->Z5_END
		MBAIRRO := SZ5->Z5_BAIRRO
		MMUN    := SZ5->Z5_CIDADE
		MEST    := SZ5->Z5_ESTADO
		MCEP    := SZ5->Z5_CEP
	ELSE
		MEND    := SA1->A1_END
		MBAIRRO := SA1->A1_BAIRRO
		MMUN    := SA1->A1_MUN
		MEST    := SA1->A1_EST
		MCEP    := SA1->A1_CEP
	ENDIF
	GRAVA_TEMP()
ENDIF
RETURN

Static Function Imprime()
DBSELECTAREA("ETIQNF")
cIndex  := CriaTrab(Nil,.F.)
// cKey    := "cep"                     // 04/09
cKey    := "NF"                       // 04/09
Indregua("ETIQNF",cIndex,ckey,,,"Selecionando Registros do Arq")

aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
cDesc1  := ' '
cDesc2  := ' '
cDesc3  := ' '
cString := 'ETIQNF'
MHORA      := TIME()
wnrel   := "ETIQNF_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
wnrel   := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)

If nLastKey == 27
	Return
Endif

NLASTKEY := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica Posicao do Formulario na Impressora                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

DBGOTOP()
SETPRC(0,0)
LIN := 0
COL := 1
LI  := 0

WHILE !EOF()     
	if LI == 0 //20080225
		@ LIN+LI,001 PSAY ' ' + NOME
	else 
		@ LIN+LI,001 PSAY NOME
	endif
	DBSKIP()
	if LI == 0 //20080225
		@ LIN+LI,043 PSAY ' ' + NOME
	else 
		@ LIN+LI,043 PSAY NOME
	endif
	DBSKIP()                  
	if LI == 0 //20080225
		@ LIN+LI,087 PSAY ' ' + NOME
	else
		@ LIN+LI,087 PSAY NOME
	endif
	DBSKIP(-2)
	LI:=LI+1
	
	@ LIN+LI,001 PSAY RESPCOB
	DBSKIP()
	@ LIN+LI,043 PSAY RESPCOB
	DBSKIP()
	@ LIN+LI,087 PSAY RESPCOB
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
	
	@ LIN+LI,001 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +CIDADE+' ' +EST
	DBSKIP()
	@ LIN+LI,045 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +CIDADE+' ' +EST
	DBSKIP()
	@ LIN+LI,087 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +CIDADE+' ' +EST
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

dbclosearea()

Return

Static FUNCTION GRAVA_TEMP()
DBSELECTAREA("ETIQNF")
Reclock("ETIQNF",.t.)
REPLACE NF      WITH  MNF
REPLACE NOME    WITH  CLIE_NOME
REPLACE RESPCOB WITH  XRESPCOB
REPLACE V_END   WITH  MEND
REPLACE BAIRRO  WITH  MBAIRRO
REPLACE CIDADE  WITH  MMUN
REPLACE CEP     WITH  MCEP
REPLACE EST     WITH  MEST
MSUnlock()
RETURN