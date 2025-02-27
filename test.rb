require_relative 'lexer'
require_relative 'parser'
require_relative 'javascript_generator'

code = <<~RUBY
  def sub(a, b)
    a - b
  end

  x = sub(3, 5)

  def soma(a, b)
    a + b
  end

  y = sub(3, 5)

  z = soma(x, y)
RUBY

lexer = Lexer.new(code)
tokens = []
while (token = lexer.next_token)
  tokens << token
end

parser = Parser.new(tokens)
ast = parser.parse

generator = JavaScriptGenerator.new(ast)
puts generator.generate
