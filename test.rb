require_relative 'lexer'
require_relative 'parser'
require_relative 'javascript_generator'

code = <<~RUBY
  def greeting(name)
    "Olá, " + name
  end

  message = greeting("mundo")

  def soma(a, b)
    a + b
  end

  resultado = soma(10, 20)
  resultado
RUBY

lexer = Lexer.new(code)
tokens = []
while (token = lexer.next_token)
  tokens << token
  puts "Token: #{token.type}, Value: #{token.value.inspect}"
end

parser = Parser.new(tokens)
ast = parser.parse

generator = JavaScriptGenerator.new(ast)
puts "\nJavaScript gerado:"
puts generator.generate
