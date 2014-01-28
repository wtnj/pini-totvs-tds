#INCLUDE "rwmake.ch"
/*/          Alterado por Danilo C S Pala, em 20041014
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
User Function RFATR51()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Private CbTxt       := ""
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 220
Private tamanho     := "G"
Private nomeprog    := "RFATR51" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo       := 18
Private aReturn     := {"Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private MHORA := TIME()
Private wnrel       := "RFATR51_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2) // Coloque aqui o nome do arquivo usado para impressao em disco
Private cPerg       := "FATR51"
Private cString     := "SE1"
Private cNatureza   := ""
Private cGrupo      := ""
Private aOrd          := {}
Private cDesc1        := "Este programa tem como objetivo imprimir relatorio "
Private cDesc2        := "de acordo com os parametros informados pelo usuario."
Private cDesc3        := "Aging - Contas a Receber"
Private cPict         := ""
Private titulo        := "Aging - Contas a Receber"
Private nLin          := 80
Private Cabec1        := "Produto                     Ate            11 a          21 a          31 a          61 a          91 a         121 a         151 a             >"
Private Cabec2        := "Ativo      Liquid.        10 dd     %     20 dd   %     30 dd   %     60 dd   %     90 dd   %    120 dd   %    150 dd   %    180 dd   %    180 dd   %        Total    %"
Private imprime       := .T.

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

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento. Processa() monta janela com a regua de processamento. ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Processa({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Processa({|| Imprime()},Titulo)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

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
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local nOrdem
Local cQuerySE1 := ""

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


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCria Arquivo de Trabalhoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
AADD(aFields,{"GRUPO"	,"C"	,6	,0})
AADD(aFields,{"NATUREZA","C"	,10	,0})
AADD(aFields,{"VALOR"	,"N"	,14	,2})
AADD(aFields,{"DIASVENC","N"	,4	,0})
AADD(aFields,{"PREFIXO" ,"C"	,3	,0})
AADD(aFields,{"NUMERO"  ,"C"	,6	,0})
AADD(aFields,{"PARCELA" ,"C"	,1	,0})
AADD(aFields,{"ITEM"	,"C"	,2	,0})

cArq   := CriaTrab(aFields,.T.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "GRUPO+NATUREZA+PREFIXO+NUMERO+PARCELA+ITEM"

DbUseArea(.T.,,cArq,"IMP",.f.,.f.)
DbSelectArea("IMP")

MsAguarde({|| Indregua("IMP",cIndex,cKey,,,"")},"Aguarde","Gerando Indice Temporario...")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicializa a Queryณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cQuerySE1 += "SELECT * FROM " + RetSqlName("SE1") + " SE1"
cQuerySE1 += " WHERE SE1.E1_FILIAL = '" + xFilial("SE1") + "'"
cQuerySE1 += " AND SE1.E1_VENCTO < '" + DTOS(MV_PAR01) +  "'"
cQuerySE1 += " AND SE1.D_E_L_E_T_ <> '*' "
cQuerySE1 += " ORDER BY SE1.E1_VENCTO, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA"

lEnd := .f.

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
	DbSelectArea("SC5")
	DbSetOrder(1)
	DbSeek(xFilial("SC5")+TRB->E1_PEDIDO)
	
	DbSelectArea("SF2")
	DbSetOrder(1)
	If DbSeek(xFilial("SF2")+TRB->E1_NUM+TRB->E1_PREFIXO)
		If Found()
			mValfat  := SF2->F2_VALFAT
			mCliente := SF2->F2_CLIENTE
		Endif
		
		DbSelectArea("SD2")
		DbSetOrder(3)
		If DbSeek(xFilial("SD2")+SF2->F2_DOC+SF2->F2_SERIE)
			While !Eof() .and. xFilial("SD2") == SD2->D2_FILIAL .and. SD2->D2_DOC == SF2->F2_DOC .and. SF2->F2_SERIE == SD2->D2_SERIE
				DbSelectArea("IMP")
				If DbSeek(SD2->D2_GRUPO+TRB->E1_NATUREZ+TRB->E1_PREFIXO+TRB->E1_NUM+TRB->E1_PARCELA+SD2->D2_ITEM)
					DbSelectArea("SD2")
					DbSkip()
					Loop
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
				IMP->GRUPO    := SD2->D2_GRUPO
				IMP->NATUREZA := TRB->E1_NATUREZ
				IMP->VALOR    := SD2->D2_TOTAL
				IMP->DIASVENC := IIF((MV_PAR01-TRB->E1_VENCTO)>0,(MV_PAR01-TRB->E1_VENCTO),0)
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

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImprime() บAutor  ณMarcos Farineli     บ Data ณ  08/19/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Faz a impressao do relatorio                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Imprime()

Local nInd := 0

//			  1	 2   3   4   5   6   7   8   9
aEmitidos := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aEmiTot   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aPagos    := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aPagTot   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aNaoPago  := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aNaoPTot  := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aCanc     := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aCanTot   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aLucPer   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aLPTot    := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aEmiGrp   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aPagGrp   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aNaoPGrp  := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aCanGrp   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
aLPGrp    := {0	,0	,0	,0	,0	,0	,0	,0	,0}

// Estrutura dos arrays
// Posicao	1	2	3	4	5	6	7	8	9	
// Dias		10	20	30	60	90	120	150	180	>180			

nLin := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
nLin++

DbSelectArea("IMP")
ProcRegua(RecCount())
DbGoTop()
cNatureza := IMP->NATUREZA
cGrupo    := IMP->GRUPO
While !Eof()
	IncProc("Imprimindo...")
	If cNatureza <> IMP->NATUREZA
		ImprResNat()
		aEmitidos := {0	,0	,0	,0	,0	,0	,0	,0	,0}
		aPagos    := {0	,0	,0	,0	,0	,0	,0	,0	,0}
		aNaoPago  := {0	,0	,0	,0	,0	,0	,0	,0	,0}
		aCanc     := {0	,0	,0	,0	,0	,0	,0	,0	,0}
		aLucPer   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
	EndIf	
	If cGrupo <> IMP->GRUPO
		Roda(0,"",tamanho)
	    nLin := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
	    nLin += 2

		DbSelectArea("SBM")
		DbSetOrder(1)
		DbSeek(xFilial("SBM")+cGrupo)
		cDescGrupo := SBM->BM_DESC
	    
	    @ nLin, 000 Psay "Grupo de Produtos: "+cGrupo+" - "+cDescGrupo
	    ImprResNat()
	    ImprResGrupo()
		aEmitidos := {0	,0	,0	,0	,0	,0	,0	,0	,0}
		aPagos    := {0	,0	,0	,0	,0	,0	,0	,0	,0}
		aNaoPago  := {0	,0	,0	,0	,0	,0	,0	,0	,0}
		aCanc     := {0	,0	,0	,0	,0	,0	,0	,0	,0}
		aLucPer   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
		aEmiGrp   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
		aPagGrp   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
		aNaoPGrp  := {0	,0	,0	,0	,0	,0	,0	,0	,0}
		aCanGrp   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
		aLPGrp    := {0	,0	,0	,0	,0	,0	,0	,0	,0}
	EndIf
	//{"GRUPO"	  ,"C"	,6	,0}
	//{"NATUREZA" ,"C"	,10	,0}
	//{"VALOR"	  ,"N"	,14	,2}
	//{"DIASVENC" ,"N"	,4	,0}
	//{"PREFIXO"  ,"C"	,3	,0}
	//{"NUMERO"   ,"C"	,6	,0}
	//{"PARCELA"  ,"C"	,1	,0}
	//{"ITEM"	  ,"C"	,2	,0}
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณAvalia totaisณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If IMP->DIASVENC >180 
		aEmitidos[9] += IMP->VALOR
		nInd         := 9
	ElseIf IMP->DIASVENC <= 180 .and. IMP->DIASVENC > 150
		aEmitidos[8] += IMP->VALOR
		nInd         := 8
	ElseIf IMP->DIASVENC <= 150 .and. IMP->DIASVENC > 120
		aEmitidos[7] += IMP->VALOR
		nInd         := 7
	ElseIf IMP->DIASVENC <= 120 .and. IMP->DIASVENC > 90
		aEmitidos[6] += IMP->VALOR
		nInd         := 6
	ElseIf IMP->DIASVENC <= 90 .and. IMP->DIASVENC > 60
		aEmitidos[5] += IMP->VALOR
		nInd         := 5
	ElseIf IMP->DIASVENC <= 60 .and. IMP->DIASVENC > 30
		aEmitidos[4] += IMP->VALOR
		nInd         := 4	
	ElseIf IMP->DIASVENC <= 30 .and. IMP->DIASVENC > 20
		aEmitidos[3] += IMP->VALOR
		nInd         := 3		
	ElseIf IMP->DIASVENC <= 20 .and. IMP->DIASVENC > 10
		aEmitidos[2] += IMP->VALOR
		nInd         := 2				
	ElseIf IMP->DIASVENC <= 10
		aEmitidos[1] += IMP->VALOR
		nInd         := 1		
	EndIf
	
	aEmiTot[nInd] += IMP->VALOR
	aEmiGrp[nInd] += IMP->VALOR
	
	DbSelectArea("SE1")
	DbSetOrder(1)
	DbSeek(xFilial("SE1")+IMP->PREFIXO+IMP->NUMERO+IMP->PARCELA)
	If DTOS(SE1->E1_BAIXA) <> "        "
		If SE1->E1_SALDO == 0 .and. !SE1->E1_PORTADO$"920/904/930"  //20041014
			aPagos[nInd]  += IMP->VALOR
		    aPagTot[nInd] += IMP->VALOR
		    aPagGrp[nInd] += IMP->VALOR
		ElseIf SE1->E1_PORTADO == "920" .or. SE1->E1_PORTADO == "930" .or. Alltrim(SE1->E1_MOTIVO) == "CAN"  //20041014
			aCanc[nInd]   += IMP->VALOR
			aCanTot[nInd] += IMP->VALOR
			aCanGrp       += IMP->VALOR
		ElseIf SE1->E1_PORTADO == "904" .or. Alltrim(SE1->E1_MOTIVO) == "LP"
			aLucPer[nInd] += IMP->VALOR
			aLPTot[nInd]  += IMP->VALOR
			aLPGrp[nInd]  += IMP->VALOR
		EndIf
	Else
		aPagos[nInd] += IMP->VALOR
		aPagTot[nInd]+= IMP->VALOR
	    aPagGrp[nInd]+= IMP->VALOR
	EndIf
	cGrupo    := IMP->GRUPO
	cNatureza := IMP->NATUREZA
	DbSelectArea("IMP")
	DbSkip()
End

ImprResNat()
ImprResGrupo()
//ImprResTot()	

	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImpResNat บAutor  ณMarcos Farineli     บ Data ณ  08/20/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime resumo de naturezas                                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImprResNat()

Local nSoma  := 0
Local nCount := 0
// Regua de Posicionamento
//           1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
// Produto                     Ate            11 a          21 a          31 a          61 a          91 a         121 a         151 a             >
// Ativo      Liquid.        10 dd     %     20 dd   %     30 dd   %     60 dd   %     90 dd   %    120 dd   %    150 dd   %    180 dd   %    180 dd   %        Total    %
// XXXXXXXXXX XXXXXXXXXX   999.999   999   999.999 999   999.999 999   999.999 999   999.999 999   999.999 999   999.999 999   999.999 999   999.999 999   999.999.999 999

For nCount := 1 to 9
	nSoma += aEmitidos[nCount]
Next nCount

Linha()
@ nLin, 000 Psay cNatureza
@ nLin, 010 Psay "Emitido"
@ nLin, 024 Psay Abs(aEmitidos[1]) Picture "@E 999,999"
@ nLin, 034 Psay Abs(aEmitidos[1]*100/nSoma) Picture "@E 999"
@ nLin, 040 Psay Abs(aEmitidos[2]) Picture "@E 999,999"
@ nLin, 048 Psay Abs(aEmitidos[2]*100/nSoma) Picture "@E 999"
@ nLin, 054 Psay Abs(aEmitidos[3]) Picture "@E 999,999"
@ nLin, 062 Psay Abs(aEmitidos[3]*100/nSoma) Picture "@E 999"
@ nLin, 068 Psay Abs(aEmitidos[4]) Picture "@E 999,999"
@ nLin, 076 Psay Abs(aEmitidos[4]*100/nSoma) Picture "@E 999"
@ nLin, 082 Psay Abs(aEmitidos[5]) Picture "@E 999,999"
@ nLin, 090 Psay Abs(aEmitidos[5]*100/nSoma) Picture "@E 999"
@ nLin, 096 Psay Abs(aEmitidos[6]) Picture "@E 999,999"
@ nLin, 104 Psay Abs(aEmitidos[6]*100/nSoma) Picture "@E 999"
@ nLin, 110 Psay Abs(aEmitidos[7]) Picture "@E 999,999"
@ nLin, 118 Psay Abs(aEmitidos[7]*100/nSoma) Picture "@E 999"
@ nLin, 124 Psay Abs(aEmitidos[8]) Picture "@E 999,999"
@ nLin, 132 Psay Abs(aEmitidos[8]*100/nSoma) Picture "@E 999"
@ nLin, 138 Psay Abs(aEmitidos[9]) Picture "@E 999,999"
@ nLin, 146 Psay Abs(aEmitidos[9]*100/nSoma) Picture "@E 999" 
@ nLin, 152 PSay Abs(nSoma) Picture "@E 999,999,999.99"
@ nLin, 152 PSay Abs(nSoma*100/nSoma) Picture "@E 999"
Linha()
For nCount := 1 to 9
	nSoma += aPagos[nCount]
Next nCount
@ nLin, 010 Psay "Pago"
@ nLin, 024 Psay Abs(aPagos[1]) Picture "@E 999,999"
@ nLin, 034 Psay Abs(aPagos[1]*100/nSoma) Picture "@E 999"
@ nLin, 040 Psay Abs(aPagos[2]) Picture "@E 999,999"
@ nLin, 048 Psay Abs(aPagos[2]*100/nSoma) Picture "@E 999"
@ nLin, 054 Psay Abs(aPagos[3]) Picture "@E 999,999"
@ nLin, 062 Psay Abs(aPagos[3]*100/nSoma) Picture "@E 999"
@ nLin, 068 Psay Abs(aPagos[4]) Picture "@E 999,999"
@ nLin, 076 Psay Abs(aPagos[4]*100/nSoma) Picture "@E 999"
@ nLin, 082 Psay Abs(aPagos[5]) Picture "@E 999,999"
@ nLin, 090 Psay Abs(aPagos[5]*100/nSoma) Picture "@E 999"
@ nLin, 096 Psay Abs(aPagos[6]) Picture "@E 999,999"
@ nLin, 104 Psay Abs(aPagos[6]*100/nSoma) Picture "@E 999"
@ nLin, 110 Psay Abs(aPagos[7]) Picture "@E 999,999"
@ nLin, 118 Psay Abs(aPagos[7]*100/nSoma) Picture "@E 999"
@ nLin, 124 Psay Abs(aPagos[8]) Picture "@E 999,999"
@ nLin, 132 Psay Abs(aPagos[8]*100/nSoma) Picture "@E 999"
@ nLin, 138 Psay Abs(aPagos[9]) Picture "@E 999,999"
@ nLin, 146 Psay Abs(aPagos[9]*100/nSoma) Picture "@E 999" 
@ nLin, 152 PSay Abs(nSoma) Picture "@E 999,999,999.99"
@ nLin, 152 PSay Abs(nSoma*100/nSoma) Picture "@E 999"
Linha()
For nCount := 1 to 9
	nSoma += aNaoPago[nCount]
Next nCount
@ nLin, 010 Psay "Pago"
@ nLin, 024 Psay Abs(aNaoPago[1]) Picture "@E 999,999"
@ nLin, 034 Psay Abs(aNaoPago[1]*100/nSoma) Picture "@E 999"
@ nLin, 040 Psay Abs(aNaoPago[2]) Picture "@E 999,999"
@ nLin, 048 Psay Abs(aNaoPago[2]*100/nSoma) Picture "@E 999"
@ nLin, 054 Psay Abs(aNaoPago[3]) Picture "@E 999,999"
@ nLin, 062 Psay Abs(aNaoPago[3]*100/nSoma) Picture "@E 999"
@ nLin, 068 Psay Abs(aNaoPago[4]) Picture "@E 999,999"
@ nLin, 076 Psay Abs(aNaoPago[4]*100/nSoma) Picture "@E 999"
@ nLin, 082 Psay Abs(aNaoPago[5]) Picture "@E 999,999"
@ nLin, 090 Psay Abs(aNaoPago[5]*100/nSoma) Picture "@E 999"
@ nLin, 096 Psay Abs(aNaoPago[6]) Picture "@E 999,999"
@ nLin, 104 Psay Abs(aNaoPago[6]*100/nSoma) Picture "@E 999"
@ nLin, 110 Psay Abs(aNaoPago[7]) Picture "@E 999,999"
@ nLin, 118 Psay Abs(aNaoPago[7]*100/nSoma) Picture "@E 999"
@ nLin, 124 Psay Abs(aNaoPago[8]) Picture "@E 999,999"
@ nLin, 132 Psay Abs(aNaoPago[8]*100/nSoma) Picture "@E 999"
@ nLin, 138 Psay Abs(aNaoPago[9]) Picture "@E 999,999"
@ nLin, 146 Psay Abs(aNaoPago[9]*100/nSoma) Picture "@E 999" 
@ nLin, 152 PSay Abs(nSoma) Picture "@E 999,999,999.99"
@ nLin, 152 PSay Abs(nSoma*100/nSoma) Picture "@E 999"
Linha()
For nCount := 1 to 9
	nSoma += aCanc[nCount]
Next nCount
@ nLin, 010 Psay "Pago"
@ nLin, 024 Psay Abs(aCanc[1]) Picture "@E 999,999"
@ nLin, 034 Psay Abs(aCanc[1]*100/nSoma) Picture "@E 999"
@ nLin, 040 Psay Abs(aCanc[2]) Picture "@E 999,999"
@ nLin, 048 Psay Abs(aCanc[2]*100/nSoma) Picture "@E 999"
@ nLin, 054 Psay Abs(aCanc[3]) Picture "@E 999,999"
@ nLin, 062 Psay Abs(aCanc[3]*100/nSoma) Picture "@E 999"
@ nLin, 068 Psay Abs(aCanc[4]) Picture "@E 999,999"
@ nLin, 076 Psay Abs(aCanc[4]*100/nSoma) Picture "@E 999"
@ nLin, 082 Psay Abs(aCanc[5]) Picture "@E 999,999"
@ nLin, 090 Psay Abs(aCanc[5]*100/nSoma) Picture "@E 999"
@ nLin, 096 Psay Abs(aCanc[6]) Picture "@E 999,999"
@ nLin, 104 Psay Abs(aCanc[6]*100/nSoma) Picture "@E 999"
@ nLin, 110 Psay Abs(aCanc[7]) Picture "@E 999,999"
@ nLin, 118 Psay Abs(aCanc[7]*100/nSoma) Picture "@E 999"
@ nLin, 124 Psay Abs(aCanc[8]) Picture "@E 999,999"
@ nLin, 132 Psay Abs(aCanc[8]*100/nSoma) Picture "@E 999"
@ nLin, 138 Psay Abs(aCanc[9]) Picture "@E 999,999"
@ nLin, 146 Psay Abs(aCanc[9]*100/nSoma) Picture "@E 999" 
@ nLin, 152 PSay Abs(nSoma) Picture "@E 999,999,999.99"
@ nLin, 152 PSay Abs(nSoma*100/nSoma) Picture "@E 999" 
Linha()
For nCount := 1 to 9
	nSoma += aLucPer[nCount]
Next nCount
@ nLin, 010 Psay "Pago"
@ nLin, 024 Psay Abs(aLucPer[1]) Picture "@E 999,999"
@ nLin, 034 Psay Abs(aLucPer[1]*100/nSoma) Picture "@E 999"
@ nLin, 040 Psay Abs(aLucPer[2]) Picture "@E 999,999"
@ nLin, 048 Psay Abs(aLucPer[2]*100/nSoma) Picture "@E 999"
@ nLin, 054 Psay Abs(aLucPer[3]) Picture "@E 999,999"
@ nLin, 062 Psay Abs(aLucPer[3]*100/nSoma) Picture "@E 999"
@ nLin, 068 Psay Abs(aLucPer[4]) Picture "@E 999,999"
@ nLin, 076 Psay Abs(aLucPer[4]*100/nSoma) Picture "@E 999"
@ nLin, 082 Psay Abs(aLucPer[5]) Picture "@E 999,999"
@ nLin, 090 Psay Abs(aLucPer[5]*100/nSoma) Picture "@E 999"
@ nLin, 096 Psay Abs(aLucPer[6]) Picture "@E 999,999"
@ nLin, 104 Psay Abs(aLucPer[6]*100/nSoma) Picture "@E 999"
@ nLin, 110 Psay Abs(aLucPer[7]) Picture "@E 999,999"
@ nLin, 118 Psay Abs(aLucPer[7]*100/nSoma) Picture "@E 999"
@ nLin, 124 Psay Abs(aLucPer[8]) Picture "@E 999,999"
@ nLin, 132 Psay Abs(aLucPer[8]*100/nSoma) Picture "@E 999"
@ nLin, 138 Psay Abs(aLucPer[9]) Picture "@E 999,999"
@ nLin, 146 Psay Abs(aLucPer[9]*100/nSoma) Picture "@E 999" 
@ nLin, 152 PSay Abs(nSoma) Picture "@E 999,999,999.99"
@ nLin, 152 PSay Abs(nSoma*100/nSoma) Picture "@E 999" 
Linha()
Linha()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImprResGr บAutor  ณMarcos Farineli     บ Data ณ  08/20/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImprime resumo de naturezas                                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImprResGrupo()

Local nSoma  := 0
Local nCount := 0

// Regua de Posicionamento
//           1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16        
// 01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
// Produto                     Ate            11 a          21 a          31 a          61 a          91 a         121 a         151 a             >
// Ativo      Liquid.        10 dd     %     20 dd   %     30 dd   %     60 dd   %     90 dd   %    120 dd   %    150 dd   %    180 dd   %    180 dd   %        Total    %
// XXXXXXXXXX XXXXXXXXXX   999.999   999   999.999 999   999.999 999   999.999 999   999.999 999   999.999 999   999.999 999   999.999 999   999.999 999   999.999.999 999
//aEmiGrp   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
//aPagGrp   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
//aNaoPGrp  := {0	,0	,0	,0	,0	,0	,0	,0	,0}
//aCanGrp   := {0	,0	,0	,0	,0	,0	,0	,0	,0}
//aLPGrp    := {0	,0	,0	,0	,0	,0	,0	,0	,0}

For nCount := 1 to 9
	nSoma += aEmiGrp[nCount]
Next nCount

Linha()
@ nLin, 000 Psay cNatureza
@ nLin, 010 Psay "Emitido"
@ nLin, 024 Psay Abs(aEmiGrp[1]) Picture "@E 999,999"
@ nLin, 034 Psay Abs(aEmiGrp[1]*100/nSoma) Picture "@E 999"
@ nLin, 040 Psay Abs(aEmiGrp[2]) Picture "@E 999,999"
@ nLin, 048 Psay Abs(aEmiGrp[2]*100/nSoma) Picture "@E 999"
@ nLin, 054 Psay Abs(aEmiGrp[3]) Picture "@E 999,999"
@ nLin, 062 Psay Abs(aEmiGrp[3]*100/nSoma) Picture "@E 999"
@ nLin, 068 Psay Abs(aEmiGrp[4]) Picture "@E 999,999"
@ nLin, 076 Psay Abs(aEmiGrp[4]*100/nSoma) Picture "@E 999"
@ nLin, 082 Psay Abs(aEmiGrp[5]) Picture "@E 999,999"
@ nLin, 090 Psay Abs(aEmiGrp[5]*100/nSoma) Picture "@E 999"
@ nLin, 096 Psay Abs(aEmiGrp[6]) Picture "@E 999,999"
@ nLin, 104 Psay Abs(aEmiGrp[6]*100/nSoma) Picture "@E 999"
@ nLin, 110 Psay Abs(aEmiGrp[7]) Picture "@E 999,999"
@ nLin, 118 Psay Abs(aEmiGrp[7]*100/nSoma) Picture "@E 999"
@ nLin, 124 Psay Abs(aEmiGrp[8]) Picture "@E 999,999"
@ nLin, 132 Psay Abs(aEmiGrp[8]*100/nSoma) Picture "@E 999"
@ nLin, 138 Psay Abs(aEmiGrp[9]) Picture "@E 999,999"
@ nLin, 146 Psay Abs(aEmiGrp[9]*100/nSoma) Picture "@E 999" 
@ nLin, 152 PSay Abs(nSoma) Picture "@E 999,999,999.99"
@ nLin, 152 PSay Abs(nSoma*100/nSoma) Picture "@E 999"
Linha()
For nCount := 1 to 9
	nSoma += aPagGrp[nCount]
Next nCount
@ nLin, 010 Psay "Pago"
@ nLin, 024 Psay Abs(aPagGrp[1]) Picture "@E 999,999"
@ nLin, 034 Psay Abs(aPagGrp[1]*100/nSoma) Picture "@E 999"
@ nLin, 040 Psay Abs(aPagGrp[2]) Picture "@E 999,999"
@ nLin, 048 Psay Abs(aPagGrp[2]*100/nSoma) Picture "@E 999"
@ nLin, 054 Psay Abs(aPagGrp[3]) Picture "@E 999,999"
@ nLin, 062 Psay Abs(aPagGrp[3]*100/nSoma) Picture "@E 999"
@ nLin, 068 Psay Abs(aPagGrp[4]) Picture "@E 999,999"
@ nLin, 076 Psay Abs(aPagGrp[4]*100/nSoma) Picture "@E 999"
@ nLin, 082 Psay Abs(aPagGrp[5]) Picture "@E 999,999"
@ nLin, 090 Psay Abs(aPagGrp[5]*100/nSoma) Picture "@E 999"
@ nLin, 096 Psay Abs(aPagGrp[6]) Picture "@E 999,999"
@ nLin, 104 Psay Abs(aPagGrp[6]*100/nSoma) Picture "@E 999"
@ nLin, 110 Psay Abs(aPagGrp[7]) Picture "@E 999,999"
@ nLin, 118 Psay Abs(aPagGrp[7]*100/nSoma) Picture "@E 999"
@ nLin, 124 Psay Abs(aPagGrp[8]) Picture "@E 999,999"
@ nLin, 132 Psay Abs(aPagGrp[8]*100/nSoma) Picture "@E 999"
@ nLin, 138 Psay Abs(aPagGrp[9]) Picture "@E 999,999"
@ nLin, 146 Psay Abs(aPagGrp[9]*100/nSoma) Picture "@E 999" 
@ nLin, 152 PSay Abs(nSoma) Picture "@E 999,999,999.99"
@ nLin, 152 PSay Abs(nSoma*100/nSoma) Picture "@E 999"
Linha()
For nCount := 1 to 9
	nSoma += aNaoPGrp[nCount]
Next nCount
@ nLin, 010 Psay "Pago"
@ nLin, 024 Psay Abs(aNaoPGrp[1]) Picture "@E 999,999"
@ nLin, 034 Psay Abs(aNaoPGrp[1]*100/nSoma) Picture "@E 999"
@ nLin, 040 Psay Abs(aNaoPGrp[2]) Picture "@E 999,999"
@ nLin, 048 Psay Abs(aNaoPGrp[2]*100/nSoma) Picture "@E 999"
@ nLin, 054 Psay Abs(aNaoPGrp[3]) Picture "@E 999,999"
@ nLin, 062 Psay Abs(aNaoPGrp[3]*100/nSoma) Picture "@E 999"
@ nLin, 068 Psay Abs(aNaoPGrp[4]) Picture "@E 999,999"
@ nLin, 076 Psay Abs(aNaoPGrp[4]*100/nSoma) Picture "@E 999"
@ nLin, 082 Psay Abs(aNaoPGrp[5]) Picture "@E 999,999"
@ nLin, 090 Psay Abs(aNaoPGrp[5]*100/nSoma) Picture "@E 999"
@ nLin, 096 Psay Abs(aNaoPGrp[6]) Picture "@E 999,999"
@ nLin, 104 Psay Abs(aNaoPGrp[6]*100/nSoma) Picture "@E 999"
@ nLin, 110 Psay Abs(aNaoPGrp[7]) Picture "@E 999,999"
@ nLin, 118 Psay Abs(aNaoPGrp[7]*100/nSoma) Picture "@E 999"
@ nLin, 124 Psay Abs(aNaoPGrp[8]) Picture "@E 999,999"
@ nLin, 132 Psay Abs(aNaoPGrp[8]*100/nSoma) Picture "@E 999"
@ nLin, 138 Psay Abs(aNaoPGrp[9]) Picture "@E 999,999"
@ nLin, 146 Psay Abs(aNaoPGrp[9]*100/nSoma) Picture "@E 999" 
@ nLin, 152 PSay Abs(nSoma) Picture "@E 999,999,999.99"
@ nLin, 152 PSay Abs(nSoma*100/nSoma) Picture "@E 999"
Linha()
For nCount := 1 to 9
	nSoma += aCanGrp[nCount]
Next nCount
@ nLin, 010 Psay "Pago"
@ nLin, 024 Psay Abs(aCanGrp[1]) Picture "@E 999,999"
@ nLin, 034 Psay Abs(aCanGrp[1]*100/nSoma) Picture "@E 999"
@ nLin, 040 Psay Abs(aCanGrp[2]) Picture "@E 999,999"
@ nLin, 048 Psay Abs(aCanGrp[2]*100/nSoma) Picture "@E 999"
@ nLin, 054 Psay Abs(aCanGrp[3]) Picture "@E 999,999"
@ nLin, 062 Psay Abs(aCanGrp[3]*100/nSoma) Picture "@E 999"
@ nLin, 068 Psay Abs(aCanGrp[4]) Picture "@E 999,999"
@ nLin, 076 Psay Abs(aCanGrp[4]*100/nSoma) Picture "@E 999"
@ nLin, 082 Psay Abs(aCanGrp[5]) Picture "@E 999,999"
@ nLin, 090 Psay Abs(aCanGrp[5]*100/nSoma) Picture "@E 999"
@ nLin, 096 Psay Abs(aCanGrp[6]) Picture "@E 999,999"
@ nLin, 104 Psay Abs(aCanGrp[6]*100/nSoma) Picture "@E 999"
@ nLin, 110 Psay Abs(aCanGrp[7]) Picture "@E 999,999"
@ nLin, 118 Psay Abs(aCanGrp[7]*100/nSoma) Picture "@E 999"
@ nLin, 124 Psay Abs(aCanGrp[8]) Picture "@E 999,999"
@ nLin, 132 Psay Abs(aCanGrp[8]*100/nSoma) Picture "@E 999"
@ nLin, 138 Psay Abs(aCanGrp[9]) Picture "@E 999,999"
@ nLin, 146 Psay Abs(aCanGrp[9]*100/nSoma) Picture "@E 999" 
@ nLin, 152 PSay Abs(nSoma) Picture "@E 999,999,999.99"
@ nLin, 152 PSay Abs(nSoma*100/nSoma) Picture "@E 999" 
Linha()
For nCount := 1 to 9
	nSoma += aLPGRP[nCount]
Next nCount
@ nLin, 010 Psay "Pago"
@ nLin, 024 Psay Abs(aLPGRP[1]) Picture "@E 999,999"
@ nLin, 034 Psay Abs(aLPGRP[1]*100/nSoma) Picture "@E 999"
@ nLin, 040 Psay Abs(aLPGRP[2]) Picture "@E 999,999"
@ nLin, 048 Psay Abs(aLPGRP[2]*100/nSoma) Picture "@E 999"
@ nLin, 054 Psay Abs(aLPGRP[3]) Picture "@E 999,999"
@ nLin, 062 Psay Abs(aLPGRP[3]*100/nSoma) Picture "@E 999"
@ nLin, 068 Psay Abs(aLPGRP[4]) Picture "@E 999,999"
@ nLin, 076 Psay Abs(aLPGRP[4]*100/nSoma) Picture "@E 999"
@ nLin, 082 Psay Abs(aLPGRP[5]) Picture "@E 999,999"
@ nLin, 090 Psay Abs(aLPGRP[5]*100/nSoma) Picture "@E 999"
@ nLin, 096 Psay Abs(aLPGRP[6]) Picture "@E 999,999"
@ nLin, 104 Psay Abs(aLPGRP[6]*100/nSoma) Picture "@E 999"
@ nLin, 110 Psay Abs(aLPGRP[7]) Picture "@E 999,999"
@ nLin, 118 Psay Abs(aLPGRP[7]*100/nSoma) Picture "@E 999"
@ nLin, 124 Psay Abs(aLPGRP[8]) Picture "@E 999,999"
@ nLin, 132 Psay Abs(aLPGRP[8]*100/nSoma) Picture "@E 999"
@ nLin, 138 Psay Abs(aLPGRP[9]) Picture "@E 999,999"
@ nLin, 146 Psay Abs(aLPGRP[9]*100/nSoma) Picture "@E 999" 
@ nLin, 152 PSay Abs(nSoma) Picture "@E 999,999,999.99"
@ nLin, 152 PSay Abs(nSoma*100/nSoma) Picture "@E 999" 
Linha()
Linha()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLinha()   บAutor  ณMarcos Farineli     บ Data ณ  08/20/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Incrementa linha e controla pagina                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Linha()

If nLin > 55
	Roda(0,"",tamanho)
    nLin := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18)
    nLin += 2
Else
	nLin++
EndIf

Return