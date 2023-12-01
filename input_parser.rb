class InputParser
  class << self
    def input_to_array(file_path)
      input = []
      File.foreach(file_path).each do |line|
        input << line
      end
      input
    end
  end
end
