#include "rwmake.ch"
#include "MSOle.Ch"
 
User Function EPFATR34()

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Declaracao de variaveis utilizadas no programa atraves da funcao    Ё
//Ё SetPrvt, que criara somente as variaveis definidas pelo usuario,    Ё
//Ё identificando as variaveis publicas do sistema utilizadas no codigo Ё
//Ё Incluido pelo assistente de conversao do AP5 IDE                    Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

SetPrvt("CARQUIVO,HWORD,PesqPict")
SetPrvt("c_Empresa, c_EndEmp, c_BairrEmp, c_CidEmp, c_UFEmp, c_CepEmp")
SetPrvt("c_TelEmp, c_CNPJEmp, c_IEEmp, c_NumNFSC, c_SerNFSC, d_EmiNFSC, c_HorNFSC")
SetPrvt("c_Cli, c_IECli, c_CNPJCli, c_EndCli, c_BairrCli, c_CepCli, c_TelCli")
SetPrvt("c_MunCli, c_UFCli, c_EndCobC, c_BairrCobC, c_CepCobC, c_MunCobC")
SetPrvt("c_UFCobC, c_Duplic, c_ValDup, c_VencDup, c_EmailCli, c_CodServ")
SetPrvt("c_Publ, c_DescrServ, c_Ins, c_Ed, c_Cst, c_Qtde, c_VlrUnit")
SetPrvt("c_VlrTotal, n_ValTotS, n_AliqIcms, n_ValIcms, n_DescAg, n_ValTotal")
SetPrvt("c_ChaveDig, n_Pedido, n_Contato, c_Obs, n_TotTrib")    
SetPrvt("c_Cliente, c_Loja, c_TpTrans, c_Agencia, c_Contato,_nCount, c_NomeAg")

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤└o    Ё EPFATR34 Ё Autor Ё Thiago Lima Dyonisio  Ё Data Ё 10.10.13 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤└o Ё ImpressЦo de NFSC - modelo 21    - VIA WORD ( MICROSIGA )  Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Editora PINI            	                                  Ё╠╠
╠╠цддддддддддеддддддддддддддддддддддддддддддддддддддддддбддддддбдддддддддд╢╠╠
╠╠Ё Revis└o  Ё                                          Ё Data Ё          Ё╠╠
╠╠юддддддддддаддддддддддддддддддддддддддддддддддддддддддаддддддадддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

//зддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Parametros usados na rotina                   Ё
//Ё mv_par01         NF de                        Ё
//Ё mv_par02         NF atИ                       Ё
//Ё mv_par03         SИrie da NF                  Ё
//юддддддддддддддддддддддддддддддддддддддддддддддды
                 
cPerg:="EPFATR34"
CriaSx1(cPerg)
Pergunte(cPerg,.F.)

@ 96,012 TO 250,400 DIALOG oDlg TITLE OemToAnsi("Integracao com MS-Word")
@ 08,005 TO 048,190
@ 18,010 SAY OemToAnsi("Esta rotina ira imprimir a Nota Fiscal de ServiГo de ComunicaГЦo - Modelo 21")

@ 56,100 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg,.T.)  
//@ 56,130 BMPBUTTON TYPE 1 ACTION WordImp()    
@ 56,130 BMPBUTTON TYPE 1 ACTION Processa({|| WordImp()},"Aguarde...")
@ 56,160 BMPBUTTON TYPE 2 ACTION Close(oDlg)

ACTIVATE DIALOG oDlg CENTERED

Return

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤└o    Ё WordImp  Ё Autor Ё Thiago Lima Dyonisio  Ё Data Ё 10.10.13 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤└o Ё ImpressЦo de NFSC - modelo 21    - VIA WORD ( MICROSIGA )  Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Editora PINI            	                                  Ё╠╠
╠╠цддддддддддеддддддддддддддддддддддддддддддддддддддддддбддддддбдддддддддд╢╠╠
╠╠Ё Revis└o  Ё                                          Ё Data Ё          Ё╠╠
╠╠юддддддддддаддддддддддддддддддддддддддддддддддддддддддаддддддадддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function WordImp()

