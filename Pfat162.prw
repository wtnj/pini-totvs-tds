#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT162   ºAutor  ³Danilo C S Pala     º Data ³  20041110   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Intercambio de Dados Eletronicos(EDI)      				  º±±
±±º			 |	 importa em SF3(Gold X Pini)						      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Pfat162
Private _cTitulo  := "EDI- Livros Fiscais"
Private cCliefor := "002067"
Private cLoja := "01"                  
Private carquivo := space(11)
Private cProcedimento := space(1)
Private nConta := 0
Private cMsgFinal := space(200)


@ 010,001 TO 300,320 DIALOG oDlg TITLE _cTitulo
@ 005,010 SAY "Arquivo: \siga\Importa\"
@ 005,070 GET carquivo
@ 020,010 SAY "Cliente/Fornec: "
@ 020,070 GET cCLIEFOR VALID .t. F3 "SA2"
@ 035,010 SAY "Loja: "
@ 035,070 GET cLoja
@ 050,020 BMPBUTTON TYPE 1 ACTION Processa({||Importar()})
@ 050,060 BMPBUTTON TYPE 2 ACTION ( Close(oDlg) )
Activate Dialog oDlg CENTERED

Return



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao que importa os dados, conforme o arquivo³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function Importar()
nConta := 0
DBSELECTAREA("SA2")
DBSETORDER(1)
IF DbSeek(xfilial("SA2")+CCLIEFOR+CLOJA)
	CESTADO :=    SA2->A2_EST
END IF          
DBSelectArea("SA2")
DbCloseArea("SA2")

DbSelectArea("SF3")   
DBUSEAREA(.T.,,"\SIGA\IMPORTA\"+ CARQUIVO,"ARQEDI",.F.,.F.)
DbSelectArea("ARQEDI")
cIndex  := CriaTrab(nil,.f.)
cChave  := "NFISCAL+SERIE"
cFiltro := ""
IndRegua("ARQEDI",cIndex,cChave,,cFiltro,"Indexando ...")
Dbgotop()                                                    

if MsgYesNo("Confirma a Importacao do lote: "+ alltrim(str(ARQEDI->LOTE)) + " de "+ dtoC(ARQEDI->DTLOTE) + "?")
  ProcRegua(Reccount())
  While !Eof()
  //	MsgStop(ARQEDI->NFISCAL)      
	DbSelectArea("SF3")   	
	RecLock("SF3",.T.) //insert .T.         
		SF3->F3_FILIAL := xfilial("SF3")
		SF3->F3_NFISCAL := ARQEDI->NFISCAL
		SF3->F3_SERIE := ARQEDI->SERIE
		SF3->F3_CFO := ARQEDI->CFO
		SF3->F3_EMISSAO := ARQEDI->EMISSAO
		SF3->F3_VALCONT := ARQEDI->VALOR
		SF3->F3_BASEICM := ARQEDI->BASEICM
		SF3->F3_VALICM := ARQEDI->VALICM
		SF3->F3_ISENICM := ARQEDI->ISENICM
		SF3->F3_OUTRICM := ARQEDI->OUTRICM
		SF3->F3_BASEIPI := ARQEDI->BASEIPI
		SF3->F3_VALIPI := ARQEDI->VALIPI
		SF3->F3_ISENIPI := ARQEDI->ISENIPI
		SF3->F3_OUTRIPI := ARQEDI->OUTRIPI
//OBRIGATORIOS
		SF3->F3_CLIEFOR := cCLIEFOR
		SF3->F3_LOJA := cLOJA
		SF3->F3_ESTADO := cESTADO
		SF3->F3_ENTRADA := DDATABASE
		SF3->F3_REPROC := "N"
		SF3->F3_ESPECIE := "NF"
	MsUnlock()
	DbSElectArea("ARQEDI")	
	DBSkip()
	IncProc()                 
	nConta := nConta +1
  end
end if
DBSelectArea("ARQEDI")
DbCloseArea("ARQEDI")
DBSelectArea("SF3")
DbCloseArea("SF3")
cMsgFinal := "Processamento finalizado!" + chr(10)
cMsgFinal += "Importados " + Alltrim(Str(nConta))+" arquivos."
MsgAlert( cMsgFinal)

return



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Funcao para atualizar o_publ    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function Atualiza()
RecLock("OPUBL",.F.) //update .F.
OPUBL->D_PROCED := cProcedimento
OPUBL->VALOR_PAGO := nValorPago
MsUnlock()
return


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Procedimento para limpar o conteudo das variaveis³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function LimparVariaveis()
cProcedimento := ""
nValorAss := 0
nValorPago := 0
return


Static Function Resolver()

DBSelectArea("SC5")
DBSetORder(1)

DBUSEAREA(.T.,,"\SIGA\ARQASS\OP_B_A2.DBF","OP_B_A",.F.,.F.)
DbSElectArea("OP_B_A")
cIndex  := CriaTrab(nil,.f.)
cChave  := "ID"
cFiltro := ""
IndRegua("OP_B_A",cIndex,cChave,,cFiltro,"Indexando ...")   
DBSelectArea("OP_B_A")
Dbgotop()
ProcRegua(Reccount())
While !Eof()
	NovoPedido := OP_B_A->NOVO_PED
	
	if Len(AllTrim(NovoPedido)) < 1
		// nao processar
		nContaNao++
	else 
		DBSelectArea("SC5")
		DbSeek(xfilial("SC5")+NovoPedido)
		RecLock("SC5",.F.) //update .F.
		SC5->C5_PARC1 := 0
		SC5->C5_DATA1 := stod("")
		SC5->C5_PARC2 := 0
		SC5->C5_DATA2 := stod("")
		SC5->C5_PARC3 := 0
		SC5->C5_DATA3 := stod("")
		SC5->C5_PARC4 := 0
		SC5->C5_DATA4 := stod("")
		SC5->C5_PARC5 := 0
		SC5->C5_DATA5 := stod("")
		SC5->C5_PARC6 :=  0
		SC5->C5_DATA6 := stod("")
		MsUnlock()
		nContaSC5++
	endif
	//limparVariaveis
	NovoPedido := 0
	IncProc()
	DBSelectArea("OP_B_A")
	DBSkip()
end

DBSelectArea("SC5")
DBCloseArea("SC5")
DBSelectArea("OP_B_A")
DbCloseArea("OP_B_A")
cMsgFinal := "Atualizados: " + Alltrim(Str(nContaSC5)) +", nao atualizados: " +  Alltrim(Str(nContaNao))
MsgAlert( cMsgFinal)

return



/* 20050331 : appendar um arquivo sdf
DBSELECTAREA("PFAT066")
   bBloco := "APPEND FROM &MCAMINHO SDF"
   //APPEND FROM &MCAMINHO SDF
   APPEND FROM &MCAMINHO SDF
   MsAguarde({|| bBloco},"Apendando arquivo temporario...")
   MSUNLOCK()
   DBGOTOP()

*/