class MusicImporter
  # retrieves the path provided to the MusicImporter object
  attr_reader :path

  #initialize
  # accepts a file path to parse MP3 files from
  def initialize(path)
    @path = path
  end

  #files
  # loads all the MP3 files in the path directory
  # normalizes the filename to just the MP3 filename with no path
  def files
    @files ||= Dir.glob("#{path}/*.mp3").map{ |file| file.gsub("#{path}/", "") }
  end

  #import
  # imports the files into the library by invoking Song.create_from_filename
  def import
    files.each{ |file| Song.create_from_filename(file) }
  end
end
