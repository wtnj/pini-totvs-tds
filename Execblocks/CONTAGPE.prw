#INCLUDE "RWMAKE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CONTAGPE  ºAutor  ³Danilo Pala         º Data ³  20110711   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Pini                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CONTAGPE(cTipo) //C=Conta, H=Historico
Local mcta  := space(20)
Local mHist := ""
Local mResposta := ""
Local aArea := GetArea()
If SE2->E2_PREFIXO =="GPE"
	IF ALLTRIM(SE2->E2_NATUREZ) == "25" .AND. ALLTRIM(SE2->E2_FORNECE)="UNIAO" .AND.  ALLTRIM(SE2->E2_TIPO)="FOL" //FGTS
   		MCTA:='21040204001'
   		mHist := 'RECOLH FGTS FOLHA'
	ELSEIF ALLTRIM(SE2->E2_NATUREZ) == "25" .AND. ALLTRIM(SE2->E2_FORNECE)="INSS" .AND.  ALLTRIM(SE2->E2_TIPO)="INS" //INSS
		MCTA:= '21040204004'
		mHist := 'RECOLH INSS FOLHA'
	ELSEIF ALLTRIM(SE2->E2_NATUREZ) == "IRF"
		MCTA:= '21050101006'
		mHist := 'APURACAO IRRF FOLHA'+ SE2->E2_CODRET
	ELSEIF ALLTRIM(SE2->E2_NATUREZ) == "ISSFOLHA"
		MCTA:= '21050101009'
		mHist := 'RECOLH ISS FOLHA'
	ELSEIF ALLTRIM(SE2->E2_TIPO) == "FOL" .AND. SE2->E2_FORNECE="001035" //ODONTOLOGICO
		MCTA:= '21040201005'
		mHist := 'PGTO ASS ODONTOLOGICA'
	ELSEIF ALLTRIM(SE2->E2_TIPO) == "FOL" .AND. SE2->E2_FORNECE="003721" //SEGURO DE VIDA
		MCTA:= '21040201006'
		mHist := 'PGTO SEGURO DE VIDA'
	ELSEIF ALLTRIM(SE2->E2_TIPO) == "FOL" .AND. SE2->E2_FORNECE=="003544" //EMPRESTIMO CONSIGNADO BV
		MCTA:= '21040203005'
		mHist := 'PGTO EMPR CONSIGNADO BV'
	ELSEIF ALLTRIM(SE2->E2_TIPO) == "FOL" .AND. SE2->E2_FORNECE=="004387" //EMPRESTIMO CONSIGNADO SANTANDER
		MCTA:= '21040203003'
		mHist := 'PGTO EMPR CONSIGNADO SANTANDER'
	ELSEIF ALLTRIM(SE2->E2_TIPO) == "FOL" .AND. SE2->E2_FORNECE=="004440" //PENSAO ALIMENTICIA
		MCTA:= '21040203001'
		mHist := 'PGTO PENSAO ALIMENTICIA'
	ELSEIF ALLTRIM(SE2->E2_TIPO) == "FOL" .AND. SE2->E2_FORNECE=="003610" //CONTRIB ASSIST JORNALISTA
		MCTA:= '21040203004'
		mHist := 'PGTO CONTRIB SIND/ASS JORNALISTA'
	ELSEIF ALLTRIM(SE2->E2_TIPO) == "FOL" .AND. SE2->E2_FORNECE=="003631" //CONTRIB SINDICAL
		MCTA:= '21040203002'
		mHist := 'PGTO CONTRIB SINDICAL'
	ELSEIF ALLTRIM(SE2->E2_TIPO) == "FOL" .AND. SE2->E2_FORNECE=="001514" //CONTRIB SINDICAL BP
		MCTA:= '21040203004'
		mHist := 'PGTO CONTRIB ASSIST'
	ELSEIF ALLTRIM(SE2->E2_TIPO) == "FOL" .AND. SE2->E2_FORNECE=="003683" //SIND EMPREG VIAJANTE
		MCTA:= '21040203004'
		mHist := 'PGTO SIND EMPREG VIAJANTE'
    END IF
Else   
	MCTA := ""
	mHist := ""
Endif
RestArea(aArea)
               
IF cTipo =="C"
	mResposta := mCta
Else
	mResposta := mHist
Endif           

RETURN(mResposta)