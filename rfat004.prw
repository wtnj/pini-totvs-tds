#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
User Function rfat004()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
//Danilo C S Pala 20060316: dados de enderecamento do DNE, etiqueta com 9 linhas, sendo a ultima ponto(.)
//Danilo C S Pala 20100305: ENDBP

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,TITULO")
SetPrvt("_ACAMPOS,_CNOME,MNF,MCLI,MPEDIDO,XRESPCOB")
SetPrvt("CLIE_NOME,MEND,MBAIRRO,MMUN,MEST,MCEP")
SetPrvt("CINDEX,CKEY,ARETURN,CDESC1,CDESC2,CDESC3")
SetPrvt("CSTRING,WNREL,NLASTKEY,LIN,COL,LI,_NOTA, LOGR,mhora")   

TITULO:="ETIQUETAS"

CPERG:="PFAT04"

If !PERGUNTE(cPerg)
    Return
Endif

_aCampos :=   {{"NF"  ,"C",6, 0} ,;
{"NOME" ,"C",40,0} ,;
{"RESPCOB","C",40,0} ,;
{"V_END","C",40,0} ,;
{"BAIRRO"  ,"C",20,0} ,;
{"CIDADE"  ,"C",20,0} ,;
{"CEP"     ,"C",8, 0} ,;
{"EST"  ,"C",2, 0},;
{"LOGR"  ,"C",120, 0}}

If Select("ETIQNF") <> 0
	DbselectArea("ETIQNF")
	DbCloseArea()
EndIf
 
_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"ETIQNF",.F.,.F.)   

Proc004()                  

WHILE .T.
	cPerg:="PFAT04"
	
	If !PERGUNTE(cPerg)
		Exit
	Endif

	Proc004()       
END               

Proc004a()     
	         
static function proc004()
_nota := mv_par01
 
DBSELECTAREA("SD2")
dbSetOrder(3)

dbSeek(xfilial()+_nota)
If found()
	mCLI    := SD2->D2_CLIENTE+SD2->D2_LOJA
	mPedido := SD2->D2_PEDIDO
	
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
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//�  Inicio do levantamento dos dados do Cliente                 �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	
	DbSelectArea("SA1")
	DBSEEK(xFilial()+MCLI)
	CLIE_NOME := SA1->A1_NOME
	*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*
	* VERIFICA ENDERECO DA COBRANCA                                    *
	*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*
	
	//20100305 DAQUI
	IF SM0->M0_CODIGO =="03" .AND. SA1->A1_ENDBP ="S"
		DbSelectArea("ZY3")
		DbSetOrder(1)
		DbSeek(XFilial()+XCLI+XLOJA)
		MEND :=ZY3_END
		MBAIRRO :=ZY3_BAIRRO
		MMUN :=ZY3_CIDADE
		MEST :=ZY3_ESTADO
		MCEP  :=ZY3_CEP                               
		MLOGR := ALLTRIM(ZY3_TPLOG)+ " " + ALLTRIM(ZY3_LOGR) + " " + ALLTRIM(ZY3_NLOGR) + " " + ALLTRIM(ZY3_COMPL) //ATE AQUI 20100305
	ELSEIF SA1->A1_ENDCOB=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
		DbSelectArea("SZ5")
		DbSetOrder(1)
		DbSeek(XFilial()+XCLI+XLOJA)
		MEND :=Z5_END
		MBAIRRO :=Z5_BAIRRO
		MMUN :=Z5_CIDADE
		MEST :=Z5_ESTADO
		MCEP  :=Z5_CEP                               
		MLOGR := ALLTRIM(Z5_TPLOG)+ " " + ALLTRIM(Z5_LOGR) + " " + ALLTRIM(Z5_NLOGR) + " " + ALLTRIM(Z5_COMPL) //20060316
	ELSE
		MEND := SA1->A1_END
		MBAIRRO := SA1->A1_BAIRRO
		MMUN := SA1->A1_MUN
		MEST := SA1->A1_EST
		MCEP  := SA1->A1_CEP
		MLOGR := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060316
	ENDIF
	GRAVA_TEMP()
ELSE
	RETURN
ENDIF

Return

Static Function Proc004a()

DBSELECTAREA("ETIQNF")
cIndex:=CriaTrab(Nil,.F.)
//cKey:="cep"
cKey:="NF"
Indregua("ETIQNF",cIndex,ckey,,,"Selecionando Registros do Arq")
aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }
cDesc1:=' '
cDesc2:=' '
cDesc3:=' '
cString:='SD2'
MHORA := TIME()
wnrel:="ETIQNF_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)
NLASTKEY:=0

