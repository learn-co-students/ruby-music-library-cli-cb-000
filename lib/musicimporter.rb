class MusicImporter

  attr_reader :path

  def import
    self.files.each{|filename| Song.create_from_filename(filename)}
  end

  def initialize(path)
    @path = path
  end

  def files
    Dir[@path + "/**/*"].collect{|f| f.gsub(@path + '/', "")}
  end

end
