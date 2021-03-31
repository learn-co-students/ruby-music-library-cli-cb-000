class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    list = Dir[path + "/*.mp3"]
    @files = list.collect { |file| file.split("/").last }.sort
  end

  def import
    files.each { |mp3| Song.create_from_filename(mp3)}
  end
end
