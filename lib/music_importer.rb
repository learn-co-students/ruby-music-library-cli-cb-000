class MusicImporter
  attr_accessor :path, :file, :filename

  @@file = []

  def initialize(path)
    @path = path
  end

  def files
    @@file = Dir.entries(path)
    @@file.delete(".")
    @@file.delete("..")
    @@file
  end

  def import
    files.each do |file_name|
      Song.create_from_filename(file_name)
    end
  end

end
