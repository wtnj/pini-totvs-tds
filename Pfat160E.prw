#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*   alterado em 20030915 por danilo
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPFat160E  บAutor  ณDanilo C S Pala     บ Data ณ  20030915   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Programa para otimizacao do Pfat106E, com query 			  บฑฑ
ฑฑบ          ณ  (Impressao de etiquetas conforme arquivo)				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Pfat160E
                                               
SetPrvt("cDesc1, cDesc2, cDesc3, Titulo")
SetPrvt("aReturn, cPrograma, MHORA, wnrel, cString")
SetPrvt("nLastKey, L, nOrdem, m_pag, nCaracter")
SetPrvt("tamanho, cTitulo, cCabec1, cCabec2")
SetPrvt("lContinua, mSaida")
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
SetPrvt("contdel, contproc, mContAss")
SetPrvt("_aCamposF, _cNomeF")
SetPrvt("_cNomeF, _aCamposF, cIndex, cKey, MsgSZJ, nRegistro")
SetPrvt("MsgSZJ, mEmpresa")
SetPrvt("mDest, mEnd, mBairro, mMun, mEst, mCEP, mFone1")

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Variaveis utilizadas para parametros                                    ณ
//ณ                                                                         ณ
//ณ mv_par01 Do Produdo.........:                                           ณ
//ณ mv_par02 At o Produto......:                                           ณ
//ณ mv_par03 Faturados/Venc de..:                                           ณ
//ณ mv_par04 Faturados/Venc at.:                                           ณ
//ณ mv_par05 Do CEP.............:                                           ณ
//ณ mv_par06 At CEP............:                                           ณ
//ณ mv_par07 Tipo...............: Pagas, Cortesia, Ambas.                   ณ
//ณ mv_par08 Situacao...........: Baixados, Em Aberto, Ambas.               ณ
//ณ mv_par09 Qtde da Selecao....:                                           ณ
//ณ mv_par10 Gerar..............: Contagem, Arquivo.                        ณ
//ณ mv_par11 Elimina duplicidade: Sim, Nao.                                 ณ
//ณ mv_par12 Cod. Promoฦo......:                                           ณ
//ณ mv_par13 Cod. Mailing.......:                                           ณ
//ณ mv_par14 Da Atividade.......:                                           ณ
//ณ mv_par15 At Atividade......:                                           ณ
//ณ mv_par16 Tipo Cliente.......: Ass. Ativos, Ass. Cancelados, Outros.     ณ
//ณ mv_par17 Utilizacao.........: Mala Direta, TeleMarketing.               ณ
//ณ mv_par18 Processa por.......: Clientes,Produtos.                        ณ
//ณ mv_par19 Inclui representante: Sim  Nao                                 ณ
//ณ mv_par20 Natureza do Cliente: Fisica, Juridica, Ambas                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
                           
CONTQTD	  := 0
mSaida    := "1"
mEmpresa  := SM0->M0_CODIGO
cDesc1   := PADC("Este programa ira gerar o arquivo de clientes em etiquetas" ,74)
cDesc2   := PADC("Elimina duplicidade por codigo de cliente e destinatario",74)
cDesc3   := ""
Titulo   := PADC("ETIQUETAS",74)
aReturn  := { "Especial", 1,"Administraฦo", 1, 2, 1,"",1 }
cPrograma:="PFA106E"
MHORA    :=TIME()
wnrel    :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString  :=SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
nLastKey := 00
L        := 00
nOrdem   := 00
m_pag    := 01
nCaracter:= 10
tamanho  := "P"
cTitulo  := ""
cCabec1  := ""
cCabec2  := ""
lContinua:= .T.
mSaida   := "3"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Caso nao exista, cria grupo de perguntas.                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cPerg    := "PF106C"


If !Pergunte(cPerg)
	Return
Endif

IF Lastkey() == 27
	Return
Endif

///*     teste 20030919
If MV_PAR10 = 2
	DbSelectArea("ZZ7")
	If DbSeek(xfilial("ZZ7")+MV_PAR12+MV_PAR13+MSAIDA)
		MsgStop("Cขdigo j  utilizado, informe cขdigo v lido ou solicite manutencao no cad. Mailing")
		Return
	Endif

	F_VERSZA()
	IF mValida == 'N'
		RETURN
	ENDIF
Endif//*/

IF MV_PAR16 = 1
	Processa({|| Ativos()})
ELSEIF MV_PAR16 = 2
	Processa({|| Inativos()})
ELSE
	Processa({|| Outros()})
END IF
	
