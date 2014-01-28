#include "rwmake.ch"

// Desenvolvido por Danilo C S Pala 20070618
//Alterado por Danilo C S Pala em 20080415: nao consultar o saldo do TES 509 e 510
//Alterado por Danilo C S Pala em 20080911: almox LS somente Priscila, Sandra e Admin
//Alterado por Danilo C S Pala em 20091016: nao deixar item maior do que 15: solicitado por Luciano
User Function ValSldAlmox()
SetPrvt("MRET, MSALDO, ACOLS, CESTOQUE, CVALIDA, CITEM")

cProduto := aCols[n,aScan(aHeader ,{|x| Upper(AllTrim(x[2]))=="C6_PRODUTO" })]
cLocal := aCols[n,aScan(aHeader ,{|x| Upper(AllTrim(x[2]))=="C6_LOCAL" })]
nQtd := aCols[n,aScan(aHeader ,{|x| Upper(AllTrim(x[2]))=="C6_QTDVEN" })]
cTES := aCols[n,aScan(aHeader ,{|x| Upper(AllTrim(x[2]))=="C6_TES" })] //20080415
cItem := aCols[n,aScan(aHeader ,{|x| Upper(AllTrim(x[2]))=="C6_ITEM" })] //20091016

if cLocal=="LS"
	if (alltrim(substr(cusuario,7,15)) =="PRISCILA RODRIG" .or. alltrim(substr(cusuario,7,15))=="SANDRA" .or. alltrim(substr(cusuario,7,15))=="Administrador")
		CVALIDA := 'S'
	else
		CVALIDA := 'N'
		MsgInfo("O almoxarifado LS pode ser movimentado apenas pela Priscila e Sandra!")
		MRET := .F.
	endif
else
	CVALIDA := 'S'
endif

if CVALIDA == 'S'
	DbSelectArea("SF4")
	DbSetOrder(1)
	DbGoTop()
	DbSeek(xFilial("SF4")+cTES)
	If SF4->F4_ESTOQUE=='S'
		CESTOQUE := 'S'
	ELSE
		CESTOQUE := 'N'
	EndIf
	
	IF CESTOQUE='N' //.OR. cTES =="509" .OR. cTES=="510" .OR. cTES=="516"
		MRET := .T.
	ELSE
		MSALDO := U_SldAlmox(cProduto, cLocal)
		
		IF ((MSALDO - nQtd) <0)
			MsgInfo("Saldo insuficiente em estoque!"+CHR(10)+CHR(13)+"Saldo atual("+ cLocal +"): "+STR(MSALDO,6,0))
			MRET := .F.
		ELSE
			MRET := .T.
		ENDIF
	ENDIF
endif

//20091016 validaitem
if Val(cItem)>99 
	MsgInfo("São válidos apenas 99 itens por pedido!")
	MRET := .F.
endif

Return(MRET)