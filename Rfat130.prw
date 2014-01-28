#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#include "Fileio.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  |Rfat130   �Autor  �Danilo C S Pala     � Data �  20120424   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Pini                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Rfat130()
Private cSerie := space(3)
Private dDaData := dDatabase
Private dAteData := dDatabase
Private cNomeArquivo := space(50)
Private cInProdutos := space(50)
cInProdutos := "'0701075','0701066'                              "

@ 000,000 TO 320,400 DIALOG oDlg TITLE "Parametros para arquivo" 
@ 001,005 TO 310,380
@ 005,010 SAY "Serie:"
@ 005,070 GET cserie  Picture "@!" 
@ 020,010 SAY "Da Data:"
@ 020,070 GET dDaData
@ 035,010 SAY "Ate Data"
@ 035,070 GET dAteData        
@ 050,010 SAY "Ate Data"
@ 050,070 GET cInProdutos
@ 065,010 SAY "Arquivo de sa�da:"
@ 065,070 GET cNomeArquivo  Picture "@!"
@ 075,070 SAY "Exemplo C:\lic201204.CSV"
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
	fWrite(nHandle, "EMISSAO;SERIE;NUMERO;CLIENTE;CPFCNPJ;FONE;EMAIL")
	fWrite(nHandle, cCrLf ) // Pula linha

	CQuery := "select d2_emissao EMISSAO, d2_serie SERIE, d2_doc NUMERO, a1_nome CLIENTE, a1_cgc CPFCNPJ, a1_tel FONE, a1_email EMAIL "
	CQuery += " from "+ RetSqlName("SA1") +" SA1, "+ RetSqlName("SD2") +" SD2 "
	CQuery += " where a1_filial='"+ XFILIAL("SA1") +"' and a1_cod=d2_cliente and a1_loja=d2_loja and d2_filial='"+ XFILIAL("SD2") +"' and d2_cod in ("+ cInProdutos +") and d2_serie='"+ cSerie +"' and d2_emissao>='"+ dtos(dDaData) + "' and d2_emissao<='"+ dtos(dAteData) +"' and sa1.d_e_l_e_t_<>'*' and sd2.d_e_l_e_t_<>'*'
	CQuery += " order by d2_emissao, d2_doc"
	TCQUERY cQuery NEW ALIAS "NOTA"
	TcSetField("NOTA","EMISSAO"   ,"D")
	DbSelectArea("NOTA")
	DBGOTOP()
	WHILE !EOF() 
		fWrite(nHandle, dtoc(NOTA->EMISSAO) +";")
		fWrite(nHandle, ("'"+ NOTA->SERIE) +";")
		fWrite(nHandle, ("'"+ NOTA->NUMERO) +";")
		fWrite(nHandle, LimparCSV("'"+ NOTA->CLIENTE) +";")
		fWrite(nHandle, LimparCSV("'"+ NOTA->CPFCNPJ) +";")
		fWrite(nHandle, LimparCSV("'"+ NOTA->FONE) +";")
		fWrite(nHandle, LimparCSV("'"+ NOTA->EMAIL))
		fWrite(nHandle, cCrLf )

		DbSelectArea("NOTA")
		DBSkip()
	END
	DbSelectArea("NOTA")
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
	MsgAlert("Falha na cria��o do arquivo")
Endif

Return 



Static Function LimparCSV(cTel)
cTel := upper(cTel)
cTel := Alltrim(StrTran(cTel,";",""))
Return cTel