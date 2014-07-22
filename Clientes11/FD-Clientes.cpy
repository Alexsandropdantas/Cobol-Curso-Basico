       fd clientes
        
       label record is standard
       value of file-id "C:\CursoCobol\Clientes11\Clientes.Arq".
       01 registro-clientes.
          02 chave-clientes.
             03 codigo-clientes         pic 9(06).
          02 nome-clientes              pic x(40).
          02 endereco-clientes          pic x(40).
          02 uf-clientes                pic x(02).
          02 procura-clientes.
             05 vendedor-clientes       pic 9(03).
               05 cidade-clientes       pic x(40).
          02 cpf-clientes               pic 9(11).
          02 filler redefines cpf-clientes.
              03 cpf1parte              pic 9(09).
              03 cpf2parte              pic 9(02).
          02 data-cadastro-clientes     pic 9(08).
          02 vendas-mensais-clientes    pic 9(09)v99.
       02 filler redefines vendas-mensais-clientes.
            03 milhoes                  pic 9(03).
            03 milheiros                pic 9(03).
            03 centenas                 pic 9(03).
            03 decimais                 pic 9(02).
       02 percentual-clientes           pic s9(03)v999.
                               
