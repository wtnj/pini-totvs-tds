#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

User Function M140bar()        // incluido pelo assistente de conversao do AP5 IDE em 13/03/02

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("AHEADER,")


/*
As Variaveis PRIVATE que voce tem acesso s긫:
_oB          -> "Objeto TBrowser"
_nAt         -> "Numero" com Registro no Browser
_lAglutina   ->  "Logica" aglutina os registros TRUE/FALSE

旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
� Elemento [01]- Titulo do campo                                              �
� Elemento [02]- Nome do campo, se este existir no SX2,os outros elementos que�
�                estiverem com NIL,ser�o atualizados com excess�o do  element-�
�                to[11]                                                       �
� Elemento [03]- Mascara do Campo                                             �
� Elemento [04]- Tamanho do campo                                             �
� Elemento [05]- Decimais do campo                                            �
� Elemento [06]- String p/ clausula VALID                                     �
� Elemento [07]- Tipo do Usado  "S"                                           �
� Elemento [08]- Tipo do Campo "C,N,D"                                        �
� Elemento [09]- Alias das tabelas ref ao elemento[2]                         �
� Elemento [10]- Obrigatorio ("S"/"N")                                        �
� Elemento [11]- String contendo Numero da proxima coluna para o foco ou "F"  �
�                indicando o fim                                              �
� Elemento [12]- Paramentros para Aglutinar ("K"-Campo Chave "A"-Adiciona o   �
�                Valor "S"-Subtrair o Valor)                                  �
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
*/
aHeader   :={{;            
             NIL,;                    //1
             "B1_CODBAR",;            //2
             NIL,;                    //3
             NIL,;                    //4
             NIL,;                    //5
             "A140VALIDCB()",;        //6
             NIL,;                    //7
             NIL,;                    //8
             "SB1",;                  //9
             "S",;                    //10
				 "F",;                    //11
				 "K";                     //12				 
				},; 
            {;        
             NIL,;                         //1
             "D1_COD",;                    //2
             NIL,;                         //3
             NIL,;                         //4
             NIL,;                         //5
             "A140VALIDCB()",;             //6
             NIL,;                         //7
             NIL,;                         //8
             "SD1",;                       //9
 			    "S",;                         //10
				 "4",;                         //11				 
				 " ";                          //12
			   },;
            {;        
             NIL,;        //1
             "B1_DESC",;  //2
             NIL,;        //3 
             NIL,;        //4
             NIL,;        //5
             "A140VALIDCB()",;        //6
             NIL,;        //7
             NIL,;        //8
             "SB1",;      //9 
             "N",;        //10 
				 NIL,;        //11				 	
				 NIL;         //12			 
				},; 
            {;        
             NIL,;        //1
             "D1_QUANT",; //2
             NIL,;        //3
             NIL,;        //4
             NIL,;        //5
             "A140VALIDCB()",;        //6
             NIL,;        //7
             NIL,;        //8
             "SD1",;      //9
             "S",;        //10 
				 " ",;        //11
				 "A";         //12				 				 
			  }}
Return

