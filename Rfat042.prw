#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/ Alterador por Danilo C S Pala , 20040830                                                
20091201 Danilo C S Pala: incluir E3_COMIS, E3_PORC -solicitado por Cidinha
Alterado por Danilo C S Pala em 20120223: por query
Alterado por Danilo C S Pala em 20120724: erro em mvalcom linha 333
Alterado por Danilo C S Pala em 20130703: alterar E1_BAIXA PARA E1_DTALT
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: Rfat042   �Autor: Rosane Rodrigues       � Data:   22/11/99 � ��
������������������������������������������������������������������������Ĵ ��
���Descri�ao: Relatorio de comissoes a pagar - Publicidade               � ��
������������������������������������������������������������������������Ĵ ��
���Alterado em 17/11/99-criado flag p/estorno e3_status(at� nova versao) � ��
���Alterado em 09/05/00- Ordem alfabetica de Clientes, criado tratamento � ��
���via arquivo temporario para indexacao.             - Roger Cangianeli � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento                                      � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function Rfat042()

SetPrvt("TITULO,CDESC1,CTITULO,CCABEC1,CCABEC2,XCABEC1")
SetPrvt("XCABEC2,NCARACTER,ARETURN,SERNF,CPROGRAMA,CPERG")
SetPrvt("NLASTKEY,M_PAG,LCONTINUA,WNREL,NLIN,CBTXT")
SetPrvt("CBCONT,NORDEM,ALFA,Z,M,TAMANHO")
SetPrvt("CDESC2,CDESC3,CSTRING,_ACAMPOS,_CARQTMP,_CVEND")
SetPrvt("_DEMISS,_DVENCTO,_DBAIXA,_CNOMCLI,LENTRADA,_CEMISSN")
SetPrvt("_CNOMEVEND,_CREGIAO,_CEQUIPE,_NVALTOT,_NTOTBASE,_CPREF")
SetPrvt("_CNUM,_CPARCELA,_CCODCLI,_CLOJA,_NBASE,_CPEDNUM")
SetPrvt("_NVALBASE,_CTIPO,_CSITUAC,MCALCCOM,MCALCFGTS,MCALCDSR")
SetPrvt("MTOTALCOM, nDivcom,mhora")
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Da Regiao                            �
//� mv_par02             // At� Regiao                           �
//� mv_par03             // Data de Pagamento                    �
//� mv_par04             // Mensal/Semestral                     �
//����������������������������������������������������������������
Titulo  :=PADC("COMISSOES ",74)
cDesc1  :=PADC("Este programa emite relatorio de Comissoes a pagar - Publicidade",74)
cTitulo := ' **** RELATORIO DE COMISSOES **** '
// Regua para impressao dos sub-titulos
//                 10        20        30        40        50        60        70         80        90        100      110       120     130         140      150       160
//          123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 12456789'
cCabec1 := 'NUMAUT    CODIGO    LJ   NOME CLIENTE                                 DUPL      DATA      DATA        DATA             VALOR         PORC            COMIS OBSERVACAO' //20091201
cCabec2 := '          CLIENTE                                                               EMISSAO   VENCTO      DIG BAIXA        BASE                    '
xCabec1 := 'DEMONSTRATIVO DE VENDAS - RESUMO'
xCabec2 := ' '
nCaracter := 18

aReturn := { "Especial", 1,"Administracao", 1, 2, 1,"",1 }

SERNF     := 'UNI'
cPrograma := "Rfat042"
cPerg     := "FAT009"
nLastKey  := 0
M_PAG     := 1
lContinua := .T.
MHORA := TIME()
wnrel     := "Rfat042_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
nLin      := 0
CbTxt     := ""
CbCont    := ""
nOrdem    := 0
Alfa      := 0
Z         := 0
M         := 0
tamanho   := "G"
cDesc2    := ""
cDesc3    := ""

//�������������������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas.                                     �
//���������������������������������������������������������������������������
Pergunte(cPerg,.T.)               // Pergunta no SX1

cString := "SE3"

//��������������������������������������������������������������Ŀ
//� Envia controle para a funcao SETPRINT                        �
//����������������������������������������������������������������
wnrel  := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.T.)

If nLastKey == 27
	Return
Endif

//��������������������������������������������������������������Ŀ
//� Verifica Posicao do Formulario na Impressora                 �
//����������������������������������������������������������������
SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

