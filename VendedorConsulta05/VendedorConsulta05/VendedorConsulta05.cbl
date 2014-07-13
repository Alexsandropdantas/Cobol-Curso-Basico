       identification division.
       program-id. VendedorConsulta.

       environment division.
       configuration section.
       special-names. decimal-point is comma.
       input-output section.
       file-control.
       copy "C:\CursoCobol\Copylib\Select-Vendedores.txt".

       data division.
       copy "C:\CursoCobol\Copylib\FD-Vendedores.txt".
       working-storage section.
       01 resposta              pic x(01) value spaces.
       01 estado-vendedores     pic x(02) value spaces.

       procedure division.
       Somente-Teste.
       teste-arquivo.
           open input vendedores
           if estado-vendedores not = "00"
             display "Arquivo Vendedores Com Problema Estado " at 2301
             estado-vendedores               
             accept resposta at 2380
             stop run
           end-if.
           
           goback.

       end program VendedorConsulta.