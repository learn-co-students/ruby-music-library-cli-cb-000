require "pry"

class MusicImporter

  def initialize(path)
    @path = path
  end

  attr_accessor :path

  def files
    Dir["#{path}/*.mp3"].collect {|f| f.sub(/.*\//,"")}
  end

  def import
    files.each{ |filename| Song.create_from_filename(filename) }
  end

end
