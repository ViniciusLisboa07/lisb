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
        if peek_next_token && peek_next_token.type == :EQUAL
          parse_assignment
        else
          expr = parse_expression
          { type: "ExpressionStatement", expression: expr }
        end
      elsif [:STRING, :NUMBER, :PLUS, :MINUS].include?(token.type)
        expr = parse_expression
        { type: "ExpressionStatement", expression: expr }
      else
        raise "Sintaxe inesperada: #{token.inspect}"
      end
    end
  
    def parse_function
      consume(:KEYWORD, "def")
      name = consume(:IDENTIFIER).value
      consume(:LPAREN)
      args = []
      while current_token && current_token.type == :IDENTIFIER
        args << consume(:IDENTIFIER).value
        consume(:COMMA) if current_token && current_token.type == :COMMA
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
      left = parse_primary
      
      if current_token && [:PLUS, :MINUS].include?(current_token.type)
        operator = consume(current_token.type).value
        right = parse_expression
        return { type: "BinaryExpression", operator: operator, left: left, right: right }
      end
      
      left
    end
  
    def parse_primary
      token = current_token
      if token.type == :NUMBER
        consume(:NUMBER)
        { type: "Number", value: token.value }
      elsif token.type == :STRING
        consume(:STRING)
        { type: "String", value: token.value }
      elsif token.type == :IDENTIFIER
        name = consume(:IDENTIFIER).value
        
        if current_token && current_token.type == :LPAREN
          consume(:LPAREN)
          args = []
          
          if current_token && current_token.type != :RPAREN
            args << parse_expression
            while current_token && current_token.type == :COMMA
              consume(:COMMA)
              args << parse_expression
            end
          end
          
          consume(:RPAREN)
          { type: "FunctionCall", name: name, arguments: args }
        else
          { type: "Variable", name: name }
        end
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
  
    def peek_next_token
      @tokens[@position + 1] if @position + 1 < @tokens.length
    end
  end
  