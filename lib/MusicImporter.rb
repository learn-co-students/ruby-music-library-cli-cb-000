class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
  end

  def self.import
    files.each{|f| Song.new_by_filename(f)}
#    binding.pry
  end

end
