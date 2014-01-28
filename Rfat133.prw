#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#include "Fileio.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  |Rfat133   �Autor  �Danilo C S Pala     � Data �  20120628   ���
�������������������������������������������������������������������������͹��
���Desc.     � PiniProtheusService, clientes de SP sem inscricao estadual ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Pini                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function Rfat133()
Private cSerie := space(3)
Private dDaData := dDatabase
Private dAteData := dDatabase
Private cEstado := "SP"
Private cNomeArquivo := space(50)

@ 000,000 TO 320,400 DIALOG oDlg TITLE "Parametros para arquivo" 
@ 001,005 TO 310,380
@ 005,010 SAY "Da Data:"
@ 005,070 GET dDaData
@ 020,010 SAY "Ate Data"
@ 020,070 GET dAteData 
@ 035,010 SAY "Estado"
@ 035,070 GET cEstado PICTURE "@!"
@ 065,010 SAY "Arquivo de sa�da:"
@ 065,070 GET cNomeArquivo  Picture "@!"
@ 075,070 SAY "Exemplo C:\inscr.CSV"
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
	fWrite(nHandle, "DATALOTE;CODIGO;LOJA;NOME;CPFCNPJ;IE;PEDIDO;SERIE;NOTA;EMISSAO")
	fWrite(nHandle, cCrLf ) // Pula linha

	CQuery := "select substr(to_char(p.datalotews,'dd/MM/yyyy'),1,10) as datalote, a1_cod, a1_loja, a1_nome, a1_cgc, a1_inscr, p.numpedidopini, se1.e1_serie, se1.e1_num, NVL(e1_emissao,'        ') AS EMISSAO "
	CQuery += " from "+ RetSqlName("SA1") +" sa1, pinipedido p LEFT OUTER JOIN SE1010 SE1 ON (E1_FILIAL='"+ XFILIAL("SE1") +"' AND E1_PEDIDO=SUBSTR(P.NUMPEDIDOPINI,1,6) AND E1_CLIENTE=substr(p.codclientepini,1,6) and E1_loja=substr(p.codclientepini,7,2))" 
	CQuery += " where a1_filial='"+ XFILIAL("SA1") +"' and a1_cod=substr(p.codclientepini,1,6) and a1_loja=substr(p.codclientepini,7,2) and sa1.d_e_l_e_t_<>'*' "
	CQuery += " and p.datalotews>= to_date('"+ dtos(dDaData) +"','yyyyMMdd') and p.datalotews<=to_date('"+ dtos(dAteData) +"','yyyyMMdd')"
	CQuery += " and length(rtrim(a1_cgc)) >11 and a1_inscr='                  ' and a1_est='"+ cEstado +"'"
	
	If Select("TRBIE") <> 0
		DbSelectArea("TRBIE")
		DbCloseArea()
	EndIf
	
	//TCQUERY cQuery NEW ALIAS "TRBIE"
	DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "TRBIE", .T., .F. )
	TcSetField("TRBIE","DATALOTE","C",10,0)
	TcSetField("TRBIE","NUMPEDIDOPINI","C",10,0)
	TcSetField("TRBIE","EMISSAO","C",8,0)
	
	DbSelectArea("TRBIE")
	DBGOTOP()
	WHILE !EOF("TRBIE") 
		fWrite(nHandle, (TRBIE->DATALOTE) +";")
		fWrite(nHandle, ("'"+TRBIE->A1_COD) +";")
		fWrite(nHandle, ("'"+TRBIE->A1_LOJA) +";")
		fWrite(nHandle, LimparCSV(TRBIE->A1_NOME) +";")
		fWrite(nHandle, Transform(TRBIE->A1_CGC,"@R 999.999.999/9999-99")+";")
		fWrite(nHandle, LimparCSV(TRBIE->A1_INSCR) +";")
		fWrite(nHandle, LimparCSV(TRBIE->NUMPEDIDOPINI) +";")
		fWrite(nHandle, LimparCSV(TRBIE->E1_SERIE) +";")
		fWrite(nHandle, LimparCSV(TRBIE->E1_NUM) +";")
		fWrite(nHandle, "'"+ TRBIE->EMISSAO +";")
		fWrite(nHandle, cCrLf )

		DbSelectArea("TRBIE")
		DBSkip()
	END
	DbSelectArea("TRBIE")
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