class MusicImporter
  attr_reader :path, :files

  def initialize(path)
    @path = path
    @files = Dir.entries(path).collect { |entry| entry if entry.size > 3 }.compact
  end

  def import
    self.files.collect {|file| Song.create_from_filename(file) }
  end
end
