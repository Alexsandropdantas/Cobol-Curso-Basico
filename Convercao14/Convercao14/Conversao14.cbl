       identification division.
       program-id. Conversao.
       environment division.
       configuration section.
       special-names. decimal-point is comma.
       input-output section.
       file-control.
       copy "C:\CursoCobol\Copylib\Select-Vendedores.txt".
       copy "C:\CursoCobol\Copylib\Select-NovoVendedores.txt".
       data division.
       copy "C:\CursoCobol\Copylib\FD-Vendedores.txt".
       copy "C:\CursoCobol\Copylib\FD-NovoVendedores.txt".
       working-storage section.
       01 estado-vendedores       pic x(02) value spaces.
       01 estado-novovendedores   pic x(02) value spaces.
       01 resposta                pic x(01) value spaces.
       procedure division.
       abre-arquivos.
           display erase at 0101
           display "Programa de Conversao..." at 0201
           display "Abrindo arquivos..." at 0301
           open input vendedores
           if estado-vendedores not = "00"
              display "Arquivo Vendedores Com Problema Estado " at 2301
                           estado-vendedores
              accept resposta at 2380
              stop run
           end-if

           open output novovendedores
           if estado-novovendedores not = "00"
              display "Arquivo NovoVendedores Com Problema Estado "
                                at 2301 estado-novovendedores
              accept resposta at 2380
              stop run
           end-if
           display "Lendo vendedores..." at 0501.
       le-arquivo.
           read vendedores next at end
                go encerra-arquivo
           end-read

           move codigo-vendedores to codigo-novovendedores
           move nome-vendedores   to nome-novovendedores
           move spaces            to regiao-novovendedores
                                     email-novovendedores
                                     site-novovendedores

           write registro-novovendedores invalid key
              display "Erro Salvar NovoVendedores = Estado "
                                at 2301 estado-novovendedores
              accept resposta at 2380
              stop run
           end-write
           go le-arquivo.
       encerra-arquivo.
           close vendedores novovendedores
           display "Conversao Finalizada..." at 1001
           display "Programa sendo finalizado..." at 1201
           goback.
       end program Conversao.