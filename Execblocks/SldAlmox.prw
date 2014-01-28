// Desenvolvido por Danilo C S Pala 20070619
User Function SldAlmox(cProduto, cLocal)
SetPrvt("MSALDO")

DbSelectArea("SB1")
DbSetOrder(1)
if DbSeek(xFilial("SB1") + cProduto)
	IF SB1->B1_TIPO =='CD' .OR. SB1->B1_TIPO =='DC'.OR. SB1->B1_TIPO =='LC'.OR. SB1->B1_TIPO =='LI'.OR. SB1->B1_TIPO =='MC'.OR. SB1->B1_TIPO =='ME'.OR. SB1->B1_TIPO =='MP'.OR. SB1->B1_TIPO =='MR'.OR. SB1->B1_TIPO =='PA'.OR. SB1->B1_TIPO =='PI'.OR. SB1->B1_TIPO =='VC'.OR. SB1->B1_TIPO =='VI'
		DbSelectArea("SB2")
		DbSetOrder(1)
		if DbSeek(xFilial("SB2") + cProduto + cLocal)
			MSALDO := SB2->B2_QATU - SB2->B2_RESERVA 
		else  
			MSALDO := 0
		endiF
	ELSE
		MSALDO := 10000
	ENDIF	
else  
	MSALDO := 0
endif


Return(MSALDO)