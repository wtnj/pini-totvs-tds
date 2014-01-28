#INCLUDE "rwmake.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRFATR51() บ Autor ณ Marcos Farineli    บ Data ณ  15/08/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Aging - Contas a Receber.                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function RFATR51A()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Private lEnd        := .F.
Private cPerg       := "FATR51"
Private cNatureza   := ""
Private cGrupo      := ""
Private mHora       := Time()
Private cString     := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
Private cArqPath    := GetMv("MV_PATHTMP")
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณParametros                 ณ
//ณ                           ณ
//ณmv_par01 - Data Base?      ณ
//ณmv_par02 - Da Natureza ?   ณ
//ณmv_par03 - Ate a Natureza ?ณ
//ณmv_par04 - Do produto ?    ณ
//ณmv_par05 - Ate o produto?  ณ
//ณmv_par06 - Situacao ?      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !Pergunte(cPerg,.t.)
	Return
EndIf

dbSelectArea("SE1")
dbSetOrder(22) // Filial + Data da Baixa //mp10 era 16

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. Processa() monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Processa({|| RunReport()})

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณRUNREPORT บ Autor ณ AP5 IDE            บ Data ณ  15/08/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function RunReport()

Private aPrazVenc := {}
Private aGrupo    := {}
Private aNatureza := {}
Private aMes      := {}
Private aEmitidos := {}
Private aPagos    := {}
Private aNaoPago  := {}
Private aCanc     := {}
Private aLucPer   := {}
Private aFields   := {}
Private cArq      := ""
Private cIndex    := ""
Private cKey      := ""
Private nValor    := 0
Private cQuerySE1 := ""

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCria Arquivo de Trabalhoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
AADD(aFields,{"GRUPO"	,"C"	,4	,0})
AADD(aFields,{"NATUREZA","C"	,10	,0})
AADD(aFields,{"NAT_BXA" ,"C"	,10	,0})
AADD(aFields,{"VALOR"	,"N"	,14	,2})
AADD(aFields,{"VAL_DUP"	,"N"	,14	,2})
AADD(aFields,{"DIASVENC","N"	,4	,0})
AADD(aFields,{"AGING"	,"C"	,2	,0})
AADD(aFields,{"SITUAC"	,"C"	,2	,0})
AADD(aFields,{"PREFIXO" ,"C"	,3	,0})
AADD(aFields,{"NUMERO"  ,"C"	,6	,0})
AADD(aFields,{"PARCELA" ,"C"	,1	,0})
AADD(aFields,{"ITEM"	,"C"	,2	,0})

cArq   := CriaTrab(aFields,.T.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "GRUPO+NATUREZA+PREFIXO+NUMERO+PARCELA+ITEM"

If Select("IMP") > 0
	DbSelectArea("IMP")
	DbCloseArea()
EndIf	

DbUseArea(.T.,,cArq,"IMP",.f.,.f.)
DbSelectArea("IMP")

MsAguarde({|| Indregua("IMP",cIndex,cKey,,,"")},"Aguarde","Gerando Indice Temporario...")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicializa a Queryณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cQuerySE1 += "SELECT * FROM " + RetSqlName("SE1") + " SE1"
cQuerySE1 += " WHERE SE1.E1_FILIAL = '" + xFilial("SE1") + "'"
If mv_par06 == 1
	cQuerySE1 += " AND SE1.E1_VENCTO < '" + DTOS(MV_PAR01) +  "'"
ElseIf mv_par06 == 2
	cQuerySE1 += " AND SE1.E1_VENCTO >= '" + DTOS(MV_PAR01) +  "'"	
EndIf	
cQuerySE1 += " AND SE1.E1_NATUREZ BETWEEN '" + MV_PAR02 + "' AND '" + MV_PAR03 + "'"
cQuerySE1 += " AND SE1.D_E_L_E_T_ <> '*' "
cQuerySE1 += " ORDER BY SE1.E1_VENCTO, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA"

lEnd := .f.

If Select("TRB") > 0
	DbSelectArea("TRB")
	DbCloseArea()
EndIf	

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuerySE1), "TRB", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณAjusta o tipo do campo de dataณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
TcSetField("TRB","E1_VENCTO"  ,"D")
TcSetField("TRB","E1_BAIXA"   ,"D")
TcSetField("TRB","E1_EMISSAO" ,"D")
TcSetField("TRB","E1_DTALT"   ,"D")

cIndexTRB := CriaTrab(Nil,.F.)
cKeyTRB   := "DTOS(E1_VENCTO)+E1_PREFIXO+E1_NUM+E1_PARCELA"

//DbSelectArea("TRB")
//MsAguarde({|| Indregua("TRB",cIndexTRB,cKeyTRB,,,"")},"Aguarde","Gerando Indice Temporario...")

