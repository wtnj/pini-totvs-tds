#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*   alterado em 20030915 por danilo
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PFat160   �Autor  �Danilo C S Pala     � Data �  20030915   ���
�������������������������������������������������������������������������͹��
���Desc.     � Programa para otimizacao do Pfat106C, com query 			  ���
���          �  (Clientes Cont/Arq)										  ���
�������������������������������������������������������������������������͹��
���Uso       � AP5                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function Pfat161

SetPrvt("MCONTA1,MCONTA2,MCONTA3,MHORA,CARQ,CSTRING")
SetPrvt("MSAIDA,CARQPATH,_CSTRING,CPERG,LEND,BBLOCO")
SetPrvt("CMSG,MVALIDA,CCHAVE,CIND,MIND2,MCONTA")
SetPrvt("MPEDIDO,MITEM,MCODCLI,MCODDEST,MPROD,MCF")
SetPrvt("MCEP,MVALOR,MQTDE,MNOMECLI,MRESPCOB,MDEST")
SetPrvt("MEND,MMUN,MEST,MFONE,MCGC,MDTPG")
SetPrvt("MDTFAT,MDTPG2,MFILIAL,MBAIRRO,MPAGO,MPGTO")
SetPrvt("MPARC,MABERTO,MVEND,MEDVENC,MEDINIC,MEDSUSP,MEDFIN,MGRAVA,MTIPOOP")
SetPrvt("MTPPROD,MDESCROP,MPRICOM,MULTCOM,MGRAT,MDTVENC")
SetPrvt("MCODREV,MTITULO,_LSEEK,MEMAIL,MFAX,MATIV")
SetPrvt("MTPCLI,MFONE1,_ACAMPOS,_CNOME,CINDEX,CKEY")
SetPrvt("MIND1,_SALIAS,AREGS,I,J,MINSCR,MINSCRM") 
SetPrvt("cQuery, _aCampos, aArq, _cnome, aQuery")
SetPrvt("cQuerySZJ, _aCamposSZJ")  
SetPrvt("contdel, contproc, mContAss, CONTDELSE1")
SetPrvt("_aCamposF, _cNomeF")
SetPrvt("_cNomeF, _aCamposF, cIndex, cKey, MsgSZJ, nRegistro")
SetPrvt("MsgSZJ, mEmpresa")
SetPrvt("mDest, mEnd, mBairro, mMun, mEst, mCEP, mFone1")

//�������������������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                                    �
//�                                                                         �
//� mv_par01 Do Produdo.........:                                           �
//� mv_par02 At� o Produto......:                                           �
//� mv_par03 Faturados/Venc de..:                                           �
//� mv_par04 Faturados/Venc at�.:                                           �
//� mv_par05 Do CEP.............:                                           �
//� mv_par06 At� CEP............:                                           �
//� mv_par07 Tipo...............: Pagas, Cortesia, Ambas.                   �
//� mv_par08 Situacao...........: Baixados, Em Aberto, Ambas.               �
//� mv_par09 Qtde da Selecao....:                                           �
//� mv_par10 Gerar..............: Contagem, Arquivo.                        �
//� mv_par11 Elimina duplicidade: Sim, Nao.                                 �
//� mv_par12 Cod. Promo��o......:                                           �
//� mv_par13 Cod. Mailing.......:                                           �
//� mv_par14 Da Atividade.......:                                           �
//� mv_par15 At� Atividade......:                                           �
//� mv_par16 Tipo Cliente.......: Ass. Ativos, Ass. Cancelados, Outros.     �
//� mv_par17 Utilizacao.........: Mala Direta, TeleMarketing.               �
//� mv_par18 Processa por.......: Clientes,Produtos.                        �
//� mv_par19 Inclui representante: Sim  Nao                                 �
//� mv_par20 Natureza do Cliente: Fisica, Juridica, Ambas                   �
//���������������������������������������������������������������������������
                           
CONTQTD	  := 0
mSaida    := "1"
cPerg     := "PF106C"   
mEmpresa  := SM0->M0_CODIGO

If !Pergunte(cPerg)
	Return
Endif
//     teste 20031104       

If MV_PAR10 = 2
	DbSelectArea("ZZ7") //zz7 controle de saida de mailing
	If DbSeek(xfilial("ZZ7")+MV_PAR12+MV_PAR13+MSAIDA)
		MsgStop("C�digo j� utilizado, informe c�digo v�lido ou solicite manutencao no cad. Mailing")
		Return
	Endif

	F_VERSZA()
	IF mValida == 'N'
		RETURN
	ENDIF
Endif 
 
IF MV_PAR16 = 1
	Processa({|| Ativos()})
ELSEIF MV_PAR16 = 2
	Processa({|| Inativos()})
ELSE
	Processa({|| Outros()})
END IF
	


If MV_PAR10 = 2
	DBSelectArea("ASSOP")              
	Copy to &("\SIGA\EXPORTA\ASSOP.DBF") VIA "DBFCDXADS" // 20121106 
	DBCloseArea("ASSOP")
	MsgAlert(OemToAnsi(MsgSZJ))
	F_ATUZZ7() 
