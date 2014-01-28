#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/
Danilo C S Pala em 20090119: Nao sair no relatorio onde a3_tipoven='3' (Josiani)
Danilo C S Pala em 20110223: Nao calcular IR e ISS para o Claudio Mitidieri
Alterado por Rodrigo Simoes 20120724: Ocultar desconto ISS linha 331
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ฑฑ
ฑฑณPrograma: PFAT172    ณAutor: DANILO C S PALA       ณ Data:   20061027 ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณDescriฦo: Recibos e Demonstrativos de direitos de Publicacao, BASEADO NO RFAT040         ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณUso      : Mขdulo de Faturamento                                      ณ ฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู ฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function PFAT172()

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,MDT")
SetPrvt("M_PAG,MMES,MANO,MMESANO,CTITULO,CPROGRAMA")
SetPrvt("CTAMANHO,cLIMITE,NCARACTER,NLASTKEY,CDESC1,CDESC2")
SetPrvt("CDESC3,ARETURN,CARQ,CINDEX,CKEY,WNREL")
SetPrvt("CSTRING,MAUT,MNOME,MMOEDA,MDOC,MVMIN")
SetPrvt("MVIGPM,MVLBR,MVLLIQ,MVLISS,MQTDE,MTLIQ")
SetPrvt("MTBR,MFLAG,MPROD,L,MVLIRF,XQTDE")
SetPrvt("XLIQ,XBR,MTIT,MTIT1,MTIT2,MTIT3")
SetPrvt("MTIT4, cQuery,mhora")
SetPrvt("_aCampos, _cNome, CINDEX1, CKEY, AUTORANT, MLIVRO, SOMAVALORAUT, SOMAVLVRUTO, SOMAQTD")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Vari veis utilizadas para parametros     ณ
//ณ mv_par01             //Periodo Inicial   ณ
//ณ mv_par02             //Periodo Final     ณ
//ณ mv_par03             //Data Pagamento    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
CPERG := 'PFAT49'
IF !PERGUNTE(CPERG)
	RETURN
ENDIF
MDT       := DDATABASE
M_PAG     := 1
MMES      := MONTH(MV_PAR02)
MANO      := YEAR(MV_PAR02)
MMESANO   := STR(MONTH(MV_PAR02),2)+STR(YEAR(MV_PAR02),4)
cTitulo   := SPACE(04)+"***** RECIBOS E DEMONSTRATIVOS DE DIREITOS DE PUBLICACAO *****"
cPrograma := "PFAT172"
cTamanho  := "P"
cLIMITE    := 80
nCaracter := 12
NLASTKEY  := 0
cDesc1    := PADC("Este programa gera os recibos e demonstrativos",70)
cDesc2    := PADC("de direitos de publicacao",70)
cDesc3    := "  "
aRETURN   := {"Especial", 1,"Administracao", 1, 2, 1," ",1 }
MHORA      := TIME()
WNREL     := "PFAT172_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING   := "SA3"
WNREL     := SETPRINT(CSTRING,WNREL,CPERG,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
SETDEFAULT(aRETURN,CSTRING)

//TABELA AUXILIAR PARA TOTALIZACAO POR PRODUTO
_aCampos := {{"PRODUTO"  ,"C",15,0} ,;
{"LIVRO"    ,"C",40, 0} ,;
{"QTD"      ,"N",6,  0} ,;
{"VALBRUTO" ,"N",12, 2} ,;
{"PERCENT"  ,"N",6,  2} ,;
{"VALAUT"   ,"N",12, 2} ,;
{"MOEDA"   ,"C",1, 0}}
_cNome  := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"AUXAUT",.F.,.F.)
CINDEX1 := CRIATRAB(NIL,.F.)
CKEY    := "PRODUTO"
INDREGUA("AUXAUT",CINDEX1,CKEY,,,"CRIANDO AUXAUT")

Processa({|| RptDetail()})
Return



/*
//ฺฤฤฤฤฤฤฤฤฤฟ
//ณRELATORIOณ
//ภฤฤฤฤฤฤฤฤฤู
*/
Static Function RptDetail()
DbSelectArea("ZZV")
if RDDName() <> "TOPCONN"
		MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
		Return nil
endif

