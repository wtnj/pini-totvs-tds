#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"
/*   
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRCTB001	บAutor  ณDanilo C S Pala     บ Data ณ  20130812   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio de LANCAMENTOS CONTABEIS				    	     บฑฑ
ฑฑบ          ณ  		           										  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PINI                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function RCTB001()
SetPrvt("CDESC1,CDESC2,CDESC3,CSTRING,TITULO,ARETURN")
SetPrvt("NOMEPROG,ALINHA,NLASTKEY,CPERG,MSALAPL,WNREL")
SetPrvt("TAMANHO,LIMITE,NSALDOATU,NENTRADAS,NSAIDAS,NSALDOINI")
SetPrvt("CFIL,NORDSE5,ARECON,_ASTRU,_CARQUIVO,LALLFIL")
SetPrvt("CBTXT,CBCONT,LI,M_PAG,CBANCO,CNOMEBANCO")
SetPrvt("CAGENCIA,CCONTA,NLIMCRED,CABEC1,CABEC2,NTIPO")
SetPrvt("CCHAVE,CCOND,CINDEX,NINDEX,CCONDWHILE,LEND")
SetPrvt("_LSUBTRAI,CDOC,_MVALOR,L,TOTENT,TOTSAI")
SetPrvt("TOTOUT,MSUBT,MTIPON,MTIT,mhora")
SetPrvt("CPERG,_StringArq, cquery, aRegs")
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cDesc1   := OemToAnsi("Relatorio de Lancamento Contabil")
cDesc2   := " "
cDesc3   := " "
cString  := "CT2"

titulo   := OemToAnsi("Relatorio de Lancamento Contabil")
aReturn  := { OemToAnsi("Especial"), 1,OemToAnsi("Administraฦo"), 2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
nomeprog := "RCTB001"
aLinha   := { }
nLastKey := 0
Msalapl  := 0


MHORA      := TIME()
_StringArq := "\SIGA\ARQTEMP\"+ SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2) +".DBF"

cPerg := "RCTB001"
ValidPerg()
Pergunte(cPerg,.t.)   

//--TITULOS AVULSOS: pegar conta do fornecedor
cQuery := "SELECT CT2_DATA, CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_LINHA, CT2_DC, CT2_DEBITO, CT2_CREDIT, CT2_VALOR, CT2_HIST, CT2_CCD, CT2_CCC, CT2_PRODUT, CT2_EDICAO, CT2_PROCES, CT2_ORIGEM"
cQuery += " FROM "+ RetSqlName("CT2") +" CT2 "
cQuery += " WHERE CT2_FILIAL='"+xfilial("CT2")+"' AND CT2_DATA='"+ DTOS(MV_PAR01)+"'"
IF !EMPTY(MV_PAR02)
 	cQuery += " AND CT2_LOTE='"+ MV_PAR02 +"'"
ENDIF
IF !EMPTY(MV_PAR03)
 	cQuery += " AND CT2_DOC='"+ MV_PAR03 +"'"
ENDIF
IF !EMPTY(MV_PAR04)
 	cQuery += " AND CT2_HIST LIKE'%"+ ALLTRIM(MV_PAR04) +"%'"
ENDIF
IF !EMPTY(MV_PAR05)
 	cQuery += " AND CT2_ORIGEM LIKE'%"+ ALLTRIM(MV_PAR05) +"%'"
ENDIF
cQuery += " AND D_E_L_E_T_<>'*' ORDER BY CT2_DATA, CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_LINHA"
MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "RCTB001", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
TcSetField("RCTB001","CT2_DATA"   ,"D")

DBSelectArea("RCTB001")
DBGotop()


	wnrel := "RCTB001"
	WnRel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",.T.,"","",.F.)

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Envia controle para a funcao REPORTINI substituir as variaveis.ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	SetDefault(aReturn,cString)
	If nLastKey == 27
		Return
	Endif

	lEnd := .f.
	tamanho   := "M"
	limite    := 132
	Cabec1 := ""
	Cabec2 := ""
	nTipo  := IIF(aReturn[4]==1,15,18)
	LI := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
	LI++
	@ LI,00 PSAY MSUBT
	LI += 2

While !eof()
	If li >= 75
		//Roda(0,"",tamanho)
		LI := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		LI++
		@ LI,00 PSAY MSUBT
		LI += 2
	EndIf
	
	@ Li,00 PSAY 'Data: '+ DTOC(RCTB001->CT2_DATA) //  SUBS(ED_CODIGO,1,4) +']   '+TRIM(ED_DESCRIC)+REPLICATE('-',(40-(LEN(TRIM(ED_DESCRIC)))))
	@ Li,50 PSAY 'Lote: '+ RCTB001->CT2_LOTE
	@ Li,80 PSAY 'Sublote: '+ RCTB001->CT2_SBLOTE
	Li++
	@ Li,00 PSAY 'Doc: '+ RCTB001->CT2_DOC
	@ Li,50 PSAY 'Linha: '+ RCTB001->CT2_LINHA 
	@ Li,80 PSAY 'Tipo Lancto: '+ RCTB001->CT2_DC
	Li++
	@ Li,00 PSAY 'Debito: '+ RCTB001->CT2_DEBITO
	@ Li,50 PSAY 'Credito: '+ RCTB001->CT2_CREDIT
	@ Li,80 PSAY 'Valor: '+ Transform(RCTB001->CT2_VALOR ,"@E 99,999,999,999.99")
	Li++
	@ Li,00 PSAY 'Hist: '+ RCTB001->CT2_HIST
	@ Li,50 PSAY 'CC Deb: '+ RCTB001->CT2_CCD
	@ Li,80 PSAY 'CC Cred: '+ RCTB001->CT2_CCC
	Li++
	@ Li,00 PSAY 'Produto: '+ RCTB001->CT2_PRODUT
	@ Li,50 PSAY 'Edicao: '+ Transform(RCTB001->CT2_EDICAO ,"@E 9999")
	@ Li,80 PSAY 'Campanha: '+ RCTB001->CT2_PROCES
	Li++
	@ Li,00 PSAY 'Origem: '+ RCTB001->CT2_ORIGEM
	Li++
	@ Li,00 PSAY REPLICATE('-',120) 
	
	IF Li >= 75
		//Roda(0,"",tamanho)
		LI := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
		LI++
	ELSE
		Li++
	ENDIF
	
	DBSelectArea("RCTB001")
	DbSkip()
End

If aReturn[5] == 1
	Set Printer To
	ourspool(wnrel)
End
MS_FLUSH()
		
	
	
COPY TO &_StringArq VIA "DBFCDXADS" 
DBCLOSEAREA()
//MsgInfo(_StringArq)   

Return             


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidPerg บAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria parametros no SX1 nao existir os parametros.           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}

aAdd(aRegs,{cPerg,"01","Data","Data","Data","mv_ch1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Lote","Lote","Lote","mv_ch2","C",06,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Doc","Doc","Doc","mv_ch3","C",06,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Historico","Historico","Historico","mv_ch4","C",20,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Origem","Origem","Origem","mv_ch5","C",20,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

_nLimite := If(Len(aRegs[1])<FCount(),Len(aRegs[1]),FCount())
For i := 1 To Len(aRegs)
	If !DbSeek(cPerg + aRegs[i,2])
		Reclock("SX1", .T.)
		For j := 1 to _nLimite
			FieldPut(j, aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next
DbSelectArea(_sAlias)

Return(.T.)