//��������������������������������������������������������������Ŀ
//�  Prepara Arquivo para Impressao                              �
//����������������������������������������������������������������
_aCampos := {}
aAdd( _aCampos, { "CPREF"   , "C", 03, 0 } )
aAdd( _aCampos, { "CNUM"    , "C", 06, 0 } )
aAdd( _aCampos, { "CPARCELA", "C", 03, 0 } )
aAdd( _aCampos, { "CCODCLI" , "C", 06, 0 } )
aAdd( _aCampos, { "CLOJA"   , "C", 02, 0 } )
aAdd( _aCampos, { "NBASE"   , "N", 12, 2 } )
aAdd( _aCampos, { "CPEDNUM" , "C", 06, 0 } )
aAdd( _aCampos, { "NVALBASE", "N", 12, 2 } )
aAdd( _aCampos, { "CTIPO"   , "C", 01, 0 } )
aAdd( _aCampos, { "CVEND"   , "C", 06, 0 } )
aAdd( _aCampos, { "CSITUAC" , "C", 01, 0 } )
aAdd( _aCampos, { "CEMISSN" , "C", 01, 0 } )
aAdd( _aCampos, { "CNOMEVEND","C", 30, 0 } )
aAdd( _aCampos, { "CREGIAO" , "C", 03, 0 } )
aAdd( _aCampos, { "CEQUIPE" , "C", 15, 0 } )
aAdd( _aCampos, { "DEMISS"  , "D", 08, 0 } )
aAdd( _aCampos, { "DVENCTO" , "D", 08, 0 } )
aAdd( _aCampos, { "DBAIXA"  , "D", 08, 0 } )
aAdd( _aCampos, { "CNOMCLI" , "C", 40, 0 } )
aAdd( _aCampos, { "NCOMIS"  , "N", 12, 2 } ) //20091201
aAdd( _aCampos, { "NPORC"   , "N", 05, 2 } ) //20091201

If Select("TRB") <> 0
	DbSelectArea("TRB")
	DbCloseArea()
EndIf

_cArqTmp := CriaTrab(_aCampos, .T.)
dbUseArea( .T.,, _cArqTmp, "TRB", .F., .F.)
MsAguarde({|| IndRegua("TRB",_cArqTmp, "CREGIAO+CVEND+CNOMCLI",,,"Indexando Arq.Trabalho...")},"Aguarde","Gerando Indice Temporario (TRB)...")

Processa({|| R042Proc()})

Return

Static Function R042Proc()

//��������������������������������������������������������������Ŀ
//�  Seleciona dados a gravar no Arquivo                         �
//����������������������������������������������������������������
dbSelectArea("SE3")
/*dbSetOrder(4)
dbSeek(xFilial("SE3")+DTOS(MV_PAR03)+MV_PAR01,.T.)
ProcRegua(RecCount())
While SE3->E3_FILIAL == xFilial("SE3") .and. DTOS(SE3->E3_DATA)==DTOS(MV_PAR03) .AND. !EOF()
	
	If SE3->E3_REGIAO < MV_PAR01 .OR. SE3->E3_REGIAO > MV_PAR02
		DBSKIP()
		LOOP
	Endif*/
	  
if MV_PAR05 == SPACE(6)
	cqueryvend :=""
else
	cqueryvend :=" AND E3_VEND='"+ MV_PAR05 +"'"
endif

