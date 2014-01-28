#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/  //Alterado por Danilo C S Pala em 20050531: condicao de pagamento
//Danilo C S Pala 20060323: dados de enderecamento do DNE
//Danilo C S Pala 20070302: reformulado para melhorar o desempenho
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: RENPUBV   ³Autor: Rosane Lacava Rodrigues³ Data:   20/12/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio de Renovacoes de Publicidade por Vencimento      ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat046()

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,CTITULO")
SetPrvt("CCABEC1,CCABEC2,CPROGRAMA,CTAMANHO,LIMITE,NCARACTER")
SetPrvt("NLASTKEY,CDESC1,CDESC2,CDESC3,M_PAG,ARETURN")
SetPrvt("_ACAMPOS,_CNOME,CINDEX,CKEY,WNREL,CSTRING")
SetPrvt("_CFILTRO,MIND,MAV,MVEND,MCLI,MAG")
SetPrvt("MQTDE,MITEM,MINIC,MDESC,L,MNOME")
SetPrvt("MNOMC,MENDC,MMUNC,MESTC,MCEPC,MFONC")
SetPrvt("MNOMA,MENDA,MMUNA,MESTA,MCEPA,MFONA")
SetPrvt("C_CONDPAG, C_DESCPAG,mhora") //20050531
cSavAlias  := Select()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //Periodo Inicial   ³
//³ mv_par02             //Periodo Final     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG := 'PFAT24'

IF !PERGUNTE(CPERG)
   RETURN
ENDIF

cTitulo   := SPACE(03)+"***** RELATORIO DE RENOVACOES - POR INTERVALO DE VENCIMENTO *****"
cCabec1   := SPACE(50)+"***** PERIODO : " +DTOC(MV_PAR01)+ " A " +DTOC(MV_PAR02)+ " *****"
cCabec2   := " "
cPrograma := "RENPUBV"
cTamanho  := "M"
LIMITE    := 132
nCaracter := 10
NLASTKEY  := 0
cDesc1    := PADC("Este programa gera o relatorio de renovacoes",70)
cDesc2    := PADC("da publicidade por vencimento",70)
cDesc3    := " "
M_PAG     := 1

aRETURN:={"Especial", 1,"Administracao", 2, 2, 1," ",1 }

/*_aCampos := {{"CODVEND"  ,"C",6 ,0} ,;  //20070301 reformulado daqui
             {"CODCLI"   ,"C",6, 0} ,;
             {"CODAG"    ,"C",6, 0} ,;
             {"NUMAV"    ,"C",6, 0} ,;
             {"ITEM"     ,"C",2, 0} ,;
             {"INICIAL"  ,"N",4, 0} ,;
             {"FINAL"    ,"N",4 ,0} ,;
             {"PRODUTO"  ,"C",7 ,0} ,;
             {"DESCR"    ,"C",30,0} ,;
             {"DTCIRC"   ,"D",8, 0} ,;
             {"VALOR"    ,"N",10,2} ,;
             {"QTDE"     ,"N",4, 0} ,;
			 {"CONDPAG"  ,"C",3, 0} ,;
             {"DESCPAG"  ,"C",15,0}}  

If Select("RENOV") <> 0
	DbSelectArea("RENOV")
	DbCloseArea()
EndIf	

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"RENOV",.F.,.F.)
CINDEX := CRIATRAB(NIL,.F.)
CKEY   := "CODVEND+CODCLI+CODAG+NUMAV+ITEM"
MsAguarde({|| INDREGUA("RENOV",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (RENOV)...")
*/ //20070301 reformulado ate aqui
MHORA := TIME()
WNREL    :="RENPUBV_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
CSTRING  :="SZS"
WNREL    := SETPRINT(CSTRING,WNREL,CPERG,cTitulo,cDesc1,cDesc2,cDesc3,.F.)

SETDEFAULT(aRETURN,CSTRING)

IF NLASTKEY==27 .OR. NLASTKEY==65
   DBCLOSEAREA()
   RETURN
ENDIF

lEnd := .f.

Processa({|lEnd| RptDetail(@lEnd)},"Aguarde","Imprimindo...",.t.)// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        RptStatus({|| Execute(RptDetail)})

