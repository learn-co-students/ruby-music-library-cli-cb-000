class MusicImporter
  attr_reader :path

  def initialize(file_path)
    @path = file_path
  end

  def files
    Dir.entries(path).select { |entry| entry.end_with?('.mp3') }
  end

  def import
    files.each { |file| Song.create_from_filename(file) }
  end
end
