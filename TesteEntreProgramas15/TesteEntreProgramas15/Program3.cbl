      $SET MS"2"
       identification division.
       program-id. TesteCall.

       environment division.
       configuration section.

       data division.
       working-storage section.
       01 campodepassagem       pic x(10) value spaces.
       01 parada                pic x(01) value spaces.
       procedure division using campodepassagem.
       mostra.
           display erase at 0101
           display "Estou em TesteCall" at 0201
           display "Digite Algo: " at 0301
           accept  campodepassagem at 0314 with update

           display "Agora vamos retornar para TesteEntreProgramas"
                                                          at 2001
           display "Atraves de Call.                    " at 2101
           display "Com o campo campodepassagem valendo:" at 2201
           display campodepassagem                        at 2301
           accept  parada                                 at 2379

           exit program.
       end program TesteCall.