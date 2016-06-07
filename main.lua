require "config"
require "map"
require "characterValidation"

-- Não mexer no funcionamento do programa
-- Carregar matriz do mapa, escolher cor de fundo e carregar o editor
function love.load()
  map = {}
  configuration()
  system = {}
  system.status = "start"
  system.font = love.graphics.newFont("Vera.ttf", 12)
  love.graphics.setFont(system.font)
  system.centralize = 400 - (system.font:getWidth("Digite o nome do mapa a ser editado(sem extensão)")/2)
  system.mapNameX = 400 - (system.font:getWidth(config.name)/2)
  system.selector = 0
  system.selectorSpacing = system.font:getWidth(config.name) / #config.name
  system.selectorLine = 0
  system.selectorLineFlag = false
  system.lineString = "15"
  system.lineStringX = 400 - (system.font:getWidth(system.lineString)/2)
  system.columnString = "15"
  system.columnStringX = 400 - (system.font:getWidth(system.columnString)/2)
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
-- Função para validar comandos do editor
function love.keypressed(key, isrepeat)
  if system.status == "write" then
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
      editor.j = editor.j + 1
      saveMap(system.backup)
    elseif key == "return" or key == "escape" then
      saveMap(config.name)
      os.remove(system.backup)
      if key == "escape" then
        love.event.quit()
      else
        config.name = config.name:sub(1,#config.name-4)
        system.status = "start"
      end
    elseif key == "capslock" then
      if config.capsLock then
        config.capsLock = false
      else
        config.capsLock = true
      end
    elseif key == "backspace" then
      map[editor.i][editor.j] = config.empty
      editor.j = editor.j - 1
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
  elseif system.status == "start" then
    if system.selectorLine == 0 then
      if isAlphanumeric(key) then
        if love.keyboard.isDown("rshift") or love.keyboard.isDown("lshift") or config.capsLock then
          config.name = config.name .. key:upper()
        else
          config.name = config.name .. key
        end
        system.selector = system.selector + 1
        system.mapNameX = 400 - (system.font:getWidth(config.name)/2)
        system.selectorSpacing = system.font:getWidth(config.name) / #config.name
      elseif key == "backspace" then
        config.name = config.name:sub(1,#config.name-1)
        system.mapNameX = 400 - (system.font:getWidth(config.name)/2)
        system.selectorSpacing = system.font:getWidth(config.name) / #config.name
      end
    elseif system.selectorLine == 1 then
      if isNumeric(key) then
        system.lineString = system.lineString:sub(1,system.selector+1) .. key .. system.lineString:sub(system.selector+2,#system.lineString)
        system.selector = system.selector + 1
        system.lineStringX = 400 - (system.font:getWidth(system.lineString)/2)
        system.selectorSpacing = system.font:getWidth(system.lineString) / #system.lineString
      elseif key == "backspace" then
        system.lineString = system.lineString:sub(1, system.selector) .. system.lineString:sub(system.selector+2,#system.lineString)
        system.lineStringX = 400 - (system.font:getWidth(system.lineString)/2)
        system.selectorSpacing = system.font:getWidth(system.lineString) / #system.lineString
      end
    elseif system.selectorLine == 2 then
      if isNumeric(key) then
        system.columnString = system.columnString:sub(1,system.selector+1) .. key .. system.columnString:sub(system.selector+2,#system.columnString)
        system.selector = system.selector + 1
        system.columnStringX = 400 - (system.font:getWidth(system.columnString)/2)
        system.selectorSpacing = system.font:getWidth(system.columnString) / #system.columnString
      elseif key == "backspace" then
        system.columnString = system.columnString:sub(1,system.selector) .. system.columnString:sub(system.selector+2,#system.columnString)
        system.columnStringX = 400 - (system.font:getWidth(system.columnString)/2)
        system.selectorSpacing = system.font:getWidth(system.columnString) / #system.columnString
      end
    end
    if key == "return" then
      config.name = config.name .. ".txt"
      config.lines = tonumber(system.lineString)
      config.columns = tonumber(system.columnString)
      loadMap(config.name)
      system.status = "write"
    elseif key == "capslock" then
      if config.capsLock then
        config.capsLock = false
      else
        config.capsLock = true
      end
    elseif key == "escape" then
      love.event.quit()
    elseif key == "right" then
      system.selector = system.selector + 1
    elseif key == "left" then
      system.selector = system.selector - 1
    elseif key == "up" then
      system.selectorLine = system.selectorLine - 1
      system.selectorLineFlag = true
    elseif key == "down" then
      system.selectorLine = system.selectorLine + 1
      system.selectorLineFlag = true
    end
    if system.selectorLine == 0 and system.selector > #config.name - 1 then
      system.selector = #config.name - 1
    elseif system.selectorLine == 1 and system.selector > #system.lineString - 1 then
      system.selector = #system.lineString - 1
    elseif system.selectorLine == 2 and system.selector > #system.columnString - 1 then
      system.selector = #system.columnString - 1
    elseif system.selector < 0 then
      system.selector = 0
    end
    if system.selectorLine > 2 then
      system.selectorLine = 2
    elseif system.selectorLine < 0 then
      system.selectorLine = 0
    end
    if system.selectorLineFlag then
      system.selector = 0
      if system.selectorLine == 0 then
        system.selectorSpacing = system.font:getWidth(config.name) / #config.name
      elseif system.selectorLine == 1 then
        system.selectorSpacing = system.font:getWidth(system.lineString) / #system.lineString
      elseif system.selectorLine == 2 then
        system.selectorSpacing = system.font:getWidth(system.columnString) / #system.columnString
      end
      system.selectorLineFlag = false
    end
  end
end