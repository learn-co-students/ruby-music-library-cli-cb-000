class MusicImporter
  attr_accessor :path
  attr_reader :files

  def initialize(path)
    @path = path
    @files = Dir.entries(@path).reject{|entry| entry == "." || entry == ".." || !entry.end_with?(".mp3")}
  end

  def import
    @files.each {|file| Song.create_from_filename(file)}
  end

end
