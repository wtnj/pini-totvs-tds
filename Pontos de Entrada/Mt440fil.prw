#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function Mt440fil()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CFILTRO,_LR,_CFILTRO,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: MTA440FIL 쿌utor: Fabio William          � Data:   07/07/99 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri놹o: Liberacao automatica de Pedido de Venda                    � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : Especifico da Editora Pini                                 � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
 쿛arametros Utilizados                                         �
 쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
 쿺v_par08  Lote de                                             �
 쿺v_par09  Lote Ate                                            �
 쿺v_par10  Data Lote de                                        �
 쿺v_par11  Data Lote Ate                                       �
 쿺v_par05  No da 1a Nota Fiscal // Avaliar usa utilizacao      �
 읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
/*/

cfiltro  := "C6_LOTEFAT >='"+mv_par08+"' .AND. C6_LOTEFAT <= '"+mv_par09+"'.and."
cfiltro  := cFiltro+"Dtos(C6_DATA)  >='"+Dtos(mv_par10)+"' .AND. Dtos(C6_DATA) <= '"+Dtos(mv_par11)+"'"
_LR      := &Cfiltro
if _lR
  alert("PASSA")
  _cFiltro := ".T."
else
  _cFiltro := ".F."
endif
// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> __Return(cFiltro)
Return(cFiltro)        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02
Return

/*/
cfiltro := execblock("mt440fil",.f.,.f.)
if !&cFiltro
   dbselectarea("SC6")
   dbskip
   loop
Endif


empe + entr < vendida
   c5_liberado == " "
else


/*/


