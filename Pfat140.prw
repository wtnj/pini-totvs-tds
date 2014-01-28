#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
#IFNDEF WINDOWS
    #DEFINE PSAY SAY
#ENDIF

User Function Pfat140()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CARQPATH,MCONTA,MCONTA1,MCONTA2,CARQ,CPERG")
SetPrvt("LEND,BBLOCO,_CSTRING,CINDEX,CKEY,MCHAVE")
SetPrvt("CFILTRO,CIND,MTESTE,MAT,MSTATUS2,MOBS3")
SetPrvt("_SALIAS,AREGS,I,J,")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     #DEFINE PSAY SAY
#ENDIF
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT140   ³Autor: Raquel Ramalho         ³ Data:   06/09/01 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Adiciona registro no cadastro de ocorrencias               ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

//ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ MV_PAR01 ³ Arquivo de trabalho  ?                         ³
//³ MV_PAR02 ³ Cod. Promo‡Æo        ?                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

#IFNDEF WINDOWS
    ScreenDraw("SMT050", 3, 0, 0, 0)
    SetCursor(1)
    SetColor("B/BG")
#ENDIF

cArqPath  :=GetMv("MV_PATHTMP")
mConta    :=0
mConta1   :=0
mConta2   :=0
cArq      :=MV_PAR01

cPerg:="PFT140"
_ValidPerg()

If !Pergunte(cPerg)
   Return
Endif

IF Lastkey()==27
   Return
Endif


#IFNDEF WINDOWS
    DrawAdvWin(" AGUARDE - ATUALIZANDO ARQUIVO DAS OCORRENCIAS" , 8, 0, 15, 75 )
    OCORR()               // para funcionar a partir do SC6.
#ELSE
    lEnd:= .F.
       bBloco:= { |lEnd| OCORR()  }// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        bBloco:= { |lEnd| Execute(OCORR)  }
    MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorna indices originais...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea('Arq')
