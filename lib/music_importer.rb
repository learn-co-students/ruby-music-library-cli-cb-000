class MusicImporter
  attr_accessor :path 

  def initialize(test_music_path)
    @path = test_music_path 
  end

  def files
    path = File.join(File.expand_path(File.dirname(__FILE__)), "../#{@path}")
    files = [] 
    Dir["#{path}/*"].each {|file| files << file.split("/").last}
    files
    
  end

  
  def import
    self.files.each do |filename|
      Song.create_from_filename(filename)
    end

  end
  
end
