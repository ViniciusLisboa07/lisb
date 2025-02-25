class JavaScriptGenerator
    def initialize(ast)
      @ast = ast
    end
  
    def generate
      @ast.map { |node| generate_node(node) }.join("\n")
    end
  
    private
  
    def generate_node(node)
      case node[:type]
      when "Function"
        "function #{node[:name]}(#{node[:args].join(', ')}) {\n  return #{generate_node(node[:body])};\n}"
      when "Assignment"
        "let #{node[:name]} = #{generate_node(node[:value])};"
      when "Number"
        node[:value].to_s
      when "Variable"
        node[:name]
      else
        raise "Tipo de nó desconhecido: #{node[:type]}"
      end
    end
  end
  