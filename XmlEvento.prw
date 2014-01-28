#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³XMLEvento ³ Autor ³ Danilo C S Pala       ³ Data ³20091028  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera arquivo XML com os dados do evento: NFS e itens        ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³String xml                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³					                                          ³±±
±±³          ³     				                                          ³±±
±±³          ³       			                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function XmlEvento(cCodEvento)
/*Private cDoNumero := space(9)
Private cAteNumero := space(9)
Private cSerie := space(3)
Private cVendedor := space(6)
Private cCodEvento := space(6)
Private cNomeEvento := space(40)
Private dDataEvento := date()
Private nVias := 1
//Private aItens := {"Abertas","Baixadas","Todas"}    

@ 000,000 TO 320,400 DIALOG oDlg TITLE "Xml Evento" 
@ 001,005 TO 310,380
@ 005,010 SAY "Serie:"
@ 005,070 GET cserie  Picture "@!" F3("SF2") Valid ValSF2()
@ 020,010 SAY "Do Numero:"
@ 020,070 GET cDoNumero  Picture "@R 999999999"
@ 035,010 SAY "Ate Numero"
@ 035,070 GET cAteNumero  Picture "@R 999999999"
@ 050,010 SAY "Vendedor:"
@ 050,070 GET cVendedor  Picture "@!" F3("SA3")
@ 065,010 SAY "Codigo Evendo:"
@ 065,070 GET cCodEvento  Picture "@!"
@ 080,010 SAY "Nome Evendo:"
@ 080,070 GET cNomeEvento  Picture "@!"
@ 095,010 SAY "Data Evendo:"
@ 095,070 GET dDataEvento
@ 115,010 BUTTON "Gerar XML" SIZE 40,20 ACTION Processa({||GetXml()})
@ 115,070 BUTTON "Sair" SIZE 40,20 Action ( Close(oDlg) )
Activate Dialog oDlg centered
Return


Static Function GetXml()*/
Private cQuery :=""
Private cString :=""

cQuery := "SELECT * FROM "+ RetSqlName("ZY0") +" ZY0 WHERE ZY0_FILIAL='"+ XFILIAL("ZY0") +"' AND ZY0_CODEVE='"+ cCodEvento +"' AND ZY0.D_E_L_E_T_<>'*'"
TCQUERY cQuery NEW ALIAS "EVENTO"
TcSetField("EVENTO","ZY0_DATA"   ,"D")
DbSelectArea("EVENTO")
DBGOTOP()
IF !EOF() 

	cString += '<DSEvento>'
	cString += '<xs:schema id="DSEvento" xmlns="" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">'
	cString += '<xs:element name="DSEvento" msdata:IsDataSet="true" msdata:UseCurrentLocale="true">'
	cString += '<xs:complexType>'
	cString += '<xs:choice minOccurs="0" maxOccurs="unbounded">'
	cString += '<xs:element name="Versao">'                      
	cString += '<xs:complexType>'
	cString += '<xs:sequence>'
	cString += '<xs:element name="CodVersao" type="xs:string" minOccurs="0" />'
	cString += '</xs:sequence>'
	cString += '</xs:complexType>'
	cString += '</xs:element>'
	cString += '<xs:element name="Evento">'
	cString += '<xs:complexType>'
	cString += '<xs:sequence>'
	cString += '<xs:element name="CodEvento" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Nome" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Data" type="xs:string" minOccurs="0" />'
	cString += '</xs:sequence>'
	cString += '</xs:complexType>'
	cString += '</xs:element>'
	cString += '<xs:element name="NotaFiscal">'
	cString += '<xs:complexType>'
	cString += '<xs:sequence>'
	cString += '<xs:element name="CodEvento" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Serie" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Numero" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Data" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Vendedor1" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Vendedor2" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Vendedor3" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Vendedor4" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Vendedor5" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Valor" type="xs:double" minOccurs="0" />'
	cString += '</xs:sequence>'
	cString += '</xs:complexType>'
	cString += '</xs:element>'
	cString += '<xs:element name="ItemNotaFiscal">'
	cString += '<xs:complexType>'
	cString += '<xs:sequence>'
	cString += '<xs:element name="CodEvento" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Serie" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Numero" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Data" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Item" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="CodProduto" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Tipo" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="CodBarra" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Descricao" type="xs:string" minOccurs="0" />'
	cString += '<xs:element name="Quantidade" type="xs:int" minOccurs="0" />'
	cString += '<xs:element name="PrcVenda" type="xs:double" minOccurs="0" />'
	cString += '<xs:element name="Total" type="xs:double" minOccurs="0" />'
	cString += '</xs:sequence>'
	cString += '</xs:complexType>'
	cString += '</xs:element>'
	cString += '</xs:choice>'
	cString += '</xs:complexType>'
	cString += '</xs:element>'
	cString += '</xs:schema>'   
	cString += '<Versao>'
	cString += '<CodVersao>0.01 20091028</CodVersao>'
	cString += '</Versao>'
	cString += '<Evento>'
	cString += '<CodEvento>'+ Alltrim(EVENTO->ZY0_CODEVE) +'</CodEvento>'
	cString += '<Nome>'+ Alltrim(EVENTO->ZY0_NOME) +'</Nome>'
	cString += '<Data>'+ dtos(EVENTO->ZY0_DATA) +'</Data>'
	cString += '</Evento>'
