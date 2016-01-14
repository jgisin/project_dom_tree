class HTMLReader

  attr_accessor :file

  def initialize(file)
    @file = file
    @html = nil
  end

  def convert_file
    open_file = File.open(@file, "r")
    file_array = []
    open_file.readlines.each do |line|
      file_array << line.strip
    end
    open_file.close
    @html = file_array.join.split( /(<\/*[^<>\/]*>)/ ) - [""]
  end

end

reader = HTMLReader.new("lib/sample.html")
p reader.convert_file

=begin

<div>
  div text before
  <p>
    p text
  </p>
  <div>
    more div text
  </div>
  div text after
</div>

=end
