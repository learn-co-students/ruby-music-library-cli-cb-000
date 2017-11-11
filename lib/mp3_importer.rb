require 'pry'

class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
    #binding.pry
  end

  def files
    filename = Dir.entries(@path)
    #binding.pry
    filename.delete(".")
    filename.delete("..")
    filename
  end

  def import
    filename = Dir.entries(@path)
    #binding.pry
    filename.delete(".")
    filename.delete("..")
    #binding.pry
    filename.each do |file|
      Song.create_from_filename(file)
    end
  end

end
