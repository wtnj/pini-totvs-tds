#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02
// Danilo C S Pala: alterado a pedido do cicero, completar pesquisa por indice
User Function cfat001()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,MVPAR")
SetPrvt("MNOTA,MDATA, MSERIE, MCLIENTE")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: CFAT001   쿌utor: Solange Nalini         � Data:   20/01/00 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri놹o: CONSULTA DE NF PELO PEDIDO                                 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento/                                     � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/
//cSavTela   := SaveScreen( 0, 0,23,80)
//cSavCursor := SetCursor()
//cSavCor    := SetColor()
//cSavAlias  := Select()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Recupera o desenho padrao de atualizacoes�
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//ScreenDraw("SMT050", 3, 0, 0, 0)
//SetCursor(1)
//SetColor("B/BG")
//
//DO WHILE .T.

   CPERG:="PFAT50"

   If .Not. PERGUNTE(cPerg)
       Return
   Endif

   MVPAR:=MV_PAR01
   DBSELECTAREA("SC5")
   DBSETORDER(1)
   IF DBSEEK(XFILIAL()+MVPAR)
      MNOTA   := SC5->C5_NOTA        
      MSERIE  := SC5->C5_SERIE
      MCLIENTE:= SC5->C5_CLIENTE
      DBSELECTAREA("SF2")
      DBSETORDER(1)

      IF DBSEEK(XFILIAL()+MNOTA+MSERIE+MCLIENTE)
         MDATA := SF2->F2_EMISSAO
      ENDIF
      notali := sc5->c5_nota
      datli  := DTOC(SF2->F2_EMISSAO)
  
      ALERT("N� da Nota Fiscal -->  " + sc5->c5_nota +' '+ SC5->C5_SERIE +'  de   '+ datli)
   Else
     ALERT("O pedido n�o se encontra faturado, Verifique !!")
   endif

RETURN