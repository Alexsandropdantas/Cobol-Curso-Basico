       identification division.
       program-id. PrimeiroProgramaCobol as "PrimeiroProgramaCobol.PrimeiroProgramaCobol".
      *
      *  Informa��es das regras do Cobol
      *Para utilizar linhas de coment�rios, utiliza-se o astetistico (*) na coluna 7
      *A �rea de programa��o � ntre as colunas 8 a 72 de cada linha
      *Existem configura��es especiais que podem ser programadas atrav�s da coluna 7 com o s�mbolo $
      *Nomes de divis�es e par�grafos sempre s�o iniciadas na coluna 8
      *Comandos de procedimentos da programa��o em si iniciam na coluna 12 a 72
      *Normalmente Editores Cobol n�o fazem diferencia��o de mai�scula e min�sculas para dados e par�grafos
      *Min�scualas em geral e ma�sculas para coisas especiais
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