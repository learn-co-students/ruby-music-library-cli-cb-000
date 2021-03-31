class MusicImporter 
  
  attr_accessor 
  

  def initialize(path)
    @path = path 
  end
  
  def path 
    @path 
  end
  
  def files
    Dir["#{path}/**/*.mp3"].map{|mp3| mp3.gsub("#{path}/","")}
  end
  
  def import 
    files.each do |f|
    Song.create_from_filename(f)
  end 
end
  
  
  
end