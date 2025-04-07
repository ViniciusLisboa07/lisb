# LISB - Ruby to JavaScript Compiler

LISB is a simple compiler that translates code with Ruby-like syntax to JavaScript. This project is educational and aims to demonstrate the basic principles of compiler construction.

## Current Features

- **Lexical Analysis**: Conversion of source code into tokens
- **Syntactic Analysis**: Generation of an Abstract Syntax Tree (AST)
- **Code Generation**: Conversion of the AST into JavaScript code

### Currently supported:
- Function definitions (with arguments)
- Function calls
- Variable assignment
- Simple arithmetic expressions (addition and subtraction)
- Operations with integers

## How to Use

```ruby
require_relative 'lexer'
require_relative 'parser'
require_relative 'javascript_generator'

# Source code in Ruby-like syntax
code = <<~RUBY
  def sub(a, b)
    a - b
  end

  x = sub(3, 5)
RUBY

# Lexical analysis - Transforms code into tokens
lexer = Lexer.new(code)
tokens = []
while (token = lexer.next_token)
  tokens << token
end

# Syntactic analysis - Transforms tokens into AST
parser = Parser.new(tokens)
ast = parser.parse

# Code generation - Transforms AST into JavaScript
generator = JavaScriptGenerator.new(ast)
javascript_code = generator.generate
puts javascript_code
```

## Example

**Input code (Ruby-like):**
```ruby
def sub(a, b)
  a - b
end

x = sub(3, 5)
```

**Output code (JavaScript):**
```javascript
function sub(a, b) {
  return a - b;
}
let x = sub(3, 5);
```

## Project Structure

- **lexer.rb**: Lexical analysis - converts source code into tokens
- **parser.rb**: Syntactic analysis - converts tokens into an AST
- **javascript_generator.rb**: Code generation - converts the AST into JavaScript
- **test.rb**: Test file that demonstrates the functionality

## Contributions

Contributions are welcome! Feel free to open issues or submit pull requests.