DbCloseArea()
DbSelectArea("SZ1")
Retindex("SZ1")
Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ Ocorr                                                         ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Atualiza Arquivo                                              ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function Ocorr
Static Function Ocorr()
   _cString  :=cArqPath+AllTrim(MV_PAR01)+'.DBF'
   dbUseArea( .T.,, _cString,'ARQ', if(.F. .OR. .F., !.F., NIL), .F. )
   dbSelectArea('ARQ')
   cIndex:=CriaTrab(Nil,.F.)
   cKey:="Z1_CODCLI+Z1_PEDIDO"
   Indregua("ARQ",cIndex,ckey,,,"Indexando......")

   Do While .Not. Eof()
      #IFNDEF WINDOWS
         @ 10,05 SAY "Eliminando Duplicidade....." +StrZero(RECNO(),7)
      #ELSE
         MsProcTxt("Eliminando Duplicidade....."+Str(Recno(),7))
      #ENDIF
      mChave:=ARQ->Z1_CODCLI+ARQ->Z1_PEDIDO
      dbSkip()
      Do While ARQ->Z1_CODCLI+ARQ->Z1_PEDIDO==mChave
         dbDelete()
         dbSkip()
      Enddo
   Enddo

   dbSelectArea('SZ1')
   cFiltro:='Z1_CODPROM=="'+MV_PAR02+'".and. Z1_STATUSI<>"600"'
   cKey   := IndexKey()
   cInd   := CriaTrab(NIL,.f.)
   IndRegua("SZ1",cInd,cKey,,cFiltro,"Filtrando Pedidos...")
   dbGotop()
   Do While !Eof()
      #IFNDEF WINDOWS
         @ 10,05 SAY "Finalizando Ocorrencias...." +StrZero(RECNO(),7)
         @ 11,05 SAY "Ocorrencias finalizadas...." +StrZero(mConta2,7)
      #ELSE
         MsProcTxt("Finalizando Ocorrencias...."+Str(Recno(),7)+" Ocorrencias Finalizadas...."+Str(mConta2,7))
      #ENDIF
      dbSelectArea('ARQ')
      DbSeek(SZ1->Z1_CODCLI+SZ1->Z1_PEDIDO)
      If !Found()
         mConta2:=mConta2+1
         dbSelectArea('SZ1')
         Reclock("SZ1",.F.)
         REPLACE Z1_STATUS2 With '600'
         REPLACE Z1_STATUSI With '600'
         SZ1->(Msunlock())
      Endif
      dbSelectArea('SZ1')
      dbSkip()
   Enddo
   mteste:=0
   Do While .t.
      mteste:=mteste+1
      if mteste==1000
         exit
      else
         loop
      endif
   Enddo
   dbSelectArea('ARQ')
   dbGotop()
   Do While .Not. Eof()
      mAT:='N'
      Dbselectarea('SZ1')
      DbSeek(xFilial()+Arq->Z1_CODCLI)
      If Found()
         Do While SZ1->Z1_CODCLI==ARQ->Z1_CODCLI
            If SZ1->Z1_PEDIDO==ARQ->Z1_PEDIDO;
               .and. SZ1->Z1_STATUSI>='500';
               .and. SZ1->Z1_CODDEST==ARQ->Z1_CODDEST

               If SZ1->Z1_VENC1<>ARQ->Z1_Venc1;
                  .OR. SZ1->Z1_VENC2<>ARQ->Z1_Venc2;
                  .OR. SZ1->Z1_VENC3<>ARQ->Z1_Venc3;
                  .OR. SZ1->Z1_VENC4<>ARQ->Z1_Venc4;
                  .OR. SZ1->Z1_VENC5<>ARQ->Z1_Venc5;
                  .OR. SZ1->Z1_VENC6<>ARQ->Z1_Venc6;
                  .OR. SZ1->Z1_VENC7<>ARQ->Z1_Venc7
                  mStatus2:='700'
                  mObs3:='ALTERA€ÇO DE PARCELA EM ABERTO'
               Else
                  mStatus2:=SZ1->Z1_STATUS2
                  mObs3:=""
               Endif
               mConta1:=mConta1+1
               Reclock("SZ1",.F.)
               REPLACE Z1_Nome     With  ARQ->Z1_Nome
               REPLACE Z1_NDest    With  ARQ->Z1_NDest
               REPLACE Z1_End      With  ARQ->Z1_End
               REPLACE Z1_Bairro   With  ARQ->Z1_Bairro
               REPLACE Z1_MUN      With  ARQ->Z1_MUN
               REPLACE Z1_UF       With  ARQ->Z1_UF
               REPLACE Z1_CEP      With  ARQ->Z1_CEP
               REPLACE Z1_Fone     With  ARQ->Z1_Fone
               REPLACE Z1_Fax      With  ARQ->Z1_Fax
               REPLACE Z1_EMAIL    With  ARQ->Z1_EMAIL
               REPLACE Z1_Parc1    With  ARQ->Z1_Parc1
               REPLACE Z1_Parc2    With  ARQ->Z1_Parc2
               REPLACE Z1_Parc3    With  ARQ->Z1_Parc3
               REPLACE Z1_Parc4    With  ARQ->Z1_Parc4
               REPLACE Z1_Parc5    With  ARQ->Z1_Parc5
               REPLACE Z1_Parc6    With  ARQ->Z1_Parc6
               REPLACE Z1_Parc7    With  ARQ->Z1_Parc7
               REPLACE Z1_Venc1    With  ARQ->Z1_Venc1
               REPLACE Z1_Venc2    With  ARQ->Z1_Venc2
               REPLACE Z1_Venc3    With  ARQ->Z1_Venc3
               REPLACE Z1_Venc4    With  ARQ->Z1_Venc4
               REPLACE Z1_Venc5    With  ARQ->Z1_Venc5
               REPLACE Z1_Venc6    With  ARQ->Z1_Venc6
               REPLACE Z1_Venc7    With  ARQ->Z1_Venc7
               REPLACE Z1_parcela  with  ARQ->Z1_parcela
               REPLACE Z1_Vldupl   with  ARQ->Z1_Vldupl
               REPLACE Z1_obs3     with  mObs3+' '+ARQ->Z1_obs3
               REPLACE Z1_Status2  With  mStatus2
               REPLACE Z1_codprom  With  MV_PAR02
               SZ1->(Msunlock())
               mat:='S'
               Exit
            Endif
            DbSkip()
         Enddo
      Endif

      If mAT=='N'
         mConta:=mConta+1
         Reclock("SZ1",.t.)
         REPLACE Z1_Pedido   With  ARQ-> Z1_Pedido
         REPLACE Z1_CodCli   With  ARQ-> Z1_CodCli
         REPLACE Z1_CodDest  With  ARQ-> Z1_CodDest
         REPLACE Z1_CEP      With  ARQ-> Z1_CEP
         REPLACE Z1_Nome     With  ARQ-> Z1_Nome
         REPLACE Z1_NDest    With  ARQ-> Z1_NDest
         REPLACE Z1_End      With  ARQ-> Z1_End
         REPLACE Z1_Bairro   With  ARQ-> Z1_Bairro
         REPLACE Z1_MUN      With  ARQ-> Z1_MUN
         REPLACE Z1_UF       With  ARQ-> Z1_UF
         REPLACE Z1_Fone     With  ARQ-> Z1_Fone
         REPLACE Z1_Fax      With  ARQ-> Z1_Fax
         REPLACE Z1_EMAIL    With  ARQ-> Z1_EMAIL
         REPLACE Z1_Parc1    With  ARQ-> Z1_Parc1
         REPLACE Z1_Parc2    With  ARQ-> Z1_Parc2
         REPLACE Z1_Parc3    With  ARQ-> Z1_Parc3
         REPLACE Z1_Parc4    With  ARQ-> Z1_Parc4
         REPLACE Z1_Parc5    With  ARQ-> Z1_Parc5
         REPLACE Z1_Parc6    With  ARQ-> Z1_Parc6
         REPLACE Z1_Parc7    With  ARQ-> Z1_Parc7
         REPLACE Z1_Venc1    With  ARQ-> Z1_Venc1
         REPLACE Z1_Venc2    With  ARQ-> Z1_Venc2
         REPLACE Z1_Venc3    With  ARQ-> Z1_Venc3
         REPLACE Z1_Venc4    With  ARQ-> Z1_Venc4
         REPLACE Z1_Venc5    With  ARQ-> Z1_Venc5
         REPLACE Z1_Venc6    With  ARQ-> Z1_Venc6
         REPLACE Z1_Venc7    With  ARQ-> Z1_Venc7
         REPLACE Z1_CodProm  With  MV_PAR02
         REPLACE Z1_StatusI  With  '501'
         REPLACE Z1_DTOCORR  With  date()
         REPLACE Z1_parcela  with  ARQ->Z1_parcela
         REPLACE Z1_Vldupl   with  ARQ->Z1_Vldupl
         REPLACE Z1_obs3     with  ARQ->Z1_obs3
         SZ1->(Msunlock())
      Endif
      #IFNDEF WINDOWS
         @ 10,05 SAY "LENDO REGISTROS..................." +StrZero(RECNO(),7)
         @ 11,05 SAY "GRAVANDO.........................." +STR(MCONTA,7)
         @ 12,05 SAY "REGRAVANDO........................" +STR(MCONTA1,7)
      #ELSE
         MsProcTxt("Lendo Registros : "+Str(Recno(),7)+"  Regravando.... "+StrZero(mConta1,7)+"  Gravando...... "+StrZero(mConta,7))
      #ENDIF
      DbSelectArea('Arq')
      DbSkip()
   Enddo
   mteste:=0
   Do While .t.
      mteste:=mteste+1
      if mteste==1000
         exit
      else
         loop
      endif
   Enddo
Return
//ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Function  ³ _ValidPerg                                                    ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Descricao ³ Valida grupo de perguntas                                     ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ Observ.   ³                                                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _ValidPerg
Static Function _ValidPerg()

         _sAlias := Alias()
         DbSelectArea("SX1")
         DbSetOrder(1)
         cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
         aRegs:={}

         // Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

         AADD(aRegs,{cPerg,"01","Arq. de Trabalho:","mv_ch1","C",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","",""})
         AADD(aRegs,{cPerg,"02","Cod. A‡Æo ......:","mv_ch2","C",03,0,0,"G","","mv_par02","","","","","","","","","","","","","","","SZA"})
         For i:=1 to Len(aRegs)
             If !dbSeek(cPerg+aRegs[i,2])
                 RecLock("SX1",.T.)
                 For j:=1 to FCount()
                     If j <= Len(aRegs[i])
                         FieldPut(j,aRegs[i,j])
                     Endif
                 Next
                 SX1->(MsUnlock())
             Endif
         Next

         DbSelectArea(_sAlias)
Return

