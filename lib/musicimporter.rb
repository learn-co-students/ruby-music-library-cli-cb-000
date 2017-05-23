class MusicImporter
  attr_accessor :path, :files

  def initialize(path)
    @path = path
  end

  def files
    files = Dir["#{@path}/*.mp3"]
    @files = files.map {|file|
      str = file.split(@path + "/")
      str[1]
    }
  end

  def import
    files
    songs = @files.map { |file|
      Song.create_from_filename(file)
    }
  end


end
