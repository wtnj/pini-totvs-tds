#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: REPCOM    ³Autor: Rosane Lacava Rodrigues³ Data:   14/09/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Arquivo com o valor das comissoes/produto - Representacoes ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Rfat047()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,NLASTKEY")
SetPrvt("_ACAMPOS,_CNOME,CINDEX,CKEY,MD,XD")
SetPrvt("MIND,_CFILTRO,CONT,MPEDIDO,MNOTA,MPERC")
SetPrvt("MCOMIS,MVEND,MCOMISS,MVAL,CONTINUA,MTES")
SetPrvt("MPORC,MPROD,MITEM,MCDEMP,MTIT,MPREFIXO")

cSavAlias  := Select()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ mv_par01             //Da data:          ³
//³ mv_par02             //Ate a data:       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CPERG:='FAT047'
IF !PERGUNTE(CPERG)
   RETURN
ENDIF

NLASTKEY :=0

McdEmp := Val(SM0->M0_CODIGO)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//DrawAdvWin("***** COMISSOES/PRODUTO - REPRESENTACOES *****", 8, 0, 14, 75)
//@ 10,04 say "Este programa gera o arquivo DBF por grupo de produto, com o total"
//@ 11,05 say "das comissoes pagas para as representacoes no periodo solicitado"

_aCampos := {{"PEDIDO"  ,"C",6, 0} ,;
             {"PREF"    ,"C",3, 0} ,;
             {"NOTA"    ,"C",6, 0} ,;
             {"PERC"    ,"N",8, 2} ,;
             {"VALORCOM","N",14,2}}

If Select("COMISS") <> 0
	DbSelectArea("COMISS")
	DbCloseArea()
