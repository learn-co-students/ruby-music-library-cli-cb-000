class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(self.path).select { |file| file.end_with?('.mp3')}
  end

  def import
    files.each { |file| Song.create_from_filename(file)}
  end
end
