      $SET MS"2"
       identification division.
       program-id. Geracao-Texto-Formatado.
       environment division.
       configuration section.
       special-names. decimal-point is comma.
       input-output section.
       file-control.
       copy "C:\CursoCobol\Copylib\Select-Vendedores.txt".
       copy "C:\CursoCobol\Copylib\Select-Clientes.cpy".
           select exportacao assign to ws-local
             organization is line sequential.
       data division.
       copy "C:\CursoCobol\Copylib\FD-Vendedores.txt".
       copy "C:\CursoCobol\Copylib\FD-Clientes.cpy".
       fd exportacao label record omitted.
       01 linha-exportacao            pic x(300).
       working-storage section.
       01 estado-vendedores       pic x(02) value spaces.
       01 estado-clientes         pic x(02) value spaces.
       01 resposta                pic x(01) value spaces.
       01 ws-local                pic x(50) value
              "C:\CursoCobol\Exportacao\TXT-Dados.Txt".
       01 ws-data.
          03 ws-ano       pic 9(02).
          03 ws-mes       pic 9(02).
          03 ws-dia       pic 9(02).
       01 ws-horario.
          03 ws-hora      pic 9(02).
          03 ws-minuto    pic 9(02).
          03 ws-segundo   pic 9(02).
          03 ws-milesimo  pic 9(02).
      * Area de Exportacao --------------------------------------------*
       01 exporta-01.
         03 e01-hora      pic 99.
         03 filler        pic x   value ":".
         03 e01-minuto    pic 99.
         03 filler        pic x   value ":".
         03 e01-segundo   pic 99.
         03 filler        pic x   value ":".
         03 e01-milesimo  pic 99.
         03 filler        pic x   value " ".
         03 e01-dia       pic 99/.
         03 e01-mes       pic 99/.
         03 e01-ano       pic 99.
         03 filler        pic x   value " ".
         03 e01-codven    pic 999.
         03 filler        pic x   value "-".
         03 e01-nomven    pic x(30).
         03 e01-codcli    pic 999.
         03 filler        pic x   value "-".
         03 e01-nomcli    pic x(45).
         03 filler        pic x   value " ".
         03 e01-venpura   pic 9(09)v99.
         03 filler        pic x   value " ".
         03 e01-venform   pic zzz.zzz.zz9,99.
         03 filler        pic x   value " ".
         03 e01-perpura   pic S9(03)v999.
         03 filler        pic x   value " ".
         03 e01-perform   pic ---9,999.
       procedure division.
       testa-arquivo.
           display erase at 0101
           display "Programa de Geracao de TXT..." at 0201

           open input vendedores
           if estado-vendedores not = "00"
              display "Arquivo Vendedores Com Problema Estado " at 2301
                           estado-vendedores
              accept resposta at 2380
              goback
           end-if

           open input clientes
           if estado-clientes not = "00"
              display "Arquivo Clientes Com Problema Estado " at 2301
                           estado-clientes
              accept resposta at 2380
              goback
           end-if.

           open output exportacao

           accept ws-data    from date
           move ws-dia       to e01-dia
           move ws-mes       to e01-mes
           move ws-ano       to e01-ano

           accept ws-horario from time
           move ws-hora      to e01-hora
           move ws-minuto    to e01-minuto
           move ws-segundo   to e01-segundo
           move ws-milesimo  to e01-milesimo.
       le-arquivo.
           read clientes next at end
                go encerra-arquivo
           end-read

           move vendedor-clientes to codigo-vendedores e01-codven
           read vendedores invalid key
                move spaces to nome-vendedores
           end-read

           move nome-vendedores to e01-nomven
           move codigo-clientes to e01-codcli
           move nome-clientes   to e01-nomcli
           move vendas-mensais-clientes to e01-venpura
                                           e01-venform

           move percentual-clientes     to e01-perpura
                                           e01-perform

           write linha-exportacao from exporta-01
           go le-arquivo.
       encerra-arquivo.
           close vendedores clientes exportacao
           display "Arquivo Gerado..." at 1001
           display "Verifique no Diretorio 'Exportacao'..." at 1501
           goback.
       end program Geracao-Texto-Formatado.