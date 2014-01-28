#include "rwmake.ch" 
/*/     
//Alterado por Danilo C S Pala em 20060315: dados de enderecamento para DNE
//Alterado por Danilo C S Pala em 20060322: nao considerar remessas ao Exterior 
//Alterado por Danilo/Fabiana em 20061023: avarias e codigo de assinatura
//Alterado por Danilo/Fabiana em 20070124: excluir senais
//Alterado por Danilo/Fabiana em 20070627: limitar quantidade apenas para Equipe de Obra
//Alterado por Danilo C S Pala em 20080404: pasta SIGA e nao mais SIGAADV
//Alterado por Danilo C S Pala em 20080619: consistencia endereco
//Alterado por Danilo C S Pala em 20080925: ENTREGA PROTOCOLADA
//Alterado por Danilo C S Pala em 20081010: DICA DE ENTREGA
//Alterado por Danilo C S Pala em 20090414: novo codigo de produto, agora com 5 digitos
//Alterado por Danilo C S Pala em 20100427: 16h
//Alterado por Danilo C S Pala em 20110110: 9912242993 novo numero de contrato //9912222431
//Alterado por Danilo C S Pala em 20110304: novos cod adm e num cart
//Alterado por Danilo C S Pala em 20110523: Anuario: 0131/ Infra: 0132
//Alterado por Danilo C S Pala em 20130618: novo numero de contrato e cartao
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT164   ³Autor: Danilo C S Pala        ³ Data:   20060214 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera arquivo para DNE, COM BASE NO ARQUIVO GERADO PELO RFAT112 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function PFAT164() 
setprvt("_aCampos, _cNome, cIndex, cKey, cArq")
setprvt("_aCamp2, _cNome2, cArq2")
setprvt("_aCamp3, _cNome3, cArq3")
setprvt("_aCamp4, _cNome4, cArq4")
setprvt("_aCamp6, _cNome6, cArq6")
setprvt("mhora, mdata, mdataEnt, ncontUF, ncontTotal")
setprvt("cRevista, cEdicao, cSiglaRev")
setprvt("npeso, nlargura, naltura, ncomprimento, cFonte, nqtdper, mdtentrega, MtpPER")
setprvt("nAvarias, nPiniProd, cMsgStop, MPROTOCOLO, cDicaEntrega,mhora")

Programa   := "PFAT164"
MHORA      := TIME()
mdata	   := dtos(date()) //20060214
mdata 	   := subs(mdata,7,2) + "-" + subs(mdata,5,2) +"-" + subs(mdata,1,4)+" 00:00"
cString    := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)         
mdtentrega := date()   
MPROTOCOLO := "N" //20080925
cDicaEntrega :=  space(60) //20081010
     
cArq	   := "FONTE"
cArq2      := "DETALHE2"
cArq3 	   := "DETALHE3"
cArq4 	   := "DETALHE4"
cArq6 	   := "DETALHE6"

nPiniProd:=space(2)
nAvarias:=space(10)

//header
private HTPREG := 1
private HTPARQ := "P"
private HCODEDIT := 27448
private HCODADM := 12219363 //8242135 //04101146 //20110304 //20130618
private HQTDPROT := 0
private HNUMCART := 66082013 //66079535 //61389447 //5034329 //20110304 //20130618
private HNUMLOTE := 1000
private HCODUN := "72900890    "
private HNUMCONT := 9912299632 //9912222431 //7231994123 20110110 //20130618
					   9912299632
private HCODSERV := 31
private HESPECSERV := 100
private HDTGER := mdata+":00"
private HDTENT := mdata
private HVERSAO := "01.00.21"


//FOOTER
private FTPREG := 7
private FQTDREG := 0
private FPESOTOT := 0
private FUNPESO := "2"
 
FArqTrab()

//TELA
_cTitulo  := "Gerar Arquivo para Correios Entrega Direta"
_ccMens1  := "Fonte: \siga\etiquetas\[arquivo].[txt]"
cMsgFinal := space(200)
cRevista  := ""
cEdicao   := "100"
cSiglaRev := "CMO"
npeso  	  := 500
nlargura  := 270
naltura	  := 21
ncomprimento := 300
cFonte	  := space(80)
Private aItens := {"3610 AUR","3611 CMO","3630 TEC","4190 EOA","15136GDC","15356CG ","19196API","18056IFU"}

@ 010,001 TO 230,350 DIALOG oDlg TITLE _cTitulo
@ 010,005 SAY "Revista"
//@ 010,040 GET cRevista
@ 010,40 COMBOBOX cRevista ITEMS aItens SIZE 80,30
@ 010,130 SAY "Lote"
@ 010,150 GET HNUMLOTE
@ 025,005 SAY "Edição"
@ 025,040 GET cEdicao                                                     
@ 025,070 SAY "Peso(g)"
@ 025,100 GET npeso
@ 040,005 SAY "Largura(cm)"
@ 040,040 GET nLargura
@ 040,070 SAY "Altura(cm)"
@ 040,100 GET nAltura
@ 040,120 SAY "Compr(cm)"
@ 040,150 GET nComprimento
@ 055,005 SAY "Data Entrega"
@ 055,040 GET mdtentrega size 40,12
@ 055,100 SAY "Avaria"
@ 055,120 GET nAvarias
@ 070,005 SAY _ccMens1
@ 080,005 GET cFonte
cFonte	  := space(40)
@ 095,005 BUTTON "Gerar Arquivo" SIZE 40,12 ACTION Processa({||ProcArq()})
@ 095,070 BUTTON "Fechar" SIZE 40,12 ACTION ( Close(oDlg) )
Activate Dialog oDlg CENTERED
      
//fechar os arquivos
DBselectArea("FONTE")
DBCloseArea("FONTE")
DBselectArea("ESTADO")
DBCloseArea("ESTADO")
DBselectArea(cArq3)
DBCloseArea(cArq3)
DBselectArea(cArq4)
DBCloseArea(cArq4)
DBselectArea("ETIQ")
DBCloseArea("ETIQ")


Return    



//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ FARQTRAB()                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Cria arquivos de trabalhos 									  ³
//³           ³                               								  ³
//³           ³ 															  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function FARQTRAB()

//DETALHE 2: QTD POR UF
_aCamp2 := {}
AADD(_aCamp2,{"D2TPREG","N",1,0})
AADD(_aCamp2,{"D2UF","C",2,0})
AADD(_aCamp2,{"D2QTD","N",10,0})

_cNome2 := CriaTrab(_aCamp2,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "D2UF"
dbUseArea(.T.,, _cNome2,"ESTADO",.F.,.F.)

dbSelectArea("ESTADO")
Indregua("ESTADO",cIndex,ckey,,,"Selecionando Registros do Arq")



//DETALHE 3: PERIODICOS
_aCamp3 := {}
AADD(_aCamp3,{"D3TPREG","C",1,0})
AADD(_aCamp3,{"D3CODTIT","N",10,0})
AADD(_aCamp3,{"D3IDPER","C",5,0})
AADD(_aCamp3,{"D3EDIC","N",10,0})
AADD(_aCamp3,{"D3TPPER","C",4,0})
AADD(_aCamp3,{"D3PESO","N",5,0})
AADD(_aCamp3,{"D3UNPESO","C",1,0})
AADD(_aCamp3,{"D3LARG","N",8,0})
AADD(_aCamp3,{"D3ALT","N",8,0})
AADD(_aCamp3,{"D3COMP","N",8,0})
AADD(_aCamp3,{"D3UNDIM","C",1,0})
AADD(_aCamp3,{"D3QTDOBJ","N",4,0})
AADD(_aCamp3,{"D3QTDTOT","N",10,0})

_cNome3 := CriaTrab(_aCamp3,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "D3CODTIT"
dbUseArea(.T.,, _cNome3,cArq3,.F.,.F.)
dbSelectArea(cArq3)
Indregua(cArq3,cIndex,ckey,,,"Selecionando Registros do Arq")




//DETALHE 4: ENCARTES
_aCamp4 := {}
AADD(_aCamp4,{"D4TPREG","C",1,0})
AADD(_aCamp4,{"D4SEQ","N",4,0})
AADD(_aCamp4,{"D4DESCR","C",60,0})
AADD(_aCamp4,{"D4CODSER","N",5,0})
AADD(_aCamp4,{"D4ESPECS","N",5,0})
AADD(_aCamp4,{"D4PESO","N",5,0})
AADD(_aCamp4,{"D4UNPESO","C",1,0})
AADD(_aCamp4,{"D4LARG","N",8,0})
AADD(_aCamp4,{"D4ALT","N",8,0})
AADD(_aCamp4,{"D4COMP","N",8,0})
AADD(_aCamp4,{"D4UNDIM","C",1,0})
AADD(_aCamp4,{"D4TPUN","C",1,0})
AADD(_aCamp4,{"D4TIT","N",10,0})
AADD(_aCamp4,{"D4EDIC","N",10,0})
AADD(_aCamp4,{"D4PAG","N",5,0})
AADD(_aCamp4,{"D4IDPER","C",4,0})
AADD(_aCamp4,{"D4QTDTOT","N",10,0})

_cNome4 := CriaTrab(_aCamp4,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "D4SEQ"
dbUseArea(.T.,, _cNome4,cArq4,.F.,.F.)
dbSelectArea(cArq4)
Indregua(cArq4,cIndex,ckey,,,"Selecionando Registros do Arq")




//DETALHE 6: ETIQUETAS
_aCamp6 := {}
AADD(_aCamp6,{"D6TPREG","C",1,0})
AADD(_aCamp6,{"D6SEQ","N",10,0})
AADD(_aCamp6,{"D6CODTIT","N",10,0})
AADD(_aCamp6,{"D6EDIC","N",10,0})
AADD(_aCamp6,{"D6TPPER","C",4,0})
AADD(_aCamp6,{"D6IPROM","C",20,0})
AADD(_aCamp6,{"D6IBRIM","C",20,0})
AADD(_aCamp6,{"D6ICAT","C",20,0})
AADD(_aCamp6,{"D6CODASS","C",20,0})
AADD(_aCamp6,{"D6ASS","C",20,0})
AADD(_aCamp6,{"D6NOME","C",60,0})
AADD(_aCamp6,{"D6CONTAT","C",60,0})
AADD(_aCamp6,{"D6LOGR","C",60,0})
AADD(_aCamp6,{"D6TPLOGR","C",15,0})
AADD(_aCamp6,{"D6COMPL","C",40,0})
AADD(_aCamp6,{"D6NUMLOG","C",10,0})
AADD(_aCamp6,{"D6BAIRRO","C",60,0})
AADD(_aCamp6,{"D6CEP","C",8,0})
AADD(_aCamp6,{"D6CIDADE","C",70,0})
AADD(_aCamp6,{"D6UF","C",2,0})
AADD(_aCamp6,{"D6REF","C",40,0})
AADD(_aCamp6,{"D6COMER","C",1,0})
AADD(_aCamp6,{"D6QTDREC","N",5,0})
AADD(_aCamp6,{"D6PROCON","C",1,0})
AADD(_aCamp6,{"D6SEQREC","N",2,0})
AADD(_aCamp6,{"D6PRIM","C",1,0})
AADD(_aCamp6,{"D6PROTOC","C",1,0})
AADD(_aCamp6,{"D6DICA","C",60,0})
AADD(_aCamp6,{"D6DISTR","C",4,0})
AADD(_aCamp6,{"D6PERCOR","C",4,0})
AADD(_aCamp6,{"D6UNDIST","C",12,0})
AADD(_aCamp6,{"D6QTDPER","N",7,0})
AADD(_aCamp6,{"D6PACOTE","C",1,0})

_cNome6 := CriaTrab(_aCamp6,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "D6SEQ"
dbUseArea(.T.,, _cNome6,"ETIQ",.F.,.F.)
dbSelectArea("ETIQ")
Indregua("ETIQ",cIndex,ckey,,,"Selecionando Registros do Arq")
           


_aCampos := {  {"NUMPED"  ,"C",6 ,0} ,;
{"ITEM"    ,"C",2 ,0} ,;
{"CODCLI"  ,"C",6 ,0} ,;
{"PORTE"   ,"C",2 ,0} ,;
{"CODDEST" ,"C",6 ,0} ,;
{"NOME"    ,"C",40,0} ,;
{"DEST"    ,"C",40,0} ,;
{"V_END"   ,"C",40,0} ,;
{"BAIRRO"  ,"C",20,0} ,;
{"MUN"     ,"C",20,0} ,;
{"CEP"     ,"C",8 ,0} ,;
{"EST"     ,"C",2 ,2} ,;
{"FONE"    ,"C",15,0},;
{"COMPL"   ,"C",30,0},;
{"TESP"     ,"C",3 ,0},; 
{"QTD"     ,"N",5 ,0},;
{"TPLOG"   ,"C",15 ,0},;    //20060315 Danilo
{"LOGR"    ,"C",60 ,0},;    //20060315 Danilo
{"NLOGR"   ,"C",10 ,0},;    //20060315 Danilo
{"CLOGR"   ,"C",40 ,0},;    //20060315 Danilo
{"TPPER"   ,"C",4 ,0}}      //20060406


_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "EST+NUMPED+ITEM"
dbUseArea(.T.,, _cNome,"FONTE",.F.,.F.)
dbSelectArea("FONTE")
Indregua("FONTE",cIndex,ckey,,,"Selecionando Registros do Arq")

Return


//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ ProcArq()                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ funcao que le o arquivo passado e gera txt conforme o layout  ³
//³           ³ dos correios                  								  ³
//³           ³ 															  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function ProcArq()
    private auxUF := space(2)
	ncontUF    := 0              
	ncontTOTAL := 0    
	nqtdper	   := 0
	cSiglaRev  := substr(cRevista,6,3) //20090414
	cRevista   := alltrim(substr(cRevista,1,5)) //20090414
	mdataEnt   := dtos(mDtEntrega)
	mdataEnt   := subs(mdataEnt,7,2) + "-" + subs(mdataEnt,5,2) +"-" + subs(mdataEnt,1,4)+" 16:00" //20090313 10h //20100427 16h
	HDTENT	   := mdataEnt
	MTPPER 	   := SPACE(4)
	if cRevista=="3610"
    	nPiniProd:="24" //au
   	elseif cRevista=="3611"
    	nPiniProd:="15" //cm + guia
    elseif cRevista=="3630"
    	nPiniProd:="16" //te
    elseif cRevista=="4190"
    	nPiniProd:="25" //eo
    elseif cRevista=="15136"
    	nPiniProd:="27" //guia
   	elseif cRevista=="15356"
    	nPiniProd:="28" //cm - guia
  	elseif cRevista=="19196"
    	nPiniProd:="31" //anuario
   	elseif cRevista=="18056"
    	nPiniProd:="32" //infra
	Endif    
	
	
	DBSELECTAREA("FONTE")
	cpath := "\SIGA\ETIQUETAS\"+ cFonte
	bBloco := "APPEND FROM &cpath SDF"
	APPEND FROM &cpath SDF
	MsAguarde({|| bBloco},"Apendando arquivo de etiquetas...")
	MSUNLOCK()
	DBGOTOP()

	While !Eof()
		if alltrim(FONTE->TPLOG)=="" .and. alltrim(FONTE->LOGR)=="" .and. alltrim(FONTE->NLOGR)=="" .and. alltrim(FONTE->CLOGR)=="" //20080619 daqui
			cMsgStop := "ATENCAO!"+CHR(10)+CHR(13)
			cMsgStop += "INCONSISTENCIA DE ENDERECO"+CHR(10)+CHR(13)
			cMsgStop += "PEDIDO: " +FONTE->NUMPED +"   ITEM: "+FONTE->ITEM+ "  CLIENTE: " + FONTE->CODCLI +CHR(10)+CHR(13)
			MsgStop(OemToAnsi(cMsgStop),"ALERTA")
			MsgStop("ATUALIZE OS ENDERECOS, DEPOIS GERE NOVAMENTE O ARQUIVO DE ETIQUETAS","PROCESSAMENTO ABORTADO")
			Return
		endif //20080619 ate aqui
		
		if (FONTE->EST <> "  " .and. FONTE->EST <> "EX") .and. ((nPiniProd="25" .and. FONTE->QTD <=2) .or. nPiniProd<>"25")     //20070124: qtd para excluir os senais //20070627: limite de quantidades apenas para Equipe de Obra
		
			if auxUF <> FONTE->EST .and. auxUF <> "  "
				//inserir estado
				InserirEstado()
				//zerar contador de estado
				ncontUF := 0
			endif                 
			
			//20080925 ENTREGA PROTOCOLADA
			DBSELECTAREA("SZK")
			IF DBSEEK(XFILIAL("SZK")+FONTE->NUMPED)
		      IF TRIM(SZK->ZK_OBS) =="ENTREGA PROTOCOLADA"
		      	MPROTOCOLO := "S"
		      ELSE 
		      	MPROTOCOLO := "N"
		      ENDIF
		    ELSE
		      MPROTOCOLO := "N"
		    ENDIF
			// ATE AQUI 20080925
			
			//20081010 DICA DE ENTREGA
			DBSELECTAREA("SC6")                   
			DBSETORDER(1)
			IF DBSEEK(XFILIAL("SC6")+FONTE->NUMPED+FONTE->ITEM)
		      IF !EMPTY(TRIM(SC6->C6_OBSDIST))
		      	cDicaEntrega := SC6->C6_OBSDIST
		      ELSE 
		      	cDicaEntrega := space(60)
		      ENDIF
		    ELSE
		      cDicaEntrega := space(60)
		    ENDIF 
		    //ATE AQUI 20081010			
			InserirEtiqueta()
			auxUF := FONTE->EST
			ncontUF := ncontUF + nqtdper // 20060317 era  + 1
			ncontTOTAL := ncontTOTAL + nqtdper // 20060317 era  + 1
		endif
			
		dbselectarea("FONTE")
		dbskip()
	End  
//	if FONTE->EST <> "  " .and. FONTE->EST <> "EX" 20060406
		InserirEstado()      
//	end if 20060406
	InserirPeriodico()
	FQTDREG  := ncontTOTAL
	FPESOTOT :=	(npeso * ncontTOTAL)/1000
	ImprimirArq()
	msgInfo("Total de objetos:"+ str(ncontTOTAL) + chr(10)+Chr(13)+"Processamento concluido!")
Return




//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ InserirEstado()                                               ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ funcao que insere um estado com o contador                    ³
//³           ³                               								  ³
//³           ³ 															  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function InserirEstado()
	DbSelectArea("ESTADO")
	RecLock("ESTADO",.T.)
		Replace D2TPREG with 2
		Replace D2UF with auxUF
		Replace D2QTD with ncontUF
	MsUnlock()  
Return




//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ InserirPeriodico()                                            ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ funcao que insere um PRODUTO                                  ³
//³           ³                               								  ³
//³           ³ 															  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function InserirPeriodico()
	DbSelectArea(cArq3)
	RecLock(cArq3,.T.)
		Replace D3TPREG  with "3"
		Replace D3CODTIT with val(cRevista)
		Replace D3IDPER  with cSiglaRev
		Replace D3EDIC   with val(cEdicao)
		Replace D3TPPER  with MTPPER
		Replace D3PESO   with npeso
		Replace D3UNPESO with "1"
		Replace D3LARG   with (nLargura)
		Replace D3ALT    with (nAltura)
		Replace D3COMP   with (nComprimento)
		Replace D3UNDIM  with "5"
		Replace D3QTDOBJ with 0
		Replace D3QTDTOT with ncontTOTAL
	MsUnlock()  
Return




//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ InserirEtiqueta()                                             ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ funcao que insere uma etiqueta                                ³
//³           ³                               								  ³
//³           ³ 															  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function InserirEtiqueta()
	DbSelectArea("ETIQ")
	RecLock("ETIQ",.T.)
		Replace D6TPREG   with  "6"
		Replace D6SEQ     with ncontTOTAL + 1
		Replace D6CODTIT  with val(cRevista)
		Replace D6EDIC    with val(cEdicao)
		Replace D6TPPER   with FONTE->TPPER //20060406
		Replace D6IPROM   with space(20)
		Replace D6IBRIM   with space(20)
		Replace D6ICAT    with space(20)
		Replace D6CODASS  with FONTE->NUMPED + nPiniProd + FONTE->ITEM
		Replace D6ASS     with "P" +FONTE->CODCLI
		Replace D6NOME    with alltrim(FONTE->NOME)
		Replace D6CONTAT  with alltrim(FONTE->DEST)
		Replace D6LOGR    with alltrim(FONTE->LOGR)
		Replace D6TPLOGR  with alltrim(FONTE->TPLOG)
		Replace D6COMPL   with alltrim(FONTE->CLOGR)
		Replace D6NUMLOG  with alltrim(FONTE->NLOGR)
		Replace D6BAIRRO  with alltrim(FONTE->BAIRRO)
		Replace D6CEP     with alltrim(FONTE->CEP)
		Replace D6CIDADE  with alltrim(FONTE->MUN)
		Replace D6UF      with alltrim(FONTE->EST)
		Replace D6REF     with SPACE(40)
		Replace D6COMER   with "N"
		Replace D6QTDREC  with 0
		Replace D6PROCON  with "N"
		Replace D6SEQREC  with 0
		Replace D6PRIM    with "N"
		Replace D6PROTOC  with MPROTOCOLO // 20080925 "N"
		Replace D6DICA    with cDicaEntrega //20081010 SPACE(60)
		Replace D6DISTR   with SPACE(4)
		Replace D6PERCOR  with SPACE(4)
		Replace D6UNDIST  with SPACE(12)
		Replace D6QTDPER  with FONTE->QTD
		Replace D6PACOTE  with " "
	MsUnlock()  
		nqtdper := FONTE->QTD    
		MTPPER := FONTE->TPPER
Return




//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ ImprimirArq()                                                 ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ funcao que le os arquivos  e gera txt conforme o layout dos   |
//³           ³ correios                     								  ³
//³           ³ 															  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function ImprimirArq()
setprvt("cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3, wrnel, aReturn")
setprvt("Li")
MHORA      := TIME()
wnrel := "Relatorio_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)                           
cDesc1 :=PADC("Este programa ira gerar o arquivo para os Correios" ,74)
cDesc2 :=""
cDesc3 :=""
aReturn    := { "Especial", 1,"Administra‡Æo", 1, 2, 1,"",1 }
mDESCR :=""
CONTROLE := ""
cPerg:=""

	wnrel := SetPrint("ESTADO",wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
	SetDefault(aReturn,"ESTADO")
     
	//HEADER
	Li := 0
	@ Li,000 PSAY HTPREG
	@ Li,001 PSAY HTPARQ
	@ Li,002 PSAY strzero(HCODEDIT,10)
	@ Li,012 PSAY strzero(HCODADM,10)
	@ Li,022 PSAY strzero(HQTDPROT,10)
	@ Li,032 PSAY strzero(HNUMCART,10)
	@ Li,042 PSAY strzero(HNUMLOTE,6)
	@ Li,048 PSAY HCODUN
	@ Li,060 PSAY strzero(HNUMCONT,12)
	@ Li,072 PSAY strzero(HCODSERV,5) 
	@ Li,077 PSAY strzero(HESPECSERV,5) 
	@ Li,082 PSAY HDTGER 
	@ Li,101 PSAY HDTENT 
	@ Li,117 PSAY HVERSAO 


	//detalhe2: UF
	dbselectarea("ESTADO")
	dbgotop()
	While !Eof()      
		Li := Li+1
		@ Li,000 PSAY ESTADO->D2TPREG
		@ Li,001 PSAY ESTADO->D2UF
		@ Li,003 PSAY strzero(ESTADO->D2QTD,10)
		dbselectarea("ESTADO")
		dbskip()
	End
	
	//detalhe 3: Periodico
	dbselectarea(cArq3)
	dbgotop()     
	Li := Li+1
	@ Li,000 PSAY D3TPREG  
	@ Li,001 PSAY strzero(D3CODTIT ,10)
	@ Li,011 PSAY D3IDPER  
	@ Li,016 PSAY strzero(D3EDIC,10)
	@ Li,026 PSAY D3TPPER  
	@ Li,030 PSAY strzero(D3PESO,8)
	@ Li,038 PSAY D3UNPESO
	@ Li,039 PSAY strzero(D3LARG,8)
	@ Li,047 PSAY strzero(D3ALT,8)
	@ Li,055 PSAY strzero(D3COMP,8)
	@ Li,063 PSAY D3UNDIM
	@ Li,064 PSAY strzero(D3QTDOBJ,4)
	@ Li,068 PSAY strzero(D3QTDTOT,10)    
	@ Li,078 PSAY strzero(val(nAvarias),10)    
	@ Li,088 PSAY space(12)
	
	//detalhe6: Etiqueta
	dbselectarea("ETIQ")
	dbgotop()
	
	While !Eof()      
		Li := Li+1
		@ Li,000 PSAY ETIQ->D6TPREG 
		@ Li,001 PSAY strzero(ETIQ->D6SEQ,10)
		@ Li,011 PSAY strzero(ETIQ->D6CODTIT,10)
		@ Li,021 PSAY strzero(ETIQ->D6EDIC,10)
		@ Li,031 PSAY ETIQ->D6TPPER 
		@ Li,035 PSAY ETIQ->D6IPROM 
		@ Li,055 PSAY ETIQ->D6IBRIM 
		@ Li,075 PSAY ETIQ->D6ICAT  
		@ Li,095 PSAY ETIQ->D6CODASS
		@ Li,115 PSAY ETIQ->D6ASS   
		@ Li,135 PSAY ETIQ->D6NOME  
		@ Li,195 PSAY ETIQ->D6CONTAT
		@ Li,255 PSAY ETIQ->D6LOGR  
		@ Li,315 PSAY ETIQ->D6TPLOGR
		@ Li,330 PSAY ETIQ->D6COMPL 
		@ Li,370 PSAY ETIQ->D6NUMLOG
		@ Li,380 PSAY ETIQ->D6BAIRRO
		@ Li,440 PSAY ETIQ->D6CEP   
		@ Li,448 PSAY ETIQ->D6CIDADE
		@ Li,518 PSAY ETIQ->D6UF    
		@ Li,520 PSAY ETIQ->D6REF   
		@ Li,560 PSAY ETIQ->D6COMER 
		@ Li,561 PSAY strzero(ETIQ->D6QTDREC,5)
		@ Li,566 PSAY ETIQ->D6PROCON
		@ Li,567 PSAY strzero(ETIQ->D6SEQREC,2)
		@ Li,569 PSAY ETIQ->D6PRIM  
		@ Li,570 PSAY ETIQ->D6PROTOC
		@ Li,571 PSAY ETIQ->D6DICA  
		@ Li,631 PSAY ETIQ->D6DISTR 
		@ Li,635 PSAY ETIQ->D6PERCOR
		@ Li,639 PSAY ETIQ->D6UNDIST
		@ Li,651 PSAY strzero(ETIQ->D6QTDPER,7)
		@ Li,658 PSAY ETIQ->D6PACOTE
		
		dbselectarea("ETIQ")
		dbskip()
	End
	

    Li := Li +1
	@ Li,000 PSAY FTPREG
	@ Li,001 PSAY strzero(FQTDREG,10)
	@ Li,011 PSAY strzero(FPESOTOT,8)
	@ Li,019 PSAY FUNPESO
	

	SET DEVICE TO SCREEN
	IF aRETURN[5] == 1
		Set Printer to
		dbcommitAll()
		ourspool(WNREL)
	ENDIF
	MS_FLUSH()
	 
	/*cString = "\SIGA\RELATO\ETIQ.TXT"
COPY TO &cString SDF
      */
Return
