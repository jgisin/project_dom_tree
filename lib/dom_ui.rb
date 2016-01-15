require_relative 'file_loader.rb'

class DomUI

  attr_accessor :file_name, :html_string

  def initialize
    @file_name = ""
    @file_loader = FileLoader.new
    @html_string = ""
  end

  def file_location
    system("clear")
    puts "========================================================="
    puts "Welcome to DOM Searcher 3000!"
    puts "Please save an html file to this directory: /project_dom_tree/lib"
    puts "What is the full name of your file?"
    puts "========================================================="
    input = gets.chomp
    until input =~ /\.html/
      puts " Please type the full file name, for example: test.html"
      input = gets.chomp
    end

    @file_name = input
  end

  def user_interaction
    # file_location 
    # Julia - uncomment above, and change the file to be @file_name
    @html_string = @file_loader.process_file('./spec/test.html')
  end



end

dui = DomUI.new
dui.user_interaction
p dui.html_string