//NotaFiscal
	cQuery := "SELECT * FROM "+ RetSqlName("SF2") +" SF2, "+ RetSqlName("ZY1") +" ZY1 WHERE F2_FILIAL='"+ XFILIAL("SF2") +"' AND ZY1_FILIAL='"+ XFILIAL("ZY1") +"' AND  F2_SERIE=ZY1_SERIE AND F2_DOC=ZY1_DOC AND F2_EMISSAO=ZY1_EMISSA AND ZY1_CODEVE='"+ EVENTO->ZY1_CODEVE +"' AND SF2.D_E_L_E_T_<>'*' AND ZY1.D_E_L_E_T_<>'*'"
	TCQUERY cQuery NEW ALIAS "NOTA"
	TcSetField("NOTA","F2_EMISSAO"   ,"D")
	DbSelectArea("NOTA")
	DBGOTOP()
	WHILE !EOF() 
		cString += '<NotaFiscal>'
		cString += '<CodEvento>'+ Alltrim(cCodEvento) +'</CodEvento>'
		cString += '<Serie>'+ NOTA->F2_SERIE +'</Serie>'
		cString += '<Numero>'+ NOTA->F2_DOC +'</Numero>'
		cString += '<Data>'+ DTOS(NOTA->F2_EMISSAO) +'</Data>'
		cString += '<Vendedor1>'+ NOTA->F2_VEND1 +'</Vendedor1>'
		cString += '<Vendedor2>'+ NOTA->F2_VEND2 +'</Vendedor2>'
		cString += '<Vendedor3>'+ NOTA->F2_VEND3 +'</Vendedor3>'
		cString += '<Vendedor4>'+ NOTA->F2_VEND4 +'</Vendedor4>'
		cString += '<Vendedor5>'+ NOTA->F2_VEND5 +'</Vendedor5>'
		cString += '<Valor>'+ FormatNumber(NOTA->F2_VALBRUTO,"decimal") +'</Valor>'
		cString += '</NotaFiscal>'
		DbSelectArea("NOTA")
		DBSkip()
	END
	DbSelectArea("NOTA")
	DbCloseArea()

	//ItemNotaFiscal
	cQuery := "SELECT D2_SERIE, D2_DOC, D2_EMISSAO, D2_ITEM, B1_COD, B1_TIPO, B1_CODBAR, B1_DESC, D2_QUANT, D2_PRCVEN, D2_TOTAL FROM "+ RetSqlName("SD2") +" SD2, "+ RetSqlName("SB1") +" SB1, "+ RetSqlName("ZY1") +" ZY1 WHERE D2_FILIAL='"+ XFILIAL("SD2") +"' AND B1_FILIAL='"+ XFILIAL("SB1") +"' AND D2_COD=B1_COD AND AND ZY1_FILIAL='"+ XFILIAL("ZY1") +"' AND  D2_SERIE=ZY1_SERIE AND D2_DOC=ZY1_DOC AND D2_EMISSAO=ZY1_EMISSA AND ZY1_CODEVE='"+ EVENTO->ZY1_CODEVE +"' AND SD2.D_E_L_E_T_<>'*' AND SB1.D_E_L_E_T_<>'*' AND ZY1.D_E_L_E_T_<>'*'"
	TCQUERY cQuery NEW ALIAS "NOTASD2"
	TcSetField("NOTASD2","D2_EMISSAO"   ,"D")
	DbSelectArea("NOTASD2")
	DBGOTOP()
	WHILE !EOF() 
		cString += '<ItemNotaFiscal>'
		cString += '<CodEvento>'+ Alltrim(cCodEvento) +'</CodEvento>'
		cString += '<Serie>'+ NOTASD2->D2_SERIE +'</Serie>'
		cString += '<Numero>'+ NOTASD2->D2_DOC +'</Numero>'
		cString += '<Data>'+ DTOS(NOTASD2->D2_EMISSAO) +'</Data>'
		cString += '<Item>'+ NOTASD2->D2_ITEM +'</Item>'
		cString += '<CodProduto>'+ NOTASD2->B1_COD +'</CodProduto>'
		cString += '<Tipo>'+ NOTASD2->B1_TIPO +'</Tipo>'
		cString += '<CodBarra>'+ NOTASD2->B1_CODBAR +'</CodBarra>'
		cString += '<Descricao>'+ Alltrim(NOTASD2->B1_DESC) +'</Descricao>'
		cString += '<Quantidade>'+ FormatNumber(NOTASD2->D2_QUANT,"int") +'</Quantidade>'
		cString += '<PrcVenda>'+ FormatNumber(NOTASD2->D2_PRCVEN,"decimal") +'</PrcVenda>'
		cString += '<Total>'+ FormatNumber(NOTASD2->D2_TOTAL,"decimal") +'</Total>'
		cString += '</ItemNotaFiscal>'
		DbSelectArea("NOTASD2")
		DBSkip()
	END
	DbSelectArea("NOTASD2")
	DbCloseArea()

	cString += '</DSEvento>'
	MemoWrit("C:\DSEVENTO_"+ Alltrim(cCodEvento) +".xml",cString)
	MsgBox("Gerado arquivo C:\DSEVENTO_"+ Alltrim(cCodEvento) +".xml")
