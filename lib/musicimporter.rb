require "pry"
class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    # binding.pry
    Dir.entries(@path).grep(/\w+[^.mp3]/)
    # binding.pry
  end

  def import
    self.files.each do |song|
      Song.create_from_filename(song)
    end
  end


end
