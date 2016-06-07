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