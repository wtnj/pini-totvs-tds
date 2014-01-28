#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³EPFAT01   ºAutor  ³Thiago Lima Dyonisioº Data ³  11/12/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Este programa é utilizado para geração do arquivo remessa  º±±
±±º          ³ do CNAB do banco SIFRA. Ele verifica o STATUS da NF na     º±±
±±º          ³ tabela SPED050, que poderá ser "transmitida" ou "Cancelada"º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Editora PINI                                               º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
                                                              
User Function EPFAT01(_cNumNf,_cSerieNf)//Recebe o número e a série da NF
                         
SetPrvt("_cStatsNF, _cChaveXml")
   
 	If Select("QRY") > 0
		QRY->(DbCloseArea())  
	EndIf

dbSelectArea("SF2")
dbSetOrder(10)
dbSeek(xFilial()+_cNumNf+_cSerieNf)

_cChaveXml := SF2->F2_CHVNFE

	cQuery := " SELECT DOC_CHV, STATUS AS STSNF, STATUSCANC "
	cQuery += " FROM SPED050 "
	cQuery += " WHERE DOC_CHV = '"+_cChaveXml+"' "

	cQuery := ChangeQuery(cQuery) 
	dbUseArea(.T., "TOPCONN", TCGenQry(, , cQuery), "QRY", .F., .T.) 
	
	dbSelectArea("QRY")                                                                                 
	dbGotop()
	
	if(QRY->STSNF == 6)
		_cStatsNF := '01'
	elseif(QRY->STSNF == 7 .and. QRY->STATUSCANC == 2)
		_cStatsNF := '02'
	else
   		_cStatsNF := '  '
   	endif	
   
    dbCloseArea("QRY")
      
Return(_cStatsNF)
	