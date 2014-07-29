       select clientes assign to disk
           organization is indexed
           access mode is dynamic
           file status estado-clientes
           lock mode is manual
           record key is chave-clientes
        alternate record key is nome-clientes with duplicates
        alternate record key is vendedor-clientes with duplicates
        alternate record key is uf-clientes with duplicates
        alternate record key is cpf-clientes.
