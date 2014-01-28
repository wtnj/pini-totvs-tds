#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Rfat012()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CSAVTELA,CSAVCURSOR,CSAVCOR,CSAVALIAS,CPERG,TITULO")
SetPrvt("MDUPL,MPARC,MPREFIXO,")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                                           ³
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

CPERG:='PFAT004'
TITULO:='ETIQUETAS'
DrawAdvWin("**  TRANSFERENCIA NATUREZA  **" , 8, 0, 12, 75 )

Do While .T.
   mDUPL:=space(6)
   MPARC:=SPACE(1)
   MPREFIXO:=SPACE(3)
   @ 09,02 say "DUPL....:  " get mDUPL
   @ 10,02 say "PREFIXO :  " get mPREFIXO
   @ 11,02 SAY 'PARC....:  ' GET MPARC
   read
   If mDUPL==space(6)
      EXIT
   Endif
      DBSELECTAREA("SE1")
      dbSeek(xfilial()+MPREFIXO+mDUPL+MPARC)
      If found()
         RECLOCK("SE1")
         REPLA E1_NATUREZ WITH 'CH'
         SE1->(MSUNLOCK())
      ENDIF
ENDDO
RETURN

