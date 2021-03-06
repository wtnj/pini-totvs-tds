#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#INCLUDE "TOPCONN.CH"  //consulta SQL  
#include "tbiconn.ch"
/*/
Danilo C S Pala 20070208: totalizar por pessoa e tipoaut
Danilo C S Pala 20070226: incluir o codigo do fornecedor
Danilo C S Pala 20080827: arredondamento    
Danilo C S Pala 20090119: Nao sair no relatorio onde a3_tipoven='CO' (Josiani)
Danilo C S Pala 20100405: Formatar CPF e CNPJ (Josiani)
Danilo C S Pala 20100416: WLASTEMILER SENCO: ISENTO DE IR (Josiani)
Danilo C S Pala 20100909: WLASTEMILER SENCO faleceu    
Danilo C S Pala 20101007: Integracao com o Compras
Danilo C S Pala 20101015: Integracao de PJ       
Danilo C S Pala 20110223: Nao calcular IR e ISS para o Claudio Mitidieri
Danilo C S Pala 20120216: Forcar prefixo COM (Marcia)      
Rodrigo Simoes 20120723: Nao calcular ISS (Salgado)
Danilo C S Pala 20130128: Validar numero da NFEntrada
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: PFAT173    �Autor: DANILO C S PALA       � Data:   20070206 � ��
������������������������������������������������������������������������Ĵ ��
���Descri��o: relatorio da planilha do autor para pagamento pelo financeiro� ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento                                      � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function PFAT173()

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,MDT")
SetPrvt("M_PAG,MMES,MANO,MMESANO,CTITULO,CPROGRAMA")
SetPrvt("CTAMANHO,cLIMITE,NCARACTER,NLASTKEY,CDESC1,CDESC2")
SetPrvt("CDESC3,ARETURN,CARQ,CINDEX,CKEY,WNREL")
SetPrvt("CSTRING,MAUT,MNOME,MMOEDA,MDOC,MVMIN")
SetPrvt("MVIGPM,MVLBR,MVLLIQ,MVLISS,MQTDE,MTLIQ")
SetPrvt("MTBR,MFLAG,MPROD,L,MVLIRF,XQTDE")
SetPrvt("XLIQ,XBR,MTIT,MTIT1,MTIT2,MTIT3")
SetPrvt("MTIT4, cQuery,mhora")
SetPrvt("_aCampos, _cNome, CINDEX1, CKEY, AUTORANT, MLIVRO, SOMAVALORAUT, SOMAVLVRUTO, SOMAQTD, L")
SetPrvt("CTIPOAUT, SOMALIQ, SOMAIRF, SOMAISS, cCGC,dDtVencto, nGeraNFE")
Private cNomeModulo := CARQREL
//������������������������������������������Ŀ
//� Vari�veis utilizadas para parametros     �
//� mv_par01             //Periodo Inicial   �
//� mv_par02             //Periodo Final     �
//� mv_par03             //Data Pagamento    �
//� mv_par04             //Gera NF?          �
//��������������������������������������������
CPERG := 'PFAT49'
ValidPerg()
IF !PERGUNTE(CPERG)
	RETURN
ENDIF
MDT       := DDATABASE
M_PAG     := 1
MMES      := MONTH(MV_PAR02)
MANO      := YEAR(MV_PAR02)
MMESANO   := STR(MONTH(MV_PAR02),2)+STR(YEAR(MV_PAR02),4)
cTitulo   := SPACE(09)+"***** PLANILHA DE PAGAMENTOS - DIREITOS AUTORAIS *****"
cPrograma := "PFAT173"
cTamanho  := "G"
cLIMITE   := 80
nCaracter := 12
NLASTKEY  := 0
cDesc1    := PADC("Este programa gera a planilha dos direitos autorais",70)
cDesc2    := PADC(" ",70)
cDesc3    := "  "
aRETURN   := {"Especial", 1,"Administracao", 1, 2, 1," ",1 }
nGeraNfe  := mv_par04 
dDtVencto := mv_par03                                        

If nGeraNfe==1 .and. cNomeModulo=="SIGAFAT.REW" //_nomeexec == "SIGAFAT.EXE" .and.20130215 
	nGeraNfe  := 2
	MsgInfo("As Notas Fiscais de Entrada devem ser geradas pelo M�dulo de Compras, o par�metro ser� desconsiderado!")
ElseIf cNomeModulo=="SIGACOM.REW" //_nomeexec == "SIGACOM.EXE" 20130215
	nGeraNfe  := mv_par04 
EndIf


cCabec1   := "PRODUTO: 02.00.000"+SPACE(30)+"****** PERIODO: "+Transform(DTOC(MV_PAR01),"@R 99/99/99")+" A "+Transform(DTOC(MV_PAR02),"@R 99/99/99")+" *****"
cCabec2   := "AUTOR  NOME DO AUTOR                             VL.BRUTO     VL.RF   VL.ISS  VL.LIQUIDO   BANCO  AGENCIA   C/CORRENTE            FORNECEDOR CPF/CNPJ"
            //1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
            //         1         2         3         4         5         6         7         8         9         10        11        12        13        14        15        16

MHORA      := TIME()
WNREL     := "PFAT173_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING   := "SA3"
WNREL     := SETPRINT(CSTRING,WNREL,CPERG,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
SETDEFAULT(aRETURN,CSTRING)

Processa({|| RptDetail()})
Return



/*
//���������Ŀ
//�RELATORIO�
//�����������
*/
Static Function RptDetail()
DbSelectArea("ZZV")
if RDDName() <> "TOPCONN"
		MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
		Return nil
