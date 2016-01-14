class DOMParser

  def initialize
  end

  def tag_parser(string)
    attr_hash = {}

    tag_type = string.match(/<(\w+) /)[1]
    attr_hash["tag_type"] = tag_type

    attribute_match_data = string.scan(/(\w+)\s?=\s?'([\w\s]+)'/)
    attribute_match_data.each do |match|
      key = match[0]
      values = match[1].split(" ")
      attr_hash[key] = values
    end

    attr_hash
  end

  def tag_printer(tag_hash)
    print "<#{tag_hash['tag_type']} "

    tag_hash.each do |key,value|

    end

  end

end

#
# p tag_parser("<p class='foo bar' id='baz' name='fozzie'>")
# p tag_parser("<div id = 'bim'>")
# p tag_parser("<img src='http://www.example.com' title='funny things'>")
