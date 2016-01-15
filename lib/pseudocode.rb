# Part0:
# - write tests!


# Part1: parsing
# - user interaction --> dom_ui.rb
# - read in a file containing HTML --> file_loader.rb
# - parse out the individual nodes --> dom_parser.rb
# - make the node tree --> dom_parser.rb


# Part2: rendering
# - takes in a tree
# - output key statistics about nodes and their sub-trees:
#     1. total nodes in the sub-tree below that node
#     2. count of each node type in the sub-tree below that node
#     3. all the node's data attributes
#     4. be able to pass `nil` and receive stats about the whole document


# Part3: searching

#     searcher = TreeSearcher.new(tree)
#     sidebars = searcher.search_by(:class, "sidebar")
#     sidebars.each { |node| renderer.render(node) }

# - search for name, text, id, or class


# Part4: rebuilding the DOM
# - rebuild original HTML file from your tree



# load file, send to dom_parser
# build tree
# send tree to node_renderer
