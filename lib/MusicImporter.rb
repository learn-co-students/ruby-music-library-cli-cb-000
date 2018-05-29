class MusicImporter

  attr_accessor :files
  attr_reader :path

  def initialize(path)
    @path = path
    @files = Dir.entries(@path).select{|file| file.include?('.mp3')}
  end

  def files
    @files
  end

  def import
    @files = @files.collect{|song| Song.create_from_filename(song)}
  end

end
