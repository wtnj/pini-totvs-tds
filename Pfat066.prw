#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: PFAT066   �Autor: Raquel Farias          � Data: 30/08/99   � ��
������������������������������������������������������������������������Ĵ ��
���Descri�ao: Roteiriza��o/Etiquetas                                     � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento  Liberado para Usu�rio em:           � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function Pfat066()

SetPrvt("ARETURN,CPROGRAMA,CDESC1,CDESC2,CDESC3,CTITULO")
SetPrvt("CSTRING,NLASTKEY,WNREL,L,NORDEM,TAMANHO")
SetPrvt("NCARACTER,LCONTINUA,CPERG,MDTSIS,MNOMEARQ,MARQ")
SetPrvt("MDIR,MCAMINHO,_ACAMPOS,_CNOME,CINDEX,CKEY")
SetPrvt("CCHAVE,CFILTRO,CIND,MPEDIDO,MNOMECLI,MNOMEDEST")
SetPrvt("MEND,MBAIRRO,MMUN,MCEP,MEST,MFONE")
SetPrvt("MCODDEST,MPRODUTO,MROTEIRO,MPORTE,MITEM,LIN")
SetPrvt("COL,LI,MCONTA,NRECNO,mhora")
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01             // Arquivo   C-8                        �
//� mv_par02             // Extens�o  C-1  SDF   TXT   DBF       �
//� mv_par03             // Diretorio C-30                       �
//� mv_par04             // Atualizar C-1 Roteiro Etiqueta Ambos �
//� mv_par05             // Produto   C-15                       �
//� mv_par06             // Do  Porte C-1                        �
//� mv_par07             // At� Porte C-1                        �
//����������������������������������������������������������������
aReturn   := { "Especial", 1,"Administra��o", 1, 2, 1,"",1 }
cPrograma := "PFAT066"
cDesc1    := PADC("Este programa ira gerar o arquivo de etiquetas" ,74)
cDesc2    := ""
cDesc3    := ""
cTitulo   := PADC("ETIQUETAS",74)
cString   := "PFAT066"
nLastKey  := 0
MHORA      := TIME()
wnrel     := "PFAT066_" + SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
L         := 0
nOrdem    := 0
tamanho   := "P"
nCaracter := 10
lContinua := .T.
cPerg     := "PFAT29"

MDTSIS    := DTOC(DATE())
MNOMEARQ  := 'ET'+SUBS(MDTSIS,1,2)+SUBS(MDTSIS,4,2)+'.TXT'
//�������������������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                                      �
//���������������������������������������������������������������������������
If !PERGUNTE(cPerg)
    Return
Endif

MARQ     := MV_PAR01
MDIR     := MV_PAR03
MCAMINHO := ALLTRIM(MDIR)+ALLTRIM(MARQ)

_aCampos := {}
AADD(_aCampos,{"IDENT"   ,"N",1, 0})
AADD(_aCampos,{"TIPOASS" ,"N",2, 0})
AADD(_aCampos,{"TIPOENT" ,"N",1, 0})
AADD(_aCampos,{"GENERICO","C",20,0})
AADD(_aCampos,{"LIXO"    ,"C",3, 0})
AADD(_aCampos,{"NUMPED"  ,"C",6, 0})
AADD(_aCampos,{"ITEM"    ,"C",2, 0})
AADD(_aCampos,{"NOME"    ,"C",50,0})
AADD(_aCampos,{"DEST"    ,"C",50,0})
AADD(_aCampos,{"VAGO"    ,"C",20,0})
AADD(_aCampos,{"CAPA"    ,"C",1, 0})
AADD(_aCampos,{"QTDE"    ,"N",5, 0})
AADD(_aCampos,{"V_END"   ,"C",50,0})
AADD(_aCampos,{"COMPL"   ,"C",30,0})
AADD(_aCampos,{"BAIRRO"  ,"C",30,0})
AADD(_aCampos,{"CEP"     ,"C",8, 0})
AADD(_aCampos,{"MUN"     ,"C",30,0})
AADD(_aCampos,{"EST"     ,"C",2, 0})

/* Danilo 20040401
AADD(_aCampos,{"FONE"    ,"C",12,0})
AADD(_aCampos,{"REFEREN" ,"C",30,0})
AADD(_aCampos,{"ROTA"    ,"C",12,0})
AADD(_aCampos,{"ROTEIRO" ,"C",6, 0})
AADD(_aCampos,{"PORTE"   ,"C",1, 0})
AADD(_aCampos,{"CODDEST" ,"C",6, 0})
*/   
// 20040401
AADD(_aCampos,{"FONE"  ,"C",30, 0})
AADD(_aCampos,{"REFEREN","C",30, 0})
AADD(_aCampos,{"CARRO"     ,"N",4, 0})
AADD(_aCampos,{"ROTA"      ,"C",4, 0})
AADD(_aCampos,{"AGENTE"    ,"N",6, 0})
AADD(_aCampos,{"ROTEIRO"   ,"C",6, 0}) 
AADD(_aCampos,{"LIXO1"      ,"C",3, 0}) 
AADD(_aCampos,{"PORTE"   ,"C",1, 0})

