class MusicImporter
  attr_reader :path
  def initialize(path)
    @path = path
  end

  def files
    Dir.entries(@path).select{|file|!File.directory? file}
  end

  def import(path=@path)
    files.each do |file|
      Song.create_from_filename(file)
    end
  end
end
