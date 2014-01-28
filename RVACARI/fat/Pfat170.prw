#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*/ 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT170   ³Autor: DANILO C S PALA        ³ Data:   20060829 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descricao: ATUALIZAR ZZV COM PAGAMENTO DOS AUTORES SEGUNDO OS PARAMETROS³ ±±
±±³ 				          											 ³ ±±
±±³  sp_dirautpgaut(in_datade => :in_datade,							 ³ ±±
±±³                 in_dataate => :in_dataate,							 ³ ±±
±±³                 in_autorde => :in_autorde,							 ³ ±±
±±³                 in_autorate => :in_autorate,						 ³ ±±
±±³                 in_datapg => :in_datapg,							 ³ ±±
±±³                 in_valorminimo => :in_valorminimo,					 ³ ±±
±±³                 in_igpm => :in_igpm);								 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PFAT170()

SetPrvt("CPERG, lend, cMsg, aRet")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros     ³
//³ FAT170									 ³
//³ MV_PAR01 DATADE							 ³
//³ MV_PAR02 DATAATE						 ³
//³ MV_PAR03 AUTORDE						 ³
//³ MV_PAR04 AUTORAET						 ³
//³ MV_PAR05 VALOR MINIMO					 ³
//³ MV_PAR06 VALOR IGPM						 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

CPERG := 'FAT170'
IF !PERGUNTE(CPERG)
	RETURN
ENDIF

lEnd := .F.

Processa({|lEnd| ProcArq(@lEnd)})
Return



Static Function ProcArq()
DbSelectArea("zzv")
if RDDName() <> "TOPCONN"
		MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
		Return nil
endif

//verifica se o igpm para o mes ja existe caso contrario insere 20061031
DBSELECTAREA("ZZX")
DBSETORDER(1)
/*If DBSEEK(xFilial("ZZX")+STOD(SUBSTR(DTOS(DDATABASE),1,6)+'01')) //EXISTE: ATUALIZAR
	RECLOCK("ZZX",.F.)
		ZZX->ZZX_INDICE := MV_PAR06
	MsUnlock()                                                                                           
ELSE //NAO EXISTE: INSERIR
	RECLOCK("ZZX",.T.)
		ZZX->ZZX_INDICE := MV_PAR06
		ZZX->ZZX_DATA := STOD(SUBSTR(DTOS(DDATABASE),1,6)+'01')
		ZZX->ZZX_FILIAL := XFILIAL("ZZX")
	MsUnlock()                                                                                           
ENDIF
  */
//Verifica se a Stored Procedure Teste existe no Servidor
If TCSPExist("SP_DIRAUTPGAUT")
	//SP_DIRAUTPGAUT(IN_DATADE VARCHAR2, IN_DATAATE VARCHAR2, IN_AUTORDE VARCHAR2, IN_AUTORATE VARCHAR2, IN_DATAPG VARCHAR2, IN_VALORMINIMO NUMBER, IN_IGPM NUMBER) is
	aRet := TCSPExec("SP_DIRAUTPGAUT", dtos(mv_par01), dtos(mv_par02), MV_PAR03, MV_PAR04, DTOS(DDATABASE), MV_PAR05, MV_PAR06)

cMsg:= "Processamento finalizado!"+ chr(13)+ "Execute o relatorio de direitos autorais"
MSGINFO(cMsg)
EndIf

Return