cQuery := "SELECT * FROM "+ RetSqlName("SE3") +" WHERE E3_FILIAL='"+ XFILIAL("SE3") +"' AND E3_DATA='"+ DTOS(MV_PAR03) +"' AND E3_REGIAO>='"+ MV_PAR01 +"' AND E3_REGIAO<='"+ MV_PAR02 +"' "+ cqueryvend +" AND D_E_L_E_T_<>'*' ORDER BY E3_DATA, E3_REGIAO, E3_VEND" //20120223 
TCQUERY cQuery NEW ALIAS "COMIS"
TcSetField("COMIS","E3_DATA"   ,"D")
DbSelectArea("COMIS")
DBGOTOP()
WHILE !EOF() 

	dbSelectArea("SA3")
	dbSetOrder(1)
	If dbSeek(xFilial("SA3")+COMIS->E3_VEND, .F.) //If dbSeek(xFilial("SA3")+SE3->E3_VEND, .F.) //20120223
		If SA3->A3_EMISSN=='N' .OR. SA3->A3_TIPOVEN <> 'CT'
			dbSelectArea("COMIS") //dbSelectArea("SE3") //20120223
			dbskip()
			Loop
		Endif
	Endif
	
	_cVend  := COMIS->E3_VEND //SE3->E3_VEND //20120223
	dbSelectArea("COMIS") //dbSelectArea("SE3") //20120223
	While Alltrim(_cVend) == Alltrim(COMIS->E3_VEND) //While _cVend == SE3->E3_VEND //20120223
		If COMIS->E3_PER #MV_PAR04  // If SE3->E3_PER #MV_PAR04 //20120223
			dbSkip()
			Loop
		Endif
		
		IncProc("Lendo Nota: "+COMIS->E3_PREFIXO+COMIS->E3_NUM) //IncProc("Lendo Nota: "+SE3->E3_PREFIXO+SE3->E3_NUM)//20120223
		
		If Val(COMIS->E3_SITUAC) == 0//If Val(SE3->E3_SITUAC) == 0 //20120223
			dbSelectArea("SE1")
			If dbSeek( xFilial("SE1")+COMIS->E3_PREFIXO+COMIS->E3_NUM+COMIS->E3_PARCELA, .F. ) //If dbSeek( xFilial("SE1")+SE3->E3_PREFIXO+SE3->E3_NUM+SE3->E3_PARCELA, .F. ) //20120223
				_dEmiss   := SE1->E1_EMISSAO
				_dVencto  := SE1->E1_VENCTO
				_dBaixa   := SE1->E1_DTALT //SE1->E1_BAIXA 20130703  
				if !EMPTY(SE1->E1_VEND1) .AND. !EMPTY(SE1->E1_VEND2) //20040827 Dividir comissao qdo 2 vendedores
					nDivcom := 2
				else
					nDivCom := 1
				end if // ateh aki20040827
			Endif
		Else
			_dEmiss := ''
			_dVencto:= ''
			_dBaixa := ''       
			nDivCom := 1
		Endif
		
		dbSelectArea("SA1")                                                                                                                    
		dbSetOrder(1)
		If dbSeek(xFilial("SA1")+COMIS->E3_CODCLI+COMIS->E3_LOJA, .F.) //If dbSeek(xFilial("SA1")+SE3->E3_CODCLI+SE3->E3_LOJA, .F.) //20120223
			_cNomCli := SA1->A1_NOME
		Else
			_cNomCli := ""
		Endif
		
		RecLock("TRB", .T.)
		TRB->CPREF      := COMIS->E3_PREFIXO //SE3->E3_PREFIXO //20120223
		TRB->CNUM       := COMIS->E3_NUM //SE3->E3_NUM //20120223
		TRB->CPARCELA   := COMIS->E3_PARCELA//SE3->E3_PARCELA //20120223
		TRB->CCODCLI    := COMIS->E3_CODCLI//SE3->E3_CODCLI //20120223
		TRB->CLOJA      := COMIS->E3_LOJA//SE3->E3_LOJA //20120223
		TRB->NBASE      := (COMIS->E3_BASE/ nDivCom)  //(SE3->E3_BASE/ nDivCom) //20040830 //20120223
		TRB->CPEDNUM    := COMIS->E3_PEDIDO //SE3->E3_PEDIDO //20120223
		TRB->NVALBASE   := (COMIS->E3_BASE / nDivCom) //(SE3->E3_BASE / nDivCom) //20040827 //20120223
		TRB->CTIPO      := COMIS->E3_TIPO//SE3->E3_TIPO //20120223
		TRB->CVEND      := COMIS->E3_VEND//SE3->E3_VEND //20120223
		TRB->CSITUAC    := COMIS->E3_SITUAC//SE3->E3_SITUAC //20120223
		TRB->CEMISSN    := SA3->A3_EMISSN
		TRB->CNOMEVEND  := SA3->A3_NOME
		TRB->CREGIAO    := SA3->A3_REGIAO
		TRB->CEQUIPE    := SA3->A3_EQUIPE
		TRB->DEMISS     := SE1->E1_EMISSAO
		TRB->DVENCTO    := SE1->E1_VENCTO
		TRB->DBAIXA     := SE1->E1_DTALT //SE1->E1_BAIXA 20130703
		TRB->CVEND      := COMIS->E3_VEND //SE3->E3_VEND //20120223
		TRB->CNOMCLI    := SA1->A1_NOME
		TRB->NCOMIS     := COMIS->E3_COMIS //SE3->E3_COMIS //20091201 //20120223
		TRB->NPORC      := COMIS->E3_PORC //SE3->E3_PORC  //20091201 //20120223
		msUnlock()
		
		dbSelectArea("COMIS")//dbSelectArea("SE3")//20120223
		dbSkip()
	End
End

DbSelectArea("COMIS") //20120223
DbCloseArea() //20120223


