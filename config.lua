-- Função para aplicar configurações
function configuration()
  -- Configurações gerais
  config = {
    name = "Mapa15x15.txt", -- nome do arquivo contendo o mapa a ser editado
    empty = 'X', -- caractere para inicializar o mapa. recomenda-se utilizar letras em maiúsculo ou números. padrão 'X'. caractere utilizado ao apertar backspace
    lines = 15, -- quantidade de linhas que a matriz do mapa terá. ignorar caso esteja editando um mapa existente
    columns = 15, -- quantidade de colunas que a matriz do mapa terá. ignorar caso esteja editando um mapa existente
    resize = false, -- alterar o tamanho da janela para caber exatamente o mapa? true/false.
    spacing = 20, -- espaçamento entre letras na visualização. recomendado não alterar
    showLines = 29, -- quantidade de linhas a serem exibidas por vez, válido apenas para resize = false. recomendado não alterar. alteração necessária apenas se "spacing" alterado
    showColumns = 39, -- quantidade de colunas a serem exibidas por vez, válido apenas para resize = false. recomendado não alterar. alteração necessária apenas se "spacing" alterado
    capsLock = false, -- capslock ativado? true/false. pode ser alterado durante o programa ao apertar a tecla capslock
  }
  -- Posição inicial do editor. i = linha, j = coluna
  editor = {
    i = 1,
    j = 1,
  }
  -- Altere para a cor que desejar. Padrão preto
  love.graphics.setBackgroundColor(0,0,0)
end

-- Desenhar os caracteres da matriz e, se for o mesmo que o editor, desenhar em vermelho(cor padrão, pode ser alterada)
function love.draw()
  for i=start.line, config.lines do
    love.graphics.print(""..i.."", 0, (i-start.line+1)*config.spacing)
    for j=start.column, config.columns do
      if i == editor.i and j == editor.j then
        -- Altere para a cor que desejar. Caractere em que se encontra o editor, padrão vermelho
        love.graphics.setColor(255,0,0)
      end
      love.graphics.print(""..map[i][j].."", (j-start.column+1)*config.spacing, (i-start.line+1)*config.spacing)
      -- Altere para a cor que desejar. Padrão branco
      love.graphics.setColor(255,255,255)
    end
  end
  for j=start.column, config.columns do
    love.graphics.print(""..j.."", (j-start.column+1)*config.spacing, 0)
  end
end