//cQuery := "SELECT zzv_autor, zzv_produt, zzv_moeda, zzv_porc, sum(zzv_valnf - zzv_descon) as val_bruto, sum(zzv_valaut) as soma_pgautor, sum(zzv_qtd) as qtd_livro from ZZV010 WHERE ZZV_FILIAL='" +xFilial("ZZV")+ "' AND ZZV_DTPGAU>='" +DTOS(MV_PAR01)+ "' AND ZZV_DTPGAU<='" +DTOS(MV_PAR02)+ "' AND ZZV_STATUS='3' AND D_E_L_E_T_<>'*' GROUP BY zzv_autor, zzv_produt, zzv_moeda, zzv_porc"
//20090119
cQuery := "SELECT zzv_autor, zzv_produt, zzv_moeda, zzv_porc, sum(zzv_valnf - zzv_descon) as val_bruto, sum(zzv_valaut) as soma_pgautor, sum(zzv_qtd) as qtd_livro from ZZV010 , SA3010
cQuery := cQuery + " WHERE A3_FILIAL='" +xFilial("SA3")+ "' AND A3_COD=ZZV_AUTOR  AND ZZV_FILIAL='" +xFilial("ZZV")+ "' AND ZZV_DTPGAU>='" +DTOS(MV_PAR01)+ "' AND ZZV_DTPGAU<='" +DTOS(MV_PAR02)+ "' AND ZZV_STATUS='3' AND A3_TIPOVEN<>'CO' AND ZZV010.D_E_L_E_T_<>'*' AND SA3010.D_E_L_E_T_<>'*' GROUP BY zzv_autor, zzv_produt, zzv_moeda, zzv_porc ORDER BY zzv_autor, zzv_produt, zzv_moeda, zzv_porc"

TCQUERY cQuery NEW ALIAS "QUERYZZV"
DbSelectArea("QUERYZZV")
DBGOTOP()
AUTORANT     := ""
MLIVRO 		 := SPACE(30)
SOMAVALORAUT := 0
SOMAVLVRUTO  := 0
SOMAQTD 	 := 0       
MOEDAANT 	 := SPACE(1)
PROCREGUA(RECCOUNT())
WHILE !EOF()
	INCPROC("Lendo Autor: "+Alltrim(QUERYZZV->ZZV_AUTOR) +": "+ Alltrim(QUERYZZV->ZZV_PRODUT))
	IF AUTORANT <> QUERYZZV->ZZV_AUTOR .AND. AUTORANT <> ""
		IMPRIMIR() //IMPRIME DADOS DO AUTOR E LIVROS, ALEM DE LIMPAR AS VARIAVEIS TOTALIZADORAS
	ENDIF

	DBSELECTAREA("SB1")
	DBSETORDER(01)
	IF DBSEEK(XFILIAL()+QUERYZZV->ZZV_PRODUT)
		MLIVRO := SUBS(SB1->B1_DESC,1,30)
	ELSE
		MLIVRO := SPACE(30)
	ENDIF
	                      
	DBSELECTAREA("AUXAUT")
	RECLOCK("AUXAUT",.T.)
		AUXAUT->PRODUTO  := QUERYZZV->ZZV_PRODUT
		AUXAUT->LIVRO    := MLIVRO
		AUXAUT->QTD      := QUERYZZV->QTD_LIVRO
		AUXAUT->VALBRUTO := QUERYZZV->VAL_BRUTO
		AUXAUT->PERCENT  := QUERYZZV->ZZV_PORC
		AUXAUT->VALAUT   := QUERYZZV->SOMA_PGAUTOR
		AUXAUT->MOEDA    := QUERYZZV->ZZV_MOEDA
	MsUnlock()   

	SOMAVALORAUT := SOMAVALORAUT + QUERYZZV->SOMA_PGAUTOR
	SOMAVLVRUTO  := SOMAVLVRUTO + QUERYZZV->VAL_BRUTO
	SOMAQTD 	 := SOMAQTD + QUERYZZV->QTD_LIVRO

	MOEDAANT := QUERYZZV->ZZV_MOEDA
	AUTORANT := QUERYZZV->ZZV_AUTOR
		
	DBSELECTAREA("QUERYZZV")
	DBSKIP()
END               
IMPRIMIR() //imprime o ultimo autor

SET DEVI TO SCREEN
IF aRETURN[5] ==1
	SET PRINTER TO
	DBCOMMITALL()
	OURSPOOL(WNREL)
