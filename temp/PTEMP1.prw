#include "rwmake.ch"

/* 
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Ptemp1    �Autor  �Danilo C S Pala     � Data �  20090105   ���
�������������������������������������������������������������������������͹��
���Desc.     � Preencher sx2990 com o x2_unico e x2_pyme do sx2010		  ���
���			 |	  													      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � PINI                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function PTEMP1
Private carquivo := space(20)
Private cProcedimento := space(1)
Private nConta := 0
Private cMsgFinal := space(200)
private cfop := space(4)
SetPrvt("_ACAMPOS,_CNOME, cpath")

nConta := 0
/*DBSELECTAREA("SA2")
DBSETORDER(1)
IF DbSeek(xfilial("SA2")+CCLIEFOR+CLOJA)
	CESTADO :=    SA2->A2_EST
END IF          
DBSelectArea("SA2")
DbCloseArea("SA2") */

DBUSEAREA(.T.,,"\SIGA\TEMP\SX2EDIT","SX2EDIT",.F.,.F.)
DbSelectArea("SX2EDIT")
cIndex  := CriaTrab(nil,.f.)
cChave  := "X2_CHAVE"
cFiltro := ""
IndRegua("SX2EDIT",cIndex,cChave,,cFiltro,"Indexando ...")
Dbgotop()        

DBUSEAREA(.T.,,"\SIGA\TEMP\SX2TESTE","SX2TESTE",.F.,.F.)
DbSelectArea("SX2TESTE")
cIndex  := CriaTrab(nil,.f.)
cChave  := "X2_CHAVE"
cFiltro := ""
IndRegua("SX2TESTE",cIndex,cChave,,cFiltro,"Indexando ...")
Dbgotop()         
                  
 
                                           */

/*cpath := "\SIGA\IMPORTA\"+ CARQUIVO
_aCampos := {}
AADD(_aCampos,{"LOTE"	,"N",	6,	0})
AADD(_aCampos,{"DTLOTE"	,"C",	8,	0})
AADD(_aCampos,{"NFISCAL","C",	6,	0})
AADD(_aCampos,{"SERIE"	,"C",	3,	0})
AADD(_aCampos,{"CFO"	,"C",   4,	0})
AADD(_aCampos,{"EMISSAO","C",	8,	0})
AADD(_aCampos,{"VALOR"	,"N",	14,	2})
AADD(_aCampos,{"BASEICM","N",	14,	2})
AADD(_aCampos,{"VALICM"	,"N",	14,	2})
AADD(_aCampos,{"ISENICM","N",	14,	2})
AADD(_aCampos,{"OUTRICM","N",	14,	2})
AADD(_aCampos,{"BASEIPI","N",	14,	2})
AADD(_aCampos,{"VALIPI" ,"N",	14,	2})
AADD(_aCampos,{"ISENIPI","N",	14,	2})
AADD(_aCampos,{"OUTRIPI","N",	14,	2})

_cNome := CriaTrab(_aCampos,.t.)
MsAguarde({|| dbUseArea(.T.,, _cNome,"ARQEDI",.F.,.F.)},"Criando arquivo temporario...")

//20050331 : appendar um arquivo sdf
DBSELECTAREA("ARQEDI")
   bBloco := "APPEND FROM &cpath SDF"
   APPEND FROM &cpath SDF
   MsAguarde({|| bBloco},"Apendando arquivo temporario...")
   MSUNLOCK()
   DBGOTOP()
  
*/

While !Eof()
	DBSELECTAREA("SX2EDIT")
	IF DbSeek(SX2TESTE->X2_CHAVE)
		DbSelectArea("SX2TESTE")   	
		RecLock("SX2TESTE",.F.)
			SX2TESTE->X2_UNICO := SX2EDIT->X2_UNICO
			SX2TESTE->X2_PYME := SX2EDIT->X2_PYME
		MsUnlock()
		nConta := nConta +1
	END IF          
	DbSelectArea("SX2TESTE")   	
	DBSkip()
	IncProc()                 

  end
DBSelectArea("SX2TESTE")
DbCloseArea("SX2TESTE")
DBSelectArea("SX2EDIT")
DbCloseArea("SX2EDIT")
cMsgFinal := "Processamento finalizado!" + chr(10)
cMsgFinal += "Atualizados " + Alltrim(Str(nConta))+" arquivos."
MsgAlert( cMsgFinal)

return