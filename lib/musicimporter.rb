class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
    @files = []
  end

  def files
    Dir.entries(@path).each {|file| @files << file if file[-4..-1] == '.mp3'}
    @files
  end

  def import
    self.files.each do |file|
      Song.create_from_filename(file)
    end
  end

end
