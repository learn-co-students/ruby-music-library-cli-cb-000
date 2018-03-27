class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    Dir["#{@path}/*.mp3"].collect do |file|
      file.gsub("#{@path}/", "")
    end
  end

  def import
    self.files.each do |filename|
      Song.create_from_filename(filename)
    end
  end

end
