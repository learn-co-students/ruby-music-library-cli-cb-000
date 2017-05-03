class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    @files ||= Dir.glob("#{@path}/*.mp3").collect { |f| f.gsub("#{@path}/", "") }
  end

  def import
    file_list = files.sort
    file_list.each { |file_name| Song.new_from_filename(file_name) }
  end

end