SetDefault(aReturn,cString)      

RptStatus({|| RptDetail()})

Return

Static Function RptDetail()

DBSELECTAREA("ETIQNF")
DBGOTOP()     

SETPRC(0,0)
LIN:=0
COL:=1
LI:=0

WHILE .NOT. EOF()
	@ LIN+LI,001 PSAY ETIQNF->NOME
	DBSKIP()
	@ LIN+LI,043 PSAY ETIQNF->NOME
	DBSKIP()
	@ LIN+LI,087 PSAY ETIQNF->NOME
	DBSKIP(-2)
	LI:=LI+1
	
	@ LIN+LI,001 PSAY ETIQNF->RESPCOB
	DBSKIP()
	@ LIN+LI,043 PSAY ETIQNF->RESPCOB
	DBSKIP()
	@ LIN+LI,087 PSAY ETIQNF->RESPCOB
	DBSKIP(-2)
	LI:=LI+1
//20060613 DAQUI	
/*	@ LIN+LI,001 PSAY ETIQNF->v_END
	DBSKIP()
	@ LIN+LI,043 PSAY ETIQNF->v_END
	DBSKIP()
	@ LIN+LI,087 PSAY ETIQNF->v_END
	DBSKIP(-2)
	LI:=LI+1 */ 
	
	@ LIN+LI,001 PSAY SUBSTR(ETIQNF->LOGR,1,40)
	DBSKIP()
	@ LIN+LI,043 PSAY SUBSTR(ETIQNF->LOGR,1,40)
	DBSKIP()
	@ LIN+LI,087 PSAY SUBSTR(ETIQNF->LOGR,1,40)
	DBSKIP(-2)	
	LI:=LI+1

	@ LIN+LI,001 PSAY SUBSTR(ETIQNF->LOGR,41,40)
	DBSKIP()
	@ LIN+LI,043 PSAY SUBSTR(ETIQNF->LOGR,41,40)
	DBSKIP()
	@ LIN+LI,087 PSAY SUBSTR(ETIQNF->LOGR,41,40)
	DBSKIP(-2)	
	LI:=LI+1
	
	@ LIN+LI,001 PSAY SUBSTR(ETIQNF->LOGR,81,40)
	DBSKIP()
	@ LIN+LI,043 PSAY SUBSTR(ETIQNF->LOGR,81,40)
	DBSKIP()
	@ LIN+LI,087 PSAY SUBSTR(ETIQNF->LOGR,81,40)
	DBSKIP(-2)	
	LI:=LI+1
// 20060316 ATE AQUI	                    

	@ LIN+LI,001 PSAY ETIQNF->BAIRRO
	DBSKIP()
	@ LIN+LI,043 PSAY ETIQNF->BAIRRO
	DBSKIP()
	@ LIN+LI,087 PSAY ETIQNF->BAIRRO
	DBSKIP(-2)
	LI:=LI+1
	
	@ LIN+LI,001 PSAY SUBS(ETIQNF->CEP,1,5)+'-'+SUBS(ETIQNF->CEP,6,3)+'   ' +ETIQNF->CIDADE+' ' +ETIQNF->EST
	DBSKIP()
	@ LIN+LI,043 PSAY SUBS(ETIQNF->CEP,1,5)+'-'+SUBS(ETIQNF->CEP,6,3)+'   ' +ETIQNF->CIDADE+' ' +ETIQNF->EST
	DBSKIP()
	@ LIN+LI,087 PSAY SUBS(ETIQNF->CEP,1,5)+'-'+SUBS(ETIQNF->CEP,6,3)+'   ' +ETIQNF->CIDADE+' ' +ETIQNF->EST
	LI:=LI+1          
	
	//20060316 DAQUI
	@ LIN+LI,001 PSAY "."
	LI:=LI+1          
	// 20060316 ATE AQUI       
	
	
	
	DBSKIP()
	
	LI:=2
	setprc(0,0)
	lin:=prow()
END

SET DEVICE TO SCREEN

IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()            
 
RETURN                 

Static FUNCTION GRAVA_TEMP()
DBSELECTAREA("ETIQNF")
Reclock("ETIQNF",.t.)
replace NF		WITH  MNF
replace NOME	WITH  CLIE_NOME
replace RESPCOB	WITH  XRESPCOB
replace v_END	WITH  MEND
REPLACE BAIRRO	WITH  MBAIRRO
REPLACE CIDADE	WITH  MMUN
REPLACE CEP		WITH  MCEP
REPLACE EST		WITH  MEST
REPLACE LOGR	WITH  MLOGR
MSUnlock()
RETURN