endif

//cQuery := "SELECT zzv_autor, zzv_moeda, sum(zzv_valnf - zzv_descon) as val_bruto, sum(zzv_valaut) as soma_pgautor, sum(zzv_qtd) as qtd_livro from ZZV010 WHERE ZZV_FILIAL='" +xFilial("ZZV")+ "' AND ZZV_DTPGAU>='" +DTOS(MV_PAR01)+ "' AND ZZV_DTPGAU<='" +DTOS(MV_PAR02)+ "' AND ZZV_STATUS='3' AND D_E_L_E_T_<>'*' GROUP BY zzv_autor, zzv_moeda"
cQuery := "SELECT A3.A3_PESSOA, ZZV.ZZV_TPAUT, ZZV.zzv_autor, ZZV.zzv_moeda, sum(ZZV.zzv_valnf - ZZV.zzv_descon) as val_bruto, sum(ZZV.zzv_valaut) as soma_pgautor, sum(ZZV.zzv_qtd) as qtd_livro "
cQuery := cQuery + " FROM ZZV010 ZZV, SA3010 A3 "
cQuery := cQuery + " WHERE ZZV.ZZV_FILIAL='  ' AND A3.A3_FILIAL='" +xFilial("ZZV")+ "' AND ZZV.ZZV_AUTOR = A3.A3_COD AND ZZV.ZZV_DTPGAU>='" +DTOS(MV_PAR01)+ "' AND ZZV.ZZV_DTPGAU<='" +DTOS(MV_PAR02)+ "' AND ZZV.ZZV_STATUS='3' AND A3_TIPOVEN<>'CO' AND ZZV.D_E_L_E_T_<>'*' AND A3.D_E_L_E_T_<>'*' "
cQuery := cQuery + " GROUP BY A3.A3_PESSOA, ZZV.ZZV_TPAUT, ZZV.zzv_autor, ZZV.zzv_moeda ORDER BY A3.A3_PESSOA, ZZV.ZZV_TPAUT, ZZV.zzv_autor, ZZV.zzv_moeda"

TCQUERY cQuery NEW ALIAS "QUERYZZV"
DbSelectArea("QUERYZZV")
DBGOTOP()
AUTORANT     := ""
SOMAVALORAUT := 0
SOMAVLVRUTO  := 0
SOMAQTD 	 := 0
SOMALIQ 	 := 0
SOMAIRF		 := 0
SOMAISS		 := 0
MVLLIQ 		 := 0
MVLBR 		 := 0
MVLIRF 		 := 0
MVLISS		 := 0
CTIPOAUT	 := SPACE(1)
MOEDAANT 	 := SPACE(1)
PROCREGUA(RECCOUNT())
L := 0
WHILE !EOF()
	INCPROC("Lendo Autor: "+Alltrim(QUERYZZV->ZZV_AUTOR))

	IF CTIPOAUT <> QUERYZZV->ZZV_TPAUT  .AND. CTIPOAUT <>' '
		totalizar()
	ENDIF

	IMPRIMIR() //IMPRIME DADOS DO AUTOR E LIVROS
	
	CTIPOAUT 	 := QUERYZZV->ZZV_TPAUT	

	DBSELECTAREA("QUERYZZV")
	DBSKIP()