else
	Mostrar()
EndIf

DbSelectArea("SA1")
Retindex("SA1")   
DbSelectArea("SZO")
Retindex("SZO")
DbSelectArea("SZN")
Retindex("SZN")
DbSelectArea("SE1")
Retindex("SE1")
DbSelectArea("SZL")
Retindex("SZL")
DbSelectArea("SZA")
Retindex("SZA")
DbSelectArea("ZZ7")
Retindex("ZZ7")
return









/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PFAT161   �Autor  �Danilo C S Pala     � Data �  09/15/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao que executa a query dos Ativos		                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Advanced Protheus                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Ativos()
Private contador := 0
Private cUpdate := ""
DbselectArea("SA1")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif                             
DBCloseArea("SA1")

//������������������������������������������������Ŀ
//�campos da consulta de edicao em circulacao (SZJ)�
//��������������������������������������������������
_aCamposSZJ := {}
AADD(_aCamposSZJ,{"zj_codrev","zj_codrev"})
AADD(_aCamposSZJ,{"zj_edicao","zj_edicao"})
AADD(_aCamposSZJ,{"zj_dtcirc","zj_dtcirc"})    


FArqTrab()

//���������������������������������������������
//�Query getting as edicoes em circulacao(SZJ)�
//���������������������������������������������
///* teste 20030916
cQuerySZJ := "SELECT distinct zj_codrev, zj_edicao, zj_dtcirc FROM szj010 where zj_dtcirc >= '"+ dtos(dDataBase) +"' and zj_dtcirc <'"+ dtos(dDataBase+30) +"' and zj_codrev>='"+ Substr(MV_PAR01,1,4) +"' and zj_codrev<='"+ Substr(MV_PAR02,1,4) +"' and d_e_l_e_t_ <>'*'" //20031120
TCQUERY cQuerySZJ NEW ALIAS "QUERYSZJ"

MsgSZJ := "Gerado: \SIGA\EXPORTA\ASSOP.DBF"+CHR(10)+CHR(13)
ProcRegua(20)
//loop nas edicoes atuais, getting os pedidos referentes
while !eof("QuerySZJ")
	IncProc("Lendo:"+ AllTrim(QUERYSZJ->ZJ_CODREV) +"-"+ AllTrim(Str(QUERYSZJ->ZJ_EDICAO)))  
	cQuery := "SELECT c6_produto as , substr(c6_produto,1,4) as codrev, c6_datfat, c6_cli, c6_num, c6_item, c6_qtdven, c6_valor, c6_cf, c6_tes, c6_coddest, c6_filial, c6_edvenc, c6_edinic, c6_edsusp, c6_edfin, c6_descri,"
	cQuery += "/*sc5*/ c5_vend1, c5_respcob, c5_tipoop, "
	cQuery += "/*SZ9*/ z9_descr, "
	cQuery += "/*sf4*/ f4_texto, f4_duplic, "
	cQuery += "/*sa1*/ a1_nome, a1_end, a1_bairro, a1_mun, a1_est, a1_cep, a1_tel, a1_cgc, a1_inscr, a1_inscrm, a1_email, a1_fax, a1_ativida, a1_tpcli, a1_pricom, a1_ultcom, "
	cQuery += "	/*deletado*/ c6.d_e_l_e_t_ as c6_del, a1.d_e_l_e_t_ as a1_del, c5.d_e_l_e_t_ as c5_del, f4.d_e_l_e_t_ as f4_del, z9.d_e_l_e_t_ as z9_del "
	cQuery += " FROM SC6"+mEmpresa+"0 C6, SC5"+mEmpresa+"0 C5, SZ9010 Z9, SF4"+mEmpresa+"0 F4, SA1010 A1 "
	cQuery += " WHERE (c6_filial='"+xfilial("SC6")+"') and (c6_cli<>'040000') and (c6_data>='20030301')"
	cQuery += "  and (c6_produto>='"+ alltrim(MV_PAR01) +"') and (c6_produto<='"+ alltrim(MV_PAR02) +"')"
	cQuery += "  and (substr(c6_produto,5,3)<>'001') "
	cQuery += "  and (c5_filial='"+xfilial("SC5")+"') and (c5_num=c6_num)"
	cQuery += "  and (substr(c6_produto,1,4) = '"+ Alltrim(QuerySZJ->ZJ_CODREV) +"') and (c6_edinic<="+ Alltrim(Str(QuerySZJ->ZJ_EDICAO)) +") and (c6_edsusp >="+ Alltrim(Str(QuerySZJ->ZJ_EDICAO)) +") "