//��������������������������������������������������������������Ŀ
//�  Prepara regua de impress�o                                  �
//����������������������������������������������������������������
dbSelectArea("TRB")
dbGoTop()
ProcRegua(RecCount())
lentrada := "T"
While !EOF()
	
	If lentrada == "T" .and. TRB->CEMISSN == "P"
		nLin := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
		nLin := nLin + 2
		@ nLin,001 PSAY  'REPRES.....:  ' + TRB->CVEND +' ' +TRB->CNOMEVEND +' '+'REGIAO: '+TRB->CREGIAO+' ' +'EQUIPE: ' + TRB->CEQUIPE
		nLin := nLin + 2
	EndIf
	
	lentrada := "F"
	IncProc("Imprimindo: "+TRB->CNUM+TRB->CPREF)
	
	_cVend     := TRB->CVEND
	_cEmissn   := TRB->CEMISSN
	_cNomeVend := TRB->CNOMEVEND
	_cRegiao   := TRB->CREGIAO
	_cEquipe   := TRB->CEQUIPE
	_nValTot   := 0
	_nTotBase  := 0
	
	While _cVend == TRB->CVEND .and. !EOF()
		_cPref      := TRB->CPREF
		_cNum       := TRB->CNUM
		_cParcela   := TRB->CPARCELA
		_cCodCli    := TRB->CCODCLI
		_cLoja      := TRB->CLOJA
		_nBase      := TRB->NBASE
		_cPedNum    := TRB->CPEDNUM
		_nValBase   := TRB->NVALBASE
		_cTipo      := TRB->CTIPO
		_cVend      := TRB->CVEND
		_cSituac    := TRB->CSITUAC
		_dEmiss     := TRB->DEMISS
		_dVencto    := TRB->DVENCTO
		_dBaixa     := TRB->DBAIXA
		_cNomCli    := TRB->CNOMCLI
		
		_cEmissn    := TRB->CEMISSN
		If _cEmissn == 'P'
			IMPPLAN()
		ElseIf _cEmissn == 'R'
			IMPRECI()
		EndIf
		
		dbSelectArea("TRB")
		dbSkip()
		
	Enddo
	
	If _cEmissn == "P"
		If nLin >= 53
			Roda(0,"",tamanho)
			nLin := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
			nLin := nLin + 2
			//			@ nLin,001 PSAY  'REPRES.....:  ' + TRB->CVEND +' ' +TRB->CNOMEVEND +' '+'REGIAO: '+TRB->CREGIAO+' ' +'EQUIPE: ' + TRB->CEQUIPE
			@ nLin,001 PSAY  'REPRES.....:  ' + _CVEND +' ' + _CNOMEVEND +' '+'REGIAO: '+ _CREGIAO+' ' +'EQUIPE: ' + _CEQUIPE
			nLin := nLin + 2
		EndIf
		nLin := nLin + 1
		@ nLin,00  PSAY 'TOTAL===========> '
		@ nLin,114 PSAY STR(_nTotBase,10,2)
		nLin := 60
		
	ElseIf _cEmissn == 'R'
		If VAL(TRB->CVEND) #10
			If nLin >= 55
				Roda(0,"",tamanho)
				nLin := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
				nLin := nLin + 2
			EndIf
			
			nLin := nLin + 1
			@ nLin,05 PSAY ' TOTAL DA PRODUCAO : '+STR(_nTotBase,10,2)
			nLin := nLin + 2
			
			If nLin >= 55
				Roda(0,"",tamanho)
				nLin := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
				nLin := nLin + 2
			EndIf
			nLin := nLin + 1
			//@ nLin,05 PSAY ' TOTAL DE COMISSOES: '+STR(MVALCOM,10,2)  //20120724
			nLin := nLin + 2
			
			@ nLin + 05,05 PSAY '                      =========='
			nLin := nLin + 2
			
			If nLin >= 55
				Roda(0,"",tamanho)
				nLin := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
				nLin := nLin + 2
			EndIf
			
		Else
			If nLin >= 55
				Roda(0,"",tamanho)
				nLin := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
				nLin := nLin + 2
			EndIf
			
			MCALCCOM    := _nTotBase * .7915   / 100
			MCALCFGTS   := _nTotBase * .074084 / 100
			MCALCDSR    := _nTotBase * .134555 / 100
			MTOTALCOM   := MCALCCOM  + MCALCFGTS+MCALCDSR
			nLin := nLin + 1
			@ nLin,10 PSAY 'TOTAL DA PRODUCAO......: ' + STR(_nTotBase,10,2)
			nLin := nLin + 2
			
			If nLin >= 55
				Roda(0,"",tamanho)
				nLin := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
				nLin := nLin + 2
			EndIf
			
			@ nLin,10 PSAY 'VALOR DE COMISSOES ....: ' + STR(MCALCCOM,10,2)
			nLin := nLin + 2
			
			If nLin >= 55
				Roda(0,"",tamanho)
				nLin := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
				nLin := nLin + 2
			EndIf
			@ nLin,10 PSAY 'VALOR FGTS ............: ' + STR(MCALCFGTS,10,2)
			nLin := nLin + 2
			
			If nLin >= 55
				Roda(0,"",tamanho)
				nLin := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
				nLin := nLin + 2
			EndIf
			@ nLin,10 PSAY 'VALOR DSR  ............: ' + STR(MCALCDSR,10,2)
			nLin := nLin + 2
			
			If nLin >= 55
				Roda(0,"",tamanho)
				nLin := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
				nLin := nLin + 2
			EndIf
			nLin := nLin + 1
			@ nLin,10 PSAY 'TOTAL DE COMISSOES.....: ' + STR(MTOTALCOM,10,2)
			nLin := nLin + 2
			
		EndIf
		
	EndIf
	
