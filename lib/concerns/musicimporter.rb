class MusicImporter
  attr_accessor :path
  attr_reader :files, :library

  @@library = []

  def initialize(path)
    @path = path
    @files = []
  end

  def files
    Dir.entries(@path).each do |file|
      @files << file if (file != "." && file != "..")
    end
    @files
  end

  def import
    files.each {|file| @@library << Song.create_from_filename(file)}
  end

  def self.library
    # May need to remove .uniq
    @@library.uniq
  end
end
