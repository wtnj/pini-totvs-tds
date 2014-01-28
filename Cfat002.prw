#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Cfat002()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,TECLA,SAI")
SetPrvt("LP,TK,UL,L,NL,PL")
SetPrvt("CSAVTELA1,MFILIAL,MCOD,MLOJA,MNOME,MEND")
SetPrvt("MBAIRRO,MCEP,MMUN,MEST,MCGC,MIE")
SetPrvt("MIM,MTEL,MFAX,MENDC,MBAIRROC,MCIDADEC")
SetPrvt("MESTADOC,MCEPC,CSAVETELA2,LIN,MVEND,MTIPOOP")
SetPrvt("FIM,MCODPROD,MCODEDISA,MTES,MNATOPER,MDESCRICAO")
SetPrvt("MPORTE,MTIPOREV,MSITUAC,MCODDEST,MENDDEST,MBAIRROD")
SetPrvt("MCIDADED,MESTADOD,MCEPD,CSAVTELAC,REC,MPEDIDO")
SetPrvt("RESP,XMOTIVO,MMOTIVO,ULTECLA,")

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: CFAT002   ³Autor: Solange Nalini         ³ Data:   15/01/99 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Consulta geral de clientes,pedidos, faturamento ....       ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
//cSavTela   := SaveScreen( 0, 0,24,80)
//cSavCursor := SetCursor()
//cSavCor    := SetColor()
//cSavAlias  := Select()
TECLA:=0
//SetColor("B/BG")
//DrawAdvWin("**  CONSULTA GERAL **" , 3, 0, 22, 78 )
sai:=.F.
@ 04,03 say 'F5 CONSULTA POR CODIGO     F6  CONSULTA POR NOME     F7 CONSULTA POR CGC '
@ 05,03 say 'F8 CONSULTA POR PEDIDO     F10 REGISTRA OCORRENCIA '
//set color to B/BG
@ 06,02 to 06,77  DOUBLE
@ 07,02 say 'Codigo'
@ 07,10 SAY 'Nome'
@ 07,55 say  'CGC'
lp:=8
tk:=0
ul:=21

dbSelectArea("SA1")
dbSetOrder(1)
go top

