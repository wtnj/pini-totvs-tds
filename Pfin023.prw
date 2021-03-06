#include "rwmake.ch" 
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFIN023   ³Autor: Danilo C S Pala        ³ Data:   20090127 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Le o arquivo do relatorio de fluxo de caixa e gerar um dbf ³ ±±
±±³correspondente 														 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Financeiro                                       ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function Pfin023()      
setprvt("_aCampos, _cNome, cIndex, cKey, cArq")
setprvt("_cTitulo, _ccMens1, cMsgFinal, cFonte, cItem")

_cTitulo  := "Gera DBF de Fluxo de Caixa com base no relatorio"
_ccMens1  := "Exemplo: \siga\relato\dcsp\arquivo.##R"
cMsgFinal := space(200)                             
cFonte	  := space(80)
cItem	  :=  space(10)
Private aItens := {"Analitico","Realizado"}

Private cString :="FONTE"
cFonte := __RELDIR + space(60)
@ 010,001 TO 230,350 DIALOG oDlg TITLE _cTitulo
@ 010,005 SAY _ccMens1
@ 020,005 GET cFonte 
@ 020,156 BUTTON "..." SIZE 15,10 ACTION RunDlg()
@ 038,005 SAY "Fluxo de Caixa"
@ 035,050 ComboBox cItem Items aItens Size 80,10
@ 080,005 BUTTON "Processar" SIZE 40,12 ACTION Processa({||ProcArq()})
@ 080,070 BUTTON "Fechar" SIZE 40,12 ACTION ( Close(oDlg) )

Activate Dialog oDlg CENTERED                                         
return


Static Function ProcArq()

if alltrim(cItem) == "Analitico"
	_aCampos := {  {"NOMEBCO"  ,"C",17 ,0} ,;
	{"BRANCO0" ,"C",1 ,0} ,;
	{"BANCO"   ,"C",3 ,0} ,;
	{"BRANCO1" ,"C",9 ,0} ,;
	{"IDENT1"  ,"C",4 ,0} ,; //AG:
	{"AGENCIA" ,"C",7 ,0} ,;
	{"IDENT2"  ,"C",5 ,0} ,; //C/C: 
	{"CONTA"   ,"C",10,0} ,;
	{"BRANCO2" ,"C",98,0} ,;
	{"VLPAGAR" ,"C",12,0} ,;
	{"BRANCO4" ,"C",2 ,0} ,;
	{"VLRECEB" ,"C",12,0} ,;
	{"BRANCO5" ,"C",2 ,0} ,;
	{"VLDISPO" ,"C",13,0}}
else  //Realizado
	_aCampos := {  {"DTMOV"  ,"C",8 ,0} ,;
	{"BRANCO0" ,"C",3 ,0} ,;
    {"NOMEBCO" ,"C",17,0} ,;
	{"BANCO"   ,"C",3 ,0} ,;
	{"BRANCO1" ,"C",1 ,0} ,;
	{"AGENCIA" ,"C",6 ,0} ,;
	{"CONTA"   ,"C",10,0} ,;
	{"BRANCO2" ,"C",18,0} ,;
	{"VLDISPO" ,"C",13,0}}
endif

_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "BANCO+AGENCIA"
dbUseArea(.T.,, _cNome,"FONTE",.F.,.F.)
dbSelectArea("FONTE")
Indregua("FONTE",cIndex,ckey,,,"Selecionando Registros do Arq")

bBloco := "APPEND FROM &cFonte SDF"
APPEND FROM &cFonte SDF
MsAguarde({|| bBloco},"Apendando relatorio...")
MSUNLOCK()
DBGOTOP()

While !Eof()                   
	if alltrim(cItem) == "Analitico"
		IF ALLTRIM(FONTE->IDENT1)<>"AG:" .OR. ALLTRIM(FONTE->IDENT2)<>"C/C:"
			RecLock("FONTE", .F.)
			dbDelete()
			msUnlock()
		ENDIF
	else                                                                       
		IF SUBSTR(FONTE->DTMOV,3,1)<>"/" .OR. SUBSTR(FONTE->DTMOV,6,1)<>"/"  
			RecLock("FONTE", .F.)
			dbDelete()
			msUnlock()
		ENDIF
	endif                
	dbselectarea("FONTE")
	dbskip()
End                          

Private mHora       := Time()           
Private cArquivo    := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
Private cArqPath    := GetMv("MV_PATHTMP")
  
Copy To &(cArqPath+cArquivo+".DBF") VIA "DBFCDXADS" // 20121106 
MsgInfo("Arquivo gerado em "+cArqPath+cArquivo+".DBF")

dbSelectArea("FONTE")
DBCloseArea()
Return


Static Function RunDlg()
cTipo := "Arquivos de Relatorios (*.##R) | *.##R | "
cTipo := cTipo + "Todos os Arquivos (*.*) | *.* "
cFonte := cGetFile(cTipo,"Dialogo de Selecao de Arquivos")
return