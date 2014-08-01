      $SET MS"2"
       identification division.
       program-id. ContinuarCallLink.

       environment division.
       configuration section.

       data division.
       working-storage section.
       01 campodepassagem       pic x(10) value spaces.
       01 parada                pic x(01) value spaces.
       01 opcao                 pic 9(01) value zeros.
       linkage section.
       01 camposdalinkage.
          03 campodelinkage       pic x(10).
       procedure division using camposdalinkage.
       mostra.
           display erase at 0101
           display "Estou em ContinuarCallLink" at 0201
           display "Digite Algo: " at 0301
           accept  campodelinkage at 0314 with update

           display "Retornando a TesteCallLink com Exit Program" at 0501
           accept  parada                                        at 0601

           exit program
       end program ContinuarCallLink.