#require 'pry-byebug'
require_relative "./dom_tree.rb"
require_relative "./html_reader.rb"
require_relative "./html_writer.rb"

class DOMParser
  def initialize
    @reader = HTMLReader.new
    @writer = HTMLWriter.new
    @tree = DOMTree.new
  end

  def parser(array)
    #identifies array element
    #runs correct parser
    #returns array of hashes relative to original html array
    # hash[type]open,close,content
    #
  end

  def tag_parser(string)
    attr_hash = {}

    tag_type = string.match(/<(\w+) /)[1]
    attr_hash["tag_type"] = tag_type

    attribute_match_data = string.scan(/(\w+)\s?=\s?'([\S]*[\w\s]*)'/)
    attribute_match_data.each do |match|
      key = match[0]
      values = match[1].split(" ")
      attr_hash[key] = values
    end

    attr_hash
  end

  def content_parser(string)
    content_hash = {}
    #creates content hash
    #concat formatting tags into content
    content_hash
  end

  def span_parser(string)

  end

  def tag_printer(tag_hash)
    html_string = ""
    html_string += "<#{tag_hash['tag_type']} "

    tag_hash.each do |key,value|
      unless key == "tag_type"
        html_string += "#{key}='"
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

  def create_tree
    #prompt for file
    @reader.file = "sample.html"
    @reader.convert_file
    @tree.populate(parser(@reader.html))
  end

  def recreate_html

  end

  def tree_to_string(tree)

  end

end

dom = DOMParser.new
p dom.tag_parser("<img src='http://www.example.com' title='funny things'>")
p dom.tag_printer(dom.tag_parser("<p class='foo bar' id='baz' name='fozzie'>"))
# p tag_parser("<div id = 'bim'>")
# p tag_parser("<img src='http://www.example.com' title='funny things'>")
