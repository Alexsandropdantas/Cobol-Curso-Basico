       identification division.
       program-id. PrimeiroProgramaCobol as "PrimeiroProgramaCobol.PrimeiroProgramaCobol".
      *
      *  Informações das regras do Cobol
      *Para utilizar linhas de comentários, utiliza-se o astetistico (*) na coluna 7
      *A área de programação é ntre as colunas 8 a 72 de cada linha
      *Existem configurações especiais que podem ser programadas através da coluna 7 com o símbolo $
      *Nomes de divisões e parágrafos sempre são iniciadas na coluna 8
      *Comandos de procedimentos da programação em si iniciam na coluna 12 a 72
      *Normalmente Editores Cobol não fazem diferenciação de maiúscula e minúsculas para dados e parágrafos
      *Minúscualas em geral e maúsculas para coisas especiais
      *
       
       environment division.
       configuration section.
       
       data division.
       working-storage section.
       01 resposta pic x(01) values spaces.
       
       procedure division.
           Display "Comando Display = Mostra a Mensagem na Tela" at 1001
           accept resposta at 2301
           goback.
           
       end program PrimeiroProgramaCobol.