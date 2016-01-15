require_relative 'dom_parser.rb'



class Rebuild

  attr_reader :tree, :new_html

  def initialize
    @dom_parser = DomParser.new
    @tree = @dom_parser.build_tree
    @new_html = "<!doctype html>\n"
  end

  # TODO: closing tags!
  def rebuild_html
    count = 2
    queue = []
    queue << @dom_parser.root
    while tag = queue.shift

      @new_html << " " * tag.depth + "<" + tag.type + ">"
      @new_html << tag.text + "\n"

      tag.children.each_with_index do |child, index|
        p tag.children.length
        queue << child 
        if tag.children
          if index == tag.children.length - 1
            # @new_html << tag.closing + "\n"
          end
        end
      end
    end

  end

end


r = Rebuild.new
p r.rebuild_html
puts r.new_html