//здддддддддддддддддддддддддддддддддддддд©
//Ё Busca as notas conforme parametro      Ё
//юдддддддддддддддддддддддддддддддддддддды

//novo**************************************************************************************************************************

	cQuery := " SELECT F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, F2_EMISSAO, F2_HORA, F2_VALBRUT, F2_DESCONT, F2_XCHNFSC "
	cQuery += " FROM "+RETSQLNAME("SF2")+" SF2, "
	cQuery += " WHERE F2_DOC BETWEEN '"+mv_par01+"' AND '"+mv_par02+"'  "
	cQuery += " AND SF2.F2_SERIE = '"+mv_par03+"' "
	cQuery += " AND SF2.D_E_L_E_T_ <> '*' " 
	cQuery += " ORDER BY F2_DOC " // novo

	cQuery := ChangeQuery(cQuery) 
	dbUseArea(.T., "TOPCONN", TCGenQry(, , cQuery), "NFS", .F., .T.) 

	nCont1 := 0
	Count To nCont1  
	
	dbSelectArea("NFS")                                                                                 
	dbGotop()

	While !NFS->(EOF())
    
//    Alert(F2_DOC+F2_SERIE)
//novo**************************************************************************************************************************



//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//ЁGuarda Dados da SF2
// Cliente e Loja       
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

c_Cliente := NFS->F2_CLIENTE 
c_Loja    := NFS->F2_LOJA  

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Busca Dados do Emitente e CabeГalho da NF                          Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

c_Empresa   := SM0->M0_NOME
c_EndEmp    := SM0->M0_ENDENT
c_BairrEmp  := SM0->M0_BAIRENT
c_CidEmp    := SM0->M0_CIDENT
c_UFEmp     := SM0->M0_ESTENT
c_CepEmp    := SM0->M0_CEPENT
c_TelEmp    := SM0->M0_TEL 
c_CNPJEmp   := SM0->M0_CGC
c_IEEmp     := SM0->M0_INSC  
c_NumNFSC	:= NFS->F2_DOC  
c_SerNFSC   := NFS->F2_SERIE
d_EmiNFSC   := NFS->F2_EMISSAO
c_HorNFSC   := NFS->F2_HORA

//здддддддддддддддддддддддддддддддддддддд©
//Ё Busca Dados do Cliente / Agencia     Ё
//юдддддддддддддддддддддддддддддддддддддды

dbSelectArea("SA1")
dbSetOrder(1)
dbSeek(xFilial()+c_Cliente+c_Loja)

c_Cli  		:= SA1->A1_NOME
c_IECli     := SA1->A1_INSCR
c_CNPJCli   := SA1->A1_CGC
c_EndCli    := SA1->A1_END
c_BairrCli  := SA1->A1_BAIRRO
c_CepCli    := SA1->A1_CEP
c_TelCli    := SA1->A1_TEL
c_MunCli    := SA1->A1_MUN
c_UFCli     := SA1->A1_EST

//здддддддддддддддддддддддддддддддддддддд©
//Ё Busca Dados de CobranГa              Ё
//юдддддддддддддддддддддддддддддддддддддды

dbSelectArea("SD2")
dbSetOrder(12)
dbSeek(xFilial()+c_NumNFSC+c_SerNFSC)