END     
totalizar()          //imprime o ultimo

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
RETURN


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PFAT172   �Autor  �Microsiga           � Data �  11/09/06   ���
�������������������������������������������������������������������������͹��
���Desc.     � IMPRIMIR                                                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static FUNCTION IMPRIMIR()
MVLLIQ 		 := 0
MVLBR 		 := 0
MVLIRF 		 := 0
MVLISS		 := 0
DBSELECTAREA("SA3")
DBSETORDER(1)
IF DBSEEK(XFILIAL("SA3")+QUERYZZV->ZZV_AUTOR)
	MNOME  := SA3->A3_NOME
	MDOC   := SA3->A3_TIPODOC
	cCGC   := ALLTRIM(SA3->A3_CGC) //daqui 20100405
	cCGC   := Alltrim(StrTran(cCGC,".","")) 
	cCGC   := Alltrim(StrTran(cCGC,",",""))
	cCGC   := Alltrim(StrTran(cCGC,"-",""))
	cCGC   := Alltrim(StrTran(cCGC,"/",""))// ate aqui 20100405
	
	MFLAG  := 'P'
	if MOEDAANT == "D"
		MMOEDA := "R$"
	else
		MMOEDA := "R$"
	endif

	MVLBR := QUERYZZV->SOMA_PGAUTOR 
	MVLBR :=  round(MVLBR,2)  //20080827
	MVLIRF := 0
	IRFISS() //CALCULA O MVLIRF e o MVLISS
	MVLLIQ := (MVLBR - MVLIRF - MVLISS)
	MVLLIQ :=  round(MVLLIQ,2)  //20080827

	IF L==0 .OR. L>63
		Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho)
		L:=9
	ENDIF
		@ L,00  PSAY SA3->A3_COD
		@ L,07  PSAY Alltrim(MNOME)
		@ L,47  PSAY round(MVLBR,2)  PICTURE "@E 999,999.99"   //20080827 ERA: noround(MVLBR,2)
		@ L,57  PSAY round(MVLIRF,2) PICTURE "@E 999,999.99"   //20080827 ERA: noround(MVLIRF,2)
		@ L,67  PSAY round(MVLISS,2) PICTURE "@E 999,999.99"   //20080827 ERA: noround(MVLISS,2)
		@ L,78  PSAY round(MVLLIQ,2) PICTURE "@E 999,999.99"   //20080827 ERA: noround(MVLLIQ,2)
		@ L,91  PSAY SA3->A3_BCO1
		@ L,98  PSAY SA3->A3_AGENCIA
		@ L,108 PSAY SA3->A3_CONTAC
		@ L,130 PSAY SA3->A3_FORNECE                                       
		IF LEN(ALLTRIM(cCGC)) <=11 //daqui 20100405
			@ L,141 PSAY cCGC PICTURE "@R 999.999.999-99"
		ELSE                                                    
			@ L,141 PSAY cCGC PICTURE "@R 99.999.999/9999-99"
		ENDIF //ate aqui 20100405
		L:=L+2
		
		SOMAVLVRUTO  := SOMAVLVRUTO + MVLBR
		SOMALIQ 	 := SOMALIQ + MVLLIQ
		SOMAIRF		 := SOMAIRF + MVLIRF
		SOMAISS		 := SOMAISS + MVLISS
		SOMAVLVRUTO :=  round(SOMAVLVRUTO,2)  //20080827
		SOMALIQ :=  round(SOMALIQ,2)  //20080827
		SOMAIRF :=  round(SOMAIRF,2)  //20080827
		SOMAISS :=  round(SOMAISS,2)  //20080827
	
		If nGeraNfe==1 //.and. SA3->A3_PESSOA=="F"
			GravaNFE(SA3->A3_COD, MVLBR, dDtVencto, SA3->A3_PESSOA)
		EndIf	
