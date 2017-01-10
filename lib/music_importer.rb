class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    @files = Dir["#{self.path}/*.mp3"].collect {|f| File.basename(f)}.sort
  end

  def import
    files.each {|filename| Song.create_from_filename(filename)}
  end

end
