       identification division.
       program-id. Importacao-Dados.

       environment division.
       configuration section.
       special-names. decimal-point is comma.
       input-output section.
       file-control.
       copy "C\CursoCobol\Copylib\Select-Paises.txt".
           selec importacao assign to ws-local
               file status is estado-importacao
               organization is line sequential.
       data division.
       copy "C:\CursoCobol\Copylib\FD-Paises.txt".
       fd importacao label redord omitted.
       01 linha-importacao         pic x(132).
       01 filler redefines linha-importacao.
          03 codigo-importacao     pic 9(004).
          03 filler                pic x(001).
          03 nome-importacao       pic x(050).
          03 filler                pic x(077).        
       working-storage section.
       01 estado-paises            pic x(02) value spaces.
       01 estado-importacao        pic x(02) value spaces.
       01 resposta                 pic x(01) value spaces.
       01 lidos                    pic 9(04) value zeros.
       01 ws-local                 pic x(50) value
               "C:\CursoCobol\Importacao\Paises.txt".

       procedure division.
       teste-arquivo-txt.
           open input importacao
           if estado-importacao not = "00"
               display "Arquivo TXT Com Problema Estado " at 2301
                       estado-importacao
               accept resposta at 2380
               stop run
           end-if.
           
       testa-arquivo-paises.
           open output paises
           if estado-paises not = "00"
               display "Arquivo Paises Com Problema Estado " at 2301
                   estado-paises
               accept resposta at 2380
               stop run
           end-if
           
           move zeros to lidos.
           
       lerarquivo-txt.
           read importacao next at end
               go importacao-fim
           end-read
           
           move codigo-importacao to codigo-paises
           move nome-importacao   to nome-paises
           
           write registro-paises
           
           add 1 to lidos
           
           go lerarquivo-txt.
           
       importacao-fim.
           close paises importacao
           
           display "Registros Lios e Importados: " at 2310 lidos
           accept resposta at 2379

       end program Importacao-Dados.
       