n_Pedido := SD2->D2_PEDIDO

	//здддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica se И Agencia ou Cliente     Ё
	//юдддддддддддддддддддддддддддддддддддддды
    
	dbSelectArea("SC5")
	dbSetOrder(1)
	dbSeek(xFilial()+n_Pedido)
	
	c_TpTrans := SC5->C5_TPTRANS
	c_Agencia := SC5->C5_CODAG    
	c_Contato := SC5->C5_VEND1       
	
	
	//здддддддддддддддддддддддддддддддддддддд©
	//Ё Busca Mensagem da Nota C5_MENNOTA    Ё
	//юдддддддддддддддддддддддддддддддддддддды

		c_Obs := SC5->C5_MENNOTA

		//зддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Se C5_TPTRANS = 04 OU 12, busca endereГo de entrega da agencia   Ё
		//юддддддддддддддддддддддддддддддддддддддддддды
	
		if c_TpTrans== "04" .or. c_TpTrans== "12"
		
		dbSelectArea("SA1")  //NOVO
		dbSetOrder(1)
		dbSeek(xFilial()+c_Agencia+"01")
		
			if SA1->A1_ENDCOB <> "S" 

			c_EndCobC    := SA1->A1_END
			c_BairrCobC  := SA1->A1_BAIRRO
			c_CepCobC    := SA1->A1_CEP
			c_MunCobC    := SA1->A1_MUN
			c_UFCobC     := SA1->A1_EST
       		
       		else //NOVO
       	
		   	dbSelectArea("SZ5")
			dbSetOrder(1)
			dbSeek(xFilial()+c_Agencia+"01") 
		
				c_EndCobC    := SZ5->Z5_END
				c_BairrCobC  := SZ5->Z5_BAIRRO
				c_CepCobC    := SZ5->Z5_CEP 
				c_MunCobC    := SZ5->Z5_CIDADE
				c_UFCobC     := SZ5->Z5_ESTADO                                        
	
	        endif
        
  		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//Ё Verifica SA1 A1_ENDCOB, SE FOR busca endereГo na SZ5, senЦo pega o endereГo padrЦo da SA1
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
       	else  
       	
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek(xFilial()+c_Cliente+c_Loja)
		
			if SA1->A1_ENDCOB <> "S" 

			c_EndCobC    := SA1->A1_END
			c_BairrCobC  := SA1->A1_BAIRRO
			c_CepCobC    := SA1->A1_CEP
			c_MunCobC    := SA1->A1_MUN
			c_UFCobC     := SA1->A1_EST
       		
       		else 
       		
			dbSelectArea("SZ5")
			dbSetOrder(1)
			dbSeek(xFilial()+c_Cliente+c_Loja) 
			
			c_EndCobC    := SZ5->Z5_END
			c_BairrCobC  := SZ5->Z5_BAIRRO
			c_CepCobC    := SZ5->Z5_CEP 
			c_MunCobC    := SZ5->Z5_CIDADE
			c_UFCobC     := SZ5->Z5_ESTADO        
        	
        	endif
        	 
        endif

//здддддддддддддддддддддддддддддддддддддд©
//Ё Busca Totais da Nota              Ё
//юдддддддддддддддддддддддддддддддддддддды

//dbSelectArea("SF2")
//dbSetOrder(10)                    
//dbSeek(xFilial()+F2_DOC+F2_SERIE)
                               
if c_TpTrans== "04" .or. c_TpTrans== "12"
	
	c_VlrTotal  := NFS->F2_VALBRUT+NFS->F2_DESCONT
	n_DescAg	:= c_VlrTotal * 0.2
	c_VlrTotal  := c_VlrTotal - n_DescAg
    
    Else        
    
    c_VlrTotal   := NFS->F2_VALBRUT+NFS->F2_DESCONT
    n_DescAg     := 0 
    
Endif

n_ValTotS   := NFS->F2_VALBRUT+NFS->F2_DESCONT
c_ChaveDig  := NFS->F2_XCHNFSC    
                                         

	//здддддддддддддддддддддддддддддддддддддд©
	//Ё Busca TМtulos a Receber  			 Ё
	//юдддддддддддддддддддддддддддддддддддддды
	cQuery := " SELECT E1_NUM, E1_PARCELA, E1_VALOR, E1_VENCREA"
	cQuery += " FROM "+RETSQLNAME("SE1")+" SE1, "
	cQuery += " WHERE E1_CLIENTE = '"+c_Cliente+"' AND E1_LOJA = '"+c_Loja+"' "
