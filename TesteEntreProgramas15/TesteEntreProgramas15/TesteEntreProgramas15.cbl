      $SET MS"2"
       identification division.
       program-id. TesteEntreProgramas.

       environment division.
       configuration section.

       data division.
       working-storage section.
       01 campodepassagem         pic x(10) value spaces.
       01 parada                  pic x(01) value spaces.
       01 opcao                   pic 9(01) value zeros.
      *linkage section.
       01 camposdalinkage.
          03 campodelinkage       pic x(10).
       procedure division using campodepassagem.
       digite-algo.
           display erase at 0101
           display "Estou em TesteEntreProgramas" at 0201
           display "Digite Algo        : " at 0301
           display "Digite Algo Linkage: " at 0401
           display "Tipo de Teste      : " at 0601
           display "    1-Vai por Chain         " at 0701
           display "    2-Vai por Call          " at 0801
           display "    3-Vai por Call c/linkage" at 0901
           display "    9-Encerra               " at 1001
           accept  campodepassagem at 0322 with update
           if campodepassagem = spaces
              stop run
           end-if

           accept  opcao           at 0622
           evaluate opcao
            when 1
             display "Agora vamos para o TesteChain       " at 2001
             display "Atraves de Chain.                   " at 2101
             display "Com o campo campodepassagem valendo:" at 2201
             display campodepassagem                        at 2301
             accept  parada                                 at 2379
             chain   "TesteChain" using campodepassagem
      * Chain tira o foco do TesteEntreProgramas e manda o Foco para
      *                      TesteChain
      *           Encerrando TesteEntreProgramas da memória
             display "Nao vai retornar para esta linha    " at 2301
             accept  parada                                 at 2379
            when 2
             display "Agora vamos para o TesteCall        " at 2001
             display "Atraves de Call.                    " at 2101
             display "Com o campo campodepassagem valendo:" at 2201
             display campodepassagem                        at 2301
             accept  parada                                 at 2379
             call    "TesteCall" using campodepassagem
      * Call executa o programa TesteCall sem encerrar o
      *           Sem encerrar o TesteEntreProgramas da Memória
             display "Retornou aqui e continua normal     " at 2301
             display "Estamos em TesteEntreProgramas.     " at 2340
             accept  parada                                 at 2379
      * Cancelamento ou Retiramos ele da memoria
             cancel  "TesteCall"
             go digite-algo
            when 3
             display "Agora vamos para o TesteCallLink    " at 2001
             display "Atraves de Call com dados Linkage   " at 2101
             display "Com os itens em camposdalinkage:    " at 2201
             display campodelinkage                         at 2301
             accept  parada                                 at 2379
             call    "TesteCallLink" using camposdalinkage
      * Call executa o programa TesteCall sem encerrar o
      *           Sem encerrar o TesteEntreProgramas da Memória
             display "Retornou aqui e continua normal com " at 2301
             display "camposdalinkage = " at 2401 camposdalinkage
             accept  parada                                 at 2379
      * Cancelamento ou Retiramos ele da memoria
             cancel  "TesteCallLink"
             go digite-algo

            when 9
             goback
           end-evaluate
           go digite-algo.
       end program TesteEntreProgramas.