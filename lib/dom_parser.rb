#require 'pry-byebug'
require_relative "./dom_tree.rb"
require_relative "./html_reader.rb"
require_relative "./html_writer.rb"
require_relative "./node_renderer.rb"
require_relative "./node_searcher.rb"
require_relative "./stack.rb"

class DOMParser
  attr_reader :tree
  attr_accessor :render, :search, :writer

  def initialize(file)
    @reader = HTMLReader.new
    @writer = HTMLWriter.new
    @tree = DOMTree.new
    @render = NodeRenderer.new
    @search = NodeSearcher.new
    @stack = Stack.new
    @file = file
  end

  # Looks at array from reader.html and calls correct parser for each element
  # Returns array of hashes with each element being the data of a tree node
  def parser(array)
    tree_data_array = []
    array.each do |element|
      if @reader.is_tag?(element)
        element_data = tag_parser(element)
        element_data[:type] = "open"
      elsif @reader.is_closing_tag?(element) 
        element_data = {:type => "close"}
      else
        element_data = content_parser(element)
        element_data[:type] = "content"
      end
      tree_data_array << element_data
    end
    tree_data_array
  end

  # Creates tag hash with attr-type and value pairs
  def tag_parser(string)
    attr_hash = {}

    tag_type = string.match(/<(\w+)./)[1]
    attr_hash[:tag_type] = tag_type

    attribute_match_data = string.scan(/(\w+)\s?=\s?'([\S]*[\w\s]*)'/)
    attribute_match_data.each do |match|
      key = match[0]
      values = match[1].split(" ")
      attr_hash[key] = values
    end
    attr_hash
  end

  # Creates content hash for text elements
  def content_parser(string)
    raise(TypeError) if string.class != String
    content_hash = {:content => string}
  end

  # Translates tag hash into useable html
  def tag_printer(tag_hash)
    html_string = ""
    html_string += "<#{tag_hash[:tag_type]} "

    tag_hash.each do |key,value|
      unless key == :tag_type
        html_string += "#{key.to_s}='"
        class_string = ""
        value.each do |sub_value|
          class_string += "#{sub_value} "
        end
        html_string += class_string.strip
        html_string += "' "
      end
    end
    html_string.strip!
    html_string += ">"
    html_string
  end

  # Populates dom tree with parsed hash information.
  def create_tree
    @reader.file = @file
    @reader.convert_file
    @tree.populate_dom(parser(@reader.html))
    @render.tree, @search.tree = @tree, @tree
  end


  #Recreates original html from data hash for output
  def tree_to_string
    #End result array
    tree_array = []

    @stack.push(@tree.root)

    #Stores opening tags in the order they appear
    current_tag = []

    #Reference for current tree depth
    current_depth = 0

    until @stack.empty?
      #Pop processed node
      current_node = @stack.pop

      current_node.children.each do |child|

        #Closing tag creator
        if child.depth <= current_depth
          tree_array << "</#{current_tag.pop}>"
        end

        #push descendants onto stack
        @stack.push(child)

        if child.data[:type] == "open"
          current_tag << child.data[:tag_type]
          child.data.delete(:type)
          tree_array << tag_printer(child.data)
        elsif child.data[:type] == "content"
          tree_array << child.data[:content]
        end

        current_depth = child.depth
      end
    end 
    (tree_array + current_tag.reverse.map{|x| "</#{x}>"}).join(" \n")
  end


end

# Uncomment below for CLI outputs

  #You can interchange between sample, sample1, sample2 for different HTML samples
   # dom = DOMParser.new("sample2.html")

  #This will Create the tree for use in all other methods
   # dom.create_tree

  #This method will take the processed html hash and recreate the original HTML
  # dom.writer.create_html_file(dom.tree_to_string)

  #This is a visual representation of each node and its data
  # print dom.render.render_print

  #This method will return the number of child nodes from the specified node
   # print dom.render.render_child_count

  #Searches work best with sample2.html (has data attributes on tags)
    #Full depth-first search of nodes for attribute data
    # print dom.search.search_by("class", "foo")

    #Depth-first search of children nodes for attribute data
    # print dom.search.search_children(dom.tree.root, "class", "bar")

    #Depth-first search of only direct descendant children for attribute data
    # print dom.search.search_direct_children(dom.tree.root.children[0], "class", "foo")

