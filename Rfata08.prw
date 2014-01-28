#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

User Function Rfata08()        // incluido pelo assistente de conversao do AP5 IDE em 25/02/02

//���������������������������������������������������������������������Ŀ
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//�����������������������������������������������������������������������

SetPrvt("_CALIAS,_NINDEX,_NREG,AROTINA,CCADASTRO,")

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
������������������������������������������������������������������������Ŀ ��
���Programa:  RFATA08  �Autor: Roger Cangianeli       � Data:   26/01/00 � ��
������������������������������������������������������������������������Ĵ ��
���Descri�ao: Browse para Manutencao de Faturamentos Especiais de A.V.'s � ��
������������������������������������������������������������������������Ĵ ��
���Uso      : Especifico Editora PINI Ltda.                              � ��
�������������������������������������������������������������������������� ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
_cAlias := Alias()
_nIndex := IndexOrd()
_nReg   := Recno()

aRotina := {    {"Pesquisa" , "AxPesqui"  , 0 , 1},;                            //"Pesquisar"
{"Visualiza", "ExecBlock('RFATA09',.F.,.F.,'V')", 0 , 2},;      //"Visualizar"
{"Incluir"  , "ExecBlock('RFATA09',.F.,.F.,'I')", 0 , 3},;      //"Incluir"
{"Alterar"  , "ExecBlock('RFATA09',.F.,.F.,'A')", 0 , 2},;      //"Alterar"
{"Excluir"  , "ExecBlock('RFATA09',.F.,.F.,'E')", 0 , 2}  }     //"Excluir"

//{"Debugar"  , "DebugIxb('RFATA09._ix')", 0 , 2},;               //"DEBUG"

//����������������������������������������������������������Ŀ
//� Define o cabecalho da tela de atualizacoes               �
//������������������������������������������������������������
cCadastro := "Faturamento Programado"
#IFNDEF WINDOWS
//����������������������������������������������������������Ŀ
//� Recupera o desenho padrao de atualizacoes                �
//������������������������������������������������������������
ScreenDraw("SMT050", 3, 0, 0, 0)
//����������������������������������������������������������Ŀ
//� Display de dados especificos deste Programa              �
//������������������������������������������������������������
SetColor("b/w,,,")
@ 3, 1 Say cCadastro
//����������������������������������������������������������Ŀ
//� Ativa tecla F10 para alterar parametro                   �
//������������������������������������������������������������
//SetKey(K_F10, { |a,b| a440Param() } )

#ELSE
cCadastro := OemToAnsi(cCadastro)
//����������������������������������������������������������Ŀ
//� Ativa tecla F12 para alterar parametro		             �
//������������������������������������������������������������
//Set Key VK_F12 TO a440Param()

#ENDIF
//����������������������������������������������������������Ŀ
//� Endereca a funcao de BROWSE                              �
//������������������������������������������������������������
#IFNDEF WINDOWS
    mBrowse( 6, 1,22,75,"SZV",,)            // "C5_LIBEROK")
#ELSE
    @ 006,005 TO 093,150 BROWSE "SZV"
#ENDIF


dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)

Return