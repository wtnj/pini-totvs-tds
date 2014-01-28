#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 22/03/02
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EXEC6005  ºAutor  ³Danilo C S Pala     º Data ³  26/06/2003 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gatilho para bloquear edicoes retroativas                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP5                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Exec6005()        
Local aArea := GetArea()
SetPrvt("_dData, _cRetorno, _cCodRevista, _cEdicao")
SetPrvt("_nPosProduto, _cLote, _nDiferenca, _cPRODUTO") 



dbSelectArea("SC6")

_nPosProduto := Ascan(aHeader,{ |x| Alltrim(x[2])=="C6_PRODUTO"}) // ARRAY Q ARMAZENA DADOS DA TABELA PROCESSADA
_cPRODUTO   := Acols[n][_nPosProduto] // ARRAY Q ARMAZENA VALORES DA TABELA PROCESSADA 

_nPosProduto := Ascan(aHeader,{ |x| Alltrim(x[2])=="C6_LOTEFAT"}) 
_cLote   := Acols[n][_nPosProduto] 

_cCodRevista := SUBSTR(_cPRODUTO,1,4)
_cEdicao     := M->C6_EDINIC
_dData       := date()
_cRetorno := _cEdicao

IF Substr(_cproduto,5,3) <> "001"
dbSelectArea("SZJ")
dbSetOrder(1)
If dbSeek(xFilial("SZJ")+_cCodRevista+Str(_cEdicao,4,0))
	_nDiferenca := 	SZJ->ZJ_DTCIRC - _dData
	// cidinha publicidade     permitir ate 60 dias depois
//	IF Alltrim(_cLote) <> "500"  01/07/2003
		if _nDiferenca < -60 //0
			_cRetorno := 0
			_nPosProduto := Ascan(aHeader,{ |x| Alltrim(x[2])=="C6_EDFIN"})  
			Acols[n][_nPosProduto] := 0
	
			_nPosProduto := Ascan(aHeader,{ |x| Alltrim(x[2])=="C6_EDSUSP"})
			Acols[n][_nPosProduto] := 0
    
	   		_nPosProduto := Ascan(aHeader,{ |x| Alltrim(x[2])=="C6_EDVENC"})
			Acols[n][_nPosProduto] := 0
		
   			Alert("EDICAO RETROATIVA, BLOQUEADO!!!!")  
  		elseif (_nDiferenca >= 180)
  			Alert("Edicao: "+Alltrim(Str(_cEdicao))+", data de circulacao: "+ DTOC(SZJ->ZJ_DTCIRC))  			
	  	endif
endif
ENDIF

RestArea(aArea)

Return(_cRetorno)