Do While .not. sai
   l:=8
   dbSelectArea("SA1")
   Do while l<=21 .and. .not. eof()
      concli()
      DBskip()
      l:=l+1
   Enddo
   nl:=L
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Limpa o restante da janela               ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   Do while nl<=21
      @ nl,02 say space(78)
      nl:=nl+1
   Enddo
   l:=l-1
   ul:=l
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Se for tecla de Funcao (Tk<0             ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   If tk<0
      goto rec
      lp:=8
   else
      Dbskip(lp-(l+1))
   Endif
   pl:=.F.
   If l<21
      If lp>8
         lp:=l
         go bott
      Endif
      pl:=.T.
   Endif
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Mostra a barra apontadora                ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  // Set Color to W+/B
   l:=lp
   concli()
  // Set Color to B/BG
   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   //³ Aguarda as teclas de funcao              ³
   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   Do while .t.
    //  cSavtela1:=Savescreen(3,0,24,79)
      tk:=inkey(0)
      Do case
         case tk==24                               //seta p/baixo
            dbskip()
            if eof()
               loop
            else
               Dbskip(-1)
            Endif
            If lp<21                               //se nao precisar rolar a tela
               L:=LP
    //           Set color to B/BG
               concli()
      //         Set color to B/BG
               lp:=lp+1
               Dbskip()
               l:=lp
        //       set color to W+/B
               CONCLI()
          //     Set color to B/BG
               loop
            Else
               l:=lp
               CONCLI()
               Dbskip()
               If .not. eof()
            //      scroll(8,2,21,77,1)
               Endif
           //    Set color to W+/B
               l:=lp
               CONCLI()
             //  Set color to B/BG
               loop
            Endif

         Case tk==5           //seta para cima
            If BOF()
               loop
            Endif
            If lp>8
               If eof()
                  Dbskip(-1)
               Endif
               l:=lp      //VER
      //         SET COLOR TO B/BG
               concli()
               lp:=lp-1
               DbSkip(-1)
        //       set color to W+/B
               l:=lp
               concli()
          //     set color to B/BG
               loop
            Else
               If eof()
                  Dbskip(-1)
               Endif
               l:=lp
               concli()
               DBSKIP(-1)
               If .not. bof()
            //       scroll(8,2,21,77,-1)
               Endif
              // set color to w+/B
               l:=lp
               concli()
             //  set color to B/BG
               loop
            Endif

         Case tk==18                             //PgUp
            If BOF()
               loop
            Endif
            If EOF()
               If lastreck()>18
                  Dbskip(-17)
               Else
                  go top
               Endif
            Else
               If lastrec()>14
                  Dbskip(-(lp-8+14))
               else
                  go top
               Endif
            Endif
            exit

         Case tk==3                           //PgDn
            If ul<21
               loop
            Endif
            DbSkip(21-lp)
            Exit

         Case tk==1                           //Home
            dbSetOrder(1)
            go top
            Exit

         Case tk==6                           //End
            dbSetOrder(1)
            go bott
            If lastrec()>=14
               Dbskip(-14)
            Else
               go top
            Endif
            exit

         Case tk==13                          //Enter
  //          cSavtela1:=Savescreen(3,0,24,79)
            dbselectarea("SA1")
    //        set color to B/BG
      //      limpa()
            mfilial:=a1_filial
            mcod   :=a1_cod
            mloja  :=a1_loja
            mnome  :=a1_nome
            mend   :=a1_end
            mbairro:=a1_bairro
            mcep   :=subs(a1_cep,1,5)+'-'+subs(a1_cep,6,3)
            mmun   :=a1_mun
            mest   :=a1_est
            mcgc   :=a1_cgc
            mie    :=a1_inscr
            mim    :=a1_inscrm
            mtel   :=a1_tel
            mfax   :=a1_fax
            Dbselectarea("SZ5")
            Dbseek(xfilial()+mcod)
            If found()
               Mendc    :=Z5_End
               Mbairroc :=Z5_bairro
               mcidadec :=Z5_cidade
               mestadoc  :=Z5_estado
               mcepc    :=subs(Z5_cep,1,5)+'-'+subs(z5_cep,6,3)
            else
               Mendc    := space(40)
               Mbairroc := space(20)
               mcidadec := space(20)
               mestadoc := space(2)
               mcepc    := space(9)
            Endif
            Dbselectarea("SA1")
            Telacli()
        //    Set color to W+/B
            @ 22,00 say PADC("<PgDn> Continua consulta  ",79)
     //       cSaveTela2:=Savescreen(3,0,24,79)
     //       set color to B/BG
            tk:=Inkey(0)
       //     Set color to B/BG
            If tk==3
         //      @ 06,02 CLEAR TO 21,77
               Dbselectarea("SC6")
               DbsetOrder(10)
               Dbseek(xfilial()+mcod)
               If .not. found()
           //       LIMPA()
     //             Set color to W/B
                  @ 10,10 to 14,60
                  @ 12,21 say "Nao h  pedidos para este cliente"
       //           set color to W+/B
                  @ 22,02 say PADC("Qualquer tecla retorna",77)
         //         set color to B/BG
                  inkey(0)
                  dbSelectArea("SA1")
           //       Restscreen(3,0,24,79,cSavtela1)
                  loop
               else
                  lin:=04
             //     Set color to W+/B
                  @ LIN,02 SAY 'Pedidos para o cliente ->' +sa1->a1_cod+' ' +sa1->a1_nome+'    '
             //     set color to B/BG
                  @ lin+1,02 to lin+1,77 double
                  lin:=lin+2
                  If tecla==-7
                     TECLA:=0
                     @ 06,02 clear TO 21,77
                     dbSelectArea("SC5")
                     dbSeek(xFilial()+mPEDIDO)
                     @ 06,02 SAY  'Pedido..: ' + SC5->C5_NUM
                     @ 06,20 say  'Lote ..: '  + SC5->C5_LOTEFAT
                     @ 06,42 SAY  'Data ..: '  + DTOC(SC5->C5_DATA)
                     @ 06,60 SAY  'Cod.Prom.: '+ SC5->C5_CODPROM
                     @ 07,02 SAY  'Repres..: ' + SC5->C5_VEND1
                     MVEND:=C5_VEND1
                     dbSelectArea("SA3")
                     dbSeek(xFilial()+MVEND)
                     @ 07,20 SAY SA3->A3_NOME
                     mTipoop := SC5->C5_TIPOOP
                     dbSelectArea("SZ9")
                     dbSeek(xFilial()+MTIPOOP)
                     @ 08,02 SAY 'Tipo Op..: ' + mtipoop+ ' ' +SZ9->Z9_DESCR
                     dbSelectArea("SC5")
                     @ 09,02 SAY 'Resp.Cobr.: '+ SC5->C5_RESPCOB
                     Set Color to W+/B
                     @ 10,02 TO 10,32
                     @ 10,34 say ' PRODUTOS '
                     @ 10,45 to 10,77
          //           Set Color to B/BG
                     LIN:=11
                     dbSelectArea("SC6")
                     dbSetOrder(1)
                     dbSeek(xFilial()+MPedido)
                     fim:=.f.
                     Do While SC6->C6_NUM==MPEDIDO .and. .not. fim
                        mcodprod := SC6->C6_PRODUTO
                        MCODEDISA:=SC6->C6_NUMANT
                        mtes:=sc6->c6_tes
                        dbSelectArea("SF4")
                        dbSeek(xfilial()+mtes)
                        mnatoper:=trim(SF4->F4_TEXTO)
                        dbSelectArea("SC6")
                        @ lin,02 say 'Ped/Item.:'+ SC6->C6_NUM+'/'+SC6->C6_ITEM
                        dbSelectArea('SB1')
                        dbSeek(xfilial()+mcodprod)
                        mdescricao := subs(SB1->B1_desc,1,35)
                        dbSelectArea("SC6")
                        @ lin,23 say mdescricao
                        @ LIN,65 SAY 'Edisa:'+mcodedisa
                        LINHA()
                        IF ULTECLA#3
                           LOOP
                        ENDIF
                        @ lin,02 say 'Qtde:' +str(sc6->c6_qtdven,3)
                        @ lin,12 say "Vlr.Unit.:"+ str(sc6->c6_prcven,10,2)
                        @ LIN,33 SAY 'Vlt.Total.: '+str(sc6->c6_valor,10,2)
                        @ LIN,56 SAY 'Nat.Oper:'+mnatoper
                        LINHA()
                        IF ULTECLA#3
                           LOOP
                        ENDIF
                        If subs(SC6->C6_PRODUTO,1,2)=='01'
                           IF LIN#21
                              @ lin,02 to lin,77
                           ENDIF
                           LINHA()
                           IF ULTECLA#3
                              LOOP
                           ENDIF
                           @ LIN,02 say 'Ed.Inic.:'+str(sc6->c6_edinic,4,0)
                           @ LIN,16 say 'Ed.Fin.:'+str(sc6->c6_edfin,4,0)
                           @ LIN,30 say 'Ed.Venc.:' +str(sc6->c6_edvenc,4,0)
                           @ lin,44 say 'Ed.Susp.:'+str(sc6->c6_edsusp,4,0)
                           Do Case
                              Case sc6->c6_tpporte=='0'
                                 mporte:='Correio Normal'
                              Case sc6->c6_tpporte=='1'
                                 mporte:='Correio CNN'
                              Case sc6->c6_tpporte=='3'
                                 mporte:='Carta'
                              Case sc6->c6_tpporte=='6'
                                 mporte:='Entr.protocolada'
                              Case sc6->c6_tpporte=='8'
                                 mporte:='Suspesas'
                           Endcase
                           Do Case
                              Case SC6->C6_TIPOREV=='0'
                                 mTiporev:='Mensal'
                              Case SC6->C6_TIPOREV=='1'
                                 mTiporev:='Par'
                              Case SC6->C6_TIPOREV=='2'
                                 mTiporev:='Impar'
                              Case SC6->C6_TIPOREV=='3'
                                 mTiporev:='Semanal'
                              Case SC6->C6_TIPOREV=='4'
                                 mTiporev:='Bimestral'
                           Endcase
                           @ lin,58 say 'Tipo Rev.:'+mtiporev
                           LINHA()
                           IF ULTECLA#3
                              LOOP
                           ENDIF
                           mSituac:='  '
                           Do Case
                              Case SC6->C6_SITUAC=='AA'
                                 mSituac:='ATIVO'
                              Case SC6->C6_SITUAC=='SI'
                                 mSituac:='Suspenso p/Inadimpl.'
                              Case SC6->C6_SITUAC=='SE'
                                 mSituac:='Suspenso p/Endereco'
                              Case SC6->C6_SITUAC=='CP'
                                 mSituac:='Suspenso a pedido do cliente'
                           Endcase
                           @ lin,02 say 'Situacao:' +msituac
                           @ lin,41 say 'Porte.:'+mporte
                           mcoddest:=c6_coddest
                           If mcoddest#' '
                              LINHA()
                              IF ULTECLA#3
                                 LOOP
                              ENDIF
                              dbselectarea("SZN")
                              dbseek(xfilial()+mcod+mcoddest)
                              mnome:=zn_nome
                              dbselectarea("SZO")
                              dbseek(xfilial()+mcod+mcoddest)
                              If found()
                                 menddest := zo_end
                                 mbairrod := zo_bairro
                                 mcidaded := zo_cidade
                                 mestadod := zo_estado
                                 mcepd    := subs(zo_cep,1,5)+'-'+subs(zo_cep,6,3)
                              Else
                                 menddest :=' '
                                 mbairrod :=' '
                                 mcidaded :='  '
                                 mestadod :='  '
                                 mcepd    :='  '
                              Endif
                              @ lin,02 to lin,77
                              LINHA()
                              IF ULTECLA#3
                                 LOOP
                              ENDIF
                              @ lin  ,02 say 'Dest.: '+mnome
                              LINHA()
                              IF ULTECLA#3
                                 LOOP
                              ENDIF
                              @ lin,02 say 'End..: '+menddest+' '+mbairrod
                              LINHA()
                              IF ULTECLA#3
                                 LOOP
                              ENDIF
                              @ lin,02 say mcepd+ ' ' +mcidaded+' '+mestadod
                           Endif
                        endif
                        dbselectarea("SC6")
                        DBSKIP()
                        IF SC6->C6_NUM#MPEDIDO
                           EXIT
                        ELSE
                           LINHA()
                           IF ULTECLA#3
                              LOOP
                           ENDIF
                           IF LIN#6
                         //     set color to W+/B
                              @ lin,02 to lin,77 double
                         //     set color to b/BG
                              LINHA()
                              IF ULTECLA#3
                                 LOOP
                              ENDIF
                           ENDIF
                           IF ULTECLA#3
                              LOOP
                           ENDIF
                        ENDIF
                     Enddo
                     IF FIM==.T.
                        DBSELECTAREA("SA1")
                        LOOP
                     ENDIF
      // testar
                  IF ULTECLA==27
                     LOOP
                  ENDIF

                     Inkey(0)
                     @ 04,02 CLEAR TO 21,77
                     dbSelectArea("SE1")
					 dbSetOrder(21)  ///dbSetOrder(15) AP5
                     dbSeek(xFILIAL()+MPEDIDO)
                     If .not. found()
                        LIMPA()
                      //  Set color to W/B
                        @ 10,10 to 14,65
                        @ 12,15 say "Nao h  duplicatas/Faturamento para este cliente"
                     //   set color to W+/B
                        @ 22,02 say PADC("Qualquer tecla retorna",77)
                     //   set color to B/BG
                     Else
                        lin:=04
                       // set color to W+/B
                        @ LIN,02 SAY 'Dupl/Fat/ para o cliente  ->' +sa1->a1_cod+' ' +sa1->a1_nome
                       // set color to B/BG
                        @ lin+1,02 to lin+1,77 double
                        lin:=lin+2
                        @ lin,02 say 'Dupl/NF'
                        @ lin,10 say 'Parcela'
                        @ lin,19 say 'Valor'
                        @ lin,26 say 'Emissao'
                        @ lin,36 say 'Vencto'
                        @ lin,46 say 'Dt.Baixa'
                        @ lin,56 say 'Mot.Baixa'
                        @ lin,66 say 'Port.'
                        @ lin,72 say 'Pedido'
                        LINHA()
                        fim:=.f.
                        Do while SE1->E1_PEDIDO==MPEDIDO .AND. LIN<21 .and. .not. fim
                       //    Set color to W+/B
                           @ 22,02 say PADC(" Fim da Consulta ",79)
                       //    set color to B/BG
                           CONSDUPL()
                           dbSkip()
                           If LIN>=20
                              tk:=inkey(0)
                              If tk#3
                                 @ 6,00 CLEAR TO 21,77
                                 fim:=.t.
//                                 Restscreen(3,0,24,79,cSavtela1)
                              Else
                                 @ 6,00 CLEAR TO 21,77
                                 LIN:=6
                                 loop
                              Endif
                           Endif
                        Enddo
                     Endif

             if ultecla==27
                     LOOP
                  ENDIF

                     inkey(0)
                     dbselectarea("SA1")
//                     Restscreen(3,0,24,79,cSavtela1)
                     tecla:=0
                     loop
                  endif
                  fim:=.f.
                  do while sc6->c6_cli==mcod .AND. .not. fim
                     mcodprod := SC6->C6_PRODUTO
                     MCODEDISA:=SC6->C6_NUMANT
                     mtes:=sc6->c6_tes
                     @ lin,02 say 'Ped/Item.:'+ SC6->C6_NUM+'/'+SC6->C6_ITEM
                     dbSelectArea('SB1')
                     dbSeek(xfilial()+mcodprod)
                     mdescricao := sb1->b1_desc
                     dbSelectArea("SF4")
                     dbSeek(xfilial()+mtes)
                     mnatoper:=TRIM(SF4->F4_TEXTO)
                     dbSelectArea("SC6")
                     @ lin,23 say mdescricao
                     @ LIN,65 SAY 'Edisa:'+mcodedisa
                     LINHA()
                     IF ULTECLA#3
                        LOOP
                     ENDIF
                     @ lin,02 say 'Qtde:' +str(sc6->c6_qtdven,3)
                     @ lin,12 say "Vlr.Unit.:"+ str(sc6->c6_prcven,10,2)
                     @ LIN,33 SAY 'Vlt.Total.: '+str(sc6->c6_valor,10,2)
                     @ LIN,57 say 'Nat.Oper.: '+mnatoper
                     LINHA()
                     IF ULTECLA#3
                        LOOP
                     ENDIF
                     If subs(SC6->C6_PRODUTO,1,2)=='01'
                        IF LIN#21
                        @ lin,02 to lin,77
                     ENDIF
                     LINHA()
                     IF ULTECLA#3
                        LOOP
                     ENDIF
                     @ LIN,02 say 'Ed.Inic.:'+str(sc6->c6_edinic,4,0)
                     @ LIN,16 say 'Ed.Fin.:'+str(sc6->c6_edfin,4,0)
                     @ LIN,30 say 'Ed.Venc.:' +str(sc6->c6_edvenc,4,0)
                     @ lin,44 say 'Ed.Susp.:'+str(sc6->c6_edsusp,4,0)
                     MPORTE:=' '
                     Do Case
                        Case sc6->c6_tpporte=='0'
                           mporte:='Correio Normal'
                        Case sc6->c6_tpporte=='1'
                           mporte:='Correio CNN'
                        Case sc6->c6_tpporte=='3'
                           mporte:='Carta'
                        Case sc6->c6_tpporte=='6'
                           mporte:='Entr.protocolada'
                        Case sc6->c6_tpporte=='8'
                           mporte:='Suspesas'
                     Endcase
                     Do Case
                        Case SC6->C6_TIPOREV=='0'
                           mTiporev:='Mensal'
                        Case SC6->C6_TIPOREV=='1'
                           mTiporev:='Par'
                        Case SC6->C6_TIPOREV=='2'
                           mTiporev:='Impar'
                        Case SC6->C6_TIPOREV=='3'
                           mTiporev:='Semanal'
                        Case SC6->C6_TIPOREV=='4'
                           mTiporev:='Bimestral'
                     Endcase
                     @ lin,58 say 'Tipo Rev.:'+mtiporev
                     LINHA()
                     IF ULTECLA#3
                        LOOP
                     ENDIF
                     Do Case
                        Case SC6->C6_SITUAC=='AA'
                           mSituac:='ATIVO'
                        Case SC6->C6_SITUAC=='SI'
                           mSituac:='Suspenso p/Inadimpl.'
                        Case SC6->C6_SITUAC=='SE'
                           mSituac:='Suspenso p/Endereco'
                        Case SC6->C6_SITUAC=='CP'
                           mSituac:='Suspenso a pedido do cliente'
                        Case SC6->C6_SITUAC=='SU'
                           mSituac:='Suspenso '
                     Endcase
                     @ lin,02 say 'Situacao:' +msituac
                     @ lin,41 say 'Porte.:'+mporte
                     LINHA()
                     IF ULTECLA#3
                        LOOP
                     ENDIF
                     mcoddest:=c6_coddest
                     If mcoddest#' '
                        dbselectarea("SZN")
                        dbseek(xfilial()+mcod+mcoddest)
                        mnome:=zn_nome
                        dbselectarea("SZO")
                        dbseek(xfilial()+mcod+mcoddest)
                        If found()
                           menddest := zo_end
                           mbairrod := zo_bairro
                           mcidaded := zo_cidade
                           mestadod := zo_estado
                           mcepd    := subs(zo_cep,1,5)+'-'+subs(zo_cep,6,3)
                         Else
                           menddest :=' '
                           mbairrod :=' '
                           mcidaded :='  '
                           mestadod :='  '
                           mcepd    :='  '
                        End                if
                        @ lin,02 to lin,77
                        LINHA()
                        IF ULTECLA#3
                           LOOP
                        ENDIF
                        @ lin  ,02 say 'Dest.: '+mnome
                        LINHA()
                        IF ULTECLA#3
                           LOOP
                        ENDIF
                        @ lin,02 say 'End..: '+menddest+' '+mbairrod
                        LINHA()
                        IF ULTECLA#3
                           LOOP
                        ENDIF
                        @ lin,02 say mcepd+ ' ' +mcidaded+' '+mestadod
                        LINHA()
                        IF ULTECLA#3
                           LOOP
                        ENDIF
                     Endif
                     dbselectarea("SC6")
                  endif
//                  set color to W+/B
                  @ lin,02 to lin,77 double
//                  set color to b/BG
                  LINHA()
                  IF ULTECLA#3
                     LOOP
                  ENDIF
                  DBSKIP()

              Enddo
                  IF ULTECLA==27
                     LOOP
                  ENDIF

                  tk:=INKEY(0)
                  If tk==3
                     @ 4,02 CLEAR TO 21,77
                     dbSelectArea("SE1")
                     dbSetOrder(2)
                     dbSeek(xFilial()+MCOD)
                     If .not. found()
                        LIMPA()
                        Set color to W/B
                        @ 10,10 to 14,65
                        @ 12,15 say "Nao h  duplicatas/Faturamento para este cliente"
//                        set color to W+/B
                        @ 22,02 say PADC("Qualquer tecla retorna",77)
//                        set color to B/BG
                        inkey(0)
                     Else
                        lin:=04
//                        set color to W+/B
                        @ liN,02 say 'Dupl/Fat/ para o cliente  ->' +sa1->a1_cod+' ' +sa1->a1_nome
//                        set color to B/BG
                        @ lin+1,02 to lin+1,77 double
                        lin:=lin+2
                        @ lin,02 say 'Dupl/NF'
                        @ lin,10 say 'Parc'
                        @ lin,19 say 'Valor'
                        @ lin,26 say 'Emissao'
                        @ lin,36 say 'Vencto'
                        @ lin,46 say 'Dt.Pgto'
                        @ lin,56 say 'Mot.Baixa'
                        @ lin,66 say 'Port.'
                        @ lin,72 say 'Pedido'
                        lin:=lin+1
                        fim:=.f.
                        Do while SE1->E1_CLIENTE==MCOD .AND. LIN<=21 .and. .not. fim
                           Set color to W+/B
                           @ 22,02 say PADC(" Fim da Consulta ",77)
//                           set color to B/BG
                           CONSDUPL()
                           dbSkip()
                           If LIN>=20
                              tk:=inkey(0)
                              If tk#3
                                 @ 6,02 CLEAR TO 21,77
                                 fim:=.t.
//                                 Restscreen(3,0,24,79,cSavtela1)
                              Else
                                 @ 6,02 CLEAR TO 21,77
                                 LIN:=6
                                 loop
                              Endif
                           Endif
                        Enddo
                        INKEY(0)
//                        Restscreen(3,0,24,79,cSavtela1)
                     Endif
                  Endif
               Endif
            Endif
            dbSelectArea("SA1")
//            Restscreen(3,0,24,79,cSavtela1)
            exit
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se teclar F5 Consulta Cod.Cliente        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        case tk==-4
//            cSavtelac:=Savescreen(8,0,22,79)
            @ 10,02 clear to 14,22
  //          set color to W/B
            @ 10,02 to 14,22
            mcod:=space(6)
    //        set color to B/BG
            @ 12,04 say 'Cod.Cli.:' get mcod pict '999999'
            read
//            Restscreen(8,0,22,79,cSavtelac)
            DbselectArea("SA1")
            dbSetOrder(1)
            If Empty(mcod)
               loop
            Endif
            Dbseek(xFilial()+mcod)
            If .not. found()
               LIMPA()
    //           Set color to W/B
               @ 10,10 to 14,65
               @ 12,28 say "Codigo nao localizado."
      //         set color to W+/B
               @ 22,02 say PADC("Qualquer tecla retorna",77)
      //         set color to B/BG
               inkey(0)
        //       Restscreen(3,0,24,79,cSavtela1)
               go top
               Loop
            Endif
            rec:=recno()
      //      Restscreen(3,0,24,79,cSavtela1)
            Exit
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se teclar F6 Consulta por Nome de cliente³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        case tk==-5
            mnome:=space(40)
        //    cSavtelac:=Savescreen(8,0,22,79)
            @ 10,02 clear to 14,55
      //      set color to W/B
            @ 10,02 to 14,55
      //      set color to B/BG
            @ 12,04 say "Nome..:" get mnome pict "@!"
            read
           // Restscreen(8,0,22,79,cSavtelac)
            If Empty(MNOME)
               loop
            Endif
            DbselectArea("SA1")
            dbSetOrder(2)
            set softseek on
            Dbseek(xFilial()+mNOME)
            rec:=recno()
            set softseek off
            exit

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se teclar F7 Consulta por CGC            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        case tk==-6
     //       cSavtelac:=Savescreen(8,0,22,79)
         //   @ 10,02 clear to 14,26
       //     set color to W/B
            @ 10,02 to 14,26
            mcgc:=space(14)
      //      set color to B/BG
            @ 12,04 say "CGC:" get MCGC pict "@!"
            read
            DbselectArea("SA1")
            If Empty(MCGC)
               loop
            Endif
            rec:=recno()
            dbSetOrder(3)
            Dbseek(xfilial()+mcgc)
            If .not. found()
               LIMPA()
//               Set color to W/B
               @ 10,10 to 14,65
               @ 12,28 say "CGC nao localizado."
//               set color to W+/B
               @ 22,01 say PADC("Qualquer tecla retorna",77)
//               set color to B/BG
               inkey(0)
        //       Restscreen(3,0,24,79,cSavtela1)
               dbSetOrder(1)
               go top
               Loop
            Endif
            rec:=recno()
          //  Restscreen(3,0,24,79,cSavtela1)
            exit

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se teclar F8 Consulta o Pedido           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        case tk==-7
            TECLA:=TK          //Guarda o valor da tecla consulta de Pedido espec¡fico    //
         //   cSavtelac:=Savescreen(8,0,22,79)
            rec:=recno()
            @ 10,02 clear to 14,20
//            set color to W/B
            @ 10,02 to 14,20
            mpedido:=space(6)
//            set color to B/BG
            @ 12,04 say "Pedido.:" get Mpedido  pict "@!"
            read
  //          Restscreen(8,0,22,79,cSavtelac)
            DbselectArea("SC5")
            If Empty(Mpedido)
               loop
            Endif
            dbSetOrder(1)
            Dbseek(xfilial()+mpedido)
            If .not. found()
               LIMPA()
    //           Set color to W/B
               @ 10,10 to 14,65
               @ 12,26 say "Pedido nao localizado."
      //         set color to W+/B
               @ 22,01 say PADC("Qualquer tecla retorna",77)
        //       set color to B/BG
               //// ver
               tecla:=0
               Inkey(0)
               DbselectArea("SA1")
           //    Restscreen(3,0,24,79,cSavtela1)
               Loop
            Endif
            mcod:=SC5->C5_CLIENTE
            DbSelectArea("SA1")
            Dbsetorder(1)
            Dbseek(xfilial()+mcod)
            rec:=recno()
            exit

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se teclar F10 Grava Ocorrencia do Cliente ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        case tk==-9
            Execblock("axfat026")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se for tecla de Funcao                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
        case tk==27
//            cSavtela1:=Savescreen(3,0,24,79)
//            limpa()
            RESP:=' '
            Set Color to W+/B
            @ 10,22 TO 14,57 double
            Set Color to B/BG
            @ 12,24 say "ABANDONAR A CONSULTA (S/N)? "  GET RESP PICT "@!"
            READ
            IF RESP=='S'
               sai:=.T.
               exit
            ELSE
//               limpa()
               @ 23,02 clear to 23,77
//               Restscreen(3,0,24,79,cSavtela1)
            ENDIF
        otherwise
//            cSavtela1:=Savescreen(3,0,24,79)
//            limpa()
         //   Set Color to W+/B
            @ 04,07 TO 19,72 double
            @ 05,08 say PADC(" Ajuda ao Usuario" ,64)
         //   Set Color to B/BG
            @ 06,09 say 'Tecla   Funcao'
            @ 08,09 say 'Setas   p/cima e p/baixo posiciona no item desejado'
            @ 09,09 say 'PgUp    Retroce pagina'
            @ 10,09 say 'PgDn    Avanca pagina'
            @ 11,09 SAY 'Home    Inicio do Arquivo'
            @ 12,09 say 'End     Fim do Arquivo'
            @ 13,09 say 'F5      Consulta por Cod.Cliente'
            @ 14,09 say 'F6      Consulta por Nome Cliente'
            @ 15,09 say 'F7      Consulta por CGC'
            @ 16,09 say 'F8      Consulta por Pedido '
            @ 17,09 say 'F10     Grava Ocorrencia'
          //  Set Color TO W+/B
            @ 23,02 say padc('Qualquer tecla retorna',77)
          //  Set Color TO B/BG
            inkey(0)
//            limpa()
            @ 23,02 clear to 23,77
          //  Restscreen(3,0,24,79,cSavtela1)
        endcase
   Enddo
Enddo

  dbSelectArea("SE1")
  dbSetOrder(1)
  dbSelectArea("SA1")
  dbSetOrder(1)
  dbSelectArea("SC5")
  dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³          Inicio das Funcoes              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


Return(nil)        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function CONCLI
Static Function CONCLI()
  @ l,02 SAY A1_COD
  @ l,10 SAY A1_NOME
  @ l,55 SAY A1_CGC
Return

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function LIMPA
Static Function LIMPA()
  @ 4,02 clear TO 21,77
  @ 24,00 CLEAR TO 24,77
Return

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function TELACLI
Static Function TELACLI()
  @ 4,02  SAY 'Cod.Cliente: ' + MCOD +'        ' +MNOME
  @ 5,02  SAY 'Endere‡o...: ' + MEND+' ' +MBAIRRO
  @ 6,02  SAY 'Cidade.....: ' + MMUN+' Estado:  ' +MEST+' Cep:  '+  MCEP
  @ 7,02  say 'CGC .......: ' + MCGC + ' Inscr.Est.:'+miE
  @ 8,02  say 'Inscr.Mun..: ' + mim
  @ 09,02 say 'Telefone...: ' +mtel+'   Fax.:' +mfax
  @ 10,02 to 10,77
  @ 11,02 say 'Dados complementares para Cobran‡a:'
  @ 12,02 to 12,37
  @ 13,02  SAY 'Endere‡o...: ' + MENDc+' ' +MBAIRROc
  @ 14,02  SAY 'Cidade.....: ' + Mcidadec+ ' Estado:  ' +Mestadoc+ ' Cep:  '+  MCEPc
Return


// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function CONSDUPL
Static Function CONSDUPL()
  @ lin,02 say SE1->E1_NUM
  @ lin,10 say SE1->E1_PARCELA
  @ lin,14 say str(SE1->E1_VALOR,10,2)
  @ lin,26 say SE1->E1_EMISSAO
  @ lin,36 say SE1->E1_VENCTO
  @ lin,46 say SE1->E1_BAIXA
  IF !Empty(SE1->E1_BAIXA)
     XMOTIVO:=SUBS(SE1->E1_MOTIVO,1,3)
     DO CASE
        CASE XMOTIVO=='CAN'
             MMOTIVO:='CANC'
        CASE XMOTIVO=='DEV'
             MMOTIVO:='DEV'
        CASE XMOTIVO=='LP '
             MMOTIVO:='LP '
        CASE XMOTIVO=='DAC'
             MMOTIVO:='DACAO'
        CASE SE1->E1_MOTIVO==SPACE(20) .OR. SE1->E1_MOTIVO='NOR'
             MMOTIVO:='PAGTO'
    ENDCASE
 ELSE
    MMOTIVO:='  '
 ENDIF

  @ lin,56 say MMOTIVO
  @ lin,66 say SE1->E1_PORTADO
  @ lin,72 Say SE1->E1_PEDIDO
  LIN:=LIN+1
Return

// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>                 FUNCTION LINHA
Static FUNCTION LINHA()
                   If LIN==21
                      tk:=inkey(0)
                      If tk#3
                          ULTECLA:=TK
                           @ 6,02 CLEAR TO 21,77
                           fim:=.t.
            //               Restscreen(3,0,24,79,cSavtela1)
                      Else
                           @ 6,02 CLEAR TO 21,77
                           LIN:=6
                      Endif
                   Else
                        LIN:=LIN+1
                          ULTECLA:=3
                   Endif
                  RETURN
