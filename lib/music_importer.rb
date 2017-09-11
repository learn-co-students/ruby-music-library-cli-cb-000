class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end
  #initializes with a path argument and it stores the path in an instance variable @path

  def import
    files.each{|f| Song.create_from_filename(f)}
    #for each of files in the @files array, return each filename to the block. The block instantiates a new song via the #create_from_filename Song method.
  end

  def files
    @files = Dir.glob("#{path}/*.mp3").collect{|f| f.gsub("#{path}/", "")}
  end
    #@files = anything in the path directory that's an MP3. Get all MP3s and collect them in an array, applying gsub to each. gsub should strip off the path data and replace it with nothing. gsub(x, y) would be x = pattern, y = replacement

    # best practice, use ||= if the left side equalls itself, thus is true, proceed, otherwise, execute the right side.

    #instance variable @files equalls @files, and if it doesn't, then execute the Dir.glob. In other words, collect all the *.mp3 files from the path in an array and return them to the block. In the block, use #gsub to strip out the prefix path info, just storing the filename in the @files array.

    #In other words, set @files to {Dir...} if @files is nil or false. If files isn't nil or false, just return @files


    # @files = @files || Dir.glob().collect{}
    # alt
    # @files ||= Dir.glob("#{path}/*.mp3").collect{|f| f.gsub("#{path}/", "")}

end

# Create a Music Importer class to work with your Song, Genre and Artist objects to import a directory of mp3s. This class will have the following methods:
# Initialize accepts a file path of mp3 files
# A #files method that will return all of the filenames
# Add a new method to the Song class called .new_from_filename that creates a Song based on a filename
# Add a new method to the Song class called .create_from_filename that creates a Song based on a filename and saves it to the @@all class variable
# In your MusicImporter class, add an .import method that imports all the files from the library and creates the Song objects.
