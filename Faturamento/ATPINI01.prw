#INCLUDE "rwmake.ch"                       
#include "topconn.ch"
#include "tbiconn.ch"

/*/
//Danilo C S Pala 20081201: c5_emissao (Sandra) e f1_obs (Martins)
//Danilo C S Pala 20090521: alterar o TES da NFE do Pedido (Martins)
//Danilo C S Pala 20090814: mp10
//Danilo C S Pala 20100128: alteracao de TES de 503 para 522, de 005 para 019
//Danilo C S Pala 20100317: alteracao dividir em 2 opcoes CONSIGNACAO(018,019,153) ou EMPRESTIMO (020,021,022) respectivamente
//Danilo C S Pala 20100630: alterar serie para MOV (Cicero) para sped nfe 20100707: Serie 2
//Danilo C S Pala 20100705: nova tes 023 no lugar da 020 (Cicero) 
//Danilo C S Pala 20100707: Alterar f1_especie="SPED" (Cicero) 
//Danilo C S Pala 20100715: C6_CLASFIS (Cicero) 
//Danilo C S Pala 20100715: Alterar da Serie 2 para MOV (Cicero)
//Danilo C S Pala 20100805: Alterar u_gravaNFE para serie 2 na armazenagem (Cicero)
//Danilo C S Pala 20100810: fixar o d1_clasfis a pedido do Cicero
//Danilo C S Pala 20100819: Alterar u_gravaNFE para serie 2 no transporte (Cicero)
//Danilo C S Pala 20100924: DESABILITADO, UTILIZAR ATPINI02
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณATPINI01  บ Autor ณ Marcio Torresson   บ Data ณ  14/08/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Primeira tela de gera็ใo de dados para a gera็ใo das NF's  บฑฑ
ฑฑบ          ณ de retorno e de emissใo cliente                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function ATPINI01()

Local aCores    := {{'Empty(ZZY_OK)', 'ENABLE'    },; // EM ABERTO
	                {'ZZY_OK=="OK"' , 'DISABLE'   },; // ENCERRADO O PODER 3บ
	                {'ZZY_OK=="QT"' , 'BR_AZUL'   },; // TRANSPORTADO TOTAL OU PARCIAL
	                {'ZZY_OK=="QA"' , 'BR_AMARELO'},; // ARMAZENADO PARCIAL
	                {'ZZY_OK=="QV"' , 'BR_MARRON' },; // VENDA PARCIAL
	                {'ZZY_OK=="VT"' , 'BR_CINZA'  },; // VENDA E TRANSPORTE PARCIAL
	                {'ZZY_OK=="TA"' , 'BR_LARANJA'},; // TRANSPORTE E ARMAZENAGEM PARCIAL
	                {'ZZY_OK=="VA"' , 'BR_PINK'   },; // VENDA E ARMAZENAGEM PARCIAL
                    {'ZZY_OK=="TP"' , 'BR_PRETO'  }}  // VENDA, TRANSPORTE E ARMAZENAGEM PARCIAL

Private cCadastro := "Gera็ใo de NFs de Devolu็ใo e Venda"
Public cConsEmp := "C"
cperg := "PINICE01"
ValidConsEmp()
Pergunte(cPerg,.t.)   
if mv_par01==1
	cConsEmp := "C"
else
	cConsEmp := "E"
endif


if cConsEmp ="E" //20100317                               
	cCadastro := "Gera็ใo de NFs de Devolu็ใo e Venda: EMPRESTIMO"
else
	cCadastro := "Gera็ใo de NFs de Devolu็ใo e Venda: CONSIGNACAO"
endif


Private cDelFunc := ".F." // Validacao para a exclusao. Pode-se utilizar ExecBlock

Private cString := ""
Private cFiltro1 := "" //mp10
Private cFiltro2 := "" //mp10
Private cFiltro3 := "" //mp10

Private cPerg := "TELA01"
Private cCod01Ven := space(06)
Private cCod02Ven := space(06)
Private cCod03NF := space(09)
Private cCod04NF := space(09)
Private cCod07Baixa := 1

if _nomeexec == "SIGAFAT.EXE"
	Private aRotina := {{"Visualizar"    ,"AxVisual"       ,0,2},;
                    {"Pesquisa"      ,"AxPesqui"       ,0,1},;
                    {"Gera Pedido"   ,"U_GeraPedido(1)",0,4},;
					{"Legenda"       ,"U_Colores()"    ,0,2}}                    
elseif _nomeexec == "SIGACOM.EXE"
	Private aRotina := {{"Visualizar"    ,"AxVisual"       ,0,2},;
                    {"Pesquisa"      ,"AxPesqui"       ,0,1},;
             		{"Gera NF Transp","U_GeraPedido(2)",0,4},;
					{"Gera NF Armaz" ,"U_GeraPedido(3)",0,4},;	
					{"Legenda"       ,"U_Colores()"    ,0,2}}                    
endif

dbselectarea("SZ9")
dbsetorder(1)

ValidPerg()

Pergunte(cPerg,.t.)   

cCod01Ven := mv_par01
cCod02Ven := mv_par02
cCod03NF   := mv_par03
cCod04NF  := mv_par04
cCod07Baixa := mv_par07

Processa({|| U_Preparando() },"Preparando Dados")

dbselectarea("TRB")
dbclosearea()

cString := "ZZY"

dbSelectArea(cString)
/*if cCod07Baixa == 2 //mp10 daqui
   set filter to zzy->zzy_ok <> "OK"
elseif !empty(cCod01Ven) .and. (substr(cCod02Ven,1,3) <> "zzz" .or. substr(cCod02Ven,1,3) <> "ZZZ")
   set filter to zzy->zzy_client >= cCod01Ven .and. zzy->zzy_client <= cCod02Ven
elseif !empty(cCod03NF) .and. (substr(cCod04NF,1,3) <> "zzz" .or. substr(cCod04NF,1,3)<> "ZZZ")
	set filter to zzy->zzy_doc >= cCod03NF .and. zzy->zzy_doc <= cCod04NF
else
   set filter to
endif    */ 
cFiltro1 := ""
cFiltro2 := ""
cFiltro3 := ""
if cCod07Baixa == 2
	cFiltro1 := "S"
endif
if !empty(cCod01Ven) .and. (substr(cCod02Ven,1,3) <> "zzz" .or. substr(cCod02Ven,1,3) <> "ZZZ")
	cFiltro2 := "S"
endif
if !empty(cCod03NF) .and. (substr(cCod04NF,1,3) <> "zzz" .or. substr(cCod04NF,1,3)<> "ZZZ")
	cFiltro3 := "S"
endif           

if cFiltro1="S" .and. cFiltro2="" .and. cFiltro3=""
	set filter to zzy->zzy_ok <> "OK"
elseif cFiltro1="S" .and. cFiltro2="S" .and. cFiltro3=""
	set filter to zzy->zzy_ok <> "OK" .and. zzy->zzy_client >= cCod01Ven .and. zzy->zzy_client <= cCod02Ven
elseif cFiltro1="S" .and. cFiltro2="S" .and. cFiltro3="S"
	set filter to zzy->zzy_ok <> "OK" .and. zzy->zzy_client >= cCod01Ven .and. zzy->zzy_client <= cCod02Ven .and. zzy->zzy_doc >= cCod03NF .and. zzy->zzy_doc <= cCod04NF
