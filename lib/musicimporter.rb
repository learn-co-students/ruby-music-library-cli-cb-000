class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.glob(self.path + '/*.mp3').collect{|file| File.basename(file)}
  end

  def import
    files.each {|file_name| Song.create_from_filename(file_name)}
  end
end
