class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    files = Dir.entries(@path)
    files.grep(/.mp3/)
  end

  def import
    files.collect {|file| Song.create_from_filename(file)}
  end

end