ENDIF
MS_FLUSH()
DBSELECTAREA("QUERYZZV")
DBCLOSEAREA()
DBSELECTAREA("SA3")
RETINDEX("SA3")
DBSELECTAREA("SB1")
RETINDEX("SB1")     
DBSELECTAREA("AUXAUT")
DBCLOSEAREA()
RETURN


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPFAT172   บAutor  ณMicrosiga           บ Data ณ  11/09/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ IMPRIMIR                                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION IMPRIMIR()
@ 00,00 PSAY AVALIMP(80)
@ 01,01 PSAY REPLICATE('-',79)

DBSELECTAREA("SA3")
DBSETORDER(1)
IF DBSEEK(XFILIAL("SA3")+AUTORANT)
	MNOME  := SA3->A3_NOME
	MDOC   := SA3->A3_TIPODOC
	MFLAG  := 'P'
	if MOEDAANT == "D"
		MMOEDA := "R$"
	else
		MMOEDA := "R$"
	endif

	MVLBR  := SOMAVALORAUT      
	MVLIRF := 0
	MVLISS := 0 
	IRFISS() //CALCULA O MVLIRF e o MVLISS 
	MVLLIQ := (MVLBR - MVLIRF - MVLISS)
	IF SA3->A3_TIPODOC == 'R'
		@ 02,37 PSAY "RECIBO"
		MTIT  := "VALOR DOS DIREITOS AUTORAIS"
		MTIT1 := "Recebi da Editora Pini Ltda - CNPJ 60.859.519/0001-51, estabelecida a Rua "
		MTIT2 := "Anhaia, 964 - Bom Retiro - Sao Paulo, a importancia liquida supra citada, "
		MTIT3 := "ref a Direitos de Publicacao do mes "+STR(MMES,2)+"/"+STR(MANO,4)+", conforme demonstrativo"
		IF MFLAG == 'P'
			MTIT4 := "abaixo :"
		ELSE
			MTIT4 := "anexo :"
		ENDIF
	ELSE
		@ 02,33 PSAY "DEMONSTRATIVO"
		MTIT  := "DEMONSTRATIVO DE PAGAMENTOS"
		MTIT1 := " "
		MTIT2 := SPACE(28) + "DEMONSTRATIVO DE VENDAS"
		MTIT3 := " "
		IF MFLAG == 'P'
			MTIT4 := " "
		ELSE
			MTIT4 := SPACE(36) + "ANEXO"
		ENDIF
	ENDIF
	@ 03,01 PSAY REPLICATE('-',79)
	@ 05,32 PSAY "DADOS DO AUTOR"
	@ 07,01 PSAY "NOME....: " + MNOME
	@ 08,01 PSAY "ENDERECO: " + SA3->A3_END
	@ 09,01 PSAY "CIDADE..: " + SA3->A3_MUN+SPACE(5)+'-'+SPACE(5)+SA3->A3_EST
	@ 10,01 PSAY "CEP.....: " + SUBS(SA3->A3_CEP,1,5)+'-'+SUBS(SA3->A3_CEP,6,3)
	@ 11,01 PSAY "CIC/CGC.: " + SA3->A3_CGC
	@ 12,01 PSAY REPLICATE('-',79)
	@ 14,26 PSAY MTIT
	@ 16,01 PSAY "VALOR BRUTO .....: " + MMOEDA
	@ 16,23 PSAY MVLBR  PICTURE "@E 999,999.99"
	@ 18,01 PSAY "DESCONTOS:"
	@ 20,01 PSAY "IMPOSTO DE RENDA : " + MMOEDA
	@ 20,23 PSAY MVLIRF PICTURE "@E 999,999.99"
	@ 21,01 PSAY "I.S.S ...........: " + MMOEDA
	@ 21,23 PSAY MVLISS PICTURE "@E 999,999.99" 
	@ 21,60 PSAY (MVLIRF+MVLISS) PICTURE "@E 999,999.99"
	@ 23,01 PSAY "VALOR LIQUIDO ...: " + MMOEDA
	@ 23,23 PSAY MVLLIQ PICTURE "@E 999,999.99"
	@ 25,01 PSAY "DATA PAGAMENTO ..: " + DTOC(MV_PAR03)
	@ 26,01 PSAY REPLICATE('-',79)
	@ 27,01 PSAY MTIT1
	@ 28,01 PSAY MTIT2
	@ 29,01 PSAY MTIT3+MTIT4
	@ 30,01 PSAY REPLICATE('-',8)+' '+REPLICATE('-',30)+' '+REPLICATE('-',6)
	@ 30,48 PSAY REPLICATE('-',10)+' '+REPLICATE('-',9)+' '+REPLICATE('-',11)
	IF MFLAG == 'P'
		@ 31,01 PSAY "CODIGO"
		@ 31,10 PSAY "LIVRO"
		@ 31,42 PSAY "QTDE"
		@ 31,48 PSAY "VL. VENDAS"
		@ 31,59 PSAY "DIR PUBL."
		@ 31,69 PSAY "DIR PUBLIC."
		@ 32,41 PSAY "VENDID"
		@ 32,49 PSAY "LIQUIDO"
		@ 32,60 PSAY "PERCENT"
		@ 32,71 PSAY "BRUTO"
		@ 33,01 PSAY REPLICATE('-',8)+' '+REPLICATE('-',30)+' '+REPLICATE('-',6)
		@ 33,48 PSAY REPLICATE('-',10)+' '+REPLICATE('-',9)+' '+REPLICATE('-',11)
	ENDIF