// ateh aki 20040401

_cNome := CriaTrab(_aCampos,.t.)
MsAguarde({|| dbUseArea(.T.,, _cNome,"PFAT066",.F.,.F.)},"Criando arquivo temporario...")

IF MV_PAR02 == 1
   DBSELECTAREA("PFAT066")
   bBloco := "APPEND FROM &MCAMINHO SDF"
   //APPEND FROM &MCAMINHO SDF
   APPEND FROM &MCAMINHO SDF
   MsAguarde({|| bBloco},"Apendando arquivo temporario...")
   MSUNLOCK()
   DBGOTOP()
ENDIF

IF MV_PAR02 == 2
   DBSELECTAREA("PFAT066")
   bBloco := "APPEND FROM &MCAMINHO DELIMITED"
   //APPEND FROM &MCAMINHO DELIMITED
   MsAguarde({|| bBloco},"Apendando arquivo temporario...")
   MSUNLOCK()
   DBGOTOP()
ENDIF

IF MV_PAR02 == 3
   DBSELECTAREA("PFAT066")
   bBloco := "APPEND FROM &MCAMINHO"
   //APPEND FROM &MCAMINHO
   MsAguarde({|| bBloco},"Apendando arquivo temporario...")
   MSUNLOCK()
   DBGOTOP()
ENDIF

IF MV_PAR04 == 1 .OR. MV_PAR04 == 3
   DBSELECTAREA("PFAT066")
   DBGOTOP()
   lEnd := .F.
   Processa({|lEnd| ATUALIZA(@lEnd)}, "Aguarde", "Atualizando o arquivo de etiquetas...",.t.) 
ENDIF

IF MV_PAR04==2 .OR. MV_PAR04==3
   wnrel := SetPrint(cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,.F.)
   SetDefault(aReturn,cString)
   If nLastKey == 27
      DBCLOSEAREA()
      Return
   Endif
      
   DBSELECTAREA("PFAT066")
   cIndex:=CriaTrab(Nil,.F.)
   cKey  :="PORTE+CEP"
   Indregua("PFAT066",cIndex,ckey,,,"Selecionando Registros do Arq")
   cChave := IndexKey()
   cFiltro:='PORTE >= "'+MV_PAR06+'" .AND. PORTE <= "'+MV_PAR07+'"'
   cInd:= CriaTrab(nil,.f.)
   IndRegua("PFAT066",cIndex,cChave,,cFiltro,"Filtrando ..")
   DBGOTOP()
   lEnd := .F.
   Processa({|lEnd| IMPRIME(@lEnd)},"Aguarde", "Preparando Geracao do Arquivo...",.t.)
ENDIF

DBSELECTAREA("PFAT066")
DBGOTOP()

MARQ :='\SIGA\TRANSFO\CORREIO\PFAT066.DBF'
COPY TO &MARQ VIA "DBFCDXADS" // 20121106 

DBSELECTAREA("PFAT066")
DBCLOSEAREA()

DbSelectArea("SC6")
Retindex("SC6")

Return

Static FUNCTION ATUALIZA()

DBSELECTAREA("PFAT066")
DBGOTOP()
ProcRegua(RecCount())
WHILE !EOF() .and. !lEnd 
	//teste 20040401
	if NUMPED = "283760" .or. numped = "388045" .or. NUMPED ="392755"
		msgalert("Achou "+ NUMPED)
	endif

	MPEDIDO  := ""
	MNOMECLI := ""
	MNOMEDEST:= ""
	MEND     := ""
	MBAIRRO  := ""
	MMUN     := ""
	MCEP     := ""
	MEST     := ""
	MFONE    := ""
	MCODDEST :=""
	MPRODUTO :=""
	MROTEIRO :=""
	MPORTE   :=""
	IncProc("Aguarde - Lendo Registro -> "+STR(RECNO()))
	
	DBSELECTAREA("PFAT066")
	MPEDIDO  := NUMPED
	MITEM    := ITEM
	MPRODUTO := MV_PAR05
	
	IF Empty(MPEDIDO)
		RecLock("PFAT066",.f.)
		DBDELETE()
		MsUnlock()
		DBSKIP()
		LOOP
	ENDIF
	
	IF VAL(ROTEIRO) == 0 .AND. VAL(ROTA) == 0
		MROTEIRO := 'ECT'
	ELSE
		MROTEIRO := 'TRF'
	ENDIF
	
	DBSELECTAREA("SC6")
	If DBSEEK(xfilial("SC6")+MPEDIDO+MITEM)
		MPORTE := C6_TPPORTE
		Reclock("SC6",.F.)
		REPLACE C6_ROTEIRO WITH MROTEIRO
		MSunlock()
	ENDIF
	
	DBSELECTAREA('PFAT066')
	Reclock("PFAT066",.F.)
	REPLACE PORTE WITH MPORTE
	MSunlock()
	DBSKIP()
