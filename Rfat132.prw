#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#include "Fileio.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  |Rfat132   ºAutor  ³Danilo C S Pala     º Data ³  20120622   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Rfat132()
Private cSerie := space(3)
Private dDaData := dDatabase
Private dAteData := dDatabase
Private cNomeArquivo := Padr("C:\POSICAO.CSV",50)
Private cInProdutos := space(50)
Private cDoAlmox := space(2)
Private cAteAlmox := space(2)
Private cDoProduto := space(15)
Private cAteProduto := space(15)
cInProdutos := "'0701075','0701066'                              "

@ 000,000 TO 320,400 DIALOG oDlg TITLE "Parametros para arquivo" 
@ 001,005 TO 310,380
@ 005,010 SAY "Do Almox:"
@ 005,070 GET cDoAlmox  Picture "@!"
@ 020,010 SAY "Ate Almox:"
@ 020,070 GET cAteAlmox Picture "@!"
@ 035,010 SAY "Do Produto"
@ 035,070 GET cDoProduto F3("SB1")
@ 050,010 SAY "Ate Produto"
@ 050,070 GET cAteProduto F3("SB1")
@ 065,010 SAY "Arquivo de saída:"
@ 065,070 GET cNomeArquivo  Picture "@!"
@ 075,070 SAY "Exemplo C:\posicao.CSV"
@ 115,010 BUTTON "Gerar Arquivo" SIZE 40,20 ACTION Processa({||GerarArquivo()})
@ 115,070 BUTTON "Sair" SIZE 40,20 Action ( Close(oDlg) )
Activate Dialog oDlg centered
Return
                
Static Function GerarArquivo()
Local cArquivo 	:= CriaTrab(,.F.)
Local oExcelApp
Local nHandle
Local cCrLf 	:= Chr(13) + Chr(10)
Local nX
local _cArq		:= ""
Private cQuery := ""


nHandle := MsfCreate(Alltrim(cNomeArquivo),0)
	
If nHandle > 0
	// Grava o cabecalho do arquivo
	fWrite(nHandle, "CODIGO;DESCRICAO;TIPO;LOCAL;QUANTIDADE")
	fWrite(nHandle, cCrLf ) // Pula linha


	CQuery := "SELECT B1_COD, B1_DESC, B1_TIPO, B2_LOCAL, (B2_QATU - B2_QEMP - B2_QEMPN - B2_RESERVA) AS QATUA FROM "+ RetSqlName("SB1") +" SB1, "+ RetSqlName("SB2") +" SB2 "
	CQuery += " WHERE B1_FILIAL='"+ XFILIAL("SB1") +"' AND B2_FILIAL='"+ XFILIAL("SB2") +"' AND B1_COD=B2_COD"
	If !Empty(cDoProduto)
		CQuery += " AND B2_COD>='"+ cDoProduto +"' AND B2_COD<='"+ cAteProduto +"'"
	EndIf
	If !Empty(cDoAlmox)
		CQuery += " AND B2_LOCAL>='"+ cDoAlmox +"' AND B2_LOCAL<='"+ cAteAlmox +"'"
	EndIf
	CQuery += " AND B1_LOCPAD=B2_LOCAL AND B1_TIPO IN('CD','DC', 'DV', 'LC','LD','LI','MI','SW','TC') AND SB1.D_E_L_E_T_<>'*' AND SB2.D_E_L_E_T_<>'*'"
	CQuery += " ORDER BY B2_LOCAL, B1_COD"
	
	TCQUERY cQuery NEW ALIAS "POSESTOQ"
	TcSetField("POSESTOQ","QATUA","N",8,0)
	DbSelectArea("POSESTOQ")
	DBGOTOP()
	WHILE !EOF() 
		fWrite(nHandle, ("'"+ POSESTOQ->B1_COD) +";")
		fWrite(nHandle, LimparCSV(POSESTOQ->B1_DESC) +";")
		fWrite(nHandle, LimparCSV(POSESTOQ->B1_TIPO) +";")
		fWrite(nHandle, LimparCSV(POSESTOQ->B2_LOCAL) +";")
		fWrite(nHandle, Transform(POSESTOQ->QATUA,"@r 99999999"))
		fWrite(nHandle, cCrLf )

		DbSelectArea("POSESTOQ")
		DBSkip()
	END
	DbSelectArea("POSESTOQ")
	DbCloseArea()

	fClose(nHandle)
	//CpyS2T( cNomeArquivo , cPath, .T. )
		
	If ! ApOleClient( 'MsExcel' )
		MsgAlert( 'MsExcel nao instalado. Arquivo gerado: ' + alltrim(cNomeArquivo))
		Return
	EndIf
		
	oExcelApp := MsExcel():New()
	oExcelApp:WorkBooks:Open(alltrim(cNomeArquivo)) // Abre uma planilha
	oExcelApp:SetVisible(.T.)
Else
	MsgAlert("Falha na criação do arquivo")
Endif

Return 



Static Function LimparCSV(cTel)
cTel := upper(cTel)
cTel := Alltrim(StrTran(cTel,";",""))
Return cTel