class MusicImporter
  
  attr_accessor :path
  
  def initialize(path)
    @path = path
    
  end
  
  
  def files
    result = []
    Dir.foreach(@path) do |item|
      next if item == '.' or item == '..'
      result.push(item)
    end
    result
  end
  
  def import
    self.files.each do |file|
      Song.create_from_filename(file)
    end
  end
  
  
end