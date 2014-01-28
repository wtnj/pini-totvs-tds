#INCLUDE "rwmake.ch"                       
#include "topconn.ch"
#include "tbiconn.ch"
#include "Fileio.ch"

/*/     
Alterado por Danilo Pala em 20100527: ZY3       
Alterado por Danilo Pala em 20120417: a partir de arquivo TXT
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RFAT120   ³Autor: Danilo C S Pala        ³ Data:   20080919 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera arquivo para SIGEP                                    ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function RFAT120() 
setprvt("cArq, Programa, cString")
setprvt("mhora, mdata, cQuery, nLastKey")
setprvt("_aCampos, _cNome, cIndex, cKey")

Programa   := "RFAT120"
MHORA      := TIME()
mdata	   := dtos(date()) //20060214
mdata 	   := subs(mdata,7,2) + "-" + subs(mdata,5,2) +"-" + subs(mdata,1,4)+" 00:00"
cString    := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)         
nLastKey:= 0     
cArq	   := "FONTE"

//header
private HTPREG := "1"
private HSIGEP := "SIGEP DESTINATARIO NACIONAL"

//FOOTER
private FTPREG := "9"
private FQTDREG := 0

Private cPerg := "RFT120"
ValidPerg()

If !Pergunte(cPerg)
   Return
Endif


Processa({||ProcArq()  },"Preparando Dados")

Return    




//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ ProcArq()                                                     ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ funcao que le o SF2 e gera txt conforme o layout do SIGEP     ³
//³           ³                               								  ³
//³           ³ 															  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function ProcArq()
setprvt("cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3, wrnel, aReturn")
setprvt("Li,mhora")
MHORA := TIME()
wnrel    := "Relatorio_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cDesc1   := PADC("Este programa ira gerar o arquivo para o SIGEP" ,74)
cDesc2   := ""
cDesc3   := ""
aReturn  := { "Especial", 1,"Administra‡Æo", 1, 2, 1,"",1 }
mDESCR   := ""
CONTROLE := ""
cPerg    := ""
cTitulo  := "RFAT120"

wnrel := SetPrint("",wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
SetDefault(aReturn,"")
     
//HEADER
Li := 0
@ Li,000 PSAY HTPREG
@ Li,001 PSAY HSIGEP
Li++
if !EMPTY(MV_PAR07)
	IF SM0->M0_CODIGO <>"02"
		MSGALERT("PARA RELATORIOS DE CUSTO, EXECUTE NA PSE!")
		return
	ENDIF
	
	cpath := "\SIGA\ETIQUETAS\"+ alltrim(MV_PAR07)
	if File(cpath)
		_aCampos := {  {"NADA"  ,"C",12 ,0} ,;
		{"NOME"    ,"C",50 ,0} ,;
		{"CONTATO" ,"C",50 ,0} ,;
		{"ENDERECO","C",59 ,0} ,;
		{"COMPLEM" ,"C",30 ,0} ,;
		{"BAIRRO"  ,"C",30 ,0} ,;
		{"CEP"     ,"C",9,0} ,;
		{"MUN"     ,"C",30,0} ,;
		{"UF"      ,"C",2,0},;
		{"NADA1"   ,"C",79,0},;
		{"PEDIDO"  ,"C",8,0},;
		{"NADA2"   ,"C",102,0}}
    	
		_cNome := CriaTrab(_aCampos,.t.)
		cIndex := CriaTrab(Nil,.F.)
		cKey   := "NADA"
		dbUseArea(.T.,, _cNome,"FONTE",.F.,.F.)
		dbSelectArea("FONTE")
		Indregua("FONTE",cIndex,ckey,,,"Selecionando Registros do Arq")
	
		DBSELECTAREA("FONTE")
		cpath := "\SIGA\ETIQUETAS\"+ alltrim(MV_PAR07)
		bBloco := "APPEND FROM &cpath SDF"
		APPEND FROM &cpath SDF
		MsAguarde({|| bBloco},"Apendando arquivo de etiquetas...")
		MSUNLOCK()
		DBGOTOP()

		While !Eof()
			if substr(FONTE->NADA,1,11)<>"<<GERASEQ>>"
				dbselectarea("FONTE")
				dbskip()      
				loop
			endif

			//localizar ItemPedido SC6      
			DbSelectArea("SC6")
			DBSETORDER(1)
			If DbSeek(xFilial("SC6")+FONTE->PEDIDO)
				DbSelectArea("SA1")    
				DBSETORDER(1)
				If DbSeek(xFilial("SA1")+SC6->C6_CLI+SC6->C6_LOJA)
					@ Li,000 PSAY "2"
					@ Li,001 PSAY SUBSTR(SA1->A1_CGC,1,14)
					@ Li,015 PSAY SUBSTR(SA1->A1_NOME,1,50)
					@ Li,065 PSAY SUBSTR(SA1->A1_EMAIL,1,50)
					DbSelectArea("SZN")
					DBSETORDER(1)
					If DbSeek(xFilial("SZN")+SC6->C6_CLI+SC6->C6_CODDEST)
						@ Li,115 PSAY SUBSTR(SZN->ZN_NOME,1,50)
						@ Li,165 PSAY SUBSTR(SZN->ZN_NOME,1,50)
					Else
						@ Li,115 PSAY space(50)
						@ Li,165 PSAY space(50)
					Endif //SZN
				
					DbSelectArea("SZO")
					DBSETORDER(1)
					IF DbSeek(xFilial("SZO")+SC6->C6_CLI+SC6->C6_CODDEST)
						@ Li,215 PSAY SUBSTR(SZO->ZO_CEP,1,8)
						@ Li,223 PSAY SUBSTR(ALLTRIM(ALLTRIM(SZO->ZO_TPLOG) + " "+ ALLTRIM(SZO->ZO_LOGR)),1,50)
						@ Li,273 PSAY SUBSTR(SZO->ZO_NLOGR,1,6)
						@ Li,279 PSAY SUBSTR(SZO->ZO_COMPL,1,30)
						@ Li,309 PSAY SUBSTR(SZO->ZO_BAIRRO,1,50)
						@ Li,359 PSAY SUBSTR(SZO->ZO_CIDADE,1,50)
					Else
						@ Li,215 PSAY SUBSTR(SA1->A1_CEP,1,8)
						@ Li,223 PSAY SUBSTR(ALLTRIM(ALLTRIM(SA1->A1_TPLOG) + " "+ ALLTRIM(SA1->A1_LOGR)),1,50)
						@ Li,273 PSAY SUBSTR(SA1->A1_NLOGR,1,6)
						@ Li,279 PSAY SUBSTR(SA1->A1_COMPL,1,30)
						@ Li,309 PSAY SUBSTR(SA1->A1_BAIRRO,1,50)
						@ Li,359 PSAY SUBSTR(SA1->A1_MUN,1,50)
					Endif //SZO

					@ Li,409 PSAY SUBSTR(SA1->A1_TEL,1,18)
					@ Li,427 PSAY SPACE(10)
					@ Li,437 PSAY SUBSTR(SA1->A1_FAX,1,10)
				Endif //SA1
			Endif //SC6
		
	   		FQTDREG++
		   	Li++
		   	dbselectarea("FONTE")
			dbskip()
		End  
		DBSelectArea("FONTE")
		DBCloseArea()
	else
		MsgAlert("Arquivo texto: \SIGA\ETIQUETAS\"+alltrim(mv_par07)+" nao localizado!")
	endif		
else
	DbSelectArea("SF2")  
	cQuery := "SELECT F2_SERIE, F2_DOC, A1_COD, A1_LOJA, A1_CGC, A1_NOME, A1_NREDUZ, TRIM(A1_TPLOG) || ' ' || TRIM(A1_LOGR) AS A1_LOGRA, A1_NLOGR, A1_COMPL, A1_CEP, A1_BAIRRO, A1_MUN, A1_EST, A1_TEL, A1_EMAIL, A1_FAX, A1_ENDCOB, Z5_CEP, TRIM(Z5_TPLOG) || ' ' || TRIM(Z5_LOGR) AS Z5_LOGRA, Z5_NLOGR, Z5_COMPL, Z5_BAIRRO, Z5_CIDADE, Z5_ESTADO, C5_RESPCOB, A1_ENDBP, ZY3_CONTAT, ZY3_END, ZY3_BAIRRO, ZY3_CEP, ZY3_CIDADE, ZY3_ESTADO,  TRIM(ZY3_TPLOG) || ' ' || TRIM(ZY3_LOGR) AS ZY3_LOGRA, ZY3_NLOGR, ZY3_COMPL"
	cQuery += " FROM "+ RETSQLNAME("SF2") +" SF2 LEFT OUTER JOIN "+ RETSQLNAME("SC5") +" SC5 ON (SC5.c5_filial='"+ xFilial("SC5") +"' and SF2.F2_DOC = SC5.c5_nota and SF2.F2_SERIE = SC5.c5_serie and sc5.d_e_l_e_t_<>'*'),"
	cQuery += " SA1010 SA1 LEFT OUTER JOIN "+ RETSQLNAME("SZ5") +" SZ5 ON (SA1.A1_FILIAL = SZ5.Z5_FILIAL AND SA1.A1_COD = SZ5.Z5_CODCLI AND SA1.A1_LOJA = SZ5.Z5_LOJA AND SZ5.D_E_L_E_T_<>'*')"
	cQuery += " LEFT OUTER JOIN ZY3010 ZY3 ON (SA1.A1_FILIAL = ZY3.ZY3_FILIAL AND SA1.A1_COD = ZY3.ZY3_CODCLI AND SA1.A1_LOJA = ZY3.ZY3_LOJA AND ZY3.D_E_L_E_T_<>'*')"
	cQuery += " WHERE SF2.F2_FILIAL='"+ xFilial("SF2") +"' AND SA1.A1_FILIAL = '"+ xFilial("SA1") +"'"
	cQuery += " AND SF2.F2_CLIENTE = SA1.A1_COD AND SF2.F2_LOJA = SA1.A1_LOJA"
	cQuery += " AND SF2.F2_SERIE >= '"+ MV_PAR01 +"' AND SF2.F2_SERIE <= '"+ MV_PAR02 +"'"
	cQuery += " AND SF2.F2_DOC >= '"+ MV_PAR03 +"' AND SF2.F2_DOC <= '"+ MV_PAR04 +"'"
	cQuery += " AND SF2.F2_EMISSAO >= '"+DTOS(MV_PAR05)+"' AND SF2.F2_EMISSAO <= '"+DTOS(MV_PAR06)+"'"
	cQuery += " AND SF2.D_E_L_E_T_<>'*' AND SA1.D_E_L_E_T_<>'*' ORDER BY SF2.F2_DOC"  
	DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'TRB', .F., .T.)
	dbselectarea("TRB")
	dbGoTop()       

	Li++
	WHILE !Eof()
				@ Li,000 PSAY "2"
				@ Li,001 PSAY SUBSTR(TRB->A1_CGC,1,14)
				@ Li,015 PSAY SUBSTR(TRB->A1_NOME,1,50)
				@ Li,065 PSAY SUBSTR(TRB->A1_EMAIL,1,50)
				@ Li,115 PSAY SUBSTR(TRB->C5_RESPCOB,1,50)
				@ Li,165 PSAY SUBSTR(TRB->C5_RESPCOB,1,50)
				IF SM0->M0_CODIGO =="03" .AND. ALLTRIM(TRB->A1_ENDBP)=="S"
					@ Li,215 PSAY SUBSTR(TRB->ZY3_CEP,1,8)
					@ Li,223 PSAY SUBSTR(TRB->ZY3_LOGRA,1,50)
					@ Li,273 PSAY SUBSTR(TRB->ZY3_NLOGR,1,6)
					@ Li,279 PSAY SUBSTR(TRB->ZY3_COMPL,1,30)
					@ Li,309 PSAY SUBSTR(TRB->ZY3_BAIRRO,1,50)
					@ Li,359 PSAY SUBSTR(TRB->ZY3_CIDADE,1,50)
				ELSEIF ALLTRIM(TRB->A1_ENDCOB)=='S' .AND. SM0->M0_CODIGO <>"03"  //ATE AQUI 20100305
					@ Li,215 PSAY SUBSTR(TRB->Z5_CEP,1,8)
					@ Li,223 PSAY SUBSTR(TRB->Z5_LOGRA,1,50)
					@ Li,273 PSAY SUBSTR(TRB->Z5_NLOGR,1,6)
					@ Li,279 PSAY SUBSTR(TRB->Z5_COMPL,1,30)
					@ Li,309 PSAY SUBSTR(TRB->Z5_BAIRRO,1,50)
					@ Li,359 PSAY SUBSTR(TRB->Z5_CIDADE,1,50)
				ELSE                                       
					@ Li,215 PSAY SUBSTR(TRB->A1_CEP,1,8)
					@ Li,223 PSAY SUBSTR(TRB->A1_LOGRA,1,50)
					@ Li,273 PSAY SUBSTR(TRB->A1_NLOGR,1,6)
					@ Li,279 PSAY SUBSTR(TRB->A1_COMPL,1,30)
					@ Li,309 PSAY SUBSTR(TRB->A1_BAIRRO,1,50)
					@ Li,359 PSAY SUBSTR(TRB->A1_MUN,1,50)
				ENDIF
				@ Li,409 PSAY SUBSTR(TRB->A1_TEL,1,18)
				@ Li,427 PSAY SPACE(10)
				@ Li,437 PSAY SUBSTR(TRB->A1_FAX,1,10)

		    	FQTDREG++
		    	Li++
		DBSELECTAREA("TRB")
		DBSKIP()  
	End
	DBSelectArea("TRB")
	DBCloseArea()
endif

	//FOOTER
	@ Li,000 PSAY FTPREG
	@ Li,001 PSAY strzero(FQTDREG,6)

	SET DEVICE TO SCREEN
	IF aRETURN[5] == 1
		Set Printer to
		dbcommitAll()
		ourspool(WNREL)
	ENDIF
	MS_FLUSH()  
	

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
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
aAdd(aRegs,{cPerg,"01","Série de?      ","Série de?      ","Série de?      ","mv_ch1","C",03,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Série até?     ","Série até?     ","Série até?     ","mv_ch2","C",03,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Nota de?       ","Nota de?       ","Nota de?       ","mv_ch3","C",09,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Nota até?      ","Nota até?      ","Nota até?      ","mv_ch4","C",09,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Emissão de?    ","Emissão de?    ","Emissão de?    ","mv_ch5","D",08,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","Emissão até?   ","Emissão até?   ","Emissão até?   ","mv_ch6","D",08,0,0,"G","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","Ou ArquivoTexto","Ou ArquivoTexto","Ou ArquivoTexto","mv_ch7","C",50,0,0,"G","","MV_PAR07","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

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






