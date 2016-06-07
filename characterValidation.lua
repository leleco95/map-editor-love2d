-- Não mexer no funcionamento do programa
-- Função para validar caracteres alfanuméricos
-- Não utilizei string:match("%W") pois esta possibilitava caracteres como "tab" ou "LSHIFT"
function isAlphanumeric(key)
  return key == 'a' or key == 'b' or key == 'c' or key == 'd' or key == 'e' or key == 'f' or key == 'g' or key == 'h' or key == 'i' or key == 'j' or key == 'k' or key == 'l' or key == 'm' or key == 'n' or key == 'o' or key == 'p' or key == 'q' or key == 'r' or key == 's' or key == 't' or key == 'u' or key == 'v' or key == 'x' or key == 'y' or key == 'z' or isNumeric(key)
end

function isNumeric(key)
  return key == '0' or key == '1' or key == '2' or key == '3' or key == '4' or key == '5' or key == '6' or key == '7' or key == '8' or key == '9'
end