End

Roda(0,"",tamanho)

dbSelectArea("TRB")
dbCloseArea()
fErase( _cArqTmp + ".DBF" )
fErase( _cArqTmp + OrdBagExt() )

SET DEVICE TO SCREEN
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()

Static FUNCTION IMPPLAN()

If nLin >= 55
	Roda(0,"",tamanho)
	nLin := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
	nLin := nLin + 2
	@ nLin,001 PSAY  'REPRES.....:  ' + TRB->CVEND +' ' +TRB->CNOMEVEND +' '+'REGIAO: '+TRB->CREGIAO+' ' +'EQUIPE: ' + TRB->CEQUIPE
	nLin := nLin + 2
EndIf

@ nLin,001 PSAY  TRB->CPEDNUM    //_cPedNum
@ nLin,010 PSAY  TRB->CCODCLI    //_cCodCli
@ nLin,020 PSAY  TRB->CLOJA      //_cLoja
@ nLin,025 PSAY  TRB->CNOMCLI    //_cNomCli
@ nLin,070 PSAY  TRB->CNUM       //_cNum
@ nLin,077 PSAY  TRB->CPARCELA   //_cParcela
@ nLin,080 PSAY  TRB->DEMISS     //_dEmiss
@ nLin,090 PSAY  TRB->DVENCTO    //_dVencto
@ nLin,102 PSAY  TRB->DBAIXA     //_dBaixa
@ nLin,114 PSAY  STR(TRB->NVALBASE,10,2)   //STR(_nValBase,10,2)
@ nLin,132 PSAY  TRANSFORM(TRB->NPORC, "@E 999.99") //20091201
@ nLin,140 PSAY  TRANSFORM(TRB->NCOMIS, "@E 999,999,999.99") //20091201

DO CASE
	CASE TRB->CSITUAC =='1'
		@ nLin,155 PSAY 'FATURAMENTO CANCELADO'
	CASE TRB->CSITUAC=='2'
		@ nLin,155 PSAY 'ESTORNO DE VENDEDOR'
	CASE TRB->CSITUAC=='3'
		@ nLin,155 PSAY 'ESTORNO DE PRODUTO'
	CASE TRB->CSITUAC=='4'
		@ nLin,155 PSAY 'ESTORNO DE CLIENTE'
	CASE TRB->CSITUAC=='5'
		@ nLin,155 PSAY 'COMISSAO PGA EM DUPLICIDADE'
	CASE TRB->CSITUAC=='6'
		@ nLin,155 PSAY 'ESTORNO PARA ACERTO DE VALOR'
ENDCASE

IF VAL(TRB->CSITUAC) > 0
	_nTotBase := _nTotBase - TRB->NVALBASE
ELSE
	_nTotBase := _nTotBase + TRB->NVALBASE
ENDIF

nLin := nLin + 1
If nLin >= 55
	Roda(0,"",tamanho)
	nLin := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho)
	nLin := nLin + 2
EndIf

RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> FUNCTION IMPRECI
Static FUNCTION IMPRECI()
IF nLin >= 55
	nLin := CABEC(cTitulo,xCabec1,xCabec2,cPrograma,tamanho)
	nLin := nLin + 2
	@ nLin,001 PSAY  'REPRES.....:  ' + TRB->CVEND +' ' + TRB->CNOMEVEND +' '+'REGIAO: '+ TRB->CREGIAO +' ' +'EQUIPE: ' + TRB->CEQUIPE
	nLin:=nLin+2
ENDIF

IF VAL(TRB->CSITUAC) > 0
	_nTotBase := _nTotBase - TRB->NVALBASE
ELSE
	_nTotBase := _nTotBase + TRB->NVALBASE
ENDIF

Return
