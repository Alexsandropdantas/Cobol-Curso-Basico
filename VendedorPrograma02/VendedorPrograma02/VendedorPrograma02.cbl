      * --- Identifica��o do programa (nome, autor, instala��o,data,...)
       identification division.
           program-id.     Vendedor.
           author.         Alexsandro.
           date-written.   06-07-2014.
           date-compiled.  06-07-2014.
       
      * --- Configura��o de Ambiente
       environment division.
       
      * --- Uma das Se��o de configura��o de ambiente
       configuration section.
       
      * --- O programa vai utilizar a v�rgula "," para separar decimais
       special-names. decimal-point is comma.
       
      * --- Informa��es das entradas e sa�das
       input-output section.
       
      * --- se��o de informa��es dos arquivos de entrada e sa�das
       file-control.
       
      * - Desiguina que "Vendedores" � o nome do arquivo salvo em disco
       select vendedores assign to disk
           organization is indexed
           access mode is dynamic
           file status estado-vendedores
           lock mode is manual
           record key is chave-vendedores.

       data division.
       
      * file description (colunas para armazenamento de dados//tipo db)
       fd vendedores
       
      * label Obrigat�ria quando exsite um fd
       label record is standard
       
      * Local onde ser� criado e mantido o arquivo
      * se colocar apenas "vend.arq" ele cria onde o programa est�
       value of file-id "C:\CursoCobol\VendedorPrograma02\Vend.Arq".
      
      * Toda FD tem N�veis (01, 02, 03, ...)
      * N�vel 01 = Desiguina in�cio da descri��o do registro
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