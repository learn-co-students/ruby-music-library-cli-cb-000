class MusicImporter
  attr_accessor :path

  def initialize (path)
    @path = path
  end

  def files
    Dir["#{path}/*.mp3"].collect do |f|
      f.split("#{path}/")[1]
    end
  end

  def import
    self.files.sort.each_with_index do |f|
      Song.create_from_filename(f)
    end
  end
end
