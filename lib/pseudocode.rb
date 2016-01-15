# Part0: IN-PROGRESS
# - write tests!


# Part1 parsing: COMPLETE
# - read in a file containing HTML --> file_loader.rb
# - parse out the individual nodes --> dom_parser.rb
# - make the node tree --> dom_parser.rb


# Part2 rendering: COMPLETE
# - takes in a tree
# - output key statistics about nodes and their sub-trees:
#     1. total nodes in the sub-tree below that node
#     2. count of each node type in the sub-tree below that node
#     3. all the node's data attributes
#     4. be able to pass `nil` and receive stats about the whole document


# Part3 searching: COMPLETE

#     searcher = TreeSearcher.new(tree)
#     sidebars = searcher.search_by(:class, "sidebar")
#     sidebars.each { |node| renderer.render(node) }

# - search for name, text, id, or class


# Part4 rebuilding the DOM: NEEDS CLOSING TAGS!
# - rebuild original HTML file from your tree



# dom_parser = parse HTML, find tags, build tree
# file_loader = micro-class for processing the file
# node_renderer = find number of nodes below the given node, what type of tags they are, and the attributes of the given tag
# tree_searcher = search for tags by attribute & search term
# rebuild = output full html
