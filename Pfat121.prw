#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
#IFNDEF WINDOWS
    #DEFINE PSAY SAY
#ENDIF

//Danilo C S Pala 20060327: dados de enderecamento do DNE
User Function Pfat121()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CDESC1,CDESC2,CDESC3,TITULO,CTITULO,ARETURN")
SetPrvt("CPROGRAMA,MHORA,CARQ,CSTRING,WNREL,CARQTEMP")
SetPrvt("NLASTKEY,L,NORDEM,M_PAG,NCARACTER,TAMANHO")
SetPrvt("CCABEC1,CCABEC2,LCONTINUA,MSAIDA,MVALIDA,CARQPATH")
SetPrvt("_CSTRING,CPERG,MCONTA,MCONTA1,MCONTA2,LEND")
SetPrvt("BBLOCO,CINDEX,CKEY,CMSG,CCHAVE,CFILTRO")
SetPrvt("CIND,MPEDIDO,MITEM,MCODCLI,MCODDEST,MPROD")
SetPrvt("MCF,MCEP,MVALOR,MNOMECLI,MDEST,MV_END")
SetPrvt("MMUN,MEST,MFONE,MCGC,MDTPG,MDTFAT")
SetPrvt("MDTPG2,MFILIAL,MBAIRRO,MPAGO,MPGTO,MPARC")
SetPrvt("MPARC1,MPARC2,MPARC3,MPARC4,MPARC5,MPARC6")
SetPrvt("MPARC7,MPARC8,MPARC9,MPARC10,MPARC11,MPARC12")
SetPrvt("MVENC1,MVENC2,MVENC3,MVENC4,MVENC5,MVENC6")
SetPrvt("MVENC7,MVENC8,MVENC9,MVENC10,MVENC11,MVENC12")
SetPrvt("MIT,MABERTO,MINADIMPL,MVEND,MEDVENC,MGRAVA")
SetPrvt("MDTVENC,MSITUAC,MREGIAO,MGRAT,MPARCELA,MDESCROP")
SetPrvt("MTIPOOP,MVLTOT,MCODREV,MEDSUSP,MEDINIC,MTITULO")
SetPrvt("MEMAIL,MFAX,MATIV,MFONE1,MCHAVE,MCHAVE2")
SetPrvt("MDTVEND,MEMABERTO,_ACAMPOS,_CNOME,_SALIAS,AREGS")
SetPrvt("I,J,")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     #DEFINE PSAY SAY
#ENDIF
/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: PFAT121   쿌utor: Raquel Ramalho         � Data:   17/11/00 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri놹o: Acompanhamento da inadimplencia                            � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento                                      � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
/*/

//旼컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� MV_PAR01 � Regiao De            ?                         �
//� MV_PAR02 � Regiao Ate           ?                         �
//� MV_PAR03 � Vendedor De          ?                         �
//� MV_PAR04 � Vendedor Ate         ?                         �
//� MV_PAR05 � Faturados De         ?                         �
//� MV_PAR06 � Faturados At�        ?                         �
//� MV_PAR07 � Produto De           ?                         �
//� MV_PAR08 � Produto At�          ?                         �
//� MV_PAR09 � Cep De               ?                         �
//� MV_PAR10 � Cep At�              ?                         �
//� MV_PAR11 � Gera                 ? Arquivo Relat줿io       �
//� MV_PAR12 � Dias de atraso       ?                         �
//� MV_PAR13 � A눯o/Promo눯o        ?                         �
//� MV_PAR14 � Tipo venda           ?  Mercantil Publicidade  �
//읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

#IFNDEF WINDOWS
    ScreenDraw("SMT050", 3, 0, 0, 0)
    SetCursor(1)
    SetColor("B/BG")
#ENDIF

cDesc1    :=PADC("Este programa ira gerar o arquivo de clientes inadimplentes" ,74)
cDesc2    :=PADC("em relat줿io" ,74)
cDesc3    :=""
Titulo    :=PADC("RELAT�RIO DE INADIMPLENTES",74)
cTitulo   :=" **** CLIENTES INADIMPLENTES **** "
aReturn   := { "Especial", 1,"Administra눯o", 1, 2, 1,"",1 }
cPrograma :="PFA121"
mHora     :=TIME()
cArq      :=SUBS(cUsuario,7,3)+SUBS(mHora,1,2)+SUBS(mHora,7,2)
cString   :=SUBS(cUsuario,7,3)+SUBS(mHora,1,2)+SUBS(mHora,7,2)
wnrel     :=SUBS(cUsuario,7,3)+SUBS(mHora,1,2)+SUBS(mHora,7,2)
cArqTemp  :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
nLastKey  := 00
L         := 00
nOrdem    := 00
m_pag     := 01
nCaracter := 10
tamanho   := "P"
cCabec1   := ""
cCabec2   := ""
lContinua := .T.
mSaida    :="2"
mValida   :=""
cArqPath  :=GetMv("MV_PATHTMP")
_cString  :=cArqPath+cString+".DBF"


cPerg:="PFT121"
_ValidPerg()

If !Pergunte(cPerg)
   Return
Endif

IF Lastkey()==27
   Return
Endif

mConta    :=0
mConta1   :=0
mConta2   :=0

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Valida gera눯o do mailing  - Verifica promo눯o               �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

#IFNDEF WINDOWS
    F_VERSZA()
    IF mValida=='N'
       RETURN
    Else
       F_AtuZZ7()
    ENDIF
#ELSE
    F_VERSZA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>     Execute(F_VERSZA)
    IF mValida=='N'
       RETURN
    Else
       F_AtuZZ7()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        Execute(F_AtuZZ7)
    ENDIF
#ENDIF

FArqTrab()

#IFNDEF WINDOWS
    DrawAdvWin(" AGUARDE  - PROCESSANDO ARQUIVO DE TRABALHO... " , 8, 0, 15, 75 )
    FILTRA()
    PRODUTOS()               // para funcionar a partir do SC6.
#ELSE
     lEnd:= .F.
     bBloco:= { |lEnd| FILTRA()  }// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>      bBloco:= { |lEnd| Execute(FILTRA)  }
     bBloco:= { |lEnd| PRODUTOS()  }// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>      bBloco:= { |lEnd| Execute(PRODUTOS)  }
     MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
#ENDIF

DbSelectArea(cArq)
cIndex := CriaTrab(Nil,.F.)
cKey   := "Z1_CEP+Z1_NOME+Z1_NDEST+Z1_CODCLI+Z1_CODDEST"
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")
dbGoTop()


//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Grava arquivo dbf                                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

If MV_PAR11==1
   cMsg:= "Arquivo Gerado com Sucesso em: "+_cString
   #IFNDEF WINDOWS
      DrawAdvWin(" AGUARDE  - COPIANDO ARQUIVO   " , 8, 0, 15, 75 )
      DbSelectArea(cArq)
      dbGoTop()
      COPY TO &_cString VIA "DBFCDXADS" // 20121106 
      ALERT(cMsg)
   #ELSE
      MsAguarde("Aguarde" ,"Copinado Arquivo...", .T. )
      DbSelectArea(cArq)
      dbGoTop()
      COPY TO &_cString VIA "DBFCDXADS" // 20121106 
      MSGINFO(cMsg)
   #ENDIF
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Relatorio                                                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

If MV_PAR11==2
   wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)
   SetDefault(aReturn,cString)

   If nLastKey == 27
      DbSelectArea(cArq)
      DbCloseArea()
      Return
   Endif

   #IFNDEF WINDOWS
       Relatorio()
   #ELSE
       RptStatus( {||Relatorio()} )// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>        RptStatus( {||Execute(Relatorio)} )
   #ENDIF
EndIf


//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Retorna indices originais...                                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

DbSelectArea(cArq)
DbCloseArea()
DbSelectArea("SC6")
Retindex("SC6")
DbSelectArea("SC5")
Retindex("SC5")
DbSelectArea("SA1")
Retindex("SA1")
DbSelectArea("SZO")
Retindex("SZO")
DbSelectArea("SZN")
Retindex("SZN")
DbSelectArea("SE1")
Retindex("SE1")
DbSelectArea("SB1")
Retindex("SB1")
DbSelectArea("SA3")
Retindex("SA3")
DbSelectArea("SZA")
Retindex("SZA")
DbSelectArea("SX5")
Retindex("SX5")
DbSelectArea("ZZ7")
Retindex("ZZ7")
DbSelectArea("SZ9")
Retindex("SZ9")

Return


//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � Filtra()                                                      �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Filtra arquivo SC6 para ser utilizado no programa.            �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function FILTRA
Static Function FILTRA()

DbSelectArea("SC6")
         IF MV_PAR14==1
            DbGoTop()
            cChave :=IndexKey()
            cFiltro:='DTOS(C6_DATA)>="'+DTOS(MV_PAR05)+'" .AND. DTOS(C6_DATA)<="'+DTOS(MV_PAR06)+'"'
            cFiltro:=Alltrim(cFiltro)+'.AND.C6_PRODUTO>="'+MV_PAR07+'".AND.C6_PRODUTO<="'+MV_PAR08+'"'
            cInd   :=CriaTrab(NIL,.f.)
            IndRegua("SC6",cInd,cChave,,cFiltro,"Filtrando Itens de Pedidos...")
         ENDIF

         IF MV_PAR14==2
            DbGoTop()
            cChave :=IndexKey()
            cFiltro:='DTOS(C6_DATA)>="'+DTOS(MV_PAR05)+'" .AND. DTOS(C6_DATA)<="'+DTOS(MV_PAR06)+'"'
            cFiltro:=Alltrim(cFiltro)+'.AND.C6_PRODUTO>="'+MV_PAR07+'".AND.C6_PRODUTO<="'+MV_PAR08+'"'
            cFiltro:=Alltrim(cFiltro)+'.AND.SUBS(C6_NUM,6,1)=="P"'
            cInd   :=CriaTrab(NIL,.f.)
            IndRegua("SC6",cInd,cChave,,cFiltro,"Filtrando Itens de Pedidos...")
         ENDIF
Return

//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � PRODUTOS()                                                    �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Realiza leitura dos registros do SC6 ja filtrado e aplica     �
//�           � restante dos filtros de parametros. Prepara os dados para     �
//�           � serem gravados. Faz chamada a funcao GRAVA.                   �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   �                                                               �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function PRODUTOS
Static Function PRODUTOS()
         DbSelectArea("SC6")
         DbGoTop()
         Do While !EOF()
            #IFNDEF WINDOWS
               @ 10,05 SAY "LENDO REGISTROS......." +STR(RECNO(),7)
            #ELSE
               MsProcTxt("Lendo Registros : "+Str(Recno(),7)+"  Gravando...... "+StrZero(mConta1,7))
            #ENDIF

            IF ALLTRIM(SC6->C6_CLI) == "040000"
               DbSkip()
               Loop
            ENDIF

            If MV_PAR11==1
               DbSelectArea(cArq)
               DbSeek(SC6->C6_NUM)
               If Found()
                  DbSelectArea("SC6")
                  DbSkip()
                  Loop
               Endif
            Endif

            mPedido := ""
            mItem   := ""
            mCodCli := ""
            mCodDest:= ""
            mProd   := ""
            mCF     := ""
            mCEP    := ""
            mValor  := 0
            mNomeCli:= ""
            mDest   := ""
            mV_End    := ""
            mMun    := ""
            mEst    := ""
            mFone   := ""
            mCGC    := ""
            mDTPG   := stod("")
            mDTFat  := stod("")
            mDTPG2  := stod("")
            mFilial := ""
            mBairro := ""
            mPago   := 0
            mPgto   := 0
            mParc   := 0
            mParc1  := 0
            mParc2  := 0
            mParc3  := 0
            mParc4  := 0
            mParc5  := 0
            mParc6  := 0
            mParc7  := 0
            mParc8  := 0
            mParc9  := 0
            mParc10 := 0
            mParc11 := 0
            mParc12 := 0
            mVenc1  := stod("")
            mVenc2  := stod("")
            mVenc3  := stod("")
            mVenc4  := stod("")
            mVenc5  := stod("")
            mVenc6  := stod("")
            mVenc7  := stod("")
            mVenc8  := stod("")
            mVenc9  := stod("")
            mVenc10  := stod("")
            mVenc11 := stod("")
            mVenc12 := stod("")
            mit     := 0
            mAberto := 0
            mInadimpl:=0
            mVend   :=""
            mEdvenc :=""
            mGrava  :=""
            mDtVenc :=stod("")
            mSituac :=""
            mRegiao :=""
            mGrat   :=""
            mParcela:=""
            mDescrop:=""
            mTipoop :=""
            mVltot :=0

            mProd   := SC6->C6_PRODUTO
            mCodRev := SUBS(SC6->C6_PRODUTO,1,4)
            mDTFat  := SC6->C6_DATFAT
            mCodCli := SC6->C6_CLI
            mPedido := SC6->C6_NUM
            mItem   := SC6->C6_ITEM
            mValor  := SC6->C6_VALOR
            mCF     := ALLTRIM(SC6->C6_CF)
            mCodDest:= SC6->C6_CODDEST
            mFilial := SC6->C6_FILIAL
            mEdvenc := SC6->C6_EDVENC
            mEdsusp := SC6->C6_EDSUSP
            mEdinic := SC6->C6_EDINIC
            mSituac := SC6->C6_SITUAC

            If MV_PAR14==1
               If 'P' $(SC6->C6_NUM)
                  DbSkip()
                  Loop
               EndIf
            Endif

            If MV_PAR14==2
               If ! 'P' $(SC6->C6_NUM)
                  DbSkip()
                  Loop
               EndIf
            Endif

            DbSelectArea ("SC5")
            DbGoTop()
            DbSeek(xFilial("SC5")+mPedido)

            If Found()
               mVend:= C5_VEND1
               mTipoop:=C5_TIPOOP
            Endif

            DbSelectArea("SZ9")
            DbSeek(xFilial("SZ9")+mTipoop,.T.)
            If Found()
               mDescrop:=SZ9->Z9_DESCR
            Endif

            DbSelectArea("SA3")
            DbSeek(xFilial("SA3")+mVend)
            If Found()
               mRegiao:=A3_REGIAO
            Endif

            If mRegiao < MV_PAR01 .OR. mRegiao > MV_PAR02
               DbSelectArea("SC6")
               DbSkip()
               Loop
            Endif

            If mVend < MV_PAR03 .OR. mVend > MV_PAR04
               DbSelectArea("SC6")
               DbSkip()
               Loop
            Endif

            //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
            //� Verifica se � cortesia                                       �
            //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

            DbSelectArea("SF4")
            DbSetOrder(1)
            DbGoTop()
            DbSeek(xFilial("SF4")+SC6->C6_TES)
            If SF4->F4_DUPLIC=='N' .OR. 'CORTESIA' $(F4_TEXTO) .OR. 'DOA��O' $(F4_TEXTO) .OR. 'DOACAO' $(F4_TEXTO)
               mGrat:='S'
            EndIf

            If '99' $(mCF)
               mGrat:='S'
            Endif

            If mGrat=='S'
               DbSelectArea("SC6")
               DbSkip()
               Loop
            Endif

            DbSelectArea("SE1")
			DbOrderNickName("E1_PEDIDO") //dbSetOrder(27) 20130225  ///dbSetOrder(15) AP5  //20090114 era(21)//20090723 mp10 era(22) //dbSetOrder(26) 20100412
            DbGoTop()
            DbSeek(xFilial("SE1")+mPedido)

            If Found()

               Do while ( SE1->E1_PEDIDO == MPEDIDO )
                  mParc := mParc+1
                  mDTPG:= SE1->E1_BAIXA

                  If SUBS(ALLTRIM(SE1->E1_MOTIVO),1,3)=='CAN'
                     Dbskip()
                     Loop
                  Endif

                  If mv_par14==2
                     If SE1->E1_VENCTO>DATE()
                        Dbskip()
                        Loop
                     Endif
                  Endif

                  mVltot:=SE1->E1_VALOR+mVltot

                  If !Empty(MDTPG) .And. E1_SALDO==0;
                     .AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,2)<>'LP';
                     .AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,3)<>'CAN';
                     .AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,3)<>'DEV'
                     mPago:=mPago+1
                   Else
                      If SE1->E1_VENCTO<=DATE()-MV_PAR12
                         mAberto:=mAberto+1
                         mit:=mit+1
                         Do Case
                            Case mit==1
                              mParc1:=SE1->E1_VALOR
                              mvenc1:=SE1->E1_VENCTO
                              mParcela:=SE1->E1_PARCELA
                            Case mit==2
                              mParc2:=SE1->E1_VALOR
                              mvenc2:=SE1->E1_VENCTO
                              mParcela:=SE1->E1_PARCELA
                            Case mit==3
                              mParc3:=SE1->E1_VALOR
                              mvenc3:=SE1->E1_VENCTO
                              mParcela:=SE1->E1_PARCELA
                            Case mit==4
                              mParc4:=SE1->E1_VALOR
                              mvenc4:=SE1->E1_VENCTO
                              mParcela:=SE1->E1_PARCELA
                            Case mit==5
                              mParc5:=SE1->E1_VALOR
                              mvenc5:=SE1->E1_VENCTO
                              mParcela:=SE1->E1_PARCELA
                            Case mit==6
                              mParc6:=SE1->E1_VALOR
                              mvenc6:=SE1->E1_VENCTO
                              mParcela:=SE1->E1_PARCELA
                            Case mit==7
                              mParc7:=SE1->E1_VALOR
                              mvenc7:=SE1->E1_VENCTO
                              mParcela:=SE1->E1_PARCELA
                            Case mit==8
                              mParc8:=SE1->E1_VALOR
                              mvenc8:=SE1->E1_VENCTO
                              mParcela:=SE1->E1_PARCELA
                            Case mit==9
                              mParc9:=SE1->E1_VALOR
                              mvenc9:=SE1->E1_VENCTO
                              mParcela:=SE1->E1_PARCELA
                            Case mit==10
                              mParc10:=SE1->E1_VALOR
                              mvenc10:=SE1->E1_VENCTO
                              mParcela:=SE1->E1_PARCELA
                            Case mit==11
                              mParc11:=SE1->E1_VALOR
                              mvenc11:=SE1->E1_VENCTO
                              mParcela:=SE1->E1_PARCELA
                            Case mit==12
                              mParc12:=SE1->E1_VALOR
                              mvenc12:=SE1->E1_VENCTO
                              mParcela:=SE1->E1_PARCELA
                         EndCase
                      Endif
                      If SE1->E1_VENCTO+30<=DATE()
                         mInadimpl:=mInadimpl+1
                      Endif
                  Endif
                  DbSkip()
               Enddo
            Else
                mAberto:=0
                mPgto  :=0
                mInadimpl:=0
            Endif

            If mVltot==0
               DbSelectArea("SC6")
               Dbskip()
               Loop
            Endif

            If MV_PAR12<>0
               If mInadimpl==0 .AND. mAberto==0
                  DbSelectArea("SC6")
                  DbSkip()
                  Loop
               Endif
            Endif

            #IFNDEF WINDOWS
                Grava()
            #ELSE
                GRAVA()// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==>                 Execute(GRAVA)
            #ENDIF

            DbSelectArea("SC6")

            If EOF()
               Exit
            Else
               DbSkip()
            Endif

         End-While

Return


//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � GRAVA()                                                       �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Realiza gravacao dos registros ideais (conforme parametros)   �
//�           � para impressao de Relatorio.                                  �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   �                                                               �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function GRAVA
Static Function GRAVA()

         DbSelectArea("SB1")
         DbSeek(xFilial("SB1")+mProd)
         If Found()
            mTitulo:=SB1->B1_TITULO
         Else
            mTitulo:="  "
         Endif

         DbSelectArea("SA1")
         DbGoTop()
         DbSeek(xFilial("SA1")+mCodCli)
         If found()
            mNomeCli := SA1->A1_NOME
            mV_End     := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060327
            mBairro  := SA1->A1_BAIRRO
            mMun     := SA1->A1_MUN
            mEst     := SA1->A1_EST
            mCEP     := SA1->A1_CEP
            mFone    := SA1->A1_TEL
            mDest    := SPACE(40)
            mCGC     := SA1->A1_CGC
            mFone    := SA1->A1_TEL
            mEmail   := SA1->A1_EMAIL
            mFax     := SA1->A1_FAX
            mAtiv    := SA1->A1_ATIVIDA
         Else
            mNomeCli := SPACE(40)
         Endif

         If mNomeCli<>"  "
            If mCodDest#" "

               DbSelectArea("SZN")
               DbSeek(xFilial("SZN")+mCodCli+mCodDest)

               If Found()
                  mDest:= SZN->ZN_NOME
               Endif

               DbSelectArea("SZO")
               DbSeek(xFilial("SZO")+mCodCli+mCodDest)

               If Found()

                  mV_End    := ALLTRIM(SZO->ZO_TPLOG) + " " + ALLTRIM(SZO->ZO_LOGR) + " " + ALLTRIM(SZO->ZO_NLOGR) + " " + ALLTRIM(SZO->ZO_COMPL) //20060327
                  mBairro := SZO->ZO_BAIRRO
                  mMun    := SZO->ZO_CIDADE
                  mEst    := SZO->ZO_ESTADO
                  mCEP    := SZO->ZO_CEP
                  mFone1  := SZO->ZO_FONE

                  If mFone1 <> "  "
                     mFone:= mFone1
                  Endif

               Endif

            Endif

         Endif

         mConta1:= mConta1+1

         #IFNDEF WINDOWS
            @ 11,05 SAY "GRAVANDO.............." +STR(MCONTA1,7)
         #ENDIF

         DbSelectArea(cArq)
         RecLock(cArq,.T.)
         REPLACE Z1_Pedido   With  mPedido
         REPLACE Z1_Item     With  mItem
         REPLACE Z1_CodCli   With  mCodCli
         REPLACE Z1_CodDest  With  mCodDest
         REPLACE Z1_Codprod  With  mProd
         REPLACE Z1_CF       With  mCF
         REPLACE Z1_CEP      With  mCEP
         REPLACE Z1_Valor    With  mValor
         REPLACE Z1_Nome     With  mNomeCli
         REPLACE Z1_NDest    With  mDest
         REPLACE Z1_End      With  mV_End
         REPLACE Z1_Bairro   With  mBairro
         REPLACE Z1_MUN      With  mMun
         REPLACE Z1_UF       With  mEst
         REPLACE Z1_Fone     With  mFone
         REPLACE Z1_Fax      With  mFax
         REPLACE Z1_EMAIL    With  mEMAIL
         REPLACE Z1_CGC      With  mCGC
         REPLACE Z1_DTPGTO   With  mDTPG
         REPLACE Z1_DTFAT    With  mDTFAT
         REPLACE Z1_PGTO     With  mPGTO
         REPLACE Z1_Emaberto With  mAberto
         REPLACE Z1_Parcela  With  mParc
         REPLACE Z1_Inadimpl With  mInadimpl
         REPLACE Z1_Descr    With  mTitulo
         REPLACE Z1_Vend     With  mVend
         REPLACE Z1_Parc1    With  mParc1
         REPLACE Z1_Parc2    With  mParc2
         REPLACE Z1_Parc3    With  mParc3
         REPLACE Z1_Parc4    With  mParc4
         REPLACE Z1_Parc5    With  mParc5
         REPLACE Z1_Parc6    With  mParc6
         REPLACE Z1_Parc7    With  mParc7
         REPLACE Z1_Parc8    With  mParc8
         REPLACE Z1_Parc9    With  mParc9
         REPLACE Z1_Parc10   With  mParc10
         REPLACE Z1_Parc11   With  mParc11
         REPLACE Z1_Parc12   With  mParc12
         REPLACE Z1_Venc1    With  mVenc1
         REPLACE Z1_Venc2    With  mVenc2
         REPLACE Z1_Venc3    With  mVenc3
         REPLACE Z1_Venc4    With  mVenc4
         REPLACE Z1_Venc5    With  mVenc5
         REPLACE Z1_Venc6    With  mVenc6
         REPLACE Z1_Venc7    With  mVenc7
         REPLACE Z1_Venc8    With  mVenc8
         REPLACE Z1_Venc9    With  mVenc9
         REPLACE Z1_Venc10   With  mVenc10
         REPLACE Z1_Venc11   With  mVenc11
         REPLACE Z1_Venc12   With  mVenc12
         REPLACE Z1_StatusI  With  '501'
         REPLACE Z1_Parc     with mParcela
         REPLACE Z1_Vldupl   with  mVltot
         REPLACE Edvenc      With  mEdvenc
         REPLACE Edinic      With  mEdinic
         REPLACE Edsusp      With  mEdsusp
         REPLACE Situac      with  Msituac
         REPLACE Tipoop      With  mTipoop
         REPLACE Descrop     With  mDescrop
         cArq->(MsUnlock())
Return

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION IMPR3
Static FUNCTION IMPR3()
   IF L<>0
      IF L==64 .OR. L+10>=64
         L:=0
      ELSE
         L:=L+1
      ENDIF
   ENDIF
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION IMPR4
Static FUNCTION IMPR4()
   IF L<>0
      IF L==64
         L:=0
      ELSE
         L:=L+1
      ENDIF
   ENDIF
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION IMPR2
Static FUNCTION IMPR2()
  IF L==0
     L:=L+1
     CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho,nCaracter)
     L:=4
     @ L,00 PSAY REPLICATE('*',79)
     L:=L+2
  ENDIF
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION CABEC2
Static FUNCTION CABEC2()
  @ L,01 PSAY 'EM ABERTO / TITULO'
  @ L,27 PSAY 'PEDIDO'
  @ L,34 PSAY 'ITEM'
  @ L,39 PSAY 'SUSP'
  @ L,44 PSAY 'ED.INI'
  @ L,51 PSAY 'ED.VENC'
  @ L,59 PSAY 'VENC/FAT'
  @ L,68 PSAY 'VALOR'
  @ L,75 PSAY 'VEND'
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION EXTRATO
Static FUNCTION EXTRATO()
  @ L,01 PSAY LTRIM(STR(MINADIMPL,1))+'/'+LTRIM(STR(MPARCELA,1))+' '+SUBS(TRIM(mTitulo),1,25)
  @ L,27 PSAY TRIM(mPedido)
  @ L,34 PSAY TRIM(mItem)
  @ L,39 PSAY STR(mEdsusp,4)
  @ L,44 PSAY STR(mEdinic,4)
  @ L,51 PSAY STR(mEdvenc,4)
  @ L,59 PSAY mDtvenc
  @ L,68 PSAY LTRIM(STR(mValor,7,2))
  @ L,75 PSAY TRIM(mVend)
RETURN

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> FUNCTION RELATORIO
Static FUNCTION RELATORIO()
  MCONTA:=0
  DBSELECTAREA(cArq)
  SETREGUA(RECCOUNT())
  DBGOTOP()
  DO WHILE .NOT. EOF()
     MCONTA:=MCONTA+1
     IncRegua()
     IMPR3()
     IMPR2()
     DBSELECTAREA(cArq)
     MCHAVE  :=CODCLI+CODDEST
     MCHAVE2 :=CODCLI+CODDEST
     @ L,01   PSAY 'COD CLI...: '+CODCLI
     @ L,27   PSAY 'COD DEST..: '+CODDEST
     @ L,54   PSAY 'FONE....:'   +TRIM(FONE)
     @ L+1,01 PSAY 'NOME......: '+NOME
     @ L+1,54 PSAY 'CPF/CGC.:'   +TRIM(CGC)
     @ L+2,01 PSAY 'DEST......: '+NDEST
     @ L+3,01 PSAY 'ENDERECO..: '+V_END
     @ L+3,54 PSAY 'BAIRRO..:'   +BAIRRO
     @ L+4,01 PSAY 'CIDADE/EST: '+TRIM(MUN)+' '+UF
     @ L+4,57 PSAY 'EMAIL...:'   +MEMAIL
     @ L+5,01 PSAY 'CEP.......: '+SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)
     L:=L+6
     CABEC2()
     DO WHILE MCHAVE2==MCHAVE
        DBSELECTAREA(cArq)
        IMPR4()
        IMPR2()
        IF L==0
           CABEC2()
           L:=L+1
        ENDIF

        mEdsusp:=" "
        mEdvenc:=" "
        mEdinic:=" "
        mDtvend:=" "
        mSituac:=SITUAC
        mPedido:=PEDIDO
        mItem  :=ITEM
        mEdvenc:=EDVENC
        mEdinic:=EDINIC
        mEdsusp:=EDSUSP
        mCodrev:=Subs(CODPROD,1,4)
        mValor :=VALOR
        mTitulo:=TRIM(SUBS(CODPROD,1,10))+' '+TRIM(SUBS(DESCR,1,10))
        mVend  :=VEND
        mDtfat :=DTFAT
        mEmaberto:=EMABERTO
        mParcela :=PARCELA
        mInadimpl:=INADIMPL
        mEmail   :=EMAIL

        DbSelectArea ("SZJ")
        DbGoTop()
        DbSeek(xFilial("SZJ")+mCodRev+Str(MEDVENC,4))
        If Found()
           mDtvenc:=SZJ->ZJ_DTCIRC
        else
           mDtvenc:=mDtfat
        Endif
        EXTRATO()
        DBSELECTAREA(cArq)
        IF EOF()
          EXIT
        ELSE
          DBSELECTAREA(cArq)
          DBSKIP()
          MCHAVE2 :=CODCLI+CODDEST
          IF MCHAVE2<>MCHAVE
             IF L<>0
                L:=L+1
                @ L,00 SAY REPLICATE('_',79)
             ENDIF
             IMPR2()
             EXIT
          ENDIF
          LOOP
        ENDIF
     ENDDO
     IF EOF()
        IMPR3()
        @ L+3,00 PSAY 'TOTAL DE REGISTROS.....'+STR(MCONTA1,7,0)
        @ L+4,00 PSAY 'TOTAL DE CLIENTES......'+STR(MCONTA,7,0)
        EXIT
     ENDIF
  ENDDO
   //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
   //� Termino do Relatorio                                         �
   //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
   SET DEVI TO SCREEN
   IF aRETURN[5] == 1
     Set Printer to
     dbcommitAll()
     ourspool(WNREL)
   ENDIF
   MS_FLUSH()
RETURN


//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � FARQTRAB()                                                    �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Cria arquivo de trabalho para guardar registros que serao     �
//�           � impressos em forma de etiquetas.                              �
//�           � serem gravados. Faz chamada a funcao GRAVA.                   �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   �                                                               �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function FARQTRAB
Static Function FARQTRAB()

         _aCampos := {}
         AADD(_aCampos,{"Z1_PEDIDO","C",6,0})
         AADD(_aCampos,{"Z1_ITEM","C",2,0})
         AADD(_aCampos,{"Z1_CF","C",5,0})
         AADD(_aCampos,{"Z1_CODCLI","C",6,0})
         AADD(_aCampos,{"Z1_CODDEST","C",6,0})
         AADD(_aCampos,{"Z1_NOME","C",40,0})
         AADD(_aCampos,{"Z1_NDEST","C",40,0})
         AADD(_aCampos,{"Z1_END","C",120,0})
         AADD(_aCampos,{"Z1_BAIRRO","C",20,0})
         AADD(_aCampos,{"Z1_MUN","C",20,0})
         AADD(_aCampos,{"Z1_UF","C",2,0})
         AADD(_aCampos,{"Z1_CEP","C",8,0})
         AADD(_aCampos,{"Z1_CGC","C",14,0})
         AADD(_aCampos,{"Z1_FONE","C",20,0})
         AADD(_aCampos,{"Z1_FAX","C",20,0})
         AADD(_aCampos,{"Z1_EMAIL","C",20,0})
         AADD(_aCampos,{"Z1_CODPROD" ,"C",15,0})
         AADD(_aCampos,{"Z1_DESCR","C",40,0})
         AADD(_aCampos,{"Z1_DTPGTO","D",8,0})
         AADD(_aCampos,{"Z1_DTFAT ","D",8,0})
         AADD(_aCampos,{"Z1_VALOR","N",12,2})
         AADD(_aCampos,{"Z1_PARC1","N",12,2})
         AADD(_aCampos,{"Z1_PARC2","N",12,2})
         AADD(_aCampos,{"Z1_PARC3","N",12,2})
         AADD(_aCampos,{"Z1_PARC4","N",12,2})
         AADD(_aCampos,{"Z1_PARC5","N",12,2})
         AADD(_aCampos,{"Z1_PARC6","N",12,2})
         AADD(_aCampos,{"Z1_PARC7","N",12,2})
         AADD(_aCampos,{"Z1_PARC8","N",12,2})
         AADD(_aCampos,{"Z1_PARC9","N",12,2})
         AADD(_aCampos,{"Z1_PARC10","N",12,2})
         AADD(_aCampos,{"Z1_PARC11","N",12,2})
         AADD(_aCampos,{"Z1_PARC12","N",12,2})
         AADD(_aCampos,{"Z1_VLDUPL","N",12,2})
         AADD(_aCampos,{"Z1_VENC1","D",08,0})
         AADD(_aCampos,{"Z1_VENC2","D",08,0})
         AADD(_aCampos,{"Z1_VENC3","D",08,0})
         AADD(_aCampos,{"Z1_VENC4","D",08,0})
         AADD(_aCampos,{"Z1_VENC5","D",08,0})
         AADD(_aCampos,{"Z1_VENC6","D",08,0})
         AADD(_aCampos,{"Z1_VENC7","D",08,0})
         AADD(_aCampos,{"Z1_VENC8","D",08,0})
         AADD(_aCampos,{"Z1_VENC9","D",08,0})
         AADD(_aCampos,{"Z1_VENC10","D",08,0})
         AADD(_aCampos,{"Z1_VENC11","D",08,0})
         AADD(_aCampos,{"Z1_VENC12","D",08,0})
         AADD(_aCampos,{"Z1_PGTO","N",5,2})
         AADD(_aCampos,{"Z1_EMABERTO","N",5,0})
         AADD(_aCampos,{"Z1_INADIMPL","N",5,0})
         AADD(_aCampos,{"Z1_PARCELA","N",5,0})
         AADD(_aCampos,{"Z1_VEND","C",6,0})
         AADD(_aCampos,{"Z1_STATUSI","C",3,0})
         AADD(_aCampos,{"Z1_PARC","C",1,0})
         AADD(_aCampos,{"EDVENC","N",4,0})
         AADD(_aCampos,{"EDINIC","N",4,0})
         AADD(_aCampos,{"EDSUSP","N",4,0})
         AADD(_aCampos,{"SITUAC","C",2,0})
         AADD(_aCampos,{"TIPOOP","C",2,0})
         AADD(_aCampos,{"DESCROP","C",50,0})

         If MV_PAR11==2
            _cNome := CriaTrab(_aCampos,.t.)
            cIndex := CriaTrab(Nil,.F.)
            cKey   := "Z1_CodCli+Z1_CodDEst"
         Endif

         If MV_PAR11==1
            _cNome := CriaTrab(_aCampos,.t.)
            cIndex := CriaTrab(Nil,.F.)
            cKey   := "Z1_PEDIDO"
         Endif

         dbUseArea(.T.,, _cNome,cArq,.F.,.F.)
         dbSelectArea(cArq)
         Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")
Return

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function F_VERSZA
Static Function F_VERSZA()
     DBSELECTAREA("SZA")
     DBGOTOP()
     DBSEEK(XFILIAL()+MV_PAR13)
     IF !FOUND()
        #IFNDEF WINDOWS
            ALERT("Promo눯o n�o cadastrada")
            ALERT("Entrar em contato com depto de Cadastro")
        #ELSE
           MsgStop("Promo눯o n�o cadastrada")
           MsgStop("Entrar em contato com depto de Cadastro")
        #ENDIF
        mValida:="N"
     ELSE
       DBSELECTAREA('SX5')
       DBGOTOP()
       DBSEEK(XFILIAL()+'91'+'931')
       IF !FOUND()
         #IFNDEF WINDOWS
            ALERT("Mailing n�o cadastrado")
            ALERT("Entrar em contato com depto de Marketing")
         #ELSE
            MsgStop("Mailing n�o cadastrado")
            MsgStop("Entrar em contato com depto de Marketing")
         #ENDIF
         mValida:="N"
       ELSE
         mValida:="S"
       ENDIF
     ENDIF
Return
//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � F_AtuZZ7                                                      �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Atualiza arquivo de controle de utilizacao.                   �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   �                                                               �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function F_AtuZZ7
Static Function F_AtuZZ7()
         DbSelectArea("ZZ7")
         RecLock("ZZ7",.T.)
         REPLACE ZZ7_CODPRO With MV_PAR13
         REPLACE ZZ7_CODMAI With '931'
         REPLACE ZZ7_USUAR  With Subs(cUsuario,7,15)
         REPLACE ZZ7_DATA   With Date()
         REPLACE ZZ7_QTDE   With mConta1
         REPLACE ZZ7_SAIDA  With STR(MV_PAR11,1)
         REPLACE ZZ7_PROD1  With MV_PAR07
         REPLACE ZZ7_PROD2  With MV_PAR08
         REPLACE ZZ7_CEP1   With MV_PAR09
         REPLACE ZZ7_CEP2   With MV_PAR10
         ZZ7->(MsUnLock())
Return

//旼컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Function  � _ValidPerg                                                    �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Descricao � Valida grupo de perguntas                                     �
//쳐컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Observ.   �                                                               �
//읕컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _ValidPerg
Static Function _ValidPerg()

         _sAlias := Alias()
         DbSelectArea("SX1")
         DbSetOrder(1)
         cPerg := PADR(cPerg,6)
         aRegs:={}

         // Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

         AADD(aRegs,{cPerg,"01","Regiao de .........:","mv_ch1","C",03,0,0,"G","","mv_par01","","0108001","","","","","","","","","","","","","ZZ9"})
         AADD(aRegs,{cPerg,"02","Regiao at�.........:","mv_ch2","C",03,0,0,"G","","mv_par02","","0108003","","","","","","","","","","","","","ZZ9"})
         AADD(aRegs,{cPerg,"03","Vendedor de........:","mv_ch3","C",06,0,0,"G","","mv_par03","","0108001","","","","","","","","","","","","","SA3"})
         AADD(aRegs,{cPerg,"04","Vendedor at�.......:","mv_ch4","C",06,0,0,"G","","mv_par04","","0108003","","","","","","","","","","","","","SA3"})
         AADD(aRegs,{cPerg,"05","Faturados de.......:","mv_ch5","D",08,0,0,"G","","mv_par05","","'01/06/99'","","","","","","","","","","","","",""})
         AADD(aRegs,{cPerg,"06","Faturados at�......:","mv_ch6","D",08,0,0,"G","","mv_par06","","'17/04/00'","","","","","","","","","","","","",""})
         AADD(aRegs,{cPerg,"07","Produto de.........:","mv_ch7","C",15,0,0,"G","","mv_par07","","0108001","","","","","","","","","","","","","SB1"})
         AADD(aRegs,{cPerg,"08","Produto at�........:","mv_ch8","C",15,0,0,"G","","mv_par08","","0108003","","","","","","","","","","","","","SB1"})
         AADD(aRegs,{cPerg,"09","Cep de.............:","mv_ch9","C", 8,0,0,"G","","mv_par09","","00000000","","","","","","","","","","","","","ZZ0"})
         AADD(aRegs,{cPerg,"10","Cep At�............:","mv_chA","C", 8,0,0,"G","","mv_par10","","99999999","","","","","","","","","","","","","ZZ0"})
         AADD(aRegs,{cPerg,"11","Gerar..............:","mv_chB","C",01,0,1,"C","","mv_par11","Arquivo","","","Relatorio","","","","","","","","","","",""})
         AADD(aRegs,{cPerg,"12","Dias de Atraso.....:","mv_chC","N",02,0,0,"G","","mv_par12","","","","","","","","","","","","","","",""})
         AADD(aRegs,{cPerg,"13","A눯o/Promo눯o......:","mv_chD","C",03,0,1,"G","","mv_par13","","","","","","","","","","","","","","",""})
         AADD(aRegs,{cPerg,"14","Tipo de Venda......:","mv_chE","C",01,0,1,"C","","mv_par14","Mercantil","","","Publicidade","","","","","","","","","","",""})

         For i:=1 to Len(aRegs)
             If !dbSeek(cPerg+aRegs[i,2])
                 RecLock("SX1",.T.)
                 For j:=1 to FCount()
                     If j <= Len(aRegs[i])
                         FieldPut(j,aRegs[i,j])
                     Endif
                 Next
                 MsUnlock()
             Endif
         Next

         DbSelectArea(_sAlias)

Return

