#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02
/*/ Alterado por Danilo C S Pala em 20040831 somente 2 clientes por pagina  
Danilo C S Pala, 20050419: nota e serie //20050603: corrigir erro nota para relatorio
//Danilo C S Pala 20060329: dados de enderecamento do DNE
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ฑฑ
ฑฑณPrograma: PFAT057   ณAutor: Raquel Farias          ณ Data:   20/08/99 ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณDescriao: Relatขrio assinantes - Editora Pini                        ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณUso      : Mขdulo de Faturamento                                      ณ ฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู ฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ ฑฑ
ฑฑณAlteraฦo           ณAlterado por: Raquel Farias   ณ Data:   10/04/00 ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณDescriฦo: Substitui  edfin por edvenc a pedido da Solange            ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณLiberado para Usu rio em: 10/04/00                                    ณ ฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด ฑฑ
ฑฑณAlteracao - Gilberto A. de Oliveira Jr. 02/10/00 - Conversao p/Windowsณ ฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู ฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function Pfat057()

SetPrvt("CCABEC1,CCABEC2,NCARACTER,ARETURN,CPROGRAMA,CPERG")
SetPrvt("NLASTKEY,M_PAG,LCONTINUA,L,CBTXT,CBCONT")
SetPrvt("NORDEM,ALFA,Z,M,TAMANHO,CDESC1")
SetPrvt("CDESC2,CDESC3,CSTRING,MDTSIS,MTIME,MEMPRESA")
SetPrvt("MCONTA,MCONTA1,MCONTA2,MCONTA3,_CARQPATH,CTITULO")
SetPrvt("MARQUIVO1,MARQUIVO2,TITULO,WNREL,_ACAMPOS,_CNOME")
SetPrvt("CARQ,CINDEX,CKEY,CCHAVE,CFILTRO,MEQUI2")
SetPrvt("MREG2,MVEND2,_CGRAVA,MCHAVE,MRECO,MCHAVE2")
SetPrvt("MPED,MPEDIDO,MITEM,MCODCLI,MCODDEST,MCODPROD")
SetPrvt("MEDIN,MEDVENC,MEDSUSP,MVALOR,MCF,MTES")
SetPrvt("MDUPL,MSIT,MVEND,MVEND1,MREGIAO,MCODREV")
SetPrvt("MEQUIPE,MCODVEND,MTITULO,MDTVENC,MNOMECLI,MEND")
SetPrvt("MBAIRRO,MMUN,MEST,MCEP,MFONE,MFAX")
SetPrvt("MEMAIL,MDEST,MCGC,MCODATIV,MFONE1,CTD")
SetPrvt("LIN,COL,LI,MPORTE,MPEDRENOV, mgrat, nnextpage, MNOTA, MSERIE")
Private mHora := TIME()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                                       ณ
//ณ mv_par01             // Regiฦo Inicial    C-3                              ณ
//ณ mv_par02             // Regiฦo Final      C-3                              ณ
//ณ mv_par03             // Vendedor Inicial  C-6                              ณ
//ณ mv_par04             // Vendedor Final    C-6                              ณ
//ณ mv_par05             // Pagas  Gratuกtas  Ambas  N-1                       ณ
//ณ mv_par06             // Renovaฦo Recuperaฦo Representaไes  Nenhum   N-1 ณ
//ณ mv_par07             // Cancelados Ativos-Rep Ativos-Sel      Nennum   N-1 ณ       ณ
//ณ mv_par08             // Cep Inicial       C-8                              ณ
//ณ mv_par09             // Cep Final         C-8                              ณ
//ณ mv_par10             // Relatขrio Arquivo Etiqueta                         ณ
//ณ mv_par11             // Do produto        C-15                             ณ
//ณ mv_par12             // At produto       C-15                             ณ
//ณ mv_par13             // Qtde Selecionada  N-7                              ณ
//ณ mv_par14             // Da  Situaฦo      C-2                              ณ
//ณ mv_par15             // At Situaฦo      C-2                              ณ
//ณ mv_par16             // Da Atividade      C-7                              ณ
//ณ mv_par17             // At Atividade     C-7                              ณ
//ณ mv_par18            // Da Porte          C-1                               ณ
//ณ mv_par19            // AtPorte          C-1                               ณ
//ณ                                                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

cCabec1   := ' '
cCabec2   := ' '
nCaracter := 10
aReturn   := { "Especial", 1,"Administraฦo", 1, 2, 1," ",1 }
cPrograma := "PFAT057"
cPerg     := "PFAT21"
nLastKey  := 0
M_PAG     := 1
lContinua := .T.
L         := 0
CbTxt     := ""
CbCont    := ""
nOrdem    := 0
Alfa      := 0
Z         := 0
M         := 0
tamanho   := "P"
cDesc1    := PADC("Importante!:Rodar o programa que gera o arquivo correspondente " ,74)
cDesc2    := PADC("aos parametros selecionados",74)
cDesc3    := " "
lContinua := .T.
cString   := "SA1"
MDTSIS    := DTOC(DATE())
MTIME     := SUBS(TIME(),1,2)+SUBS(TIME(),4,2)
MEMPRESA  := SM0->M0_CODIGO
MCONTA    := 0
MCONTA1   := 0
MCONTA2   := 0
MCONTA3   := 0       
mnota := space(6)
mserie := space(3)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica as perguntas selecionadas                                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !PERGUNTE(cPerg)
	Return
Endif

_cArqPath:= GETMV("MV_PATHASS")   // GILBERTO - 02/10/00
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define arquivo de trabalho e cabecalhos                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
IF MV_PAR06 == 1
	cTitulo := ' **** RENOVA€ๅES **** '
	DO CASE
		CASE MEMPRESA == '01'
			MARQUIVO1 := _cArqPath+'RENOV01.DTC'//".DBF" //20121106.DBF'
			MARQUIVO2 := 'RENOV01'
		CASE MEMPRESA == '02'
			MARQUIVO1 := _cArqPath+'RENOV02.DTC'//".DBF" //20121106.DBF'
			MARQUIVO2 := 'RENOV02'
	ENDCASE
	Titulo:=PADC("RENOVA€ๅES ",74)
ENDIF

IF MV_PAR06 == 2
	cTitulo := ' **** RECUPERA€วO **** '
	DO CASE
		CASE MEMPRESA=='01'
			MARQUIVO1 := _cArqPath+'RENOV01.DTC'//".DBF" //20121106.DBF'
			MARQUIVO2 := 'RENOV01'
		CASE MEMPRESA == '02'
			MARQUIVO1 := _cArqPath+'RENOV02.DTC'//".DBF" //20121106.DBF'
			MARQUIVO2 := 'RENOV02'
	ENDCASE
	Titulo := PADC("RECUPERA€วO ",74)
ENDIF

IF MV_PAR07 == 1
	cTitulo := ' **** CANCELADOS **** '
	DO CASE
		CASE MEMPRESA == '01'
			MARQUIVO1 := _cArqPath+'ASSCANC1.DTC'//".DBF" //20121106.DBF'
			MARQUIVO2 := 'ASSCANC1'
		CASE MEMPRESA == '02'
			MARQUIVO1 := _cArqPath+'ASSCANC2.DTC'//".DBF" //20121106.DBF'
			MARQUIVO2 := 'ASSCANC2'
	ENDCASE
	Titulo:=PADC("CANCELADOS ",74)
ENDIF

IF MV_PAR07==2
	cTitulo:= ' **** ATIVOS **** '
	DO CASE
		CASE MEMPRESA=='01'
			MARQUIVO1:=_cArqPath+'ASSAT01.DTC'//".DBF" //20121106.DBF'
			MARQUIVO2:='ASSAT01'
		CASE MEMPRESA=='02'
			MARQUIVO1:=_cArqPath+'ASSAT02.DTC'//".DBF" //20121106.DBF'
			MARQUIVO2:='ASSAT02'
	ENDCASE
	Titulo:=PADC("ATIVOS ",74)
ENDIF

IF MV_PAR07==3
	cTitulo:= ' **** ATIVOS - SELECAO **** '
	DO CASE
		CASE MEMPRESA == '01'
			MARQUIVO1 := _cArqPath+'ASSSEL01.DTC'//".DBF" //20121106.DBF'
			MARQUIVO2 := 'ASSSEL01'
		CASE MEMPRESA == '02'
			MARQUIVO1 := _cArqPath+'ASSSEL02.DTC'//".DBF" //20121106.DBF'
			MARQUIVO2 := 'ASSSEL02'
	ENDCASE
	Titulo := PADC("ATIVOS ",74)
ENDIF

IF MV_PAR10==1 .OR. MV_PAR10==3
	wnrel := MARQUIVO2
	wnrel := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)
	SetDefault(aReturn,cString)
	If nLastKey == 27
		Return
	Endif
ENDIF
_aCampos := {}
AADD(_aCampos,{"NUMPED","C",6,0})
AADD(_aCampos,{"ITEM","C",2,0})
AADD(_aCampos,{"CODCLI","C",6,0})
AADD(_aCampos,{"CODDEST","C",6,0})
AADD(_aCampos,{"NOME","C",40,0})
AADD(_aCampos,{"DEST","C",40,0})
AADD(_aCampos,{"V_END","C",120,0})
AADD(_aCampos,{"BAIRRO","C",20,0})
AADD(_aCampos,{"MUN","C",20,0})
AADD(_aCampos,{"CEP","C",8,0})
AADD(_aCampos,{"EST","C",2,2})
AADD(_aCampos,{"FONE","C",15,0})
AADD(_aCampos,{"FAX","C",15,0})
AADD(_aCampos,{"EMAIL","C",40,0})
AADD(_aCampos,{"CGC","C",20,0})
AADD(_aCampos,{"CODPROD","C",15,0})
AADD(_aCampos,{"TITULO","C",30,0})
AADD(_aCampos,{"CODVEND","C",6,0})
AADD(_aCampos,{"EDIN","N",4,0})
AADD(_aCampos,{"EDVENC","N",4,0})
AADD(_aCampos,{"EDSUSP","N",4,0})
AADD(_aCampos,{"VALOR","N",12,2})
AADD(_aCampos,{"SITUAC","C",2,0})
AADD(_aCampos,{"CF","C",5, 0})
AADD(_aCampos,{"CODATIV","C",7,0})
AADD(_aCampos,{"DTVENC","C",8,0})
AADD(_aCampos,{"PORTE","C",1,0})
AADD(_aCampos,{"PEDRENOV","C",6,0})  
AADD(_aCampos,{"NOTA" ,"C",9,0}) //mp10
AADD(_aCampos,{"SERIE" ,"C" ,3 ,0})


_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"PFAT57",.F.,.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria indice                                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cArq := MARQUIVO1
dbUseArea( .T.,, cArq,MARQUIVO2, if(.F. .OR. .F., !.F., NIL), .F. )
dbSelectArea(MARQUIVO2)

cArq := MARQUIVO2
IF MV_PAR06 == 1 .OR. MV_PAR06==2 .OR. MV_PAR07==1 .AND. MV_PAR10==1
	cIndex := CriaTrab(Nil,.F.)
	cKey   := "NOVAREG+EQUIPE+NOVOVEND+CEP+CODCLI+CODDEST"
	Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")
	dbGotop()
ENDIF

IF MV_PAR07 == 2 .AND. MV_PAR10 == 1
	cIndex := CriaTrab(Nil,.F.)
	cKey   := "NOVAREG+NOVOVEND+NOME+CODCLI+CODDEST"
	Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")
	dbGoTop()
ENDIF

IF MV_PAR07 == 3 .AND. MV_PAR10 == 1
	cIndex := CriaTrab(Nil,.F.)
	cKey   := "NOVAREG+NOVOVEND+CEP+CODCLI+CODDEST"
	Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")
	dbGoTop()
ENDIF

IF MV_PAR10==2 .OR. MV_PAR10==3
	cIndex := CriaTrab(Nil,.F.)
	cKey   := "CEP+CODCLI+CODDEST"
	Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")
	dbGotop()
ENDIF

cChave  := IndexKey()
cFiltro :='CEP >= "'+MV_PAR08+'" .AND. CEP <= "'+MV_PAR09+'"'
cFiltro += ' .AND.NOVAREG >= "'+MV_PAR01+'" .AND. NOVAREG <= "'+MV_PAR02+'"'
cFiltro += ' .AND.NOVOVEND >= "'+MV_PAR03+'" .AND. NOVOVEND <= "'+MV_PAR04+'"'
cFiltro += ' .AND.CODPROD >= "'+MV_PAR11+'" .AND. CODPROD <= "'+MV_PAR12+'"'
cFiltro += ' .AND.SITUAC >= "'+MV_PAR14+'" .AND. SITUAC <= "'+MV_PAR15+'"'
cFiltro += ' .AND. CODATIV >= "'+MV_PAR16+'" .AND. CODATIV <= "'+MV_PAR17+'"'
cFiltro += ' .AND. PORTE >= "'+MV_PAR18+'" .AND. PORTE <= "'+MV_PAR19+'"'
cIndex  := CriaTrab(nil,.f.)
IndRegua(cArq,cIndex,cChave,,cFiltro,"Filtrando ..")
dbGoTop()

If MV_PAR10==1 .OR. MV_PAR10==3
	RptStatus({|| RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>       RptStatus({|| Execute(RptDetail)})
ElseIf MV_PAR10 == 2
	Processa( {||RptDetail()})// Substituido pelo assistente de conversao do AP5 IDE em 25/02/02 ==>       Processa( {||Execute(RptDetail)})
Endif
Return

Static Function RptDetail()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Inกcio do relatขrio                                          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
IF MV_PAR10==1
	DbSelectArea(mArquivo2)
	SetRegua(RecCount())
	DbGotop()
	While !EOF()
		DbSelectArea(mArquivo2)
		Atualiza()

		//20031031
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Verifica se  1:pago /2:cortesia /3:ambas                    ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSelectArea("SF4")
		DbSetOrder(1)
		DbGoTop()
		DbSeek(xFilial("SF4")+MTES)
		If SF4->F4_DUPLIC=='N' .OR. 'CORTESIA' $(SF4->F4_TEXTO) .OR. 'DOACAO' $(SF4->F4_TEXTO)
			mGrat:='S'
		Else
			mGrat:='N'
		EndIf
		If (MV_PAR05 = 1 .and. mGrat='S') //pago
			DBSELECTAREA(MARQUIVO2)
			DBSKIP()
			LOOP
		Elseif (MV_PAR05 = 2 .and. mGrat<>'S')
			DBSELECTAREA(MARQUIVO2)
			DBSKIP()
			LOOP
		Endif     //ateh aki 20031031
		
		RELACIONA()
		IMPRIME()
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Movimenta Regua Processamento                                ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		IncRegua()
		
		dbSelectArea(mArquivo2)
		mEqui2 :=EQUIPE
		mReg2  :=NOVAREG
		mVend2 :=NOVOVEND
		mConta1:=MCONTA1+1
		
		If mEqui2<>mEquipe .Or. mReg2<>mRegiao .Or. mVend2<>mVend
			@ L+1,05 PSAY 'TOTAL DE ASSINANTES....'+STR(MCONTA1,7)
			@ L+2,05 PSAY 'TOTAL DE ASSINATURAS...'+STR(MCONTA3,7)
			L:=0
			MCONTA1:=0
			MCONTA3:=0
		Endif
	End
	
	@ L+1,05 PSAY 'TOTAL GERAL ASSINATURAS......'+STR(MCONTA,7)
	L:=0
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Termino do Relatorio                                         ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	SET DEVICE TO SCREEN
	IF aRETURN[5] == 1
		Set Printer to
		dbcommitAll()
		ourspool(WNREL)
	ENDIF
	MS_FLUSH()
ENDIF

IF MV_PAR10==2
	ProcRegua(Reccount())
	
	WHILE !EOF()
		
		IncProc()
		MCONTA := MCONTA+1
		DBSELECTAREA(MARQUIVO2)
		Atualiza()
		//20031031
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Verifica se  1:pago /2:cortesia /3:ambas                    ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSelectArea("SF4")
		DbSetOrder(1)
		DbGoTop()
		DbSeek(xFilial("SF4")+MTES)
		If SF4->F4_DUPLIC=='N' .OR. 'CORTESIA' $(SF4->F4_TEXTO) .OR. 'DOACAO' $(SF4->F4_TEXTO)
			mGrat:='S'
		Else
			mGrat:='N'
		EndIf
		If (MV_PAR05 = 1 .and. mGrat='S') //pago
			DBSELECTAREA(MARQUIVO2)
			DBSKIP()
			LOOP
		Elseif (MV_PAR05 = 2 .and. mGrat<>'S')
			DBSELECTAREA(MARQUIVO2)
			DBSKIP()
			LOOP
		Endif     //ateh aki 20031031
		
		RELACIONA()
		GRAVA_TEMP()
		DBSELECTAREA(MARQUIVO2)
		DBSKIP()
	END
	
	DBSELECTAREA("PFAT57")
	DBGOTOP()
	_cGrava:= _cArqPath+"PF057_"+SUBS(MHORA,7,2)+".DBF"
	COPY TO &_cGrava VIA "DBFCDXADS" // 20121106 
	MsgAlert("Arquivo gerado: "+_cGrava)
ENDIF

IF MV_PAR10==3
	DbSelectArea(MARQUIVO2)
	SetRegua(RecCount())
	dbGotop()
	
	While !EOF()
		dbSelectArea(mArquivo2)
		Atualiza()
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Elimina duplicidade por codigo de cliente e destinat rio     ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		DbSelectArea(mArquivo2)
		MCHAVE :=CODCLI+CODDEST
		MRECO  :=RECNO()
		
		While !Eof()
			dbSkip()
			MCHAVE2 := CODCLI+CODDEST
			IF MCHAVE2 == MCHAVE
				RecLock(mArquivo2,.f.)
				DBDELETE()
				MsUnlock()
			ELSE
				DBGOTO(MRECO)
				EXIT
			ENDIF
		END
		
		RELACIONA()
		GRAVA_TEMP()
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Movimenta Regua Processamento                                ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		IncRegua()
		DBSELECTAREA(MARQUIVO2)
		DBSKIP()
	END
	ETIQUETA()
ENDIF

DbSelectArea("PFAT57")
DbCloseArea()
DbSelectArea(MARQUIVO2)
DbCloseArea()
DbSelectArea("SZJ")
Retindex("SZJ")
DbSelectArea("SA1")
Retindex("SA1")
DbSelectArea("SB1")
Retindex("SB1")
DbSelectArea("SZO")
Retindex("SZO")
DbSelectArea("SZN")
Retindex("SZN")
DbSelectArea("SF4")
Retindex("SF4")
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtualiza  บAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Atualiza()

dbSelectArea(mArquivo2)

MPED     := NUMPED
MPEDIDO  := NUMPED
MITEM    := ITEM
MCODCLI  := CODCLI
MCODDEST := CODDEST
MCODPROD := CODPROD
MEDIN    := EDIN
MEDVENC  := EDVENC
MEDSUSP  := EDSUSP
MVALOR   := VALOR
MCF      := ALLTRIM(CF)
MTES     := ALLTRIM(TES)
MDUPL    := ALLTRIM(DUPL)
MSIT     := SITUAC
MCODCLI  := CODCLI
MVEND    := NOVOVEND
MVEND1   := CODVEND
MREGIAO  := NOVAREG
MCODREV  := CODREV
MEQUIPE  := EQUIPE
MCODVEND := CODVEND
MPORTE   := PORTE
MPEDRENOV:= PEDRENOV          
If MV_PAR10==2
	MNOTA 	 := NOTA  //20050419
	MSERIE	 := SERIE  //20050419
Endif
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRelaciona บAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Relaciona()

DbSelectArea("SB1")
If DbSeek(xFilial()+MCODPROD)
	mTitulo := SB1->B1_TITULO
	If Empty(mTitulo)
		mTitulo := Subs(SB1->B1_DESC,1,13)
	Endif
Else
	mTitulo := '  '
Endif

DbSelectArea("SZJ")
If DbSeek(xFilial()+MCODREV+STR(MEDVENC,4,0))
	MDtVenc := DTOC(SZJ->ZJ_DTCIRC)
Else
	mDtVenc := '  '
Endif

DbSelectArea("SA1")
If DbSeek(xFilial()+MCODCLI)
	mNomeCli := SA1->A1_NOME
	mEnd     := ALLTRIM(SA1->A1_TPLOG) + " " + ALLTRIM(SA1->A1_LOGR) + " " + ALLTRIM(SA1->A1_NLOGR) + " " + ALLTRIM(SA1->A1_COMPL) //20060329
	mBairro  := SA1->A1_BAIRRO
	mMun     := SA1->A1_MUN
	mEst     := SA1->A1_EST
	mCEP     := SA1->A1_CEP
	mFone    := SA1->A1_TEL
	mFax     := SA1->A1_FAX
	mEmail   := SA1->A1_EMAIL
	mDest    := SPACE(40)
	mCGC     := SA1->A1_CGC
	mFone    := SA1->A1_TEL
	mCodAtiv := SA1->A1_ATIVIDA
Else
	mNomeCli := SPACE(40)
Endif

If mNomeCli<> '  '
	If mCodDest#' '
		DbSelectArea("SZN")
		DbSeek(xFilial()+mCodCli+mCodDest)
		If Found()
			mDest := SZN->ZN_NOME
		Endif
		
		DbSelectArea("SZO")
		DbSeek(xFilial()+mCodCli+mCodDest)
		If Found()
			mEnd    := ALLTRIM(SZO->ZO_TPLOG) + " " + ALLTRIM(SZO->ZO_LOGR) + " " + ALLTRIM(SZO->ZO_NLOGR) + " " + ALLTRIM(SZO->ZO_COMPL) //20060329
			mBairro := SZO->ZO_BAIRRO
			mMun    := SZO->ZO_CIDADE
			mEst    := SZO->ZO_ESTADO
			mCEP    := SZO->ZO_CEP
			mFone1  := SZO->ZO_FONE
			If mFone1<>'  '
				mFone:=mFone1
			Endif
		Endif
	Endif
Endif
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCheca1()  บAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION CHECA1()

IF L <> 0
	IF L >= 64
		Roda(0,"",tamanho)
		L := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho,nCaracter)
		L++
		//L := 0
	ELSE
		L++
	ENDIF
ENDIF
RETURN


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCheca3()  บAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION CHECA3()

IF L <> 0
	IF L >= 64
		Roda(0,"",tamanho)
		L := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho,nCaracter)
		L++
		//L := 0
	ELSE
		L++
	ENDIF
ENDIF
RETURN


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCheca2()  บAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION CHECA2()

IF L == 0
	L := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho,nCaracter)
	L += 2
	//L := 4
	@ L,00 PSAY REPLICATE('*',79)
	//L := 6
	@ L,01 PSAY 'REGIAO: '+MREGIAO +' '+  'REPRES.....:' + MVEND +'   '+'EQUIPE...:'+MEQUIPE
	L += 2
	
ENDIF
RETURN


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCabec2    บAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION CABEC2()

@ L,00 PSAY 'TITULO'
@ L,25 PSAY 'PEDIDO'
@ L,32 PSAY 'ITEM'
@ L,37 PSAY 'SUSP'
@ L,42 PSAY 'ED.INI'
@ L,49 PSAY 'ED.VEN'
@ L,57 PSAY 'VENC'
@ L,65 PSAY 'VALOR'
@ L,73 PSAY 'VEND'
RETURN


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExtrato   บAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION EXTRATO()

@ L,00 PSAY '('+MSIT+')'+SUBS(TRIM(MCODPROD),1,7)+' '+SUBS(TRIM(MTITULO),1,13)
@ L,25 PSAY TRIM(MPEDIDO)
@ L,32 PSAY TRIM(MITEM)
@ L,37 PSAY MEDSUSP
@ L,42 PSAY MEDIN
@ L,49 PSAY MEDVENC
@ L,57 PSAY MDTVENC
@ L,65 PSAY TRIM(STR(MVALOR,7,2))
@ L,73 PSAY TRIM(MVEND1)
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
CHECA3()
CHECA2()

DBSELECTAREA(MARQUIVO2)
MCHAVE  := CODCLI+CODDEST
MCHAVE2 := CODCLI+CODDEST
@ L,01   PSAY 'COD CLI...: '+MCODCLI
@ L,27   PSAY 'COD DEST..: '+MCODDEST
@ L,57   PSAY 'FONE....:'   +TRIM(MFONE)
@ L+1,01 PSAY 'NOME......: '+MNOMECLI
@ L+1,57 PSAY 'CPF/CGC.:'   +TRIM(MCGC)
@ L+2,01 PSAY 'DEST......: '+MDEST
@ L+2,57 PSAY 'FAX.....: '+MFAX
@ L+3,01 PSAY 'ENDERECO..: '+MEND
@ L+4,01 PSAY 'BAIRRO....:'   +MBAIRRO
@ L+4,57 PSAY 'CID/EST.: '+TRIM(MMUN)+' '+MEST
@ L+5,01 PSAY 'EMAIL.....:'   +ALLTRIM(MEMAIL)
@ L+5,57 PSAY 'CEP.....: '+SUBS(MCEP,1,5)+'-'+SUBS(MCEP,6,3)
L:=L+6

CHECA1()
CHECA2()
CABEC2()

MCONTA  := MCONTA+1
MCONTA3 := MCONTA3+1
WHILE .T.
	DBSELECTAREA(MARQUIVO2)
	MCHAVE2 := CODCLI+CODDEST
	IF MCHAVE2 <> MCHAVE
		CHECA2()
		EXIT
	ENDIF
	DBSELECTAREA(MARQUIVO2)
	CHECA1()
	CHECA2()
	Extrato()
	IF EOF()
		EXIT
	ELSE
		DBSKIP()
		MCHAVE2 := CODCLI+CODDEST
		IF MV_PAR05 == 1
			IF SUBS(CF,2,2) == '99' .AND. MDUPL == 'N'
				DBSKIP()
				LOOP
			ENDIF
		ENDIF
		
		IF MV_PAR05 == 2
			IF SUBS(CF,2,2) <> '99' .AND. MDUPL <> 'N'
				DBSKIP()
				LOOP
			ENDIF
		ENDIF
		IF MCHAVE2 <> MCHAVE
			CHECA2()
			EXIT
		ENDIF
		MCONTA++
		MCONTA3++
		Atualiza()
		RELACIONA()
		LOOP
	ENDIF
END
IF L <> 0
//	L++ //20040831
	L := L + 15 //20040831
	@ L,00 PSAY REPLICATE('_',80)
	CTD := L
	CTD += 18
	IF CTD >= 64
		Roda(0,"",tamanho)
		L := CABEC(cTitulo,cCabec1,cCabec2,cPrograma,tamanho,nCaracter)
		L++
		// L:=0
	ELSE
		L++
	ENDIF
ENDIF
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

DBSELECTAREA("PFAT57")
Reclock("PFAT57",.t.)
REPLACE CODCLI   WITH  MCODCLI
REPLACE CODDEST  WITH  MCODDEST
REPLACE CF       WITH  MCF
REPLACE SITUAC   WITH  MSIT
REPLACE EDIN     WITH  MEDIN
REPLACE EDVENC   WITH  MEDVENC
REPLACE EDSUSP   WITH  MEDSUSP
REPLACE NOME     WITH  MNOMECLI
REPLACE DEST     WITH  MDEST
REPLACE V_END    WITH  MEND
REPLACE BAIRRO   WITH  MBAIRRO
REPLACE MUN      WITH  MMUN
REPLACE CEP      WITH  MCEP
REPLACE EST      WITH  MEST
REPLACE FAX      WITH  MFAX
REPLACE EMAIL    WITH  MEMAIL
REPLACE FONE     WITH  MFONE
REPLACE TITULO   WITH  MTITULO
REPLACE CGC      WITH  MCGC
REPLACE NUMPED   WITH  MPED
REPLACE ITEM     WITH  MITEM
REPLACE VALOR    WITH  MVALOR
REPLACE DTVENC   WITH  MDTVENC
REPLACE CODVEND  WITH  MCODVEND
REPLACE CODPROD  WITH  MCODPROD
REPLACE CODATIV  WITH  MCODATIV
REPLACE PORTE    WITH  MPORTE
REPLACE PEDRENOV WITH  MPEDRENOV   
REPLACE NOTA    WITH  MNOTA  //20050419
REPLACE SERIE    WITH  MSERIE  //20050419
MSUnlock()
RETURN


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPFAT057   บAutor  ณMicrosiga           บ Data ณ  04/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static FUNCTION ETIQUETA()

SETPRC(0,0)
LIN := 0
COL := 1
LI  := 0
DBSELECTAREA('PFAT57')
COUNT TO MCONTA
DBGOTOP()
WHILE !EOF()
	@ LIN+LI,001 PSAY NOME
	DBSKIP()
	@ LIN+LI,043 PSAY NOME
	DBSKIP()
	@ LIN+LI,087 PSAY NOME
	DBSKIP(-2)
	LI++
	
	@ LIN+LI,001 PSAY DEST
	DBSKIP()
	@ LIN+LI,043 PSAY DEST
	DBSKIP()
	@ LIN+LI,087 PSAY DEST
	DBSKIP(-2)
	LI++

//20060329 DAQUI	
	@ LIN+LI,001 PSAY SUBSTR(V_END,1,40)
	DBSKIP()
	@ LIN+LI,043 PSAY SUBSTR(V_END,1,40)
	DBSKIP()
	@ LIN+LI,087 PSAY SUBSTR(V_END,1,40)
	DBSKIP(-2)
	LI++
	
	@ LIN+LI,001 PSAY SUBSTR(V_END,41,40)
	DBSKIP()
	@ LIN+LI,043 PSAY SUBSTR(V_END,41,40)
	DBSKIP()
	@ LIN+LI,087 PSAY SUBSTR(V_END,41,40)
	DBSKIP(-2)
	LI++

	@ LIN+LI,001 PSAY SUBSTR(V_END,81,40)
	DBSKIP()
	@ LIN+LI,043 PSAY SUBSTR(V_END,81,40)
	DBSKIP()
	@ LIN+LI,087 PSAY SUBSTR(V_END,81,40)
	DBSKIP(-2)
	LI++
//20060329 ATE AKI
	
	@ LIN+LI,001 PSAY BAIRRO+'          '+'('+NUMPED+')'
	DBSKIP()
	@ LIN+LI,043 PSAY BAIRRO+'          '+'('+NUMPED+')'
	DBSKIP()
	@ LIN+LI,087 PSAY BAIRRO+'          '+'('+NUMPED+')'
	DBSKIP(-2)
	LI++
	
	@ LIN+LI,001 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
	DBSKIP()
	@ LIN+LI,043 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
	DBSKIP()
	@ LIN+LI,087 PSAY SUBS(CEP,1,5)+'-'+SUBS(CEP,6,3)+'   ' +MUN+' ' +EST
	LI++
	DBSKIP()     

	@ LIN+LI,001 PSAY "." //20060329
	LI:=LI+1              //20060329
	
	LI := 2
	setprc(0,0)
	lin := prow()
	IncRegua()
END

@ LIN+LI  ,001 PSAY '****************************************'
@ LIN+LI+1,001 PSAY 'TOTAL...................:'+STR(MCONTA,7)
@ LIN+LI+2,001 PSAY '****************************************'
@ LIN+LI+3,001 PSAY MV_PAR11+' A '+ MV_PAR12
@ LIN+LI+4,001 PSAY MV_PAR18+' A '+MV_PAR19

SET DEVICE TO SCREEN

IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()
RETURN