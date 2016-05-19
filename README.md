# Txt Map Editor para o Love2D
Map Editor para o Love2D feito em lua

Programa em LÖVE2D para escrever mapas em .txt

Instruções:
    loadMap = true, -- ler o arquivo de mapa já existente para edição? true/false
    name = "mapa2.txt", -- nome do arquivo contendo o mapa a ser editado
    empty = 'X', -- caractere para inicializar o mapa. recomenda-se utilizar letras em maiúsculo ou números. padrão 'X'. caractere utilizado ao apertar backspace
    lines = 100, -- quantidade de linhas que a matriz do mapa terá. ignorar caso esteja editando um mapa existente
    columns = 100, -- quantidade de colunas que a matriz do mapa terá. ignorar caso esteja editando um mapa existente
    resize = false, -- alterar o tamanho da janela para caber exatamente o mapa? true/false.
    spacing = 20, -- espaçamento entre letras na visualização. recomendado não alterar
    showLines = 29, -- quantidade de linhas a serem exibidas por vez, válido apenas para resize = false. recomendado não alterar. alteração necessária apenas se "spacing" alterado
    showColumns = 39, -- quantidade de colunas a serem exibidas por vez, válido apenas para resize = false. recomendado não alterar. alteração necessária apenas se "spacing" alterado
    capsLock = false, -- capslock inicialmente ativado? true/false. pode ser alterado durante o programa ao apertar a tecla capslock

Para salvar o mapa e fechar o programa, aperte escape ou return/enter.
