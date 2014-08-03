      $SET MS"2"
       identification division.
       program-id. ExemploEstruturado.

       environment division.
       configuration section.

       data division.
       working-storage section.
       01 deuerro         pic x(03) value spaces.
       01 encerrar        pic x(03) value spaces.
       01 opcao           pic 9(02) value zeros.
       01 resposta        pic x(01) value spaces.
       screen section.
       01 tela-principal.
          03 line 01 column 01 blank screen.
       01 tela-opcoes.
          03 line 05 column 10 "01-Incluir".
          03 line 06 column 10 "02-Consultar".
          03 line 07 column 10 "03-Encerrar".
          03 line 09 column 10 "Opcao:".
          03                   pic 99 using opcao.
       procedure division.
       Principal.
           perform abrir-arquivos
           if deuerro = "SIM"
              continue
           else
              display tela-principal
              move spaces to encerrar
              perform pedir-opcoes until encerrar = "SIM"
           end-if

           perform fechar-arquivos
           goback.
       abrir-arquivos.
      *    Aqui abrimos os arquivos necessarios
      *    Se der erro
      *       move "SIM" to deuerro
       fechar-arquivos.
      *    Aqui fechamos os arquivos utilizados
       pedir-opcoes.
           move spaces to encerrar
           move zeros  to opcao
           display tela-opcoes
           accept  tela-opcoes
           evaluate opcao
            when 1
                  perform incluir
            when 2
                  perform consultar
            when 3
                  move "SIM" to encerrar
           end-evaluate.
       incluir.
      *    Aqui monta-se a rotina de inclusao
           display "Aqui e a inclusao" at 2355
           accept resposta at 2379.
       consultar.
      *    Aqui monta-se a rotina de consultar
           display "Aqui e a consulta" at 2355
           accept resposta at 2379.
       end program ExemploEstruturado.