ELSE
	MsgBox("Evento "+ Alltrim(cCodEvento) +" nao localizado!")
ENDIF

DbSelectArea("EVENTO")
DbCloseArea()
Return       


Static Function XMLTag(cTag,cConteudo) //Exemplo: NfeTag('<Usuario>','Danilo'))
Local cRetorno := ""
If (!Empty(AllTrim(cConteudo)) .And. IsAlpha(AllTrim(cConteudo))) .Or. Val(AllTrim(cConteudo))<>0
	cRetorno := cTag+AllTrim(cConteudo)+SubStr(cTag,1,1)+"/"+SubStr(cTag,2)
EndIf
Return(cRetorno)

                  
Static Function ValSF2()
	cSerie := SF2->F2_SERIE
	cDoNumero := SF2->F2_DOC
	cAteNumero := SF2->F2_DOC
RETURN (.T.)


static FUNCTION FormatNumber(nNumero, cTipo)
Local cString := ""
if upper(cTipo) =="INT"
	cString := Alltrim(Transform(nNumero,"@E 999,999,999"))
else 
	cString := Alltrim(Transform(nNumero,"@E 999,999,999.99"))
endif
cString := Alltrim(StrTran(cString,".",""))
cString := Alltrim(StrTran(cString,",","."))
Return cString