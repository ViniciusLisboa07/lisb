# LISB - Um Compilador Ruby para JavaScript

LISB é um compilador simples que traduz código em uma sintaxe similar a Ruby para JavaScript. Este projeto é educacional e visa demonstrar os princípios básicos de construção de compiladores.

## Funcionalidades Atuais

- **Análise Léxica**: Conversão do código fonte em tokens
- **Análise Sintática**: Geração de uma Árvore de Sintaxe Abstrata (AST)
- **Geração de Código**: Conversão da AST em código JavaScript

### O que é suportado atualmente:
- Definição de funções (com argumentos)
- Chamadas de funções
- Atribuição de variáveis
- Expressões aritméticas simples (adição e subtração)
- Operações com números inteiros

## Como Usar

```ruby
require_relative 'lexer'
require_relative 'parser'
require_relative 'javascript_generator'

# Código fonte em sintaxe similar a Ruby
code = <<~RUBY
  def sub(a, b)
    a - b
  end

  x = sub(3, 5)
RUBY

# Análise léxica - Transforma o código em tokens
lexer = Lexer.new(code)
tokens = []
while (token = lexer.next_token)
  tokens << token
end

# Análise sintática - Transforma tokens em AST
parser = Parser.new(tokens)
ast = parser.parse

# Geração de código - Transforma AST em JavaScript
generator = JavaScriptGenerator.new(ast)
javascript_code = generator.generate
puts javascript_code
```

## Exemplo

**Código de entrada (Ruby-like):**
```ruby
def sub(a, b)
  a - b
end

x = sub(3, 5)
```

**Código de saída (JavaScript):**
```javascript
function sub(a, b) {
  return a - b;
}
let x = sub(3, 5);
```

## Estrutura do Projeto

- **lexer.rb**: Análise léxica - converte código fonte em tokens
- **parser.rb**: Análise sintática - converte tokens em uma AST
- **javascript_generator.rb**: Geração de código - converte a AST em JavaScript
- **test.rb**: Arquivo de teste que demonstra a funcionalidade

## Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.