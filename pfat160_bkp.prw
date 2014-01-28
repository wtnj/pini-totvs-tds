#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"  //consulta SQL
/*   alterado em 20030915 por danilo
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFat160   ºAutor  ³Danilo C S Pala     º Data ³  20030915   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Programa para otimizacao do Pfat106C, com query 			  º±±
±±º          ³  (Clientes Cont/Arq)										  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Pfat160

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

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                    ³
//³                                                                         ³
//³ mv_par01 Do Produdo.........:                                           ³
//³ mv_par02 At‚ o Produto......:                                           ³
//³ mv_par03 Faturados/Venc de..:                                           ³
//³ mv_par04 Faturados/Venc at‚.:                                           ³
//³ mv_par05 Do CEP.............:                                           ³
//³ mv_par06 At‚ CEP............:                                           ³
//³ mv_par07 Tipo...............: Pagas, Cortesia, Ambas.                   ³
//³ mv_par08 Situacao...........: Baixados, Em Aberto, Ambas.               ³
//³ mv_par09 Qtde da Selecao....:                                           ³
//³ mv_par10 Gerar..............: Contagem, Arquivo.                        ³
//³ mv_par11 Elimina duplicidade: Sim, Nao.                                 ³
//³ mv_par12 Cod. Promo‡Æo......:                                           ³
//³ mv_par13 Cod. Mailing.......:                                           ³
//³ mv_par14 Da Atividade.......:                                           ³
//³ mv_par15 At‚ Atividade......:                                           ³
//³ mv_par16 Tipo Cliente.......: Ass. Ativos, Ass. Cancelados, Outros.     ³
//³ mv_par17 Utilizacao.........: Mala Direta, TeleMarketing.               ³
//³ mv_par18 Processa por.......: Clientes,Produtos.                        ³
//³ mv_par19 Inclui representante: Sim  Nao                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


mConta1   := 0
mConta2   := 0
mConta3   := 0
MHORA     := TIME()
cArq      := SUBS(CUSUARIO,1,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString   := SUBS(CUSUARIO,1,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
mSaida    := "1"
cArqPath  := GetMv("MV_PATHTMP")
_cString  := cArqPath+cString+".DBF"
cPerg     := "PF106C"

If !Pergunte(cPerg)
	Return
Endif
/*
If MV_PAR10 <> 1
	DbSelectArea("ZZ7")
	If DbSeek(xfilial("ZZ7")+MV_PAR12+MV_PAR13+MSAIDA)
		MsgStop("C¢digo j  utilizado, informe c¢digo v lido ou solicite manutencao no cad. Mailing")
		Return
	Endif
	
	F_VERSZA()
	
	IF mValida == 'N'
		RETURN
	ENDIF
Endif */

//FArqTrab()

lEnd:= .F.

If mv_par18 == 2
//	bBloco:= {|lEnd| Produtos(@lEnd)}
Else
	bBloco:= {|lEnd| Clientes(@lEnd)}
EndIf

MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
  /*
MOSTRA()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza arquivo de controle  - saida de mailing             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
F_ATUZZ7()

While .T.
	If !Pergunte(cPerg)
		Exit
	Endif
	
	If LastKey() == 27
		Exit
	Endif
	
	lEnd:= .F.
	If mv_par18 == 1
		bBloco:= {|lEnd| Clientes(@lEnd)}
	Else
		bBloco:= {|lEnd| Produtos(@lEnd)}
	EndIf
	
	MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )
	
	MOSTRA()
	
	IF MV_PAR10 <> 1
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Valida gera‡Æo do mailing  - Verifica promo‡Æo               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		F_VERSZA()
		IF mValida == 'N'
			DbSelectArea(cArq)
			DbCloseArea()
			RETURN
		ENDIF
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Atualiza arquivo de controle  - saida de mailing             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		F_ATUZZ7()
		
	ENDIF
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava arquivo para Access...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par10 == 2
	cMsg := "Arquivo Gerado com Sucesso em: "+_cString
	lEnd:= .F.
	bBloco:= {|lEnd| FGERARQ(@lEnd)}
	MsAguarde(bBloco,"Aguarde" ,"Copiando Arquivo...", .T. )
	MSGINFO(cMsg)
Endif

DbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorna indices originais...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

DbSelectArea(cArq)
DbCloseArea()
Return


         */