//	cQuery += "  and (substr(c6_produto,1,4) = '0115') and (c6_edinic<=26) and (c6_edsusp >=26) "
	cQuery += "  and (z9_filial='"+xfilial("SZ9")+"') and (z9_tipoop = c5_tipoop)"
	cQuery += "  and (f4_filial='"+xfilial("SF4")+"') and (f4_codigo=c6_tes) "
	cQuery += "  and (a1_cod =c6_cli) and (a1_loja=c6_loja) and (a1_filial='"+xfilial("SA1")+"')"
	cQuery += "  and (((a1_cep >= '"+ alltrim(Mv_Par05) +"') and (a1_cep<='"+ alltrim(mv_par06) +"')) or (a1_est='EX')) "
	cQuery += "  and (a1_ativida >= '"+ alltrim(mv_par14) +"') and (a1_ativida <= '"+ alltrim(mv_par15) +"') "
	cQuery += " and (a1.d_e_l_e_t_<>'*') and (c6.d_e_l_e_t_<>'*') and (c5.d_e_l_e_t_<>'*') and (z9.d_e_l_e_t_<>'*') and (f4.d_e_l_e_t_<>'*')"
	TCQUERY cQuery NEW ALIAS "QUERY"                        
	
	//CONSISTENCIAS LIMPAR/ PROCESSAR E GRAVAR
	PROCASSOP()

    dbSelectArea("Query")
	DBCloseArea("Query") 
	    
	DbSelectArea("QuerySZJ")
	DBSkip()
end    
DBCloseArea("QuerySZJ")            

return




      








/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Inativos()�Autor  �Danilo C S Pala     � Data �  20030919   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao que executa a query dos Inativos                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Advanced Protheus                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Inativos()
Private contador := 0
Private cUpdate := ""
DbselectArea("SA1")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif              
DBCloseArea("SA1")

//������������������������������������������������Ŀ
//�campos da consulta de edicao em circulacao (SZJ)�
//��������������������������������������������������
_aCamposSZJ := {}
AADD(_aCamposSZJ,{"EdDe","N",4,0})
AADD(_aCamposSZJ,{"EdAte","N",4,0})
AADD(_aCamposSZJ,{"zj_codRev","C",4,0})    


FArqTrab()

//���������������������������������������������
//�Query getting as edicoes em circulacao(SZJ)�
//���������������������������������������������
///* teste 20030919
cQuerySZJ := "SELECT min(zj_edicao) as Edde, max(zj_edicao) as EdAte, zj_codrev FROM szj010 where zj_dtcirc >= '"+ dTOS(MV_PAR03) +"' and zj_dtcirc <='"+ dTOS(MV_PAR04) +"' and d_e_l_e_t_ <>'*' group by zj_codrev"

TCQUERY cQuerySZJ NEW ALIAS "QUERYSZJ"

MsgSZJ := "Gerado: \SIGA\EXPORTA\ASSOP.DBF"+CHR(10)+CHR(13)
ProcRegua(20)
//loop nas edicoes atuais, getting os pedidos referentes
while !eof("QuerySZJ")
	IncProc("Lendo:"+ AllTrim(QUERYSZJ->ZJ_CODREV))
	cQuery := "SELECT c6_produto as , substr(c6_produto,1,4) as codrev, c6_datfat, c6_cli, c6_num, c6_item, c6_qtdven, c6_valor, c6_cf, c6_tes, c6_coddest, c6_filial, c6_edvenc, c6_edinic, c6_edsusp, c6_edfin, c6_descri, c6_pedren, "
	cQuery += "/*sc5*/ c5_vend1, c5_respcob, c5_tipoop, "
	cQuery += "/*SZ9*/ z9_descr, "
	cQuery += "/*sf4*/ f4_texto, f4_duplic, "
	cQuery += "/*sa1*/ a1_nome, a1_end, a1_bairro, a1_mun, a1_est, a1_cep, a1_tel, a1_cgc, a1_inscr, a1_inscrm, a1_email, a1_fax, a1_ativida, a1_tpcli, a1_pricom, a1_ultcom, "
	cQuery += "	/*deletado*/ c6.d_e_l_e_t_ as c6_del, a1.d_e_l_e_t_ as a1_del, c5.d_e_l_e_t_ as c5_del, f4.d_e_l_e_t_ as f4_del, z9.d_e_l_e_t_ as z9_del "
	cQuery += " FROM SC6"+mEmpresa+"0 C6, SC5"+mEmpresa+"0 C5, SZ9010 Z9, SF4"+mEmpresa+"0 F4, SA1010 A1 "
	cQuery += " WHERE (c6_filial='01') and (c6_cli<>'040000') and (c6_data>='20030301')"
	cQuery += "  and (c6_produto>='"+ alltrim(MV_PAR01) +"') and (c6_produto<='"+ alltrim(MV_PAR02) +"')"
	cQuery += "  and (substr(c6_produto,5,3)<>'001') "
	cQuery += "  and (c5_filial='01') and (c5_num=c6_num) " 
	cQuery += "/*dif*/   and (substr(c6_produto,1,4) = '"+ Alltrim(QuerySZJ->ZJ_CODREV) +"') and (c6_edsusp>="+ Alltrim(Str(QuerySZJ->EdDe)) +") and (c6_edsusp <="+ Alltrim(Str(QuerySZJ->EdAte)) +") "
	cQuery += "  and (z9_filial='  ') and (z9_tipoop = c5_tipoop)"
	cQuery += "  and (f4_filial='01') and (f4_codigo=c6_tes) "
	cQuery += "  and (a1_cod =c6_cli) and (a1_loja=c6_loja) and (a1_filial='  ')"
	cQuery += "  and (((a1_cep >= '"+ alltrim(Mv_Par05) +"') and (a1_cep<='"+ alltrim(mv_par06) +"')) or (a1_est='EX')) "
	cQuery += "  and (a1_ativida >= '"+ alltrim(mv_par14) +"') and (a1_ativida <= '"+ alltrim(mv_par15) +"') "
	cQuery += "/*renovacao*/  and (c6_pedren ='      ')"
	cQuery += " and (a1.d_e_l_e_t_<>'*') and (c6.d_e_l_e_t_<>'*') and (c5.d_e_l_e_t_<>'*') and (z9.d_e_l_e_t_<>'*') and (f4.d_e_l_e_t_<>'*')"
	TCQUERY cQuery NEW ALIAS "QUERY"                        
	
	//CONSISTENCIAS LIMPAR/ PROCESSAR E GRAVAR
	PROCASSOP()

    dbSelectArea("Query")
	DBCloseArea("Query") 
	    
	DbSelectArea("QuerySZJ")
	DBSkip()
