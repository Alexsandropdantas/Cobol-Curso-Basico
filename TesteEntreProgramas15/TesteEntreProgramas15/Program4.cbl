      $SET MS"2"
       identification division.
       program-id. TesteCallLink.

       environment division.
       configuration section.

       data division.
       working-storage section.
       01 campodepassagem       pic x(10) value spaces.
       01 parada                pic x(01) value spaces.
       01 opcao                 pic 9(01) value zeros.
       linkage section.
       01 camposdalinkage.
          03 campodelinkage     pic x(10).
       procedure division using camposdalinkage.
       mostra.
           display erase at 0101
           display "Estou em TesteCallLink" at 0201
           display "Digite Algo: " at 0301
           accept  campodelinkage at 0314 with update

           display "Opcoes com Linkage: " at 0601
           display "1-Retornar para TesteEntreProgramas" at 0701
           display "2-Avancar para ContinuarCallLink"    at 0801
           display "3-Encerrar por :goback:         "    at 0901
           display "9-Encerrar por :stop run:       "    at 1001

           accept opcao at 0620
           evaluate opcao
            when 1
              display "Agora vamos retornar para TesteEntreProgramas"
                                                             at 2001
              display "Atraves de Call.                    " at 2101
              display "Com o campo campodepassagem valendo:" at 2201
              display campodelinkage                         at 2301
              accept  parada                                 at 2379
              exit program
            when 2
              display "Agora vamos avancar para ContinuarCallLink"
                                                             at 2001
              display "Atraves de Call.                    " at 2101
              display "Com o campo campodepassagem valendo:" at 2201
              display campodelinkage                         at 2301
              accept  parada                                 at 2379
              call "ContinuarCallLink" using camposdalinkage
      * Depois deste call e exit program em "ContinuarCallLink"
      *        ele retornar para esta linha abaixo
              cancel "ContinuarCallLink"

              display "Retornou aqui e continua normal     " at 2301
              display "Estamos em TesteCallLink.           " at 2340
              accept  parada                                 at 2379

              go mostra
            when 8
               goback
            when 9
               stop run
           end-evaluate

       end program TesteCallLink.