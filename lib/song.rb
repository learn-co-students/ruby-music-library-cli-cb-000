class Song
  extend Concerns::Findable
  extend Persistable::ClassMethods
  extend Nameable::ClassMethods
  include Persistable::InstanceMethods

  @@all = []
  attr_accessor :name, :genre
  attr_reader :artist

  def initialize(name, artistObj=nil, genreObj=nil)
    @name = name
    self.artist= artistObj if artistObj!=nil
    self.genre= genreObj if genreObj != nil
  end

  def self.new_from_filename(fn)
    fileArr = fn.split(" - ")
    artistName = fileArr[0]
    songName = fileArr[1]
    genreName = fileArr[2].gsub(".mp3", "")

    artistObj = Artist.find_or_create_by_name(artistName)
    genreObj = Genre.find_or_create_by_name(genreName)
    song = Song.find_or_create_by_name(songName)
    song.artist = artistObj
    song.genre = genreObj
    song
  end

  def self.create_from_filename(fn)
    song = self.new_from_filename(fn)
    song
  end

  def artist=(artistObj)
      @artist = artistObj
      @artist.add_song(self) unless @artist.songs.include?(self)
      #if (!@artist.songs.include?(self))
      #  @artist.add_song(self)
      #end
  end

  def genre=(genreObj)
      @genre = genreObj

      genreObj.songs << self unless genreObj.songs.include?(self)
      artist.genres << genreObj unless (artist == nil) || (!artist.genres == nil) || (artist.genres.include?(genreObj))

  end

  def self.all
     @@all
  end

end #Song Class


  
