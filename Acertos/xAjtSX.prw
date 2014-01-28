#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#include "Fileio.ch"

User Function xAjtSX() // Ajuste Virada
//Processa({|| U_xAjtSX() },"AJUSTE SX........")// Executar no formula para cada empresa.
Local nHandle
Local cCrLf 	:= Chr(13) + Chr(10)
Local cNomeArquivo := "c:\xAjtSX_P10_to_11_"+SM0->M0_CODIGO+".txt"
cDir:= "\DIRDOC"
cALIAS := "TRB"
cMsg :=""
cMsgx:=""                        
aMsg1 := {}
 
nHandle := MsfCreate(Alltrim(cNomeArquivo),0)
	
If nHandle > 0
	fWrite(nHandle, "Ajuste SXs... "+SM0->M0_CODIGO+SM0->M0_NOME)
	fWrite(nHandle, cCrLf ) // Pula linha
	
	dbSelectArea("SX7")
	dbSetOrder(1)
	dbGotop()
	ProcRegua(SX7->(RecCount())*5) // Regua


	aSX7 :={}
	aDel :={}

	While !Eof()
		IncProc("SX7 : "+SX7->X7_CAMPO+SX7->X7_SEQUENC)
		if Ascan(aSX7,{|x| x[1]+x[2] == SX7->X7_CAMPO+SX7->X7_SEQUENC}) == 0
			Aadd(aSX7,{SX7->X7_CAMPO,SX7->X7_SEQUENC})
		Else
			Aadd(aDel,{SX7->X7_CAMPO,SX7->X7_SEQUENC})
		Endif
		dbSelectArea("SX7")
		dbSkip()
	End

	//cMsg +="Correção SX7 Gatilho duplicado:<br>"
	fWrite(nHandle, "Correção SX7 Gatilho duplicado:<br>")
	fWrite(nHandle, cCrLf ) // Pula linha
	dbSelectArea("SX7")
	dbSetOrder(1)
	ProcRegua(Len(aDel))
	For i:= 1 To Len(aDel)
		IncProc("SX7 Deletando: "+aDel[i][1]+aDel[i,2])
		If dbSeek(aDel[i,1]+aDel[i,2])
			//cMsg += SX7->X7_CAMPO+"-"+SX7->X7_SEQUENC+"<br>"
			fWrite(nHandle, SX7->X7_CAMPO+"-"+SX7->X7_SEQUENC+"<br>")
			fWrite(nHandle, cCrLf ) // Pula linha
			RecLock("SX7",.F.)
			DbDelete()
			MsUnlock()
		ENDIF
		dbSkip()
	next 

	cMsg +="<br><br>"
	cMsg2 :=""
	aMsg1 :={}
	

	if !Empty(cMsg2)
		Aadd(aMsg1,cMsg2)
		cMsg2:= ""

	Endif


	cMsg +="<br><br>"

	dbSelectArea("SXG")
	dbSetOrder(1)

	dbSelectArea("SX3")
	dbSetOrder(1)

	ProcRegua(SX3->(RecCount())) // Regua
	dbGotop()
	//cMsg +="Correção SX3 X3_GRPSXG:<br>"
	fWrite(nHandle, "Correção SX3 X3_GRPSXG:<br>")
	fWrite(nHandle, cCrLf ) // Pula linha

	While !Eof()
		IncProc("SX3 GRUPO: "+SX3->X3_CAMPO)
		if !Empty(SX3->X3_GRPSXG) .And. SXG->( dbSeek(SX3->X3_GRPSXG,.T.) )
			IF 	SX3->X3_TAMANHO <> SXG->XG_SIZE
				//cMsg += SX3->X3_CAMPO+"-"+SX3->X3_GRPSXG+"<br>"
				fWrite(nHandle, SX3->X3_CAMPO+"-"+SX3->X3_GRPSXG+"<br>")
				fWrite(nHandle, cCrLf ) // Pula linha
		  		SX3->(RecLock("SX3",.f.))
				SX3->X3_TAMANHO:= SXG->XG_SIZE
				SX3->( MsUnlock() )
			Endif
		Endif
		dbSelectArea("SX3")
		dbSkip()
	End
	cMsg +="<br><br>"
	fWrite(nHandle, cCrLf ) // Pula linha
	fWrite(nHandle, cCrLf ) // Pula linha

	aTab :={'TRA','TRB','TRC','TRJ','TRK','TRX'}
	aTab :={'TRA','TRC','TRJ','TRK','TRX','TRW'}
	//ProcRegua(3) // Regua
	//cMsg +="Linha 120 Drop:<br>"
	//for x:=1 to Len(aTab)
	//IncProc("DROP : "+aTab[x])
	//If TcSqlExec("DROP TABLE "+RetSqlName(aTab[x]) ) < 0
	//  	MsgStop("Houveram erros durante o processamento: "+aTab[x]+chr(10)+chr(13)+TCSQLERROR())
	//Else
	//	cMsg += RetSqlName(aTab[x])+"<br>"
	//EndIf
	//Next
                 
	cMsg +="<br><br>"

	dbSelectArea("SX2")
	dbSetOrder(1)

	dbSelectArea("SX3")
	dbSetOrder(1)

	dbSelectArea("SIX")
	dbSetOrder(1)

	//cMsg +="Deletar SXS...<br>"
	fWrite(nHandle,"Deletar SXS...<br>") 
	fWrite(nHandle, cCrLf ) // Pula linha

	ProcRegua(3) // Regua
	for x:=1 to Len(aTab)
		IncProc("DEL SX2/SX3/SIX : "+aTab[x])
		//cMsg += RetSqlName(aTab[x])+"<br>"
		fWrite(nHandle, RetSqlName(aTab[x])+"<br>")
		fWrite(nHandle, cCrLf ) // Pula linha	
		if SX2->(dbSeek(aTab[x]))
	  		RecLock( "SX2", .F. )
			SX2->( DbDelete() )
		 	SX2->( MsUnLock() )
		Endif              
		dbSelectArea("SX3")
		if SX3->(dbSeek(aTab[x]))                
			While !Eof() .And. X3_ARQUIVO  == aTab[x]
	   			RecLock( "SX3", .F. )
				SX3->( DbDelete() )
				SX3->( MsUnLock() )
			dbSkip()
			End
		Endif
	
		dbSelectArea("SIX")
		if SX1->(dbSeek(aTab[x]))
			While !Eof() .And. INDICE  == aTab[x]
		  		RecLock( "SIX", .F. )
				SIX->( DbDelete() )
			  	SIX->( MsUnLock() )
				dbSkip()
			End
		Endif
	Next

	//cMsg +="Ajuste X1_TAMANHO...<br>"
	fWrite(nHandle,"Ajuste X1_TAMANHO...<br>") 
	fWrite(nHandle, cCrLf ) // Pula linha	
	// MTA996 pergunta 07 e 10 para 9
	cMsg +="<br><br>"
	//ASX1:={Padr("MTA996",10)+"07",Padr("MTA996",10)+"10"}

	dbSelectArea("SXG")
	dbSetOrder(1)   

	dbSelectArea("SX1")
	dbSetOrder(1)   
	ProcRegua(SX1->(RecCount())) // Regua
	dbGotop()
	While !Eof()
		IncProc("SX1 : "+X1_GRPSXG)
		If !Empty(X1_GRPSXG) //.And. 
			dbSelectArea("SXG")
			IF dbSeek(SX1->X1_GRPSXG,.T.) 	    
				dbSelectArea("SX1")
				if SX1->X1_TAMANHO <> SXG->XG_SIZE
					//cMsg += X1_GRUPO+"<br>"
					fWrite(nHandle, X1_GRUPO+"<br>")	
					fWrite(nHandle, cCrLf ) // Pula linha	
					RecLock("SX1",.F.)
					X1_TAMANHO := SXG->XG_SIZE
					MsUnlock()
				endif
			endif
		ENDIF          
		dbSelectArea("SX1")
		dbSkip()
	End


	// SIX 

	cMsg +="<br><br>"
	dbSelectArea("SIX")
	dbSetOrder(1)
	aSX1 :={}
	aDel :={}
	dbGotop()
	ProcRegua(SX1->(RecCount())*5) // Regua
	While !Eof()
		IncProc("SIX : "+INDICE)
		//	if INDICE $ "AB9;BMA;SA1;SF2"
		if Ascan(aSX1,{|x| x[1]+x[3] == INDICE+CHAVE}) == 0
			Aadd(aSX1,{INDICE,ORDEM,CHAVE})
		Else
			Aadd(aDel,{INDICE,ORDEM,CHAVE})
		Endif
		//	Endif
		dbSkip()
	end

	//cMsg +="Correção SIX Deletado duplicado:<br>"
	fWrite(nHandle, "Correção SIX Deletado duplicado:<br>")
	fWrite(nHandle, cCrLf ) // Pula linha
	dbGotop()
	ProcRegua(Len(aDel))
	For i:= 1 To Len(aDel)
		IncProc("SIX Deletando: "+aDel[i][1]+aDel[i,2])
		If dbSeek(aDel[i,1]+aDel[i,2])
			//cMsg += INDICE+"-"+ORDEM+"<br>"
			fWrite(nHandle, INDICE+"-"+ORDEM+"<br>")
			fWrite(nHandle, cCrLf ) // Pula linha		
			RecLock("SIX",.F.)
			DbDelete()
			MsUnlock()
		ENDIF
	next

	cMsgx +="<br><br>"

