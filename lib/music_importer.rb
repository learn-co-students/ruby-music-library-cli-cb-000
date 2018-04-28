class MusicImporter

  attr_reader :path

  def initialize(path)
    @path=path
  end

  def files
    Dir.chdir("/home/marcusjun/ruby-music-library-cli-cb-000")
    Dir.chdir(@path)
    @files = Dir.glob("*.mp3")
  end

  def import
    files
    @files.each {|filename| Song.create_from_filename(filename)}
  end

end