wnrel:=SetPrint("ASSOP",wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.)
SetDefault(aReturn,"ASSOP")
                       
Etiqueta()   

///*
If MV_PAR10 = 2
	DBSelectArea("ASSOP")              
	Copy to &("\SIGA\EXPORTA\ASSOP.DBF") VIA "DBFCDXADS" // 20121106 
	DBCloseArea("ASSOP")
	MsgAlert(OemToAnsi(MsgSZJ))
	F_ATUZZ7() 
else
	Mostrar()
EndIf
 // */
DBSelectArea("ASSOP")
DBCloseArea("ASSOP")
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPFAT160   บAutor  ณDanilo C S Pala     บ Data ณ  09/15/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que executa a query dos Ativos		                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Advanced Protheus                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณcampos da consulta de edicao em circulacao (SZJ)ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
_aCamposSZJ := {}
AADD(_aCamposSZJ,{"zj_codrev","zj_codrev"})
AADD(_aCamposSZJ,{"zj_edicao","zj_edicao"})
AADD(_aCamposSZJ,{"zj_dtcirc","zj_dtcirc"})    


FArqTrab()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณQuery getting as edicoes em circulacao(SZJ)ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
	cQuery += "  and (f4_filial='"+xfilial("SF4")+"') and (f4_codigo=c6_tes)"
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณInativos()บAutor  ณDanilo C S Pala     บ Data ณ  20030919   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que executa a query dos Inativos                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Advanced Protheus                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณcampos da consulta de edicao em circulacao (SZJ)ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
_aCamposSZJ := {}
AADD(_aCamposSZJ,{"EdDe","N",4,0})
AADD(_aCamposSZJ,{"EdAte","N",4,0})
AADD(_aCamposSZJ,{"zj_codRev","C",4,0})    


