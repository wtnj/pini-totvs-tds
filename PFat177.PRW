#include "rwmake.ch"
#include "ap5mail.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*   
20070402: Danilo C S Pala: retirar mensagem Wagner
20070425: Danilo C S Pala: gerar arquivo com os titulos alterados
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPFAT177   บAutor  ณDanilo C S Pala     บ Data ณ  20061215   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Alterar o nosso numero dos titulos que sao gerados pelo    บฑฑ
ฑฑบ          ณ  banco													  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PFAT177
setprvt("_aCampos, _cNome, caIndex, caChave, caFiltro, cQuery, contPed, _cMsgINFO, ContSzk")
Private Memp      := SM0->M0_CODIGO
Private marquivo  := space(40) 
PRIVATE MNOSSONUM := SPACE(10)
PRIVATE MSEUNUM   := SPACE(10)
Private idlinha   := space(1)
Private ncont     := 1        
Private MHORA     := TIME()
Private cString   := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
Private cArqPath  := GetMv("MV_PATHTMP")
Private _cString  := cArqPath+cString+".DBF"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Vari veis utilizadas para parametros     ณ
//ณ MV_PAR01 ID DETALHE	 					 |
//ณ MV_PAR02 POSICAO TITULO INICIO			 ณ
//ณ MV_PAR03 POSICAO TITULO FIM				 ณ
//ณ MV_PAR04 POSICAO NOSSO NUMERO INICIO	 ณ
//ณ MV_PAR05 POSICAO NOSSO NUMERO FIM		 ณ
//ณ MV_PAR06 NOME DO ARQUIVO				 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

FARQTRAB()
Private cPerg:='FAT177' 
IF .NOT. PERGUNTE(cPerg)
   RETURN
ENDIF                               
RptStatus({|| PRETORNO()})


DbSelectArea("SAIDA")
dbGoTop()
COPY TO &_cString VIA "DBFCDXADS" // 20121106 
msginfo("Arquivo gerado: " +_cString) 
DBCLOSEAREA("SAIDA")

DBSelectArea("FONTE")
DBCLOSEAREA("FONTE")
DBSelectArea("SE1")
DBCLOSEAREA("SE1")
Return


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณPROCESSAR O ARQUIVO DE RETORNO DO BANCOณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Static Function PRETORNO()
setprvt("cString,wnrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3, wrnel, aReturn, cPrograma, tamanho")
setprvt("Li, NNUMERO, NCLIENTE")

MARQUIVO := MV_PAR06

DBSELECTAREA("FONTE")
cpath := "\SIGAADV\"+ MARQUIVO
bBloco := "APPEND FROM &cpath SDF"
APPEND FROM &cpath SDF
MsAguarde({|| bBloco},"Apendando arquivo...")
MSUNLOCK()           

dbGoTo(ncont)

WHILE !Eof()    
	idlinha := substr(FONTE->LINHA, 1, 1)
	MSEUNUM := substr(FONTE->LINHA, MV_PAR02, (MV_PAR03 - MV_PAR02 +1))
	MNOSSONUM := substr(FONTE->LINHA, MV_PAR04,(MV_PAR05 - MV_PAR04 +1))
		
	IF IDLINHA == MV_PAR01 //VERIFICA SE A LINHA DO REGISTRO DE DETALHE
		DBSelectArea("SE1")
		DBSetOrder(1)     //(1) :E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
		IF DBSeek(xfilial("SE1")+MSEUNUM+"NF ")
			//msginfo(SE1->E1_FILIAL + SE1->E1_PREFIXO + SE1->E1_NUM + SE1->E1_PARCELA + SE1->E1_TIPO + "NOSSO NUMERO ATUAL: " + SE1->E1_NUMBCO + CHR(10) + "NOVO NOSSO NUMERO: "+ MNOSSONUM ) //20070402
					
		   	RECLOCK("SE1",.F.)  //UPDATE .F.
				SE1->E1_NUMBCO  := MNOSSONUM
			MSUNLOCK("SE1")
			
			RECLOCK("SAIDA",.T.) //INSERIR .T.
				SAIDA->SERIE    := SE1->E1_PREFIXO
				SAIDA->NUMERO   := SE1->E1_NUM
				SAIDA->PARCELA  := SE1->E1_PARCELA
				SAIDA->NOSSONUM := MNOSSONUM
			MSUNLOCK("SAIDA") 	
		ELSE
			msginfo("TITULO NAO ENCONTRADO: " +MSEUNUM) 
		ENDIF   
	ENDIF

	DBSELECTAREA("FONTE")
	//DBSKIP()   
	ncont  := ncont + 1
	dbGoTo(ncont)
END //WHILE	

RETURN


        
//ฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Function  ณ FARQTRAB()                                                    ณ
//รฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
//ณ Descricao ณ Cria arquivos de trabalhos 									  ณ
//ณ           ณ                               								  ณ
//ณ           ณ 															  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Static Function FARQTRAB()
_aCampos := {  {"LINHA"  ,"C",400 ,0} }
_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "LINHA"
dbUseArea(.T.,, _cNome,"FONTE",.F.,.F.)
dbSelectArea("FONTE")
Indregua("FONTE",cIndex,ckey,,,"Criando arquivo FONTE")

_aCampos := {}
AADD(_aCampos,{"SERIE"     ,"C",3 ,0})
AADD(_aCampos,{"NUMERO"    ,"C",6 ,0})
AADD(_aCampos,{"PARCELA"   ,"C",1 ,0})
AADD(_aCampos,{"NOSSONUM"  ,"C",10,0})
_cnome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "SERIE+NUMERO+PARCELA"
dbUseArea(.T.,, _cNome,"SAIDA",.F.,.F.)
dbSelectArea("SAIDA")
Indregua("SAIDA",cIndex,ckey,,,"Criando arquivo SAIDA")
return