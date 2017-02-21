require 'pry'

class MusicImporter
  attr_accessor :path
  
  def initialize(path)
    @path = path
  end

  def files
    Dir["#{self.path}/*"].collect do |file|
      file.split("/").last
    end
  end

  def import
    self.files.each do |filename|
      Song.create_from_filename(filename)
    end
  end

end