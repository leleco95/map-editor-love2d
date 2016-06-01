# Txt Map Editor para o Love2D
Map Editor para o Love2D feito em lua

Programa em LÖVE2D para escrever mapas em .txt

Instruções:

  * Abra o arquivo config.lua

  * Dentro da função configuration(), altere o nome do mapa a ser editado, juntamente com o número de linhas e colunas

  * Se desejar, altere as configurações avançadas como cores e outros(lembre-se que alterar "spacing", "showLines" e "showColumns" podem ter impacto direto no funcionamento do programa)
  

Funcionamento:

  * Ao rodar com love2d, o programa irá checar se existe um arquivo de mapa com o mesmo nome do específicado

  * Caso haja um arquivo .dat do mesmo nome do arquivo de mapa, este será priorizado no carregamento pois será considerado backup da execução anterior, que terminou de maneira errada

  * Caso exista um .txt(ou .dat) com o nome especificado, irá carregar este mapa e ignorar as configurações de linhas e colunas anteriormente especificadas

  * A cada alteração no mapa, é salvo um arquivo .dat com o mesmo nome do mapa para garantir que o mal funcionamento do programa não acarretará em perda de conteúdo

  * Para salvar o mapa e fechar o programa, aperte escape ou return/enter. O .dat de backup será deletado ao encerrar o programa desta maneira.
