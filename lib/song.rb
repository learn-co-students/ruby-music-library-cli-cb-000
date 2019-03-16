class Song
  extend Concerns::Findable
  @@all = []
  attr_accessor :name, :genre
  attr_reader :artist

  def initialize(name, artistObj=nil, genreObj=nil)
    @name = name
    self.artist= artistObj if artistObj!=nil
    self.genre= genreObj if genreObj != nil
    #puts("Song::Initialize name=#{@name}")
  end

  def self.new_from_filename(fn)
    fileArr = fn.split(" - ")
    artistName = fileArr[0]
    songName = fileArr[1]
    genreName = fileArr[2].gsub(".mp3", "")

    #puts("Artist Name:  #{artistName}")
    #puts("Song Name:  #{songName}")
    #puts("Genre Name:  #{genreName}")

    artistObj = Artist.find_or_create_by_name(artistName)
    genreObj = Genre.find_or_create_by_name(genreName)
    song = Song.find_or_create_by_name(songName)
    song.artist = artistObj
    song.genre = genreObj
    #puts("Song::new_from_filename songs[].size:  #{@@all.size}")
    song
  end

  def self.create_from_filename(fn)
    song = self.new_from_filename(fn)
    #puts("Song::song[] size in create_from_filename:  #{@@all.size}")
    song
  end


  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def artist=(artistObj)
      # set this song's artist to ArtistObj
      # set artistObj.songs array to include this song
      @artist = artistObj
      if (!@artist.songs.include?(self))
        @artist.add_song(self)
      end
  end

  def genre=(genreObj)
      @genre = genreObj
      if (!genreObj.songs.include?(self))
          genreObj.songs << self
      end

      if (artist != nil)
          if (artist.genres == nil) ||  (!artist.genres.include?(genreObj))
              artist.genres << genreObj
          end
      end
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all.clear
  end

  def self.all
    @@all
  end

  def self.printAll
    @@all.each{ |s| puts("Song:  #{s.name}\n")}
  end
end
