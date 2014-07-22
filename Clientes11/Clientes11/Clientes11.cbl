      $SET use "C:\CursoCobol\Config\COBOL.DIR"
       identification division.
       program-id. Clientes.

       environment division.
       configuration section.
       special-names. decimal-point is comma.
       input-output section.
       file-control.
       copy "C:\CursoCobol\Copylib\Select-Vendedores.txt".
       copy "C:\CursoCobol\Clientes11\Select-Clientes.cpy".
       
       data division.
       copy "C:\CursoCobol\Copylib\FD-Vendedores.txt".
       copy "C:\CursoCobol\Clientes11\FD-Clientes.cpy".       
       working-storage section.
       01 estado-vendedores            pic x(02) value spaces.
       01 estado-clientes              pic x(02) value spaces.
       01 resposta                     pic x(01) value spaces.
       01 opcao                        pic 9(01) value zeros.
       
       01 ws-data.
          03 ws-dia                    pic 9(02).
          88 ws-dia-ok  value 01 02 03 04 05 06 07 08 09 10 11 12 13 14
                              15 16 17 18 19 20 21 22 23 24 25 26 27 28
                              29 30 31.
          88 ws-dia-30 value 30.
          88 ws-dia-31 value 31.
          03 ws-mes                    pic 9(02).
          88 ws-mes-ok value 01 02 03 04 05 06 07 08 09 10 11 12.
          88 ws-mes-30 value 04 06 08 09 11.
          88 ws-mes-31 value 01 03 05 07 10 12.
          88 ws-mes-28 value 02.
          03 ws-ano                    pic 9(04).
          88 ws-ano-ok value 2010 thru 2099.
          
       01 ws-cpf.
          03 campocpf      pic 9(11).
          03 totalcpf      pic 9(11).
          03 restocpf      pic 9(11).
          03 errocpf       pic 9(01).
          03 separacpf     pic 9(11).
          03 filler redefines separacpf.
             05 wscpf      pic 9 occurs 11.
           
       screen section.
       01 tela-codigo.
          03 line 01 column 01 blank screen.
          03 line 03 column 01 "Codigo Cliente........: ".
          03               pic zzzzz9 using codigo-clientes.
          
       01 tela-dados1.
          03 line 05 column 01 "Nome..................: ".
          03                   pic x(40) using nome-clientes.
          03 line 06 column 01 "Cidade................: ".
          03                   pic x(40) using cidade-clientes.
          03 line 07 column 01 "Estado/UF..........: ".
          03                   pic xx using uf-clientes.
          03 line 08 column 01 "Endereco...........: ".
          03                   pic x(40) using endereco-clientes.
          
       01 tela-dados2.
          03 line 09 column 01 "Vendedor..............: ".
          03                   pic zz9 using vendedor-clientes.
          
       01 tela-dados3.
          03 line 10 column 01 "CPF...................: ".
          03                   pic zzzzzzzzzz9 using cpf-clientes.
          
       01 tela-dados4.
          03 line 11 column 01 "Data cadasto.........: ".
          03                 pic 99/99/999 using data-cadastro-clientes.
       01 tela-dados5.
          03 line 12 column 01 "Vendas Mensais.......: ".
          03                   pic zzz.zzz.zz9,99
                               using vendas-mensais-clientes.
          03 line 13 column 01 "% Percentual Vendas...: ".
          03                   pic ---9,999 using percentual-clientes.
          
       procedure division.
       copy "C:\CursoCobol\Clintes11\OpenIOClientes.cpy".
       abre-aquivo-io-vendedores section.
           open input vendedores
           if estado-vendedores not = "00"
               display "Arquivo Vendedores Com Problema Estado " at 2301
                           estado-vendedores
               accept resposta at 2380
               stop run
           end-if.
       mostra-opcoes section.
           display erase          at 0101
           display "01-Incluir"   at 0301
           display "02-Alterar"   at 0401
           display "03-Consultar" at 0501
           display "00-Sair     " at 0601
           display "Opcao:      " at 1001
           
           accept opcao at 1008
           
           if opcao = 01
               go inclusao
           else
           if opcao = 02
               go alteracao
           else
           if opcao = 03
               go consulta
           else
           if opcao = 00
               close vendedores clientes
               stop run
           else
               go mostra-opcoes
           end-if.
       mostra-tela-dados section.
           display tela-codigo
                   tela-dados1 tela-dados2 tela-dados3 tela-dados4
                   tela-dados5.
          display "-------------------------------------------" at 1401.
           
       inclusao section.
           initialize registro-clientes
           initialize registro-vendedores
           
           perform mostra-tela-dados
           
           accept tela-codigo
           if codigo-clientes = zeros
               go mostra-opcoes
           end-if

           read clientes invalid key
               go inclusao-dados
           end-read

           display "Este Codigo Ja Existe, Foneca Outro " at 2301
                           estado-clientes
           accept resposta at 2380
           go inclusao.
       inclusao-dados.
           accept tela-dados1
           if cidade-clientes = spaces
               display "Obrigatorio Informar." at 2301
               accept resposta at 2380
               go inclusao-dados
           end-if
           if uf-clientes = "RS" or "SP" or "SP" or "MG"
               continue
           else
               go inclusao-dados
           end-if.
       inclusao-vendedor.
           accept tela-dados2
           move vendedor-clientes to codigo-vendedores
           read vendedores invalid key
               display "Este Codigo Nao Existe. Enter." at 2301
               accept resposta at 2380
               go inclusao-vendedor
           end-read
           
           display nome-vendedores at 0940.
       inclusao-cpf.
           accept tela-dados3
           perform calcula-cpf thru calcula-cpf-e
           if errocpf = 9
               display "CPFInvalido, verifique." at 2301
               accept resposta at 2380
               go inclusao-cpf
           end-if.
       inclusao-teste-data.
           accept tela-dados4
           
           move data-cadastro-clientes to ws-data
           if not ws-dia-ok
               display "Dia fora da faixa." at 2301
               accept resposta at 2380
               go inclusao-testa-data
           else
           if not ws-mes-ok
               display "Mes fora da faixa." at 2301
               accept resposta at 2380
               go inclusao-teste-data
           else
           if not ws-ano-ok
               display "Ano fora da faixa" at 2301
               accept resposta at 2380
               go inclusao-teste-data
           end-if
           
           if ws-mes-30 and ws-dia <= 30
               continue
           else
           if ws-mes-31 and ws-dia <= 31
               continue
           else
           if ws-mes-28 and ws-dia <= 28
               continue
           else
               display "Dia/Mes 30/31 Incompativel, verifique." at 2301
               accept resposta at 2380
               go inclusao-testa-data
           end-if
       inclusao-vendas.
           accept tela-dados5
               
           if milheiros = zeros and milhoes = zeros
               display "Somente Clientes com > de Milheiros em vendas."
                               at 2301
               accept resposta at 2380
               go inclusao-vendas
           end-if
           
           if vendas-mensais-clientes < 1000,00
               display "Valor Minimo de Hum mil ....."
                              at 2301
               accept resposta at 2380
               go inclusao-vendas
           end-if
           
           if vendas-mensais-clientes = zeros 
               display "Obrigatorio informar ....." at 2301
               accept resposta at 2380
           end-if
           
           if percentual-clientes < 0 
               Display "Aviso, Cliente perigoso." at 2301
               accept resposta at 2380
           end-if.
           
       inclusao-grava-clientes section.
           write registro-clientes
           end-write
           
           if estado-clientes = "22"
               display "Gravacao com prolema, Estado " at 2301
                       estado-clientes " Chave Duplicada "
               accept resposta at 2380
               stop run
           end-if
           
           if estado-clientes = "24"
               display "Gravacao com Problemas, Estado " at 2301
                           estado-clientes " Disco-Cheio "
               accept resposta at 2380
               stop run
           end-if
           
           if estado-clientes not = "00" and "02"
               display "Gravacao com Problema, estado " at 2301
                           estado-clientes
               accept resposta at 2380
               stop run
           end-if
           
           go inclusao.
       consulta section.
           initialize registro-clientes
           initialize registro-vendedores
           
           perform mostra-tela-dados
           
           accept tela-codigo
           if codigo-clientes = zeros
               go mostra-opcoes
           end-if
           
           read clientes invalid key
               display "Este Codigo Nao Existe, Forneca Outro " at 2301
               accept resposta at 2380
               go consulta
           end-read
           
       mostra-dados.
           display tela-dados1 tela-dados2 tela-dados3
                   tela-dados4 tela-dados5
                   
           move vendedor-clientes to codigo-vendedores
           read vendedores
           
           display nome-vendedores at 0940.
       mostra-final-consulta section.
           display "Enter, finaliza Consulta." at 2301
           accept resposta at 2380
           go consulta.
       alteracao section.
           initialize registro-clientes
           initialize registro-vendedores
           
           perform mostra-tela-dados
           
           accept tela-codigo
           if codigo-clientes = zeros
               go mostra-opcoes
           end-if
           
           read clientes invalid key
               display " este Codigo nao Existe, Forneca Outro " at 2301
                               estado-clientes
               accept resposta at 2380
               go consulta
           end-read
           
           perform mostra-dados
           
           perform inclusao-dados thru inclusao-vendas
           
           rewrite registro-clientes invalid key
               display "Gravacao com problema, Estado " at 2301
                           estado-vendedores
               accept resposta at 2380
               stop run
           end-rewrite
           
           go alteracao.
       calcula-cpf section.
           move zeros to ws-cpf
           move cpf-clientes to separacpf
           compute totalcpf = 
                   (wscpf(10) * 2) +     
                   (wscpf(9) * 3) + (wscpf(8) * 4) + (wscpf(7) * 5) +
                   (wscpf(6) * 6) + (wscpf(5) * 7) + (wscpf(4) * 8) +
                   (wscpf(3) * 9) + (wscpf(2) * 10) + (wscpf(1) * 11)
           end-compute
           if totalcpf < 10
               compute campocpf = 11 - totalcpf
           else
               compute campocpf = totalcpf / 11
               compute restocpf = totalcpf - (campocpf * 11)
               if restocpf = 0
                   compute campocpf = 0
               else
                   compute campocpf = 11 - restocpf
               end-if
           end-if
           
           move campocpf to wscpf(11)
           
           if cpf-clientes = separacpf
               move 1 to errocpf
           else
               move 9 to errocpf
           end-if.
           
       calcula-cpf-e.
           exit. 

       end program Clientes.