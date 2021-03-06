#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function MTA410E()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("_CALIAS,_NINDEX,_NREG,")

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇙o    쿘TA410E   � Autor � Fabio William         � Data � 16.12.99 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇙o 쿐xclui as Av. Programadas. dos arquivos SZV e SZS           낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      쿑aturamento Publicidade  - Acionado antes da exclusao da AV 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿝elease   쿝oger Cangianeli - padronizacao e otimizacao em 02/02/00.   낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/

_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()

If SM0->M0_CODIGO == "01" .and. SC5->C5_DIVVEN == "PUBL"
	
	// 旼컴컴컴컴컴컴컴컴컴컴컴컴컴�
	// � Exclui as Avs Normais     �
	// 읕컴컴컴컴컴컴컴컴컴컴컴컴컴�
	If SC5->C5_AVESP == "N" // Somente AV Com pagamento normal
		
		dbSelectArea("SZS")
		dbSetOrder(1)
		dbSeek(xFilial("SZS")+SC5->C5_NUM)
		While !eof()  .and. SZS->ZS_NUMAV == SC5->C5_NUM
			RecLock("SZS",.F.)
			dbDelete()
			MsUnlock()
			dbSkip()
		End
		
	Else
		
		// 旼컴컴컴컴컴컴컴컴컴컴컴컴컴�
		// � Exclui as Avs Especiais   �
		// 읕컴컴컴컴컴컴컴컴컴컴컴컴컴�
		dbSelectArea("SZV")
		dbSetOrder(01)
		dbSeek(xFilial()+SC5->C5_NUM)
		While !eof()  .and. SZV->ZV_NUMAV == SC5->C5_NUM
			RecLock("SZV",.F.)
			dbDelete()
			msUnlock()
			dbSkip()
		End
		
	EndIf
	
EndIf

dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)

Return