ENDIF
RETURN



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �IRFISS () �Autor  �DANILO C S PALA     � Data �  20061109   ���
�������������������������������������������������������������������������͹��
���Desc.     �Processa IRF e ISS do Autor                                 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP5                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
				//MVLISS := (MVLBR * 5/100) // 20120723
				MVLISS := 0 // 20120723
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
		MVLISS :=  round(MVLISS,2)  //20080827
		MVLIRF :=  round(MVLIRF,2)  //20080827
	ENDIF
	
	
	//20100416 WLASTEMILER SENCO: ISENTO DE IR
	/*IF SA3->A3_COD=="001145" //20100909
		MVLIRF :=0	
	ENDIF*/
RETURN



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PFAT173   �Autor  �Microsiga           � Data �  02/08/07   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function totalizar()
	@ L,00 PSAY "TOTAL PARCIAL ..............: "
	@ L,47 PSAY round(SOMAVLVRUTO,2) PICTURE "@E 999,999.99" //20080827: ERA noround(SOMAVLVRUTO,2)
	@ L,57 PSAY round(SOMAIRF,2)   PICTURE "@E 999,999.99" //20080827: ERA noround(SOMAIRF,2)
	@ L,67 PSAY round(SOMAISS,2)   PICTURE "@E 999,999.99" //20080827: ERA noround(SOMAISS,2)
	@ L,78 PSAY round(SOMALIQ,2)   PICTURE "@E 999,999.99" //20080827: ERA noround(SOMALIQ,2)
	SOMAVLVRUTO  := 0
	SOMALIQ 	 := 0
	SOMAIRF		 := 0
	SOMAISS		 := 0
	L := 0                 
return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PFAT173   �Autor  �Microsiga           � Data �  02/08/07   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GravaNFE(cVendedor, nValor, dVencto, cPessoa)
Local aCabec := {}
Local aItens := {}
Local aLinha := {}
Local lOk := .T.
Local _cSerieNFS := "   "
Local cE2_Naturez := "1600"
PRIVATE lMsErroAuto := .F.
Private lMsHelpAuto := .T.
Private nNumero := 0
Private cCodProd := "9990011"
Private cTES := "017"
Private cCondPag := "101"
Private cUpdate := ""
Private nUpd := 0

If cPessoa == "F"
	cCodProd := "9990011"
	cTES := "017"
Else
	cCodProd := "9990013"
	cTES := "497"
EndIf
	
dbselectarea("SA3")
dbsetorder(1)
If !dbseek(xfilial("SA3")+cVendedor)
	MsgAlert("VENDEDOR NAO LOCALIZADO: "+ cVendedor)
	return
EndIf

dbselectarea("SA2")
dbsetorder(1)
If !dbseek(xfilial("SA2")+SA3->A3_FORNECE+SA3->A3_LOJA)
	MsgAlert(SA3->A3_COD +":"+ SA3->A3_NOME+ " N�O ESTA COM O FORNECEDOR CADASTRADO")
	return
EndIf

nNumero := ValidarNF(SA3->A3_NFEDIR, SA3->A3_FORNECE, SA3->A3_LOJA) //20130128
dbselectarea("SA3")
reclock("SA3",.f.)
	SA3->A3_NFEDIR := nNumero +1
msunlock()
               

dbSelectArea("SF1")
dbSetOrder(1)

aCabec := {}
aItens := {}
aadd(aCabec,{"F1_TIPO"   ,"N"})
aadd(aCabec,{"F1_FORMUL" ,"N"})
aadd(aCabec,{"F1_DOC"    ,strzero(nNumero,6)})//??
aadd(aCabec,{"F1_SERIE"  ,_cSerieNFS}) //?
aadd(aCabec,{"F1_EMISSAO",dDataBase})
aadd(aCabec,{"F1_FORNECE",SA3->A3_FORNECE})
aadd(aCabec,{"F1_LOJA"   ,SA3->A3_LOJA})
aadd(aCabec,{"F1_ESPECIE","NF"})
aadd(aCabec,{"F1_COND"   ,cCondPag}) 
aadd(aCabec,{"F1_VALMERC",nValor})
aadd(aCabec,{"F1_VALBRUT",nValor})
aadd(aCabec,{"F1_PREFIXO","COM"})
aadd(aCabec,{"E2_NATUREZ",cE2_Naturez})