dbSelectArea("SX3")
dbSetOrder(1)

	ProcRegua(SX3->(RecCount())) // Regua
	dbGotop()
	//cMsg1 :="Correção SX3 X3_PROPRI (2):<br>"
	fWrite(nHandle, "Correção SX3 X3_PROPRI (2):<br>")
	fWrite(nHandle, cCrLf ) // Pula linha
	//CD9_TPCOMB
	//A1_NOME
	While !Eof()
		IncProc("SX3  X3_PROPRI (2): "+SX3->X3_CAMPO)
		IF Left(SX3->X3_ARQUIVO,2) <> "SZ" .And. X3_PROPRI <> "S"
			if SubStr(SX3->X3_CAMPO,AT("_",X3_CAMPO),2) <> "_X"  //.And. !Alltrim(SubStr(SX3->X3_CAMPO,AT("_",X3_CAMPO)+1,12)) $ "USERLGI;USERLGA"
		
				//cMsgx += SX3->X3_CAMPO+"-"+"<br>"
				fWrite(nHandle, SX3->X3_CAMPO+"-"+"<br>")
				fWrite(nHandle, cCrLf ) // Pula linha
		
				SX3->(RecLock("SX3",.f.))
				SX3->X3_PROPRI:= "S" 
				SX3->( MsUnlock() )  
			
			Endif
		Endif
		dbSelectArea("SX3")
		dbSkip()
	End

	cMsg +="<br><br>"


