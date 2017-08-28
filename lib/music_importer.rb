class MusicImporter

  attr_accessor :path, :files

  def initialize file_path
    self.path = file_path
  end

  def files
    @files = Dir.entries(path).select {|f| !File.directory? f}.sort
  end

  def import
    s = self.files.each { |file| Song.create_from_filename file }
  end
end
