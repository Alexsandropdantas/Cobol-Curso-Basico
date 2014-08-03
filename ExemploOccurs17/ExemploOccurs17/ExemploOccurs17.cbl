      $SET MS"2"
       identification division.
       program-id. ExemploOccurs.
       data division.
       working-storage section.
       01 resposta             pic x     value spaces.

       01 tabela-occurs.
          03 itens             pic x(02) occurs 10.
          03 itensmatriz       pic x(18).
          03 redefines itensmatriz.
             05 itensxy           occurs 03.
                07 itensxydados   pic x(02) occurs 03.

       01 indice-1             pic 99    value zeros.
       01 indice-2             pic 99    value zeros.
       procedure division.
       trabalhando-com-occurs.
           move spaces to tabela-occurs
           move zeros  to indice-1 indice-2

           display erase at 0101
           display "Programa de Exemplo de Occurs: " at 0201

           display "Digite alguns dados: " at 0301
           display "Obs:Digite varios e varios caracteres" at 0341

           accept itensmatriz at 0401

           display "Itens digitados em uma matriz: " at 0601
           display itensxydados(1, 1) at 0701
           display itensxydados(2, 1) at 0801
           display itensxydados(3, 1) at 0901

           display itensxydados(1, 2) at 0711
           display itensxydados(2, 2) at 0811
           display itensxydados(3, 2) at 0911

           display itensxydados(1, 3) at 0721
           display itensxydados(2, 3) at 0821
           display itensxydados(3, 3) at 0921

           display "Digite a linha  da Matriz (1 a 3): " at 1101
           display "Digite a coluna da Matriz (1 a 3): " at 1201.
       digita-1.
           accept indice-1 at 1136
           if indice-1 = 0 or > 3 go digita-1.
       digita-2.
           accept indice-2 at 1236
           if indice-1 = 0 or > 3 go digita-2.
       mostra.
           display "Dados do campo itensxydados: " at 1501
                            itensxydados(indice-1, indice-2)

           accept resposta at 2379
           goback.

       end program ExemploOccurs.