//For nX := 1 To len(aCols)
aLinha := {}
aadd(aLinha,{"D1_ITEM" ,"0001",Nil})
aadd(aLinha,{"D1_COD" ,cCodProd,Nil})
aadd(aLinha,{"D1_QUANT",1,Nil})
aadd(aLinha,{"D1_VUNIT",nValor,Nil})
aadd(aLinha,{"D1_TOTAL",nValor,Nil})            
dbselectarea("SB1")
dbsetorder(1)
If dbseek(xfilial("SB1")+cCodProd)
	cTES := SB1->B1_TE
Else 
	If cPessoa == "F"
		cTES := "017"
	Else
		cTES := "497"
	EndIf
EndIf
aadd(aLinha,{"D1_TES",cTES,Nil})
posicione("SF4",1,xfilial("SF4")+cTES,"F4_CODIGO")  
aadd(aLinha,{"D1_NATUREZ",cE2_Naturez,NIL})
aadd(aLinha,{"D1_CLASFIS",Subs(SB1->B1_ORIGEM,1,1)+SF4->F4_SITTRIB,NIL})
aadd(aLinha,{"D1_LOCAL",SB1->B1_LOCPAD,Nil})
aadd(aLinha,{"AUTDELETA" ,"N",Nil}) // Incluir sempre no �ltimo elemento do array de cada item
aadd(aItens,aLinha)                       
//Next nX
MATA103(aCabec,aItens,3)
If !lMsErroAuto
	while __lsx8
    	confirmsx8()
	enddo
    //MsgInfo("Nota Fiscal n� "+cdoc+" gerada!!")
    //daqui 20120216   
    cUpdate := "UPDATE "+ RETSQLNAME("SF1") +" SET F1_PREFIXO='COM' WHERE F1_FILIAL='"+xfilial("SF1")+"' AND F1_DOC='"+ strzero(nNumero,6) +"   ' AND F1_PREFIXO='FAT' AND F1_FORNECE='"+ SA3->A3_FORNECE +"' AND F1_LOJA='"+ SA3->A3_LOJA +"' AND F1_EMISSAO='"+ DTOS(dDataBase) +"' AND F1_ESPECIE='NF' AND D_E_L_E_T_<>'*'"
	nUpd :=	TCSQLExec(cUpdate)
	
    cUpdate := "UPDATE "+ RETSQLNAME("SE2") +" SET E2_PREFIXO='COM', E2_VENCTO='"+ dtos(dVencto) +"', E2_VENCREA='"+ dtos(dVencto) +"' WHERE E2_FILIAL='"+xfilial("SE2")+"' AND E2_NUM='"+ strzero(nNumero,6) +"   ' AND E2_PREFIXO='FAT' AND E2_FORNECE='"+ SA3->A3_FORNECE +"' AND E2_LOJA='"+ SA3->A3_LOJA +"' AND E2_PARCELA=' ' AND E2_TIPO='NF ' AND D_E_L_E_T_<>'*'"
	nUpd :=	TCSQLExec(cUpdate)
		
	cUpdate := "UPDATE "+ RETSQLNAME("SE2") +" SET E2_TITPAI='COM"+ strzero(nNumero,6) +"    NF "+ SA3->A3_FORNECE + SA3->A3_LOJA +"'  WHERE E2_FILIAL='"+xfilial("SE2")+"' AND E2_TITPAI='FAT"+ strzero(nNumero,6) +"    NF "+ SA3->A3_FORNECE + SA3->A3_LOJA +"' AND D_E_L_E_T_<>'*'"
	nUpd :=	TCSQLExec(cUpdate)
    //ate aqui 20120216
    

	cUpdate := "UPDATE "+ RETSQLNAME("SE2") +" SET E2_FORNISS='000701', E2_LOJAISS='01', E2_CODRET='0588', E2_VENCTO='"+ dtos(dVencto) +"', E2_VENCREA='"+ dtos(dVencto) +"' WHERE E2_FILIAL='"+xfilial("SE2")+"' AND E2_NUM='"+ strzero(nNumero,6) +"   ' AND E2_PREFIXO='COM' AND E2_FORNECE='"+ SA3->A3_FORNECE +"' AND E2_LOJA='"+ SA3->A3_LOJA +"' AND E2_PARCELA=' ' AND E2_TIPO='NF ' AND D_E_L_E_T_<>'*'"
	nUpd :=	TCSQLExec(cUpdate)
	/*If nUpd <=0 
		lRetorno := .T.
	Else
		lRetorno := .F.
	EndIf*/                   
    //UPDATE NO SE2: select * from se2010 where E2_filial='01' and E2_TITPAI='COM001682    NF 00307101                          '
	//IR: geradirf=SIM e codigo de Retencao de IR
	cUpdate := "UPDATE "+ RETSQLNAME("SE2") +" SET E2_CODRET='0588', E2_DIRF='1' WHERE E2_FILIAL='"+xfilial("SE2")+"' AND E2_TITPAI='COM"+ strzero(nNumero,6) +"    NF "+ SA3->A3_FORNECE + SA3->A3_LOJA +"' AND E2_TIPO='TX ' AND E2_NATUREZ='IRF       ' AND D_E_L_E_T_<>'*'"
	nUpd :=	TCSQLExec(cUpdate)
	//ISS: fornecedor ISS
	cUpdate := "UPDATE "+ RETSQLNAME("SE2") +" SET E2_LOJA='01', E2_NOMFOR='PREFEITURA          ' WHERE E2_FILIAL='"+xfilial("SE2")+"' AND E2_TITPAI='COM"+ strzero(nNumero,6) +"    NF "+ SA3->A3_FORNECE + SA3->A3_LOJA +"' AND E2_TIPO='ISS' AND E2_NATUREZ='ISS       ' AND D_E_L_E_T_<>'*'"
	nUpd :=	TCSQLExec(cUpdate)
	
