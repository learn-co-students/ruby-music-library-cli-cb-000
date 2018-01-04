class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    @files = Dir.entries(@path).reject{|entry| entry == "." || entry == ".." || !entry.end_with?(".mp3")}
  end

  def import
    self.files if @files == nil
    @files.each {|file| Song.create_from_filename(file)}
  end

end
