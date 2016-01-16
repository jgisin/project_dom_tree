# project_dom_tree
Like leaves on the wind

[A data structures, algorithms, file I/O, ruby and regular expression (regex) project from the Viking Code School](http://www.vikingcodeschool.com)

Andrew and Julia.

* Load an HTML file to the project root
* test.html is loaded for your convenience

1. dom_parser.rb = parse HTML, find tags, build tree

  To use:
  parser = DomParser.new
  
  print parser.build_tree("../test.html")

2. file_loader.rb = micro-class for processing the HTML file

3. node_renderer.rb = find number of nodes below the given node, what type of tags they are, and the attributes of the given tag
  
  To use:
  r = NodeRenderer.new

  r.render("html") 

  ^^^ "html" can be any type of tag in your file, for example: html, head, body, div, li, h2, etc.


4. tree_searcher.rb = search for tags by attribute & search term

  To use:
  ts = TreeSearcher.new
  
  ts.search_by(:classes, "inner-div")

  ^^^ attributes include: text, type, classes, id, and name


5. rebuild.rb = output full html

  To use:
  r = Rebuild.new
  
  r.rebuild_html
  
  puts r.new_html

  
