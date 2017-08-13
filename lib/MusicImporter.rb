class MusicImporter

  attr_reader :path, :files

  def initialize(path=nil)
    @path = path if path
    files
  end

  def files
    @files = Dir["#{@path}/**/*.mp3"]
    @files.map! { |file| file.gsub(/\.\/spec\/fixtures\/mp3s\//, '') }
  end

  def import
    @files.each do |filename|
      Song.create_from_filename(filename)
    end
  end


end
