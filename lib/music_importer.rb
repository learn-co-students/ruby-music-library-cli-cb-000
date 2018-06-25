class MusicImporter
  attr_accessor :path, :files

  def initialize(path)
    @path = path
    @files = []
  end


#  def files
#    Dir.new(self.path).each {|f| @files << f.gsub("./spec/fixtures/mp3s")}
#  end

  def files
   files = []
    Dir.new(self.path).each do |file|
      files << file if file.include?(".mp3")
    end
    files
  end

  def import
    files.each {|file| Song.create_from_filename(file)}
  end


end
