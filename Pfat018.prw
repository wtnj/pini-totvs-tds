#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Pfat018()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("_CALIAS,_NINDEX,_NREG,CSAVTELA,CSAVCURSOR,CSAVCOR")
SetPrvt("CSAVALIAS,NLASTKEY,APERG,CPERG,TREGS,M_MULT")
SetPrvt("P_ANT,P_ATU,P_CNT,M_SAV20,M_SAV7,_CMSG")
SetPrvt("_NPEDIDO,_CLETRA,_CPEDIDO,cLetraInicial")

/*/
//20100622 Danilo C S Pala: correcao solicitada por Priscila para permitir letras no numero do pedido
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT018   ³Autor: Solange Nalini         ³ Data:   06/07/98 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Distribui‡Æo de pedidos - Controle p/Vendedor              ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()

#IFNDEF WINDOWS
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Salva condicoes iniciais                                                  ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    cSavTela   := SaveScreen( 0, 0,24,80)
    cSavCursor := SetCursor()
    cSavCor    := SetColor()
    cSavAlias  := Select()

    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Recupera o desenho padrao de atualizacoes³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    ScreenDraw("SMT050", 3, 0, 0, 0)
    SetCursor(1)
    SetColor("B/BG")

#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Ambientais                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nLastkey := 0
aPerg    :=  ' '

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Cod.Vendedor                         ³
//³ mv_par02             // Pedido Inicial                       ³
//³ mv_par03             // Pedido Final                         ³
//³ mv_par04             // No. da Requisi‡Æo                    ³
//³ mv_par05             // DivisÆo de Vendas                    ³
//³ mv_par06            // Letra inicial						 |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Ambientais                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg:="FAT012"


If !Pergunte(cPerg)
        Return
EndIf

#IFNDEF WINDOWS
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³ Janela do Siga Advanced.                 ³
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    DrawAdvWin("**  CONTROLE DE PEDIDOS  **" , 8, 0, 12, 75 )
    @ 10, 5 Say " A G U A R D E "

#ENDIf

dbSelectArea("SZD")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa regua de processamento        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
tregs := LastRec() - Recno()+1

#IfNDEF WINDOWS
    m_mult := 1
    If tregs>0
        m_mult := 70/tregs
    EndIf
    p_ant := 4
    p_atu := 4
    p_cnt := 0
    m_sav20 := dcursor(3)
    m_sav7 := savescreen(23,0,24,79)

#ELSE
    Processa({||_RunProc()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     Processa({||Execute(_RunProc)})
    Return
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>     Function _RunProc
Static Function _RunProc()

#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Inicio do processamento                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
/*
*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
* VERIfICA SE A REQUISICAO OU OS PEDIDOS JA FORAM LANCADOS          *
*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
*/
dbSetOrder(3)
If dbSeek(xfilial("SZD")+mv_par04, .F.)
    _cMsg   := 'ATENCAO !  Requisi‡ao '+ MV_PAR04 + '    j  lan‡ada  ! '
    #IFNDEF WINDOWS
        SetColor("b/bg")
        @ 10,05 SAY _cMsg
        @ 11,05 SAY '<ESC>  Retorna '
        Inkey(0)
        If NLastkey == 27
            SetColor("n/w,,,")
            Return
        EndIf

    #ELSE
        If !MsgBox(_cMsg+" Deseja Continuar ? ", "ATENCAO", "YESNO")
            Return
        EndIf
    #ENDIF

EndIf

dbSetorder(1)
_nPedido:=Val(MV_PAR02)

If MV_PAR05=='PUBL'
    _cLetra:='P'
Elseif MV_PAR05=='EVEN'
    _cLetra:='E'       
Elseif MV_PAR05=='MERC' //20100625
	IF MV_PAR06 == " "
		cLetraInicial := ""
	ELSE
		cLetraInicial := MV_PAR06
	ENDIF	
Else
	IF MV_PAR06 == " "
		cLetraInicial := ""
	ELSE
		cLetraInicial := MV_PAR06
	ENDIF	
EndIf

While _nPedido <= Val(MV_PAR03)
    If MV_PAR05=='PUBL' .or. MV_PAR05=='EVEN'
          _cPedido:=STRZERO(_nPedido,5)+TRIM(_cLetra)
   //     _cPedido:=STRZERO(_nPedido,5)+TRIM(_cLetra)
    Else
        //_cPedido:=STRZERO(_nPedido,6)+TRIM(_cLetra) //20100622
        if cLetraInicial ==""
       		_cPedido:= STRZERO(_nPedido,6) //20100622
	    else                                                              
       		_cPedido:= TRIM(cLetraInicial) + STRZERO(_nPedido,5) //20100622
        endif
    EndIf
    If dbSeek( xFilial("SZD")+_cPedido, .F. )
        _cMsg   := 'PEDIDO   '+ _cPedido + ' JA ENTREGUE AO VENDEDOR  '+SZD->ZD_CODVEND
        #IFNDEF WINDOWS
            SetColor("b/bg")
            @ 10,05 SAY _cMsg
            @ 11,05 SAY '<ENTER> CONTINUA OU <ESC> RETORNA '
            INKEY(0)
            SetColor("n/w,,,")
            If lastkey()==27
                Return
            EndIf
        #ELSE
            If !MsgBox(_cMsg+" Deseja Continuar ? ", "ATENCAO", "YESNO")
                Return
            EndIf
        #ENDIF
        _nPedido:=_nPedido+1
        Loop
    EndIf
/*
        *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
        * DISTRIBUI OS PEDIDOS POR VENDEDOR NO ARQ DE CONTROLE DE PEDIDOS   *
        *ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*
  */
    Reclock("SZD",.T.)
    SZD->ZD_FILIAL  := xFilial("SZD")
    SZD->ZD_CODVEND := mv_par01
    SZD->ZD_PEDIDO  := _cPedido
    SZD->ZD_REQUIS  := mv_par04
    SZD->ZD_SITUAC  := 'D'
    SZD->ZD_DTREQ   := dDataBase
    SZD->ZD_DTSITUA := dDataBase
    SZD->ZD_DIVVEND := MV_PAR05
    SZD->(MsUnlock())
    _nPedido:=_nPedido+1

        //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
        //³ Movimenta regua de processamento         ³
        //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    #IFNDEF WINDOWS
        p_cnt := p_cnt + 1
        p_atu := 3+INT(p_cnt*m_mult)
        If p_atu != p_ant
            p_ant := p_atu
            Restscreen(23,0,24,79,m_sav7)
            Restscreen(23,p_atu,24,p_atu+3,m_sav20)
        EndIf
    #ELSE
        IncProc()
    #ENDIF
End

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)
Return

