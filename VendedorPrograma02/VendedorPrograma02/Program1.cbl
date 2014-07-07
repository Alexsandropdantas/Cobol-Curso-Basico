       identification division.
       program-id. Vendedor.

       environment division.
       configuration section.
       special-names. decimal-point is comma.
       input-output section.
       file-control.
       select vendedores assign to disk
           organization is indexed
           access mode is dynamic
           file status estado-vendedores
           lock mode is manual
           record key is chave-vendedores.

       data division.
       working-storage section.

       procedure division.

           goback.

       end program Vendedor.