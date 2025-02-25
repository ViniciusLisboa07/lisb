code = <<~RUBY
  def soma(a, b)
    a + b
  end

  x = soma(3, 5)
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
