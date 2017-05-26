class MusicImporter

  attr_accessor :path, :files

  def initialize(path)
    @path = path
  end

  def files
    @file_array = []
    Dir.foreach(path) { |f| @file_array << f unless f.length < 5 }
    @file_array
  end

  def import
    @file_array = []
    Dir.foreach(@path) {|f| @file_array << f unless f.length < 5}
    @file_array.each {|f| Song.create_from_filename(f)}
  end





end
