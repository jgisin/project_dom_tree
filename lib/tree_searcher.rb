require_relative 'dom_parser.rb'
require_relative 'node_renderer.rb'

# TODO: implement search_descendents and search_parents

class TreeSearcher

  attr_reader :matches

  def initialize
    @dom_parser = DomParser.new
    @tree = @dom_parser.build_tree()
    @matches = []
  end

  def search_by(attribute, search_term)
    puts "You searched for: #{attribute}, #{search_term}"
    find_matches(attribute, search_term)
    puts "There are #{@matches.length} tags that match your search."
    render_matches
  end


  def render_matches
    puts "Here are the tags that match your search:"
    @matches.each do |tag|
      puts "    Type: #{tag.type}"
      puts "    Class(es): #{tag.classes}"
      puts "    ID: #{tag.id}"
      puts "    Text: #{tag.text}"
      puts "    Name: #{tag.name}"
      puts
    end
  end


  def find_matches(attribute, search_term)
    # get list of tags that match the criteria
    queue = []
    queue << @dom_parser.root
    while tag = queue.shift
      if tag[attribute]
          @matches << tag if tag[attribute].include? search_term
      end
      tag.children.each do |child|
        queue << child 
      end
    end
  end

end


ts = TreeSearcher.new
ts.search_by(:text, "One")
# p ts.matches
# ts.render_matches