require_relative 'dom_parser.rb'
require 'pry'


class NodeRenderer

  attr_reader :tree

  def initialize
    @dom_parser = DomParser.new
    @tree = @dom_parser.build_tree("../test.html")
    @child_count = 0
    @types_hash = {}

  end

  def render(node)
    # Number of children below this node
    number_of_children(node)
    puts "There are #{@child_count} nodes below this node."
    puts
    # A count of each node type in the sub-tree below this node
    children_type(node)
    puts "These are the node types below your node: "
    puts "#{@types_hash}"
    puts
    # All of the node's data attributes
    tag = find_our_node(node)
    puts "Here are your tag's attributes:"
    puts "    Type: #{tag.type}"
    puts "    Class(es): #{tag.classes}"
    puts "    ID: #{tag.id}"
    puts "    Text: #{tag.text}"
    puts "    Name: #{tag.name}"
    # TODO: You should be able to pass nil to receive statistics for the entire document (the root node).

  end

  def find_our_node(target_node)
    queue = []
    queue << @dom_parser.root
    while tag = queue.shift
      return tag if tag.type == target_node
      tag.children.each do |child|
        queue << child 
      end
    end

  end


  def number_of_children(target_node)
    @child_count = 0
    keep_count = false
    queue = []
    queue << @dom_parser.root
    while tag = queue.shift
      # these are the droids we're looking for
      keep_count = true if tag.type == target_node
      tag.children.each do |child|
        queue << child 
        @child_count += 1 if keep_count
      end
    end
    @child_count -=1 # subract the node itself
  end


  def children_type(target_node)
    # @types_hash = {"div" => 3, "em" => 1}
    keep_track = false
    queue = []
    queue << @dom_parser.root
    while tag = queue.shift
      keep_track = true if tag.type == target_node
      tag.children.each do |child|
        queue << child 
        if @types_hash.include?(child.type)
          @types_hash[child.type] += 1 if keep_track
        else
          @types_hash[child.type] = 1 if keep_track
        end
      end
    end
  end



end


renderer = NodeRenderer.new
p renderer.render("h2")
# p renderer.children_type("main")
# p renderer.tree[0].children

# start with an empty queue
# put root node into the queue
# if the root node is the node we asked for:
  # put the children in the queue
  ## evaluate the child, put their children into the queue
  ## increase the count each time we encounter a child
  ## return when we have no more children
# if the root node is NOT what we asked for:
  # keep going through children until we find the one we want
  # put its children into the queue
  ## evaluate the child, put their children into the queue
  ## increase the count each time we encounter a child
  ## return when we have no more children