END

If lEnd
   		MsgAlert("Processamento interrompido pelo usuario. Verifique a integridade do arquivo.","Atencao")
EndIf

RETURN

Static FUNCTION IMPRIME()
   SETPRC(0,0)
   LIN    := 0
   COL    := 1
   LI     := 0
   MCONTA := 0
   DBSELECTAREA('PFAT066')
   DbGoTop()
   DELETE ALL FOR VAL(ROTEIRO)<>0
   DELETE ALL FOR VAL(ROTA)<>0
   DELETE ALL FOR EMPTY(NUMPED)
   DELETE ALL FOR EMPTY(NOME)
   //   ProcRegua(RecCount()) /**********estava como set regua*************/
   DbCommit()
   Pack
   DBGOTOP()
   ProcRegua(RecCount())
   WHILE !EOF() .and. !lEnd
      If IDENT == 0
      	DBSELECTAREA('PFAT066')
      	DbSkip()
      EndIf
      nRecno := Recno()
      @ LIN + LI, 001 PSAY Padr(ALLTRIM(NOME),40)
      DBSELECTAREA('PFAT066')
      DBSKIP()
      @ LIN + LI, 043 PSAY Padr(ALLTRIM(NOME),40)
      DBSELECTAREA('PFAT066')
      DBSKIP()
      @ LIN + LI, 087 PSAY Padr(ALLTRIM(NOME),40)
      DBSELECTAREA('PFAT066')
      dbGoto(nRecno)
      LI++
      
      @ LIN + LI, 001 PSAY Padr(ALLTRIM(DEST),40)
      DBSELECTAREA('PFAT066')
      DBSKIP()
      @ LIN + LI, 043 PSAY Padr(ALLTRIM(DEST),40)
      DBSELECTAREA('PFAT066')
      DBSKIP()
      @ LIN + LI, 087 PSAY Padr(ALLTRIM(DEST),40)
      DBSELECTAREA('PFAT066')
      dbGoto(nRecno)
      LI++
      
      @ LIN + LI, 001 PSAY Padr(ALLTRIM(V_END),40)
      DBSELECTAREA('PFAT066')
      DBSKIP()
      @ LIN + LI, 043 PSAY Padr(ALLTRIM(V_END),40)
      DBSELECTAREA('PFAT066')
      DBSKIP()
      @ LIN + LI, 087 PSAY Padr(ALLTRIM(V_END),40)
      DBSELECTAREA('PFAT066')
      dbGoto(nRecno)
      LI++
      
      @ LIN + LI, 001 PSAY Padr(ALLTRIM(BAIRRO)+'       '+'('+NUMPED+')',40)
      DBSELECTAREA('PFAT066')
      DBSKIP()
      @ LIN + LI, 043 PSAY Padr(ALLTRIM(BAIRRO)+'       '+'('+NUMPED+')',40)
      DBSELECTAREA('PFAT066')
      DBSKIP()     
      @ LIN + LI, 087 PSAY Padr(ALLTRIM(BAIRRO)+'       '+'('+NUMPED+')',40)
      DBSELECTAREA('PFAT066')
      dbGoto(nRecno)
      LI++
      
      @ LIN + LI,001 PSAY Padr(SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +ALLTRIM(MUN)+' ' +ALLTRIM(EST),40)
      DBSELECTAREA('PFAT066')
      DBSKIP()
      @ LIN + LI,043 PSAY Padr(SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +ALLTRIM(MUN)+' ' +ALLTRIM(EST),40)
      DBSELECTAREA('PFAT066')
      DBSKIP()
      @ LIN + LI,087 PSAY Padr(SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +ALLTRIM(MUN)+' ' +ALLTRIM(EST),40)
      LI++
      DBSELECTAREA('PFAT066')
      DBSKIP()

      LI := 2
      setprc(0,0)
      lin:=prow()
      IncProc("Gerando registro: "+Str(Recno()))
   END
   DBGOTOP()

   If lEnd
   		MsgAlert("Processamento interrompido pelo usuario. Verifique a integridade do arquivo.","Atencao")
   EndIf

   COUNT TO MCONTA

   @ LIN+LI  ,001 PSAY '****************************************'
   @ LIN+LI+1,001 PSAY 'TOTAL DO PORTE '+MV_PAR06+' A '+MV_PAR07+'..:'+STR(MCONTA,7)
   @ LIN+LI+2,001 PSAY '****************************************'

   SET DEVICE TO SCREEN

   IF aRETURN[5] == 1
      Set Printer to
      dbcommitAll()
      ourspool(WNREL)
   ENDIF

   MS_FLUSH()

RETURN