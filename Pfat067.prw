#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ฑฑ
ฑฑณPrograma: PFAT067   ณAutor: Raquel Farias          ณ Data:   13/09/99 ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณDescriao: Etiquetas avulsas                                          ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณUso      : Mขdulo de Faturamento                                      ณ ฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู ฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function Pfat067()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

SetPrvt("ARETURN,CPROGRAMA,CDESC1,CDESC2,CDESC3,CTITULO")
SetPrvt("CSTRING,NLASTKEY,WNREL,L,NORDEM,TAMANHO")
SetPrvt("NCARACTER,LCONTINUA,CPERG,_ACAMPOS,_CNOME,MPEDIDO")
SetPrvt("MPRODUTO,MCLIENTE,MCODDEST,MNOMECLI,MNOMEDEST,MEND")
SetPrvt("MBAIRRO,MMUN,MCEP,MEST,MFONE,NOMEDEST")
SetPrvt("LIN,COL,LI,mhora")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                         ณ
//ณ mv_par01             // Pedido             C-6               ณ
//ณ mv_par02             // Produto            C-15              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aReturn   := { "Especial", 1,"Administraฦo", 1, 2, 1,"",1 }
cPrograma := "PFAT067"
cDesc1    := PADC("Este programa ira gerar o arquivo de etiquetas" ,74)
cDesc2    := ""
cDesc3    := ""
cTitulo   := PADC("ETIQUETAS",74)
cString   := "PFAT067"
nLastKey  := 0
MHORA      := TIME()
wnrel     := "PFAT067_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
L         := 0
nOrdem    := 0
tamanho   := "P"
nCaracter := 10
lContinua := .T.
cPerg     := "PFAT31"

If !PERGUNTE(cPerg)
    Return
Endif

If LastKey()== 27
   Return
Endif

_aCampos := {  {"NUMPED"  ,"C",6 ,0},;
               {"CODCLI"  ,"C",6 ,0},;
               {"NOME"    ,"C",40,0},;
               {"DEST"    ,"C",40,0},;
               {"V_END"   ,"C",40,0},;
               {"BAIRRO"  ,"C",15,0},;
               {"MUN"     ,"C",20,0},;
               {"CEP"     ,"C",8 ,0},;
               {"EST"     ,"C",2 ,2}}

If Select("PFAT067") <> 0
	DbSelectarea("PFAT067")
	DbCloseArea()
EndIf

_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PFAT067",.F.,.F.)

ATUALIZA()

WHILE .T.
   cPerg:="PFAT31"

   If !PERGUNTE(cPerg)
       Exit
   Endif

   If LastKey()== 27
      exit
   Endif
   ATUALIZA()
END

