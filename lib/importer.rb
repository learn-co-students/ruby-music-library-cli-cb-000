class MusicImporter
  attr_accessor :path, :files

  def initialize (path)
    @path = path
    @files = []
  end

  def files
    Dir.new(@path).each do |item|
      next if item == '.' or item == '..'
      @files << item
    end
    @files
  end

  def import
    self.files.each {|filename| Song.create_from_filename(filename)}
  end

end
