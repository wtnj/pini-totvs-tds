 #include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
//Danilo C S Pala 20060320: dados de enderecamento do DNE

User Function Rfat013()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,MVPAR")
SetPrvt("MCODCLI,MTPTRANS,MCONDPAG,MCODAG,MVEND,MDATA")
SetPrvt("MAVESP,MNOMEVEND,MNOME,MEND,MBAIRRO,MCIDADE")
SetPrvt("MESTADO,MCGC,MINSC,MFONE,MCEP,MNOMEAG")
SetPrvt("MENDAG,MBAIRROAG,MCIDADEAG,MESTADOAG,MCEPAG,MFONEAG")
SetPrvt("MOSTRA,MOSTRA_DUPL,MPARCELA,XITEM,MCODPROD,MDESCRI")
SetPrvt("XVALOR2,XDESC,MMOTIVO,TECLA,CSAVTELA1,L")
SetPrvt("XL,_X,PARC,DUP,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa:           ³Autor: Solange Nalini         ³ Data:   06/01/00 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: CONSULTA DE AV                                             ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento/PUBLICIDADE                          ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
cSavTela   := SaveScreen( 0, 0,23,80)
cSavCursor := SetCursor()
cSavCor    := SetColor()
cSavAlias  := Select()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recupera o desenho padrao de atualizacoes³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ScreenDraw("SMT050", 3, 0, 0, 0)
//SetCursor(1)
//SetColor("B/BG")
//
DO WHILE .T.

   CPERG:="PFAT50"

   If .Not. PERGUNTE(cPerg)
       Return
   Endif

   MVPAR:=MV_PAR01
   DBSELECTAREA("SC5")
   DBSETORDER(1)
   DBSEEK(XFILIAL()+MVPAR)
   IF FOUND()
      MCODCLI  :=SC5->C5_CLIENTE
      MTPTRANS :=SC5->C5_TPTRANS
      MCONDPAG :=SC5->C5_CONDPAG
      MCODAG   :=SC5->C5_CODAG
      MVEND    :=SC5->C5_VEND1
      MDATA    :=SC5->C5_EMISSAO
      MAVESP   :=SC5->C5_AVESP
   ELSE
      ALERT("AV NAO CADASTRADA OU CLIENTE INEXISTENTE")
   ENDIF
   DBSELECTAREA("SA3")
   DBSETORDER(1)
   DBSEEK(XFILIAL()+MVEND)
   IF FOUND()
      MNOMEVEND:=SA3->A3_NOME
   ENDIF
   DBSELECTAREA("SA1")
   DBSETORDER(1)
   DBSEEK(XFILIAL()+SC5->C5_CLIENTE)
   MNOME  :=SA1->A1_NOME
   MEND   := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060320 //SA1->A1_END //20060320
   MBAIRRO:=SA1->A1_BAIRRO
   MCIDADE:=SA1->A1_MUN
   MESTADO:=SA1->A1_EST
   MCGC   :=SA1->A1_CGC
   MINSC  :=SA1->A1_INSCR
   MFONE  :=SA1->A1_TEL
   MCEP   :=SA1->A1_CEP
   IF MCODAG#'  '
      DBSEEK(XFILIAL()+MCODAG)
      IF FOUND()
         MNOMEAG    :=SA1->A1_NOME
         MENDAG     := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060320 //SA1->A1_END
         MBAIRROAG  :=SA1->A1_BAIRRO
         MCIDADEAG  :=SA1->A1_MUN
         MESTADOAG  :=SA1->A1_EST
         MCEPAG     :=SA1->A1_CEP
         MFONEAG    :=SA1->A1_TEL
      ENDIF
   ENDIF

   DBSELECTAREA("SZS")
   DBSETORDER(1)
   DBSEEK(XFILIAL()+MVPAR)
   IF .NOT. FOUND()
       ALERT("AV NAO PROGRAMADA")
       LOOP
   ENDIF

   MOSTRA:={}
   MOSTRA_DUPL:={}
   MPARCELA:={}

   DO WHILE SZS->ZS_NUMAV==MVPAR
      XITEM:=SZS->ZS_ITEM
      MCODPROD:=SZS->ZS_CODPROD
      DBSELECTAREA("SB1")
      DBSETORDER(1)
      DBSEEK(XFILIAL()+MCODPROD)
      IF FOUND()
         MDESCRI:= SUBS(SB1->B1_DESC,1,18)
      ELSE
         MDESCRI:=' '
      ENDIF
      DBSELECTAREA("SZS")

      IF MTPTRANS == '04' .OR. MTPTRANS == '18'
         XVALOR2:=SZS->ZS_VALOR-(SZS->ZS_VALOR*.20)
         XDESC :=20
      ELSE
         XVALOR2:=SZS->ZS_VALOR
         XDESC :=0
      ENDIF

      AADD(MOSTRA, SZS->ZS_ITEM+'  ' +STR(SZS->ZS_NUMINS)+'  '+SUBS(ZS_VEIC,1,4)+' '+STR(SZS->ZS_EDICAO,4,0);
           +'    '+DTOC(SZS->ZS_DTCIRC)+' '+SZS->ZS_SITUAC+' '+STR(SZS->ZS_VALOR,8,2)+' '+;
           SZS->ZS_NFISCAL +' '+MDESCRI+' '+SZS->ZS_CODMAT)


      DBSKIP()
   ENDDO
   IF SC5->C5_AVESP=='S'
      DBSELECTAREA("SZV")
      DBSETORDER(1)
      DBSEEK(XFILIAL()+MVPAR)
      IF .NOT. FOUND()
          AADD(MPARCELA,' ')
      ELSE
          DO WHILE SZV->ZV_NUMAV == MVPAR
             AADD(MPARCELA,STR(SZV->ZV_NPARC,2)+'/'+STR(SZV->ZV_TOTPARC,2)+'  '+;
             STR(SZV->ZV_VALOR,8,2)+'   '+SUBS(DTOC(SZV->ZV_ANOMES),4,5)+ '     '+SZV->ZV_NFISCAL;
             +'     '+DTOC(SZV->ZV_DTNF)+'     ' +SZV->ZV_SITUAC)
             DBSKIP()
          ENDDO
      ENDIF
  ENDIF

      DBSELECTAREA('SE1')
      DBGOTOP()
dbSetOrder(21)  ///dbSetOrder(15) AP5
      dbseek(XFILIAL()+MVPAR)
      IF .NOT. FOUND()
          AADD(MOSTRA_DUPL, '  ')
      ELSE
          DO WHILE SE1->E1_PEDIDO == MVPAR
             IF !EMPTY(SE1->E1_BAIXA) .AND. EMPTY(SE1->E1_MOTIVO)
                MMOTIVO:='PAGTO           '
             ELSE
                MMOTIVO:=TRIM(SE1->E1_MOTIVO)+SPACE(LEN(SE1->E1_MOTIVO)-(LEN(TRIM(SE1->E1_MOTIVO))))
             ENDIF
             AADD(MOSTRA_DUPL, SE1->E1_NUM+' '+SE1->E1_PARCELA+' '+STR(SE1->E1_VALOR,8,2)+'   ';
                +DTOC(SE1->E1_EMISSAO)+'  ' +DTOC(SE1->E1_VENCTO)+'  ' +DTOC(SE1->E1_BAIXA)+'  ';
                +MMOTIVO +' ' +SE1->E1_PORTADO)
                 DBSKIP()
          ENDDO
      ENDIF

      DBSELECTAREA("SZS")
      DBSKIP()
      cSavCursor := SetCursor()
      cSavCor    := SetColor()
      cSavAlias  := Select()
      TECLA:=0

      cSavtela1:=Savescreen(3,0,24,79)
      set color to B/BG
      limpa()


      DrawAdvWin("**  CONSULTA DE AV   **" , 3, 0, 24, 78 )
      Set color to W+/B
      @ 24,01 SAY PADC("PGDOW CONTINUA CONSULTA",78)
      SET COLOR TO B/BG
      @ 04,02 SAY "Cod.Cliente: "+MCODCLI+' ' + MNOME + 'No. AV : '+MVPAR
      @ 05,02 SAY 'Endereco   : ' + mend
      @ 06,02 SAY 'Bairro     : ' +mbairro +' ' +MCIDADE +' ' + mcep
      @ 07,02 SAY 'CGC.: .....: ' + MCGC + ' ' + 'INSCR.EST.:'+MINSC
      @ 08,02 SAY 'Cond.Pagto.: ' + mcondpag + ' ' +'Tipo Trans.:' +mtptrans
      @ 09,02 say 'Contato....: ' + mvend + ' '+ mnomevend
      L:=10
      IF MCODAG#'  '
      @ L,02 say REPLICATE('-',76)
        L:=L+1
         @ L,02 SAY 'Agencia : '+ mnomeag
         L:=L+1
         IF MTPTRANS=='04' .OR. MTPTRANS =='12'
            @ L,02   SAY  'End.....: ' + mendag
            @ L+1,02 SAY  'Cidade..: '+trim(mcidadeag)+'-'+mestadoag+' '+ mcepag
            L := L+2
         ENDIF
      ENDIF
      Set color to W+/B
      @ L,02 SAY 'ITEM INS REV EDICAO  DT.CIRC. SIT.  VALOR NFISCAL DESCRICAO         CODMAT  '
            Set color to B/BG
      XL:=L+1
      L:=L+1
         _X:=1

         FOR _X:=1 TO LEN(MOSTRA)
         @ L,02 SAY MOSTRA[_X]
         LINHA()
         NEXT
      INKEY(0)
      XL:=XL-1
      @ XL,02 CLEAR TO 23,77

      L:=XL
      IF SC5->C5_AVESP=='S'
         Set color to W+/B
         @ L,02 SAY PADC('FORMA DE PAGAMENTO/PARCELAMENTO',76)
         SET COLOR TO B/BG
         L:=L+1
         @ L,02 SAY 'PARC.     VALOR   ANO/MES   N.FISCAL     DT.NF      SITUAC '
         L:=L+1
         XL:=L
         PARC:=1
         FOR PARC:=1 TO LEN(MPARCELA)
             @ L,02 SAY MPARCELA[PARC]
             LINHA()
         NEXT
         INKEY(0)
         XL:=XL-2
         L:=XL
      ENDIF

            Set color to W+/B
      @ L,02 SAY PADC('POSI€AO DAS DUPLICATAS',76)
            Set color to B/BG
      L:=L+1
      @ L,02 SAY 'DUPL/PARC   VALOR   EMISSAO    VENCTO    BAIXA    MOT.BAIXA        PORTADOR '
      L:=L+1
      DUP:=1
      FOR DUP:=1 TO LEN(MOSTRA_DUPL)
         @ L,02 SAY MOSTRA_DUPL[DUP]
      LINHA()
      NEXT
            Set color to W+/B
      @ 24,02 SAY PADC(" FIM DA CONSULTA " ,77)
            Set color to B/BG
      INKEY(0)
      limpa()
            Set color to W+/B
      @ 24,02 CLEAR TO 24,77
            Set color to B/BG
ENDDO
Restscreen(3,2,23,79,cSavtela1)




// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>    Function LIMPA
Static Function LIMPA()
     @ 4,02 clear TO 21,77
     @ 23,01 SAY REPLICATE(' ',76)
   Return



// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>    function linha
Static function linha()
   if l>22
      inkey(0)
      @ xl,02 clear to 23,77
      l:=xl
   else
      l:=l+1
   endif
RETURN








