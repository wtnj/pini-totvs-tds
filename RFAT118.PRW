#include "rwmake.ch"        
/*/
//Danilo C S Pala 20070704: Incluir mensagem para nota
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa: RFAT118   �Autor: DANILO CESAR SESTARI PALA � Data: 20070620� ��
������������������������������������������������������������������������Ĵ ��
���Descri��o: Relatorio de vendas da SWAT                                � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : M�dulo de Faturamento                                      � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function Rfat118()

SetPrvt("CPERG,_StringArq, cquery, MHORA, aRegs")
SetPrvt("")
MHORA      := TIME()
_StringArq := "\SIGA\ARQTEMP\"+ SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2) +".DBF"

//������������������������������������������Ŀ
//� Vari�veis utilizadas para parametros     �
//� mv_par01             //Vendedor de       �
//� mv_par02             //Vendedor ate      �
//� mv_par03             //Faturado de       �
//� mv_par04             //Faturado ate      �
//��������������������������������������������
cPerg    := "FAT118"
ValidPerg()
If !Pergunte(cPerg)
   Return
Endif

If Select("RELSWAT") <> 0
	DbSelectArea("RELSWAT")
	DbCloseArea()
EndIf
      
bBloco:= { |lEnd| RptDetail()  }
MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )

RETURN


Static Function RptDetail()
cQuery := "select c5_vend1 as CODVEND, a3_nome as VENDEDOR, c6_cli AS CLIENTE, c6_num AS PEDIDO, c6_item as ITEM, c6_produto AS PRODUTO,  c6_descri AS DESCRICAO, c6_qtdven AS QTD, c6_valor as VALOR, c5_tipoop as TIPOOP, c6_serie AS SERIE, c6_nota AS NOTA, c6_datfat AS DTFAT, c5_mennota as MSGNOTA"
cQuery := cQuery + " from "+ RetSqlName("SC6") +" c6, "+ RetSqlName("SC5") +" c5, "+ RetSqlName("SA3") +" a3"
cQuery := cQuery + " where c5_filial=c6_filial and c5_num=c6_num and c5_vend1=a3_cod and a3_filial='"+xfilial("SA3")+"' and c5_filial='"+xfilial("SC5")+"' and c5_vend1>='"+ MV_PAR01 +"' and c5_vend1<='"+ MV_PAR02 +"' and c5_emissao>='"+ DTOS(MV_PAR03) +"' and c5_emissao<='"+ DTOS(MV_PAR04) +"' and c5.d_e_l_e_t_<>'*' and c6.d_e_l_e_t_<>'*' and a3.d_e_l_e_t_<>'*'"
MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "RELSWAT", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")

TcSetField("RELSWAT","DTFAT"   ,"D")


COPY TO &_StringArq VIA "DBFCDXADS" // 20121106 
DBCLOSEAREA()   
MsgInfo(_StringArq)

RETURN


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ValidPerg �Autor  �DANILO C S PALA     � Data �  20080919   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cria parametros no SX1 nao existir os parametros.           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Pini                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
aAdd(aRegs,{cPerg,"01","Vendedor de    ","Vendedor de    ","Vendedor de    ","mv_ch1","C",06,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","SA3","","","",""})
aAdd(aRegs,{cPerg,"02","Vendedor ate   ","Vendedor ate   ","Vendedor ate   ","mv_ch2","C",06,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","SA3","","","",""})
aAdd(aRegs,{cPerg,"03","Emiss�o de     ","Emiss�o de     ","Emiss�o de     ","mv_ch3","D",08,0,0,"G","","MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Emiss�o at�    ","Emiss�o at�    ","Emiss�o at�    ","mv_ch4","D",08,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

_nLimite := If(Len(aRegs[1])<FCount(),Len(aRegs[1]),FCount())
For i := 1 To Len(aRegs)
	If !DbSeek(cPerg + aRegs[i,2])
		Reclock("SX1", .T.)
		For j := 1 to _nLimite
			FieldPut(j, aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next
DbSelectArea(_sAlias)
Return(.T.)
