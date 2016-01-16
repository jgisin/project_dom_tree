require_relative "./stack.rb"

class NodeRenderer
  attr_accessor :tree

  def initialize
    @tree = nil
    @stack = Stack.new
  end

  # Returns total children in subtree below node
  def render_child_count(node = @tree.root)
    @stack.push(node)
    child_count = 0
    until @stack.empty?
      current_node = @stack.pop
      current_node.children.each do |child|
        @stack.push(child)
        child_count += 1
      end
    end
    child_count
  end

  #Returns [tag count, content count]
  def render_child_type_count(node = @tree.root)
    @stack.push(node)
    result_hash = {}
    tag_count = 0
    content_count = 0
    until @stack.empty?
      current_node = @stack.pop
      current_node.children.each do |child|
        @stack.push(child)
        child.data.each do |key, value|
          if result_hash[key].nil?
            result_hash[key] = 1
          else
            result_hash[key] += 1
          end
        end

      end
    end
    result_hash[:total_nodes] = render_child_count(node)
    result_hash.delete(:type)
    result_hash
  end

  def render_print(node = @tree.root)
    @stack.push(node)
    until @stack.empty?
      current_node = @stack.pop
      current_node.children.each do |child|
        @stack.push(child)
        unless child.data.nil?
          render_print_node_data(child)
        end
      end
    end
  end

  def render_print_node_data(node = @tree.root)
      puts
      puts "Start Node Render --------"
    node.data.each do |name, value|
      puts "#{name}: #{value}"
    end
      puts "End Node Render ----------"
      puts
  end


end