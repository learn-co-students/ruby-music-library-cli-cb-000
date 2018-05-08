class Artist
  
  attr_reader :name
  
  def initialize(name)
    @name = name
    @@all = []
    @songs = []
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
    newArtist = Artist.new(name)
    newArtist.save
    return newArtist
  end
  
  def songs
    return @songs
  end
  
  def add_song(song)
    if (song.artist == nil)
      song.artist = self
      @songs << song
    else
      # do not assign self to song.artist
    end
  end
  
  def genres
    collectorArray = []
    @songs.each do |song_object|
      collectorArray << song_object.genre
    end
    return collectorArray.uniq
  end
  
end