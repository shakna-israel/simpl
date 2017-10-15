stypes = require "stypes"

tokenise = (program) ->
  tokens = {}
  expr = {}
  token = ""
  inChar = false
  inString = false
  for c in program\gmatch "."
    if inString
      if c == '"' and token[#token] != '\\'
        token = "#{token}#{c}"
        inString = false
      else
        token = "#{token}#{c}"
    elseif inChar
      if c == "'" and token[#token] != '\\'
        token = "#{token}#{c}"
        inChar = false
      else
        token = "#{token}#{c}"
    else
      if c == '"'
        inString = true
        token = "#{token}#{c}"
      elseif c == "'"
        inChar = true
        token = "#{token}#{c}"
      elseif c == " "
        expr[#expr + 1] = token
        token = ""
      elseif c == "\n"
        tokens[#tokens + 1] = expr
        expr = {}
      else
        token = "#{token}#{c}"
  if #token > 0
    expr[#expr + 1] = token
    token = ""
  if #expr > 0
    tokens[#tokens + 1] = expr
    expr = {}
  tokens
  
parse = (tokens) ->
  ast = {}
  errors = {}
  for _, expr in pairs tokens
    new_expr = {}
    for pos, sym in pairs expr
      if pos == 1
        new_expr[#new_expr + 1] = stypes.Label(sym)
      elseif pos == 2
        new_expr[#new_expr + 1] = stypes.Function(sym)
      elseif stypes.isnumber(sym)
        new_expr[#new_expr + 1] = stypes.Number(sym)
      elseif stypes.isfloat(sym)
        new_expr[#new_expr + 1] = stypes.Float(sym)
      elseif stypes.isrational(sym)
        new_expr[#new_expr + 1] = stypes.Rational(sym)
      elseif stypes.ischar(sym)
        new_expr[#new_expr + 1] = stypes.Character(sym)
      elseif stypes.isstring(sym)
        new_expr[#new_expr + 1] = stypes.String(sym)
      -- TODO: else error
    ast[#ast + 1] = new_expr
  ast

dump_tokens = (tokens) ->
  for line, expr in pairs tokens
    msg = "["
    for _, sym in pairs expr
      msg = "#{msg} #{sym},"
    msg = "#{msg\sub(1, #msg - 1)} ]"
    print msg
  
dump_tokens tokenise "10 print \"Hello, World!\" \n20 print 'a"
