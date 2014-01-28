#include "totvs.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFAT121   ³Autor: DANILO C S PALA        ³ Data:   20081031 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descricao: RELATORIO DE CONTROLE PODER DE TERCEIROS                   ³ ±±
±±³                         											 ³ ±±
SP_REL_PODER_TERCEIROS(IN_VENDEDOR, IN_LOJA, IN_DATADE, IN_DATAATE, IN_SITUACAO, IN_FORMATO)
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/               

User Function RFAT121()      

SetPrvt("lEnd")

//SP_REL_PODER_TERCEIROS(IN_VENDEDOR, IN_LOJA, IN_DATADE, IN_DATAATE, IN_SITUACAO, IN_FORMATO)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //VENDEDOR          ³
//³ mv_par02             //LOJA              ³
//³ mv_par03             //DATADE            ³
//³ mv_par04             //DATAATE           ³
//³ mv_par05             //SITUACAO          ³
//³ mv_par06             //FORMATO           ³
//³ mv_par07             //Relatorio         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

CPERG := 'RFT121'
ValidPerg()
IF !PERGUNTE(CPERG)
	RETURN
ENDIF

lEnd := .F.
Processa({|lEnd| ProcArq(@lEnd)})
Return


Static Function ProcArq()
Private nQTD_ENT    := 0
PRIVATE MHORA     := TIME()
Private cString   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
Private cArqPath  := GetMv("MV_PATHTMP")
Private _cString  := cArqPath+cString+".DBF"
Private cSituacao := Space(1) //mv_par05 //1=Aberto, 2=Fechado, 3=Todos
Private cFormato := Space(1) //mv_par06 //1=Analitico, 2=Sintetico   
Private cFile := ""
Private cArquivo
Private cMask      := "Planilhas (*.xls) |*.xls|Todos os arquivos (*.*) |*.*|"

if mv_par05  == 1
	cSituacao := "A"
elseif mv_par05 == 2
	cSituacao := "F"
else
	cSituacao := "T"
endif

if mv_par06 == 1
	cFormato := "A"
else
	cFormato := "S"
endif

DbSelectArea("SB1")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif    


//Pergunta qual local deseja salvar o arquivo...

/*                 
If mv_par07  == 1
//Verifica se a Stored Procedure Teste existe no Servidor
	If TCSPExist("SP_REL_PODER_TERCEIROS")
		//SP_REL_PODER_TERCEIROS(IN_VENDEDOR, IN_LOJA, IN_DATADE, IN_DATAATE, IN_SITUACAO, IN_FORMATO)
		aRet := TCSPExec("SP_REL_PODER_TERCEIROS", mv_par01, mv_par02, dtos(mv_par03), dtos(mv_par04), cSituacao, cFormato)
		
		cQuery := "SELECT TIPO, SERIEORI, DOCORI, SERIE, DOC, OBS, EMISSAO, TPPROD, PRODUTO, DESCR, ROUND(QTDSAIDA,1) AS QTDSAIDA, ROUND(NVL(QTDENTR,0),1) AS QTDENTR, ROUND(QTDDIF,1) AS QTDDIF, ROUND(CUSTO1,1) AS CUSTO1 from rel_poder_terceiros ORDER BY SERIEORI, DOCORI, PRODUTO, TIPO DESC"
		//TCQUERY cQuery NEW ALIAS "PODER3"   
		MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PODER3", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
		TcSetField("PODER3","QTDSAIDA" ,"N",10,0)
		TcSetField("PODER3","QTDENTR"  ,"N",10,0)
		TcSetField("PODER3","QTDDIF"   ,"N",10,0)
		
		DbSelectArea("PODER3")
		DBGotop()
		COPY TO &_cString VIA "DBFCDXADS" // 20121106 
		DBCloseArea()
		
		cMsg:= "Arquivo gerado em: "+_cString
		MSGINFO(cMsg)
	EndIf
	
Else

	cQuery := "SELECT f1_emissao, f1_serie, f1_doc, f1_fornece, f1_loja, f1_tipo, f1_valmerc, f1_valbrut from sf1010 where f1_filial='"+xfilial("SF1")+"' and f1_tipo ='B' and f1_emissao>='"+ dtos(mv_par03) +"' and f1_emissao<='"+ dtos(mv_par04) +"' and d_e_l_e_t_<>'*'"
	MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PODER3", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
	TcSetField("PODER3","f1_emissao" 	,"D")
	TcSetField("PODER3","f1_valmerc"  	,"N",10,2)
	TcSetField("PODER3","f1_valbrut"   	,"N",10,2)
	
	DbSelectArea("PODER3")
	DBGoTop()
	
	DbSelectArea("PODER3")
	DBGotop()
	COPY TO &_cString VIA "DBFCDXADS" //20121106 
	DBCloseArea()
	
	cMsg:= "Arquivo gerado em: " + _cString
	MSGINFO(cMsg)

Endif
  
*/
 
