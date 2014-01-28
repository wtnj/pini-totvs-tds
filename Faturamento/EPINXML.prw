#INCLUDE "rwmake.ch"
#include "Protheus.ch"
#INCLUDE "ap5mail.ch"
#INCLUDE "TbiConn.ch"
#INCLUDE "TopConn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT100TOK  º Autor ³ Rodolfo Vacari     º Data ³  07/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ed. Pini                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/   

**********************************************************************
//Funcao para incluir xml no banco de dados      
//ATENCAO nao eh feita a verificacao se eh repedito o XML pois pode
// se tratar de 1 xml de cancelamento
**********************************************************************

User Function InsertXml(AEMP)

Local _aRetNfe := {}
Local _cKeyNFe := ""
Local _cError
Local _cWarning
Local _lRecusada
Local i
Local x
Local _cXml := ""
Local _aData := {;
{"ZY9_CHVNFE", , Nil},;
{"ZY9_XMLNFE", , Nil},;
{"ZY9_HRCKKE", , Nil},;
{"ZY9_CNPJEM", , Nil},;
{"ZY9_CNPJDE", , Nil},;
{"ZY9_NOTA", , Nil},;
{"ZY9_SERIE", , Nil},;
{"ZY9_EMISSA", , Nil},;
{"ZY9_VALOR", , Nil},;
{"ZY9_DEST", , Nil},;
{"ZY9_NFOK", , Nil},;
{"ZY9_CANCEL", , Nil}}
Local _nPosChv		:= aScan(_aData,{|x| x[1] == "ZY9_CHVNFE"})
Local _nPosXML		:= aScan(_aData,{|x| x[1] == "ZY9_XMLNFE"})
Local _nPosHRK		:= aScan(_aData,{|x| x[1] == "ZY9_HRCKKE"})
Local _nPosCNEM		:= aScan(_aData,{|x| x[1] == "ZY9_CNPJEM"})
Local _nPosCNDE		:= aScan(_aData,{|x| x[1] == "ZY9_CNPJDE"})
Local _nPosNota		:= aScan(_aData,{|x| x[1] == "ZY9_NOTA"})
Local _nPosSerie	:= aScan(_aData,{|x| x[1] == "ZY9_SERIE"})
Local _nPosEmiss	:= aScan(_aData,{|x| x[1] == "ZY9_EMISSA"})
Local _nPosValor	:= aScan(_aData,{|x| x[1] == "ZY9_VALOR"})
Local _nPosDest		:= aScan(_aData,{|x| x[1] == "ZY9_DEST"})
Local _nPosOk		:= aScan(_aData,{|x| x[1] == "ZY9_NFOK"})
Local _nPosCanc		:= aScan(_aData,{|x| x[1] == "ZY9_CANCEL"})
Local _cMsg
Local _lRet := .T.   
Local cFile := ""          

If ValType(AEMP) == "A" 
	if  Len(aEmp) > 0 
		Prepare Environment EMPRESA AEMP[1] FILIAL AEMP[2]
	Endif
EndIf        

Private lMsErroAuto := .F.
Private lAutoErrNoFile := .T.
Private _oXml
Private _oRoot
Private _cKeyNFe  := ""
Private cDir      := ""
Private cDirDest  := ""
Private cDirEXPO  := ""
Private cDirNoImp := ""
Private cDirEXPO  := ""
Private aDirXML   := {}

cDir      := SuperGetMv("MV_XDIRNFE",,"\NFE\Entrada\IMPORT")
cDirNoImp := SuperGetMv("MV_XDIRNFE",,"\NFE\Entrada\NoIMPORT")
aDirXML := Directory( cDir + "\*.xml")