ENDIF
L := 35

//LOOP NA TABELA AUXILIAR
DBSELECTAREA("AUXAUT")
DBGOTOP()
WHILE !EOF()
	@ L,01 PSAY SUBS(AUXAUT->PRODUTO,1,8)
	@ L,10 PSAY SUBS(AUXAUT->LIVRO,1,30)			
	@ L,41 PSAY AUXAUT->QTD     PICTURE "@E 999999"
	@ L,48 PSAY AUXAUT->VALBRUTO PICTURE "@E 999,999.99"
	@ L,60 PSAY AUXAUT->PERCENT  PICTURE "@E 999.99"
	@ L,69 PSAY AUXAUT->VALAUT   PICTURE "@E 999,999.99"
	L := L+2                                     
	RecLock("AUXAUT",.F.)
		DELETE
    MSUnlock()
	DBSKIP()
END
@ L,01 PSAY "TOTAIS .............................: "
@ L,41 PSAY SOMAQTD PICTURE "@E 999999"
@ L,48 PSAY SOMAVLVRUTO PICTURE "@E 999,999.99"
@ L,69 PSAY SOMAVALORAUT  PICTURE "@E 999,999.99"
L := L+5
@ L,01 PSAY "SAO PAULO, "
@ L,12 PSAY MDT
@ L,55 PSAY REPLICATE('_',24)
L := L+1
@ L,55 PSAY "Assinatura do favorecido"
L := L+3
@ L,27   PSAY    "FAVOR DEVOLVER UMA VIA ASSINADA"
@ L+1,24 PSAY "A/C JOSIANI DE SOUZA - MANUAIS TECNICOS"   
@ L+2,32 PSAY        "EDITORA PINI LTDA"
@ L+3,27 PSAY   "RUA ANHAIA 964 - BOM RETIRO"
@ L+4,29 PSAY     "01130-900 SAO PAULO  SP"

//LIMPAR VARIAVEIS E TABELA AUXILIAR
DBSELECTAREA("AUXAUT")
//zap()
SOMAVALORAUT := 0
SOMAVLVRUTO  := 0
SOMAQTD 	 := 0
RETURN



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณIRFISS () บAutor  ณDANILO C S PALA     บ Data ณ  20061109   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณProcessa IRF e ISS do Autor                                 บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION IRFISS()
	DBSELECTAREA("SZZ") //tabela com percentuais do IRF
	DBGOTOP()               
	IF SA3->A3_COD == "004026" //MITIDIERI 20110223
		MVLISS := 0
		MVLIRF := 0
	ELSE
		IF SA3->A3_PESSOA == "F"
			WHILE !EOF()
				//MVLISS := (MVLBR * 5/100)//20120724
				IF MVLBR >= SZZ->ZZ_VALORI .AND. MVLBR <= SZZ->ZZ_VALORF
					MVLIRF := ((MVLBR * (SZZ->ZZ_ALIQ/100)) - SZZ->ZZ_DEDUCAO)
				ENDIF
				DBSELECTAREA("SZZ")
				DBSKIP()
			END
		ENDIF
		IF MVLIRF < 10
			MVLIRF := 0
		ENDIF
	ENDIF
RETURN