If mv_par07  == 1  
   
	cQuery := "SELECT SD2.D2_DOC AS ENTRADA, SD1.D1_DOC AS SAIDA, SD2.D2_SERIE AS SERS , SD1.D1_SERIE AS SERE," + CRLF
	cQuery += "       SF1.F1_OBS AS OBS ," + CRLF
	cQuery += "       SD2.D2_EMISSAO AS EMISSAOE, SD1.D1_EMISSAO AS EMISSAOS, " + CRLF
   
	cQuery += "       SB1.B1_COD AS CODIGO, " + CRLF
	cQuery += "       SB1.B1_DESC AS DESCRICAO , SB1.B1_TIPO AS TIPO, SD2.D2_QUANT AS QTDSAIDA, " + CRLF
	cQuery += "       SD1.D1_QUANT AS QTDENTR, (SD2.D2_QUANT - SD1.D1_QUANT) AS QTDDIF," + CRLF
	cQuery += "       ROUND(( (SD2.D2_QUANT - SD1.D1_QUANT) * SD2.D2_CUSTO1) / SD2.D2_QUANT,2) AS CUSTO1"   + CRLF
	       
	cQuery += "FROM "+RETSQLNAME("SF2")+" SF2" + CRLF
	cQuery += "JOIN "+RETSQLNAME("SD2")+" SD2 ON SD2.D_E_L_E_T_ != '*' " + CRLF
	cQuery += "AND SD2.D2_FILIAL = SF2.F2_FILIAL " + CRLF
	cQuery += "AND SD2.D2_DOC = SF2.F2_DOC " + CRLF
	cQuery += "AND SD2.D2_SERIE = SF2.F2_SERIE" + CRLF
	cQuery += "AND SD2.D2_CLIENTE = SF2.F2_CLIENTE " + CRLF
	cQuery += "AND SD2.D2_LOJA = SF2.F2_LOJA" + CRLF
	
	cQuery += "JOIN "+RETSQLNAME("SB1")+" SB1 ON SB1.D_E_L_E_T_ != '*'" + CRLF
	cQuery += "AND SB1.B1_COD = SD2.D2_COD" + CRLF
	
	cQuery += "JOIN "+RETSQLNAME("SD1")+" SD1 ON SD1.D_E_L_E_T_ != '*' " + CRLF
	cQuery += "AND SD1.D1_FILIAL = SD2.D2_FILIAL" + CRLF
	cQuery += "AND SD1.D1_NFORI = SD2.D2_DOC" + CRLF
	cQuery += "AND SD1.D1_SERIORI = SD2.D2_SERIE" + CRLF
	cQuery += "AND SD1.D1_ITEMORI = SD2.D2_ITEM" + CRLF
	
	cQuery += "JOIN "+RETSQLNAME("SF1")+" SF1 ON SF1.D_E_L_E_T_ != '*'" + CRLF 
	cQuery += "AND SF1.F1_FILIAL = SD1.D1_FILIAL" + CRLF
	cQuery += "AND SF1.F1_DOC = SD1.D1_DOC" + CRLF
	cQuery += "AND SF1.F1_SERIE = SD1.D1_SERIE" + CRLF
	
	cQuery += "WHERE SF2.D_E_L_E_T_ != '*' " + CRLF
	cQuery += "AND SD2.D2_CLIENTE = '"+MV_PAR01+"' " + CRLF
	cQuery += "AND SF2.F2_EMISSAO BETWEEN '"+DTOS(MV_PAR03)+"' AND '"+DTOS(MV_PAR04)+"' " + CRLF
	cQuery += "ORDER BY SF2.F2_EMISSAO, SD2.D2_DOC, SD1.D1_DOC " + CRLF
	
	MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PODER3", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
	
		TcSetField("PODER3","EMISSAOS" 	,"D")
		TcSetField("PODER3","EMISSAOE" 	,"D")
		TcSetField("PODER3","CUSTO1"   		,"N" ,10 ,2)
		TcSetField("PODER3","QTDENTR"  		,"N" ,10 ,2)
		TcSetField("PODER3","QTDSAIDA" 		,"N" ,10 ,2)
   		
	DbSelectArea("PODER3")
	DBGoTop()
	
	DbSelectArea("PODER3")
	DBGotop()
	COPY TO &_cString VIA "DBFCDXADS" //20121106 
	DBCloseArea("PODER3")
	
	cMsg:= "Arquivo gerado em: " + _cString
	MSGINFO(cMsg)

