class Lexer
    KEYWORDS = ["def", "end", "if", "else", "while", "puts"]
  
    Token = Struct.new(:type, :value)
  
    def initialize(source)
      @source = source
      @position = 0
    end
  
    def next_token
      skip_whitespace
      return nil if @position >= @source.length
  
      char = @source[@position]
  
      if letter?(char)
        read_identifier
      elsif digit?(char)
        read_number
      elsif char == "="
        advance
        Token.new(:EQUAL, "=")
      elsif char == "+"
        advance
        Token.new(:PLUS, "+")
      elsif char == "-"
        advance
        Token.new(:MINUS, "-")
      elsif char == "("
        advance
        Token.new(:LPAREN, "(")
      elsif char == ")"
        advance
        Token.new(:RPAREN, ")")
      elsif char == "\n"
        advance
        Token.new(:NEWLINE, "\n")
      else
        raise "Caractere inesperado: #{char}"
      end
    end
  
    private
  
    def read_identifier
      start = @position
      advance while letter?(@source[@position])
      value = @source[start...@position]
      type = KEYWORDS.include?(value) ? :KEYWORD : :IDENTIFIER
      Token.new(type, value)
    end
  
    def read_number
      start = @position
      advance while digit?(@source[@position])
      Token.new(:NUMBER, @source[start...@position].to_i)
    end
  
    def letter?(char)
      char =~ /[a-zA-Z]/
    end
  
    def digit?(char)
      char =~ /[0-9]/
    end
  
    def advance
      @position += 1
    end
  
    def skip_whitespace
      advance while @source[@position] =~ /\s/
    end
  end