elseif cFiltro1="" .and. cFiltro2="S" .and. cFiltro3=""
	set filter to zzy->zzy_client >= cCod01Ven .and. zzy->zzy_client <= cCod02Ven
elseif cFiltro1="" .and. cFiltro2="S" .and. cFiltro3="S"
	set filter to zzy->zzy_client >= cCod01Ven .and. zzy->zzy_client <= cCod02Ven .and. zzy->zzy_doc >= cCod03NF .and. zzy->zzy_doc <= cCod04NF
elseif cFiltro1="" .and. cFiltro2="" .and. cFiltro3="S"	
	set filter to zzy->zzy_doc >= cCod03NF .and. zzy->zzy_doc <= cCod04NF
endif //ate aqui mp10

mBrowse(6,1,22,75,cString,,,,,,aCores)

Return                                                              

/*/
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ Colores   ณ Autor ณ Marcio Torresson     ณ Data ณ 07.10.08 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Cria uma janela contendo a legenda da mBrowse              ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ ATPINI01                                                   ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function Colores()
Local aLegenda := {{"ENABLE"    ,"Em Aberto - Sem Movimenta็ใo"            },; 
	               {"DISABLE"   ,"Encerradas - Venda ou Armazenagem Total" },; 
	               {"BR_AZUL"   ,"Transporte Total ou Parcial"             },; 
	               {"BR_AMARELO","Armazenagem Parcial"                     },;
	               {"BR_MARRON" ,"Venda Parcial"                           },;
	               {"BR_CINZA"  ,"Venda e Transporte Parcial"              },;
	               {"BR_LARANJA","Transporte e Armazenagem Parcial"        },;
	               {"BR_PINK"   ,"Venda e Armazenagem Parcial"             },;
	               {"BR_PRETO"  ,"Venda, Transporte e Armazenagem Parcial" }} 

BrwLegenda(cCadastro,"Legendas",aLegenda) //"Legenda"

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPreparandoบAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPreparando dados no arquivo zzy para novos processos        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Preparando()

Local nTotal  := 0
Local nFeito  := 0

ProcRegua(1)

incproc("Este processo irแ demorar alguns minutos, Aguarde !!!")

cQuery := "SELECT D2_ITEM,B6_ATEND,D2_CLIENTE,D2_LOJA,A1_NOME,D2_DOC,D2_SERIE,D2_COD,B1_DESC,D2_ITEMPV,C6_QTDVEN,"
cQuery += "D2_QUANT,B6_SALDO,B6_PRUNIT FROM "+RETSQLNAME("SD2")+" SD2,"+RETSQLNAME("SB6")+" SB6,"+RETSQLNAME("SA1")+" SA1,"
cQuery += RETSQLNAME("SC6")+" SC6,"+RETSQLNAME("SB1")+" SB1"
if !empty(mv_par01) .and. (substr(mv_par02,1,3) <> "zzz" .or. substr(mv_par02,1,3) <> "ZZZ")
	cQuery += " WHERE SD2.D2_CLIENTE >= '"+MV_PAR01+"' AND SD2.D2_CLIENTE <= '"+MV_PAR02+"' AND"
else
	cQuery += " WHERE"
endif
if !empty(mv_par03) .and. (substr(mv_par04,1,3) <> "zzz" .or. substr(mv_par04,1,3)<> "ZZZ")
	cQuery += " SD2.D2_DOC >= '"+MV_PAR03+"' AND SD2.D2_DOC <= '"+MV_PAR04+"' AND"
endif
cQuery += " SD2.D2_EMISSAO >= '"+DTOS(MV_PAR05)+"' AND SD2.D2_EMISSAO <= '"+DTOS(MV_PAR06)+"' AND SD2.D2_IDENTB6 <> '"+space(06)+"'"
cQuery += " AND SD2.D_E_L_E_T_ <> '*'"

cQuery += " AND SB6.B6_FILIAL = SD2.D2_FILIAL AND SB6.B6_PRODUTO = SD2.D2_COD AND SB6.B6_CLIFOR = SD2.D2_CLIENTE"
cQuery += " AND SB6.B6_LOJA = SD2.D2_LOJA AND SB6.B6_IDENT = SD2.D2_IDENTB6"
cQuery += " AND SB6.B6_ATEND <> 'S' AND SB6.B6_SALDO > 0 AND SB6.D_E_L_E_T_ <> '*'"

cQuery += " AND SA1.A1_FILIAL = '"+xfilial("SA1")+"' AND SA1.A1_COD = SD2.D2_CLIENTE AND SA1.A1_LOJA = SD2.D2_LOJA"
cQuery += " AND SA1.D_E_L_E_T_ <> '*'"

cQuery += " AND SB1.B1_FILIAL = '"+xfilial("SB1")+"' AND SB1.B1_COD = SD2.D2_COD AND SB1.D_E_L_E_T_ <> '*'"

cQuery += " AND SC6.C6_FILIAL = SD2.D2_FILIAL AND SC6.C6_NUM = SD2.D2_PEDIDO AND SC6.C6_ITEM = SD2.D2_ITEMPV"
cQuery += " AND SC6.C6_PRODUTO = SD2.D2_COD AND SC6.D_E_L_E_T_ <> '*'"

cQuery += " ORDER BY D2_CLIENTE,D2_DOC"

DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), 'TRB', .F., .T.)

cString := "TRB"

dbSelectArea(cString)

dbselectarea("TRB")
dbGoTop()       

do while .t.
	if !eof()
		nTotal := nTotal + 1
    else
    	exit
	endif
	dbskip()
enddo       

dbGotop()

if nTotal == 0
   return
endif

ProcRegua(nTotal) // Numero de registros a processar

do while .t.        
	
	nFeito := nFeito + 1

	incproc("Processados: "+strzero(nFeito,6)+" de "+ strzero(nTotal,6))
	
	dbselectarea("ZZY")
	dbsetorder(1)
	dbseek(xfilial("ZZY")+trb->(d2_doc+d2_serie+d2_cliente+d2_loja+d2_cod+d2_itempv))
	if eof()
		reclock("ZZY",.t.)
		zzy_filial  := xfilial("ZZY")
		zzy_itempv  := trb->d2_itempv
		zzy_itemnf  := trb->d2_item
		zzy_doc     := trb->d2_doc
		zzy_serie   := trb->d2_serie 
		zzy_client  := trb->d2_cliente
		zzy_loja    := trb->d2_loja               
		zzy_nome    := trb->a1_nome
		zzy_cod     := trb->d2_cod
		ZZY_desc    := trb->b1_desc
		ZZY_qtdpv   := trb->c6_qtdven               
		ZZY_q3ini   := trb->d2_quant
		ZZY_q3fim   := trb->b6_saldo
		ZZY_prunit  := trb->b6_prunit
        ZZY_item    := trb->d2_item
		if trb->b6_atend == "S" .or. ZZY_q3fim == 0
			ZZY_atend   := "Encerrado"
			ZZY_ok      := "OK"
		else
			ZZY_atend   := "Aberto"
		endif
		msunlock()
    else
        reclock("ZZY",.f.)
        if trb->b6_atend == "S" .or. trb->b6_saldo == 0
           zzy_q3fim    := trb->b6_saldo
           zzy_atend    := "Encerrado"
           zzy_ok       := "OK"
        else
           zzy_q3fim    := trb->b6_saldo
           zzy_atend    := "Aberto"
			do case
				case zzy_qtdven > 0 .and. zzy_qtdtra == 0 .and. zzy_qtdarm == 0
					zzy_ok := "QV"
				case zzy_qtdven > 0 .and. zzy_qtdtra > 0 .and. zzy_qtdarm == 0
					zzy_ok := "VT"
				case zzy_qtdven > 0 .and. zzy_qtdtra == 0 .and. zzy_qtdarm > 0
					zzy_ok := "VA"
				case zzy_qtdven > 0 .and. zzy_qtdtra > 0 .and. zzy_qtdarm > 0
					zzy_ok := "TP" 	
				case zzy_qtdven == 0 .and. zzy_qtdtra > 0 .and. zzy_qtdarm == 0
					zzy_ok := "QT"
				case zzy_qtdven == 0 .and. zzy_qtdtra > 0 .and. zzy_qtdarm > 0
					zzy_ok := "TA"
				case zzy_qtdven == 0 .and. zzy_qtdtra == 0 .and. zzy_qtdarm > 0
					zzy_ok := "QA"
			endcase
        endif
        msunlock()
	endif
	
	dbselectarea("TRB")
	dbskip()           
	if eof()
		exit
	endif

enddo

return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGeraPedidoบAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GeraPedido(x)             

Local cChave   := ""
Local nLin
Local i        := 0
Local lRet     := .F.                               
Local cAlias   := "ZZY"    
Local cProcura := ""     
Local nContS   := 0
Local cLibera  := ""

Private cT        := "Manuten็ใo de Vendas/Devolu็ใo"     
if cConsEmp ="E" //20100317                               
	cT := "Manuten็ใo de Vendas/Devolu็ใo: EMPRESTIMO"
else                                                  
	cT := "Manuten็ใo de Vendas/Devolu็ใo: CONSIGNACAO"
endif
Private aC        := {}
Private aR        := {}
Private aCGD      := {}
Private cLinOK    := ""
Private cAllOK    := "u_VerTudOK()"
Private aGetsGD   := {}
Private bF4       := {|| }
Private cIniCpos  := "+ZZY_ITEM"
Private nMax      := 15
Private aHeader   := {}
Private aCols     := {}
Private nCount    := 0
Private bCampo    := {|nField| FieldName(nField)}
Private aAlt      := {}   
Private xtipo     := x
Private nVlTot    := 0
Private nVlVend   := 0
Private cObs      := space(40)
Private cPagto    := space(03)
Private c1Comis   := space(06)
Private c2Comis   := space(06)
Private cTipoOper := space(03)
Private cTComis1 
Private cRegiao
Private nqItem    := 0
Private cCgc
Private cCodCli
Private cCodLoja

if xtipo == 2
   dbselectarea("SA1")
   dbsetorder(1)
   if dbseek(xfilial("SA1")+(cAlias)->(zzy_client+zzy_loja))
      cCgc := a1_cgc
      if empty(cCgc)
         msginfo("Nใo ้ possํvel efetuar a emissใo de Nota Fiscal de Transporte para Vendedor sem CPF/CNPJ !!!")
         return
      endif
      
      dbselectarea("SA2")
      dbsetorder(3)
      if dbseek(xfilial("SA2")+cCgc)
         cCodCli  := a2_cod
         cCodLoja := a2_loja
      else
         msginfo("Efetue o cadastro do Vendedor no Cadastro de Fornecedores para emissใo da Nota Fiscal de Transporte !!!")
         return
      endif
   endif
endif

dbselectarea(cAlias)
For i := 1 to FCount()
	cCampo := FieldName(i)
	M->&(cCampo) := CriaVar(cCampo,.T.)
Next                 

dbselectarea("SX3")
dbsetorder(1)
dbseek(cAlias)

while !SX3->(EOF()) .and. SX3->X3_Arquivo == cAlias
	if X3Uso(SX3->X3_USADO)    .and.;
	   cNivel >= SX3->X3_Nivel .and.;
	   Trim(SX3->X3_CAMPO) $ "ZZY_ITEMPV/ZZY_DOC/ZZY_SERIE/ZZY_COD/ZZY_DESC/ZZY_QTDVEN/ZZY_QTDTRA/ZZY_QTDARM/ZZY_PVENDA/ZZY_Q3INI/ZZY_Q3FIM/ZZY_PRUNIT"
	   if xtipo == 1 .and. Trim(SX3->X3_CAMPO) <> "ZZY_QTDTRA" .and. Trim(SX3->X3_CAMPO) <> "ZZY_QTDARM"
		   aAdd(aHeader, {Trim(SX3->X3_TITULO),;
		                       SX3->X3_CAMPO  ,;
		                       SX3->X3_PICTURE,;
		                       SX3->X3_TAMANHO,;
		                       SX3->X3_DECIMAL,;
		                       SX3->X3_VALID  ,;
		                       SX3->X3_USADO  ,;
		                       SX3->X3_TIPO   ,;
		                       SX3->X3_ARQUIVO,;
		                       SX3->X3_CONTEXT})
	   elseif xtipo == 2 .and. Trim(SX3->X3_CAMPO) <> "ZZY_QTDVEN" .and. Trim(SX3->X3_CAMPO) <> "ZZY_QTDARM" .and. Trim(SX3->X3_CAMPO) <> "ZZY_PVENDA"
		   aAdd(aHeader, {Trim(SX3->X3_TITULO),;
		                       SX3->X3_CAMPO  ,;
		                       SX3->X3_PICTURE,;
		                       SX3->X3_TAMANHO,;
		                       SX3->X3_DECIMAL,;
		                       SX3->X3_VALID  ,;
		                       SX3->X3_USADO  ,;
		                       SX3->X3_TIPO   ,;
		                       SX3->X3_ARQUIVO,;
		                       SX3->X3_CONTEXT})
	   elseif xtipo == 3 .and. Trim(SX3->X3_CAMPO) <> "ZZY_QTDVEN" .and. Trim(SX3->X3_CAMPO) <> "ZZY_QTDTRA" .and. Trim(SX3->X3_CAMPO) <> "ZZY_PVENDA"
		   aAdd(aHeader, {Trim(SX3->X3_TITULO),;
		                       SX3->X3_CAMPO  ,;
		                       SX3->X3_PICTURE,;
		                       SX3->X3_TAMANHO,;
		                       SX3->X3_DECIMAL,;
		                       SX3->X3_VALID  ,;
		                       SX3->X3_USADO  ,;
		                       SX3->X3_TIPO   ,;
		                       SX3->X3_ARQUIVO,;
		                       SX3->X3_CONTEXT})
	   endif
	endif
	
	sx3->(dbskip())
	
enddo

m->ZZY_doc     := (cAlias)->ZZY_doc
m->ZZY_serie   := (cAlias)->ZZY_serie
m->ZZY_client  := (cAlias)->ZZY_client
m->ZZY_nome    := (cAlias)->ZZY_nome
m->ZZY_loja    := (cAlias)->ZZY_loja 
m->ZZY_nclien  := (cAlias)->ZZY_nclien
m->ZZY_nloja   := (cAlias)->ZZY_nloja
m->ZZY_pedido  := (cAlias)->ZZY_pedido
m->ZZY_ok      := (cAlias)->ZZY_ok
m->ZZY_nnome   := (cAlias)->ZZY_nnome

c1Comis := posicione("SA1",1,xfilial("SA1")+m->(ZZY_client+ZZY_loja),"A1_VEND")
c2Comis := posicione("SA3",1,xfilial("SA3")+c1Comis,"A3_GEREN")

cProcura := xfilial(cAlias)+m->ZZY_doc+m->ZZY_serie+m->ZZY_client+m->ZZY_loja

dbselectarea(cAlias)
dbsetOrder(1)
dbseek(cProcura)

while !eof() .and. (cAlias)->(ZZY_filial+ZZY_doc+ZZY_serie+ZZY_client+ZZY_loja) == cProcura

	if (cAlias)->ZZY_ok == "OK"
		cLibera := "Nใo ้ possํvel executar nenhum movimento com uma nota encerradas, verifique!!!"
	elseif xtipo == 2 .and. (cAlias)->ZZY_qtdtra >= (cAlias)->ZZY_q3fim
		cLibera := "Nใo hแ valor a ser transportado para este produto, verifique!!!"
	else
		aAdd(aCols,Array(Len(aHeader)+1))
		nLin := Len(aCols)
		For i:= 1 to Len(aHeader) 
			if aHeader[i][10] = "R" .and. aHeader[i][2] <> "ZZY_QTDVEN" .and. aHeader[i][2] <> "ZZY_QTDTRA" .and. aHeader[i][2] <> "ZZY_QTDARM" .and. aHeader[i][2] <> "ZZY_PVENDA"
	   			aCols[nLin][i] := FieldGet(FieldPos(aHeader[i][2]))									   
			else
				aCols[nLin][i] := CriaVar(aHeader[i][2],.t.)
			endif       
		Next
		aCols[nLin][Len(aHeader)+1] = .F.
		aAdd(aAlt, Recno())
		nContS := nContS + 1
	endif              		
	dbselectarea(cAlias)
	dbskip()      
	
enddo

if nContS == 0
	msgalert(cLibera)
	return nil
endif 

aAdd(aC,{"M->ZZY_CLIENT"  ,{20,10 },"Vendedor."          ,"@!"    ,           ,     ,.F.})
aAdd(aC,{"M->ZZY_LOJA"    ,{20,85 },"Loja"               ,"@!"    ,           ,     ,.F.})
aAdd(aC,{"M->ZZY_NOME"    ,{20,120},"Nome Vendedor."     ,"@!"    ,           ,     ,.F.})
if xtipo == 1	
	aAdd(aC,{"M->ZZY_NCLIEN"  ,{35,10 },"Cliente......"      ,"@!"    ,"u_achar()","SA1",.T.})
	aAdd(aC,{"M->ZZY_NLOJA"   ,{35,85 },"Loja"               ,"@!"    ,           ,     ,.T.})
	aAdd(aC,{"M->ZZY_NNOME"   ,{35,120},"Nome Cliente......" ,"@!"    ,           ,     ,.F.})
	aAdd(aC,{"M->ZZY_PEDIDO " ,{50,10 },"Pedido......"       ,"@!", "u_achaped()" ,"SC6",.T.})
	aAdd(aC,{"cPagto"        ,{50,85 },"Cond. Pagto"        ,"999"   ,           ,"SE4",.T.})
	aAdd(aC,{"cTipoOper"     ,{50,150},"Tipo de Opera็ใo"   ,"@!"    ,           ,"SZ9",.T.})
	aAdd(aC,{"c1Comis"       ,{50,230},"Comissใo 01"        ,"999999","u_comis()","SA3",.T.})
	aAdd(aC,{"c2Comis"       ,{50,320},"Comissใo 02"        ,"999999",           ,"SA3",.T.})
	aCGD := {110,5,63,280}
else
	aCGD := {50,5,108,280}
endif

if xtipo == 1
   aAdd(aR,{"nVlTot" ,{68,10 },"Total Custo","@E 999,999,999.99",,,.F.})
   aAdd(aR,{"cObs"   ,{68,120},"Observa็๕es","@!"               ,,,.T.})
   aAdd(aR,{"nVLVend",{83,10 },"Total Venda","@E 999,999,999.99",,,.F.})
elseif xtipo == 2
   aAdd(aR,{"nVlTot",{112,10},"Total do Transporte","@E 999,999,999.99",,,.F.})
elseif xtipo == 3
   aAdd(aR,{"nVlTot",{112,10},"Total da Armazenagem","@E 999,999,999.99",,,.F.})
endif

cLinOk := "u_VerLinOK()"

cTitulo := cT

lRet := Modelo2(cTitulo,aC,aR,aCGD,4,cLinOK,cAllOk,,,cIniCpos,nMax,{01,01,550,950},.f.)

if lRet
	if MsgYesNo("Confirma os Dados Digitados?",cTitulo)
		
		Processa({||U_Gravazzy(cAlias)},cTitulo,"Gerando as informa็๕es, aguarde por favor!!")
		
		if xtipo == 1
		   // Execu็ใo do cadastro do Pedido de venda (Mata410)
           u_gravaPED()
		elseif xtipo == 2
		   // Execu็ใo do cadastro de NF de Transporte (Mata103)
           u_gravaNFE() //20100805 nao tinha parametro
		else
		   // Execu็ใo do cadastro de NF de Armazenagem (Mata103)
           u_gravaNFE()//20100805 nao tinha parametro
		endif
		
	endif
else
	rollbackSX8()
endif

return nil                 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAchar     บAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGatilho para o cadastro de cliente                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                             
User Function Achar()
dbselectarea("SA1")
dbsetorder(1)
dbseek(xfilial("SA1")+m->ZZY_nclien)
if !eof()
	m->ZZY_nloja := a1_loja
	m->ZZY_nnome := a1_nome                                          
endif
return
                                                                                           
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณComis     บAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGatilho para o cadastro de cliente                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                             
User Function Comis()

c2Comis := posicione("SA3",1,xfilial("SA3")+c1Comis,"A3_GEREN")
cTComis1 := posicione("SA3",1,xfilial("SA3")+c1Comis,"A3_TIPOVEN")
cRegiao := posicione("SA3",1,xfilial("SA3")+c1Comis,"A3_REGIAO")

return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAchaPed  บAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGatilho para o cadastro de cliente                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                             
User Function AchaPed()
dbselectarea("SC5")
dbsetorder(1)
dbseek(xfilial("SC5")+m->ZZY_pedido)
if !eof() .and. c5_cliente == m->zzy_nclien .and. c5_lojacli == m->zzy_nloja
	nVlVend := c5_vlrped
endif
return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGravazzy  บAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava os dados ajustados e digitados na tela                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                             
User Function Gravazzy(cAlias)

Local i
Local y
Local nNrCampo
ProcRegua(Len(aCols))
dbselectarea(cAlias)
dbsetOrder(1)
For i := 1 to Len(aCols)
	if i <= Len(aAlt)
		dbselectarea("ZZY")
		dbgoto(aAlt[i])
		if aCols[1][Len(aHeader)+1]
			MsgInfo("Nesta Op็ใo nใo ้ possํvel excluir dados!!!",cTitulo)
		else
			reclock("ZZY",.f.)
			for y := 1 to Len(aHeader)
				nNrCampo := FieldPos(Trim(aHeader[y][2]))
				if xtipo <> 2
					Fieldput(nNrCampo,aCols[i][y])
				else
					if trim(aHeader[y][2]) <> alltrim("ZZY_Q3FIM")
						Fieldput(nNrCampo,aCols[i][y])
					endif
				endif
			next
			(cAlias)->ZZY_filial   := xfilial(cAlias)
			(cAlias)->ZZY_pedido   := m->ZZY_pedido
			(cAlias)->ZZY_nclien   := m->ZZY_nclien
			(cAlias)->ZZY_nloja    := m->ZZY_nloja
			(cAlias)->zzy_nnome := m->zzy_nnome
			if (cAlias)->ZZY_q3fim == 0
                if xtipo == 3
                   (cAlias)->zzy_atend := "Encerrado"
                elseif xtipo == 1
                   (cAlias)->zzy_ok := "OK"
                   (cAlias)->zzy_atend := "Encerrado"
                endif         
            else
				do case
					case (cAlias)->zzy_qtdven > 0 .and. (cAlias)->zzy_qtdtra == 0 .and. (cAlias)->zzy_qtdarm == 0
						(cAlias)->zzy_ok := "QV"
					case (cAlias)->zzy_qtdven > 0 .and. (cAlias)->zzy_qtdtra > 0 .and. (cAlias)->zzy_qtdarm == 0
						(cAlias)->zzy_ok := "VT"
					case (cAlias)->zzy_qtdven > 0 .and. (cAlias)->zzy_qtdtra == 0 .and. (cAlias)->zzy_qtdarm > 0
						(cAlias)->zzy_ok := "VA"
					case (cAlias)->zzy_qtdven > 0 .and. (cAlias)->zzy_qtdtra > 0 .and. (cAlias)->zzy_qtdarm > 0
						(cAlias)->zzy_ok := "TP" 	
					case (cAlias)->zzy_qtdven == 0 .and. (cAlias)->zzy_qtdtra > 0 .and. (cAlias)->zzy_qtdarm == 0
						(cAlias)->zzy_ok := "QT"
					case (cAlias)->zzy_qtdven == 0 .and. (cAlias)->zzy_qtdtra > 0 .and. (cAlias)->zzy_qtdarm > 0
						(cAlias)->zzy_ok := "TA"
					case (cAlias)->zzy_qtdven == 0 .and. (cAlias)->zzy_qtdtra == 0 .and. (cAlias)->zzy_qtdarm > 0
						(cAlias)->zzy_ok := "QA"
				endcase
            endif
			zzy->(msunlock())
		endif
	else
		if !aCols[i][Len(aHeader)+1]
			reclock(cAlias,.t.)
			for y := 1 to Len(aHeader)
				nNrCampo := FieldPos(Trim(aHeader[y][2]))
				if xtipo <> 2
					Fileldput(nNrCampo,aCols[i][y])
				else
					if trim(aHeader[y][2]) <> alltrim("ZZY_Q3FIM")
						Fieldput(nNrCampo,aCols[i][y])
					endif
				endif
			next
			(cAlias)->ZZY_filial   := xfilial(cAlias)
			(cAlias)->ZZY_pedido   := m->ZZY_pedido
			(cAlias)->ZZY_nclien   := m->ZZY_nclien
			(cAlias)->ZZY_nloja    := m->ZZY_nloja
			(cAlias)->zzy_nnome := m->zzy_nnome
			if (cAlias)->ZZY_q3fim == 0
                if xtipo == 3
                   (cAlias)->zzy_atend := "Encerrado"
                elseif xtipo == 1
                   (cAlias)->zzy_ok := "OK"
                   (cAlias)->zzy_atend := "Encerrado"
                endif
            else
				do case
					case (cAlias)->zzy_qtdven > 0 .and. (cAlias)->zzy_qtdtra == 0 .and. (cAlias)->zzy_qtdarm == 0
						(cAlias)->zzy_ok := "QV"
					case (cAlias)->zzy_qtdven > 0 .and. (cAlias)->zzy_qtdtra > 0 .and. (cAlias)->zzy_qtdarm == 0
						(cAlias)->zzy_ok := "VT"
					case (cAlias)->zzy_qtdven > 0 .and. (cAlias)->zzy_qtdtra == 0 .and. (cAlias)->zzy_qtdarm > 0
						(cAlias)->zzy_ok := "VA"
					case (cAlias)->zzy_qtdven > 0 .and. (cAlias)->zzy_qtdtra > 0 .and. (cAlias)->zzy_qtdarm > 0
						(cAlias)->zzy_ok := "TP" 	
					case (cAlias)->zzy_qtdven == 0 .and. (cAlias)->zzy_qtdtra > 0 .and. (cAlias)->zzy_qtdarm == 0
						(cAlias)->zzy_ok := "QT"
					case (cAlias)->zzy_qtdven == 0 .and. (cAlias)->zzy_qtdtra > 0 .and. (cAlias)->zzy_qtdarm > 0
						(cAlias)->zzy_ok := "TA"
					case (cAlias)->zzy_qtdven == 0 .and. (cAlias)->zzy_qtdtra == 0 .and. (cAlias)->zzy_qtdarm > 0
						(cAlias)->zzy_ok := "QA"
				endcase
            endif
			msunlock()
		endif
	endif
next

Return nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGravaNFE  บAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava os dados ajustados para a emissใo da Nota Fiscal de   บฑฑ
ฑฑบ          ณentrada                                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GravaNFE()
Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local nX := 0
Local nY := 0
Local nNumNF := len(aCols)/15
Local lOk := .T.
Local _cSerieNFS := "MOV" // "UNI" //20100630 // MOV
Local _cmvnfs:=SuperGetMV("MV_TPNRNFS")
Local cE2_Naturez := "DEVOLUCAO"
PRIVATE lMsErroAuto := .F.
Private lMsHelpAuto := .T.
Private cNumero         
     
//20100805 daqui
if xtipo == 3
	_cSerieNFS := "2  "
elseif xtipo == 2 //20100819
	_cSerieNFS := "2  "
else
	_cSerieNFS := "MOV"
endif
//20100805 ate aqui

if nNumNF <= 15
   nNumNF := 1
else
    nNumNF := int(nNumNF)
endif
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//| Verifica o ultimo documento valido para um fornecedor |
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SF1")
dbSetOrder(1)

For nY := 1 To nNumNF
    aCabec := {}
    aItens := {}
    cdoc := NxtSX5Nota( _cSerieNFS,.T.,_cmvnfs)
    if xtipo == 3
       aadd(aCabec,{"F1_TIPO"   ,"B"})
       aadd(aCabec,{"F1_FORMUL" ,"S"})
       aadd(aCabec,{"F1_DOC"    ,cdoc})
       aadd(aCabec,{"F1_SERIE"  ,_cSerieNFS})
       aadd(aCabec,{"F1_EMISSAO",dDataBase})
       aadd(aCabec,{"F1_FORNECE",m->ZZY_client})
       aadd(aCabec,{"F1_LOJA"   ,m->ZZY_loja})
       aadd(aCabec,{"F1_ESPECIE","SPED"}) //20100707 NFE
       aadd(aCabec,{"F1_COND"   ,"201"})
       aadd(aCabec,{"E2_NATUREZ",cE2_Naturez})
       aadd(aCabec,{"F1_VALMERC",nVlTot,NIL})
       aadd(aCabec,{"F1_VALBRUT",nVlTot,NIL})
    else
       aadd(aCabec,{"F1_TIPO"   ,"N"})
       aadd(aCabec,{"F1_FORMUL" ,"S"})
       aadd(aCabec,{"F1_DOC"    ,cdoc})
       aadd(aCabec,{"F1_SERIE"  ,_cSerieNFS})
       aadd(aCabec,{"F1_EMISSAO",dDataBase})
       aadd(aCabec,{"F1_DESPESA",0})
       aadd(aCabec,{"F1_FORNECE",cCodCli})
       aadd(aCabec,{"F1_LOJA"   ,cCodLoja})
       aadd(aCabec,{"F1_ESPECIE","SPED"}) //20100707 NFE
       aadd(aCabec,{"F1_COND"   ,"201"})
       aadd(aCabec,{"F1_DESCONT",0,NIL})
       aadd(aCabec,{"F1_SEGURO" ,0,NIL})
       aadd(aCabec,{"F1_FRETE"  ,0,NIL})
       aadd(aCabec,{"F1_VALMERC",nVlTot,NIL})
       aadd(aCabec,{"F1_VALBRUT",nVlTot,NIL})
    endif
    
    For nX := 1 To len(aCols)
        aLinha := {}
        if aCols[nX][7] > 0     // ZZY_qtdarm or ZZY_qtdtra
	        aadd(aLinha,{"D1_ITEM" ,strzero(nX,2),Nil})
	        aadd(aLinha,{"D1_COD" ,aCols[nX][5],Nil})
	        if xtipo == 2
	           aadd(aLinha,{"D1_QUANT",aCols[nX][7],Nil})
	           aadd(aLinha,{"D1_VUNIT",aCols[nX][10],Nil})
	           aadd(aLinha,{"D1_TOTAL",(aCols[nX][7] * aCols[nX][10]),Nil}) 
          	   if cConsEmp ="E" //20100317
	          	   aadd(aLinha,{"D1_TES","022",Nil})
	   	           posicione("SF4",1,xfilial("SF4")+"022","F4_CODIGO") //20100810
	        	else 
		        	aadd(aLinha,{"D1_TES","153",Nil})
		        	posicione("SF4",1,xfilial("SF4")+"153","F4_CODIGO") //20100810
	        	endif
	           aadd(aLinha,{"D1_SEGURO",0,NIL})
	           aadd(aLinha,{"D1_VALFRE",0,NIL})
               aadd(aLinha,{"D1_DESPESA",0,NIL})
	        else
	            aadd(aLinha,{"D1_QUANT",aCols[nX][7],Nil})
    	        aadd(aLinha,{"D1_VUNIT",aCols[nX][10],Nil})
	            aadd(aLinha,{"D1_TOTAL",(aCols[nX][7] * aCols[nX][10]),Nil})
	            if cConsEmp ="E" //20100317
	          	    aadd(aLinha,{"D1_TES","023",Nil}) //20100705: era 020
	          	    posicione("SF4",1,xfilial("SF4")+"023","F4_CODIGO") //20100810
	        	else     
	        		aadd(aLinha,{"D1_TES","019",Nil}) //20100128: era 005
	        		posicione("SF4",1,xfilial("SF4")+"019","F4_CODIGO") //20100810
	        	endif
	        	aadd(aLinha,{"D1_NFORI",aCols[nX][3],NIL})
	        	aadd(aLinha,{"D1_SERIORI",aCols[nX][4],NIL})
            	aadd(aLinha,{"D1_ITEMORI",aCols[nX][1],NIL})
            	aadd(aLinha,{"D1_IDENTB6",posicione("SD2",3,xfilial("SD2")+aCols[nX][3]+aCols[nX][4]+m->(zzy_client+zzy_loja)+aCols[nX][5]+aCols[nX][1],"D2_IDENTB6"),NIL})
	        endif
	        posicione("SB1",1,xfilial("SB1")+aCols[nx][5],"B1_COD") //20100810
	        aadd(aLinha,{"D1_CLASFIS",Subs(SB1->B1_ORIGEM,1,1)+SF4->F4_SITTRIB,NIL}) //20100810
	        aadd(aLinha,{"AUTDELETA" ,"N",Nil}) // Incluir sempre no ๚ltimo elemento do array de cada item
	
	        aadd(aItens,aLinha)                       
		endif
    Next nX
    MATA103(aCabec,aItens,3)
    If !lMsErroAuto
       while __lsx8
             confirmsx8()
       enddo
    Else
    	Mostraerro()
        MsgInfo("Erro na inclusao da Nota Fiscal, verifique!!!")

		dbselectarea("ZZY")
		dbsetorder(1)
		
		for nX := 1 to len(aCols)
		
		    if aCols[Nx][7] > 0
		       dbseek(xfilial("ZZY")+aCols[nX][3]+aCols[nX][4]+m->zzy_client+m->zzy_loja+aCols[nX][5]+aCols[nX][2])
		       reclock("ZZY",.f.)
		       if xtipo == 3   
		          zzy_q3fim  := zzy_q3fim + zzy_qtdarm
                  zzy_qtdarm := 0                     
                  zzy_ok     := ""
               else
                  zzy_qtdtra := 0 
                  zzy_ok     := ""
               endif
		       msunlock()
		    endif
		
		next nX        
        return
    EndIf
Next nY        

dbselectarea("ZZY")
dbsetorder(1)

for nX := 1 to len(aCols)

    if aCols[Nx][7] > 0
       dbseek(xfilial("ZZY")+aCols[nX][3]+aCols[nX][4]+m->zzy_client+m->zzy_loja+aCols[nX][5]+aCols[nX][2])
       reclock("ZZY",.f.)
       if xtipo == 2
   	      zzy_tdoc := cdoc
       elseif xtipo == 3
    	  zzy_adoc := cdoc
       endif
       
       if zzy_atend == "Encerrado"
          zzy_ok := "OK"
       endif
       msunlock()
    endif

next nX

Return nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGravaPED  บAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava os dados ajustados para a emissใo da Nota Fiscal de   บฑฑ
ฑฑบ          ณentrada e o pedido de venda                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GravaPED()
Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local nX := 0
Local nY := 0
Local nNumNF := len(aCols)/15
Local lOk := .T.
Local _cSerieNFS := "MOV" // "UNI" //20100630 MOV
Local _cmvnfs:=SuperGetMV("MV_TPNRNFS")
Local cE2_Naturez := "DEVOLUCAO"
PRIVATE lMsErroAuto := .F.
Private lMsHelpAuto := .T.
Private cNumero

if nNumNF <= 15
   nNumNF := 1
else
    nNumNF := int(nNumNF)
endif

dbSelectArea("SF1")
dbSetOrder(1)

For nY := 1 To nNumNF
    aCabec := {}
    aItens := {}
    cdoc := NxtSX5Nota( _cSerieNFS,.T.,_cmvnfs)
    aadd(aCabec,{"F1_TIPO"   ,"B"})
    aadd(aCabec,{"F1_FORMUL" ,"S"})
    aadd(aCabec,{"F1_DOC"    ,cdoc})
    aadd(aCabec,{"F1_SERIE"  ,_cSerieNFS})
    aadd(aCabec,{"F1_EMISSAO",dDataBase})
    aadd(aCabec,{"F1_FORNECE",m->ZZY_client})
    aadd(aCabec,{"F1_LOJA"   ,m->ZZY_loja})
    aadd(aCabec,{"F1_ESPECIE","SPED"}) //20100707 NFE
    aadd(aCabec,{"F1_COND"   ,cPagto})
    aadd(aCabec,{"E2_NATUREZ",cE2_Naturez})
    aadd(aCabec,{"F1_VALMERC",nVlTot})
    aadd(aCabec,{"F1_VALBRUT",nVlTot})

    For nX := 1 To len(aCols)
        aLinha := {}
        if aCols[nX][7] > 0     // ZZY_qtdven
	        aadd(aLinha,{"D1_ITEM" ,aCols[nX][1],Nil})
	        aadd(aLinha,{"D1_COD" ,aCols[nX][5],Nil})
            aadd(aLinha,{"D1_QUANT",aCols[nX][7],Nil})
	        aadd(aLinha,{"D1_VUNIT",aCols[nX][11],Nil})
	        aadd(aLinha,{"D1_TOTAL",(aCols[nX][7] * aCols[nX][11]),Nil})
	        if cConsEmp ="E" //20100317
		       	aadd(aLinha,{"D1_TES","023",Nil}) //20100705: era 020
		       	posicione("SF4",1,xfilial("SF4")+"023","F4_CODIGO")  //20100810
	        else                                             
	           	aadd(aLinha,{"D1_TES","018",Nil}) //20090521: 005
	           	posicione("SF4",1,xfilial("SF4")+"018","F4_CODIGO") //20100810
	        endif
		    aadd(aLinha,{"D1_NFORI",aCols[nX][3],NIL})
	        aadd(aLinha,{"D1_SERIORI",aCols[nX][4],NIL})
            aadd(aLinha,{"D1_ITEMORI",aCols[nX][1],NIL})
            aadd(aLinha,{"D1_NATUREZ",cE2_Naturez,NIL}) //20090909 NATUREZA DE DEVOLUCAO
            aadd(aLinha,{"D1_IDENTB6",posicione("SD2",3,xfilial("SD2")+aCols[nX][3]+aCols[nX][4]+m->(zzy_client+zzy_loja)+aCols[nX][5]+aCols[nX][1],"D2_IDENTB6"),NIL})
			posicione("SB1",1,xfilial("SB1")+aCols[nx][5],"B1_COD") //20100810
	        aadd(aLinha,{"D1_CLASFIS",Subs(SB1->B1_ORIGEM,1,1)+SF4->F4_SITTRIB,NIL}) //20100810
	        aadd(aLinha,{"AUTDELETA" ,"N",Nil}) // Incluir sempre no ๚ltimo elemento do array de cada item

	        aadd(aItens,aLinha)                       
		endif
    Next nX
    MATA103(aCabec,aItens,3)
    If !lMsErroAuto
       while __lsx8
             confirmsx8()
       enddo
		// 20081201 Danilo C S Pala DAQUI
       	//F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO
		dbselectarea("SF1")
		dbsetorder(1)
		if dbseek(xfilial("SF1")+ PADR(cdoc,9) + _cSerieNFS + m->zzy_client + m->zzy_loja +"B") //mp10
			reclock("SF1",.f.)
				F1_OBS := "PEDIDO: " + m->ZZY_pedido
			msunlock()
		endif // 20081201 Danilo C S Pala ATE DAQUI

       MsgInfo("Nota Fiscal de Retorno nบ "+cdoc+" gerada!!")
    Else
    	Mostraerro()
        MsgInfo("Erro na inclusao da Nota Fiscal, verifique!!!")          

		For nX := 1 To len(aCols)
			if aCols[nX][7] > 0
       			dbseek(xfilial("ZZY")+aCols[nX][3]+aCols[nX][4]+m->zzy_client+m->zzy_loja+aCols[nX][5]+aCols[nX][2])
       			reclock("ZZY",.f.)
				ZZY_nclien := ""
				ZZY_nloja  := ""
				zzy_nnome  := ""
				ZZY_pedido := ""
				zzy_q3fim  := zzy_q3fim + zzy_qtdven
				zzy_qtdven := 0
				zzy_pvenda := 0
				zzy_ok     := ""
				msunlock()
			endif
		next nX
        
        return
    EndIf
Next nY

dbselectarea("SC5")
dbsetorder(1)
dbseek(xfilial("SC5")+m->ZZY_pedido)

if eof()
	reclock("SC5",.t.)
	c5_filial	:= xfilial("SC5")
	c5_num		:= m->ZZY_pedido
	c5_tipo		:= "N"
	c5_divven	:= "MERC"
	c5_codprom	:= "N"
	c5_identif	:= "."
	c5_cliente	:= m->ZZY_nclien
	c5_lojacli	:= m->ZZY_nloja
	c5_lojaent  := m->zzy_nloja
	c5_tipocli	:= "F"
	c5_condpag	:= cPagto
	c5_lotefat	:= ""
	c5_data		:= ddatabase
	c5_emissao	:= ddatabase //20081201 danilo: solicitado por sandra
	c5_vend1	:= c1Comis
	c5_vlrped	:= nVlVend
	c5_vend4	:= c2Comis
	c5_tipoop	:= cTipoOper
	c5_dtcalc	:= ddatabase
	c5_avesp	:= "N"
	c5_tptrans	:= "99"
	c5_mennota	:= cObs
	msunlock()
else
	reclock("SC5",.f.)
	c5_vlrped := nVlVend
	msunlock()
endif

dbselectarea("SC6")
dbsetorder(1)
if dbseek(xfilial("SC6")+m->zzy_pedido)
   do while .t.
      nqItem := nqItem + 1
      dbskip()
      if eof() .or. sc6->c6_num <> m->zzy_pedido
         exit
      endif
   enddo
endif

For nX := 1 To len(aCols)
	if aCols[nX][7] > 0
		reclock("SC6",.t.)
		c6_filial	:= xfilial("SC6")
        if nqItem > 0
           c6_item    := strzero((nX+nqItem),2)
        else
           c6_item     := strzero(nX,2)
        endif
		c6_produto	:= aCols[nX][5]
		c6_local    := posicione("SD2",3,xfilial("SD2")+aCols[nX][3]+aCols[nX][4]+m->(zzy_client+zzy_loja)+aCols[nX][5]+aCols[nX][1],"D2_LOCAL")
		c6_descri	:= aCols[nX][6]
		c6_tes		:= posicione("SB1",1,xfilial("SB1")+aCols[nx][5],"B1_TS")
		c6_cf       := posicione("SF4",1,xfilial("SF4")+c6_tes,"F4_CF")
		c6_localcli	:= posicione("SD2",3,xfilial("SD2")+m->ZZY_doc+m->ZZY_serie+m->ZZY_client+m->ZZY_loja+aCols[nX][5]+aCols[nX][2],"D2_LOJA")
		c6_qtdven	:= aCols[nX][7]
		c6_prcven	:= aCols[nX][8]
		c6_valor	:= aCols[nX][7] * aCols[nX][8]
		c6_data		:= ddatabase
		c6_cli		:= m->ZZY_nclien
		c6_loja		:= m->ZZY_nloja
		c6_num		:= m->ZZY_pedido
		c6_tpop		:= "F"
		c6_tiporev  := "0"
		C6_EDINIC   := 9999
        C6_EDFIN    := 9999
        C6_EDVENC   := 9999
        C6_EDSUSP   := 9999
        C6_REGCOT   := '99'+space(13)
        C6_TPPROG   := 'N'
        C6_SITUAC   :='AA'                                                        
        c6_comis1 := iif(cTComis1 $ "OP",posicione("SZ3",1,xfilial("SZ3")+aCols[nX][5]+cRegiao,"Z3_COMOTEL"),posicione("SZ3",1,xfilial("SZ3")+aCols[nX][5]+cRegiao,"Z3_COMREP1"))
        if !empty(sc5->c5_vend3)
        	c6_comis3 := posicione("SZ3",1,xfilial("SZ3")+aCols[nX][5]+cRegiao,"Z3_COMSUP")
        endif
        if !empty(sc5->c5_vend4)
        	c6_comis4 := posicione("SZ3",1,xfilial("SZ3")+aCols[nX][5]+cRegiao,"Z3_COMGLOC")
        endif     
        C6_CLASFIS := Subs(SB1->B1_ORIGEM,1,1)+SF4->F4_SITTRIB //20100715

		msunlock()
	endif
next nX

Return nil
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCalczzy   บAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica os dados em cada linha digitada                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                             
User Function Calczzy()

Local noldq3fim := buscacols("ZZY_Q3FIM")
Local nq3fim := buscacols("ZZY_Q3FIM")
Local nPrUnit := buscacols("ZZY_PRUNIT")
Local gravaSaldo := zzy->zzy_q3fim

if noldq3fim < gravaSaldo
   noldq3fim := gravaSaldo
endif

if xtipo == 1 .and. m->ZZY_qtdven > 0
	nq3fim := nq3fim - m->ZZY_qtdven
	if nq3fim < 0
		MsgInfo("Quantidade de Venda Informada ้ Superior ao Saldo Existente, verifique!!!",cTitulo)
		nq3fim := noldq3fim
		aCols[n][7]:= 0 //m->ZZY_qtdven := 0
	endif	
	nVlTot += m->ZZY_qtdven * nPrUnit
elseif xtipo == 2 .and. m->ZZY_qtdtra > 0
	nq3fim := nq3fim - m->ZZY_qtdtra
	if nq3fim < 0
		MsgInfo("Quantidade de Transporte Informada ้ Superior ao Saldo Existente, verifique!!!",cTitulo)
		nq3fim := noldq3fim
		aCols[n][7]:= 0 //m->ZZY_qtdtra := 0
	endif		
	nVlTot += m->ZZY_qtdtra * nPrUnit
elseif xtipo == 3 .and. m->ZZY_qtdarm > 0
	nq3fim := nq3fim - m->ZZY_qtdarm
	if nq3fim < 0
		MsgInfo("Quantidade de Armazenagem Informada ้ Superior ao Saldo Existente, verifique!!!",cTitulo)
		nq3fim := noldq3fim
		aCols[n][7]:= 0 //m->ZZY_qtdarm := 0
	endif		
	nVlTot += m->ZZY_qtdarm * nPrUnit
elseif m->ZZY_qtdven < 0 .or. m->ZZY_qtdarm < 0 .or. m->ZZY_qtdtra < 0
	MsgInfo("Nใo ้ permitido lan็ar valores negativo, verifique!!!",cTitulo)
elseif m->zzy_qtdven == 0 .or. m->zzy_qtdarm == 0 .or. m->zzy_qtdtra == 0
   if nVlTot > 0
		nVlTot := nVltot - nPrUnit
   endif
   nq3fim := gravaSaldo
   if nVlVend >0 
   		nVlVend := nVlVend - buscacols("ZZY_PVENDA")
   endif             
   if xtipo == 1
      aCols[n][8]:= 0 //m->zzy_pvenda := 0
   endif
endif

return(nq3fim)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCalcped   บAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica os dados em cada linha digitada                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                             
User Function Calcped()

Local nPrVenda := buscacols("ZZY_PVENDA")
Local nQVenda := buscacols("ZZY_QTDVEN")

if xtipo == 1 .and. nQVenda > 0
	nVlVend += m->zzy_qtdven * nPrVenda
elseif nQVenda == 0
	nVlVend := nVlVend - nPrVenda
	if nVlVend < 0
		nVlVend := 0
	endif
	nPrVenda := 0
endif

return(nPrVenda)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVerLinOK  บAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica os dados em cada linha digitada                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                             
User Function VerLinOK()   

Local lRet := .t.

if xtipo == 1 .and. m->ZZY_qtdven < 0
	MsgInfo("Nใo ้ permitido valores negativos para Pedidos de Venda, verifique!!!",cTitulo)
	lret := .f.                                       
elseif xtipo == 1 .and. m->zzy_pvenda <= 0 .and. m->zzy_qtdven > 0
	MsgInfo("Nใo ้ permitido Pre็o de venda negativo ou zerado, verifique !!!",cTitulo)
	lret := .f.
elseif xtipo == 2 .and. m->ZZY_qtdtra < 0
	MsgInfo("Nใo ้ permitido valores negativos para Transporte, verifique!!!",cTitulo)
	lret := .f.	
elseif xtipo == 3 .and. m->ZZY_qtdarm < 0                   
	MsgInfo("Nใo ้ permitido valores negativos para Armazenagem, verifique!!!",cTitulo)
	lret := .f.	
endif

Return lRet       

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVerTudOK  บAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica os dados se estใo tudo certos                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                             
User Function VerTudOK()

Local lRet := .t.
Local i    := 0
Local nDel := 0

For i := 1 to Len(aCols)
	if aCols[i][Len(aHeader)+1]
		nDel++
	endif
Next

if nDel == Len(aCols)
	MsgInfo("Nesta Op็ใo nใo ้ possํvel excluir dados!!!",cTitulo)
	lRet := .f.
endif

if xtipo == 1
   if empty(m->zzy_nclien) .or. empty(m->zzy_pedido) .or. empty(cPagto) .or. empty(cTipoOper) .or. empty(c1Comis)
      msgInfo("Existem campos obrigat๓rios em branco!! Verifique Cliente, Pedido, Condi็๕es de Pagto, Tipo de Opera็ใo e Comissใo",cTitulo)
      lRet := .f.
   endif
endif

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidPerg บAutor  ณMarcio Torresson    บ Data ณ  10/06/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria parametros no SX1 nao existir os parametros.           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Pini                                                       บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
//
//mv_par01 - Vendedor de
//mv_par02 - Vendedor at้
//mv_par03 - Nota de
//mv_par04 - Nota at้
//mv_par05 - Emissใo de
//mv_par06 - Emissใo at้
//mv_par07 - Encerradas

aAdd(aRegs,{cPerg,"01","Vendedor de?   ","Vendedor de?   ","Vendedor de?   ","mv_ch1","C",06,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","SA1","","","",""})
aAdd(aRegs,{cPerg,"02","Vendedor at้?  ","Vendedor at้?  ","Vendedor at้?  ","mv_ch2","C",06,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","SA1","","","",""})
aAdd(aRegs,{cPerg,"03","Nota de?       ","Nota de?       ","Nota de?       ","mv_ch3","C",09,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Nota at้?      ","Nota at้?      ","Nota at้?      ","mv_ch4","C",09,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Emissใo de?    ","Emissใo de?    ","Emissใo de?    ","mv_ch5","D",08,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","Emissใo at้?   ","Emissใo at้?   ","Emissใo at้?   ","mv_ch6","D",08,0,0,"G","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"07","Encerradas?    ","Encerradas?    ","Encerradas?    ","mv_ch7","C",01,0,2,"C","","MV_PAR07","Sim","Sim","Sim","","","Nใo","Nใo","Nใo","","","","","","","","","","","","","","","","","","","","",""})

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


Static Function ValidConsEmp()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
aAdd(aRegs,{cPerg,"01","Tipo?","Tipo?","Tipo?","mv_ch1","N",01,0,2,"C","","MV_PAR01","Consignacao","Consignacao","Consignacao","","","Emprestimo","Emprestimo","Emprestimo","","","","","","","","","","","","","","","","","","","","",""})

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