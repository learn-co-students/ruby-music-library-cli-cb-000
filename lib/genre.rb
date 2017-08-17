class Genre
  extend Findable
  attr_accessor :name
  @songs = []
    
  def initialize(name)
    Genre.setup
    @songs = []
    @name = name
  end 
  
  def songs
    @songs 
  end

  def genre
    self
  end
  
  def artists
    @songs.collect { |song| song.artist }.uniq
  end
    
  def add_song(song)
    song.genre = self unless song.genre
    songs << song unless songs.include?(song)
  end
  
  def add_artist(artist)
    song.artist = self unless artist.genre
    artists << artist unless artists.include?(artist)
  end
end
