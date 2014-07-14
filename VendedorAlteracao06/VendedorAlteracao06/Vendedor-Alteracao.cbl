       identification division.
       program-id. Vendedor-Alteracao.

       environment division.
       configuration section.
       special-names. decimal-point is comma.
       input-output section.
       file-control.
       copy "C:\CursoCobol\Copylib\Select-Vendedores.txt".
       data division.
       copy "C:\CursoCobol\Copylib\FD-Vendedores.txt".

       working-storage section.
       01 estado-vendedores     pic x(02) value spaces.
       01 resposta              pic x(01) value spaces.
       01 ws-senha              pic x(10) value spaces.
       
       
       screen section.
       01 tela-senha.
           05 line 10 column 15 " Senha para Acesso:"
               background-color 1 foreground-color 2.
           05 line 10 column 35 pic x(10) using ws-senha
                            secure.
           01 tela-codigo.
               03 line 01 column 01 blank screen.
               03 line 06 column 05 "Codigo do Vendedor:" reverse-video.
               03 line 06 column 25 pic 999 using codigo-vendedores.
           01 tela-dados prompt.
               03 line 08 column 05 "Nome do Vendedor :".
               03 line 08 column 25 pic x(20) using nome-vendedores.
      *Mudei de proposito o x(20) do tamanho do nome-vendedores.
      *     o correto do tamanho do nome-vendedores e x(40)
       
       01 tela-confirmacao.
           03 line 23 column 01 blank line.
           03 line 23 column 15 "Confirme Alteracao? Sim ou Nao?".
           03 tela-conf     pic x using resposta auto.     

       procedure division.
       pede-senha.
           display erase at 0101
           display tela-senha
           
           accept tela-senha
           if ws-senha = "ok"
               next sentence
           else
               goback.
       testa-arquivo.
           open i-o vendedores
           if estado-vendedores not = "00"
               display "Arquivo Vendedores COm Problema Estado " at 2301
                   estado-vendedores
               accept resposta at 2380
               stop run
           end-if.
       mostra-tela.
           move zeros to codigo-vendedores
           move spaces to nome-vendedores
           
           display tela-codigo tela-dados
           accept tela-codigo
           if codigo-vendedores = zeros
               close vendedores
               goback
           end-if
           
           read vendedores invalid key
               display "Este Codigo Nao Existe ... Enter" at 2301
                   estado-vendedores
               accept resposta at 2380
               go mostra-tela
           end-read
           
           display tela-dados
           
           accept tela-dados.
           
       confirma-alteracao.
           display tela-confirmacao
           accept tela-conf
           if resposta = "S" or "s"
               next sentence
           else
           if resposta = "N" or "n"
               go mostra-tela
           else
               go confirma-alteracao.
               
           rewrite registro-vendedores invalid key
               display "ReGravacao com Problema, Estado " at 2301
                   estado-vendedores
               accept resposta at 2380
               stop run
           end-rewrite
           
           go mostra-tela.

       end program Vendedor-Alteracao.