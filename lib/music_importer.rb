class MusicImporter
  attr_accessor :path

  def initialize(file_path)
    @path = file_path
  end

  def files
    arr = []
    Dir.entries(path).each do |x|
      if x.include?(".mp3")
        arr << x
      end
    end
    arr
  end

  def import
    self.files.each do |x|
      Song.create_from_filename(x)
    end
  end


end
