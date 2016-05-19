--[[
PROGRAMA EM LOVE PARA ESCREVER MAPAS EM TXT
CONFIGURE O TAMANHO DO MAPA(LINHAS E COLUNAS DA MATRIZ) CONFORME AS INSTRUÇÕES ABAIXO
CONFIGURE O PADRÃO DE LETRA PARA INICIALIZAR O MAPA
ESCOLHA O NOME DO ARQUIVO A SER SALVO O MAPA
DECIDA SE DESEJA LER UM MAPA EXISTENTE E EDITÁ-LO OU CRIAR UM NOVO
SE DESEJAR, ALTERE A POSIÇÃO INICIAL DO EDITOR

UTILIZE AS SETAS DO TECLADO PARA MOVER O EDITOR
PARA ALTERAR UM CARACTERE PARA O PADRÃO DE ESPAÇO VAZIO/INICIAL, É POSSÍVEL APERTAR BACKSPACE
PARA DIGITAR UM CARACTERE EM MAIÚSCULO, ATIVE CAPSLOCK OU SEGURE A TECLA SHIFT

PARA FECHAR O PROGRAMA E SALVAR O MAPA APERTE "ESCAPE" OU "RETURN"(ENTER)
CASO FECHE O PROGRAMA SEM SER ASSIM, O MAPA NÃO SERÁ SALVO

DIVIRTA-SE
]]--

-- Função para aplicar configurações
function configuration()
  -- Configurações gerais
  config = {
    loadMap = true, -- ler o arquivo de mapa já existente para edição? true/false
    name = "mapa2.txt", -- nome do arquivo contendo o mapa a ser editado
    empty = 'X', -- caractere para inicializar o mapa. recomenda-se utilizar letras em maiúsculo ou números. padrão 'X'. caractere utilizado ao apertar backspace
    lines = 100, -- quantidade de linhas que a matriz do mapa terá. ignorar caso esteja editando um mapa existente
    columns = 100, -- quantidade de colunas que a matriz do mapa terá. ignorar caso esteja editando um mapa existente
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

-- Fim das partes configuráveis, favor não alterar as partes abaixo

-- Não mexer no funcionamento do programa
-- Carregar matriz do mapa, escolher cor de fundo e carregar o editor
function love.load()
  map = {}
  configuration()
  if config.loadMap then
    loadMap(config.name)
  else
    for i=1, config.lines do
      map[i] = {}
      for j=1, config.columns do
        map[i][j] = config.empty
      end
    end
  end
  start = {
    line = 1,
    column = 1,
  }
  love.keyboard.setKeyRepeat(true)
  if config.resize then
    love.window.setMode(config.columns*config.spacing, config.lines*config.spacing)
  end
end

-- Não mexer no funcionamento do programa
-- Função para salvar o arquivo contendo o mapa
function saveMap(filename)
  local file = io.open(filename, "w")
	for i = 1, config.lines do		
    for j = 1, config.columns do
      file:write(map[i][j])
    end
    if i < config.lines then
      file:write("\n")
    end
	end
	file:close()
end

-- Não mexer no funcionamento do programa
-- Função para carregar um mapa existente
function loadMap(filename)
  local file = io.open(filename)
  local i = 1
  for line in file:lines() do
    map[i] = {}
    for j=1, #line, 1 do
      map[i][j] = line:sub(j,j)
    end
    config.columns = #line
    i = i + 1
  end
  config.lines = i-1
  if not config.resize and config.showLines > config.lines then
    config.showLines = config.lines
  end
  if not config.resize and config.showColumns > config.columns then
    config.showColumns = config.columns
  end
  file:close()
end

-- Não mexer no funcionamento do programa
-- Função para validar caracteres alfanuméricos
-- Não utilizei string:match("%W") pois esta possibilitava caracteres como "tab" ou "LSHIFT"
function isAlphanumeric(key)
  return key == 'a' or key == 'b' or key == 'c' or key == 'd' or key == 'e' or key == 'f' or key == 'g' or key == 'h' or key == 'i' or key == 'j' or key == 'k' or key == 'l' or key == 'm' or key == 'n' or key == 'o' or key == 'p' or key == 'q' or key == 'r' or key == 's' or key == 't' or key == 'u' or key == 'v' or key == 'x' or key == 'y' or key == 'z' or key == '0' or key == '1' or key == '2' or key == '3' or key == '4' or key == '5' or key == '6' or key == '7' or key == '8' or key == '9'
end

-- Não mexer no funcionamento do programa
-- Função para validar comandos do editor
function love.keypressed(key, isrepeat)
  if key == "up" then
    editor.i = editor.i - 1
  elseif key == "down" then
    editor.i = editor.i + 1
  elseif key == "left" then
    editor.j = editor.j - 1
  elseif key == "right" then
    editor.j = editor.j + 1
  elseif isAlphanumeric(key) then
    if love.keyboard.isDown("rshift") or love.keyboard.isDown("lshift") or config.capsLock then
      map[editor.i][editor.j] = key:upper()
    else
      map[editor.i][editor.j] = key
    end
  elseif key == "return" or key == "escape" then
    saveMap(config.name)
    love.event.quit()
  elseif key == "capslock" then
    if config.capsLock then
      config.capsLock = false
    else
      config.capsLock = true
    end
  elseif key == "backspace" then
    map[editor.i][editor.j] = config.empty
  end
  if editor.i < 1 then
    editor.i = config.lines
    if not config.resize then
      start.line = config.lines - config.showLines + 1
    end
  elseif editor.i > config.lines then
    editor.i = 1
    if not config.resize then
      start.line = 1
    end
  elseif editor.i < start.line and not config.resize then
    start.line = start.line - 1
  elseif editor.i >= start.line + config.showLines and not config.resize then
    start.line = start.line + 1
  end
  if editor.j < 1 then
    editor.j = config.columns
    if not config.resize then
      start.column = config.columns - config.showColumns + 1
    end
  elseif editor.j > config.columns then
    editor.j = 1
    if not config.resize then
      start.column = 1
    end
  elseif editor.j < start.column and not config.resize then
    start.column = start.column - 1
  elseif editor.j >= start.column + config.showColumns and not config.resize then
    start.column = start.column + 1
  end
end