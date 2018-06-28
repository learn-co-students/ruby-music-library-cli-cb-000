require 'pry'

class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
    @files = []
  end

  def files
    Dir.entries(@path).each do |file|
      @files << file if file.include?(".mp3")
    end
    @files
  end

  def import
    files.each do |file|
      Song.create_from_filename(file)
    end
  end

end
# binding.pry