//	cQuery += " AND E1_PREFIXO   = '"+mv_par02+"' " 
	cQuery += " AND E1_PREFIXO   = '"+c_SerNFSC+"' "
	cQuery += " AND E1_NUM       = '"+c_NumNFSC+"' "
	cQuery += " AND SE1.D_E_L_E_T_ <> '*' "     
	cQuery += " ORDER BY E1_PARCELA "

	cQuery := ChangeQuery(cQuery) 
	dbUseArea(.T., "TOPCONN", TCGenQry(, , cQuery), "TITULOS", .F., .T.) 

	nCount1 := 0
	Count To nCount1
	dbSelectArea("TITULOS")                                                                                 
	dbGotop()
    
	//dbSelectArea("TITULOS")
	//While !TITULOS->(EOF()) 
	//	MsgInfo(TITULOS->E1_NUM)		
	//TITULOS->(dbSkip())  
	//End
/*	
	nCont := 0
	dbSelectArea("SE1")
	dbSetOrder(29)
	dbSeek(xFilial()+c_Cliente+c_Loja+MV_PAR02+MV_PAR01)
	    
		While !EOF()
			Alert(OemToAnsi(xFilial()+c_Cliente+c_Loja+MV_PAR02+MV_PAR01))
//			MsgInfo(⌠VocЙ estА no cliente:■ + A1_NOME)	
			nCount++        
			DbSkip()
		End                                
*/

	//здддддддддддддддддддддддддддддддддддддд©
	//Ё Busca Itens da NF 					 Ё
	//юдддддддддддддддддддддддддддддддддддддды    
//if c_TpTrans== "11" .or. c_TpTrans== "12".or. c_TpTrans== "13"

	cQuery := " SELECT D2_ITEM, D2_PEDIDO, D2_COD, D2_QUANT, D2_PRUNIT, D2_TOTAL, ZS_NUMAV, ZS_ITEM, ZS_NUMINS, ZS_VALOR, ZS_EDICAO, B1_DESC"
	cQuery += " FROM "+RETSQLNAME("SD2")+" SD2,"+RETSQLNAME("SZS")+" SZS,"+RETSQLNAME("SB1")+" SB1 " "
	cQuery += " WHERE D2_DOC = '"+c_NumNFSC+"' AND D2_SERIE = '"+c_SerNFSC+"' "
	cQuery += " AND D2_PEDIDO = ZS_NUMAV "
	cQuery += " AND D2_ITEMPV = ZS_ITEM " 
	cQuery += " AND D2_DOC = ZS_NFISCAL " //NOVO
	cQuery += " AND D2_SERIE = ZS_SERIE "//NOVO
	cQuery += " AND D2_COD = B1_COD "      
	cQuery += " AND SD2.D_E_L_E_T_ <> '*' "
	cQuery += " AND SZS.D_E_L_E_T_ <> '*' " 
	cQuery += " ORDER BY D2_ITEM "    
                                           
	cQuery := ChangeQuery(cQuery) 
	dbUseArea(.T., "TOPCONN", TCGenQry(, , cQuery), "RST", .F., .T.) 
    
	nCount := 0
	Count To nCount
	dbSelectArea("RST")                                                                                 
	dbGotop()
//ENDIF
//If MsgYesNo("Procura arquivo")
//	cArquivo := cGetFile("Documentos  (*.DO*)        | *.DO* | ",;
//	"Dialogo de Selecao de Arquivos",,,.f.)
//Else
	cArquivo := "C:\Temp\nfsc.dotm" 
//   	cArquivo := "\SYSTEM\Modelos\\NFSC.DOT"
//Endif
                    
//зддддддддддддддд©
//Ё Inicia o Word Ё
//юддддддддддддддды  

hWord := OLE_CreateLink()

//SETA PROPRIEDADES