Else

	cQuery := "SELECT f1_emissao, f1_serie, f1_doc, f1_fornece, f1_loja, f1_tipo, f1_valmerc, f1_valbrut from sf1010 where f1_filial='"+xfilial("SF1")+"' and f1_tipo ='B' and f1_emissao>='"+ dtos(mv_par03) +"' and f1_emissao<='"+ dtos(mv_par04) +"' and d_e_l_e_t_<>'*'"
	MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PODER3", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
	TcSetField("PODER3","f1_emissao" 	,"D")
	TcSetField("PODER3","f1_valmerc"  	,"N",10,2)
	TcSetField("PODER3","f1_valbrut"   	,"N",10,2)
	
	DbSelectArea("PODER3")
	DBGoTop()
	
	DbSelectArea("PODER3")
	DBGotop()
	COPY TO &_cString VIA "DBFCDXADS" //20121106 
	DBCloseArea("PODER3")
	
	cMsg:= "Arquivo gerado em: " + _cString
	MSGINFO(cMsg)

Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValidPerg ºAutor  ³DANILO C S PALA     º Data ³  20080919   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria parametros no SX1 nao existir os parametros.           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)  //mp10 x1_grupo char(10)
aRegs := {}
aAdd(aRegs,{cPerg,"01","Vendedor?      ","Vendedor?      ","Vendedor?      ","mv_ch1","C",06,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Loja?          ","Loja?          ","Loja?          ","mv_ch2","C",02,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Emissão de?    ","Emissão de?    ","Emissão de?    ","mv_ch3","D",08,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Emissão até?   ","Emissão até?   ","Emissão até?   ","mv_ch4","D",08,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Situacao?      ","Situacao?      ","Situacao?      ","mv_ch5","C",01,0,2,"C","","MV_PAR05","Aberto","Aberto","Aberto","","","Fechado","Fechado","Fechado","","","Todos","Todos","Todos","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","Formato?       ","Formato?       ","Formato?       ","mv_ch6","C",01,0,2,"C","","MV_PAR06","Analitico","Analitico","Analitico","","","Sintetico","Sintetico","Sintetico","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","Relatorio?     ","Relatorio?     ","Relatorio?     ","mv_ch7","C",01,0,2,"C","","MV_PAR07","Poder3","Poder3","Poder3","","","NF Beneficiamento","NF Beneficiamento","NF Beneficiamento","","","","","","","","","","","","","","","","","","","","",""})

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