//	dbSelectArea("SX2")
//	ProcRegua(SX2->(RecCount())) // Regua
//	dbGotop()
//	cMsgx :="Linha 268 Drop SX2 vazio:<br>"

//	While !Eof()
//		IncProc("SX2  drop (2): "+SX2->X2_CHAVE)
//		//dbSelectArea(SX2->X2_CHAVE)
//		//(SX2->X2_CHAVE)->(RecCount()) == 0
//		if   xRecCount(SX2->X2_CHAVE+cEmpAnt+"0")   // .And. ( Left(SX2->X2_CHAVE,2) == "SZ" .or. Left(SX2->X2_CHAVE,2) == "WF" )
//				//dbSelectArea(SX2->X2_CHAVE+cEmpAnt+"0")
//				//dbClosearea()
//				//dbSelectArea("SX2")
//				If TcSqlExec("DROP TABLE "+SX2->X2_CHAVE+cEmpAnt+"0" ) < 0
//	  				MsgStop("Houveram erros durante o processamento: "+SX2->X2_CHAVE+chr(10)+chr(13)+TCSQLERROR())
//				Else
//					cMsgx += SX2->X2_CHAVE+"-"+"<br>"
//				EndIf
//		Endif
//		dbSelectArea("SX2")
//		dbSkip()
//	End
//	cMsgx +="<br><br>"

	//Exceçao

	//dbSelectArea("SX3")
	//dbSetOrder(2)

	//ProcRegua(SX3->(RecCount())) // Regua
	//dbGotop()
	//aSzw := {"ZW_ORIGEM","ZW_DESTINO"}//  ,"CTD_ITVM","CTD_ITRED","B1_CODISS","C6_CODISS","C9_CODISS","D1_CODISS","D2_CODISS","F3_CODISS","FT_CODISS"}//,"E5_AGLIMP"}
	//aTam := {4          ,4           }// ,9         ,9         ,9          ,9           ,9         ,9          ,9          ,9          ,9          }//,6}
	//For x:= 1 to Len(aSzw)
	//	IncProc("SX3  deixando igual ao tamanho no banco : "+SX3->X3_CAMPO)
	//	if SX3->(dbSeek(aSzw[x]))                					       
	//		cMsgx += SX3->X3_CAMPO+" de "+AllTrim(Str(SX3->X3_TAMANHO))+" para +"+AllTrim(Str(aTam[X]))+"<br>"
	//		SX3->(RecLock("SX3",.f.))
	//		SX3->X3_TAMANHO:= aTam[X]
	//		SX3->( MsUnlock() )  	
	//	Endif
	//Next
         
