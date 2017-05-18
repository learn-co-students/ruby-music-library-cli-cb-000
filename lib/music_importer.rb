class MusicImporter
  attr_accessor :path, :files

  def initialize(file_path)
    @path = file_path
    all_files = Dir.entries(@path).reject do |f|
      File.directory? f
    end
    @files = all_files.select {|f| f.split(".")[1] == "mp3"}
  end

  def import
    @files.each {|file| Song.create_from_filename(file)}
  end
end
