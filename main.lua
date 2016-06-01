require "config"

-- Não mexer no funcionamento do programa
-- Carregar matriz do mapa, escolher cor de fundo e carregar o editor
function love.load()
  map = {}
  configuration()
  system = {}
  loadMap(config.name)
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
  system.backup = filename:sub(1, #filename -4) .. ".dat"
  local file = io.open(system.backup)
  if file == nil then
    file = io.open(filename)
  end
  if file ~= nil then
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
  else
    for i=1, config.lines do
      map[i] = {}
      for j=1, config.columns do
        map[i][j] = config.empty
      end
    end
  end
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
    saveMap(system.backup)
  elseif key == "return" or key == "escape" then
    saveMap(config.name)
    os.remove(system.backup)
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
    if not config.resize and config.showLines < config.lines then
      start.line = config.lines - config.showLines + 1
    end
  elseif editor.i > config.lines then
    editor.i = 1
    if not config.resize and config.showLines < config.lines then
      start.line = 1
    end
  elseif editor.i < start.line and not config.resize then
    start.line = start.line - 1
  elseif editor.i >= start.line + config.showLines and not config.resize then
    start.line = start.line + 1
  end
  if editor.j < 1 then
    editor.j = config.columns
    if not config.resize and config.showColumns < config.columns then
      start.column = config.columns - config.showColumns + 1
    end
  elseif editor.j > config.columns then
    editor.j = 1
    if not config.resize and config.showColumns < config.columns then
      start.column = 1
    end
  elseif editor.j < start.column and not config.resize then
    start.column = start.column - 1
  elseif editor.j >= start.column + config.showColumns and not config.resize then
    start.column = start.column + 1
  end
end