wnrel:=SetPrint(cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica Posiฦo do Formul rio na Impressora                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
SetDefault(aReturn,cString)
If nLastKey == 27
   Return
Endif

Processa({|| IMPRIME()})

DBSELECTAREA("PFAT067")
DBCLOSEAREA()

DBSELECTAREA("SC6")
Retindex("SC6")

DBSELECTAREA("SA1")
Retindex("SA1")

DBSELECTAREA('SZO')
Retindex("SZO")

DBSELECTAREA('SZN')
Retindex("SZN")

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtualiza()บAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION ATUALIZA()

  MPEDIDO   := MV_PAR01
  MPRODUTO  := MV_PAR02
  MCLIENTE  := '  '
  MCODDEST  := '  '
  MNOMECLI  := '  '
  MNOMEDEST := '  '
  MEND      := '  '
  MBAIRRO   := '  '
  MMUN      := '  '
  MCEP      := '  '
  MEST      := '  '
  DBSELECTAREA('SC6')
  If DBSEEK(xfilial()+MPEDIDO)
     WHILE .T.
        IF SUBS(SC6->C6_REGCOT,1,4)==SUBS(MPRODUTO,1,4)  .AND. SC6->C6_NUM==MPEDIDO
           MCLIENTE := SC6->C6_CLI
           MCODDEST := SC6->C6_CODDEST
           EXIT
         ELSE
           DBSKIP()
           IF SC6->C6_NUM <> MPEDIDO
              EXIT
           ELSE
             LOOP
           ENDIF
        ENDIF
     END
  ENDIF
  DBSELECTAREA("SA1")
  If DBSEEK(XFILIAL()+MCLIENTE)
     MNOMECLI := SA1->A1_NOME
  ELSE
     MNOMECLI := '  '
  ENDIF
  MEND     := SA1->A1_END
  MBAIRRO  := SA1->A1_BAIRRO
  MMUN     := SA1->A1_MUN
  MEST     := SA1->A1_EST
  MCEP     := SA1->A1_CEP
  MFONE    := SA1->A1_TEL
  NOMEDEST := SPACE(40)

  IF MCODDEST # ' '
     DBSELECTAREA("SZN")
     If DBSEEK(XFILIAL()+MCLIENTE+MCODDEST)
        MNOMEDEST := SZN->ZN_NOME
     ENDIF
     DBSELECTAREA("SZO")
     If DBSEEK(XFILIAL()+MCLIENTE+MCODDEST)
        MEND    := SZO->ZO_END
        MBAIRRO := SZO->ZO_BAIRRO
        MMUN    := SZO->ZO_CIDADE
        MEST    := SZO->ZO_ESTADO
        MCEP    := SZO->ZO_CEP
        MFONE   := SZO->ZO_FONE
     ENDIF
  ENDIF
  GRAVA_TEMP()

RETURN
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrava_tempบAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION GRAVA_TEMP()

DBSELECTAREA("PFAT067")

Reclock("PFAT067",.T.)
REPLACE NUMPED WITH  MPEDIDO
REPLACE NOME   WITH  MNOMECLI
REPLACE DEST   WITH  MNOMEDEST
REPLACE V_END    WITH  MEND
REPLACE BAIRRO WITH  MBAIRRO
REPLACE MUN    WITH  MMUN
REPLACE CEP    WITH  MCEP
REPLACE EST    WITH  MEST
MSUnlock()

RETURN
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณImprime   บAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION IMPRIME()
   SETPRC(0,0)
   LIN := 0
   COL := 1
   LI  := 0
   DBSELECTAREA('PFAT067')
   COUNT TO MCONTA
   DBGOTOP()
   ProcRegua(MCONTA)
   WHILE !EOF()
      @ LIN+LI,001 PSAY NOME
      DBSKIP()
      @ LIN+LI,043 PSAY NOME
      DBSKIP(-1)
      LI++

      @ LIN+LI,001 PSAY DEST
      DBSKIP()
      @ LIN+LI,043 PSAY DEST
      DBSKIP(-1)
      LI++

      @ LIN+LI,001 PSAY V_END
      DBSKIP()
      @ LIN+LI,043 PSAY V_END
      DBSKIP(-1)   
      LI++

      @ LIN+LI,001 PSAY BAIRRO+'               '+'('+NUMPED+')'
      DBSKIP()
      @ LIN+LI,043 PSAY BAIRRO+'               '+'('+NUMPED+')'
      DBSKIP(-1)
      LI++

      @ LIN+LI,001 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
      DBSKIP()
      @ LIN+LI,043 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
      LI++
      DBSKIP()

      LI  := 2
      setprc(0,0)
      lin := prow()
      IncProc()
   END

   @ LIN+LI  ,001 PSAY '****************************************'
   @ LIN+LI+1,001 PSAY 'TOTAL................ ..:'+STR(MCONTA,7)
   @ LIN+LI+2,001 PSAY '****************************************'

   SET DEVICE TO SCREEN
   
   IF aRETURN[5] == 1
     Set Printer to
     dbcommitAll()
     ourspool(WNREL)
   ENDIF
   
   MS_FLUSH()
   
RETURN