EndIf 	

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"COMISS",.F.,.F.)
CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="NOTA+PEDIDO"
MsAguarde({|| INDREGUA("COMISS",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (COMISS)...")

//Set Index To
//DbSetIndex(CINDEX)

_aCampos := {{"TITULO"  ,"C",24,0} ,;
             {"PREF"    ,"C",3, 0} ,;
             {"NOTA","C",6,0},;
             {"V_DATA","D",8,0},;
             {"PEDIDO","C",6,0},;
             {"VALOR"   ,"N",14,2}}

If Select("CUSPROD") <> 0
	DbSelectArea("CUSPROD")
	DbCloseArea()
EndIf 	

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"CUSPROD",.F.,.F.)

_aCampos := {{"TITULO"  ,"C",24,0} ,;
             {"VALOR"   ,"N",14,2}}

If Select("REPCOM") <> 0
	DbSelectArea("REPCOM")
	DbCloseArea()
EndIf 	

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"REPCOM",.F.,.F.)
CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="TITULO"
MsAguarde({|| INDREGUA("REPCOM",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (REPCOM)...")
//Set Index To
//DbSetIndex(CINDEX)

_aCampos := {{"PEDIDO"  ,"C",6, 0} ,;
             {"PREF"    ,"C",3, 0} ,;
             {"NOTA"    ,"C",6, 0} ,;
             {"PERC"    ,"N",8, 2} ,;
             {"PORC"    ,"N",8, 2} ,;
             {"VALORPED","N",14,2} ,;
             {"VALORCOM","N",14,2} ,;
             {"VALORP"  ,"N",14,2}}

If Select("REPPED") <> 0
	DbSelectArea("REPPED")
	DbCloseArea()
EndIf	

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"REPPED",.F.,.F.)
CINDEX:=CRIATRAB(NIL,.F.)
CKEY:="NOTA+PEDIDO"
MsAguarde({|| INDREGUA("REPPED",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (REPPED)...")
//Set Index To
//DbSetIndex(CINDEX)

IF NLASTKEY==27 .OR. NLASTKEY==65
   DBCLOSEAREA()
   RETURN
ENDIF

lEnd := .f.

Processa({|lEnd| RptDetail(@lEnd)},"Aguarde","Gerando Arquivos...",.t.)// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>        RptStatus({|| Execute(RptDetail)})

Return

Static Function RptDetail()

MD := MV_PAR01
XD := DTOS(MD)

//DBSELECTAREA("SD2")
//CINDEX:=CRIATRAB(NIL,.F.)
//CKEY:="D2_FILIAL+D2_DOC+D2_PEDIDO"
//MsAguarde({|| INDREGUA("SD2",CINDEX,CKEY,,,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario (SD2)...")
//RETINDEX("SD2")
//MIND:=RETINDEX("SD2")
//DBSETINDEX(CINDEX)
//MIND:=MIND+1

DBSELECTAREA("SE3")
DbSetOrder(4)
//_cFiltro := "E3_FILIAL == '"+xFilial("SE3")+"'"
//_cFiltro := _cFiltro + " .and. DTOS(E3_DATA) >= '"+DTOS(MV_PAR01)+"'" //_cFiltro+".and.DTOS(E3_DATA)>=DTOS(CTOD('"+DTOC(MV_PAR01)+"'))"
//_cFiltro := _cFiltro + " .and. E3_REGIAO >= '"+mv_par03+"' .and. E3_REGIAO <= '"+mv_par04+"'"  //" .and. E3_REGIAO <> '1  '"
//CINDEX := CRIATRAB(NIL,.F.)
//CKEY   := "E3_FILIAL+DTOS(E3_DATA)+E3_PEDIDO"
//MsAguarde({|| INDREGUA("SE3",CINDEX,CKEY,,_cFiltro,"SELECIONANDO REGISTROS DO ARQ")},"Aguarde","Gerando Indice Temporario(SE3)...")

DBSEEK(XFILIAL("SE3")+XD,.T.)   // Soft Seek on (.T.)

PROCREGUA(RECCOUNT())

WHILE !EOF() .AND. SE3->E3_FILIAL == xFilial("SE3") .and. DTOS(SE3->E3_DATA) <= DTOS(MV_PAR02)
   INCPROC("Nota: "+SE3->E3_PREFIXO+SE3->E3_NUM)
   
   IF Val(SE3->E3_REGIAO) < Val(MV_PAR03) .OR. Val(SE3->E3_REGIAO) > Val(MV_PAR04) //VAL(SE3->E3_REGIAO) < 20
      DBSKIP()
      LOOP
   ENDIF

   IF SE3->E3_SITUAC <> ' '
      CONT := -1
   ELSE
      CONT := 1
   ENDIF

   MPREFIXO:= SE3->E3_PREFIXO
   MPEDIDO := SE3->E3_PEDIDO
   MNOTA   := SE3->E3_NUM
   MPERC   := SE3->E3_PORC
   MCOMIS  := (SE3->E3_COMIS * CONT)
   MVEND   := SE3->E3_VEND

   DBSELECTAREA("SA3")
   DbSetOrder(1)
   DBSEEK(XFILIAL("SA3")+MVEND)
   IF "COMPRA" $(A3_NOME) .OR. SA3->A3_TIPOVEN == 'CT' .OR. SA3->A3_TIPOVEN == 'CP'
       DBSELECTAREA("SE3")
       DBSKIP()
       LOOP
   ENDIF

   DBSELECTAREA("COMISS")
   RECLOCK("COMISS",.T.)
   COMISS->VALORCOM := MCOMIS
   COMISS->PERC     := MPERC
   COMISS->PEDIDO   := MPEDIDO
   COMISS->NOTA     := MNOTA
   COMISS->PREF     := MPREFIXO
   MsUnlock()

   DBSELECTAREA("SE3")
   DBSKIP()
   INCPROC()
END

DBSELECTAREA("COMISS")

DbGotop()

PROCREGUA(RECCOUNT())

WHILE !EOF()

   INCPROC("Nota: "+NOTA)
   MPREFIXO:= PREF 
   MNOTA   := NOTA
   MPEDIDO := PEDIDO
   MPERC   := PERC
   MCOMISS := VALORCOM
   MVAL    := 0

   DBSELECTAREA("SD2")
   DBSETORDER(3) //DBSETORDER(MIND)
   //IF !DBSEEK(xFilial("SD2")+MNOTA+MPEDIDO)
   IF !DBSEEK(xFilial("SD2")+MNOTA+MPREFIXO)
       DBSELECTAREA("COMISS")
       DBSKIP()
       LOOP
   ENDIF

   CONTINUA:=.T.
   WHILE SD2->D2_FILIAL == xFilial("SD2") .AND. MNOTA == SD2->D2_DOC .AND. MPREFIXO == SD2->D2_SERIE .and. CONTINUA//MPEDIDO == SD2->D2_PEDIDO .AND. MNOTA == SD2->D2_DOC .AND. CONTINUA
      INCPROC("Nota: "+SD2->D2_SERIE+SD2->D2_DOC)
      MTES := SD2->D2_TES
      
	 IF MPEDIDO <> SD2->D2_PEDIDO
	 	DBSELECTAREA("SD2")
        DBSKIP()
        LOOP
     ENDIF

      DBSELECTAREA("SF4")
      DBSEEK(XFILIAL("SF4")+MTES)
      IF !"VENDA" $(F4_TEXTO) .AND. !"PREST SERV" $(F4_TEXTO)
          DBSELECTAREA("SD2")
          DBSKIP()
          LOOP
      ENDIF

      MVAL := (MVAL + SD2->D2_TOTAL)
      DBSELECTAREA("SD2")
      DBSKIP()
      INCPROC()
   ENDDO

   DBSELECTAREA("REPPED")
   RECLOCK("REPPED",.T.)
   REPPED->VALORPED := MVAL
   REPPED->PERC     := MPERC
   REPPED->PEDIDO   := MPEDIDO
   REPPED->NOTA     := MNOTA
   REPPED->VALORP   := MCOMISS
   REPPED->VALORCOM := (MVAL * (MPERC/100))
   REPPED->PORC     := ((MCOMISS * 100)/REPPED->VALORCOM)
   REPPED->PREF     := MPREFIXO
   MsUnlock()

   DBSELECTAREA("COMISS")
   DBSKIP()
   INCPROC()
END

DBSELECTAREA("REPPED")
DbGotop()
PROCREGUA(RECCOUNT())
WHILE !EOF()
   INCPROC()
   MNOTA    := NOTA
   MPEDIDO  := PEDIDO
   MPERC    := PERC
   MPORC    := PORC
   MPREFIXO := PREF	  

   DBSELECTAREA("SD2")
   DBSETORDER(3)
   //DBSETORDER(MIND)
   //DBSEEK(MNOTA+MPEDIDO)
   DBSEEK(xFilial("SD2")+MNOTA)
   IF !FOUND()
       DBSELECTAREA("REPPED")
       DBSKIP()
       LOOP
   ENDIF

   CONTINUA:=.T.
   WHILE !Eof() .and. MNOTA == SD2->D2_DOC .AND. MPREFIXO == SD2->D2_SERIE .AND. CONTINUA
      INCPROC("Nota: "+SD2->D2_SERIE+SD2->D2_DOC)

      IF MPEDIDO <> SD2->D2_PEDIDO
      	DBSELECTAREA("SD2")
       	DBSKIP()
       	LOOP
   	  ENDIF
      	
      MPREFIXO := SD2->D2_SERIE
      MPROD  := SD2->D2_COD
      MVAL   := 0
      MCOMISS:= 0
      MITEM  := SD2->D2_ITEM
      MTES   := SD2->D2_TES

      DBSELECTAREA("SF4")
      DbSetorder(1)
      DBSEEK(XFILIAL("SF4")+MTES)
      IF !"VENDA" $(F4_TEXTO) .AND. !"PREST SERV" $(F4_TEXTO)
          DBSELECTAREA("SD2")
          DBSKIP()
          LOOP
      ENDIF

      IF VAL(SUBSTR(MPROD,1,2)) < 10
         MCDEMP := 1
      ELSE
         MCDEMP := 2
      ENDIF

      MTIT  := ' '

      DBSELECTAREA("SB1")
      DBSETORDER(1)
      DBSEEK(XFILIAL("SB1")+MPROD)
      IF FOUND()
         MTIT := SB1->B1_TITULO
      ENDIF

      IF SUBSTR(MPROD,1,2) == '02'
         MTIT := 'LIVROS                  '
      ENDIF
      IF SUBSTR(MPROD,1,4) == '0404'
         MTIT:='FOTOGRAFIAS TECNICAS'
      ENDIF
      IF SUBSTR(MPROD,1,2) == '05'
         MTIT := 'CURSOS                  '
      ENDIF
      IF SUBSTR(MPROD,1,2) == '07'
         MTIT := 'VIDEOS/CDROM            '
      ENDIF
      IF SUBSTR(MPROD,1,2) == '01'
         MTIT := 'ASSINATURAS E EX AVULSOS'
      ENDIF
      IF SUBSTR(MPROD,1,2) == '10'
         MTIT := 'RELATORIOS              '
      ENDIF
      IF SUBSTR(MPROD,1,2) == '11' .OR. SUBSTR(MPROD,1,2) == '20'
         MTIT := 'SOFTWARE VOLARE         '
      ENDIF
      IF SUBSTR(MPROD,1,4) == '1105'
         MTIT := 'ATUALIZACAO DE INSUMOS  '
      ENDIF
      IF SUBSTR(MPROD,1,2) == '12'
         MTIT := 'VOLARE PROPOSTA TECNICA '
      ENDIF
      IF SUBSTR(MPROD,1,2) == '13'
         MTIT := 'VOLARE PEQUENAS OBRAS   '
      ENDIF
      IF SUBSTR(MPROD,1,2) == '14'
         MTIT := 'SOFTWARE STRATO         '
      ENDIF
      IF SUBSTR(MPROD,1,4) == '1501' .OR. SUBS(MPROD,1,4) =='1595'
         MTIT := 'SOFTWARE ARCON          '
      ENDIF
      IF SUBSTR(MPROD,1,4) == '1502' .OR. SUBS(MPROD,1,4) =='1595'
         MTIT := 'SOFTWARE PROCAD         '
      ENDIF
      IF SUBSTR(MPROD,1,4) == '1701' .OR. SUBS(MPROD,1,4) =='1795'
         MTIT := 'ESSERE ASSINATURA       '
      ENDIF
      IF SUBSTR(MPROD,1,4) == '1901'
         MTIT := 'TREINAMENTO VOLARE      '
      ENDIF
      IF SUBSTR(MPROD,1,4) == '1902'
         MTIT := 'TREINAMENTO ARCON       '
      ENDIF
      IF SUBSTR(MPROD,1,4) == '1903'
         MTIT := 'TREINAMENTO PROCAD      '
      ENDIF
      IF SUBSTR(MPROD,1,4) == '1904'
         MTIT := 'TREINAMENTO STRATO      '
      ENDIF

      MCOMISS := (SD2->D2_TOTAL * (MPERC/100))
      MVAL    := (MCOMISS * (MPORC/100))

      DBSELECTAREA("REPCOM")
      DbSetOrder(01)
      DBSEEK(MTIT)
      IF !FOUND()
          RECLOCK("REPCOM",.T.)
          REPCOM->TITULO := MTIT
          REPCOM->VALOR  := MVAL
          MsUnlock()
      ELSE
          RECLOCK("REPCOM",.F.)
          REPCOM->VALOR := (REPCOM->VALOR + MVAL)
          MsUnlock()
      ENDIF

    DBSELECTAREA("CUSPROD")
       RECLOCK("CUSPROD",.T.)
       CUSPROD->PREF   := MPREFIXO
       CUSPROD->TITULO := MTIT
       CUSPROD->VALOR  := MVAL
       CUSPROD->NOTA   := SD2->D2_DOC
       CUSPROD->V_DATA   := SD2->D2_EMISSAO
       CUSPROD->PEDIDO := MPEDIDO
       MSUNLOCK()

      INCPROC()

      DBSELECTAREA("SD2")
      DBSKIP()
      //INCPROC()
   END
   DBSELECTAREA("REPPED")
   DBSKIP()
   INCPROC()
END

DBSELECTAREA("REPCOM")
IF SM0->M0_CODIGO == "01"
   COPY TO &("\SIGA\ARQTEMP\COMEP.DBF") VIA "DBFCDXADS" // 20121106 
ELSEIF SM0->M0_CODIGO == "02"
   COPY TO &("\SIGA\ARQTEMP\COMPS.DBF") VIA "DBFCDXADS" // 20121106 
ELSEIF SM0->M0_CODIGO == "03"
   COPY TO &("\SIGA\ARQTEMP\COMPW.DBF") VIA "DBFCDXADS" // 20121106 
ENDIF 

DBCLOSEAREA()

DBSELECTAREA("REPPED")
IF SM0->M0_CODIGO == "01"
   COPY TO &("\SIGA\ARQTEMP\ROEP.DBF") VIA "DBFCDXADS" // 20121106 
ELSEIF SM0->M0_CODIGO == "02"
   COPY TO &("\SIGA\ARQTEMP\ROPS.DBF") VIA "DBFCDXADS" // 20121106 
ELSEIF SM0->M0_CODIGO == "03"
   COPY TO &("\SIGA\ARQTEMP\ROPW.DBF") VIA "DBFCDXADS" // 20121106 
ENDIF 

DBCLOSEAREA()

DBSELECTAREA("COMISS")
DBCLOSEAREA()

DBSELECTAREA("CUSPROD")
IF Alltrim(SM0->M0_CODIGO) == "01"
   COPY TO &("\SIGA\ARQTEMP\CUSPRODEP.DBF") VIA "DBFCDXADS" // 20121106 
ELSEIF SM0->M0_CODIGO == "02"
   COPY TO &("\SIGA\ARQTEMP\CUSPRODPS.DBF") VIA "DBFCDXADS" // 20121106 
ELSEIF SM0->M0_CODIGO == "03"
   COPY TO &("\SIGA\ARQTEMP\CUSPRODPW.DBF") VIA "DBFCDXADS" // 20121106 
ENDIF 

DBCLOSEAREA()

cMsg := OemToAnsi("Arquivos Gerados em \SIGA\ARQTEMP\.")
MsgAlert(cMsg,"Final de Processamento")

DBSELECTAREA("SE3")
RETINDEX("SE3")

DBSELECTAREA("SD2")
RETINDEX("SD2")

DBSELECTAREA("SF4")
RETINDEX("SF4")

DBSELECTAREA("SB1")
RETINDEX("SB1")

DBSELECTAREA("SA3")
RETINDEX("SA3")

RETURN