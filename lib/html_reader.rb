class HTMLReader


  attr_accessor :file
  attr_reader :html

  def initialize
    @file = file
    @html = nil
  end

  # Creates array of dom elements (tag, content, close tags)
  def convert_file
    open_file = File.open(@file, "r")
    file_array = []
    open_file.readlines.each do |line|
      file_array << line.strip
    end
    open_file.close
    @html = file_array.join.split( /(<\/*[^<>\/]*>)/ ) - [""]
  end


  def is_tag?(string)
    !!string.match(/<[^<>\/]*>/)
  end

  def is_closing_tag?(string)
    !!string.match(/<(\/[^<>\/]*)>/)
  end



end


