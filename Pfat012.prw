#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/ Atualizado por Danilo C S Pala, em 20041026: Nao atualizar data para portadores = 904 920, 930
Danilo C S Pala em 20110301: Nao processar se a data(MV_PAR03) for diferente do ddatabase, solicitado por Cidinha
Danilo C S Pala em 20110302: Somente Administrador e Cidinha //apos conversa com Cruz
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT012   ³Autor: Solange Nalini         ³ Data:   22/06/98 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Atulizacao da data de pagto de comissoes                   ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Pfat012()
SetPrvt("TITULO,CDESC1,CDESC2,CDESC3,NOMEPROG,CPERG")
SetPrvt("CSTRING,MDATA,CINDEX,CKEY,TREGS,M_MULT")
SetPrvt("P_ANT,P_ATU,P_CNT,M_SAV20,M_SAV7,MVEND")
SetPrvt("MREGPOS,MVAL,MPED,MNUM,MPARC,MREGIAO")
SetPrvt("MCONT, cLoginUsuario")
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // Da Regiao                            ³
//³ mv_par02             // At‚ Regiao                           ³
//³ MV_PAR03			// Data Pagamento
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

titulo   := PADC("COMISSOES ",74)
cDesc1   := PADC("Este programa atualiza a Data de Pagto das Comissoes ",74)
cDesc2   := " "
cDesc3   := " "
nomeprog := "PGCOM"
cPerg    := "FAT009"

cLoginUsuario := alltrim(substr(cusuario,7,15)) //20110302
If (cLoginUsuario=="CIDINHA" .or. cLoginUsuario=="Administrador") //20110302
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica as perguntas selecionadas.                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !PERGUNTE(cPerg)
    	Return
	Endif

	if dtos(MV_PAR03) == dtos(dDatabase) //20110301
		cString := "SE3"
		MDATA   := SPACE(8)
		lEnd := .f.
		Processa({|lEnd| P012Proc(@lEnd)},"Aguarde","Atualizando Arquivos...",.t.)
	Else
		MsgAlert("A data do pagamento deve ser igual a data base do sistema"+chr(10)+chr(13)+"Processo abortado!","Atenção")
	EndIf
Else 
	MsgAlert("Este procedimento so pode ser executado pela Cidinha"+chr(10)+chr(13)+"Processo abortado!","Atenção")
EndIf

Return

Static Function P012Proc()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Prepara regua de impressÆo                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DBSELECTAREA("SE3")
cIndex := CriaTrab(Nil,.F.)
cKey   := "E3_FILIAL+DTOS(E3_DATA)+E3_REGIAO+E3_PER+E3_VEND"
MsAguarde({|| Indregua("SE3",cIndex,ckey,,,"Selecionando Registros do Arq")},"Aguarde","Gerando Indice Temporario (SE3)...")
DBSEEK(XFILIAL("SE3")+MDATA)

tregs   := LastRec()-Recno()+1

ProcRegua(tregs)

MREGPOSANT := 0

WHILE !Eof() .and. SE3->E3_FILIAL == xFilial("SE3") .and. DTOS(SE3->E3_DATA) == MDATA .and. !lEnd
   
   IncProc("Nota: "+SE3->E3_PREFIXO+SE3->E3_NUM+SE3->E3_PARCELA)

   MVEND   := SE3->E3_VEND
   MREGPOSANT := RECNO()
   DBSKIP()
   MREGPOS := RECNO()
   DBGOTO(MREGPOSANT)   //SKIP(-1)
   MVAL    := SE3->E3_BASE
   MPED    := SE3->E3_PEDIDO
   MNUM    := SE3->E3_NUM
   MPARC   := SE3->E3_PARCELA

   DBSELECTAREA("SA3")
   DBSETORDER(1)
   IF DBSEEK(XFILIAL("SA3")+MVEND)
      IF VAL(SA3->A3_REGIAO)<VAL(MV_PAR01) .OR. VAL(SA3->A3_REGIAO)>VAL(MV_PAR02) .OR. SA3->A3_TIPOVEN == 'CT'
         DBSELECTAREA("SE3")
         DBSKIP()
         LOOP
      ENDIF
   ENDIF

   MREGIAO := SA3->A3_REGIAO

   IF SE3->E3_SITUAC == ' '
      
      IF SE3->E3_BASE < 0
         MCONT := -1
      ELSE
         MCONT := 1
      ENDIF
      
      DBSELECTAREA("SE1")
      DbOrderNickName("E1_PEDIDO") //dbSetOrder(27) 20130225  ///dbSetOrder(15) AP5 //20090114 era(21) //20090723 mp10 era(22) //dbSetOrder(26) 20100412
      
      IF DBSEEK(XFILIAL("SE1")+MPED+MNUM+MPARC)
         //20041026 Nao atualizar data para portadores = 904 920, 930
         if se1->e1_portado = '904' .or. se1->e1_portado = '920' .or. se1->e1_portado = '930'
	         DBSELECTAREA("SE3")
    	     DBSKIP()
        	 LOOP
         end if //ateh aki 20041026
         
         IF SE1->E1_BASCOM1 <> 0
            MVAL := (SE1->E1_BASCOM1 * MCONT)
         ENDIF  
      ENDIF
      
   ENDIF

   DBSELECTAREA("SE3")
   RECLOCK("SE3",.F.)
   REPLACE E3_DATA   WITH MV_PAR03
   REPLACE E3_REGIAO WITH MREGIAO
   REPLACE E3_PER    WITH MV_PAR04
   REPLACE E3_BASE   WITH MVAL
   REPLACE E3_COMIS  WITH (MVAL * (SE3->E3_PORC/100))
   MSUNLOCK()
   DBSELECTAREA("SE3")
   DBGOTO(MREGPOS)
END

cMsg := ""

If lEnd
	cMsg := OemToAnsi("O Arquivo de comissoes foi atualizado ate o titulo "+SE3->E3_PREFIXO+SE3->E3_NUM+SE3->E3_PARCELA+".")
    MsgAlert(cMsg,"Processamento Interrompido")
Else
	cMsg := OemToAnsi("Atualizacao Finalizada")
    MsgAlert(cMsg,"Final de Processamento")
EndIf    

DBSELECTAREA("SE3")
RETINDEX("SE3")

RETURN