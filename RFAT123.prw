#INCLUDE "rwmake.ch"                       
#include "topconn.ch"
#include "tbiconn.ch"

/*/     
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFAT123   ³Autor: Danilo C S Pala        ³ Data:   20090914 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera arquivo de contratos                                  ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function RFAT123() 
setprvt("cArq, cArqPath, cArquivo")
setprvt("mhora, mdata, cQuery, nLastKey, nTotal")


@ 010,001 TO 100,200 DIALOG oDlg TITLE "Relatorio de Contratos"
@ 015,010 BUTTON "Gerar" SIZE 40,15 ACTION   Processa({||ProcQuery()})
@ 015,060 BUTTON "Fechar" SIZE 40,15 Action ( Close(oDlg) )
Activate Dialog oDlg CENTERED     
Return    




Static Function ProcQuery()
Private cQuery := ""
//DbSelectArea("ZZW")
cQuery := "SELECT ZZW_NUM NUMERO, ZZW_CLIENT CLIENTE, ZZW_LOJACL LOJA, ZZW_NOMECL NOME, ZZW_DTCALC DTCALC, ZZW_VEND1 VEND1, ZZW_VEND2 VEND2, ZZW_VEND3 VEND3, ZZW_VEND4 VEND4, ZZW_VEND5 VEND5, ZZW_RESPCO RESPCO, ZZW_PRODUT PRODUTO, ZZW_VALOR VALOR, ZZW_VALORO VALOROLD, ZZW_DTINI DTINI, ZZW_DTFIM DTFIM, ZZW_DTSUSP DTSUSP, ZZW_STATUS STATUS, ZZW_DTATU DTATU, ZZW_OBS OBS FROM ZZW030 WHERE D_E_L_E_T_<>'*'"
MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "CONTRATO", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
TcSetField("CONTRATO","DTCALC","D")
TcSetField("CONTRATO","DTINI" ,"D")
TcSetField("CONTRATO","DTFIM" ,"D")
TcSetField("CONTRATO","DTSUSP" ,"D")
TcSetField("CONTRATO","DTATU" ,"D")
                   
DbSelectArea("CONTRATO")

MHORA     := TIME()
cArq      := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,4,2) +".DBF"
cArqPath   :=GetMv("MV_PATHTMP")                    
cArquivo := cArqPath+cArq
COPY TO &cArquivo VIA "DBFCDXADS" // 20121106              

MsgInfo(cArquivo)     
dbselectarea("CONTRATO")
dbclosearea()
Return