Else
	Mostraerro()
    MsgInfo("Erro na inclusao da Nota Fiscal, verifique!!!")          
EndIf


Return


Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
//� mv_par01             //Periodo Inicial   �
//� mv_par02             //Periodo Final     �
//� mv_par03             //Data Pagamento    �
//� mv_par04             //Gera NF           �

aAdd(aRegs,{cPerg,"01","Periodo Inicial","Periodo Inicial","Periodo Inicial","mv_ch1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Periodo Final  ","Periodo Final  ","Periodo Final  ","mv_ch2","D",08,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Data Pagamento ","Data Pagamento ","Data Pagamento ","mv_ch3","D",08,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Gera NFE       ","Gera NFE       ","Gera NFE       ","mv_ch4","N",1,0,2,"C","","MV_PAR04","Sim","Sim","Sim","","","Nao","Nao","Nao","","","","","","","","","","","","","","","","","","","","",""})

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



Static Function ValidarNF(nNumero, cFornece, cLoja) //loop ate nao encontrar NF //20130128
Local cQuery := ""
Local lCont := .T.

If empty(nNumero) .or. nNumero <100
	nNumero :=100000
EndIf

while lCont
	cQuery := "SELECT F1_DOC, F1_FORNECE FROM "+ RetSqlName("SF1") +" WHERE F1_FILIAL='"+ XFILIAL("SF1") +"' AND F1_FORNECE='"+ cFornece  +"' AND F1_LOJA='"+ cLoja +"' AND F1_DOC='"+ strzero(nNumero,6) +"' AND D_E_L_E_T_<>'*'"
	TCQUERY cQuery NEW ALIAS "QUERYNF1"
	DbSelectArea("QUERYNF1")
	DBGotop()
	If EOF()
		lCont := .F.
	Else
		lCont := .T.
		nNumero := nNumero +1
	EndIf
	DbSelectArea("QUERYNF1")
	DBCloseArea()
end
Return nNumero