return









/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PFAT160   ºAutor  ³Danilo C S Pala     º Data ³  09/15/03   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao que executa a query 				                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Advanced Protheus                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Clientes
Private contador := 0
Private cUpdate := ""
DbselectArea("SA1")
if RDDName() <> "TOPCONN"
	MsgStop("Este programa somente podera ser executado na versao SQL do SIGA Advanced.")
	Return nil
endif                             


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³campos da consulta de edicao em circulacao (SZJ)³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_aCamposSZJ := {}
AADD(_aCamposSZJ,{"zj_codrev","zj_codrev"})
AADD(_aCamposSZJ,{"zj_edicao","zj_edicao"})
AADD(_aCamposSZJ,{"zj_dtcirc","zj_dtcirc"})    



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³campos da consulta de cliente/pedido/operacao...³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_aCampos:={}                  
AADD(_aCampos,{"c6_produto","C",6,0})
AADD(_aCampos,{"codrev","C",4,0})
AADD(_aCampos,{"c6_datfat","D",8,0})
AADD(_aCampos,{"c6_cli","C",6,0})
AADD(_aCampos,{"c6_num","C",6,0})
AADD(_aCampos,{"c6_item","C",2,0})
AADD(_aCampos,{"c6_qtdven","N",12,2}) 
AADD(_aCampos,{"c6_valor","N",12,2})
AADD(_aCampos,{"c6_cf","C",2,0})
AADD(_aCampos,{"c6_tes","C",3,0})
AADD(_aCampos,{"c6_coddest","C",2,0})
AADD(_aCampos,{"c6_filial","C",2,0})
AADD(_aCampos,{"c6_edvenc","N",4,0})
AADD(_aCampos,{"c6_edinic","N",4,0})
AADD(_aCampos,{"c6_edsusp","N",4,0})
AADD(_aCampos,{"c6_edfin","N",4,0})
AADD(_aCampos,{"c6_descri","C",30,0})
AADD(_aCampos,{"c5_vend1","C",6,0})
AADD(_aCampos,{"c5_respcob","C",40,0})
AADD(_aCampos,{"c5_tipoop","C",3,0})
AADD(_aCampos,{"z9_descr","C",40,0})
AADD(_aCampos,{"f4_texto","C",40,0})
AADD(_aCampos,{"a1_nome","C",40,0})
AADD(_aCampos,{"a1_end","C",40,0})
AADD(_aCampos,{"a1_bairro","C",20,0}) 
AADD(_aCampos,{"a1_mun","C",20,0})
AADD(_aCampos,{"a1_est","C",2,0})
AADD(_aCampos,{"a1_cep","C",8,0})
AADD(_aCampos,{"a1_tel","C",20,0})
AADD(_aCampos,{"a1_cgc","C",20,0})
AADD(_aCampos,{"a1_inscr","C",20,0})
AADD(_aCampos,{"a1_inscrm","C",20,0})
AADD(_aCampos,{"a1_email","C",40,0})
AADD(_aCampos,{"a1_fax","C",20,0})
AADD(_aCampos,{"a1_ativida","C",6,0}) 
AADD(_aCampos,{"a1_tpcli","C",2,0})
AADD(_aCampos,{"a1_pricom","D",8,0})
AADD(_aCampos,{"a1_ultcom","D",8,0})
AADD(_aCampos,{"z9_del","C",1,0})
AADD(_aCampos,{"f4_del","C",1,0})
AADD(_aCampos,{"c5_del","C",1,0})
AADD(_aCampos,{"a1_del","C",1,0})
AADD(_aCampos,{"c6_del","C",1,0}) 


