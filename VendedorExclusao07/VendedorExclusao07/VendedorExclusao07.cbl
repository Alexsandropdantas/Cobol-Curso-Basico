       identification division.
       program-id. Vendedor-Exclusao.

       environment division.
       configuration section.
       special-names. decimal-point is comma.
       input-output section.
       file-control.
       copy "C:\CursoCobol\Copylib\Select-Vendedores.txt".
       data division.
       copy "C:\CursoCobol\Copylib\FD-Vendedores.txt".
       
       working-storage section.
       01 estado-vendedores    pic x(02) value spaces.
       01 resposta             pic x(01) value spaces.
       
       01 ws-data.
          03 ws-ano            pic 9(02).
          03 ws-mes            pic 9(02).
          03 ws-dia            pic 9(02).
       01 ws-horario.
          03 ws-hora           pic 9(02).
          03 ws-minuto         pic 9(02).
          03 ws-segundo        pic 9(02).
          03 ws-milesimo       pic 9(02).
          
       screen section.
       01 tela-codigo.
          03 line 01 column 01 blank screen.
          03 line 06 column 05 "Codigo do Vendedor:" reverse-video.
          03 line 06 column 25 pic x(20) using nome-vendedores.
       01 tela-dados prompt.
          03 line 08 column 05 "Nome do Vendedor:".
          03 line 08 column 25 pic x(20) using nome-vendedores.
       01 tela-confirmacao.
          03 line 23 column 01 blank line.
          03 line 23 column 15 "Confirma Exclusao? Sim ou Nao?".
          03 tela-conf         pic x using resposta auto.

       procedure division.
       testaarquivo.
           open i-o vendedores
           if estado-vendedores not = "00"
               display "Arquivo Vendedores Com Problema Estado " at 2301
                   estado-vendedores
               accept resposta at 2380
               stop run
           end-if.
       mostra-tela.
           move zeros to codigo-vendedores
           move spaces to nome-vendedores
           
           display tela-codigo tela-dados
           
           accept ws-data from date
           accept ws-horario from time
           
           display "Data Atual do Equipamento: " at 2001
           display     ws-dia at 2110 "/" ws-mes "/" ws-ano
           display     ws-data at 2210
           display "Hora Atual do Equipamento: " at 2050
           display     ws-hora at 2150 ";" ws-minuto ":" ws-segundo
                           ":" ws-milesimo
           display ws-horario at 2250
           
           accept tela-codigo
           if codigo-vendedores = zeros
               close vendedores
               goback
           end-if
           
           read vendedores invalid key
               display "Este Codigo Nao Existe ... Enter" at 2301
               accept resposta at 2380
               go mostra-tela
           end-read
           
           display tela-dados.
           
       confirma-exclusao.
           display tela-confirmacao
           accept tela-conf
           if resposta = "S" or "s"
               next sentence
           else
           if resposta = "N" or "n"
               go mostra-tela
           else
               go confirma-exclusao.
           delete vendedores invalid key
               display "ReGravacao com Problema, Estado " at 2301
                           estado-vendedores
               accept resposta at 2380
               stop run
           end-delete
           
           go mostra-tela.

       end program Vendedor-Exclusao.