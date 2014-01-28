#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function Lj10d2()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CTABD2,_NSUPORTE,_NPERRET,_CESTADO,_TNORTE,_CALIAS")
SetPrvt("_ARETORNO,_CPRODUTO,_CDESCPRO,_CTES,_CUM,_CCF")
SetPrvt("_CDOC,_CSERIE,_CLOCAL,_CITEM,_NVALDESC,_NQUANT")
SetPrvt("_NVRUNIT,_NVALICM,_NDESC,_NBASEICM,_NVALIPI,_NVALISS")
SetPrvt("_NVLRITEM,_DEMISSAO,_NDESCPRO,_NPRCTAB,_NI,_NCM1")
SetPrvt("_NCM2,_NCM3,_NCM4,_NCM5,_CSEQ,_ASTRU")
SetPrvt("_NTOTAL,_NSOBRA,_NJ,AVENDAS,")

cTabD2    :=""
_nSuporte :=0
_nPerRet  :=0
_cEstado	 := GetMV("mv_estado")
_tNorte	 := GetMV("mv_norte")
_cAlias   := Alias()
_aRetorno := {}
_cProduto:=""
_cDescPro:=""
_cTes    :=""
_cUm     :=""
_cCf     :=""
_cDoc    :=""
_cSerie  :=""
_cLocal  :=""
_cItem   :=""
_nValDesc:=0
_nQuant  :=0
_nVrUnit :=0
_nValIcm :=0
_nDesc   :=0
_nBaseIcm:=0
_nValIpi :=0
_nValIss :=0
_nVlrItem:=0
_dEmissao:=dDatabase
_nDescPro:=0
_nPrcTab :=0


// Descricao dos Itens do Array
//01 - Produto
//02 - Descricao
//03 - Valor desconto
//04 - Tes
//05 - Unidade de Medida
//06 - Quantidade
//07 - Valor Unitario
//08 - Valor do Icm
//09 - Cf
//10 - Desconto em %
//11 - Numero da NF
//12 - Data de Emissao
//13 - Serie da nota
//14 - Base de Icm
//15 - Local
//16 - Item
//17 - Valor do Ipi
//18 - Valor do Iss
//19 - Valor total do item
//20 - recno do sl2
//21 - Zero
//22 - Desconto Proporcional
//23 - Preco Venda
//24 - Tabela de preco utilizada