Return

Static Function RptDetail()

/*dbselectarea("SZS") //20070301 reformulado daqui
_cFiltro := "ZS_FILIAL == '"+xFilial("SZS")+"'"
_cFiltro := _cFiltro+".and. ZS_SITUAC <> 'CC' .AND. ZS_CODTIT <> SPACE(03)"

CINDEX := CRIATRAB(NIL,.F.)
CKEY   := "ZS_FILIAL+ZS_NUMAV+ZS_ITEM+STR(ZS_NUMINS,3)"
MsAguarde({|| INDREGUA("SZS",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (SZS)...")
//RETINDEX("SZS")
//MIND:=RETINDEX("SZS")
//DBSETINDEX(CINDEX)
//MIND:=MIND+1

dbselectarea("SC5")
_cFiltro := "C5_FILIAL == '"+xFilial("SC5")+"'"
_cFiltro := _cFiltro+" .and. C5_DIVVEN =='PUBL'"
CINDEX   := CRIATRAB(NIL,.F.)
CKEY     := "C5_FILIAL+C5_NUM"
MsAguarde({|| INDREGUA("SC5",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (SC5)...")

DBGOTOP()
PROCREGUA(RECCOUNT())
WHILE !EOF() .AND. SC5->C5_DIVVEN == 'PUBL'
   INCPROC("Pedido: "+SC5->C5_NUM)

   MAV   := SC5->C5_NUM
   MVEND := SC5->C5_VEND1
   MCLI  := SC5->C5_CLIENTE
   MAG   := SC5->C5_CODAG

   DBSELECTAREA("SE4") //20050531
   IF DBSEEK(XFILIAL("SE4")+SC5->C5_CONDPAG)
   		C_CONDPAG := SE4->E4_CODIGO
   		C_DESCPAG := SE4->E4_DESCRI
   ELSE
   		C_CONDPAG := SE4->E4_CODIGO
   		C_DESCPAG := SE4->E4_DESCRI
   ENDIF //ATE AKI 20050531
   
   
   DBSELECTAREA("SC6")
   DBSETORDER(1)
   IF DBSEEK(XFILIAL("SC6")+MAV)
   	  WHILE SC6->C6_NUM == MAV
         MQTDE := SC6->C6_QTDVEN
         MITEM := SC6->C6_ITEM
         MINIC := SC6->C6_EDINIC
         MDESC := SC6->C6_DESCRI
         DBSELECTAREA("SZS")
         //DBSETORDER (MIND)
         DBSEEK(XFILIAL("SZS")+MAV+MITEM+STR(MQTDE,3))
         IF FOUND() .AND. SZS->ZS_DTCIRC>=MV_PAR01 .AND. SZS->ZS_DTCIRC<=MV_PAR02
            DBSELECTAREA("RENOV")
            RECLOCK("RENOV",.T.)
            RENOV->CODVEND := MVEND
            RENOV->CODCLI  := MCLI
            RENOV->CODAG   := MAG
            RENOV->QTDE    := MQTDE
            RENOV->NUMAV   := MAV
            RENOV->ITEM    := MITEM
            RENOV->INICIAL := MINIC
            RENOV->FINAL   := SZS->ZS_EDICAO
            RENOV->DTCIRC  := SZS->ZS_DTCIRC
            RENOV->PRODUTO := SZS->ZS_VEIC
            RENOV->DESCR   := MDESC
            RENOV->VALOR   := SZS->ZS_VALOR   
            RENOV->CONDPAG := C_CONDPAG  //20050531
            RENOV->DESCPAG := C_DESCPAG //20050531 
            MSUNLOCK()
         ENDIF
         DBSELECTAREA("SC6")
         DBSKIP()
         //INCPROC()
      END
   ENDIF
   DBSELECTAREA("SC5")
   DBSKIP()
END */ //20070301 reformulado ate aqui

