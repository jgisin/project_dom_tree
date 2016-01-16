require_relative "./stack.rb"

class NodeSearcher

  attr_accessor :tree

  def initialize
    @tree = nil
    @stack = Stack.new
  end

  def search_by(query_type, query)
    @stack.push(@tree.root)
    result_array = []
    until @stack.empty?
      current_node = @stack.pop
      current_node.children.each do |child|
        @stack.push(child)
        #binding.pry
        if (child.data[query_type]) && (child.data[query_type].include? query)
          result_array << child
        end
      end
    end
    result_array   
  end

  def search_children(node, query_type, query)
    @stack.push(node)
    result_array = []
    until @stack.empty?
      current_node = @stack.pop
      current_node.children.each do |child|
        @stack.push(child)
        if (child.data[query_type]) && (child.data[query_type].include? query) &&
          child.depth > node.depth
          result_array << child
        end
      end
    end
    result_array   
  end

  def search_direct_children(node, query_type, query)
    @stack.push(node)
    result_array = []
    until @stack.empty?
      current_node = @stack.pop
      current_node.children.each do |child|
        @stack.push(child)
        #binding.pry
        if (child.data[query_type]) && (child.data[query_type].include? query) &&
          child.depth == node.depth + 1
          result_array << child
        end
      end
    end
    result_array
  end

end