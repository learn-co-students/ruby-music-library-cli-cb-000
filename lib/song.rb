class Song
  
  attr_reader :name, :artist, :genre
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    @@all = []
    #@artist = artist
    if !(artist == nil)
      artist.add_song(self)
    else
      # do nothing
    end
    @genre = genre
  end
  
  def name=(name)
    @name = name
  end
  
  def self.all
    return @@all
  end
  
  def self.destroy_all
    @@all = []
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    newSong = Song.new(name)
    newSong.save
    return newSong
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    # genre.songs << self
    if (genre.songs.include?(self))
      # do nothing
    else
      genre.songs << self
    end

  end
  
end










