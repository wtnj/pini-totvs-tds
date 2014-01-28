#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ ±±
±±³Programa: PFAT126   ³Autor: Raquel Ramalho         ³ Data:   05/02/01 ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Descri‡ao: Gera arquivo DBF das vendas                                ³ ±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´ ±±
±±³Uso      : M¢dulo de Faturamento                                      ³ ±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
/*/
User Function RACLIENTE()        // incluido pelo assistente de conversao do AP5 IDE em 26/02/02

SetPrvt("MHORA, CARQ,CSTRING,CARQPATH,_CSTRING")  
SetPrvt("MGRUPO,MCHAVE1,MCHAVE2,MDTFAT")  
SetPrvt("MNOME,MUF,MMUN,MATIVIDADE")



Programa:="RAVENDAS"
MHORA:=TIME()
cArq:=SUBS(CUSUARIO,1,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cString:=SUBS(CUSUARIO,1,3)+SUBS(MHORA,1,2)+SUBS(MHORA,7,2)
cArqPath:=GetMv("MV_PATHTMP")
_cString:=cArqPath+cString+".DBF"  
  

_aCampos := {}
AADD(_aCampos,{"PEDIDO","C",6,0})
AADD(_aCampos,{"ITEM","C",2,0})
AADD(_aCampos,{"CF","C",5,0})
AADD(_aCampos,{"CODCLI","C",6,0})
AADD(_aCampos,{"CODDEST","C",6,0})
AADD(_aCampos,{"PRODUTO" ,"C",15,0})
AADD(_aCampos,{"DESDE","D",8,0})
AADD(_aCampos,{"NOME","C",40,0})
AADD(_aCampos,{"MUN ","C",30,0})
AADD(_aCampos,{"UF","C",2,0})
AADD(_aCampos,{"ATIVIDA","C",40,0})
AADD(_aCampos,{"ASSINATURA","C",1,0})
AADD(_aCampos,{"CURSO","C",1,0})
AADD(_aCampos,{"LIVROS","C",1,0})
AADD(_aCampos,{"TCPO","C",1,0}) 
AADD(_aCampos,{"SOFTWARE","C",1,0})
AADD(_aCampos,{"PUBLICID","C",1,0})   
AADD(_aCampos,{"OUTROS","C",1,0})
AADD(_aCampos,{"CGC","C",1,0})

_cNome := CriaTrab(_aCampos,.t.)
cIndex := CriaTrab(Nil,.F.)
cKey   := "Pedido+Item"
dbUseArea(.T.,, _cNome,cArq,.F.,.F.)
dbSelectArea(cArq)
Indregua(cArq,cIndex,ckey,,,"Selecionando Registros do Arq")
  

lEnd:= .F.
bBloco:= {|lEnd| RACLIENTE()}
Processa(bBloco, "CLIENTES" ,"Processando...", .T. )    
 
/*
cArq := CLIENTE
dbUseArea( .T.,, cArq,"CLI", if(.F. .OR. .F., !.F., NIL), .F. )
dbSelectArea("CLI")   
cIndex := CriaTrab(Nil,.F.)
cKey   := "CODCLI"
dbUseArea(.T.,, _cNome,"CLI",.F.,.F.)
dbSelectArea("CLI")
Indregua("CLI",cIndex,ckey,,,"Selecionando Registros do Arq")
*/

DbSelectArea("SA1")
DbGoTop()
//While !EOF()        
While RECNO()<=5
    MDTFAT:=CTOD('  /  /  ')  
    DbSelectArea("ZZ8")
    DbGoTop()  
    DbSeek(xFilial("ZZ8")+SA1->A1_ATIVIDA)
    If Found()
     	MATIVIDADE:= ZZ8->ZZ8_DESCR 
    Endif
            
    DbSelectArea("SC6")
	DbSetOrder(5)
	If MsSeek(xFilial("SC6")+SA1->A1_COD, .T.)
       MCHAVE1:=SC6->C6_NUM+'UNI' 
       MCHAVE2:=SC6->C6_NUM  
       DbSelectArea("SD2") 
       DbSetOrder(8)
       If MsSeek(xFilial("SD2")+MCHAVE1)
     	  MDTFAT:=SD2->D2_EMISSAO
       Else
      		If MsSeek(xFilial("SD2")+MCHAVE2)
    	       MDTFAT :=SD2->D2_EMISSAO
    		Endif
       Endif
    Endif
    
    DbSelectArea("SB1") 
    DbGoTop()
    If MsSeek(xFilial("SB1")+subs(SC6->C6_PRODUTO,1,4)+'000')
       MGRUPO:=SB1->B1_DESC
    Else
        MGRUPO:=""	
    Endif

   DbSelectArea("cArq") 
   If MsSeek(SA1->A1_COD)    
      RecLock("cArq",.F.)  
      DO CASE
         CASE 'LIVRO' $(MGRUPO)
                LIVROS:='S'
         CASE 'ASSINATURA' $(MGRUPO)
               ASSINATURAS:='S'
         CASE 'CURSO' $(MGRUPO)
              CURSOS:='S'                
        CASE 'TCPO' $(MGRUPO)
             TCPO:='S'
       CASE 'SOFT' $(MGRUPO)
             SOFTWARE:='S'        
        CASE 'PUBL' $(MGRUPO)
             PUBLICIDADE:='S'     
        CASE Empty(MGRUPO)
              OUTROS:='S'                                           
    ENDCASE                
   
   Else    
     RecLock("cArq",.T.) 
     PEDIDO:=SC6->C6_NUM
     ITEM:=SC6->C6_ITEM  
     CF:=SC6->C6_CF 
     CODCLI:=SC6->C6_CLI
     CODDEST:=SC6->C6_CODDEST
     PRODUTO:=SC6->C6_PRODUTO       
   
     DESDE:=MDTFAT
   
     GRUPO:=MGRUPO
   
     NOME:= SA1->A1_NOME
     UF:= SA1->A1_EST
     MUN:= SA1->A1_MUN  
     ATIVIDADE:=MATIVIDADE
     CGC:=SA1->A1_CGC
   
     DO CASE
           CASE 'LIVRO' $(MGRUPO)
                  LIVROS:='S'
           CASE 'ASSINATURA' $(MGRUPO)
                 ASSINATURAS:='S'
           CASE 'CURSO' $(MGRUPO)
                CURSOS:='S'                
          CASE 'TCPO' $(MGRUPO)
               TCPO:='S'
         CASE 'SOFT' $(MGRUPO)
               SOFTWARE:='S'        
          CASE 'PUBL' $(MGRUPO)
               PUBLICID:='S'     
          CASE Empty(MGRUPO)
                OUTROS:='S'                                           
      ENDCASE               
      MSUNLOCK()
   EndIf   
End

DbSelectArea("cArq")
dbGoTop()
cMsg:= "Arquivo Gerado com Sucesso em: "+_cString
DbSelectArea("cArq")
dbGoTop()
COPY TO &_cString
MSGINFO(cMsg,"Arquivo Copiado")


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retorna indices originais...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("cArq")
DbCloseArea()
DbSelectArea("SA1")
Retindex("SA1")
DbSelectArea("SC6")
Retindex("SC6")     
DbSelectArea("SD2")
Retindex("SD2")
DbSelectArea("SB1")
Retindex("SB1")
DbSelectArea("ZZ8")
Retindex("ZZ8")

Return
