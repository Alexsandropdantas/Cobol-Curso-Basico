      $SET MS"2"
      *SET USE "C:\CursoCobol\Config\COBOL.DIR"
       
       identification division.
       program-id. Teste-Config.

       environment division.
       configuration section.
       special-names. decimal-point is comma.
       input-output section.

       data division.
       working-storage section.
       01 opcao                pic 9 value zeros.
       01 parada               pic x value spaces.
       01 teclafuncao          pic 9(02) value zeros.
       01 qualquercoisa        pic x(01) value spaces.
       
       01 edicao               pic zzzzz9,999.
       01 campo                pic 9(06)v999.
       
       01 edicaosinal          pic -----9,999.
       01 camposinal           pic s9(05)v999.
       
       screen section.
       01 tela-teste.
          03 line 01 column 01 blank screen.
          03 line 01 column 01 "Teste Por Screen Section".
          03 line 02 column 01 "Teste de Accept/Display Campos/Edicao".
          03 line 04 column 01 "Edicao zzzzz9,999 = ".
          03                   pic zzzzz9,999 using edicao.
       01 tela-teste-mostra.
          03 line 04 column 35 "Display zzzzz9,999= ".
          03                   pic 9(06)v999 using edicao.
          03 line 05 column 35 "Display 9(06)v999 = ".
          03                   pic 9(06)v999 using campo.
       01 tela-teste-pic.
          03 line 06 column 01 "Display 9(06)v999 = ".
          03                   pic 9(06)v999 using campo.
       01 tela-teste-mostra-pic.
          03 line 06 column 35 "Display zzzzz9,999= ".
          03                   pic zzzzz9,999 using edicao.
          03 line 07 column 35 "Display 9(06)v999 = ".
          03                   pic 9(06)v999 using campo.
          
       01 tela-teste-sinal.
          03 line 12 column 01 "Teste de Accept/Display Campos/Edicao".
          03                   "Com sinal".
          03 line 13 column 01 "Edicao -----9,99 = ".
          03                   pic -----9,99 using edicaosinal.
       01 tela-teste-mostra-sinal.
          03 line 13 column 35 "Display -----9,99= ".
          03                   pic -----9,99 using edicaosinal.
          03 line 14 column 35 "Display S9(05)v999= ".
          03                   pic s9(05)v999 using camposinal.
       01 tela-teste-pic-sinal.
          03 line 16 column 01 "Edicao s9(05)v999 = ".
          03                   pic s9(05)v999 using camposinal.
       01 tela-teste-mostra-pic-sinal.
          03 line 16 column 35 "Display -----9,999= ".
          03                   pic -----9,999 using edicaosinal.
          03 line 17 column 35 "Display s9(05)v999= ".
          03                   pic s9(05)v999 using camposinal.        

       procedure division.
           perform testes until opcao = 9
           goback.
       testes.
          display erase at 0101
          display "Opcoes de Testes Accept/Dispaly:" at 0201
          display "1-Por procedure Division" at 0315
          display "2-PorSceen Section" at 0415
          display "3-Teste Adisctrl (adiscf) e Teclas de Funcao" at 0515
          display "9-Encerrar        " at 0615
          
       initialize edicao campo edicaosinal camposinal
       accept opcao at 0245
       evaluate opcao
        when 1
           perform testes-procedure
        when 2
           perform testes-screen
        when 3
           perform testes-funcoes until qualquercoisa = "X"
        when 9
           exit
        end-evaluate.
       testes-procedure.
           display erase at 0101
           display "Testes Por Procedure Division" at 0101
           display "Testes de accept/display de Campos/Edicao" at 0201
           display "Edicao zzzzz9,999 = " at 0401
           
           accept edicao at 0421
           move edicao to campo
           display "Display zzzzz9,999 "   at 0435 edicao
           display "Display 9(06)v999 = "  at 0535 campo
           
           display "Edicao 9(06)v999 = " at 0701
           
           accept campo at 0721
           move campo to edicao
           display "Display zzzzz9,999= " at 0735 edicao
           display "Display 9(06)v999 = " at 0835 campo
       
           display "Testes de accept/display de Campos/Edicao C/Sinal"
                                          at 1201
           display "Edicao -----9,999 = " at 1301
       
           accept edicaosinal at 1321
           move edicaosinal to camposinal
           display "Display -----9,999 " at 1335 edicaosinal
           display "Display s9(05)v999 = " at 1435 camposinal
           display "Edicao s9(05)v999 = " at 1601
       
           accept camposinal at 1621
           move camposinal to edicaosinal
           display "Display -----9,999= " at 1635 edicaosinal
           display "Display s9(05)v999 = " at 1735 camposinal
       
           accept parada at 2379.
       
       testes-screen.
           display tela-teste
           accept tela-teste
           move edicao to campo
           display tela-teste-mostra
           display tela-teste-pic
           accept tela-teste-pic
           move campo to edicao
           display tela-teste-mostra-pic
           
           display tela-teste-sinal
           accept tela-teste-sinal
           move edicaosinal to camposinal
           display tela-teste-mostra-sinal
           display tela-teste-pic-sinal
           move camposinal to edicaosinal
           display tela-teste-mostra-pic-sinal
           
           accept parada at 2379.
       testes-funcoes.
           display erase at 0101
           move spaces to qualquercoisa
           display "Testes das Teclas de Funcções"     at 0101
           display "Digite qualquer tecla, ESC, F1, etc ...." at 0201
           display "Digite X para sair deste tela"     at 0401
           
           accept qualquercoisa at 0440
           accept teclafuncao from escape key
           display "Codigo da tecla pressionada: " at 1001 teclafuncao
           accept parada at 2379.

       end program Teste-Config.