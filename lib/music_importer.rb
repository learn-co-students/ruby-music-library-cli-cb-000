class MusicImporter
  attr_accessor :path
  def initialize(path)
    @path=path
  end

  def import
    filelist=self.files                                   #call files to get list of files
    filelist.each {|f| Song.create_from_filename(f)}      #create new song from each file
  end #import                                             #path was given on init, so miObject.import called

  def files
    filelist=Dir["#{@path}/*.mp3"]
    newlist=[]
    filelist.each do |file|
      file.slice! "#{@path}/"
      newlist << file
    end #each
    newlist
  end #files

end