//OLE_SetPropertie( hWord, oleWdPrintBack, .F.)
OLE_SetProperty( hWord, oleWdPrintBack	 , .T.)
//OLE_SetPropertie( hWord, oleWdVisible, .T.) 
OLE_SetProperty( hWord, oleWdVisible	 , .F.) 
OLE_SetProperty( hWord, '208'            , .F.)
OLE_NewFile(hWord, cArquivo)       

// INSERE DADOS DO EMITENTE E DO CABEгALHO NAS VARIаVEIS DO WORD

OLE_SetDocumentVar(hWord, "EPNOME"    , c_Empresa)
OLE_SetDocumentVar(hWord, "EPEND"     , c_EndEmp)
OLE_SetDocumentVar(hWord, "EPBAIRRO"  , c_BairrEmp)
OLE_SetDocumentVar(hWord, "EPCIDADE"  , c_CidEmp)
OLE_SetDocumentVar(hWord, "EPUF"      , c_UFEmp)
OLE_SetDocumentVar(hWord, "EPCEP"     , c_CepEmp)
OLE_SetDocumentVar(hWord, "EPTEL"     , c_TelEmp)
//OLE_SetDocumentVar(hWord, "EPCNPJ"    , c_CNPJEmp)
OLE_SetDocumentVar(hWord, 'EPCNPJ'    , Transform(c_CNPJEmp,"@R 99.999.999/9999-99"))
OLE_SetDocumentVar(hWord, "EPIE"      , c_IEEmp)
OLE_SetDocumentVar(hWord, "NUMNFSC"   , c_NumNFSC)
OLE_SetDocumentVar(hWord, "SERNFSC"   , c_SerNFSC)
OLE_SetDocumentVar(hWord, "DTEMISSAO" , STOD(d_EmiNFSC))
OLE_SetDocumentVar(hWord, "HREMISSAO" , c_HorNFSC) 

// INSERE DADOS DO CLIENTE NAS VARIаVEIS DO WORD

OLE_SetDocumentVar(hWord, "CRAZAO"    , c_Cli)
OLE_SetDocumentVar(hWord, "CIE"       , c_IECli)
//OLE_SetDocumentVar(hWord, "CCNPJ"     , c_CNPJCli)
OLE_SetDocumentVar(hWord, 'CCNPJ'    , Transform(c_CNPJCli,"@R 99.999.999/9999-99"))
OLE_SetDocumentVar(hWord, "CEND"      , c_EndCli)
OLE_SetDocumentVar(hWord, "CBAIRRO"   , c_BairrCli)
OLE_SetDocumentVar(hWord, "CCEP"      , c_CepCli)
OLE_SetDocumentVar(hWord, "CTEL"      , c_TelCli)
OLE_SetDocumentVar(hWord, "CCIDADE"   , c_MunCli)
OLE_SetDocumentVar(hWord, "CUF"       , c_UFCli)

// INSERE DADOS DE ENDEREгO DE COBRANгA NAS VARIаVEIS DO WORD

OLE_SetDocumentVar(hWord, "CENDCOB"   , c_EndCobC)
OLE_SetDocumentVar(hWord, "CBAIRRCOB" , c_BairrCobC)
OLE_SetDocumentVar(hWord, "CCEPCOB"   , c_CepCobC)
OLE_SetDocumentVar(hWord, "CMUNCOB"   , c_MunCobC)
OLE_SetDocumentVar(hWord, "CUFCOB"    , c_UFCobC)

// INSERE TOTAIS DA NOTA NAS VARIаVEIS DO WORD

