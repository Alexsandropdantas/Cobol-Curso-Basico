       identification division.
       program-id. Calculos.

       environment division.
       configuration section.
       special-names. decimal-point is comma.
   
       data division.
       working-storage section.
       01 valor-1                  pic 9(03)v99.
       01 valor-2                  pic 9(03)v99.
       01 valor-3                  pic 9(03)v99.
       01 calculocompute           pic 9(03)v99.
       01 calculorounded           pic 9(03)v9.
       
       01 opcoes                   pic 9 value 9.
       01 crounded                 pic 9.
       01 parada                   pic x.
       
       procedure division.
       inicio.
           perform tela-opcoes until opcoes = 0
           goback.
           
       tela-opcoes.
           perform mostra-linhas
           
           accept valor-1  at 0317
           accept valor-2  at 0517
           accept opcoes   at 0717
           accept crounded at 1317
           
           evaluate crounded
           when 1
               evaluate opcoes
                   when 1 compute calculocompute = valor-1 + valor-2
                       add valor-1 to valor-2
                       display valor-2 at 1625
                   when 2 compute calculocompute = valor-1 - valor-2
                       subtract valor-2 from valor-1
                       display valor-1 at 1625
                   when 3 compute calculocompute = valor-1 * valor-2
                       multiply valor-1 by valor-2 giving valor-2
                       display valor-2 at 1625
                   when 4 compute calculocompute = valor-1 / valor-2
                       divide valor-1 by valor-2 giving valor-1
                                           remainder valor-3
                       display valor-1 at 1625
                       display valor-3 at 1725
               end-evaluate
           when 2
             evaluate opcoes
              when 1 compute calculorounded rounded = valor-1 + valor-2
                     add valor-1 to valor-2 rounded
                     display valor-2 at 1625
              when 2 compute calculorounded rounded = valor-1 - valor-2
                     subtract valor-2 from  valor-1 rounded
                     display valor-1 at 1625
              when 3 compute calculorounded rounded = valor-1 * valor-2
                     multiply valor-1 by valor-2 giving valor-2 rounded
                     display valor-2 at 1625
              when 4 compute calculorounded rounded = valor-1 / valor-2
                     divide valor-1 by valor-2 giving valor-1 rounded
                                        remainder valor-3
                     display valor-1 at 1625
                     display valor-3 at 1725
             end-evaluate
            end-evaluate
            
           perform teste-perform thru teste-perform-exit.
           
       teste-perform.
           display calculocompute at 1625
           display calculorounded at 1825
       
           accept parada at 2315.
 
               
       teste-perform-exit.
           exit.
            
      
       mostra-linhas.
            display erase             at 0101
            display "Valor 01 ....: " at 0301
            display "Valor 02 ....: " at 0501
            display "Opcao .......: " at 0701
            display "    1-Adicao         2-Subtracao   " at 0801
            display "    3-Multiplicacao  4-Divisao     " at 0901
            display "    0-Encarra                      " at 1001
               
            display "Opcao Rounded: " at 1301
            display "   1-Normal       2-C/Rounded      " at 1401
               
            display "Resultado compute...: " at 1501
            display "Resultado funcao....: " at 1601
            display "Resto...............: " at 1701
            display "Resultado Comp.Round: " at 1801.       

       end program Calculos.