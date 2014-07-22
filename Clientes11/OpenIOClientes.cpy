       abre-arquivo-io-clientes section.
            open i-o clientes
            if estado-clientes not = "00"
            if estado-clientes = "35" or "05"
                close clientes
                open output clientes
                close clientes
                go abre-aquivo-io-clientes
            else
                display "Arquivo Clientes Com Problema Estado " at 2301
                               estado-clientes
                accept resposta at 2380
                goback
               end-if
            end-if.