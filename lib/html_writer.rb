class HTMLWriter
  def initialize
  end

  def create_html_file(string)
    file = File.new("sample_out.html", "w")

    # write string to the file

    file.close
  end
end
