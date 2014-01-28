#include "rwmake.ch" 
#include "Fileio.ch"

User Function PiniFRead(cpath)
 
Local cBuffer := ""
Local cFileOpen := cpath //""
Local cTitulo1 := "Selecione o arquivo"
Local cExtens := "Arquivo Txt | *.txt"
//Local cMainpath := "\system\EXPSA1.TXT"
Local cConteudo := ""
 
/*
cGetfile(ca,cb,nc,cd,le,nf)
ca - Expressao de filtro
cb - Titulo da janela
nc - Numero de mascara default 1 para *.EXE
cd - Diretorio inicial se necessario
le - .F. botao salvar - .T. botao abrir
nf - Mascara de bits para escolher a visualizacao do objeto
*/
 
//cFileOpen := cGetFile(cExtens,cTitulo1,,cMainpath,.T.)
 
if File(cFileOpen)
	FT_FUSE(cFileOpen)  //abrir
	FT_FGOTOP() //vai para o topo
	//Procregua(FT_FLASTREC())  //quantos registros para ler
 	While !FT_FEOF()
	 	 //IncProc()
 
		 //Capturar dados
		 cBuffer := FT_FREADLN()  //lendo a linha
		 cConteudo := cConteudo +" "+ cBuffer
 
		 /*cMsg := "Filial: "          +Substr(cBuffer,1,2) + Chr(13)+Chr(10)
		 cMsg += "Codigo: "          +Substr(cBuffer,3,6) + Chr(13)+Chr(10)
		 cMsg += "Loja: "            +Substr(cBuffer,9,2) + Chr(13)+Chr(10)
		 cMsg += "Nome Fantasia: "   +Substr(cBuffer,11,15) + Chr(13)+Chr(10)
		 cMsg += "Valor: "           +Substr(cBuffer,26,14) + Chr(13)+Chr(10)
		 cMsg += "Data: "            +Substr(cBuffer,40,08) + Chr(13)+Chr(10)
 
		 Msginfo(cMsg)*/
 
		 FT_FSKIP()   //proximo registro no arquivo txt
 
	Enddo
 
	FT_FUSE()  //fecha o arquivo txt
Else
	MsgAlert("Arquivo texto: "+cFileOpen+" nao localizado")
endif
 
return alltrim(cConteudo)