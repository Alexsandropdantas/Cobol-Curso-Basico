      $SET MS"2"
       identification division.
       program-id. Processamento-Dados.
       environment division.
       configuration section.
       special-names. decimal-point is comma.
       input-output section.
       file-control.
       copy "C:\CursoCobol\Copylib\Select-Vendedores.txt".
       copy "C:\CursoCobol\Programa11\Programa11\Select-Clientes.cpy".
       copy "C:\CursoCobol\Copylib\Select-Processamento.txt".
       data division.
       copy "C:\CursoCobol\Copylib\FD-Processamento.txt".
       copy "C:\CursoCobol\Copylib\FD-Vendedores.txt".
       copy "C:\CursoCobol\Programa11\Programa11\FD-Clientes.cpy".
       working-storage section.
       01 estado-vendedores       pic x(02) value spaces.
       01 estado-clientes         pic x(02) value spaces.
       01 estado-processamento    pic x(02) value spaces.
       01 resposta                pic x(01) value spaces.
       01 temerro                 pic 9(01) value zeros.
       procedure division.
       procedure-geral section.
           display erase at 0101
           display "Iniciando Processsamento..." at 0201
           display "Abrindo Arquivos..." at 0301
           initialize temerro
           perform abre-arquivos thru abre-arquivos-exit
           if temerro = 9
              goback
           end-if

           display "Lendo Clientes e Gerando Arquivo Processamento"
                               at 0501
           perform gera-processamento thru
                   gera-processamento-exit
           if temerro = 9
              goback
           end-if

           display "Fechando Arquivos..." at 0701
           perform fecha-arquivos thru fecha-arquivos-exit
           if temerro = 9
              goback
           end-if

           display "Mostrando Registros Gerados..." at 0901
           perform mostra-processo thru mostra-processo-exit

           display "Finalizou o processamento..." at 1301
           display "Agora o programa vai ser encerrado..." at 1501
           goback.
       abre-arquivos section.
           open input vendedores
           if estado-vendedores not = "00"
              display "EstadoVendedores= " at 2320 estado-vendedores
              accept resposta at 2370
              move 9 to temerro
           end-if

           open input clientes
           if estado-clientes not = "00"
              display "Estado Clientes = " at 2320 estado-clientes
              accept resposta at 2370
              move 9 to temerro
           end-if

           open output processamento
           if estado-processamento not = "00"
              display "Estado Processamento = " at 2320
                          estado-processamento
              accept resposta at 2370
              move 9 to temerro
           end-if

           close processamento
           open i-o processamento
           if estado-processamento not = "00"
              display "Estado Processamento = " at 2320
                          estado-processamento
              accept resposta at 2370
              move 9 to temerro
           end-if.
       abre-arquivos-exit.
           exit.
       fecha-arquivos section.
           close vendedores
           close clientes
           close processamento
           if estado-processamento not = "00"
              display "Estado Processamento = " at 2320
                          estado-processamento
              accept resposta at 2370
              move 9 to temerro
           end-if.
       fecha-arquivos-exit.
           exit.
       gera-processamento section.
           perform gera-processamento-le until estado-clientes = "10".
       gera-processamento-exit.
           exit.
       gera-processamento-le.
           read clientes next at end
                exit
           end-read

           move vendedor-clientes to vendedor-processamento

           read processamento
           end-read

           if estado-processamento = "23"
                perform zera-dados
                perform adiciona-dados
                perform write-dados
           else
                perform adiciona-dados
                perform rewrite-dados
           end-if.

       zera-dados.
           move zeros to clientes-processamento
           move zeros to total-vendas-processamento.
       adiciona-dados.
           add  1                       to clientes-processamento
           add  vendas-mensais-clientes to total-vendas-processamento.
       rewrite-dados.
           rewrite registro-processamento invalid key
              display "Estado Processamento ReWrite = " at 2320
                          estado-processamento
                            " Chave= " vendedor-processamento
              accept resposta at 2370
              move 9 to temerro
           end-rewrite.
       write-dados.
           write registro-processamento invalid key
              display "Estado Processamento Write = " at 2320
                          estado-processamento
                            " Chave= " vendedor-processamento
              accept resposta at 2370
              move 9 to temerro
           end-write.
       mostra-processo section.
           open input processamento
           if estado-processamento not = "00"
              display "Estado Processamento = " at 2320
                          estado-processamento
              accept resposta at 2370
              move 9 to temerro
              exit section
           end-if.

           perform until estado-processamento = "10"
                 read processamento next at end
                          continue
                 end-read

                 if estado-processamento not = "10"
                    display "Registro Lido: " at 1001
                          registro-processamento
                    display "Enter, para mostrar proximo registro"
                                              at 1101
                    accept resposta at 1575
                 end-if
           end-perform.
       mostra-processo-exit.
           exit.
       end program Processamento-Dados.