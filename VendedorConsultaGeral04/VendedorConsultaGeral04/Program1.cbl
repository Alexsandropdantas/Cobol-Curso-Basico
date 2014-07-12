       identification division.
       program-id. Vendedor-Consulta-Geral.

       environment division.
       configuration section.
       special-names. decimal-point is comma.
       input-output section.
       file-control.
       copy "C:\CursoCobol\Copylib\Select-Vendedores.txt".

       data division.
       copy "C:\CursoCobol\Copylib\FD-Vendedores.txt".
       
       working-storage section.
       01 estado-vendedores       pic x(02) value spaces.
       01 resposta                pic x(01) value spaces.
       77 codigo-inicial          pic 9(04) value zeros.
       01 linha                   pic 99    value zeros.
       
       procedure division.
       testa-arquivo.
           open input vendedores
           if estado-vendedores not = "00"
               display "Arquivo Vendedores Com Problema Estado" at 2301
                   estado-vendedores
               accept resposta at 2380
               stop run
           end-if.
           
       mostra-tela.
           display erase at 0101
           display "Codigo Inicial vendedor: " at 0301
           
           move zeros to codigo-vendedores
           move spaces to nome-vendedores
           
           accept codigo-inicial at 0326 with reverse-video
           if codigo-inicial = zeros
               close vendedores
               stop run
               goback
           end-if
           
           move codigo-inicial to codigo-vendedores
           
           start vendedores key is >= chave-vendedores invalid key
               display "Este Codigo Nao Existe...Enter" at 2301
                   estado-vendedores
               accept resposta at 2380
               go mostra-tela
           end-start.
           
       monta-tela-consulta.
           display erase at 0401
           display "Codigo Vendedor" at 0410
           display "Nome Vendedor" at 0440
           
           move 05 to linha
       
       le-arquivo-ate-o-fim.
           read vendedores next at end
               go finaliza-consulta
           end-read
           
           add 1 to linha
           
           display codigo-vendedores at line linha column 15
           display nome-vendedores at line linha column 40
           
           if linha > 22
               go pede-se-continua-proxima-tela
           end-if
           
           go pede-se-continua-proxima-tela.
           
           pede-se-continuidade-proxima-tela.
               display "Continua para a proxima tela?" at 2310
               accept resposta at 2350
               
               if resposta ="S" or "s"
                   go monta-tela-consulta
               else
               if resposta = "N" or "n"
                   go mostra-tela
               else
                   go pede-se-continua-proxima-tela.
            
            finaliza-consulta.
               display "Consulta Finalizada. Enter Continua" at 2310
               accept resposta at 2350
               go mostra-tela

       end program Vendedor-Consulta-Geral.