aArq := _aCampos
_cNome := CriaTrab(_aCampos,.t.)
dbUseArea(.T.,, _cNome,"WEBOP",.F.,.F.)  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query getting as edicoes em circulacao(SZJ)³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
///* teste 20030916
cQuerySZJ := "SELECT distinct zj_codrev, zj_edicao, zj_dtcirc FROM szj010 where zj_dtcirc > '"+ dtos(dDataBase-30) +"' and zj_dtcirc <='"+ dtos(dDataBase) +"' and d_e_l_e_t_ <>'*'
TCQUERY cQuerySZJ NEW ALIAS "QUERYSZJ"

@ 200,001 TO 400,600 DIALOG oDlg1 TITLE "QUERYSZJ"
@ 6,5 TO 100,250 BROWSE "QUERYSZJ" FIELDS _aCamposSZJ
@ 070,260 BUTTON "_Ok" SIZE 40,15 ACTION Close(oDlg1)
ACTIVATE DIALOG oDlg1 CENTERED


//loop nas edicoes atuais, getting os pedidos referentes
while !eof("QuerySZJ")
                 */
	cQuery := "SELECT c6_produto as , substr(c6_produto,1,4) as codrev, c6_datfat, c6_cli, c6_num, c6_item, c6_qtdven, c6_valor, c6_cf, c6_tes, c6_coddest, c6_filial, c6_edvenc, c6_edinic, c6_edsusp, c6_edfin, c6_descri,"
	cQuery += "/*sc5*/ c5_vend1, c5_respcob, c5_tipoop, "
	cQuery += "/*SZ9*/ z9_descr, "
	cQuery += "/*sf4*/ f4_texto,"
	cQuery += "/*sa1*/ a1_nome, a1_end, a1_bairro, a1_mun, a1_est, a1_cep, a1_tel, a1_cgc, a1_inscr, a1_inscrm, a1_email, a1_fax, a1_ativida, a1_tpcli, a1_pricom, a1_ultcom, "
	cQuery += "	/*deletado*/ c6.d_e_l_e_t_ as c6_del, a1.d_e_l_e_t_ as a1_del, c5.d_e_l_e_t_ as c5_del, f4.d_e_l_e_t_ as f4_del, z9.d_e_l_e_t_ as z9_del "
	cQuery += " FROM SC6010 C6, SC5010 C5, SZ9010 Z9, SF4010 F4, SA1010 A1 "
	cQuery += " WHERE (c6_filial='01')"
	cQuery += "  and (c6_cli<>'040000') "
	cQuery += "  and (c6_produto>='"+ alltrim(MV_PAR01) +"') and (c6_produto<='"+ alltrim(MV_PAR02) +"')
	cQuery += "  and (substr(c6_produto,5,3)<>'001') "
	cQuery += "  and (c5_filial='01') and (c5_num=c6_num)"
	cQuery += "  and (substr(c6_produto,1,4) = '"+ Alltrim(QuerySZJ->ZJ_CODREV) +"') and (c6_edinic<="+ Alltrim(Str(QuerySZJ->ZJ_EDICAO)) +") and (c6_edsusp >="+ Alltrim(Str(QuerySZJ->ZJ_EDICAO)) +") "
//	cQuery += "  and (substr(c6_produto,1,4) = '0115') and (c6_edinic<=26) and (c6_edsusp >=26) "
	cQuery += "  and (z9_filial='  ') and (z9_tipoop = c5_tipoop)"
	cQuery += "  and (f4_filial='01') and (f4_codigo=c6_tes)"
	cQuery += "  and (a1_cod =c6_cli) and (a1_loja=c6_loja) and (a1_filial='  ')"
	cQuery += "  and (a1_cep >= '"+ alltrim(Mv_Par05) +"') and (a1_cep<='"+ alltrim(mv_par06) +"') "
	cQuery += "  and (a1_ativida >= '"+ alltrim(mv_par14) +"') and (a1_ativida >= '"+ alltrim(mv_par15) +"') "
	TCQUERY cQuery NEW ALIAS "QUERY"                        
	
	ReplaWebop()
    
    dbSelectArea("Query")
	DBCloseArea("Query") 
	    
	DbSelectArea("QuerySZJ")
	DBSkip()
