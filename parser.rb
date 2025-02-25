class Parser
    def initialize(tokens)
      @tokens = tokens
      @position = 0
    end
  
    def parse
      statements = []
      while current_token
        statements << parse_statement
      end
      statements
    end
  
    private
  
    def parse_statement
      token = current_token
      if token.type == :KEYWORD && token.value == "def"
        parse_function
      elsif token.type == :IDENTIFIER
        parse_assignment
      else
        raise "Sintaxe inesperada: #{token.inspect}"
      end
    end
  
    def parse_function
      consume(:KEYWORD, "def")
      name = consume(:IDENTIFIER).value
      consume(:LPAREN)
      args = []
      while current_token.type == :IDENTIFIER
        args << consume(:IDENTIFIER).value
        consume(:COMMA) if current_token&.type == :COMMA
      end
      consume(:RPAREN)
      body = parse_statement
      consume(:KEYWORD, "end")
      { type: "Function", name: name, args: args, body: body }
    end
  
    def parse_assignment
      name = consume(:IDENTIFIER).value
      consume(:EQUAL)
      value = parse_expression
      { type: "Assignment", name: name, value: value }
    end
  
    def parse_expression
      token = current_token
      if token.type == :NUMBER
        consume(:NUMBER)
        { type: "Number", value: token.value }
      elsif token.type == :IDENTIFIER
        consume(:IDENTIFIER)
        { type: "Variable", name: token.value }
      else
        raise "Expressão inválida: #{token.inspect}"
      end
    end
  
    def consume(expected_type, expected_value = nil)
      token = current_token
      raise "Erro de sintaxe" unless token && token.type == expected_type && (expected_value.nil? || token.value == expected_value)
      @position += 1
      token
    end
  
    def current_token
      @tokens[@position]
    end
  end
  