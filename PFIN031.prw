#INCLUDE "rwmake.ch"                       
#include "topconn.ch"
#include "tbiconn.ch"
#include "Fileio.ch"

/*/          
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFIN031   ³Autor: Danilo C S Pala        ³ Data:   20130402 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: IMPORTAR PAGAMENTO DAS OPERADORAS DE CARTAO DE CREDITO      ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Pini					                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function PFIN031(nLayout, cDiretorio) 
Local cString := ""
Local cArq := ""
Local aString
Local nLinha := 0
Local lLayoutOk := .F.
Local aFiles := {}
Local nXaFiles 
Local bArqProcOk := .f.
Local cMsgErro := ""


if empty(nLayout) .or. empty(cDiretorio)
	cperg := "PFIN031"
	ValidPerg()
	Pergunte(cPerg,.t.)
	nLayout := MV_PAR01
	cDiretorio :=  alltrim(MV_PAR02)
endif   

CHKFILE("ZYC")

if !Empty(cDiretorio)
	//abrir diretorio
	aFiles := {}
	cpath := alltrim(cDiretorio)
	if substr(cpath,len(cpath)-1,1)<>"/"
		cpath := cpath+"\"
	endif
	aFiles := Directory(cpath+"*.CSV", "D")
	For nArq := 1 to Len( aFiles )
  		cArq := cpath + aFiles[nArq,1]
	
		If File(cArq)
			FT_FUSE(cArq)  //abrir
			FT_FGOTOP() //vai para o topo
			Procregua(FT_FLASTREC())  //quantos registros para ler
			nLinha := 1
			
 			While !FT_FEOF()
				cString := FT_FREADLN()  //lê a linha
				aString := strtokarr (cString, ";")
				IncProc("Importando registro "+ transform(nLinha,"@EZ 99999") + " de "+ transform(FT_FLASTREC(),"@EZ 99999"))
					If nLayout == 1 //Cielo
						cLayout := "C"
						/*Layout da Cielo
						1 Data da venda: 24/08/2012
						2 Data efetiva de pagamento: 27/03/2013
						3 Descrição: Visa parcelado loja - 7/8 (Pode ser: Cancelamento venda Visa crédito)
						4 Resumo: 4120824
						5 N° do cartão / TID: 999999******9999
						6 NSU / DOC: 547653
						7 Código Autorização: 65288 (pode ter letra)
						9 Valor Bruto (R$): 49,9 (Pode ser valor negativo, cancelamento)
						10 Rejeitado: Não
						11 Valor do saque (R$): 0
						*/
					
						//analisar layout
						lLayoutOk := .F.
						If Empty(aString[1]) .or. VALTYPE(ctod(aString[1])) <>"D" //data valida
							lLayoutOk := .F.
						ElseIf len(aString) < 10 //testar se existe as demais linhas
							lLayoutOk := .F.
						Else
							If Empty(aString[2]) .or. VALTYPE(ctod(aString[2])) <>"D" //data valida
								lLayoutOk := .F.
							ElseIf Empty(aString[3]) .or. Valtype(aString[3]) <>"C" //texto valido
								lLayoutOk := .F.
							ElseIf Empty(aString[4]) .or. Valtype(val(replace(aString[4],'"',''))) <>"N" .or. val(replace(aString[4],'"','')) =0 //numero valido
								lLayoutOk := .F.
							ElseIf Empty(aString[5]) .or. Valtype(val(substr(aString[5],2,4))) <>"N" .or. val(substr(aString[5],2,4))=0 //numero valido
								lLayoutOk := .F.
							ElseIf Empty(aString[6]) .or. Valtype(val(replace(aString[6],'"',''))) <>"N" .or. val(replace(aString[6],'"','')) =0 //numero valido
								lLayoutOk := .F.
							ElseIf Empty(aString[7]) .or. Valtype(aString[7]) <>"C"//texto valido
								lLayoutOk := .F.
							ElseIf Empty(aString[9]) .or. Valtype(val(replace(aString[9],'"',''))) <>"N" .or. val(replace(aString[9],'"','')) =0 //numero valido
								lLayoutOk := .F.
							ElseIf Empty(aString[10]) .or. Valtype(aString[10]) <>"C" //texto valido
								lLayoutOk := .F.
							ElseIf Empty(aString[11]) .or. Valtype(val(replace(aString[11],'"',''))) <>"N" //numero valido
								lLayoutOk := .F.
							Else //se tudo estiver ok
								lLayoutOk := .T.
							EndIf
						Endif
			
						if lLayoutOk //importar somente se layout estiver correto
							//verificar se existe
							dDTVEND := ctod(aString[1])
							dDTPGTO := ctod(aString[2])
							cDESCRI := replace(aString[3],'"','')
							cRESUMO := replace(aString[4],'"','')
							cCARTAO := replace(aString[5],'"','')
							cDOC := replace(aString[6],'"','')
							cAUT  := replace(aString[7],'"','')
							nVALOR := val(replace(replace(replace(aString[9],'"',''),'.',''),',','.')) //ERA8
							cREJEIT  := substr(aString[10],2,1) //ERA9
					
							cQuery := "SELECT * FROM "+ RetSqlName("ZYC") +" ZYC WHERE ZYC_FILIAL='"+ xFilial("ZYV") +"' AND ZYC_LAYOUT='"+ cLayout +"' AND ZYC_DTVEND='"+ dtos(dDTVEND) +"' AND ZYC_DTPGTO='"+ dtos(dDTPGTO) +"' AND ZYC_DESCRI='"+ cDESCRI +"' AND ZYC_RESUMO='"+ cRESUMO +"' AND ZYC_CARTAO='"+ cCARTAO +"' AND ZYC_DOC='"+ cDOC +"' AND ZYC_AUT='"+ cAUT +"' AND D_E_L_E_T_<>'*'"
							MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "ZYCCONS", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
							DbSelectArea("ZYCCONS")
							If EOF() //importar
								DBSelectArea("ZYC")
								RECLOCK("ZYC",.T.)  //INSERIR .T.
								ZYC->ZYC_FILIAL  := xfilial("ZYC")
								ZYC->ZYC_LAYOUT := cLayout
								ZYC->ZYC_DTVEND := dDTVEND
								ZYC->ZYC_DTPGTO := dDTPGTO
								ZYC->ZYC_DESCRI := cDESCRI
								ZYC->ZYC_RESUMO := cRESUMO
								ZYC->ZYC_CARTAO := cCARTAO
								ZYC->ZYC_DOC := cDOC
								ZYC->ZYC_AUT := cAUT
								ZYC->ZYC_VALOR := nVALOR
								ZYC->ZYC_REJEIT := cREJEIT  
								MSUNLOCK("ZYC")
							EndIf
							DBSelectArea("ZYCCONS")
							DBCloseArea()
						ElseIf nLinha > 3
							cMsgErro += "Erro layout linha "+ transform(nLinha,"@EZ 99999") + chr(10)+chr(13)
						endif
						
					Elseif nLayout == 2 //Redecard
						cLayout := "R"
						/*Layout da Redecard
						1 DATA DA APRESENTAÇÃO: 29/06/2012
						2 DATA DO VENCIMENTO: 01/03/2013
						3 QUANTIDADE DE CV'S: 2
						4 NÚMERO DO RV: 74749944
						5 NÚMERO DO PV: 678309
						6 VALOR APRESENTADO: 1.215,20
						7 VALOR APURADO: 1.215,20
						8 VALOR LÍQUIDO: 144,69
						9 TIPO: MULTI
						*/
						//analisar layout
						lLayoutOk := .F.
						If Empty(aString[1]) .or. VALTYPE(ctod(aString[1])) <>"D" //data valida
							lLayoutOk := .F.
						ElseIf len(aString) < 9 //testar se existe as demais linhas
							lLayoutOk := .F.
						Else
							If Empty(aString[2]) .or. VALTYPE(ctod(aString[2])) <>"D" //data valida
								lLayoutOk := .F.
							ElseIf Empty(aString[3]) .or. Valtype(val(replace(aString[3],'"',''))) <>"N" .or. val(replace(aString[3],'"','')) =0 //numero valido
								lLayoutOk := .F.
							ElseIf Empty(aString[4]) .or. Valtype(val(replace(aString[4],'"',''))) <>"N" .or. val(replace(aString[4],'"','')) =0 //numero valido
								lLayoutOk := .F.
							ElseIf Empty(aString[5]) .or. Valtype(val(replace(aString[5],'"',''))) <>"N" .or. val(replace(aString[5],'"','')) =0 //numero valido
								lLayoutOk := .F.
							ElseIf Empty(aString[6]) .or. Valtype(val(replace(aString[6],'"',''))) <>"N" .or. val(replace(aString[6],'"','')) =0 //numero valido
								lLayoutOk := .F.
							ElseIf Empty(aString[7]) .or. Valtype(val(replace(aString[4],'"',''))) <>"N" .or. val(replace(aString[7],'"','')) =0 //numero valido
								lLayoutOk := .F.
							ElseIf Empty(aString[8]) .or. Valtype(val(replace(aString[4],'"',''))) <>"N" .or. val(replace(aString[8],'"','')) =0 //numero valido
								lLayoutOk := .F.
							ElseIf Empty(aString[9]) .or. Valtype(aString[9]) <>"C" //texto valido
								lLayoutOk := .F.
							Else
								lLayoutOk := .T.
							Endif
						EndIf
				
						if lLayoutOk //importar somente se layout estiver correto
							//verificar se existe
							dDTVEND := ctod(aString[1])
							dDTPGTO := ctod(aString[2])
							nQTDCV := val(replace(replace(replace(aString[3],'"',''),'.',''),',','.'))
							cNUMRV := replace(aString[4],'"','')
							cNUMPV := replace(aString[5],'"','')
							nVLVEND := val(replace(replace(replace(aString[6],'"',''),'.',''),',','.'))
							nVLAPUR := val(replace(replace(replace(aString[7],'"',''),'.',''),',','.'))
							nVALOR := val(replace(replace(replace(aString[8],'"',''),'.',''),',','.'))
							cTIPO := aString[9]
				
							cQuery := "SELECT * FROM "+ RetSqlName("ZYC") +" ZYC WHERE ZYC_FILIAL='"+ xFilial("ZYV") +"' AND ZYC_LAYOUT='"+ cLayout +"' AND ZYC_DTVEND='"+ dtos(dDTVEND) +"' AND ZYC_DTPGTO='"+ dtos(dDTPGTO) +"' AND ZYC_QTDCV="+ alltrim(str(nQTDCV)) +" AND ZYC_NUMRV='"+ cNUMRV +"' AND ZYC_NUMPV='"+ cNUMPV +"' AND D_E_L_E_T_<>'*'"
							MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "ZYCCONS", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
							DbSelectArea("ZYCCONS")
							If EOF() //importar
								DBSelectArea("ZYC")
								RECLOCK("ZYC",.T.)  //INSERIR .T.
									ZYC->ZYC_FILIAL  := xfilial("ZYC")
									ZYC->ZYC_LAYOUT := cLayout
									ZYC->ZYC_DTVEND := dDTVEND
									ZYC->ZYC_DTPGTO := dDTPGTO
									ZYC->ZYC_QTDCV := nQTDCV
									ZYC->ZYC_NUMRV := cNUMRV
									ZYC->ZYC_NUMPV := cNUMPV
									ZYC->ZYC_VLVEND := nVLVEND
									ZYC->ZYC_VLAPUR := nVLAPUR
									ZYC->ZYC_VALOR := nVALOR
									ZYC->ZYC_TIPO := cTIPO  
								MSUNLOCK("ZYC")
							EndIf
							DBSelectArea("ZYCCONS")
							DBCloseArea()
						endif
				
				EndIf
				
				nLinha += 1
				FT_FSKIP()   //proximo registro no arquivo txt
			Enddo //while ler linhas arquivo
			
			If !Empty(cMsgErro)
				MsgAlert(cMSgErro)
			EndIf
			
			//verificar se todas as linhas foram processadas
			if nLinha >= FT_FLASTREC()
				bArqProcOk := .T.
			else
				bArqProcOk := .F.
			endif
			
			FT_FUSE()  //fecha o arquivo txt
		
		Else //arquivo nao encontrado
			MsgAlert("Arquivo texto: "+cArq+" nao localizado")
		Endif
	
		//somente renomear se arquivo inteiro tiver sido processado
		if bArqProcOk
			//try
				cArq := Alltrim(StrTran(cArq,"//","/"))
				cArq := Alltrim(StrTran(cArq,"\\","\"))
				FRENAME(cArq, cArq+'.OK')
			//catch e as IdxException
				//ConOut( ProcName() + " " + Str(ProcLine()) + " " + e:cErrorText )
			//end try
		endif
	
	Next nArq //arquivo
else
	MsgAlert("Informe o diretorio dos arquivos das Operadoras de Cartão de Crédito")
endif


Return              

           




Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
aAdd(aRegs,{cPerg,"01","Operadora","Operadora","Operadora","mv_ch1","N",01,0,2,"C","","MV_PAR01","Cielo","Cielo","Cielo","","","Redecard","Redecard","Redecard","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Diretorio","Diretorio","Diretorio","mv_ch2","C",50,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
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
