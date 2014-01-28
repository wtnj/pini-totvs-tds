#include "rwmake.ch"        
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFIN027   ³Autor: DANILO CESAR SESTARI PALA ³ Data: 20101013³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡Æo: Relatorio TITULOS A RECEBER EM ABERTO                      ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : Pini													     ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PFIN027()

SetPrvt("CPERG,_StringArq, cquery, MHORA, aRegs")
MHORA      := TIME()
_StringArq := "\SIGA\ARQTEMP\"+ SUBS(CUSUARIO,7,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2) +".DBF"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros      ³
//³ mv_par01             cliente de           ³
//³ mv_par02             cliente ate          ³
//³ mv_par03             Prefixos: 1, UNI, PUB³
//³ mv_par04             titulo de            ³
//³ mv_par05             Titulo ate           ³
//³ mv_par06             Banco de             ³
//³ mv_par07             Banco ate            ³
//³ mv_par08             //Vencto de          ³
//³ mv_par09             //Vencto ate         ³
//³ mv_par10             //Emissao de         ³
//³ mv_par11             //Emissao ate        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPerg    := "PFIN027"  
ValidPerg()
If !Pergunte(cPerg)
   Return
Endif

If Select("PFIN027") <> 0
	DbSelectArea("PFIN027")
	DbCloseArea()
EndIf
      
bBloco:= { |lEnd| RptDetail()  }
MsAguarde( bBloco, "Aguarde" ,"Processando...", .T. )

RETURN


Static Function RptDetail() 
Private cPrefixos := ""            
Private cNovoPref := ""
Private cAuxPref := ""
Private nVirgula := 0

cPrefixos := mv_par03
nVirgula := At(",",cPrefixos)
if nVirgula ==0 
	nVirgula := len(cPrefixos)
endif
While ( nVirgula >0 )
		cAuxPref := SubStr(cPrefixos,0, nVirgula-1)
		if cNovoPref == ""
			cNovoPref := "'" + padr(cAuxPref,3)+"'"
		else                                        
			cNovoPref := cNovoPref+ ",'" + padr(cAuxPref,3)+"'"			
		endif
		cPrefixos := Substr(cPrefixos,nVirgula+1, len(cPrefixos)-nVirgula)
		nVirgula := At(",",cPrefixos)
		if nVirgula ==0 
			nVirgula := len(cPrefixos)
		endif
End
//'1  ','UNI','PUB'

      
cQuery := "SELECT E1_CLIENTE, E1_LOJA, E1_PREFIXO, E1_NUM, E1_PARCELA, SUBSTR(F_CONVERTER_DATA_SIGA(E1_EMISSAO),1,10) AS EMISSAO, SUBSTR(F_CONVERTER_DATA_SIGA(E1_VENCTO),1,10) AS VENCTO, SUBSTR(F_CONVERTER_DATA_SIGA(E1_VENCREA),1,10) AS VENCREA, E1_BAIXA, E1_NATUREZ, E1_PORTADO, E1_NOMCLI, E1_VALOR, E1_SALDO, E1_NUMBCO, E1_OBS, E1_HIST, E1_PEDIDO, SUBSTR(F_ITENSPEDIDO(E1_PEDIDO,'01'),1,200) AS ITENSPED"
cQuery := cQuery + " FROM "+ RetSqlName("SE1") +" SE1 WHERE E1_FILIAL='"+ xFilial("SE1") +"' AND E1_CLIENTE>='"+ MV_PAR01 +"' AND E1_CLIENTE <='"+ MV_PAR02 +"' AND E1_PREFIXO IN("+ cNovoPref +")"
cQuery := cQuery + " AND E1_NUM>='"+ MV_PAR04 +"' AND E1_NUM<='"+ MV_PAR05 +"' AND E1_PORTADO >='"+ MV_PAR06 +"' AND E1_PORTADO <='"+ MV_PAR07 +"' AND E1_VENCREA>='"+ DTOS(MV_PAR08) +"' AND E1_VENCTO<='"+ DTOS(MV_PAR09) +"'"
cQuery := cQuery + " AND E1_BAIXA='        ' AND E1_EMISSAO>='"+ DTOS(MV_PAR10) +"' AND E1_EMISSAO<='"+ DTOS(MV_PAR11) +"' AND SE1.D_E_L_E_T_<>'*' AND E1_TIPO='NF '"

MsAguarde({|| DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PFIN027", .T., .F. )},"Aguarde - NAO DESCONECTE!","Selecionando dados. Isto pode demorar um pouco...")
DBSelectArea("PFIN027")
DBGotop()
COPY TO &_StringArq VIA "DBFCDXADS" // 20121106 
DBCLOSEAREA()   
MsgInfo(_StringArq)
RETURN




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValidPerg ºAutor  ³Marcio Torresson    º Data ³  10/06/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria parametros no SX1 nao existir os parametros.           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValidPerg()
_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
aRegs := {}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Vari veis utilizadas para parametros      ³
//³ mv_par01             cliente de           ³
//³ mv_par02             cliente ate          ³
//³ mv_par03             Prefixos: 1, UNI, PUB³
//³ mv_par04             titulo de            ³
//³ mv_par05             Titulo ate           ³
//³ mv_par06             Banco de             ³
//³ mv_par07             Banco ate            ³
//³ mv_par08             //Vencto de          ³
//³ mv_par09             //Vencto ate         ³
//³ mv_par10             //Emissao de         ³
//³ mv_par11             //Emissao ate        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAdd(aRegs,{cPerg,"01","Cliente de     ","Cliente de     ","Cliente de     ","mv_ch1","C",06,0,2,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","SA1","","","",""})
aAdd(aRegs,{cPerg,"02","Cliente ate    ","Cliente ate    ","Cliente ate    ","mv_ch2","C",06,0,0,"G","","MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","SA1","","","",""})
aAdd(aRegs,{cPerg,"03","Prefixos       ","Prefixos       ","Prefixos       ","mv_ch3","C",20,0,0,"G","","MV_PAR03","","1,UNI,PUB","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"04","Titulo de      ","Titulo de      ","Titulo de      ","mv_ch4","C",09,0,0,"G","","MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Titulo ate     ","Titulo ate     ","Titulo ate     ","mv_ch5","C",09,0,0,"G","","MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"06","Banco de       ","Banco de       ","Banco de       ","mv_ch6","C",03,0,0,"G","","MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","","SA6","","","",""})
aAdd(aRegs,{cPerg,"07","Banco ate      ","Banco ate      ","Banco ate      ","mv_ch7","C",03,0,0,"G","","MV_PAR07","","","","","","","","","","","","","","","","","","","","","","","","","SA6","","","",""})
aAdd(aRegs,{cPerg,"08","Vencimento de  ","Vencimento de  ","Vencimento de  ","mv_ch8","D",08,0,0,"G","","MV_PAR08","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"09","Vencimento ate ","Vencimento ate ","Vencimento ate ","mv_ch9","D",08,0,0,"G","","MV_PAR09","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"10","Emissao de     ","Emissao de     ","Emissao de     ","mv_chA","D",08,0,0,"G","","MV_PAR10","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"11","Emissao ate    ","Emissao ate    ","Emissao ate    ","mv_chB","D",08,0,0,"G","","MV_PAR11","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})

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