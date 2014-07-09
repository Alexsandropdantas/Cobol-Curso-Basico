       identification division.
       program-id. Vendedor-Consulta.
           author.         Alexsandro.
           date-written.   09-07-2014.
           date-compiled.  09-07-2014.
       
       environment division.
       configuration section.
       special-names. decimal-point is comma.
       input-output section.
       file-control.
       
      * Criar esta pasta/diretório ou alterar conform o projeto
       copy "C:\CursoCobol\Copylib\Select-Vendedores.txt".
      * "Copy" Importa qualquer arquivo no formato texto
       
       data division.
       copy "C:\CursoCobol\Copylib\FD-Vendedores.txt".

       working-storage section.
       01 estado-vendedores   pic x(02) value spaces.
       01 resposta            pic x(01) value spaces.
       
       procedure division.
       testa-arquivo.
           open i-o vendedores
           if estado-vendedores not = "00"
              if estado-vendedores = "35" or "05"
                   close vendedores
                   go testa-arquivo
              else
               Display "Arquivo Vendedores Com Problema Estado" at 2301
               estado-vendedores
               accept resposta at 2380
               stop run
              end-if.
              
       monta-tela.
           display erase at 0101
           display "Codigo Vendedor: " at 0501
           display "Nome   Vendedor: " at 0701
           
           move zeros to codigo-vendedores
           move spaces to nome-vendedores
           
           accept codigo-vendedores at 0518
           if codigo-vendedores = zeros
               close vendedores
               stop run
               goback
           end-if
           
           read vendedores invalid key
               go codigo-nao-existe
           end-read
           
           display "Este codigo Ja Existe, Forneca Outro " at 2301
               estado-vendedores
           accept resposta at 2380
           go to monta-tela.
         codigo-nao-existe.
           accept nome-vendedores at 0718
           .
         grava-cadastro.
           write registro-vendedores invalid key
               display "Gravacao com Problemas, Estado " at 2301
                   estado-vendedores
               accept resposta at 2380
               stop run
           end-write
           
         go monta-tela.
               
       end program Vendedor-Consulta.