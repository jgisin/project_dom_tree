class HTMLReader

  IGNORE_TAGS = ["<b>","</b>", "<em>", "</em>", "<i>", "</i>", "<small>", "</small>", "<strong>", "</strong>", "<sub>", "</sub>", "<sup>", "</sup>", "<ins>", "</ins>", "<del>", "</del>", "<mark>", "</mark>" ]

  attr_accessor :file
  attr_reader :html

  def initialize
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
    @html = file_array.join.split( /(<\/*[^<>\/]*>)/ ) - [""].join
  end

  def ignore_tag
    # when finding an ignore tag
      #check if element before ignore is tag
        #if not tag add to concat
      #select ignore, element after ignore, end-ignore
        #add to concat
      #check if element after end-ignore is tag
        #if not add to concat
  end

  def is_tag?(string)
    !!string.match(/<[^<>\/]*>/)
  end

  def is_closing_tag?(string)
    !!string.match(/<(\/[^<>\/]*)>/)
  end

  def is_ignore_tag?(string)
    IGNORE_TAGS.include?(string) &&
    (is_tag?(string))
  end

  def is_ignore_closing_tag?(string)
    IGNORE_TAGS.include?(string) &&
    (is_closing_tag?(string))
  end

end

# reader = HTMLReader.new
# p reader.convert_file

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
