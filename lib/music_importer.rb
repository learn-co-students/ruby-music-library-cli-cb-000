class MusicImporter

  attr_reader :path, :files

  def initialize(path)
    @path = path
    @files = Dir.entries(@path).select { |x| x.include?('.mp3')}
  end

  def import
    @files.each { |x| Song.create_from_filename(x) }
  end

end
