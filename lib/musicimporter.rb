require 'pry'

class MusicImporter
  attr_accessor :path

  def initialize(file_path)
    @path = file_path
    @files = []
  end

  def files
    return @files
  end

  def import
    self.files
    @files.each do |filename|
      Song.create_from_filename(filename)
    end
  end

  def files
    full_path = @path + "/*.mp3"
    full_file = Dir[full_path]
    full_file.each do |file|
      @files << file.split("#{@path}/")[1]
    end
    return @files
  end

end
