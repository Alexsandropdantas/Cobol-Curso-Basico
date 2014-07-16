       identification division.
       program-id. Vendedor-Relatorio.

       environment division.
       configuration section.
       special-names. decimal-point is comma.
       input-output section.
       file-control.
       copy "C:\CursoCobol\Copylib\Select-Vendedores.txt".
           select relatorio assign to ws-local
               organization is line sequential.
           select arquivo-sort assign to disk.
       
       data division.
       copy "C:\CursoCobol\Copylib\FD-Vendedores.txt".
       fd relatorio label record omitted
               linage is 63 lines
               with footing at 63 lines
               at top 0 lines at bottom 3.
       01 linha-relatorio      pic x(132).
       sd arquivo-sort.
       01 registro-sort.
           03 codigo-sort      pic 9(03).
           03 nome-sort        pic x(40).
       working-storage section.
       01 estado-vendedores    pic x(02) value spaces.
       01 resposta             pic x(01) value spaces.
       77 ws-opc               pic 99    value zeros.
       01 ws-local             pic x(50) value
           "C:\CursoCobol\Relatorios\Spool-Vendedores.txt".
       01 ws-data.
          03 ws-ano            pic 9(02).
          03 ws-mes            pic 9(02).
          03 ws-dia            pic 9(02).
       01 ws-horario.
          03 ws-hora           pic 9(02).
          03 ws-minuto         pic 9(02).
          03 ws-segundo        pic 9(02).
          03 ws-milesimo       pic 9(02).
          
      * Area de Relatórios ---------------------------------------- *
       01 linha-00.
         03 fille              pic x(40) value "Relatorio Vendedores".
         03 filler             pic x(14) value "Data Emissao:".
         03 00-dia             pic 99/.
         03 00-mes             pic 99/.
         03 00-ano             pic 99/.
       01 linha-01.
         03 filler             pic x(07) value spaces.
         03 filler             pic x(15) value "CODIGO".
         03 filler             pic x(40) value "VENDEDOR".
       01 linha-02.
         03 filler             pic x(10) value spaces.
         03 12-codigo          pic zz9bb.
         03 12-nome            pic x(45).
       screen section.
       01 tela-opcoes.
          03 line 01 column 01 blank screen.
          03 line 06 column 05 "01-Relatorio Vendedores Numerico".
          03 line 08 column 05 "02-Relatorio Vendedores Alfabetico".
          03 line 10 column 05 "99-Sai do Programa".
          03 line 15 column 05 "Opcao: ".
          03                   pic 99 using ws-opc.
       
       procedure division.
       testa-arquivo.
           open input vendedores
           if estado-vendedores not = "00"
               display "Arquivo Vendedores Com Problema Estado " at 2301
                   estado-vendedores
               accept resposta at 2380
               stop run
           end-if.
       mostra-opcao.
           display tela-opcoes
           
           accept tela-opcoes
           
           if ws-opc = 99
               stop run
           else
           if ws-opc = 01
               go relatorio-01
           else
           if ws-opc = 02
               go relatorio-02
           else
               go mostra-opcao.
       relatorio-01.
           open input vendedores
           
           open output relatorio
           
           accept ws-data from date
           
           move ws-dia     to 00-dia
           move ws-mes     to 00-mes
           move ws-ano     to 00-ano
           
           move spaces to linha-relatorio
           write linha-relatorio.
       
       relatorio-01-cabecalho.
       
           write linha-relatorio from linha-00
           write linha-relatorio from linha-01.
           
       relatorio-01-a.
           read vendedores next at end
               go relatorio-01-finaliza
           end-read
           
           move codigo-vendedores to 12-codigo
           move nome-vendedores   to 12-nome
           
           write linha-relatorio from linha-02 at eop
               perform relatorio-01-cabecalho
           end-write
           go relatorio-01-a.
           
       relatorio-01-finaliza.
      *Final do Relatorio
           move "Fim do Relatorio" to linha-relatorio
           write linha-relatorio
           close vendedores relatorio
           display "Relatorio 01 Finalizado." at 2315
           accept resposta at 2370
           go mostra-opcao.
       relatorio-02.
       
           sort arquivo-sort on ascending key nome-sort
               input procedure  is relatorio-02-le
                              thru relatorio-02-fim
               output procedure is relatorio-02-imprime
                              thru relatorio-02-imprime-fim
               
       
           display "Relatorio 02 Finalizado." at 2315
           accept resposta at 2370
           
           go mostra-opcao.
       relatorio-02-le.
           open input vendedores.
       relatorio-02-read.
           read vendedores next at end
               go relatorio-02-fim
           end-read
           
           move nome-vendedores to nome-sort
           move codigo-vendedores to codigo-sort
           
           release registro-sort
           go relatorio-02-read.
       relatorio-02-fim.
           close vendedores.
       relatorio-02-imprime.
           open output relatorio
           move spaces to linha-relatorio
           write linha-relatorio.
       relatorio-02-imprime-le.
           return arquivo-sort at end
                  go relatorio-02-imprime-fim
           end-return
           
           move nome-sort   to 12-nome
           move codigo-sort to 12-codigo
           
           write linha-relatorio from linha-02
           go relatorio-02-imprime-le.
       relatorio-02-imprime-fim.
           close relatorio.

       end program Vendedor-Relatorio.