//20070301 reformulado geracao por query

                   
cQuery := "select c5_vend1 as CODVEND, c5_cliente as CODCLI, c5_codag as CODAG, c5_num as NUMAV, c6_item as ITEM, c6_edinic as INICIAL, zs_edicao as FINAL, ZS_VEIC as PRODUTO, c6_descri as DESCR, zs_dtcirc as DTCIRC, zs_valor as VALOR, c6_qtdven as QTDE, e4_codigo as CONDPAG, e4_descri as DESCPAG, C5_MENNOTA AS MENNOTA"
cQuery := cQuery + " from "+ RetSqlName("SZS") +" ZS, "+ RetSqlName("SC5") +" C5, "+ RetSqlName("SC6") +" C6, "+ RetSqlName("SE4") +" E4"
cQuery := cQuery + " where c5_filial='"+xfilial("SC5")+"' and c6_filial='"+xfilial("SC6")+"' and c5_num = c6_num and c5_divven='PUBL' "
cQuery := cQuery + " and zs_filial='"+xfilial("SZS")+"' and zs_numav = c6_num and zs_item = c6_item and zs_numins = c6_qtdven"
cQuery := cQuery + " and zs_situac<>'CC' and zs_codtit<>'   '  and ZS_DTCIRC>='"+ dtos(MV_PAR01) +"' and ZS_DTCIRC<='"+ dtos(MV_PAR02) +"'"
cQuery := cQuery + " and e4_filial='"+xfilial("SE4")+"' and e4_codigo = C5_CONDPAG"
cQuery := cQuery + " and zs.d_e_l_e_t_<>'*' and c5.d_e_l_e_t_<>'*' and c6.d_e_l_e_t_<>'*' and e4.d_e_l_e_t_<>'*'"
cQuery := cQuery + " order by CODVEND,CODCLI,CODAG,NUMAV,ITEM"
//TCQUERY cQuery NEW ALIAS "RENOV" //20070301 query
MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "RENOV", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")

TcSetField("RENOV","DTCIRC"   ,"D")
L := 0
DBSELECTAREA("RENOV")
//DBSETORDER(1)
DBGOTOP()
WHILE !EOF()
   //Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho,if(aReturn[4]==1,15,10))

   L := Cabec(cTitulo,cCabec1,cCabec2,cPrograma,cTamanho,if(aReturn[4]==1,15,10))
   L += 6 

   MVEND := CODVEND
   MCLI  := CODCLI
   MAG   := CODAG
   MNOME := ' '

   DBSELECTAREA("SA3")
   DBSETORDER(1)
   IF DBSEEK(XFILIAL("SA3")+MVEND)
      MNOME := SA3->A3_NOME
   ENDIF

   L := L+2
   @ L,01 PSAY "CONTATO : " + MVEND + ' ' + MNOME
   L := L+2
   VER()
   
   IF !EMPTY(RENOV->MENNOTA) //20130829 DAQUI
   		@ L,01  PSAY "MEN NOTA: " + SUBSTR(RENOV->MENNOTA,1,120)
   		IF !EMPTY(SUBSTR(RENOV->MENNOTA,121,120))
   			L := L+1 
   			@ L,01  PSAY SUBSTR(RENOV->MENNOTA,121,120)
   		ENDIF
   	ENDIF //20130829 ATE AQUI
   
   L := L+2
   @ L,01  PSAY "NUMAV / ITEM"
   @ L,15  PSAY "REVISTA"
   @ L,24  PSAY "EDIN"
   @ L,30  PSAY "EDFIN"
   @ L,37  PSAY "DTVENCTO"
   @ L,47  PSAY "INS."
   @ L,53  PSAY "VALOR INS."
   @ L,65  PSAY "FORMATO/CORES"
   @ L,97  PSAY "OBSERVACAO"       
   L := L+1
   @ L,65  PSAY "CONDPAG"
   
   L := L+1
   @ L,01  PSAY "============"
   @ L,15  PSAY "======="
   @ L,24  PSAY "===="
   @ L,30  PSAY "====="
   @ L,37  PSAY "========"
   @ L,47  PSAY "===="
   @ L,53  PSAY "=========="
   @ L,65  PSAY "=============================="
   @ L,97  PSAY "=============================="

   DBSELECTAREA("RENOV")
   WHILE (CODVEND+CODCLI+CODAG) == MVEND+MCLI+MAG
      L := L+2
      @ L,01  PSAY NUMAV+'/'+ITEM
      @ L,15  PSAY PRODUTO
      @ L,24  PSAY INICIAL
      @ L,30  PSAY FINAL
      @ L,37  PSAY DTCIRC
      @ L,47  PSAY QTDE
      @ L,53  PSAY VALOR PICTURE "@E 999,999.99"
      @ L, 65  PSAY DESCR //20050531
      @ L+1, 65  PSAY CONDPAG //20050531
      @ L+1, 70  PSAY DESCPAG //20050531

      DBSKIP()
   END