For _ni:= 1 to Len(aVendas)
	_cProduto:=""
	_cDescPro:=""
	_cTes    :=""
	_cUm     :=""
	_cCf     :=""
	_cDoc    :=""
	_cSerie  :=""
	_cLocal  :=""
	_cItem   :=""
	_nValDesc:=0
	_nQuant  :=0
	_nVrUnit :=0
	_nValIcm :=0
	_nDesc   :=0
	_nBaseIcm:=0
	_nValIpi :=0
	_nValIss :=0
	_nVlrItem:=0
	_dEmissao:=dDatabase
	_nDescPro:=0
	_nPrcTab :=0
	_nCm1    :=0
	_nCm2    :=0
	_nCm3    :=0
	_nCm4    :=0
	_nCm5    :=0				
	
	cTabD2   :=""
	dbSelectArea("SG1")
	dbSetOrder(1)
	dbSeek(xFilial()+aVendas[_ni,1])
	IF !Eof()
		dbSelectArea("SB1")
		dbSeek(xFilial()+aVendas[_ni,1])
		_cSeq := ProxNum()
    	dbSelectArea("SB2")
	   dbSetOrder(1)
	   If dbSeek(xFilial()+aVendas[_ni,1])
		   _nCm1:=B2_Cm1
		   _nCm2:=B2_Cm2
		   _nCm3:=B2_Cm3
		   _nCm4:=B2_Cm4
		   _nCm5:=B2_Cm5
		Endif													
		// Gerar RE7 do computador
		dbSelectArea("SD3")
		RecLock("SD3",.t.)
		SD3->D3_FILIAL  := xFilial("SD3")
		SD3->D3_COD     := aVendas[_ni,1]
		SD3->D3_QUANT   := aVendas[_ni,6]
		SD3->D3_CF      := "RE7"
		SD3->D3_CHAVE   := "E0"
		SD3->D3_LOCAL   := aVendas[_ni,15]
		SD3->D3_DOC     := aVendas[_ni,11]
		SD3->D3_EMISSAO := dDatabase
		SD3->D3_UM      := aVendas[_ni,5]
		SD3->D3_GRUPO   := SB1->B1_GRUPO
		SD3->D3_NUMSEQ  := _cSeq
		SD3->D3_TM      := "999"
		SD3->D3_TIPO    := SB1->B1_TIPO
		SD3->D3_CONTA   := SB1->B1_CONTA
		SD3->D3_USUARIO := SubStr(cUsuario,7,15)
		SD3->D3_RATEIO  := 100
		SD3->D3_CUSTO1  := _nCm1
		SD3->D3_CUSTO2  := _nCm2
		SD3->D3_CUSTO3  := _nCm3
		SD3->D3_CUSTO4  := _nCm4
		SD3->D3_CUSTO5  := _nCm5								
		B2AtuComD3({_nCm1,_nCm2,_nCm3,_nCm4,_nCm5})	
      // Acerta Quantidade de Pedido de Vendas	
    	dbSelectArea("SB2")
	   dbSetOrder(1)
	   If dbSeek(xFilial()+aVendas[_ni,1])
    	   Reclock( "SB2")	   
		   Replace B2_QPedVen with (B2_QPedVen) - (aVendas[_ni,6])
   	   MsUnlock( )
   	Endif	
		dbSelectArea("SG1")
		_aStru := {}
		_nTotal := 0
		While !Eof() .and. SG1->G1_COD == aVendas[_ni,1]
			dbSelectArea("SB1")
			dbSeek(xFilial()+SG1->G1_COMP)
			AADD(_aStru,{SG1->G1_COMP,SG1->G1_QUANT,SB1->B1_UPRC})
			_nTotal := _nTotal + ( SB1->B1_UPRC * SG1->G1_QUANT )
			dbSelectArea("SG1")
			dbSkip()
		End
		
		_nSobra := 100		
		For _nJ := 1 to Len(_aStru)
			// Definicoes que nao precisam de Arquivo
			_cDoc    :=aVendas[_ni,11]
			_dEmissao:=aVendas[_ni,12]
			_cSerie  :=aVendas[_ni,13]
			_cItem   :=StrZero(Len(_aRetorno)+1,2)
			_nDesc   :=aVendas[_ni,10]
			_nValIcm :=0
			
			_cProduto:=_aStru[_nj,1]
			
			// Posicionando SB1
			dbSelectArea("SB1")
			dbSeek(xFilial()+_aStru[_nj,1])

			// Posicionando SB0
			dbSelectArea("SB0")
			dbSetOrder(1)
			dbSeek(xFilial()+_cProduto)			
									

			_cDescPro:=0
			_nQuant  :=aVendas[_ni,6]*_aStru[_nj,2]
			_cTes    :=SB1->B1_Ts
			_cUm     :=SB1->B1_Um
			_cLocal  :=SB1->B1_LocPad
			cTabD2   :=aVendas[_ni,24]
			If cTabd2 == "1"
			   _nPrcTab :=SB0->B0_Prv1
			ElseIf cTabD2 == "2"	
			   _nPrcTab :=SB0->B0_Prv2
			ElseIf cTabD2 == "3"	
			   _nPrcTab :=SB0->B0_Prv3
			ElseIf cTabD2 == "4"	
			   _nPrcTab :=SB0->B0_Prv4
			ElseIf cTabD2 == "5"	
			   _nPrcTab :=SB0->B0_Prv5
			ElseIf cTabD2 == "6"	
			   _nPrcTab :=SB0->B0_Prv6
			ElseIf cTabD2 == "7"																
			   _nPrcTab :=SB0->B0_Prv7
			ElseIf cTabD2 == "8"	
			   _nPrcTab :=SB0->B0_Prv8
			ElseIf cTabD2 == "9"	
			   _nPrcTab :=SB0->B0_Prv9				
			Endif			
			_nVrUnit :=_nPrcTab
		   _nVlrItem:=_nVrUnit*_nQuant
			_nValDesc:=_nVlrItem*(_nDesc/100)
			_nDescPro:=aVendas[_ni,22]

									
   
			//Posicionando SF4
			dbSelectArea("SF4")
			dbSetOrder(1)
			dbSeek(xFilial()+_cTes)
            _cCf:= ALLTRIM(SF4->F4_CF)

			If SF4->F4_IPI == "S"
			   _nValIpi :=_nVlrItem * (SB1->B1_IPI /100)
		   Else
			  _nValIpi  :=0		
			Endif
			
			IF SF4->F4_ISS == "S"
				_nValIss :=_nVlrItem * (SB1->B1_ALIQISS / 100)			
			Else 
			   _nValIss :=0
			Endif	

         If SF4->F4_BASEICM > 0
            _nBaseIcm:= _nVlrItem * (SF4->F4_BaseICM/100)
			Else
			   _nBaseIcm:=_nVlrItem	
		   Endif
					
			IF SF4->F4_ICM == "S"
				IF Empty(SA1->A1_INSCR)
					_nPerRet := iif(SB1->B1_PICM>0,SB1->B1_PICM,GetMV("mv_icmpad"))
				Elseif SB1->B1_PICM > 0 .And. SA1->A1_EST == _cEstado
					_nPerRet := SB1->B1_PICM
				Elseif SA1->A1_EST == _cEstado
					_nPerRet := GetMV("mv_icmpad")
				Elseif SA1->A1_EST $ _tNorte .And. At(_cEstado,_tNorte) == 0
					_nPerRet := 7
				Else
					_nPerRet := 12
				Endif
			Endif

         If _nPerRet > 0
	         _nValIcm  := NoRound(_nBaseIcm * _nPerRet / 100 , 2)
		   Else
				_nValIcm :=0
		   Endif
										
			AADD(_aRetorno,{_cProduto,0,_nValDesc,_cTes,_cUm,_nQuant,_nVrUnit,_nValIcm,;
			_cCf,_nDesc,_cDoc,_dEmissao,_cSerie,_nBaseicm,_cLocal,_cItem,_nValIpi,_nValIss,_nVlrItem,aVendas[_ni,20],0,_nDescPro,_nPrcTab})		
		
    	  dbSelectArea("SB2")
	     dbSetOrder(1)
	     If dbSeek(xFilial()+_aStru[_nj,1])
		     _nCm1:=B2_Cm1
		     _nCm2:=B2_Cm2
		     _nCm3:=B2_Cm3
		     _nCm4:=B2_Cm4
		     _nCm5:=B2_Cm5
		  Else
		     _nCm1    :=0
	        _nCm2    :=0
	        _nCm3    :=0
	        _nCm4    :=0
	        _nCm5    :=0						  
		  Endif													

			// Gerar DE7 das pecas
			RecLock("SD3",.t.)
			SD3->D3_FILIAL := xFilial("SD3")
			SD3->D3_COD     := _aStru[_nj,1]
			SD3->D3_QUANT   := _aStru[_nj,2] * aVendas[_ni,6]
			SD3->D3_CF      := "DE7"
			SD3->D3_CHAVE   := "E9"
			SD3->D3_LOCAL   := aVendas[_ni,15]
			SD3->D3_DOC     := aVendas[_ni,11]
			SD3->D3_EMISSAO := dDatabase
			SD3->D3_UM      := SB1->B1_UM
			SD3->D3_GRUPO   := SB1->B1_GRUPO
			SD3->D3_NUMSEQ  := _cSeq
			SD3->D3_TM      := "499"
			SD3->D3_TIPO    := SB1->B1_TIPO
			SD3->D3_CONTA   := SB1->B1_CONTA
			SD3->D3_USUARIO := SubStr(cUsuario,7,15)
		   SD3->D3_CUSTO1  := _nCm1
		   SD3->D3_CUSTO2  := _nCm2
		   SD3->D3_CUSTO3  := _nCm3
		   SD3->D3_CUSTO4  := _nCm4
		   SD3->D3_CUSTO5  := _nCm5								
			IF _nj == Len(_aStru)
					SD3->D3_RATEIO  := _nSobra
			Else
					IF _nSobra > 0
						SD3->D3_RATEIO  := Round( ( ( _aStru[_nj,2]*_aStru[_nj,3] ) / _nTotal ) * 100 , 2 ) 
						_nSobra := Round(_nSobra - SD3->D3_RATEIO,2)
						IF _nSobra < 0
							SD3->D3_RATEIO := SD3->D3_RATEIO - _nSobra
							_nSobra := 0
						Endif
					Endif
			Endif

    	   dbSelectArea("SB2")
	      dbSetOrder(1)
	      If dbSeek(xFilial()+_aStru[_nj,1])			
    	      Reclock( "SB2")	   
		      Replace B2_QATU   with B2_QATU+SD3->D3_QUANT
				Replace B2_vAtu1  with B2_vAtu1+B2_Cm1
				Replace B2_vAtu2  with B2_vAtu2+B2_Cm2
				Replace B2_vAtu3  with B2_vAtu3+B2_Cm3
				Replace B2_vAtu4  with B2_vAtu4+B2_Cm4
				Replace B2_vAtu5  with B2_vAtu5+B2_Cm5																
			Endif				
			
						
			//Atualizar Quantidade de Pedido de Venda das pecas
       	dbSelectArea("SB2")
	      dbSetOrder(1)
	      If dbSeek(xFilial()+SG1->G1_Comp)
    	      Reclock( "SB2")	   
		      Replace B2_QPedVen with (B2_QPedVen) + (_aRetorno[_ni,6])
   	      MsUnlock( )
   	   Endif	
		Next
	Else
		AADD(_aRetorno,aClone(aVendas[_ni]))
		_aRetorno[Len(_aRetorno),16] := StrZero(Len(_aRetorno),2,0)
		dbSelectArea("SB1")
		dbSeek(xFilial()+aVendas[_ni,1])		
		If B1_Suporte > 0 
          // Desconto para o Software no Valor do Item
		   _nSuporte:= B1_Suporte
			_aRetorno[Len(_aRetorno),3] :=_nSuporte
			_aRetorno[Len(_aRetorno),10]:=(_nSuporte/_aRetorno[Len(_aRetorno),19])*100
			dbSeek(xFilial()+"SUPORTE")
			// Posicionando SB0
			dbSelectArea("SB0")
			dbSetOrder(1)
			dbSeek(xFilial()+"SUPORTE")			
					
			_cDescPro:=0
			_nQuant  :=1
			_cTes    :=SB1->B1_Ts
			_cUm     :=SB1->B1_Um
			_cLocal  :=SB1->B1_LocPad
			_nVrUnit :=_nSuporte
		   _nVlrItem:=_nSuporte*_nQuant
			_nValDesc:=0
		   _nDescPro:=aVendas[_ni,22]
			cTabD2   :=aVendas[_ni,24]
			If cTabd2 == "1"
			   _nPrcTab :=SB0->B0_Prv1
			ElseIf cTabD2 == "2"	
			   _nPrcTab :=SB0->B0_Prv2
			ElseIf cTabD2 == "3"	
			   _nPrcTab :=SB0->B0_Prv3
			ElseIf cTabD2 == "4"	
			   _nPrcTab :=SB0->B0_Prv4
			ElseIf cTabD2 == "5"	
			   _nPrcTab :=SB0->B0_Prv5
			ElseIf cTabD2 == "6"	
			   _nPrcTab :=SB0->B0_Prv6
			ElseIf cTabD2 == "7"																
			   _nPrcTab :=SB0->B0_Prv7
			ElseIf cTabD2 == "8"	
			   _nPrcTab :=SB0->B0_Prv8
			ElseIf cTabD2 == "9"	
			   _nPrcTab :=SB0->B0_Prv9				
			Endif

			//Posicionando SF4
			dbSelectArea("SF4")
			dbSetOrder(1)
			dbSeek(xFilial()+_cTes)
            _cCf:=ALLTRIM(SF4->F4_CF)

			If SF4->F4_IPI == "S"
			   _nValIpi :=_nVlrItem * (SB1->B1_IPI /100)
		   Else
			  _nValIpi  :=0		
			Endif
			
			IF SF4->F4_ISS == "S"
				_nValIss :=_nVlrItem * (SB1->B1_ALIQISS / 100)			
			Else 
			   _nValIss :=0
			Endif	

         If SF4->F4_BASEICM > 0
            _nBaseIcm:= _nVlrItem * (SF4->F4_BaseICM/100)
			Else
			   _nBaseIcm:=_nVlrItem	
		   Endif
					
			IF SF4->F4_ICM == "S"
				IF Empty(SA1->A1_INSCR)
					_nPerRet := iif(SB1->B1_PICM>0,SB1->B1_PICM,GetMV("mv_icmpad"))
				Elseif SB1->B1_PICM > 0 .And. SA1->A1_EST == _cEstado
					_nPerRet := SB1->B1_PICM
				Elseif SA1->A1_EST == _cEstado
					_nPerRet := GetMV("mv_icmpad")
				Elseif SA1->A1_EST $ _tNorte .And. At(_cEstado,_tNorte) == 0
					_nPerRet := 7
				Else
					_nPerRet := 12
				Endif
			Endif

         If _nPerRet > 0
	         _nValIcm  := NoRound(_nBaseIcm * _nPerRet / 100 , 2)
		   Else
				_nValIcm :=0
		   Endif
										
			_cDoc    :=aVendas[_ni,11]
			_cSerie  :=aVendas[_ni,13]
			_cItem   :=StrZero(Len(_aRetorno)+1,2)
			AADD(_aRetorno,{"SUPORTE",0,_nValDesc,_cTes,_cUm,1,_nVrUnit,_nValIcm,;
			_cCf,_nDesc,_cDoc,_dEmissao,_cSerie,_nBaseicm,_cLocal,_cItem,_nValIpi,_nValIss,_nVlrItem,1,0,_nDescPro,_nPrcTab})		
		Endif
	Endif	
Next
aVendas := aClone(_aRetorno)
dbSelectArea(_cAlias)
// Substituido pelo assistente de conversao do AP5 IDE em 13/03/02 ==> __Return(.t.)
Return(.t.)        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02


