# require_relative 'tag.rb'
require_relative 'file_loader.rb'
require_relative 'dom_ui.rb'

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


  attr_reader :root, :tag_list, :tag_structs, :html_string

  def initialize
    @file_loader = FileLoader.new
    @dom_ui = DomUI.new
    @html_string = @dom_ui.html_string
    @root = nil
    @depth = 0
    @tag_list = nil
    @tag_structs = []
  end

  def match_multiple_tags
    # grab the text between an opening tag and the next tag
    # separate the "type" from the "text"
    # save "type" as tag.type, "text" as tag.text
  end


  def find_all_tags(html_string=@html_string)
    depth = 0
    @tag_list = html_string.scan(ALL_TAG_REGEX).map {|array| array[0]}
    # for each opening tag: generate Tag, set attributes, increase depth by 1
    @tag_list.each do |tag|
      if tag.match(OPEN_TAG_REGEX)
        @tag_structs << set_tag_attributes(tag, depth)
        depth += 1
      # for each closing tag, decrease depth by 1
      else
        depth -= 1
      end
    end
    p @tag_list
    @tag_structs
  end


  def generate_tree
    current_node = @tag_structs[0]
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
  end


  def set_tag_attributes(tag_info, depth)
    new_tag = Tag.new(nil, nil, nil, nil, nil, [])

    new_tag.type = tag_info.match(TYPE_REGEX).to_s[1..-1]
    new_tag.classes = tag_info.match(CLASS_REGEX).to_s[7..-2].split(' ') if tag_info.match(CLASS_REGEX)
    new_tag.id = tag_info.match(ID_REGEX).to_s[4..-2]
    new_tag.name = tag_info.match(NAME_REGEX).to_s[6..-2]
    new_tag.text = tag_info.match(TEXT_REGEX).to_s
    new_tag.depth = depth
    # tag.closing = @html_string.match(/<\/#{tag.type}>/).to_s

    return new_tag
  end

end

game = DomParser.new
game.find_all_tags
# puts game.generate_tree
# # puts game.tag_list.inspect
# game.tag_structs.each do |tag|
#   print "  " * tag.depth
#   puts tag.type
# end
# puts game.html_string
