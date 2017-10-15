class Label
  new: (content) =>
    @kind = "Label"
    @content = content
    
class Function
  new: (call) =>
    @kind => "Function"
    @content = call
    
is_number = (num) ->
  r = tonumber num
  if r == nil
    false
  else
    true

class Number
  new: (num) =>
    @kind = "Number"
    @content = tonumber(num)
    
class Float
  new: (num) =>
    @kind = "Float"
    @content = tonumber(num)
    
class Rational
  new: (above, below) =>
    @kind = "Rational"
    @content = {:above, :below}
    
class Character
  new: (char) =>
    @kind = "Character"
    @content = char\sub(2, 2)
    
class String
  new: (str) =>
    @kind = "String"
    @content = str
    @array = {}
    for c in str\gmatch "."
      @array[@array + 1] = Character("'#{c}")

-- TODO: Generics

{:Label, :is_number, :Number, :Float, :Rational, :Character, :String}
