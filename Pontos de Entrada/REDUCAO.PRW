//#INCLUDE "REDUCAO.CH"
#INCLUDE "RWMAKE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ LojA170	³ Autor ³ Fernando Godoy	     ³ Data ³ 16/10/96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Leitura X                  			            		   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Alteracao³ Alteracao realizada dia 29/07/2003 para impressao da reducao³±±
±±³ Alteracao³ "X" via modulo Faturamento na impressora fical Bematech     ³±±
±±³ Alteracao³ Analista Claudio M. Ouverney                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function reducao()
/*
Local nOpca := 0
Local oDlg
Local _cImpressora:= GetMv("MV_IMPFIS")
Local _cPorta     := GetMv("MV_PORTFIS")
Local aSays    := {}   //Array de expressoes da formbatch
Local aButtons := {}   //Array de botoes da formbatch
Private cCadastro   := OemToAnsi(STR0001)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Montagem da tela de processamento³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Este programa tem como
// objetivo efetuar	a	impress„o	do
// cupom de leitura impressora fiscal

AADD(aSays,OemToAnsi( STR0005 ) ) 
AADD(aSays,OemToAnsi( STR0006 ) ) 
AADD(aSays,OemToAnsi( STR0007 ) ) 
AADD(aSays,OemToAnsi( STR0008 + _cImpressora + "." ) ) 
AADD(aButtons, { 1,.T.,{|o| (nOpca := 1,IF(MsgYesNo( OemToAnsi(STR0010),OemToAnsi(STR0011) ),o:oWnd:End(),nOpca:=0))}})
AADD(aButtons, { 2,.T.,{|o| o:oWnd:End() }} )
FormBatch( cCadastro, aSays, aButtons )

If Type("nHdlECF") == "U"
	Public nHdlECF
	nHdlECF := IFAbrir( _cImpressora,_cPorta )
EndIf

If nOpca == 1
	Processa({|lEnd| lj160Leitura()})
Endif

Return Nil

Static Function lj160Leitura()
Local iRet
Local cReducao:=space(500)
Local cTribut
Local cNumero
Local nI
Local dData2,dData
Local nGTIni
Local nImpDebt := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Descricao do retorno da variavel cReducao                      ³
//³---------------------------------------------------------------³
//³ 1 - XX/XX/XX            - Data do Movimento                   ³
//³ 2 - XXXX                - Numero do ECF                       ³
//³ 3 - XXXXXXXXXXXXX       - Serie do ECF                        ³
//³ 4 - XXXX                - Numero de reducoes                  ³
//³ 5 - XXXXXXXXXXXXXXXX.XX - Grande Total Final                  ³
//³ 6 - XXXXXX              - Numero doumento Inical              ³
//³ 7 - XXXXXX              - Numero doumento Final               ³
//³ 8 - XXXXXXXXXXXX.XX     - Valor do Cancelamento               ³
//³ 9 - XXXXXXXX.XX         - Valor Contabil ( Venda Liquida )    ³
//³10 - XXXXXXXX.XX         - Desconto                            ³
//³11 - XXXXXXXX.XX         - Nao tributado SUBSTITUIcao TRIB     ³
//³12 - XXXXXXXX.XX         - Nao tributado ISENTO                ³
//³13 - XXXXXXXX.XX         - Nao tributado Nao Tributado         ³
//³14 - XX/XX/XX            - Data da Reducao Z                   ³
//³15 - XXXXXX              - Contador de Ordem de Operação       ³
//³16 - 0000000000000000    - Outros Recebimentos                 ³
//³17 - TXX,XX999999999.99  - Totas as Aliquotas e seus valores.. ³
//³                           que estao gravados no ECF           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cReducao := GetMv('MV_LJGRMR') + cReducao
iRet := IFReducaoZ( nHdlECF, @cReducao )
if GetMv('MV_LJGRMR')='S'.and. iRet=0
	dbselectArea('SFI')
	dbSetOrder(1)
    dbGotop()
    dData2:=FI_DTMOVTO
    dData :=Ctod(subs(cReducao,1,8))
    nGTIni:=0
    while dData2<=dData.and. !empty(dData2)
       dData :=dData-1
       if dbSeek(xFilial('SFI')+DToS(dData)+subs(cReducao,11,3))
          nGTIni:=FI_GTFINAL
          Exit
       EndIf   
    End   
	If !dbSeek(xFilial('SFI')+DToS(Ctod(subs(cReducao,1,8)))+subs(cReducao,10,4))
		cTribut:=Subs(cReducao,181)
		cNumero:=LJ200Num( ctod(subs(cReducao,1,8)) )
		RecLock( "SFI", .T. )
		Replace FI_FILIAL    with xFilial('SFI')
		Replace FI_DTMOVTO  with CtoD(subs(cReducao,1,8))
		Replace FI_PDV      with subs(cReducao,11,3) // PDV tem de ser 3 posicoes para geracao do Registro Tipo 60
		Replace FI_SERPDV   with subs(cReducao,15,13)
		Replace FI_NUMREDZ  with subs(cReducao,29,4)
		Replace FI_GTFINAL  with Val(subs(cReducao,34,19))
		Replace FI_NUMINI   with subs(cReducao,54,6)
		Replace FI_NUMFIM   with subs(cReducao,61,6)
		Replace FI_CANCEL   with Val(subs(cReducao,68,15))
		Replace FI_VALCON   with Val(subs(cReducao,84,15))
		Replace FI_DESC     with Val(subs(cReducao,100,11))
		Replace FI_SUBTRIB  with Val(subs(cReducao,112,11))
		Replace FI_ISENTO   with Val(subs(cReducao,124,11))
		Replace FI_NTRIB    with Val(subs(cReducao,136,11))
		Replace FI_COO      with subs(cReducao,157,6)
		Replace FI_OUTROSR with Val(subs(cReducao,164,16))
		Replace FI_NUMERO   with cNumero
		Replace FI_GTINI    with nGTIni                    
        While Len(cTribut)>0 
            cCampo:='FI_BAS'

            if Val(Subs(cTribut,2,2))>=10
                  cCampo+=Subs(cTribut,2,2)
            Else
                  cCampo+=Subs(cTribut,3,1)
               EndIf
            if Val(Subs(cTribut,5,2))>0
                  cCampo+=Subs(cTribut,5,2)
            Endif   
			if FieldPos(cCampo) > 0
				FieldPut(FieldPos(cCampo),FieldGet(FieldPos(cCampo))+Val(Subs(cTribut,8,14)))
                nImpDebt += Val(Subs(cTribut,23,13))
            Endif   
            cTribut:=Subs(cTribut,37)
        End
		Replace FI_IMPDEBT with nImpDebt
		MsUnLock()
	EndIf
EndIf
*/
Return NIL

