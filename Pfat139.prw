#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

User Function Pfat139()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("CPERG,CCHAVE,CFILTRO1,CFILTRO2,CFILTRO3,CFILTRO4")
SetPrvt("CFILTRO5,CIND,CFILTRO,_SALIAS,AREGS,I")
SetPrvt("J,")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴커 굇
굇쿛rograma: PFAT139   쿌utor: Raquel Farias          � Data:   16/08/99 � 굇
굇쳐컴컴컴컴컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴캑 굇
굇쿏escri놹o: Cadastro das Ocorrencias                                   � 굇
굇쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑 굇
굇쿢so      : M줰ulo de Faturamento                                      � 굇
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 굇
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Variaveis utilizadas para parametros                                    �
//쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� mv_par01 Operador.....:                                                 �
//� mv_par02 Status I De..:                                                 �
//� mv_par03 Status I At�.:                                                 �
//� mv_par04 Data de......:                                                 �
//� mv_par05 Data at�.....:                                                 �
//� mv_par06 Follow Up De.:                                                 �
//� mv_par07 Follow Up At�:                                                 �
//� mv_par08 Cod. A눯o De.:                                                 �
//� mv_par09 Cod. A눯o At�:                                                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
/*/

cPerg:="PFT061"

_ValidPerg()

If !Pergunte(cPerg)
   Return
Endif

IF Lastkey()==27
   Return
Endif

DbSelectArea("SZ1")
DbGoTop()
cChave := IndexKey()

If MV_PAR01<>'              '
   cFiltro1:='Z1_OPER=="'+MV_PAR01+'"'
   cFiltro2:='.AND.Z1_STATUSI>="'+MV_PAR02+'".AND.Z1_STATUSI<="'+MV_PAR03+'"'
   cFiltro3:='.AND.Z1_STATUS2>="'+MV_PAR06+'".AND.Z1_STATUS2<="'+MV_PAR07+'"'
   cFiltro4:='.AND.Z1_CODPROM>="'+MV_PAR08+'".AND.Z1_CODPROM<="'+MV_PAR09+'"'
   cFiltro5:='.AND.DTOS(Z1_DTOCORR)>="'+DTOS(MV_PAR04)+'" .AND. DTOS(Z1_DTOCORR)<="'+DTOS(MV_PAR05)+'"'
Else
   cFiltro1:='Z1_STATUSI>="'+MV_PAR02+'".AND.Z1_STATUSI<="'+MV_PAR03+'"'
   cFiltro2:='.AND.DTOS(Z1_DTOCORR)>="'+DTOS(MV_PAR04)+'" .AND. DTOS(Z1_DTOCORR)<="'+DTOS(MV_PAR05)+'"'
   cFiltro3:='.AND.Z1_CODPROM>="'+MV_PAR08+'".AND.Z1_CODPROM<="'+MV_PAR09+'"'
   cFiltro4:='.AND.Z1_STATUS2>="'+MV_PAR06+'".AND.Z1_STATUS2<="'+MV_PAR07+'"'
   cFiltro5:= ''
Endif

cInd   := CriaTrab(NIL,.f.)
cFiltro:=cFiltro1+cFiltro2+cFiltro3+cFiltro4+cFiltro5
IndRegua("SZ1",cInd,cChave,,cFiltro,"Filtrando Pedidos...")
AxCadastro("SZ1","Ocorrencia")
// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> __return(" ")
Return(" ")        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿣ALIDPERG � Autor �  Luiz Carlos Vieira   � Data � 16/07/97 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Verifica as perguntas inclu죒do-as caso n꼘 existam        낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿢so       � Espec죉ico para clientes Microsiga                         낢�
굇읕컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

// Substituido pelo assistente de conversao do AP5 IDE em 26/02/02 ==> Function _ValidPerg
Static Function _ValidPerg()

         _sAlias := Alias()
         DbSelectArea("SX1")
         DbSetOrder(1)
         cPerg    := PADR(cPerg,10) //mp10 x1_grupo char(10)
         aRegs:={}

         // Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05/F3

         AADD(aRegs,{cPerg,"01","Operador...........:","mv_ch1","C",15,0,0,"G","","mv_par01","","","","","","","","","","","","","","",""})
         AADD(aRegs,{cPerg,"02","Status I De........:","mv_ch2","C", 3,0,0,"G","","mv_par02","","","","","","","","","","","","","","","90"})
         AADD(aRegs,{cPerg,"03","Status I At�.......:","mv_ch3","C", 3,0,0,"G","","mv_par03","","''","","","","","","","","","","","","","90"})
         AADD(aRegs,{cPerg,"04","Data de............:","mv_ch4","D",08,0,0,"G","","mv_par04","","''","","","","","","","","","","","","",""})
         AADD(aRegs,{cPerg,"05","Data at�...........:","mv_ch5","D",08,0,0,"G","","mv_par05","","","","","","","","","","","","","","",""})
         AADD(aRegs,{cPerg,"06","Follow Up De.......:","mv_ch6","C", 3,0,0,"G","","mv_par06","","","","","","","","","","","","","","","90"})
         AADD(aRegs,{cPerg,"07","Follow Up At�......:","mv_ch7","C", 3,0,0,"G","","mv_par07","","''","","","","","","","","","","","","","90"})
         AADD(aRegs,{cPerg,"08","Cod. A눯o De.......:","mv_ch8","C", 3,0,0,"G","","mv_par08","","","","","","","","","","","","","","","SZA"})
         AADD(aRegs,{cPerg,"09","Cod. A눯o At�......:","mv_ch9","C", 3,0,0,"G","","mv_par09","","''","","","","","","","","","","","","","SZA"})

         For i:=1 to Len(aRegs)
             If !dbSeek(cPerg+aRegs[i,2])
                 RecLock("SX1",.T.)
                 For j:=1 to FCount()
                     If j <= Len(aRegs[i])
                         FieldPut(j,aRegs[i,j])
                     Endif
                 Next
                 SX1->(MsUnlock())
             Endif
         Next

         DbSelectArea(_sAlias)

Return