//	if !Empty(cMsg) .or. !Empty(cMsgx)                        //;mcfranceschi@hotmail.com
	//WFNotifyAdmin( "r.vacari01@hotmail.com" , "Ajuste SXs... "+Capital("  - "+SM0->M0_FILIAL),"Indices Deletados<BR>"+cMsg+cMsgx, {} )
	//aEval(aMsg1,{|x| WFNotifyAdmin( "r.vacari01@hotmail.com" , "Ajuste SXs(X3_PROPRI) "+Capital("  - "+SM0->M0_FILIAL),x, {} )})
	
		
//		fWrite(nHandle, "Indices Deletados<BR>"+cMsg+cMsgx)
//		fWrite(nHandle, cCrLf ) // Pula linha
	
//	Endif
	fClose(nHandle)
	MsgAlert(cNomeArquivo)
Endif
	
Return

Static function xRecCount(cTab)
Local xArea := GetArea()
Local lRet  := .f.
Local cAlias:= GetNextAlias()
//versao 2008 ou >
//dbUseArea(.T., "TOPCONN", TCGenQry(,,"select COUNT(*) ntab from sys.objects"+;

//versao 200 sbc, cpv, btm e wsul
dbUseArea(.T., "TOPCONN", TCGenQry(,,"select COUNT(*) ntab from sysobjects"+;
			" where name = '"+cTab+"'"), cAlias, .F., .T.)
dbSelectArea(cAlias)
lRet := ntab > 0    
(cAlias)->(dbCloseArea())
if lRet
	dbUseArea(.T., "TOPCONN", TCGenQry(,,"select COUNT(*)  NREG from "+cTab+""+;
			" "), cAlias, .F., .T.)
	dbSelectArea(cAlias) //where D_E_L_E_T_ = ''
	lRet := NREG  == 0    
	(cAlias)->(dbCloseArea())       
Endif

RestArea(xArea)
Return lREt

