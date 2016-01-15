
#children in an array
Node = Struct.new(:data, :children, :parent, :depth)

class DOMTree

  DEEP_NODE = ["open", "content", "span"]

  def initialize
    @root = nil
  end

  def populate_dom(array)
    @root = Node.new(nil, [], nil, 0)
    current_node = @root
    current_depth = 0
    array.each_with do |hash|
      if DEEP_NODE.include? hash[:type]
        new_node = Node.new(hash, [], current_node, current_node.depth + 1)
        current_node.children << new_node
        current_node = new_node
        current_depth += 1
      else #hash[:type] == "close"
        current_depth -= 1
        current_node = current_node.parent
      end
    end
  end

end

# span tags can be a problem

# opening tag - create new node

# until tag with no children

# children? - 
  #new node for each child w/ content type=text or content
  #current node = child_node (children.last)
  #if <> depth += 1
  #if </> depth -= 1


# 
