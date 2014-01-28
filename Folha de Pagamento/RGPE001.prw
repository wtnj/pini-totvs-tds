#INCLUDE "rwmake.ch"                       
#include "topconn.ch"
#include "tbiconn.ch"

/*/
Alterado por Danilo C S Pala em 20081126
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RGPE001   � Autor � DANILO C S PALA    � Data �  20080904   ���
�������������������������������������������������������������������������͹��
���Descricao � RELATORIO DE FOLHA DE PAGAMENTO ANALITICO EM DB            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Pini                                                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function RGPE001()

Private cPerg := "RGP001"
Private mEmpresa := SM0->M0_CODIGO
ValidPerg()
Pergunte(cPerg,.t.)    
Private mData :=  substr(dtos(MV_PAR01),3,4)
Private mHORA := TIME()
Private cString := SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,4,2)  //+".DBF"

     
//                                                                                            RC010807 = RC +EMP + ANOMES
if mv_par02 == 1 //Sintetico
	cQuery := "SELECT ra_cc, rc_pd, rv_desc, sum(rc_valor) valores FROM RC"+ mEmpresa + mData +" RC, " + RetSqlName("SRV") + " SRV, "+ RetSqlName("SRA") +" SRA"
	cQuery += " WHERE RC_FILIAL='"+xfilial("SRC")+"' and rv_filial='"+xfilial("SRV")+"' and ra_filial='"+xfilial("SRA5")+"' and rc_mat = ra_mat and rv_cod= rc_pd and RC.d_e_l_e_t_<>'*' and SRV.d_e_l_e_t_<>'*' and SRA.d_e_l_e_t_<>'*'"
	cQuery += " group by ra_cc, rc_pd, rv_desc"
	cQuery += " order by ra_cc, rc_pd, rv_desc"
else  //Analiticosigavi
	cQuery := "SELECT ra_cc, rc_mat, ra_nome, rc_pd, rv_desc, rc_horas, rc_valor, rc_data FROM RC"+ mEmpresa + mData +" RC, " + RetSqlName("SRV") + " SRV, "+ RetSqlName("SRA") + " SRA"
	cQuery += " WHERE RC_FILIAL='"+xfilial("SRC")+"' and rv_filial='"+xfilial("SRV")+"' and ra_filial='"+xfilial("SRA")+"' and rc_mat = ra_mat and rv_cod= rc_pd and RC.d_e_l_e_t_<>'*' and SRV.d_e_l_e_t_<>'*' and SRA.d_e_l_e_t_<>'*'"
	cQuery += " order by ra_cc, ra_nome, rv_desc"
endif

DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cString, .F., .T.)

dbSelectArea(cString)
dbGoTop()       
_ARQ  := "/SIGA/ARQTEMP/"+ cString +".DBF"
COPY TO &_ARQ VIA "DBFCDXADS" // 20121106                            
DBCloseArea()  
msgInfo(_ARQ)

Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ValidPerg �Autor  �danilo c s Pala     � Data �  20080904   ���
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

//mv_par01 - Mes
aAdd(aRegs,{cPerg,"01","Mes            ","Mes            ","Mes            ","mv_ch1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Formato?       ","Formato?       ","Formato?       ","mv_ch2","C",01,0,2,"C","","MV_PAR02","Sintetico","Sintetico","Sintetico","","","Analitico","Analitico","Analitico","","","","","","","","","","","","","","","","","","","","",""})

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