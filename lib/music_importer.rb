class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    libdirs = File.join(path, "*.mp3")
    filenames = Dir.glob(libdirs)
    normalize_filenames(filenames)
  end

  def normalize_filenames(filenames)
    filenames.collect do |fn|
      fn.split('/').last
    end
  end

  def import
    filenames = normalize_filenames(self.files)
    filenames.each do |fn|
      Song.create_from_filename(fn)
    end
  end
end
