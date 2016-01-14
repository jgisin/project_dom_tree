class HTMLReader

  def initialize(file)
    @file = file
  end

  def open_file
    File.read(@file, "r")
  end

  def 

end

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