Roda(0,"",ctamanho)
END

DBSELECTAREA("RENOV")
SET DEVICE TO SCREEN

IF aRETURN[5] ==1
   SET PRINTER TO
   DBCOMMITALL()
   OURSPOOL(WNREL)
ENDIF

MS_FLUSH()

DBCLOSEAREA()

DBSELECTAREA("SC6")
RETINDEX("SC6")

DBSELECTAREA("SE4")
RETINDEX("SE4")

DBSELECTAREA("SC5")
RETINDEX("SC5")

DBSELECTAREA("SA3")
RETINDEX("SA3")

DBSELECTAREA("SA1")
RETINDEX("SA1")

DBSELECTAREA("SZS")
RETINDEX("SZS")

RETURN

Static FUNCTION VER()

MNOMC := ' ' 
MENDC := ' ' 
MMUNC := ' ' 
MESTC := ' ' 
MCEPC := ' ' 
MFONC := ' ' 
MNOMA := ' ' 
MENDA := ' ' 
MMUNA := ' ' 
MESTA := ' ' 
MCEPA := ' ' 
MFONA := ' ' 

DBSELECTAREA("SA1")
DBSETORDER(1)
IF DBSEEK(XFILIAL("SA1")+MCLI)
   MNOMC := SA1->A1_NOME 
   MENDC := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060323
   MMUNC := SA1->A1_MUN
   MESTC := SA1->A1_EST
   MCEPC := SA1->A1_CEP
   MFONC := SA1->A1_TEL
ENDIF

DBSELECTAREA("SA1")
DBSETORDER(1)
IF DBSEEK(XFILIAL("SA1")+MAG)
   MNOMA := SA1->A1_NOME 
   MENDA := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060323
   MMUNA := SA1->A1_MUN
   MESTA := SA1->A1_EST
   MCEPA := SA1->A1_CEP
   MFONA := SA1->A1_TEL
ENDIF

L := L+1
@ L,01 PSAY "CODCLI : " + MCLI
IF MAG <> SPACE(06)
   @ L,81 PSAY "CODAG  : " + MAG
ENDIF
L := L+1
@ L,01 PSAY "NOME ..: " + MNOMC
IF MAG <> SPACE(06)
   @ L,81 PSAY "NOME ..: " + MNOMA
ENDIF
L := L+1
@ L,01 PSAY "END ...: " + substr(MENDC,1,70)
IF MAG <> SPACE(06)
   @ L,81 PSAY "END ...: " + substr(MENDA,1,70)
ENDIF
L := L+1
@ L,01 PSAY "MUN ...: " + MMUNC
IF MAG <> SPACE(06)
   @ L,81 PSAY "MUN ...: " + MMUNA
ENDIF
L := L+1
@ L,01 PSAY "UF ....: " + MESTC
IF MAG <> SPACE(06)
   @ L,81 PSAY "UF ....: " + MESTA
ENDIF
L := L+1
@ L,01 PSAY "CEP ...: " + SUBST(MCEPC,1,5)+'-'+SUBST(MCEPC,6,3)
IF MAG <> SPACE(06)
   @ L,81 PSAY "CEP ...: " + SUBST(MCEPA,1,5)+'-'+SUBST(MCEPA,6,3)
ENDIF
L := L+1
@ L,01 PSAY "FONE ..: " + MFONC
IF MAG <> SPACE(06)
   @ L,81 PSAY "FONE ..: " + MFONA
ENDIF
L := L+1

RETURN