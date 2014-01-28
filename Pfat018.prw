#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Pfat018()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("_CALIAS,_NINDEX,_NREG,CSAVTELA,CSAVCURSOR,CSAVCOR")
SetPrvt("CSAVALIAS,NLASTKEY,APERG,CPERG,TREGS,M_MULT")
SetPrvt("P_ANT,P_ATU,P_CNT,M_SAV20,M_SAV7,_CMSG")
SetPrvt("_NPEDIDO,_CLETRA,_CPEDIDO,cLetraInicial")

/*/
//20100622 Danilo C S Pala: correcao solicitada por Priscila para permitir letras no numero do pedido
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: PFAT018   쿌utor: Solange Nalini         � Data:   06/07/98 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri눯o: Distribui눯o de pedidos - Controle p/Vendedor              � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento                                      � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()

#IFNDEF WINDOWS
    //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
    //� Salva condicoes iniciais                                                  �
    //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
    cSavTela   := SaveScreen( 0, 0,24,80)
    cSavCursor := SetCursor()
    cSavCor    := SetColor()
    cSavAlias  := Select()

    //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
    //� Recupera o desenho padrao de atualizacoes�
    //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
    ScreenDraw("SMT050", 3, 0, 0, 0)
    SetCursor(1)
    SetColor("B/BG")

#ENDIF

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Ambientais                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
nLastkey := 0
aPerg    :=  ' '

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Cod.Vendedor                         �
//� mv_par02             // Pedido Inicial                       �
//� mv_par03             // Pedido Final                         �
//� mv_par04             // No. da Requisi눯o                    �
//� mv_par05             // Divis�o de Vendas                    �
//� mv_par06            // Letra inicial						 |
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸


//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Ambientais                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
cPerg:="FAT012"


If !Pergunte(cPerg)
        Return
EndIf

#IFNDEF WINDOWS
    //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
    //� Janela do Siga Advanced.                 �
    //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
    DrawAdvWin("**  CONTROLE DE PEDIDOS  **" , 8, 0, 12, 75 )
    @ 10, 5 Say " A G U A R D E "

#ENDIf

dbSelectArea("SZD")
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Inicializa regua de processamento        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//�  Inicio do processamento                                     �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
/*
*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�*
* VERIfICA SE A REQUISICAO OU OS PEDIDOS JA FORAM LANCADOS          *
*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�*
*/
dbSetOrder(3)
If dbSeek(xfilial("SZD")+mv_par04, .F.)
    _cMsg   := 'ATENCAO !  Requisi놹o '+ MV_PAR04 + '    j� lan놹da  ! '
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
        *컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�*
        * DISTRIBUI OS PEDIDOS POR VENDEDOR NO ARQ DE CONTROLE DE PEDIDOS   *
        *컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�*
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

        //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
        //� Movimenta regua de processamento         �
        //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
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
