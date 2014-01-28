#include "rwmake.ch"      

// Desenvolvido por Danilo C S Pala 20070629
//Alterado por Danilo C S Pala em 20090303: nao deixar utilizar TES que nao movimenta estoque, algumas exececoes
//Alterado por Danilo C S Pala em 20090310: liberar Priscial 509 e 510  
//Alterado por Danilo C S Pala em 20100831: Liberar Eliane e Nicola
//Alterado por Danilo C S Pala em 20130520: Liberar GUILHERME SANTOS
User Function ValidaTES()
SetPrvt("MRET, ACOLS, loginUsuario")
                                        
//cTES := aCols[n,aScan(aHeader ,{|x| Upper(AllTrim(x[2]))=="C6_TES" })]  //20070703 POSICIONA O SF4 E DEPOIS ATUALIZA O SC6, POR ISSO NAO PRECISA SELECIONA-LO
cTES := SF4->F4_CODIGO

/*DbSelectArea("SF4")
DbSetOrder(1)
if DbSeek(xFilial("F4") + cTES)*/
	IF SF4->F4_TPMOV=='0' //INATIVO = ZERO
		MsgAlert("TES "+ cTES + " obsoleto! Favor utilizar outro!")
	   	MRET:=.F.
	ELSE
	   	MRET:=.T.
	ENDIF
//endif               

IF SUBSTR(SB1->B1_COD,1,2) == "02" .OR. SUBSTR(SB1->B1_COD,1,2) == "07"  //LIVROS E CDS
	loginUsuario := alltrim(substr(cusuario,7,15))
	IF MRET == .T. .AND. SF4->F4_ESTOQUE=='N' //20090303
		//IF 	(loginUsuario=="JOSE CICERO DE" .or. loginUsuario=="JOSE MARTINS" .or. loginUsuario=="JOSE RICARDO" .or. loginUsuario=="CIDINHA" .or. loginUsuario=="Administrador" .or. loginUsuario=="ELIANA SANTANA" .or. loginUsuario=="NICOLA" .or. loginUsuario=="GUILHERME SANTO") .or. ((cTES=="509" .or. cTES=="510") .and. loginUsuario=="PRISCILA RODRIG")
		IF 	(loginUsuario=="JOSE CICERO DE" .or. loginUsuario=="JOSE MARTINS" .or. loginUsuario=="JOSE RICARDO" .or. loginUsuario=="CIDINHA" .or. loginUsuario=="Administrador" .or. loginUsuario=="ELIANA SANTANA" .or. loginUsuario=="GUILHERME SANTO" .or. loginUsuario=="PRISCILA RODRIG")
			MRET:=.T.
		ELSE
			MsgAlert("TES "+ cTES + " nao atualiza estoque! Favor utilizar outro!")     
			MRET:=.F.
		ENDIF
	ENDIF
ELSE
	MRET := .T. //OUTROS PRODUTOS
ENDIF
	

Return(MRET)