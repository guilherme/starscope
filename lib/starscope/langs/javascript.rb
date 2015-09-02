require 'rkelly'
module Starscope::Lang
  module Javascript
    VERSION = 1

    def self.match_file(name)
      name.end_with?('.js')
    end

    def self.extract(path, contents, &block)
      parser = RKelly::Parser.new
      ast = parser.parse(contents)
      ast.each do |node|
        case node
        when RKelly::Nodes::VarStatementNode
          node.value.each do |assignment_statements|
            extract_var_statement_node(assignment_statements, &block)
          end
        when RKelly::Nodes::FunctionDeclNode
          yield :defs, node.value, :line_no => node.line, :type => :func, :col => '0'
        end
      end
    end

    def self.extract_var_statement_node(node, &block)
      case node.value
      when RKelly::Nodes::AssignExprNode
        extract_assignment_expr_node(node, node.value, &block)
      end
    end

    def self.extract_assignment_expr_node(root, node, &block)
      case node.value
      when RKelly::Nodes::FunctionExprNode
        yield :defs, root.name, :line_no => root.line, :type => :func, :col => '0'
      when RKelly::Nodes::ObjectLiteralNode
        extract_object_literal(node.value, &block)
      end
    end

    def self.extract_object_literal(node, &block)
      case node.value
      when RKelly::Nodes::PropertyNode
        extract_object_function(node, node.value, &block)
      end
    end

  end
end
