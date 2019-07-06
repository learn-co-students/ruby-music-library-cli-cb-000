class MusicImporter

  attr_accessor :path, :files

  def initialize(path)
    @path = path
    @files = []
  end

  def files
    Dir.children(path).each {|file| @files << file }
  end

  def import
    self.files.sort
    @files.each do |file|
      song = file
      Song.create_from_filename(song)
    end
  end

end
