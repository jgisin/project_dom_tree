

class FileLoader

  def process_file(file_path)
    puts "file should come from here"
    File.open(file_path.to_s).readlines[1..-1].map(&:strip).join
  end

end

# fl = FileLoader.new
# p long_string = fl.process_file('test.html')
# p long_string.scan(/>(\s*.*?\s*)</).map {|array| array[0]}