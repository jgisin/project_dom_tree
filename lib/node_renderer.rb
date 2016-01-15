require_relative 'dom_parser.rb'


class NodeRenderer

  attr_reader :tree

  def initialize
    @dom_parser = DomParser.new
    @tree = @dom_parser.build_tree
  end

  def render(node)
    p @tree
    # How many total nodes there are in the sub-tree below this node
    puts "There are #{node.children.length} nodes below this node."
    # A count of each node type in the sub-tree below this node
    puts ""
    # All of the node's data attributes
    puts "Here are all the attributes for your node: "

  end




  def bfs_for(node)
    queue = []
    queue << @dom_parser.root
    while move = queue.shift
      if [move.x, move.y] == node
        return show_path(move)
      end
      move.children.each { |child| queue << child }
    end
    puts "Couldn't find it."
  end

  def dfs_for(target_coords)
    stack = []
    stack << @tree.start
    while move = stack.pop
      if [move.x, move.y] == target_coords
        return show_path(move)
      end
      move.children.each { |child| stack << child}
    end
    puts "Couldn't find it."
  end

  def show_path(move)
    puts "#{move.depth} Moves:"
    puts "[#{move.x},#{move.y}]"
    while move = move.parent
      puts "[#{move.x},#{move.y}]"
    end
  end

# You should be able to pass nil to receive statistics for the entire document (the root node).



end


renderer = NodeRenderer.new
renderer.bfs_for("html")