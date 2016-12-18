class MusicImporter

  attr_reader :path

  def initialize(path)
    @path = path
  end

  #loads all the mp3 files in teh path directory
  def files
    #dir gives array but contains pathname so we need to gsub it out
    #the /**/*.mp3 is just recursive short cut to include all subfolders and files with .mp3 extention
    Dir["#{path}/**/*.mp3"].collect{|p| p.gsub("#{path}/","")}
  end

  #imports the files into the library by creating songs from a filename
  def import
    #files is calling #files method above
    files.each{|file| Song.create_from_filename(file)}
  end

end
