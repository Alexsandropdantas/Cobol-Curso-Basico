      $SET MS"2"
       identification division.
       program-id. ManipulacaoStrings.
       working-storage section.
       01 resposta              pic x     value spaces.
       01 string1               pic x(25) value spaces.
       01 string2               pic x(25) value spaces.
       01 string3               pic x(25) value spaces.
       01 quant-1               pic 9(03) value zeros.
       01 quant-2               pic 9(03) value zeros.
       procedure division.
       menu-geral.
           display erase at 0101
           display "Aprendendo a manipular Strings em Cobol" at 0201
           display "Comandos de Exemplo:" at 0301
           display "Comando STRING ... " at 0401
           display "Comando UNSTRING ... " at 0501
           display "Comando INSPECT ... " at 0601
           display "Comando INSPECT com REPLACING... " at 0701
           display "Comando MOVE especial ... " at 0801

           display "Enter...Para iniciar Exemplos..." at 1001
           accept resposta at 2379

           perform comando-string
           perform comando-unstring
           perform comando-inspect
           perform comando-inspect-replacing
           perform comando-move
           goback.
       comando-string.
           display erase at 0101
           move spaces to string1 string2 string3
           display "Exemplos de Manipulacao de Strings" at 0201
           display "Digite Algo 1: " at 0301
           display "Digite Algo 2: " at 0401
           display "Funcao STRING une strings ..." at 0501
           display "Resultado:" at 0601

           accept string1 at 0316
           accept string2 at 0416

           string string1 delimited spaces
                    " + "
                  string2 delimited spaces
                     into string3

           display string3 at 0612
           accept resposta at 2379.
       comando-unstring.
           display erase at 0101
           move spaces to string1 string2 string3
           display "Exemplos de Manipulacao de Strings" at 0201
           display "Digite Algo (com um X no meio): " at 0301
           display "    Exemplo: ContatoXQualquer   " at 0401
           display "Funcao UNSTRING separa strings ..." at 0501
           display "Resultado:" at 0601
           display "Parte1: " at 0701
           display "Parte2: " at 0801

           accept string1 at 0333

           unstring string1 delimited by "X"
                         into string2 string3

           display string2 at 0712
           display string3 at 0812
           accept resposta at 2379.
       comando-inspect.
           display erase at 0101
           move spaces to string1
           move zeros to quant-1 quant-2
           display "Exemplos de Manipulacao de Strings" at 0201
           display "Digite Algo (com um X1/X2): " at 0301
           display "    Exemplo: OlaX1OiX1TemX2     " at 0401
           display "Funcao INSPECT conta strings ..." at 0501
           display "Resultado:" at 0601
           display "Quantidade de X1: " at 0701
           display "Quantidade de X2: " at 0801

           accept string1 at 0333

           inspect string1 tallying
                    quant-1 for all "X1"
                    quant-2 for all "X2"

           display quant-1 at 0719
           display quant-2 at 0819
           accept resposta at 2379.
       comando-inspect-replacing.
           display erase at 0101
           move spaces to string1
           display "Exemplos de Manipulacao de Strings" at 0201
           display "Digite Algo (com um X1/X2): " at 0301
           display "    Exemplo: OlaX1OiX1TemX2     " at 0401
           display "Funcao INSPECT COM REPLACING substitui strings ..."
                                          at 0501
           display "Resultado:" at 0601
           display "Substituindo X1 e X2 por G8 e G9" at 0701

           accept string1 at 0333

           inspect string1 replacing
                    all "X1" by "G8"
                    all "X2" by "G9"

           display string1 at 0619
           accept resposta at 2379.
       comando-move.
           display erase at 0101
           move spaces to string1
           display "Exemplos de Manipulacao de Strings" at 0201
           display "Digite Algo (com 10 digitos): " at 0301
           display "    Exemplo: StringGrande10D    " at 0401
           display "Funcao MOVE de Partes do Campos ..." at 0501
           display "Resultado:" at 0601
           display "Parte1:" at 0701
           display "Parte1:" at 0801

           accept string1 at 0333

           move string1(2:3) to string2
           move string1(10:) to string3

           display string2 at 0719
           display string3 at 0819
           accept resposta at 2379.
       end program ManipulacaoStrings.