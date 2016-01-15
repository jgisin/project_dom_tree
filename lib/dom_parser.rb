require_relative 'file_loader.rb'

Tag = Struct.new(:text, :type, :classes, :id, :name, :children, :parent, :closing, :depth)


class DomParser

  TYPE_REGEX = /<[a-z]*[0-9]*/
  CLASS_REGEX = /class=('|")[[a-z0-9]*\W*\s]*?('|")/
  ID_REGEX = /id=('|")[[a-z0-9]*\W*]*?('|")/
  NAME_REGEX = /name=('|")[[a-z0-9]*\W*]*?('|")/
  TEXT_REGEX = />(\s*.*?\s*)</

  ALL_TAG_REGEX = /(<[a-z]*.*?>)/
  OPEN_TAG_REGEX = /<[a-z].*?>/
  # SELF_CLOSING_REGEX = /^(.*?>.*?)>/
  ROOT_CLOSING = /<\/html>/


  attr_reader :root, :tag_list, :tag_structs, :html_string, :tag_text, :tree

  def initialize
    @file_loader = FileLoader.new
    @html_string = ""
    @root = nil
    @depth = 0
    @tag_list = nil
    @tag_text = nil
    @tag_structs = []
    @tree = nil
  end

  def build_tree(file_name)
    @html_string = @file_loader.process_file(file_name)
    find_all_tags
    @tree = generate_tree
    # p "here's the root:", @root
  end


  def find_all_tags(html_string=@html_string)
    depth = 0
    @tag_list = html_string.scan(ALL_TAG_REGEX).map {|array| array[0]}
    @tag_text = html_string.scan(TEXT_REGEX).map {|array| array[0]}
    # for each opening tag: generate Tag, set attributes, increase depth by 1
    @tag_list.each_with_index do |tag, index|
      if tag.match(OPEN_TAG_REGEX)
        @tag_structs << set_tag_attributes(tag, depth, @tag_text[index])
        depth += 1
      # for each closing tag, decrease depth by 1
      else
        depth -= 1
      end
    end
    @tag_structs
  end


  def generate_tree
    @root = @tag_structs[0]
    current_node = @root
    current_depth = current_node.depth
    @tag_structs[0..-2].each_with_index do |tag, index|
      next_node = @tag_structs[index+1]
      next_depth = next_node.depth
      # current_node is a parent of next_node
      if current_depth < next_depth
        current_node.children << next_node
        current_node = next_node
      end
    end
    @tag_structs
  end


  def set_tag_attributes(tag_info, depth, text)
    new_tag = Tag.new(nil, nil, nil, nil, nil, [])

    new_tag.type = tag_info.match(TYPE_REGEX).to_s[1..-1]
    new_tag.classes = tag_info.match(CLASS_REGEX).to_s[7..-2].split(' ') if tag_info.match(CLASS_REGEX)
    new_tag.id = tag_info.match(ID_REGEX).to_s[4..-2]
    new_tag.name = tag_info.match(NAME_REGEX).to_s[6..-2]
    new_tag.text = text
    new_tag.depth = depth
    new_tag.closing = "</#{new_tag.type}>"

    return new_tag
  end

end

game = DomParser.new
game.build_tree("../test.html")
# p game.root

# game.tag_structs.each do |tag|
#   print "  " * tag.depth
#   puts tag.type, tag.text
# end