end    

DBCloseArea("QuerySZJ")            
DBSelectArea("WEBOP")
Copy to &("\SIGA\EXPORTA\WEBOP.DBF")    
/*
Limpar() //pfat160A
Processar()//pfat160A
Gravar() //pfat160A
*/
DBCloseArea("WEBOP")
MsgAlert("Gerado: \SIGA\EXPORTA\WEBOP.DBF")
return



Static Function ReplaWebop()
DBSelectArea("Query")
DbGotop()
While !eof("Query")
	DBSELECTAREA("WEBOP")
	Reclock("WEBOP",.t.)
	WEBOP->c6_produto := QUERY->c6_produto
	WEBOP->codrev := QUERY->codrev
	WEBOP->c6_datfat := CtoD(ConverterData(QUERY->c6_datfat))
	WEBOP->c6_cli := QUERY->c6_cli
	WEBOP->c6_num := QUERY->c6_num
	WEBOP->c6_item := QUERY->c6_item
	WEBOP->c6_qtdven := QUERY->c6_qtdven
	WEBOP->c6_valor := QUERY->c6_valor
	WEBOP->c6_cf := QUERY->c6_cf
	WEBOP->c6_tes := QUERY->c6_tes
	WEBOP->c6_coddest := QUERY->c6_coddest
	WEBOP->c6_filial := QUERY->c6_filial
	WEBOP->c6_edvenc := QUERY->c6_edvenc
	WEBOP->c6_edinic := QUERY->c6_edinic
	WEBOP->c6_edsusp := QUERY->c6_edsusp
	WEBOP->c6_edfin := QUERY->c6_edfin
	WEBOP->c6_descri := QUERY->c6_descri
	WEBOP->c5_vend1 := QUERY->c5_vend1
	WEBOP->c5_respcob := QUERY->c5_respcob
	WEBOP->c5_tipoop := QUERY->c5_tipoop
	WEBOP->z9_descr := QUERY->z9_descr
	WEBOP->f4_texto := QUERY->f4_texto
	WEBOP->a1_nome := QUERY->a1_nome
	WEBOP->a1_end := QUERY->a1_end
	WEBOP->a1_bairro := QUERY->a1_bairro
	WEBOP->a1_mun := QUERY->a1_mun
	WEBOP->a1_est := QUERY->a1_est
	WEBOP->a1_cep := QUERY->a1_cep
	WEBOP->a1_tel := QUERY->a1_tel
	WEBOP->a1_cgc := QUERY->a1_cgc
	WEBOP->a1_inscr := QUERY->a1_inscr
	WEBOP->a1_inscrm := QUERY->a1_inscrm
	WEBOP->a1_email := QUERY->a1_email
	WEBOP->a1_fax := QUERY->a1_fax
	WEBOP->a1_ativida := QUERY->a1_ativida
	WEBOP->a1_tpcli := QUERY->a1_tpcli
	WEBOP->a1_pricom := QUERY->a1_pricom
	WEBOP->a1_ultcom := QUERY->a1_ultcom
	WEBOP->z9_del := QUERY->z9_del
	WEBOP->f4_del := QUERY->f4_del
	WEBOP->c5_del := QUERY->c5_del
	WEBOP->a1_del := QUERY->a1_del
	WEBOP->c6_del := QUERY->c6_del
	MSUNLOCK("WEBOP")
	DbSelectArea("Query")
	DBSkip()
end           
return



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³converterData³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
static Function ConverterData(data_old)             //12345678
setprvt("data_new")                      //20030814
data_new := substr(data_old,7,2)+"/"+substr(data_old,5,2)+"/"+substr(data_old,3,2)
return data_new