
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRfat111   บAutor  ณDanilo C S Pala     บ Data ณ  03/11/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณConsultar zz6 com parametro: origem e estado                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Rfat111

//Private cString
Local aOrd := {}
Local cDesc1 := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2 := "de acordo com os parametros informados pelo usuario."
Local cDesc3 := ""
Local cPict  := ""
Local titulo       := "*** Relatorio de Prospects ***"
Local nLin         := 80
Local Cabec1       := ""
Local Cabec2       := ""
Local imprime      := .T.

Private cPerg     := "FAT111"  //SX1
Private cString    := "ZZ6"
Private CbTxt      := ""
Private lEnd := .F.
Private lAbortPrint  := .F.
Private limite           := 80
Private tamanho          := "P"
Private nomeprog         := "Rfat111" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private MHORA := TIME()
Private wnrel      := "Rfat111_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2) // Coloque aqui o nome do arquivo usado para impressao em disco

Setprvt("aCampos, cMsg, tot, estado, subtotal, descricao, orig")

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณParametros em FAT111 no SX1                ณ
//ณmv_par01 => De origem                      ณ
//ณmv_par02 => Ate origem                     ณ
//ณmv_par03 => Agrupar por Estado (SIM ou NAO)ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
*/

If !Pergunte(cPerg)      //parametros de FAT111 em SX1  para montar a GUI
	Return
Endif

wnrel := SetPrint(cString,NomeProg,cPerg,titulo,cDesc1,cDesc2,cDesc3,.f.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|| Rel_Rfat111(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRFAT111   บAutor  ณMicrosiga           บ Data ณ  03/12/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de relatorio                                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Rel_Rfat111(Cabec1,Cabec2,Titulo,nLin)
#INCLUDE "TOPCONN.CH"            //consulta SQL
Local nOrdem
SetPrvt("cQuery")

SET DEVICE TO PRINTER

dbSelectArea("ZZ6")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif



//Decisao de agrupamento por estado
if mv_par03 == 1  // Sim: agrupar por estado
	
	cQuery := "select zz6_estado, count(zz6_origem) as SUBTOTAL from zz6010 where zz6_origem between "
	cQuery := cQuery +mv_par01+ " and " +mv_par02
	cQuery := cQuery + " group by zz6_estado order by zz6_estado"
	
	//TCQuery Abre uma workarea com o resultado da query
	TCQUERY cQuery NEW ALIAS "QRY"
	
	tot := 0
	Cabec1       := "De origem: "+mv_par01+ " Ate origem: " +mv_par02
             // 123456789 123456789
	Cabec2 := "Estado  Subtotal"
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 10
	
	SetRegua(RecCount())
	dbGoTop()
	While !EOF()
		Subtotal := Qry->SUBTOTAL
		Estado := Qry->zz6_ESTADO
		Tot += Subtotal
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif    
		// codigo p imprimir
		@nLin,00 PSAY ESTADO
		@nLin,8 PSAY Transform(SUBTOTAL,"@E 999,999,999")
		nLin := nLin + 1 // Avanca a linha de impressao
		dbSkip()
	End
	
	nLin := nLin + 1
	@nLin,8 PSAY "Total"
	@nLin+1,8 PSAY "-----------"
	@nLin+2,8 PSAY  Transform(TOT,"@E 999,999,999")
	Dbclosearea("Qry")
else   //Nao: nao agrupar por estado e sim por origem
	
	cQuery := "select z6.zz6_origem as origem, z5.x5_descri as descr, count(z6.zz6_cod) as subtotal from zz6010 z6, sx5010 z5 "
	cQuery := cQuery + 	"where (z5.x5_tabela = '91' and z5.x5_chave = z6.zz6_origem) and z6.zz6_origem between "
	cQuery := cQuery + mv_par01+ " and " +mv_par02
	cQuery := cQuery + " group by z6.zz6_origem, z5.x5_descri order by z6.zz6_origem "
	//TCQuery Abre uma workarea com o resultado da query
	TCQUERY cQuery NEW ALIAS "QUERY"

	tot := 0
	Cabec1       := "De origem: "+mv_par01+ " Ate origem: " +mv_par02
     	     // 123456789 123456789 123456789 123456789 123456789 123456789
	Cabec2 := "Origem  Descricao                                         Subtotal"
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 10

	SetRegua(RecCount())
	dbGoTop()
	While !EOF()
		Orig := Query->Origem
		Descricao := Query->descr
		Subtotal := Query->SUBTOTAL
		Tot += Subtotal
		If lAbortPrint
			@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif    
		// codigo p imprimir
		@nLin,00 PSAY orig
		@nLin,8 PSAY substr(Descricao,1,49)
		@nLin,58 PSAY Transform(SUBTOTAL,"@E 999,999,999")
		nLin := nLin + 1 // Avanca a linha de impressao
		dbSkip()
	End
	
	nLin := nLin + 1
	@nLin,58 PSAY "Total"
	@nLin+1,58 PSAY "-----------"
	@nLin+2,58 PSAY  Transform(TOT,"@E 999,999,999")
	Dbclosearea("Query")
	
endif


//bloco fim de impressao
SET DEVICE TO SCREEN

IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()



return
