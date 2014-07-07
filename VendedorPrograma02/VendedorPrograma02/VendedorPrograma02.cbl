      * --- Identificação do programa (nome, autor, instalação,data,...)
       identification division.
           program-id.     Vendedor.
           author.         Alexsandro.
           date-written.   06-07-2014.
           date-compiled.  06-07-2014.
       
      * --- Configuração de Ambiente
       environment division.
       
      * --- Uma das Seção de configuração de ambiente
       configuration section.
       
      * --- O programa vai utilizar a vírgula "," para separar decimais
       special-names. decimal-point is comma.
       
      * --- Informações das entradas e saídas
       input-output section.
       
      * --- seção de informações dos arquivos de entrada e saídas
       file-control.
       
      * - Desiguina que "Vendedores" é o nome do arquivo salvo em disco
       select vendedores assign to disk
           organization is indexed
           access mode is dynamic
           file status estado-vendedores
           lock mode is manual
           record key is chave-vendedores.

       data division.
       
      * file description (colunas para armazenamento de dados//tipo db)
       fd vendedores
       
      * label Obrigatória quando exsite um fd
       label record is standard
       
      * Local onde será criado e mantido o arquivo
      * se colocar apenas "vend.arq" ele cria onde o programa está
       value of file-id "C:\CursoCobol\VendedorPrograma02\Vend.Arq".
      
      * Toda FD tem Níveis (01, 02, 03, ...)
      * Nível 01 = Desiguina início da descrição do registro
       01 registro-vendedores.
           02 chave-vendedores.
               03 codigo-vendedores pic 9(3).
           02 nome-vendedores       pic x(40).
           02 filler                pic x(30).
       
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
               

       end program Vendedor.