class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    files = []
    Dir.new(self.path).each do |file|
      files << file if file.include?(".mp3")
    end
    files
  end

  def import
    self.files.each {|file| Song.create_from_filename(file)}
  end

end
