
#children in an array
Node = Struct.new(:data, :children, :parent, :depth)

class DOMTree
  attr_reader :root

  DEEP_NODE = ["open", "content", "span"]

  def initialize
    @root = Node.new(nil, [], nil, 0)
  end

  #Creates Tree from processed HTML hash array
  def populate_dom(array)
    node_count = 0
    current_node = @root
    current_depth = 0
    array.each do |hash|
      if DEEP_NODE.include? hash[:type]
        new_node = Node.new(hash, [], current_node, current_node.depth + 1)
        current_node.children << new_node
        current_node = new_node
        current_depth += 1
      else #hash[:type] == "close"
        current_depth -= 1    
        current_node = current_node.parent
      end
      node_count += 1
    end
    node_count
  end


end