OLE_SetDocumentVar(hWord, "CHAVE"     , c_ChaveDig)   
OLE_SetDocumentVar(hWord, "PEDIDO"    , n_Pedido)  
OLE_SetDocumentVar(hWord, "CONTATO"   , c_Contato) 
OLE_SetDocumentVar(hWord, "OBS"       , c_Obs)  
OLE_SetDocumentVar(hWord,"VALTOTSERV" ,"R$ "+Transform(n_ValTotS,"@E 99,999,999.99"))
OLE_SetDocumentVar(hWord,"DESCAG" ,"R$ "+Transform(n_DescAg,"@E 99,999,999.99"))
OLE_SetDocumentVar(hWord,"VALTOTNF" ,"R$ "+Transform(c_VlrTotal,"@E 99,999,999.99"))
OLE_UpdateFields(hWord)	// Atualizando as variaveis do documento do Word
OLE_SetDocumentVar(hWord, 'faturas_nro',str(nCount1))	//variavel para identificar o numero total de linhas na parte variavel                  
OLE_SetDocumentVar(hWord, 'Prt_nroitens',str(nCount))	//variavel para identificar o numero total de linhas na parte variavel  

if c_TpTrans== "04" .or. c_TpTrans== "05".or. c_TpTrans== "12".or. c_TpTrans== "13"
         
		dbSelectArea("SA1")  //NOVO
		dbSetOrder(1)
		dbSeek(xFilial()+c_Agencia+"01")
		
		c_NomeAg := SA1->A1_NOME
		
		OLE_SetDocumentVar(hWord, "NOMEAGENCIA", c_NomeAg)

	else

		OLE_SetDocumentVar(hWord, "NOMEAGENCIA", " ")

endif

        

// INSERE FATURAS NA NF                     

_nCount1 := 1
	dbSelectArea("TITULOS")
	
	While !TITULOS->(EOF())
    
    	OLE_SetDocumentVar(hWord,"faturas_num"+AllTrim(Str(_nCount1)),TITULOS->E1_NUM+" - "+E1_PARCELA)
    	OLE_SetDocumentVar(hWord,"faturas_valor"+AllTrim(Str(_nCount1)),"R$ "+Transform(TITULOS->E1_VALOR,"@E 99,999,999.99")) 
    	OLE_SetDocumentVar(hWord,"faturas_venc"+AllTrim(Str(_nCount1)),STOD(TITULOS->E1_VENCREA))
    
    _nCount1++	
    
    dbSelectArea("TITULOS")
	TITULOS->(dbSkip())
	
	EndDo  
	
OLE_UpdateFields( hWord )   
OLE_ExecuteMacro(hWord,"FATURAS")	

dbCloseArea("TITULOS")	          
	
// INSERE ITENS NA NF

// VERIFICA SE и FATURAMENTO PROGRAMADO

if c_TpTrans== "11" .or. c_TpTrans== "12".or. c_TpTrans== "13"
		
		If Select("RST") > 0
			RST->(DbCloseArea())
		EndIf
		
		dbSelectArea("SZV")
		dbSetOrder(2)
        dbSeek(xFilial()+c_NumNFSC)
        
        _cParcela := SZV->ZV_NPARC
		
		OLE_SetDocumentVar(hWord,"CAMPANHA"   , "PARCELA "+AllTrim(Str(_cParcela))+", REF. CAMPANHA PUBLICITаRIA PINI  ") 
		OLE_SetDocumentVar(hWord,"TOTALCAMP"  , "R$ "+Transform(n_ValTotS,"@E 99,999,999.99"))

		
		dbCloseArea("SZV")
   