FArqTrab()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณQuery getting as edicoes em circulacao(SZJ)ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
	cQuery += "  and (f4_filial='01') and (f4_codigo=c6_tes)"
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณOutros()  บAutor  ณDanilo C S Pala     บ Data ณ  20030919   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao que executa a query dos Outros(todos os pedidos no   บฑฑ
ฑฑบ          ณintervalo de datas informado							   	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Advanced Protheus                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFArqTrab()บAutor  ณDAnilo C S Pala     บ Data ณ  09/19/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria o arquivo ASSOP                                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPROCASSOP()  บAutor  ณDAnilo C S Pala     บ Data ณ  09/18/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function PROCASSOP()
contDel := 0
ContProc := 0
ContCons := 0
DBSELECTAREA("QUERY")
DbGotop()            
While !eof("QUERY") .and. (CONTQTD <= MV_PAR09)
	//PROCESSAR CONSISTENCIAS
		mTpprod   := ""
		mPRODUTO  := QUERY->C6_PRODUTO
		mPEDIDO   := QUERY->C6_NUM
		mCODCLI   := QUERY->C6_CLI
		mCODDEST  := QUERY->C6_CODDEST
		mTES 	  := QUERY->C6_TES
		mCF 	  := QUERY->C6_CF
		mF4_TEXTO := QUERY->F4_TEXTO  
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
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Verifica o se eh conversao pois o c6_datfat estah em branco  ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
	                                                                      
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Verifica o se eh pessoa fisica ou juridica				     ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Verifica o registro faz parte do cad de representante        ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Verifica se  pago 1/cortesia 2/ambas 3	                     ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
	
	
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณcalculando as baixas						                     ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
	MsgSZJ += Alltrim(QuerySZJ->zj_codrev) + Alltrim(QuerySZJ->zj_edicao) + ": processados: "+ Alltrim(str(contproc)) +", deletados: "+ Alltrim(str(contdel)) +" e Del por Consist: "+ Alltrim(str(contcons))+CHR(10)+CHR(13)
ELSEIF MV_PAR16=2
	MsgSZJ += Alltrim(QuerySZJ->zj_codrev) +": processados: "+ Alltrim(str(contproc)) +", deletados: "+ Alltrim(str(contdel)) +" e Del por Consist: "+ Alltrim(str(contcons))+CHR(10)+CHR(13)
ELSE
	MsgSZJ += "ASSOP: processados: "+ Alltrim(str(contproc)) +", deletados: "+ Alltrim(str(contdel)) +" e Del por Consist: "+ Alltrim(str(contcons))+CHR(10)+CHR(13)
ENDIF
return                                                                













/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGRAVAR()  บAutor  ณDanilo C S Pala     บ Data ณ  09/18/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Grava os dados em ASSOP.DBF                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
MSUNLOCK("ASSOP")
return










/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPFAT160   บAutor  ณDanilo C S Pala     บ Data ณ  09/18/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Mostra o resultado final da apuracao dos registros que     บฑฑ
ฑฑบ          ณ gravados em ASSOP.DBF                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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








//ฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Function  ณ F_VERSZA                                                      ณ
//รฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
//ณ Descricao ณ Valida geraCAO do arquivo  de dados                           ณ
//รฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
//ณ Observ.   ณ                                                               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Static Function F_VERSZA()
DBSELECTAREA("SZA")
DBGOTOP()
IF !DBSEEK(XFILIAL("SZA")+MV_PAR12)
	MsgStop("Promocao nao cadastrada")
	MsgStop("Entrar em contato com depto de Cadastro")
	mValida    := "N"
ELSE
	DBSELECTAREA('SX5')
	DBGOTOP()
	IF !DBSEEK(XFILIAL("SX5")+'91'+MV_PAR13)
		MsgStop("Mailing nฦo cadastrado")
		MsgStop("Entrar em contato com depto de Marketing")
		mValida := "N"
	ELSE
		mValida := "S"
	ENDIF
ENDIF
Return




//ฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Function  ณ F_AtuZZ7                                                      ณ
//รฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
//ณ Descricao ณ Atualiza arquivo de controle de utilizacao.                   ณ
//รฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
//ณ Observ.   ณ                                                               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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


//ฺฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Function  ณ ETIQUETA()                                                    ณ
//รฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
//ณ Descricao ณ Realiza Impressao das etiquetas conforme arquivo de trabalho. ณ
//รฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
//ณ Observ.   ณ                                                               ณ
//ภฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Static Function ETIQUETA()
SetPrc(0,0)
Lin:= 0
Col:= 1
Li := 0

DbSelectArea("ASSOP")
cIndex := CriaTrab(Nil,.F.)
cKey   := "ZZ6_CEP+ZZ6_NOME+ZZ6_CONTAT"
Indregua("ASSOP",cIndex,ckey,,,"Indexando ASSOP")
dbGoTop()

Count to mConta
pROCRegua(RecCount())
DbGoTop()

While ! EOF()
	IncPROC()
	
	@ Lin+Li,001 PSAY ASSOP->ZZ6_NOME
	DBSKIP()
	@ LIN+LI,043 PSAY ASSOP->ZZ6_NOME
	DBSKIP()
	@ LIN+LI,087 PSAY ASSOP->ZZ6_NOME
	DBSKIP(-2)
	LI:=LI+1
	
	IF ! EMPTY(ASSOP->ZZ6_CONTAT)
		@ LIN+LI,001 PSAY ASSOP->ZZ6_CONTAT
		DBSKIP()
		@ LIN+LI,043 PSAY ASSOP->ZZ6_CONTAT
		DBSKIP()
		@ LIN+LI,087 PSAY ASSOP->ZZ6_CONTAT
		DBSKIP(-2)
		LI:=LI+1
	ELSE
		@ LIN+LI,001 PSAY ASSOP->RESPCOB
		DBSKIP()
		@ LIN+LI,043 PSAY ASSOP->RESPCOB
		DBSKIP()
		@ LIN+LI,087 PSAY ASSOP->RESPCOB
		DBSKIP(-2)
		LI:=LI+1
	ENDIF
	
	@ LIN+LI,001 PSAY ASSOP->ZZ6_END
	DbSkip()
	@ LIN+LI,043 PSAY ASSOP->ZZ6_END
	DbSkip()
	@ LIN+LI,087 PSAY ASSOP->ZZ6_END
	DbSkip(-2)
	Li:=Li+1
	
	@ Lin+Li,001 PSAY ASSOP->ZZ6_BAIRRO+'          '+'('+ASSOP->NUMPED+')'
	DbSkip()
	@ Lin+Li,043 PSAY ASSOP->ZZ6_BAIRRO+'          '+'('+ASSOP->NUMPED+')'
	DbSkip()
	@ Lin+Li,087 PSAY ASSOP->ZZ6_BAIRRO+'          '+'('+ASSOP->NUMPED+')'
	DbSkip(-2)
	Li:=Li+1
	
	@ Lin+Li,001 PSAY SUBS(ASSOP->ZZ6_CEP,1,5)+'-'+SUBS(ASSOP->ZZ6_CEP,6,3)+'   ' +ASSOP->ZZ6_Mun+' ' +ASSOP->ZZ6_ESTADO
	DbSkip()
	@ LIN+LI,043 PSAY SUBS(ASSOP->ZZ6_CEP,1,5)+'-'+SUBS(ASSOP->ZZ6_CEP,6,3)+'   ' +ASSOP->ZZ6_Mun+' ' +ASSOP->ZZ6_ESTADO
	DbSkip()
	@ LIN+LI,087 PSAY SUBS(ASSOP->ZZ6_CEP,1,5)+'-'+SUBS(ASSOP->ZZ6_CEP,6,3)+'   ' +ASSOP->ZZ6_Mun+' ' +ASSOP->ZZ6_ESTADO
	LI:=LI+1
	DbSkip()
	
	Li:=2
	SetPrc(0,0)
	Lin:=Prow()
End

@ Lin+Li  ,001 PSAY '****************************************'
@ Lin+Li+1,001 PSAY 'TOTAL...................:'+STR(MCONTA,7)
@ Lin+Li+2,001 PSAY '****************************************'

Set Devi To Screen
IF aRETURN[5] == 1
	Set Printer to
	dbcommitAll()
	ourspool(WNREL)
ENDIF

MS_FLUSH()
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณVALIDPERG ณ Autor ณ  Luiz Carlos Vieira   ณ Data ณ 16/07/97 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Verifica as perguntas incluกndo-as caso no existam        ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Especกfico para clientes Microsiga                         ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _ValidPerg
Static Function _ValidPerg()
_sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg := PADR(cPerg,6)
aRegs:={}
// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3
AADD(aRegs,{cPerg,"01","Do Produdo.........:","mv_ch1","C",15,0,0,"G","","mv_par01","","0108001","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"02","At o Produto......:","mv_ch2","C",15,0,0,"G","","mv_par02","","0108003","","","","","","","","","","","","","SB1"})
AADD(aRegs,{cPerg,"03","Faturados/Venc de..:","mv_ch3","D",08,0,0,"G","","mv_par03","","'01/06/99'","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Faturados/Venc at.:","mv_ch4","D",08,0,0,"G","","mv_par04","","'17/04/00'","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"05","Do CEP.............:","mv_ch5","C",08,0,0,"G","","mv_par05","","12000000","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"06","At CEP............:","mv_ch6","C",08,0,0,"G","","mv_par06","","12999999","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"07","Tipo...............:","mv_ch7","C",01,0,3,"C","","mv_par07","Pagos","","","Cortesias","","","Ambas","","","","","","","",""})
AADD(aRegs,{cPerg,"08","Situaฦo...........:","mv_ch8","C",01,0,3,"C","","mv_par08","Baixados","","","Em aberto","","","Ambas","","","","","","","",""})
AADD(aRegs,{cPerg,"09","Qtde da Selecao....:","mv_ch9","N",07,0,3,"G","","mv_par09","","9999999","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"10","Elimina duplicidade:","mv_chA","C",01,0,1,"C","","mv_par10","Sim","ZZZZZZZ","","Nao","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"11","Cod. Promoฦo......:","mv_chB","C",03,0,1,"G","","mv_par11","","N","","","","","","","","","","","","","SZA"})
AADD(aRegs,{cPerg,"12","Cod. Mailing.......:","mv_chC","C",03,0,1,"G","","mv_par12","","107","","","","","","","","","","","","","91"})
AADD(aRegs,{cPerg,"13","Da Atividade.......:","mv_chD","C",07,0,0,"G","","mv_par13","","","","","","","","","","","","","","","ZZ8"})
AADD(aRegs,{cPerg,"14","At Atividade......:","mv_chE","C",07,0,0,"G","","mv_par14","","ZZZZZZZ","","","","","","","","","","","","","ZZ8"})
AADD(aRegs,{cPerg,"15","Tipo Cliente.......:","mv_chF","C",01,0,3,"C","","mv_par15","Ass. Ativos","","","Ass. Cancelados","","","Outros","","","","","","","",""})
AADD(aRegs,{cPerg,"16","Utilizacao.........:","mv_chG","C",01,0,1,"C","","mv_par16","Mala Direta","","","Telemarketing","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"17","Processa por.......:","mv_chH","C",01,0,1,"C","","mv_par17","Clientes","","","Produtos","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"18","Inclui Representante:","mv_chI","C",01,0,1,"C","","mv_par18","Sim","","","Nฦo","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"19","Natureza do Cliente:","mv_chj","C",01,0,1,"C","","mv_par19","Fisica","","","Juridica","","","Ambas","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		SX1->(MsUnlock())
	Endif
Next
DbSelectArea(_sAlias)
Return