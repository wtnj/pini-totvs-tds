/*
//Alterado por Danilo C S Pala em 20070315: CFE
//Alterado por Danilo C S Pala em 20070328: NFS
//Alterado por Danilo C S Pala em 20080220: SEM 
//Alterado por Danilo C S Pala em 20081031: STD
//Alterado por Danilo C S Pala em 20100507: ECF
//Alterado por Danilo C S Pala em 201000803: 1
//Alterado por Danilo C S Pala em 20110719: centralizar as series da contabilizacao para despesa de remessa do SF2 e da valor do SD2
//Alterado por Danilo C S Pala em 20110722: Pis e cofins apuracao
//Alterado por Danilo C S Pala em 20110816: tipo de operacao com 2 contas e naturezas: valor parcelas
//Alterado por Danilo C S Pala em 20110829: Considerar se1 deletado para estorno -Jose Martins
//Alterado por Danilo C S Pala em 20130325: Sigaloja Feicon 
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SERIE_SI5 �Autor  �DANILO C S PALA     � Data �  20050131   ���
�������������������������������������������������������������������������͹��
���Desc.     � RETORNA O VALOR DO ITEM DA NOTA FISCAL A SER CONTABILIZADO ���
���          � CONFORME A SERIE CORRETA									  ���
�������������������������������������������������������������������������͹��
���Uso       � AP5                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function SERIE_SI5(cTipo) //D=despesa de remessa. '' ou V = valor do item da nota ou P=PIS apuracao ou C=COFINS apuracao
Local n_serie  := 0
Local aArea := GetArea()    

if (SF2->F2_SERIE=='UNI' .OR. TRIM(SF2->F2_SERIE)=='D1' .OR. SF2->F2_SERIE=='CUP' .OR. SF2->F2_SERIE=='CFS' .OR.SF2->F2_SERIE=='CFA' .OR. SF2->F2_SERIE=='PUB' .OR. SF2->F2_SERIE=='CFB' .OR. SF2->F2_SERIE=='CFC' .OR. SF2->F2_SERIE=='CFD' .OR. SF2->F2_SERIE=='ANG' .OR. SF2->F2_SERIE=='CFE' .OR. SF2->F2_SERIE=='NFS' .OR. SF2->F2_SERIE=='SEN' .OR. SF2->F2_SERIE=='STD' .OR. SF2->F2_SERIE=='ECF' .OR. SF2->F2_SERIE=='1  ' .OR. SF2->F2_SERIE=='8  ' .OR. SF2->F2_SERIE=='EC1' .OR. SF2->F2_SERIE=='4  '.OR. SF2->F2_SERIE=='5  ') //Alterado 16062014 Douglas Silva.OR. SF2->F2_SERIE=='21 ')
	if alltrim(upper(cTipo)) == "1" .or. alltrim(upper(cTipo)) == "2"
		IF ALLTRIM(SF2->F2_ESPECIE)=="CF" .AND. !EMPTY(SF2->F2_PDV) .AND. !EMPTY(SF2->F2_ECF) //20130325
			n_serie := ValorLoja(SF2->F2_SERIE, SF2->F2_DOC, DTOS(SF2->F2_EMISSAO), SF2->F2_CLIENTE, SF2->F2_LOJA, cTipo, "S") //20130325
		ELSE	
		  If EMPTY(SF2->F2_DTLANC) //verificar se ja foi contabilizado, entao sera estorno
				n_serie := ValorConta(SF2->F2_SERIE, SF2->F2_DOC, DTOS(SF2->F2_EMISSAO), SF2->F2_CLIENTE, SF2->F2_LOJA, cTipo, "S")
			Else
				n_serie := ValorConta(SF2->F2_SERIE, SF2->F2_DOC, DTOS(SF2->F2_EMISSAO), SF2->F2_CLIENTE, SF2->F2_LOJA, cTipo, "N")
			EndIf
		ENDIF
	elseif alltrim(upper(cTipo)) == "D" //despesa de remessa
		n_serie := SF2->F2_DESPREM
	else
		//VERIFICAR O TES
		DbSelectArea("SF4")
		DbSetOrder(1)
		DbSeek(xFilial("SF4")+SD2->D2_TES)
		IF SF4->F4_DUPLIC=='S'
			if alltrim(upper(cTipo)) == "P"//Pis apuracao 20110722
				n_serie := SD2->D2_VALIMP6
			elseif alltrim(upper(cTipo)) == "C" //COFINS apuracao 20110722
				n_serie := SD2->D2_VALIMP5
			elseif alltrim(upper(cTipo)) == "V"
				n_serie := SD2->D2_TOTAL
		    endif
		ELSE
			n_serie := 0
		ENDIF //TES
	Endif
Else 
	n_serie := 0
EndIf

RestArea(aArea)
RETURN(n_serie)


Static Function ValorConta(cPrefixo, cNumero, dEmissao, cCliente, cLoja, cTipo, cDel)
Local cQuery := ""
Local nValor := 0

cQuery := "select sum(e1_valor) as valor from " + RetSqlName("SE1") + " where e1_filial='" + xFilial("SE1") + "' and e1_prefixo='"+ cPrefixo +"' and e1_num='"+ cNumero +"' and e1_cliente='"+ cCliente +"' and e1_loja='"+ cLoja +"' and e1_emissao='"+ dEmissao +"' and e1_tipo='NF'"
if cTipo =="1"
	cQuery := cQuery + " and (e1_parcela=' ' or e1_parcela='A')"
else
	cQuery := cQuery + " and (e1_parcela<>' ' and e1_parcela<>'A')"
endif
if cDel =='S'
	cQuery := cQuery + " and d_e_l_e_t_<>'*'"
endif
	
DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PINICR", .T., .F. )
DbSelectArea("PINICR")
dbGotop()
If !EOF()
	nValor :=	PINICR->VALOR
Else
	nValor :=	0
EndIf   
DBCloseArea()

Return nValor


Static Function ValorLoja(cPrefixo, cNumero, dEmissao, cCliente, cLoja, cTipo, cDel)
Local cQuery := ""
Local nValor := 0

cQuery := "select sum(e1_valor) as valor from " + RetSqlName("SE1") + " where e1_filial='" + xFilial("SE1") + "' and e1_prefixo='"+ cPrefixo +"' and e1_num='"+ cNumero +"' and e1_emissao='"+ dEmissao +"'"
if cTipo =="1"
	cQuery := cQuery + " and (e1_parcela=' ' or e1_parcela='A')"
else
	cQuery := cQuery + " and (e1_parcela<>' ' and e1_parcela<>'A')"
endif
if cDel =='S'
	cQuery := cQuery + " and d_e_l_e_t_<>'*'"
endif
	
DbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), "PINICR", .T., .F. )
DbSelectArea("PINICR")
dbGotop()
If !EOF()
	nValor :=	PINICR->VALOR
Else
	nValor :=	0
EndIf   
DBCloseArea()

Return nValor