else
		OLE_SetDocumentVar(hWord, "CAMPANHA" , " ")	
		OLE_SetDocumentVar(hWord, "TOTALCAMP", " ")
		
		_nCount := 1
		dbSelectArea("RST")
	    
		While !RST->(EOF())    
		    
			nItem := RST->D2_ITEM
			nCount2 := 0 

			dbSelectArea("SZS")
			dbSetOrder(6)
           		
			dbSeek(xFilial()+n_Pedido+nItem) 
  						
			While !EOF() 
				if  SZS->ZS_NUMAV = n_Pedido .AND. SZS->ZS_ITEM = nItem
				nCount2++ 
				ENDIF
			DbSkip()
			Enddo
									
    	dbSelectArea("RST")
    	        	    
    	OLE_SetDocumentVar(hWord,"prt_nroitens1"+AllTrim(Str(_nCount)),Transform(RST->D2_ITEM,"@E 9999"))
    	OLE_SetDocumentVar(hWord,"Prt_qtde"+AllTrim(Str(_nCount)),RST->D2_QUANT)
    	OLE_SetDocumentVar(hWord,"Prt_codprod"+AllTrim(Str(_nCount)),RST->D2_COD)	
   		OLE_SetDocumentVar(hWord,"Prt_desc"+AllTrim(Str(_nCount)),RST->B1_DESC)
   		OLE_SetDocumentVar(hWord,"Prt_ins"+AllTrim(Str(_nCount)),AllTrim(Str(RST->ZS_NUMINS))+" / "+AllTrim(Str(nCount2)))
 		OLE_SetDocumentVar(hWord,"Prt_edt"+AllTrim(Str(_nCount)),RST->ZS_EDICAO)
   		OLE_SetDocumentVar(hWord,"Prt_cst"+AllTrim(Str(_nCount)),"04")
   		OLE_SetDocumentVar(hWord,"Prt_prunit"+AllTrim(Str(_nCount)),"R$ "+Transform(RST->ZS_VALOR,"@E 99,999,999.99"))
   		OLE_SetDocumentVar(hWord,"Prt_total"+AllTrim(Str(_nCount)),"R$ "+Transform(RST->ZS_VALOR,"@E 99,999,999.99"))

  		_nCount++
		
    	dbSelectArea("RST")
		RST->(dbSkip())
		
		EndDo               
		
		OLE_ExecuteMacro(hWord,"NFSC")	
		dbCloseArea("RST") 
		dbCloseArea("SZS")   
		
endif

OLE_UpdateFields( hWord )   
	                        
// VALOR APROXIMADO DOS TRIBUTOS
    
	n_TotTrib := ((n_ValTotS * 9.25)/100)
	OLE_SetDocumentVar(hWord, "VALAPROTRIB"     , "VALOR APROXIMADO DOS TRIBUTOS: R$ " +alltrim(Transform(n_TotTrib,"@R 999,999,999.99"))+" (9.25%) FONTE: IBPT.")

OLE_UpdateFields( hWord )     	
	
//If MsgYesNo("Imprime o Documento ?")
	
	OLE_PrintFile( hWord )

//EndIf

//NOVO**************************************************************************************************************************
	dbSelectArea("NFS")
	NFS->(dbSkip())

	EndDo               
    
	dbCloseArea("NFS")

//	dbCloseArea("RST")
//NOVO**************************************************************************************************************************


//здддддддддддддддд©
//Ё Qtde de Copias Ё
//юдддддддддддддддды

//If MsgYesNo("Fecha o Word e Corta o Link ?")
	OLE_CloseFile( hWord )
	OLE_CloseLink( hWord )
//Endif

	Close(oDlg)

Return

//здддддддддддддддд©
//Ё Cria SX1       Ё
//юдддддддддддддддды

Static Function CriaSx1()                 

PutSx1(cPerg,"01","Nota Fiscal de: "  , "", "", "mv_ch1","C",09,0,0,"G","", "", "", "", "mv_par01",""        , "", "", ""        , "", "", ""     , "", "", "", "", "", "", "", "", "", {"", "", "", ""}, {"", "", "", ""}, {"", "", ""}, "")
PutSx1(cPerg,"02","Nota Fiscal atИ:"  , "", "", "mv_ch2","C",09,0,0,"G","", "", "", "", "mv_par02",""        , "", "", ""        , "", "", ""     , "", "", "", "", "", "", "", "", "", {"", "", "", ""}, {"", "", "", ""}, {"", "", ""}, "")
PutSx1(cPerg,"03","SИrie?"  , "", "", "mv_ch3","C",03,0,0,"G","", "", "", "", "mv_par03",""        , "", "", ""        , "", "", ""     , "", "", "", "", "", "", "", "", "", {"", "", "", ""}, {"", "", "", ""}, {"", "", ""}, "")


Return 