dbSelectArea("TRB")
ProcRegua(RecCount())
dbGoTop()
While !EOF()
	IncProc("Vencimento: "+ Transform(TRB->E1_VENCTO, "@E 99/99/99"))
	
	DbSelectArea("SF2")
	DbSetOrder(1)
	If DbSeek(xFilial("SF2")+TRB->E1_NUM+TRB->E1_PREFIXO)
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณParametros                 ณ
		//ณ                           ณ
		//ณmv_par01 - Data Base?      ณ
		//ณmv_par02 - Da Natureza ?   ณ
		//ณmv_par03 - Ate a Natureza ?ณ
		//ณmv_par04 - Do produto ?    ณ
		//ณmv_par05 - Ate o produto?  ณ
		//ณmv_par06 - Situacao ?      ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

		DbSelectArea("SD2")
		DbSetOrder(3)
		If DbSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE)
			While !Eof() .and. xFilial("SD2") == SD2->D2_FILIAL .and. SD2->D2_DOC == SF2->F2_DOC .and. SF2->F2_SERIE == SD2->D2_SERIE
				lGravaTot := .f.
				If SD2->D2_COD < mv_par04 .or. SD2->D2_COD > mv_par05 
					DbSelectArea("SD2")
					DbSkip()
					Loop
				EndIf
				
				DbSelectArea("IMP")
				If DbSeek(SD2->D2_GRUPO+TRB->E1_NATUREZ+TRB->E1_PREFIXO+TRB->E1_NUM+TRB->E1_PARCELA+SD2->D2_ITEM)
					DbSelectArea("SD2")
					DbSkip()
					Loop
				EndIf
				
				DbSelectArea("IMP")
				If !DbSeek(SD2->D2_GRUPO+TRB->E1_NATUREZ+TRB->E1_PREFIXO+TRB->E1_NUM+TRB->E1_PARCELA)
					lGravaTot := .t.
				EndIf
								
				//{"GRUPO"	  ,"C"	,6	,0}
				//{"NATUREZA" ,"C"	,10	,0}
				//{"VALOR"	  ,"N"	,14	,2}
				//{"DIASVENC" ,"N"	,4	,0}
				//{"PREFIXO"  ,"C"	,3	,0}
				//{"NUMERO"   ,"C"	,6	,0}
				//{"PARCELA"  ,"C"	,1	,0}
				//{"ITEM"	  ,"C"	,2	,0}
				
				DbSelectArea("IMP")
				RecLock("IMP",.t.)
				IMP->VAL_DUP  := IIF(lGravaTot,TRB->E1_VALOR,0)
				IMP->GRUPO    := SD2->D2_GRUPO
				IMP->NATUREZA := TRB->E1_NATUREZ
				IMP->VALOR    := Round(TRB->E1_VALOR * (SD2->D2_TOTAL/SF2->F2_VALFAT),2)
				IMP->DIASVENC := IIF((MV_PAR01-TRB->E1_VENCTO)>0,(MV_PAR01-TRB->E1_VENCTO),0)
				If IMP->DIASVENC >180 
					IMP->AGING := "9"
				ElseIf IMP->DIASVENC <= 180 .and. IMP->DIASVENC > 150
					IMP->AGING := "8"
				ElseIf IMP->DIASVENC <= 150 .and. IMP->DIASVENC > 120
					IMP->AGING := "7"
				ElseIf IMP->DIASVENC <= 120 .and. IMP->DIASVENC > 90
					IMP->AGING := "6"
				ElseIf IMP->DIASVENC <= 90 .and. IMP->DIASVENC > 60
					IMP->AGING := "5"
				ElseIf IMP->DIASVENC <= 60 .and. IMP->DIASVENC > 30
					IMP->AGING := "4"	
				ElseIf IMP->DIASVENC <= 30 .and. IMP->DIASVENC > 20
					IMP->AGING := "3"		
				ElseIf IMP->DIASVENC <= 20 .and. IMP->DIASVENC > 10
					IMP->AGING := "2"				
				ElseIf IMP->DIASVENC <= 10
					IMP->AGING := "1"
				ElseIf IMP->DIASVENC == 0
					IMP->AGING := "0" 
				EndIf
				If DTOS(TRB->E1_BAIXA) <> "        " .and. DTOS(TRB->E1_VENCTO) < DTOS(MV_PAR01)
					If TRB->E1_SALDO == 0 .and. !TRB->E1_PORTADO$"920/904/930" .and. !Alltrim(TRB->E1_MOTIVO) $ "CAN/LP" //20041014
						IMP->SITUAC := "PG"
					    IMP->NAT_BXA:= TRB->E1_NATBX
					ElseIf TRB->E1_PORTADO == "920" .or. TRB->E1_PORTADO == "930" .or. Alltrim(TRB->E1_MOTIVO) == "CAN" //20041014
						IMP->SITUAC := "CN"
					ElseIf TRB->E1_PORTADO == "904" .or. Alltrim(TRB->E1_MOTIVO) == "LP" //20041014
						IMP->SITUAC := "LP"
					EndIf
				ElseIf DTOS(TRB->E1_BAIXA) == "        " .and. DTOS(TRB->E1_VENCTO) < DTOS(MV_PAR01)
					IMP->SITUAC := "NP"
				ElseIf DTOS(TRB->E1_BAIXA) == "        " .and. DTOS(TRB->E1_VENCTO) >= DTOS(MV_PAR01)
					IMP->SITUAC := "AV"				
				EndIf
				IMP->PREFIXO  := TRB->E1_PREFIXO
				IMP->NUMERO   := TRB->E1_NUM
				IMP->PARCELA  := TRB->E1_PARCELA
				IMP->ITEM     := SD2->D2_ITEM
				MsUnlock()
				
				DbSelectArea("SD2")
				Dbskip()
			End
		EndIf // SD2
	EndIf // SF2
	DbSelectArea("TRB")
	dbSkip()
End

DbSelectArea("IMP")
Copy To &(cArqPath+cString+".DBF") VIA "DBFCDXADS" // 20121106 

MsgInfo("Arquivo gerado em "+cArqPath+cString+".DBF")

DbSelectArea("IMP")
DbCloseArea()

DbSelectArea("TRB")
DbCloseArea()

Return