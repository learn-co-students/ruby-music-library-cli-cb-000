class MusicImporter
  attr_reader :path

  def initialize(folder_path)
    @path = folder_path
    @files = []
  end

  # save an array of all mp3s file in the path
  def files
    # fetch the appropriate files
    filenames = Dir.glob(@path + "/*.mp3")
    filenames.map { |filename| @files << File.basename(filename) }
    @files
  end

  def import
    self.files.each { |filename| Song.create_from_filename(filename) }
  end

end