end    
DBCloseArea("QuerySZJ")            

return








/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Outros()  �Autor  �Danilo C S Pala     � Data �  20030919   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao que executa a query dos Outros(todos os pedidos no   ���
���          �intervalo de datas informado							   	  ���
�������������������������������������������������������������������������͹��
���Uso       � Advanced Protheus                                          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Outros()
Private contador := 0
DbselectArea("SA1")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif              
DBCloseArea("SA1")

FArqTrab()

MsgSZJ := "Gerado: \SIGA\EXPORTA\ASSOP.DBF"+CHR(10)+CHR(13)
                 
cQuery := "SELECT c6_produto as , substr(c6_produto,1,4) as codrev, c6_datfat, c6_cli, c6_num, c6_item, c6_qtdven, c6_valor, c6_cf, c6_tes, c6_coddest, c6_filial, c6_edvenc, c6_edinic, c6_edsusp, c6_edfin, c6_descri, c6_pedren, c6_data, "
cQuery += "/*sc5*/ c5_vend1, c5_respcob, c5_tipoop, "
cQuery += "/*SZ9*/ z9_descr, "
cQuery += "/*sf4*/ f4_texto, f4_duplic, "
cQuery += "/*sa1*/ a1_nome, a1_end, a1_bairro, a1_mun, a1_est, a1_cep, a1_tel, a1_cgc, a1_inscr, a1_inscrm, a1_email, a1_fax, a1_ativida, a1_tpcli, a1_pricom, a1_ultcom, "
cQuery += "	/*deletado*/ c6.d_e_l_e_t_ as c6_del, a1.d_e_l_e_t_ as a1_del, c5.d_e_l_e_t_ as c5_del, f4.d_e_l_e_t_ as f4_del, z9.d_e_l_e_t_ as z9_del "
	cQuery += " FROM SC6"+mEmpresa+"0 C6, SC5"+mEmpresa+"0 C5, SZ9010 Z9, SF4"+mEmpresa+"0 F4, SA1010 A1 "
cQuery += " WHERE (c6_filial='01') and (c6_cli<>'040000') and (c6_data>='20030301')"
cQuery += "  and (c6_produto>='"+ alltrim(MV_PAR01) +"') and (c6_produto<='"+ alltrim(MV_PAR02) +"')"
//cQuery += "  and (substr(c6_produto,5,3)<>'001') "
cQuery += "  and (c5_filial='01') and (c5_num=c6_num) " 
cQuery += "  and (z9_filial='  ') and (z9_tipoop = c5_tipoop)"
cQuery += "  and (f4_filial='01') and (f4_codigo=c6_tes)"
cQuery += "  and (a1_cod =c6_cli) and (a1_loja=c6_loja) and (a1_filial='  ')"
cQuery += "  and (((a1_cep >= '"+ alltrim(Mv_Par05) +"') and (a1_cep<='"+ alltrim(mv_par06) +"')) or (a1_est='EX')) "
cQuery += "  and (a1_ativida >= '"+ alltrim(mv_par14) +"') and (a1_ativida <= '"+ alltrim(mv_par15) +"') "
cQuery += "   /*data*/  and (c6_data >= '"+ DTOS(MV_PAR03) +"') and (c6_data <= '"+ DTOS(MV_PAR04) +"')"
cQuery += " and (a1.d_e_l_e_t_<>'*') and (c6.d_e_l_e_t_<>'*') and (c5.d_e_l_e_t_<>'*') and (z9.d_e_l_e_t_<>'*') and (f4.d_e_l_e_t_<>'*')"
TCQUERY cQuery NEW ALIAS "QUERY"                        
	
//CONSISTENCIAS LIMPAR/ PROCESSAR E GRAVAR
PROCASSOP()

dbSelectArea("Query")
DBCloseArea("Query") 

return
















/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FArqTrab()�Autor  �DAnilo C S Pala     � Data �  09/19/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cria o arquivo ASSOP                                        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function FArqTrab()
_aCamposF:={}
AADD(_aCamposF,{"NUMPED","C",6,0})
AADD(_aCamposF,{"ZZ6_SEQASS","C",2,0})
AADD(_aCamposF,{"ZZ6_COD","C",6,0})
AADD(_aCamposF,{"ZZ6_NOME","C",40,0})
AADD(_aCamposF,{"ZZ6_CONTAT","C",40,0})
AADD(_aCamposF,{"ZZ6_END","C",40,0})
AADD(_aCamposF,{"ZZ6_BAIRRO","C",20,0})
AADD(_aCamposF,{"ZZ6_MUN","C",20,0})
AADD(_aCamposF,{"ZZ6_ESTADO","C",2,0})
AADD(_aCamposF,{"ZZ6_CEP","C",8,0})
AADD(_aCamposF,{"ZZ6_CGC","C",14,0})  
AADD(_aCamposF,{"ZZ6_INSCR","C",14,0})   
AADD(_aCamposF,{"ZZ6_INSCRM","C",14,0})
AADD(_aCamposF,{"ZZ6_TEL","C",20,0})
AADD(_aCamposF,{"ZZ6_FAX","C",20,0})
AADD(_aCamposF,{"ZZ6_EMAIL","C",20,0})
AADD(_aCamposF,{"ZZ6_EDINIC","N",4,0})
AADD(_aCamposF,{"ZZ6_EDVENC","N",4,0})
AADD(_aCamposF,{"ZZ6_EDSUSP","N",4,0})
AADD(_aCamposF,{"ZZ6_EDFIN","N",4,0})
AADD(_aCamposF,{"ZZ6_PRODUT","C",2,0}) 
AADD(_aCamposF,{"ZZ6_CODVEN","C",6,0}) 
AADD(_aCamposF,{"ZZ6_TPCLI","C",1,0})
AADD(_aCamposF,{"CODASS","C",12,0}) 
AADD(_aCamposF,{"RESPCOB","C",40,0})
AADD(_aCamposF,{"CF","C",5,0})
AADD(_aCamposF,{"CODPROD","C",15,0})
AADD(_aCamposF,{"DESCR","C",40,0})
AADD(_aCamposF,{"DTPGTO","D",8,0})
AADD(_aCamposF,{"DTFAT","D",8,0})
AADD(_aCamposF,{"QTDE","N",12,2})
AADD(_aCamposF,{"ZZ6_VALOR","N",12,2})
AADD(_aCamposF,{"PGTO","N",5,2})
AADD(_aCamposF,{"EMABERTO","N",5,0})
AADD(_aCamposF,{"CODDEST","C",6,0})
AADD(_aCamposF,{"TIPOOP","C",2,0})
AADD(_aCamposF,{"DESCROP","C",50,0})
AADD(_aCamposF,{"PRICOM","D",8,0})
AADD(_aCamposF,{"ULTCOM","D",8,0})
AADD(_aCamposF,{"TPPROD","C",30,0}) 

_cNomeF := CriaTrab(_aCamposF,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "ZZ6_Cod+CodDEst"
dbUseArea(.T.,, _cNomeF,"ASSOP",.F.,.F.)
dbSelectArea("ASSOP")
Indregua("ASSOP",cIndex,ckey,,,"Selecionando Registros do Arq")
return






              





/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PROCASSOP()  �Autor  �DAnilo C S Pala     � Data �  09/18/03���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function PROCASSOP()
contDel := 0
ContProc := 0
ContCons := 0                        
CONTDELSE1 := 0
DBSELECTAREA("QUERY")
DbGotop()            
procregua(reccount())
While !eof("QUERY") .and. (CONTQTD <= MV_PAR09)      	
incproc("Pedido: "+Query->c6_num)       
  
	/*IF QUERY->C6_NUM = "395076"// .OR. QUERY->C6_NUM = "275950" .OR. QUERY->C6_NUM = "381638" .OR. QUERY->C6_NUM = "3718440" // 20040115
           MsgAlert("Achou: "+ QUERY->C6_NUM)
	Endif*/
	//PROCESSAR CONSISTENCIAS
		mTpprod   := ""
		mPRODUTO  := QUERY->C6_PRODUTO
		mPEDIDO   := QUERY->C6_NUM
		mCODCLI   := QUERY->C6_CLI
		mCODDEST  := QUERY->C6_CODDEST
		mTES 	  := QUERY->C6_TES
		mCF 	  := QUERY->C6_CF
		mF4_TEXTO := QUERY->F4_TEXTO  
		mF4_DUPLIC := QUERY->F4_DUPLIC
		mTpCli	  := QUERY->A1_TPCLI
		mDTPG     := stod("")
		mDTPG2   := stod("")
		mPgto	  := 0
		mAberto	  := 0    
		mPago    := 0
		mParc    := 0
		mDest := "."
		mEnd  :=QUERY->a1_end
		mBairro := QUERY->a1_bairro
		mMun    := QUERY->a1_mun
		mEst    := QUERY->a1_est
		mCEP    := QUERY->a1_cep
		mFone  := QUERY->a1_tel
		
		
		//20030919
		//��������������������������������������������������������������Ŀ
		//� Verifica o se eh conversao pois o c6_datfat estah em branco  �
		//����������������������������������������������������������������
		if MV_PAR16 = 3
			if (mTES<>'700') .and. (mTES<>'701')
				IF (STOD(QUERY->C6_DATFAT) < MV_PAR03) .OR. (STOD(QUERY->C6_DATFAT) > MV_PAR04)
					contCons++    
					DBSelectarea("QUERY")	
					DBSkip()                        
					Loop
				ENDIF
			endif
		endif
	                                                                      
		//��������������������������������������������������������������Ŀ
		//� Verifica o se eh pessoa fisica ou juridica				     �
		//����������������������������������������������������������������
	    If MV_PAR20 = 1 .and. mTpCli <> 'F'
			contCons++    
			DBSelectarea("QUERY")	
			DBSkip()                        
			Loop
		Elseif MV_PAR20 == 2 .and. mTpCli <> 'J'
			contCons++    
			DBSelectarea("QUERY")	
			DBSkip()                        
			Loop
		Endif
	
		//��������������������������������������������������������������Ŀ
		//� Verifica o registro faz parte do cad de representante        �
		//����������������������������������������������������������������
		IF MV_PAR19 = 2
			DbSelectArea("SZL")
			DbGoTop()
			DbSeek(xFilial("SZL")+MCODCLI)
			If Found()
				contCons++    
				DBSelectarea("QUERY")	
				DBSkip()                        
				Loop
			Endif   
			DBCloseArea("SZL")
		ENDIF
	
	
		If mv_par11 == 1
			DbSelectArea("ASSOP")
			DbGoTop()
			DbSeek(mCodCli+mCodDest)
			If Found()
				contCons++    
				DBSelectarea("QUERY")	
				DBSkip()                        
				Loop
			Endif
		Endif
		
		//��������������������������������������������������������������Ŀ
		//� Verifica se � pago 1/cortesia 2/ambas 3	                     �
		//����������������������������������������������������������������
		If MV_PAR07 = 1 .OR. MV_PAR07 = 2
			IF  (AllTrim(mF4_TEXTO) $ 'CORTESIA'.OR. AllTrim(mF4_TEXTO) $ 'DOACAO' .OR. (mF4_duplic = 'N')) .and. (MV_PAR07 == 1)
				contCons++    
				DBSelectarea("QUERY")	
				DBSkip()                        
				Loop
			elseif  (MV_PAR07 == 2)//pagas e mv_par07=2
				contCons++    
				DBSelectarea("QUERY")	
				DBSkip()                        
				Loop
			Endif
		Endif
	
	
		//��������������������������������������������������������������Ŀ
		//�calculando as baixas						                     �
		//����������������������������������������������������������������
 		 DbSelectArea("SE1")
		 DbOrderNickName("E1_PEDIDO") //dbSetOrder(27) 20130225  ///dbSetOrder(15) AP5  //20090114 era(21) //20090723 mp10 era(22) //dbSetOrder(26) 20100412
		 DbSeek(xFilial("SE1")+mPedido)
		 If Found()
			mDTPG := SE1->E1_BAIXA
			While ( SE1->E1_PEDIDO == MPEDIDO ) .And. !Eof()
				mParc := mParc+1
				mDTPG2:= SE1->E1_BAIXA
				If !Empty(MDTPG2) .And. SE1->E1_SALDO == 0;
					.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,2) <> 'LP';
					.AND.SUBS(ALLTRIM(SE1->E1_MOTIVO),1,4) <> 'CANC'
					mPago:=mPago+1
				Else
					If SE1->E1_VENCTO+30 < DATE()
						mAberto := mAberto+1
					Endif
				Endif
				DbSkip()
			End
			mPGTO := mPAGO/mPARC
		 ElseIF (mTES='700') .OR. (mTES='701')
		 	mAberto := 0
		 Else
			mAberto := 99999
		 Endif              
		 DBCloseArea("SE1")
		
		 // BAIXADOS 1/ ABERTOS 2/ ambos 3
		 If MV_PAR08 = 1    
			If mAberto <> 0
				contCons++    
				CONTDELSE1++
				DBSelectarea("QUERY")	
				DBSkip()                        
				Loop
			Endif
		 Elseif MV_PAR08 = 2            
			If mAberto = 0
				contCons++    
				DBSelectarea("QUERY")	
				DBSkip()                        
				Loop
			Endif       
		 Endif 
	 
	
		Do Case
		  Case subs(mPRODUTO,1,2) == '02'
			mTpprod:='LIVROS'
		  Case subs(mPRODUTO,1,2) == '07'
			mTpprod:='CD'
		  Case subs(mPRODUTO,1,2) == '01'.And. subs(mPRODUTO,5,3) == '002'
			mTpprod:='NOVA ANUAL'
		  Case subs(mPRODUTO,1,2) == '01'.And. subs(mPRODUTO,5,3) == '003'
			mTpprod:='NOVA BIENAL'
		  Case subs(mPRODUTO,1,2) == '01'.And. subs(mPRODUTO,5,3) == '004'
			mTpprod:='RENOVADA ANUAL'
		  Case subs(mPRODUTO,1,2) == '01'.And. subs(mPRODUTO,5,3) == '005'
			mTpprod:='RENOVADA BIENAL'
		  OtherWise
			mTpprod:='OUTROS'
		EndCase    
		
		//destinatario
		If mCodDest#" "
			DbSelectArea("SZN")
			DbSeek(xFilial("SZN")+mCodCli+mCodDest)
			If Found()
				mDest := SZN->ZN_NOME
			Endif
		
			DbSelectArea("SZO")
			DbSeek(xFilial("SZO")+mCodCli+mCodDest)
			If Found()
				mEnd    := SZO->ZO_END
				mBairro := SZO->ZO_BAIRRO
				mMun    := SZO->ZO_CIDADE
				mEst    := SZO->ZO_ESTADO
				mCEP    := SZO->ZO_CEP
				mFone1  := SZO->ZO_FONE
				If mFone1 <> "  "
					mFone:= mFone1
				Endif
			Endif
		Endif
	
		GRAVAR()      
		contproc++
		ContQtd++
		DBSelectArea("QUERY")
		DBSkip()    
		Loop
end         
IF MV_par16 = 1 
	MsgSZJ += Alltrim(QuerySZJ->zj_codrev) + Alltrim(QuerySZJ->zj_edicao) + ": processados: "+ Alltrim(str(contproc)) +", deletados: "+ Alltrim(str(contdel)) +" e Del por Consist: "+ Alltrim(str(contcons)) +" E DELSE1: "+ Alltrim(str(contDELSE1))+CHR(10)+CHR(13)
ELSEIF MV_PAR16=2
	MsgSZJ += Alltrim(QuerySZJ->zj_codrev) +": processados: "+ Alltrim(str(contproc)) +", deletados: "+ Alltrim(str(contdel)) +" e Del por Consist: "+ Alltrim(str(contcons)) +" E DELSE1: "+ Alltrim(str(contDELSE1)) +CHR(10)+CHR(13)
ELSE
	MsgSZJ += "ASSOP: processados: "+ Alltrim(str(contproc)) +", deletados: "+ Alltrim(str(contdel)) +" e Del por Consist: "+ Alltrim(str(contcons))+" E DELSE1: "+ Alltrim(str(contDELSE1)) +CHR(10)+CHR(13)
ENDIF
return                                                                













/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GRAVAR()  �Autor  �Danilo C S Pala     � Data �  09/18/03   ���
�������������������������������������������������������������������������͹��
���Desc.     � Grava os dados em ASSOP.DBF                                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function GRAVAR()
DBSELECTAREA("ASSOP")
Reclock("ASSOP",.t.)
ASSOP->CodProd := QUERY->c6_produto
ASSOP->DTFAT := StoD(QUERY->c6_datfat)
ASSOP->zz6_Cod := QUERY->c6_cli
ASSOP->NumPed := QUERY->c6_num
ASSOP->zz6_Seqass := QUERY->c6_item
ASSOP->Qtde := QUERY->c6_qtdven
ASSOP->zz6_Valor := QUERY->c6_valor
ASSOP->CF := QUERY->c6_cf
ASSOP->CodDest := QUERY->c6_coddest
ASSOP->zz6_EdVenc := QUERY->c6_edvenc
ASSOP->zz6_Edinic := QUERY->c6_edinic
ASSOP->zz6_Edsusp := QUERY->c6_edsusp
ASSOP->zz6_Edfin := QUERY->c6_edfin
ASSOP->Descr := QUERY->c6_descri
ASSOP->zz6_CodVend := QUERY->c5_vend1
ASSOP->Respcob := QUERY->c5_respcob
ASSOP->Tipoop := QUERY->c5_tipoop
ASSOP->Descrop := QUERY->z9_descr
ASSOP->zz6_nome := QUERY->a1_nome
ASSOP->zz6_end := mEnd
ASSOP->zz6_bairro := mBairro
ASSOP->zz6_mun := mMun
ASSOP->zz6_estado := mEst
ASSOP->zz6_cep := mCEp
ASSOP->zz6_tel := mFone
ASSOP->zz6_cgc := QUERY->a1_cgc
ASSOP->zz6_inscr := QUERY->a1_inscr
ASSOP->zz6_inscrm := QUERY->a1_inscrm
ASSOP->zz6_email := QUERY->a1_email
ASSOP->zz6_fax := QUERY->a1_fax
ASSOP->zz6_TpCli := QUERY->a1_tpcli
ASSOP->pricom := StoD(QUERY->a1_pricom)
ASSOP->ultcom := StoD(QUERY->a1_ultcom)
//novo em webop
ASSOP->codass := QUERY->C6_NUM+substr(QUERY->C6_PRODUTO,3,2)+QUERY->C6_ITEM    
ASSOP->zz6_contat := mDest //var     
ASSOP->zz6_Produto  := substr(QUERY->C6_PRODUTO,3,2)        
ASSOP->DTPGTO  :=  mDTPG //VAR   
ASSOP->PGTO :=  mPGTO //VAR
ASSOP->EmAberto :=  mAberto //VAR    
ASSOP->Tpprod   :=  mTpprod //VAR    
/*//ADICIONAIS P/ CONSISTENCIAS
ASSOP->codrev := QUERY->codrev 
ASSOP->c6_tes := QUERY->c6_tes 
ASSOP->c6_filial := QUERY->c6_filial
ASSOP->f4_texto := QUERY->f4_texto
ASSOP->z9_del := QUERY->z9_del
ASSOP->f4_del := QUERY->f4_del
ASSOP->c5_del := QUERY->c5_del
ASSOP->a1_del := QUERY->a1_del
ASSOP->c6_del := QUERY->c6_del                            
//ASSOP->a1_ativida := QUERY->a1_ativida	//ESTAH NA QUERY*/
MSUNLOCK("ASSOP")
return











/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PFAT160   �Autor  �Danilo C S Pala     � Data �  09/18/03   ���
�������������������������������������������������������������������������͹��
���Desc.     � Mostra o resultado final da apuracao dos registros que     ���
���          � gravados em ASSOP.DBF                                      ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Mostra()
@ 200,001 TO 400,450 DIALOG oDlg TITLE " Confirme ... "
@ 003,010 TO 090,220
@ 15,018 Say "Produto................: "+Trim(MV_PAR01)+ " A " + Trim(MV_PAR02)
@ 30,018 Say "CEP....................: "+MV_PAR05      + " A " + MV_PAR06
@ 45,018 SAY "Quantidade Selecionada.: "+STRZERO(MV_PAR09,7,0)
@ 60,018 SAY "Quantidade Mailing.....: "+STRZERO(ContQtd ,7,0)
@ 75,188 BMPBUTTON TYPE 01 ACTION Close(oDlg)
Activate Dialog oDlg Centered

Return








//���������������������������������������������������������������������������Ŀ
//� Function  � F_VERSZA                                                      �
//���������������������������������������������������������������������������Ĵ
//� Descricao � Valida geraCAO do arquivo  de dados                           �
//���������������������������������������������������������������������������Ĵ
//� Observ.   �                                                               �
//�����������������������������������������������������������������������������
Static Function F_VERSZA()
DBSELECTAREA("SZA") //Cadastro de promocoes de venda
DBGOTOP()
IF !DBSEEK(XFILIAL("SZA")+MV_PAR12)
	MsgStop("Promocao nao cadastrada")
	MsgStop("Entrar em contato com depto de Cadastro")
	mValida    := "N"
ELSE
	DBSELECTAREA('SX5') //controle de tabelas
	DBGOTOP()
	IF !DBSEEK(XFILIAL("SX5")+'91'+MV_PAR13)
		MsgStop("Mailing n�o cadastrado")
		MsgStop("Entrar em contato com depto de Marketing")
		mValida := "N"
	ELSE
		mValida := "S"
	ENDIF
ENDIF
Return




//���������������������������������������������������������������������������Ŀ
//� Function  � F_AtuZZ7                                                      �
//���������������������������������������������������������������������������Ĵ
//� Descricao � Atualiza arquivo de controle de utilizacao.                   �
//���������������������������������������������������������������������������Ĵ
//� Observ.   �                                                               �
//�����������������������������������������������������������������������������
Static Function F_AtuZZ7()
DbSelectArea("ZZ7")
RecLock("ZZ7",.T.)
ZZ7->ZZ7_CODPRO := MV_PAR12
ZZ7->ZZ7_CODMAI := MV_PAR13
ZZ7->ZZ7_USUAR  := Subs(cUsuario,7,15)
ZZ7->ZZ7_DATA   := Date()
ZZ7->ZZ7_QTDE   := mConta1
ZZ7->ZZ7_SAIDA  := mSaida
ZZ7->ZZ7_PROD1  := MV_PAR01
ZZ7->ZZ7_PROD2  := MV_PAR02
ZZ7->ZZ7_CEP1   := MV_PAR05
ZZ7->ZZ7_CEP2   := MV_PAR06
ZZ7->ZZ7_ATIV1  := MV_PAR14
ZZ7->ZZ7_ATIV2  := MV_PAR15
ZZ7->ZZ7_TPCLI  := Str(MV_PAR16,1)
ZZ7->ZZ7_UTILIZ := Str(MV_PAR17,1)
ZZ7->ZZ7_DUPLIC := Str(MV_PAR11,1)
ZZ7->ZZ7_SITUAC := Str(MV_PAR08,1)
ZZ7->ZZ7_TPVEND := Str(MV_PAR07,1)
MsUnLock()
Return
