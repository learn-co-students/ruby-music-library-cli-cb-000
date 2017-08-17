class Artist
  extend Findable

  attr_accessor :genre, :songs, :name
  @songs = []
  

  def initialize(name, genre=nil)
    Artist.setup
    @songs = []
    @name = name
    puts "Artist #{self}"
  end 

  def songs
    @songs
  end 

  def genres
    @songs.collect { |song| song.genre }.uniq
  end 

  def add_song(song)
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)
  end 
end
