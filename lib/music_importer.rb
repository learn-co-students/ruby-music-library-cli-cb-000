class MusicImporter

  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    files = Dir.entries(@path.to_s).reject { |entry| File.directory?(entry) }
    files
  end

  def import
    all_files = files
    all_files.each do |filename|
      Song.create_from_filename(filename)
    end
  end

end