dbSelectArea("ZY9")
dbSetOrder(1)
//For i := 1 To Len(aFiles)
For i := 1 To Len(aDirXML)

	if nXML > 1
		Exit
	Endif

	//cFile := aFiles[i][1]	
	If at(".XML",UPPER(cFile)) == 0 //verifica se eh um arquivo xml
		Loop
	EndIf

	_cError := ""
	_cWarning := ""

	cFile := Alltrim(cDir)+"\"+AllTrim(aDirXML[nXML,1]) 
	_oXml := XmlParserFile( cFile, "_", @_cError, @_cWarning )
	If Empty(_cError)
		If Type("_oXml:_NFE") <> "U"
			_cKeyNFe := AllTrim(StrTran(Upper(_oXml:_NFE:_INFNFE:_ID:TEXT), "NFE", ""))
			_oRoot := _oXml:_NFE
		Elseif Type("_oXml:_NFEPROC") <> "U"
			_cKeyNFe := AllTrim(StrTran(Upper(_oXml:_NFEPROC:_NFE:_INFNFE:_ID:TEXT), "NFE", ""))
			_oRoot := _oXml:_NFEPROC:_NFE
		EndIf
		If !Empty(_cKeyNFe)
			FT_FUse(cFile)
			_cXml := ""
			While !FT_FEOF()
				_cXml += FT_FREADLN()
				FT_FSkip()
			EndDo
			FT_FUse()//fecha o arquivo 
			
			If ZY9->(dbSeek(xFilial("ZY9") + _cKeyNFe))
				Loop
			EndIf
				
			_aRetNFe := U_ConNFeKey(_cKeyNFe)
			
			_aData[_nPosChv][2] := _cKeyNFe
			_aData[_nPosXML][2] := _cXml
			_aData[_nPosHRK][2] := Dtoc(Date()) + " " + Time()
			_aData[_nPosCNDE][2] := IF(TYPE("_oRoot:_INFNFE:_DEST:_CNPJ:TEXT")=="U" , _oRoot:_INFNFE:_DEST:_CPF:TEXT,_oRoot:_INFNFE:_DEST:_CNPJ:TEXT)          //Verifica CNPJ do Destinatario no XML
			_aData[_nPosCNEM][2] := IF(TYPE("_oRoot:_INFNFE:_EMIT:_CNPJ:TEXT")=="U" , _oRoot:_INFNFE:_EMIT:_CPF:TEXT,_oRoot:_INFNFE:_EMIT:_CNPJ:TEXT)          //Verifica CNPJ do Destinatario no XML
			_aData[_nPosNota][2] := StrZero(Val(_oRoot:_INFNFE:_IDE:_NNF:TEXT),9)
			_aData[_nPosSerie][2] := PadR(_oRoot:_INFNFE:_IDE:_SERIE:TEXT,3)
			_aData[_nPosEmiss][2] := Stod(Replace(_oRoot:_INFNFE:_IDE:_DEMI:TEXT,"-",""))
			_aData[_nPosValor][2] := Val(Iif(Type("_oRoot:_INFNFE:_TOTAL:_ICMSTOT:_VNF") != "U", _oRoot:_INFNFE:_TOTAL:_ICMSTOT:_VNF:TEXT, "0"))
			_aData[_nPosDest][2] :=	Iif(cDest != Nil, cDest, "")
			_aData[_nPosOk][2] :=	_aRetNfe[3] == "100"
			_aData[_nPosCanc][2] :=	_aRetNfe[3] == "101"

			If _aRetNFe[3] <> "100"
				aAdd(_aLog,"A NOTA : " + _aData[_nPosNota][2] + " DO FORNECEDOR " + ALLTRIM(_oRoot:_DEST:_XNOME:TEXT) + " ESTA RECUSADA NO SEFAZ")
				aAdd(_aLog,"")
				_lRet := .F.
				Copy File &(Alltrim(cDir)+"\"+AllTrim(aDirXML[nXML,1])) To &(Alltrim(cDirNoImp)+"\"+AllTrim(aDirXML[nXML,1]))									
				FErase(Alltrim(cDir)+"\"+AllTrim(aDirXML[nXML,1]))
			EndIf
			
			AxCadastro("ZY9","XML NOTA FISCAL ELETRONICA",".T.",".T.",,,,,,_aData,3,,)
			_cMsg := ""
			If lMsErroauto
				aEval(GetAutoGRLog(),{|x| _cMsg += x + CRLF})
				aAdd(_aLog," Error ao salvar os dados do Arquivo: " + cFile + " " + _cMsg)
				aAdd(_aLog,"")
				_lRet := .F.
			EndIf
			
			If !lMsErroauto .AND. _aRetNFe[3] == "100"
				cDirEXPO  := SuperGetMv("MV_XDIRARQ",,"\NFE\Entrada\")
				cDirEXPO  += AllTrim(Str(Year(dDatabase)))
				cDirEXPO  += "\"
				cDirEXPO  += Alltrim(Strzero(Month(dDatabase),2))	
					
				WHILE !file(cDirEXPO)                              
					if !file("\NFE")                              
						MakeDir("\NFE")                              
				        Elseif !file("\NFE\Entrada")
			       			    MakeDir("\NFE\Entrada")
					Elseif !file("\NFE\Entrada\"+AllTrim(Str(Year(dDatabase))))
						    MakeDir("\NFE\Entrada\"+AllTrim(Str(Year(dDatabase))))
					Elseif !file("\NFE\Entrada\"+AllTrim(Str(Year(dDatabase)))+"/"+Alltrim(Strzero(Month(dDatabase),2)))
						    MakeDir("\NFE\Entrada\"+AllTrim(Str(Year(dDatabase)))+"/"+Alltrim(Strzero(Month(dDatabase),2)))
					Else
					    MakeDir(cDirEXPO)
				        Endif
				End 
					
				Copy File &(Alltrim(cDir)+"\"+AllTrim(aDirXML[nXML,1])) To &(Alltrim(cDirEXPO)+"\"+"IMPORT ED-"+AllTrim(aDirXML[nXML,1]))
									
				FErase(Alltrim(cDir)+"\"+AllTrim(aDirXML[nXML,1]))    	
			
			EndIf

		EndIf
	Else
		Copy File &(Alltrim(cDir)+"\"+AllTrim(aDirXML[nXML,1])) To &(Alltrim(cDirNoImp)+"\"+AllTrim(aDirXML[nXML,1]))									
		FErase(Alltrim(cDir)+"\"+AllTrim(aDirXML[nXML,1]))
		aAdd(_aLog,_cError)
		aAdd(_aLog,"")
		_lRet := .F.
	EndIf
Next
Return _lRet