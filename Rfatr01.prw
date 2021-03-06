#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
#IFNDEF WINDOWS
  #DEFINE PSAY SAY
#ENDIF

User Function Rfatr01()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CSTRING,CDESC1,CDESC2,CDESC3,TAMANHO,ARETURN")
SetPrvt("NOMEPROG,ALINHA,NLASTKEY,CPERG,NLIN,TITULO")
SetPrvt("CABEC1,CABEC2,CCANCEL,M_PAG,WNREL,CARQ")
SetPrvt("CKEY,CFILTRO,NINDEX,mhora")

#IFNDEF WINDOWS
// Movido para o inicio do arquivo pelo assistente de conversao do AP5 IDE em 25/02/02 ==>   #DEFINE PSAY SAY
#ENDIF

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
귿컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴� 굇
교Programa: RFATR01   쿌utor: Fabio William          � Data:   07/07/97 � 굇
궁컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴� 굇
교Descri놹o: Imprime Pedidos Nao Faturados ou com Bloqueio              � 굇
궁컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴� 굇
교Uso      : M줰ulo de Faturamento                                      � 굇
굼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴� 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽
/*/


//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//�   Parametros Utilizados                   �
//�   mv_par01 = Lote Inicial                 �
//�   mv_par02 = Lote Final                   �
//�   mv_par03 = Data do Lote Inicial         �
//�   mv_par04 = Data do Lote Final           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

cString  :="SC9"
cDesc1   := OemToAnsi("Este programa tem como objetivo, demostrar a utiliza눯o ")
cDesc2   := OemToAnsi("das ferramentas de impress�o do Interpretador xBase.  ")
cDesc3   := ""
tamanho  :="P"
aReturn  := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
nomeprog :="RFATR01"
aLinha   := { }
nLastKey := 0
cPerg    := "FATR01"
pergunte(cPerg,.F.)
nLin     :=  80
titulo      :=oemtoansi("Rela놹o de Pedidos Liberados/Bloqueados ")
cabec1      :="PEDIDO ITEM CLIENTE NOME                                       BLQ      NOTA"
cabec2      :="                                                             EST  CRED  NUM"
//             XXXXXX  XX  XXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX XX    XX   XXXXXX
//             12345678901234567890123456789012345678901234567890123456789012345678901234567890
//                      1         2         3         4         5         6         7         8

cCancel := "***** CANCELADO PELO OPERADOR *****"

m_pag := 0  //Variavel que acumula numero da pagina
MHORA := TIME()
wnrel:="RFATR01_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

If nLastKey == 27
    Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
    Return
Endif

// 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// 쿎ria o arquivo temporario                      �
// 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

cArq       := CriaTrab(NIL,.F.)
cKey       := "C9_PEDIDO+C9_ITEM"
cFiltro    := 'C9_FILIAL=="'+xFilial()+'".And.C9_LOTEFAT>="'+MV_PAR01+'".And.'
cFiltro    := cFiltro + 'C9_LOTEFAT <="'+MV_PAR02+'".And.DTOS(C9_DATA)>="'+DTOS(MV_PAR03)+'".And.'
cFiltro    := cFiltro + ' DTOS(C9_DATA) <= "'+DTOS(MV_PAR04)+'" .AND.'
cFiltro    := cFiltro + ' (C9_BLEST #"  " .OR. C9_BLCRED # "  ")'
//cFiltro    := cFiltro + ' .AND. EMPTY(C9_NFISCAL)'

IndRegua("SC9",cArq,cKey,,cFiltro,"Selecionando registros .. ")
nIndex:=RetIndex("SC9")
#IFNDEF TOP
	dbSetIndex(cArq+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()


// 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// 쿎hama Relatorio                                �
// 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
#IFDEF WINDOWS
   RptStatus({|| RptDetail() })// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>    RptStatus({|| Execute(RptDetail) })
#ELSE
   RptDetail()
#ENDIF
Return

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    쿝ptDetail � Autor � Ary Medeiros          � Data � 15.02.96 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o 쿔mpressao do corpo do relatorio                             낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/  
// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==> Function RptDetail
Static Function RptDetail()

SetRegua(Reccount())
Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18) //Impressao do cabecalho


Do While !eof()
   if nLin > 57
      nLin := Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,18) //Impressao do cabecalho
      nLin := nLin + 1
   endif
   DbSelectArea("SA1")
   DbSeek(xFilial()+SC9->C9_CLIENTE+SC9->C9_LOJA)
   @ nlin,000 PSAY SC9->C9_PEDIDO
   @ nLin,009 PSAY SC9->C9_ITEM
   @ nlin,013 PSAY SC9->C9_CLIENTE
   @ nlin,021 PSAY SA1->A1_NOME
   @ nlin,062 PSAY SC9->C9_BLEST
   @ nlin,068 PSAY SC9->C9_BLCRED
   @ nlin,073 PSAY SC9->C9_NFISCAL
   nLin := nLin + 1

   DbSelectarea("SC9")
   DbSkip()
Enddo

DbSelectarea("SC9")
RetIndex("SC9")
Ferase(cArq+OrdBagExt())


Roda(0,"","P")
Set Filter To
If aReturn[5] == 1
	Set Printer To
	Commit
    ourspool(wnrel) //Chamada do Spool de Impressao
Endif
MS_FLUSH() //Libera fila de relatorios em spool
Return



